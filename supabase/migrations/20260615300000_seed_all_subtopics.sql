-- Seed subtopics for all subjects that are missing them
-- Pattern: PSC/TSC keyword slugs, same style as Nepal Geography subtopics
-- Covers: 1.1, 1.2, 1.4, 1.5, 1.6 (gaps), 1.7 (gaps), 1.8, 1.9, 1.10, 1.12
-- 1.3 and 1.11 already have subtopics — skipped

-- ============================================================
-- 1.1 ब्रह्माण्ड
-- ============================================================

-- 1.1.1 सौर्यमण्डल (e4669424)
INSERT INTO public.subtopics (topic_id, name, slug, display_order) VALUES
  ('e4669424-e6ea-4432-b9de-9906631758c6', 'सूर्य र ग्रह',                 'universe-sun-planets',        1),
  ('e4669424-e6ea-4432-b9de-9906631758c6', 'उपग्रह, क्षुद्रग्रह र धूमकेतु', 'universe-satellites-asteroids', 2),
  ('e4669424-e6ea-4432-b9de-9906631758c6', 'तारा र नक्षत्र',                 'universe-stars-constellations', 3);

-- 1.1.2 पृथ्वीको संरचना र गति (091645c1)
INSERT INTO public.subtopics (topic_id, name, slug, display_order) VALUES
  ('091645c1-4826-4980-87d2-6dbdcf7875b0', 'पृथ्वीको आन्तरिक संरचना',   'earth-internal-structure', 1),
  ('091645c1-4826-4980-87d2-6dbdcf7875b0', 'पृथ्वीको गति र ऋतु',         'earth-motion-seasons',     2),
  ('091645c1-4826-4980-87d2-6dbdcf7875b0', 'समय क्षेत्र र तिथिरेखा',     'earth-timezones-dateline', 3);

-- ============================================================
-- 1.2 विश्वको भूगोल
-- ============================================================

-- 1.2.1 महादेश र महासागर (722f6f4a)
INSERT INTO public.subtopics (topic_id, name, slug, display_order) VALUES
  ('722f6f4a-3a07-4d40-8074-5a6081421e2b', 'सात महादेश',     'world-geo-continents', 1),
  ('722f6f4a-3a07-4d40-8074-5a6081421e2b', 'पाँच महासागर',   'world-geo-oceans',     2);

-- 1.2.2 अक्षांश, देशान्तर र समय (6fbb8c52)
INSERT INTO public.subtopics (topic_id, name, slug, display_order) VALUES
  ('6fbb8c52-1991-4718-b7f9-437400e6a1a1', 'अक्षांश र देशान्तर', 'world-geo-latitude-longitude', 1),
  ('6fbb8c52-1991-4718-b7f9-437400e6a1a1', 'समय क्षेत्र',         'world-geo-time-zones',         2);

-- 1.2.3 पर्वत, मरुभूमि र प्राकृतिक परिघटना (77fff8bd)
INSERT INTO public.subtopics (topic_id, name, slug, display_order) VALUES
  ('77fff8bd-42f5-4c25-84fc-d0ebd77ca503', 'पर्वतश्रृंखला',         'world-geo-mountain-ranges',    1),
  ('77fff8bd-42f5-4c25-84fc-d0ebd77ca503', 'मरुभूमि',                'world-geo-deserts',            2),
  ('77fff8bd-42f5-4c25-84fc-d0ebd77ca503', 'भूकम्प र ज्वालामुखी',   'world-geo-earthquakes-volcano', 3);

-- 1.2.4 नदी, ताल र हिमनदी (fc362243)
INSERT INTO public.subtopics (topic_id, name, slug, display_order) VALUES
  ('fc362243-9e66-45dd-8567-a7d23e55b69a', 'प्रमुख नदी',         'world-geo-rivers',   1),
  ('fc362243-9e66-45dd-8567-a7d23e55b69a', 'प्रमुख ताल र हिमनदी', 'world-geo-lakes',    2);

