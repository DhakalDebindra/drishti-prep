-- Append a question to an existing set in a single round trip.
--
-- The admin editor previously did this in four calls (max order_number, max
-- position, insert question, insert membership). Each call is a separate
-- network round trip from the Next.js server to Supabase, which is what made
-- "Adding..." linger. Folding them into one function also makes the pair of
-- inserts atomic: before, a failed membership insert had to be undone with a
-- compensating delete.
--
-- SECURITY INVOKER: RLS still applies, so only admins can insert (see the
-- is_admin() policies on questions and question_set_questions).

CREATE OR REPLACE FUNCTION public.add_question_to_set(
  p_set_id uuid,
  p_content text,
  p_option_a text,
  p_option_b text,
  p_option_c text,
  p_option_d text,
  p_correct_option text,
  p_explanation text DEFAULT NULL,
  p_exam_year integer DEFAULT NULL,
  p_paper_ref text DEFAULT NULL,
  p_language text DEFAULT 'nepali'
)
RETURNS public.questions
LANGUAGE plpgsql
SECURITY INVOKER
SET search_path = public
AS $$
DECLARE
  v_position integer;
  v_question public.questions;
BEGIN
  -- Row lock serialises concurrent adds to the same set so two admins cannot
  -- compute the same position. Doubles as the set-exists check.
  PERFORM 1 FROM public.question_sets WHERE id = p_set_id FOR UPDATE;
  IF NOT FOUND THEN
    RAISE EXCEPTION 'Question set % not found', p_set_id
      USING ERRCODE = 'no_data_found';
  END IF;

  -- One past the highest of either linkage, so a set whose two tables have
  -- drifted still lands on a free slot in both.
  SELECT GREATEST(
           COALESCE((SELECT MAX(order_number) FROM public.questions
                      WHERE set_id = p_set_id), 0),
           COALESCE((SELECT MAX(position) FROM public.question_set_questions
                      WHERE question_set_id = p_set_id), 0)
         ) + 1
    INTO v_position;

  INSERT INTO public.questions (
    set_id, order_number, content,
    option_a, option_b, option_c, option_d,
    correct_option, explanation, exam_year, paper_ref, language
  )
  VALUES (
    p_set_id, v_position, p_content,
    p_option_a, p_option_b, p_option_c, p_option_d,
    p_correct_option, p_explanation, p_exam_year, p_paper_ref,
    COALESCE(p_language, 'nepali')
  )
  RETURNING * INTO v_question;

  INSERT INTO public.question_set_questions (question_set_id, question_id, position)
  VALUES (p_set_id, v_question.id, v_position);

  RETURN v_question;
END;
$$;

REVOKE EXECUTE ON FUNCTION public.add_question_to_set(
  uuid, text, text, text, text, text, text, text, integer, text, text
) FROM PUBLIC;

GRANT EXECUTE ON FUNCTION public.add_question_to_set(
  uuid, text, text, text, text, text, text, text, integer, text, text
) TO authenticated;
