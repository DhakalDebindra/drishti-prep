-- Phase 3: Pathway 2 - Dispute Aggregation View

-- This view aggregates all pending reports grouped by the specific question.
-- It automatically computes urgency (priority) based on a threshold (3+ reports = High Priority).
-- It joins with questions and question_sets for immediate contextual display in the Admin Inbox.

CREATE OR REPLACE VIEW public.active_disputes_view AS
SELECT 
    r.question_id,
    q.content AS question_content,
    q.set_id,
    qs.title AS set_title,
    COUNT(r.id) AS report_count,
    CASE 
        WHEN COUNT(r.id) >= 3 THEN 'High'
        ELSE 'Normal'
    END AS priority,
    MIN(r.created_at) AS oldest_report_date,
    JSON_AGG(DISTINCT r.issue_type) AS issue_types
FROM public.reports r
JOIN public.questions q ON r.question_id = q.id
JOIN public.question_sets qs ON q.set_id = qs.id
WHERE r.status = 'pending'
GROUP BY r.question_id, q.content, q.set_id, qs.title;

-- Ensure admins have select access to the view
GRANT SELECT ON public.active_disputes_view TO authenticated;