-- 1.2.5 जलवायु र वायुमण्डल (e95a5c6c)
INSERT INTO public.subtopics (topic_id, name, slug, display_order) VALUES
  ('e95a5c6c-b208-47f2-8967-7013013edcb6', 'जलवायु क्षेत्र र मनसुन', 'world-geo-climate-monsoon',  1),
  ('e95a5c6c-b208-47f2-8967-7013013edcb6', 'वायुमण्डलीय तह',          'world-geo-atmosphere-layers', 2);

-- ============================================================
-- 1.4 विश्वको इतिहास
-- ============================================================

-- 1.4.1 प्रमुख विश्व घटनाक्रम (28f50314)
INSERT INTO public.subtopics (topic_id, name, slug, display_order) VALUES
  ('28f50314-50d3-45f7-8c81-9741b812f589', 'म्याग्नाकार्टा र प्रारम्भिक लोकतन्त्र', 'world-history-magna-carta',  1),
  ('28f50314-50d3-45f7-8c81-9741b812f589', 'अमेरिकी स्वतन्त्रता संग्राम',            'world-history-us-revolution', 2);

-- 1.4.2 विश्व क्रान्ति र आन्दोलन (3d0af756)
INSERT INTO public.subtopics (topic_id, name, slug, display_order) VALUES
  ('3d0af756-8941-473e-ae9a-c738df292e35', 'औद्योगिक क्रान्ति',  'world-history-industrial-revolution', 1),
  ('3d0af756-8941-473e-ae9a-c738df292e35', 'फ्रान्सेली क्रान्ति', 'world-history-french-revolution',     2),
  ('3d0af756-8941-473e-ae9a-c738df292e35', 'रुसी क्रान्ति',       'world-history-russian-revolution',    3);

-- 1.4.3 प्रथम र द्वितीय विश्वयुद्ध (6c7916c4)
INSERT INTO public.subtopics (topic_id, name, slug, display_order) VALUES
  ('6c7916c4-5fa4-4147-b75e-072c9e10a186', 'प्रथम विश्वयुद्ध',            'world-history-ww1',          1),
  ('6c7916c4-5fa4-4147-b75e-072c9e10a186', 'द्वितीय विश्वयुद्ध',          'world-history-ww2',          2),
  ('6c7916c4-5fa4-4147-b75e-072c9e10a186', 'भारतीय स्वतन्त्रता संग्राम', 'world-history-india-freedom', 3);

-- ============================================================
-- 1.5 नेपालको इतिहास
-- ============================================================

-- 1.5.1 प्राचीन र मध्यकाल (4cdada95)
INSERT INTO public.subtopics (topic_id, name, slug, display_order) VALUES
  ('4cdada95-4bd2-4fe6-afaf-e8cc2578af63', 'किरात र लिच्छविकाल', 'nepal-history-kirat-licchavi', 1),
  ('4cdada95-4bd2-4fe6-afaf-e8cc2578af63', 'मल्लकाल',             'nepal-history-malla',          2);

-- 1.5.2 नेपालको एकीकरण र राणाकाल (5eb2ebcf)
INSERT INTO public.subtopics (topic_id, name, slug, display_order) VALUES
  ('5eb2ebcf-f2e0-45a7-b7fd-ee361bfbe2e1', 'पृथ्वीनारायण शाह र एकीकरण', 'nepal-history-unification',  1),
  ('5eb2ebcf-f2e0-45a7-b7fd-ee361bfbe2e1', 'राणाशासन',                    'nepal-history-rana-regime',  2);

-- 1.5.3 २००७ पछिको इतिहास (60d18a83)
INSERT INTO public.subtopics (topic_id, name, slug, display_order) VALUES
  ('60d18a83-ba4d-416b-9bd1-320694297371', 'प्रजातन्त्र स्थापना र पञ्चायत', 'nepal-history-panchayat',    1),
  ('60d18a83-ba4d-416b-9bd1-320694297371', 'बहुदलीय प्रजातन्त्र र द्वन्द्व', 'nepal-history-multiparty',   2),
  ('60d18a83-ba4d-416b-9bd1-320694297371', 'जनआन्दोलन र गणतन्त्र',           'nepal-history-republic',     3);

