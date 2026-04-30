-- Migration: Consolidate all RLS admin checks to use public.is_admin()
-- 
-- Context: Older migrations used inline EXISTS checks against profiles.
-- The is_admin() SECURITY DEFINER function was added in 20260424180000_rls_security_hardening.sql.
-- This migration replaces all inline checks with the canonical function for:
--   1. Consistency — one pattern to audit instead of two
--   2. Security — SECURITY DEFINER ensures the check works even when
--      profiles table RLS would otherwise block the lookup
--   3. Maintainability — future changes to admin logic touch one function

-- Document the canonical admin check function
COMMENT ON FUNCTION public.is_admin() IS 
  'Canonical admin check for RLS policies. Returns true if the current user has is_admin=true in profiles. Use this function in all RLS policies instead of inline EXISTS checks.';

-- ─── Modules ──────────────────────────────────────────────────────────────────
DROP POLICY IF EXISTS "Admin write modules" ON public.modules;
DROP POLICY IF EXISTS "Admins can delete modules" ON public.modules;
CREATE POLICY "Admins can manage modules"
  ON public.modules
  FOR ALL
  TO authenticated
  USING (public.is_admin())
  WITH CHECK (public.is_admin());

-- ─── Subjects ─────────────────────────────────────────────────────────────────
DROP POLICY IF EXISTS "Admins can insert subjects" ON public.subjects;
DROP POLICY IF EXISTS "Admins can update subjects" ON public.subjects;
DROP POLICY IF EXISTS "Admins can delete subjects" ON public.subjects;
CREATE POLICY "Admins can manage subjects"
  ON public.subjects
  FOR ALL
  TO authenticated
  USING (public.is_admin())
  WITH CHECK (public.is_admin());

-- ─── Topics ───────────────────────────────────────────────────────────────────
DROP POLICY IF EXISTS "Admins can insert topics" ON public.topics;
DROP POLICY IF EXISTS "Admins can update topics" ON public.topics;
DROP POLICY IF EXISTS "Admins can delete topics" ON public.topics;
CREATE POLICY "Admins can manage topics"
  ON public.topics
  FOR ALL
  TO authenticated
  USING (public.is_admin())
  WITH CHECK (public.is_admin());

-- ─── Question Sets ────────────────────────────────────────────────────────────
DROP POLICY IF EXISTS "Admins can insert question_sets" ON public.question_sets;
DROP POLICY IF EXISTS "Admins can update question_sets" ON public.question_sets;
DROP POLICY IF EXISTS "Admins can delete question_sets" ON public.question_sets;
CREATE POLICY "Admins can manage question sets"
  ON public.question_sets
  FOR ALL
  TO authenticated
  USING (public.is_admin())
  WITH CHECK (public.is_admin());

-- ─── Questions ────────────────────────────────────────────────────────────────
DROP POLICY IF EXISTS "Admins can insert questions" ON public.questions;
DROP POLICY IF EXISTS "Admins can update questions" ON public.questions;
DROP POLICY IF EXISTS "Admins can delete questions" ON public.questions;
CREATE POLICY "Admins can manage questions"
  ON public.questions
  FOR ALL
  TO authenticated
  USING (public.is_admin())
  WITH CHECK (public.is_admin());

-- ─── Tags ─────────────────────────────────────────────────────────────────────
DROP POLICY IF EXISTS "Admin write tags" ON public.tags;
DROP POLICY IF EXISTS "Admins can delete tags" ON public.tags;
CREATE POLICY "Admins can manage tags"
  ON public.tags
  FOR ALL
  TO authenticated
  USING (public.is_admin())
  WITH CHECK (public.is_admin());

-- ─── Question Tags ───────────────────────────────────────────────────────────
DROP POLICY IF EXISTS "Admin write question_tags" ON public.question_tags;
CREATE POLICY "Admins can manage question tags"
  ON public.question_tags
  FOR ALL
  TO authenticated
  USING (public.is_admin())
  WITH CHECK (public.is_admin());
