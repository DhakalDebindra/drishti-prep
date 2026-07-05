-- Idempotent UPSERT import: निमावि प्रथम पत्र — ग-३ शिक्षण सिकाइमा ICT को प्रयोग (Level I topic-wise sets)
-- Override same-identity sets/questions; never deletes. Generated 2026-07-05T07:06:17.823Z.
DO $$
DECLARE
  v_module_id uuid := '6695669a-f40e-421a-a4ec-b09bbeaf56c4'::uuid;
  v_set_id uuid;
  v_q_id uuid;
BEGIN

  -- Set: ICT को अवधारणा, महत्व र इ-लर्निङ (आधारभूत तह) (10 Q)
  v_set_id := extensions.uuid_generate_v5('733c0efb-b304-4be4-b92a-fe5f7de85f1b'::uuid, E'ICT को अवधारणा, महत्व र इ-लर्निङ (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'd3a2cc9d-8360-4348-8f7c-07b7c0544f2e'::uuid, '733c0efb-b304-4be4-b92a-fe5f7de85f1b'::uuid, E'ICT को अवधारणा, महत्व र इ-लर्निङ (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '733c0efb-b304-4be4-b92a-fe5f7de85f1b'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षण सिकाइ प्रक्रियामा ICT को मुख्य उद्देश्य के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'शिक्षण सिकाइ प्रक्रियामा ICT को मुख्य उद्देश्य के हो?', E'सिकाइलाई रोचक, प्रभावकारी र विद्यार्थी-केन्द्रित बनाउनु', E'शिक्षकको कार्यबोझ बढाउनु', E'परीक्षा प्रणाली पूर्ण रूपमा खारेज गर्नु', E'पाठ्यपुस्तकको प्रयोग पूर्ण रूपमा हटाउनु', E'A', E'**ICT को मुख्य उद्देश्य सिकाइलाई रोचक, प्रभावकारी र विद्यार्थी-केन्द्रित बनाउनु हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षण सिकाइ प्रक्रियामा ICT को मुख्य उद्देश्य के हो?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'ICT को प्रयोगले शिक्षकको भूमिकालाई कुन रूपमा परिणत गरेको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'ICT को प्रयोगले शिक्षकको भूमिकालाई कुन रूपमा परिणत गरेको छ?', E'सहजकर्ताबाट परीक्षकको रूपमा मात्र', E'ज्ञानको स्रोत (Source of Knowledge) बाट सहजकर्ता (Facilitator) को रूपमा', E'प्रशासकबाट लेखापालको रूपमा', E'यसले शिक्षकको भूमिकामा कुनै परिवर्तन ल्याएको छैन', E'B', E'**ICT ले शिक्षकको भूमिकालाई ज्ञानको स्रोतबाट सहजकर्ता (Facilitator) को रूपमा परिणत गरेको छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:ICT को प्रयोगले शिक्षकको भूमिकालाई कुन रूपमा परिणत गरेको छ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षण सिकाइमा मल्टिमिडिया (Multimedia) भन्नाले के बुझिन्छ, र ''डिजिटल डिभाइड'' (Digital Divide) भन्नाले के बुझिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'शिक्षण सिकाइमा मल्टिमिडिया (Multimedia) भन्नाले के बुझिन्छ, र ''डिजिटल डिभाइड'' (Digital Divide) भन्नाले के बुझिन्छ?', E'केवल भिडियो सामग्री — इन्टरनेट स्पिडको भिन्नता', E'केवल ध्वनि सामग्री — कम्प्युटरका दुई ब्रान्डबीचको भिन्नता', E'पाठ, ध्वनि, चित्र र भिडियोको एकीकृत प्रयोग — सूचना प्रविधिको पहुँच भएका र नभएका बीचको खाडल', E'पाठ र चित्र मात्र — शहर र गाउँबीचको भौतिक दूरी', E'C', E'**मल्टिमिडिया भनेको पाठ, ध्वनि, चित्र र भिडियोको एकीकृत प्रयोग हो। डिजिटल डिभाइड भनेको सूचना प्रविधिको पहुँच भएका र नभएका व्यक्ति वा समुदायबीचको खाडल हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षण सिकाइमा मल्टिमिडिया (Multimedia) भन्नाले के बुझिन्छ, र ''डिजिटल डिभाइड'' (Digital Divide) भन्नाले के बुझिन्छ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'इ-लर्निङ (E-learning) को पूरा रूप के हो, र भौतिक रूपमा कक्षाकोठामा उपस्थित नभई इन्टरनेटको माध्यमबाट गरिने सिकाइलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'इ-लर्निङ (E-learning) को पूरा रूप के हो, र भौतिक रूपमा कक्षाकोठामा उपस्थित नभई इन्टरनेटको माध्यमबाट गरिने सिकाइलाई के भनिन्छ?', E'Extended Learning — कक्षाकोठा सिकाइ', E'External Learning — पुस्तकालय सिकाइ', E'Electronic Learning — रेडियो सिकाइ मात्र', E'Electronic Learning — अनलाइन सिकाइ (Online Learning) वा भर्चुअल सिकाइ', E'D', E'**इ-लर्निङको पूरा रूप Electronic Learning हो। भौतिक कक्षाकोठाबिना इन्टरनेटमार्फत गरिने सिकाइलाई अनलाइन वा भर्चुअल सिकाइ भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:इ-लर्निङ (E-learning) को पूरा रूप के हो, र भौतिक रूपमा कक्षाकोठामा उपस्थित नभई इन्टरनेटको माध्यमबाट गरिने सिकाइलाई के भनिन्छ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षक र विद्यार्थी एकै समयमा अनलाइन जोडिएर गरिने शिक्षण सिकाइलाई के भनिन्छ, र शिक्षकले सामग्री राख्ने र विद्यार्थीले आफ्नो अनुकूल समयमा पढ्ने विधिलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'शिक्षक र विद्यार्थी एकै समयमा अनलाइन जोडिएर गरिने शिक्षण सिकाइलाई के भनिन्छ, र शिक्षकले सामग्री राख्ने र विद्यार्थीले आफ्नो अनुकूल समयमा पढ्ने विधिलाई के भनिन्छ?', E'सिन्क्रोनस लर्निङ (जस्तै Zoom Class) — असिन्क्रोनस लर्निङ (जस्तै रेकर्ड गरिएको भिडियो)', E'असिन्क्रोनस लर्निङ — सिन्क्रोनस लर्निङ', E'ब्लेन्डेड लर्निङ — फ्लिप्ड क्लासरूम', E'सिन्क्रोनस लर्निङ — ब्लेन्डेड लर्निङ', E'A', E'**एकैसाथ जोडिएर हुने शिक्षणलाई सिन्क्रोनस लर्निङ भनिन्छ; आफ्नो अनुकूल समयमा हुने सिकाइलाई असिन्क्रोनस लर्निङ भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षक र विद्यार्थी एकै समयमा अनलाइन जोडिएर गरिने शिक्षण सिकाइलाई के भनिन्छ, र शिक्षकले सामग्री राख्ने र विद्यार्थीले आफ्नो अनुकूल समयमा पढ्ने विधिलाई के भनिन्छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'ब्लेन्डेड लर्निङ (Blended Learning) भनेको के हो, र फ्लिप्ड क्लासरूम (Flipped Classroom) को अवधारणा के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'ब्लेन्डेड लर्निङ (Blended Learning) भनेको के हो, र फ्लिप्ड क्लासरूम (Flipped Classroom) को अवधारणा के हो?', E'पूर्ण अनलाइन सिकाइ मात्र — शिक्षकले घरमा पढ्ने', E'परम्परागत भौतिक कक्षा र अनलाइन सिकाइको मिश्रित रूप — विद्यार्थीले घरमा डिजिटल माध्यमबाट पाठ पढ्ने र कक्षाकोठामा छलफल/अभ्यास गर्ने', E'पूर्ण भौतिक कक्षा मात्र — विद्यार्थीले कक्षामा मात्र पढ्ने', E'मल्टिमिडिया सामग्री — रेडियो शिक्षा', E'B', E'**ब्लेन्डेड लर्निङ परम्परागत भौतिक कक्षा र अनलाइन सिकाइको मिश्रित रूप हो। फ्लिप्ड क्लासरूममा विद्यार्थीले घरमा डिजिटल माध्यमबाट पाठ पढ्छन् र कक्षाकोठामा छलफल वा अभ्यास गर्छन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:ब्लेन्डेड लर्निङ (Blended Learning) भनेको के हो, र फ्लिप्ड क्लासरूम (Flipped Classroom) को अवधारणा के हो?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'MOOC को पूरा रूप के हो, र तलकामध्ये कुन MOOC प्लेटफर्म होइन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'MOOC को पूरा रूप के हो, र तलकामध्ये कुन MOOC प्लेटफर्म होइन?', E'Multiple Open Online Class — Coursera', E'Massive Offline Online Course — edX', E'Massive Open Online Course — MS Word', E'Major Open Online Content — Udemy', E'C', E'**MOOC को पूरा रूप Massive Open Online Course हो। MS Word वर्ड प्रोसेसिङ सफ्टवेयर हो, MOOC प्लेटफर्म होइन — Coursera, edX, Udemy MOOC प्लेटफर्महरू हुन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:MOOC को पूरा रूप के हो, र तलकामध्ये कुन MOOC प्लेटफर्म होइन?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'LMS को पूरा रूप के हो, र Moodle (मुडल) के को उदाहरण हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'LMS को पूरा रूप के हो, र Moodle (मुडल) के को उदाहरण हो?', E'Learning Media System — MOOC को उदाहरण', E'Local Management System — OER को उदाहरण', E'Live Media Support — VR को उदाहरण', E'Learning Management System — LMS को उदाहरण', E'D', E'**LMS को पूरा रूप Learning Management System हो। Moodle LMS को एउटा उदाहरण हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:LMS को पूरा रूप के हो, र Moodle (मुडल) के को उदाहरण हो?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'गुगल क्लासरुम (Google Classroom) को मुख्य काम के हो, र भर्चुअल रियालिटी (VR) को शिक्षामा मुख्य प्रयोग के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'गुगल क्लासरुम (Google Classroom) को मुख्य काम के हो, र भर्चुअल रियालिटी (VR) को शिक्षामा मुख्य प्रयोग के हो?', E'विद्यार्थीलाई असाइनमेन्ट दिन, सामग्री सेयर गर्न र सिकाइ व्यवस्थापन गर्न — कृत्रिम तर वास्तविक जस्तो वातावरणमा प्रयोगात्मक सिकाइ गराउन', E'फोटो सम्पादन गर्न — इमेल पठाउन', E'भिडियो सम्पादन गर्न मात्र — गेम खेल्न', E'स्प्रेडसिट बनाउन — डाटा भण्डारण गर्न', E'A', E'**Google Classroom ले विद्यार्थीलाई असाइनमेन्ट दिने, सामग्री सेयर गर्ने र सिकाइ व्यवस्थापन गर्ने काम गर्छ। VR ले कृत्रिम तर वास्तविक जस्तो वातावरणमा प्रयोगात्मक सिकाइ गराउँछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:गुगल क्लासरुम (Google Classroom) को मुख्य काम के हो, र भर्चुअल रियालिटी (VR) को शिक्षामा मुख्य प्रयोग के हो?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षामा ''डिजिटल साक्षरता'' (Digital Literacy) किन आवश्यक छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'शिक्षामा ''डिजिटल साक्षरता'' (Digital Literacy) किन आवश्यक छ?', E'केवल कम्प्युटर बेच्न', E'डिजिटल उपकरण र जानकारीको सुरक्षित र प्रभावकारी प्रयोग गर्न', E'केवल परीक्षा उत्तीर्ण गर्न', E'पाठ्यपुस्तक हटाउन', E'B', E'**डिजिटल साक्षरता डिजिटल उपकरण र जानकारीको सुरक्षित र प्रभावकारी प्रयोग गर्नका लागि आवश्यक छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षामा ''डिजिटल साक्षरता'' (Digital Literacy) किन आवश्यक छ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: ICT: शिक्षण सामग्री, अफिस प्याकेज र सञ्चार उपकरण (आधारभूत तह) (10 Q)
  v_set_id := extensions.uuid_generate_v5('dbf21b94-3d51-4232-8a6d-23c525693023'::uuid, E'ICT: शिक्षण सामग्री, अफिस प्याकेज र सञ्चार उपकरण (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'd3a2cc9d-8360-4348-8f7c-07b7c0544f2e'::uuid, 'dbf21b94-3d51-4232-8a6d-23c525693023'::uuid, E'ICT: शिक्षण सामग्री, अफिस प्याकेज र सञ्चार उपकरण (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'dbf21b94-3d51-4232-8a6d-23c525693023'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'OER को पूरा रूप के हो, र यसले कस्तो शैक्षिक सामग्रीलाई बुझाउँछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'OER को पूरा रूप के हो, र यसले कस्तो शैक्षिक सामग्रीलाई बुझाउँछ?', E'Open Educational Resources — इन्टरनेटमा निःशुल्क उपलब्ध र अनुमतिसहित प्रयोग/परिमार्जन गर्न सकिने सामग्री', E'Online Education Records — भुक्तानी गरेर मात्र पाइने सामग्री', E'Open Exam Resources — परीक्षा प्रश्नपत्र मात्र', E'Official Education Rule — सरकारी नीति दस्तावेज मात्र', E'A', E'**OER को पूरा रूप Open Educational Resources हो — इन्टरनेटमा निःशुल्क उपलब्ध र अनुमतिसहित प्रयोग वा परिमार्जन गर्न सकिने सामग्री।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:OER को पूरा रूप के हो, र यसले कस्तो शैक्षिक सामग्रीलाई बुझाउँछ?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपाल सरकार (CEHRD) ले सञ्चालन गरेको सिकाइ पोर्टल (सिकाइ चौतारी) को वेबसाइट ठेगाना कुन हो, र यसमा कस्ता सामग्रीहरू राखिएका छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'नेपाल सरकार (CEHRD) ले सञ्चालन गरेको सिकाइ पोर्टल (सिकाइ चौतारी) को वेबसाइट ठेगाना कुन हो, र यसमा कस्ता सामग्रीहरू राखिएका छन्?', E'moe.gov.np — केवल शिक्षक भर्ना सूचना', E'learning.cehrd.gov.np — कक्षा १ देखि १२ सम्मका अन्तरक्रियात्मक डिजिटल पाठ र भिडियो', E'cehrd.gov.np/exam — केवल परीक्षा तालिका', E'learning.gov.np — केवल विश्वविद्यालय तहका सामग्री', E'B', E'**CEHRD को सिकाइ पोर्टल (सिकाइ चौतारी) को ठेगाना learning.cehrd.gov.np हो, जसमा कक्षा १ देखि १२ सम्मका अन्तरक्रियात्मक डिजिटल पाठ र भिडियो राखिएका छन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपाल सरकार (CEHRD) ले सञ्चालन गरेको सिकाइ पोर्टल (सिकाइ चौतारी) को वेबसाइट ठेगाना कुन हो, र यसमा कस्ता सामग्रीहरू राखिएका छन्?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पोडकास्ट (Podcast) कुन प्रकारको सिकाइ सामग्री हो, र ब्लग (Blog) को प्रयोग शिक्षामा कसरी गरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'पोडकास्ट (Podcast) कुन प्रकारको सिकाइ सामग्री हो, र ब्लग (Blog) को प्रयोग शिक्षामा कसरी गरिन्छ?', E'दृश्य (Video) सामग्री — केवल विज्ञापनका लागि', E'पाठ्य सामग्री मात्र — फोटो सम्पादन गर्न', E'श्रव्य (Audio) सामग्री — शिक्षक र विद्यार्थीले आफ्ना विचार, लेख र अनुभव साटासाट गर्न', E'श्रव्य-दृश्य दुवै — केवल खेल खेल्न', E'C', E'**पोडकास्ट श्रव्य (Audio) सामग्री हो। ब्लगको प्रयोग शिक्षक र विद्यार्थीले आफ्ना विचार, लेख र अनुभव साटासाट गर्न गरिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पोडकास्ट (Podcast) कुन प्रकारको सिकाइ सामग्री हो, र ब्लग (Blog) को प्रयोग शिक्षामा कसरी गरिन्छ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पाठयोजना वा प्रश्नपत्र टाइप गर्न कुन सफ्टवेयर उपयुक्त हुन्छ, र विद्यार्थीको नतिजा विश्लेषण र मार्कसिट बनाउन कुन सफ्टवेयर सबैभन्दा बढी प्रयोग गरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'पाठयोजना वा प्रश्नपत्र टाइप गर्न कुन सफ्टवेयर उपयुक्त हुन्छ, र विद्यार्थीको नतिजा विश्लेषण र मार्कसिट बनाउन कुन सफ्टवेयर सबैभन्दा बढी प्रयोग गरिन्छ?', E'MS Excel — MS Word', E'MS PowerPoint — MS Word', E'MS Word — MS PowerPoint', E'MS Word — MS Excel', E'D', E'**पाठयोजना वा प्रश्नपत्र टाइप गर्न MS Word उपयुक्त हुन्छ। नतिजा विश्लेषण र मार्कसिट बनाउन MS Excel सबैभन्दा बढी प्रयोग गरिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पाठयोजना वा प्रश्नपत्र टाइप गर्न कुन सफ्टवेयर उपयुक्त हुन्छ, र विद्यार्थीको नतिजा विश्लेषण र मार्कसिट बनाउन कुन सफ्टवेयर सबैभन्दा बढी प्रयोग गरिन्छ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'MS Excel मा विद्यार्थीको पास वा फेल छुट्याउन कुन लजिकल फर्मुला प्रयोग गरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'MS Excel मा विद्यार्थीको पास वा फेल छुट्याउन कुन लजिकल फर्मुला प्रयोग गरिन्छ?', E'=IF()', E'=SUM()', E'=AVERAGE()', E'=COUNT()', E'A', E'**विद्यार्थीको पास वा फेल छुट्याउन =IF() लजिकल फर्मुला प्रयोग गरिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:MS Excel मा विद्यार्थीको पास वा फेल छुट्याउन कुन लजिकल फर्मुला प्रयोग गरिन्छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यार्थीहरूलाई समूह कार्य (Group Work) गरी अनलाइनमै रिपोर्ट लेख्न लगाउन कुन टुल उपयुक्त हुन्छ, र अनलाइनमार्फत क्विज (Quiz) लिन कुन टुल प्रयोग गरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'विद्यार्थीहरूलाई समूह कार्य (Group Work) गरी अनलाइनमै रिपोर्ट लेख्न लगाउन कुन टुल उपयुक्त हुन्छ, र अनलाइनमार्फत क्विज (Quiz) लिन कुन टुल प्रयोग गरिन्छ?', E'MS PowerPoint — MS Excel', E'Google Docs — Google Forms वा Kahoot!', E'YouTube — Facebook', E'Google Docs — MS Word', E'B', E'**समूह कार्य गरी अनलाइन रिपोर्ट लेख्न Google Docs उपयुक्त हुन्छ। अनलाइन क्विजका लागि Google Forms वा Kahoot! प्रयोग गरिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यार्थीहरूलाई समूह कार्य (Group Work) गरी अनलाइनमै रिपोर्ट लेख्न लगाउन कुन टुल उपयुक्त हुन्छ, र अनलाइनमार्फत क्विज (Quiz) लिन कुन टुल प्रयोग गरिन्छ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''नेटिकेट'' (Netiquette) भन्नाले के बुझिन्छ, र विकी (Wiki) वेबसाइटको मुख्य विशेषता के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'''नेटिकेट'' (Netiquette) भन्नाले के बुझिन्छ, र विकी (Wiki) वेबसाइटको मुख्य विशेषता के हो?', E'इन्टरनेट स्पिड नाप्ने विधि — भुक्तानी गरेर मात्र पढ्न पाइने', E'पासवर्ड बनाउने नियम — केवल एकजनाले सम्पादन गर्न सक्ने', E'इन्टरनेट प्रयोग गर्दा पालना गर्नुपर्ने शिष्टाचार र आचरण — प्रयोगकर्ताहरूले आफैं सम्पादन र जानकारी थप गर्न सक्ने', E'इमेल पठाउने ढाँचा — भिडियो मात्र राख्न सकिने', E'C', E'**नेटिकेट इन्टरनेट प्रयोग गर्दा पालना गर्नुपर्ने शिष्टाचार र आचरण हो। विकीको मुख्य विशेषता भनेको प्रयोगकर्ताहरूले आफैं सम्पादन र जानकारी थप्न सक्नु हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''नेटिकेट'' (Netiquette) भन्नाले के बुझिन्छ, र विकी (Wiki) वेबसाइटको मुख्य विशेषता के हो?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'क्लाउड स्टोरेज (Cloud Storage) भन्नाले के बुझिन्छ, र शिक्षकले शैक्षिक सामग्री अनलाइन सुरक्षित राख्न कुन टुल प्रयोग गर्न सक्छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'क्लाउड स्टोरेज (Cloud Storage) भन्नाले के बुझिन्छ, र शिक्षकले शैक्षिक सामग्री अनलाइन सुरक्षित राख्न कुन टुल प्रयोग गर्न सक्छन्?', E'स्थानीय हार्ड डिस्कमा डाटा राख्ने प्रविधि — पेन ड्राइभ मात्र', E'मोबाइलमा मात्र डाटा राख्ने प्रविधि — Bluetooth', E'प्रिन्ट गरेर राख्ने प्रविधि — CD/DVD मात्र', E'इन्टरनेटको सर्भरमा डाटा सुरक्षित राख्ने प्रविधि — Google Drive वा Dropbox', E'D', E'**क्लाउड स्टोरेज भनेको इन्टरनेटको सर्भरमा डाटा सुरक्षित राख्ने प्रविधि हो (जस्तै Google Drive)। शिक्षकले Google Drive वा Dropbox प्रयोग गर्न सक्छन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:क्लाउड स्टोरेज (Cloud Storage) भन्नाले के बुझिन्छ, र शिक्षकले शैक्षिक सामग्री अनलाइन सुरक्षित राख्न कुन टुल प्रयोग गर्न सक्छन्?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'अनलाइन मिटिङ वा भर्चुअल कक्षा सञ्चालन गर्दा स्क्रिन सेयर (Screen Share) गर्नुको उद्देश्य के हो, र वेबिनार (Webinar) भनेको के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'अनलाइन मिटिङ वा भर्चुअल कक्षा सञ्चालन गर्दा स्क्रिन सेयर (Screen Share) गर्नुको उद्देश्य के हो, र वेबिनार (Webinar) भनेको के हो?', E'शिक्षकको कम्प्युटरमा भएको सामग्री विद्यार्थीलाई देखाउन — इन्टरनेटमार्फत सञ्चालन गरिने सेमिनार वा कार्यशाला', E'इन्टरनेट स्पिड बढाउन — भौतिक कक्षाकोठाको बैठक', E'फाइल डिलिट गर्न — प्रिन्ट गर्ने कार्य', E'भाइरस हटाउन — केवल भिडियो हेर्ने कार्य', E'A', E'**स्क्रिन सेयरको उद्देश्य शिक्षकको कम्प्युटरमा भएको सामग्री विद्यार्थीलाई देखाउनु हो। वेबिनार भनेको इन्टरनेटमार्फत सञ्चालन गरिने सेमिनार वा कार्यशाला हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:अनलाइन मिटिङ वा भर्चुअल कक्षा सञ्चालन गर्दा स्क्रिन सेयर (Screen Share) गर्नुको उद्देश्य के हो, र वेबिनार (Webinar) भनेको के हो?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'डिजिटल सामग्री निर्माण गर्दा शिक्षकले कुन कुरामा बढी ध्यान दिनुपर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'डिजिटल सामग्री निर्माण गर्दा शिक्षकले कुन कुरामा बढी ध्यान दिनुपर्छ?', E'सामग्रीको रङ मात्र', E'सामग्रीको विश्वसनीयता र कपीराइट (Copyright)', E'फाइलको साइज मात्र', E'सामग्री बनाउन लाग्ने समय मात्र', E'B', E'**डिजिटल सामग्री निर्माण गर्दा शिक्षकले सामग्रीको विश्वसनीयता र कपीराइटमा बढी ध्यान दिनुपर्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:डिजिटल सामग्री निर्माण गर्दा शिक्षकले कुन कुरामा बढी ध्यान दिनुपर्छ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: ICT: सिकाइ सिद्धान्त, मूल्याङ्कन र अनलाइन सुरक्षा (आधारभूत तह) (11 Q)
  v_set_id := extensions.uuid_generate_v5('1d49ca8b-75ae-4eb3-abb9-ed5f2766b651'::uuid, E'ICT: सिकाइ सिद्धान्त, मूल्याङ्कन र अनलाइन सुरक्षा (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'd3a2cc9d-8360-4348-8f7c-07b7c0544f2e'::uuid, '1d49ca8b-75ae-4eb3-abb9-ed5f2766b651'::uuid, E'ICT: सिकाइ सिद्धान्त, मूल्याङ्कन र अनलाइन सुरक्षा (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '1d49ca8b-75ae-4eb3-abb9-ed5f2766b651'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुन सिकाइ सिद्धान्तले ''विद्यार्थी आफैले ज्ञानको निर्माण गर्छन्'' भन्ने मान्यता राख्छ, जसलाई ICT ले सघाउँछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'कुन सिकाइ सिद्धान्तले ''विद्यार्थी आफैले ज्ञानको निर्माण गर्छन्'' भन्ने मान्यता राख्छ, जसलाई ICT ले सघाउँछ?', E'निर्माणवाद (Constructivism)', E'व्यवहारवाद (Behaviourism)', E'परम्परावाद', E'संरचनावाद', E'A', E'**निर्माणवाद (Constructivism) सिद्धान्तले विद्यार्थी आफैले ज्ञानको निर्माण गर्छन् भन्ने मान्यता राख्छ, जसलाई ICT ले सघाउँछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुन सिकाइ सिद्धान्तले ''विद्यार्थी आफैले ज्ञानको निर्माण गर्छन्'' भन्ने मान्यता राख्छ, जसलाई ICT ले सघाउँछ?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सिकाइमा ''गेमिफिकेसन'' (Gamification) भन्नाले के बुझिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'सिकाइमा ''गेमिफिकेसन'' (Gamification) भन्नाले के बुझिन्छ?', E'विद्यार्थीलाई खेल खेल्नबाट रोक्नु', E'सिकाइलाई रोचक बनाउन शैक्षिक खेल (Educational Games) को प्रयोग गर्नु', E'परीक्षामा खेल सामेल गर्नु', E'कक्षाकोठामा खेलकुद सामग्री राख्नु मात्र', E'B', E'**गेमिफिकेसन भनेको सिकाइलाई रोचक बनाउन शैक्षिक खेल (Educational Games) को प्रयोग गर्नु हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सिकाइमा ''गेमिफिकेसन'' (Gamification) भन्नाले के बुझिन्छ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'TPACK (Technological Pedagogical Content Knowledge) मोडलको मुख्य सार के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'TPACK (Technological Pedagogical Content Knowledge) मोडलको मुख्य सार के हो?', E'शिक्षकले प्रविधि मात्र जान्नु पर्छ', E'शिक्षकले विषयवस्तु मात्र जान्नु पर्छ', E'प्रभावकारी शिक्षणका लागि शिक्षकमा प्रविधि, पेडागोजी र विषयवस्तुको एकीकृत ज्ञान हुनुपर्छ', E'विद्यार्थीले पेडागोजी जान्नु पर्छ', E'C', E'**TPACK मोडलको मुख्य सार भनेको प्रभावकारी शिक्षणका लागि शिक्षकमा प्रविधि (Technological), पेडागोजी (Pedagogical) र विषयवस्तु (Content) को एकीकृत ज्ञान हुनुपर्छ भन्ने हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:TPACK (Technological Pedagogical Content Knowledge) मोडलको मुख्य सार के हो?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'SAMR मोडल शिक्षामा प्रविधिको एकीकरण मापन गर्ने मोडल हो। यसमा ''S'' ले के जनाउँछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'SAMR मोडल शिक्षामा प्रविधिको एकीकरण मापन गर्ने मोडल हो। यसमा ''S'' ले के जनाउँछ?', E'Software', E'System', E'Smart Technology', E'Substitution (प्रतिस्थापन — जस्तै किताबको सट्टा PDF पढ्नु)', E'D', E'**SAMR मोडलमा ''S'' ले Substitution (प्रतिस्थापन) जनाउँछ — जस्तै किताबको सट्टा PDF पढ्नु।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:SAMR मोडल शिक्षामा प्रविधिको एकीकरण मापन गर्ने मोडल हो। यसमा ''S'' ले के जनाउँछ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दृष्टिविहीन विद्यार्थीहरूका लागि कम्प्युटर चलाउन कुन प्रविधिको प्रयोग गरिन्छ, र यस्ता सहयोगी प्रविधिहरूलाई समग्रमा के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'दृष्टिविहीन विद्यार्थीहरूका लागि कम्प्युटर चलाउन कुन प्रविधिको प्रयोग गरिन्छ, र यस्ता सहयोगी प्रविधिहरूलाई समग्रमा के भनिन्छ?', E'स्क्रिन रिडर (जस्तै NVDA वा JAWS) — असिस्टिभ टेक्नोलोजी (Assistive Technology)', E'माउस — हार्डवेयर', E'किबोर्ड — सफ्टवेयर', E'प्रिन्टर — आउटपुट डिभाइस', E'A', E'**दृष्टिविहीन विद्यार्थीका लागि स्क्रिन रिडर (NVDA वा JAWS जस्ता) प्रयोग गरिन्छ। यस्ता सहयोगी प्रविधिहरूलाई समग्रमा असिस्टिभ टेक्नोलोजी भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दृष्टिविहीन विद्यार्थीहरूका लागि कम्प्युटर चलाउन कुन प्रविधिको प्रयोग गरिन्छ, र यस्ता सहयोगी प्रविधिहरूलाई समग्रमा के भनिन्छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यार्थीले गरेका कामहरूको डिजिटल सङ्ग्रहलाई के भनिन्छ, जुन मूल्याङ्कनको आधार बन्न सक्छ, र OMR को पूरा रूप के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'विद्यार्थीले गरेका कामहरूको डिजिटल सङ्ग्रहलाई के भनिन्छ, जुन मूल्याङ्कनको आधार बन्न सक्छ, र OMR को पूरा रूप के हो?', E'क्लाउड स्टोरेज — Online Mark Report', E'इ-पोर्टफोलियो (E-Portfolio) — Optical Mark Reader', E'ब्लग — Optical Machine Reader', E'इ-पोर्टफोलियो — Open Mark Record', E'B', E'**विद्यार्थीको कामको डिजिटल सङ्ग्रहलाई इ-पोर्टफोलियो भनिन्छ। OMR को पूरा रूप Optical Mark Reader हो, जुन बहुवैकल्पिक उत्तरपुस्तिका जाँच्न प्रयोग गरिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यार्थीले गरेका कामहरूको डिजिटल सङ्ग्रहलाई के भनिन्छ, जुन मूल्याङ्कनको आधार बन्न सक्छ, र OMR को पूरा रूप के हो?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'परीक्षाको नतिजा विश्लेषण (Item Analysis) गर्न ICT को प्रयोग किन गरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'परीक्षाको नतिजा विश्लेषण (Item Analysis) गर्न ICT को प्रयोग किन गरिन्छ?', E'केवल नतिजा छाप्न', E'परीक्षा केन्द्र तोक्न', E'प्रश्नको स्तर र विद्यार्थीको कमजोरी पहिचान गर्न', E'उत्तरपुस्तिका बाँड्न', E'C', E'**Item Analysis ले प्रश्नको स्तर र विद्यार्थीको कमजोरी पहिचान गर्न मद्दत गर्छ, त्यसैले यसमा ICT प्रयोग गरिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:परीक्षाको नतिजा विश्लेषण (Item Analysis) गर्न ICT को प्रयोग किन गरिन्छ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यालयमा प्रयोग हुने कम्प्युटरहरूमा अश्लील वा हानिकारक साइटहरू नखुल्ने बनाउन के प्रयोग गरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'विद्यालयमा प्रयोग हुने कम्प्युटरहरूमा अश्लील वा हानिकारक साइटहरू नखुल्ने बनाउन के प्रयोग गरिन्छ?', E'एन्टिभाइरस मात्र', E'स्क्रिन रिडर', E'OMR', E'कन्टेन्ट फिल्टरिङ सफ्टवेयर (Content Filtering) वा फायरवाल', E'D', E'**अश्लील वा हानिकारक साइटहरू नखुल्ने बनाउन कन्टेन्ट फिल्टरिङ सफ्टवेयर वा फायरवाल प्रयोग गरिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यालयमा प्रयोग हुने कम्प्युटरहरूमा अश्लील वा हानिकारक साइटहरू नखुल्ने बनाउन के प्रयोग गरिन्छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'साहित्यिक चोरी (Plagiarism) भन्नाले के बुझिन्छ, र विद्यार्थीको साहित्यिक चोरी पत्ता लगाउन शिक्षकले कुन टुल प्रयोग गर्न सक्छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'साहित्यिक चोरी (Plagiarism) भन्नाले के बुझिन्छ, र विद्यार्थीको साहित्यिक चोरी पत्ता लगाउन शिक्षकले कुन टुल प्रयोग गर्न सक्छन्?', E'अरूको लेख, विचार वा डाटालाई आफ्नो भनेर प्रस्तुत गर्नु — Plagiarism Checker (जस्तै Turnitin, Grammarly)', E'आफ्नै विचार लेख्नु — Antivirus', E'स्रोत उल्लेख गरी लेख्नु — Firewall', E'समूहमा काम गर्नु — Screen Reader', E'A', E'**साहित्यिक चोरी भनेको अरूको लेख, विचार वा डाटालाई आफ्नो भनेर प्रस्तुत गर्नु हो। यसलाई पत्ता लगाउन Turnitin, Grammarly जस्ता Plagiarism Checker प्रयोग गरिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:साहित्यिक चोरी (Plagiarism) भन्नाले के बुझिन्छ, र विद्यार्थीको साहित्यिक चोरी पत्ता लगाउन शिक्षकले कुन टुल प्रयोग गर्न सक्छन्?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'STEM शिक्षाको पूरा रूप के हो, र रोबोटिक्स (Robotics) लाई विद्यालय शिक्षामा समावेश गर्नुको मुख्य उद्देश्य के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'STEM शिक्षाको पूरा रूप के हो, र रोबोटिक्स (Robotics) लाई विद्यालय शिक्षामा समावेश गर्नुको मुख्य उद्देश्य के हो?', E'Science, Teaching, Education, and Media — कला सीप विकास गर्न', E'Science, Technology, Engineering, and Mathematics — तार्किक, गणितीय र समस्या समाधान गर्ने सीप विकास गर्न', E'Study, Technology, Exam, and Marks — परीक्षा तयारीका लागि', E'Social, Technical, Ethical, and Moral — नैतिक शिक्षाका लागि', E'B', E'**STEM को पूरा रूप Science, Technology, Engineering, and Mathematics हो। रोबोटिक्स समावेश गर्नुको उद्देश्य विद्यार्थीमा तार्किक, गणितीय र समस्या समाधान गर्ने सीप विकास गर्नु हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:STEM शिक्षाको पूरा रूप के हो, र रोबोटिक्स (Robotics) लाई विद्यालय शिक्षामा समावेश गर्नुको मुख्य उद्देश्य के हो?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''डिजिटल सिटिजनसिप'' (Digital Citizenship) भनेको के हो, र शिक्षकले विद्यार्थीलाई इमेल पठाउँदा गोप्यता कायम राख्न सबैको इमेल ठेगाना कुन फिल्डमा राख्नुपर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'''डिजिटल सिटिजनसिप'' (Digital Citizenship) भनेको के हो, र शिक्षकले विद्यार्थीलाई इमेल पठाउँदा गोप्यता कायम राख्न सबैको इमेल ठेगाना कुन फिल्डमा राख्नुपर्छ?', E'इन्टरनेट अनिवार्य प्रयोग गर्नुपर्ने नियम — CC मा', E'नागरिकता प्रमाणपत्र अनलाइन बनाउने प्रक्रिया — To फिल्डमा', E'प्रविधिको जिम्मेवार, सुरक्षित र नैतिकतापूर्ण प्रयोग गर्ने क्षमता — BCC (Blind Carbon Copy) मा', E'मतदान अनलाइन गर्ने अधिकार — Subject फिल्डमा', E'C', E'**डिजिटल सिटिजनसिप भनेको प्रविधिको जिम्मेवार, सुरक्षित र नैतिकतापूर्ण प्रयोग गर्ने क्षमता हो। गोप्यता कायम राख्न सबैको इमेल ठेगाना BCC मा राख्नुपर्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''डिजिटल सिटिजनसिप'' (Digital Citizenship) भनेको के हो, र शिक्षकले विद्यार्थीलाई इमेल पठाउँदा गोप्यता कायम राख्न सबैको इमेल ठेगाना कुन फिल्डमा राख्नुपर्छ?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  RAISE NOTICE 'ग-३ ICT-in-teaching upsert complete: 3 sets, 31 questions.';
END $$;
