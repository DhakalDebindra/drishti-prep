-- Collapse 1.11 from 10 topics → 4 per approved syllabus
-- Approved: राष्ट्रिय समसामयिक | अन्तर्राष्ट्रिय समसामयिक | खेलकुद/पुरस्कार/व्यक्ति | स्रोत आधारित अभ्यास
-- स्रोत-आधारित अभ्यास (sets=100) is untouched — only moved to ord=4

-- ============================================================
-- Step 1: Delete subtopics of 6 topics being removed (all sets=0)
-- ============================================================
DELETE FROM public.subtopics WHERE topic_id IN (
  'ff568595-ea49-47d9-b386-4a35d3568a37',  -- खेलकुद
  'e8da7144-5a33-4956-acbe-127855a4eadf',  -- महत्वपूर्ण व्यक्ति
  '167f0e23-c5d2-42ec-925f-7b9f5a4f1131',  -- दिवस, नारा र संवत्सर
  '6ea60441-edb0-418e-9160-16a7e430eeb2',  -- पुस्तक, प्रतिवेदन र सूचकाङ्क
  'f51dac93-2e70-47c2-b41a-603a8641e3dc',  -- विज्ञान, प्रविधि र वातावरण
  'e04d38cf-669a-4d23-bf75-6f586acd9888'   -- रक्षा र सुरक्षा
);

-- Also clear old subtopics from पुरस्कार र सम्मान (68e6363f)
-- which will become the new 1.11.3 merged topic
DELETE FROM public.subtopics WHERE topic_id = '68e6363f-030b-4ac5-b53c-b4f67d602c65';

-- ============================================================
-- Step 2: Delete the 6 extra topics
-- ============================================================
DELETE FROM public.topics WHERE id IN (
  'ff568595-ea49-47d9-b386-4a35d3568a37',
  'e8da7144-5a33-4956-acbe-127855a4eadf',
  '167f0e23-c5d2-42ec-925f-7b9f5a4f1131',
  '6ea60441-edb0-418e-9160-16a7e430eeb2',
  'f51dac93-2e70-47c2-b41a-603a8641e3dc',
  'e04d38cf-669a-4d23-bf75-6f586acd9888'
);

-- ============================================================
-- Step 3: Fix display_order and syllabus_refs on all 4 surviving topics
-- ============================================================

-- 1.11.1 राष्ट्रिय समसामयिक (ed8b1c71)
UPDATE public.topics SET syllabus_ref = '1.11.1', display_order = 1
WHERE id = 'ed8b1c71-eeb2-4e08-8d32-f0d34e913a60';

-- 1.11.2 अन्तर्राष्ट्रिय समसामयिक (2cf676c5)
UPDATE public.topics SET syllabus_ref = '1.11.2', display_order = 2
WHERE id = '2cf676c5-260f-47c6-9bbc-dd5fa93d6c3c';

-- 1.11.3: repurpose पुरस्कार र सम्मान → merged topic
UPDATE public.topics
SET name          = 'खेलकुद, पुरस्कार र उल्लेखनीय व्यक्ति',
    slug          = 'current-affairs-sports-awards-persons',
    syllabus_ref  = '1.11.3',
    display_order = 3
WHERE id = '68e6363f-030b-4ac5-b53c-b4f67d602c65';

-- 1.11.4 स्रोत-आधारित अभ्यास (0627843e) — 100 sets, untouched content
UPDATE public.topics SET syllabus_ref = '1.11.4', display_order = 4
WHERE id = '0627843e-8276-4d35-8789-d9ccd0a89085';

-- ============================================================
-- Step 4: Add subtopics to the new merged 1.11.3
-- ============================================================
INSERT INTO public.subtopics (topic_id, name, slug, display_order) VALUES
  ('68e6363f-030b-4ac5-b53c-b4f67d602c65', 'खेलकुद उपलब्धि',                    'ca-sports-achievements', 1),
  ('68e6363f-030b-4ac5-b53c-b4f67d602c65', 'राष्ट्रिय र अन्तर्राष्ट्रिय पुरस्कार', 'ca-awards',              2),
  ('68e6363f-030b-4ac5-b53c-b4f67d602c65', 'पुस्तक र उल्लेखनीय व्यक्ति',         'ca-books-persons',       3);