-- ============================================================
-- 1.6 सामाजिक एवं सांस्कृतिक (fill gaps)
-- ============================================================

-- 1.6.1 जनसंख्या, जातजाति र धर्म (0c2194a0) — already has जनसंख्या र जनगणना, जातजाति र भाषा; add धर्म
INSERT INTO public.subtopics (topic_id, name, slug, display_order) VALUES
  ('0c2194a0-a5c1-47cc-a8bb-b63285fb27f7', 'धर्म र विश्वास', 'social-religion-faith', 5);

-- 1.6.2 संस्कृति र सांस्कृतिक सम्पदा (5f7a0922)
INSERT INTO public.subtopics (topic_id, name, slug, display_order) VALUES
  ('5f7a0922-4dd7-453e-a0b6-a7068404eaa3', 'चाडपर्व र परम्परा',        'social-culture-festivals',  1),
  ('5f7a0922-4dd7-453e-a0b6-a7068404eaa3', 'कला, साहित्य र संगीत',     'social-culture-arts',       2),
  ('5f7a0922-4dd7-453e-a0b6-a7068404eaa3', 'युनेस्को सूचीकृत सम्पदा', 'social-culture-unesco',     3);

-- 1.6.3 सामाजिक समस्या र समावेशिता (0229e2dd)
INSERT INTO public.subtopics (topic_id, name, slug, display_order) VALUES
  ('0229e2dd-e75c-4f49-8cef-bd8fce43e069', 'सामाजिक कुरीति र समस्या', 'social-problems-evils',     1),
  ('0229e2dd-e75c-4f49-8cef-bd8fce43e069', 'लैंगिक समानता र समावेश',  'social-problems-inclusion', 2);

-- 1.6.4 जनसंख्या तथ्याङ्क र जनगणना (a89943a3)
INSERT INTO public.subtopics (topic_id, name, slug, display_order) VALUES
  ('a89943a3-e83d-4351-99e2-ca1f42cbb1a7', 'जनगणना तथ्याङ्क',         'social-demography-census',   1),
  ('a89943a3-e83d-4351-99e2-ca1f42cbb1a7', 'जनसंख्या वृद्धि र वितरण', 'social-demography-growth',   2);

-- ============================================================
-- 1.7 आर्थिक अवस्था (fill gaps only)
-- ============================================================

-- 1.7.1 कृषि, उद्योग र व्यापार (01d23733) — already has कृषि र वन; add more
INSERT INTO public.subtopics (topic_id, name, slug, display_order) VALUES
  ('01d23733-a071-431e-bdd2-c99c7c9b941a', 'उद्योग',               'economy-industry',      2),
  ('01d23733-a071-431e-bdd2-c99c7c9b941a', 'व्यापार र आयात-निर्यात', 'economy-trade-export',  3);

-- 1.7.3 पूर्वाधार र यातायात (ce662166) — currently empty
INSERT INTO public.subtopics (topic_id, name, slug, display_order) VALUES
  ('ce662166-d606-470c-af3a-8173f311e9b3', 'सडक, रेल र हवाई', 'economy-infra-transport', 1),
  ('ce662166-d606-470c-af3a-8173f311e9b3', 'संचार र सिंचाइ',   'economy-infra-comms',     2);

-- 1.7.4 आर्थिक योजना र नीति (575ad5dd) — currently empty
INSERT INTO public.subtopics (topic_id, name, slug, display_order) VALUES
  ('575ad5dd-a45a-412b-836c-52a8a960f6e5', 'आवधिक योजना',             'economy-periodic-plans',   1),
  ('575ad5dd-a45a-412b-836c-52a8a960f6e5', 'बजेट, मुद्रा र विप्रेषण', 'economy-budget-remittance', 2);

-- ============================================================
-- 1.8 विज्ञान, प्रविधि र स्वास्थ्य
-- ============================================================

-- 1.8.1 आविष्कार र प्रविधि (35b7a731)
INSERT INTO public.subtopics (topic_id, name, slug, display_order) VALUES
  ('35b7a731-cc67-486a-9ed3-2c18ec94b27a', 'महत्वपूर्ण आविष्कार र वैज्ञानिक', 'science-inventions',  1),
  ('35b7a731-cc67-486a-9ed3-2c18ec94b27a', 'सूचना-संचार प्रविधि (ICT)',         'science-ict',         2);

