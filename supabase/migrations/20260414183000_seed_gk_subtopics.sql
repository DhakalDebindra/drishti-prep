-- Migration: Seed full GK syllabus subtopics (topics)
DO $$
DECLARE
  s1_1 uuid; s1_2 uuid; s1_3 uuid; s1_4 uuid; s1_5 uuid;
  s1_6 uuid; s1_7 uuid; s1_8 uuid; s1_9 uuid; s1_10 uuid; s1_11 uuid;
BEGIN
  -- Fetch Subject IDs based on syllabus_ref
  SELECT id INTO s1_1 FROM public.subjects WHERE syllabus_ref = '1.1';
  SELECT id INTO s1_2 FROM public.subjects WHERE syllabus_ref = '1.2';
  SELECT id INTO s1_3 FROM public.subjects WHERE syllabus_ref = '1.3';
  SELECT id INTO s1_4 FROM public.subjects WHERE syllabus_ref = '1.4';
  SELECT id INTO s1_5 FROM public.subjects WHERE syllabus_ref = '1.5';
  SELECT id INTO s1_6 FROM public.subjects WHERE syllabus_ref = '1.6';
  SELECT id INTO s1_7 FROM public.subjects WHERE syllabus_ref = '1.7';
  SELECT id INTO s1_8 FROM public.subjects WHERE syllabus_ref = '1.8';
  SELECT id INTO s1_9 FROM public.subjects WHERE syllabus_ref = '1.9';
  SELECT id INTO s1_10 FROM public.subjects WHERE syllabus_ref = '1.10';
  SELECT id INTO s1_11 FROM public.subjects WHERE syllabus_ref = '1.11';

  -- 1.1 Universe
  INSERT INTO public.topics (subject_id, name, syllabus_ref, display_order) VALUES
  (s1_1, 'सौर्यमण्डल (सूर्य, ग्रह, उपग्रह, शिशुग्रह, उल्का, पुच्छ्रेतारा)', '1.1.1', 1),
  (s1_1, 'पृथ्वी (परिचय, उत्पत्ति र गति)', '1.1.2', 2)
  ON CONFLICT (subject_id, name) DO NOTHING;

  -- 1.2 World Geography (Logical splits for better UX)
  INSERT INTO public.topics (subject_id, name, syllabus_ref, display_order) VALUES
  (s1_2, 'महादेश र महासागर', '1.2.1', 1),
  (s1_2, 'ध्रुव, अक्षांश, देशान्तर, समय र दूरी', '1.2.2', 2),
  (s1_2, 'पर्वतश्रृंखला, मरुभूमि, भूकम्प र ज्वालामुखी', '1.2.3', 3),
  (s1_2, 'नदी, हिमनदी, ताल र हिमताल', '1.2.4', 4),
  (s1_2, 'जलवायु, व्यापारिक वायू र मनसुन', '1.2.5', 5)
  ON CONFLICT (subject_id, name) DO NOTHING;

  -- 1.3 Nepal Geography
  INSERT INTO public.topics (subject_id, name, syllabus_ref, display_order) VALUES
  (s1_3, 'धरातलीय स्वरुपको किसिम र विशेषताहरु', '1.3.1', 1),
  (s1_3, 'प्राकृतिक स्रोतहरु (किसिम, उपलब्धि र वर्तमान अवस्था)', '1.3.2', 2),
  (s1_3, 'भौगोलिक विविधता र जनजीवन', '1.3.3', 3),
  (s1_3, 'नेपालमा पाईने हावापानीको किसिम र विशेषता', '1.3.4', 4),
  (s1_3, 'गण्डकी प्रदेशमा आर्थिक तथा सामाजिक क्रियाकलाप', '1.3.5', 5)
  ON CONFLICT (subject_id, name) DO NOTHING;

  -- 1.4 World History
  INSERT INTO public.topics (subject_id, name, syllabus_ref, display_order) VALUES
  (s1_4, 'प्रमुख विश्व घटनाक्रम (म्याग्नाकार्टादेखि अमेरिकी स्वतन्त्रतासम्म)', '1.4.1', 1),
  (s1_4, 'विश्वका प्रमुख क्रान्तिहरु (औद्योगिक, फ्रान्स, रुसी)', '1.4.2', 2),
  (s1_4, 'प्रथम र द्वितीय विश्वयुद्ध तथा भारतीय स्वतन्त्रता सङ्ग्राम', '1.4.3', 3)
  ON CONFLICT (subject_id, name) DO NOTHING;

  -- 1.5 Nepal History
  INSERT INTO public.topics (subject_id, name, syllabus_ref, display_order) VALUES
  (s1_5, 'किराँतकाल, लिच्छविकाल र मध्यकाल', '1.5.1', 1),
  (s1_5, 'आधुनिक इतिहास र प्रमुख राजनीतिक घटनाक्रम', '1.5.2', 2)
  ON CONFLICT (subject_id, name) DO NOTHING;

  -- 1.6 Social & Cultural
  INSERT INTO public.topics (subject_id, name, syllabus_ref, display_order) VALUES
  (s1_6, 'प्रथा, परम्परा, धर्म र जातजाति', '1.6.1', 1),
  (s1_6, 'कला, साहित्य, संगीत र सांस्कृतिक सम्पदा', '1.6.2', 2),
  (s1_6, 'गण्डकी प्रदेशका विशेष प्रथा र संस्कृति', '1.6.3', 3)
  ON CONFLICT (subject_id, name) DO NOTHING;

  -- 1.7 Nepal Economy
  INSERT INTO public.topics (subject_id, name, syllabus_ref, display_order) VALUES
  (s1_7, 'विकासका पूर्वाधारहरु (कृषि, उद्योग, पर्यटन, आदि)', '1.7.1', 1),
  (s1_7, 'नेपालको विकास योजना', '1.7.2', 2)
  ON CONFLICT (subject_id, name) DO NOTHING;

  -- 1.8 Science, Tech & Health
  INSERT INTO public.topics (subject_id, name, syllabus_ref, display_order) VALUES
  (s1_8, 'विज्ञान प्रविधिको प्रभाव र सूचना सञ्चार प्रविधि', '1.8.1', 1),
  (s1_8, 'जैविक प्रविधि र वैकल्पिक उर्जा', '1.8.2', 2),
  (s1_8, 'वंशाणु, स्वास्थ्य, रोग र खोप', '1.8.3', 3),
  (s1_8, 'दैनिक जीवनमा प्रयोग हुने वस्तुहरु', '1.8.4', 4)
  ON CONFLICT (subject_id, name) DO NOTHING;

  -- 1.9 Ecosystem & Environment
  INSERT INTO public.topics (subject_id, name, syllabus_ref, display_order) VALUES
  (s1_9, 'पारिस्थितिक पद्धतिको परिचय र प्रकार', '1.9.1', 1),
  (s1_9, 'दिगो विकास, जलवायु परिवर्तन र वातावरण प्रदुषण', '1.9.2', 2)
  ON CONFLICT (subject_id, name) DO NOTHING;

  -- 1.10 International Relations
  INSERT INTO public.topics (subject_id, name, syllabus_ref, display_order) VALUES
  (s1_10, 'नेपालका छिमेकी देशहरु र प्रमुख शक्ति राष्ट्रसँगको सम्बन्ध', '1.10.1', 1),
  (s1_10, 'संयुक्त राष्ट्रसंघ (अङ्ग र गतिविधिहरु)', '1.10.2', 2),
  (s1_10, 'क्षेत्रीय संगठनहरु (सार्क, बिमस्टेक, आसियान, EU)', '1.10.3', 3)
  ON CONFLICT (subject_id, name) DO NOTHING;

  -- 1.11 Current Affairs
  INSERT INTO public.topics (subject_id, name, syllabus_ref, display_order) VALUES
  (s1_11, 'समसामयिक घटना तथा नविनतम गतिविधिहरु', '1.11.1', 1),
  (s1_11, 'महत्वपूर्ण व्यक्तित्व तथा विचारकहरु', '1.11.2', 2)
  ON CONFLICT (subject_id, name) DO NOTHING;

END $$;
