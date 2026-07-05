-- Idempotent UPSERT import: निमावि प्रथम पत्र — unit ग-१ कम्प्युटर: इतिहास, पुस्ता र प्रकार (Level I topic-wise set)
-- Override same-identity sets/questions; never deletes. Generated 2026-07-05T05:24:46.926Z.
DO $$
DECLARE
  v_module_id uuid := '6695669a-f40e-421a-a4ec-b09bbeaf56c4'::uuid;
  v_set_id uuid;
  v_q_id uuid;
BEGIN

  -- Set: कम्प्युटरको इतिहास, पुस्ता र प्रकार (आधारभूत तह) (15 Q)
  v_set_id := extensions.uuid_generate_v5('d1c12361-445d-4e7d-b2cc-ccdbcdcea30b'::uuid, E'कम्प्युटरको इतिहास, पुस्ता र प्रकार (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '3550276d-035c-4369-8511-78c34093d306'::uuid, 'd1c12361-445d-4e7d-b2cc-ccdbcdcea30b'::uuid, E'कम्प्युटरको इतिहास, पुस्ता र प्रकार (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'd1c12361-445d-4e7d-b2cc-ccdbcdcea30b'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कम्प्युटरका पिता (Father of Computer) भनेर कसलाई चिनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'कम्प्युटरका पिता (Father of Computer) भनेर कसलाई चिनिन्छ?', E'चार्ल्स ब्याबेज', E'एलन ट्युरिङ', E'बिल गेट्स', E'टिम बर्नर्स ली', E'A', E'**चार्ल्स ब्याबेजलाई कम्प्युटरका पिता मानिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कम्प्युटरका पिता (Father of Computer) भनेर कसलाई चिनिन्छ?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कम्प्युटरको पहिलो पुस्ता (First Generation) मा मुख्य पुर्जाको रूपमा के प्रयोग गरिएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'कम्प्युटरको पहिलो पुस्ता (First Generation) मा मुख्य पुर्जाको रूपमा के प्रयोग गरिएको थियो?', E'ट्रान्जिस्टर', E'भ्याकुम ट्युब', E'इन्टिग्रेटेड सर्किट (IC)', E'माइक्रोप्रोसेसर', E'B', E'**पहिलो पुस्ताको कम्प्युटरमा भ्याकुम ट्युब प्रयोग गरिएको थियो (सन् १९४०-१९५६)।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कम्प्युटरको पहिलो पुस्ता (First Generation) मा मुख्य पुर्जाको रूपमा के प्रयोग गरिएको थियो?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दोस्रो पुस्ताको कम्प्युटरमा भ्याकुम ट्युबको सट्टा के को प्रयोग गरियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'दोस्रो पुस्ताको कम्प्युटरमा भ्याकुम ट्युबको सट्टा के को प्रयोग गरियो?', E'इन्टिग्रेटेड सर्किट', E'माइक्रोप्रोसेसर', E'ट्रान्जिस्टर', E'आर्टिफिसियल इन्टेलिजेन्स', E'C', E'**दोस्रो पुस्ताको कम्प्युटरमा भ्याकुम ट्युबको सट्टा ट्रान्जिस्टरको प्रयोग गरियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दोस्रो पुस्ताको कम्प्युटरमा भ्याकुम ट्युबको सट्टा के को प्रयोग गरियो?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'इन्टिग्रेटेड सर्किट (IC) को प्रयोग कुन पुस्ताको कम्प्युटरबाट सुरु भएको हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'इन्टिग्रेटेड सर्किट (IC) को प्रयोग कुन पुस्ताको कम्प्युटरबाट सुरु भएको हो?', E'दोस्रो पुस्ता', E'चौथो पुस्ता', E'पाँचौं पुस्ता', E'तेस्रो पुस्ता', E'D', E'**तेस्रो पुस्ताको कम्प्युटरबाट इन्टिग्रेटेड सर्किटको प्रयोग सुरु भएको हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:इन्टिग्रेटेड सर्किट (IC) को प्रयोग कुन पुस्ताको कम्प्युटरबाट सुरु भएको हो?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'माइक्रोप्रोसेसरको प्रयोग कुन पुस्ताको कम्प्युटरमा गरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'माइक्रोप्रोसेसरको प्रयोग कुन पुस्ताको कम्प्युटरमा गरिन्छ?', E'चौथो पुस्ता', E'तेस्रो पुस्ता', E'पाँचौं पुस्ता', E'पहिलो पुस्ता', E'A', E'**चौथो पुस्ताको कम्प्युटरमा माइक्रोप्रोसेसरको प्रयोग गरिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:माइक्रोप्रोसेसरको प्रयोग कुन पुस्ताको कम्प्युटरमा गरिन्छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पाँचौं पुस्ताको कम्प्युटर (Fifth Generation Computer) कुन प्रविधिमा आधारित छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'पाँचौं पुस्ताको कम्प्युटर (Fifth Generation Computer) कुन प्रविधिमा आधारित छ?', E'इन्टिग्रेटेड सर्किट', E'कृत्रिम बौद्धिकता (Artificial Intelligence)', E'ट्रान्जिस्टर', E'भ्याकुम ट्युब', E'B', E'**पाँचौं पुस्ताको कम्प्युटर कृत्रिम बौद्धिकता (Artificial Intelligence) मा आधारित छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पाँचौं पुस्ताको कम्प्युटर (Fifth Generation Computer) कुन प्रविधिमा आधारित छ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालमा सर्वप्रथम प्रयोग गरिएको कम्प्युटर कुन मोडेलको थियो, र कुन प्रयोजनका लागि ल्याइएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'नेपालमा सर्वप्रथम प्रयोग गरिएको कम्प्युटर कुन मोडेलको थियो, र कुन प्रयोजनका लागि ल्याइएको थियो?', E'IBM 5100 — वि.सं. २०३२ सालको शिक्षा गणना गर्न', E'IBM 1401 — वि.सं. २०३६ सालको कृषि गणना गर्न', E'IBM 1401 — वि.सं. २०२८ सालको जनगणना तथ्याङ्क प्रशोधन गर्न', E'Apple II — वि.सं. २०३० सालको जनगणना गर्न', E'C', E'**नेपालमा सर्वप्रथम IBM 1401 कम्प्युटर वि.सं. २०२८ सालको जनगणना तथ्याङ्क प्रशोधन गर्नका लागि ल्याइएको थियो।**\\nनोट: यो दोस्रो पुस्ताको कम्प्युटर थियो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालमा सर्वप्रथम प्रयोग गरिएको कम्प्युटर कुन मोडेलको थियो, र कुन प्रयोजनका लागि ल्याइएको थियो?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कामको प्रकृतिको आधारमा कम्प्युटरलाई कति भागमा विभाजन गर्न सकिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'कामको प्रकृतिको आधारमा कम्प्युटरलाई कति भागमा विभाजन गर्न सकिन्छ?', E'२ भागमा (Analog, Digital)', E'४ भागमा (Analog, Digital, Hybrid, Mixed)', E'५ भागमा', E'३ भागमा (Analog, Digital, Hybrid)', E'D', E'**कामको प्रकृतिका आधारमा कम्प्युटरलाई एनालग, डिजिटल र हाइब्रिड गरी ३ भागमा विभाजन गरिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कामको प्रकृतिको आधारमा कम्प्युटरलाई कति भागमा विभाजन गर्न सकिन्छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तापक्रम, चाप, गति जस्ता निरन्तर परिवर्तन भइरहने भौतिक परिमाण नाप्न कुन प्रकारको कम्प्युटर प्रयोग गरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'तापक्रम, चाप, गति जस्ता निरन्तर परिवर्तन भइरहने भौतिक परिमाण नाप्न कुन प्रकारको कम्प्युटर प्रयोग गरिन्छ?', E'एनालग कम्प्युटर', E'डिजिटल कम्प्युटर', E'हाइब्रिड कम्प्युटर', E'माइक्रो कम्प्युटर', E'A', E'**निरन्तर परिवर्तन हुने भौतिक परिमाण नाप्न एनालग कम्प्युटर प्रयोग गरिन्छ।**\\nनोट: भूकम्प नाप्ने यन्त्र पनि एनालग कम्प्युटरकै उदाहरण हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तापक्रम, चाप, गति जस्ता निरन्तर परिवर्तन भइरहने भौतिक परिमाण नाप्न कुन प्रकारको कम्प्युटर प्रयोग गरिन्छ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'एनालग र डिजिटल दुवै कम्प्युटरको गुण भएको कम्प्युटरलाई के भनिन्छ, र यसको प्रयोग कहाँ हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'एनालग र डिजिटल दुवै कम्प्युटरको गुण भएको कम्प्युटरलाई के भनिन्छ, र यसको प्रयोग कहाँ हुन्छ?', E'माइक्रो कम्प्युटर — जस्तै घर वा अफिसमा', E'हाइब्रिड कम्प्युटर — जस्तै अस्पतालको ICU मा मुटुको धड्कन नाप्न र हवाईजहाजमा', E'सुपर कम्प्युटर — जस्तै मौसम पूर्वानुमानमा', E'मेनफ्रेम कम्प्युटर — जस्तै बैंकिङ प्रणालीमा', E'B', E'**हाइब्रिड कम्प्युटरमा एनालग र डिजिटल दुवैको गुण हुन्छ, र यसको प्रयोग अस्पतालको ICU (मुटुको धड्कन नाप्न) र हवाईजहाजमा गरिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:एनालग र डिजिटल दुवै कम्प्युटरको गुण भएको कम्प्युटरलाई के भनिन्छ, र यसको प्रयोग कहाँ हुन्छ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'आकार (Size) को आधारमा कम्प्युटरलाई कति प्रकारमा बाँडिएको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'आकार (Size) को आधारमा कम्प्युटरलाई कति प्रकारमा बाँडिएको छ?', E'३ भागमा (Super, Mainframe, Micro)', E'५ भागमा', E'४ भागमा (Super, Mainframe, Mini, Micro)', E'२ भागमा (Super, Micro)', E'C', E'**आकारका आधारमा कम्प्युटरलाई सुपर, मेनफ्रेम, मिनी र माइक्रो गरी ४ भागमा बाँडिएको छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:आकार (Size) को आधारमा कम्प्युटरलाई कति प्रकारमा बाँडिएको छ?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सुपर कम्प्युटर, मेनफ्रेम कम्प्युटर, मिनी कम्प्युटर र माइक्रो कम्प्युटरमध्ये सबैभन्दा महँगो कम्प्युटर कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'सुपर कम्प्युटर, मेनफ्रेम कम्प्युटर, मिनी कम्प्युटर र माइक्रो कम्प्युटरमध्ये सबैभन्दा महँगो कम्प्युटर कुन हो?', E'मेनफ्रेम कम्प्युटर', E'मिनी कम्प्युटर', E'माइक्रो कम्प्युटर', E'सुपर कम्प्युटर', E'D', E'**सुपर कम्प्युटर आकार र क्षमता दुवैका हिसाबले सबैभन्दा ठूलो र महँगो हुन्छ।**\\nनोट: घर वा अफिसमा प्रयोग हुने डेस्कटप वा ल्यापटप माइक्रो कम्प्युटरको उदाहरण हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सुपर कम्प्युटर, मेनफ्रेम कम्प्युटर, मिनी कम्प्युटर र माइक्रो कम्प्युटरमध्ये सबैभन्दा महँगो कम्प्युटर कुन हो?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'ब्रान्डको आधारमा कम्प्युटरलाई कति प्रकारमा विभाजन गरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'ब्रान्डको आधारमा कम्प्युटरलाई कति प्रकारमा विभाजन गरिन्छ?', E'३ प्रकारमा (IBM PC, IBM Compatibles, Apple/Macintosh)', E'२ प्रकारमा', E'४ प्रकारमा', E'५ प्रकारमा', E'A', E'**ब्रान्डको आधारमा कम्प्युटरलाई IBM PC, IBM Compatibles र Apple/Macintosh गरी ३ प्रकारमा विभाजन गरिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:ब्रान्डको आधारमा कम्प्युटरलाई कति प्रकारमा विभाजन गरिन्छ?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''Computer'' शब्दको उद्गम कुन भाषाबाट भएको हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'''Computer'' शब्दको उद्गम कुन भाषाबाट भएको हो?', E'ग्रीक भाषा', E'ल्याटिन भाषा', E'फ्रेन्च भाषा', E'अंग्रेजी भाषा', E'B', E'**''Computer'' शब्दको उद्गम ल्याटिन भाषाबाट भएको हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''Computer'' शब्दको उद्गम कुन भाषाबाट भएको हो?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कम्प्युटरको नेपाली नाम के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'कम्प्युटरको नेपाली नाम के हो?', E'गणनायन्त्र', E'अंकयन्त्र', E'सुसांख्य', E'सूचनायन्त्र', E'C', E'**कम्प्युटरको नेपाली नाम ''सुसांख्य'' हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कम्प्युटरको नेपाली नाम के हो?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  RAISE NOTICE 'Unit ग-१ upsert complete: 1 sets, 15 questions.';
END $$;
