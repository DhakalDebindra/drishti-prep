-- Align question feedback data model with the unified explanation requirement
-- Rename the existing general_explanation column to the new canonical name.
ALTER TABLE public.questions
    RENAME COLUMN general_explanation TO explanation;

-- Remove the per-option feedback columns that are no longer needed.
ALTER TABLE public.questions
    DROP COLUMN IF EXISTS feedback_a,
    DROP COLUMN IF EXISTS feedback_b,
    DROP COLUMN IF EXISTS feedback_c,
    DROP COLUMN IF EXISTS feedback_d;
