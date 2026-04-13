-- Phase 3: Pathway 2 - Dispute Aggregation View Security Fix

-- Recreate the view explicitly defining SECURITY INVOKER true
-- This ensures that the view does not bypass RLS policies of the underlying tables (reports, questions).
-- By default in Postgres 15+, views don't enforce RLS unless this is set.
-- Without this, any authenticated student could hit the postgrest API and fetch aggregated data for all disputes.

CREATE OR REPLACE VIEW public.active_disputes_view WITH (security_invoker = true) AS
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
