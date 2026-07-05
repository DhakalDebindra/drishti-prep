-- Everything GK v2 — Phase 1a (1/3): subject spine — rename + renumber
-- Renames subjects to v2 names and renumbers the 3 shifted subjects so the new
-- subjects (1.9 Computer, 1.13 Static GK) can slot in. NO sets touched, NO subtopics moved.
-- Idempotent / re-runnable.
--
-- subjects.syllabus_ref is UNIQUE (global). Renumber must vacate 1.11 -> then 1.10 -> then 1.9,
-- so the order of the three renumber UPDATEs below is load-bearing.
--   Current Affairs   1.11 -> 1.14   (1.14 is free)
--   Intl Relations    1.10 -> 1.11   (freed by the line above)
--   Environment       1.9  -> 1.10   (freed by the line above)  ... leaving 1.9 free for Computer

-- ── Renumber (order matters) ──────────────────────────────────────────────
UPDATE public.subjects SET syllabus_ref = '1.14', display_order = 14,
       name = 'Current Affairs', name_np = 'समसामयिक घटनाक्रम'
 WHERE id = 'a2a04965-3137-4ee2-aea3-e3b8b41a7047';   -- was 1.11 समसामयिक घटना

UPDATE public.subjects SET syllabus_ref = '1.11', display_order = 11,
       name = 'International Relations and Organizations', name_np = 'अन्तर्राष्ट्रिय सम्बन्ध तथा संघसंस्था'
 WHERE id = '670d2893-73eb-4ae8-9701-56053a339dbe';   -- was 1.10 अन्तर्राष्ट्रिय सम्बन्ध

UPDATE public.subjects SET syllabus_ref = '1.10', display_order = 10,
       name = 'Environment and Sustainability', name_np = 'पर्यावरण, पारिस्थितिकी र दिगो विकास'
 WHERE id = '413f591e-8da9-4df6-ab6b-c16551778587';   -- was 1.9 पारिस्थितिक पद्धति र वातावरण

-- ── Rename remaining subjects to v2 names (refs unchanged) ─────────────────
UPDATE public.subjects SET name = 'Universe and Astronomy', name_np = 'ब्रह्माण्ड र खगोल'
 WHERE id = '348eb779-c34f-4752-a9ad-2c03b89f21d8';   -- 1.1

UPDATE public.subjects SET name = 'Society, Culture and Heritage', name_np = 'नेपालको समाज, संस्कृति र सम्पदा'
 WHERE id = 'd34079d5-e8f2-4b9a-84df-452efb1c9a79';   -- 1.6

UPDATE public.subjects SET name = 'Economy and Finance', name_np = 'नेपालको अर्थतन्त्र र वित्त'
 WHERE id = '1e8b0175-27f2-4038-a66e-cdf14397c489';   -- 1.7

UPDATE public.subjects SET name = 'Constitution, Governance and Public Administration',
       name_np = 'संविधान, शासन प्रणाली र सार्वजनिक प्रशासन'
 WHERE id = '38c59885-e272-474f-8798-be7e5dfae798';   -- 1.12

-- ── Renumber topic syllabus_refs under the 3 shifted subjects ──────────────
-- (topics.syllabus_ref is UNIQUE per subject; prefix-swap is safe. LIKE guard = idempotent.)
UPDATE public.topics SET syllabus_ref = '1.14' || substring(syllabus_ref FROM 5)
 WHERE subject_id = 'a2a04965-3137-4ee2-aea3-e3b8b41a7047' AND syllabus_ref LIKE '1.11.%';

UPDATE public.topics SET syllabus_ref = '1.11' || substring(syllabus_ref FROM 5)
 WHERE subject_id = '670d2893-73eb-4ae8-9701-56053a339dbe' AND syllabus_ref LIKE '1.10.%';

UPDATE public.topics SET syllabus_ref = '1.10' || substring(syllabus_ref FROM 4)
 WHERE subject_id = '413f591e-8da9-4df6-ab6b-c16551778587' AND syllabus_ref LIKE '1.9.%';
