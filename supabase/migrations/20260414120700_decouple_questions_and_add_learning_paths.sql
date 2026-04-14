-- Phase 1: Metadata & Architecture Updates

-- Step 1 — Add set_type to question_sets
ALTER TABLE public.question_sets
ADD COLUMN IF NOT EXISTS set_type text NOT NULL DEFAULT 'learning'
CHECK (set_type IN ('learning', 'mock_exam', 'daily_practice', 'revision', 'custom'));

-- Step 2 — Create question_set_questions junction table
CREATE TABLE IF NOT EXISTS public.question_set_questions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  question_set_id uuid NOT NULL REFERENCES public.question_sets(id) ON DELETE CASCADE,
  question_id uuid NOT NULL REFERENCES public.questions(id) ON DELETE CASCADE,
  position integer NOT NULL DEFAULT 0,
  added_at timestamp with time zone DEFAULT now(),
  UNIQUE(question_set_id, question_id)
);

-- Migrate existing set_id relationships
INSERT INTO public.question_set_questions (question_set_id, question_id, position)
SELECT 
  q.set_id,
  q.id,
  ROW_NUMBER() OVER (PARTITION BY q.set_id ORDER BY q.created_at)
FROM public.questions q
WHERE q.set_id IS NOT NULL
ON CONFLICT (question_set_id, question_id) DO NOTHING;

-- Step 3 — Create topic_learning_paths table
CREATE TABLE IF NOT EXISTS public.topic_learning_paths (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  topic_id uuid NOT NULL REFERENCES public.topics(id) ON DELETE CASCADE,
  question_set_id uuid NOT NULL REFERENCES public.question_sets(id) ON DELETE RESTRICT,
  step_order integer NOT NULL,
  is_locked boolean NOT NULL DEFAULT true,
  unlocked_after uuid REFERENCES public.topic_learning_paths(id) ON DELETE SET NULL,
  created_at timestamp with time zone DEFAULT now(),
  UNIQUE(topic_id, step_order),
  UNIQUE(topic_id, question_set_id)
);

-- Populate topic_learning_paths from existing data
INSERT INTO public.topic_learning_paths (topic_id, question_set_id, step_order, is_locked)
SELECT 
  qs.topic_id,
  qs.id,
  ROW_NUMBER() OVER (PARTITION BY qs.topic_id ORDER BY qs.created_at),
  false
FROM public.question_sets qs
WHERE qs.topic_id IS NOT NULL
ON CONFLICT (topic_id, question_set_id) DO NOTHING;

-- Set step 1 to permanently unlocked
UPDATE public.topic_learning_paths
SET is_locked = false
WHERE step_order = 1;

-- Wire the unlocked_after references
UPDATE public.topic_learning_paths tlp
SET unlocked_after = prev.id
FROM public.topic_learning_paths prev
WHERE tlp.topic_id = prev.topic_id
  AND tlp.step_order = prev.step_order + 1;

-- Step 4 — Create user_topic_progress table
CREATE TABLE IF NOT EXISTS public.user_topic_progress (
  user_id uuid NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  topic_id uuid NOT NULL REFERENCES public.topics(id) ON DELETE CASCADE,
  current_step integer NOT NULL DEFAULT 1,
  sets_completed integer NOT NULL DEFAULT 0,
  completed_set_ids uuid[] DEFAULT '{}',
  last_activity timestamp with time zone DEFAULT now(),
  PRIMARY KEY (user_id, topic_id)
);

-- Step 5 — Add provenance columns to questions
ALTER TABLE public.questions
ADD COLUMN IF NOT EXISTS exam_year integer,
ADD COLUMN IF NOT EXISTS paper_ref text,
ADD COLUMN IF NOT EXISTS is_verified boolean NOT NULL DEFAULT false,
ADD COLUMN IF NOT EXISTS verified_by uuid REFERENCES public.profiles(id) ON DELETE SET NULL,
ADD COLUMN IF NOT EXISTS language text NOT NULL DEFAULT 'both'
  CHECK (language IN ('nepali', 'english', 'both')),
ADD COLUMN IF NOT EXISTS source_question_id uuid REFERENCES public.questions(id) ON DELETE SET NULL;

