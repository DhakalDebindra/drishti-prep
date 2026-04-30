-- Manual-verification payment flow for DrishtiPrep.
--
-- The operator is an individual (not a registered business), so cannot integrate
-- eSewa/Khalti/ConnectIPS APIs. Payment is QR + WhatsApp + manual approval:
--   1. User uploads disability card in-app (mandatory identity proof).
--   2. User pays via QR (operator's personal wallet) and clicks "I've paid".
--   3. App creates an enrollments row with a generated short_code.
--   4. User sends payment screenshot via WhatsApp; admin matches it to the
--      pending row by short_code, verifies the card image, and approves.
--   5. has_module_access() gates the [moduleSlug] route group.

-- ─── Pricing on modules ───────────────────────────────────────────────────────
ALTER TABLE public.modules
  ADD COLUMN IF NOT EXISTS price_paisa BIGINT,
  ADD COLUMN IF NOT EXISTS currency CHAR(3) NOT NULL DEFAULT 'NPR';

-- ─── Disability verification fields on profiles ──────────────────────────────
ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS disability_card_path TEXT,
  ADD COLUMN IF NOT EXISTS disability_card_uploaded_at TIMESTAMPTZ,
  ADD COLUMN IF NOT EXISTS disability_verified BOOLEAN NOT NULL DEFAULT false,
  ADD COLUMN IF NOT EXISTS disability_verified_at TIMESTAMPTZ,
  ADD COLUMN IF NOT EXISTS disability_verified_by UUID REFERENCES public.profiles(id);

-- ─── Enrollments ──────────────────────────────────────────────────────────────
DO $$ BEGIN
  CREATE TYPE enrollment_status AS ENUM ('pending', 'approved', 'rejected', 'revoked');
EXCEPTION WHEN duplicate_object THEN null; END $$;

CREATE TABLE IF NOT EXISTS public.enrollments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  short_code TEXT NOT NULL UNIQUE
    DEFAULT upper(substr(replace(gen_random_uuid()::text, '-', ''), 1, 8)),
  user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  module_id UUID NOT NULL REFERENCES public.modules(id) ON DELETE CASCADE,
  status enrollment_status NOT NULL DEFAULT 'pending',
  amount_quoted_paisa BIGINT NOT NULL,
  payment_reference TEXT,
  admin_notes TEXT,
  rejection_reason TEXT,
  reviewed_by UUID REFERENCES public.profiles(id),
  reviewed_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Allows a fresh submission only after a previous attempt was rejected/revoked.
CREATE UNIQUE INDEX IF NOT EXISTS enrollments_one_active_per_user_module
  ON public.enrollments (user_id, module_id)
  WHERE status IN ('pending', 'approved');

CREATE INDEX IF NOT EXISTS enrollments_status_created_idx
  ON public.enrollments (status, created_at DESC);

ALTER TABLE public.enrollments ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Users read own enrollments" ON public.enrollments;
CREATE POLICY "Users read own enrollments" ON public.enrollments
  FOR SELECT TO authenticated
  USING (user_id = auth.uid() OR public.is_admin());

DROP POLICY IF EXISTS "Users insert own pending enrollment" ON public.enrollments;
CREATE POLICY "Users insert own pending enrollment" ON public.enrollments
  FOR INSERT TO authenticated
  WITH CHECK (user_id = auth.uid() AND status = 'pending');

DROP POLICY IF EXISTS "Admins manage enrollments" ON public.enrollments;
CREATE POLICY "Admins manage enrollments" ON public.enrollments
  FOR UPDATE TO authenticated
  USING (public.is_admin())
  WITH CHECK (public.is_admin());

-- ─── Access helper RPC ────────────────────────────────────────────────────────
-- SECURITY DEFINER lets server components ask "does this user have access?"
-- without joining through profiles in an RLS-restricted query.
CREATE OR REPLACE FUNCTION public.has_module_access(p_module UUID)
RETURNS BOOLEAN
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT EXISTS (
    SELECT 1 FROM modules
    WHERE id = p_module AND price_paisa IS NULL
  ) OR EXISTS (
    SELECT 1 FROM enrollments
    WHERE user_id = auth.uid()
      AND module_id = p_module
      AND status = 'approved'
  );
$$;

GRANT EXECUTE ON FUNCTION public.has_module_access(UUID) TO authenticated;

-- ─── site_settings (single-row config table) ─────────────────────────────────
CREATE TABLE IF NOT EXISTS public.site_settings (
  id INT PRIMARY KEY DEFAULT 1 CHECK (id = 1),
  payment_qr_url TEXT,
  payment_instructions TEXT,
  whatsapp_number TEXT,
  whatsapp_message_template TEXT,
  updated_at TIMESTAMPTZ DEFAULT now()
);

ALTER TABLE public.site_settings ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Anyone reads site settings" ON public.site_settings;
CREATE POLICY "Anyone reads site settings" ON public.site_settings
  FOR SELECT TO authenticated USING (true);

DROP POLICY IF EXISTS "Admins write site settings" ON public.site_settings;
CREATE POLICY "Admins write site settings" ON public.site_settings
  FOR ALL TO authenticated
  USING (public.is_admin())
  WITH CHECK (public.is_admin());

INSERT INTO public.site_settings (id, whatsapp_message_template, payment_instructions)
VALUES (
  1,
  E'Hi DrishtiPrep, I have paid for {module}.\nName: {name}\nAmount: NPR {amount}\nCode: {code}',
  'Pay the amount shown via the QR code above. After paying, click "I''ve paid" and send your payment screenshot via WhatsApp with the code shown on the next screen.'
)
ON CONFLICT (id) DO NOTHING;

-- ─── updated_at trigger for enrollments ──────────────────────────────────────
CREATE OR REPLACE FUNCTION public.set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS enrollments_set_updated_at ON public.enrollments;
CREATE TRIGGER enrollments_set_updated_at
  BEFORE UPDATE ON public.enrollments
  FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

-- ─── Storage bucket for disability cards (private) ───────────────────────────
INSERT INTO storage.buckets (id, name, public)
VALUES ('disability-cards', 'disability-cards', false)
ON CONFLICT (id) DO NOTHING;

-- Path convention: {user_id}/{uuid}.{ext}
-- storage.foldername(name) returns the path segments as an array; segment 1
-- is the top-level folder, which we use as the owning user's id.
DROP POLICY IF EXISTS "Owners upload disability cards" ON storage.objects;
CREATE POLICY "Owners upload disability cards" ON storage.objects
  FOR INSERT TO authenticated
  WITH CHECK (
    bucket_id = 'disability-cards'
    AND (storage.foldername(name))[1] = auth.uid()::text
  );

DROP POLICY IF EXISTS "Owners read own disability cards" ON storage.objects;
CREATE POLICY "Owners read own disability cards" ON storage.objects
  FOR SELECT TO authenticated
  USING (
    bucket_id = 'disability-cards'
    AND (
      (storage.foldername(name))[1] = auth.uid()::text
      OR public.is_admin()
    )
  );

DROP POLICY IF EXISTS "Owners update own disability cards" ON storage.objects;
CREATE POLICY "Owners update own disability cards" ON storage.objects
  FOR UPDATE TO authenticated
  USING (
    bucket_id = 'disability-cards'
    AND (storage.foldername(name))[1] = auth.uid()::text
  );

DROP POLICY IF EXISTS "Owners delete own disability cards" ON storage.objects;
CREATE POLICY "Owners delete own disability cards" ON storage.objects
  FOR DELETE TO authenticated
  USING (
    bucket_id = 'disability-cards'
    AND (storage.foldername(name))[1] = auth.uid()::text
  );
