-- Idempotent UPSERT import: निमावि प्रथम पत्र — unit घ-३ शिक्षा नियमावली, २०५९ (Level I topic-wise sets)
-- Override same-identity sets/questions; never deletes. Generated 2026-07-02T12:03:10.217Z.
DO $$
DECLARE
  v_module_id uuid := '6695669a-f40e-421a-a4ec-b09bbeaf56c4'::uuid;
  v_set_id uuid;
  v_q_id uuid;
BEGIN

  -- Set: शिक्षा नियमावली, २०५९: विद्यालय व्यवस्थापन समिति, प्रधानाध्यापक र जिल्ला शिक्षा समिति (आधारभूत तह) (13 Q)
  v_set_id := extensions.uuid_generate_v5('8b7f88b1-a68e-4247-a05c-e61b0a82a205'::uuid, E'शिक्षा नियमावली, २०५९: विद्यालय व्यवस्थापन समिति, प्रधानाध्यापक र जिल्ला शिक्षा समिति (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'af1b68f3-8f5e-4735-8f1e-3e5960ba3403'::uuid, '8b7f88b1-a68e-4247-a05c-e61b0a82a205'::uuid, E'शिक्षा नियमावली, २०५९: विद्यालय व्यवस्थापन समिति, प्रधानाध्यापक र जिल्ला शिक्षा समिति (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '8b7f88b1-a68e-4247-a05c-e61b0a82a205'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा नियमावली, २०५९ (संशोधनसहित) अनुसार माध्यमिक तहको प्रधानाध्यापक पदका लागि शिक्षक सिफारिस गर्दा दुई उम्मेदवारको अङ्क बराबर भएमा तलकामध्ये कसलाई प्राथमिकतामा सिफारिस गर्नुपर्ने व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'शिक्षा नियमावली, २०५९ (संशोधनसहित) अनुसार माध्यमिक तहको प्रधानाध्यापक पदका लागि शिक्षक सिफारिस गर्दा दुई उम्मेदवारको अङ्क बराबर भएमा तलकामध्ये कसलाई प्राथमिकतामा सिफारिस गर्नुपर्ने व्यवस्था छ?', E'माथिका सबै (क्रमशः)', E'महिला', E'दलित', E'अपाङ्गता भएको व्यक्ति', E'A', E'**समान अङ्क प्राप्त भएको अवस्थामा क्रमशः महिला, दलित र अपाङ्गता भएको उम्मेदवारलाई प्राथमिकतामा सिफारिस गर्नुपर्दछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा नियमावली, २०५९ (संशोधनसहित) अनुसार माध्यमिक तहको प्रधानाध्यापक पदका लागि शिक्षक सिफारिस गर्दा दुई उम्मेदवारको अङ्क बराबर भएमा तलकामध्ये कसलाई प्राथमिकतामा सिफारिस गर्नुपर्ने व्यवस्था छ?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा नियमावली, २०५९ अनुसार प्रधानाध्यापक छनोट गर्दा नेतृत्व लिने क्षमता बापत इकाई प्रमुख व्यवस्थापन समितिले मूल्याङ्कन गर्ने आधारमा तलकामध्ये कुन पर्दैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'शिक्षा नियमावली, २०५९ अनुसार प्रधानाध्यापक छनोट गर्दा नेतृत्व लिने क्षमता बापत इकाई प्रमुख व्यवस्थापन समितिले मूल्याङ्कन गर्ने आधारमा तलकामध्ये कुन पर्दैन?', E'शिक्षण पेशाप्रति निष्ठावान तथा लगनशील', E'उत्तरदायित्व र पारदर्शिता सम्बन्धी व्यवहार', E'विद्यालयको शैक्षिक गुणस्तरप्रतिको समर्पण भाव', E'शिक्षण गरेको विषयको नतिजाको अवस्था', E'B', E'**उत्तरदायित्व र पारदर्शिता सम्बन्धी व्यवहार नेतृत्व क्षमता मूल्याङ्कनको आधारमा पर्दैन।**\\nनोट: विद्यार्थी, शिक्षक र व्यवस्थापन समितिबीच प्रभावकारी सम्बन्ध स्थापना गर्न र समुदायलाई परिचालन गर्न सक्ने क्षमता पनि यसैमा हेरिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा नियमावली, २०५९ अनुसार प्रधानाध्यापक छनोट गर्दा नेतृत्व लिने क्षमता बापत इकाई प्रमुख व्यवस्थापन समितिले मूल्याङ्कन गर्ने आधारमा तलकामध्ये कुन पर्दैन?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षकले पालना गर्नुपर्ने आचारसंहितामा तलकामध्ये कुन पर्दैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'शिक्षकले पालना गर्नुपर्ने आचारसंहितामा तलकामध्ये कुन पर्दैन?', E'स्वीकृति नलिई आफू खटिएको ठाउँभन्दा बाहिर काम गर्न नहुने', E'विद्यार्थीलाई शारीरिक वा मानसिक यातना दिन नहुने', E'विद्यार्थीलाई विद्यालय बाहिर जहाँसुकै पनि अनुशासनमा राख्नुपर्ने', E'आज्ञाकारिता, अनुशासन, सद्भावना, सहयोग, सदाचार, सहानुभूति, धैर्य र सत्यनिष्ठाको प्रोत्साहन दिनुपर्ने', E'C', E'**विद्यार्थीलाई विद्यालय बाहिर जहाँसुकै अनुशासनमा राख्नुपर्ने भन्ने प्रावधान शिक्षकको आचारसंहितामा पर्दैन।**\\nनोट: नियम १३३ मा शिक्षकले पालना गर्नुपर्ने र नियम १३४ मा विद्यार्थीले पालना गर्नुपर्ने छुट्टाछुट्टै आचारसंहिताको व्यवस्था छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षकले पालना गर्नुपर्ने आचारसंहितामा तलकामध्ये कुन पर्दैन?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सामुदायिक विद्यालयमा कार्यरत शिक्षकको अध्ययन विदा कसले स्वीकृत गर्ने व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'सामुदायिक विद्यालयमा कार्यरत शिक्षकको अध्ययन विदा कसले स्वीकृत गर्ने व्यवस्था छ?', E'सम्बन्धित क्षेत्रको विद्यालय निरीक्षकले', E'विद्यालय व्यवस्थापन समितिको सिफारिसमा शिक्षा विकास तथा समन्वय इकाई प्रमुखले', E'शिक्षक सेवा समितिले', E'विद्यालयको प्रधानाध्यापकले', E'D', E'**सामुदायिक विद्यालयमा कार्यरत शिक्षकको अध्ययन विदा विद्यालयको प्रधानाध्यापकले स्वीकृत गर्दछन्।**\\nनोट: पाँच वर्ष स्थायी सेवा पुगेका शिक्षकले एकैपटक वा पटक-पटक गरी बढीमा तीन वर्षसम्म अध्ययन विदा लिन सक्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सामुदायिक विद्यालयमा कार्यरत शिक्षकको अध्ययन विदा कसले स्वीकृत गर्ने व्यवस्था छ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा नियमावली, २०५९ को नियम १३ बमोजिम विद्यालयको कस्तो प्रमुखको रूपमा काम गर्न विद्यालयमा एकजना प्रधानाध्यापक रहने व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'शिक्षा नियमावली, २०५९ को नियम १३ बमोजिम विद्यालयको कस्तो प्रमुखको रूपमा काम गर्न विद्यालयमा एकजना प्रधानाध्यापक रहने व्यवस्था छ?', E'प्राज्ञिक तथा प्रशासकीय', E'प्रशासकीय मात्र', E'नेतृत्व तथा प्रशासकीय', E'व्यवस्थापकीय तथा प्रशासकीय', E'A', E'**विद्यालयको प्राज्ञिक तथा प्रशासकीय प्रमुखको रूपमा काम गर्न एकजना प्रधानाध्यापक रहने व्यवस्था छ।**\\nनोट: माध्यमिक तहको प्रधानाध्यापक बन्न शिक्षाशास्त्र विषयमा स्नातकोत्तर वा सम्बन्धित विषयमा स्नातक गरी कम्तीमा १० वर्ष स्थायी सेवा गरेको हुनुपर्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा नियमावली, २०५९ को नियम १३ बमोजिम विद्यालयको कस्तो प्रमुखको रूपमा काम गर्न विद्यालयमा एकजना प्रधानाध्यापक रहने व्यवस्था छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'हाल सामुदायिक विद्यालयको विद्यालय व्यवस्थापन समिति गठन तथा व्यवस्थापन गर्ने अधिकार कसमा रहेको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'हाल सामुदायिक विद्यालयको विद्यालय व्यवस्थापन समिति गठन तथा व्यवस्थापन गर्ने अधिकार कसमा रहेको छ?', E'वडा समिति', E'गाउँपालिका र नगरपालिका', E'विद्यालय प्रशासन', E'गाउँ र नगर शिक्षा समिति', E'B', E'**विद्यालय व्यवस्थापन समिति गठन तथा व्यवस्थापन गर्ने अधिकार हाल गाउँपालिका र नगरपालिकामा रहेको छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:हाल सामुदायिक विद्यालयको विद्यालय व्यवस्थापन समिति गठन तथा व्यवस्थापन गर्ने अधिकार कसमा रहेको छ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सामुदायिक विद्यालयको विद्यालय व्यवस्थापन समितिको पदावधि कति वर्षको हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'सामुदायिक विद्यालयको विद्यालय व्यवस्थापन समितिको पदावधि कति वर्षको हुन्छ?', E'दुई वर्ष', E'चार वर्ष', E'तीन वर्ष', E'पाँच वर्ष', E'C', E'**सामुदायिक विद्यालयको विद्यालय व्यवस्थापन समितिको पदावधि तीन वर्षको हुन्छ।**\\nनोट: शिक्षक अभिभावक सङ्घको पदावधि भने दुई वर्षको हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सामुदायिक विद्यालयको विद्यालय व्यवस्थापन समितिको पदावधि कति वर्षको हुन्छ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समावेशी शिक्षा सञ्चालन गर्ने विद्यालयको व्यवस्थापन समितिमा कम्तीमा कतिजना अपाङ्गता भएको व्यक्तिलाई सदस्य बनाउनुपर्ने व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'समावेशी शिक्षा सञ्चालन गर्ने विद्यालयको व्यवस्थापन समितिमा कम्तीमा कतिजना अपाङ्गता भएको व्यक्तिलाई सदस्य बनाउनुपर्ने व्यवस्था छ?', E'दुई जना', E'तीन जना', E'इच्छा अनुसार', E'एकजना', E'D', E'**समावेशी शिक्षा सञ्चालन गर्ने विद्यालयको व्यवस्थापन समितिमा कम्तीमा एकजना अपाङ्गता भएको व्यक्ति सदस्य रहनुपर्दछ।**\\nनोट: विशेष शिक्षा सञ्चालन गर्ने विद्यालयको व्यवस्थापन समितिमा भने कम्तीमा ५०% सदस्य अपाङ्गता भएका व्यक्ति हुनुपर्दछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समावेशी शिक्षा सञ्चालन गर्ने विद्यालयको व्यवस्थापन समितिमा कम्तीमा कतिजना अपाङ्गता भएको व्यक्तिलाई सदस्य बनाउनुपर्ने व्यवस्था छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सामुदायिक विद्यालयको विद्यालय व्यवस्थापन समितिको काम, कर्तव्य र अधिकारमा तलकामध्ये कुन पर्दैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'सामुदायिक विद्यालयको विद्यालय व्यवस्थापन समितिको काम, कर्तव्य र अधिकारमा तलकामध्ये कुन पर्दैन?', E'अनुशासनहीन शिक्षक उपर विभागीय कारबाही चलाउने', E'विद्यालय सञ्चालनका लागि प्राप्त साधन र स्रोतको परिचालन गर्ने', E'शिक्षाको गुणस्तर कायम गर्ने सम्बन्धमा शिक्षक-अभिभावक सङ्गठन गर्ने', E'विद्यालयको चल-अचल सम्पत्तिको लगत राख्ने, राख्न लगाउने र सुरक्षा गर्ने', E'A', E'**अनुशासनहीन शिक्षक उपर विभागीय कारबाही चलाउने अधिकार विद्यालय व्यवस्थापन समितिको काम कर्तव्य अधिकारमा पर्दैन।**\\nनोट: वार्षिक लेखा परीक्षण गराउने र कार्यालयबाट खटिएको शिक्षकलाई हाजिर गराई काममा लगाउने भने समितिकै जिम्मेवारी हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सामुदायिक विद्यालयको विद्यालय व्यवस्थापन समितिको काम, कर्तव्य र अधिकारमा तलकामध्ये कुन पर्दैन?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सामुदायिक विद्यालयको व्यवस्थापन समितिको काम, कर्तव्य र अधिकारमा तलकामध्ये कुन पर्दैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'सामुदायिक विद्यालयको व्यवस्थापन समितिको काम, कर्तव्य र अधिकारमा तलकामध्ये कुन पर्दैन?', E'शिक्षाको गुणस्तर कायम गर्ने सम्बन्धमा शिक्षक-अभिभावक सङ्गठन गर्ने', E'विद्यालयको लेखा परीक्षणका लागि लेखा परीक्षक नियुक्ति गर्ने', E'विद्यालयको वार्षिक बजेट स्वीकृत गरी सोको जानकारी गाउँ शिक्षा समिति र शिक्षा विकास तथा समन्वय इकाइलाई दिने', E'विद्यालयको चल-अचल सम्पत्तिको लगत राख्ने, राख्न लगाउने र सुरक्षा गर्ने', E'B', E'**विद्यालयको लेखा परीक्षणका लागि लेखा परीक्षक नियुक्ति गर्ने कार्य व्यवस्थापन समितिको काम कर्तव्य अधिकारमा पर्दैन।**\\nनोट: जिल्ला शिक्षा समितिले आवश्यक परेमा विद्यालय व्यवस्थापन समिति विघटन गरी अस्थायी व्यवस्थापन समिति गठन गर्न सक्दछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सामुदायिक विद्यालयको व्यवस्थापन समितिको काम, कर्तव्य र अधिकारमा तलकामध्ये कुन पर्दैन?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यालयमा आउने, अध्यापन गर्ने र जाने समय पालना नगर्ने प्रधानाध्यापकलाई नसिहत दिने अधिकारी तलकामध्ये को रहने व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'विद्यालयमा आउने, अध्यापन गर्ने र जाने समय पालना नगर्ने प्रधानाध्यापकलाई नसिहत दिने अधिकारी तलकामध्ये को रहने व्यवस्था छ?', E'विद्यालय व्यवस्थापन समिति अध्यक्ष', E'स्थानीय शिक्षा शाखा प्रमुख', E'शिक्षा विकास तथा समन्वय इकाइ प्रमुख', E'विद्यालय विकास तथा समन्वय समिति', E'C', E'**समय पालना नगर्ने प्रधानाध्यापकलाई नसिहत दिने अधिकारी शिक्षा विकास तथा समन्वय इकाइ प्रमुख हुन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यालयमा आउने, अध्यापन गर्ने र जाने समय पालना नगर्ने प्रधानाध्यापकलाई नसिहत दिने अधिकारी तलकामध्ये को रहने व्यवस्था छ?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै जिल्लाको जिल्ला शिक्षा समितिले तोकिएको जिम्मेवारी पूरा गर्न नसकेमा कसले सो जिल्ला शिक्षा समितिलाई विघटन गर्न सक्नेछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'कुनै जिल्लाको जिल्ला शिक्षा समितिले तोकिएको जिम्मेवारी पूरा गर्न नसकेमा कसले सो जिल्ला शिक्षा समितिलाई विघटन गर्न सक्नेछ?', E'शिक्षा तथा मानव स्रोत विकास केन्द्र', E'शिक्षा, विज्ञान तथा प्रविधि मन्त्रालय', E'नेपाल सरकार', E'जिल्ला समन्वय समिति', E'D', E'**जिम्मेवारी पूरा गर्न नसकेको जिल्ला शिक्षा समितिलाई जिल्ला समन्वय समितिले विघटन गर्न सक्दछ।**\\nनोट: जिल्ला शिक्षा समितिको संयोजक जिल्ला समन्वय समितिको अध्यक्ष हुन्छन्, र सदस्य-सचिव इकाई प्रमुख हुन्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै जिल्लाको जिल्ला शिक्षा समितिले तोकिएको जिम्मेवारी पूरा गर्न नसकेमा कसले सो जिल्ला शिक्षा समितिलाई विघटन गर्न सक्नेछ?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यालय प्रधानाध्यापक, प्रधानाध्यापकसँग समान श्रेणीको शिक्षक र प्रधानाध्यापकभन्दा माथिल्लो श्रेणीको शिक्षकको कार्यसम्पादन मूल्याङ्कन गर्दा सुपरिवेक्षक तलकामध्ये को रहने व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'विद्यालय प्रधानाध्यापक, प्रधानाध्यापकसँग समान श्रेणीको शिक्षक र प्रधानाध्यापकभन्दा माथिल्लो श्रेणीको शिक्षकको कार्यसम्पादन मूल्याङ्कन गर्दा सुपरिवेक्षक तलकामध्ये को रहने व्यवस्था छ?', E'स्थानीय तहको शिक्षा हेर्ने प्रमुख', E'विद्यालय व्यवस्थापन समितिका अध्यक्ष', E'विद्यालय निरीक्षक', E'शिक्षा विकास तथा समन्वय इकाइ प्रमुख', E'A', E'**यस्तो अवस्थामा सुपरिवेक्षक स्थानीय तहको शिक्षा हेर्ने प्रमुख हुन्छन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यालय प्रधानाध्यापक, प्रधानाध्यापकसँग समान श्रेणीको शिक्षक र प्रधानाध्यापकभन्दा माथिल्लो श्रेणीको शिक्षकको कार्यसम्पादन मूल्याङ्कन गर्दा सुपरिवेक्षक तलकामध्ये को रहने व्यवस्था छ?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: शिक्षा नियमावली, २०५९: शिक्षक सेवा-शर्त — विदा, आचारसंहिता र सजाय (आधारभूत तह) (9 Q)
  v_set_id := extensions.uuid_generate_v5('fa05141b-9aad-4cc3-aaea-971f495aa89e'::uuid, E'शिक्षा नियमावली, २०५९: शिक्षक सेवा-शर्त — विदा, आचारसंहिता र सजाय (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'af1b68f3-8f5e-4735-8f1e-3e5960ba3403'::uuid, 'fa05141b-9aad-4cc3-aaea-971f495aa89e'::uuid, E'शिक्षा नियमावली, २०५९: शिक्षक सेवा-शर्त — विदा, आचारसंहिता र सजाय (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'fa05141b-9aad-4cc3-aaea-971f495aa89e'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यालयले दशैं विदा, हिउँदे विदा वा बर्खे विदाका अतिरिक्त एक शैक्षिक सत्रमा उपयोग गर्न सक्ने पाँच दिनको स्थानीय विदा कसको निर्णयमा गर्न सक्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'विद्यालयले दशैं विदा, हिउँदे विदा वा बर्खे विदाका अतिरिक्त एक शैक्षिक सत्रमा उपयोग गर्न सक्ने पाँच दिनको स्थानीय विदा कसको निर्णयमा गर्न सक्छ?', E'गाउँ/नगर शिक्षा समिति', E'विद्यालय व्यवस्थापन समिति', E'शिक्षक स्टाफ बैठक', E'वडा शिक्षा समिति', E'B', E'**पाँच दिनको स्थानीय विदा विद्यालय व्यवस्थापन समितिको निर्णयमा गर्न सकिन्छ।**\\nनोट: एक शैक्षिक सत्रमा हिउँदे र बर्खे विदा गरी दुवैको जम्मा ३५ दिन विद्यालय बन्द हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यालयले दशैं विदा, हिउँदे विदा वा बर्खे विदाका अतिरिक्त एक शैक्षिक सत्रमा उपयोग गर्न सक्ने पाँच दिनको स्थानीय विदा कसको निर्णयमा गर्न सक्छ?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा नियमावली, २०५९ अनुसार कुनै शिक्षकले विद्यालय छोडी गएमा निजको जिम्मामा रहेको नगद, जिन्सी वा सामानको बरबुझार्थ कति दिनभित्र गर्नुपर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'शिक्षा नियमावली, २०५९ अनुसार कुनै शिक्षकले विद्यालय छोडी गएमा निजको जिम्मामा रहेको नगद, जिन्सी वा सामानको बरबुझार्थ कति दिनभित्र गर्नुपर्छ?', E'बढीमा ७ दिन', E'३५ दिन', E'१५ दिन', E'२१ दिन', E'C', E'**विद्यालय छोडी गएको शिक्षकको नगद, जिन्सी वा सामानको बरबुझार्थ १५ दिनभित्र गर्नुपर्छ।**\\nनोट: बरबुझार्थ गर्न नसकिएमा निजले पाउने तलब रोक्का गरी असुल-उपर गरिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा नियमावली, २०५९ अनुसार कुनै शिक्षकले विद्यालय छोडी गएमा निजको जिम्मामा रहेको नगद, जिन्सी वा सामानको बरबुझार्थ कति दिनभित्र गर्नुपर्छ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएका विदाहरूमध्ये शिक्षकले आधा दिन पनि लिन सक्ने विदा कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'तल दिइएका विदाहरूमध्ये शिक्षकले आधा दिन पनि लिन सक्ने विदा कुन हो?', E'असाधारण बिदा', E'अध्ययन बिदा', E'बेतलबी बिदा', E'पर्व बिदा', E'D', E'**पर्व बिदा आधा दिन पनि लिन सकिने विदा हो।**\\nनोट: भैपरी आउने बिदा पनि आधा दिन लिन सकिन्छ; पर्व बिदा र भैपरी आउने बिदा दुवै वर्षमा ६/६ दिनसम्म लिन सकिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएका विदाहरूमध्ये शिक्षकले आधा दिन पनि लिन सक्ने विदा कुन हो?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै शिक्षकलाई आफूले गरेको कार्यबापत निलम्बन गर्दा साधारणतया कति समयका लागि निलम्बन गर्न सकिने व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'कुनै शिक्षकलाई आफूले गरेको कार्यबापत निलम्बन गर्दा साधारणतया कति समयका लागि निलम्बन गर्न सकिने व्यवस्था छ?', E'तीन महिनासम्म', E'दुई महिनासम्म', E'छ महिनासम्म', E'एक वर्षसम्म', E'A', E'**शिक्षकलाई साधारणतया तीन महिनासम्म निलम्बन गर्न सकिन्छ।**\\nनोट: निलम्बनको अवधिमा शिक्षकले आफूले पाउने तलबको आधा रकम पाउने व्यवस्था छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै शिक्षकलाई आफूले गरेको कार्यबापत निलम्बन गर्दा साधारणतया कति समयका लागि निलम्बन गर्न सकिने व्यवस्था छ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा नियमावली, २०५९ अनुसार तलकामध्ये कस्तो अवस्थामा शिक्षकलाई नोकरीबाट बर्खास्त गरिने व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'शिक्षा नियमावली, २०५९ अनुसार तलकामध्ये कस्तो अवस्थामा शिक्षकलाई नोकरीबाट बर्खास्त गरिने व्यवस्था छ?', E'नैतिक पतन देखिने फौजदारी अभियोगमा अदालतबाट सजाय पाएमा', E'माथिका सबै', E'स्थायी आवासीय अनुमति लिएमा वा सोका लागि आवेदन गरेमा', E'भ्रष्टाचार गरेमा', E'B', E'**माथिका सबै अवस्थामा शिक्षकलाई नोकरीबाट बर्खास्त गर्न सकिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा नियमावली, २०५९ अनुसार तलकामध्ये कस्तो अवस्थामा शिक्षकलाई नोकरीबाट बर्खास्त गरिने व्यवस्था छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा नियमावली, २०५९ अनुसार शिक्षकले नोकरीको तमाम अवधिमा अधिकतम कति असाधारण विदा लिन सक्ने व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'शिक्षा नियमावली, २०५९ अनुसार शिक्षकले नोकरीको तमाम अवधिमा अधिकतम कति असाधारण विदा लिन सक्ने व्यवस्था छ?', E'एकैपटक वा पटक-पटक गरी बढीमा तीन वर्ष', E'एकैपटक वा पटक-पटक गरी बढीमा पाँच वर्ष', E'एक पटकमा एक वर्ष नबढाई बढीमा एक वर्ष', E'एक पटकमा एक वर्ष नबढाई बढीमा पाँच वर्ष', E'C', E'**शिक्षकले नोकरीको तमाम अवधिमा एक पटकमा एक वर्ष नबढाई बढीमा एक वर्षसम्म असाधारण विदा लिन सक्दछन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा नियमावली, २०५९ अनुसार शिक्षकले नोकरीको तमाम अवधिमा अधिकतम कति असाधारण विदा लिन सक्ने व्यवस्था छ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलकामध्ये कस्तो अवस्थामा शिक्षकमा कार्यक्षमताको अभाव भएको मानिने व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'तलकामध्ये कस्तो अवस्थामा शिक्षकमा कार्यक्षमताको अभाव भएको मानिने व्यवस्था छ?', E'आफूले अध्यापन गराएको विषयमा लगातार दुई शैक्षिक सत्रसम्म ५०% भन्दा कम विद्यार्थी उत्तीर्ण भएमा', E'आफूले अध्यापन गराएको विषयमा लगातार पाँच शैक्षिक सत्रसम्म ५०% भन्दा कम विद्यार्थी उत्तीर्ण भएमा', E'आफूले अध्यापन गराएको विषयमा लगातार तीन शैक्षिक सत्रसम्म ४०% भन्दा कम विद्यार्थी उत्तीर्ण भएमा', E'आफूले अध्यापन गराएको विषयमा लगातार तीन शैक्षिक सत्रसम्म ५०% भन्दा कम विद्यार्थी उत्तीर्ण भएमा', E'D', E'**आफूले अध्यापन गराएको विषयमा लगातार तीन शैक्षिक सत्रसम्म ५०% भन्दा कम विद्यार्थी उत्तीर्ण भएमा कार्यक्षमताको अभाव भएको मानिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलकामध्ये कस्तो अवस्थामा शिक्षकमा कार्यक्षमताको अभाव भएको मानिने व्यवस्था छ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शैक्षिक गुठीको आय-व्ययको लेखा तलकामध्ये कसबाट लेखापरीक्षण गराउनुपर्ने व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'शैक्षिक गुठीको आय-व्ययको लेखा तलकामध्ये कसबाट लेखापरीक्षण गराउनुपर्ने व्यवस्था छ?', E'मान्यता प्राप्त लेखापरीक्षकबाट', E'महालेखा परीक्षकले खटाएको लेखापरीक्षकबाट', E'स्थानीय तहबाट खटाइएको लेखापरीक्षकबाट', E'शिक्षा विकास तथा समन्वय इकाइबाट खटाइएको लेखापरीक्षकबाट', E'A', E'**शैक्षिक गुठीको आय-व्ययको लेखा मान्यता प्राप्त लेखापरीक्षकबाट लेखापरीक्षण गराउनुपर्दछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शैक्षिक गुठीको आय-व्ययको लेखा तलकामध्ये कसबाट लेखापरीक्षण गराउनुपर्ने व्यवस्था छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यालय प्रमाणपत्र भङ्ग गरेको वा उत्तरपुस्तिका परीक्षण गर्दा लापरवाही गरेको भनी गरिएको कारबाही उपर चित्त नबुझेमा कति दिनभित्र पुनरावेदन गर्न सकिने व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'विद्यालय प्रमाणपत्र भङ्ग गरेको वा उत्तरपुस्तिका परीक्षण गर्दा लापरवाही गरेको भनी गरिएको कारबाही उपर चित्त नबुझेमा कति दिनभित्र पुनरावेदन गर्न सकिने व्यवस्था छ?', E'२१ दिनभित्र', E'३० दिनभित्र', E'३५ दिनभित्र', E'१ दिनभित्र', E'B', E'**यस्तो कारबाही उपर चित्त नबुझेमा ३० दिनभित्र पुनरावेदन गर्न सकिन्छ।**\\nनोट: प्रमुख जिल्ला अधिकारीले गरेको सजायको आदेश उपर चित्त नबुझेमा जिल्ला अदालतमा पुनरावेदन गर्न सकिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यालय प्रमाणपत्र भङ्ग गरेको वा उत्तरपुस्तिका परीक्षण गर्दा लापरवाही गरेको भनी गरिएको कारबाही उपर चित्त नबुझेमा कति दिनभित्र पुनरावेदन गर्न सकिने व्यवस्था छ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: शिक्षा नियमावली, २०५९: विद्यालय दर्ता, वर्गीकरण, कोष र सम्पत्ति व्यवस्थापन (आधारभूत तह) (14 Q)
  v_set_id := extensions.uuid_generate_v5('a39c4c5d-a6bc-4499-b853-0191412ee9a3'::uuid, E'शिक्षा नियमावली, २०५९: विद्यालय दर्ता, वर्गीकरण, कोष र सम्पत्ति व्यवस्थापन (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'af1b68f3-8f5e-4735-8f1e-3e5960ba3403'::uuid, 'a39c4c5d-a6bc-4499-b853-0191412ee9a3'::uuid, E'शिक्षा नियमावली, २०५९: विद्यालय दर्ता, वर्गीकरण, कोष र सम्पत्ति व्यवस्थापन (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'a39c4c5d-a6bc-4499-b853-0191412ee9a3'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा नियमावली, २०५९ (संशोधनसहित) को नियम १८९(क) अनुसार कोचिङ कक्षा सञ्चालन गर्न चाहने व्यक्तिले कति रकम धरौटी राख्नुपर्ने व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'शिक्षा नियमावली, २०५९ (संशोधनसहित) को नियम १८९(क) अनुसार कोचिङ कक्षा सञ्चालन गर्न चाहने व्यक्तिले कति रकम धरौटी राख्नुपर्ने व्यवस्था छ?', E'२५ हजार', E'५० हजार', E'७५ हजार', E'१ लाख', E'C', E'**कोचिङ कक्षा सञ्चालन गर्न चाहने व्यक्तिले ७५ हजार रुपैयाँ धरौटी राख्नुपर्दछ।**\\nनोट: यस्तो अनुमति शिक्षा विकास तथा समन्वय इकाई प्रमुखले दिने र निजले तोकेको बैंकमा धरौटी राख्नुपर्ने व्यवस्था छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा नियमावली, २०५९ (संशोधनसहित) को नियम १८९(क) अनुसार कोचिङ कक्षा सञ्चालन गर्न चाहने व्यक्तिले कति रकम धरौटी राख्नुपर्ने व्यवस्था छ?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा नियमावली, २०५९ को नियम ७७ अनुसार सामुदायिक विद्यालयको प्रत्येक कक्षामा विद्यार्थी सङ्ख्या उपत्यका तथा तराई, पहाड र हिमाली क्षेत्रमा सामान्यतया क्रमशः कति हुनुपर्ने व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'शिक्षा नियमावली, २०५९ को नियम ७७ अनुसार सामुदायिक विद्यालयको प्रत्येक कक्षामा विद्यार्थी सङ्ख्या उपत्यका तथा तराई, पहाड र हिमाली क्षेत्रमा सामान्यतया क्रमशः कति हुनुपर्ने व्यवस्था छ?', E'४४, ३३ र २२', E'४५, ४० र ३५', E'५०, ३० र २०', E'५०, ४५ र ४०', E'D', E'**सामुदायिक विद्यालयको प्रत्येक कक्षामा विद्यार्थी सङ्ख्या उपत्यका तथा तराई, पहाड र हिमाली क्षेत्रमा क्रमशः ५०, ४५ र ४० हुनुपर्दछ।**\\nनोट: संस्थागत विद्यालयको प्रत्येक कक्षामा भने न्यूनतम २२, अधिकतम ४४ र औसत ३३ विद्यार्थी सङ्ख्या हुनुपर्ने छुट्टै व्यवस्था छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा नियमावली, २०५९ को नियम ७७ अनुसार सामुदायिक विद्यालयको प्रत्येक कक्षामा विद्यार्थी सङ्ख्या उपत्यका तथा तराई, पहाड र हिमाली क्षेत्रमा सामान्यतया क्रमशः कति हुनुपर्ने व्यवस्था छ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा नियमावली, २०५९ को नियम ७७ अनुसार संस्थागत विद्यालयको प्रत्येक कक्षामा विद्यार्थी सङ्ख्या न्यूनतम, अधिकतम र औसत गरी कति हुनुपर्ने व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'शिक्षा नियमावली, २०५९ को नियम ७७ अनुसार संस्थागत विद्यालयको प्रत्येक कक्षामा विद्यार्थी सङ्ख्या न्यूनतम, अधिकतम र औसत गरी कति हुनुपर्ने व्यवस्था छ?', E'२२, ४४ र ३३', E'२०, ४०  र ३०', E'२५, ५० र ३५', E'१५, ३० र २०', E'A', E'**संस्थागत विद्यालयको प्रत्येक कक्षामा न्यूनतम २२, अधिकतम ४४ र औसत ३३ विद्यार्थी सङ्ख्या हुनुपर्दछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा नियमावली, २०५९ को नियम ७७ अनुसार संस्थागत विद्यालयको प्रत्येक कक्षामा विद्यार्थी सङ्ख्या न्यूनतम, अधिकतम र औसत गरी कति हुनुपर्ने व्यवस्था छ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शैक्षिक गुठीका प्रकार तलकामध्ये कुन उपयुक्त हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'शैक्षिक गुठीका प्रकार तलकामध्ये कुन उपयुक्त हो?', E'सामुदायिक वा निजी गुठी', E'सार्वजनिक वा निजी गुठी', E'सामुदायिक वा सार्वजनिक गुठी', E'सार्वजनिक गुठी मात्र', E'B', E'**शैक्षिक गुठी सार्वजनिक वा निजी गरी दुई प्रकारका हुन्छन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शैक्षिक गुठीका प्रकार तलकामध्ये कुन उपयुक्त हो?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा नियमावली, २०५९ को परिच्छेद ३२ मा भएको शिक्षा विकास कोष सम्बन्धी भनाइहरूमध्ये तलकामध्ये कुन गलत छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'शिक्षा नियमावली, २०५९ को परिच्छेद ३२ मा भएको शिक्षा विकास कोष सम्बन्धी भनाइहरूमध्ये तलकामध्ये कुन गलत छ?', E'शिक्षा विकास कोषको लेखापरीक्षण महालेखा परीक्षकको कार्यालयबाट हुनेछ', E'शिक्षा विकास तथा सञ्चालक समितिको बैठक वर्षमा कम्तीमा तीनपटक बस्नेछ', E'संस्थागत विद्यालयले प्रत्येक महिना एक रुपैयाँ दरले हुन आउने रकम वार्षिक रूपमा शिक्षा विकास कोषमा जम्मा गर्नुपर्नेछ', E'शिक्षा विकास कोषमा जम्मा भएको रकम इकाई प्रमुखले आवश्यकता अनुसार बजेट बनाई सोही जिल्लामा खर्च गर्न सक्नेछ', E'C', E'**यो भनाइ गलत हो — जम्मा गर्ने प्रयोजनका लागि प्रत्येक जिल्ला सदरमुकाममा कुनै बैंकमा खाता खोलिनेछ र सो रकम इकाई प्रमुखले कोषमा पठाउनुपर्नेछ, वार्षिक एकमुष्ट होइन।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा नियमावली, २०५९ को परिच्छेद ३२ मा भएको शिक्षा विकास कोष सम्बन्धी भनाइहरूमध्ये तलकामध्ये कुन गलत छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सामुदायिक विद्यालयको नाममा रहेको सम्पत्तिको व्यवस्थापन र संरक्षण गर्नका लागि जिल्ला स्थित विद्यालय सम्पत्ति संरक्षण समितिको अध्यक्ष तलकामध्ये को रहने व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'सामुदायिक विद्यालयको नाममा रहेको सम्पत्तिको व्यवस्थापन र संरक्षण गर्नका लागि जिल्ला स्थित विद्यालय सम्पत्ति संरक्षण समितिको अध्यक्ष तलकामध्ये को रहने व्यवस्था छ?', E'शिक्षा विकास तथा समन्वय इकाई प्रमुख', E'जिल्ला शिक्षा समिति प्रमुख', E'जिल्ला प्रशासन कार्यालय प्रमुख', E'प्रमुख जिल्ला अधिकारी', E'D', E'**विद्यालय सम्पत्ति संरक्षण समितिको अध्यक्ष प्रमुख जिल्ला अधिकारी हुन्छन्।**\\nनोट: यो पाँच सदस्यीय समिति हो जसमा शिक्षा विकास तथा समन्वय इकाई प्रमुख पनि सदस्यको रूपमा रहन्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सामुदायिक विद्यालयको नाममा रहेको सम्पत्तिको व्यवस्थापन र संरक्षण गर्नका लागि जिल्ला स्थित विद्यालय सम्पत्ति संरक्षण समितिको अध्यक्ष तलकामध्ये को रहने व्यवस्था छ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा नियमावलीमा भएको व्यवस्था अनुसार सामुदायिक विद्यालयले भौतिक पूर्वाधार विकासका लागि आफ्नो नाममा रहेको जग्गा बिक्री-वितरण गर्न चाहेमा कसको स्वीकृति लिनुपर्नेछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'शिक्षा नियमावलीमा भएको व्यवस्था अनुसार सामुदायिक विद्यालयले भौतिक पूर्वाधार विकासका लागि आफ्नो नाममा रहेको जग्गा बिक्री-वितरण गर्न चाहेमा कसको स्वीकृति लिनुपर्नेछ?', E'शिक्षा विकास तथा समन्वय इकाई प्रमुख', E'स्थानीय तह', E'गाउँ/नगर शिक्षा समिति', E'शिक्षा मन्त्रालय', E'A', E'**यस्तो जग्गा बिक्री-वितरण गर्न शिक्षा विकास तथा समन्वय इकाई प्रमुखको स्वीकृति लिनुपर्नेछ।**\\nनोट: विद्यालयको कुल जग्गाको २५% सम्म भने मन्त्रालयको स्वीकृति नलिई बिक्री गर्न सकिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा नियमावलीमा भएको व्यवस्था अनुसार सामुदायिक विद्यालयले भौतिक पूर्वाधार विकासका लागि आफ्नो नाममा रहेको जग्गा बिक्री-वितरण गर्न चाहेमा कसको स्वीकृति लिनुपर्नेछ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि दैवी प्रकोप वा काबु बाहिरको परिस्थितिले गर्दा सामुदायिक विद्यालयको सम्पत्तिमा १ लाख रुपैयाँभन्दा माथिको हानि-नोक्सानी हुन गएको प्रमाणित भएमा त्यसको मन्जुरी दिने अधिकार कसलाई छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'यदि दैवी प्रकोप वा काबु बाहिरको परिस्थितिले गर्दा सामुदायिक विद्यालयको सम्पत्तिमा १ लाख रुपैयाँभन्दा माथिको हानि-नोक्सानी हुन गएको प्रमाणित भएमा त्यसको मन्जुरी दिने अधिकार कसलाई छ?', E'शिक्षा विकास तथा समन्वय इकाई प्रमुख', E'शिक्षा मन्त्रालय', E'सम्बन्धित निर्देशक', E'स्थानीय तह', E'B', E'**१ लाख रुपैयाँभन्दा माथिको हानि-नोक्सानी मन्जुर गर्ने अधिकार शिक्षा मन्त्रालयलाई छ।**\\nनोट: यो अधिकार रकमको आकार अनुसार तहगत रूपमा बाँडिएको छ — ५ हजारसम्म प्रधानाध्यापकको सिफारिसमा व्यवस्थापन समितिले, १० हजारसम्म इकाई प्रमुखले, २० हजारसम्म निर्देशकले र सोभन्दा बढी भए मन्त्रालयले निर्णय दिन सक्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि दैवी प्रकोप वा काबु बाहिरको परिस्थितिले गर्दा सामुदायिक विद्यालयको सम्पत्तिमा १ लाख रुपैयाँभन्दा माथिको हानि-नोक्सानी हुन गएको प्रमाणित भएमा त्यसको मन्जुरी दिने अधिकार कसलाई छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'माध्यमिक तहसम्मको परीक्षा कक्षासहित सञ्चालन गर्न चाहने संस्थागत विद्यालयले कति रकम धरौटी राख्नुपर्ने व्यवस्था शिक्षा नियमावलीमा छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'माध्यमिक तहसम्मको परीक्षा कक्षासहित सञ्चालन गर्न चाहने संस्थागत विद्यालयले कति रकम धरौटी राख्नुपर्ने व्यवस्था शिक्षा नियमावलीमा छ?', E'१ लाख ५० हजार', E'दुई लाख', E'तीन लाख', E'५० हजार', E'C', E'**माध्यमिक परीक्षा कक्षासहित सञ्चालन गर्न तीन लाख रुपैयाँ धरौटी राख्नुपर्दछ।**\\nनोट: प्राथमिक तहका लागि ५० हजार र निम्न माध्यमिक तहका लागि १ लाख ५० हजार धरौटी राख्नुपर्ने छुट्टै व्यवस्था छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:माध्यमिक तहसम्मको परीक्षा कक्षासहित सञ्चालन गर्न चाहने संस्थागत विद्यालयले कति रकम धरौटी राख्नुपर्ने व्यवस्था शिक्षा नियमावलीमा छ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'संस्थागत विद्यालयले विद्यालयमा भर्ना भएका कुल विद्यार्थी सङ्ख्याको कति प्रतिशत नघट्ने गरी विपन्न, अपाङ्ग, महिला, दलित वा जनजाति विद्यार्थीलाई निःशुल्क छात्रवृत्ति उपलब्ध गराउनुपर्ने व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'संस्थागत विद्यालयले विद्यालयमा भर्ना भएका कुल विद्यार्थी सङ्ख्याको कति प्रतिशत नघट्ने गरी विपन्न, अपाङ्ग, महिला, दलित वा जनजाति विद्यार्थीलाई निःशुल्क छात्रवृत्ति उपलब्ध गराउनुपर्ने व्यवस्था छ?', E'५ प्रतिशत', E'१५ प्रतिशत', E'२० प्रतिशत', E'१० प्रतिशत', E'D', E'**संस्थागत विद्यालयले कुल विद्यार्थी सङ्ख्याको कम्तीमा १० प्रतिशत नघट्ने गरी यस्ता विद्यार्थीलाई निःशुल्क छात्रवृत्ति दिनुपर्दछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:संस्थागत विद्यालयले विद्यालयमा भर्ना भएका कुल विद्यार्थी सङ्ख्याको कति प्रतिशत नघट्ने गरी विपन्न, अपाङ्ग, महिला, दलित वा जनजाति विद्यार्थीलाई निःशुल्क छात्रवृत्ति उपलब्ध गराउनुपर्ने व्यवस्था छ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सामुदायिक विद्यालयले प्रत्येक कक्षामा तृतीय स्थान हासिल गर्ने सफल विद्यार्थीलाई शुल्क मिनाहा गरी जेहनदार छात्रवृत्ति उपलब्ध गराउने बाध्यात्मक व्यवस्था छ कि छैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'सामुदायिक विद्यालयले प्रत्येक कक्षामा तृतीय स्थान हासिल गर्ने सफल विद्यार्थीलाई शुल्क मिनाहा गरी जेहनदार छात्रवृत्ति उपलब्ध गराउने बाध्यात्मक व्यवस्था छ कि छैन?', E'छुट दिनुपर्ने बाध्यात्मक व्यवस्था छैन', E'शत प्रतिशत छुट दिनुपर्ने बाध्यात्मक व्यवस्था छ', E'५० प्रतिशत छुट दिनुपर्ने बाध्यात्मक व्यवस्था छ', E'२५ प्रतिशत छुट दिनुपर्ने बाध्यात्मक व्यवस्था छ', E'A', E'**तृतीय स्थान हासिल गर्ने विद्यार्थीलाई छुट दिनुपर्ने बाध्यात्मक व्यवस्था छैन।**\\nनोट: प्रथम स्थानका लागि शतप्रतिशत र द्वितीय स्थानका लागि ५०% शुल्क मिनाहा दिने व्यवस्था छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सामुदायिक विद्यालयले प्रत्येक कक्षामा तृतीय स्थान हासिल गर्ने सफल विद्यार्थीलाई शुल्क मिनाहा गरी जेहनदार छात्रवृत्ति उपलब्ध गराउने बाध्यात्मक व्यवस्था छ कि छैन?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सार्वजनिक शैक्षिक गुठीको रूपमा सञ्चालित विद्यालयले उत्तराधिकारी तोक्दा कुन निकायबाट स्वीकृति लिनुपर्ने व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'सार्वजनिक शैक्षिक गुठीको रूपमा सञ्चालित विद्यालयले उत्तराधिकारी तोक्दा कुन निकायबाट स्वीकृति लिनुपर्ने व्यवस्था छ?', E'जिल्ला शिक्षा कार्यालय', E'शिक्षा मन्त्रालय', E'शिक्षा विभाग', E'जिल्ला शिक्षा समिति', E'B', E'**सार्वजनिक शैक्षिक गुठीको उत्तराधिकारी तोक्न शिक्षा मन्त्रालयको स्वीकृति लिनुपर्दछ।**\\nनोट: सार्वजनिक गुठीमा पञ्चकर र निजी गुठीमा कम्तीमा तीनजना सदस्य हुनुपर्ने व्यवस्था छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सार्वजनिक शैक्षिक गुठीको रूपमा सञ्चालित विद्यालयले उत्तराधिकारी तोक्दा कुन निकायबाट स्वीकृति लिनुपर्ने व्यवस्था छ?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सामुदायिक विद्यालयलाई शैक्षिक पूर्वाधार निर्माण र मर्मतसम्भारका लागि आवश्यक बजेट व्यवस्थापन गर्ने जिम्मेवार निकाय तलकामध्ये कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'सामुदायिक विद्यालयलाई शैक्षिक पूर्वाधार निर्माण र मर्मतसम्भारका लागि आवश्यक बजेट व्यवस्थापन गर्ने जिम्मेवार निकाय तलकामध्ये कुन हो?', E'गाउँ/नगर शिक्षा समिति', E'वडा समिति', E'गाउँ/नगरपालिका', E'शिक्षा विकास तथा समन्वय इकाई', E'C', E'**सामुदायिक विद्यालयको शैक्षिक पूर्वाधार निर्माण र मर्मतसम्भार बजेट व्यवस्थापन गर्ने जिम्मेवारी गाउँ/नगरपालिकाको हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सामुदायिक विद्यालयलाई शैक्षिक पूर्वाधार निर्माण र मर्मतसम्भारका लागि आवश्यक बजेट व्यवस्थापन गर्ने जिम्मेवार निकाय तलकामध्ये कुन हो?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा नियमावली, २०५९ (संशोधनसहित) अनुसार कुनै संस्थाले दूरशिक्षा सञ्चालन गर्न चाहेमा स्वीकृतिका लागि कसको समक्ष निवेदन दिनुपर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'शिक्षा नियमावली, २०५९ (संशोधनसहित) अनुसार कुनै संस्थाले दूरशिक्षा सञ्चालन गर्न चाहेमा स्वीकृतिका लागि कसको समक्ष निवेदन दिनुपर्छ?', E'शिक्षा विकास तथा समन्वय इकाई', E'दूर शिक्षा समिति', E'पाठ्यक्रम विकास केन्द्र', E'शिक्षा तथा मानव स्रोत विकास केन्द्र', E'D', E'**दूरशिक्षा सञ्चालनको स्वीकृतिका लागि शिक्षा तथा मानव स्रोत विकास केन्द्र समक्ष निवेदन दिनुपर्छ।**\\nनोट: दूरशिक्षा समितिमा ९ सदस्य रहन्छन्, जसको अध्यक्ष मन्त्रालयका सचिव हुन्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा नियमावली, २०५९ (संशोधनसहित) अनुसार कुनै संस्थाले दूरशिक्षा सञ्चालन गर्न चाहेमा स्वीकृतिका लागि कसको समक्ष निवेदन दिनुपर्छ?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: शिक्षा नियमावली, २०५९: राष्ट्रिय परीक्षा बोर्ड, भर्ना र शैक्षिक सत्र व्यवस्था (आधारभूत तह) (8 Q)
  v_set_id := extensions.uuid_generate_v5('92ef2762-3616-4dd6-b1b3-e16ed174b2f5'::uuid, E'शिक्षा नियमावली, २०५९: राष्ट्रिय परीक्षा बोर्ड, भर्ना र शैक्षिक सत्र व्यवस्था (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'af1b68f3-8f5e-4735-8f1e-3e5960ba3403'::uuid, '92ef2762-3616-4dd6-b1b3-e16ed174b2f5'::uuid, E'शिक्षा नियमावली, २०५९: राष्ट्रिय परीक्षा बोर्ड, भर्ना र शैक्षिक सत्र व्यवस्था (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '92ef2762-3616-4dd6-b1b3-e16ed174b2f5'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'राष्ट्रिय परीक्षा बोर्डको काम, कर्तव्य र अधिकारमा तलकामध्ये कुन पर्दैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'राष्ट्रिय परीक्षा बोर्डको काम, कर्तव्य र अधिकारमा तलकामध्ये कुन पर्दैन?', E'बोर्डको आवधिक तथा वार्षिक प्रतिवेदन मन्त्रालयमा पेश गर्ने', E'परीक्षा सम्बन्धी राष्ट्रिय नीति तयार गरी कार्यान्वयन गर्ने, गराउने', E'बोर्डको दीर्घकालीन योजना तयार गरी कार्यान्वयन गर्ने, गराउने', E'विद्यालय शिक्षा परीक्षाको मर्यादा र गुणस्तर कायम भए-नभएको मूल्याङ्कन गर्ने र परीक्षा सञ्चालनका लागि आवश्यक आर्थिक स्रोत जुटाउने', E'A', E'**बोर्डको आवधिक तथा वार्षिक प्रतिवेदन मन्त्रालयमा पेश गर्ने कार्य बोर्डको काम कर्तव्य अधिकारमा पर्दैन।**\\nनोट: यसको सट्टा बोर्डको वार्षिक बजेट तथा कार्यक्रम स्वीकृत गर्ने कार्य बोर्डको जिम्मेवारी हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:राष्ट्रिय परीक्षा बोर्डको काम, कर्तव्य र अधिकारमा तलकामध्ये कुन पर्दैन?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'राष्ट्रिय परीक्षा बोर्डले नेपाल सरकारसँग समन्वय तथा सम्पर्क राख्दा तलकामध्ये केमार्फत राख्नुपर्ने व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'राष्ट्रिय परीक्षा बोर्डले नेपाल सरकारसँग समन्वय तथा सम्पर्क राख्दा तलकामध्ये केमार्फत राख्नुपर्ने व्यवस्था छ?', E'सिधै आफैले सम्पर्क गर्न सक्ने', E'शिक्षा, विज्ञान तथा प्रविधि मन्त्रालयमार्फत', E'शिक्षा तथा मानव स्रोत विकास केन्द्रमार्फत', E'माथिका सबै', E'B', E'**राष्ट्रिय परीक्षा बोर्डले नेपाल सरकारसँग शिक्षा, विज्ञान तथा प्रविधि मन्त्रालयमार्फत समन्वय तथा सम्पर्क राख्नुपर्दछ।**\\nनोट: राष्ट्रिय परीक्षा बोर्ड १४ सदस्यीय रहन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:राष्ट्रिय परीक्षा बोर्डले नेपाल सरकारसँग समन्वय तथा सम्पर्क राख्दा तलकामध्ये केमार्फत राख्नुपर्ने व्यवस्था छ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'राष्ट्रिय परीक्षा बोर्ड गठनका लागि गठन हुने नियुक्ति सिफारिस समितिमा तलकामध्ये को सदस्य रहने व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'राष्ट्रिय परीक्षा बोर्ड गठनका लागि गठन हुने नियुक्ति सिफारिस समितिमा तलकामध्ये को सदस्य रहने व्यवस्था छ?', E'ख्याति प्राप्त शिक्षाविद्मध्येबाट मन्त्रालयले मनोनीत गरेको एकजना महिला सदस्य', E'ख्याति प्राप्त शिक्षाविद्मध्येबाट मन्त्रालयले मनोनीत गरेको एकजना सदस्य', E'शिक्षा सचिव', E'लोकसेवा आयोगको अध्यक्ष', E'C', E'**राष्ट्रिय परीक्षा बोर्ड गठनका लागि गठन हुने नियुक्ति सिफारिस समितिमा शिक्षा सचिव सदस्यको रूपमा रहन्छन्।**\\nनोट: लोकसेवा आयोगको अध्यक्ष भने राष्ट्रिय परीक्षा बोर्ड र शैक्षिक गुणस्तर परीक्षण केन्द्रको प्रमुख सिफारिस गर्ने समितिको अध्यक्ष हुन्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:राष्ट्रिय परीक्षा बोर्ड गठनका लागि गठन हुने नियुक्ति सिफारिस समितिमा तलकामध्ये को सदस्य रहने व्यवस्था छ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'माध्यमिक शिक्षा परीक्षाको सञ्चालन, समन्वय र व्यवस्थापन गर्ने राष्ट्रिय परीक्षा बोर्डको अध्यक्ष हुन आवश्यक योग्यता तथा अनुभव तलकामध्ये कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'माध्यमिक शिक्षा परीक्षाको सञ्चालन, समन्वय र व्यवस्थापन गर्ने राष्ट्रिय परीक्षा बोर्डको अध्यक्ष हुन आवश्यक योग्यता तथा अनुभव तलकामध्ये कुन हो?', E'कम्तीमा स्नातकोत्तर र शिक्षा वा शिक्षणसम्बन्धी क्षेत्रमा १२ वर्षको अनुभव', E'कम्तीमा स्नातकोत्तर र कानुनसम्बन्धी क्षेत्रमा कम्तीमा १२ वर्षको अनुभव', E'कम्तीमा स्नातकोत्तर र १२ वर्षको शिक्षण अनुभव', E'कम्तीमा स्नातकोत्तर र शिक्षा तथा परीक्षा सम्बन्धित क्षेत्रमा कम्तीमा १२ वर्षको अनुभव', E'D', E'**बोर्डको अध्यक्ष हुन कम्तीमा स्नातकोत्तर र शिक्षा तथा परीक्षा सम्बन्धित क्षेत्रमा कम्तीमा १२ वर्षको अनुभव आवश्यक पर्दछ।**\\nनोट: बोर्डमा १३ सदस्य रहन्छन्; अध्यक्ष नेपाल सरकारद्वारा नियुक्त हुन्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:माध्यमिक शिक्षा परीक्षाको सञ्चालन, समन्वय र व्यवस्थापन गर्ने राष्ट्रिय परीक्षा बोर्डको अध्यक्ष हुन आवश्यक योग्यता तथा अनुभव तलकामध्ये कुन हो?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा नियमावली अनुसार शैक्षिक सत्र परिवर्तन गर्नुपर्ने अवस्था हुनसक्ने विकट हिमाली क्षेत्र भनेर तलकामध्ये कुन जिल्लाहरू चिनिन्छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'शिक्षा नियमावली अनुसार शैक्षिक सत्र परिवर्तन गर्नुपर्ने अवस्था हुनसक्ने विकट हिमाली क्षेत्र भनेर तलकामध्ये कुन जिल्लाहरू चिनिन्छन्?', E'जुम्ला, कालिकोट, मुगु, डोल्पा र मुस्ताङ', E'हुम्ला, जुम्ला, कालिकोट, मनाङ र मुस्ताङ', E'हिमाली जिल्ला जति सबै', E'हुम्ला, जुम्ला, कालिकोट, मुगु र डोल्पा', E'A', E'**विकट हिमाली क्षेत्र भनेर जुम्ला, कालिकोट, मुगु, डोल्पा र मुस्ताङ चिनिन्छन्।**\\nनोट: यी जिल्लामा मन्त्रालयले शैक्षिक सत्र परिवर्तन गर्न सक्दछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा नियमावली अनुसार शैक्षिक सत्र परिवर्तन गर्नुपर्ने अवस्था हुनसक्ने विकट हिमाली क्षेत्र भनेर तलकामध्ये कुन जिल्लाहरू चिनिन्छन्?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यालयले शैक्षिक सत्र सुरु भएको मितिले सामान्यतया कति समयभित्र विद्यार्थी भर्ना गर्नुपर्ने व्यवस्था शिक्षा नियमावलीमा छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'विद्यालयले शैक्षिक सत्र सुरु भएको मितिले सामान्यतया कति समयभित्र विद्यार्थी भर्ना गर्नुपर्ने व्यवस्था शिक्षा नियमावलीमा छ?', E'१५ दिनभित्र', E'एक महिनाभित्र', E'आवश्यकता अनुसार', E'दुई महिनाभित्र', E'B', E'**विद्यार्थी भर्ना शैक्षिक सत्र सुरु भएको मितिले एक महिनाभित्र गर्नुपर्दछ।**\\nनोट: शिक्षा नियमावली अनुसार विद्यालयमा एक शैक्षिक सत्रमा कम्तीमा २२० दिन कक्षा सञ्चालन हुनुपर्दछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यालयले शैक्षिक सत्र सुरु भएको मितिले सामान्यतया कति समयभित्र विद्यार्थी भर्ना गर्नुपर्ने व्यवस्था शिक्षा नियमावलीमा छ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा नियमावली, २०५९ (संशोधनसहित) अनुसार कक्षा १२ मा कम्तीमा कति प्रतिशत हाजिर भई नियमित रूपमा अध्ययन गरेको विद्यार्थी मात्र माध्यमिक उत्तीर्ण परीक्षामा सहभागी हुन पाउनेछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'शिक्षा नियमावली, २०५९ (संशोधनसहित) अनुसार कक्षा १२ मा कम्तीमा कति प्रतिशत हाजिर भई नियमित रूपमा अध्ययन गरेको विद्यार्थी मात्र माध्यमिक उत्तीर्ण परीक्षामा सहभागी हुन पाउनेछ?', E'७० प्रतिशत', E'८० प्रतिशत', E'७५ प्रतिशत', E'८५ प्रतिशत', E'C', E'**कक्षा १२ मा कम्तीमा ७५ प्रतिशत हाजिर भई नियमित रूपमा अध्ययन गरेको विद्यार्थी मात्र माध्यमिक उत्तीर्ण परीक्षामा सहभागी हुन पाउँछ।**\\nनोट: यही ७५% हाजिरी सर्त सबै कक्षामा उस्तै लागू हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा नियमावली, २०५९ (संशोधनसहित) अनुसार कक्षा १२ मा कम्तीमा कति प्रतिशत हाजिर भई नियमित रूपमा अध्ययन गरेको विद्यार्थी मात्र माध्यमिक उत्तीर्ण परीक्षामा सहभागी हुन पाउनेछ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा नियमावली, २०५९ अनुसार अनौपचारिक शिक्षाको पाठ्यक्रम तथा पाठ्यपुस्तक कुन निकायबाट स्वीकृत भएझैं मानिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'शिक्षा नियमावली, २०५९ अनुसार अनौपचारिक शिक्षाको पाठ्यक्रम तथा पाठ्यपुस्तक कुन निकायबाट स्वीकृत भएझैं मानिन्छ?', E'शिक्षा तथा मानव स्रोत विकास केन्द्र', E'जिल्ला शिक्षा समिति', E'शिक्षा विकास तथा समन्वय इकाई', E'राष्ट्रिय पाठ्यक्रम विकास तथा मूल्याङ्कन परिषद्', E'D', E'**अनौपचारिक शिक्षाको पाठ्यक्रम तथा पाठ्यपुस्तक राष्ट्रिय पाठ्यक्रम विकास तथा मूल्याङ्कन परिषद्ले स्वीकृत गरेझैं मानिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा नियमावली, २०५९ अनुसार अनौपचारिक शिक्षाको पाठ्यक्रम तथा पाठ्यपुस्तक कुन निकायबाट स्वीकृत भएझैं मानिन्छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  RAISE NOTICE 'Unit घ-३ upsert complete: 4 sets, 44 questions.';
END $$;