-- Step 6 — Create tags system
CREATE TABLE IF NOT EXISTS public.tags (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL UNIQUE,
  name_np text,
  slug text NOT NULL UNIQUE,
  color text,
  created_at timestamp with time zone DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.question_tags (
  question_id uuid NOT NULL REFERENCES public.questions(id) ON DELETE CASCADE,
  tag_id uuid NOT NULL REFERENCES public.tags(id) ON DELETE CASCADE,
  PRIMARY KEY (question_id, tag_id)
);

-- Step 7 — Add structured targeting to profiles
ALTER TABLE public.profiles
ADD COLUMN IF NOT EXISTS target_exam_level text 
  CHECK (target_exam_level IN ('kharidar', 'nayab_subba', 'section_officer', 'other')),
ADD COLUMN IF NOT EXISTS target_year integer,
ADD COLUMN IF NOT EXISTS district text,
ADD COLUMN IF NOT EXISTS province text;

-- Step 8 — Add missing indexes
CREATE INDEX IF NOT EXISTS idx_questions_status ON public.questions(status);
CREATE INDEX IF NOT EXISTS idx_questions_exam_year ON public.questions(exam_year);
CREATE INDEX IF NOT EXISTS idx_attempt_answers_attempt ON public.attempt_answers(attempt_id);
CREATE INDEX IF NOT EXISTS idx_attempt_answers_question ON public.attempt_answers(question_id);
CREATE INDEX IF NOT EXISTS idx_bookmarks_user ON public.bookmarks(user_id);
CREATE INDEX IF NOT EXISTS idx_attempts_user ON public.attempts(user_id);
CREATE INDEX IF NOT EXISTS idx_qsq_set ON public.question_set_questions(question_set_id);
CREATE INDEX IF NOT EXISTS idx_qsq_question ON public.question_set_questions(question_id);
CREATE INDEX IF NOT EXISTS idx_tlp_topic ON public.topic_learning_paths(topic_id);
CREATE INDEX IF NOT EXISTS idx_utp_user ON public.user_topic_progress(user_id);

-- Step 9 — Enable RLS on all new tables
ALTER TABLE public.question_set_questions ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public read question_set_questions" ON public.question_set_questions FOR SELECT USING (true);
CREATE POLICY "Admin write question_set_questions" ON public.question_set_questions FOR ALL
  USING (EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND is_admin = true));

ALTER TABLE public.topic_learning_paths ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public read topic_learning_paths" ON public.topic_learning_paths FOR SELECT USING (true);
CREATE POLICY "Admin write topic_learning_paths" ON public.topic_learning_paths FOR ALL
  USING (EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND is_admin = true));

ALTER TABLE public.user_topic_progress ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users manage own progress" ON public.user_topic_progress FOR ALL
  USING (auth.uid() = user_id);

ALTER TABLE public.tags ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public read tags" ON public.tags FOR SELECT USING (true);
CREATE POLICY "Admin write tags" ON public.tags FOR ALL
  USING (EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND is_admin = true));

ALTER TABLE public.question_tags ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public read question_tags" ON public.question_tags FOR SELECT USING (true);
CREATE POLICY "Admin write question_tags" ON public.question_tags FOR ALL
  USING (EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND is_admin = true));

-- Step 10 — Create analytics view
CREATE OR REPLACE VIEW public.attempt_answers_enriched AS
SELECT
  aa.id,
  aa.attempt_id,
  aa.question_id,
  aa.selected_option,
  aa.is_correct,
  a.user_id,
  a.set_id as attempt_set_id,
  qs.topic_id,
  qs.difficulty_level as difficulty,
  qs.set_type,
  t.subject_id,
  t.name as topic_name,
  s.name as subject_name
FROM public.attempt_answers aa
JOIN public.attempts a ON a.id = aa.attempt_id
JOIN public.question_sets qs ON qs.id = a.set_id
JOIN public.topics t ON t.id = qs.topic_id
JOIN public.subjects s ON s.id = t.subject_id;

-- Step 11 — PENDING: DROP COLUMN questions.set_id
-- Run this only after confirming all frontend queries use question_set_questions
-- ALTER TABLE public.questions DROP COLUMN set_id;
