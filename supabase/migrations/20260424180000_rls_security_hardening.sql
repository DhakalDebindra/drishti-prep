-- Hardening RLS policies across the database
-- Focus: Consolidating admin checks and ensuring per-user data is strictly isolated.

-- 1. Helper function for admin checks (efficient and reusable)
CREATE OR REPLACE FUNCTION public.is_admin()
RETURNS BOOLEAN AS $$
BEGIN
  RETURN EXISTS (
    SELECT 1 FROM public.profiles 
    WHERE id = auth.uid() AND is_admin = true
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 2. Secure PROFILES
-- Current: Users can only see/update themselves. 
-- Need: Admins need to list/view users.
DROP POLICY IF EXISTS "Profiles can select own row" ON public.profiles;
DROP POLICY IF EXISTS "Users can view own profile" ON public.profiles;
DROP POLICY IF EXISTS "Users can update own profile" ON public.profiles;

CREATE POLICY "Profiles are readable by owners and admins" 
  ON public.profiles FOR SELECT 
  USING (auth.uid() = id OR public.is_admin());

CREATE POLICY "Profiles are updatable by owners" 
  ON public.profiles FOR UPDATE 
  USING (auth.uid() = id)
  WITH CHECK (auth.uid() = id);

-- 3. Secure ATTEMPTS & ANSWERS
-- Current policies exist but we'll use our new is_admin() for clarity and speed.
DROP POLICY IF EXISTS "Attempts readable by admins" ON public.attempts;
CREATE POLICY "Attempts readable by admins" 
  ON public.attempts FOR SELECT 
  USING (public.is_admin());

DROP POLICY IF EXISTS "Attempt answers readable by admins" ON public.attempt_answers;
CREATE POLICY "Attempt answers readable by admins" 
  ON public.attempt_answers FOR SELECT 
  USING (public.is_admin());

DROP POLICY IF EXISTS "AI feedback readable by admins" ON public.ai_feedback;
CREATE POLICY "AI feedback readable by admins" 
  ON public.ai_feedback FOR SELECT 
  USING (public.is_admin());

-- 4. Secure REPORTS
-- Reports are per-user, but admins need full control.
DROP POLICY IF EXISTS "Admins can view all reports" ON public.reports;
DROP POLICY IF EXISTS "Admins can update reports" ON public.reports;
DROP POLICY IF EXISTS "Admins manage all reports" ON public.reports;

CREATE POLICY "Admins manage all reports" 
  ON public.reports FOR ALL 
  USING (public.is_admin());

-- 5. Content Tables: Ensure DELETE is restricted to admins
-- Some migrations might have missed DELETE or used true/false incorrectly.
DROP POLICY IF EXISTS "Admins can delete subjects" ON public.subjects;
CREATE POLICY "Admins can delete subjects" ON public.subjects FOR DELETE USING (public.is_admin());

DROP POLICY IF EXISTS "Admins can delete topics" ON public.topics;
CREATE POLICY "Admins can delete topics" ON public.topics FOR DELETE USING (public.is_admin());

DROP POLICY IF EXISTS "Admins can delete question_sets" ON public.question_sets;
CREATE POLICY "Admins can delete question_sets" ON public.question_sets FOR DELETE USING (public.is_admin());

DROP POLICY IF EXISTS "Admins can delete questions" ON public.questions;
CREATE POLICY "Admins can delete questions" ON public.questions FOR DELETE USING (public.is_admin());

DROP POLICY IF EXISTS "Admins can delete modules" ON public.modules;
CREATE POLICY "Admins can delete modules" ON public.modules FOR DELETE USING (public.is_admin());

DROP POLICY IF EXISTS "Admins can delete tags" ON public.tags;
CREATE POLICY "Admins can delete tags" ON public.tags FOR DELETE USING (public.is_admin());

-- 6. User Progress Isolation
-- Ensure users can't see or modify others' progress tracking.
DROP POLICY IF EXISTS "Users manage own progress" ON public.user_topic_progress;
CREATE POLICY "Users manage own progress" 
  ON public.user_topic_progress FOR ALL 
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- 7. Junction Tables: Ensure admin-only writes
DROP POLICY IF EXISTS "Admin write question_set_questions" ON public.question_set_questions;
CREATE POLICY "Admin write question_set_questions" 
  ON public.question_set_questions FOR ALL 
  USING (public.is_admin());

DROP POLICY IF EXISTS "Admin write topic_learning_paths" ON public.topic_learning_paths;
CREATE POLICY "Admin write topic_learning_paths" 
  ON public.topic_learning_paths FOR ALL 
  USING (public.is_admin());
