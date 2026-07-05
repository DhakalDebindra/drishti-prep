-- 1.11.3: remove "उल्लेखनीय व्यक्ति", split into खेलकुद + पुरस्कार subtopics

-- Rename topic
UPDATE public.topics
SET name = 'खेलकुद र पुरस्कार', slug = 'current-affairs-sports-awards'
WHERE id = '68e6363f-030b-4ac5-b53c-b4f67d602c65';

-- Drop old 3 subtopics (all sets=0)
DELETE FROM public.subtopics WHERE topic_id = '68e6363f-030b-4ac5-b53c-b4f67d602c65';

-- Add 2 correct subtopics
INSERT INTO public.subtopics (topic_id, name, slug, display_order) VALUES
  ('68e6363f-030b-4ac5-b53c-b4f67d602c65', 'राष्ट्रिय तथा अन्तर्राष्ट्रिय खेलकुद', 'ca-sports',  1),
  ('68e6363f-030b-4ac5-b53c-b4f67d602c65', 'राष्ट्रिय तथा अन्तर्राष्ट्रिय पुरस्कार', 'ca-awards',  2);