-- 1.8.2 जैविक प्रविधि र वैकल्पिक ऊर्जा (6b9d5218)
INSERT INTO public.subtopics (topic_id, name, slug, display_order) VALUES
  ('6b9d5218-4120-46ae-b2da-bad7b1948f6d', 'जैविक प्रविधि',    'science-biotech',         1),
  ('6b9d5218-4120-46ae-b2da-bad7b1948f6d', 'वैकल्पिक ऊर्जा', 'science-renewable-energy', 2);

-- 1.8.3 मानव शरीर र स्वास्थ्य (22efaeb6)
INSERT INTO public.subtopics (topic_id, name, slug, display_order) VALUES
  ('22efaeb6-2703-435d-abbf-fbf345837be7', 'मानव शरीर प्रणाली',     'health-human-body',     1),
  ('22efaeb6-2703-435d-abbf-fbf345837be7', 'रोग, खोप र औषधि',      'health-disease-vaccine', 2),
  ('22efaeb6-2703-435d-abbf-fbf345837be7', 'पोषण र खाद्य सुरक्षा', 'health-nutrition',       3);

-- 1.8.4 दैनिक जीवनको विज्ञान (2b1a846e)
INSERT INTO public.subtopics (topic_id, name, slug, display_order) VALUES
  ('2b1a846e-9027-4392-8d35-f9100dff835e', 'दैनिक उपयोगका पदार्थ',  'science-daily-materials', 1),
  ('2b1a846e-9027-4392-8d35-f9100dff835e', 'सरसफाइ र वातावरण',      'science-hygiene-env',     2);

-- ============================================================
-- 1.9 पारिस्थितिक पद्धति र वातावरण
-- ============================================================

-- 1.9.1 दिगो विकास (c4e89c03)
INSERT INTO public.subtopics (topic_id, name, slug, display_order) VALUES
  ('c4e89c03-8589-4c88-bada-d5f9298eca00', 'दिगो विकासका लक्ष्य (SDGs)', 'eco-sdgs',                1),
  ('c4e89c03-8589-4c88-bada-d5f9298eca00', 'नेपालको दिगो विकास',          'eco-nepal-sustainable',   2);

-- 1.9.2 पारिस्थितिक पद्धति र जैविक विविधता (f423de8a)
INSERT INTO public.subtopics (topic_id, name, slug, display_order) VALUES
  ('f423de8a-c0f7-4567-81f2-96dd0bd327af', 'पारिस्थितिक पद्धतिको प्रकार',    'eco-ecosystem-types',    1),
  ('f423de8a-c0f7-4567-81f2-96dd0bd327af', 'खाद्य श्रृंखला र जैविक विविधता', 'eco-food-chain-biodiv',  2);

-- 1.9.3 संरक्षित क्षेत्र (13da78f9)
INSERT INTO public.subtopics (topic_id, name, slug, display_order) VALUES
  ('13da78f9-bafa-4677-9b47-5d531bf2d8dd', 'राष्ट्रिय निकुञ्ज र आरक्ष',    'eco-protected-areas',        1),
  ('13da78f9-bafa-4677-9b47-5d531bf2d8dd', 'दुर्लभ जीवजन्तु र वनस्पति',    'eco-rare-wildlife',          2),
  ('13da78f9-bafa-4677-9b47-5d531bf2d8dd', 'रामसार सूची',                    'eco-ramsar-sites',           3);

-- 1.9.4 वातावरणीय समस्या (edcada75)
INSERT INTO public.subtopics (topic_id, name, slug, display_order) VALUES
  ('edcada75-e4d9-45bd-9d74-11a4f2f16b15', 'जलवायु परिवर्तन र हरितगृह',   'eco-climate-change',        1),
  ('edcada75-e4d9-45bd-9d74-11a4f2f16b15', 'प्रदूषण र फोहोर व्यवस्थापन',  'eco-pollution-waste',       2);

