-- Scrub ai_feedback rows whose `strengths` field was poisoned with the raw
-- Gemini error string (e.g. "[GoogleGenerativeAI Error]: ... 429 Too Many
-- Requests Your prepayment credits are depleted ..."). These rows render as
-- the "Overall Performance" coaching text on the practice-review page,
-- exposing the upstream API endpoint and billing URL to learners.
--
-- After this migration, affected attempts will return 503 from
-- /api/attempts/[id]/feedback (per the route fix shipped in the same PR)
-- and the panel will render its friendly retry message until a fresh
-- feedback row is generated.

delete from public.ai_feedback
where
  strengths ilike '%generativelanguage.googleapis.com%'
  or strengths ilike '%GoogleGenerativeAI Error%'
  or strengths ilike '%prepayment credits are depleted%'
  or strengths ilike '%AI feedback generation failed.%';
