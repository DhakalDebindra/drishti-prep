-- Collapse 1.12 from 11 topics → 5 per approved syllabus
-- Approved: इतिहास | मौलिक हक/कर्तव्य/निर्देशक | संरचना/शासन | संवैधानिक निकाय | विविध तथ्य
-- All subtopics being removed/merged have sets=0 — safe to delete

-- ============================================================
-- Step 1: Delete subtopics from the 6 topics being removed
-- ============================================================
DELETE FROM public.subtopics WHERE topic_id IN (
  '26205e7b-e5de-4d0f-a8cc-cd31d549a623',  -- संविधानको परिचय
  'b81803ff-1bfc-476b-b66c-3b0d87b47169',  -- नागरिकता
  'bda7135a-9bc1-4f59-89aa-62952bba342e',  -- निर्देशक सिद्धान्त
  'd011e58e-2b13-487f-874d-3e922d345bed',  -- कार्यपालिका
  'db7b97b9-0702-40cb-a738-d4e9e525509c',  -- व्यवस्थापिका
  '189480ef-1025-446f-b9c3-189ce926d21e'   -- न्यायपालिका
);

-- Also clear subtopics from the two topics being renamed/merged into,
-- so we can add the correct merged subtopics fresh
DELETE FROM public.subtopics WHERE topic_id IN (
  'cb490683-a1e3-4227-b2b9-bb72da6bdb33',  -- मौलिक हक → becomes 1.12.2
  '291aea03-f1a0-44e5-983e-1fa5f2358974'   -- राज्य संरचना → becomes 1.12.3
);

-- ============================================================
-- Step 2: Delete the 6 collapsed topics
-- ============================================================
DELETE FROM public.topics WHERE id IN (
  '26205e7b-e5de-4d0f-a8cc-cd31d549a623',
  'b81803ff-1bfc-476b-b66c-3b0d87b47169',
  'bda7135a-9bc1-4f59-89aa-62952bba342e',
  'd011e58e-2b13-487f-874d-3e922d345bed',
  'db7b97b9-0702-40cb-a738-d4e9e525509c',
  '189480ef-1025-446f-b9c3-189ce926d21e'
);

-- ============================================================
-- Step 3: Rename and renumber the 5 surviving topics
-- ============================================================

-- 1.12.1 संवैधानिक इतिहास (7130b022) — no change needed, stays ord=1

-- 1.12.2: was "मौलिक हक र कर्तव्य" → merged topic
UPDATE public.topics
SET name         = 'मौलिक हक, कर्तव्य र निर्देशक सिद्धान्त',
    slug         = 'const-rights-duties-directives',
    syllabus_ref = '1.12.2',
    display_order = 2
WHERE id = 'cb490683-a1e3-4227-b2b9-bb72da6bdb33';

-- 1.12.3: was "राज्य संरचना र शक्ति बाँडफाँड" → merged topic
UPDATE public.topics
SET name         = 'राज्यको संरचना र शासन प्रणाली',
    slug         = 'const-structure-governance',
    syllabus_ref = '1.12.3',
    display_order = 3
WHERE id = '291aea03-f1a0-44e5-983e-1fa5f2358974';

-- 1.12.4: was 1.12.10 संवैधानिक निकाय
UPDATE public.topics
SET syllabus_ref = '1.12.4', display_order = 4
WHERE id = '79659c10-a751-4c00-8cb3-db168964e97f';

-- 1.12.5: was 1.12.11 संवैधानिक विविध तथ्य
UPDATE public.topics
SET syllabus_ref = '1.12.5', display_order = 5
WHERE id = 'f7e9e471-5e2c-49fc-8a8d-d2c321bb3228';

-- ============================================================
-- Step 4: Add correct subtopics to the merged topics
-- ============================================================

-- 1.12.2 मौलिक हक, कर्तव्य र निर्देशक सिद्धान्त
INSERT INTO public.subtopics (topic_id, name, slug, display_order) VALUES
  ('cb490683-a1e3-4227-b2b9-bb72da6bdb33', 'नागरिकता र प्रारम्भिक व्यवस्था',    'const-citizenship-prelim',  1),
  ('cb490683-a1e3-4227-b2b9-bb72da6bdb33', 'मौलिक हक',                             'const-fundamental-rights',  2),
  ('cb490683-a1e3-4227-b2b9-bb72da6bdb33', 'नागरिक कर्तव्य',                       'const-civic-duties',        3),
  ('cb490683-a1e3-4227-b2b9-bb72da6bdb33', 'निर्देशक सिद्धान्त र राज्य नीति',    'const-directives-policy',   4);

-- 1.12.3 राज्यको संरचना र शासन प्रणाली
INSERT INTO public.subtopics (topic_id, name, slug, display_order) VALUES
  ('291aea03-f1a0-44e5-983e-1fa5f2358974', 'संघीय संरचना र शक्ति बाँडफाँड', 'const-federal-power',   1),
  ('291aea03-f1a0-44e5-983e-1fa5f2358974', 'कार्यपालिका',                      'const-executive',       2),
  ('291aea03-f1a0-44e5-983e-1fa5f2358974', 'व्यवस्थापिका',                     'const-legislature',     3),
  ('291aea03-f1a0-44e5-983e-1fa5f2358974', 'न्यायपालिका',                      'const-judiciary',       4);
