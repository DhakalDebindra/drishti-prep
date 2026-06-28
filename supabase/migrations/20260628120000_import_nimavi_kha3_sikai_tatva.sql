-- Idempotent UPSERT import: निमावि प्रथम पत्र — unit ख-३ सिकाइ (concept/transfer/reinforcement batch)
-- Adds Level I sets alongside preserved model sets. Override same-identity; never deletes. Generated 2026-06-28T05:29:13.612Z.
DO $$
DECLARE
  v_module_id uuid := '6695669a-f40e-421a-a4ec-b09bbeaf56c4'::uuid;
  v_set_id uuid;
  v_q_id uuid;
BEGIN

  -- Set: सिकाइको अर्थ, परिभाषा र विशेषता (आधारभूत तह) (20 Q)
  v_set_id := extensions.uuid_generate_v5('1321484b-4aed-477a-8d70-b5d735dedd94'::uuid, E'सिकाइको अर्थ, परिभाषा र विशेषता (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '4752098a-e0df-497d-a58a-61d08d4c6814'::uuid, '1321484b-4aed-477a-8d70-b5d735dedd94'::uuid, E'सिकाइको अर्थ, परिभाषा र विशेषता (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '1321484b-4aed-477a-8d70-b5d735dedd94'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''सिकाइ'' कुन अङ्ग्रेजी शब्दको नेपाली रूपान्तरण हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'''सिकाइ'' कुन अङ्ग्रेजी शब्दको नेपाली रूपान्तरण हो?', E'Teaching', E'Learning', E'Training', E'Education', E'B', E'**''सिकाइ'' अङ्ग्रेजी शब्द ''Learning'' को नेपाली रूपान्तरण हो।**\\n- Teaching को नेपाली अर्थ शिक्षण हो।\\n- Training को अर्थ तालिम हो।\\n- Education को अर्थ शिक्षा हो।\\nनोट: सिकाइ भनेको अनुभव, तालिम र अभ्यासद्वारा व्यवहारमा आउने परिवर्तन हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''सिकाइ'' कुन अङ्ग्रेजी शब्दको नेपाली रूपान्तरण हो?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सिकाइको शाब्दिक अर्थ के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'सिकाइको शाब्दिक अर्थ के हो?', E'अनुभव, तालिम र अभ्यासद्वारा व्यवहारमा आउने परिवर्तन', E'जन्मजात प्राप्त हुने स्वभाव', E'शारीरिक अङ्गको आकारमा हुने वृद्धि', E'वंशाणुक्रमबाट प्राप्त हुने गुण', E'A', E'**सिकाइको शाब्दिक अर्थ अनुभव, तालिम र अभ्यासद्वारा व्यवहारमा आउने परिवर्तन हो।**\\nनोट: यो परिवर्तन तुलनात्मक रूपमा स्थायी हुन्छ; शारीरिक आकारमा हुने वृद्धि भने वृद्धि (Growth) हो, सिकाइ होइन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सिकाइको शाब्दिक अर्थ के हो?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''व्यवहारमा आउने उत्तरोत्तर अनुकूलनको प्रक्रिया (Progressive adaptation) नै सिकाइ हो'' भनी कसले परिभाषित गरेका छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'''व्यवहारमा आउने उत्तरोत्तर अनुकूलनको प्रक्रिया (Progressive adaptation) नै सिकाइ हो'' भनी कसले परिभाषित गरेका छन्?', E'गेट्स (Gates)', E'वुडवर्थ (Woodworth)', E'स्किनर (Skinner)', E'क्रोनब्याक (Cronbach)', E'C', E'**''व्यवहारमा आउने उत्तरोत्तर अनुकूलनको प्रक्रिया नै सिकाइ हो'' भनी स्किनर (Skinner) ले परिभाषित गरेका छन्।**\\n- गेट्सले ''अनुभव र तालिमद्वारा व्यवहारमा आउने परिवर्तन नै सिकाइ हो'' भने।\\n- वुडवर्थले ''सिकाइ नयाँ ज्ञान र प्रतिक्रिया प्राप्त गर्ने प्रक्रिया हो'' भने।\\n- क्रोनब्याकले ''अनुभवद्वारा व्यवहारमा आउने परिवर्तन नै सिकाइ हो'' भने।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''व्यवहारमा आउने उत्तरोत्तर अनुकूलनको प्रक्रिया (Progressive adaptation) नै सिकाइ हो'' भनी कसले परिभाषित गरेका छन्?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''सिकाइ नयाँ ज्ञान र प्रतिक्रिया प्राप्त गर्ने प्रक्रिया हो'' भन्ने परिभाषा कसको हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'''सिकाइ नयाँ ज्ञान र प्रतिक्रिया प्राप्त गर्ने प्रक्रिया हो'' भन्ने परिभाषा कसको हो?', E'वुडवर्थ (Woodworth)', E'स्किनर', E'हिलगार्ड', E'क्रोनब्याक', E'A', E'**''सिकाइ नयाँ ज्ञान र प्रतिक्रिया प्राप्त गर्ने प्रक्रिया हो'' भन्ने परिभाषा वुडवर्थ (Woodworth) को हो।**\\n- स्किनरले सिकाइलाई उत्तरोत्तर अनुकूलनको प्रक्रिया भने।\\n- हिलगार्डका अनुसार सिकाइ अभ्यास र तालिमद्वारा प्राप्त हुने व्यवहार हो।\\n- क्रोनब्याकले अनुभवद्वारा व्यवहारमा आउने परिवर्तनलाई सिकाइ भने।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''सिकाइ नयाँ ज्ञान र प्रतिक्रिया प्राप्त गर्ने प्रक्रिया हो'' भन्ने परिभाषा कसको हो?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सिकाइको मुख्य आधार कुन-कुन हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'सिकाइको मुख्य आधार कुन-कुन हुन्?', E'वंशाणुक्रम र जन्मजात स्वभाव', E'अभ्यास, अनुभव र परिपक्वता', E'शारीरिक आकार र तौल', E'उमेर र लिङ्ग मात्र', E'B', E'**सिकाइको मुख्य आधार अभ्यास, अनुभव र परिपक्वता हुन्।**\\nनोट: परिपक्वता सिकाइको आधार हो किनभने शारीरिक तथा मानसिक रूपमा परिपक्व नभई कुनै पनि नयाँ सीप सिक्न सकिँदैन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सिकाइको मुख्य आधार कुन-कुन हुन्?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सिकाइको स्वरूप कस्तो प्रक्रिया हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'सिकाइको स्वरूप कस्तो प्रक्रिया हो?', E'केवल मानसिक प्रक्रिया', E'केवल व्यावहारिक प्रक्रिया', E'मानसिक र व्यावहारिक दुवै प्रक्रिया', E'केवल शारीरिक प्रक्रिया', E'C', E'**सिकाइको स्वरूप मानसिक र व्यावहारिक दुवै प्रक्रिया हो।**\\nनोट: सिकाइले व्यवहारमा स्थायी प्रकृतिको परिवर्तन (नयाँ, सकारात्मक वा नकारात्मक) ल्याउँछ र यो उद्देश्यमूलक (Goal-oriented) हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सिकाइको स्वरूप कस्तो प्रक्रिया हो?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''सिकाइ अभ्यास र तालिमद्वारा प्राप्त हुने व्यवहार हो'' भन्ने परिभाषा कसको हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'''सिकाइ अभ्यास र तालिमद्वारा प्राप्त हुने व्यवहार हो'' भन्ने परिभाषा कसको हो?', E'हिलगार्ड (Hilgard)', E'गेट्स', E'स्किनर', E'वुडवर्थ', E'A', E'**''सिकाइ अभ्यास र तालिमद्वारा प्राप्त हुने व्यवहार हो'' भन्ने परिभाषा हिलगार्ड (Hilgard) को हो।**\\n- गेट्सले अनुभव र तालिमद्वारा व्यवहारमा आउने परिवर्तनलाई सिकाइ भने।\\n- स्किनरले उत्तरोत्तर अनुकूलनलाई सिकाइ भने।\\n- वुडवर्थले नयाँ ज्ञान प्राप्त गर्ने प्रक्रियालाई सिकाइ भने।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''सिकाइ अभ्यास र तालिमद्वारा प्राप्त हुने व्यवहार हो'' भन्ने परिभाषा कसको हो?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सिकाइ कस्तो प्रकृतिको प्रक्रिया हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'सिकाइ कस्तो प्रकृतिको प्रक्रिया हो?', E'एक्कासी हुने घटना', E'निरन्तर र जीवनपर्यन्त चल्ने प्रक्रिया', E'केवल बाल्यावस्थामा सीमित प्रक्रिया', E'केवल विद्यालयमा हुने प्रक्रिया', E'B', E'**सिकाइ निरन्तर र जीवनपर्यन्त चल्ने प्रक्रिया हो, एक्कासी हुने घटना होइन।**\\nनोट: सिकाइ प्रगतिशील, निरन्तर, जीवनपर्यन्त र सर्वव्यापी हुन्छ; यो विद्यालयभित्र मात्र नभई जीवनभर हुने प्रक्रिया हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सिकाइ कस्तो प्रकृतिको प्रक्रिया हो?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सिकाइ जन्मजात हो कि आर्जित (प्राप्त गरिने)?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'सिकाइ जन्मजात हो कि आर्जित (प्राप्त गरिने)?', E'जन्मजात प्रक्रिया', E'आर्जित प्रक्रिया', E'केवल वंशाणुगत', E'स्वतः हुने प्रक्रिया', E'B', E'**सिकाइ आर्जित (Acquired) प्रक्रिया हो।**\\nनोट: सिकाइ अभ्यास, अनुभव र तालिमबाट प्राप्त गरिने हुनाले यो आर्जित प्रक्रिया हो; यो जन्मजात वा वंशाणुगत स्वभाव होइन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सिकाइ जन्मजात हो कि आर्जित (प्राप्त गरिने)?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''शिक्षा'' शब्द संस्कृत भाषाको कुन धातुबाट बनेको हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'''शिक्षा'' शब्द संस्कृत भाषाको कुन धातुबाट बनेको हो?', E'''विद्'' धातु', E'''गम्'' धातु', E'''शिक्ष्'' धातु', E'''ज्ञा'' धातु', E'C', E'**''शिक्षा'' शब्द संस्कृत भाषाको ''शिक्ष्'' (Shiksh) धातुमा ''अ'' प्रत्यय लागेर बनेको हो, जसको अर्थ ''सिक्नु'' वा ''सिकाउनु'' हुन्छ।**\\nनोट: यसैले शिक्षा र सिकाइ अवधारणागत रूपमा घनिष्ठ रूपमा जोडिएका छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''शिक्षा'' शब्द संस्कृत भाषाको कुन धातुबाट बनेको हो?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सिकाइ सुनेर र देखेर भन्दा कसरी बढी प्रभावकारी हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'सिकाइ सुनेर र देखेर भन्दा कसरी बढी प्रभावकारी हुन्छ?', E'रटेर', E'गरेर (Learning by doing)', E'सुनेर मात्र', E'पढेर मात्र', E'B', E'**सिकाइ सुनेर र देखेर भन्दा गरेर (Learning by doing) बढी प्रभावकारी हुन्छ।**\\nनोट: सिकाइ आफैंले प्रयास गर्नुपर्ने कार्य हो; प्रत्यक्ष अनुभवबाट हुने सिकाइ अर्थपूर्ण र दीर्घकालीन हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सिकाइ सुनेर र देखेर भन्दा कसरी बढी प्रभावकारी हुन्छ?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सिकाइ प्रक्रियाको पहिलो खुड्किलो (चरण) कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'सिकाइ प्रक्रियाको पहिलो खुड्किलो (चरण) कुन हो?', E'अभिप्रेरणा (Motivation)', E'परिमार्जन', E'अनुभव', E'बाधा', E'A', E'**सिकाइ प्रक्रियाको पहिलो खुड्किलो अभिप्रेरणा (Motivation) हो।**\\nनोट: सिकाइ प्रक्रियाको क्रम अभिप्रेरणा → लक्ष्य → बाधा/अवरोध → क्रिया → अनुभव र तालिम → परिमार्जन हुँदै अघि बढ्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सिकाइ प्रक्रियाको पहिलो खुड्किलो (चरण) कुन हो?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सिकाइ प्रक्रियाको सही क्रम कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'सिकाइ प्रक्रियाको सही क्रम कुन हो?', E'अभिप्रेरणा → लक्ष्य → बाधा → क्रिया → अनुभव → परिमार्जन', E'लक्ष्य → अभिप्रेरणा → परिमार्जन → क्रिया → बाधा → अनुभव', E'परिमार्जन → अनुभव → क्रिया → बाधा → लक्ष्य → अभिप्रेरणा', E'क्रिया → बाधा → लक्ष्य → अभिप्रेरणा → अनुभव → परिमार्जन', E'A', E'**सिकाइ प्रक्रियाको सही क्रम: अभिप्रेरणा (Motivation) → लक्ष्य (Goal) → बाधा/अवरोध (Obstacle) → क्रिया (Action) → अनुभव र तालिम → परिमार्जन/परिवर्तन (Change) हो।**\\nनोट: अभिप्रेरणाले सिकारुलाई लक्ष्य प्राप्त गर्न सक्रिय बनाउने हुनाले यो पहिलो चरण हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सिकाइ प्रक्रियाको सही क्रम कुन हो?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सिकाइ कुन दिशामा हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'सिकाइ कुन दिशामा हुन्छ?', E'केवल Horizontal (समतलीय)', E'केवल Vertical (लम्बीय)', E'Horizontal र Vertical दुवै', E'कुनै निश्चित दिशा हुँदैन', E'C', E'**सिकाइ Horizontal (समतलीय) र Vertical (लम्बीय) दुवै दिशामा हुन्छ।**\\nनोट: समतलीय सिकाइ एउटै तहमा फैलिन्छ भने लम्बीय सिकाइ सरलबाट जटिलतर्फ माथि उक्लन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सिकाइ कुन दिशामा हुन्छ?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सिकाइ उत्प्रेरणाविना सम्भव छ कि छैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'सिकाइ उत्प्रेरणाविना सम्भव छ कि छैन?', E'सम्भव छ', E'सम्भव छैन', E'केवल वयस्कमा सम्भव छ', E'केवल बालकमा सम्भव छ', E'B', E'**सिकाइ उत्प्रेरणाविना सम्भव छैन।**\\nनोट: उत्प्रेरणाले सिकारुलाई लक्ष्य प्राप्त गर्न सक्रिय बनाउँछ र सिकाइको गतिलाई तीव्रता दिने हुनाले उत्प्रेरणा सिकाइको अनिवार्य तत्त्व हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सिकाइ उत्प्रेरणाविना सम्भव छ कि छैन?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''अनुभवद्वारा व्यवहारमा आउने परिवर्तन नै सिकाइ हो'' भन्ने परिभाषा कसको हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'''अनुभवद्वारा व्यवहारमा आउने परिवर्तन नै सिकाइ हो'' भन्ने परिभाषा कसको हो?', E'स्किनर', E'हिलगार्ड', E'क्रोनब्याक (Cronbach)', E'गेट्स', E'C', E'**''अनुभवद्वारा व्यवहारमा आउने परिवर्तन नै सिकाइ हो'' भन्ने परिभाषा क्रोनब्याक (Cronbach) को हो।**\\n- स्किनरले उत्तरोत्तर अनुकूलनलाई सिकाइ भने।\\n- हिलगार्डले अभ्यास र तालिमद्वारा प्राप्त व्यवहारलाई सिकाइ भने।\\n- गेट्सले अनुभव र तालिमद्वारा आउने परिवर्तनलाई सिकाइ भने।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''अनुभवद्वारा व्यवहारमा आउने परिवर्तन नै सिकाइ हो'' भन्ने परिभाषा कसको हो?'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'निम्नमध्ये कुन सिकाइको विशेषता होइन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'निम्नमध्ये कुन सिकाइको विशेषता होइन?', E'निरन्तर र जीवनपर्यन्त', E'उद्देश्यपूर्ण', E'जन्मजात र वंशाणुगत', E'अनुभवबाट आर्जित', E'C', E'**''जन्मजात र वंशाणुगत'' हुनु सिकाइको विशेषता होइन।**\\n- सिकाइ निरन्तर, जीवनपर्यन्त, उद्देश्यपूर्ण र अनुभवबाट आर्जित हुने हुन्छ।\\nनोट: सिकाइ अनुभव र अभ्यासबाट प्राप्त गरिने हुनाले यो जन्मजात होइन, आर्जित हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:निम्नमध्ये कुन सिकाइको विशेषता होइन?'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विकास (Development) कुन दुई प्रक्रियाको प्रतिफल हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'विकास (Development) कुन दुई प्रक्रियाको प्रतिफल हो?', E'परिपक्वता र सिकाइ', E'वृद्धि र पोषण', E'वंशाणुक्रम र उमेर', E'अभ्यास र आहार', E'A', E'**विकास परिपक्वता र सिकाइ (Maturation and Learning) को प्रतिफल हो।**\\nनोट: परिपक्वता र सिकाइ मानव विकासका दुई प्रमुख प्रक्रिया हुन्; सिकाइ अवसरको कमीले विकासलाई सीमित बनाउँछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विकास (Development) कुन दुई प्रक्रियाको प्रतिफल हो?'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सिकाइलाई ''व्यवहारमा हुने चेतनापूर्ण परिवर्तन'' भन्नुको मुख्य आशय के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'सिकाइलाई ''व्यवहारमा हुने चेतनापूर्ण परिवर्तन'' भन्नुको मुख्य आशय के हो?', E'अचेतन अवस्थामा हुने परिवर्तन', E'होस र चेतनासहित हुने व्यवहार परिवर्तन', E'शारीरिक आकारमा हुने वृद्धि', E'वंशाणुगत गुणको हस्तान्तरण', E'B', E'**सिकाइ भनेको होस र चेतनासहित हुने व्यवहारको परिवर्तन हो।**\\nनोट: सिकाइ चेतनापूर्ण मस्तिष्कको उपज हो; यो अचेतन अवस्थामा स्वतः हुने परिपक्वताभन्दा फरक छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सिकाइलाई ''व्यवहारमा हुने चेतनापूर्ण परिवर्तन'' भन्नुको मुख्य आशय के हो?'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सिकाइअन्तर्गत हुने व्यवहार परिवर्तनमा मुख्यतया कुन-कुन परिवर्तन पर्दछन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 20, E'सिकाइअन्तर्गत हुने व्यवहार परिवर्तनमा मुख्यतया कुन-कुन परिवर्तन पर्दछन्?', E'ज्ञान, सीप र प्रवृत्तिमा परिवर्तन', E'उचाइ, तौल र आकारमा परिवर्तन', E'रङ, रूप र आकृतिमा परिवर्तन', E'वंश, जाति र वर्गमा परिवर्तन', E'A', E'**सिकाइअन्तर्गत हुने व्यवहार परिवर्तनमा ज्ञान, सीप र प्रवृत्तिमा परिवर्तन पर्दछन्।**\\nनोट: उचाइ, तौल र आकारमा हुने परिवर्तन भने वृद्धि (Growth) अन्तर्गत पर्छ, सिकाइ होइन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सिकाइअन्तर्गत हुने व्यवहार परिवर्तनमा मुख्यतया कुन-कुन परिवर्तन पर्दछन्?'), v_set_id, v_q_id, 20)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: सिकाइमा प्रभाव पार्ने तत्त्वहरू (आधारभूत तह) (20 Q)
  v_set_id := extensions.uuid_generate_v5('1321484b-4aed-477a-8d70-b5d735dedd94'::uuid, E'सिकाइमा प्रभाव पार्ने तत्त्वहरू (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '4752098a-e0df-497d-a58a-61d08d4c6814'::uuid, '1321484b-4aed-477a-8d70-b5d735dedd94'::uuid, E'सिकाइमा प्रभाव पार्ने तत्त्वहरू (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '1321484b-4aed-477a-8d70-b5d735dedd94'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'उत्प्रेरणा (Motivation) सिकाइलाई प्रभाव पार्ने कस्तो तत्त्व हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'उत्प्रेरणा (Motivation) सिकाइलाई प्रभाव पार्ने कस्तो तत्त्व हो?', E'आन्तरिक (सिकारुसँग सम्बन्धित) तत्त्व', E'बाह्य (वातावरणसँग सम्बन्धित) तत्त्व', E'विषयवस्तुसँग सम्बन्धित तत्त्व', E'विधिसँग सम्बन्धित तत्त्व', E'A', E'**उत्प्रेरणा सिकाइलाई प्रभाव पार्ने आन्तरिक (सिकारुसँग सम्बन्धित) तत्त्व हो।**\\n- शिक्षण विधि र वातावरण भने बाह्य तत्त्व हुन्।\\nनोट: सिकारुसँग सम्बन्धित आन्तरिक तत्त्वमा शारीरिक/मानसिक स्वास्थ्य, उमेर, रुचि र बुद्ध्याङ्क पर्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:उत्प्रेरणा (Motivation) सिकाइलाई प्रभाव पार्ने कस्तो तत्त्व हो?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'निम्नमध्ये कुन सिकाइलाई प्रभाव पार्ने सिकारुसँग सम्बन्धित (आन्तरिक) तत्त्व हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'निम्नमध्ये कुन सिकाइलाई प्रभाव पार्ने सिकारुसँग सम्बन्धित (आन्तरिक) तत्त्व हो?', E'कक्षाकोठाको भौतिक वातावरण', E'शिक्षकको व्यवहार', E'बुद्ध्याङ्क (Intelligence) र परिपक्वता', E'शैक्षिक सामग्रीको उपलब्धता', E'C', E'**बुद्ध्याङ्क (Intelligence) र परिपक्वता सिकाइलाई प्रभाव पार्ने सिकारुसँग सम्बन्धित (आन्तरिक) तत्त्व हुन्।**\\n- कक्षाकोठाको भौतिक वातावरण र शिक्षकको व्यवहार वातावरणसँग सम्बन्धित तत्त्व हुन्।\\n- शैक्षिक सामग्री विषयवस्तु/विधिसँग सम्बन्धित तत्त्व हो।\\nनोट: सिकारुसँग सम्बन्धित तत्त्वमा शारीरिक/मानसिक स्वास्थ्य, उमेर, रुचि र उत्प्रेरणा पनि पर्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:निम्नमध्ये कुन सिकाइलाई प्रभाव पार्ने सिकारुसँग सम्बन्धित (आन्तरिक) तत्त्व हो?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'निम्नमध्ये कुन सिकाइलाई प्रभाव पार्ने वातावरणसँग सम्बन्धित तत्त्व हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'निम्नमध्ये कुन सिकाइलाई प्रभाव पार्ने वातावरणसँग सम्बन्धित तत्त्व हो?', E'सिकारुको बुद्ध्याङ्क', E'पारिवारिक र सामाजिक परिवेश', E'सिकारुको उमेर', E'सिकारुको रुचि', E'B', E'**पारिवारिक र सामाजिक परिवेश सिकाइलाई प्रभाव पार्ने वातावरणसँग सम्बन्धित तत्त्व हो।**\\n- सिकारुको बुद्ध्याङ्क, उमेर र रुचि भने आन्तरिक (सिकारुसँग सम्बन्धित) तत्त्व हुन्।\\nनोट: वातावरणसँग सम्बन्धित तत्त्वमा कक्षाकोठाको भौतिक वातावरण र शिक्षक तथा सहपाठीको व्यवहार पनि पर्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:निम्नमध्ये कुन सिकाइलाई प्रभाव पार्ने वातावरणसँग सम्बन्धित तत्त्व हो?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सिकाइको सबैभन्दा मुख्य आधार के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'सिकाइको सबैभन्दा मुख्य आधार के हो?', E'अभ्यास र अनुभव', E'बुद्धि', E'उमेर', E'वंशाणुक्रम', E'A', E'**सिकाइको सबैभन्दा मुख्य आधार अभ्यास र अनुभव हो।**\\nनोट: बुद्धिले सिकाइमा मद्दत गर्छ तर यो मुख्य आधार होइन; अभ्यास र अनुभवबिना सिकाइ हुन सक्दैन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सिकाइको सबैभन्दा मुख्य आधार के हो?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'परिपक्वता (Maturity) सिकाइका लागि किन आवश्यक छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'परिपक्वता (Maturity) सिकाइका लागि किन आवश्यक छ?', E'परिपक्वताले उमेर घटाउने हुनाले', E'शारीरिक तथा मानसिक रूपमा परिपक्व नभई नयाँ सीप सिक्न नसकिने हुनाले', E'परिपक्वताले अभ्यासको आवश्यकता हटाउने हुनाले', E'परिपक्वताले उत्प्रेरणा घटाउने हुनाले', E'B', E'**परिपक्वता सिकाइका लागि आवश्यक छ किनभने शारीरिक तथा मानसिक रूपमा परिपक्व नभई कुनै पनि नयाँ सीप सिक्न सकिँदैन।**\\nनोट: यसैले परिपक्वता र सिकाइ एकअर्कासँग जोडिएका छन्; परिपक्वता सिकाइको आधार हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:परिपक्वता (Maturity) सिकाइका लागि किन आवश्यक छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'निम्नमध्ये कुन सिकाइलाई प्रभाव पार्ने विषयवस्तु तथा विधिसँग सम्बन्धित तत्त्व हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'निम्नमध्ये कुन सिकाइलाई प्रभाव पार्ने विषयवस्तु तथा विधिसँग सम्बन्धित तत्त्व हो?', E'सिकारुको स्वास्थ्य', E'पारिवारिक परिवेश', E'शिक्षण विधि र अभ्यास (Repetition)', E'सिकारुको उत्प्रेरणा', E'C', E'**शिक्षण विधि र अभ्यास (Repetition) सिकाइलाई प्रभाव पार्ने विषयवस्तु तथा विधिसँग सम्बन्धित तत्त्व हो।**\\n- सिकारुको स्वास्थ्य र उत्प्रेरणा आन्तरिक तत्त्व हुन्।\\n- पारिवारिक परिवेश वातावरणसँग सम्बन्धित तत्त्व हो।\\nनोट: विषयवस्तु/विधिसँग सम्बन्धित तत्त्वमा विषयवस्तुको प्रकृति र शैक्षिक सामग्रीको उपलब्धता पनि पर्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:निम्नमध्ये कुन सिकाइलाई प्रभाव पार्ने विषयवस्तु तथा विधिसँग सम्बन्धित तत्त्व हो?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सिकाइमा बुद्धि (Intelligence) को भूमिका कस्तो हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'सिकाइमा बुद्धि (Intelligence) को भूमिका कस्तो हुन्छ?', E'मुख्य आधार हुन्छ', E'मद्दत गर्छ तर मुख्य आधार होइन', E'कुनै भूमिका हुँदैन', E'अभ्यासलाई प्रतिस्थापन गर्छ', E'B', E'**सिकाइमा बुद्धिले मद्दत गर्छ तर यो मुख्य आधार होइन।**\\nनोट: सिकाइको सबैभन्दा मुख्य आधार अभ्यास र अनुभव हो; बुद्धिले सिकाइलाई सहज बनाउँछ तर अभ्यासको विकल्प बन्न सक्दैन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सिकाइमा बुद्धि (Intelligence) को भूमिका कस्तो हुन्छ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सिकारुको रुचि, उमेर, लिङ्ग र स्वास्थ्य स्थिति कुन प्रकारका तत्त्वमा पर्छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'सिकारुको रुचि, उमेर, लिङ्ग र स्वास्थ्य स्थिति कुन प्रकारका तत्त्वमा पर्छन्?', E'व्यक्तिगत तत्त्व', E'वातावरणीय तत्त्व', E'सामाजिक तत्त्व', E'भौतिक तत्त्व', E'A', E'**सिकारुको रुचि, उमेर, लिङ्ग र स्वास्थ्य स्थिति व्यक्तिगत तत्त्वमा पर्छन्।**\\nनोट: शिक्षण सिकाइ प्रक्रियाको केन्द्रविन्दु स्वयम् विद्यार्थी हुने हुनाले यी व्यक्तिगत तत्त्वले सिकाइमा प्रत्यक्ष प्रभाव पार्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सिकारुको रुचि, उमेर, लिङ्ग र स्वास्थ्य स्थिति कुन प्रकारका तत्त्वमा पर्छन्?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'मानसिक तत्त्व (Mental factor) भन्नाले मुख्यतया के बुझिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'मानसिक तत्त्व (Mental factor) भन्नाले मुख्यतया के बुझिन्छ?', E'व्यक्तिको शारीरिक बनावट', E'व्यक्तिको मस्तिष्कले गर्ने सिकाइको क्षमता', E'व्यक्तिको पारिवारिक अवस्था', E'व्यक्तिको आर्थिक स्थिति', E'B', E'**मानसिक तत्त्व भन्नाले व्यक्तिको मस्तिष्कले गर्ने सिकाइको क्षमतालाई बुझाउँछ।**\\nनोट: तीक्ष्ण, मध्यम वा सुस्त मानसिक क्षमता, तथा तर्क, कल्पना र विश्लेषण क्षमता मानसिक तत्त्वअन्तर्गत पर्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:मानसिक तत्त्व (Mental factor) भन्नाले मुख्यतया के बुझिन्छ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षण सिकाइ प्रक्रियाको केन्द्रविन्दु को हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'शिक्षण सिकाइ प्रक्रियाको केन्द्रविन्दु को हो?', E'शिक्षक', E'स्वयम् विद्यार्थी', E'पाठ्यपुस्तक', E'अभिभावक', E'B', E'**शिक्षण सिकाइ प्रक्रियाको केन्द्रविन्दु स्वयम् विद्यार्थी हुन्।**\\nनोट: यसैले सिकाइ सहजीकरण क्रियाकलाप विद्यार्थीको रुचि, क्षमता र आवश्यकतालाई केन्द्रमा राखेर सञ्चालन गर्नुपर्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षण सिकाइ प्रक्रियाको केन्द्रविन्दु को हो?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सिकाइ सहजीकरण विधि छनोट गर्दा बालमनोविज्ञानले मुख्यतया केमा ध्यान दिन सुझाव दिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'सिकाइ सहजीकरण विधि छनोट गर्दा बालमनोविज्ञानले मुख्यतया केमा ध्यान दिन सुझाव दिन्छ?', E'शिक्षकको तलब र सुविधा', E'सिकारुको रुचि, क्षमता र पूर्वज्ञान', E'विद्यालयको भौतिक भवन', E'पाठ्यपुस्तकको मूल्य', E'B', E'**सिकाइ सहजीकरण विधि छनोटमा बालमनोविज्ञानले सिकारुको इच्छा, रुचि, क्षमता, प्रवृत्ति र पूर्वज्ञानमा ध्यान दिन सुझाव दिन्छ।**\\nनोट: विधि छनोटमा सक्षमता, सिकाइ उपलब्धि, विषयवस्तुको स्वरूप, स्रोत-साधन र समय-विद्यार्थी संख्याले पनि प्रभाव पार्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सिकाइ सहजीकरण विधि छनोट गर्दा बालमनोविज्ञानले मुख्यतया केमा ध्यान दिन सुझाव दिन्छ?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शैक्षिक सामग्रीको प्रयोगले सिकाइमा कस्तो प्रभाव पार्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'शैक्षिक सामग्रीको प्रयोगले सिकाइमा कस्तो प्रभाव पार्छ?', E'सिकाइलाई अमूर्त र कठिन बनाउँछ', E'सिकाइलाई अर्थपूर्ण र दीर्घकालीन बनाउँछ', E'सिकाइलाई छोटो र अस्थायी बनाउँछ', E'सिकाइमा कुनै प्रभाव पार्दैन', E'B', E'**शैक्षिक सामग्रीको प्रयोगले सिकाइलाई अर्थपूर्ण र दीर्घकालीन बनाउँछ।**\\nनोट: सामग्रीको प्रयोगले विद्यार्थीलाई प्रत्यक्ष हेराइ र गराइबाट अनुभव प्राप्त हुने हुनाले सिकाइ स्पष्ट र दिगो हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शैक्षिक सामग्रीको प्रयोगले सिकाइमा कस्तो प्रभाव पार्छ?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यार्थीको विविधता व्यवस्थापन गर्न शिक्षकले मुख्यतया के पहिचान गर्नुपर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'विद्यार्थीको विविधता व्यवस्थापन गर्न शिक्षकले मुख्यतया के पहिचान गर्नुपर्छ?', E'विद्यार्थीको पारिवारिक सम्पत्ति', E'विद्यार्थीको सिकाइको गति, शैली, क्षमता र बहुबौद्धिकता', E'विद्यार्थीको जात र वर्ग', E'विद्यार्थीको शारीरिक उचाइ', E'B', E'**विविधता व्यवस्थापन गर्न शिक्षकले विद्यार्थीको सिकाइको गति, सिकाइ शैली, सिकाइ क्षमता र बहुबौद्धिकता पहिचान गर्नुपर्छ।**\\nनोट: बहुबौद्धिकता पहिचान गरी सोहीअनुसारको शिक्षण सिकाइ क्रियाकलाप चयन गर्नाले सबै विद्यार्थीको सिकाइ प्रभावकारी हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यार्थीको विविधता व्यवस्थापन गर्न शिक्षकले मुख्यतया के पहिचान गर्नुपर्छ?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कक्षाकोठा व्यवस्थापनलाई किन उत्तम सिकाइको पूर्वसर्त मानिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'कक्षाकोठा व्यवस्थापनलाई किन उत्तम सिकाइको पूर्वसर्त मानिन्छ?', E'यसले शिक्षकको कार्यबोझ बढाउने हुनाले', E'यसले प्रभावकारी शिक्षण-सिकाइका लागि उचित वातावरण सिर्जना गर्ने हुनाले', E'यसले परीक्षा सजिलो बनाउने हुनाले', E'यसले पाठ्यक्रम छोटो बनाउने हुनाले', E'B', E'**कक्षाकोठा व्यवस्थापनलाई उत्तम सिकाइको पूर्वसर्त मानिन्छ किनभने यसले शिक्षक र विद्यार्थीबीच प्रभावकारी शिक्षण-सिकाइ सञ्चालन गर्न उचित सिकाइ वातावरण सिर्जना गर्छ।**\\nनोट: यसमा भौतिक व्यवस्थापनसँगै मनोवैज्ञानिक र विविधता व्यवस्थापनलाई पनि ध्यान दिनुपर्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कक्षाकोठा व्यवस्थापनलाई किन उत्तम सिकाइको पूर्वसर्त मानिन्छ?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सिकाइमा अभ्यास (Repetition) को मुख्य भूमिका के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'सिकाइमा अभ्यास (Repetition) को मुख्य भूमिका के हो?', E'दोहोर्‍याएर सिकाइलाई बलियो बनाउने', E'सिकाइलाई छोटो बनाउने', E'उत्प्रेरणा घटाउने', E'विस्मरण बढाउने', E'A', E'**सिकाइमा अभ्यास (Repetition) ले दोहोर्‍याएर सिकाइलाई बलियो बनाउँछ।**\\nनोट: पटक-पटक विषयवस्तु दोहोर्‍याउनुलाई अभ्यास भनिन्छ; थर्नडाइकको प्रयोगको नियमअनुसार पनि अभ्यासले सिकाइ दृढ बनाउँछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सिकाइमा अभ्यास (Repetition) को मुख्य भूमिका के हो?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सिकाइलाई प्रभावकारी र दिगो बनाउन सिकाइ कस्तो हुनुपर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'सिकाइलाई प्रभावकारी र दिगो बनाउन सिकाइ कस्तो हुनुपर्छ?', E'रटानमा आधारित', E'व्यावहारिक जीवनसँग मेल खाने', E'केवल सैद्धान्तिक', E'केवल परीक्षाकेन्द्रित', E'B', E'**सिकाइ व्यावहारिक जीवनसँग मेल खाएमा सिकाइ प्रभावकारी र दिगो हुन्छ।**\\nनोट: सिकाइ प्रक्रिया सैद्धान्तिक पक्षमा भन्दा बढी ''गरेर सिक्ने'' क्रियाकलापमा आधारित हुनुपर्छ, जसले सिकाइलाई दीर्घकालीन बनाउँछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सिकाइलाई प्रभावकारी र दिगो बनाउन सिकाइ कस्तो हुनुपर्छ?'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'थकावट, कार्यबोझ र स्वास्थ्य अवस्था सिकाइलाई प्रभाव पार्ने कुन प्रकारका तत्त्व हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'थकावट, कार्यबोझ र स्वास्थ्य अवस्था सिकाइलाई प्रभाव पार्ने कुन प्रकारका तत्त्व हुन्?', E'संवेगात्मक तत्त्व', E'विषयवस्तुसँग सम्बन्धित तत्त्व', E'भौतिक पूर्वाधार', E'वंशाणुगत तत्त्व', E'A', E'**थकावट, कार्यबोझ, पारिवारिक र सामाजिक परिवेश तथा स्वास्थ्य अवस्था सिकाइलाई प्रभाव पार्ने संवेगात्मक तत्त्व हुन्।**\\nनोट: संवेगात्मक अवस्थाले सिकारुको एकाग्रता र सिकाइ क्षमतामा प्रत्यक्ष असर पार्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:थकावट, कार्यबोझ र स्वास्थ्य अवस्था सिकाइलाई प्रभाव पार्ने कुन प्रकारका तत्त्व हुन्?'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सिकाइ सहजीकरण प्रक्रिया सञ्चालन गर्दा कुन विधिमा जोड दिनुपर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'सिकाइ सहजीकरण प्रक्रिया सञ्चालन गर्दा कुन विधिमा जोड दिनुपर्छ?', E'शिक्षककेन्द्रित र व्याख्यानमुखी विधि', E'विद्यार्थीकेन्द्रित र बालमैत्री विधि', E'केवल रटान विधि', E'केवल परीक्षा अभ्यास', E'B', E'**सिकाइ सहजीकरण प्रक्रिया सञ्चालन गर्दा विद्यार्थीकेन्द्रित र बालमैत्री शिक्षण विधि अपनाउनुपर्छ।**\\nनोट: शिक्षणमा भन्दा निरन्तर सिकाइमा जोड दिँदै सबै सिकाइ आवश्यकता भएका विद्यार्थीलाई समेट्ने समावेशी सहजीकरण प्रक्रिया अपनाउनुपर्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सिकाइ सहजीकरण प्रक्रिया सञ्चालन गर्दा कुन विधिमा जोड दिनुपर्छ?'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'घरपरिवार, विद्यालय, टोल र छिमेकको परिवेश सिकाइलाई प्रभाव पार्ने कस्ता तत्त्व हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'घरपरिवार, विद्यालय, टोल र छिमेकको परिवेश सिकाइलाई प्रभाव पार्ने कस्ता तत्त्व हुन्?', E'व्यक्तिगत तत्त्व', E'मानसिक तत्त्व', E'वातावरणीय तत्त्व', E'वंशाणुगत तत्त्व', E'C', E'**घरपरिवार, विद्यालय, टोल र छिमेक वा समुदायको परिवेश सिकाइलाई प्रभाव पार्ने वातावरणीय तत्त्व हुन्।**\\nनोट: विद्यालयको आन्तरिक र बाह्य वातावरण तथा पारिवारिक वातावरण गरी यी तीन तत्त्वले शैक्षिक सिकाइ वातावरणलाई प्रभाव पार्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:घरपरिवार, विद्यालय, टोल र छिमेकको परिवेश सिकाइलाई प्रभाव पार्ने कस्ता तत्त्व हुन्?'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सिकाइमा उत्प्रेरणाको मुख्य भूमिका के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 20, E'सिकाइमा उत्प्रेरणाको मुख्य भूमिका के हो?', E'सिकारुलाई निष्क्रिय बनाउने', E'सिकारुलाई लक्ष्य प्राप्त गर्न सक्रिय बनाई सिकाइको गति तीव्र पार्ने', E'सिकाइको अवधि छोट्याउने', E'सिकाइलाई कठिन बनाउने', E'B', E'**सिकाइमा उत्प्रेरणाले सिकारुलाई लक्ष्य प्राप्त गर्न सक्रिय बनाउँछ र सिकाइको गतिलाई तीव्रता दिन्छ।**\\nनोट: उत्प्रेरणाले सिकाइका लागि आवश्यक वातावरण सिर्जना गर्ने हुनाले उत्प्रेरणाबिना सिकाइ सम्भव हुँदैन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सिकाइमा उत्प्रेरणाको मुख्य भूमिका के हो?'), v_set_id, v_q_id, 20)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: सिकाइ स्थानान्तरण, स्मृति र विस्मरण (आधारभूत तह) (20 Q)
  v_set_id := extensions.uuid_generate_v5('3a6a4d23-5a26-4387-bfff-8a6deb23a094'::uuid, E'सिकाइ स्थानान्तरण, स्मृति र विस्मरण (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '4752098a-e0df-497d-a58a-61d08d4c6814'::uuid, '3a6a4d23-5a26-4387-bfff-8a6deb23a094'::uuid, E'सिकाइ स्थानान्तरण, स्मृति र विस्मरण (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '3a6a4d23-5a26-4387-bfff-8a6deb23a094'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सिकाइ स्थानान्तरण (Transfer of Learning) भनेको के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'सिकाइ स्थानान्तरण (Transfer of Learning) भनेको के हो?', E'एक विद्यालयबाट अर्को विद्यालयमा भर्ना सर्नु', E'पहिले सिकेको ज्ञान वा सीप नयाँ ज्ञान/सीप सिक्न प्रयोग गर्नु', E'शिक्षकले विषय फेर्नु', E'पाठ्यक्रम परिवर्तन गर्नु', E'B', E'**सिकाइ स्थानान्तरण भनेको पहिले सिकेको कुरा अर्को नयाँ ज्ञान वा सीप सिक्ने स्थितिमा प्रयोग गर्नु हो।**\\nनोट: यसले एउटा परिस्थितिमा सिकेको कुरालाई अर्को परिस्थितिमा लागू गर्ने क्षमतालाई जनाउँछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सिकाइ स्थानान्तरण (Transfer of Learning) भनेको के हो?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'एक विषयको सिकाइले अर्को विषयको सिकाइमा प्रत्यक्ष सहयोग पुर्‍याउने स्थानान्तरणलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'एक विषयको सिकाइले अर्को विषयको सिकाइमा प्रत्यक्ष सहयोग पुर्‍याउने स्थानान्तरणलाई के भनिन्छ?', E'सकारात्मक स्थानान्तरण', E'नकारात्मक स्थानान्तरण', E'शून्य स्थानान्तरण', E'लम्बीय स्थानान्तरण', E'A', E'**एक विषयको सिकाइले अर्को विषयको सिकाइमा प्रत्यक्ष सहयोग पुर्‍याउने स्थानान्तरणलाई सकारात्मक स्थानान्तरण (Positive Transfer) भनिन्छ।**\\n- नकारात्मक स्थानान्तरणमा एक सिकाइले अर्कोमा बाधा पुर्‍याउँछ।\\n- शून्य स्थानान्तरणमा न सहयोग न अवरोध हुन्छ।\\nनोट: जस्तै, गणित राम्ररी सिकेको विद्यार्थीलाई भौतिकशास्त्र सिक्न सजिलो हुनु सकारात्मक स्थानान्तरण हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:एक विषयको सिकाइले अर्को विषयको सिकाइमा प्रत्यक्ष सहयोग पुर्‍याउने स्थानान्तरणलाई के भनिन्छ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'एउटा सिकाइको अवस्थाले अर्को सिकाइमा बाधा उत्पन्न गर्ने स्थानान्तरणलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'एउटा सिकाइको अवस्थाले अर्को सिकाइमा बाधा उत्पन्न गर्ने स्थानान्तरणलाई के भनिन्छ?', E'सकारात्मक स्थानान्तरण', E'नकारात्मक स्थानान्तरण', E'शून्य स्थानान्तरण', E'द्विपक्षीय स्थानान्तरण', E'B', E'**एउटा सिकाइको अवस्थाले अर्को सिकाइमा बाधा उत्पन्न गर्ने स्थानान्तरणलाई नकारात्मक स्थानान्तरण (Negative Transfer) भनिन्छ।**\\n- सकारात्मक स्थानान्तरणमा भने एक सिकाइले अर्कोलाई सहयोग गर्छ।\\nनोट: पुरानो बानीले नयाँ सीप सिक्न बाधा पुर्‍याउँदा नकारात्मक स्थानान्तरण हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:एउटा सिकाइको अवस्थाले अर्को सिकाइमा बाधा उत्पन्न गर्ने स्थानान्तरणलाई के भनिन्छ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'एक विषयको सिकाइले अर्को विषयमा न सहयोग न अवरोध गर्ने अवस्थालाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'एक विषयको सिकाइले अर्को विषयमा न सहयोग न अवरोध गर्ने अवस्थालाई के भनिन्छ?', E'सकारात्मक स्थानान्तरण', E'नकारात्मक स्थानान्तरण', E'शून्य स्थानान्तरण', E'समतलीय स्थानान्तरण', E'C', E'**एक विषयको सिकाइले अर्को विषयमा न सहयोग न अवरोध गर्ने अवस्थालाई शून्य स्थानान्तरण (Zero Transfer) भनिन्छ।**\\n- सकारात्मक स्थानान्तरणले सहयोग गर्छ भने नकारात्मक स्थानान्तरणले बाधा पुर्‍याउँछ।\\nनोट: दुई विषयबीच कुनै साझा तत्त्व नहुँदा प्रायः शून्य स्थानान्तरण हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:एक विषयको सिकाइले अर्को विषयमा न सहयोग न अवरोध गर्ने अवस्थालाई के भनिन्छ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सामान्य सिकाइबाट विशेष ज्ञान वा सीपतर्फ हुने स्थानान्तरणलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'सामान्य सिकाइबाट विशेष ज्ञान वा सीपतर्फ हुने स्थानान्तरणलाई के भनिन्छ?', E'समतलीय (Horizontal) स्थानान्तरण', E'लम्बीय (Vertical) स्थानान्तरण', E'शून्य स्थानान्तरण', E'नकारात्मक स्थानान्तरण', E'B', E'**सामान्य सिकाइबाट विशेष ज्ञान वा सीपतर्फ हुने स्थानान्तरणलाई लम्बीय (Vertical) स्थानान्तरण भनिन्छ।**\\n- समतलीय स्थानान्तरणमा भने एउटै तह वा मिल्दो विषय/व्यवहारबीच स्थानान्तरण हुन्छ।\\nनोट: लम्बीय स्थानान्तरण सरलबाट जटिलतर्फ माथि उक्लने प्रकृतिको हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सामान्य सिकाइबाट विशेष ज्ञान वा सीपतर्फ हुने स्थानान्तरणलाई के भनिन्छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'एउटै तह वा मिल्दो विषय/व्यवहारबीच हुने स्थानान्तरणलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'एउटै तह वा मिल्दो विषय/व्यवहारबीच हुने स्थानान्तरणलाई के भनिन्छ?', E'समतलीय (Horizontal) स्थानान्तरण', E'लम्बीय (Vertical) स्थानान्तरण', E'नकारात्मक स्थानान्तरण', E'शून्य स्थानान्तरण', E'A', E'**एउटै तह वा मिल्दो विषय/व्यवहारबीच हुने स्थानान्तरणलाई समतलीय (Horizontal) स्थानान्तरण भनिन्छ।**\\n- लम्बीय स्थानान्तरणमा भने सामान्यबाट विशेष ज्ञानतर्फ स्थानान्तरण हुन्छ।\\nनोट: समान कठिनाइ तहका दुई विषयबीच हुने स्थानान्तरण समतलीय हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:एउटै तह वा मिल्दो विषय/व्यवहारबीच हुने स्थानान्तरणलाई के भनिन्छ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'एक पक्षको सिकाइले अर्को पक्षको सिकाइमा सहयोग गर्ने (जस्तै दुवै हातले टाइप गर्न सिक्ने) स्थानान्तरणलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'एक पक्षको सिकाइले अर्को पक्षको सिकाइमा सहयोग गर्ने (जस्तै दुवै हातले टाइप गर्न सिक्ने) स्थानान्तरणलाई के भनिन्छ?', E'शून्य स्थानान्तरण', E'द्विपक्षीय स्थानान्तरण', E'नकारात्मक स्थानान्तरण', E'समतलीय स्थानान्तरण', E'B', E'**एक पक्षको सिकाइले अर्को पक्षको सिकाइमा सहयोग गर्ने स्थानान्तरणलाई द्विपक्षीय स्थानान्तरण (Bilateral Transfer) भनिन्छ।**\\nनोट: जस्तै, एक हातले टाइप गर्न सिकेपछि अर्को हातले पनि सजिलै टाइप गर्न सक्नु द्विपक्षीय स्थानान्तरण हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:एक पक्षको सिकाइले अर्को पक्षको सिकाइमा सहयोग गर्ने (जस्तै दुवै हातले टाइप गर्न सिक्ने) स्थानान्तरणलाई के भनिन्छ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुन सिद्धान्तअनुसार सिकाइ स्थानान्तरणको मात्रा विषयवस्तुको समानतामा निर्भर हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'कुन सिद्धान्तअनुसार सिकाइ स्थानान्तरणको मात्रा विषयवस्तुको समानतामा निर्भर हुन्छ?', E'मानसिक अनुशासनको सिद्धान्त', E'समतत्त्वको सिद्धान्त (Theory of Identical Elements)', E'सामान्यीकरणको सिद्धान्त', E'दमनको सिद्धान्त', E'B', E'**सिकाइ स्थानान्तरणको मात्रा विषयवस्तुको समानतामा निर्भर हुन्छ भन्ने सिद्धान्त समतत्त्वको सिद्धान्त (Theory of Identical Elements) हो।**\\n- मानसिक अनुशासनको सिद्धान्तअनुसार जुनसुकै सिकाइले मस्तिष्कलाई अनुशासित बनाउँछ।\\n- सामान्यीकरणको सिद्धान्तले सिकेको कुरालाई सामान्यीकरण गरी लागू गर्ने कुरामा जोड दिन्छ।\\nनोट: जति बढी साझा तत्त्व हुन्छ, त्यति बढी स्थानान्तरण हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुन सिद्धान्तअनुसार सिकाइ स्थानान्तरणको मात्रा विषयवस्तुको समानतामा निर्भर हुन्छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुन सिद्धान्तअनुसार जुनसुकै सिकाइले मस्तिष्कका विभिन्न विभागलाई अनुशासित र सक्षम तुल्याउँछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'कुन सिद्धान्तअनुसार जुनसुकै सिकाइले मस्तिष्कका विभिन्न विभागलाई अनुशासित र सक्षम तुल्याउँछ?', E'समतत्त्वको सिद्धान्त', E'मानसिक अनुशासनको सिद्धान्त', E'हस्तक्षेपको सिद्धान्त', E'दमनको सिद्धान्त', E'B', E'**जुनसुकै सिकाइले मस्तिष्कका विभिन्न विभागलाई अनुशासित र सक्षम तुल्याउँछ भन्ने सिद्धान्त मानसिक अनुशासनको सिद्धान्त (Theory of Mental Discipline) हो।**\\n- समतत्त्वको सिद्धान्तले भने स्थानान्तरणलाई विषयवस्तुको समानतासँग जोड्छ।\\nनोट: यो सिद्धान्तअनुसार मस्तिष्कलाई व्यायाम गराए जसरी सिकाइले अनुशासित बनाउँछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुन सिद्धान्तअनुसार जुनसुकै सिकाइले मस्तिष्कका विभिन्न विभागलाई अनुशासित र सक्षम तुल्याउँछ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सामान्य र विशिष्ट अंशको सिद्धान्तअनुसार सिकाइ स्थानान्तरण केमा निर्भर हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'सामान्य र विशिष्ट अंशको सिद्धान्तअनुसार सिकाइ स्थानान्तरण केमा निर्भर हुन्छ?', E'जति बढी साझा तत्त्व, त्यति बढी स्थानान्तरण', E'जति कम साझा तत्त्व, त्यति बढी स्थानान्तरण', E'विषयको कठिनाइमा मात्र', E'सिकारुको उमेरमा मात्र', E'A', E'**सामान्य र विशिष्ट अंशको सिद्धान्तअनुसार जति बढी साझा तत्त्व हुन्छ, त्यति धेरै सिकाइ स्थानान्तरण हुन्छ।**\\nनोट: यो समतत्त्वको सिद्धान्तसँग मिल्दोजुल्दो छ — दुई विषयबीच जति समानता हुन्छ, त्यति सजिलो स्थानान्तरण हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सामान्य र विशिष्ट अंशको सिद्धान्तअनुसार सिकाइ स्थानान्तरण केमा निर्भर हुन्छ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'स्मृति प्रक्रिया (R.C.S.R.) को सही क्रम कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'स्मृति प्रक्रिया (R.C.S.R.) को सही क्रम कुन हो?', E'पुनर्प्राप्ति → भण्डार → सङ्केतन → प्राप्ति', E'प्राप्ति → सङ्केतन → भण्डार → पुनर्प्राप्ति', E'सङ्केतन → प्राप्ति → पुनर्प्राप्ति → भण्डार', E'भण्डार → प्राप्ति → सङ्केतन → पुनर्प्राप्ति', E'B', E'**स्मृति प्रक्रियाको सही क्रम: प्राप्ति (Reception) → सङ्केतन (Coding) → भण्डार (Storage) → पुनर्प्राप्ति (Retrieval) हो।**\\nनोट: प्राप्ति चरणमा ज्ञानेन्द्रियमार्फत सूचना ग्रहण गरिन्छ, सङ्केतन चरणमा भण्डारणयोग्य बनाइन्छ, भण्डार चरणमा सुरक्षित गरिन्छ र पुनर्प्राप्ति चरणमा फेरि उपयोगमा ल्याइन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:स्मृति प्रक्रिया (R.C.S.R.) को सही क्रम कुन हो?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'स्मृति प्रक्रियाको प्राप्ति (Reception) चरणमा मुख्यतया के हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'स्मृति प्रक्रियाको प्राप्ति (Reception) चरणमा मुख्यतया के हुन्छ?', E'मस्तिष्कमा सूचना सुरक्षित रहन्छ', E'ज्ञानेन्द्रियमार्फत सूचना प्राप्त गरी मस्तिष्कमा पठाइन्छ', E'सुरक्षित सूचना पुनः उपयोगमा ल्याइन्छ', E'सूचना सङ्केतीकरण गरिन्छ', E'B', E'**प्राप्ति चरणमा ज्ञानेन्द्रियहरूमार्फत मानिसले विभिन्न स्रोतबाट सूचना प्राप्त गरी मस्तिष्कमा पठाउँछ।**\\n- भण्डारण चरणमा सूचना सुरक्षित रहन्छ।\\n- पुनर्प्राप्ति चरणमा सुरक्षित सूचना पुनः उपयोगमा ल्याइन्छ।\\nनोट: भण्डारण स्मृति दृष्टि संवेदन र श्रव्य संवेदन गरी दुई प्रकारको हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:स्मृति प्रक्रियाको प्राप्ति (Reception) चरणमा मुख्यतया के हुन्छ?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'अप्रयोगले स्मृति चिह्न धमिलो हुने विस्मरणको ह्रासको सिद्धान्त (Theory of Decay) कसले प्रतिपादन गरेका थिए?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'अप्रयोगले स्मृति चिह्न धमिलो हुने विस्मरणको ह्रासको सिद्धान्त (Theory of Decay) कसले प्रतिपादन गरेका थिए?', E'मुलर (Muller)', E'सिग्मण्ड फ्रायड', E'एबिङ्घस (Ebbinghaus)', E'वुडवर्थ', E'C', E'**अप्रयोगले स्मृति चिह्न धमिलो हुने ह्रासको सिद्धान्त (Theory of Decay) एबिङ्घस (Ebbinghaus) र उनका साथीहरूले प्रतिपादन गरेका थिए।**\\n- हस्तक्षेपको सिद्धान्त मुलर, वुडवर्थ र रोबिन्सनले दिए।\\n- दमनको सिद्धान्त सिग्मण्ड फ्रायडले दिए।\\nनोट: यो सिद्धान्तअनुसार अभ्यास नगर्दा समयसँगै स्मृति चिह्न मेटिँदै जान्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:अप्रयोगले स्मृति चिह्न धमिलो हुने विस्मरणको ह्रासको सिद्धान्त (Theory of Decay) कसले प्रतिपादन गरेका थिए?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विस्मरणको हस्तक्षेपको सिद्धान्त (Theory of Interference) कसले प्रतिपादन गरेका थिए?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'विस्मरणको हस्तक्षेपको सिद्धान्त (Theory of Interference) कसले प्रतिपादन गरेका थिए?', E'एबिङ्घस', E'मुलर, वुडवर्थ र रोबिन्सन', E'सिग्मण्ड फ्रायड', E'जिन पियाजे', E'B', E'**विस्मरणको हस्तक्षेपको सिद्धान्त मुलर (Muller), वुडवर्थ (Woodworth) र रोबिन्सन (Robinson) ले प्रतिपादन गरेका थिए।**\\n- ह्रासको सिद्धान्त एबिङ्घसले दिए।\\n- दमनको सिद्धान्त फ्रायडले दिए।\\nनोट: यो सिद्धान्तअनुसार एक सिकाइले अर्को सिकाइमा हस्तक्षेप गर्दा विस्मरण हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विस्मरणको हस्तक्षेपको सिद्धान्त (Theory of Interference) कसले प्रतिपादन गरेका थिए?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विस्मरणको दमनको सिद्धान्त (Theory of Repression) कसले प्रतिपादन गरेका थिए?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'विस्मरणको दमनको सिद्धान्त (Theory of Repression) कसले प्रतिपादन गरेका थिए?', E'एबिङ्घस', E'मुलर', E'सिग्मण्ड फ्रायड (Sigmund Freud)', E'रोबिन्सन', E'C', E'**विस्मरणको दमनको सिद्धान्त सिग्मण्ड फ्रायड (Sigmund Freud) ले प्रतिपादन गरेका थिए।**\\n- ह्रासको सिद्धान्त एबिङ्घसले दिए।\\n- हस्तक्षेपको सिद्धान्त मुलर र रोबिन्सनले दिए।\\nनोट: यो सिद्धान्तअनुसार दुःखद वा पीडादायी अनुभवलाई मनले अचेतनतर्फ धकेल्दा विस्मरण हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विस्मरणको दमनको सिद्धान्त (Theory of Repression) कसले प्रतिपादन गरेका थिए?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'निम्नमध्ये कुन विस्मरणको एक सामान्य कारण हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'निम्नमध्ये कुन विस्मरणको एक सामान्य कारण हो?', E'सिकाइ सामग्रीको प्रकृति', E'अत्यधिक अभ्यास', E'उच्च उत्प्रेरणा', E'नियमित पुनरावृत्ति', E'A', E'**सिकाइ सामग्रीको प्रकृति विस्मरणको एक सामान्य कारण हो।**\\nनोट: अर्थहीन, जटिल वा रुचि नलाग्ने सामग्री छिटो बिर्सिने हुन्छ; अभ्यास, उत्प्रेरणा र पुनरावृत्तिले भने विस्मरण घटाउँछन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:निम्नमध्ये कुन विस्मरणको एक सामान्य कारण हो?'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'भण्डारण स्मृति (Sensory Memory) मुख्यतया कति प्रकारको हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'भण्डारण स्मृति (Sensory Memory) मुख्यतया कति प्रकारको हुन्छ?', E'दुई (दृष्टि संवेदन र श्रव्य संवेदन)', E'तीन', E'चार', E'एक', E'A', E'**सांवेदिक भण्डारण स्मृति मुख्यतया दुई प्रकारको हुन्छ: दृष्टि संवेदन स्मृति (देखेर थाहा पाउने) र श्रव्य संवेदन स्मृति (आवाज सुनेर हुने)।**\\nनोट: भण्डारण चरणमा स्मृति मानिसको मस्तिष्कमा रहन्छ र आवश्यकताअनुसार पुनर्प्राप्ति हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:भण्डारण स्मृति (Sensory Memory) मुख्यतया कति प्रकारको हुन्छ?'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'स्मृति प्रक्रियाको पुनर्प्राप्ति (Retrieval) चरणमा के हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'स्मृति प्रक्रियाको पुनर्प्राप्ति (Retrieval) चरणमा के हुन्छ?', E'नयाँ सूचना ग्रहण गरिन्छ', E'सूचना सङ्केतीकरण गरिन्छ', E'भण्डारमा सुरक्षित स्मृति पुनः उपयोगमा ल्याइन्छ', E'सूचना स्थायी रूपमा मेटिन्छ', E'C', E'**पुनर्प्राप्ति चरणमा मस्तिष्कको भण्डारणमा सुरक्षित रहेको स्मृतिलाई पुनः उपयोगमा ल्याइन्छ।**\\n- नयाँ सूचना ग्रहण गर्नु प्राप्ति चरण हो।\\n- सङ्केतीकरण गर्नु सङ्केतन चरण हो।\\nनोट: स्मृतिका तत्त्वमा स्थापना, धारण, पुनः स्मरण र पहिचान पर्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:स्मृति प्रक्रियाको पुनर्प्राप्ति (Retrieval) चरणमा के हुन्छ?'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'गणित राम्ररी सिकेको विद्यार्थीलाई भौतिकशास्त्रका सूत्र बुझ्न सजिलो हुनु कुन प्रकारको स्थानान्तरण हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'गणित राम्ररी सिकेको विद्यार्थीलाई भौतिकशास्त्रका सूत्र बुझ्न सजिलो हुनु कुन प्रकारको स्थानान्तरण हो?', E'नकारात्मक स्थानान्तरण', E'सकारात्मक स्थानान्तरण', E'शून्य स्थानान्तरण', E'द्विपक्षीय स्थानान्तरण', E'B', E'**गणित राम्ररी सिकेको विद्यार्थीलाई भौतिकशास्त्रका सूत्र बुझ्न सजिलो हुनु सकारात्मक स्थानान्तरणको उदाहरण हो।**\\nनोट: एक विषयको सिकाइले अर्को मिल्दो विषयको सिकाइमा प्रत्यक्ष सहयोग पुर्‍याउँदा सकारात्मक स्थानान्तरण हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:गणित राम्ररी सिकेको विद्यार्थीलाई भौतिकशास्त्रका सूत्र बुझ्न सजिलो हुनु कुन प्रकारको स्थानान्तरण हो?'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सिकाइसँग सम्बन्धित स्मृति र विस्मरणबारे निम्नमध्ये कुन भनाइ सही हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 20, E'सिकाइसँग सम्बन्धित स्मृति र विस्मरणबारे निम्नमध्ये कुन भनाइ सही हो?', E'सिकाइमा स्मरण मात्र हुन्छ, विस्मरण हुँदैन', E'सिकाइमा स्मरण र विस्मरण दुवै हुन्छन्', E'सिकाइमा विस्मरण मात्र हुन्छ', E'सिकाइमा न स्मरण न विस्मरण हुन्छ', E'B', E'**सिकाइमा स्मरण र विस्मरण दुवै हुन्छन्।**\\nनोट: सिकाइले व्यवहारमा परिवर्तन ल्याउँछ तर सिकेको कुरा अभ्यासको अभाव वा हस्तक्षेपका कारण बिर्सन पनि सकिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सिकाइसँग सम्बन्धित स्मृति र विस्मरणबारे निम्नमध्ये कुन भनाइ सही हो?'), v_set_id, v_q_id, 20)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: पुनर्बल (Reinforcement): अवधारणा, प्रकार र प्रयोग (आधारभूत तह) (16 Q)
  v_set_id := extensions.uuid_generate_v5('dd368be9-e6a9-496b-903a-374891ecc38f'::uuid, E'पुनर्बल (Reinforcement): अवधारणा, प्रकार र प्रयोग (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '4752098a-e0df-497d-a58a-61d08d4c6814'::uuid, 'dd368be9-e6a9-496b-903a-374891ecc38f'::uuid, E'पुनर्बल (Reinforcement): अवधारणा, प्रकार र प्रयोग (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'dd368be9-e6a9-496b-903a-374891ecc38f'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पुनर्बल (Reinforcement) भनेको के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'पुनर्बल (Reinforcement) भनेको के हो?', E'व्यवहार दोहोरिने सम्भावना घटाउने प्रक्रिया', E'प्रतिक्रिया दोहोरिने सम्भावना बढाउने प्रक्रिया वा उद्दीपक', E'सिकाइ पूर्ण रोक्ने प्रक्रिया', E'स्मृति मेटाउने प्रक्रिया', E'B', E'**पुनर्बल भनेको प्रतिक्रिया दोहोरिने सम्भावना बढाउने प्रक्रिया वा उद्दीपक हो।**\\nनोट: स्किनरको कार्यपरक अनुबन्धन सिद्धान्तको मुख्य आधार पुनर्बल हो; प्राणीले त्यस्तो प्रतिक्रिया दोहोर्‍याउँछ जसका लागि उसले उत्तेजना (पुरस्कार) प्राप्त गर्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पुनर्बल (Reinforcement) भनेको के हो?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'हरेक सही प्रतिक्रियामा पुनर्बल दिने तालिकालाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'हरेक सही प्रतिक्रियामा पुनर्बल दिने तालिकालाई के भनिन्छ?', E'लगातार पुनर्बल (Continuous)', E'आंशिक पुनर्बल', E'चर अनुपात पुनर्बल', E'निश्चित अन्तराल पुनर्बल', E'A', E'**हरेक सही प्रतिक्रियामा पुनर्बल दिने तालिकालाई लगातार पुनर्बल (Continuous Reinforcement) भनिन्छ।**\\n- आंशिक पुनर्बलमा भने कहिलेकाहीँ मात्र पुनर्बल दिइन्छ।\\nनोट: नयाँ व्यवहार सिकाउने सुरुवाती चरणमा लगातार पुनर्बल बढी प्रभावकारी हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:हरेक सही प्रतिक्रियामा पुनर्बल दिने तालिकालाई के भनिन्छ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कहिलेकाहीँ मात्र, अनियमित रूपमा पुनर्बल दिने तालिकालाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'कहिलेकाहीँ मात्र, अनियमित रूपमा पुनर्बल दिने तालिकालाई के भनिन्छ?', E'लगातार पुनर्बल', E'आंशिक पुनर्बल (Partial)', E'प्राथमिक पुनर्बल', E'मौखिक पुनर्बल', E'B', E'**कहिलेकाहीँ मात्र पुनर्बल दिने तालिकालाई आंशिक पुनर्बल (Partial Reinforcement) भनिन्छ।**\\n- लगातार पुनर्बलमा भने हरेक सही प्रतिक्रियामा पुनर्बल दिइन्छ।\\nनोट: आंशिक पुनर्बलले व्यवहारलाई लामो समयसम्म कायम राख्न मद्दत गर्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कहिलेकाहीँ मात्र, अनियमित रूपमा पुनर्बल दिने तालिकालाई के भनिन्छ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'निश्चित संख्याको प्रतिक्रियापछि पुनर्बल दिने तालिकालाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'निश्चित संख्याको प्रतिक्रियापछि पुनर्बल दिने तालिकालाई के भनिन्छ?', E'निश्चित अनुपात (Fixed Ratio)', E'निश्चित अन्तराल (Fixed Interval)', E'चर अन्तराल (Variable Interval)', E'लगातार पुनर्बल', E'A', E'**निश्चित संख्याको प्रतिक्रियापछि पुनर्बल दिने तालिकालाई निश्चित अनुपात (Fixed Ratio) भनिन्छ।**\\n- निश्चित अन्तराल तालिका भने निश्चित समयपछि पुनर्बल दिनेसँग सम्बन्धित छ।\\nनोट: अनुपात तालिका प्रतिक्रियाको संख्यामा र अन्तराल तालिका समयमा आधारित हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:निश्चित संख्याको प्रतिक्रियापछि पुनर्बल दिने तालिकालाई के भनिन्छ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'निश्चित समय अन्तरालपछि पुनर्बल दिने तालिकालाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'निश्चित समय अन्तरालपछि पुनर्बल दिने तालिकालाई के भनिन्छ?', E'निश्चित अनुपात', E'निश्चित अन्तराल (Fixed Interval)', E'चर अनुपात', E'आंशिक पुनर्बल', E'B', E'**निश्चित समय अन्तरालपछि पुनर्बल दिने तालिकालाई निश्चित अन्तराल (Fixed Interval) भनिन्छ।**\\n- निश्चित अनुपात तालिका भने निश्चित संख्याको प्रतिक्रियासँग सम्बन्धित छ।\\nनोट: निश्चित अन्तराल तालिका समयसँग सम्बन्धित हुन्छ — जस्तै, हरेक हप्ता तलब दिनु।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:निश्चित समय अन्तरालपछि पुनर्बल दिने तालिकालाई के भनिन्छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'स्किनरका अनुसार कुन पुनर्बल तालिका सबैभन्दा प्रभावकारी मानिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'स्किनरका अनुसार कुन पुनर्बल तालिका सबैभन्दा प्रभावकारी मानिन्छ?', E'लगातार पुनर्बल', E'निश्चित अनुपात', E'चर अनुपात र चर अन्तराल', E'निश्चित अन्तराल', E'C', E'**स्किनरका अनुसार चर अनुपात (Variable Ratio) र चर अन्तराल (Variable Interval) तालिका सबैभन्दा प्रभावकारी मानिन्छन्।**\\nनोट: अनियमित रूपमा दिइने पुनर्बलले व्यवहारलाई लामो समयसम्म कायम राख्छ, किनभने पुनर्बल कहिले आउँछ भन्ने अनुमान गर्न सकिँदैन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:स्किनरका अनुसार कुन पुनर्बल तालिका सबैभन्दा प्रभावकारी मानिन्छ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कक्षामा शिक्षकले ''धेरै राम्रो'', ''शाबास'' भनी प्रशंसा गर्नु कुन प्रकारको पुनर्बल हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'कक्षामा शिक्षकले ''धेरै राम्रो'', ''शाबास'' भनी प्रशंसा गर्नु कुन प्रकारको पुनर्बल हो?', E'मौखिक पुनर्बल', E'अमौखिक पुनर्बल', E'नकारात्मक पुनर्बल', E'प्राथमिक पुनर्बल', E'A', E'**''धेरै राम्रो'', ''शाबास'' भनी शब्दद्वारा प्रशंसा गर्नु मौखिक पुनर्बल (Verbal Reinforcement) हो।**\\n- मुस्कान, थाप्पडी वा टाउको हल्लाएर गरिने पुनर्बल भने अमौखिक पुनर्बल हो।\\nनोट: मौखिक र अमौखिक दुवै पुनर्बल सकारात्मक र नकारात्मक हुन सक्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कक्षामा शिक्षकले ''धेरै राम्रो'', ''शाबास'' भनी प्रशंसा गर्नु कुन प्रकारको पुनर्बल हो?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षकले विद्यार्थीलाई मुस्कुराएर वा टाउको हल्लाएर प्रोत्साहन दिनु कुन प्रकारको पुनर्बल हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'शिक्षकले विद्यार्थीलाई मुस्कुराएर वा टाउको हल्लाएर प्रोत्साहन दिनु कुन प्रकारको पुनर्बल हो?', E'मौखिक पुनर्बल', E'अमौखिक पुनर्बल', E'प्राथमिक पुनर्बल', E'लगातार पुनर्बल', E'B', E'**मुस्कुराएर वा टाउको हल्लाएर दिइने प्रोत्साहन अमौखिक पुनर्बल (Non-verbal Reinforcement) हो।**\\n- शब्दद्वारा गरिने प्रशंसा भने मौखिक पुनर्बल हो।\\nनोट: हाउभाउ, मुस्कान र थाप्पडी जस्ता अमौखिक सङ्केतले पनि विद्यार्थीको व्यवहारलाई प्रोत्साहित गर्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षकले विद्यार्थीलाई मुस्कुराएर वा टाउको हल्लाएर प्रोत्साहन दिनु कुन प्रकारको पुनर्बल हो?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'निम्नमध्ये कुन सहायक (द्वितीयक) पुनर्बल हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'निम्नमध्ये कुन सहायक (द्वितीयक) पुनर्बल हो?', E'खाना', E'पानी', E'अंक र प्रशंसा', E'निद्रा', E'C', E'**अंक र प्रशंसा सहायक (द्वितीयक) पुनर्बल हुन्।**\\n- खाना, पानी र निद्रा जस्ता जैविक आवश्यकता भने प्राथमिक पुनर्बल हुन्।\\nनोट: सहायक पुनर्बलले प्रतिक्रियादाताको आवश्यकता प्रत्यक्ष पूरा नगरे पनि प्रतिक्रियाको सम्भावना बढाउँछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:निम्नमध्ये कुन सहायक (द्वितीयक) पुनर्बल हो?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पुनर्बल र दण्डबीचको मुख्य भिन्नता के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'पुनर्बल र दण्डबीचको मुख्य भिन्नता के हो?', E'पुनर्बलले व्यवहार बढाउँछ भने दण्डले व्यवहार घटाउँछ', E'पुनर्बलले व्यवहार घटाउँछ भने दण्डले बढाउँछ', E'दुवैले व्यवहार बढाउँछन्', E'दुवैले व्यवहार घटाउँछन्', E'A', E'**पुनर्बलले व्यवहार दोहोरिने सम्भावना बढाउँछ भने दण्डले व्यवहार घटाउँछ।**\\nनोट: नकारात्मक पुनर्बल पनि व्यवहार बढाउनकै लागि हो, घटाउनका लागि होइन; यसैले नकारात्मक पुनर्बल र दण्ड फरक कुरा हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पुनर्बल र दण्डबीचको मुख्य भिन्नता के हो?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यार्थीको सिकाइका लागि कुन पुनर्बल सबैभन्दा उत्तम मानिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'विद्यार्थीको सिकाइका लागि कुन पुनर्बल सबैभन्दा उत्तम मानिन्छ?', E'सकारात्मक पुनर्बल', E'सकारात्मक दण्ड', E'नकारात्मक दण्ड', E'शारीरिक दण्ड', E'A', E'**विद्यार्थीको सिकाइका लागि सकारात्मक पुनर्बल सबैभन्दा उत्तम मानिन्छ।**\\nनोट: सकारात्मक पुनर्बलले विद्यार्थीमा सन्तोष दिई व्यवहार दोहोर्‍याउन प्रेरित गर्छ, जबकि दण्डले व्यवहार दबाउँछ मात्र, सिक्न मद्दत गर्दैन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यार्थीको सिकाइका लागि कुन पुनर्बल सबैभन्दा उत्तम मानिन्छ?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पुनर्बलको अवधारणा मुख्यतया कुन सिकाइ सिद्धान्तसँग सम्बन्धित छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'पुनर्बलको अवधारणा मुख्यतया कुन सिकाइ सिद्धान्तसँग सम्बन्धित छ?', E'पाभ्लोवको शास्त्रीय अनुबन्धन', E'स्किनरको कार्यपरक अनुबन्धन', E'कोहलरको अन्तर्दृष्टि सिद्धान्त', E'पियाजेको संज्ञानात्मक सिद्धान्त', E'B', E'**पुनर्बलको अवधारणा मुख्यतया स्किनरको कार्यपरक अनुबन्धन (Operant Conditioning) सिद्धान्तसँग सम्बन्धित छ।**\\nनोट: स्किनरको सिद्धान्तको मुख्य आधार नै पुनर्बल हो; यसमा प्रतिक्रिया पछि पुनर्बल (पुरस्कार) आउने गरी सिकाइ हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पुनर्बलको अवधारणा मुख्यतया कुन सिकाइ सिद्धान्तसँग सम्बन्धित छ?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'जीवन बाँच्नका लागि आवश्यक उद्दीपक वा शरीरका आवश्यकतासँग सम्बन्धित पुनर्बललाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'जीवन बाँच्नका लागि आवश्यक उद्दीपक वा शरीरका आवश्यकतासँग सम्बन्धित पुनर्बललाई के भनिन्छ?', E'प्राथमिक पुनर्बल', E'सहायक पुनर्बल', E'मौखिक पुनर्बल', E'आंशिक पुनर्बल', E'A', E'**जीवन बाँच्नका लागि आवश्यक उद्दीपक वा शरीरका आवश्यकतासँग सम्बन्धित पुनर्बललाई प्राथमिक पुनर्बल (Primary Reinforcer) भनिन्छ।**\\n- अंक, पैसा र प्रशंसा जस्ता सामाजिक पुनर्बल भने सहायक (द्वितीयक) पुनर्बल हुन्।\\nनोट: खाना र पानी प्राथमिक पुनर्बलका उदाहरण हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:जीवन बाँच्नका लागि आवश्यक उद्दीपक वा शरीरका आवश्यकतासँग सम्बन्धित पुनर्बललाई के भनिन्छ?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'चर अनुपात र चर अन्तराल तालिका किन सबैभन्दा प्रभावकारी मानिन्छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'चर अनुपात र चर अन्तराल तालिका किन सबैभन्दा प्रभावकारी मानिन्छन्?', E'पुनर्बल नियमित र अनुमानयोग्य हुने हुनाले', E'पुनर्बल अनियमित हुँदा व्यवहार लामो समय कायम रहने हुनाले', E'पुनर्बल कहिल्यै नदिने हुनाले', E'पुनर्बल दण्डमा परिणत हुने हुनाले', E'B', E'**चर अनुपात र चर अन्तराल तालिका सबैभन्दा प्रभावकारी मानिन्छन् किनभने पुनर्बल अनियमित हुँदा व्यवहार लामो समयसम्म कायम रहन्छ।**\\nनोट: पुनर्बल कहिले आउँछ भन्ने अनुमान गर्न नसकिने हुनाले प्राणीले निरन्तर प्रतिक्रिया दिइरहन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:चर अनुपात र चर अन्तराल तालिका किन सबैभन्दा प्रभावकारी मानिन्छन्?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नकारात्मक पुनर्बल (Negative Reinforcement) को मुख्य उद्देश्य के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'नकारात्मक पुनर्बल (Negative Reinforcement) को मुख्य उद्देश्य के हो?', E'व्यवहारको सम्भावना घटाउनु', E'अप्रिय वस्तु हटाएर व्यवहारको सम्भावना बढाउनु', E'विद्यार्थीलाई सजाय दिनु', E'व्यवहार पूर्ण रोक्नु', E'B', E'**नकारात्मक पुनर्बलको मुख्य उद्देश्य अप्रिय वस्तु हटाएर व्यवहारको सम्भावना बढाउनु हो।**\\nनोट: नकारात्मक पुनर्बल दण्ड होइन; दण्डले व्यवहार घटाउँछ भने नकारात्मक पुनर्बलले व्यवहार बढाउँछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नकारात्मक पुनर्बल (Negative Reinforcement) को मुख्य उद्देश्य के हो?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कक्षाकोठामा विद्यार्थीको राम्रो व्यवहारलाई प्रशंसा र पुरस्कारद्वारा प्रोत्साहन गर्ने उद्देश्य के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'कक्षाकोठामा विद्यार्थीको राम्रो व्यवहारलाई प्रशंसा र पुरस्कारद्वारा प्रोत्साहन गर्ने उद्देश्य के हो?', E'राम्रो व्यवहार दोहोरिने सम्भावना बढाउनु', E'विद्यार्थीलाई डर देखाउनु', E'व्यवहार घटाउनु', E'विद्यार्थीलाई दण्डित गर्नु', E'A', E'**विद्यार्थीको राम्रो व्यवहारलाई प्रशंसा र पुरस्कारद्वारा प्रोत्साहन गर्ने उद्देश्य त्यो राम्रो व्यवहार दोहोरिने सम्भावना बढाउनु हो।**\\nनोट: यो सकारात्मक पुनर्बलको कक्षाकोठा प्रयोग हो, जसले विद्यार्थीको उत्प्रेरणा र सिकाइ दुवै बढाउँछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कक्षाकोठामा विद्यार्थीको राम्रो व्यवहारलाई प्रशंसा र पुरस्कारद्वारा प्रोत्साहन गर्ने उद्देश्य के हो?'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  RAISE NOTICE 'Unit ख-३ सिकाइ-तत्त्व batch upsert complete: 4 sets, 76 questions.';
END $$;
