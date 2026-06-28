-- Idempotent UPSERT import: निमावि प्रथम पत्र — unit ख-३ सिकाइका सिद्धान्त (theory sets batch)
-- Adds Level I sets alongside preserved model sets. Override same-identity; never deletes. Generated 2026-06-28T05:06:12.083Z.
DO $$
DECLARE
  v_module_id uuid := '6695669a-f40e-421a-a4ec-b09bbeaf56c4'::uuid;
  v_set_id uuid;
  v_q_id uuid;
BEGIN

  -- Set: थर्नडाइकको प्रयत्न र त्रुटि सिद्धान्त र सिकाइ सिद्धान्तको परिचय (आधारभूत तह) (20 Q)
  v_set_id := extensions.uuid_generate_v5('e36b2b2e-9195-45ea-a5e2-6d4dec987e72'::uuid, E'थर्नडाइकको प्रयत्न र त्रुटि सिद्धान्त र सिकाइ सिद्धान्तको परिचय (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '33eadd7e-4fa5-4c91-a18a-850a6af93275'::uuid, 'e36b2b2e-9195-45ea-a5e2-6d4dec987e72'::uuid, E'थर्नडाइकको प्रयत्न र त्रुटि सिद्धान्त र सिकाइ सिद्धान्तको परिचय (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'e36b2b2e-9195-45ea-a5e2-6d4dec987e72'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'प्रयत्न र त्रुटि (Trial and Error) सिकाइ सिद्धान्तका प्रतिपादक को हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'प्रयत्न र त्रुटि (Trial and Error) सिकाइ सिद्धान्तका प्रतिपादक को हुन्?', E'इभान पाभ्लोव', E'इ.एल. थर्नडाइक', E'बी.एफ. स्किनर', E'जिन पियाजे', E'B', E'**प्रयत्न र त्रुटि सिकाइ सिद्धान्तका प्रतिपादक इ.एल. थर्नडाइक (E.L. Thorndike) हुन्।**\\n- इभान पाभ्लोवले शास्त्रीय अनुबन्धन सिद्धान्त दिए।\\n- बी.एफ. स्किनरले कार्यपरक अनुबन्धन सिद्धान्त दिए।\\n- जिन पियाजेले संज्ञानात्मक विकास सिद्धान्त दिए।\\nनोट: थर्नडाइकले सन् १९१३ मा यो सिद्धान्त प्रतिपादन गरेका थिए।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:प्रयत्न र त्रुटि (Trial and Error) सिकाइ सिद्धान्तका प्रतिपादक को हुन्?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'थर्नडाइकले आफ्नो प्रयोग कुन जनावरमा गरेका थिए?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'थर्नडाइकले आफ्नो प्रयोग कुन जनावरमा गरेका थिए?', E'भोको बिरालो', E'कुकुर', E'मुसा', E'चिम्पान्जी', E'A', E'**थर्नडाइकले भोको बिरालो (Hungry Cat) माथि भुलभुलैया बाकस (Puzzle Box) मा राखेर प्रयोग गरेका थिए।**\\n- कुकुरमा पाभ्लोवले प्रयोग गरे।\\n- मुसामा स्किनरले प्रयोग गरे।\\n- चिम्पान्जीमा कोहलरले प्रयोग गरे।\\nनोट: बिरालो भोको हुनु आवश्यक थियो, किनभने भोक (Drive) नभए बिरालो बाकसबाट निस्कन प्रयत्न गर्दैनथ्यो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:थर्नडाइकले आफ्नो प्रयोग कुन जनावरमा गरेका थिए?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'थर्नडाइकले प्रतिपादन गरेको सिद्धान्तलाई अर्को कुन नामले चिनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'थर्नडाइकले प्रतिपादन गरेको सिद्धान्तलाई अर्को कुन नामले चिनिन्छ?', E'अन्तर्दृष्टि सिद्धान्त', E'सामाजिक सिकाइ सिद्धान्त', E'सम्बन्धवाद (Connectionism)', E'निर्माणवाद', E'C', E'**थर्नडाइकले प्रतिपादन गरेको सिद्धान्तलाई सम्बन्धवाद (Connectionism) भनिन्छ।**\\n- अन्तर्दृष्टि सिद्धान्त कोहलरको हो।\\n- सामाजिक सिकाइ सिद्धान्त ब्यान्डुराको हो।\\n- निर्माणवाद पियाजेसँग सम्बन्धित छ।\\nनोट: थर्नडाइकले सिकाइलाई उद्दीपक र प्रतिक्रिया (S-R) बीच सम्बन्ध बन्ने प्रक्रियाका रूपमा हेरे।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:थर्नडाइकले प्रतिपादन गरेको सिद्धान्तलाई अर्को कुन नामले चिनिन्छ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'थर्नडाइकका मुख्य तीन नियम कुन-कुन हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'थर्नडाइकका मुख्य तीन नियम कुन-कुन हुन्?', E'तत्परता, अभ्यास र प्रभावको नियम', E'लोप, सामान्यीकरण र विभेदीकरण', E'अवधान, धारणा र पुनरुत्पादन', E'आत्मसातीकरण, समायोजन र सन्तुलन', E'A', E'**थर्नडाइकका मुख्य तीन नियम तत्परताको नियम (Law of Readiness), अभ्यासको नियम (Law of Exercise) र प्रभावको नियम (Law of Effect) हुन्।**\\n- लोप, सामान्यीकरण पाभ्लोवका अवधारणा हुन्।\\n- अवधान, धारणा, पुनरुत्पादन ब्यान्डुराका सोपान हुन्।\\n- आत्मसातीकरण, समायोजन पियाजेका अवधारणा हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:थर्नडाइकका मुख्य तीन नियम कुन-कुन हुन्?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'थर्नडाइकको कुन नियमअनुसार सन्तुष्टिकारक प्रतिक्रिया दोहोरिन्छ र असन्तुष्टिकारक प्रतिक्रिया दोहोरिँदैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'थर्नडाइकको कुन नियमअनुसार सन्तुष्टिकारक प्रतिक्रिया दोहोरिन्छ र असन्तुष्टिकारक प्रतिक्रिया दोहोरिँदैन?', E'तत्परताको नियम', E'अभ्यासको नियम', E'प्रभावको नियम (Law of Effect)', E'साहचर्यको नियम', E'C', E'**सन्तुष्टिकारक प्रतिक्रिया दोहोरिने र असन्तुष्टिकारक प्रतिक्रिया नदोहोरिने नियमलाई प्रभावको नियम (Law of Effect) भनिन्छ।**\\n- तत्परताको नियमले सिकारु तयार हुँदा सिकाइले सन्तुष्टि दिने कुरा बताउँछ।\\n- अभ्यासको नियमले दोहोर्‍याएर सिकाइ बलियो हुने बताउँछ।\\nनोट: प्रभावको नियमलाई पुरस्कार र दण्डसँग जोडिन्छ — पुरस्कारले सिकाइ बढाउँछ, दण्डले घटाउँछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:थर्नडाइकको कुन नियमअनुसार सन्तुष्टिकारक प्रतिक्रिया दोहोरिन्छ र असन्तुष्टिकारक प्रतिक्रिया दोहोरिँदैन?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'थर्नडाइकको अभ्यासको नियम (Law of Exercise) का दुई उप-नियम कुन हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'थर्नडाइकको अभ्यासको नियम (Law of Exercise) का दुई उप-नियम कुन हुन्?', E'पुरस्कार र दण्डको नियम', E'प्रयोग र अनुपयोगको नियम', E'तत्परता र प्रभावको नियम', E'सामान्यीकरण र विभेदीकरणको नियम', E'B', E'**अभ्यासको नियमका दुई उप-नियम प्रयोगको नियम (Law of Use) र अनुपयोगको नियम (Law of Disuse) हुन्।**\\n- प्रयोगको नियमअनुसार अभ्यासले सिकाइ बलियो हुन्छ।\\n- अनुपयोगको नियमअनुसार अभ्यास नगर्दा सिकेको कुरा बिर्सिन्छ।\\nनोट: पुरस्कार र दण्डको उप-नियम भने प्रभावको नियमअन्तर्गत पर्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:थर्नडाइकको अभ्यासको नियम (Law of Exercise) का दुई उप-नियम कुन हुन्?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'थर्नडाइकको प्रयोगमा बिरालो भोको हुनुलाई कुन तत्त्व मानिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'थर्नडाइकको प्रयोगमा बिरालो भोको हुनुलाई कुन तत्त्व मानिन्छ?', E'ड्राइभ (Drive)', E'उद्दीपक (Stimulus)', E'प्रतिक्रिया (Response)', E'पुनर्बल (Reinforcement)', E'A', E'**थर्नडाइकको प्रयोगमा बिरालो भोको हुनुलाई ड्राइभ (Drive) मानिन्छ।**\\n- माछाको टुक्रा उद्दीपक (Stimulus) हो।\\n- लिभर थिच्नु प्रतिक्रिया (Response) हो।\\n- पजल बक्स बाधा (Obstacle) हो।\\nनोट: भोक नभए बिरालोले बाकसबाट निस्कने प्रयत्न नै गर्दैनथ्यो, त्यसैले ड्राइभ सिकाइको प्रेरक तत्त्व हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:थर्नडाइकको प्रयोगमा बिरालो भोको हुनुलाई कुन तत्त्व मानिन्छ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'थर्नडाइकको सिद्धान्तअनुसार सिकाइ कसरी हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'थर्नडाइकको सिद्धान्तअनुसार सिकाइ कसरी हुन्छ?', E'अकस्मात् अन्तर्दृष्टिबाट', E'अरूको अवलोकन गरेर', E'बिस्तारै-बिस्तारै प्रयत्न र भूल दोहोर्‍याएर', E'सामाजिक अन्तरक्रियाबाट', E'C', E'**थर्नडाइकको सिद्धान्तअनुसार सिकाइ बिस्तारै-बिस्तारै प्रयत्न र भूल (Trial and Error) दोहोर्‍याएर हुन्छ।**\\n- अकस्मात् अन्तर्दृष्टिबाट सिकाइ कोहलरको सिद्धान्तमा हुन्छ।\\n- अवलोकनबाट सिकाइ ब्यान्डुराको सिद्धान्तमा हुन्छ।\\n- सामाजिक अन्तरक्रियाबाट सिकाइ भाइगोत्स्कीको सिद्धान्तमा हुन्छ।\\nनोट: यस सिद्धान्तमा भूल घट्दै जानु नै सिकाइ हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:थर्नडाइकको सिद्धान्तअनुसार सिकाइ कसरी हुन्छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'थर्नडाइकको प्रयत्न र त्रुटि सिद्धान्तमा अन्तर्दृष्टि (Insight) को भूमिका कस्तो हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'थर्नडाइकको प्रयत्न र त्रुटि सिद्धान्तमा अन्तर्दृष्टि (Insight) को भूमिका कस्तो हुन्छ?', E'मुख्य भूमिका हुन्छ', E'कुनै भूमिका हुँदैन', E'आंशिक भूमिका हुन्छ', E'सबैभन्दा महत्त्वपूर्ण हुन्छ', E'B', E'**थर्नडाइकको प्रयत्न र त्रुटि सिद्धान्तमा अन्तर्दृष्टि (Insight) को कुनै भूमिका हुँदैन।**\\nनोट: अन्तर्दृष्टि वा अकस्मात् हुने सिकाइ कोहलरको सिद्धान्तमा हुन्छ; थर्नडाइकको सिकाइ भने यान्त्रिक (Mechanical) र क्रमिक अभ्यासमा आधारित हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:थर्नडाइकको प्रयत्न र त्रुटि सिद्धान्तमा अन्तर्दृष्टि (Insight) को भूमिका कस्तो हुन्छ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'थर्नडाइकको सिद्धान्त निम्नमध्ये कुन प्रकारको कार्य सिक्न उपयुक्त मानिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'थर्नडाइकको सिद्धान्त निम्नमध्ये कुन प्रकारको कार्य सिक्न उपयुक्त मानिन्छ?', E'अमूर्त दार्शनिक चिन्तन', E'जटिल वैज्ञानिक आविष्कार', E'बानी बसाल्न, टाइपराइटर र भाषा सिक्न', E'उच्च तार्किक तर्क', E'C', E'**थर्नडाइकको सिद्धान्त बानी बसाल्न, टाइपराइटर सिक्न, भाषा सिक्न जस्ता साना कार्यका लागि उपयुक्त छ।**\\nनोट: जटिल समस्या (गणित, विज्ञान) समाधान गर्न भने कोहलरको अन्तर्दृष्टि सिद्धान्त बढी उपयुक्त मानिन्छ, किनभने थर्नडाइकको सिद्धान्तले रट्ने (Rote) सिकाइलाई बढावा दिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:थर्नडाइकको सिद्धान्त निम्नमध्ये कुन प्रकारको कार्य सिक्न उपयुक्त मानिन्छ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सिकाइलाई ''व्यवहारमा हुने चेतनापूर्ण र स्थायी परिवर्तन'' भनिन्छ। निम्नमध्ये कुन परिवर्तन सिकाइ होइन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'सिकाइलाई ''व्यवहारमा हुने चेतनापूर्ण र स्थायी परिवर्तन'' भनिन्छ। निम्नमध्ये कुन परिवर्तन सिकाइ होइन?', E'अभ्यासबाट आएको परिवर्तन', E'अनुभवबाट आएको परिवर्तन', E'थकान वा परिपक्वताबाट आएको अल्पकालीन परिवर्तन', E'तालिमबाट आएको परिवर्तन', E'C', E'**थकान, औषधिको प्रभाव वा परिपक्वताका कारण हुने अल्पकालीन परिवर्तन सिकाइ होइन।**\\n- अभ्यास, अनुभव र तालिमबाट आएको स्थायी परिवर्तन भने सिकाइ हो।\\nनोट: सिकाइमा अभ्यास र अनुभवको भूमिका हुन्छ र यो परिवर्तन तुलनात्मक रूपमा स्थायी हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सिकाइलाई ''व्यवहारमा हुने चेतनापूर्ण र स्थायी परिवर्तन'' भनिन्छ। निम्नमध्ये कुन परिवर्तन सिकाइ होइन?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'व्यवहारवादी सिकाइ सिद्धान्तलाई अर्को कुन नामले चिनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'व्यवहारवादी सिकाइ सिद्धान्तलाई अर्को कुन नामले चिनिन्छ?', E'White box theory', E'Black box theory', E'Gestalt theory', E'Field theory', E'B', E'**व्यवहारवादी सिकाइ सिद्धान्तलाई Black box theory पनि भनिन्छ।**\\n- संज्ञानवादी सिद्धान्तलाई भने White box theory भनिन्छ।\\nनोट: व्यवहारवादीले मनभित्रको प्रक्रिया (Black box) नहेरी अवलोकन गर्न सकिने व्यवहारको परिवर्तनमा मात्र जोड दिन्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:व्यवहारवादी सिकाइ सिद्धान्तलाई अर्को कुन नामले चिनिन्छ?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'संज्ञानवादी (Cognitive) सिकाइ सिद्धान्तलाई अर्को कुन नामले चिनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'संज्ञानवादी (Cognitive) सिकाइ सिद्धान्तलाई अर्को कुन नामले चिनिन्छ?', E'Black box theory', E'White box theory', E'R-S theory', E'S-R theory', E'B', E'**संज्ञानवादी सिकाइ सिद्धान्तलाई White box theory भनिन्छ।**\\n- व्यवहारवादी सिद्धान्तलाई Black box theory भनिन्छ।\\nनोट: संज्ञानवादीले सिकाइलाई मानसिक तथा बौद्धिक क्षमताको उपजका रूपमा लिन्छन्, त्यसैले मनभित्रको प्रक्रियालाई महत्त्व दिन्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:संज्ञानवादी (Cognitive) सिकाइ सिद्धान्तलाई अर्को कुन नामले चिनिन्छ?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वर्तमान ज्ञानको संरचनाका आधारमा नयाँ ज्ञान निर्माण गर्न सकिने कुरामा जोड दिने सिद्धान्त कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'वर्तमान ज्ञानको संरचनाका आधारमा नयाँ ज्ञान निर्माण गर्न सकिने कुरामा जोड दिने सिद्धान्त कुन हो?', E'निर्माणवाद (Constructivism)', E'व्यवहारवाद', E'सम्बन्धवाद', E'शास्त्रीय अनुबन्धन', E'A', E'**वर्तमान ज्ञानको संरचनाका आधारमा नयाँ ज्ञान निर्माण गर्न सकिने कुरामा जोड दिने सिद्धान्त निर्माणवाद (Constructivism) हो।**\\n- व्यवहारवाद, सम्बन्धवाद र शास्त्रीय अनुबन्धन भने बाह्य व्यवहारको परिवर्तनमा जोड दिन्छन्।\\nनोट: निर्माणवाद ज्ञानात्मक (संज्ञानात्मक) सिकाइको मुख्य सिद्धान्त हो, जससँग पियाजे र भाइगोत्स्की सम्बन्धित छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वर्तमान ज्ञानको संरचनाका आधारमा नयाँ ज्ञान निर्माण गर्न सकिने कुरामा जोड दिने सिद्धान्त कुन हो?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'थर्नडाइकको कुन नियमअनुसार सिकाइ अघि सिकारुलाई ''तत्पर'' बनाउनुपर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'थर्नडाइकको कुन नियमअनुसार सिकाइ अघि सिकारुलाई ''तत्पर'' बनाउनुपर्छ?', E'तत्परताको नियम (Law of Readiness)', E'प्रभावको नियम', E'अभ्यासको नियम', E'बहुप्रतिक्रियाको नियम', E'A', E'**सिकाइ अघि सिकारुलाई तत्पर बनाउनुपर्छ भन्ने नियम तत्परताको नियम (Law of Readiness) हो।**\\n- प्रभावको नियम पुरस्कार र दण्डसँग सम्बन्धित छ।\\n- अभ्यासको नियम दोहोर्‍याएर सिकाइ बलियो बनाउनेसँग सम्बन्धित छ।\\nनोट: ''मानसिक सेट'' (Mental Set) ले सिकारुलाई सिकाइका लागि तयार पार्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:थर्नडाइकको कुन नियमअनुसार सिकाइ अघि सिकारुलाई ''तत्पर'' बनाउनुपर्छ?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'थर्नडाइकको प्रयोगमा माछाको टुक्रा (मनपर्ने खाना) ले कुन तत्त्वको प्रतिनिधित्व गर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'थर्नडाइकको प्रयोगमा माछाको टुक्रा (मनपर्ने खाना) ले कुन तत्त्वको प्रतिनिधित्व गर्छ?', E'बाधा (Obstacle)', E'उद्दीपक (Stimulus)', E'ड्राइभ (Drive)', E'प्रतिक्रिया (Response)', E'B', E'**थर्नडाइकको प्रयोगमा माछाको टुक्रा उद्दीपक (Stimulus) हो।**\\n- पजल बक्स बाधा (Obstacle) हो।\\n- बिरालो भोको हुनु ड्राइभ (Drive) हो।\\n- लिभर थिच्नु प्रतिक्रिया (Response) हो।\\nनोट: बिरालोले बाकस बाहिर रहेको माछा देख्न सक्ने गरी राखिएको थियो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:थर्नडाइकको प्रयोगमा माछाको टुक्रा (मनपर्ने खाना) ले कुन तत्त्वको प्रतिनिधित्व गर्छ?'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'थर्नडाइकको सिद्धान्त कुन मनोवैज्ञानिक सम्प्रदायसँग सम्बन्धित छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'थर्नडाइकको सिद्धान्त कुन मनोवैज्ञानिक सम्प्रदायसँग सम्बन्धित छ?', E'संज्ञानवाद', E'समग्रवाद', E'व्यवहारवाद', E'मनोविश्लेषणवाद', E'C', E'**थर्नडाइकको सिद्धान्त व्यवहारवाद (Behaviorist school) सँग सम्बन्धित छ र यसले यान्त्रिक (Mechanical) सिकाइमा विश्वास राख्छ।**\\n- समग्रवादसँग कोहलरको अन्तर्दृष्टि सिद्धान्त सम्बन्धित छ।\\n- संज्ञानवादसँग पियाजेको सिद्धान्त सम्बन्धित छ।\\nनोट: पाभ्लोव र स्किनरका सिद्धान्त पनि व्यवहारवादअन्तर्गत नै पर्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:थर्नडाइकको सिद्धान्त कुन मनोवैज्ञानिक सम्प्रदायसँग सम्बन्धित छ?'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'थर्नडाइकले प्रयत्न र त्रुटि सिद्धान्त कुन सालमा प्रतिपादन गरेका थिए?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'थर्नडाइकले प्रयत्न र त्रुटि सिद्धान्त कुन सालमा प्रतिपादन गरेका थिए?', E'सन् १९०४', E'सन् १९१३', E'सन् १९३०', E'सन् १९६१', E'B', E'थर्नडाइकले ''Animal Intelligence'' को अध्ययनबाट सुरु गरी सन् **१९१३** मा प्रयत्न र त्रुटि सिद्धान्त प्रतिपादन गरेका थिए।\\nनोट: पाभ्लोवले १९०४ मा शास्त्रीय अनुबन्धन र ब्यान्डुराले १९६१ मा बोबो डल प्रयोग गरेका थिए।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:थर्नडाइकले प्रयत्न र त्रुटि सिद्धान्त कुन सालमा प्रतिपादन गरेका थिए?'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'थर्नडाइकको सिद्धान्तमा सिकाइ भनेको मूलतः केबीच सम्बन्ध बन्नु हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'थर्नडाइकको सिद्धान्तमा सिकाइ भनेको मूलतः केबीच सम्बन्ध बन्नु हो?', E'उद्दीपक र प्रतिक्रिया (S-R)', E'मोडल र अनुकरण', E'स्कीमा र सन्तुलन', E'भाषा र संस्कृति', E'A', E'**थर्नडाइकको सिद्धान्तमा सिकाइ भनेको उद्दीपक र प्रतिक्रिया (Stimulus-Response) बीच सम्बन्ध बन्नु हो।**\\n- मोडल र अनुकरण ब्यान्डुराको सिद्धान्तसँग सम्बन्धित छ।\\n- स्कीमा र सन्तुलन पियाजेसँग सम्बन्धित छ।\\n- भाषा र संस्कृति भाइगोत्स्कीसँग सम्बन्धित छ।\\nनोट: उद्दीपक भनेको उत्तेजना दिने वस्तु र प्रतिक्रिया भनेको त्यसको जवाफमा गरिने व्यवहार हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:थर्नडाइकको सिद्धान्तमा सिकाइ भनेको मूलतः केबीच सम्बन्ध बन्नु हो?'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'व्यवहारवादी सिकाइ सिद्धान्तले मुख्यतया केमा जोड दिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 20, E'व्यवहारवादी सिकाइ सिद्धान्तले मुख्यतया केमा जोड दिन्छ?', E'अन्तर्दृष्टिबाट समस्या समाधान', E'सिकाइमार्फत व्यवहारको परिवर्तन र परिमार्जन', E'सामाजिक अन्तरक्रिया', E'ज्ञानको आन्तरिक निर्माण', E'B', E'**व्यवहारवादी सिकाइ सिद्धान्तले सिकाइमार्फत व्यवहारको परिवर्तन र परिमार्जनमा जोड दिन्छ।**\\n- अन्तर्दृष्टिबाट समाधान कोहलरको सिद्धान्तले जोड दिन्छ।\\n- सामाजिक अन्तरक्रिया भाइगोत्स्कीले जोड दिन्छन्।\\n- ज्ञानको आन्तरिक निर्माण निर्माणवादले जोड दिन्छ।\\nनोट: पाभ्लोव, थर्नडाइक र स्किनरका सिद्धान्त व्यवहारवादअन्तर्गत पर्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:व्यवहारवादी सिकाइ सिद्धान्तले मुख्यतया केमा जोड दिन्छ?'), v_set_id, v_q_id, 20)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: पियाजेको संज्ञानात्मक विकास र भाइगोत्स्कीको सामाजिक-सांस्कृतिक सिद्धान्त (आधारभूत तह) (20 Q)
  v_set_id := extensions.uuid_generate_v5('e36b2b2e-9195-45ea-a5e2-6d4dec987e72'::uuid, E'पियाजेको संज्ञानात्मक विकास र भाइगोत्स्कीको सामाजिक-सांस्कृतिक सिद्धान्त (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '33eadd7e-4fa5-4c91-a18a-850a6af93275'::uuid, 'e36b2b2e-9195-45ea-a5e2-6d4dec987e72'::uuid, E'पियाजेको संज्ञानात्मक विकास र भाइगोत्स्कीको सामाजिक-सांस्कृतिक सिद्धान्त (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'e36b2b2e-9195-45ea-a5e2-6d4dec987e72'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'संज्ञानात्मक विकास सिद्धान्त (Cognitive Development Theory) का प्रतिपादक को हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'संज्ञानात्मक विकास सिद्धान्त (Cognitive Development Theory) का प्रतिपादक को हुन्?', E'लेभ भाइगोत्स्की', E'जिन पियाजे', E'अल्बर्ट ब्यान्डुरा', E'वुल्फगाङ कोहलर', E'B', E'**संज्ञानात्मक विकास सिद्धान्तका प्रतिपादक स्विस मनोवैज्ञानिक जिन पियाजे (Jean Piaget) हुन्।**\\n- लेभ भाइगोत्स्कीले सामाजिक-सांस्कृतिक सिद्धान्त दिए।\\n- अल्बर्ट ब्यान्डुराले सामाजिक सिकाइ सिद्धान्त दिए।\\n- वुल्फगाङ कोहलरले अन्तर्दृष्टि सिद्धान्त दिए।\\nनोट: पियाजेको सिद्धान्तलाई संरचनावादी/निर्माणवादी (Constructivist) सिद्धान्त भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:संज्ञानात्मक विकास सिद्धान्त (Cognitive Development Theory) का प्रतिपादक को हुन्?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पियाजेका अनुसार बालबालिकालाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'पियाजेका अनुसार बालबालिकालाई के भनिन्छ?', E'साना वैज्ञानिक (Little Scientists)', E'खाली स्लेट', E'निष्क्रिय सिकारु', E'अनुकरणकर्ता', E'A', E'**पियाजेका अनुसार बालबालिका ''साना वैज्ञानिक'' (Little Scientists) हुन्।**\\nनोट: बालबालिकाले संसार बुझ्न निरन्तर प्रश्न गर्ने र प्रयोग गर्ने हुनाले पियाजेले उनीहरूलाई साना वैज्ञानिक भनेका हुन्; उनीहरू आफैं सक्रिय रूपमा ज्ञान निर्माण गर्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पियाजेका अनुसार बालबालिकालाई के भनिन्छ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पियाजेका अनुसार ज्ञानको मानसिक खाका वा भण्डारलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'पियाजेका अनुसार ज्ञानको मानसिक खाका वा भण्डारलाई के भनिन्छ?', E'ZPD', E'स्क्याफोल्डिङ', E'स्कीमा (Schema)', E'मोडल', E'C', E'**पियाजेका अनुसार ज्ञानको मानसिक खाका वा भण्डारलाई स्कीमा (Schema) भनिन्छ।**\\n- ZPD र स्क्याफोल्डिङ भाइगोत्स्कीका अवधारणा हुन्।\\n- मोडल ब्यान्डुराको अवधारणा हो।\\nनोट: नयाँ अनुभवअनुसार स्कीमा परिमार्जन हुँदै जान्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पियाजेका अनुसार ज्ञानको मानसिक खाका वा भण्डारलाई के भनिन्छ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नयाँ ज्ञानलाई पुरानो स्कीमामा जोड्ने प्रक्रियालाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'नयाँ ज्ञानलाई पुरानो स्कीमामा जोड्ने प्रक्रियालाई के भनिन्छ?', E'आत्मसातीकरण (Assimilation)', E'समायोजन (Accommodation)', E'सन्तुलन (Equilibration)', E'स्क्याफोल्डिङ', E'A', E'**नयाँ ज्ञानलाई पुरानो स्कीमामा जोड्ने प्रक्रियालाई आत्मसातीकरण (Assimilation) भनिन्छ।**\\n- समायोजन (Accommodation) भने नयाँ ज्ञानअनुसार पुरानो स्कीमा बदल्ने प्रक्रिया हो।\\n- सन्तुलन (Equilibration) नयाँ र पुरानो ज्ञानबीच सामञ्जस्य मिलाउने प्रक्रिया हो।\\nनोट: आत्मसातीकरणमा स्कीमा नबदली नयाँ कुरालाई पुरानै ढाँचामा राखिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नयाँ ज्ञानलाई पुरानो स्कीमामा जोड्ने प्रक्रियालाई के भनिन्छ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नयाँ ज्ञानअनुसार पुरानो स्कीमालाई परिमार्जन गर्ने प्रक्रियालाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'नयाँ ज्ञानअनुसार पुरानो स्कीमालाई परिमार्जन गर्ने प्रक्रियालाई के भनिन्छ?', E'आत्मसातीकरण', E'समायोजन (Accommodation)', E'सन्तुलन', E'केन्द्रीकरण', E'B', E'**नयाँ ज्ञानअनुसार पुरानो स्कीमालाई परिमार्जन गर्ने प्रक्रियालाई समायोजन (Accommodation) भनिन्छ।**\\n- आत्मसातीकरणमा भने स्कीमा नबदली नयाँ ज्ञान पुरानैमा जोडिन्छ।\\n- सन्तुलन दुवै प्रक्रियाबीच सामञ्जस्य ल्याउने अवस्था हो।\\nनोट: संज्ञानात्मक विकासको क्रम स्कीमा निर्माण → आत्मसातीकरण → द्वन्द्व → समायोजन → सन्तुलन हुँदै अघि बढ्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नयाँ ज्ञानअनुसार पुरानो स्कीमालाई परिमार्जन गर्ने प्रक्रियालाई के भनिन्छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पियाजेका अनुसार संज्ञानात्मक विकासका मुख्य कति चरण छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'पियाजेका अनुसार संज्ञानात्मक विकासका मुख्य कति चरण छन्?', E'दुई', E'तीन', E'चार', E'पाँच', E'C', E'**पियाजेका अनुसार संज्ञानात्मक विकासका मुख्य चार चरण छन्।**\\nनोट: यी हुन् — इन्द्रियगत/संवेदी (०-२ वर्ष), पूर्व-संक्रियात्मक (२-७ वर्ष), मूर्त संक्रियात्मक (७-११ वर्ष) र औपचारिक संक्रियात्मक (११-१५+ वर्ष)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पियाजेका अनुसार संज्ञानात्मक विकासका मुख्य कति चरण छन्?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पियाजेको कुन चरणमा वस्तु स्थायित्व (Object Permanence) को विकास हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'पियाजेको कुन चरणमा वस्तु स्थायित्व (Object Permanence) को विकास हुन्छ?', E'इन्द्रियगत/संवेदी चरण (०-२ वर्ष)', E'पूर्व-संक्रियात्मक चरण (२-७ वर्ष)', E'मूर्त संक्रियात्मक चरण (७-११ वर्ष)', E'औपचारिक संक्रियात्मक चरण (११-१५+ वर्ष)', E'A', E'**वस्तु स्थायित्व (Object Permanence) इन्द्रियगत/संवेदी चरण (०-२ वर्ष) को मुख्य उपलब्धि हो।**\\nनोट: वस्तु स्थायित्व भनेको आँखा अगाडि नहुँदा पनि वस्तुको अस्तित्व छ भन्ने बुझ्नु हो; यसले बालबालिकामा स्मृति शक्तिको विकास भएको जनाउँछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पियाजेको कुन चरणमा वस्तु स्थायित्व (Object Permanence) को विकास हुन्छ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'आत्म-केन्द्रित सोच (Egocentrism) पियाजेको कुन चरणको विशेषता हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'आत्म-केन्द्रित सोच (Egocentrism) पियाजेको कुन चरणको विशेषता हो?', E'इन्द्रियगत/संवेदी चरण', E'पूर्व-संक्रियात्मक चरण (२-७ वर्ष)', E'मूर्त संक्रियात्मक चरण', E'औपचारिक संक्रियात्मक चरण', E'B', E'**आत्म-केन्द्रित सोच (Egocentrism) पूर्व-संक्रियात्मक चरण (२-७ वर्ष) को विशेषता हो।**\\nनोट: यस चरणमा प्रतीकात्मक सोच र केन्द्रीकरण (Centration) पनि देखिन्छ, तर तर्क पूर्ण हुँदैन; बालकले अरूको दृष्टिकोणबाट सोच्न सक्दैन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:आत्म-केन्द्रित सोच (Egocentrism) पियाजेको कुन चरणको विशेषता हो?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'संरक्षणको अवधारणा (Conservation) र तार्किक सोचको सुरुवात पियाजेको कुन चरणमा हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'संरक्षणको अवधारणा (Conservation) र तार्किक सोचको सुरुवात पियाजेको कुन चरणमा हुन्छ?', E'इन्द्रियगत/संवेदी चरण', E'पूर्व-संक्रियात्मक चरण', E'मूर्त संक्रियात्मक चरण (७-११ वर्ष)', E'औपचारिक संक्रियात्मक चरण', E'C', E'**संरक्षणको अवधारणा (Conservation), विकेन्द्रीकरण र तार्किक सोचको सुरुवात मूर्त संक्रियात्मक चरण (७-११ वर्ष) मा हुन्छ।**\\nनोट: यस चरणमा बालबालिकाले तर्क गर्न सक्छन्, तर आफूले देखेका (मूर्त) वस्तुमा आधारित रहेर मात्र; अमूर्त सोच भने औपचारिक चरणमा विकास हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:संरक्षणको अवधारणा (Conservation) र तार्किक सोचको सुरुवात पियाजेको कुन चरणमा हुन्छ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'अमूर्त सोच (Abstract Thinking) र परिकल्पनात्मक सोच पियाजेको कुन चरणको विशेषता हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'अमूर्त सोच (Abstract Thinking) र परिकल्पनात्मक सोच पियाजेको कुन चरणको विशेषता हो?', E'औपचारिक संक्रियात्मक चरण (११-१५+ वर्ष)', E'मूर्त संक्रियात्मक चरण', E'पूर्व-संक्रियात्मक चरण', E'इन्द्रियगत/संवेदी चरण', E'A', E'**अमूर्त सोच, परिकल्पनात्मक सोच र वैज्ञानिक सोच औपचारिक संक्रियात्मक चरण (११-१५+ वर्ष) का विशेषता हुन्।**\\nनोट: यस चरणमा किशोरहरूले परिकल्पना (Hypothesis) बनाएर परीक्षण गर्न सक्ने हुनाले वैज्ञानिक सोच विकास हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:अमूर्त सोच (Abstract Thinking) र परिकल्पनात्मक सोच पियाजेको कुन चरणको विशेषता हो?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पियाजेको सिद्धान्तमा शिक्षकको भूमिका कस्तो हुनुपर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'पियाजेको सिद्धान्तमा शिक्षकको भूमिका कस्तो हुनुपर्छ?', E'ज्ञान दिने मुख्य स्रोत', E'सहजकर्ता (Facilitator)', E'कडा अनुशासक', E'निष्क्रिय पर्यवेक्षक', E'B', E'**पियाजेको सिद्धान्तमा शिक्षकको भूमिका सहजकर्ता (Facilitator) हुनुपर्छ।**\\nनोट: विद्यार्थी आफैंले ज्ञान निर्माण गर्ने हुनाले शिक्षकले बाटो मात्र देखाउनुपर्छ; सिकाइ सक्रिय र अन्वेषण (Discovery) मा आधारित प्रक्रिया हो र उमेरअनुसारको पाठ्यक्रम पियाजेको महत्त्वपूर्ण सुझाव हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पियाजेको सिद्धान्तमा शिक्षकको भूमिका कस्तो हुनुपर्छ?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सामाजिक-सांस्कृतिक सिद्धान्त (Socio-Cultural Theory) का प्रतिपादक को हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'सामाजिक-सांस्कृतिक सिद्धान्त (Socio-Cultural Theory) का प्रतिपादक को हुन्?', E'जिन पियाजे', E'अल्बर्ट ब्यान्डुरा', E'लेभ भाइगोत्स्की', E'बी.एफ. स्किनर', E'C', E'**सामाजिक-सांस्कृतिक सिद्धान्तका प्रतिपादक रुसी मनोवैज्ञानिक लेभ भाइगोत्स्की (Lev Vygotsky) हुन्।**\\n- जिन पियाजेले संज्ञानात्मक विकास सिद्धान्त दिए।\\n- अल्बर्ट ब्यान्डुराले सामाजिक सिकाइ सिद्धान्त दिए।\\n- बी.एफ. स्किनरले कार्यपरक अनुबन्धन सिद्धान्त दिए।\\nनोट: यो सिद्धान्तलाई सामाजिक-संरचनावादी (Social Constructivist) पनि भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सामाजिक-सांस्कृतिक सिद्धान्त (Socio-Cultural Theory) का प्रतिपादक को हुन्?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'भाइगोत्स्कीका अनुसार विद्यार्थीले आफैं गर्न सक्ने र सहयोगबिना गर्न नसक्ने बीचको सम्भावित क्षमताको क्षेत्रलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'भाइगोत्स्कीका अनुसार विद्यार्थीले आफैं गर्न सक्ने र सहयोगबिना गर्न नसक्ने बीचको सम्भावित क्षमताको क्षेत्रलाई के भनिन्छ?', E'स्कीमा', E'ZPD (Zone of Proximal Development)', E'स्क्याफोल्डिङ', E'सन्तुलन', E'B', E'**विद्यार्थीले आफैं गर्न सक्ने र सहयोगबिना गर्न नसक्ने बीचको सम्भावित क्षमताको क्षेत्रलाई ZPD (Zone of Proximal Development) भनिन्छ।**\\n- स्कीमा र सन्तुलन पियाजेका अवधारणा हुन्।\\n- स्क्याफोल्डिङ भने सिक्न दिइने सहयोग हो।\\nनोट: ZPD सिकाइको उच्च सीमा होइन, यो विद्यार्थीले सहयोगसहित सिक्न सक्ने ''सम्भावित क्षमता'' को क्षेत्र हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:भाइगोत्स्कीका अनुसार विद्यार्थीले आफैं गर्न सक्ने र सहयोगबिना गर्न नसक्ने बीचको सम्भावित क्षमताको क्षेत्रलाई के भनिन्छ?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'भाइगोत्स्कीका अनुसार सिक्नका लागि दिइने अस्थायी सहयोगलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'भाइगोत्स्कीका अनुसार सिक्नका लागि दिइने अस्थायी सहयोगलाई के भनिन्छ?', E'स्क्याफोल्डिङ (Scaffolding)', E'आत्मसातीकरण', E'पुनर्बल', E'अनुकरण', E'A', E'**सिक्नका लागि दिइने अस्थायी सहयोगलाई स्क्याफोल्डिङ (Scaffolding) भनिन्छ।**\\nनोट: स्क्याफोल्डिङ सधैं दिइरहनु हुँदैन; विद्यार्थीले सिक्दै गएपछि सहयोग कम गर्दै लैजानुपर्छ, किनभने यो अस्थायी सहयोग हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:भाइगोत्स्कीका अनुसार सिक्नका लागि दिइने अस्थायी सहयोगलाई के भनिन्छ?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'भाइगोत्स्कीको सिद्धान्तमा MKO (More Knowledgeable Other) भनेको के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'भाइगोत्स्कीको सिद्धान्तमा MKO (More Knowledgeable Other) भनेको के हो?', E'ज्ञानको मानसिक खाका', E'आफूभन्दा बढी जान्ने व्यक्ति', E'अस्थायी सहयोग', E'सम्भावित क्षमताको क्षेत्र', E'B', E'**MKO (More Knowledgeable Other) भनेको आफूभन्दा बढी जान्ने व्यक्ति हो, जुन शिक्षक, अभिभावक वा जान्ने साथी पनि हुन सक्छ।**\\nनोट: भाइगोत्स्कीका अनुसार बालकले एक्लै भन्दा MKO सँग मिलेर छिटो र प्रभावकारी सिक्छ, किनभने सिकाइ सामाजिक अन्तरक्रियाबाट हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:भाइगोत्स्कीको सिद्धान्तमा MKO (More Knowledgeable Other) भनेको के हो?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'भाइगोत्स्कीका अनुसार संज्ञानात्मक विकासको मुख्य औजार (Tool) के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'भाइगोत्स्कीका अनुसार संज्ञानात्मक विकासको मुख्य औजार (Tool) के हो?', E'अनुकरण', E'पुनर्बल', E'भाषा (Language)', E'अन्तर्दृष्टि', E'C', E'**भाइगोत्स्कीका अनुसार भाषा (Language) संज्ञानात्मक विकासको मुख्य औजार हो।**\\nनोट: विचारलाई निर्देशित गर्ने भाषालाई ''आन्तरिक संवाद'' (Inner/Private Speech) भनिन्छ; भाषाले हाम्रा विचार र सामाजिक सम्बन्धलाई सङ्गठित गर्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:भाइगोत्स्कीका अनुसार संज्ञानात्मक विकासको मुख्य औजार (Tool) के हो?'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''सिकाइले विकासलाई डोर्‍याउँछ'' (Learning precedes development) भन्ने मान्यता कसको हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'''सिकाइले विकासलाई डोर्‍याउँछ'' (Learning precedes development) भन्ने मान्यता कसको हो?', E'जिन पियाजे', E'लेभ भाइगोत्स्की', E'इ.एल. थर्नडाइक', E'इभान पाभ्लोव', E'B', E'**''सिकाइले विकासलाई डोर्‍याउँछ'' भन्ने मान्यता लेभ भाइगोत्स्कीको हो।**\\n- पियाजेका अनुसार भने ''विकासले सिकाइलाई डोर्‍याउँछ'' (Development precedes learning)।\\nनोट: पियाजेले वैयक्तिक अन्वेषण र जैविक परिपक्वतालाई जोड दिए भने भाइगोत्स्कीले सामाजिक अन्तरक्रिया र संस्कृतिलाई जोड दिए।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''सिकाइले विकासलाई डोर्‍याउँछ'' (Learning precedes development) भन्ने मान्यता कसको हो?'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पियाजेका अनुसार ज्ञानको नयाँ र पुरानो अवस्थाबीच सामञ्जस्य मिलाउने प्रक्रियालाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'पियाजेका अनुसार ज्ञानको नयाँ र पुरानो अवस्थाबीच सामञ्जस्य मिलाउने प्रक्रियालाई के भनिन्छ?', E'आत्मसातीकरण', E'समायोजन', E'सन्तुलन (Equilibration)', E'स्क्याफोल्डिङ', E'C', E'**ज्ञानको नयाँ र पुरानो अवस्थाबीच सामञ्जस्य मिलाउने प्रक्रियालाई सन्तुलन (Equilibration) भनिन्छ।**\\n- आत्मसातीकरणमा नयाँ ज्ञान पुरानो स्कीमामा जोडिन्छ।\\n- समायोजनमा स्कीमा परिमार्जन हुन्छ।\\n- स्क्याफोल्डिङ भाइगोत्स्कीको अवधारणा हो।\\nनोट: सन्तुलनले द्वन्द्व (Disequilibrium) पछि ज्ञानमा स्थिरता ल्याउँछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पियाजेका अनुसार ज्ञानको नयाँ र पुरानो अवस्थाबीच सामञ्जस्य मिलाउने प्रक्रियालाई के भनिन्छ?'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पियाजेको पूर्व-संक्रियात्मक चरण कति उमेर अवधिको हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'पियाजेको पूर्व-संक्रियात्मक चरण कति उमेर अवधिको हो?', E'०-२ वर्ष', E'२-७ वर्ष', E'७-११ वर्ष', E'११-१५ वर्ष', E'B', E'**पियाजेको पूर्व-संक्रियात्मक चरण (Pre-operational) २-७ वर्षको हो।**\\n- ०-२ वर्ष इन्द्रियगत/संवेदी चरण हो।\\n- ७-११ वर्ष मूर्त संक्रियात्मक चरण हो।\\n- ११-१५+ वर्ष औपचारिक संक्रियात्मक चरण हो।\\nनोट: यस चरणमा आत्म-केन्द्रित र प्रतीकात्मक सोच देखिन्छ तर तर्क पूर्ण हुँदैन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पियाजेको पूर्व-संक्रियात्मक चरण कति उमेर अवधिको हो?'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पियाजे र भाइगोत्स्कीको सिद्धान्तबीचको मुख्य भिन्नता के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 20, E'पियाजे र भाइगोत्स्कीको सिद्धान्तबीचको मुख्य भिन्नता के हो?', E'पियाजेले वैयक्तिक अन्वेषण र भाइगोत्स्कीले सामाजिक अन्तरक्रियालाई जोड दिए', E'दुवैले पुनर्बललाई जोड दिए', E'दुवैले अन्तर्दृष्टिलाई जोड दिए', E'पियाजेले सामाजिक र भाइगोत्स्कीले जैविक पक्षलाई जोड दिए', E'A', E'**पियाजेले वैयक्तिक अन्वेषण र जैविक परिपक्वतालाई जोड दिए भने भाइगोत्स्कीले सामाजिक अन्तरक्रिया र संस्कृतिलाई जोड दिए।**\\nनोट: यही कारण पियाजेका अनुसार विकासले सिकाइलाई डोर्‍याउँछ भने भाइगोत्स्कीका अनुसार सिकाइले विकासलाई डोर्‍याउँछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पियाजे र भाइगोत्स्कीको सिद्धान्तबीचको मुख्य भिन्नता के हो?'), v_set_id, v_q_id, 20)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: ब्यान्डुराको सामाजिक सिकाइ र कोहलरको अन्तर्दृष्टि सिद्धान्त (आधारभूत तह) (20 Q)
  v_set_id := extensions.uuid_generate_v5('e36b2b2e-9195-45ea-a5e2-6d4dec987e72'::uuid, E'ब्यान्डुराको सामाजिक सिकाइ र कोहलरको अन्तर्दृष्टि सिद्धान्त (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '33eadd7e-4fa5-4c91-a18a-850a6af93275'::uuid, 'e36b2b2e-9195-45ea-a5e2-6d4dec987e72'::uuid, E'ब्यान्डुराको सामाजिक सिकाइ र कोहलरको अन्तर्दृष्टि सिद्धान्त (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'e36b2b2e-9195-45ea-a5e2-6d4dec987e72'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सामाजिक सिकाइ सिद्धान्त (Social Learning Theory) का प्रतिपादक को हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'सामाजिक सिकाइ सिद्धान्त (Social Learning Theory) का प्रतिपादक को हुन्?', E'अल्बर्ट ब्यान्डुरा', E'लेभ भाइगोत्स्की', E'वुल्फगाङ कोहलर', E'बी.एफ. स्किनर', E'A', E'**सामाजिक सिकाइ सिद्धान्तका प्रतिपादक क्यानेडियन-अमेरिकी मनोवैज्ञानिक अल्बर्ट ब्यान्डुरा (Albert Bandura) हुन्।**\\n- लेभ भाइगोत्स्कीले सामाजिक-सांस्कृतिक सिद्धान्त दिए।\\n- वुल्फगाङ कोहलरले अन्तर्दृष्टि सिद्धान्त दिए।\\n- बी.एफ. स्किनरले कार्यपरक अनुबन्धन सिद्धान्त दिए।\\nनोट: यो सिद्धान्तलाई पछि सामाजिक संज्ञानात्मक सिद्धान्त (Social Cognitive Theory) भनियो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सामाजिक सिकाइ सिद्धान्त (Social Learning Theory) का प्रतिपादक को हुन्?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'ब्यान्डुराको सामाजिक सिकाइ सिद्धान्तको मुख्य आधार के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'ब्यान्डुराको सामाजिक सिकाइ सिद्धान्तको मुख्य आधार के हो?', E'पुनर्बल र दण्ड', E'अवलोकन र अनुकरण (Observation and Imitation)', E'अनुकूलित प्रतिक्रिया', E'प्रयत्न र भूल', E'B', E'**ब्यान्डुराको सामाजिक सिकाइ सिद्धान्तको मुख्य आधार अवलोकन (Observation) र अनुकरण (Imitation) हो।**\\n- पुनर्बल र दण्ड स्किनरको सिद्धान्तसँग सम्बन्धित छन्।\\n- अनुकूलित प्रतिक्रिया पाभ्लोवसँग सम्बन्धित छ।\\n- प्रयत्न र भूल थर्नडाइकसँग सम्बन्धित छ।\\nनोट: यो सिद्धान्तले ''अरूको व्यवहार हेरेर सिक्ने'' कुरामा जोड दिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:ब्यान्डुराको सामाजिक सिकाइ सिद्धान्तको मुख्य आधार के हो?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'ब्यान्डुराले बालबालिकाको आक्रामक व्यवहारको अध्ययन गर्न कुन प्रयोग गरेका थिए?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'ब्यान्डुराले बालबालिकाको आक्रामक व्यवहारको अध्ययन गर्न कुन प्रयोग गरेका थिए?', E'स्किनर बक्स', E'पजल बक्स', E'बोबो डल (Bobo Doll)', E'घन्टी र खाना', E'C', E'**ब्यान्डुराले बालबालिकाको आक्रामक व्यवहारको अध्ययन गर्न बोबो डल (Bobo Doll - प्लास्टिकको खेलौना) प्रयोग गरेका थिए।**\\n- स्किनर बक्स स्किनरले प्रयोग गरे।\\n- पजल बक्स थर्नडाइकले प्रयोग गरे।\\n- घन्टी र खाना पाभ्लोवले प्रयोग गरे।\\nनोट: ब्यान्डुराले सन् १९६१ मा बालबालिका र बोबो डलमा यो प्रयोग गरेका थिए।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:ब्यान्डुराले बालबालिकाको आक्रामक व्यवहारको अध्ययन गर्न कुन प्रयोग गरेका थिए?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'ब्यान्डुराका अनुसार सामाजिक सिकाइका चार सोपानको सही क्रम कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'ब्यान्डुराका अनुसार सामाजिक सिकाइका चार सोपानको सही क्रम कुन हो?', E'अवधान → धारणा → पुनरुत्पादन → अभिप्रेरणा', E'अभिप्रेरणा → अवधान → धारणा → पुनरुत्पादन', E'धारणा → अवधान → अभिप्रेरणा → पुनरुत्पादन', E'पुनरुत्पादन → धारणा → अवधान → अभिप्रेरणा', E'A', E'**सामाजिक सिकाइका चार सोपानको सही क्रम: अवधान (Attention) → धारणा (Retention) → पुनरुत्पादन (Reproduction) → अभिप्रेरणा (Motivation) हो।**\\nनोट: पहिले मोडलको व्यवहार हेर्ने (अवधान), अनि सम्झने (धारणा), त्यसपछि व्यवहारमा उतार्ने (पुनरुत्पादन) र अन्त्यमा पुनर्बलले निरन्तरता दिने (अभिप्रेरणा)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:ब्यान्डुराका अनुसार सामाजिक सिकाइका चार सोपानको सही क्रम कुन हो?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'ब्यान्डुराको सिद्धान्तमा मोडल (Model) भनेको के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'ब्यान्डुराको सिद्धान्तमा मोडल (Model) भनेको के हो?', E'ज्ञानको मानसिक खाका', E'जसको व्यवहार अनुकरण गरिन्छ', E'अस्थायी सहयोग', E'पुरस्कार दिने उपकरण', E'B', E'**ब्यान्डुराको सिद्धान्तमा मोडल (Model) भनेको त्यो व्यक्ति हो जसको व्यवहार अनुकरण गरिन्छ।**\\nनोट: मोडल चर्चित, आकर्षक र सम्मानित व्यक्ति हुँदा अनुकरण बढी हुन्छ; यसैले शिक्षक आफैं विद्यार्थीका लागि एउटा मोडल हुनुपर्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:ब्यान्डुराको सिद्धान्तमा मोडल (Model) भनेको के हो?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''म यो काम गर्न सक्छु'' भन्ने आत्म-विश्वासलाई ब्यान्डुराले कुन नाम दिए?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'''म यो काम गर्न सक्छु'' भन्ने आत्म-विश्वासलाई ब्यान्डुराले कुन नाम दिए?', E'स्व-प्रभावकारिता (Self-Efficacy)', E'आत्म-केन्द्रितता', E'आत्मसातीकरण', E'आत्म-यथार्थीकरण', E'A', E'**''म यो काम गर्न सक्छु'' भन्ने आत्म-विश्वासलाई ब्यान्डुराले स्व-प्रभावकारिता (Self-Efficacy) भने।**\\n- आत्म-केन्द्रितता (Egocentrism) पियाजेको अवधारणा हो।\\n- आत्मसातीकरण पनि पियाजेको अवधारणा हो।\\n- आत्म-यथार्थीकरण मास्लोको अवधारणा हो।\\nनोट: स्व-प्रभावकारिता अवधारणा ब्यान्डुराले नै ल्याएका हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''म यो काम गर्न सक्छु'' भन्ने आत्म-विश्वासलाई ब्यान्डुराले कुन नाम दिए?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'अवलोकनद्वारा हुने सिकाइलाई अर्को कुन नामले पनि चिनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'अवलोकनद्वारा हुने सिकाइलाई अर्को कुन नामले पनि चिनिन्छ?', E'Rote Learning', E'Vicarious Learning', E'Insight Learning', E'Programmed Learning', E'B', E'**अवलोकनद्वारा हुने सिकाइलाई Vicarious Learning पनि भनिन्छ।**\\n- Insight Learning कोहलरको सिद्धान्तसँग सम्बन्धित छ।\\n- Programmed Learning स्किनरको सिद्धान्तसँग सम्बन्धित छ।\\nनोट: यसमा आफैंले पुरस्कार नपाए पनि वा अरूले दण्ड पाएको दृश्य हेरेर पनि सिकाइ हुनसक्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:अवलोकनद्वारा हुने सिकाइलाई अर्को कुन नामले पनि चिनिन्छ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'ब्यान्डुराको सिद्धान्तमा अवलोकन सिकाइका लागि पुरस्कार कस्तो हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'ब्यान्डुराको सिद्धान्तमा अवलोकन सिकाइका लागि पुरस्कार कस्तो हुन्छ?', E'अनिवार्य हुन्छ', E'अनिवार्य छैन', E'सधैं नकारात्मक हुन्छ', E'मात्र दण्डले काम गर्छ', E'B', E'**ब्यान्डुराको सिद्धान्तमा अवलोकन सिकाइका लागि पुरस्कार अनिवार्य छैन।**\\nनोट: मानिसले अरूको व्यवहार हेरेरै सिक्न सक्ने हुनाले प्रत्यक्ष पुरस्कार नपाए पनि वा दण्डको दृश्य हेरेर पनि सिकाइ हुन्छ; यही कारण ब्यान्डुराको सिद्धान्त स्किनरको पुनर्बल-आधारित सिद्धान्तभन्दा फरक छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:ब्यान्डुराको सिद्धान्तमा अवलोकन सिकाइका लागि पुरस्कार कस्तो हुन्छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'ब्यान्डुरालाई किन ''संज्ञानात्मक व्यवहारवादी'' भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'ब्यान्डुरालाई किन ''संज्ञानात्मक व्यवहारवादी'' भनिन्छ?', E'उनको सिद्धान्त पूर्ण व्यवहारवादी भएकाले', E'उनको दर्शन व्यवहारवाद र संज्ञानात्मकवादबीचको सेतु भएकाले', E'उनले अन्तर्दृष्टिमा जोड दिएकाले', E'उनले पुनर्बललाई मात्र मानेकाले', E'B', E'**ब्यान्डुरालाई ''संज्ञानात्मक व्यवहारवादी'' भनिन्छ किनभने उनको दर्शनलाई व्यवहारवाद र संज्ञानात्मकवादबीचको सेतु मानिन्छ।**\\nनोट: सामाजिक सिकाइमा धारणा (Retention) र सम्झना जस्ता मानसिक (संज्ञानात्मक) प्रक्रिया संलग्न हुने हुनाले यो पूर्ण व्यवहारवादी नभई संज्ञानात्मक प्रकृतिको पनि हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:ब्यान्डुरालाई किन ''संज्ञानात्मक व्यवहारवादी'' भनिन्छ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'अन्तर्दृष्टि सिकाइ सिद्धान्त (Insight Learning Theory) का प्रतिपादक को हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'अन्तर्दृष्टि सिकाइ सिद्धान्त (Insight Learning Theory) का प्रतिपादक को हुन्?', E'अल्बर्ट ब्यान्डुरा', E'जिन पियाजे', E'वुल्फगाङ कोहलर', E'इ.एल. थर्नडाइक', E'C', E'**अन्तर्दृष्टि सिकाइ सिद्धान्तका प्रतिपादक वुल्फगाङ कोहलर (Wolfgang Köhler) हुन्।**\\n- अल्बर्ट ब्यान्डुराले सामाजिक सिकाइ सिद्धान्त दिए।\\n- जिन पियाजेले संज्ञानात्मक विकास सिद्धान्त दिए।\\n- इ.एल. थर्नडाइकले प्रयत्न र त्रुटि सिद्धान्त दिए।\\nनोट: कोहलरका समर्थकमा म्याक्स वर्डहाइमर र कुर्ट कोफ्का पर्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:अन्तर्दृष्टि सिकाइ सिद्धान्त (Insight Learning Theory) का प्रतिपादक को हुन्?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कोहलरको अन्तर्दृष्टि सिद्धान्त कुन मनोवैज्ञानिक सम्प्रदायसँग सम्बन्धित छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'कोहलरको अन्तर्दृष्टि सिद्धान्त कुन मनोवैज्ञानिक सम्प्रदायसँग सम्बन्धित छ?', E'गेस्टाल्ट (समग्रवाद)', E'व्यवहारवाद', E'मनोविश्लेषणवाद', E'संरचनावाद', E'A', E'**कोहलरको अन्तर्दृष्टि सिद्धान्त गेस्टाल्ट (Gestalt) अर्थात् समग्रवाद सम्प्रदायसँग सम्बन्धित छ।**\\nनोट: ''गेस्टाल्ट'' को अर्थ ''समग्रता'' वा ''पूर्ण रूप'' हुन्छ; यसले ''समग्र नै अंशभन्दा ठूलो हुन्छ'' भन्ने मान्दछ र यो संज्ञानात्मक प्रकृतिको सिकाइ हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कोहलरको अन्तर्दृष्टि सिद्धान्त कुन मनोवैज्ञानिक सम्प्रदायसँग सम्बन्धित छ?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कोहलरले आफ्नो अन्तर्दृष्टि सिद्धान्तको प्रयोग कुन जनावरमा गरेका थिए?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'कोहलरले आफ्नो अन्तर्दृष्टि सिद्धान्तको प्रयोग कुन जनावरमा गरेका थिए?', E'कुकुर', E'मुसा', E'बिरालो', E'सुल्तान नामको चिम्पान्जी', E'D', E'**कोहलरले ''सुल्तान'' नामको चिम्पान्जीमाथि टेनेरिफ टापु (Tenerife) मा प्रयोग गरेका थिए।**\\n- कुकुरमा पाभ्लोवले प्रयोग गरे।\\n- मुसामा स्किनरले प्रयोग गरे।\\n- बिरालोमा थर्नडाइकले प्रयोग गरे।\\nनोट: प्रयोगमा बाकस र लट्ठीको प्रयोग गरिएको थियो, जसमा चिम्पान्जीले अन्तर्दृष्टिद्वारा समस्या समाधान गर्‍यो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कोहलरले आफ्नो अन्तर्दृष्टि सिद्धान्तको प्रयोग कुन जनावरमा गरेका थिए?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'अन्तर्दृष्टि (Insight) भनेको के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'अन्तर्दृष्टि (Insight) भनेको के हो?', E'बिस्तारै अभ्यासबाट हुने सिकाइ', E'अकस्मात् समस्या समाधानको उपाय आउने क्षण (Aha! Moment)', E'अरूको अनुकरण गर्ने प्रक्रिया', E'पुरस्कारबाट हुने सिकाइ', E'B', E'**अन्तर्दृष्टि (Insight) भनेको अकस्मात् समस्या समाधान गर्ने उपाय आउने क्षण (Aha! Moment) हो।**\\nनोट: कोहलरका अनुसार सिकाइ प्रयत्न र भूलबाट होइन, समस्याको पूर्ण बुझाइ (Understanding) बाट हुन्छ; अन्तर्दृष्टि ढिलो आए पनि आउँदा अकस्मात् आउँछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:अन्तर्दृष्टि (Insight) भनेको के हो?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कोहलरका अनुसार सिकाइ मुख्यतया कसरी हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'कोहलरका अनुसार सिकाइ मुख्यतया कसरी हुन्छ?', E'प्रयत्न र भूलबाट', E'पुनर्बलबाट', E'समस्याको पूर्ण बुझाइ (Understanding) बाट', E'अनुकूलित प्रतिक्रियाबाट', E'C', E'**कोहलरका अनुसार सिकाइ प्रयत्न र भूलबाट होइन, समस्याको पूर्ण बुझाइ (Understanding) बाट हुन्छ।**\\n- प्रयत्न र भूलबाट सिकाइ थर्नडाइकको सिद्धान्तमा हुन्छ।\\n- पुनर्बलबाट सिकाइ स्किनरको सिद्धान्तमा हुन्छ।\\n- अनुकूलित प्रतिक्रियाबाट सिकाइ पाभ्लोवको सिद्धान्तमा हुन्छ।\\nनोट: यो तार्किक र उच्च स्तरको सिकाइ हो, जुन जटिल समस्या समाधान गर्न उत्तम मानिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कोहलरका अनुसार सिकाइ मुख्यतया कसरी हुन्छ?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'गेस्टाल्टवादीहरूका अनुसार समस्यालाई कसरी हेर्नुपर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'गेस्टाल्टवादीहरूका अनुसार समस्यालाई कसरी हेर्नुपर्छ?', E'अंशमा विभाजन गरेर', E'पूर्ण (समग्र) रूपमा', E'एक-एक चरणमा', E'पुरस्कारका आधारमा', E'B', E'**गेस्टाल्टवादीहरूका अनुसार समस्यालाई अंशमा होइन, पूर्ण (समग्र) रूपमा हेर्नुपर्छ।**\\nनोट: ''पूर्ण''बाट ''अंश''तर्फ जाने यो दृष्टिकोणअनुसार पूर्ण रूप (Gestalt) मा मात्र समस्याको यथार्थ बुझिन्छ; यसमा पूर्व अनुभव र पुनर्संरचना (Restructuring) को महत्त्वपूर्ण भूमिका हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:गेस्टाल्टवादीहरूका अनुसार समस्यालाई कसरी हेर्नुपर्छ?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'ब्यान्डुराले बोबो डल प्रयोग कुन सालमा गरेका थिए?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'ब्यान्डुराले बोबो डल प्रयोग कुन सालमा गरेका थिए?', E'सन् १९०४', E'सन् १९१३', E'सन् १९३०', E'सन् १९६१', E'D', E'ब्यान्डुराले बालबालिकाको आक्रामक व्यवहारको अध्ययन गर्न सन् **१९६१** मा बोबो डल प्रयोग गरेका थिए।\\nनोट: पाभ्लोवले १९०४ मा, थर्नडाइकले १९१३ मा र स्किनरले १९३० को दशकमा आ-आफ्ना प्रयोग गरेका थिए।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:ब्यान्डुराले बोबो डल प्रयोग कुन सालमा गरेका थिए?'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'प्रयत्न र भूल (थर्नडाइक) र अन्तर्दृष्टि (कोहलर) बीचको मुख्य भिन्नता के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'प्रयत्न र भूल (थर्नडाइक) र अन्तर्दृष्टि (कोहलर) बीचको मुख्य भिन्नता के हो?', E'प्रयत्न र भूल यान्त्रिक हो भने अन्तर्दृष्टि बौद्धिक सिकाइ हो', E'दुवै यान्त्रिक सिकाइ हुन्', E'दुवै बौद्धिक सिकाइ हुन्', E'प्रयत्न र भूल बौद्धिक हो भने अन्तर्दृष्टि यान्त्रिक हो', E'A', E'**''प्रयत्न र भूल'' (थर्नडाइक) यान्त्रिक सिकाइ हो भने ''अन्तर्दृष्टि'' (कोहलर) बौद्धिक सिकाइ हो।**\\nनोट: कोहलरको सिकाइमा अन्धकारमा हात-खुट्टा चलाउनु (प्रयत्न र भूल) पर्दैन, किनभने यहाँ समस्यालाई समग्र रूपमा हेरेर बुद्धिद्वारा समाधान गरिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:प्रयत्न र भूल (थर्नडाइक) र अन्तर्दृष्टि (कोहलर) बीचको मुख्य भिन्नता के हो?'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'ब्यान्डुराको सिद्धान्तमा हेरेको व्यवहार व्यवहारमा नउतारेमा के हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'ब्यान्डुराको सिद्धान्तमा हेरेको व्यवहार व्यवहारमा नउतारेमा के हुन्छ?', E'सिकाइ पूर्ण हुन्छ', E'त्यो ज्ञान मात्र रहन्छ, सिकाइ अधुरो हुन्छ', E'तुरुन्तै बिर्सिन्छ', E'पुनर्बल स्वतः मिल्छ', E'B', E'**हेरेको व्यवहार व्यवहारमा उतारेन भने त्यो ज्ञान मात्र रहन्छ र सिकाइ अधुरो हुन्छ।**\\nनोट: यसैले ब्यान्डुराको सिद्धान्तमा पुनरुत्पादन (Reproduction) महत्त्वपूर्ण सोपान हो; अवलोकन गरेको व्यवहारलाई नक्कल गरेर मात्र सिकाइ पूर्ण हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:ब्यान्डुराको सिद्धान्तमा हेरेको व्यवहार व्यवहारमा नउतारेमा के हुन्छ?'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कोहलरको अन्तर्दृष्टि सिद्धान्त निम्नमध्ये कुन कार्यका लागि उत्तम मानिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'कोहलरको अन्तर्दृष्टि सिद्धान्त निम्नमध्ये कुन कार्यका लागि उत्तम मानिन्छ?', E'रट्ने सिकाइ', E'बानी बसाल्ने कार्य', E'जटिल समस्या (गणित र विज्ञान) समाधान', E'अनैच्छिक प्रतिक्रिया विकास', E'C', E'**कोहलरको अन्तर्दृष्टि सिद्धान्त जटिल समस्या (जस्तै गणित र विज्ञान) समाधान गर्न उत्तम मानिन्छ।**\\n- रट्ने सिकाइ र बानी बसाल्ने कार्यका लागि भने थर्नडाइकको सिद्धान्त उपयुक्त छ।\\nनोट: यो तार्किक र उच्च स्तरको सिकाइ हो जसले व्यवहारवादी र रट्ने सिकाइलाई अस्वीकार गर्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कोहलरको अन्तर्दृष्टि सिद्धान्त निम्नमध्ये कुन कार्यका लागि उत्तम मानिन्छ?'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'ब्यान्डुराको सिद्धान्तअनुसार शिक्षकको भूमिका कस्तो हुनुपर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 20, E'ब्यान्डुराको सिद्धान्तअनुसार शिक्षकको भूमिका कस्तो हुनुपर्छ?', E'विद्यार्थीका लागि एउटा असल मोडल', E'कडा अनुशासक', E'केवल पुरस्कार दिने व्यक्ति', E'निष्क्रिय पर्यवेक्षक', E'A', E'**ब्यान्डुराको सिद्धान्तअनुसार शिक्षक आफैं विद्यार्थीका लागि एउटा असल मोडल हुनुपर्छ।**\\nनोट: विद्यार्थीले शिक्षकको व्यवहार अवलोकन गरेर अनुकरण गर्ने हुनाले शिक्षकको आचरण अनुकरणीय हुनुपर्छ; मिडिया, चलचित्र र भिडियो गेमले पनि व्यवहार सिकाइमा भूमिका खेल्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:ब्यान्डुराको सिद्धान्तअनुसार शिक्षकको भूमिका कस्तो हुनुपर्छ?'), v_set_id, v_q_id, 20)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: पाभ्लोवको शास्त्रीय अनुबन्धन सिद्धान्त (आधारभूत तह) (20 Q)
  v_set_id := extensions.uuid_generate_v5('0d569671-39de-4aff-a46c-ce9ab71ec100'::uuid, E'पाभ्लोवको शास्त्रीय अनुबन्धन सिद्धान्त (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '33eadd7e-4fa5-4c91-a18a-850a6af93275'::uuid, '0d569671-39de-4aff-a46c-ce9ab71ec100'::uuid, E'पाभ्लोवको शास्त्रीय अनुबन्धन सिद्धान्त (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '0d569671-39de-4aff-a46c-ce9ab71ec100'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शास्त्रीय अनुबन्धन (Classical Conditioning) सिद्धान्तका प्रतिपादक को हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'शास्त्रीय अनुबन्धन (Classical Conditioning) सिद्धान्तका प्रतिपादक को हुन्?', E'बी.एफ. स्किनर', E'इ.एल. थर्नडाइक', E'इभान पाभ्लोव', E'वुल्फगाङ कोहलर', E'C', E'**शास्त्रीय अनुबन्धन सिद्धान्तका प्रतिपादक रुसी फिजियोलोजिस्ट इभान पाभ्लोव (Ivan P. Pavlov) हुन्।**\\n- बी.एफ. स्किनरले कार्यपरक अनुबन्धन सिद्धान्त दिए।\\n- इ.एल. थर्नडाइकले प्रयत्न र त्रुटि सिद्धान्त दिए।\\n- वुल्फगाङ कोहलरले अन्तर्दृष्टि सिकाइ सिद्धान्त दिए।\\nनोट: पाभ्लोवले सन् १९०४ मा पाचन प्रणालीको अध्ययनका लागि नोबेल पुरस्कार पाएका थिए।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शास्त्रीय अनुबन्धन (Classical Conditioning) सिद्धान्तका प्रतिपादक को हुन्?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पाभ्लोवले आफ्नो शास्त्रीय अनुबन्धन सिद्धान्तको प्रयोग कुन जनावरमा गरेका थिए?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'पाभ्लोवले आफ्नो शास्त्रीय अनुबन्धन सिद्धान्तको प्रयोग कुन जनावरमा गरेका थिए?', E'कुकुर', E'बिरालो', E'मुसा', E'चिम्पान्जी', E'A', E'**पाभ्लोवले आफ्नो प्रयोग कुकुर (Dog) मा गरेका थिए।**\\n- बिरालो (Cat) माथि थर्नडाइकले प्रयोग गरेका थिए।\\n- मुसा (Rat) माथि स्किनरले प्रयोग गरेका थिए।\\n- चिम्पान्जी (सुल्तान) माथि कोहलरले प्रयोग गरेका थिए।\\nनोट: पाभ्लोवको प्रयोगमा कुकुरलाई खाना देखाउँदा र्याल आउने स्वाभाविक प्रतिक्रिया अध्ययन गरिएको थियो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पाभ्लोवले आफ्नो शास्त्रीय अनुबन्धन सिद्धान्तको प्रयोग कुन जनावरमा गरेका थिए?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शास्त्रीय अनुबन्धन सिद्धान्तलाई अर्को कुन नामले पनि चिनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'शास्त्रीय अनुबन्धन सिद्धान्तलाई अर्को कुन नामले पनि चिनिन्छ?', E'R-S Theory', E'S-R Theory (Stimulus-Response)', E'अन्तर्दृष्टि सिद्धान्त', E'सम्बन्धवाद (Connectionism)', E'B', E'**शास्त्रीय अनुबन्धन सिद्धान्तलाई S-R Theory (Stimulus-Response) वा Respondent Conditioning पनि भनिन्छ।**\\n- R-S Theory भनेर स्किनरको कार्यपरक अनुबन्धनलाई चिनिन्छ।\\n- अन्तर्दृष्टि सिद्धान्त कोहलरको हो।\\n- सम्बन्धवाद (Connectionism) थर्नडाइकको हो।\\nनोट: यसमा पहिले उद्दीपक (Stimulus) आउँछ, त्यसपछि प्रतिक्रिया (Response) हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शास्त्रीय अनुबन्धन सिद्धान्तलाई अर्को कुन नामले पनि चिनिन्छ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पाभ्लोवको प्रयोगमा स्वाभाविक उद्दीपक (Unconditioned Stimulus) कुन थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'पाभ्लोवको प्रयोगमा स्वाभाविक उद्दीपक (Unconditioned Stimulus) कुन थियो?', E'घन्टी', E'बत्ती', E'र्याल', E'खाना', E'D', E'**पाभ्लोवको प्रयोगमा स्वाभाविक उद्दीपक (US) खाना (Food) थियो।**\\n- घन्टी तटस्थ उद्दीपक (NS) थियो, जुन पछि अनुकूलित उद्दीपक बन्यो।\\n- र्याल आउनु भने स्वाभाविक प्रतिक्रिया (UR) हो, उद्दीपक होइन।\\nनोट: खाना देखेपछि कुकुरलाई स्वतः र्याल आउने हुनाले खाना स्वाभाविक उद्दीपक हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पाभ्लोवको प्रयोगमा स्वाभाविक उद्दीपक (Unconditioned Stimulus) कुन थियो?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पाभ्लोवको प्रयोगमा तटस्थ उद्दीपक (Neutral Stimulus) कुन थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'पाभ्लोवको प्रयोगमा तटस्थ उद्दीपक (Neutral Stimulus) कुन थियो?', E'घन्टी', E'खाना', E'र्याल', E'भोक', E'A', E'**पाभ्लोवको प्रयोगमा तटस्थ उद्दीपक (NS) घन्टी (Bell) थियो।**\\n- खाना स्वाभाविक उद्दीपक (US) थियो।\\n- र्याल स्वाभाविक प्रतिक्रिया (UR) थियो।\\nनोट: सुरुमा घन्टी बज्दा र्याल आउँदैनथ्यो, तर घन्टी र खाना सँगै दिएपछि घन्टी मात्र बजाउँदा पनि र्याल आउन थाल्यो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पाभ्लोवको प्रयोगमा तटस्थ उद्दीपक (Neutral Stimulus) कुन थियो?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'अनुबन्धन पछि घन्टी मात्र सुन्दा र्याल आउनुलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'अनुबन्धन पछि घन्टी मात्र सुन्दा र्याल आउनुलाई के भनिन्छ?', E'स्वाभाविक प्रतिक्रिया (UR)', E'स्वाभाविक उद्दीपक (US)', E'अनुकूलित प्रतिक्रिया (Conditioned Response)', E'तटस्थ उद्दीपक (NS)', E'C', E'**अनुबन्धन पछि घन्टी मात्र सुन्दा र्याल आउनुलाई अनुकूलित प्रतिक्रिया (Conditioned Response - CR) भनिन्छ।**\\n- खाना देखेर र्याल आउनु भने स्वाभाविक प्रतिक्रिया (UR) हो।\\nनोट: अनुबन्धन पछि घन्टी अनुकूलित उद्दीपक (CS) बन्छ र त्यसले निकाल्ने र्याल अनुकूलित प्रतिक्रिया (CR) हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:अनुबन्धन पछि घन्टी मात्र सुन्दा र्याल आउनुलाई के भनिन्छ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'बारम्बार खाना नदिई घन्टी मात्र बजाउँदा बिस्तारै र्याल आउन छोड्ने अवस्थालाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'बारम्बार खाना नदिई घन्टी मात्र बजाउँदा बिस्तारै र्याल आउन छोड्ने अवस्थालाई के भनिन्छ?', E'सामान्यीकरण', E'लोप (Extinction)', E'विभेदीकरण', E'स्वतः पुनरावृत्ति', E'B', E'**खाना नदिई घन्टी मात्र बजाउँदा र्याल आउन छोड्ने अवस्थालाई लोप (Extinction) भनिन्छ।**\\n- सामान्यीकरणमा उस्तै आवाजले पनि र्याल आउँछ।\\n- विभेदीकरणमा सही घन्टी र फरक आवाज छुट्याइन्छ।\\n- स्वतः पुनरावृत्तिमा लोप भएपछि पनि केही समयपछि फेरि र्याल आउँछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:बारम्बार खाना नदिई घन्टी मात्र बजाउँदा बिस्तारै र्याल आउन छोड्ने अवस्थालाई के भनिन्छ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'लोप (Extinction) भएको केही समयपछि फेरि घन्टी सुन्दा र्याल आउने प्रक्रियालाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'लोप (Extinction) भएको केही समयपछि फेरि घन्टी सुन्दा र्याल आउने प्रक्रियालाई के भनिन्छ?', E'उद्दीपक सामान्यीकरण', E'उद्दीपक विभेदीकरण', E'उच्चस्तरीय अनुबन्धन', E'स्वतः पुनरावृत्ति (Spontaneous Recovery)', E'D', E'**लोप भएको केही समयपछि फेरि घन्टी सुन्दा र्याल आउने प्रक्रियालाई स्वतः पुनरावृत्ति (Spontaneous Recovery) भनिन्छ।**\\n- उद्दीपक सामान्यीकरणमा उस्तै आवाजले पनि र्याल आउँछ।\\n- उद्दीपक विभेदीकरणमा फरक आवाज छुट्याइन्छ।\\n- उच्चस्तरीय अनुबन्धनमा घन्टीसँग अरू नयाँ तटस्थ उद्दीपक जोडिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:लोप (Extinction) भएको केही समयपछि फेरि घन्टी सुन्दा र्याल आउने प्रक्रियालाई के भनिन्छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'अनुकूलित घन्टी जस्तै उस्तै-उस्तै आवाजले पनि र्याल आउने अवस्थालाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'अनुकूलित घन्टी जस्तै उस्तै-उस्तै आवाजले पनि र्याल आउने अवस्थालाई के भनिन्छ?', E'उद्दीपक सामान्यीकरण (Stimulus Generalization)', E'उद्दीपक विभेदीकरण', E'लोप', E'स्वतः पुनरावृत्ति', E'A', E'**अनुकूलित घन्टी जस्तै उस्तै-उस्तै आवाजले पनि र्याल आउने अवस्थालाई उद्दीपक सामान्यीकरण (Stimulus Generalization) भनिन्छ।**\\n- उद्दीपक विभेदीकरणमा भने सही घन्टी र फरक आवाज छुट्याइन्छ।\\n- लोपमा र्याल आउन छोड्छ।\\nनोट: सामान्यीकरण र विभेदीकरण एकअर्काको विपरीत प्रक्रिया हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:अनुकूलित घन्टी जस्तै उस्तै-उस्तै आवाजले पनि र्याल आउने अवस्थालाई के भनिन्छ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शास्त्रीय अनुबन्धन सफल हुन घन्टी र खानाबीचको समय कस्तो हुनुपर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'शास्त्रीय अनुबन्धन सफल हुन घन्टी र खानाबीचको समय कस्तो हुनुपर्छ?', E'धेरै लामो', E'छोटो (करिब ०.५ सेकेन्ड)', E'ठ्याक्कै एक मिनेट', E'समयको कुनै भूमिका हुँदैन', E'B', E'**शास्त्रीय अनुबन्धन सफल हुन घन्टी र खानाबीचको समय छोटो (करिब ०.५ सेकेन्ड) हुनुपर्छ; यसलाई समयको समीपता (Contiguity) भनिन्छ।**\\nनोट: दुई उद्दीपकबीचको समय धेरै भयो भने अनुबन्धन हुँदैन, किनभने समीपता नै सिकाइको आधार हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शास्त्रीय अनुबन्धन सफल हुन घन्टी र खानाबीचको समय कस्तो हुनुपर्छ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शास्त्रीय अनुबन्धन मुख्यतया कस्तो प्रकारको व्यवहारसँग सम्बन्धित छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'शास्त्रीय अनुबन्धन मुख्यतया कस्तो प्रकारको व्यवहारसँग सम्बन्धित छ?', E'ऐच्छिक व्यवहार', E'अनैच्छिक व्यवहार', E'योजनाबद्ध व्यवहार', E'सिर्जनात्मक व्यवहार', E'B', E'**शास्त्रीय अनुबन्धन मुख्यतया अनैच्छिक (Involuntary) व्यवहारसँग सम्बन्धित छ।**\\n- ऐच्छिक (Voluntary) व्यवहारसँग भने स्किनरको कार्यपरक अनुबन्धन सम्बन्धित छ।\\nनोट: र्याल आउनु, डर लाग्नु जस्ता स्वतः हुने प्रतिक्रियाहरू अनैच्छिक व्यवहार हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शास्त्रीय अनुबन्धन मुख्यतया कस्तो प्रकारको व्यवहारसँग सम्बन्धित छ?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शास्त्रीय अनुबन्धन सिद्धान्तको मुख्य आधार के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'शास्त्रीय अनुबन्धन सिद्धान्तको मुख्य आधार के हो?', E'पुनर्बल (Reinforcement)', E'अन्तर्दृष्टि (Insight)', E'अनुकूलित प्रतिक्रिया (Conditioned Response)', E'अवलोकन (Observation)', E'C', E'**शास्त्रीय अनुबन्धनको मुख्य आधार अनुकूलित प्रतिक्रिया (Conditioned Response) हो।**\\n- पुनर्बल (Reinforcement) स्किनरको कार्यपरक अनुबन्धनको आधार हो।\\n- अन्तर्दृष्टि (Insight) कोहलरको सिद्धान्तको आधार हो।\\n- अवलोकन (Observation) ब्यान्डुराको सामाजिक सिकाइको आधार हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शास्त्रीय अनुबन्धन सिद्धान्तको मुख्य आधार के हो?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शास्त्रीय अनुबन्धन सिद्धान्त कुन मनोवैज्ञानिक सम्प्रदायसँग सम्बन्धित छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'शास्त्रीय अनुबन्धन सिद्धान्त कुन मनोवैज्ञानिक सम्प्रदायसँग सम्बन्धित छ?', E'व्यवहारवाद (Behaviorism)', E'संज्ञानवाद (Cognitivism)', E'मनोविश्लेषणवाद', E'समग्रवाद (Gestaltism)', E'A', E'**शास्त्रीय अनुबन्धन सिद्धान्त व्यवहारवाद (Behaviorism) सँग सम्बन्धित छ।**\\n- संज्ञानवाद र समग्रवादसँग भने पियाजे र कोहलरका सिद्धान्त सम्बन्धित छन्।\\n- मनोविश्लेषणवाद फ्रायडसँग सम्बन्धित छ।\\nनोट: व्यवहारवादले अवलोकन गर्न सकिने बाह्य व्यवहारको परिवर्तनमा जोड दिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शास्त्रीय अनुबन्धन सिद्धान्त कुन मनोवैज्ञानिक सम्प्रदायसँग सम्बन्धित छ?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'अनुकूलित घन्टीसँग अर्को नयाँ तटस्थ उद्दीपक जोडेर सिकाउने प्रक्रियालाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'अनुकूलित घन्टीसँग अर्को नयाँ तटस्थ उद्दीपक जोडेर सिकाउने प्रक्रियालाई के भनिन्छ?', E'लोप', E'स्वतः पुनरावृत्ति', E'उच्चस्तरीय अनुबन्धन (Higher-Order Conditioning)', E'विभेदीकरण', E'C', E'**अनुकूलित घन्टीसँग अर्को नयाँ तटस्थ उद्दीपक जोडेर सिकाउने प्रक्रियालाई उच्चस्तरीय अनुबन्धन (Higher-Order Conditioning) भनिन्छ।**\\n- लोपमा अनुकूलित प्रतिक्रिया हराउँछ।\\n- स्वतः पुनरावृत्तिमा लोप भएको प्रतिक्रिया फेरि देखिन्छ।\\n- विभेदीकरणमा फरक उद्दीपक छुट्याइन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:अनुकूलित घन्टीसँग अर्को नयाँ तटस्थ उद्दीपक जोडेर सिकाउने प्रक्रियालाई के भनिन्छ?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सही अनुकूलित घन्टी र फरक आवाजलाई छुट्याउन सक्ने क्षमतालाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'सही अनुकूलित घन्टी र फरक आवाजलाई छुट्याउन सक्ने क्षमतालाई के भनिन्छ?', E'उद्दीपक सामान्यीकरण', E'उद्दीपक विभेदीकरण (Stimulus Discrimination)', E'लोप', E'उच्चस्तरीय अनुबन्धन', E'B', E'**सही अनुकूलित घन्टी र फरक आवाजलाई छुट्याउन सक्ने क्षमतालाई उद्दीपक विभेदीकरण (Stimulus Discrimination) भनिन्छ।**\\n- उद्दीपक सामान्यीकरणमा भने उस्तै आवाजले पनि उही प्रतिक्रिया आउँछ।\\nनोट: विभेदीकरणले प्राणीलाई समान देखिने उद्दीपकहरूबीच भिन्नता छुट्याउन सिकाउँछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सही अनुकूलित घन्टी र फरक आवाजलाई छुट्याउन सक्ने क्षमतालाई के भनिन्छ?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पाभ्लोवको शास्त्रीय अनुबन्धन सिद्धान्त कक्षाकोठामा कुन कामका लागि उपयुक्त मानिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'पाभ्लोवको शास्त्रीय अनुबन्धन सिद्धान्त कक्षाकोठामा कुन कामका लागि उपयुक्त मानिन्छ?', E'जटिल गणितीय समस्या समाधान गर्न', E'अमूर्त वैज्ञानिक चिन्तन विकास गर्न', E'डर हटाउन र राम्रो बानी बसाल्न', E'अनुसन्धान कौशल विकास गर्न', E'C', E'**पाभ्लोवको सिद्धान्त कक्षाकोठामा डर हटाउन, राम्रो बानी बसाल्न र डर/खुसी/घृणा जस्ता संवेग सिकाउन उपयुक्त मानिन्छ।**\\n- जटिल समस्या समाधान र अमूर्त चिन्तनका लागि भने कोहलरको अन्तर्दृष्टि सिद्धान्त उपयुक्त मानिन्छ।\\nनोट: यो सिद्धान्त भाषा शिक्षणमा शब्द र अर्थबीच सम्बन्ध बनाउन पनि प्रभावकारी छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पाभ्लोवको शास्त्रीय अनुबन्धन सिद्धान्त कक्षाकोठामा कुन कामका लागि उपयुक्त मानिन्छ?'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पाभ्लोवको प्रयोगमा कुकुरलाई खाना देखाउँदा र्याल आउनुलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'पाभ्लोवको प्रयोगमा कुकुरलाई खाना देखाउँदा र्याल आउनुलाई के भनिन्छ?', E'अनुकूलित प्रतिक्रिया', E'स्वाभाविक प्रतिक्रिया (Unconditioned Response)', E'तटस्थ उद्दीपक', E'अनुकूलित उद्दीपक', E'B', E'**कुकुरलाई खाना देखाउँदा र्याल आउनु स्वाभाविक प्रतिक्रिया (Unconditioned Response - UR) हो।**\\n- घन्टी मात्र सुनेर र्याल आउनु भने अनुकूलित प्रतिक्रिया (CR) हो।\\nनोट: खाना (US) ले निकाल्ने र्याल स्वाभाविक हो, तर घन्टी (CS) ले निकाल्ने र्याल सिकाइको परिणाम हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पाभ्लोवको प्रयोगमा कुकुरलाई खाना देखाउँदा र्याल आउनुलाई के भनिन्छ?'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पाभ्लोवले शास्त्रीय अनुबन्धन सिद्धान्त कुन सालमा प्रतिपादन गरेका थिए?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'पाभ्लोवले शास्त्रीय अनुबन्धन सिद्धान्त कुन सालमा प्रतिपादन गरेका थिए?', E'सन् १९०४', E'सन् १९१३', E'सन् १९३८', E'सन् १९६१', E'A', E'पाभ्लोवले शास्त्रीय अनुबन्धन सिद्धान्त सन् **१९०४** मा प्रतिपादन गरेका थिए।\\nनोट: थर्नडाइकले सन् १९१३ मा प्रयत्न र त्रुटि सिद्धान्त र ब्यान्डुराले सन् १९६१ मा बोबो डल प्रयोग गरेका थिए।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पाभ्लोवले शास्त्रीय अनुबन्धन सिद्धान्त कुन सालमा प्रतिपादन गरेका थिए?'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शास्त्रीय अनुबन्धनमा सिकाइ कसरी हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'शास्त्रीय अनुबन्धनमा सिकाइ कसरी हुन्छ?', E'अन्तर्दृष्टि (Aha! moment) बाट', E'अरूको अवलोकन र अनुकरणबाट', E'स्वाभाविक र तटस्थ उद्दीपकको संयोजनबाट', E'प्रतिक्रिया पछि पुरस्कार दिएर', E'C', E'**शास्त्रीय अनुबन्धनमा सिकाइ स्वाभाविक उद्दीपक र तटस्थ उद्दीपकको संयोजनबाट हुन्छ।**\\n- अन्तर्दृष्टिबाट सिकाइ कोहलरको सिद्धान्तमा हुन्छ।\\n- अवलोकन र अनुकरणबाट सिकाइ ब्यान्डुराको सिद्धान्तमा हुन्छ।\\n- प्रतिक्रिया पछि पुरस्कार दिने स्किनरको कार्यपरक अनुबन्धन हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शास्त्रीय अनुबन्धनमा सिकाइ कसरी हुन्छ?'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पाभ्लोवको शास्त्रीय अनुबन्धन सिद्धान्तले सिकाइमा कुन तत्त्वको ठूलो भूमिका हुन्छ भन्ने जोड दिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 20, E'पाभ्लोवको शास्त्रीय अनुबन्धन सिद्धान्तले सिकाइमा कुन तत्त्वको ठूलो भूमिका हुन्छ भन्ने जोड दिन्छ?', E'वंशाणुक्रम', E'वातावरण', E'अन्तर्दृष्टि', E'परिपक्वता', E'B', E'**पाभ्लोवको सिद्धान्तले सिकाइमा वातावरण (Environment) को ठूलो भूमिका हुन्छ भन्ने जोड दिन्छ।**\\nनोट: यो सिद्धान्तले व्यक्तिगत भिन्नतालाई ध्यान दिनुपर्ने कुरामा पनि जोड दिन्छ, किनभने फरक प्राणीमा अनुबन्धनको गति फरक हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पाभ्लोवको शास्त्रीय अनुबन्धन सिद्धान्तले सिकाइमा कुन तत्त्वको ठूलो भूमिका हुन्छ भन्ने जोड दिन्छ?'), v_set_id, v_q_id, 20)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: स्किनरको कार्यपरक अनुबन्धन सिद्धान्त (आधारभूत तह) (20 Q)
  v_set_id := extensions.uuid_generate_v5('ae53051f-5f42-49ce-8e36-508fb656fa90'::uuid, E'स्किनरको कार्यपरक अनुबन्धन सिद्धान्त (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '33eadd7e-4fa5-4c91-a18a-850a6af93275'::uuid, 'ae53051f-5f42-49ce-8e36-508fb656fa90'::uuid, E'स्किनरको कार्यपरक अनुबन्धन सिद्धान्त (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'ae53051f-5f42-49ce-8e36-508fb656fa90'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कार्यपरक अनुबन्धन (Operant Conditioning) सिद्धान्तका प्रतिपादक को हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'कार्यपरक अनुबन्धन (Operant Conditioning) सिद्धान्तका प्रतिपादक को हुन्?', E'इभान पाभ्लोव', E'बी.एफ. स्किनर', E'अल्बर्ट ब्यान्डुरा', E'इ.एल. थर्नडाइक', E'B', E'**कार्यपरक अनुबन्धन सिद्धान्तका प्रतिपादक अमेरिकी मनोवैज्ञानिक बी.एफ. स्किनर (B.F. Skinner) हुन्।**\\n- इभान पाभ्लोवले शास्त्रीय अनुबन्धन सिद्धान्त दिए।\\n- अल्बर्ट ब्यान्डुराले सामाजिक सिकाइ सिद्धान्त दिए।\\n- इ.एल. थर्नडाइकले प्रयत्न र त्रुटि सिद्धान्त दिए।\\nनोट: यो ''व्यवहारवाद'' मा आधारित सिद्धान्त हो जसको मुख्य आधार पुनर्बल हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कार्यपरक अनुबन्धन (Operant Conditioning) सिद्धान्तका प्रतिपादक को हुन्?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'स्किनरले आफ्नो कार्यपरक अनुबन्धनको प्रयोग कुन जनावरमा गरेका थिए?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'स्किनरले आफ्नो कार्यपरक अनुबन्धनको प्रयोग कुन जनावरमा गरेका थिए?', E'मुसा र परेवा', E'कुकुर', E'बिरालो', E'चिम्पान्जी', E'A', E'**स्किनरले मुसा (Rat) र परेवा (Pigeon) माथि प्रयोग गरेका थिए।**\\n- कुकुर (Dog) माथि पाभ्लोवले प्रयोग गरे।\\n- बिरालो (Cat) माथि थर्नडाइकले प्रयोग गरे।\\n- चिम्पान्जी (सुल्तान) माथि कोहलरले प्रयोग गरे।\\nनोट: स्किनरले ''स्किनर बक्स'' (Skinner Box) भित्र यी प्रयोग गरेका थिए।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:स्किनरले आफ्नो कार्यपरक अनुबन्धनको प्रयोग कुन जनावरमा गरेका थिए?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'स्किनरले आफ्नो प्रयोगका लागि प्रयोग गरेको उपकरण कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'स्किनरले आफ्नो प्रयोगका लागि प्रयोग गरेको उपकरण कुन हो?', E'पजल बक्स', E'बोबो डल', E'स्किनर बक्स', E'बाकस र लट्ठी', E'C', E'**स्किनरले आफ्नो प्रयोगका लागि स्किनर बक्स (Skinner Box) प्रयोग गरेका थिए।**\\n- पजल बक्स (भुलभुलैया बाकस) थर्नडाइकले प्रयोग गरे।\\n- बोबो डल ब्यान्डुराले प्रयोग गरे।\\n- बाकस र लट्ठी कोहलरले प्रयोग गरे।\\nनोट: स्किनर बक्सभित्र मुसाले लिभर थिच्दा खाना पाउने व्यवस्था मिलाइएको थियो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:स्किनरले आफ्नो प्रयोगका लागि प्रयोग गरेको उपकरण कुन हो?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कार्यपरक अनुबन्धन सिद्धान्तको मुख्य आधार के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'कार्यपरक अनुबन्धन सिद्धान्तको मुख्य आधार के हो?', E'अनुकूलित प्रतिक्रिया', E'अन्तर्दृष्टि', E'अवलोकन', E'पुनर्बल (Reinforcement)', E'D', E'**कार्यपरक अनुबन्धन सिद्धान्तको मुख्य आधार पुनर्बल (Reinforcement) हो।**\\n- अनुकूलित प्रतिक्रिया पाभ्लोवको शास्त्रीय अनुबन्धनको आधार हो।\\n- अन्तर्दृष्टि कोहलरको आधार हो।\\n- अवलोकन ब्यान्डुराको आधार हो।\\nनोट: यसमा प्रतिक्रिया पछि उद्दीपक (पुरस्कार) आउने गरी सिकाइ हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कार्यपरक अनुबन्धन सिद्धान्तको मुख्य आधार के हो?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कार्यपरक अनुबन्धन सिद्धान्तलाई अर्को कुन नामले पनि चिनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'कार्यपरक अनुबन्धन सिद्धान्तलाई अर्को कुन नामले पनि चिनिन्छ?', E'R-S Theory (वाद्य अनुबन्धन)', E'S-R Theory', E'अन्तर्दृष्टि सिद्धान्त', E'सम्बन्धवाद', E'A', E'**कार्यपरक अनुबन्धन सिद्धान्तलाई R-S Theory (Response-Stimulus) वा वाद्य अनुबन्धन (Instrumental Conditioning) पनि भनिन्छ।**\\n- S-R Theory भनेर पाभ्लोवको शास्त्रीय अनुबन्धनलाई चिनिन्छ।\\n- अन्तर्दृष्टि सिद्धान्त कोहलरको हो।\\n- सम्बन्धवाद थर्नडाइकको हो।\\nनोट: R-S भनिनुको कारण जीवले पहिले प्रतिक्रिया दिन्छ, त्यसपछि पुरस्कार (उद्दीपक) पाउँछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कार्यपरक अनुबन्धन सिद्धान्तलाई अर्को कुन नामले पनि चिनिन्छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'स्किनरका अनुसार पुनर्बल (Reinforcement) मुख्यतया कति प्रकारका हुन्छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'स्किनरका अनुसार पुनर्बल (Reinforcement) मुख्यतया कति प्रकारका हुन्छन्?', E'एक', E'दुई (सकारात्मक र नकारात्मक)', E'तीन', E'चार', E'B', E'**स्किनरका अनुसार पुनर्बल मुख्यतया दुई प्रकारका हुन्छन्: सकारात्मक पुनर्बल र नकारात्मक पुनर्बल।**\\nनोट: सकारात्मक पुनर्बलले पुरस्कार दिएर र नकारात्मक पुनर्बलले अप्रिय वस्तु हटाएर व्यवहारको सम्भावना बढाउँछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:स्किनरका अनुसार पुनर्बल (Reinforcement) मुख्यतया कति प्रकारका हुन्छन्?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पुरस्कार (खाना, प्रशंसा, अंक) दिएर व्यवहारको सम्भावना बढाउनुलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'पुरस्कार (खाना, प्रशंसा, अंक) दिएर व्यवहारको सम्भावना बढाउनुलाई के भनिन्छ?', E'सकारात्मक पुनर्बल', E'नकारात्मक पुनर्बल', E'सकारात्मक दण्ड', E'नकारात्मक दण्ड', E'A', E'**पुरस्कार दिएर व्यवहारको सम्भावना बढाउनुलाई सकारात्मक पुनर्बल (Positive Reinforcement) भनिन्छ।**\\n- नकारात्मक पुनर्बलमा अप्रिय वस्तु हटाएर व्यवहार बढाइन्छ।\\n- सकारात्मक दण्डमा गाली वा सजाय दिइन्छ।\\n- नकारात्मक दण्डमा प्रिय वस्तु फिर्ता लिइन्छ।\\nनोट: सकारात्मक पुनर्बललाई सबैभन्दा उत्तम मानिन्छ किनभने यसले सन्तोष दिई व्यवहार दोहोर्‍याउन प्रेरित गर्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पुरस्कार (खाना, प्रशंसा, अंक) दिएर व्यवहारको सम्भावना बढाउनुलाई के भनिन्छ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'अप्रिय वा कष्टकर वस्तु हटाएर व्यवहारको सम्भावना बढाउनुलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'अप्रिय वा कष्टकर वस्तु हटाएर व्यवहारको सम्भावना बढाउनुलाई के भनिन्छ?', E'सकारात्मक पुनर्बल', E'नकारात्मक पुनर्बल', E'दण्ड', E'लोप', E'B', E'**अप्रिय वस्तु हटाएर (जस्तै विद्युतीय झट्का बन्द गरेर) व्यवहारको सम्भावना बढाउनुलाई नकारात्मक पुनर्बल (Negative Reinforcement) भनिन्छ।**\\n- सकारात्मक पुनर्बलमा भने पुरस्कार दिइन्छ।\\nनोट: नकारात्मक पुनर्बल दण्ड होइन; यो व्यवहार बढाउनका लागि हो, घटाउनका लागि होइन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:अप्रिय वा कष्टकर वस्तु हटाएर व्यवहारको सम्भावना बढाउनुलाई के भनिन्छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'निम्नमध्ये कुन प्राथमिक पुनर्बल (Primary Reinforcer) हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'निम्नमध्ये कुन प्राथमिक पुनर्बल (Primary Reinforcer) हो?', E'पैसा', E'अंक', E'खाना र पानी', E'प्रशंसा', E'C', E'**खाना र पानी जस्ता जैविक आवश्यकतासँग सम्बन्धित उद्दीपक प्राथमिक पुनर्बल (Primary Reinforcer) हुन्।**\\n- पैसा, अंक र प्रशंसा भने द्वितीयक (सामाजिक) पुनर्बल हुन्।\\nनोट: प्राथमिक पुनर्बल जीवन बाँच्नका लागि आवश्यक हुन्छ भने द्वितीयक पुनर्बल सिकाइ र अनुभवबाट मूल्यवान् बन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:निम्नमध्ये कुन प्राथमिक पुनर्बल (Primary Reinforcer) हो?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'स्किनरका अनुसार दण्ड (Punishment) ले व्यवहारमा कस्तो प्रभाव पार्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'स्किनरका अनुसार दण्ड (Punishment) ले व्यवहारमा कस्तो प्रभाव पार्छ?', E'व्यवहार बढाउँछ', E'व्यवहार घटाउँछ', E'व्यवहार स्थायी बनाउँछ', E'व्यवहारमा कुनै प्रभाव पार्दैन', E'B', E'**स्किनरका अनुसार दण्ड (Punishment) ले व्यवहार घटाउने काम गर्छ।**\\n- पुनर्बलले भने व्यवहारको सम्भावना बढाउँछ।\\nनोट: दण्डको प्रयोग सधैं प्रभावकारी हुँदैन, किनभने दण्डले व्यवहार दबाउँछ मात्र, सिक्न मद्दत गर्दैन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:स्किनरका अनुसार दण्ड (Punishment) ले व्यवहारमा कस्तो प्रभाव पार्छ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यार्थीको प्रिय वस्तु (जस्तै मोबाइल) फिर्ता लिनु स्किनरका अनुसार कुन प्रकारको हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'विद्यार्थीको प्रिय वस्तु (जस्तै मोबाइल) फिर्ता लिनु स्किनरका अनुसार कुन प्रकारको हो?', E'सकारात्मक पुनर्बल', E'नकारात्मक पुनर्बल', E'सकारात्मक दण्ड', E'नकारात्मक दण्ड', E'D', E'**प्रिय वस्तु (जस्तै मोबाइल) फिर्ता लिनु नकारात्मक दण्ड (Negative Punishment) हो।**\\n- सकारात्मक दण्ड भने गाली वा सजाय दिनु हो।\\n- पुनर्बलले व्यवहार बढाउँछ, दण्डले घटाउँछ।\\nनोट: दुवै प्रकारका दण्डको उद्देश्य अवाञ्छित व्यवहार घटाउनु हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यार्थीको प्रिय वस्तु (जस्तै मोबाइल) फिर्ता लिनु स्किनरका अनुसार कुन प्रकारको हो?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'स्किनरका अनुसार सबैभन्दा प्रभावकारी पुनर्बल तालिका (Schedule) कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'स्किनरका अनुसार सबैभन्दा प्रभावकारी पुनर्बल तालिका (Schedule) कुन हो?', E'निश्चित अनुपात', E'निश्चित अन्तराल', E'चर अनुपात र चर अन्तराल', E'लगातार पुनर्बल', E'C', E'**स्किनरका अनुसार चर अनुपात (Variable Ratio) र चर अन्तराल (Variable Interval) तालिका सबैभन्दा प्रभावकारी मानिन्छन्।**\\n- निश्चित अन्तराल तालिका समयसँग सम्बन्धित हुन्छ।\\n- चर अनुपात तालिका प्रतिक्रियाको अनियमित संख्यासँग सम्बन्धित हुन्छ।\\nनोट: अनियमित पुनर्बलले व्यवहारलाई लामो समयसम्म कायम राख्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:स्किनरका अनुसार सबैभन्दा प्रभावकारी पुनर्बल तालिका (Schedule) कुन हो?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'स-साना चरणमा क्रमशः जटिल लक्ष्य प्राप्त गराउने स्किनरको विधिलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'स-साना चरणमा क्रमशः जटिल लक्ष्य प्राप्त गराउने स्किनरको विधिलाई के भनिन्छ?', E'आकार दिने प्रक्रिया (Shaping)', E'लोप', E'सामान्यीकरण', E'अन्तर्दृष्टि', E'A', E'**स-साना चरणमा क्रमशः जटिल लक्ष्य प्राप्त गराउने विधिलाई आकार दिने प्रक्रिया (Shaping / Behaviour Shaping) भनिन्छ।**\\n- लोप र सामान्यीकरण शास्त्रीय अनुबन्धनका अवधारणा हुन्।\\n- अन्तर्दृष्टि कोहलरको सिद्धान्तको अवधारणा हो।\\nनोट: साना-साना कदम (Small Steps) र तत्काल प्रतिपुष्टि स्किनरको सिद्धान्तका मुख्य शैक्षिक विशेषता हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:स-साना चरणमा क्रमशः जटिल लक्ष्य प्राप्त गराउने स्किनरको विधिलाई के भनिन्छ?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'स्किनरको सिद्धान्तलाई R-S (Response-Stimulus) किन भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'स्किनरको सिद्धान्तलाई R-S (Response-Stimulus) किन भनिन्छ?', E'पहिले उद्दीपक, अनि प्रतिक्रिया आउने भएकाले', E'पहिले प्रतिक्रिया, अनि पुरस्कार (उद्दीपक) आउने भएकाले', E'उद्दीपक र प्रतिक्रिया सँगै आउने भएकाले', E'प्रतिक्रिया नआई पनि सिकाइ हुने भएकाले', E'B', E'**स्किनरको सिद्धान्तलाई R-S भनिन्छ किनभने यसमा जीवले पहिले प्रतिक्रिया (Response) दिन्छ, त्यसपछि पुरस्कार अर्थात् उद्दीपक (Stimulus) पाउँछ।**\\n- पाभ्लोवको शास्त्रीय अनुबन्धनमा भने पहिले उद्दीपक आउँछ (S-R)।\\nनोट: यसैले स्किनरको सिद्धान्तमा विद्यार्थी सक्रिय हुनुपर्छ, किनभने प्रतिक्रिया नदिई पुनर्बल पाउने सम्भावना हुँदैन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:स्किनरको सिद्धान्तलाई R-S (Response-Stimulus) किन भनिन्छ?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'स्किनरको सिद्धान्त कुन मनोवैज्ञानिक सम्प्रदायमा आधारित छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'स्किनरको सिद्धान्त कुन मनोवैज्ञानिक सम्प्रदायमा आधारित छ?', E'संज्ञानवाद', E'समग्रवाद', E'व्यवहारवाद', E'मनोविश्लेषणवाद', E'C', E'**स्किनरको कार्यपरक अनुबन्धन सिद्धान्त व्यवहारवाद (Behaviorism) मा आधारित छ।**\\n- संज्ञानवाद र समग्रवादसँग पियाजे र कोहलरका सिद्धान्त सम्बन्धित छन्।\\n- मनोविश्लेषणवाद फ्रायडसँग सम्बन्धित छ।\\nनोट: पाभ्लोव र थर्नडाइकका सिद्धान्त पनि व्यवहारवादअन्तर्गत नै पर्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:स्किनरको सिद्धान्त कुन मनोवैज्ञानिक सम्प्रदायमा आधारित छ?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'निम्नमध्ये कुन शैक्षिक अभ्यास स्किनरको सिद्धान्तमा आधारित छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'निम्नमध्ये कुन शैक्षिक अभ्यास स्किनरको सिद्धान्तमा आधारित छ?', E'खोज विधि', E'प्रोग्राम्ड लर्निङ र शिक्षण मेसिन', E'समूह छलफल', E'परियोजना विधि', E'B', E'**प्रोग्राम्ड लर्निङ (Programmed Learning) र शिक्षण मेसिन स्किनरको सिद्धान्तमा आधारित छन्।**\\nनोट: शैक्षिक प्रविधि र कम्प्युटर सहायक सिकाइ (CAI) पनि स्किनरकै सिद्धान्तमा आधारित छन्, जसमा सक्रिय सिकाइ, तत्काल प्रतिपुष्टि र स्व-गतिमा सिकाइलाई जोड दिइन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:निम्नमध्ये कुन शैक्षिक अभ्यास स्किनरको सिद्धान्तमा आधारित छ?'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'स्किनरले मुसामाथि स्किनर बक्सको प्रयोग कुन सालमा गरेका थिए?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'स्किनरले मुसामाथि स्किनर बक्सको प्रयोग कुन सालमा गरेका थिए?', E'सन् १९०४', E'सन् १९१३', E'सन् १९३०', E'सन् १९६१', E'C', E'स्किनरले मुसामाथि स्किनर बक्सको प्रयोग सन् **१९३०** को दशकमा गरेका थिए।\\nनोट: पाभ्लोवले १९०४ मा, थर्नडाइकले १९१३ मा र ब्यान्डुराले १९६१ मा आ-आफ्ना प्रयोग गरेका थिए।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:स्किनरले मुसामाथि स्किनर बक्सको प्रयोग कुन सालमा गरेका थिए?'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'निश्चित अन्तराल (Fixed Interval) पुनर्बल तालिका मुख्यतया केसँग सम्बन्धित हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'निश्चित अन्तराल (Fixed Interval) पुनर्बल तालिका मुख्यतया केसँग सम्बन्धित हुन्छ?', E'समय', E'प्रतिक्रियाको संख्या', E'पुरस्कारको आकार', E'सिकारुको उमेर', E'A', E'**निश्चित अन्तराल (Fixed Interval) पुनर्बल तालिका समयसँग सम्बन्धित हुन्छ।**\\n- चर अनुपात (Variable Ratio) तालिका भने प्रतिक्रियाको अनियमित संख्यासँग सम्बन्धित हुन्छ।\\nनोट: अन्तराल तालिका समयमा र अनुपात तालिका प्रतिक्रियाको संख्यामा आधारित हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:निश्चित अन्तराल (Fixed Interval) पुनर्बल तालिका मुख्यतया केसँग सम्बन्धित हुन्छ?'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'स्किनरको प्रयोगमा मुसाले लिभर थिच्दा खाना पाउनु कुन तत्त्वको उदाहरण हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'स्किनरको प्रयोगमा मुसाले लिभर थिच्दा खाना पाउनु कुन तत्त्वको उदाहरण हो?', E'बाधा (Obstacle)', E'पुनर्बल (Reinforcement)', E'तटस्थ उद्दीपक', E'अन्तर्दृष्टि', E'B', E'**मुसाले लिभर थिच्दा खाना पाउनु पुनर्बल (Reinforcement) को उदाहरण हो।**\\nनोट: स्किनरको प्रयोगमा प्राणीले त्यस्तो प्रतिक्रिया दोहोर्‍याउँछ जसका लागि उसले उत्तेजना (खाना) प्राप्त गर्छ; यसले लिभर थिच्ने र खानाबीच सम्बन्ध स्थापित गराउँछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:स्किनरको प्रयोगमा मुसाले लिभर थिच्दा खाना पाउनु कुन तत्त्वको उदाहरण हो?'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'स्किनरको सिद्धान्तमा क्रियापरक व्यवहार (Operant Behaviour) भनेको के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 20, E'स्किनरको सिद्धान्तमा क्रियापरक व्यवहार (Operant Behaviour) भनेको के हो?', E'ज्ञात उत्तेजनाका लागि स्वतः हुने प्रतिक्रिया', E'भविष्यमा उत्तेजना प्राप्तिका लागि वर्तमानमा गरिने प्रतिक्रिया', E'अरूको व्यवहार हेरेर गरिने अनुकरण', E'अकस्मात् आउने समाधान', E'B', E'**क्रियापरक व्यवहार भनेको भविष्यमा रहेको उत्तेजना (पुरस्कार) प्राप्तिका लागि वर्तमानमा गरिने प्रतिक्रिया हो।**\\n- ज्ञात उत्तेजनाका लागि स्वतः हुने प्रतिक्रिया भने पाभ्लोवको प्रतिक्रियात्मक व्यवहार हो।\\n- अरूको व्यवहार हेरेर अनुकरण गर्नु ब्यान्डुराको सामाजिक सिकाइ हो।\\n- अकस्मात् आउने समाधान कोहलरको अन्तर्दृष्टि हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:स्किनरको सिद्धान्तमा क्रियापरक व्यवहार (Operant Behaviour) भनेको के हो?'), v_set_id, v_q_id, 20)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  RAISE NOTICE 'Unit ख-३ theory batch upsert complete: 5 sets, 100 questions.';
END $$;
