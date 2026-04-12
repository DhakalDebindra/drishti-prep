-- Phase 3 Content Lifecycle Updates

-- Add a status column to the questions table for individual deprecation.
-- We use 'active' and 'deprecated' to allow excluding questions without deleting them.
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS status TEXT DEFAULT 'active' CHECK (status IN ('active', 'deprecated'));

-- We will continue using `is_verified` on `question_sets` to handle the Draft (false) vs Published (true) state.
