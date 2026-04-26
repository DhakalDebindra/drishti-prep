-- Phase 2: Wipe Current Affairs Content
DO $$
DECLARE
  ca_subject_id uuid;
BEGIN
  -- Identify the Current Affairs subject
  SELECT id INTO ca_subject_id FROM subjects WHERE slug = 'current-affairs' LIMIT 1;

  IF ca_subject_id IS NULL THEN
    RAISE EXCEPTION 'Current Affairs subject not found';
  END IF;

  -- 1. Delete from dependent tables first (bottom-up)
  DELETE FROM public.ai_feedback WHERE attempt_id IN (
    SELECT id FROM public.attempts WHERE set_id IN (
      SELECT id FROM public.question_sets WHERE topic_id IN (
        SELECT id FROM public.topics WHERE subject_id = ca_subject_id
      )
    )
  );

  DELETE FROM public.attempt_answers WHERE attempt_id IN (
    SELECT id FROM public.attempts WHERE set_id IN (
      SELECT id FROM public.question_sets WHERE topic_id IN (
        SELECT id FROM public.topics WHERE subject_id = ca_subject_id
      )
    )
  );

  DELETE FROM public.attempts WHERE set_id IN (
    SELECT id FROM public.question_sets WHERE topic_id IN (
      SELECT id FROM public.topics WHERE subject_id = ca_subject_id
    )
  );

  DELETE FROM public.bookmarks WHERE question_id IN (
    SELECT id FROM public.questions WHERE set_id IN (
      SELECT id FROM public.question_sets WHERE topic_id IN (
        SELECT id FROM public.topics WHERE subject_id = ca_subject_id
      )
    )
  );

  DELETE FROM public.reports WHERE question_id IN (
    SELECT id FROM public.questions WHERE set_id IN (
      SELECT id FROM public.question_sets WHERE topic_id IN (
        SELECT id FROM public.topics WHERE subject_id = ca_subject_id
      )
    )
  );

  DELETE FROM public.question_tags WHERE question_id IN (
    SELECT id FROM public.questions WHERE set_id IN (
      SELECT id FROM public.question_sets WHERE topic_id IN (
        SELECT id FROM public.topics WHERE subject_id = ca_subject_id
      )
    )
  );

  DELETE FROM public.question_set_questions WHERE question_id IN (
    SELECT id FROM public.questions WHERE set_id IN (
      SELECT id FROM public.question_sets WHERE topic_id IN (
        SELECT id FROM public.topics WHERE subject_id = ca_subject_id
      )
    )
  ) OR question_set_id IN (
    SELECT id FROM public.question_sets WHERE topic_id IN (
      SELECT id FROM public.topics WHERE subject_id = ca_subject_id
    )
  );

  DELETE FROM public.topic_learning_paths WHERE topic_id IN (
    SELECT id FROM public.topics WHERE subject_id = ca_subject_id
  ) OR question_set_id IN (
    SELECT id FROM public.question_sets WHERE topic_id IN (
      SELECT id FROM public.topics WHERE subject_id = ca_subject_id
    )
  );

  DELETE FROM public.user_topic_progress WHERE topic_id IN (
    SELECT id FROM public.topics WHERE subject_id = ca_subject_id
  );

  DELETE FROM public.questions WHERE set_id IN (
    SELECT id FROM public.question_sets WHERE topic_id IN (
      SELECT id FROM public.topics WHERE subject_id = ca_subject_id
    )
  );

  DELETE FROM public.question_sets WHERE topic_id IN (
    SELECT id FROM public.topics WHERE subject_id = ca_subject_id
  );

  DELETE FROM public.topics WHERE subject_id = ca_subject_id;

END $$;
