-- Three structural changes to complete the approved syllabus:
-- 1. Economy 1.7: split 2 topics → 4 (rename + insert 2 new + shuffle subtopics)
-- 2. Social 1.6: add 1.6.3 "सामाजिक समस्या र समावेशिता"
-- 3. Ecosystem 1.9.6: move जनसंख्यांकी topic → Social 1.6 (becomes 1.6.4)

-- ============================================================
-- 1. Economy 1.7 restructure
-- ============================================================

-- 1a. Rename existing 1.7.1 → "कृषि, उद्योग र व्यापार" (keeps कृषि र वन)
UPDATE public.topics
SET name = 'कृषि, उद्योग र व्यापार', slug = 'economy-agriculture-industry-trade'
WHERE id = '01d23733-a071-431e-bdd2-c99c7c9b941a';

-- 1b. Push old 1.7.2 (विकास योजना) to ord=4 so new topics can take ord=2 and ord=3
UPDATE public.topics
SET display_order = 4,
    name          = 'आर्थिक योजना र नीति',
    slug          = 'economy-planning-policy',
    syllabus_ref  = '1.7.4'
WHERE id = '575ad5dd-a45a-412b-836c-52a8a960f6e5';

-- 1c. Insert new 1.7.2 "जलविद्युत, खनिज र पर्यटन"
INSERT INTO public.topics (subject_id, name, slug, syllabus_ref, display_order)
VALUES (
  '1e8b0175-27f2-4038-a66e-cdf14397c489',
  'जलविद्युत, खनिज र पर्यटन',
  'economy-hydropower-minerals-tourism',
  '1.7.2',
  2
);

-- 1d. Insert new 1.7.3 "पूर्वाधार र यातायात"
INSERT INTO public.topics (subject_id, name, slug, syllabus_ref, display_order)
VALUES (
  '1e8b0175-27f2-4038-a66e-cdf14397c489',
  'पूर्वाधार र यातायात',
  'economy-infrastructure-transport',
  '1.7.3',
  3
);

-- 1e. Move जलविद्युत र खनिज + पर्यटन र यातायात subtopics to new 1.7.2
UPDATE public.subtopics
SET topic_id = (SELECT id FROM public.topics WHERE slug = 'economy-hydropower-minerals-tourism')
WHERE id IN (
  '5ceff9c8-db17-4726-acf2-7edfb7317bf0',  -- जलविद्युत र खनिज
  '20aaecbc-7618-444d-bf1d-2f261031b180'   -- पर्यटन र यातायात
);

-- 1f. Update question_sets.topic_id for those subtopics
UPDATE public.question_sets
SET topic_id = (SELECT id FROM public.topics WHERE slug = 'economy-hydropower-minerals-tourism')
WHERE subtopic_id IN (
  '5ceff9c8-db17-4726-acf2-7edfb7317bf0',
  '20aaecbc-7618-444d-bf1d-2f261031b180'
);

-- ============================================================
-- 2. Social 1.6: add missing topic 1.6.3
-- ============================================================
INSERT INTO public.topics (subject_id, name, slug, syllabus_ref, display_order)
VALUES (
  'd34079d5-e8f2-4b9a-84df-452efb1c9a79',
  'सामाजिक समस्या र समावेशिता',
  'social-problems-inclusion',
  '1.6.3',
  3
);

-- ============================================================
-- 3. Move Ecosystem 1.9.6 (जनसंख्यांकी) → Social 1.6 (becomes 1.6.4)
-- ============================================================
UPDATE public.topics
SET subject_id    = 'd34079d5-e8f2-4b9a-84df-452efb1c9a79',
    name          = 'जनसंख्या तथ्याङ्क र जनगणना',
    slug          = 'social-demography-census',
    syllabus_ref  = '1.6.4',
    display_order = 4
WHERE id = 'a89943a3-e83d-4351-99e2-ca1f42cbb1a7';
