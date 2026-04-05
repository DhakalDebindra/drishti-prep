-- Migration to allow skipped state in attempt_answers
ALTER TABLE public.attempt_answers DROP CONSTRAINT IF EXISTS attempt_answers_selected_option_check;
ALTER TABLE public.attempt_answers ALTER COLUMN selected_option TYPE VARCHAR(10);
ALTER TABLE public.attempt_answers ADD CONSTRAINT attempt_answers_selected_option_check CHECK (selected_option IN ('A', 'B', 'C', 'D', 'skipped'));
