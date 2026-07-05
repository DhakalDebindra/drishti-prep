-- Move economic subtopics out of Nepal Geography (1.3) → Economy (1.7)
-- Affected subtopics: कृषि र वन (sets=3), जलविद्युत र खनिज (sets=1), पर्यटन र यातायात (sets=1)
-- Target topic: 1.7.1 विकासका पूर्वाधारहरु (01d23733-a071-431e-bdd2-c99c7c9b941a)
-- Strategy: update subtopic.topic_id + question_sets.topic_id for affected sets

-- 1. Move कृषि र वन subtopic to Economy topic 1.7.1
UPDATE public.subtopics
SET topic_id = '01d23733-a071-431e-bdd2-c99c7c9b941a'
WHERE id = '6d69614c-5e83-4c9b-98a6-dcedd4867e03';

-- 2. Move जलविद्युत र खनिज subtopic to Economy topic 1.7.1
UPDATE public.subtopics
SET topic_id = '01d23733-a071-431e-bdd2-c99c7c9b941a'
WHERE id = '5ceff9c8-db17-4726-acf2-7edfb7317bf0';

-- 3. Move पर्यटन र यातायात subtopic to Economy topic 1.7.1
UPDATE public.subtopics
SET topic_id = '01d23733-a071-431e-bdd2-c99c7c9b941a'
WHERE id = '20aaecbc-7618-444d-bf1d-2f261031b180';

-- 4. Update question_sets.topic_id for all sets under these three subtopics
UPDATE public.question_sets
SET topic_id = '01d23733-a071-431e-bdd2-c99c7c9b941a'
WHERE subtopic_id IN (
  '6d69614c-5e83-4c9b-98a6-dcedd4867e03',  -- कृषि र वन
  '5ceff9c8-db17-4726-acf2-7edfb7317bf0',  -- जलविद्युत र खनिज
  '20aaecbc-7618-444d-bf1d-2f261031b180'   -- पर्यटन र यातायात
);

-- Verify: after this migration, topic 7cd15d4d (now "प्राकृतिक स्रोत र हावापानी")
-- should only have "जलवायु" (f84c8fd5) remaining.
