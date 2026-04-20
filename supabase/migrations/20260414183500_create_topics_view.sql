-- Migration: Create view for topics with question set counts
CREATE OR REPLACE VIEW public.topics_with_set_counts AS
SELECT 
    t.id,
    t.name,
    t.description,
    t.subject_id,
    t.syllabus_ref,
    t.display_order,
    t.created_at,
    COUNT(qs.id) FILTER (WHERE qs.is_verified = true) as set_count
FROM public.topics t
LEFT JOIN public.question_sets qs ON t.id = qs.topic_id
GROUP BY t.id;

-- Grant access to the view
GRANT SELECT ON public.topics_with_set_counts TO anon, authenticated;
