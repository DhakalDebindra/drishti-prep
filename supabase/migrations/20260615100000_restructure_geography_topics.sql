-- Restructure Nepal Geography (1.3) topics and subtopics
-- 1. Fix syllabus_ref on subject (currently NULL)
-- 2. Rename topics to approved Nepali keyword slugs + fix display_order
-- 3. Rename all 15 subtopics from English to Nepali
-- 4. Repurpose old "आर्थिक तथा वातावरणीय भूगोल" topic → "प्राकृतिक स्रोत र हावापानी" (1.3.2)
--    and swap its display_order with प्रशासनिक (so order is: धरातल / स्रोत / प्रशासन / विशेष)

-- Subject
UPDATE public.subjects
SET syllabus_ref = '1.3'
WHERE id = '95cfe064-d398-4df2-9e26-a871c9014aef';

-- Topic 1: भौतिक भूगोल → धरातलीय स्वरूप (stays ord=1)
UPDATE public.topics
SET name = 'धरातलीय स्वरूप', syllabus_ref = '1.3.1', display_order = 1
WHERE id = '9f33ca46-2fc5-48a2-aeac-5aae8832b050';

-- Topic 3 (was आर्थिक तथा वातावरणीय भूगोल) → प्राकृतिक स्रोत र हावापानी (becomes ord=2)
UPDATE public.topics
SET name = 'प्राकृतिक स्रोत र हावापानी', syllabus_ref = '1.3.2', display_order = 2
WHERE id = '7cd15d4d-4625-4f4b-883c-965472919a9c';

-- Topic 2 (was प्रशासनिक तथा जनसांख्यिक भूगोल) → प्रशासनिक विभाजन (becomes ord=3)
UPDATE public.topics
SET name = 'प्रशासनिक विभाजन', syllabus_ref = '1.3.3', display_order = 3
WHERE id = '93074e74-e812-4094-8a5b-c27cac7ac4d7';

-- Topic 4: विशेष भौगोलिक तथ्य (stays ord=4)
UPDATE public.topics
SET syllabus_ref = '1.3.4', display_order = 4
WHERE id = '3695b0a9-e95e-45d6-b3f8-70a3f096ebc9';

-- Subtopics: rename from English to Nepali (Topic 1 — धरातलीय स्वरूप)
UPDATE public.subtopics SET name = 'अवस्थिति र सीमा'     WHERE id = 'fcc83c91-4a38-47f2-8104-cd68312cf3c3';
UPDATE public.subtopics SET name = 'भू-आकृति'            WHERE id = '9d73c3cc-38a3-431a-9c60-de5bfa269711';
UPDATE public.subtopics SET name = 'हिमाल'               WHERE id = '48352a2e-1802-4418-9a0f-46becc4f93a3';
UPDATE public.subtopics SET name = 'नदी'                 WHERE id = 'a904d4de-3768-4496-ab53-0895dee65679';
UPDATE public.subtopics SET name = 'ताल'                 WHERE id = '3c98ad41-8fbf-4d4f-bb24-fe3d59396acd';

-- Subtopics: rename (Topic 2 → now ord=3, प्रशासनिक विभाजन)
UPDATE public.subtopics SET name = 'प्रदेश र जिल्ला'     WHERE id = '00c2a4ec-1723-48b1-8fa6-07baaa19824b';
UPDATE public.subtopics SET name = 'स्थानीय तह'          WHERE id = '360abb5b-72e0-42a5-aa76-9b1f09d023ca';
UPDATE public.subtopics SET name = 'जनसंख्या र जनगणना'   WHERE id = 'eb1c5b79-5cad-487f-b2ea-711db97bffd2';
UPDATE public.subtopics SET name = 'जातजाति र भाषा'      WHERE id = 'e221309c-877f-48a2-b703-935e9d8b7c43';

-- Subtopics: rename (Topic 3 → now ord=2, प्राकृतिक स्रोत र हावापानी)
-- Economic ones will be moved out in next migration; rename them first for clarity
UPDATE public.subtopics SET name = 'कृषि र वन'            WHERE id = '6d69614c-5e83-4c9b-98a6-dcedd4867e03';
UPDATE public.subtopics SET name = 'जलविद्युत र खनिज'    WHERE id = '5ceff9c8-db17-4726-acf2-7edfb7317bf0';
UPDATE public.subtopics SET name = 'पर्यटन र यातायात'    WHERE id = '20aaecbc-7618-444d-bf1d-2f261031b180';
-- Climate stays in geo; rename and keep here
UPDATE public.subtopics SET name = 'जलवायु'               WHERE id = 'f84c8fd5-e2d0-4a95-acef-44c8777e90c9';

-- Subtopics: rename (Topic 4 — विशेष भौगोलिक तथ्य)
UPDATE public.subtopics SET name = 'उच्चतम, न्यूनतम, लामो र छोटो' WHERE id = '39619e4b-ed5e-46a8-bea3-47ab87f417fc';
UPDATE public.subtopics SET name = 'पहिलो, अन्तिम र विविध तथ्य'   WHERE id = '11307cdf-5cb1-47ed-9e7b-4dfe9c4725a4';
