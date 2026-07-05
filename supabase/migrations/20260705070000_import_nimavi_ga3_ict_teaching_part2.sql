-- Idempotent UPSERT import: निमावि प्रथम पत्र — ग-३ शिक्षण सिकाइमा ICT को प्रयोग, part 2 (LMS/AI, नीति/पेसागत विकास/सुरक्षा, फर्म्याट/सर्टकट)
-- Override same-identity sets/questions; never deletes. Generated 2026-07-05T07:18:07.113Z.
DO $$
DECLARE
  v_module_id uuid := '6695669a-f40e-421a-a4ec-b09bbeaf56c4'::uuid;
  v_set_id uuid;
  v_q_id uuid;
BEGIN

  -- Set: ICT: LMS, मूल्याङ्कन टुल र कृत्रिम बौद्धिकता (आधारभूत तह) (11 Q)
  v_set_id := extensions.uuid_generate_v5('cbb263c2-3d08-40eb-8a62-cde9506661f6'::uuid, E'ICT: LMS, मूल्याङ्कन टुल र कृत्रिम बौद्धिकता (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'd3a2cc9d-8360-4348-8f7c-07b7c0544f2e'::uuid, 'cbb263c2-3d08-40eb-8a62-cde9506661f6'::uuid, E'ICT: LMS, मूल्याङ्कन टुल र कृत्रिम बौद्धिकता (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'cbb263c2-3d08-40eb-8a62-cde9506661f6'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सिकाइ सामग्री व्यवस्थापन गर्न, विद्यार्थीको ट्र्याकिङ गर्न र परीक्षा लिन प्रयोग गरिने सफ्टवेयरलाई छोटकरीमा के भनिन्छ, र यसको एउटा उदाहरण के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'सिकाइ सामग्री व्यवस्थापन गर्न, विद्यार्थीको ट्र्याकिङ गर्न र परीक्षा लिन प्रयोग गरिने सफ्टवेयरलाई छोटकरीमा के भनिन्छ, र यसको एउटा उदाहरण के हो?', E'LMS (Learning Management System) — Moodle', E'OER — Wikipedia', E'CMS — WordPress', E'ERP — SAP', E'A', E'**LMS (Learning Management System) ले सिकाइ सामग्री व्यवस्थापन, विद्यार्थी ट्र्याकिङ र परीक्षा सञ्चालन गर्छ; Moodle यसको उदाहरण हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सिकाइ सामग्री व्यवस्थापन गर्न, विद्यार्थीको ट्र्याकिङ गर्न र परीक्षा लिन प्रयोग गरिने सफ्टवेयरलाई छोटकरीमा के भनिन्छ, र यसको एउटा उदाहरण के हो?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कक्षाकोठामा खेलको माध्यमबाट बहुवैकल्पिक (MCQ) प्रश्न सोध्न कुन प्रख्यात एप प्रयोग गरिन्छ, र यस्तै अर्को लोकप्रिय मूल्याङ्कन टुल कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'कक्षाकोठामा खेलको माध्यमबाट बहुवैकल्पिक (MCQ) प्रश्न सोध्न कुन प्रख्यात एप प्रयोग गरिन्छ, र यस्तै अर्को लोकप्रिय मूल्याङ्कन टुल कुन हो?', E'Padlet — Edpuzzle', E'Kahoot! — Quizizz वा Socrative', E'Zoom — Google Meet', E'Canva — Photoshop', E'B', E'**Kahoot! खेलमार्फत MCQ सोध्ने प्रख्यात एप हो; Quizizz वा Socrative यस्तै अर्को लोकप्रिय मूल्याङ्कन टुल हुन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कक्षाकोठामा खेलको माध्यमबाट बहुवैकल्पिक (MCQ) प्रश्न सोध्न कुन प्रख्यात एप प्रयोग गरिन्छ, र यस्तै अर्को लोकप्रिय मूल्याङ्कन टुल कुन हो?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'गुगल क्लासरुम भित्र असाइनमेन्टमा सोझै नम्बर र फिडब्याक दिन कुन सुविधा प्रयोग गरिन्छ, र विद्यार्थीको अनलाइन हाजिरी वा डाटा संकलन गर्न गुगलको कुन टुल बढी प्रयोग हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'गुगल क्लासरुम भित्र असाइनमेन्टमा सोझै नम्बर र फिडब्याक दिन कुन सुविधा प्रयोग गरिन्छ, र विद्यार्थीको अनलाइन हाजिरी वा डाटा संकलन गर्न गुगलको कुन टुल बढी प्रयोग हुन्छ?', E'Gmail — Google Meet', E'Google Drive — YouTube', E'ग्रेडबुक र रुब्रिक्स — Google Forms', E'Padlet — Kahoot!', E'C', E'**गुगल क्लासरुममा नम्बर र फिडब्याक दिन ग्रेडबुक (Gradebook) र रुब्रिक्स (Rubrics) प्रयोग हुन्छ। हाजिरी/डाटा संकलनका लागि Google Forms बढी प्रयोग गरिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:गुगल क्लासरुम भित्र असाइनमेन्टमा सोझै नम्बर र फिडब्याक दिन कुन सुविधा प्रयोग गरिन्छ, र विद्यार्थीको अनलाइन हाजिरी वा डाटा संकलन गर्न गुगलको कुन टुल बढी प्रयोग हुन्छ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'Google Forms मा बनाइएको डाटा कुन सफ्टवेयरमा स्वचालित रूपमा गएर बस्छ, र विद्यार्थीलाई भिडियोको बिच-बिचमा प्रश्न सोध्न मिल्ने अन्तरक्रियात्मक टुल कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'Google Forms मा बनाइएको डाटा कुन सफ्टवेयरमा स्वचालित रूपमा गएर बस्छ, र विद्यार्थीलाई भिडियोको बिच-बिचमा प्रश्न सोध्न मिल्ने अन्तरक्रियात्मक टुल कुन हो?', E'Google Docs — Kahoot!', E'Google Slides — Padlet', E'Google Sites — Quizizz', E'Google Sheets — Edpuzzle', E'D', E'**Google Forms को डाटा स्वचालित रूपमा Google Sheets मा गएर बस्छ। भिडियोको बिचमा प्रश्न सोध्ने टुल Edpuzzle हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:Google Forms मा बनाइएको डाटा कुन सफ्टवेयरमा स्वचालित रूपमा गएर बस्छ, र विद्यार्थीलाई भिडियोको बिच-बिचमा प्रश्न सोध्न मिल्ने अन्तरक्रियात्मक टुल कुन हो?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षकहरूले शैक्षिक सामग्री, भिडियो र लिंकहरू एउटै भित्तामा टाँसेर विद्यार्थीलाई सेयर गर्न कुन टुल प्रयोग गर्छन्, र इ-पोर्टफोलियो निर्माण गर्न कुन टुल उपयोगी हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'शिक्षकहरूले शैक्षिक सामग्री, भिडियो र लिंकहरू एउटै भित्तामा टाँसेर विद्यार्थीलाई सेयर गर्न कुन टुल प्रयोग गर्छन्, र इ-पोर्टफोलियो निर्माण गर्न कुन टुल उपयोगी हुन्छ?', E'Padlet — Google Sites वा Mahara', E'Kahoot! — Google Forms', E'Edpuzzle — Google Sheets', E'Google Classroom — Padlet', E'A', E'**Padlet ले सामग्री/भिडियो/लिंकलाई एउटै भित्तामा टाँसेर सेयर गर्न मिल्छ। इ-पोर्टफोलियो निर्माणका लागि Google Sites वा Mahara उपयोगी हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षकहरूले शैक्षिक सामग्री, भिडियो र लिंकहरू एउटै भित्तामा टाँसेर विद्यार्थीलाई सेयर गर्न कुन टुल प्रयोग गर्छन्, र इ-पोर्टफोलियो निर्माण गर्न कुन टुल उपयोगी हुन्छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'मोबाइल लर्निङ (M-Learning) को मुख्य विशेषता के हो, र AI को पूरा रूप के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'मोबाइल लर्निङ (M-Learning) को मुख्य विशेषता के हो, र AI को पूरा रूप के हो?', E'केवल विद्यालयमा मात्र सिकाइ हुनु — Automatic Internet', E'जहाँसुकै-जहिलेसुकै सिकाइ सम्भव हुनु — Artificial Intelligence', E'इन्टरनेट नचाहिनु — Applied Information', E'शिक्षक अनिवार्य चाहिनु — Advanced Instruction', E'B', E'**M-Learning को मुख्य विशेषता जहाँसुकै र जहिलेसुकै (Anywhere, Anytime) सिकाइ सम्भव हुनु हो। AI को पूरा रूप Artificial Intelligence (कृत्रिम बौद्धिकता) हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:मोबाइल लर्निङ (M-Learning) को मुख्य विशेषता के हो, र AI को पूरा रूप के हो?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षामा ChatGPT जस्ता AI टुलको मुख्य प्रयोग कसरी गर्न सकिन्छ, र ''मेसिन लर्निङ'' शिक्षामा कसरी प्रयोग हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'शिक्षामा ChatGPT जस्ता AI टुलको मुख्य प्रयोग कसरी गर्न सकिन्छ, र ''मेसिन लर्निङ'' शिक्षामा कसरी प्रयोग हुन्छ?', E'परीक्षा उत्तरपुस्तिका आफै लेख्न — शिक्षकको तलब गणना गर्न', E'विद्यार्थीको हाजिरी लिन मात्र — कक्षाकोठा सफा गर्न', E'पाठयोजना बनाउन/विचार मन्थन गर्न/जटिल कुरा सरल बनाउन — विद्यार्थीको सिकाइ ढाँचा बुझेर स्वचालित सामग्री दिन (Adaptive Learning)', E'पाठ्यपुस्तक छाप्न — बिजुली बचत गर्न', E'C', E'**ChatGPT जस्ता AI टुल पाठयोजना बनाउन, विचार मन्थन गर्न र जटिल कुरा सरल भाषामा बुझाउन प्रयोग हुन्छन्। मेसिन लर्निङले विद्यार्थीको सिकाइ ढाँचा बुझेर स्वचालित रूपमा उपयुक्त सामग्री दिन्छ (Adaptive Learning)।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षामा ChatGPT जस्ता AI टुलको मुख्य प्रयोग कसरी गर्न सकिन्छ, र ''मेसिन लर्निङ'' शिक्षामा कसरी प्रयोग हुन्छ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''अगुमेन्टेड रियालिटी'' (AR) ले सिकाइमा कसरी मद्दत गर्छ, र ''भर्चुअल रियालिटी'' (VR) हेर्न कुन उपकरण लगाइन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'''अगुमेन्टेड रियालिटी'' (AR) ले सिकाइमा कसरी मद्दत गर्छ, र ''भर्चुअल रियालिटी'' (VR) हेर्न कुन उपकरण लगाइन्छ?', E'केवल फोटो सम्पादन गर्न — माउस', E'इन्टरनेट स्पिड बढाउन — किबोर्ड', E'भाइरस हटाउन — प्रिन्टर', E'वास्तविक संसारमा डिजिटल/3D सामग्री थपेर हेर्न (जस्तै मोबाइलबाट किताब स्क्यान गर्दा चित्र घुम्नु) — VR Headset', E'D', E'**AR ले वास्तविक संसारमा डिजिटल वा 3D सामग्री थपेर देखाउँछ (जस्तै मोबाइलबाट स्क्यान गर्दा चित्र घुम्नु)। VR हेर्न VR Headset लगाइन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''अगुमेन्टेड रियालिटी'' (AR) ले सिकाइमा कसरी मद्दत गर्छ, र ''भर्चुअल रियालिटी'' (VR) हेर्न कुन उपकरण लगाइन्छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यालयको ठूलो तथ्याङ्क (जस्तै हजारौं विद्यार्थीको वर्षौंको नतिजा) विश्लेषण गरी भविष्यको योजना बनाउन कुन प्रविधि प्रयोग हुन्छ, र इन्टरनेट अफ थिंग्स (IoT) ले विद्यालयमा के फाइदा दिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'विद्यालयको ठूलो तथ्याङ्क (जस्तै हजारौं विद्यार्थीको वर्षौंको नतिजा) विश्लेषण गरी भविष्यको योजना बनाउन कुन प्रविधि प्रयोग हुन्छ, र इन्टरनेट अफ थिंग्स (IoT) ले विद्यालयमा के फाइदा दिन्छ?', E'बिग डाटा एनालिटिक्स — विद्यालयका उपकरण (बत्ती/पंखा/क्यामेरा) इन्टरनेटमार्फत स्वचालित/नियन्त्रित हुनु', E'MS Word — इन्टरनेट स्पिड बढ्नु', E'Antivirus — फाइल डिलिट हुनु', E'Firewall — भिडियो हेर्न मिल्नु', E'A', E'**ठूलो तथ्याङ्क विश्लेषण गरी योजना बनाउन बिग डाटा एनालिटिक्स प्रयोग हुन्छ। IoT ले विद्यालयका उपकरणहरूलाई इन्टरनेटमार्फत स्वचालित र नियन्त्रित बनाउँछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यालयको ठूलो तथ्याङ्क (जस्तै हजारौं विद्यार्थीको वर्षौंको नतिजा) विश्लेषण गरी भविष्यको योजना बनाउन कुन प्रविधि प्रयोग हुन्छ, र इन्टरनेट अफ थिंग्स (IoT) ले विद्यालयमा के फाइदा दिन्छ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षामा ''क्लाउड कम्प्युटिङ'' को मुख्य फाइदा के हो, र ब्लकचेन प्रविधिको प्रयोग शिक्षामा भविष्यमा कुन कामका लागि हुन सक्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'शिक्षामा ''क्लाउड कम्प्युटिङ'' को मुख्य फाइदा के हो, र ब्लकचेन प्रविधिको प्रयोग शिक्षामा भविष्यमा कुन कामका लागि हुन सक्छ?', E'इन्टरनेट नचाहिने — भिडियो हेर्न मिल्ने', E'विद्यालयले आफ्नै ठूलो सर्भर किन्नु नपर्ने र डाटा सुरक्षित रहने — विद्यार्थीको सर्टिफिकेट/मार्कसिटलाई नक्कली बनाउन नमिल्ने (Tamper-proof) बनाउन', E'बिजुली नचाहिने — भाइरस हटाउने', E'शिक्षक नचाहिने — गृहकार्य आफै बन्ने', E'B', E'**क्लाउड कम्प्युटिङको फाइदा भनेको विद्यालयले आफ्नै ठूलो सर्भर किन्नु नपर्नु र डाटा सुरक्षित रहनु हो। ब्लकचेनले प्रमाणपत्र/मार्कसिटलाई Tamper-proof बनाउन सक्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षामा ''क्लाउड कम्प्युटिङ'' को मुख्य फाइदा के हो, र ब्लकचेन प्रविधिको प्रयोग शिक्षामा भविष्यमा कुन कामका लागि हुन सक्छ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'थ्रीडी प्रिन्टिङले विद्यालयमा कस्तो सिकाइलाई प्रवर्द्धन गर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'थ्रीडी प्रिन्टिङले विद्यालयमा कस्तो सिकाइलाई प्रवर्द्धन गर्छ?', E'विज्ञान र प्रविधि (STEM) का मोडेल आफैं बनाएर सिक्ने (Hands-on Learning)', E'परीक्षा प्रश्नपत्र छाप्ने काम मात्र', E'पाठ्यपुस्तक छाप्ने काम मात्र', E'फोटोकपी गर्ने काम मात्र', E'C', E'**थ्रीडी प्रिन्टिङले STEM का मोडेल आफैं बनाएर सिक्ने (Hands-on Learning) लाई प्रवर्द्धन गर्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:थ्रीडी प्रिन्टिङले विद्यालयमा कस्तो सिकाइलाई प्रवर्द्धन गर्छ?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: ICT: नेपालको ICT नीति, शिक्षक पेसागत विकास र उन्नत डिजिटल सुरक्षा (आधारभूत तह) (14 Q)
  v_set_id := extensions.uuid_generate_v5('46654309-946f-4ebb-8566-01378fd9ae0c'::uuid, E'ICT: नेपालको ICT नीति, शिक्षक पेसागत विकास र उन्नत डिजिटल सुरक्षा (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'd3a2cc9d-8360-4348-8f7c-07b7c0544f2e'::uuid, '46654309-946f-4ebb-8566-01378fd9ae0c'::uuid, E'ICT: नेपालको ICT नीति, शिक्षक पेसागत विकास र उन्नत डिजिटल सुरक्षा (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '46654309-946f-4ebb-8566-01378fd9ae0c'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपाल सरकारले ''सूचना तथा सञ्चार प्रविधि नीति'' (National ICT Policy) पछिल्लो पटक कहिले ल्याएको हो, र यसले शिक्षा क्षेत्रमा सन् २०२० सम्ममा कति प्रतिशत जनसंख्यालाई डिजिटल साक्षर बनाउने लक्ष्य राखेको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'नेपाल सरकारले ''सूचना तथा सञ्चार प्रविधि नीति'' (National ICT Policy) पछिल्लो पटक कहिले ल्याएको हो, र यसले शिक्षा क्षेत्रमा सन् २०२० सम्ममा कति प्रतिशत जनसंख्यालाई डिजिटल साक्षर बनाउने लक्ष्य राखेको थियो?', E'वि.सं. २०७२ मा — ७५ प्रतिशत', E'वि.सं. २०६५ मा — ५० प्रतिशत', E'वि.सं. २०७८ मा — ९० प्रतिशत', E'वि.सं. २०७२ मा — ५० प्रतिशत', E'A', E'**नेपालको ICT Policy वि.सं. २०७२ (सन् २०१५) मा ल्याइएको हो, जसले सन् २०२० सम्ममा ७५ प्रतिशत जनसंख्यालाई डिजिटल साक्षर बनाउने लक्ष्य राखेको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपाल सरकारले ''सूचना तथा सञ्चार प्रविधि नीति'' (National ICT Policy) पछिल्लो पटक कहिले ल्याएको हो, र यसले शिक्षा क्षेत्रमा सन् २०२० सम्ममा कति प्रतिशत जनसंख्यालाई डिजिटल साक्षर बनाउने लक्ष्य राखेको थियो?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालमा ''राष्ट्रिय सूचना तथा सञ्चार प्रविधि दिवस'' (National ICT Day) कहिले मनाइन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'नेपालमा ''राष्ट्रिय सूचना तथा सञ्चार प्रविधि दिवस'' (National ICT Day) कहिले मनाइन्छ?', E'जनवरी १ (नयाँ वर्ष)', E'मे २', E'अक्टोबर १० (विश्व दूरसञ्चार दिवस)', E'अप्रिल १४ (नयाँ वर्ष)', E'B', E'**नेपालमा राष्ट्रिय सूचना तथा सञ्चार प्रविधि दिवस मे २ मा मनाइन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालमा ''राष्ट्रिय सूचना तथा सञ्चार प्रविधि दिवस'' (National ICT Day) कहिले मनाइन्छ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा विज्ञान तथा प्रविधि मन्त्रालयले ''वैकल्पिक प्रणालीबाट विद्यार्थीको सिकाइ सहजीकरण निर्देशिका'' कहिले जारी गर्‍यो, र यो किन जारी भएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'शिक्षा विज्ञान तथा प्रविधि मन्त्रालयले ''वैकल्पिक प्रणालीबाट विद्यार्थीको सिकाइ सहजीकरण निर्देशिका'' कहिले जारी गर्‍यो, र यो किन जारी भएको थियो?', E'२०७२ भूकम्पपछि — विद्यालय पुनर्निर्माणका लागि', E'२०६५ मा — शिक्षक भर्तीका लागि', E'२०७७ जेठमा — कोभिड-१९ महामारीको समयमा वैकल्पिक माध्यमबाट सिकाइ सहजीकरण गर्न', E'२०८० मा — नयाँ पाठ्यक्रम लागू गर्न', E'C', E'**यो निर्देशिका २०७७ जेठमा कोभिड-१९ महामारीको समयमा वैकल्पिक माध्यमबाट विद्यार्थीको सिकाइ सहजीकरण गर्न जारी गरिएको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा विज्ञान तथा प्रविधि मन्त्रालयले ''वैकल्पिक प्रणालीबाट विद्यार्थीको सिकाइ सहजीकरण निर्देशिका'' कहिले जारी गर्‍यो, र यो किन जारी भएको थियो?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यालयमा इन्टरनेट जडान गर्न नेपाल दूरसञ्चार प्राधिकरण (NTA) ले कुन कोषको रकम प्रयोग गर्दै आएको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'विद्यालयमा इन्टरनेट जडान गर्न नेपाल दूरसञ्चार प्राधिकरण (NTA) ले कुन कोषको रकम प्रयोग गर्दै आएको छ?', E'शिक्षक कल्याण कोष', E'प्रधानमन्त्री राहत कोष', E'नागरिक लगानी कोष', E'ग्रामीण दूरसञ्चार विकास कोष (RTDF)', E'D', E'**NTA ले विद्यालयमा इन्टरनेट जडानका लागि ग्रामीण दूरसञ्चार विकास कोष (RTDF) को रकम प्रयोग गर्दै आएको छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यालयमा इन्टरनेट जडान गर्न नेपाल दूरसञ्चार प्राधिकरण (NTA) ले कुन कोषको रकम प्रयोग गर्दै आएको छ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'TPACK मोडलका प्रतिपादक को हुन्, र यो कुन सालमा प्रतिपादन गरिएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'TPACK मोडलका प्रतिपादक को हुन्, र यो कुन सालमा प्रतिपादन गरिएको थियो?', E'Punya Mishra र Matthew J. Koehler — सन् २००६', E'Ruben Puentedura — सन् २०१०', E'Benjamin Bloom — सन् १९५६', E'Lev Vygotsky — सन् १९७८', E'A', E'**TPACK मोडल Punya Mishra र Matthew J. Koehler ले सन् २००६ मा प्रतिपादन गरेका हुन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:TPACK मोडलका प्रतिपादक को हुन्, र यो कुन सालमा प्रतिपादन गरिएको थियो?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षक निर्देशिका र पाठ्यक्रमका सफ्ट कपीहरू कुन निकायको वेबसाइटबाट डाउनलोड गर्न सकिन्छ, र शिक्षकहरूको पेसागत विकासका लागि CEHRD ले कुन प्रकृतिको अनलाइन तालिम सञ्चालन गर्दै आएको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'शिक्षक निर्देशिका र पाठ्यक्रमका सफ्ट कपीहरू कुन निकायको वेबसाइटबाट डाउनलोड गर्न सकिन्छ, र शिक्षकहरूको पेसागत विकासका लागि CEHRD ले कुन प्रकृतिको अनलाइन तालिम सञ्चालन गर्दै आएको छ?', E'शिक्षक सेवा आयोग — SEE तालिम', E'पाठ्यक्रम विकास केन्द्र (CDC) — TPD अनलाइन तालिम', E'निर्वाचन आयोग — मतदाता शिक्षा', E'राष्ट्र बैंक — वित्तीय साक्षरता तालिम', E'B', E'**पाठ्यक्रम विकास केन्द्र (CDC) को वेबसाइटबाट शिक्षक निर्देशिका र पाठ्यक्रम डाउनलोड गर्न सकिन्छ। CEHRD ले शिक्षकको पेसागत विकासका लागि TPD अनलाइन तालिम सञ्चालन गर्दै आएको छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षक निर्देशिका र पाठ्यक्रमका सफ्ट कपीहरू कुन निकायको वेबसाइटबाट डाउनलोड गर्न सकिन्छ, र शिक्षकहरूको पेसागत विकासका लागि CEHRD ले कुन प्रकृतिको अनलाइन तालिम सञ्चालन गर्दै आएको छ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षकले अनलाइन माध्यमबाट पढाउँदा प्रयोग गर्ने ''ह्वाइटबोर्ड'' टुल कुन हो, र प्रस्तुतीकरणको स्लाइडमा धेरै टेक्स्ट राख्नु राम्रो मानिन्छ कि थोरै टेक्स्ट र चित्र (6x6 Rule)?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'शिक्षकले अनलाइन माध्यमबाट पढाउँदा प्रयोग गर्ने ''ह्वाइटबोर्ड'' टुल कुन हो, र प्रस्तुतीकरणको स्लाइडमा धेरै टेक्स्ट राख्नु राम्रो मानिन्छ कि थोरै टेक्स्ट र चित्र (6x6 Rule)?', E'MS Excel — धेरै टेक्स्ट राम्रो मानिन्छ', E'MS Word — कुनै फरक पर्दैन', E'Google Jamboard वा MS Whiteboard — थोरै टेक्स्ट र सान्दर्भिक चित्र राम्रो मानिन्छ', E'Google Forms — केवल चित्र मात्र राख्नुपर्छ', E'C', E'**अनलाइन शिक्षणमा Google Jamboard वा MS Whiteboard प्रयोग गरिन्छ। स्लाइडमा थोरै टेक्स्ट र सान्दर्भिक चित्र राख्नु राम्रो मानिन्छ (6x6 Rule)।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षकले अनलाइन माध्यमबाट पढाउँदा प्रयोग गर्ने ''ह्वाइटबोर्ड'' टुल कुन हो, र प्रस्तुतीकरणको स्लाइडमा धेरै टेक्स्ट राख्नु राम्रो मानिन्छ कि थोरै टेक्स्ट र चित्र (6x6 Rule)?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'डिजिटल सिटिजनसिपका मुख्य तीन क्षेत्र (REP) के-के हुन्, र क्रिएटिभ कमन्स (CC) लाइसेन्सले के जनाउँछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'डिजिटल सिटिजनसिपका मुख्य तीन क्षेत्र (REP) के-के हुन्, र क्रिएटिभ कमन्स (CC) लाइसेन्सले के जनाउँछ?', E'Read, Edit, Print — सामग्री बेच्न पाइने', E'Record, Erase, Play — सामग्री सम्पादन गर्न नपाइने', E'Report, Escalate, Prevent — सामग्री पूर्ण गोप्य राख्नुपर्ने', E'Respect, Educate, Protect — लेखकले सर्तसहित सामग्री अरूलाई प्रयोग गर्न अनुमति दिएको', E'D', E'**डिजिटल सिटिजनसिपका तीन क्षेत्र Respect, Educate, Protect (REP) हुन्। Creative Commons लाइसेन्सले लेखकले सर्तसहित आफ्नो सामग्री अरूलाई प्रयोग गर्न अनुमति दिएको जनाउँछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:डिजिटल सिटिजनसिपका मुख्य तीन क्षेत्र (REP) के-के हुन्, र क्रिएटिभ कमन्स (CC) लाइसेन्सले के जनाउँछ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'ट्रोजन हर्स (Trojan Horse) के हो, र र्यान्समवेयर (Ransomware) ले कम्प्युटरमा आक्रमण गरेपछि के माग्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'ट्रोजन हर्स (Trojan Horse) के हो, र र्यान्समवेयर (Ransomware) ले कम्प्युटरमा आक्रमण गरेपछि के माग्छ?', E'राम्रो सफ्टवेयर जस्तो देखिने तर भित्रभित्रै हानि गर्ने मालवेयर — फाइल लक गरेर फिरौती माग्छ', E'एउटा एन्टिभाइरस — कुनै फाइदा दिँदैन', E'इन्टरनेट ब्राउजर — केवल विज्ञापन देखाउँछ', E'पासवर्ड म्यानेजर — फाइल थप्छ', E'A', E'**ट्रोजन हर्स राम्रो सफ्टवेयर जस्तो देखिने तर भित्रभित्रै कम्प्युटरलाई हानि गर्ने मालवेयर हो। र्यान्समवेयरले फाइल लक गरेर फिरौती (पैसा/Cryptocurrency) माग्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:ट्रोजन हर्स (Trojan Horse) के हो, र र्यान्समवेयर (Ransomware) ले कम्प्युटरमा आक्रमण गरेपछि के माग्छ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''2FA'' को पूरा रूप के हो, र वेबसाइट सुरक्षित छ कि छैन भनेर जाँच्न URL मा के हेर्नुपर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'''2FA'' को पूरा रूप के हो, र वेबसाइट सुरक्षित छ कि छैन भनेर जाँच्न URL मा के हेर्नुपर्छ?', E'Two-File Access — केवल .com डोमेन', E'Two-Factor Authentication — HTTP को सट्टा HTTPS छ कि छैन (र ताल्चाको चिन्ह)', E'Two-Feature App — वेबसाइटको रङ', E'Two-Form Analysis — पासवर्डको लम्बाइ मात्र', E'B', E'**2FA को पूरा रूप Two-Factor Authentication हो। वेबसाइट सुरक्षित छ कि छैन जाँच्न URL मा HTTP को सट्टा HTTPS छ कि छैन र ताल्चाको चिन्ह हेर्नुपर्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''2FA'' को पूरा रूप के हो, र वेबसाइट सुरक्षित छ कि छैन भनेर जाँच्न URL मा के हेर्नुपर्छ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'VPN को पूरा रूप के हो, र विद्यार्थीले साइबर बुलिङको गुनासो गरेमा शिक्षकले सबैभन्दा पहिले के गर्नुपर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'VPN को पूरा रूप के हो, र विद्यार्थीले साइबर बुलिङको गुनासो गरेमा शिक्षकले सबैभन्दा पहिले के गर्नुपर्छ?', E'Verified Public Network — तुरुन्तै प्रहरीमा उजुरी गर्ने मात्र', E'Video Private Node — विद्यार्थीलाई निष्कासन गर्ने', E'Virtual Private Network — विद्यार्थीलाई सान्त्वना दिने र प्रमाण (Screenshot) सुरक्षित राख्न लगाउने', E'Virtual Protected Node — कुनै कारबाही नगर्ने', E'C', E'**VPN को पूरा रूप Virtual Private Network हो। साइबर बुलिङको गुनासोमा शिक्षकले पहिले विद्यार्थीलाई सान्त्वना दिने र प्रमाण (Screenshot) सुरक्षित राख्न लगाउने काम गर्नुपर्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:VPN को पूरा रूप के हो, र विद्यार्थीले साइबर बुलिङको गुनासो गरेमा शिक्षकले सबैभन्दा पहिले के गर्नुपर्छ?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पढ्न कठिनाइ हुने (Dyslexia) भएका विद्यार्थीका लागि कुन प्रविधि उपयोगी हुन्छ, र सुन्न नसक्ने (Deaf) विद्यार्थीलाई भिडियो सामग्री देखाउँदा के को अनिवार्य प्रयोग हुनुपर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'पढ्न कठिनाइ हुने (Dyslexia) भएका विद्यार्थीका लागि कुन प्रविधि उपयोगी हुन्छ, र सुन्न नसक्ने (Deaf) विद्यार्थीलाई भिडियो सामग्री देखाउँदा के को अनिवार्य प्रयोग हुनुपर्छ?', E'Speech-to-Text — ब्रेल प्रिन्टर', E'Magnifier — Screen Reader', E'On-screen Keyboard — Zoom सफ्टवेयर', E'Text-to-Speech — सबटाइटल वा क्याप्सन', E'D', E'**पढ्न कठिनाइ हुने विद्यार्थीका लागि Text-to-Speech (अक्षरलाई आवाजमा बदल्ने) उपयोगी हुन्छ। सुन्न नसक्ने विद्यार्थीलाई भिडियोमा सबटाइटल वा क्याप्सनको अनिवार्य प्रयोग हुनुपर्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पढ्न कठिनाइ हुने (Dyslexia) भएका विद्यार्थीका लागि कुन प्रविधि उपयोगी हुन्छ, र सुन्न नसक्ने (Deaf) विद्यार्थीलाई भिडियो सामग्री देखाउँदा के को अनिवार्य प्रयोग हुनुपर्छ?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'किबोर्ड चलाउन नसक्ने शारीरिक अपाङ्गता भएका विद्यार्थीले कुन प्रविधि प्रयोग गर्न सक्छन्, र ब्रेल प्रिन्टरले कसलाई सहयोग पुर्‍याउँछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'किबोर्ड चलाउन नसक्ने शारीरिक अपाङ्गता भएका विद्यार्थीले कुन प्रविधि प्रयोग गर्न सक्छन्, र ब्रेल प्रिन्टरले कसलाई सहयोग पुर्‍याउँछ?', E'Speech-to-Text वा On-screen Keyboard — दृष्टिविहीन विद्यार्थीलाई', E'Text-to-Speech — सुन्न नसक्ने विद्यार्थीलाई', E'Magnifier — बोल्न नसक्ने विद्यार्थीलाई', E'VPN — सामान्य विद्यार्थीलाई', E'A', E'**किबोर्ड चलाउन नसक्ने विद्यार्थीले Speech-to-Text वा On-screen Keyboard प्रयोग गर्न सक्छन्। ब्रेल प्रिन्टरले दृष्टिविहीन विद्यार्थीलाई (टेक्स्टलाई ब्रेल लिपिमा छाप्न) सहयोग पुर्‍याउँछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:किबोर्ड चलाउन नसक्ने शारीरिक अपाङ्गता भएका विद्यार्थीले कुन प्रविधि प्रयोग गर्न सक्छन्, र ब्रेल प्रिन्टरले कसलाई सहयोग पुर्‍याउँछ?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'म्याग्निफायर (Magnifier) टुल कम्प्युटरमा किन प्रयोग गरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'म्याग्निफायर (Magnifier) टुल कम्प्युटरमा किन प्रयोग गरिन्छ?', E'कमजोर दृष्टि (Low Vision) भएका विद्यार्थीलाई अक्षर ठूलो बनाएर देखाउन', E'फाइल कम्प्रेस गर्न', E'इन्टरनेट स्पिड नाप्न', E'भाइरस स्क्यान गर्न', E'B', E'**म्याग्निफायर कमजोर दृष्टि भएका विद्यार्थीलाई अक्षर ठूलो बनाएर देखाउन प्रयोग गरिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:म्याग्निफायर (Magnifier) टुल कम्प्युटरमा किन प्रयोग गरिन्छ?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: ICT: फाइल फर्म्याट, व्यावहारिक ज्ञान र किबोर्ड सर्टकट (आधारभूत तह) (19 Q)
  v_set_id := extensions.uuid_generate_v5('89e0c8d9-1800-4678-a373-ae28249bc461'::uuid, E'ICT: फाइल फर्म्याट, व्यावहारिक ज्ञान र किबोर्ड सर्टकट (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'd3a2cc9d-8360-4348-8f7c-07b7c0544f2e'::uuid, '89e0c8d9-1800-4678-a373-ae28249bc461'::uuid, E'ICT: फाइल फर्म्याट, व्यावहारिक ज्ञान र किबोर्ड सर्टकट (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '89e0c8d9-1800-4678-a373-ae28249bc461'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'अडियो फाइलको सबैभन्दा प्रख्यात फर्म्याट कुन हो, र भिडियो फाइलको सबैभन्दा बढी प्रयोग हुने फर्म्याट कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'अडियो फाइलको सबैभन्दा प्रख्यात फर्म्याट कुन हो, र भिडियो फाइलको सबैभन्दा बढी प्रयोग हुने फर्म्याट कुन हो?', E'.mp3 — .mp4', E'.doc — .pdf', E'.zip — .rar', E'.png — .jpg', E'A', E'**अडियो फाइलको प्रख्यात फर्म्याट .mp3 हो; भिडियो फाइलको सबैभन्दा बढी प्रयोग हुने फर्म्याट .mp4 हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:अडियो फाइलको सबैभन्दा प्रख्यात फर्म्याट कुन हो, र भिडियो फाइलको सबैभन्दा बढी प्रयोग हुने फर्म्याट कुन हो?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तस्बिर (Image) फाइलका प्रख्यात फर्म्याट कुन-कुन हुन्, र GIF फर्म्याटको मुख्य विशेषता के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'तस्बिर (Image) फाइलका प्रख्यात फर्म्याट कुन-कुन हुन्, र GIF फर्म्याटको मुख्य विशेषता के हो?', E'.mp3, .wav — ध्वनि बज्नु', E'.jpg, .png, .gif — तस्बिरहरू चलिरहेको (Animated) जस्तो देखिनु', E'.exe, .bat — प्रोग्राम चल्नु', E'.zip, .rar — साइज सानो हुनु', E'B', E'**तस्बिर फाइलका प्रख्यात फर्म्याट .jpg, .png, .gif हुन्। GIF फर्म्याटको मुख्य विशेषता यसमा तस्बिरहरू Animated जस्तो देखिनु हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तस्बिर (Image) फाइलका प्रख्यात फर्म्याट कुन-कुन हुन्, र GIF फर्म्याटको मुख्य विशेषता के हो?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कम्प्रेस गरेर साइज सानो बनाइएको फाइलको फर्म्याट के हुन्छ, र कुन फाइल फर्म्याटलाई सजिलै सम्पादन गर्न मिल्दैन र सबै डिभाइसमा एउटै डिजाइनमा खुल्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'कम्प्रेस गरेर साइज सानो बनाइएको फाइलको फर्म्याट के हुन्छ, र कुन फाइल फर्म्याटलाई सजिलै सम्पादन गर्न मिल्दैन र सबै डिभाइसमा एउटै डिजाइनमा खुल्छ?', E'.mp4 — .docx', E'.png — .xlsx', E'.zip वा .rar — PDF', E'.exe — .pptx', E'C', E'**कम्प्रेस गरिएको फाइलको फर्म्याट .zip वा .rar हुन्छ। PDF (Portable Document Format) लाई सजिलै सम्पादन गर्न मिल्दैन र सबै डिभाइसमा एउटै डिजाइनमा खुल्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कम्प्रेस गरेर साइज सानो बनाइएको फाइलको फर्म्याट के हुन्छ, र कुन फाइल फर्म्याटलाई सजिलै सम्पादन गर्न मिल्दैन र सबै डिभाइसमा एउटै डिजाइनमा खुल्छ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'भिडियो सम्पादन गर्ने कुनै एउटा निःशुल्क (Open Source) सफ्टवेयर कुन हो, र तस्बिर सम्पादन गर्न प्रयोग हुने प्रख्यात प्रोफेसनल सफ्टवेयर कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'भिडियो सम्पादन गर्ने कुनै एउटा निःशुल्क (Open Source) सफ्टवेयर कुन हो, र तस्बिर सम्पादन गर्न प्रयोग हुने प्रख्यात प्रोफेसनल सफ्टवेयर कुन हो?', E'MS Word — MS Excel', E'Kahoot! — Padlet', E'Google Forms — Google Sheets', E'OpenShot वा Shotcut — Adobe Photoshop', E'D', E'**भिडियो सम्पादनका निःशुल्क सफ्टवेयर OpenShot वा Shotcut हुन्। तस्बिर सम्पादनको प्रख्यात प्रोफेसनल सफ्टवेयर Adobe Photoshop हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:भिडियो सम्पादन गर्ने कुनै एउटा निःशुल्क (Open Source) सफ्टवेयर कुन हो, र तस्बिर सम्पादन गर्न प्रयोग हुने प्रख्यात प्रोफेसनल सफ्टवेयर कुन हो?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वेब ब्राउजरमा बुकमार्क (Bookmark) किन गरिन्छ, र इन्टरनेटबाट डाउनलोड भएका फाइलहरू सामान्यतया कुन फोल्डरमा गएर बस्छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'वेब ब्राउजरमा बुकमार्क (Bookmark) किन गरिन्छ, र इन्टरनेटबाट डाउनलोड भएका फाइलहरू सामान्यतया कुन फोल्डरमा गएर बस्छन्?', E'मन परेको वा पछि चाहिने वेबसाइटको ठेगाना सेभ गर्न — Downloads फोल्डरमा', E'भाइरस हटाउन — Documents फोल्डरमा', E'फाइल डिलिट गर्न — Desktop मा', E'पासवर्ड सेभ गर्न — Recycle Bin मा', E'A', E'**बुकमार्क मन परेको वा पछि चाहिने वेबसाइटको ठेगाना सेभ गरेर राख्न गरिन्छ। डाउनलोड भएका फाइल सामान्यतया Downloads फोल्डरमा गएर बस्छन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वेब ब्राउजरमा बुकमार्क (Bookmark) किन गरिन्छ, र इन्टरनेटबाट डाउनलोड भएका फाइलहरू सामान्यतया कुन फोल्डरमा गएर बस्छन्?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षकले आफ्नो कक्षाकोठालाई ''पेपरलेस'' बनाउन के गर्न सक्छन्, र सिकाइमा ''सिमुलेसन'' भन्नाले के बुझिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'शिक्षकले आफ्नो कक्षाकोठालाई ''पेपरलेस'' बनाउन के गर्न सक्छन्, र सिकाइमा ''सिमुलेसन'' भन्नाले के बुझिन्छ?', E'पाठ्यपुस्तक हटाएर — भाइरस हटाउनु', E'गृहकार्य/नोट गुगल क्लासरुम वा इमेलमार्फत आदानप्रदान गरेर — वास्तविक परिस्थितिको नक्कल गरी कम्प्युटरमार्फत अभ्यास गराउनु', E'कापी बढी किनेर — फोटोकपी गर्नु', E'कलम नचलाएर — इन्टरनेट स्पिड बढाउनु', E'B', E'**पेपरलेस कक्षाकोठा बनाउन गृहकार्य/नोट गुगल क्लासरुम वा इमेलमार्फत आदानप्रदान गर्न सकिन्छ। सिमुलेसन भनेको वास्तविक परिस्थितिको नक्कल गरी कम्प्युटरमार्फत अभ्यास गराउनु हो (जस्तै पाइलटलाई फ्लाइट सिमुलेटरमा सिकाउनु)।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षकले आफ्नो कक्षाकोठालाई ''पेपरलेस'' बनाउन के गर्न सक्छन्, र सिकाइमा ''सिमुलेसन'' भन्नाले के बुझिन्छ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विज्ञानका प्रयोगात्मक कक्षाहरू (Lab) विद्यालयमा नहुँदा शिक्षकले के को प्रयोग गर्न सक्छन्, र ''युनिकोड'' (Unicode) को प्रयोग शिक्षामा किन महत्त्वपूर्ण छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'विज्ञानका प्रयोगात्मक कक्षाहरू (Lab) विद्यालयमा नहुँदा शिक्षकले के को प्रयोग गर्न सक्छन्, र ''युनिकोड'' (Unicode) को प्रयोग शिक्षामा किन महत्त्वपूर्ण छ?', E'MS Excel — फाइल कम्प्रेस गर्न', E'Padlet — भिडियो हेर्न', E'भर्चुअल ल्याब (जस्तै PhET Simulations) — नेपाली भाषालाई इन्टरनेट/कम्प्युटरमा सर्वमान्य रूपमा लेख्न र पढ्न', E'Kahoot! — पासवर्ड सुरक्षित राख्न', E'C', E'**ल्याब नभएको विद्यालयमा भर्चुअल ल्याब (जस्तै PhET Simulations) प्रयोग गर्न सकिन्छ। युनिकोडले नेपाली भाषालाई इन्टरनेट र कम्प्युटरमा सर्वमान्य रूपमा लेख्न र पढ्न सम्भव बनाउँछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विज्ञानका प्रयोगात्मक कक्षाहरू (Lab) विद्यालयमा नहुँदा शिक्षकले के को प्रयोग गर्न सक्छन्, र ''युनिकोड'' (Unicode) को प्रयोग शिक्षामा किन महत्त्वपूर्ण छ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''रोमन टु युनिकोड'' कन्भर्टरले के काम गर्छ, र प्रिटी (Preeti) फन्ट र युनिकोडमा मुख्य भिन्नता के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'''रोमन टु युनिकोड'' कन्भर्टरले के काम गर्छ, र प्रिटी (Preeti) फन्ट र युनिकोडमा मुख्य भिन्नता के हो?', E'नेपालीलाई अंग्रेजीमा अनुवाद गर्छ — दुवै उस्तै हुन्', E'फाइल डिलिट गर्छ — प्रिटी नयाँ हो, युनिकोड पुरानो हो', E'भाइरस हटाउँछ — युनिकोड फन्ट मात्र हो', E'अंग्रेजी अक्षरमा टाइप गरेको कुरालाई नेपाली (देवनागरी) मा परिणत गर्छ — प्रिटी एउटा डिजाइन (फन्ट) मात्र हो, युनिकोड भाषाको विश्वव्यापी कोडिङ प्रणाली हो', E'D', E'**रोमन टु युनिकोड कन्भर्टरले अंग्रेजी अक्षरमा टाइप गरेको कुरालाई नेपाली (देवनागरी) मा परिणत गर्छ। प्रिटी एउटा फन्ट (डिजाइन) मात्र हो भने युनिकोड भाषाको विश्वव्यापी कोडिङ प्रणाली हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''रोमन टु युनिकोड'' कन्भर्टरले के काम गर्छ, र प्रिटी (Preeti) फन्ट र युनिकोडमा मुख्य भिन्नता के हो?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'गुगल ट्रान्सलेटको मुख्य काम के हो, र नेपालका ग्रामीण क्षेत्रमा ICT प्रयोगमा सबैभन्दा ठूलो चुनौती के छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'गुगल ट्रान्सलेटको मुख्य काम के हो, र नेपालका ग्रामीण क्षेत्रमा ICT प्रयोगमा सबैभन्दा ठूलो चुनौती के छ?', E'एउटा भाषाको लेखलाई अर्को भाषामा अनुवाद गर्ने — भरपर्दो बिजुली र इन्टरनेटको अभाव', E'फोटो सम्पादन गर्ने — शिक्षक धेरै हुनु', E'भिडियो सम्पादन गर्ने — कम्प्युटर सस्तो हुनु', E'फाइल कम्प्रेस गर्ने — पाठ्यपुस्तक धेरै हुनु', E'A', E'**गुगल ट्रान्सलेटको मुख्य काम एउटा भाषाको लेखलाई अर्को भाषामा अनुवाद गर्नु हो। नेपालका ग्रामीण क्षेत्रमा ICT प्रयोगको सबैभन्दा ठूलो चुनौती भरपर्दो बिजुली र इन्टरनेटको अभाव हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:गुगल ट्रान्सलेटको मुख्य काम के हो, र नेपालका ग्रामीण क्षेत्रमा ICT प्रयोगमा सबैभन्दा ठूलो चुनौती के छ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'काम नलाग्ने वा पुराना विद्युतीय उपकरणहरूलाई के भनिन्छ, र ''सूचनाको अतिभार'' (Information Overload) भन्नाले के बुझिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'काम नलाग्ने वा पुराना विद्युतीय उपकरणहरूलाई के भनिन्छ, र ''सूचनाको अतिभार'' (Information Overload) भन्नाले के बुझिन्छ?', E'साइबर बुलिङ — इन्टरनेट स्पिड बढ्नु', E'इ-वेस्ट (E-waste) — इन्टरनेटमा धेरै जानकारी उपलब्ध हुँदा सही र आवश्यक कुरा छनोट गर्न गाह्रो हुनु', E'मालवेयर — फाइल कम भएको अवस्था', E'ब्यान्डविड्थ — जानकारी नै नहुनु', E'B', E'**पुराना/काम नलाग्ने विद्युतीय उपकरणलाई इ-वेस्ट भनिन्छ। सूचनाको अतिभार भनेको इन्टरनेटमा धेरै जानकारी हुँदा सही र आवश्यक कुरा छनोट गर्न गाह्रो हुनु हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:काम नलाग्ने वा पुराना विद्युतीय उपकरणहरूलाई के भनिन्छ, र ''सूचनाको अतिभार'' (Information Overload) भन्नाले के बुझिन्छ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''वान-वे कम्युनिकेशन'' प्रविधि कुन हो, र ''टु-वे कम्युनिकेशन'' प्रविधि कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'''वान-वे कम्युनिकेशन'' प्रविधि कुन हो, र ''टु-वे कम्युनिकेशन'' प्रविधि कुन हो?', E'टेलिफोन — रेडियो', E'इमेल — पत्र', E'रेडियो वा टेलिभिजन — टेलिफोन वा भिडियो कन्फ्रेन्स', E'भिडियो कन्फ्रेन्स — टेलिभिजन', E'C', E'**वान-वे कम्युनिकेशन प्रविधि रेडियो वा टेलिभिजन हो। टु-वे कम्युनिकेशन प्रविधि टेलिफोन वा भिडियो कन्फ्रेन्स हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''वान-वे कम्युनिकेशन'' प्रविधि कुन हो, र ''टु-वे कम्युनिकेशन'' प्रविधि कुन हो?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'डार्क वेब (Dark Web) भनेको के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'डार्क वेब (Dark Web) भनेको के हो?', E'रातको समयमा मात्र चल्ने इन्टरनेट', E'अन्धकार कोठामा प्रयोग गरिने कम्प्युटर', E'इन्टरनेट नभएको ठाउँ', E'इन्टरनेटको त्यो लुकेको भाग जहाँ सामान्य ब्राउजरबाट पुग्न सकिँदैन र प्रायः गैरकानुनी काम हुन्छ', E'D', E'**डार्क वेब इन्टरनेटको त्यो लुकेको भाग हो जहाँ सामान्य ब्राउजरबाट पुग्न सकिँदैन र प्रायः गैरकानुनी काम हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:डार्क वेब (Dark Web) भनेको के हो?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'Ctrl + C र Ctrl + V ले क्रमशः के काम गर्छन्, र Ctrl + X ले के गर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'Ctrl + C र Ctrl + V ले क्रमशः के काम गर्छन्, र Ctrl + X ले के गर्छ?', E'Copy र Paste — Cut', E'Cut र Copy — Paste', E'Paste र Cut — Copy', E'Undo र Redo — Cut', E'A', E'**Ctrl+C ले Copy र Ctrl+V ले Paste गर्छ। Ctrl+X ले Cut (काट्ने) काम गर्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:Ctrl + C र Ctrl + V ले क्रमशः के काम गर्छन्, र Ctrl + X ले के गर्छ?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'Ctrl + Z ले के काम गर्छ, र Ctrl + Y ले के काम गर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'Ctrl + Z ले के काम गर्छ, र Ctrl + Y ले के काम गर्छ?', E'Redo — Undo', E'Undo — Redo', E'Copy — Cut', E'Save — Print', E'B', E'**Ctrl+Z ले Undo (अन्तिम पटक गरेको काम उल्टाउने) गर्छ। Ctrl+Y ले Redo (Undo गरेको फेरि ल्याउने) गर्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:Ctrl + Z ले के काम गर्छ, र Ctrl + Y ले के काम गर्छ?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विन्डोजमा सबै फाइल सेलेक्ट गर्न कुन कीबोर्ड सर्टकट प्रयोग हुन्छ, र कम्प्युटर लक गर्न कुन विन्डोज सर्टकट प्रयोग गरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'विन्डोजमा सबै फाइल सेलेक्ट गर्न कुन कीबोर्ड सर्टकट प्रयोग हुन्छ, र कम्प्युटर लक गर्न कुन विन्डोज सर्टकट प्रयोग गरिन्छ?', E'Ctrl + S — Alt + F4', E'Ctrl + P — Ctrl + Alt + L', E'Ctrl + A — Windows Key + L', E'Ctrl + F — Windows Key + P', E'C', E'**सबै फाइल सेलेक्ट गर्न Ctrl+A प्रयोग हुन्छ। कम्प्युटर लक गर्न Windows Key + L प्रयोग गरिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विन्डोजमा सबै फाइल सेलेक्ट गर्न कुन कीबोर्ड सर्टकट प्रयोग हुन्छ, र कम्प्युटर लक गर्न कुन विन्डोज सर्टकट प्रयोग गरिन्छ?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'हाल चलिरहेको प्रोग्रामलाई बन्द गर्न कुन सर्टकट प्रयोग गरिन्छ, र एउटा प्रोग्रामबाट अर्को प्रोग्राममा जान कुन सर्टकट प्रयोग गरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'हाल चलिरहेको प्रोग्रामलाई बन्द गर्न कुन सर्टकट प्रयोग गरिन्छ, र एउटा प्रोग्रामबाट अर्को प्रोग्राममा जान कुन सर्टकट प्रयोग गरिन्छ?', E'Ctrl + F4 — Ctrl + Tab', E'Alt + Tab — Alt + F4', E'Ctrl + W — Ctrl + Tab', E'Alt + F4 — Alt + Tab', E'D', E'**चलिरहेको प्रोग्राम बन्द गर्न Alt+F4 प्रयोग हुन्छ। एउटा प्रोग्रामबाट अर्कोमा जान Alt+Tab प्रयोग हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:हाल चलिरहेको प्रोग्रामलाई बन्द गर्न कुन सर्टकट प्रयोग गरिन्छ, र एउटा प्रोग्रामबाट अर्को प्रोग्राममा जान कुन सर्टकट प्रयोग गरिन्छ?'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'डेस्कटपको स्क्रिनसट लिन कुन की थिचिन्छ, र कम्प्युटरको ''टास्क म्यानेजर'' खोल्न कुन की संयोजन प्रयोग गरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'डेस्कटपको स्क्रिनसट लिन कुन की थिचिन्छ, र कम्प्युटरको ''टास्क म्यानेजर'' खोल्न कुन की संयोजन प्रयोग गरिन्छ?', E'PrtScn — Ctrl + Shift + Esc', E'F2 — Alt + Tab', E'F5 — Ctrl + Alt + Delete मात्र', E'Delete — Ctrl + P', E'A', E'**स्क्रिनसट लिन PrtScn (Print Screen) थिचिन्छ। टास्क म्यानेजर खोल्न Ctrl+Shift+Esc (वा Ctrl+Alt+Delete) प्रयोग गरिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:डेस्कटपको स्क्रिनसट लिन कुन की थिचिन्छ, र कम्प्युटरको ''टास्क म्यानेजर'' खोल्न कुन की संयोजन प्रयोग गरिन्छ?'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'गुगल क्रोममा नयाँ ट्याब खोल्न कुन सर्टकट प्रयोग हुन्छ, र क्रोममा झुक्किएर बन्द भएको ट्याबलाई फेरि खोल्न कुन सर्टकट प्रयोग हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'गुगल क्रोममा नयाँ ट्याब खोल्न कुन सर्टकट प्रयोग हुन्छ, र क्रोममा झुक्किएर बन्द भएको ट्याबलाई फेरि खोल्न कुन सर्टकट प्रयोग हुन्छ?', E'Ctrl + N — Ctrl + W', E'Ctrl + T — Ctrl + Shift + T', E'Ctrl + Shift + T — Ctrl + T', E'Ctrl + O — Ctrl + P', E'B', E'**क्रोममा नयाँ ट्याब खोल्न Ctrl+T प्रयोग हुन्छ। बन्द भएको ट्याब फेरि खोल्न Ctrl+Shift+T प्रयोग हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:गुगल क्रोममा नयाँ ट्याब खोल्न कुन सर्टकट प्रयोग हुन्छ, र क्रोममा झुक्किएर बन्द भएको ट्याबलाई फेरि खोल्न कुन सर्टकट प्रयोग हुन्छ?'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'इन्टरनेट ब्राउजरको हिस्टोरी डिलिट गर्न कुन सर्टकट प्रयोग हुन्छ, र ब्राउजरमा कुनै कुरा खोज्न (Search/Find) कुन सर्टकट प्रयोग गरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'इन्टरनेट ब्राउजरको हिस्टोरी डिलिट गर्न कुन सर्टकट प्रयोग हुन्छ, र ब्राउजरमा कुनै कुरा खोज्न (Search/Find) कुन सर्टकट प्रयोग गरिन्छ?', E'Ctrl + H — Ctrl + G', E'Ctrl + Delete — Ctrl + S', E'Ctrl + Shift + Delete — Ctrl + F', E'Ctrl + Shift + F — Ctrl + H', E'C', E'**ब्राउजर हिस्टोरी डिलिट गर्न Ctrl+Shift+Delete प्रयोग हुन्छ। ब्राउजरमा कुरा खोज्न Ctrl+F प्रयोग गरिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:इन्टरनेट ब्राउजरको हिस्टोरी डिलिट गर्न कुन सर्टकट प्रयोग हुन्छ, र ब्राउजरमा कुनै कुरा खोज्न (Search/Find) कुन सर्टकट प्रयोग गरिन्छ?'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  RAISE NOTICE 'ग-३ part 2 upsert complete: 3 sets, 44 questions.';
END $$;