-- 1.9.5 अन्तर्राष्ट्रिय सन्धि र सम्मेलन (11c21d9c)
INSERT INTO public.subtopics (topic_id, name, slug, display_order) VALUES
  ('11c21d9c-6f76-4847-861b-47e365a75f8f', 'प्रमुख वातावरणीय सन्धि',        'eco-env-treaties',           1),
  ('11c21d9c-6f76-4847-861b-47e365a75f8f', 'अन्तर्राष्ट्रिय संगठन',          'eco-intl-orgs',              2);

-- ============================================================
-- 1.10 अन्तर्राष्ट्रिय सम्बन्ध
-- ============================================================

-- 1.10.1 परराष्ट्र नीति र द्विपक्षीय सम्बन्ध (0caa0a35)
INSERT INTO public.subtopics (topic_id, name, slug, display_order) VALUES
  ('0caa0a35-51c5-40bb-b46f-e97893f9e139', 'परराष्ट्र नीतिका सिद्धान्त',      'intl-foreign-policy',    1),
  ('0caa0a35-51c5-40bb-b46f-e97893f9e139', 'भारत र चीनसँगको सम्बन्ध',         'intl-india-china',       2),
  ('0caa0a35-51c5-40bb-b46f-e97893f9e139', 'अन्य देशसँगको सम्बन्ध',            'intl-other-countries',   3);

-- 1.10.2 संयुक्त राष्ट्रसंघ (285cb410)
INSERT INTO public.subtopics (topic_id, name, slug, display_order) VALUES
  ('285cb410-f80d-4f9f-a32a-b07ba0ad43fd', 'संयुक्त राष्ट्रसंघका अंग',        'intl-un-organs',         1),
  ('285cb410-f80d-4f9f-a32a-b07ba0ad43fd', 'विशिष्टिकृत संस्था',               'intl-un-agencies',       2);

-- 1.10.3 क्षेत्रीय संगठन (d71d3b8b)
INSERT INTO public.subtopics (topic_id, name, slug, display_order) VALUES
  ('d71d3b8b-111e-4260-8de3-f6e471d0561a', 'सार्क र बिमस्टेक',                 'intl-saarc-bimstec',     1),
  ('d71d3b8b-111e-4260-8de3-f6e471d0561a', 'आसियान र युरोपियन संघ',            'intl-asean-eu',          2);

-- ============================================================
-- 1.12 नेपालको संविधान र शासन व्यवस्था
-- ============================================================

-- 1.12.1 संवैधानिक इतिहास (7130b022)
INSERT INTO public.subtopics (topic_id, name, slug, display_order) VALUES
  ('7130b022-4632-4dcf-b8ba-b29725548aec', 'विभिन्न संविधानहरू (२००४–२०७२)', 'const-history-constitutions', 1),
  ('7130b022-4632-4dcf-b8ba-b29725548aec', 'संविधानसभा र संविधान निर्माण',    'const-history-assembly',      2);

-- 1.12.2 संविधानको परिचय र प्रारम्भिक व्यवस्था (26205e7b)
INSERT INTO public.subtopics (topic_id, name, slug, display_order) VALUES
  ('26205e7b-e5de-4d0f-a8cc-cd31d549a623', 'प्रस्तावना',             'const-intro-preamble',  1),
  ('26205e7b-e5de-4d0f-a8cc-cd31d549a623', 'प्रारम्भिक व्यवस्था',   'const-intro-prelim',    2);

-- 1.12.3 नागरिकता सम्बन्धी व्यवस्था (b81803ff)
INSERT INTO public.subtopics (topic_id, name, slug, display_order) VALUES
  ('b81803ff-1bfc-476b-b66c-3b0d87b47169', 'नागरिकताको प्रकार',     'const-citizenship-types',   1),
  ('b81803ff-1bfc-476b-b66c-3b0d87b47169', 'नागरिकता प्राप्ति',     'const-citizenship-acquire', 2);

