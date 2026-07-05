-- Everything GK v2 — Phase 1a (3/3): new subject 1.13 — विविध तथा स्थिर सामान्य ज्ञान (Static & Misc GK)
-- Brand-new subject + 5 topics + 13 subtopics. Purely additive. Idempotent.
-- NOTE: topic refs 1.13.5 (खेलकुद) and 1.13.6 (पुरस्कार) are RESERVED — they arrive in Phase 2 by
-- re-homing the existing (0-set) Current Affairs खेलकुद/पुरस्कार topic, so they are NOT created here.

-- Subject 1.13
INSERT INTO public.subjects (id, module_id, name, name_np, slug, syllabus_ref, display_order) VALUES
  ('b1c00013-0000-4000-8000-000000000013',
   (SELECT id FROM public.modules WHERE slug = 'gk'),
   'Static and Miscellaneous GK', 'विविध तथा स्थिर सामान्य ज्ञान', 'static-misc-gk', '1.13', 13)
ON CONFLICT (id) DO NOTHING;

-- Topics (5 of 7; 1.13.5/1.13.6 reserved for Phase 2)
INSERT INTO public.topics (id, subject_id, name, slug, syllabus_ref, display_order) VALUES
  ('b1c00013-0001-4000-8000-000000000001', 'b1c00013-0000-4000-8000-000000000013', 'विश्व परिचय',              'static-world-intro',  '1.13.1', 1),
  ('b1c00013-0002-4000-8000-000000000002', 'b1c00013-0000-4000-8000-000000000013', 'महत्वपूर्ण दिवस र वर्ष',   'static-days-years',   '1.13.2', 2),
  ('b1c00013-0003-4000-8000-000000000003', 'b1c00013-0000-4000-8000-000000000013', 'पुस्तक, लेखक र नारा',      'static-books-authors','1.13.3', 3),
  ('b1c00013-0004-4000-8000-000000000004', 'b1c00013-0000-4000-8000-000000000013', 'कीर्तिमान, पहिलो र ठूलो',  'static-records-firsts','1.13.4', 4),
  ('b1c00013-0007-4000-8000-000000000007', 'b1c00013-0000-4000-8000-000000000013', 'राष्ट्रिय परिचय',          'static-national-id',  '1.13.7', 7)
ON CONFLICT (id) DO NOTHING;

-- Subtopics
INSERT INTO public.subtopics (topic_id, name, slug, display_order) VALUES
  ('b1c00013-0001-4000-8000-000000000001', 'देश, राजधानी, मुद्रा र भाषा',   'static-country-capital-currency', 1),
  ('b1c00013-0001-4000-8000-000000000001', 'राष्ट्रिय झण्डा र प्रतीक',       'static-flags-symbols',            2),
  ('b1c00013-0001-4000-8000-000000000001', 'प्रसिद्ध भौगोलिक उपनाम',         'static-geographic-nicknames',     3),
  ('b1c00013-0002-4000-8000-000000000002', 'राष्ट्रिय दिवस',                 'static-national-days',            1),
  ('b1c00013-0002-4000-8000-000000000002', 'अन्तर्राष्ट्रिय दिवस',           'static-international-days',        2),
  ('b1c00013-0002-4000-8000-000000000002', 'महत्वपूर्ण वर्ष र दशक',          'static-important-years',          3),
  ('b1c00013-0003-4000-8000-000000000003', 'प्रसिद्ध पुस्तक र लेखक',         'static-famous-books',             1),
  ('b1c00013-0003-4000-8000-000000000003', 'प्रसिद्ध नारा र भनाइ',           'static-slogans-quotes',           2),
  ('b1c00013-0004-4000-8000-000000000004', 'विश्वका पहिलो, ठूलो र सानो',     'static-world-records',            1),
  ('b1c00013-0004-4000-8000-000000000004', 'नेपालका पहिलो व्यक्ति र घटना',   'static-nepal-firsts',             2),
  ('b1c00013-0007-4000-8000-000000000007', 'राष्ट्रिय जनावर, पक्षी र फूल',   'static-national-nature',          1),
  ('b1c00013-0007-4000-8000-000000000007', 'राष्ट्रिय विभूति',               'static-national-luminaries',      2),
  ('b1c00013-0007-4000-8000-000000000007', 'महत्वपूर्ण राष्ट्रिय तथ्य',      'static-national-facts',           3)
ON CONFLICT (topic_id, slug) DO NOTHING;
