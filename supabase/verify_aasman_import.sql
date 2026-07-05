-- Quick verification of the Aasman daily import
SELECT
  (SELECT COUNT(*) FROM public.question_sets qs
   JOIN public.subtopics st ON st.id = qs.subtopic_id
   WHERE st.slug = 'aasman-collection') AS aasman_sets_total,
  (SELECT COUNT(*) FROM public.questions q
   JOIN public.question_set_questions qsq ON qsq.question_id = q.id
   JOIN public.question_sets qs ON qs.id = qsq.question_set_id
   JOIN public.subtopics st ON st.id = qs.subtopic_id
   WHERE st.slug = 'aasman-collection') AS aasman_questions_total,
  (SELECT COUNT(*) FROM public.topic_learning_paths tlp
   JOIN public.subtopics st ON st.topic_id = tlp.topic_id
   WHERE st.slug = 'aasman-collection') AS learning_path_steps;
