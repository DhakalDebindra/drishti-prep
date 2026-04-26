-- Phase 3: Seed Current Affairs Curriculum
DO $$
DECLARE
  ca_subject_id uuid;
  t1_id uuid; t2_id uuid; t3_id uuid; t4_id uuid; t5_id uuid;
  t6_id uuid; t7_id uuid; t8_id uuid; t9_id uuid; t10_id uuid;
BEGIN
  -- 1. Rename the GK module
  UPDATE public.modules
  SET name = 'GK for All'
  WHERE slug = 'gk';

  -- 2. Identify the Current Affairs subject
  SELECT id INTO ca_subject_id FROM public.subjects WHERE slug = 'current-affairs' LIMIT 1;

  IF ca_subject_id IS NULL THEN
    RAISE EXCEPTION 'Current Affairs subject not found';
  END IF;

  -- 3. Insert 10 topics under Current Affairs
  -- Topic 1
  INSERT INTO public.topics (subject_id, name, slug, description, display_order)
  VALUES (ca_subject_id, 'राष्ट्रिय समसामयिक', 'national-current-affairs', 'नेपालका राजनीतिक, आर्थिक र सामाजिक हालका घटनाहरू।', 1)
  ON CONFLICT (subject_id, slug) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description, display_order = EXCLUDED.display_order
  RETURNING id INTO t1_id;

  -- Topic 2
  INSERT INTO public.topics (subject_id, name, slug, description, display_order)
  VALUES (ca_subject_id, 'अन्तर्राष्ट्रिय समसामयिक', 'international-current-affairs', 'विश्वका हालका राजनीतिक र कूटनीतिक घटनाहरू।', 2)
  ON CONFLICT (subject_id, slug) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description, display_order = EXCLUDED.display_order
  RETURNING id INTO t2_id;

  -- Topic 3
  INSERT INTO public.topics (subject_id, name, slug, description, display_order)
  VALUES (ca_subject_id, 'पुरस्कार र सम्मान', 'awards-honors', 'राष्ट्रिय र अन्तर्राष्ट्रिय पुरस्कार तथा सम्मानका विवरणहरू।', 3)
  ON CONFLICT (subject_id, slug) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description, display_order = EXCLUDED.display_order
  RETURNING id INTO t3_id;

  -- Topic 4
  INSERT INTO public.topics (subject_id, name, slug, description, display_order)
  VALUES (ca_subject_id, 'खेलकुद', 'sports', 'राष्ट्रिय र अन्तर्राष्ट्रिय खेलकुदका हालका उपलब्धिहरू।', 4)
  ON CONFLICT (subject_id, slug) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description, display_order = EXCLUDED.display_order
  RETURNING id INTO t4_id;

  -- Topic 5
  INSERT INTO public.topics (subject_id, name, slug, description, display_order)
  VALUES (ca_subject_id, 'महत्वपूर्ण व्यक्ति', 'important-persons', 'समसामयिक रूपमा चर्चामा रहेका महत्वपूर्ण व्यक्तित्वहरू।', 5)
  ON CONFLICT (subject_id, slug) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description, display_order = EXCLUDED.display_order
  RETURNING id INTO t5_id;

  -- Topic 6
  INSERT INTO public.topics (subject_id, name, slug, description, display_order)
  VALUES (ca_subject_id, 'दिवस, नारा र संवत्सर', 'days-slogans-anniversaries', 'राष्ट्रिय र अन्तर्राष्ट्रिय दिवसहरू, वार्षिक नारा र संवत्सरहरू।', 6)
  ON CONFLICT (subject_id, slug) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description, display_order = EXCLUDED.display_order
  RETURNING id INTO t6_id;

  -- Topic 7
  INSERT INTO public.topics (subject_id, name, slug, description, display_order)
  VALUES (ca_subject_id, 'पुस्तक, प्रतिवेदन र सूचकाङ्क', 'books-reports-indices', 'हालै प्रकाशित पुस्तक, राष्ट्रिय/अन्तर्राष्ट्रिय प्रतिवेदन र सूचकाङ्कहरू।', 7)
  ON CONFLICT (subject_id, slug) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description, display_order = EXCLUDED.display_order
  RETURNING id INTO t7_id;

  -- Topic 8
  INSERT INTO public.topics (subject_id, name, slug, description, display_order)
  VALUES (ca_subject_id, 'विज्ञान, प्रविधि र वातावरण', 'science-tech-environment', 'समसामयिक विज्ञान, प्रविधि, AI र वातावरण सम्बन्धी घटनाहरू।', 8)
  ON CONFLICT (subject_id, slug) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description, display_order = EXCLUDED.display_order
  RETURNING id INTO t8_id;

  -- Topic 9
  INSERT INTO public.topics (subject_id, name, slug, description, display_order)
  VALUES (ca_subject_id, 'रक्षा र सुरक्षा', 'defense-security', 'राष्ट्रिय सुरक्षा र अन्तर्राष्ट्रिय द्वन्द्व/शान्ति विषयक घटनाहरू।', 9)
  ON CONFLICT (subject_id, slug) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description, display_order = EXCLUDED.display_order
  RETURNING id INTO t9_id;

  -- Topic 10
  INSERT INTO public.topics (subject_id, name, slug, description, display_order)
  VALUES (ca_subject_id, 'स्रोत-आधारित अभ्यास', 'source-based-practice', 'आसमान सर सङ्ग्रह, गोरखापत्र, र अन्य स्रोतमा आधारित मिश्रित अभ्यास।', 10)
  ON CONFLICT (subject_id, slug) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description, display_order = EXCLUDED.display_order
  RETURNING id INTO t10_id;

  -- 4. Insert Subtopics
  -- Topic 1 Subtopics
  INSERT INTO public.subtopics (topic_id, name, slug, description, display_order) VALUES
  (t1_id, 'राजनीति र शासन', 'politics-governance', 'संसद, चुनाव र संवैधानिक मामिलाका हालका घटनाहरू।', 1),
  (t1_id, 'नियुक्ति र पदाधिकारी', 'appointments-officials', 'हालैका सरकारी, संवैधानिक र कूटनीतिक नियुक्तिहरू।', 2),
  (t1_id, 'सरकारी नीति, बजेट र योजना', 'policy-budget-planning', 'नयाँ बजेट, सरकारी नीति र विकास योजना सम्बन्धी जानकारी।', 3),
  (t1_id, 'आर्थिक सूचक र विकास', 'economic-indicators', 'जीडिपी, मुद्रास्फीति र राष्ट्रिय गौरवका आयोजनाको अवस्था।', 4),
  (t1_id, 'राष्ट्रिय घटना र दुर्घटना', 'national-events-incidents', 'देशभित्र भएका ठूला प्राकृतिक वा मानव-सिर्जित घटनाहरू।', 5)
  ON CONFLICT (topic_id, slug) DO NOTHING;

  -- Topic 2 Subtopics
  INSERT INTO public.subtopics (topic_id, name, slug, description, display_order) VALUES
  (t2_id, 'विश्व राजनीति', 'world-politics', 'अन्य देशका चुनाव, सत्ता परिवर्तन र राजनीतिक उतारचढाव।', 1),
  (t2_id, 'अन्तर्राष्ट्रिय संगठन', 'intl-organizations', 'UN, SAARC, EU जस्ता संगठनका हालका गतिविधिहरू।', 2),
  (t2_id, 'सम्मेलन र शिखर बैठक', 'summits-conferences', 'अन्तर्राष्ट्रिय स्तरमा भएका ठूला बैठक र निर्णयहरू।', 3),
  (t2_id, 'द्विपक्षीय सम्बन्ध', 'bilateral-relations', 'नेपालको अन्य देशसँगको सम्बन्ध र वैदेशिक भ्रमणहरू।', 4)
  ON CONFLICT (topic_id, slug) DO NOTHING;

  -- Topic 3 Subtopics
  INSERT INTO public.subtopics (topic_id, name, slug, description, display_order) VALUES
  (t3_id, 'अन्तर्राष्ट्रिय पुरस्कार', 'intl-awards', 'नोबेल, ओस्कार, म्यागासेसे जस्ता विश्वस्तरीय पुरस्कारहरू।', 1),
  (t3_id, 'राष्ट्रिय पुरस्कार र विभूषण', 'national-awards', 'मदन पुरस्कार र नेपाल सरकारले प्रदान गर्ने मानपदवीहरू।', 2),
  (t3_id, 'खेलकुद पुरस्कार', 'sports-awards', 'ब्यालोन डी ओर र राष्ट्रिय खेलकुद सम्मानहरू।', 3)
  ON CONFLICT (topic_id, slug) DO NOTHING;

  -- Topic 4 Subtopics
  INSERT INTO public.subtopics (topic_id, name, slug, description, display_order) VALUES
  (t4_id, 'क्रिकेट', 'cricket', 'नेपाली र अन्तर्राष्ट्रिय क्रिकेटका पछिल्लो खेल र रेकर्ड।', 1),
  (t4_id, 'फुटबल', 'football', 'विश्वकप, युरोकप र लिग फुटबलका ताजा नतिजाहरू।', 2),
  (t4_id, 'ओलम्पिक र एसियाली खेल', 'olympics-asian-games', 'ओलम्पिक र एसियाली खेलका प्रमुख पदक र घटनाहरू।', 3),
  (t4_id, 'अन्य खेल', 'other-sports', 'टेनिस, भलिबल र अन्य खेलकुदका महत्वपूर्ण जानकारी।', 4)
  ON CONFLICT (topic_id, slug) DO NOTHING;

  -- Topic 5 Subtopics
  INSERT INTO public.subtopics (topic_id, name, slug, description, display_order) VALUES
  (t5_id, 'राष्ट्राध्यक्ष र राजनेता', 'heads-of-state', 'विभिन्न देशका राष्ट्रपति र प्रधानमन्त्रीहरूको जानकारी।', 1),
  (t5_id, 'नियुक्त पदाधिकारी', 'appointed-officials', 'हालै नियुक्त भएका प्रमुख व्यक्ति र पदाधिकारीहरू।', 2),
  (t5_id, 'खेलाडी, कलाकार, साहित्यकार', 'athletes-artists-writers', 'चर्चामा रहेका खेलाडी, कलाकार र स्रष्टाहरूको विवरण।', 3),
  (t5_id, 'हालै निधन भएका व्यक्तित्व', 'recent-obituaries', 'हालै मृत्यु भएका महत्वपूर्ण राष्ट्रिय र अन्तर्राष्ट्रिय व्यक्तित्व।', 4)
  ON CONFLICT (topic_id, slug) DO NOTHING;

  -- Topic 6 Subtopics
  INSERT INTO public.subtopics (topic_id, name, slug, description, display_order) VALUES
  (t6_id, 'राष्ट्रिय दिवसहरू', 'national-days', 'नेपालमा मनाइने प्रमुख दिवस र तिनका कार्यक्रम।', 1),
  (t6_id, 'अन्तर्राष्ट्रिय दिवसहरू', 'intl-days', 'विश्वभर मनाइने संयुक्त राष्ट्रसंघीय र अन्य दिवसहरू।', 2),
  (t6_id, 'वार्षिक नाराहरू', 'annual-slogans', 'विभिन्न दिवसका लागि तय गरिएका मुख्य नाराहरू।', 3),
  (t6_id, 'ऐतिहासिक संवत्सर', 'historical-anniversaries', 'प्रमुख ऐतिहासिक घटनाका वार्षिकोत्सव र जयन्तीहरू।', 4)
  ON CONFLICT (topic_id, slug) DO NOTHING;

  -- Topic 7 Subtopics
  INSERT INTO public.subtopics (topic_id, name, slug, description, display_order) VALUES
  (t7_id, 'हालै प्रकाशित पुस्तक र लेखक', 'recent-books', 'बजारमा आएका नयाँ पुस्तक र तिनका लेखकको जानकारी।', 1),
  (t7_id, 'अन्तर्राष्ट्रिय सूचकाङ्क', 'intl-indices', 'भ्रष्टाचार, खुसी र विकास सम्बन्धी विश्वव्यापी सूची।', 2),
  (t7_id, 'राष्ट्रिय प्रतिवेदन', 'national-reports', 'जनगणना र आर्थिक सर्वेक्षण जस्ता सरकारी प्रतिवेदनहरू।', 3)
  ON CONFLICT (topic_id, slug) DO NOTHING;

  -- Topic 8 Subtopics
  INSERT INTO public.subtopics (topic_id, name, slug, description, display_order) VALUES
  (t8_id, 'अन्तरिक्ष र विज्ञान', 'space-science', 'अन्तरिक्ष मिशन, नयाँ ग्रह र वैज्ञानिक खोजहरूको विवरण।', 1),
  (t8_id, 'प्रविधि र AI', 'tech-ai', 'नयाँ ग्याजेट, सफ्टवेयर र कृत्रिम बौद्धिकताका प्रगति।', 2),
  (t8_id, 'जलवायु र वातावरण', 'climate-environment', 'ग्लोबल वार्मिङ, कोप सम्मेलन र संरक्षणका प्रयासहरू।', 3)
  ON CONFLICT (topic_id, slug) DO NOTHING;

  -- Topic 9 Subtopics
  INSERT INTO public.subtopics (topic_id, name, slug, description, display_order) VALUES
  (t9_id, 'राष्ट्रिय सुरक्षा', 'defense-security', 'नेपाली सेना, प्रहरी र सीमा सुरक्षा सम्बन्धी गतिविधि।', 1),
  (t9_id, 'अन्तर्राष्ट्रिय द्वन्द्व र शान्ति', 'intl-conflict-peace', 'विश्वका युद्ध, विद्रोही गतिविधि र शान्ति स्थापनाका प्रयास।', 2)
  ON CONFLICT (topic_id, slug) DO NOTHING;

  -- Topic 10 Subtopics
  INSERT INTO public.subtopics (topic_id, name, slug, description, display_order) VALUES
  (t10_id, 'आसमान सर सङ्ग्रह', 'aasman-collection', 'आसमान उपाध्याय सरका वार्षिक समसामयिक सङ्ग्रह।', 1),
  (t10_id, 'गोरखापत्र साप्ताहिक', 'gorkhapatra', 'गोरखापत्रमा प्रकाशित लोकसेवा सामग्री र समसामयिक।', 2),
  (t10_id, 'लोकसेवा प्रकाशन', 'psc-publications', 'लोकसेवा आयोगका सूचना र आधिकारिक प्रकाशनका प्रश्न।', 3),
  (t10_id, 'दैनिक समाचार सङ्कलन', 'daily-news-digest', 'प्रमुख दैनिक पत्रिकाबाट छानिएका समसामयिक प्रश्नहरू।', 4)
  ON CONFLICT (topic_id, slug) DO NOTHING;

END $$;