-- 1.12.4 मौलिक हक र कर्तव्य (cb490683)
INSERT INTO public.subtopics (topic_id, name, slug, display_order) VALUES
  ('cb490683-a1e3-4227-b2b9-bb72da6bdb33', 'मौलिक हक',     'const-fundamental-rights', 1),
  ('cb490683-a1e3-4227-b2b9-bb72da6bdb33', 'नागरिक कर्तव्य', 'const-civic-duties',      2);

-- 1.12.5 निर्देशक सिद्धान्त र राज्य नीति (bda7135a)
INSERT INTO public.subtopics (topic_id, name, slug, display_order) VALUES
  ('bda7135a-9bc1-4f59-89aa-62952bba342e', 'राज्य नीति',    'const-state-policy',       1),
  ('bda7135a-9bc1-4f59-89aa-62952bba342e', 'राज्यका दायित्व', 'const-state-obligations', 2);

-- 1.12.6 राज्य संरचना र शक्ति बाँडफाँड (291aea03)
INSERT INTO public.subtopics (topic_id, name, slug, display_order) VALUES
  ('291aea03-f1a0-44e5-983e-1fa5f2358974', 'संघीय संरचना',    'const-federal-structure', 1),
  ('291aea03-f1a0-44e5-983e-1fa5f2358974', 'शक्ति बाँडफाँड', 'const-power-sharing',      2);

-- 1.12.7 कार्यपालिका (d011e58e)
INSERT INTO public.subtopics (topic_id, name, slug, display_order) VALUES
  ('d011e58e-2b13-487f-874d-3e922d345bed', 'राष्ट्रपति र उपराष्ट्रपति', 'const-exec-president', 1),
  ('d011e58e-2b13-487f-874d-3e922d345bed', 'मन्त्रिपरिषद',               'const-exec-cabinet',   2),
  ('d011e58e-2b13-487f-874d-3e922d345bed', 'प्रादेशिक कार्यपालिका',      'const-exec-province',  3);

-- 1.12.8 व्यवस्थापिका (db7b97b9)
INSERT INTO public.subtopics (topic_id, name, slug, display_order) VALUES
  ('db7b97b9-0702-40cb-a738-d4e9e525509c', 'संघीय संसद',  'const-legis-parliament', 1),
  ('db7b97b9-0702-40cb-a738-d4e9e525509c', 'प्रदेश सभा',  'const-legis-province',   2);

-- 1.12.9 न्यायपालिका (189480ef)
INSERT INTO public.subtopics (topic_id, name, slug, display_order) VALUES
  ('189480ef-1025-446f-b9c3-189ce926d21e', 'सर्वोच्च अदालत', 'const-judiciary-supreme', 1),
  ('189480ef-1025-446f-b9c3-189ce926d21e', 'उच्च अदालत',     'const-judiciary-high',    2);

-- 1.12.10 संवैधानिक निकाय (79659c10)
INSERT INTO public.subtopics (topic_id, name, slug, display_order) VALUES
  ('79659c10-a751-4c00-8cb3-db168964e97f', 'लोक सेवा आयोग',              'const-body-psc',           1),
  ('79659c10-a751-4c00-8cb3-db168964e97f', 'निर्वाचन आयोग',              'const-body-election',      2),
  ('79659c10-a751-4c00-8cb3-db168964e97f', 'अख्तियार दुरुपयोग आयोग',    'const-body-ciaa',          3),
  ('79659c10-a751-4c00-8cb3-db168964e97f', 'महालेखा परीक्षक',            'const-body-auditor',       4),
  ('79659c10-a751-4c00-8cb3-db168964e97f', 'मानव अधिकार आयोग',           'const-body-humanrights',   5);

-- 1.12.11 संवैधानिक विविध तथ्य (f7e9e471)
INSERT INTO public.subtopics (topic_id, name, slug, display_order) VALUES
  ('f7e9e471-5e2c-49fc-8a8d-d2c321bb3228', 'धारा संख्या, भाग र अनुसूची', 'const-misc-articles',   1),
  ('f7e9e471-5e2c-49fc-8a8d-d2c321bb3228', 'महत्वपूर्ण मिति र तथ्य',     'const-misc-dates-facts', 2);
