-- Cross-link GK स्रोत-आधारित sets to Nimavi module
-- Creates stub subtopics in Nimavi समसामयिक topic (949d456e) as nav anchors,
-- then inserts junction rows for all sets in GK's 1.11.4 subtopics.

-- ============================================================
-- Step 1: Add स्रोत subtopics under Nimavi समसामयिक topic
-- ============================================================
-- Nimavi topic: "राष्ट्रिय तथा अन्तर्राष्ट्रिय समसामयिक घटना" (949d456e)
-- These are nav anchors; the actual questions live in the GK side.

INSERT INTO public.subtopics (topic_id, name, slug, display_order) VALUES
  ('949d456e-f7e6-41e0-9bf9-a6098032eaa4', 'आसमान सर सङ्ग्रह',    'nimavi-aasman-collection', 1),
  ('949d456e-f7e6-41e0-9bf9-a6098032eaa4', 'गोरखापत्र साप्ताहिक', 'nimavi-gorkhapatra',       2),
  ('949d456e-f7e6-41e0-9bf9-a6098032eaa4', 'लोकसेवा प्रकाशन',     'nimavi-psc-publications',  3),
  ('949d456e-f7e6-41e0-9bf9-a6098032eaa4', 'दैनिक समाचार सङ्कलन', 'nimavi-daily-news-digest', 4);

-- ============================================================
-- Step 2: Cross-link GK आसमान sets → Nimavi (100 sets)
-- ============================================================
INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
SELECT
  qs.id,
  '6695669a-f40e-421a-a4ec-b09bbeaf56c4'::uuid,  -- nimavi-pratham-patra module
  (SELECT id FROM public.subtopics WHERE slug = 'nimavi-aasman-collection')
FROM public.question_sets qs
WHERE qs.subtopic_id = '68f17c03-c021-4bd6-bf1d-b5f3273a8c75'  -- GK आसमान सर सङ्ग्रह
ON CONFLICT DO NOTHING;

-- ============================================================
-- Step 3: Cross-link GK गोरखापत्र sets → Nimavi (currently 0 sets; future-proof)
-- ============================================================
INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
SELECT
  qs.id,
  '6695669a-f40e-421a-a4ec-b09bbeaf56c4'::uuid,
  (SELECT id FROM public.subtopics WHERE slug = 'nimavi-gorkhapatra')
FROM public.question_sets qs
WHERE qs.subtopic_id = '496b46ba-91ca-44b6-9dba-9ac38f2713f7'  -- GK गोरखापत्र साप्ताहिक
ON CONFLICT DO NOTHING;

-- ============================================================
-- Step 4: Cross-link GK लोकसेवा sets → Nimavi (currently 0 sets; future-proof)
-- ============================================================
INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
SELECT
  qs.id,
  '6695669a-f40e-421a-a4ec-b09bbeaf56c4'::uuid,
  (SELECT id FROM public.subtopics WHERE slug = 'nimavi-psc-publications')
FROM public.question_sets qs
WHERE qs.subtopic_id = '6f1b8a1c-8c6a-4892-9600-9525550d5270'  -- GK लोकसेवा प्रकाशन
ON CONFLICT DO NOTHING;

-- ============================================================
-- Step 5: Cross-link GK दैनिक समाचार sets → Nimavi (currently 0 sets; future-proof)
-- ============================================================
INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
SELECT
  qs.id,
  '6695669a-f40e-421a-a4ec-b09bbeaf56c4'::uuid,
  (SELECT id FROM public.subtopics WHERE slug = 'nimavi-daily-news-digest')
FROM public.question_sets qs
WHERE qs.subtopic_id = '58e63396-f84a-4f4c-afc6-4b8878f4c445'  -- GK दैनिक समाचार सङ्कलन
ON CONFLICT DO NOTHING;
