-- Idempotent UPSERT import: निमावि प्रथम पत्र — unit ख-१ (redesigned Level I topic-wise sets)
-- Override same-identity sets/questions; never deletes. Generated 2026-06-27T15:23:42.103Z.
DO $$
DECLARE
  v_module_id uuid := '6695669a-f40e-421a-a4ec-b09bbeaf56c4'::uuid;
  v_set_id uuid;
  v_q_id uuid;
BEGIN

  -- Set: शिक्षाको अर्थ, परिभाषा र प्रकृति (आधारभूत तह — भाग १) (20 Q)
  v_set_id := extensions.uuid_generate_v5('70023fdf-26dc-4bd4-9777-5800c874c1b7'::uuid, E'शिक्षाको अर्थ, परिभाषा र प्रकृति (आधारभूत तह — भाग १)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '9b5be12e-0497-4716-ab14-356d4d19e7be'::uuid, '70023fdf-26dc-4bd4-9777-5800c874c1b7'::uuid, E'शिक्षाको अर्थ, परिभाषा र प्रकृति (आधारभूत तह — भाग १)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '70023fdf-26dc-4bd4-9777-5800c874c1b7'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'अंग्रेजी भाषाको ''Education'' शब्द कुन ल्याटिन शब्दबाट उत्पत्ति भएको हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'अंग्रेजी भाषाको ''Education'' शब्द कुन ल्याटिन शब्दबाट उत्पत्ति भएको हो?', E'Educatum', E'Educare', E'Educere', E'Duco', E'A', E'**अंग्रेजी ''Education'' शब्द ल्याटिन भाषाको ''Educatum'' बाट उत्पत्ति भएको हो।**\\n- Educare (एडुकेयर) को अर्थ हुर्काउनु वा पालनपोषण गर्नु हो, जसले बाह्य प्रभावलाई जनाउँछ।\\n- Educere (एडुसेयर) को अर्थ प्रस्फुटन गर्नु वा बाहिर निकाल्नु हो, जसले आन्तरिक क्षमतालाई जनाउँछ।\\n- Duco ल्याटिन शब्द हो जसको अर्थ बाहिर डोर्‍याउनु (to lead out) हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:अंग्रेजी भाषाको ''Education'' शब्द कुन ल्याटिन शब्दबाट उत्पत्ति भएको हो?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुन ल्याटिन शब्दले व्यक्तिको आन्तरिक क्षमता बाहिर निकाल्ने (प्रस्फुटन) अर्थ दिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'कुन ल्याटिन शब्दले व्यक्तिको आन्तरिक क्षमता बाहिर निकाल्ने (प्रस्फुटन) अर्थ दिन्छ?', E'Educatum', E'Educare', E'Educere', E'Educatio', E'C', E'**ल्याटिन शब्द Educere (एडुसेयर) ले आन्तरिक क्षमता बाहिर निकाल्ने अर्थ दिन्छ।**\\n- Educare ले हुर्काउनु वा पालनपोषण गर्नु अर्थात् बाह्य प्रभावलाई जनाउँछ।\\n- Educatum बाटै अंग्रेजीको Education शब्द बनेको हो।\\nनोट: Educere ले शिक्षाको आन्तरिक पक्ष (भित्री गुण बाहिर ल्याउने) र Educare ले बाह्य पक्ष जनाउने हुनाले यी दुई शब्द परीक्षामा बारम्बार सोधिन्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुन ल्याटिन शब्दले व्यक्तिको आन्तरिक क्षमता बाहिर निकाल्ने (प्रस्फुटन) अर्थ दिन्छ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षाको अर्थ मस्तिष्क (Head), हृदय (Heart) र हात (Hand) को सन्तुलित विकास हो भन्ने 3H अवधारणा कुन शिक्षाविद्ले दिएका हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'शिक्षाको अर्थ मस्तिष्क (Head), हृदय (Heart) र हात (Hand) को सन्तुलित विकास हो भन्ने 3H अवधारणा कुन शिक्षाविद्ले दिएका हुन्?', E'फ्रोबेल', E'पेस्टालोजी', E'जोन डिवे', E'हर्बर्ट स्पेन्सर', E'B', E'**मस्तिष्क, हृदय र हातको सन्तुलित विकास गर्ने 3H अवधारणा पेस्टालोजी (Pestalozzi) ले दिएका हुन्।**\\n- फ्रोबेलले शिक्षालाई बालकको आन्तरिक गुण बाहिर ल्याउने प्रक्रिया मानेका छन्।\\n- जोन डिवेले शिक्षालाई अनुभवको निरन्तर पुनर्निर्माण मानेका छन्।\\n- हर्बर्ट स्पेन्सरले शिक्षालाई पूर्ण जीवनको तयारी भनेका छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षाको अर्थ मस्तिष्क (Head), हृदय (Heart) र हात (Hand) को सन्तुलित विकास हो भन्ने 3H अवधारणा कुन शिक्षाविद्ले दिएका हुन्?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'"शिक्षा भनेको अनुभवहरूको निरन्तर पुनर्निर्माण र पुनर्संरचना हो" भनी कसले परिभाषित गरेका छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'"शिक्षा भनेको अनुभवहरूको निरन्तर पुनर्निर्माण र पुनर्संरचना हो" भनी कसले परिभाषित गरेका छन्?', E'हर्बर्ट स्पेन्सर', E'टी.पी. नन', E'जोन डिवे', E'फ्रोबेल', E'C', E'**"शिक्षा भनेको अनुभवहरूको निरन्तर पुनर्निर्माण र पुनर्संरचना हो" भनी जोन डिवे (John Dewey) ले परिभाषित गरेका छन्।**\\n- हर्बर्ट स्पेन्सरले शिक्षालाई पूर्ण जीवनको तयारी भनेका छन्।\\n- टी.पी. ननले शिक्षालाई वैयक्तिकताको पूर्ण विकास भनेका छन्।\\n- फ्रोबेलले शिक्षालाई बालकको आन्तरिक गुण बाहिर ल्याउने प्रक्रिया भनेका छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:"शिक्षा भनेको अनुभवहरूको निरन्तर पुनर्निर्माण र पुनर्संरचना हो" भनी कसले परिभाषित गरेका छन्?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'"शिक्षा भनेको पूर्ण जीवनको तयारी (Preparation for complete living) हो" भन्ने परिभाषा कसको हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'"शिक्षा भनेको पूर्ण जीवनको तयारी (Preparation for complete living) हो" भन्ने परिभाषा कसको हो?', E'हर्बर्ट स्पेन्सर', E'जोन डिवे', E'पेस्टालोजी', E'टी.पी. नन', E'A', E'**"शिक्षा भनेको पूर्ण जीवनको तयारी हो" भन्ने परिभाषा हर्बर्ट स्पेन्सर (Herbert Spencer) को हो।**\\n- जोन डिवेले शिक्षालाई जीवनको तयारी होइन, जीवन आफैं मानेका छन्।\\n- पेस्टालोजीले शिक्षालाई आन्तरिक शक्तिको स्वाभाविक र प्रगतिशील विकास भनेका छन्।\\n- टी.पी. ननले शिक्षालाई वैयक्तिकताको पूर्ण विकास भनेका छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:"शिक्षा भनेको पूर्ण जीवनको तयारी (Preparation for complete living) हो" भन्ने परिभाषा कसको हो?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'"शिक्षा एक द्विमुखी प्रक्रिया (Bipolar process) हो" भन्ने कसले बताएका छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'"शिक्षा एक द्विमुखी प्रक्रिया (Bipolar process) हो" भन्ने कसले बताएका छन्?', E'जोन डिवे', E'हर्बर्ट स्पेन्सर', E'टी.पी. नन', E'जोन एडम्स', E'D', E'**"शिक्षा एक द्विमुखी प्रक्रिया हो जसमा एक व्यक्तित्वले अर्को व्यक्तित्वलाई प्रभाव पार्दछ" भनी जोन एडम्स (John Adams) ले बताएका छन्।**\\n- जोन डिवेले शिक्षालाई अनुभवको पुनर्निर्माण मानेका छन्।\\n- हर्बर्ट स्पेन्सरले शिक्षालाई पूर्ण जीवनको तयारी भनेका छन्।\\n- टी.पी. ननले शिक्षालाई वैयक्तिकताको पूर्ण विकास भनेका छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:"शिक्षा एक द्विमुखी प्रक्रिया (Bipolar process) हो" भन्ने कसले बताएका छन्?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'"शिक्षा भनेको व्यक्तिको वैयक्तिकताको पूर्ण विकास (Complete development of individuality) हो" भन्ने कसको परिभाषा हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'"शिक्षा भनेको व्यक्तिको वैयक्तिकताको पूर्ण विकास (Complete development of individuality) हो" भन्ने कसको परिभाषा हो?', E'जोन एडम्स', E'टी.पी. नन', E'फ्रोबेल', E'जे.एस. म्याकेन्जी', E'B', E'**"शिक्षा भनेको वैयक्तिकताको पूर्ण विकास हो" भन्ने परिभाषा टी.पी. नन (T.P. Nunn) को हो।**\\n- जोन एडम्सले शिक्षालाई द्विमुखी प्रक्रिया मानेका छन्।\\n- फ्रोबेलले शिक्षालाई आन्तरिक गुण बाहिर ल्याउने प्रक्रिया भनेका छन्।\\n- जे.एस. म्याकेन्जीले शिक्षालाई सचेत रूपमा निर्देशित प्रयास भनेका छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:"शिक्षा भनेको व्यक्तिको वैयक्तिकताको पूर्ण विकास (Complete development of individuality) हो" भन्ने कसको परिभाषा हो?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'"शिक्षा यस्तो प्रक्रिया हो जसले बालकको आन्तरिक गुणलाई बाहिर ल्याउँछ" भनी कसले भनेका छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'"शिक्षा यस्तो प्रक्रिया हो जसले बालकको आन्तरिक गुणलाई बाहिर ल्याउँछ" भनी कसले भनेका छन्?', E'जोन डिवे', E'हर्बर्ट स्पेन्सर', E'फ्रोबेल', E'टी. रेमोन्ट', E'C', E'**बालकको आन्तरिक गुणलाई बाहिर ल्याउने प्रक्रिया भनी शिक्षालाई फ्रोबेल (Froebel) ले परिभाषित गरेका छन्।**\\n- जोन डिवेले शिक्षालाई अनुभवको पुनर्निर्माण भनेका छन्।\\n- हर्बर्ट स्पेन्सरले शिक्षालाई पूर्ण जीवनको तयारी भनेका छन्।\\n- टी. रेमोन्टले शिक्षालाई समाजमा जीवनयापन गर्न सिकाउने ज्ञान भनेका छन्।\\nनोट: फ्रोबेललाई किण्डरगार्टेन (Kindergarten) शिक्षा पद्धतिका प्रवर्तकका रूपमा पनि चिनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:"शिक्षा यस्तो प्रक्रिया हो जसले बालकको आन्तरिक गुणलाई बाहिर ल्याउँछ" भनी कसले भनेका छन्?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षाका उद्देश्यलाई मुख्यतया कतिमा वर्गीकरण गरिएको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'शिक्षाका उद्देश्यलाई मुख्यतया कतिमा वर्गीकरण गरिएको छ?', E'तीन (व्यक्तिगत, सामाजिक, राष्ट्रिय)', E'दुई (व्यक्तिगत, सामाजिक)', E'चार (व्यक्तिगत, सामाजिक, राष्ट्रिय, आर्थिक)', E'पाँच (व्यक्तिगत, सामाजिक, राष्ट्रिय, आर्थिक, सांस्कृतिक)', E'A', E'**शिक्षाका उद्देश्यलाई मुख्यतया व्यक्तिगत, सामाजिक र राष्ट्रिय गरी तीन भागमा वर्गीकरण गरिएको छ।**\\n- आर्थिक, सांस्कृतिक र अन्तर्राष्ट्रिय भने शिक्षाका कार्य (functions) अन्तर्गत पर्दछन्, उद्देश्यमा होइन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षाका उद्देश्यलाई मुख्यतया कतिमा वर्गीकरण गरिएको छ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षाको व्यक्तिगत (वैयक्तिक) लक्ष्यका पिता कसलाई मानिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'शिक्षाको व्यक्तिगत (वैयक्तिक) लक्ष्यका पिता कसलाई मानिन्छ?', E'जोन डिवे', E'रुसो', E'ब्याग्ले', E'पेस्टालोजी', E'B', E'**शिक्षाको व्यक्तिगत (वैयक्तिक) लक्ष्यका पिता रुसो (Rousseau) लाई मानिन्छ।**\\n- जोन डिवे र ब्याग्ले शिक्षाको सामाजिक लक्ष्यका पिता मानिन्छन्।\\n- पेस्टालोजी 3H अवधारणाका लागि प्रसिद्ध छन्।\\nनोट: शिक्षामा व्यक्तिगत लक्ष्यको वकालत गर्ने विद्वान टी.पी. नन हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षाको व्यक्तिगत (वैयक्तिक) लक्ष्यका पिता कसलाई मानिन्छ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षाको सामाजिक लक्ष्यका पिता कसलाई मानिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'शिक्षाको सामाजिक लक्ष्यका पिता कसलाई मानिन्छ?', E'रुसो', E'हर्बर्ट स्पेन्सर', E'फ्रोबेल', E'जोन डिवे', E'D', E'**शिक्षाको सामाजिक लक्ष्यका पिता जोन डिवे (John Dewey) लाई मानिन्छ (ब्याग्ले समेत)।**\\n- रुसो शिक्षाको व्यक्तिगत लक्ष्यका पिता हुन्।\\n- हर्बर्ट स्पेन्सरले शिक्षालाई पूर्ण जीवनको तयारी भनेका छन्।\\n- फ्रोबेलले शिक्षालाई आन्तरिक गुण बाहिर ल्याउने प्रक्रिया भनेका छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षाको सामाजिक लक्ष्यका पिता कसलाई मानिन्छ?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'"शिक्षा भनेको बालकदेखि प्रौढसम्मलाई दिइने त्यस्तो ज्ञान हो जसले समाजमा जीवनयापन गर्न सिकाउँछ" भन्ने संकुचित परिभाषा कसको हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'"शिक्षा भनेको बालकदेखि प्रौढसम्मलाई दिइने त्यस्तो ज्ञान हो जसले समाजमा जीवनयापन गर्न सिकाउँछ" भन्ने संकुचित परिभाषा कसको हो?', E'डमभिल', E'जोन एडम्स', E'टी. रेमोन्ट', E'हर्बर्ट स्पेन्सर', E'C', E'**समाजमा जीवनयापन गर्न सिकाउने ज्ञानका रूपमा शिक्षाको संकुचित परिभाषा टी. रेमोन्ट (T. Raymont) ले दिएका हुन्।**\\n- डमभिलले शिक्षालाई जन्मदेखि मृत्युसम्मका सबै प्रभावका रूपमा व्यापक अर्थमा परिभाषित गरेका छन्।\\n- जोन एडम्सले शिक्षालाई द्विमुखी प्रक्रिया भनेका छन्।\\n- हर्बर्ट स्पेन्सरले शिक्षालाई पूर्ण जीवनको तयारी भनेका छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:"शिक्षा भनेको बालकदेखि प्रौढसम्मलाई दिइने त्यस्तो ज्ञान हो जसले समाजमा जीवनयापन गर्न सिकाउँछ" भन्ने संकुचित परिभाषा कसको हो?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'आर्थिक दृष्टिकोणले शिक्षालाई उपभोग (Consumption) नभई के मानिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'आर्थिक दृष्टिकोणले शिक्षालाई उपभोग (Consumption) नभई के मानिन्छ?', E'लगानी (Investment)', E'अनुदान (Grant)', E'बचत (Saving)', E'ऋण (Loan)', E'A', E'**आर्थिक रूपमा शिक्षा भनेको भविष्यको उच्च प्रतिफलका लागि गरिएको लगानी (Investment) हो, उपभोग मात्र होइन।**\\n- यसैलाई मानव पूँजी निर्माण (Human Capital Formation) भनिन्छ, जसले दक्ष जनशक्ति उत्पादन गर्दछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:आर्थिक दृष्टिकोणले शिक्षालाई उपभोग (Consumption) नभई के मानिन्छ?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'"शिक्षा भनेको हाम्रा शक्तिहरूको विकासका लागि सचेत रूपमा निर्देशित प्रयास (Consciously directed effort) हो" भन्ने कसको परिभाषा हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'"शिक्षा भनेको हाम्रा शक्तिहरूको विकासका लागि सचेत रूपमा निर्देशित प्रयास (Consciously directed effort) हो" भन्ने कसको परिभाषा हो?', E'टी. रेमोन्ट', E'डमभिल', E'जोन एडम्स', E'जे.एस. म्याकेन्जी', E'D', E'**शिक्षालाई सचेत रूपमा निर्देशित प्रयास भन्ने संकुचित परिभाषा जे.एस. म्याकेन्जी (J.S. Mackenzie) ले दिएका हुन्।**\\n- टी. रेमोन्टले शिक्षालाई समाजमा जीवनयापन सिकाउने ज्ञान भनेका छन्।\\n- डमभिलले शिक्षालाई जन्मदेखि मृत्युसम्मका सबै प्रभाव भनी व्यापक अर्थमा परिभाषित गरेका छन्।\\n- जोन एडम्सले शिक्षालाई द्विमुखी प्रक्रिया भनेका छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:"शिक्षा भनेको हाम्रा शक्तिहरूको विकासका लागि सचेत रूपमा निर्देशित प्रयास (Consciously directed effort) हो" भन्ने कसको परिभाषा हो?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विश्वबन्धुत्व र भाइचाराको भावनाको विकास गर्नु शिक्षाको कुन कार्य अन्तर्गत पर्दछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'विश्वबन्धुत्व र भाइचाराको भावनाको विकास गर्नु शिक्षाको कुन कार्य अन्तर्गत पर्दछ?', E'सांस्कृतिक कार्य', E'अन्तर्राष्ट्रिय (विश्वव्यापी) कार्य', E'आर्थिक कार्य', E'राष्ट्रिय कार्य', E'B', E'**विश्वबन्धुत्व र भाइचाराको भावनाको विकास शिक्षाको अन्तर्राष्ट्रिय (विश्वव्यापी) कार्य अन्तर्गत पर्दछ।**\\n- सांस्कृतिक कार्यले संस्कृति र परम्परागत मूल्यमान्यताको संरक्षण गर्दछ।\\n- आर्थिक कार्यले दक्ष जनशक्ति उत्पादन र गरिबी निवारणमा मद्दत गर्दछ।\\n- राष्ट्रिय कार्यले राष्ट्रिय एकता र राष्ट्रप्रेमको भावना विकास गर्दछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विश्वबन्धुत्व र भाइचाराको भावनाको विकास गर्नु शिक्षाको कुन कार्य अन्तर्गत पर्दछ?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दक्ष जनशक्ति उत्पादन गर्ने र गरिबी निवारणमा मद्दत गर्ने कार्य शिक्षाको कुन कार्य हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'दक्ष जनशक्ति उत्पादन गर्ने र गरिबी निवारणमा मद्दत गर्ने कार्य शिक्षाको कुन कार्य हो?', E'सांस्कृतिक कार्य', E'अन्तर्राष्ट्रिय कार्य', E'आर्थिक कार्य', E'व्यक्तिगत कार्य', E'C', E'**दक्ष जनशक्ति उत्पादन र गरिबी निवारणमा मद्दत गर्ने कार्य शिक्षाको आर्थिक कार्य हो।**\\n- सांस्कृतिक कार्यले साहित्य, कला र संस्कृतिको संरक्षण-सम्बर्द्धन गर्दछ।\\n- अन्तर्राष्ट्रिय कार्यले विश्वबन्धुत्व र सहअस्तित्वको भावना विकास गर्दछ।\\n- व्यक्तिगत कार्यले व्यक्तित्व विकास र आत्मनिर्भरता प्रदान गर्दछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दक्ष जनशक्ति उत्पादन गर्ने र गरिबी निवारणमा मद्दत गर्ने कार्य शिक्षाको कुन कार्य हो?'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'एक पुस्ताबाट अर्को पुस्तामा संस्कृतिको स्थानान्तरण र संरक्षण गर्नु शिक्षाको कुन कार्य हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'एक पुस्ताबाट अर्को पुस्तामा संस्कृतिको स्थानान्तरण र संरक्षण गर्नु शिक्षाको कुन कार्य हो?', E'सांस्कृतिक कार्य', E'आर्थिक कार्य', E'अन्तर्राष्ट्रिय कार्य', E'व्यक्तिगत कार्य', E'A', E'**संस्कृतिको स्थानान्तरण र संरक्षण गर्नु शिक्षाको सांस्कृतिक कार्य हो।**\\n- आर्थिक कार्यले अर्थव्यवस्थालाई मजबुत बनाउँछ र दक्ष जनशक्ति उत्पादन गर्दछ।\\n- अन्तर्राष्ट्रिय कार्यले संस्कृति र प्रविधिको आदानप्रदान गराउँछ।\\n- व्यक्तिगत कार्यले व्यक्तिको आन्तरिक शक्ति र व्यक्तित्व विकास गर्दछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:एक पुस्ताबाट अर्को पुस्तामा संस्कृतिको स्थानान्तरण र संरक्षण गर्नु शिक्षाको कुन कार्य हो?'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षाले व्यक्तिलाई तल्लो सामाजिक वा आर्थिक वर्गबाट माथिल्लो स्तरमा उक्लन मद्दत गर्ने प्रक्रियालाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'शिक्षाले व्यक्तिलाई तल्लो सामाजिक वा आर्थिक वर्गबाट माथिल्लो स्तरमा उक्लन मद्दत गर्ने प्रक्रियालाई के भनिन्छ?', E'सामाजिक नियन्त्रण', E'सामाजिकीकरण', E'मानव पूँजी निर्माण', E'सामाजिक गतिशीलता', E'D', E'**शिक्षाले व्यक्तिलाई तल्लो वर्गबाट माथिल्लो स्तरमा उक्लन मद्दत गर्ने प्रक्रियालाई सामाजिक गतिशीलता (Social Mobility) भनिन्छ।**\\n- सामाजिक नियन्त्रणले समाजलाई अनुशासित राख्ने कार्य गर्दछ।\\n- सामाजिकीकरणले व्यक्तिलाई समाजका मूल्यमान्यता सिकाउँछ।\\n- मानव पूँजी निर्माणले शिक्षालाई भविष्यको प्रतिफलका लागि गरिएको लगानी मान्दछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षाले व्यक्तिलाई तल्लो सामाजिक वा आर्थिक वर्गबाट माथिल्लो स्तरमा उक्लन मद्दत गर्ने प्रक्रियालाई के भनिन्छ?'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'"शिक्षाको व्यापक अर्थभित्र ती सबै प्रभावहरू पर्दछन् जसले व्यक्तिलाई जन्मदेखि मृत्युसम्म प्रभावित पार्दछन्" भन्ने कसको परिभाषा हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'"शिक्षाको व्यापक अर्थभित्र ती सबै प्रभावहरू पर्दछन् जसले व्यक्तिलाई जन्मदेखि मृत्युसम्म प्रभावित पार्दछन्" भन्ने कसको परिभाषा हो?', E'जे.एस. म्याकेन्जी', E'डमभिल', E'टी. रेमोन्ट', E'जोन एडम्स', E'B', E'**शिक्षालाई जन्मदेखि मृत्युसम्मका सबै प्रभावका रूपमा व्यापक अर्थमा डमभिल (Dumville) ले परिभाषित गरेका छन्।**\\n- जे.एस. म्याकेन्जीले शिक्षालाई सचेत रूपमा निर्देशित प्रयास भनी संकुचित अर्थमा परिभाषित गरेका छन्।\\n- टी. रेमोन्टले शिक्षालाई समाजमा जीवनयापन सिकाउने ज्ञान भनेका छन्।\\n- जोन एडम्सले शिक्षालाई द्विमुखी प्रक्रिया भनेका छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:"शिक्षाको व्यापक अर्थभित्र ती सबै प्रभावहरू पर्दछन् जसले व्यक्तिलाई जन्मदेखि मृत्युसम्म प्रभावित पार्दछन्" भन्ने कसको परिभाषा हो?'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुन ल्याटिन शब्दको अर्थ "हुर्काउनु" वा "पालनपोषण गर्नु" हुन्छ, जसले शिक्षाको बाह्य प्रभावलाई जनाउँछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 20, E'कुन ल्याटिन शब्दको अर्थ "हुर्काउनु" वा "पालनपोषण गर्नु" हुन्छ, जसले शिक्षाको बाह्य प्रभावलाई जनाउँछ?', E'Educatum', E'Duco', E'Educare', E'Educere', E'C', E'**ल्याटिन शब्द Educare (एडुकेयर) को अर्थ हुर्काउनु वा पालनपोषण गर्नु हो, जसले शिक्षाको बाह्य प्रभावलाई जनाउँछ।**\\n- Educatum बाटै अंग्रेजीको Education शब्द बनेको हो।\\n- Duco को अर्थ बाहिर डोर्‍याउनु हो।\\n- Educere को अर्थ प्रस्फुटन गर्नु अर्थात् आन्तरिक क्षमता बाहिर निकाल्नु हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुन ल्याटिन शब्दको अर्थ "हुर्काउनु" वा "पालनपोषण गर्नु" हुन्छ, जसले शिक्षाको बाह्य प्रभावलाई जनाउँछ?'), v_set_id, v_q_id, 20)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: शिक्षाको अर्थ, परिभाषा र प्रकृति (आधारभूत तह — भाग २) (15 Q)
  v_set_id := extensions.uuid_generate_v5('70023fdf-26dc-4bd4-9777-5800c874c1b7'::uuid, E'शिक्षाको अर्थ, परिभाषा र प्रकृति (आधारभूत तह — भाग २)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '9b5be12e-0497-4716-ab14-356d4d19e7be'::uuid, '70023fdf-26dc-4bd4-9777-5800c874c1b7'::uuid, E'शिक्षाको अर्थ, परिभाषा र प्रकृति (आधारभूत तह — भाग २)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '70023fdf-26dc-4bd4-9777-5800c874c1b7'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'ल्याटिन शब्द ''Educatum'' कुन दुई शब्द मिलेर बनेको हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'ल्याटिन शब्द ''Educatum'' कुन दुई शब्द मिलेर बनेको हो?', E'''E'' (भित्रबाट) र ''Duco'' (बाहिर निकाल्नु)', E'''Ex'' र ''Ducere''', E'''Educare'' र ''Educere''', E'''E'' र ''Cura''', E'A', E'**''Educatum'' शब्द ''E'' (भित्रबाट) र ''Duco'' (बाहिर निकाल्नु/डोर्‍याउनु) मिलेर बनेको हो।** यसैबाट अंग्रेजीको ''Education'' शब्द उत्पत्ति भएको हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:ल्याटिन शब्द ''Educatum'' कुन दुई शब्द मिलेर बनेको हो?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'निम्नमध्ये शिक्षाको व्यक्तिगत कार्य होइन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'निम्नमध्ये शिक्षाको व्यक्तिगत कार्य होइन?', E'आन्तरिक शक्तिको विकास', E'व्यक्तित्व विकास', E'आत्मनिर्भरता प्राप्ति', E'राष्ट्रिय एकताको विकास', E'D', E'**राष्ट्रिय एकताको विकास शिक्षाको व्यक्तिगत कार्य होइन, यो राष्ट्रिय कार्य हो।** व्यक्तिगत कार्यअन्तर्गत आन्तरिक शक्ति, व्यक्तित्व र आत्मनिर्भरताको विकास पर्दछन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:निम्नमध्ये शिक्षाको व्यक्तिगत कार्य होइन?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षाको परम्परागत कार्यलाई अर्को कुन नामले पनि चिनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'शिक्षाको परम्परागत कार्यलाई अर्को कुन नामले पनि चिनिन्छ?', E'प्रगतिशील कार्य', E'संरक्षणात्मक कार्य', E'तटस्थ कार्य', E'सिर्जनात्मक कार्य', E'B', E'**शिक्षाको परम्परागत कार्यलाई संरक्षणात्मक कार्य पनि भनिन्छ।** यसले विद्यमान ज्ञान, संस्कृति र मूल्यमान्यताको संरक्षण गर्दछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षाको परम्परागत कार्यलाई अर्को कुन नामले पनि चिनिन्छ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'बदलिँदो परिवेश अनुसार नयाँ–नयाँ विचारलाई आत्मसात गराउँदै लैजाने शिक्षाको कार्य कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'बदलिँदो परिवेश अनुसार नयाँ–नयाँ विचारलाई आत्मसात गराउँदै लैजाने शिक्षाको कार्य कुन हो?', E'संरक्षणात्मक कार्य', E'तटस्थ कार्य', E'प्रगतिशील कार्य', E'परम्परागत कार्य', E'C', E'**बदलिँदो परिवेश अनुसार नयाँ विचार आत्मसात गराउने कार्य शिक्षाको प्रगतिशील कार्य हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:बदलिँदो परिवेश अनुसार नयाँ–नयाँ विचारलाई आत्मसात गराउँदै लैजाने शिक्षाको कार्य कुन हो?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'"शिक्षा विवादभन्दा टाढा बस्नुपर्छ" भन्ने मान्यता शिक्षाको कुन कार्यसँग सम्बन्धित छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'"शिक्षा विवादभन्दा टाढा बस्नुपर्छ" भन्ने मान्यता शिक्षाको कुन कार्यसँग सम्बन्धित छ?', E'प्रगतिशील कार्य', E'संरक्षणात्मक कार्य', E'सामाजिक कार्य', E'तटस्थ कार्य', E'D', E'**शिक्षा विवादभन्दा टाढा रहनुपर्छ भन्ने मान्यता तटस्थ कार्यसँग सम्बन्धित छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:"शिक्षा विवादभन्दा टाढा बस्नुपर्छ" भन्ने मान्यता शिक्षाको कुन कार्यसँग सम्बन्धित छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षाका सामाजिक कार्यहरू मुख्यतः कुन विद्वान्का अनुसार उल्लेख गरिएका हुन्छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'शिक्षाका सामाजिक कार्यहरू मुख्यतः कुन विद्वान्का अनुसार उल्लेख गरिएका हुन्छन्?', E'ब्रुबेकर', E'रुसो', E'हर्बर्ट स्पेन्सर', E'जोन एडम्स', E'A', E'**शिक्षाका सामाजिक कार्यहरू मुख्यतः ब्रुबेकर (Brubacker) का अनुसार उल्लेख गरिएका हुन्छन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षाका सामाजिक कार्यहरू मुख्यतः कुन विद्वान्का अनुसार उल्लेख गरिएका हुन्छन्?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'निम्नमध्ये शिक्षाको राष्ट्रिय कार्य होइन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'निम्नमध्ये शिक्षाको राष्ट्रिय कार्य होइन?', E'राष्ट्रिय एकताको विकास', E'नेतृत्व विकास', E'विश्वबन्धुत्वको विकास', E'नागरिक गुणको विकास', E'C', E'**विश्वबन्धुत्वको विकास राष्ट्रिय कार्य होइन, यो अन्तर्राष्ट्रिय (विश्वव्यापी) कार्य हो।** राष्ट्रिय कार्यअन्तर्गत राष्ट्रिय एकता, नेतृत्व र नागरिक गुणको विकास पर्दछन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:निम्नमध्ये शिक्षाको राष्ट्रिय कार्य होइन?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समाजलाई अनुशासित राख्दै समयसापेक्ष सकारात्मक रूपान्तरण ल्याउने शिक्षाको भूमिकालाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'समाजलाई अनुशासित राख्दै समयसापेक्ष सकारात्मक रूपान्तरण ल्याउने शिक्षाको भूमिकालाई के भनिन्छ?', E'सामाजिक गतिशीलता', E'सामाजिक नियन्त्रण र परिवर्तन', E'मानव पूँजी निर्माण', E'सामाजिकीकरण', E'B', E'**समाजलाई अनुशासित राख्दै सकारात्मक रूपान्तरण ल्याउने भूमिकालाई सामाजिक नियन्त्रण र परिवर्तन (Social Control and Change) भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समाजलाई अनुशासित राख्दै समयसापेक्ष सकारात्मक रूपान्तरण ल्याउने शिक्षाको भूमिकालाई के भनिन्छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षाले व्यक्तिको शारीरिक, बौद्धिक, संवेगात्मक, नैतिक र सामाजिक पक्षको सन्तुलित विकास गर्नुलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'शिक्षाले व्यक्तिको शारीरिक, बौद्धिक, संवेगात्मक, नैतिक र सामाजिक पक्षको सन्तुलित विकास गर्नुलाई के भनिन्छ?', E'सर्वाङ्गीण विकास', E'मानसिक विकास', E'शारीरिक विकास', E'व्यावसायिक विकास', E'A', E'**व्यक्तिको शारीरिक, बौद्धिक, संवेगात्मक, नैतिक र सामाजिक पक्षको सन्तुलित विकास नै सर्वाङ्गीण विकास (All-round Development) हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षाले व्यक्तिको शारीरिक, बौद्धिक, संवेगात्मक, नैतिक र सामाजिक पक्षको सन्तुलित विकास गर्नुलाई के भनिन्छ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'"शिक्षा जीवनको तयारी होइन, शिक्षा आफैं जीवन हो" भन्ने भनाइ कसको हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'"शिक्षा जीवनको तयारी होइन, शिक्षा आफैं जीवन हो" भन्ने भनाइ कसको हो?', E'हर्बर्ट स्पेन्सर', E'फ्रोबेल', E'टी.पी. नन', E'जोन डिवे', E'D', E'**"शिक्षा जीवनको तयारी होइन, शिक्षा आफैं जीवन हो" भन्ने प्रसिद्ध भनाइ जोन डिवेको हो।** हर्बर्ट स्पेन्सरले भने शिक्षालाई पूर्ण जीवनको तयारी मानेका छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:"शिक्षा जीवनको तयारी होइन, शिक्षा आफैं जीवन हो" भन्ने भनाइ कसको हो?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'निश्चित पाठ्यक्रम, समयतालिका र विद्यालयमार्फत योजनाबद्ध रूपमा दिइने शिक्षालाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'निश्चित पाठ्यक्रम, समयतालिका र विद्यालयमार्फत योजनाबद्ध रूपमा दिइने शिक्षालाई के भनिन्छ?', E'अनौपचारिक शिक्षा', E'औपचारिक शिक्षा', E'अतिरिक्त शिक्षा', E'आजीवन शिक्षा', E'B', E'**निश्चित पाठ्यक्रम र समयतालिका अनुसार विद्यालयमार्फत योजनाबद्ध रूपमा दिइने शिक्षा औपचारिक शिक्षा हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:निश्चित पाठ्यक्रम, समयतालिका र विद्यालयमार्फत योजनाबद्ध रूपमा दिइने शिक्षालाई के भनिन्छ?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'निम्नमध्ये शिक्षाको कार्य (Function) अन्तर्गत नपर्ने कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'निम्नमध्ये शिक्षाको कार्य (Function) अन्तर्गत नपर्ने कुन हो?', E'आर्थिक कार्य', E'सांस्कृतिक कार्य', E'भौगोलिक कार्य', E'अन्तर्राष्ट्रिय कार्य', E'C', E'**शिक्षाका कार्यहरूमा भौगोलिक कार्य पर्दैन।** शिक्षाका कार्य व्यक्तिगत, सामाजिक, राष्ट्रिय, अन्तर्राष्ट्रिय, आर्थिक र सांस्कृतिक गरी वर्गीकृत छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:निम्नमध्ये शिक्षाको कार्य (Function) अन्तर्गत नपर्ने कुन हो?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पेस्टालोजीको 3H अवधारणामा निम्नमध्ये कुन पर्दैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'पेस्टालोजीको 3H अवधारणामा निम्नमध्ये कुन पर्दैन?', E'Health (स्वास्थ्य)', E'Head (मस्तिष्क)', E'Heart (हृदय)', E'Hand (हात)', E'A', E'**3H अवधारणामा Health (स्वास्थ्य) पर्दैन; यसमा Head (मस्तिष्क), Heart (हृदय) र Hand (हात/सीप) पर्दछन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पेस्टालोजीको 3H अवधारणामा निम्नमध्ये कुन पर्दैन?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'निम्नमध्ये शिक्षाको उद्देश्य (Aim) को मुख्य वर्गीकरणमा नपर्ने कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'निम्नमध्ये शिक्षाको उद्देश्य (Aim) को मुख्य वर्गीकरणमा नपर्ने कुन हो?', E'व्यक्तिगत उद्देश्य', E'प्राविधिक उद्देश्य', E'सामाजिक उद्देश्य', E'राष्ट्रिय उद्देश्य', E'B', E'**शिक्षाको उद्देश्यको मुख्य वर्गीकरणमा प्राविधिक उद्देश्य पर्दैन; यी मुख्यतः व्यक्तिगत, सामाजिक र राष्ट्रिय हुन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:निम्नमध्ये शिक्षाको उद्देश्य (Aim) को मुख्य वर्गीकरणमा नपर्ने कुन हो?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'निम्नमध्ये शिक्षाको सांस्कृतिक कार्य अन्तर्गत नपर्ने कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'निम्नमध्ये शिक्षाको सांस्कृतिक कार्य अन्तर्गत नपर्ने कुन हो?', E'संस्कृतिको स्थानान्तरण', E'साहित्य र कलाको संरक्षण', E'गरिबी निवारण', E'सांस्कृतिक धरोहरको सम्बर्द्धन', E'C', E'**गरिबी निवारण सांस्कृतिक कार्य होइन, यो आर्थिक कार्य हो।** सांस्कृतिक कार्यले संस्कृति, साहित्य, कला र धरोहरको संरक्षण-सम्बर्द्धन गर्दछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:निम्नमध्ये शिक्षाको सांस्कृतिक कार्य अन्तर्गत नपर्ने कुन हो?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: नेपालमा आधुनिक शिक्षाको सुरुवात र राणाकालीन शिक्षा (आधारभूत तह) (18 Q)
  v_set_id := extensions.uuid_generate_v5('472e95ab-622e-48d9-9b70-b68afccc8589'::uuid, E'नेपालमा आधुनिक शिक्षाको सुरुवात र राणाकालीन शिक्षा (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '9b5be12e-0497-4716-ab14-356d4d19e7be'::uuid, '472e95ab-622e-48d9-9b70-b68afccc8589'::uuid, E'नेपालमा आधुनिक शिक्षाको सुरुवात र राणाकालीन शिक्षा (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '472e95ab-622e-48d9-9b70-b68afccc8589'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालमा आधुनिक शिक्षाको थालनी मानिने दरबार स्कुल कुन सालमा स्थापना भएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'नेपालमा आधुनिक शिक्षाको थालनी मानिने दरबार स्कुल कुन सालमा स्थापना भएको थियो?', E'वि.सं. १९०७', E'वि.सं. १९१५', E'वि.सं. १९५८', E'वि.सं. १९१०', E'D', E'**वि.सं. १९१० मा जङ्गबहादुर राणाले थापाथली दरबारमा अङ्ग्रेजी प्रारम्भिक स्कुल (दरबार स्कुल) स्थापना गरेका थिए।** यसलाई नेपालको आधुनिक शिक्षाको सुरुवात मानिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालमा आधुनिक शिक्षाको थालनी मानिने दरबार स्कुल कुन सालमा स्थापना भएको थियो?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दरबार स्कुल कसले स्थापना गरेका थिए?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'दरबार स्कुल कसले स्थापना गरेका थिए?', E'चन्द्र समशेर', E'देव समशेर', E'जङ्गबहादुर राणा', E'वीर समशेर', E'C', E'**दरबार स्कुल जङ्गबहादुर राणाले वि.सं. १९१० मा स्थापना गरेका थिए।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दरबार स्कुल कसले स्थापना गरेका थिए?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालमा शिक्षाको पिता कसलाई मानिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'नेपालमा शिक्षाको पिता कसलाई मानिन्छ?', E'देव समशेर', E'जङ्गबहादुर राणा', E'चन्द्र समशेर', E'पद्म समशेर', E'A', E'**भाषा पाठशालाको व्यापक विस्तार गरेकाले देव समशेरलाई नेपालमा शिक्षाको पिता मानिन्छ।** उनले वि.सं. १९५८ मा कन्या पाठशालासमेत खुलाएका थिए।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालमा शिक्षाको पिता कसलाई मानिन्छ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालको पहिलो समाचारपत्र गोरखापत्रको प्रकाशन कुन सालमा सुरु भएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'नेपालको पहिलो समाचारपत्र गोरखापत्रको प्रकाशन कुन सालमा सुरु भएको थियो?', E'वि.सं. १९४५', E'वि.सं. १९५२', E'वि.सं. १९६७', E'वि.सं. १९५८', E'D', E'**गोरखापत्रको प्रकाशन वि.सं. १९५८ मा सुरु भएको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालको पहिलो समाचारपत्र गोरखापत्रको प्रकाशन कुन सालमा सुरु भएको थियो?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालको पहिलो कलेज (महाविद्यालय) त्रिचन्द्र कलेज कुन सालमा स्थापना भएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'नेपालको पहिलो कलेज (महाविद्यालय) त्रिचन्द्र कलेज कुन सालमा स्थापना भएको थियो?', E'वि.सं. १९६७', E'वि.सं. १९७५', E'वि.सं. १९७२', E'वि.सं. १९८२', E'B', E'**नेपालको पहिलो कलेज त्रिभुवन चन्द्र (त्रिचन्द्र) कलेज वि.सं. १९७५ भाद्र २७ मा स्थापना भएको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालको पहिलो कलेज (महाविद्यालय) त्रिचन्द्र कलेज कुन सालमा स्थापना भएको थियो?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दरबार स्कुलको पहिलो नेपाली हेडमास्टर को थिए?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'दरबार स्कुलको पहिलो नेपाली हेडमास्टर को थिए?', E'रुद्रराज पाण्डे', E'बालकृष्ण सम', E'सोमनाथ सिग्द्याल', E'वासुदेव उप्रेती', E'A', E'**वि.सं. १९८२ मा रुद्रराज पाण्डे दरबार स्कुलको पहिलो नेपाली हेडमास्टर नियुक्त भएका थिए।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दरबार स्कुलको पहिलो नेपाली हेडमास्टर को थिए?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'परीक्षा सञ्चालन गर्ने उद्देश्यले पास जाँच अड्डाको स्थापना कुन सालमा भएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'परीक्षा सञ्चालन गर्ने उद्देश्यले पास जाँच अड्डाको स्थापना कुन सालमा भएको थियो?', E'वि.सं. १९५२', E'वि.सं. १९६७', E'वि.सं. १९७५', E'वि.सं. १९९०', E'B', E'**पास जाँच अड्डाको स्थापना वि.सं. १९६७ कार्तिकमा भएको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:परीक्षा सञ्चालन गर्ने उद्देश्यले पास जाँच अड्डाको स्थापना कुन सालमा भएको थियो?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'काठमाडौँ उपत्यका बाहिर स्थापना भएको पहिलो अङ्ग्रेजी स्कुल कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'काठमाडौँ उपत्यका बाहिर स्थापना भएको पहिलो अङ्ग्रेजी स्कुल कुन हो?', E'त्रिजुद्ध स्कुल', E'दरबार स्कुल', E'जुद्धोदय स्कुल', E'चन्द्र मिडिल स्कुल', E'D', E'**उपत्यका बाहिरको पहिलो अङ्ग्रेजी स्कुल चन्द्र मिडिल स्कुल हो, जुन वि.सं. १९७२ मा स्थापना भएको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:काठमाडौँ उपत्यका बाहिर स्थापना भएको पहिलो अङ्ग्रेजी स्कुल कुन हो?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'काठमाडौँ उपत्यका बाहिर पहिलो एस.एल.सी. परीक्षा केन्द्र कहाँ खोलिएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'काठमाडौँ उपत्यका बाहिर पहिलो एस.एल.सी. परीक्षा केन्द्र कहाँ खोलिएको थियो?', E'वीरगन्ज (त्रिजुद्ध स्कुल)', E'विराटनगर', E'पोखरा', E'धनकुटा', E'A', E'**वि.सं. २००१ माघ १२ को सनदबाट वीरगन्जको त्रिजुद्ध स्कुलमा उपत्यका बाहिरको पहिलो एस.एल.सी. केन्द्र खोलिएको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:काठमाडौँ उपत्यका बाहिर पहिलो एस.एल.सी. परीक्षा केन्द्र कहाँ खोलिएको थियो?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालमा कन्या पाठशाला खुलाउने श्रेय कुन राणा प्रधानमन्त्रीलाई जान्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'नेपालमा कन्या पाठशाला खुलाउने श्रेय कुन राणा प्रधानमन्त्रीलाई जान्छ?', E'चन्द्र समशेर', E'जङ्गबहादुर राणा', E'देव समशेर', E'वीर समशेर', E'C', E'**वि.सं. १९५८ मा देव समशेरले काठमाडौँ, भादगाउँ र पाटनमा कन्या पाठशाला खुलाएका थिए।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालमा कन्या पाठशाला खुलाउने श्रेय कुन राणा प्रधानमन्त्रीलाई जान्छ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वैदिक शिक्षामा मानव जीवनलाई कतिवटा आश्रममा विभाजन गरिएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'वैदिक शिक्षामा मानव जीवनलाई कतिवटा आश्रममा विभाजन गरिएको थियो?', E'तीन आश्रम', E'चार आश्रम', E'पाँच आश्रम', E'दुई आश्रम', E'B', E'**वैदिक शिक्षामा जीवनलाई ब्रह्मचर्य, गृहस्थ, वानप्रस्थ र सन्न्यास गरी चार आश्रममा विभाजन गरिएको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वैदिक शिक्षामा मानव जीवनलाई कतिवटा आश्रममा विभाजन गरिएको थियो?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'मल्लकालमा व्यावसायिक सीप सिकाउने व्यवस्था कुन राजाले सुरु गरेका थिए?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'मल्लकालमा व्यावसायिक सीप सिकाउने व्यवस्था कुन राजाले सुरु गरेका थिए?', E'प्रताप मल्ल', E'यक्ष मल्ल', E'भूपतीन्द्र मल्ल', E'जयस्थिति मल्ल', E'D', E'**मल्लकालमा जयस्थिति मल्लले व्यावसायिक सीप सिकाउने व्यवस्था सुरु गरेका थिए।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:मल्लकालमा व्यावसायिक सीप सिकाउने व्यवस्था कुन राजाले सुरु गरेका थिए?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वि.सं. २००७ सालसम्म नेपालमा कतिवटा महाविद्यालय (कलेज) मात्र थिए?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'वि.सं. २००७ सालसम्म नेपालमा कतिवटा महाविद्यालय (कलेज) मात्र थिए?', E'तीन', E'दुई', E'एक', E'पाँच', E'C', E'**वि.सं. २००७ मा नेपालमा ३२१ प्राथमिक, ११ माध्यमिक विद्यालय र एक मात्र महाविद्यालय (त्रिचन्द्र कलेज) थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वि.सं. २००७ सालसम्म नेपालमा कतिवटा महाविद्यालय (कलेज) मात्र थिए?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'निम्नमध्ये कुन कार्य देव समशेरको शैक्षिक योगदान होइन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'निम्नमध्ये कुन कार्य देव समशेरको शैक्षिक योगदान होइन?', E'भाषा पाठशालाको विस्तार', E'कन्या पाठशालाको स्थापना', E'गोरखापत्रको प्रकाशन', E'त्रिभुवन विश्वविद्यालयको स्थापना', E'D', E'**त्रिभुवन विश्वविद्यालयको स्थापना (वि.सं. २०१६) देव समशेरको योगदान होइन।** भाषा पाठशाला, कन्या पाठशाला र गोरखापत्र भने उनकै कालका कार्य हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:निम्नमध्ये कुन कार्य देव समशेरको शैक्षिक योगदान होइन?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यालय व्यवस्थापन हेर्ने निकाय स्कुल गोश्वाराको स्थापना कुन सालमा भएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'विद्यालय व्यवस्थापन हेर्ने निकाय स्कुल गोश्वाराको स्थापना कुन सालमा भएको थियो?', E'वि.सं. १९४५', E'वि.सं. १९५२', E'वि.सं. १९५७', E'वि.सं. १९६७', E'B', E'**स्कुल गोश्वाराको स्थापना वि.सं. १९५२ मा भएको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यालय व्यवस्थापन हेर्ने निकाय स्कुल गोश्वाराको स्थापना कुन सालमा भएको थियो?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वीर पुस्तकालयको स्थापना कुन सालमा भएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'वीर पुस्तकालयको स्थापना कुन सालमा भएको थियो?', E'वि.सं. १९५२', E'वि.सं. १९६७', E'वि.सं. १९५७', E'वि.सं. १९७५', E'C', E'**वीर पुस्तकालयको स्थापना वि.सं. १९५७ मा भएको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वीर पुस्तकालयको स्थापना कुन सालमा भएको थियो?'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'बसन्तपुरको कुमारी चोकमा टेक्निकल स्कुल कुन सालमा खुलेको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'बसन्तपुरको कुमारी चोकमा टेक्निकल स्कुल कुन सालमा खुलेको थियो?', E'वि.सं. १९८७', E'वि.सं. १९७५', E'वि.सं. १९८२', E'वि.सं. १९९०', E'A', E'**वि.सं. १९८७ फाल्गुन १९ मा बसन्तपुर कुमारी चोकमा टेक्निकल स्कुल खुलेको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:बसन्तपुरको कुमारी चोकमा टेक्निकल स्कुल कुन सालमा खुलेको थियो?'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विराटनगरमा आदर्श स्कुल खोल्न खोज्दा राणा शासनले कसलाई थुनामा राखेको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'विराटनगरमा आदर्श स्कुल खोल्न खोज्दा राणा शासनले कसलाई थुनामा राखेको थियो?', E'बी.पी. कोइराला', E'कृष्णप्रसाद कोइराला', E'टंकप्रसाद आचार्य', E'दिल्लीरमण रेग्मी', E'B', E'**वि.सं. १९९४ मा आदर्श स्कुल खोल्ने प्रयासमा कृष्णप्रसाद कोइराला थुनामा परेका थिए।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विराटनगरमा आदर्श स्कुल खोल्न खोज्दा राणा शासनले कसलाई थुनामा राखेको थियो?'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: शिक्षा आयोग तथा समितिका प्रतिवेदनहरू (आधारभूत तह) (16 Q)
  v_set_id := extensions.uuid_generate_v5('472e95ab-622e-48d9-9b70-b68afccc8589'::uuid, E'शिक्षा आयोग तथा समितिका प्रतिवेदनहरू (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '9b5be12e-0497-4716-ab14-356d4d19e7be'::uuid, '472e95ab-622e-48d9-9b70-b68afccc8589'::uuid, E'शिक्षा आयोग तथा समितिका प्रतिवेदनहरू (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '472e95ab-622e-48d9-9b70-b68afccc8589'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालको शैक्षिक इतिहासमा कोशेढुङ्गा मानिने पहिलो व्यापक शिक्षा आयोग कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'नेपालको शैक्षिक इतिहासमा कोशेढुङ्गा मानिने पहिलो व्यापक शिक्षा आयोग कुन हो?', E'राष्ट्रिय शिक्षा योजना आयोग, २०११', E'सर्वाङ्गीण राष्ट्रिय शिक्षा समिति, २०१८', E'राष्ट्रिय शिक्षा पद्धति योजना, २०२८', E'राष्ट्रिय शिक्षा आयोग, २०४९', E'A', E'**राष्ट्रिय शिक्षा योजना आयोग, २०११ (NNEPC) नेपालको पहिलो व्यापक शिक्षा आयोग हो, जसलाई शैक्षिक इतिहासको कोशेढुङ्गा मानिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालको शैक्षिक इतिहासमा कोशेढुङ्गा मानिने पहिलो व्यापक शिक्षा आयोग कुन हो?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'राष्ट्रिय शिक्षा योजना आयोग, २०११ ले कस्तो विद्यालय संरचना सिफारिस गरेको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'राष्ट्रिय शिक्षा योजना आयोग, २०११ ले कस्तो विद्यालय संरचना सिफारिस गरेको थियो?', E'३-४-३', E'५-५-४', E'५+३+२+२', E'१०+२', E'B', E'**राष्ट्रिय शिक्षा योजना आयोग, २०११ ले ५-५-४ ढाँचाको शिक्षा संरचना सिफारिस गरेको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:राष्ट्रिय शिक्षा योजना आयोग, २०११ ले कस्तो विद्यालय संरचना सिफारिस गरेको थियो?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'राष्ट्रिय शिक्षा योजना आयोग, २०११ का अध्यक्ष को थिए?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'राष्ट्रिय शिक्षा योजना आयोग, २०११ का अध्यक्ष को थिए?', E'डिल्लीरमण रेग्मी', E'त्रैलोक्यनाथ उप्रेती', E'सरदार रुद्रराज पाण्डे', E'केशर बहादुर के.सी.', E'C', E'**राष्ट्रिय शिक्षा योजना आयोग, २०११ का अध्यक्ष सरदार रुद्रराज पाण्डे थिए।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:राष्ट्रिय शिक्षा योजना आयोग, २०११ का अध्यक्ष को थिए?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'राष्ट्रिय शिक्षा योजना आयोग, २०११ का अमेरिकी शैक्षिक सल्लाहकार को थिए?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'राष्ट्रिय शिक्षा योजना आयोग, २०११ का अमेरिकी शैक्षिक सल्लाहकार को थिए?', E'केदारभक्त माथेमा', E'जोन डिवे', E'डा. रामावतार यादव', E'डा. ह्यु बी. उड', E'D', E'**ओरेगन विश्वविद्यालयका प्राध्यापक डा. ह्यु बी. उड (Hugh B. Wood) राष्ट्रिय शिक्षा योजना आयोग, २०११ का शैक्षिक सल्लाहकार थिए।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:राष्ट्रिय शिक्षा योजना आयोग, २०११ का अमेरिकी शैक्षिक सल्लाहकार को थिए?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सर्वाङ्गीण राष्ट्रिय शिक्षा समितिको गठन कुन सालमा भएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'सर्वाङ्गीण राष्ट्रिय शिक्षा समितिको गठन कुन सालमा भएको थियो?', E'वि.सं. २०१८', E'वि.सं. २०११', E'वि.सं. २०२४', E'वि.सं. २०२८', E'A', E'**सर्वाङ्गीण राष्ट्रिय शिक्षा समितिको गठन वि.सं. २०१८ मा भएको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सर्वाङ्गीण राष्ट्रिय शिक्षा समितिको गठन कुन सालमा भएको थियो?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सर्वाङ्गीण राष्ट्रिय शिक्षा समिति, २०१८ का अध्यक्ष को थिए?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'सर्वाङ्गीण राष्ट्रिय शिक्षा समिति, २०१८ का अध्यक्ष को थिए?', E'गोविन्दराज जोशी', E'विश्वबन्धु थापा', E'कुलबहादुर गुरुङ', E'अर्जुन नरसिंह केसी', E'B', E'**तत्कालीन शिक्षामन्त्री विश्वबन्धु थापा सर्वाङ्गीण राष्ट्रिय शिक्षा समिति, २०१८ का अध्यक्ष थिए।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सर्वाङ्गीण राष्ट्रिय शिक्षा समिति, २०१८ का अध्यक्ष को थिए?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालमा क्रान्तिकारी मानिने राष्ट्रिय शिक्षा पद्धति योजना (NESP) कुन सालमा लागू भएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'नेपालमा क्रान्तिकारी मानिने राष्ट्रिय शिक्षा पद्धति योजना (NESP) कुन सालमा लागू भएको थियो?', E'वि.सं. २०२४', E'वि.सं. २०४९', E'वि.सं. २०२८', E'वि.सं. २०१८', E'C', E'**राष्ट्रिय शिक्षा पद्धति योजना (NESP) वि.सं. २०२८ देखि लागू भएको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालमा क्रान्तिकारी मानिने राष्ट्रिय शिक्षा पद्धति योजना (NESP) कुन सालमा लागू भएको थियो?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'राष्ट्रिय शिक्षा पद्धति योजना, २०२८ ले कस्तो विद्यालय संरचना लागू गरेको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'राष्ट्रिय शिक्षा पद्धति योजना, २०२८ ले कस्तो विद्यालय संरचना लागू गरेको थियो?', E'५-५-४', E'५+३+२+२', E'१०+२', E'३-४-३', E'D', E'**राष्ट्रिय शिक्षा पद्धति योजना, २०२८ ले ३-४-३ को विद्यालय संरचना लागू गरेको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:राष्ट्रिय शिक्षा पद्धति योजना, २०२८ ले कस्तो विद्यालय संरचना लागू गरेको थियो?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यार्थीलाई गाउँमा अनिवार्य सेवा गर्नुपर्ने ''राष्ट्रिय विकास सेवा'' (NDS) कुन योजनाले लागू गरेको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'विद्यार्थीलाई गाउँमा अनिवार्य सेवा गर्नुपर्ने ''राष्ट्रिय विकास सेवा'' (NDS) कुन योजनाले लागू गरेको थियो?', E'राष्ट्रिय शिक्षा पद्धति योजना, २०२८', E'राष्ट्रिय शिक्षा योजना आयोग, २०११', E'राष्ट्रिय शिक्षा आयोग, २०४९', E'उच्चस्तरीय राष्ट्रिय शिक्षा आयोग, २०५५', E'A', E'**राष्ट्रिय शिक्षा पद्धति योजना, २०२८ ले राष्ट्रिय विकास सेवा (NDS) लागू गरेको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यार्थीलाई गाउँमा अनिवार्य सेवा गर्नुपर्ने ''राष्ट्रिय विकास सेवा'' (NDS) कुन योजनाले लागू गरेको थियो?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'राष्ट्रिय शिक्षा पद्धति योजना, २०२८ को पहिलो (प्रयोगात्मक) चरण कुन जिल्लाबाट सुरु भएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'राष्ट्रिय शिक्षा पद्धति योजना, २०२८ को पहिलो (प्रयोगात्मक) चरण कुन जिल्लाबाट सुरु भएको थियो?', E'झापा र मोरङ', E'चितवन र कास्की', E'काठमाडौँ र ललितपुर', E'बाँके र दाङ', E'B', E'**राष्ट्रिय शिक्षा पद्धति योजना, २०२८ को पहिलो प्रयोगात्मक चरण चितवन र कास्की गरी २ जिल्लाबाट सुरु भएको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:राष्ट्रिय शिक्षा पद्धति योजना, २०२८ को पहिलो (प्रयोगात्मक) चरण कुन जिल्लाबाट सुरु भएको थियो?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'राष्ट्रिय शिक्षा पद्धति योजना, २०२८ ले त्रिभुवन विश्वविद्यालयअन्तर्गत कतिवटा अध्ययन संस्थान (Institutes) स्थापना गरेको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'राष्ट्रिय शिक्षा पद्धति योजना, २०२८ ले त्रिभुवन विश्वविद्यालयअन्तर्गत कतिवटा अध्ययन संस्थान (Institutes) स्थापना गरेको थियो?', E'१०', E'१२', E'१६', E'४', E'C', E'**राष्ट्रिय शिक्षा पद्धति योजना, २०२८ ले त्रिभुवन विश्वविद्यालयअन्तर्गत १६ वटा अध्ययन संस्थान स्थापना गरी विकेन्द्रीकरण गरेको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:राष्ट्रिय शिक्षा पद्धति योजना, २०२८ ले त्रिभुवन विश्वविद्यालयअन्तर्गत कतिवटा अध्ययन संस्थान (Institutes) स्थापना गरेको थियो?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'राष्ट्रिय शिक्षा आयोग, २०४९ का अध्यक्ष को थिए?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'राष्ट्रिय शिक्षा आयोग, २०४९ का अध्यक्ष को थिए?', E'केदारभक्त माथेमा', E'डा. सुरेशराज शर्मा', E'डा. त्रैलोक्यनाथ उप्रेती', E'गोविन्दराज जोशी', E'D', E'**तत्कालीन शिक्षामन्त्री गोविन्दराज जोशी राष्ट्रिय शिक्षा आयोग, २०४९ का अध्यक्ष थिए।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:राष्ट्रिय शिक्षा आयोग, २०४९ का अध्यक्ष को थिए?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'राष्ट्रिय शिक्षा आयोग, २०४९ ले कस्तो विद्यालय संरचना सिफारिस गरेको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'राष्ट्रिय शिक्षा आयोग, २०४९ ले कस्तो विद्यालय संरचना सिफारिस गरेको थियो?', E'५+३+२+२', E'३-४-३', E'५-५-४', E'१०+२+३', E'A', E'**राष्ट्रिय शिक्षा आयोग, २०४९ ले ५+३+२+२ मोडलको विद्यालय संरचना सिफारिस गरेको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:राष्ट्रिय शिक्षा आयोग, २०४९ ले कस्तो विद्यालय संरचना सिफारिस गरेको थियो?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'उच्चस्तरीय राष्ट्रिय शिक्षा आयोग, २०५५ ले राष्ट्रिय बजेटको कति प्रतिशत शिक्षा क्षेत्रमा विनियोजन गर्नुपर्ने सिफारिस गरेको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'उच्चस्तरीय राष्ट्रिय शिक्षा आयोग, २०५५ ले राष्ट्रिय बजेटको कति प्रतिशत शिक्षा क्षेत्रमा विनियोजन गर्नुपर्ने सिफारिस गरेको थियो?', E'१० प्रतिशत', E'१७ प्रतिशत', E'१५ प्रतिशत', E'२० प्रतिशत', E'B', E'**उच्चस्तरीय राष्ट्रिय शिक्षा आयोग, २०५५ ले राष्ट्रिय बजेटको १७ प्रतिशत शिक्षामा विनियोजन गर्नुपर्ने सिफारिस गरेको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:उच्चस्तरीय राष्ट्रिय शिक्षा आयोग, २०५५ ले राष्ट्रिय बजेटको कति प्रतिशत शिक्षा क्षेत्रमा विनियोजन गर्नुपर्ने सिफारिस गरेको थियो?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'उच्चस्तरीय राष्ट्रिय शिक्षा आयोग, २०५५ ले कुल शिक्षा बजेटको कति प्रतिशत प्राथमिक शिक्षामा लगानी गर्नुपर्ने सिफारिस गरेको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'उच्चस्तरीय राष्ट्रिय शिक्षा आयोग, २०५५ ले कुल शिक्षा बजेटको कति प्रतिशत प्राथमिक शिक्षामा लगानी गर्नुपर्ने सिफारिस गरेको थियो?', E'५० प्रतिशत', E'४० प्रतिशत', E'५५ प्रतिशत', E'६० प्रतिशत', E'C', E'**उच्चस्तरीय राष्ट्रिय शिक्षा आयोग, २०५५ ले कुल शिक्षा बजेटको ५५ प्रतिशत प्राथमिक शिक्षामा लगानी गर्नुपर्ने सिफारिस गरेको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:उच्चस्तरीय राष्ट्रिय शिक्षा आयोग, २०५५ ले कुल शिक्षा बजेटको कति प्रतिशत प्राथमिक शिक्षामा लगानी गर्नुपर्ने सिफारिस गरेको थियो?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सर्वाङ्गीण राष्ट्रिय शिक्षा समिति, २०१८ ले विश्वविद्यालय उत्तीर्ण गर्नेलाई कुन उपाधि दिने सिफारिस गरेको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'सर्वाङ्गीण राष्ट्रिय शिक्षा समिति, २०१८ ले विश्वविद्यालय उत्तीर्ण गर्नेलाई कुन उपाधि दिने सिफारिस गरेको थियो?', E'प्रथमा', E'मध्यमा', E'आचार्य', E'शास्त्री', E'D', E'**सर्वाङ्गीण राष्ट्रिय शिक्षा समिति, २०१८ ले विश्वविद्यालय उत्तीर्णलाई ''शास्त्री'' उपाधि दिने सिफारिस गरेको थियो (माध्यमिक–प्रथमा, महाविद्यालय–मध्यमा, M.A.–आचार्य)।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सर्वाङ्गीण राष्ट्रिय शिक्षा समिति, २०१८ ले विश्वविद्यालय उत्तीर्ण गर्नेलाई कुन उपाधि दिने सिफारिस गरेको थियो?'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: वि.सं. २००७ पछिका शैक्षिक घटनाक्रम र संस्थागत विकास (आधारभूत तह) (16 Q)
  v_set_id := extensions.uuid_generate_v5('472e95ab-622e-48d9-9b70-b68afccc8589'::uuid, E'वि.सं. २००७ पछिका शैक्षिक घटनाक्रम र संस्थागत विकास (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '9b5be12e-0497-4716-ab14-356d4d19e7be'::uuid, '472e95ab-622e-48d9-9b70-b68afccc8589'::uuid, E'वि.सं. २००७ पछिका शैक्षिक घटनाक्रम र संस्थागत विकास (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '472e95ab-622e-48d9-9b70-b68afccc8589'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालको पहिलो विश्वविद्यालय त्रिभुवन विश्वविद्यालयको स्थापना कुन सालमा भएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'नेपालको पहिलो विश्वविद्यालय त्रिभुवन विश्वविद्यालयको स्थापना कुन सालमा भएको थियो?', E'वि.सं. २०१६', E'वि.सं. २०११', E'वि.सं. २०२८', E'वि.सं. २००७', E'A', E'**नेपालको पहिलो विश्वविद्यालय त्रिभुवन विश्वविद्यालय वि.सं. २०१६ असार ३० मा स्थापना भएको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालको पहिलो विश्वविद्यालय त्रिभुवन विश्वविद्यालयको स्थापना कुन सालमा भएको थियो?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालमा विशेष शिक्षाको सुरुवात (कीर्तिपुरको लेबोरेटरी स्कुलमा दृष्टिविहीन विद्यार्थीका लागि) कुन सालदेखि भएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'नेपालमा विशेष शिक्षाको सुरुवात (कीर्तिपुरको लेबोरेटरी स्कुलमा दृष्टिविहीन विद्यार्थीका लागि) कुन सालदेखि भएको थियो?', E'वि.सं. २०१९', E'वि.सं. २०२१', E'वि.सं. २०२३', E'वि.सं. २०१६', E'B', E'**वि.सं. २०२१ फागुनदेखि कीर्तिपुरको लेबोरेटरी स्कुलमा दृष्टिविहीन विद्यार्थीका लागि पठनपाठन सुरु गरी नेपालमा विशेष शिक्षाको थालनी भएको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालमा विशेष शिक्षाको सुरुवात (कीर्तिपुरको लेबोरेटरी स्कुलमा दृष्टिविहीन विद्यार्थीका लागि) कुन सालदेखि भएको थियो?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालमा अध्यापन अनुमतिपत्र (अधिकारपत्र) को व्यवस्था सुरुमा २० जिल्लामा कुन सालमा लागू गरिएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'नेपालमा अध्यापन अनुमतिपत्र (अधिकारपत्र) को व्यवस्था सुरुमा २० जिल्लामा कुन सालमा लागू गरिएको थियो?', E'वि.सं. २०१६', E'वि.सं. २०२१', E'वि.सं. २०२३', E'वि.सं. २०२८', E'C', E'**वि.सं. २०२३ मा २० जिल्लामा अध्यापन अनुमतिपत्र (अधिकारपत्र) को व्यवस्था लागू गरिएको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालमा अध्यापन अनुमतिपत्र (अधिकारपत्र) को व्यवस्था सुरुमा २० जिल्लामा कुन सालमा लागू गरिएको थियो?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपाली भाषाले राष्ट्रभाषाका रूपमा मान्यता कुन सालमा पाएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'नेपाली भाषाले राष्ट्रभाषाका रूपमा मान्यता कुन सालमा पाएको थियो?', E'वि.सं. २०११', E'वि.सं. २०१६', E'वि.सं. २०१९', E'वि.सं. २०१५', E'D', E'**नेपाली भाषाले राष्ट्रभाषाका रूपमा मान्यता वि.सं. २०१५ मा पाएको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपाली भाषाले राष्ट्रभाषाका रूपमा मान्यता कुन सालमा पाएको थियो?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपाल कोलम्बो योजनाको सदस्य कुन सालमा बनेको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'नेपाल कोलम्बो योजनाको सदस्य कुन सालमा बनेको थियो?', E'वि.सं. २००९', E'वि.सं. २०११', E'वि.सं. २०१६', E'वि.सं. २००७', E'A', E'**नेपाल वि.सं. २००९ मा कोलम्बो योजनाको सदस्य बनेको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपाल कोलम्बो योजनाको सदस्य कुन सालमा बनेको थियो?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शैक्षिक विकेन्द्रीकरणका लागि देशलाई ७ क्षेत्रमा बाँडी डिभिजनल इन्स्पेक्टरको व्यवस्था कुन सालमा गरिएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'शैक्षिक विकेन्द्रीकरणका लागि देशलाई ७ क्षेत्रमा बाँडी डिभिजनल इन्स्पेक्टरको व्यवस्था कुन सालमा गरिएको थियो?', E'वि.सं. २००८', E'वि.सं. २०१०', E'वि.सं. २०१६', E'वि.सं. २०२८', E'B', E'**वि.सं. २०१० माघ १६ मा शैक्षिक विकेन्द्रीकरणका लागि देशलाई ७ क्षेत्रमा बाँडी डिभिजनल इन्स्पेक्टरको व्यवस्था गरिएको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शैक्षिक विकेन्द्रीकरणका लागि देशलाई ७ क्षेत्रमा बाँडी डिभिजनल इन्स्पेक्टरको व्यवस्था कुन सालमा गरिएको थियो?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालमा कक्षा १ देखि नै अङ्ग्रेजी विषय अनिवार्य कुन सालदेखि भएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'नेपालमा कक्षा १ देखि नै अङ्ग्रेजी विषय अनिवार्य कुन सालदेखि भएको थियो?', E'वि.सं. २०५६', E'वि.सं. २०५२', E'वि.सं. २०६०', E'वि.सं. २०६६', E'C', E'**वि.सं. २०६० देखि नेपालमा कक्षा १ देखि नै अङ्ग्रेजी विषय अनिवार्य भएको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालमा कक्षा १ देखि नै अङ्ग्रेजी विषय अनिवार्य कुन सालदेखि भएको थियो?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालमा शैक्षिक सत्र श्रावण महिनादेखि सुरु हुने व्यवस्था कुन सालदेखि भएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'नेपालमा शैक्षिक सत्र श्रावण महिनादेखि सुरु हुने व्यवस्था कुन सालदेखि भएको थियो?', E'वि.सं. २०५२', E'वि.सं. २०६०', E'वि.सं. २०४९', E'वि.सं. २०५६', E'D', E'**वि.सं. २०५६ देखि नेपालमा शैक्षिक सत्र श्रावण महिनादेखि सुरु हुने व्यवस्था भएको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालमा शैक्षिक सत्र श्रावण महिनादेखि सुरु हुने व्यवस्था कुन सालदेखि भएको थियो?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालमा ब्रेल पुस्तकालयको स्थापना कुन सालमा भएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'नेपालमा ब्रेल पुस्तकालयको स्थापना कुन सालमा भएको थियो?', E'वि.सं. २०५२', E'वि.सं. २०५६', E'वि.सं. २०४३', E'वि.सं. २०५५', E'A', E'**वि.सं. २०५२ साउन २२ मा नेपालमा ब्रेल पुस्तकालयको स्थापना भएको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालमा ब्रेल पुस्तकालयको स्थापना कुन सालमा भएको थियो?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपाल राजपत्र (गजेट) को प्रकाशन कुन सालदेखि सुरु भएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'नेपाल राजपत्र (गजेट) को प्रकाशन कुन सालदेखि सुरु भएको थियो?', E'वि.सं. २००७', E'वि.सं. २००८', E'वि.सं. २०११', E'वि.सं. २०१६', E'B', E'**वि.सं. २००८ श्रावण २२ देखि नेपाल राजपत्र (गजेट) को प्रकाशन सुरु भएको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपाल राजपत्र (गजेट) को प्रकाशन कुन सालदेखि सुरु भएको थियो?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'राष्ट्रिय अभिलेखालयको स्थापना कुन सालमा भएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'राष्ट्रिय अभिलेखालयको स्थापना कुन सालमा भएको थियो?', E'वि.सं. २०१६', E'वि.सं. २०१८', E'वि.सं. २०१९', E'वि.सं. २०२३', E'C', E'**राष्ट्रिय अभिलेखालयको स्थापना वि.सं. २०१९ मा भएको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:राष्ट्रिय अभिलेखालयको स्थापना कुन सालमा भएको थियो?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'त्रिभुवन विश्वविद्यालयअन्तर्गतको शिक्षाशास्त्र अध्ययन संस्थानलाई शिक्षाशास्त्र संकायमा कुन सालमा परिणत गरिएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'त्रिभुवन विश्वविद्यालयअन्तर्गतको शिक्षाशास्त्र अध्ययन संस्थानलाई शिक्षाशास्त्र संकायमा कुन सालमा परिणत गरिएको थियो?', E'वि.सं. २०२९', E'वि.सं. २०३६', E'वि.सं. २०४०', E'वि.सं. २०४३', E'D', E'**वि.सं. २०४३ मा शिक्षाशास्त्र अध्ययन संस्थानलाई शिक्षाशास्त्र संकायमा परिणत गरिएको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:त्रिभुवन विश्वविद्यालयअन्तर्गतको शिक्षाशास्त्र अध्ययन संस्थानलाई शिक्षाशास्त्र संकायमा कुन सालमा परिणत गरिएको थियो?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपाल सरकार र अमेरिकी सहयोग नियोग (USAID) बिचको सम्झौताबाट विज्ञान शिक्षा प्रवर्द्धन कार्यक्रम (STEP) कुन सालमा सुरु भएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'नेपाल सरकार र अमेरिकी सहयोग नियोग (USAID) बिचको सम्झौताबाट विज्ञान शिक्षा प्रवर्द्धन कार्यक्रम (STEP) कुन सालमा सुरु भएको थियो?', E'वि.सं. २०२३', E'वि.सं. २०२९', E'वि.सं. २०१६', E'वि.सं. २०१९', E'A', E'**वि.सं. २०२३ मा नेपाल सरकार र USAID बिचको सम्झौताबाट विज्ञान शिक्षा प्रवर्द्धन कार्यक्रम (STEP) सुरु भएको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपाल सरकार र अमेरिकी सहयोग नियोग (USAID) बिचको सम्झौताबाट विज्ञान शिक्षा प्रवर्द्धन कार्यक्रम (STEP) कुन सालमा सुरु भएको थियो?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'फिनल्यान्ड सरकारको सहयोगमा वि.सं. २०६४–२०६६ मा बहुभाषी शिक्षा कार्यक्रम कतिवटा जिल्लामा सञ्चालन गरिएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'फिनल्यान्ड सरकारको सहयोगमा वि.सं. २०६४–२०६६ मा बहुभाषी शिक्षा कार्यक्रम कतिवटा जिल्लामा सञ्चालन गरिएको थियो?', E'४ जिल्ला', E'६ जिल्ला', E'८ जिल्ला', E'१० जिल्ला', E'B', E'**फिनल्यान्ड सरकारको सहयोगमा वि.सं. २०६४ देखि २०६६ सम्म ६ जिल्लाका ७ विद्यालयमा बहुभाषी शिक्षा कार्यक्रम सञ्चालन गरिएको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:फिनल्यान्ड सरकारको सहयोगमा वि.सं. २०६४–२०६६ मा बहुभाषी शिक्षा कार्यक्रम कतिवटा जिल्लामा सञ्चालन गरिएको थियो?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वि.पी. कोइराला स्वास्थ्य विज्ञान प्रतिष्ठानको स्थापना कुन सालमा भएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'वि.पी. कोइराला स्वास्थ्य विज्ञान प्रतिष्ठानको स्थापना कुन सालमा भएको थियो?', E'वि.सं. २०५२', E'वि.सं. २०५६', E'वि.सं. २०५५', E'वि.सं. २०४९', E'C', E'**वि.पी. कोइराला स्वास्थ्य विज्ञान प्रतिष्ठानको स्थापना वि.सं. २०५५ मा भएको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वि.पी. कोइराला स्वास्थ्य विज्ञान प्रतिष्ठानको स्थापना कुन सालमा भएको थियो?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'निम्नमध्ये कुन घटना वि.सं. २००७ पछिको होइन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'निम्नमध्ये कुन घटना वि.सं. २००७ पछिको होइन?', E'त्रिभुवन विश्वविद्यालयको स्थापना', E'विशेष शिक्षाको सुरुवात', E'अध्यापन अनुमतिपत्रको व्यवस्था', E'दरबार स्कुलको स्थापना', E'D', E'**दरबार स्कुलको स्थापना (वि.सं. १९१०) वि.सं. २००७ भन्दा अघिको घटना हो।** बाँकी तीनै घटना (TU २०१६, विशेष शिक्षा २०२१, अध्यापन अनुमतिपत्र २०२३) प्रजातन्त्रपछिका हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:निम्नमध्ये कुन घटना वि.सं. २००७ पछिको होइन?'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: शैक्षिक संगठन र संरचना: संघीयदेखि स्थानीय निकायहरू (आधारभूत तह) (16 Q)
  v_set_id := extensions.uuid_generate_v5('78064cb5-7e3a-4be6-bbf8-2ff364bdc4e4'::uuid, E'शैक्षिक संगठन र संरचना: संघीयदेखि स्थानीय निकायहरू (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '9b5be12e-0497-4716-ab14-356d4d19e7be'::uuid, '78064cb5-7e3a-4be6-bbf8-2ff364bdc4e4'::uuid, E'शैक्षिक संगठन र संरचना: संघीयदेखि स्थानीय निकायहरू (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '78064cb5-7e3a-4be6-bbf8-2ff364bdc4e4'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालमा शिक्षा मन्त्रालयको स्थापना कुन सालमा भएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'नेपालमा शिक्षा मन्त्रालयको स्थापना कुन सालमा भएको थियो?', E'वि.सं. २००७ फाल्गुण ७', E'वि.सं. २०१६', E'वि.सं. २०५६', E'वि.सं. १९१०', E'A', E'**नेपालमा शिक्षा मन्त्रालयको स्थापना वि.सं. २००७ साल फाल्गुण ७ गते भएको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालमा शिक्षा मन्त्रालयको स्थापना कुन सालमा भएको थियो?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा, विज्ञान तथा प्रविधि मन्त्रालयमा हाल कतिवटा महाशाखा रहेका छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'शिक्षा, विज्ञान तथा प्रविधि मन्त्रालयमा हाल कतिवटा महाशाखा रहेका छन्?', E'३ महाशाखा', E'७ महाशाखा', E'५ महाशाखा', E'९ महाशाखा', E'B', E'**शिक्षा, विज्ञान तथा प्रविधि मन्त्रालयमा ७ महाशाखा र ३० शाखा रहेका छन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा, विज्ञान तथा प्रविधि मन्त्रालयमा हाल कतिवटा महाशाखा रहेका छन्?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा तथा मानव स्रोत विकास केन्द्र (CEHRD) को स्थापना कुन सालमा भएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'शिक्षा तथा मानव स्रोत विकास केन्द्र (CEHRD) को स्थापना कुन सालमा भएको थियो?', E'वि.सं. २०५२', E'वि.सं. २०४९', E'वि.सं. २०५६', E'वि.सं. २०६६', E'C', E'**शिक्षा तथा मानव स्रोत विकास केन्द्र (CEHRD) को स्थापना वि.सं. २०५६/०२/०९ मा भएको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा तथा मानव स्रोत विकास केन्द्र (CEHRD) को स्थापना कुन सालमा भएको थियो?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा तथा मानव स्रोत विकास केन्द्र (CEHRD) मा कतिवटा महाशाखा रहेका छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'शिक्षा तथा मानव स्रोत विकास केन्द्र (CEHRD) मा कतिवटा महाशाखा रहेका छन्?', E'७ महाशाखा', E'५ महाशाखा', E'४ महाशाखा', E'३ महाशाखा', E'D', E'**शिक्षा तथा मानव स्रोत विकास केन्द्र (CEHRD) मा ३ महाशाखा र १७ शाखा रहेका छन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा तथा मानव स्रोत विकास केन्द्र (CEHRD) मा कतिवटा महाशाखा रहेका छन्?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शैक्षिक गुणस्तर परीक्षण केन्द्र (ERO) को स्थापना कुन मितिमा भएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'शैक्षिक गुणस्तर परीक्षण केन्द्र (ERO) को स्थापना कुन मितिमा भएको थियो?', E'वि.सं. २०६६ कार्तिक १३', E'वि.सं. २०६७ कार्तिक ३०', E'वि.सं. २०५६ जेठ ९', E'वि.सं. २०७० असार १५', E'A', E'**शिक्षा मन्त्रालयअन्तर्गत शैक्षिक गुणस्तर परीक्षण केन्द्र (Education Review Office) को स्थापना वि.सं. २०६६ कार्तिक १३ मा भएको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शैक्षिक गुणस्तर परीक्षण केन्द्र (ERO) को स्थापना कुन मितिमा भएको थियो?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शैक्षिक गुणस्तर परीक्षण केन्द्र (ERO) को कार्यकारी प्रमुख कुन पद हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'शैक्षिक गुणस्तर परीक्षण केन्द्र (ERO) को कार्यकारी प्रमुख कुन पद हो?', E'सचिव', E'महानिर्देशक', E'अध्यक्ष', E'निर्देशक', E'B', E'**शैक्षिक गुणस्तर परीक्षण केन्द्र (ERO) को कार्यकारी प्रमुख महानिर्देशक हुन्छन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शैक्षिक गुणस्तर परीक्षण केन्द्र (ERO) को कार्यकारी प्रमुख कुन पद हो?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'राष्ट्रिय परीक्षा बोर्ड (NEB) का अध्यक्षको पदावधि कति वर्षको हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'राष्ट्रिय परीक्षा बोर्ड (NEB) का अध्यक्षको पदावधि कति वर्षको हुन्छ?', E'२ वर्ष', E'३ वर्ष', E'४ वर्ष', E'५ वर्ष', E'C', E'**राष्ट्रिय परीक्षा बोर्ड (NEB) का अध्यक्ष तथा मनोनीत सदस्यको पदावधि ४ वर्षको हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:राष्ट्रिय परीक्षा बोर्ड (NEB) का अध्यक्षको पदावधि कति वर्षको हुन्छ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'राष्ट्रिय परीक्षा बोर्ड (NEB) को उपाध्यक्ष को रहने व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'राष्ट्रिय परीक्षा बोर्ड (NEB) को उपाध्यक्ष को रहने व्यवस्था छ?', E'प्रधानमन्त्री', E'शिक्षामन्त्री', E'CEHRD का महानिर्देशक', E'शिक्षा मन्त्रालयको सचिव', E'D', E'**राष्ट्रिय परीक्षा बोर्ड (NEB) को उपाध्यक्ष शिक्षा मन्त्रालयको सचिव रहने व्यवस्था छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:राष्ट्रिय परीक्षा बोर्ड (NEB) को उपाध्यक्ष को रहने व्यवस्था छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कक्षा ११ र १२ को अन्त्यमा हुने माध्यमिक शिक्षा प्रमाणीकरण परीक्षा (SLCE) कुन निकायले सञ्चालन गर्दछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'कक्षा ११ र १२ को अन्त्यमा हुने माध्यमिक शिक्षा प्रमाणीकरण परीक्षा (SLCE) कुन निकायले सञ्चालन गर्दछ?', E'राष्ट्रिय परीक्षा बोर्ड (NEB)', E'प्रदेशस्तरीय परीक्षा बोर्ड', E'शैक्षिक गुणस्तर परीक्षण केन्द्र', E'त्रिभुवन विश्वविद्यालय', E'A', E'**कक्षा ११ र १२ को माध्यमिक शिक्षा प्रमाणीकरण परीक्षा (SLCE) राष्ट्रिय परीक्षा बोर्ड (NEB) ले सञ्चालन गर्दछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कक्षा ११ र १२ को अन्त्यमा हुने माध्यमिक शिक्षा प्रमाणीकरण परीक्षा (SLCE) कुन निकायले सञ्चालन गर्दछ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कक्षा १० को अन्त्यमा हुने माध्यमिक शिक्षा परीक्षा (SEE) कुन तहको निकायले सञ्चालन गर्दछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'कक्षा १० को अन्त्यमा हुने माध्यमिक शिक्षा परीक्षा (SEE) कुन तहको निकायले सञ्चालन गर्दछ?', E'संघीय परीक्षा बोर्ड', E'प्रदेशस्तरीय परीक्षा बोर्ड', E'स्थानीय तह', E'शिक्षा विकास तथा समन्वय इकाई', E'B', E'**कक्षा १० को माध्यमिक शिक्षा परीक्षा (SEE) को सञ्चालन, प्रश्नपत्र निर्माण र नतिजा प्रकाशन प्रदेशस्तरीय परीक्षा बोर्डले गर्दछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कक्षा १० को अन्त्यमा हुने माध्यमिक शिक्षा परीक्षा (SEE) कुन तहको निकायले सञ्चालन गर्दछ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'संघीय स्तरमा राष्ट्रिय पाठ्यक्रम विकास, परिमार्जन र सम्बन्धित अनुसन्धान गर्ने निकाय कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'संघीय स्तरमा राष्ट्रिय पाठ्यक्रम विकास, परिमार्जन र सम्बन्धित अनुसन्धान गर्ने निकाय कुन हो?', E'शैक्षिक गुणस्तर परीक्षण केन्द्र', E'राष्ट्रिय परीक्षा बोर्ड', E'पाठ्यक्रम विकास केन्द्र (CDC)', E'शिक्षा तथा मानव स्रोत विकास केन्द्र', E'C', E'**संघीय स्तरमा राष्ट्रिय पाठ्यक्रम विकास, परिमार्जन र अनुसन्धान गर्ने निकाय पाठ्यक्रम विकास केन्द्र (CDC) हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:संघीय स्तरमा राष्ट्रिय पाठ्यक्रम विकास, परिमार्जन र सम्बन्धित अनुसन्धान गर्ने निकाय कुन हो?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यालय पाठ्यपुस्तकको लेखन, छपाइ र वितरण गर्ने सानोठिमीस्थित निकाय कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'विद्यालय पाठ्यपुस्तकको लेखन, छपाइ र वितरण गर्ने सानोठिमीस्थित निकाय कुन हो?', E'पाठ्यक्रम विकास केन्द्र', E'शैक्षिक गुणस्तर परीक्षण केन्द्र', E'राष्ट्रिय अभिलेखालय', E'जनक शिक्षा सामग्री केन्द्र', E'D', E'**विद्यालय पाठ्यपुस्तकको लेखन, छपाइ र वितरण गर्ने सानोठिमीस्थित निकाय जनक शिक्षा सामग्री केन्द्र हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यालय पाठ्यपुस्तकको लेखन, छपाइ र वितरण गर्ने सानोठिमीस्थित निकाय कुन हो?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'संघीय संरचनामा प्रदेश तहमा शिक्षा हेर्ने निकाय कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'संघीय संरचनामा प्रदेश तहमा शिक्षा हेर्ने निकाय कुन हो?', E'शिक्षा विकास निर्देशनालय', E'शिक्षा तथा मानव स्रोत विकास केन्द्र', E'शिक्षा विकास तथा समन्वय इकाई', E'स्थानीय शिक्षा शाखा', E'A', E'**प्रदेश तहमा सामाजिक विकास मन्त्रालयअन्तर्गत शिक्षा विकास निर्देशनालयले शिक्षा हेर्दछ; सातै प्रदेशमा यो स्थापना भएको छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:संघीय संरचनामा प्रदेश तहमा शिक्षा हेर्ने निकाय कुन हो?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'जिल्ला तहमा शिक्षा समन्वय गर्ने निकाय कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'जिल्ला तहमा शिक्षा समन्वय गर्ने निकाय कुन हो?', E'जिल्ला शिक्षा कार्यालय', E'शिक्षा विकास तथा समन्वय इकाई', E'शिक्षा विकास निर्देशनालय', E'स्रोत केन्द्र', E'B', E'**हालको संघीय संरचनामा जिल्ला तहमा शिक्षा समन्वय गर्ने निकाय शिक्षा विकास तथा समन्वय इकाई हो (यसको संरचना ४ समूह र १६ कार्यविवरणमा वर्गीकृत छ)।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:जिल्ला तहमा शिक्षा समन्वय गर्ने निकाय कुन हो?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शैक्षिक गुणस्तर परीक्षण केन्द्र (ERO) ले सञ्चालन गर्ने राष्ट्रिय स्तरको विद्यार्थी उपलब्धि परीक्षण प्रणालीलाई छोटकरीमा के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'शैक्षिक गुणस्तर परीक्षण केन्द्र (ERO) ले सञ्चालन गर्ने राष्ट्रिय स्तरको विद्यार्थी उपलब्धि परीक्षण प्रणालीलाई छोटकरीमा के भनिन्छ?', E'EMIS', E'SLCE', E'NASA', E'EGRA', E'C', E'**शैक्षिक गुणस्तर परीक्षण केन्द्र (ERO) ले सञ्चालन गर्ने राष्ट्रिय विद्यार्थी उपलब्धि परीक्षणलाई नासा (NASA — National Assessment of Student Achievement) भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शैक्षिक गुणस्तर परीक्षण केन्द्र (ERO) ले सञ्चालन गर्ने राष्ट्रिय स्तरको विद्यार्थी उपलब्धि परीक्षण प्रणालीलाई छोटकरीमा के भनिन्छ?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'निम्नमध्ये कुन निकाय संघीय (केन्द्रीय) तहको होइन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'निम्नमध्ये कुन निकाय संघीय (केन्द्रीय) तहको होइन?', E'शिक्षा तथा मानव स्रोत विकास केन्द्र', E'पाठ्यक्रम विकास केन्द्र', E'राष्ट्रिय परीक्षा बोर्ड', E'शिक्षा विकास निर्देशनालय', E'D', E'**शिक्षा विकास निर्देशनालय प्रदेश तहको निकाय हो, संघीय होइन।** CEHRD, पाठ्यक्रम विकास केन्द्र र राष्ट्रिय परीक्षा बोर्ड भने संघीय तहका निकाय हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:निम्नमध्ये कुन निकाय संघीय (केन्द्रीय) तहको होइन?'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  RAISE NOTICE 'Unit ख-१ upsert complete: 6 sets, 101 questions.';
END $$;
