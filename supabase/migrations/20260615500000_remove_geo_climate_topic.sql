-- Remove topic 1.3.2 प्राकृतिक स्रोत र हावापानी from Nepal Geography (1.3).
-- The new Nepal-Geography-only design treats natural-resources/climate as out of
-- scope for this subject. The one real set under it ("हावापानी, ऋतु र संरक्षित
-- क्षेत्रहरू", 10 verified Qs) is relocated to 1.9 Ecosystem & Environment rather
-- than deleted. Remaining geography topics are renumbered to stay sequential.

-- 1) Relocate the climate set to 1.9 → संरक्षित क्षेत्र → राष्ट्रिय निकुञ्ज र आरक्ष.
UPDATE public.question_sets
   SET topic_id    = '13da78f9-bafa-4677-9b47-5d531bf2d8dd',  -- संरक्षित क्षेत्र
       subtopic_id = 'f7a1d745-f125-4081-a706-c70ba952d647'   -- राष्ट्रिय निकुञ्ज र आरक्ष
 WHERE id = 'ef26dc6a-04cd-483e-b59a-c2774478de12';

-- Keep the cross-module junction row pointing at the set's new subtopic (module unchanged = gk).
UPDATE public.question_set_modules
   SET subtopic_id = 'f7a1d745-f125-4081-a706-c70ba952d647'
 WHERE question_set_id = 'ef26dc6a-04cd-483e-b59a-c2774478de12'
   AND subtopic_id     = 'f84c8fd5-e2d0-4a95-acef-44c8777e90c9';

-- 2) Delete the now-empty जलवायु subtopic.
DELETE FROM public.subtopics
 WHERE id = 'f84c8fd5-e2d0-4a95-acef-44c8777e90c9';

-- 3) Delete the now-empty topic 1.3.2 प्राकृतिक स्रोत र हावापानी.
DELETE FROM public.topics
 WHERE id = '7cd15d4d-4625-4f4b-883c-965472919a9c';

-- 4) Renumber the surviving Nepal Geography topics to close the 1.3.2 gap.
UPDATE public.topics
   SET syllabus_ref = '1.3.2', display_order = 2
 WHERE id = '93074e74-e812-4094-8a5b-c27cac7ac4d7';  -- प्रशासनिक विभाजन (was 1.3.3)

UPDATE public.topics
   SET syllabus_ref = '1.3.3', display_order = 3
 WHERE id = '3695b0a9-e95e-45d6-b3f8-70a3f096ebc9';  -- विशेष भौगोलिक तथ्य (was 1.3.4)
