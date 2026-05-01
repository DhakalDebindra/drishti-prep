-- Decouple identity verification from per-course enrollment.
--
-- Previously, /enroll bundled disability-card upload with per-course payment,
-- which meant:
--   - users re-uploaded their card every time they enrolled in a new course
--   - admins reviewed identity + payment together (different cadences, different
--     decision criteria)
--
-- New model:
--   - identity_verifications is the source of truth for ID review (one row per
--     submission attempt; full audit trail).
--   - profiles.disability_status is a denormalized derived field for fast gate
--     checks; kept in sync by the trigger below.
--   - enrollments concern payment only.

-- ─── Denormalize email onto profiles for admin lookups ──────────────────────
-- Admin needs to search users by email (the canonical identifier) when
-- creating enrollments. auth.users.email isn't accessible via the regular
-- supabase client without service-role; copying it onto profiles + syncing on
-- signup avoids needing a service-role client for this read path.
ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS email TEXT;

CREATE INDEX IF NOT EXISTS profiles_email_idx ON public.profiles (lower(email));

-- Backfill existing profiles.
UPDATE public.profiles p
   SET email = u.email
  FROM auth.users u
 WHERE p.id = u.id
   AND p.email IS NULL;

-- Update the signup trigger to also store email.
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  INSERT INTO public.profiles (id, full_name, email, is_admin)
  VALUES (
    new.id,
    new.raw_user_meta_data->>'full_name',
    new.email,
    false
  )
  ON CONFLICT (id) DO UPDATE
    SET email = EXCLUDED.email
    WHERE public.profiles.email IS DISTINCT FROM EXCLUDED.email;
  RETURN new;
END;
$$;

-- ─── disability_status enum on profiles ───────────────────────────────────────
DO $$ BEGIN
  CREATE TYPE disability_status AS ENUM ('not_submitted', 'pending', 'approved', 'rejected');
EXCEPTION WHEN duplicate_object THEN null; END $$;

ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS disability_status disability_status NOT NULL DEFAULT 'not_submitted',
  ADD COLUMN IF NOT EXISTS disability_rejection_reason TEXT;

-- Backfill: any profile that already has disability_verified=true is approved.
UPDATE public.profiles
   SET disability_status = 'approved'
 WHERE disability_verified = true
   AND disability_status = 'not_submitted';

-- ─── identity_verifications table ────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.identity_verifications (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  card_path TEXT NOT NULL,
  status disability_status NOT NULL DEFAULT 'pending'
    CHECK (status IN ('pending', 'approved', 'rejected')),
  rejection_reason TEXT,
  admin_notes TEXT,
  reviewed_by UUID REFERENCES public.profiles(id),
  reviewed_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- One pending submission at a time per user; lets them re-submit after rejection.
CREATE UNIQUE INDEX IF NOT EXISTS identity_verifications_one_pending_per_user
  ON public.identity_verifications (user_id)
  WHERE status = 'pending';

CREATE INDEX IF NOT EXISTS identity_verifications_status_created_idx
  ON public.identity_verifications (status, created_at DESC);

ALTER TABLE public.identity_verifications ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Users read own identity verifications" ON public.identity_verifications;
CREATE POLICY "Users read own identity verifications" ON public.identity_verifications
  FOR SELECT TO authenticated
  USING (user_id = auth.uid() OR public.is_admin());

DROP POLICY IF EXISTS "Users insert own pending identity verification" ON public.identity_verifications;
CREATE POLICY "Users insert own pending identity verification" ON public.identity_verifications
  FOR INSERT TO authenticated
  WITH CHECK (user_id = auth.uid() AND status = 'pending');

DROP POLICY IF EXISTS "Admins manage identity verifications" ON public.identity_verifications;
CREATE POLICY "Admins manage identity verifications" ON public.identity_verifications
  FOR UPDATE TO authenticated
  USING (public.is_admin())
  WITH CHECK (public.is_admin());

-- updated_at trigger (reuses the function created in 20260501000000)
DROP TRIGGER IF EXISTS identity_verifications_set_updated_at ON public.identity_verifications;
CREATE TRIGGER identity_verifications_set_updated_at
  BEFORE UPDATE ON public.identity_verifications
  FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

-- ─── Sync trigger: identity_verifications → profiles ─────────────────────────
-- Whenever a verification row is inserted or its status changes, project the
-- result onto the profile so gate checks can read one row.
CREATE OR REPLACE FUNCTION public.sync_disability_status()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  IF NEW.status = 'pending' THEN
    UPDATE public.profiles
       SET disability_status = 'pending',
           disability_card_path = NEW.card_path,
           disability_card_uploaded_at = NEW.created_at,
           disability_rejection_reason = NULL
     WHERE id = NEW.user_id;

  ELSIF NEW.status = 'approved' THEN
    UPDATE public.profiles
       SET disability_status = 'approved',
           disability_verified = true,
           disability_verified_at = NEW.reviewed_at,
           disability_verified_by = NEW.reviewed_by,
           disability_rejection_reason = NULL
     WHERE id = NEW.user_id;

  ELSIF NEW.status = 'rejected' THEN
    UPDATE public.profiles
       SET disability_status = 'rejected',
           disability_verified = false,
           disability_rejection_reason = NEW.rejection_reason
     WHERE id = NEW.user_id;
  END IF;

  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS identity_verifications_sync_profile ON public.identity_verifications;
CREATE TRIGGER identity_verifications_sync_profile
  AFTER INSERT OR UPDATE OF status ON public.identity_verifications
  FOR EACH ROW EXECUTE FUNCTION public.sync_disability_status();

-- ─── Lock down enrollments: admin-only writes ────────────────────────────────
-- Users no longer create their own enrollment rows. The admin creates them
-- after receiving payment proof out-of-band (WhatsApp/email/in-person) and
-- looking up the user by registered email.
DROP POLICY IF EXISTS "Users insert own pending enrollment" ON public.enrollments;

DROP POLICY IF EXISTS "Admins create enrollments" ON public.enrollments;
CREATE POLICY "Admins create enrollments" ON public.enrollments
  FOR INSERT TO authenticated
  WITH CHECK (public.is_admin());

-- Existing "Admins manage enrollments" UPDATE policy from migration 1 stays.
-- Existing "Users read own enrollments" SELECT policy from migration 1 stays.
