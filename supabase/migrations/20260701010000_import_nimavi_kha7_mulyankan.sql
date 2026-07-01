-- Idempotent UPSERT import: निमावि प्रथम पत्र — unit ख-७ मूल्याङ्कन र परीक्षा
-- Adds Level I sets alongside preserved model sets. Override same-identity; never deletes. Generated 2026-07-01T15:08:14.671Z.
DO $$
DECLARE
  v_module_id uuid := '6695669a-f40e-421a-a4ec-b09bbeaf56c4'::uuid;
  v_set_id uuid;
  v_q_id uuid;
BEGIN

  -- Set: मूल्याङ्कनको अर्थ, मापनका प्रकार र मूल्याङ्कनका चार प्रकार (आधारभूत तह) (19 Q)
  v_set_id := extensions.uuid_generate_v5('529c541d-c7b9-4af8-874e-7623be4b9b80'::uuid, E'मूल्याङ्कनको अर्थ, मापनका प्रकार र मूल्याङ्कनका चार प्रकार (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '33e33b97-b080-4e2e-9c20-198b6cba350b'::uuid, '529c541d-c7b9-4af8-874e-7623be4b9b80'::uuid, E'मूल्याङ्कनको अर्थ, मापनका प्रकार र मूल्याङ्कनका चार प्रकार (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '529c541d-c7b9-4af8-874e-7623be4b9b80'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'मापनका प्रकार जम्मा कति वटा मानिन्छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'मापनका प्रकार जम्मा कति वटा मानिन्छन्?', E'दुई', E'तीन', E'चार', E'पाँच', E'C', E'**मापनका चार प्रकार हुन्छन्: नामाङ्कन वा वर्गीकरण मापनी, क्रमागत स्केल, अन्तराल स्केल, र अनुपातिक स्केल।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:मापनका प्रकार जम्मा कति वटा मानिन्छन्?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै घटना, व्यक्ति वा विशेषतालाई कुनै सङ्ख्या वा सङ्केत प्रयोग गरी वर्गीकरण मात्र गर्ने मापनलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'कुनै घटना, व्यक्ति वा विशेषतालाई कुनै सङ्ख्या वा सङ्केत प्रयोग गरी वर्गीकरण मात्र गर्ने मापनलाई के भनिन्छ?', E'क्रमागत स्केल', E'नामाङ्कन वा वर्गीकरण मापनी (Nominal Scale)', E'अन्तराल स्केल', E'अनुपातिक स्केल', E'B', E'**कुनै घटना, व्यक्ति वा विशेषतालाई कुनै सङ्ख्या वा सङ्केत प्रयोग गरी वर्गीकरण मात्र गर्ने मापनलाई नामाङ्कन वा वर्गीकरण मापनी (Nominal Scale) भनिन्छ।**\\n- क्रमागत स्केलमा गुणहरूको सानो-ठूलो तुलनात्मक मान जनाइन्छ, तर अन्तरमा एकरूपता हुँदैन।\\n- अन्तराल स्केलमा सापेक्ष शून्य हुन्छ।\\n- अनुपातिक स्केलमा निरपेक्ष शून्य र वास्तविक मान जनाइन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै घटना, व्यक्ति वा विशेषतालाई कुनै सङ्ख्या वा सङ्केत प्रयोग गरी वर्गीकरण मात्र गर्ने मापनलाई के भनिन्छ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'गुणहरूको सानो-ठूलो तुलनात्मक मान जनाउने तर अन्तरमा एकरूपता नहुने मापनलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'गुणहरूको सानो-ठूलो तुलनात्मक मान जनाउने तर अन्तरमा एकरूपता नहुने मापनलाई के भनिन्छ?', E'नामाङ्कन मापनी', E'क्रमागत स्केल (Ordinal Scale)', E'अन्तराल स्केल', E'अनुपातिक स्केल', E'B', E'**गुणहरूको सानो-ठूलो तुलनात्मक मान जनाउने तर अन्तरमा एकरूपता नहुने मापनलाई क्रमागत स्केल (Ordinal Scale) भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:गुणहरूको सानो-ठूलो तुलनात्मक मान जनाउने तर अन्तरमा एकरूपता नहुने मापनलाई के भनिन्छ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सापेक्ष शून्य हुने तर शून्यको अर्थ गुणको अनुपस्थिति नहुने मापनलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'सापेक्ष शून्य हुने तर शून्यको अर्थ गुणको अनुपस्थिति नहुने मापनलाई के भनिन्छ?', E'नामाङ्कन मापनी', E'क्रमागत स्केल', E'अन्तराल स्केल (Interval Scale)', E'अनुपातिक स्केल', E'C', E'**सापेक्ष शून्य हुने तर शून्यको अर्थ गुणको अनुपस्थिति नहुने मापनलाई अन्तराल स्केल (Interval Scale) भनिन्छ।**\\n- अनुपातिक स्केलमा भने निरपेक्ष शून्य हुन्छ, जसको अर्थ गुणको पूर्ण अनुपस्थिति हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सापेक्ष शून्य हुने तर शून्यको अर्थ गुणको अनुपस्थिति नहुने मापनलाई के भनिन्छ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'निरपेक्ष शून्य र वास्तविक मान जनाउने मापनलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'निरपेक्ष शून्य र वास्तविक मान जनाउने मापनलाई के भनिन्छ?', E'नामाङ्कन मापनी', E'क्रमागत स्केल', E'अन्तराल स्केल', E'अनुपातिक स्केल (Ratio Scale)', E'D', E'**निरपेक्ष शून्य र वास्तविक मान जनाउने मापनलाई अनुपातिक स्केल (Ratio Scale) भनिन्छ, जसमा शून्यको अर्थ गुणको पूर्ण अनुपस्थिति हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:निरपेक्ष शून्य र वास्तविक मान जनाउने मापनलाई के भनिन्छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'मापन र मूल्याङ्कनबीचको प्रमुख भिन्नता के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'मापन र मूल्याङ्कनबीचको प्रमुख भिन्नता के हो?', E'मापन सङ्ख्यात्मक÷परिमाणात्मक उपलब्धिसँग सम्बन्धित हुन्छ भने मूल्याङ्कन गुणात्मक उपलब्धिसँग सम्बन्धित हुन्छ', E'दुवै एउटै हुन्', E'मूल्याङ्कन सङ्ख्यात्मक हुन्छ भने मापन गुणात्मक हुन्छ', E'मापन र मूल्याङ्कनको कुनै सम्बन्ध छैन', E'A', E'**मापन सङ्ख्यात्मक÷परिमाणात्मक उपलब्धिसँग सम्बन्धित हुन्छ भने मूल्याङ्कन गुणात्मक उपलब्धिसँग सम्बन्धित हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:मापन र मूल्याङ्कनबीचको प्रमुख भिन्नता के हो?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'परीक्षा र मूल्याङ्कनबीचको सम्बन्धका बारेमा के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'परीक्षा र मूल्याङ्कनबीचको सम्बन्धका बारेमा के भनिन्छ?', E'परीक्षा मापन विधि वा साधन हो भने मूल्याङ्कन परिणामसहितको साध्य हो', E'दुवै एउटै अवधारणा हुन्', E'मूल्याङ्कन साधन हो भने परीक्षा साध्य हो', E'दुवैको कुनै सम्बन्ध छैन', E'A', E'**परीक्षा मापन विधि वा साधन हो भने मूल्याङ्कन परिणामसहितको साध्य हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:परीक्षा र मूल्याङ्कनबीचको सम्बन्धका बारेमा के भनिन्छ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'मूल्याङ्कन (Evaluation) लाई सामान्यतया के भनिएको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'मूल्याङ्कन (Evaluation) लाई सामान्यतया के भनिएको छ?', E'मापन र मूल्य निर्धारणको सम्मिलित स्वरूप', E'केवल सङ्ख्यात्मक तथ्याङ्क सङ्कलन', E'केवल परीक्षा सञ्चालन', E'केवल प्रश्नपत्र निर्माण', E'A', E'**मूल्याङ्कन मापन र मूल्य निर्धारणको सम्मिलित स्वरूप हो।**\\nनोट: यसलाई निर्णय गर्नका लागि सूचना प्रदान गर्ने विज्ञान पनि भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:मूल्याङ्कन (Evaluation) लाई सामान्यतया के भनिएको छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'मूल्याङ्कनलाई मूलतः कति भागमा विभाजन गरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'मूल्याङ्कनलाई मूलतः कति भागमा विभाजन गरिन्छ?', E'एक', E'दुई', E'तीन', E'चार', E'B', E'**मूल्याङ्कनलाई मूलतः निर्माणात्मक र निर्णयात्मक गरी दुई भागमा विभाजन गरिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:मूल्याङ्कनलाई मूलतः कति भागमा विभाजन गरिन्छ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'मूल्याङ्कनलाई कति प्रकारमा विभाजन गरी अध्ययन गर्न सकिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'मूल्याङ्कनलाई कति प्रकारमा विभाजन गरी अध्ययन गर्न सकिन्छ?', E'दुई', E'तीन', E'चार', E'पाँच', E'C', E'**मूल्याङ्कनलाई चार प्रकारमा विभाजन गरी अध्ययन गर्न सकिन्छ: प्रारम्भिक÷पूर्व मूल्याङ्कन, निदानात्मक मूल्याङ्कन, निर्माणात्मक मूल्याङ्कन र निर्णयात्मक मूल्याङ्कन।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:मूल्याङ्कनलाई कति प्रकारमा विभाजन गरी अध्ययन गर्न सकिन्छ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै विद्यार्थीको पूर्ण क्षमताको मूल्याङ्कन गर्ने प्रकारलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'कुनै विद्यार्थीको पूर्ण क्षमताको मूल्याङ्कन गर्ने प्रकारलाई के भनिन्छ?', E'निदानात्मक मूल्याङ्कन', E'प्रारम्भिक मूल्याङ्कन', E'निर्माणात्मक मूल्याङ्कन', E'निर्णयात्मक मूल्याङ्कन', E'B', E'**कुनै विद्यार्थीको पूर्ण क्षमताको मूल्याङ्कन गर्ने प्रकारलाई प्रारम्भिक मूल्याङ्कन भनिन्छ।**\\n- निदानात्मक मूल्याङ्कनले विद्यार्थीका विशेष समस्या र सिकाइ सम्बन्धी जटिलताका कारण पत्ता लगाउँछ।\\n- निर्माणात्मक मूल्याङ्कनले विद्यार्थीको कमी-कमजोरी पत्ता लगाई सुधार गर्छ।\\n- निर्णयात्मक मूल्याङ्कनले योजनाको अन्त्यमा सफलता जाँच्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै विद्यार्थीको पूर्ण क्षमताको मूल्याङ्कन गर्ने प्रकारलाई के भनिन्छ?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यार्थीका विशेष समस्या र सिकाइ सम्बन्धी जटिलता तथा त्यसको कारण पत्ता लगाई उपचारका लागि योजना बनाउने मूल्याङ्कनलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'विद्यार्थीका विशेष समस्या र सिकाइ सम्बन्धी जटिलता तथा त्यसको कारण पत्ता लगाई उपचारका लागि योजना बनाउने मूल्याङ्कनलाई के भनिन्छ?', E'प्रारम्भिक मूल्याङ्कन', E'निदानात्मक मूल्याङ्कन (Diagnostic Evaluation)', E'निर्माणात्मक मूल्याङ्कन', E'निर्णयात्मक मूल्याङ्कन', E'B', E'**विद्यार्थीका विशेष समस्या र सिकाइ सम्बन्धी जटिलता, त्यसका कारण र उपचारका लागि योजना बनाउने मूल्याङ्कनलाई निदानात्मक मूल्याङ्कन (Diagnostic Evaluation) भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यार्थीका विशेष समस्या र सिकाइ सम्बन्धी जटिलता तथा त्यसको कारण पत्ता लगाई उपचारका लागि योजना बनाउने मूल्याङ्कनलाई के भनिन्छ?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यार्थीको कमी-कमजोरी पत्ता लगाई त्यसको सुधार गर्नु कुन मूल्याङ्कनको मुख्य उद्देश्य हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'विद्यार्थीको कमी-कमजोरी पत्ता लगाई त्यसको सुधार गर्नु कुन मूल्याङ्कनको मुख्य उद्देश्य हो?', E'प्रारम्भिक मूल्याङ्कन', E'निदानात्मक मूल्याङ्कन', E'निर्माणात्मक मूल्याङ्कन (Formative Evaluation)', E'निर्णयात्मक मूल्याङ्कन', E'C', E'**विद्यार्थीको कमी-कमजोरी पत्ता लगाई त्यसको सुधार वा निराकरण गर्नु निर्माणात्मक मूल्याङ्कन (Formative Evaluation) को मुख्य उद्देश्य हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यार्थीको कमी-कमजोरी पत्ता लगाई त्यसको सुधार गर्नु कुन मूल्याङ्कनको मुख्य उद्देश्य हो?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'योजनाको अन्त्यमा योजना सफल भयो वा भएन भनी गरिने मूल्याङ्कनलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'योजनाको अन्त्यमा योजना सफल भयो वा भएन भनी गरिने मूल्याङ्कनलाई के भनिन्छ?', E'प्रारम्भिक मूल्याङ्कन', E'निदानात्मक मूल्याङ्कन', E'निर्माणात्मक मूल्याङ्कन', E'निर्णयात्मक मूल्याङ्कन (Summative Evaluation)', E'D', E'**योजनाको अन्त्यमा योजना सफल भयो वा भएन भनी गरिने मूल्याङ्कनलाई निर्णयात्मक मूल्याङ्कन (Summative Evaluation) भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:योजनाको अन्त्यमा योजना सफल भयो वा भएन भनी गरिने मूल्याङ्कनलाई के भनिन्छ?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'निर्णयात्मक मूल्याङ्कनको मुख्य उद्देश्य के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'निर्णयात्मक मूल्याङ्कनको मुख्य उद्देश्य के हो?', E'विद्यार्थीको उपलब्धिको तह वा श्रेणी निर्धारण गरी प्रमाणपत्रसमेत प्रदान गर्नु', E'विद्यार्थीको कमी-कमजोरी पत्ता लगाउनु', E'विद्यार्थीको पूर्ण क्षमता जाँच्नु', E'सिकाइ जटिलता पत्ता लगाउनु', E'A', E'**निर्णयात्मक मूल्याङ्कनको मुख्य उद्देश्य विद्यार्थीको उपलब्धिको तह वा श्रेणी निर्धारण गरी प्रमाणपत्रसमेत प्रदान गर्नु हो।**\\n- विद्यार्थीको कमी-कमजोरी पत्ता लगाउनु निर्माणात्मक मूल्याङ्कनको उद्देश्य हो।\\n- विद्यार्थीको पूर्ण क्षमता जाँच्नु प्रारम्भिक मूल्याङ्कनको उद्देश्य हो।\\n- सिकाइ जटिलता पत्ता लगाउनु निदानात्मक मूल्याङ्कनको उद्देश्य हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:निर्णयात्मक मूल्याङ्कनको मुख्य उद्देश्य के हो?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वार्षिक परीक्षा, बोर्डका परीक्षाहरू, प्रवेश परीक्षा र सेवा आयोगका परीक्षाहरू कुन मूल्याङ्कनका साधन हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'वार्षिक परीक्षा, बोर्डका परीक्षाहरू, प्रवेश परीक्षा र सेवा आयोगका परीक्षाहरू कुन मूल्याङ्कनका साधन हुन्?', E'प्रारम्भिक मूल्याङ्कन', E'निदानात्मक मूल्याङ्कन', E'निर्माणात्मक मूल्याङ्कन', E'निर्णयात्मक मूल्याङ्कन', E'D', E'**वार्षिक परीक्षा, बोर्डका परीक्षाहरू, प्रवेश परीक्षा र सेवा आयोगका परीक्षाहरू निर्णयात्मक मूल्याङ्कनका साधनहरू हुन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वार्षिक परीक्षा, बोर्डका परीक्षाहरू, प्रवेश परीक्षा र सेवा आयोगका परीक्षाहरू कुन मूल्याङ्कनका साधन हुन्?'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'व्यावहारिक उद्देश्य (Behavioral Objective) का विशेषताहरू के-के हुनुपर्दछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'व्यावहारिक उद्देश्य (Behavioral Objective) का विशेषताहरू के-के हुनुपर्दछ?', E'विशिष्ट, मापनीय, स्पष्ट, व्यावहारिक र प्राप्त गर्न सकिने', E'अस्पष्ट र अमूर्त', E'सामान्य र फराकिलो', E'केवल शिक्षकको धारणामा भर पर्ने', E'A', E'**व्यावहारिक उद्देश्यका विशेषताहरू विशिष्ट, मापनीय, स्पष्ट, व्यावहारिक, र प्राप्ति÷हासिल गर्न सकिने हुनुपर्दछन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:व्यावहारिक उद्देश्य (Behavioral Objective) का विशेषताहरू के-के हुनुपर्दछ?'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'श्रेणीकरण र स्थान निर्धारण, प्रमाणीकरण, शैक्षणिक सुधार र सिकाइ उन्नति कुनको उद्देश्य वा कार्य हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'श्रेणीकरण र स्थान निर्धारण, प्रमाणीकरण, शैक्षणिक सुधार र सिकाइ उन्नति कुनको उद्देश्य वा कार्य हुन्?', E'पाठ्यक्रमको', E'मूल्याङ्कनको', E'शिक्षक तालिमको', E'कक्षाकोठा व्यवस्थापनको', E'B', E'**श्रेणीकरण र स्थान निर्धारण (Grading and Placement), प्रमाणीकरण (Certifying), शैक्षणिक सुधार (Instructional Improvement) र सिकाइ उन्नति (Promotion of Learning) मूल्याङ्कनका प्रमुख उद्देश्य र कार्यहरू हुन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:श्रेणीकरण र स्थान निर्धारण, प्रमाणीकरण, शैक्षणिक सुधार र सिकाइ उन्नति कुनको उद्देश्य वा कार्य हुन्?'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वास्तविक रूपमा शैक्षिक उद्देश्य कुन हदसम्म प्राप्त गर्न सकियो भनी किटान गर्ने प्रक्रियालाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'वास्तविक रूपमा शैक्षिक उद्देश्य कुन हदसम्म प्राप्त गर्न सकियो भनी किटान गर्ने प्रक्रियालाई के भनिन्छ?', E'मापन', E'मूल्याङ्कन', E'परीक्षा', E'पाठ्यक्रम विकास', E'B', E'**वास्तविक रूपमा शैक्षिक उद्देश्यलाई कुन हदसम्म प्राप्त गर्न सकियो भनी किटान गर्ने प्रक्रियालाई मूल्याङ्कन भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वास्तविक रूपमा शैक्षिक उद्देश्य कुन हदसम्म प्राप्त गर्न सकियो भनी किटान गर्ने प्रक्रियालाई के भनिन्छ?'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: निर्णयात्मक र निर्माणात्मक मूल्याङ्कनका उद्देश्य र आत्ममूल्याङ्कन (आधारभूत तह) (12 Q)
  v_set_id := extensions.uuid_generate_v5('529c541d-c7b9-4af8-874e-7623be4b9b80'::uuid, E'निर्णयात्मक र निर्माणात्मक मूल्याङ्कनका उद्देश्य र आत्ममूल्याङ्कन (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '33e33b97-b080-4e2e-9c20-198b6cba350b'::uuid, '529c541d-c7b9-4af8-874e-7623be4b9b80'::uuid, E'निर्णयात्मक र निर्माणात्मक मूल्याङ्कनका उद्देश्य र आत्ममूल्याङ्कन (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '529c541d-c7b9-4af8-874e-7623be4b9b80'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'निम्नमध्ये कुन निर्णयात्मक मूल्याङ्कनको उद्देश्य होइन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'निम्नमध्ये कुन निर्णयात्मक मूल्याङ्कनको उद्देश्य होइन?', E'प्रमाणपत्र वितरण गर्नु', E'कक्षा उकास्ने वा नउकास्ने निर्णय गर्नु', E'विद्यार्थीको सिकाइमा तत्काल सुधार ल्याउनु', E'विद्यालयहरूबिचको शैक्षिक स्तरको तुलना गर्नु', E'C', E'**प्रमाणपत्र वितरण, कक्षा उकास्ने-नउकास्ने निर्णय र विद्यालयहरूबिचको शैक्षिक स्तर तुलना निर्णयात्मक मूल्याङ्कनका उद्देश्य हुन्।**\\n- विद्यार्थीको सिकाइमा तत्काल सुधार ल्याउनु भने निर्माणात्मक मूल्याङ्कनको उद्देश्य हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:निम्नमध्ये कुन निर्णयात्मक मूल्याङ्कनको उद्देश्य होइन?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'निर्णयात्मक मूल्याङ्कनका उद्देश्यहरूमा शैक्षिक क्रियाकलापको प्रभावकारिता जाँच्ने र योजनाको वैधता जाँच्ने कुरा पर्दछ। निम्नमध्ये अर्को कुन कुरा पनि यसैको उद्देश्यमा पर्दछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'निर्णयात्मक मूल्याङ्कनका उद्देश्यहरूमा शैक्षिक क्रियाकलापको प्रभावकारिता जाँच्ने र योजनाको वैधता जाँच्ने कुरा पर्दछ। निम्नमध्ये अर्को कुन कुरा पनि यसैको उद्देश्यमा पर्दछ?', E'विद्यालयको प्रगति र स्तर पत्ता लगाउनु', E'विद्यार्थीलाई तत्काल पृष्ठपोषण दिई सिकाइ सुधार्नु', E'शिक्षकलाई नयाँ शिक्षण विधि सिकाउनु', E'पाठ्यक्रम परिमार्जन गर्नु', E'A', E'**विद्यालयको प्रगति र स्तर पत्ता लगाउनु पनि निर्णयात्मक मूल्याङ्कनको एउटा उद्देश्य हो, जसरी शैक्षिक क्रियाकलापको प्रभावकारिता र योजनाको वैधता जाँच्ने कुरा पनि यसैमा पर्छन्।**\\n- विद्यार्थीलाई तत्काल पृष्ठपोषण दिई सिकाइ सुधार्नु निर्माणात्मक मूल्याङ्कनको काम हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:निर्णयात्मक मूल्याङ्कनका उद्देश्यहरूमा शैक्षिक क्रियाकलापको प्रभावकारिता जाँच्ने र योजनाको वैधता जाँच्ने कुरा पर्दछ। निम्नमध्ये अर्को कुन कुरा पनि यसैको उद्देश्यमा पर्दछ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'निम्नमध्ये कुन कुरा निर्णयात्मक मूल्याङ्कनको उद्देश्यभित्र पर्दैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'निम्नमध्ये कुन कुरा निर्णयात्मक मूल्याङ्कनको उद्देश्यभित्र पर्दैन?', E'शिक्षाको उद्देश्य प्राप्तिको लेखाजोखा गर्नु', E'शैक्षिक स्तरलाई प्रमाणित गर्नु', E'विद्यार्थीलाई तत्कालै पृष्ठपोषण दिई कमजोरी सुधार्नु', E'विद्यालयको प्रगति र स्तर पत्ता लगाउनु', E'C', E'**शिक्षाको उद्देश्य प्राप्तिको लेखाजोखा गर्नु, शैक्षिक स्तर प्रमाणित गर्नु र विद्यालयको प्रगति पत्ता लगाउनु निर्णयात्मक मूल्याङ्कनका उद्देश्य हुन्।**\\n- विद्यार्थीलाई तत्कालै पृष्ठपोषण दिई कमजोरी सुधार्नु निर्माणात्मक मूल्याङ्कनको काम हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:निम्नमध्ये कुन कुरा निर्णयात्मक मूल्याङ्कनको उद्देश्यभित्र पर्दैन?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कक्षा ४ देखि ८ सम्म विद्यार्थीको उपलब्धिको लेखाजोखा गर्दा आन्तरिक र बाह्य मूल्याङ्कनको भार अनुपात कस्तो हुनुपर्ने छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'कक्षा ४ देखि ८ सम्म विद्यार्थीको उपलब्धिको लेखाजोखा गर्दा आन्तरिक र बाह्य मूल्याङ्कनको भार अनुपात कस्तो हुनुपर्ने छ?', E'२५% – ७५%', E'५०% – ५०%', E'७५% – २५%', E'१००% आन्तरिक मात्र', E'B', E'**कक्षा ४–८ मा ५० प्रतिशत भारको आन्तरिक मूल्याङ्कन र ५० प्रतिशत भारको बाह्य मूल्याङ्कनका माध्यमले विद्यार्थीको उपलब्धिको लेखाजोखा गर्नुपर्ने छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कक्षा ४ देखि ८ सम्म विद्यार्थीको उपलब्धिको लेखाजोखा गर्दा आन्तरिक र बाह्य मूल्याङ्कनको भार अनुपात कस्तो हुनुपर्ने छ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'निर्णयात्मक मूल्याङ्कनमा आन्तरिक मूल्याङ्कनको कति प्रतिशत र बाह्य परीक्षाको कति प्रतिशत भार कायम गरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'निर्णयात्मक मूल्याङ्कनमा आन्तरिक मूल्याङ्कनको कति प्रतिशत र बाह्य परीक्षाको कति प्रतिशत भार कायम गरिन्छ?', E'आन्तरिक ५०% – बाह्य ५०%', E'आन्तरिक २५% – बाह्य ७५%', E'आन्तरिक ७५% – बाह्य २५%', E'आन्तरिक १०% – बाह्य ९०%', E'B', E'**निर्णयात्मक मूल्याङ्कनमा आन्तरिक मूल्याङ्कनको कम्तीमा २५ प्रतिशत र बाह्य परीक्षाको ७५ प्रतिशत भार कायम गरी निर्णयात्मक मूल्याङ्कन गरिने छ।**\\nनोट: यो अनुपात कक्षा ४-८ को ५०-५० आन्तरिक-बाह्य लेखाजोखाभन्दा फरक हो, किनभने यसले निर्णयात्मक मूल्याङ्कनको अन्तिम भार विभाजनलाई जनाउँछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:निर्णयात्मक मूल्याङ्कनमा आन्तरिक मूल्याङ्कनको कति प्रतिशत र बाह्य परीक्षाको कति प्रतिशत भार कायम गरिन्छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'आन्तरिक मूल्याङ्कनको मुख्य उद्देश्य के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'आन्तरिक मूल्याङ्कनको मुख्य उद्देश्य के हो?', E'विद्यार्थीहरूको सिकाइ स्तरमा सुधार गर्नु', E'विद्यार्थीलाई प्रमाणपत्र दिनु', E'विद्यालयको ग्रेड निर्धारण गर्नु', E'राष्ट्रिय परीक्षा सञ्चालन गर्नु', E'A', E'**आन्तरिक मूल्याङ्कनको मुख्य उद्देश्य विद्यार्थीहरूको सिकाइ स्तरमा सुधार गर्नु हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:आन्तरिक मूल्याङ्कनको मुख्य उद्देश्य के हो?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यार्थीले आफ्नै विषयमा आफैं गर्ने मूल्याङ्कनलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'विद्यार्थीले आफ्नै विषयमा आफैं गर्ने मूल्याङ्कनलाई के भनिन्छ?', E'निदानात्मक मूल्याङ्कन', E'आत्ममूल्याङ्कन (Self-Evaluation)', E'सहकर्मी मूल्याङ्कन', E'बाह्य मूल्याङ्कन', E'B', E'**विद्यार्थीले आफूले आफ्नै विषयमा गर्ने मूल्याङ्कनलाई आत्ममूल्याङ्कन भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यार्थीले आफ्नै विषयमा आफैं गर्ने मूल्याङ्कनलाई के भनिन्छ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'आत्ममूल्याङ्कनलाई सामान्यतया कस्तो मूल्याङ्कन मानिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'आत्ममूल्याङ्कनलाई सामान्यतया कस्तो मूल्याङ्कन मानिन्छ?', E'सबैभन्दा कमजोर र अविश्वसनीय', E'सबैभन्दा राम्रो र प्रभावकारी', E'पूर्णतया अनावश्यक', E'केवल शिक्षकले मात्र गर्न सक्ने', E'B', E'**आत्ममूल्याङ्कनलाई सबैभन्दा राम्रो र प्रभावकारी मूल्याङ्कन मानिन्छ, किनकि कसैले आफ्ना गल्ती-कमजोरी आफैं पत्ता लगाई व्यक्त गर्न सक्नु नै सबैभन्दा राम्रो मूल्याङ्कन हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:आत्ममूल्याङ्कनलाई सामान्यतया कस्तो मूल्याङ्कन मानिन्छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'आत्ममूल्याङ्कनको एउटा सबल पक्ष के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'आत्ममूल्याङ्कनको एउटा सबल पक्ष के हो?', E'यसमा न्यूनतम स्रोत र साधन चाहिन्छ', E'यो सधैं महँगो हुन्छ', E'यसका लागि विशेषज्ञ चाहिन्छ', E'यो केवल परीक्षामार्फत मात्र सम्भव हुन्छ', E'A', E'**आत्ममूल्याङ्कनको एउटा सबल पक्ष यो न्यूनतम स्रोत र साधनबाट सम्पन्न हुन सक्नु हो।**\\n- यसका अन्य सबल पक्षमा आफ्नो मूल्याङ्कन आफैं गर्न सकिनु, कमजोरी पत्ता लगाई व्यवहार परिवर्तन गर्न सकिनु, र आफूलाई आफैं पृष्ठपोषण दिन सकिनु पर्दछन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:आत्ममूल्याङ्कनको एउटा सबल पक्ष के हो?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'आत्ममूल्याङ्कनको एउटा कमजोर पक्ष के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'आत्ममूल्याङ्कनको एउटा कमजोर पक्ष के हो?', E'यो पक्षपातपूर्ण हुन सक्छ र विश्वसनीयतामा कमी हुन सक्छ', E'यो सधैं बाहिरी विशेषज्ञले मात्र गर्न सक्छ', E'यसमा कुनै लागत लाग्दैन', E'यो विद्यालयको वार्षिक परीक्षामा मात्र प्रयोग हुन्छ', E'A', E'**आत्ममूल्याङ्कनको एउटा कमजोर पक्ष यो पक्षपातपूर्ण हुन सक्छ र यसमा विश्वसनीयताको कमी हुन सक्छ।**\\n- यसका अन्य कमजोर पक्षमा व्यक्तिले आफ्ना कमजोर पक्ष लुकाउन सक्नु र सही मूल्याङ्कन नहुन सक्नु पर्दछन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:आत्ममूल्याङ्कनको एउटा कमजोर पक्ष के हो?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'निर्णयात्मक मूल्याङ्कनको प्रमुख उद्देश्य विद्यार्थीको स्तर निर्धारण गर्नु हो भने निर्माणात्मक मूल्याङ्कनको प्रमुख उद्देश्य के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'निर्णयात्मक मूल्याङ्कनको प्रमुख उद्देश्य विद्यार्थीको स्तर निर्धारण गर्नु हो भने निर्माणात्मक मूल्याङ्कनको प्रमुख उद्देश्य के हो?', E'विद्यार्थी सिकाइमा सुधार गर्नु', E'विद्यार्थीलाई प्रमाणपत्र दिनु', E'विद्यालयको स्तर तुलना गर्नु', E'राष्ट्रिय परीक्षा सञ्चालन गर्नु', E'A', E'**निर्णयात्मक मूल्याङ्कनको प्रमुख उद्देश्य विद्यार्थीको स्तर निर्धारण गर्नु हो भने निर्माणात्मक मूल्याङ्कनको प्रमुख उद्देश्य विद्यार्थी सिकाइमा सुधार गर्नु हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:निर्णयात्मक मूल्याङ्कनको प्रमुख उद्देश्य विद्यार्थीको स्तर निर्धारण गर्नु हो भने निर्माणात्मक मूल्याङ्कनको प्रमुख उद्देश्य के हो?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यार्थी मूल्याङ्कन गर्दा शिक्षकले अपाङ्गता भएका र विशेष सिकाइ आवश्यकता भएका विद्यार्थीहरूका लागि के अपनाउनुपर्ने छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'विद्यार्थी मूल्याङ्कन गर्दा शिक्षकले अपाङ्गता भएका र विशेष सिकाइ आवश्यकता भएका विद्यार्थीहरूका लागि के अपनाउनुपर्ने छ?', E'उपयुक्त हुने मूल्याङ्कन प्रक्रिया', E'सामान्य विद्यार्थीसरहकै एउटै प्रक्रिया', E'मूल्याङ्कनबाट पूर्णतया छुट', E'कठिन प्रश्नपत्र मात्र', E'A', E'**विद्यार्थी मूल्याङ्कन गर्दा शिक्षकले अपाङ्गता भएका र विशेष सिकाइ आवश्यकता भएका विद्यार्थीहरूका लागि उपयुक्त हुने मूल्याङ्कन प्रक्रिया अपनाउनुपर्ने छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यार्थी मूल्याङ्कन गर्दा शिक्षकले अपाङ्गता भएका र विशेष सिकाइ आवश्यकता भएका विद्यार्थीहरूका लागि के अपनाउनुपर्ने छ?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: मूल्याङ्कनका साधनहरू — अवलोकन, पोर्टफोलियो र रुब्रिक्स (आधारभूत तह) (11 Q)
  v_set_id := extensions.uuid_generate_v5('529c541d-c7b9-4af8-874e-7623be4b9b80'::uuid, E'मूल्याङ्कनका साधनहरू — अवलोकन, पोर्टफोलियो र रुब्रिक्स (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '33e33b97-b080-4e2e-9c20-198b6cba350b'::uuid, '529c541d-c7b9-4af8-874e-7623be4b9b80'::uuid, E'मूल्याङ्कनका साधनहरू — अवलोकन, पोर्टफोलियो र रुब्रिक्स (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '529c541d-c7b9-4af8-874e-7623be4b9b80'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यार्थीहरूलाई मूल्याङ्कन गरिँदैछ भन्ने पूर्व जानकारी दिएर गरिने अवलोकनलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'विद्यार्थीहरूलाई मूल्याङ्कन गरिँदैछ भन्ने पूर्व जानकारी दिएर गरिने अवलोकनलाई के भनिन्छ?', E'अनौपचारिक अवलोकन', E'औपचारिक अवलोकन (Formal Observation)', E'आत्ममूल्याङ्कन', E'पोर्टफोलियो', E'B', E'**विद्यार्थीहरूलाई क्रियाकलापको मूल्याङ्कन गरिँदैछ भन्ने पूर्व जानकारी दिएर गरिने अवलोकनलाई औपचारिक अवलोकन (Formal Observation) भनिन्छ।**\\n- अनौपचारिक अवलोकनमा भने विद्यार्थीहरूलाई मूल्याङ्कन भइरहेको जानकारी नदिई नियमित क्रियाकलाप अवलोकन गरिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यार्थीहरूलाई मूल्याङ्कन गरिँदैछ भन्ने पूर्व जानकारी दिएर गरिने अवलोकनलाई के भनिन्छ?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यार्थीहरूलाई पूर्व जानकारी नदिई तिनीहरूको नियमित क्रियाकलाप अवलोकन गर्ने विधिलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'विद्यार्थीहरूलाई पूर्व जानकारी नदिई तिनीहरूको नियमित क्रियाकलाप अवलोकन गर्ने विधिलाई के भनिन्छ?', E'औपचारिक अवलोकन', E'अनौपचारिक अवलोकन (Informal Observation)', E'पोर्टफोलियो', E'रुब्रिक्स', E'B', E'**विद्यार्थीहरूलाई पूर्व जानकारी नदिई तिनीहरूको नियमित क्रियाकलाप अवलोकन गर्ने विधिलाई अनौपचारिक अवलोकन (Informal Observation) भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यार्थीहरूलाई पूर्व जानकारी नदिई तिनीहरूको नियमित क्रियाकलाप अवलोकन गर्ने विधिलाई के भनिन्छ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'अवलोकनमा प्रयोग हुने फारामहरूमा निम्नमध्ये कुन पर्दैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'अवलोकनमा प्रयोग हुने फारामहरूमा निम्नमध्ये कुन पर्दैन?', E'श्रेणीमापन', E'रुजु सूची', E'संचित अभिलेख', E'प्रश्नपत्र निर्माण फाराम', E'D', E'**अवलोकनमा प्रयोग हुने फारामहरू श्रेणीमापन, रुजु सूची, संचित अभिलेख र घटनावृत्त अभिलेख हुन्।**\\n- प्रश्नपत्र निर्माण फाराम अवलोकनको फाराम होइन; यो लिखित परीक्षासँग सम्बन्धित हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:अवलोकनमा प्रयोग हुने फारामहरूमा निम्नमध्ये कुन पर्दैन?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यार्थीले गरेका विभिन्न कामका उपलब्धिलाई एकीकृत गरी मूल्याङ्कन गर्ने साधनलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'विद्यार्थीले गरेका विभिन्न कामका उपलब्धिलाई एकीकृत गरी मूल्याङ्कन गर्ने साधनलाई के भनिन्छ?', E'रुब्रिक्स', E'कार्यसञ्चयिका (Portfolio)', E'रुजु सूची', E'श्रेणीमापन', E'B', E'**विद्यार्थीले गरेका विभिन्न कामका उपलब्धिलाई एकीकृत गरी मूल्याङ्कन गर्नु नै कार्यसञ्चयिका (Portfolio) हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यार्थीले गरेका विभिन्न कामका उपलब्धिलाई एकीकृत गरी मूल्याङ्कन गर्ने साधनलाई के भनिन्छ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पोर्टफोलियो (Portfolio) को एउटा सीमितता के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'पोर्टफोलियो (Portfolio) को एउटा सीमितता के हो?', E'यो तयार गर्न सजिलो, सस्तो र छिटो हुन्छ', E'यो तयार गर्न खर्चिलो र धेरै समय लाग्ने मानिन्छ', E'यसमा कुनै विद्यार्थी सामग्री समावेश हुँदैन', E'यो केवल मौखिक परीक्षामा मात्र प्रयोग हुन्छ', E'B', E'**पोर्टफोलियो तयार गर्ने कार्यलाई खर्चिलो र धेरै समय लाग्ने मानिन्छ; यो सजिलो छैन।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पोर्टफोलियो (Portfolio) को एउटा सीमितता के हो?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'"रुब्रिक्स" शब्द कुन भाषाको "रुब्रिका (Rubrica)" शब्दबाट आएको हो, जसको शाब्दिक अर्थ "रातो चक" हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'"रुब्रिक्स" शब्द कुन भाषाको "रुब्रिका (Rubrica)" शब्दबाट आएको हो, जसको शाब्दिक अर्थ "रातो चक" हुन्छ?', E'ग्रीक', E'ल्याटिन', E'फ्रेन्च', E'जर्मन', E'B', E'**"रुब्रिक्स" शब्द ल्याटिन भाषाको "रुब्रिका (Rubrica)" बाट आएको हो, जसको शाब्दिक अर्थ "रातो चक" हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:"रुब्रिक्स" शब्द कुन भाषाको "रुब्रिका (Rubrica)" शब्दबाट आएको हो, जसको शाब्दिक अर्थ "रातो चक" हुन्छ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'रुब्रिक्स आधिकारिक मूल्याङ्कनको साधनको रूपमा कहाँ व्यापक रूपमा प्रयोग हुने गरेको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'रुब्रिक्स आधिकारिक मूल्याङ्कनको साधनको रूपमा कहाँ व्यापक रूपमा प्रयोग हुने गरेको छ?', E'शिक्षा क्षेत्रमा', E'कृषि क्षेत्रमा', E'खेलकुद क्षेत्रमा मात्र', E'प्रयोग हुँदैन', E'A', E'**रुब्रिक्स आधिकारिक मूल्याङ्कनको एउटा साधनको रूपमा शिक्षा क्षेत्रमा व्यापक रूपमा प्रयोग हुने गरेको छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:रुब्रिक्स आधिकारिक मूल्याङ्कनको साधनको रूपमा कहाँ व्यापक रूपमा प्रयोग हुने गरेको छ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'रुब्रिक्समा के कुरा विस्तृत रूपमा उल्लेख गरिएको हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'रुब्रिक्समा के कुरा विस्तृत रूपमा उल्लेख गरिएको हुन्छ?', E'विद्यार्थीहरूको कार्यको स्तर', E'शिक्षकको तलब', E'विद्यालयको भवन नक्सा', E'पाठ्यपुस्तकको मूल्य', E'A', E'**रुब्रिक्समा विद्यार्थीहरूको कार्यको स्तर विस्तृत रूपमा उल्लेख गरिएको हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:रुब्रिक्समा के कुरा विस्तृत रूपमा उल्लेख गरिएको हुन्छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'रुब्रिक्सको प्रयोगले विद्यार्थीहरूको सिकाइ उपलब्धिलाई कसरी अङ्कन गर्न सकिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'रुब्रिक्सको प्रयोगले विद्यार्थीहरूको सिकाइ उपलब्धिलाई कसरी अङ्कन गर्न सकिन्छ?', E'एकरूपताका साथ', E'सधैं फरक-फरक तरिकाले', E'कुनै आधार बिना', E'संयोगमा आधारित', E'A', E'**रुब्रिक्सको प्रयोगबाट विद्यार्थीहरूको सिकाइ उपलब्धिलाई एकरूपताका साथ अङ्कन गर्न सकिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:रुब्रिक्सको प्रयोगले विद्यार्थीहरूको सिकाइ उपलब्धिलाई कसरी अङ्कन गर्न सकिन्छ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'रुब्रिक्सको प्रयोग गरी विद्यार्थीहरू स्वयंले पनि के गर्न सक्छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'रुब्रिक्सको प्रयोग गरी विद्यार्थीहरू स्वयंले पनि के गर्न सक्छन्?', E'आफ्नो कार्यको आफैं मूल्याङ्कन', E'परीक्षा प्रश्नपत्र निर्माण', E'शिक्षक नियुक्ति', E'पाठ्यक्रम स्वीकृति', E'A', E'**रुब्रिक्सको प्रयोग गरी विद्यार्थीहरू स्वयंले पनि आफ्नो कार्यको आफैं मूल्याङ्कन गर्न सक्छन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:रुब्रिक्सको प्रयोग गरी विद्यार्थीहरू स्वयंले पनि के गर्न सक्छन्?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'रुब्रिक्सको निर्माण गर्दा सकेसम्म अङ्कनका तहहरू कस्तो सङ्ख्यामा राख्नुपर्दछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'रुब्रिक्सको निर्माण गर्दा सकेसम्म अङ्कनका तहहरू कस्तो सङ्ख्यामा राख्नुपर्दछ?', E'जोर सङ्ख्यामा', E'विजोर सङ्ख्यामा', E'सधैं ३ मात्र', E'सधैं १० मात्र', E'A', E'**रुब्रिक्सको निर्माण गर्दा सकेसम्म जोर सङ्ख्यामा अङ्कनका तहहरू राख्नुपर्दछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:रुब्रिक्सको निर्माण गर्दा सकेसम्म अङ्कनका तहहरू कस्तो सङ्ख्यामा राख्नुपर्दछ?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: परीक्षाका किसिम — मौखिक, प्रयोगात्मक, विषयगत र वस्तुगत (आधारभूत तह) (15 Q)
  v_set_id := extensions.uuid_generate_v5('8b858502-60a4-4e5b-a411-3ad13deec9dd'::uuid, E'परीक्षाका किसिम — मौखिक, प्रयोगात्मक, विषयगत र वस्तुगत (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '33e33b97-b080-4e2e-9c20-198b6cba350b'::uuid, '8b858502-60a4-4e5b-a411-3ad13deec9dd'::uuid, E'परीक्षाका किसिम — मौखिक, प्रयोगात्मक, विषयगत र वस्तुगत (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '8b858502-60a4-4e5b-a411-3ad13deec9dd'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'निम्नमध्ये कुन परीक्षाको एउटा किसिम होइन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'निम्नमध्ये कुन परीक्षाको एउटा किसिम होइन?', E'लिखित साधन', E'मौखिक साधन', E'पाठ्यक्रम निर्माण', E'व्यक्तिगत तथा सामूहिक परीक्षण', E'C', E'**लिखित साधन, मौखिक साधन र व्यक्तिगत तथा सामूहिक परीक्षण परीक्षाका किसिमहरू हुन्।**\\n- पाठ्यक्रम निर्माण परीक्षाको किसिम होइन; यो छुट्टै शैक्षिक प्रक्रिया हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:निम्नमध्ये कुन परीक्षाको एउटा किसिम होइन?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सुनाइ र बोलाइ सीपको मूल्याङ्कनका लागि कुन प्रकारको परीक्षा आवश्यक मानिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'सुनाइ र बोलाइ सीपको मूल्याङ्कनका लागि कुन प्रकारको परीक्षा आवश्यक मानिन्छ?', E'लिखित परीक्षा', E'मौखिक परीक्षा', E'वस्तुगत परीक्षा', E'प्रामाणिक परीक्षा', E'B', E'**सुनाइ र बोलाइ सीपको मूल्याङ्कनका लागि मौखिक परीक्षा आवश्यक मानिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सुनाइ र बोलाइ सीपको मूल्याङ्कनका लागि कुन प्रकारको परीक्षा आवश्यक मानिन्छ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'निम्नमध्ये कुन मौखिक परीक्षाको फाइदा होइन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'निम्नमध्ये कुन मौखिक परीक्षाको फाइदा होइन?', E'तल्लो कक्षाका विद्यार्थीका लागि उपयोगी', E'लेख्न नसक्ने र अपाङ्गता भएकालाई उपयुक्त', E'पाठ्यक्रमका सबै एकाइबाट प्रश्न निर्माण सुनिश्चित गर्ने', E'खर्च र समय बचत गर्ने', E'C', E'**तल्लो कक्षाका विद्यार्थीका लागि उपयोगी हुनु, लेख्न नसक्ने र अपाङ्गता भएकालाई उपयुक्त हुनु र खर्च तथा समय बचत गर्नु मौखिक परीक्षाका फाइदा हुन्।**\\n- पाठ्यक्रमका सबै एकाइबाट प्रश्न निर्माण सुनिश्चित गर्नु मौखिक परीक्षाको फाइदा होइन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:निम्नमध्ये कुन मौखिक परीक्षाको फाइदा होइन?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'मौखिक परीक्षाको एउटा फाइदा के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'मौखिक परीक्षाको एउटा फाइदा के हो?', E'उत्तरपुस्तिका जाँच्ने झन्झट नहुने', E'उत्तरपुस्तिका जाँच्न बढी समय लाग्ने', E'चिटिङको उच्च सम्भावना हुने', E'केवल माथिल्लो कक्षाका लागि मात्र उपयोगी हुने', E'A', E'**मौखिक परीक्षाको एउटा फाइदा उत्तरपुस्तिका जाँच्ने झन्झट नहुनु हो।**\\n- मौखिक परीक्षामा चिटिङको अवसर हुँदैन, बरु यो घट्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:मौखिक परीक्षाको एउटा फाइदा के हो?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'प्रयोगात्मक परीक्षाको एउटा फाइदा के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'प्रयोगात्मक परीक्षाको एउटा फाइदा के हो?', E'सैद्धान्तिक ज्ञानलाई व्यवहारमा परिणत गर्छ', E'समय धेरै जोगिन्छ', E'पाठ्यक्रमको आवश्यकता पर्दैन', E'घोकेको कुरा लेख्न प्रोत्साहन गर्छ', E'A', E'**प्रयोगात्मक परीक्षाको एउटा फाइदा यसले सैद्धान्तिक ज्ञानलाई व्यवहारमा परिणत गर्नु हो।**\\n- घोकेको कुरा लेख्न प्रोत्साहन गर्नु भने विषयगत परीक्षाको एउटा अवगुण हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:प्रयोगात्मक परीक्षाको एउटा फाइदा के हो?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'प्रयोगात्मक परीक्षाले लिखित परीक्षाबाट प्राप्त परिणामलाई के गर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'प्रयोगात्मक परीक्षाले लिखित परीक्षाबाट प्राप्त परिणामलाई के गर्छ?', E'खण्डन गर्छ', E'प्रमाणित गर्छ', E'बेवास्ता गर्छ', E'परिवर्तन गर्छ', E'B', E'**प्रयोगात्मक परीक्षाले लिखित परीक्षाबाट प्राप्त परिणामलाई प्रमाणित गर्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:प्रयोगात्मक परीक्षाले लिखित परीक्षाबाट प्राप्त परिणामलाई के गर्छ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विषयगत परीक्षाको अवगुणमा निम्नमध्ये के पर्दछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'विषयगत परीक्षाको अवगुणमा निम्नमध्ये के पर्दछ?', E'विश्वसनीयता र वैधता मापन गुणको अभाव हुनु', E'उत्तर दिन कम समय लाग्नु', E'प्रश्न निर्माण गर्न धेरै सजिलो हुनु', E'परीक्षार्थीको ज्ञान राम्ररी मापन हुनु', E'A', E'**विषयगत परीक्षाको एउटा अवगुण विश्वसनीयता र वैधता मापन गुणको अभाव हुनु हो।**\\n- यसका अन्य अवगुणमा घोकेको कुरा लेख्न प्रोत्साहन गर्नु र परीक्षणमा विषयगत (subjective) प्रभाव पर्नु पनि पर्दछन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विषयगत परीक्षाको अवगुणमा निम्नमध्ये के पर्दछ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विषयगत (Subjective) परीक्षा मुख्यतया केको परीक्षण गर्न प्रयोग गरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'विषयगत (Subjective) परीक्षा मुख्यतया केको परीक्षण गर्न प्रयोग गरिन्छ?', E'विद्यार्थीको मौलिक स्वतन्त्र अभिव्यक्ति क्षमता, भाषाशैली र चिन्तन सीप', E'सही उत्तर छनोट गर्ने बौद्धिक क्षमता मात्र', E'केवल स्मरण शक्ति', E'केवल हस्तलेखन गुणस्तर', E'A', E'**विषयगत परीक्षा विद्यार्थीको मौलिक स्वतन्त्र अभिव्यक्ति क्षमता, भाषाशैली तथा चिन्तन सीपको परीक्षण गर्न प्रयोग गरिन्छ।**\\n- सही उत्तर छनोट गर्न सक्ने बौद्धिक क्षमताको परीक्षण भने वस्तुगत परीक्षाले गर्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विषयगत (Subjective) परीक्षा मुख्यतया केको परीक्षण गर्न प्रयोग गरिन्छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वस्तुगत (Objective) परीक्षा मुख्यतया केको परीक्षण गर्दछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'वस्तुगत (Objective) परीक्षा मुख्यतया केको परीक्षण गर्दछ?', E'सही उत्तर छनोट गर्न सक्ने बौद्धिक क्षमता', E'मौलिक अभिव्यक्ति क्षमता', E'भाषाशैली', E'चिन्तन सीप मात्र', E'A', E'**वस्तुगत (Objective) परीक्षाले सही उत्तर छनोट गर्न सक्ने बौद्धिक क्षमताको परीक्षण गर्दछ।**\\n- मौलिक अभिव्यक्ति क्षमता, भाषाशैली र चिन्तन सीप भने विषयगत परीक्षाले परीक्षण गर्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वस्तुगत (Objective) परीक्षा मुख्यतया केको परीक्षण गर्दछ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'प्रामाणिक (Standardized) परीक्षा कस्तो विषयवस्तु र उद्देश्यमा आधारित हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'प्रामाणिक (Standardized) परीक्षा कस्तो विषयवस्तु र उद्देश्यमा आधारित हुन्छ?', E'व्यापक क्षेत्रसँग सम्बन्धित', E'सीमित क्षेत्रसँग सम्बन्धित', E'एक विद्यालयमा मात्र सीमित', E'केवल मौखिक प्रश्नमा आधारित', E'A', E'**प्रामाणिक (Standardized) परीक्षा व्यापक क्षेत्रसँग सम्बन्धित विषयवस्तु र उद्देश्यमा आधारित हुन्छ, र यसमा विशेषज्ञले निर्माण गरेका प्रश्नहरू समावेश गरिन्छन्।**\\n- शिक्षक निर्मित परीक्षा भने सीमित क्षेत्रसँग सम्बन्धित हुन्छ, र यसमा शिक्षकद्वारा तयार गरेका प्रश्नहरू समावेश गरिन्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:प्रामाणिक (Standardized) परीक्षा कस्तो विषयवस्तु र उद्देश्यमा आधारित हुन्छ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षक निर्मित (Teacher-made) परीक्षामा समावेश गरिने प्रश्नहरू सामान्यतया कसद्वारा तयार गरिन्छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'शिक्षक निर्मित (Teacher-made) परीक्षामा समावेश गरिने प्रश्नहरू सामान्यतया कसद्वारा तयार गरिन्छन्?', E'शिक्षकद्वारा', E'विषय विशेषज्ञहरूको समूहद्वारा', E'राष्ट्रिय परीक्षा बोर्डद्वारा', E'अन्तर्राष्ट्रिय संस्थाद्वारा', E'A', E'**शिक्षक निर्मित परीक्षामा शिक्षकद्वारा तयार गरेका प्रश्नहरू समावेश गरिन्छन्; यो सीमित क्षेत्रसँग सम्बन्धित विषयवस्तु र उद्देश्यमा आधारित हुन्छ।**\\n- प्रामाणिक परीक्षामा भने विशेषज्ञले निर्माण गरेका प्रश्नहरू समावेश गरिन्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षक निर्मित (Teacher-made) परीक्षामा समावेश गरिने प्रश्नहरू सामान्यतया कसद्वारा तयार गरिन्छन्?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'श्रेणीमापन (Rating Scale) विधिको उद्देश्य के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'श्रेणीमापन (Rating Scale) विधिको उद्देश्य के हो?', E'विशेष गुणको मापनका लागि पूर्वनिर्धारित आधार दिनु', E'प्रश्नपत्र छाप्नु', E'परीक्षा केन्द्र निर्धारण गर्नु', E'पाठ्यक्रम स्वीकृत गर्नु', E'A', E'**श्रेणीमापनले विशेष गुणको मापनका लागि स्पष्ट र पूर्वनिर्धारित आधार दिन्छ; विशेष योग्यता, आचरण, बानी आदिको विकास कुन हदसम्म भएको छ भनी अवलोकन गरेर श्रेणी जनाइन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:श्रेणीमापन (Rating Scale) विधिको उद्देश्य के हो?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'श्रेणीमापनमा सामान्यतया कति वटासम्म श्रेणी राखिन्छन् (जस्तै अत्युत्तम, उत्तम, मध्यम, निम्न आदि)?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'श्रेणीमापनमा सामान्यतया कति वटासम्म श्रेणी राखिन्छन् (जस्तै अत्युत्तम, उत्तम, मध्यम, निम्न आदि)?', E'२ देखि ३', E'३ देखि ५÷७', E'१० भन्दा बढी', E'श्रेणी राखिँदैन', E'B', E'**श्रेणीमापनमा श्रेणी जनाउँदा अत्युत्तम, उत्तम, मध्यम, निम्न आदि गरी ३ देखि ५÷७ सम्म श्रेणीहरू राखिने गरिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:श्रेणीमापनमा सामान्यतया कति वटासम्म श्रेणी राखिन्छन् (जस्तै अत्युत्तम, उत्तम, मध्यम, निम्न आदि)?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'निम्नमध्ये कुन परीक्षाको किसिम होइन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'निम्नमध्ये कुन परीक्षाको किसिम होइन?', E'गति तथा शक्ति परीक्षण', E'बुद्धिमता परीक्षण', E'अभिरुचि परीक्षण', E'पाठ्यक्रम विकास परीक्षण', E'D', E'**गति तथा शक्ति परीक्षण, बुद्धिमता परीक्षण र अभिरुचि परीक्षण परीक्षाका मान्यता प्राप्त किसिमहरू हुन्।**\\n- "पाठ्यक्रम विकास परीक्षण" भन्ने छुट्टै किसिम अवस्थित छैन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:निम्नमध्ये कुन परीक्षाको किसिम होइन?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'प्रयोगात्मक परीक्षाको एउटा फाइदा विद्यार्थीको क्षमताका आधारमा के प्रदान गर्न सकिन्छ भन्ने हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'प्रयोगात्मक परीक्षाको एउटा फाइदा विद्यार्थीको क्षमताका आधारमा के प्रदान गर्न सकिन्छ भन्ने हो?', E'पृष्ठपोषण', E'प्रमाणपत्र', E'छात्रवृत्ति', E'दण्ड', E'A', E'**प्रयोगात्मक परीक्षाको एउटा फाइदा विद्यार्थीको क्षमताका आधारमा पृष्ठपोषण प्रदान गर्न सकिनु हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:प्रयोगात्मक परीक्षाको एउटा फाइदा विद्यार्थीको क्षमताका आधारमा के प्रदान गर्न सकिन्छ भन्ने हो?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: नेपालको परीक्षा प्रणालीको इतिहास र संरचना (आधारभूत तह) (13 Q)
  v_set_id := extensions.uuid_generate_v5('8b858502-60a4-4e5b-a411-3ad13deec9dd'::uuid, E'नेपालको परीक्षा प्रणालीको इतिहास र संरचना (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '33e33b97-b080-4e2e-9c20-198b6cba350b'::uuid, '8b858502-60a4-4e5b-a411-3ad13deec9dd'::uuid, E'नेपालको परीक्षा प्रणालीको इतिहास र संरचना (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '8b858502-60a4-4e5b-a411-3ad13deec9dd'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पटना विश्वविद्यालयको एस.एल.सी. परीक्षा केन्द्र काठमाडौंमा कुन साल (वि.सं.) मा खुलेको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'पटना विश्वविद्यालयको एस.एल.सी. परीक्षा केन्द्र काठमाडौंमा कुन साल (वि.सं.) मा खुलेको थियो?', E'१९८६', E'२०१८', E'२०३९', E'२०६३', E'A', E'**वि.सं. १९८६ मा पटना विश्वविद्यालयको एस.एल.सी. परीक्षा केन्द्र काठमाडौंमा खुलेको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पटना विश्वविद्यालयको एस.एल.सी. परीक्षा केन्द्र काठमाडौंमा कुन साल (वि.सं.) मा खुलेको थियो?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'त्रिभुवन विश्वविद्यालयमा नेपाली भाषालाई परीक्षाको माध्यम कुन मिति (वि.सं.) मा बनाइएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'त्रिभुवन विश्वविद्यालयमा नेपाली भाषालाई परीक्षाको माध्यम कुन मिति (वि.सं.) मा बनाइएको थियो?', E'२०१८ वैशाख ३०', E'२०२८ जेठ १', E'२०३९ माघ १५', E'२०५१ चैत्र १०', E'A', E'**त्रिभुवन विश्वविद्यालयमा नेपाली भाषालाई परीक्षाको माध्यम वि.सं. २०१८ वैशाख ३० गते बनाइएको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:त्रिभुवन विश्वविद्यालयमा नेपाली भाषालाई परीक्षाको माध्यम कुन मिति (वि.सं.) मा बनाइएको थियो?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'त्रिभुवन विश्वविद्यालयमा सेमेस्टर प्रणालीको सट्टा वार्षिक परीक्षा प्रणाली कुन साल (वि.सं.) देखि लागू भएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'त्रिभुवन विश्वविद्यालयमा सेमेस्टर प्रणालीको सट्टा वार्षिक परीक्षा प्रणाली कुन साल (वि.सं.) देखि लागू भएको थियो?', E'२०१८', E'२०२८', E'२०३९', E'२०६३', E'C', E'**त्रिभुवन विश्वविद्यालयमा सेमेस्टर प्रणालीको सट्टा वार्षिक परीक्षा प्रणाली वि.सं. २०३९ देखि लागू भएको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:त्रिभुवन विश्वविद्यालयमा सेमेस्टर प्रणालीको सट्टा वार्षिक परीक्षा प्रणाली कुन साल (वि.सं.) देखि लागू भएको थियो?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वि.सं. २०६३/७/१३ को निर्णयअनुसार एस.एल.सी. परीक्षामा कुन कक्षाबाट मात्र प्रश्न सोध्ने व्यवस्था भएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'वि.सं. २०६३/७/१३ को निर्णयअनुसार एस.एल.सी. परीक्षामा कुन कक्षाबाट मात्र प्रश्न सोध्ने व्यवस्था भएको थियो?', E'कक्षा ९', E'कक्षा १०', E'कक्षा ९ र १० दुवैबाट', E'कक्षा ११', E'B', E'**वि.सं. २०६३/७/१३ को निर्णयअनुसार एस.एल.सी. परीक्षामा कक्षा १० बाट मात्र प्रश्न सोध्ने व्यवस्था भएको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वि.सं. २०६३/७/१३ को निर्णयअनुसार एस.एल.सी. परीक्षामा कुन कक्षाबाट मात्र प्रश्न सोध्ने व्यवस्था भएको थियो?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यार्थीले सिकेका कुराहरूलाई सम्झने र समयको अन्तरालमा सम्झने प्रक्रियाद्वारा स्मृतिको मापन गर्ने तरिकालाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'विद्यार्थीले सिकेका कुराहरूलाई सम्झने र समयको अन्तरालमा सम्झने प्रक्रियाद्वारा स्मृतिको मापन गर्ने तरिकालाई के भनिन्छ?', E'पुनर्सिकाइ वा बचत', E'प्रत्याह्वान वा उत्पादन', E'मान्यता', E'पुनर्निर्माण', E'B', E'**सिकेका कुराहरूलाई सम्झने र समयको अन्तरालमा सम्झने प्रक्रियालाई प्रत्याह्वान वा उत्पादन तरिका भनिन्छ।**\\n- पुनर्सिकाइ वा बचत तरिकामा पहिले सिकेका कुरा पुनः सिक्दा लाग्ने पटक गणना गरिन्छ।\\n- मान्यता तरिकामा पहिले सिकेका कुरा तत्काल र समयको अन्तरालमा सम्झने प्रक्रिया समावेश हुन्छ।\\n- पुनर्निर्माण तरिकामा सिकाइको क्रमिकतालाई बिगारेर तलमाथि पारिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यार्थीले सिकेका कुराहरूलाई सम्झने र समयको अन्तरालमा सम्झने प्रक्रियाद्वारा स्मृतिको मापन गर्ने तरिकालाई के भनिन्छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पहिले सिकेका कुराहरूलाई पुनः सिक्दा कति पटक लागेको थियो भनी गणना गर्ने स्मृति मापन तरिकालाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'पहिले सिकेका कुराहरूलाई पुनः सिक्दा कति पटक लागेको थियो भनी गणना गर्ने स्मृति मापन तरिकालाई के भनिन्छ?', E'प्रत्याह्वान वा उत्पादन', E'पुनर्सिकाइ वा बचत (Relearning/Savings)', E'मान्यता', E'पुनर्निर्माण', E'B', E'**पहिले सिकेका कुराहरूलाई पुनः सिक्दा कति पटक लागेको थियो भनी गणना गर्ने तरिकालाई पुनर्सिकाइ वा बचत (Relearning/Savings) भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पहिले सिकेका कुराहरूलाई पुनः सिक्दा कति पटक लागेको थियो भनी गणना गर्ने स्मृति मापन तरिकालाई के भनिन्छ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सिकाइको क्रमिकतालाई बिगारेर तलमाथि पारी सिकारुले पुनः क्रमबद्ध गर्न सक्ने क्षमता जाँच्ने स्मृति मापन तरिकालाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'सिकाइको क्रमिकतालाई बिगारेर तलमाथि पारी सिकारुले पुनः क्रमबद्ध गर्न सक्ने क्षमता जाँच्ने स्मृति मापन तरिकालाई के भनिन्छ?', E'प्रत्याह्वान वा उत्पादन', E'पुनर्सिकाइ वा बचत', E'मान्यता', E'पुनर्निर्माण (Reconstruction)', E'D', E'**सिकाइको क्रमिकतालाई बिगारेर तलमाथि पारी सिकारुले पुनः क्रमबद्ध गर्न सक्ने क्षमता जाँच्ने तरिकालाई पुनर्निर्माण (Reconstruction) भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सिकाइको क्रमिकतालाई बिगारेर तलमाथि पारी सिकारुले पुनः क्रमबद्ध गर्न सक्ने क्षमता जाँच्ने स्मृति मापन तरिकालाई के भनिन्छ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वर्तमान व्यवस्थाअनुसार आधारभूत तह (कक्षा ८) को अन्त्यमा परीक्षा कुन तहमा हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'वर्तमान व्यवस्थाअनुसार आधारभूत तह (कक्षा ८) को अन्त्यमा परीक्षा कुन तहमा हुन्छ?', E'राष्ट्रिय तहमा', E'स्थानीय तहमा', E'प्रदेश तहमा', E'अन्तर्राष्ट्रिय तहमा', E'B', E'**आधारभूत तह (कक्षा ८) को अन्त्यमा स्थानीय तहमा परीक्षा हुनेछ।**\\n- कक्षा १० को अन्त्यमा प्रदेश स्तरीय माध्यमिक शिक्षा परीक्षा (SEE) सञ्चालन हुनेछ।\\n- कक्षा ११ र १२ को अन्तिम परीक्षा राष्ट्रिय परीक्षा बोर्डले राष्ट्रिय स्तरमा सञ्चालन गर्ने छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वर्तमान व्यवस्थाअनुसार आधारभूत तह (कक्षा ८) को अन्त्यमा परीक्षा कुन तहमा हुन्छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कक्षा १० को अन्त्यमा कुन तहमा माध्यमिक शिक्षा परीक्षा (SEE) सञ्चालन हुनेछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'कक्षा १० को अन्त्यमा कुन तहमा माध्यमिक शिक्षा परीक्षा (SEE) सञ्चालन हुनेछ?', E'स्थानीय तह', E'प्रदेश तह', E'राष्ट्रिय तह', E'अन्तर्राष्ट्रिय तह', E'B', E'**कक्षा १० को अन्त्यमा प्रदेश स्तरीय माध्यमिक शिक्षा परीक्षा (Secondary Education Examination-SEE) सञ्चालन हुनेछ।**\\n- आधारभूत तह (कक्षा ८) को परीक्षा स्थानीय तहमा हुन्छ भने कक्षा ११-१२ को अन्तिम परीक्षा राष्ट्रिय परीक्षा बोर्डले राष्ट्रिय स्तरमा सञ्चालन गर्दछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कक्षा १० को अन्त्यमा कुन तहमा माध्यमिक शिक्षा परीक्षा (SEE) सञ्चालन हुनेछ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कक्षा ११ र १२ को अन्तिम परीक्षा (माध्यमिक शिक्षा प्रमाणीकरण परीक्षा) कसले सञ्चालन, व्यवस्थापन र प्रमाणीकरण गर्ने छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'कक्षा ११ र १२ को अन्तिम परीक्षा (माध्यमिक शिक्षा प्रमाणीकरण परीक्षा) कसले सञ्चालन, व्यवस्थापन र प्रमाणीकरण गर्ने छ?', E'स्थानीय तहले', E'प्रदेश सरकारले', E'राष्ट्रिय परीक्षा बोर्डले', E'पाठ्यक्रम विकास केन्द्रले', E'C', E'**कक्षा ११ र १२ को अन्तिम परीक्षा (School Leaving Certificate Examination) राष्ट्रिय परीक्षा बोर्डले राष्ट्रिय स्तरमा सञ्चालन, व्यवस्थापन र प्रमाणीकरण गर्ने छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कक्षा ११ र १२ को अन्तिम परीक्षा (माध्यमिक शिक्षा प्रमाणीकरण परीक्षा) कसले सञ्चालन, व्यवस्थापन र प्रमाणीकरण गर्ने छ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नयाँ पाठ्यक्रमअनुसार कक्षा १ देखि ३ सम्म परीक्षाका लागि के प्रावधान छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'नयाँ पाठ्यक्रमअनुसार कक्षा १ देखि ३ सम्म परीक्षाका लागि के प्रावधान छ?', E'प्रश्नपत्र बनाई परीक्षा सञ्चालन गर्ने', E'प्रश्नपत्र बनाई परीक्षा सञ्चालन गर्ने प्रावधान छैन', E'राष्ट्रिय परीक्षा बोर्डले परीक्षा लिने', E'वार्षिक बोर्ड परीक्षा लिने', E'B', E'**नयाँ पाठ्यक्रमअनुसार कक्षा १ देखि ३ सम्म परीक्षाका लागि प्रश्नपत्र बनाई परीक्षा सञ्चालन गर्ने प्रावधान छैन।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नयाँ पाठ्यक्रमअनुसार कक्षा १ देखि ३ सम्म परीक्षाका लागि के प्रावधान छ?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'श्रेणीमापन विधिको शुरुवात गर्ने व्यक्ति को हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'श्रेणीमापन विधिको शुरुवात गर्ने व्यक्ति को हुन्?', E'Fackner', E'Pearson', E'Cattell', E'Cronbach', E'A', E'**श्रेणीमापन विधिको शुरुवात Fackner ले गरेका हुन्।**\\nनोट: पहिलो श्रेणीमापन Cattell ले सन् १८८३ मा प्रकाशित गरेका थिए, र Pearson ले सन् १९०६ मा बुद्धिको मापन गर्ने ७ वटा वर्गक्रम निर्माण गरेका थिए।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:श्रेणीमापन विधिको शुरुवात गर्ने व्यक्ति को हुन्?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'Pearson ले सन् १९०६ मा बुद्धिको मापन गर्न कति वटा वर्गक्रम निर्माण गरेका थिए?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'Pearson ले सन् १९०६ मा बुद्धिको मापन गर्न कति वटा वर्गक्रम निर्माण गरेका थिए?', E'५', E'६', E'७', E'९', E'C', E'**Pearson ले सन् १९०६ मा बुद्धिको मापन गर्ने ७ वटा वर्गक्रम निर्माण गरेका थिए।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:Pearson ले सन् १९०६ मा बुद्धिको मापन गर्न कति वटा वर्गक्रम निर्माण गरेका थिए?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: विश्वसनीयता — परिभाषा र गणना विधिहरू (आधारभूत तह) (12 Q)
  v_set_id := extensions.uuid_generate_v5('13fd152a-d851-41bb-81f2-a8278052af6f'::uuid, E'विश्वसनीयता — परिभाषा र गणना विधिहरू (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '33e33b97-b080-4e2e-9c20-198b6cba350b'::uuid, '13fd152a-d851-41bb-81f2-a8278052af6f'::uuid, E'विश्वसनीयता — परिभाषा र गणना विधिहरू (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '13fd152a-d851-41bb-81f2-a8278052af6f'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'"विश्वसनीयता भन्नाले परीक्षार्थीले उस्तै खालका दुईओटा परीक्षामा वा एउटा परीक्षा दुईपटक दिँदा उस्तै अङ्क प्राप्त गर्नु हो" भनी कसले परिभाषित गरेका छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'"विश्वसनीयता भन्नाले परीक्षार्थीले उस्तै खालका दुईओटा परीक्षामा वा एउटा परीक्षा दुईपटक दिँदा उस्तै अङ्क प्राप्त गर्नु हो" भनी कसले परिभाषित गरेका छन्?', E'Brown', E'Remmers', E'Freeman', E'Cronbach', E'A', E'**Brown ले विश्वसनीयतालाई परीक्षार्थीले उस्तै खालका दुईओटा परीक्षामा वा एउटा परीक्षा दुईपटक दिँदा उस्तै अङ्क प्राप्त गर्नु हो भनी परिभाषित गरेका छन्।**\\n- Remmers ले विश्वसनीयतालाई परीक्षाको नतिजामा एकरूपता आउनु भनेका छन्।\\n- Freeman ले विश्वसनीयतालाई परीक्षालाई दुईपटक लिँदा प्राप्ताङ्कबिच एकरूपता हुने गुण भनेका छन्।\\n- Cronbach ले विश्वसनीयतालाई मापनको क्रमभरि सधैं एकरूप हुनु भनेका छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:"विश्वसनीयता भन्नाले परीक्षार्थीले उस्तै खालका दुईओटा परीक्षामा वा एउटा परीक्षा दुईपटक दिँदा उस्तै अङ्क प्राप्त गर्नु हो" भनी कसले परिभाषित गरेका छन्?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'James S. Ross का अनुसार विश्वसनीयताको अर्थ के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'James S. Ross का अनुसार विश्वसनीयताको अर्थ के हो?', E'एकरूपता हुनु', E'मापनको क्रमभरि सधैं एकरूप हुनु', E'परीक्षा दुईपटक दिँदा उस्तै अङ्क प्राप्त गर्नु', E'मापनमा भएको भिन्नतालाई जनाउनु', E'A', E'**James S. Ross का अनुसार विश्वसनीयताको अर्थ एकरूपता हुनु हो।**\\n- L.J. Cronbach ले विश्वसनीयतालाई मापनको क्रमभरि सधैं एकरूप हुनु भनेका छन्।\\n- Brown ले विश्वसनीयतालाई परीक्षा दुईपटक दिँदा उस्तै अङ्क प्राप्त गर्नु भनेका छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:James S. Ross का अनुसार विश्वसनीयताको अर्थ के हो?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'Ebel का अनुसार विश्वसनीयताको अर्थ के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'Ebel का अनुसार विश्वसनीयताको अर्थ के हो?', E'एउटा परीक्षाको अङ्कको मापन जहाँसुकै मापन गरे पनि एकरूपता हुनु', E'परीक्षाको नतिजामा भिन्नता आउनु', E'मापनको तह जनाउनु', E'मापनको आधार परिवर्तन गर्नु', E'A', E'**Ebel का अनुसार विश्वसनीयताको अर्थ एउटा परीक्षाको अङ्कको मापन जहाँसुकै मापन गरे पनि एकरूपता हुनु हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:Ebel का अनुसार विश्वसनीयताको अर्थ के हो?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नरम्यान इ. ग्रोन्ल्याण्ड (Norman E. Gronlund) का अनुसार विश्वसनीयताले के जनाउँछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'नरम्यान इ. ग्रोन्ल्याण्ड (Norman E. Gronlund) का अनुसार विश्वसनीयताले के जनाउँछ?', E'मापनमा भएको एकरूपतालाई', E'मापनमा भएको भिन्नतालाई', E'परीक्षाको कठिनाइस्तरलाई', E'परीक्षाको वैधतालाई', E'A', E'**नरम्यान इ. ग्रोन्ल्याण्ड (Norman E. Gronlund) का अनुसार विश्वसनीयताले मापनमा भएको एकरूपतालाई जनाउँछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नरम्यान इ. ग्रोन्ल्याण्ड (Norman E. Gronlund) का अनुसार विश्वसनीयताले के जनाउँछ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'अनान्सटसी (Anastasi) का अनुसार विश्वसनीयता कहिले हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'अनान्सटसी (Anastasi) का अनुसार विश्वसनीयता कहिले हुन्छ?', E'कुनै परीक्षणमा विभिन्न अवस्था र अवसरहरूमा एउटै किसिमको परीक्षणका प्राप्ताङ्कहरूबिच सङ्गति हुँदा', E'परीक्षा कठिन हुँदा', E'परीक्षार्थी संख्या बढी हुँदा', E'परीक्षा छोटो हुँदा', E'A', E'**अनान्सटसी (Anastasi) का अनुसार कुनै परीक्षणमा विभिन्न अवस्था एवम् अवसरहरूमा एउटै किसिमको परीक्षणका प्राप्ताङ्कहरूबिच सङ्गति हुन्छ भने त्यो परीक्षणमा विश्वसनीयता हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:अनान्सटसी (Anastasi) का अनुसार विश्वसनीयता कहिले हुन्छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'एउटै परीक्षण एक पटक एउटा समूहमा लिई केही समयको अन्तरालमा त्यही समूहलाई त्यही परीक्षण पुनः लिने विश्वसनीयता गणना विधिलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'एउटै परीक्षण एक पटक एउटा समूहमा लिई केही समयको अन्तरालमा त्यही समूहलाई त्यही परीक्षण पुनः लिने विश्वसनीयता गणना विधिलाई के भनिन्छ?', E'समानान्तर प्रारूप विधि', E'परीक्षण-पुनः परीक्षण विधि (Test-Retest Method)', E'अर्ध विभाजन विधि', E'कुडर रिचार्डसनको सूत्र', E'B', E'**एउटै परीक्षण एक पटक एउटा समूहमा लिई केही समयको अन्तरालमा त्यही समूहलाई त्यही परीक्षण पुनः लिने विधिलाई परीक्षण-पुनः परीक्षण विधि (Test-Retest Method) भनिन्छ।**\\n- समानान्तर प्रारूप विधिमा दुई सेट प्रश्न तयार गरी एउटै समूहलाई पालैपालो दिइन्छ।\\n- अर्ध विभाजन विधिमा एउटा परीक्षणलाई बराबरी दुई भागमा विभाजन गरिन्छ।\\n- कुडर रिचार्डसनको सूत्र प्रयोग गरेर पूर्ण प्रश्नपत्रको विश्वसनीयता निकालिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:एउटै परीक्षण एक पटक एउटा समूहमा लिई केही समयको अन्तरालमा त्यही समूहलाई त्यही परीक्षण पुनः लिने विश्वसनीयता गणना विधिलाई के भनिन्छ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दुई सेट प्रश्न तयार गरी एउटा समूहलाई ती प्रश्न पालैपालो केही समयको अन्तरालमा वा उतिखेरै जाँच दिन लगाउने विश्वसनीयता गणना विधिलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'दुई सेट प्रश्न तयार गरी एउटा समूहलाई ती प्रश्न पालैपालो केही समयको अन्तरालमा वा उतिखेरै जाँच दिन लगाउने विश्वसनीयता गणना विधिलाई के भनिन्छ?', E'समानान्तर प्रारूप विधि (Parallel Form Method)', E'परीक्षण-पुनः परीक्षण विधि', E'अर्ध विभाजन विधि', E'कुडर रिचार्डसनको सूत्र', E'A', E'**दुई सेट प्रश्न तयार गरी एउटा समूहलाई ती प्रश्न पालैपालो जाँच दिन लगाउने विधिलाई समानान्तर प्रारूप विधि (Parallel Form Method) भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दुई सेट प्रश्न तयार गरी एउटा समूहलाई ती प्रश्न पालैपालो केही समयको अन्तरालमा वा उतिखेरै जाँच दिन लगाउने विश्वसनीयता गणना विधिलाई के भनिन्छ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'एउटा परीक्षणलाई बराबरी दुई भागमा विभाजन गरी दुई अलग-अलग भागबाट प्राप्त प्राप्ताङ्कको सहसम्बन्धका आधारमा विश्वसनीयता निकाल्ने विधिलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'एउटा परीक्षणलाई बराबरी दुई भागमा विभाजन गरी दुई अलग-अलग भागबाट प्राप्त प्राप्ताङ्कको सहसम्बन्धका आधारमा विश्वसनीयता निकाल्ने विधिलाई के भनिन्छ?', E'परीक्षण-पुनः परीक्षण विधि', E'समानान्तर प्रारूप विधि', E'अर्ध विभाजन विधि (Split-Half Method)', E'कुडर रिचार्डसनको सूत्र', E'C', E'**एउटा परीक्षणलाई बराबरी दुई भागमा विभाजन गरी दुई अलग-अलग भागबाट प्राप्त प्राप्ताङ्कको सहसम्बन्धका आधारमा विश्वसनीयता निकाल्ने विधिलाई अर्ध विभाजन विधि (Split-Half Method) भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:एउटा परीक्षणलाई बराबरी दुई भागमा विभाजन गरी दुई अलग-अलग भागबाट प्राप्त प्राप्ताङ्कको सहसम्बन्धका आधारमा विश्वसनीयता निकाल्ने विधिलाई के भनिन्छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'KR-20 र KR-21 सूत्र प्रयोग गरेर पूर्ण प्रश्नपत्रको विश्वसनीयता निकाल्ने विधिलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'KR-20 र KR-21 सूत्र प्रयोग गरेर पूर्ण प्रश्नपत्रको विश्वसनीयता निकाल्ने विधिलाई के भनिन्छ?', E'परीक्षण-पुनः परीक्षण विधि', E'समानान्तर प्रारूप विधि', E'अर्ध विभाजन विधि', E'कुडर रिचार्डसनको सूत्र (Kuder-Richardson Formula)', E'D', E'**KR-20 र KR-21 सूत्र प्रयोग गरेर पूर्ण प्रश्नपत्रको विश्वसनीयता निकाल्ने विधिलाई कुडर रिचार्डसनको सूत्र (Kuder-Richardson Formula) भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:KR-20 र KR-21 सूत्र प्रयोग गरेर पूर्ण प्रश्नपत्रको विश्वसनीयता निकाल्ने विधिलाई के भनिन्छ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विश्वसनीयता गणना गर्न आवश्यक तथ्याङ्क सामान्यतया कसरी प्राप्त गर्न सकिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'विश्वसनीयता गणना गर्न आवश्यक तथ्याङ्क सामान्यतया कसरी प्राप्त गर्न सकिन्छ?', E'एउटै परीक्षणबाट प्राप्त गर्न सकिन्छ', E'धेरै भिन्न परीक्षणबाट मात्र प्राप्त गर्न सकिन्छ', E'कहिल्यै प्राप्त गर्न सकिँदैन', E'केवल मौखिक अन्तर्वार्ताबाट मात्र प्राप्त हुन्छ', E'A', E'**विश्वसनीयता गणना गर्न आवश्यक तथ्याङ्क एउटै परीक्षणबाट प्राप्त गर्न सकिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विश्वसनीयता गणना गर्न आवश्यक तथ्याङ्क सामान्यतया कसरी प्राप्त गर्न सकिन्छ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विश्वसनीयता (Reliability) कस्तो प्रकारको परीक्षणका लागि त्यति उपयोगी हुँदैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'विश्वसनीयता (Reliability) कस्तो प्रकारको परीक्षणका लागि त्यति उपयोगी हुँदैन?', E'गति परीक्षण (Speed Test)', E'उपलब्धि परीक्षण', E'व्यक्तित्व परीक्षण', E'अभिरुचि परीक्षण', E'A', E'**विश्वसनीयता गति परीक्षण (Speed Test) का लागि त्यति उपयोगी हुँदैन।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विश्वसनीयता (Reliability) कस्तो प्रकारको परीक्षणका लागि त्यति उपयोगी हुँदैन?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विश्वसनीयताको एउटा विशेषता के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'विश्वसनीयताको एउटा विशेषता के हो?', E'यो आन्तरिक एकरूपता मापन गर्न उपयोगी हुन्छ', E'यो सधैं महँगो र जटिल हुन्छ', E'यसलाई गणना गर्न असम्भव छ', E'यो केवल बुद्धि परीक्षणमा मात्र लागू हुन्छ', E'A', E'**विश्वसनीयता आन्तरिक एकरूपता मापन गर्न उपयोगी हुन्छ; यो गणना गर्ने छिटो विधि पनि हो र समयको हिसाबले मितव्ययी हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विश्वसनीयताको एउटा विशेषता के हो?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: वैधता, विशिष्टीकरण तालिका र प्रश्न विश्लेषण (आधारभूत तह) (14 Q)
  v_set_id := extensions.uuid_generate_v5('13fd152a-d851-41bb-81f2-a8278052af6f'::uuid, E'वैधता, विशिष्टीकरण तालिका र प्रश्न विश्लेषण (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '33e33b97-b080-4e2e-9c20-198b6cba350b'::uuid, '13fd152a-d851-41bb-81f2-a8278052af6f'::uuid, E'वैधता, विशिष्टीकरण तालिका र प्रश्न विश्लेषण (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '13fd152a-d851-41bb-81f2-a8278052af6f'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै परीक्षणले जुन गुणको मापन गर्नुपर्ने हो त्यही गुण मात्र सही मापन गर्न सक्दा त्यस परीक्षणलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'कुनै परीक्षणले जुन गुणको मापन गर्नुपर्ने हो त्यही गुण मात्र सही मापन गर्न सक्दा त्यस परीक्षणलाई के भनिन्छ?', E'विश्वसनीय परीक्षण', E'वैध परीक्षण (Valid Test)', E'वस्तुनिष्ठ परीक्षण', E'व्यावहारिक परीक्षण', E'B', E'**कुनै परीक्षणले जुन गुणको मापन गर्नुपर्ने हो त्यही गुण मात्र सही मापन गर्न सक्दा त्यस परीक्षणलाई वैध परीक्षण (Valid Test) भनिन्छ।**\\n- विश्वसनीयता भने परीक्षाको नतिजामा एकरूपता आउने गुण हो, वैधता होइन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै परीक्षणले जुन गुणको मापन गर्नुपर्ने हो त्यही गुण मात्र सही मापन गर्न सक्दा त्यस परीक्षणलाई के भनिन्छ?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वैधता (Validity) लाई कसरी प्रस्तुत गरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'वैधता (Validity) लाई कसरी प्रस्तुत गरिन्छ?', E'मात्राको रूपमा (जस्तै ० वा १०० प्रतिशत)', E'तुलनात्मक स्तरको रूपमा', E'केवल हो/होइन भनेर', E'कुनै प्रस्तुतिको आवश्यकता पर्दैन', E'B', E'**वैधतालाई मात्राको रूपमा प्रस्तुत नगरेर तुलनात्मक स्तरको रूपमा प्रस्तुत गरिन्छ।**\\nनोट: वैधताको पनि मात्रा हुन्छ, तर यसलाई ० वा १०० प्रतिशत भनेर टुङ्ग्याउन सकिँदैन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वैधता (Validity) लाई कसरी प्रस्तुत गरिन्छ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वैधता र विश्वसनीयतामध्ये कुन गुण बढी महत्त्वपूर्ण मानिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'वैधता र विश्वसनीयतामध्ये कुन गुण बढी महत्त्वपूर्ण मानिन्छ?', E'विश्वसनीयता', E'वैधता', E'दुवै समान महत्त्वका छन्', E'कुनैको महत्त्व छैन', E'B', E'**वैधता विश्वसनीयताको तुलनामा बढी महत्त्वपूर्ण गुण हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वैधता र विश्वसनीयतामध्ये कुन गुण बढी महत्त्वपूर्ण मानिन्छ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वैधतालाई अर्को कुन शब्दले पनि चिनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'वैधतालाई अर्को कुन शब्दले पनि चिनिन्छ?', E'प्रामाणिकता', E'एकरूपता', E'वस्तुनिष्ठता', E'व्यावहारिकता', E'A', E'**वैधतालाई अर्को शब्दमा प्रामाणिकता पनि भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वैधतालाई अर्को कुन शब्दले पनि चिनिन्छ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वैधता किन निश्चित (fixed) हुँदैन भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'वैधता किन निश्चित (fixed) हुँदैन भनिन्छ?', E'किनभने वैधता स्थापित गर्ने विधि नै निश्चित छैन', E'किनभने परीक्षा सधैं परिवर्तन हुन्छ', E'किनभने विद्यार्थी संख्या फरक हुन्छ', E'किनभने शिक्षक फरक हुन्छन्', E'A', E'**वैधता निश्चित हुँदैन, किनभने वैधता स्थापित गर्ने विधि नै निश्चित छैन।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वैधता किन निश्चित (fixed) हुँदैन भनिन्छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'मापनका साधनको उत्तर जहाँ लगेर परीक्षण गरे पनि उस्तै नतिजा निस्कने गुणलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'मापनका साधनको उत्तर जहाँ लगेर परीक्षण गरे पनि उस्तै नतिजा निस्कने गुणलाई के भनिन्छ?', E'वैधता', E'विश्वसनीयता', E'वस्तुनिष्ठता (Objectivity)', E'उपयोगिता', E'C', E'**मापनका साधनको उत्तर जहाँ लगेर परीक्षण गरे पनि उस्तै नतिजा निस्कने गुणलाई वस्तुनिष्ठता (Objectivity) भनिन्छ।**\\n- वैधताले परीक्षणले जुन गुण मापन गर्नुपर्ने हो त्यही मापन गरे-नगरेको जनाउँछ।\\n- विश्वसनीयताले परीक्षाको नतिजामा एकरूपता जनाउँछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:मापनका साधनको उत्तर जहाँ लगेर परीक्षण गरे पनि उस्तै नतिजा निस्कने गुणलाई के भनिन्छ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'मूल्याङ्कनका साधन सञ्चालन गर्न, परीक्षण गर्न र अङ्कन गर्न सकिने गुणलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'मूल्याङ्कनका साधन सञ्चालन गर्न, परीक्षण गर्न र अङ्कन गर्न सकिने गुणलाई के भनिन्छ?', E'वैधता', E'व्यावहारिकता (Practicality)', E'विश्वसनीयता', E'वस्तुनिष्ठता', E'B', E'**मूल्याङ्कनका साधन सञ्चालन गर्न, परीक्षण गर्न र अङ्कन गर्न सकिने गुणलाई व्यावहारिकता (Practicality) भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:मूल्याङ्कनका साधन सञ्चालन गर्न, परीक्षण गर्न र अङ्कन गर्न सकिने गुणलाई के भनिन्छ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'मूल्याङ्कन सञ्चालन र प्रयोग गर्न सजिलो हुने गुणलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'मूल्याङ्कन सञ्चालन र प्रयोग गर्न सजिलो हुने गुणलाई के भनिन्छ?', E'उपयोगिता (Usability)', E'वैधता', E'विश्वसनीयता', E'वस्तुनिष्ठता', E'A', E'**मूल्याङ्कन सञ्चालन र प्रयोग गर्न सजिलो हुने गुणलाई उपयोगिता (Usability) भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:मूल्याङ्कन सञ्चालन र प्रयोग गर्न सजिलो हुने गुणलाई के भनिन्छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विशिष्टीकरण तालिका (Table of Specification) कस्तो प्रकारको तालिका हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'विशिष्टीकरण तालिका (Table of Specification) कस्तो प्रकारको तालिका हो?', E'एक-आयामिक तालिका', E'दुई-आयामिक तालिका', E'तीन-आयामिक तालिका', E'आयाम नभएको तालिका', E'B', E'**विशिष्टीकरण तालिकाको निर्माण दुई-आयामिक तालिका हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विशिष्टीकरण तालिका (Table of Specification) कस्तो प्रकारको तालिका हो?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विशिष्टीकरण तालिकामा के-के सुनिश्चित गरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'विशिष्टीकरण तालिकामा के-के सुनिश्चित गरिन्छ?', E'विषयवस्तु, शैक्षिक उद्देश्य र प्रश्नको सङ्ख्या तथा किसिम', E'केवल विद्यार्थी सङ्ख्या', E'केवल परीक्षा मिति', E'केवल परीक्षा केन्द्र', E'A', E'**विशिष्टीकरण तालिकामा विषयवस्तु, त्यसका शैक्षिक उद्देश्यहरू, ती उद्देश्य मापन गर्नका लागि आवश्यक प्रश्नको सङ्ख्या र किसिम सुनिश्चित गरिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विशिष्टीकरण तालिकामा के-के सुनिश्चित गरिन्छ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विशिष्टीकरण तालिकाले परीक्षणको के सुनिश्चित गर्दछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'विशिष्टीकरण तालिकाले परीक्षणको के सुनिश्चित गर्दछ?', E'विषयगत वैधता', E'विश्वसनीयता मात्र', E'परीक्षा केन्द्र', E'प्रश्नपत्रको मूल्य', E'A', E'**विशिष्टीकरण तालिकाले परीक्षणको विषयगत वैधता सुनिश्चित गर्दछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विशिष्टीकरण तालिकाले परीक्षणको के सुनिश्चित गर्दछ?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै प्रश्नले राम्रो र नराम्रो (उच्च र निम्न क्षमताका) विद्यार्थीलाई छुट्याउन सक्ने क्षमतालाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'कुनै प्रश्नले राम्रो र नराम्रो (उच्च र निम्न क्षमताका) विद्यार्थीलाई छुट्याउन सक्ने क्षमतालाई के भनिन्छ?', E'कठिनाइस्तर', E'विभेदीकरण (Discrimination)', E'वैधता', E'वस्तुनिष्ठता', E'B', E'**कुनै प्रश्नले राम्रो र नराम्रो विद्यार्थीलाई छुट्याउन सक्ने क्षमतालाई विभेदीकरण (Discrimination) भनिन्छ।**\\n- कठिनाइस्तरले भने प्रश्न कति कठिन वा सजिलो छ भन्ने जनाउँछ, विद्यार्थी छुट्याउने क्षमता होइन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै प्रश्नले राम्रो र नराम्रो (उच्च र निम्न क्षमताका) विद्यार्थीलाई छुट्याउन सक्ने क्षमतालाई के भनिन्छ?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'माथिल्लो क्षमता समूह र तल्लो क्षमता समूहका विद्यार्थी सङ्ख्या लिँदा दुवै समूहमा कुल परीक्षार्थीको कति प्रतिशत लिन उपयुक्त हुन्छ भन्ने मत तथ्याङ्कशास्त्री रोनाल्ड फिसरको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'माथिल्लो क्षमता समूह र तल्लो क्षमता समूहका विद्यार्थी सङ्ख्या लिँदा दुवै समूहमा कुल परीक्षार्थीको कति प्रतिशत लिन उपयुक्त हुन्छ भन्ने मत तथ्याङ्कशास्त्री रोनाल्ड फिसरको छ?', E'१५ प्रतिशत', E'२७ प्रतिशत', E'४० प्रतिशत', E'५० प्रतिशत', E'B', E'**माथिल्लो क्षमता समूह र तल्लो क्षमता समूहका विद्यार्थी सङ्ख्या लिँदा दुवै समूहमा कुल परीक्षार्थीको २७ प्रतिशत लिन उपयुक्त हुन्छ भन्ने तथ्याङ्कशास्त्री रोनाल्ड फिसरको मत रहेको छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:माथिल्लो क्षमता समूह र तल्लो क्षमता समूहका विद्यार्थी सङ्ख्या लिँदा दुवै समूहमा कुल परीक्षार्थीको कति प्रतिशत लिन उपयुक्त हुन्छ भन्ने मत तथ्याङ्कशास्त्री रोनाल्ड फिसरको छ?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'व्यापकताका लागि प्रश्नपत्रमा प्रश्नहरूको सङ्ख्या कस्तो हुनुपर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'व्यापकताका लागि प्रश्नपत्रमा प्रश्नहरूको सङ्ख्या कस्तो हुनुपर्छ?', E'धेरै हुनुपर्छ', E'कम हुनुपर्छ', E'एउटा मात्र हुनुपर्छ', E'कुनै मापदण्ड छैन', E'A', E'**व्यापकताका लागि प्रश्नपत्रमा प्रश्नहरूको सङ्ख्या धेरै हुनुपर्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:व्यापकताका लागि प्रश्नपत्रमा प्रश्नहरूको सङ्ख्या कस्तो हुनुपर्छ?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: निरन्तर विद्यार्थी मूल्याङ्कन प्रणाली (CAS) (आधारभूत तह) (13 Q)
  v_set_id := extensions.uuid_generate_v5('47b7b17e-774a-4b15-8720-aa233edf30f8'::uuid, E'निरन्तर विद्यार्थी मूल्याङ्कन प्रणाली (CAS) (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '33e33b97-b080-4e2e-9c20-198b6cba350b'::uuid, '47b7b17e-774a-4b15-8720-aa233edf30f8'::uuid, E'निरन्तर विद्यार्थी मूल्याङ्कन प्रणाली (CAS) (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '47b7b17e-774a-4b15-8720-aa233edf30f8'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'निरन्तर विद्यार्थी मूल्याङ्कन प्रणाली (Continuous Assessment System) लाई छोटकरीमा के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'निरन्तर विद्यार्थी मूल्याङ्कन प्रणाली (Continuous Assessment System) लाई छोटकरीमा के भनिन्छ?', E'CBS', E'CAS', E'CES', E'SAS', E'B', E'**निरन्तर विद्यार्थी मूल्याङ्कनलाई अङ्ग्रेजीमा Continuous Assessment System (CAS) भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:निरन्तर विद्यार्थी मूल्याङ्कन प्रणाली (Continuous Assessment System) लाई छोटकरीमा के भनिन्छ?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालमा निरन्तर विद्यार्थी मूल्याङ्कन र उदार कक्षोन्नति प्रणाली कक्षा १ देखि ३ सम्म पहिलोपटक कति जिल्लामा परीक्षणका रूपमा लागू गरिएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'नेपालमा निरन्तर विद्यार्थी मूल्याङ्कन र उदार कक्षोन्नति प्रणाली कक्षा १ देखि ३ सम्म पहिलोपटक कति जिल्लामा परीक्षणका रूपमा लागू गरिएको थियो?', E'३', E'५', E'७', E'१०', E'B', E'**वि.सं. २०५७/०५८ देखि ५ जिल्ला — इलाम, चितवन, स्याङ्जा, सुर्खेत र कञ्चनपुरमा कक्षा १ देखि ३ सम्म निरन्तर विद्यार्थी मूल्याङ्कन र उदार कक्षोन्नति प्रणाली परीक्षणका रूपमा लागू गरिएको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालमा निरन्तर विद्यार्थी मूल्याङ्कन र उदार कक्षोन्नति प्रणाली कक्षा १ देखि ३ सम्म पहिलोपटक कति जिल्लामा परीक्षणका रूपमा लागू गरिएको थियो?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'निम्नमध्ये कुन जिल्लामा निरन्तर विद्यार्थी मूल्याङ्कन प्रणाली सुरुमा (वि.सं. २०५७) लागू भएको थिएन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'निम्नमध्ये कुन जिल्लामा निरन्तर विद्यार्थी मूल्याङ्कन प्रणाली सुरुमा (वि.सं. २०५७) लागू भएको थिएन?', E'इलाम', E'चितवन', E'काठमाडौं', E'कञ्चनपुर', E'C', E'**इलाम, चितवन, स्याङ्जा, सुर्खेत र कञ्चनपुरमा निरन्तर विद्यार्थी मूल्याङ्कन प्रणाली सुरुमा लागू भएको थियो।**\\n- काठमाडौं यी सुरुका ५ जिल्लामा पर्दैन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:निम्नमध्ये कुन जिल्लामा निरन्तर विद्यार्थी मूल्याङ्कन प्रणाली सुरुमा (वि.सं. २०५७) लागू भएको थिएन?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नवौं पञ्चवर्षीय योजनाको नीतिगत व्यवस्थाअनुसार वि.सं. २०५७ बाट ती ५ जिल्लाका करिब कति विद्यालयमा निरन्तर विद्यार्थी मूल्याङ्कन प्रणाली लागू गरिएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'नवौं पञ्चवर्षीय योजनाको नीतिगत व्यवस्थाअनुसार वि.सं. २०५७ बाट ती ५ जिल्लाका करिब कति विद्यालयमा निरन्तर विद्यार्थी मूल्याङ्कन प्रणाली लागू गरिएको थियो?', E'५००', E'१,०००', E'२,०००', E'५,०००', E'C', E'**नवौं पञ्चवर्षीय योजनाको नीतिगत व्यवस्थाअनुसार वि.सं. २०५७ बाट इलाम, चितवन, स्याङ्जा, सुर्खेत र कञ्चनपुरका करिब २,००० विद्यालयमा निरन्तर विद्यार्थी मूल्याङ्कन प्रणाली लागू गरिएको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नवौं पञ्चवर्षीय योजनाको नीतिगत व्यवस्थाअनुसार वि.सं. २०५७ बाट ती ५ जिल्लाका करिब कति विद्यालयमा निरन्तर विद्यार्थी मूल्याङ्कन प्रणाली लागू गरिएको थियो?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'निरन्तर विद्यार्थी मूल्याङ्कन प्रणाली (CAS) मुख्यतया के गर्ने प्रणाली हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'निरन्तर विद्यार्थी मूल्याङ्कन प्रणाली (CAS) मुख्यतया के गर्ने प्रणाली हो?', E'विद्यार्थीको लगातार मूल्याङ्कन गर्ने', E'वर्षको अन्त्यमा मात्र एकपटक मूल्याङ्कन गर्ने', E'विद्यार्थी छनोट गर्ने', E'शिक्षक नियुक्ति गर्ने', E'A', E'**निरन्तर विद्यार्थी मूल्याङ्कन प्रणाली विद्यार्थीको लगातार मूल्याङ्कन गर्ने प्रणाली हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:निरन्तर विद्यार्थी मूल्याङ्कन प्रणाली (CAS) मुख्यतया के गर्ने प्रणाली हो?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'निरन्तर विद्यार्थी मूल्याङ्कनले विद्यार्थीको सिकाइ कम भएको क्षेत्रमा के गर्ने अवसर दिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'निरन्तर विद्यार्थी मूल्याङ्कनले विद्यार्थीको सिकाइ कम भएको क्षेत्रमा के गर्ने अवसर दिन्छ?', E'समयमै पुनर्बलीकरण गरी सुधारात्मक शिक्षण गर्ने', E'विद्यार्थीलाई कक्षाबाट हटाउने', E'परीक्षा नै रद्द गर्ने', E'विद्यालय बन्द गर्ने', E'A', E'**निरन्तर विद्यार्थी मूल्याङ्कनले विद्यार्थीको सिकाइ कम भएको क्षेत्रमा समयमै पुनर्बलीकरण गरी सुधारात्मक शिक्षण गर्ने अवसर दिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:निरन्तर विद्यार्थी मूल्याङ्कनले विद्यार्थीको सिकाइ कम भएको क्षेत्रमा के गर्ने अवसर दिन्छ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'निरन्तर विद्यार्थी मूल्याङ्कनले विद्यार्थीको सिकाइ उपलब्धिको कुन गुणमा सुधार गर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'निरन्तर विद्यार्थी मूल्याङ्कनले विद्यार्थीको सिकाइ उपलब्धिको कुन गुणमा सुधार गर्छ?', E'वैधता र विश्वसनीयता', E'मूल्य र लागत', E'आयु र लिङ्ग', E'रङ र आकार', E'A', E'**निरन्तर विद्यार्थी मूल्याङ्कनले विद्यार्थीको सिकाइ उपलब्धिको वैधता र विश्वसनीयतामा सुधार गर्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:निरन्तर विद्यार्थी मूल्याङ्कनले विद्यार्थीको सिकाइ उपलब्धिको कुन गुणमा सुधार गर्छ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यार्थीको सिकाइस्तर पहिचान गर्दा "कमजोर" स्तरलाई कति अङ्क दिइन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'विद्यार्थीको सिकाइस्तर पहिचान गर्दा "कमजोर" स्तरलाई कति अङ्क दिइन्छ?', E'१', E'२', E'३', E'४', E'A', E'**विद्यार्थीको सिकाइस्तर पहिचान गर्दा कमजोरलाई १, सामान्यलाई २, राम्रोलाई ३ र उच्चलाई ४ अङ्क दिइन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यार्थीको सिकाइस्तर पहिचान गर्दा "कमजोर" स्तरलाई कति अङ्क दिइन्छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यार्थीको सिकाइस्तर पहिचान गर्दा "उच्च" स्तरलाई कति अङ्क दिइन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'विद्यार्थीको सिकाइस्तर पहिचान गर्दा "उच्च" स्तरलाई कति अङ्क दिइन्छ?', E'१', E'२', E'३', E'४', E'D', E'**विद्यार्थीको सिकाइस्तर पहिचान गर्दा उच्चलाई ४ अङ्क दिइन्छ; कमजोरलाई १, सामान्यलाई २ र राम्रोलाई ३ अङ्क दिइन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यार्थीको सिकाइस्तर पहिचान गर्दा "उच्च" स्तरलाई कति अङ्क दिइन्छ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'उपलब्धिस्तर ३ प्राप्त गरेको विद्यार्थीलाई के गर्न सहयोग गर्नुपर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'उपलब्धिस्तर ३ प्राप्त गरेको विद्यार्थीलाई के गर्न सहयोग गर्नुपर्छ?', E'उपलब्धिस्तर ४ पुर्‍याउन', E'उपलब्धिस्तर १ मा झार्न', E'परीक्षाबाट हटाउन', E'कक्षा दोहोर्‍याउन', E'A', E'**उपलब्धिस्तर ३ प्राप्त गरेको विद्यार्थीलाई समेत उपलब्धिस्तर ४ पुर्‍याउन सहयोग गर्नुपर्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:उपलब्धिस्तर ३ प्राप्त गरेको विद्यार्थीलाई के गर्न सहयोग गर्नुपर्छ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सुधारात्मक सिकाइपछि के गर्नुपर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'सुधारात्मक सिकाइपछि के गर्नुपर्छ?', E'पुनः विद्यार्थीको मूल्याङ्कन गरी उपलब्धिस्तर निर्धारण गरी पुनः-अभिलेखीकरण गर्नुपर्छ', E'विद्यार्थीलाई मूल्याङ्कनबाट पूर्णतया छुट दिनुपर्छ', E'पुरानो अभिलेख मेटाउनुपर्छ', E'कुनै कार्य गर्नु पर्दैन', E'A', E'**सुधारात्मक सिकाइपछि पुनः विद्यार्थीको मूल्याङ्कन गरी उपलब्धिस्तर निर्धारण गरेर पुनः-अभिलेखीकरण गर्नुपर्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सुधारात्मक सिकाइपछि के गर्नुपर्छ?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पुरानो पाठ्यक्रममा सिकाइ उपलब्धिमा आधारित मूल्याङ्कन रेजा प्रतिशत (५ आधारमा) थियो भने नयाँ पाठ्यक्रममा के छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'पुरानो पाठ्यक्रममा सिकाइ उपलब्धिमा आधारित मूल्याङ्कन रेजा प्रतिशत (५ आधारमा) थियो भने नयाँ पाठ्यक्रममा के छ?', E'उपलब्धि प्रतिशत ४ स्तर', E'रेजा प्रतिशत ६ आधार', E'कुनै मूल्याङ्कन प्रणाली छैन', E'केवल अक्षर ग्रेड मात्र', E'A', E'**पुरानो पाठ्यक्रममा रेजा प्रतिशत (५ आधारमा) सिकाइ उपलब्धिमा आधारित मूल्याङ्कन थियो भने नयाँ पाठ्यक्रममा उपलब्धि प्रतिशत ४ स्तर छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पुरानो पाठ्यक्रममा सिकाइ उपलब्धिमा आधारित मूल्याङ्कन रेजा प्रतिशत (५ आधारमा) थियो भने नयाँ पाठ्यक्रममा के छ?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यालय तहमा पठनपाठन सञ्चालनका लागि सामान्यतया एक घण्टी कति मिनेटको हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'विद्यालय तहमा पठनपाठन सञ्चालनका लागि सामान्यतया एक घण्टी कति मिनेटको हुन्छ?', E'४५ मिनेट', E'५० मिनेट', E'६० मिनेट', E'७५ मिनेट', E'C', E'**विद्यालय तहमा पठनपाठन सञ्चालनका लागि सामान्यतया साठी (६०) मिनेटको एक घन्टी हुने व्यवस्था छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यालय तहमा पठनपाठन सञ्चालनका लागि सामान्यतया एक घण्टी कति मिनेटको हुन्छ?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: लेटर ग्रेडिङ पद्दति — अर्थ, इतिहास र ग्रेड तालिका (आधारभूत तह) (15 Q)
  v_set_id := extensions.uuid_generate_v5('47b7b17e-774a-4b15-8720-aa233edf30f8'::uuid, E'लेटर ग्रेडिङ पद्दति — अर्थ, इतिहास र ग्रेड तालिका (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '33e33b97-b080-4e2e-9c20-198b6cba350b'::uuid, '47b7b17e-774a-4b15-8720-aa233edf30f8'::uuid, E'लेटर ग्रेडिङ पद्दति — अर्थ, इतिहास र ग्रेड तालिका (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '47b7b17e-774a-4b15-8720-aa233edf30f8'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'लेटर ग्रेडिङ (Letter Grading) भनेको के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'लेटर ग्रेडिङ (Letter Grading) भनेको के हो?', E'तोकिएको सक्षमताको मूल्याङ्कनपश्चात् विद्यार्थीले हासिल गर्ने सिकाइस्तरलाई अक्षरमा गरिने प्रस्तुति', E'परीक्षा प्रश्नपत्रको नाम', E'पाठ्यक्रमको एउटा प्रकार', E'शिक्षक तालिमको तरिका', E'A', E'**लेटर ग्रेडिङ भनेको तोकिएको सक्षमताको मूल्याङ्कनपश्चात् विद्यार्थीले हासिल गर्ने सिकाइस्तरलाई अक्षरमा गरिने प्रस्तुति हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:लेटर ग्रेडिङ (Letter Grading) भनेको के हो?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'स्तरीकृत अङ्क (Grade Point) भनेको के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'स्तरीकृत अङ्क (Grade Point) भनेको के हो?', E'अक्षरमा गरिएको विद्यार्थी मूल्याङ्कनको स्तरीकरणलाई अङ्कमा प्रस्तुत गरिएको आनुसाङ्ख्यिक मान', E'विद्यार्थीको उपस्थिति प्रतिशत', E'परीक्षा शुल्क', E'कक्षा कोठाको संख्या', E'A', E'**स्तरीकृत अङ्क (Grade Point) भनेको अक्षरमा गरिएको विद्यार्थी मूल्याङ्कनको स्तरीकरणलाई अङ्कमा प्रस्तुत गरिएको आनुसाङ्ख्यिक मान हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:स्तरीकृत अङ्क (Grade Point) भनेको के हो?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालमा लेटर ग्रेडिङ पद्दति प्रयोग गर्नुपर्ने सिफारिस कुन प्रतिवेदनहरूले गरेका थिए?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'नेपालमा लेटर ग्रेडिङ पद्दति प्रयोग गर्नुपर्ने सिफारिस कुन प्रतिवेदनहरूले गरेका थिए?', E'उच्चस्तरीय राष्ट्रिय शिक्षा आयोगको प्रतिवेदन २०५५ र एस.एल.सी. अध्ययन प्रतिवेदन २०६२', E'राष्ट्रिय शिक्षा नीति २०७६', E'शिक्षा ऐन २०२८', E'शिक्षा नियमावली २०५९', E'A', E'**नेपालमा लेटर ग्रेडिङ पद्दति (अक्षरमापक प्रणाली) प्रयोग गर्नुपर्ने सिफारिस उच्चस्तरीय राष्ट्रिय शिक्षा आयोगको प्रतिवेदन २०५५ र एस.एल.सी. अध्ययन प्रतिवेदन २०६२ (सन् २००५) ले गरेका थिए।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालमा लेटर ग्रेडिङ पद्दति प्रयोग गर्नुपर्ने सिफारिस कुन प्रतिवेदनहरूले गरेका थिए?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'राष्ट्रिय पाठ्यक्रम विकास तथा मूल्याङ्कन परिषद्ले लेटर ग्रेडिङ सम्बन्धमा सैद्धान्तिक निर्णय कुन मिति (वि.सं.) मा गरेको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'राष्ट्रिय पाठ्यक्रम विकास तथा मूल्याङ्कन परिषद्ले लेटर ग्रेडिङ सम्बन्धमा सैद्धान्तिक निर्णय कुन मिति (वि.सं.) मा गरेको थियो?', E'२०७१/३/३०', E'२०७२/८/२३', E'२०५५/१/१', E'२०६३/७/१३', E'A', E'**राष्ट्रिय पाठ्यक्रम विकास तथा मूल्याङ्कन परिषद्को मिति २०७१/३/३० को बैठकले लेटर ग्रेडिङ सम्बन्धमा सैद्धान्तिक रूपमा निर्णय गरेको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:राष्ट्रिय पाठ्यक्रम विकास तथा मूल्याङ्कन परिषद्ले लेटर ग्रेडिङ सम्बन्धमा सैद्धान्तिक निर्णय कुन मिति (वि.सं.) मा गरेको थियो?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यालय शिक्षामा अक्षराङ्कन पद्धति सर्वप्रथम लागू हुँदा ६ ग्रेड कायम गरी कति सामुदायिक विद्यालयमा लागू भएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'विद्यालय शिक्षामा अक्षराङ्कन पद्धति सर्वप्रथम लागू हुँदा ६ ग्रेड कायम गरी कति सामुदायिक विद्यालयमा लागू भएको थियो?', E'५०', E'९९', E'२००', E'५००', E'B', E'**विद्यालय शिक्षामा अक्षराङ्कन पद्धति लागू गर्न परिषद्को निर्णय मिति २०७१ मंसिरमा भई, त्यही वर्षदेखि प्राविधिक धारका ९९ सामुदायिक विद्यालयमा ६ ग्रेड हुने गरी लागू भएको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यालय शिक्षामा अक्षराङ्कन पद्धति सर्वप्रथम लागू हुँदा ६ ग्रेड कायम गरी कति सामुदायिक विद्यालयमा लागू भएको थियो?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यालय शिक्षामा अक्षराङ्कन पद्धति कार्यान्वयन कार्यविधि, २०७२ स्वीकृत भएपछि ग्रेडको संख्या कति कायम गरिएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'विद्यालय शिक्षामा अक्षराङ्कन पद्धति कार्यान्वयन कार्यविधि, २०७२ स्वीकृत भएपछि ग्रेडको संख्या कति कायम गरिएको थियो?', E'६', E'७', E'८', E'९', E'D', E'**विद्यालय शिक्षामा अक्षराङ्कन पद्धति कार्यान्वयन कार्यविधि, २०७२ स्वीकृत गर्ने निकाय राष्ट्रिय पाठ्यक्रम विकास तथा मूल्याङ्कन परिषद् थियो, र यसको स्वीकृति मिति २०७२।०८।२३ मा ९ ग्रेड कायम गरिएको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यालय शिक्षामा अक्षराङ्कन पद्धति कार्यान्वयन कार्यविधि, २०७२ स्वीकृत भएपछि ग्रेडको संख्या कति कायम गरिएको थियो?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'लेटर ग्रेडिङ प्रणालीको पहिलो प्रयोग कुन विश्वविद्यालयमा भएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'लेटर ग्रेडिङ प्रणालीको पहिलो प्रयोग कुन विश्वविद्यालयमा भएको थियो?', E'कोम्ब्रिज विश्वविद्यालय', E'येल विश्वविद्यालय', E'हार्वर्ड विश्वविद्यालय', E'अक्सफोर्ड विश्वविद्यालय', E'B', E'**लेटर ग्रेडिङ प्रणालीको पहिलो प्रयोग येल विश्वविद्यालयमा भएको थियो।**\\n- यसको विकसित प्रयोग विलियम फरिशद्वारा कोम्ब्रिज विश्वविद्यालयमा भएको थियो।\\n- यसको सर्वप्रथम प्रयोग मार्क वि डर्मद्वारा अलाबामाको अथेन्स स्टेट युनिभर्सिटीमा भएको थियो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:लेटर ग्रेडिङ प्रणालीको पहिलो प्रयोग कुन विश्वविद्यालयमा भएको थियो?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'लेटर ग्रेडिङ प्रणालीको विकसित प्रयोग विलियम फरिशद्वारा कुन विश्वविद्यालयमा भएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'लेटर ग्रेडिङ प्रणालीको विकसित प्रयोग विलियम फरिशद्वारा कुन विश्वविद्यालयमा भएको थियो?', E'येल विश्वविद्यालय', E'कोम्ब्रिज विश्वविद्यालय', E'हार्वर्ड विश्वविद्यालय', E'अथेन्स स्टेट युनिभर्सिटी', E'B', E'**लेटर ग्रेडिङ प्रणालीको विकसित प्रयोग विलियम फरिशद्वारा कोम्ब्रिज विश्वविद्यालयमा भएको थियो।**\\n- यसको पहिलो प्रयोग येल विश्वविद्यालयमा भएको थियो।\\n- यसको सर्वप्रथम प्रयोग मार्क वि डर्मद्वारा अथेन्स स्टेट युनिभर्सिटीमा भएको थियो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:लेटर ग्रेडिङ प्रणालीको विकसित प्रयोग विलियम फरिशद्वारा कुन विश्वविद्यालयमा भएको थियो?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'लेटर ग्रेडिङ प्रणालीको सर्वप्रथम प्रयोग मार्क वि डर्मद्वारा कुन विश्वविद्यालयमा भएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'लेटर ग्रेडिङ प्रणालीको सर्वप्रथम प्रयोग मार्क वि डर्मद्वारा कुन विश्वविद्यालयमा भएको थियो?', E'येल विश्वविद्यालय', E'कोम्ब्रिज विश्वविद्यालय', E'अलाबामाको अथेन्स स्टेट युनिभर्सिटी', E'हार्वर्ड विश्वविद्यालय', E'C', E'**लेटर ग्रेडिङ प्रणालीको सर्वप्रथम प्रयोग मार्क वि डर्मद्वारा अलाबामाको अथेन्स स्टेट युनिभर्सिटीमा भएको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:लेटर ग्रेडिङ प्रणालीको सर्वप्रथम प्रयोग मार्क वि डर्मद्वारा कुन विश्वविद्यालयमा भएको थियो?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालमा लेटर ग्रेडिङ प्रणाली कुन साल (वि.सं.) को एस.एल.सी. देखि लागू भएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'नेपालमा लेटर ग्रेडिङ प्रणाली कुन साल (वि.सं.) को एस.एल.सी. देखि लागू भएको थियो?', E'२०६३', E'२०७१', E'२०७२', E'२०७६', E'C', E'**नेपालमा लेटर ग्रेडिङ प्रणाली वि.सं. २०७२ को एस.एल.सी. देखि लागू भएको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालमा लेटर ग्रेडिङ प्रणाली कुन साल (वि.सं.) को एस.एल.सी. देखि लागू भएको थियो?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'लेटर ग्रेडिङ अनुसार ९० प्रतिशत र सोभन्दा माथि प्राप्त गर्ने विद्यार्थीलाई कुन ग्रेड र स्तरीकृत अङ्क दिइन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'लेटर ग्रेडिङ अनुसार ९० प्रतिशत र सोभन्दा माथि प्राप्त गर्ने विद्यार्थीलाई कुन ग्रेड र स्तरीकृत अङ्क दिइन्छ?', E'A+, ४.० (Outstanding)', E'A, ३.६ (Excellent)', E'B+, ३.२ (Very Good)', E'B, २.८ (Good)', E'A', E'**लेटर ग्रेडिङ अनुसार ९० प्रतिशत र सोभन्दा माथि प्राप्त गर्ने विद्यार्थीलाई A+ ग्रेड र ४.० स्तरीकृत अङ्क (सर्वोत्तम/Outstanding) दिइन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:लेटर ग्रेडिङ अनुसार ९० प्रतिशत र सोभन्दा माथि प्राप्त गर्ने विद्यार्थीलाई कुन ग्रेड र स्तरीकृत अङ्क दिइन्छ?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'लेटर ग्रेडिङमा "अत्युत्तम (Excellent)" ग्रेड (A) पाउनका लागि कति प्रतिशत ल्याउनुपर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'लेटर ग्रेडिङमा "अत्युत्तम (Excellent)" ग्रेड (A) पाउनका लागि कति प्रतिशत ल्याउनुपर्छ?', E'९० र सोभन्दा माथि', E'८० र सोभन्दा माथि ९० भन्दा कम', E'७० र सोभन्दा माथि ८० भन्दा कम', E'६० र सोभन्दा माथि ७० भन्दा कम', E'B', E'**८० र सोभन्दा माथि ९० भन्दा कम प्रतिशत ल्याउने विद्यार्थीलाई A ग्रेड (अत्युत्तम/Excellent, स्तरीकृत अङ्क ३.६) दिइन्छ।**\\n- ९० र सोभन्दा माथि ल्याउनेलाई A+ (Outstanding) दिइन्छ।\\n- ७०-८० ल्याउनेलाई B+ (उत्कृष्ट/Very Good) दिइन्छ।\\n- ६०-७० ल्याउनेलाई B (उत्तम/Good) दिइन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:लेटर ग्रेडिङमा "अत्युत्तम (Excellent)" ग्रेड (A) पाउनका लागि कति प्रतिशत ल्याउनुपर्छ?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'लेटर ग्रेडिङमा ३५ प्रतिशतभन्दा कम अङ्क ल्याउने विद्यार्थीलाई कुन ग्रेड दिइन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'लेटर ग्रेडिङमा ३५ प्रतिशतभन्दा कम अङ्क ल्याउने विद्यार्थीलाई कुन ग्रेड दिइन्छ?', E'D (Basic)', E'C (Acceptable)', E'NG (Not Graded/अवर्गीकृत)', E'E (Very Insufficient)', E'C', E'**लेटर ग्रेडिङमा ३५ प्रतिशतभन्दा कम अङ्क ल्याउने विद्यार्थीलाई NG (अवर्गीकृत/Not Graded) दिइन्छ, जसको कुनै स्तरीकृत अङ्क हुँदैन।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:लेटर ग्रेडिङमा ३५ प्रतिशतभन्दा कम अङ्क ल्याउने विद्यार्थीलाई कुन ग्रेड दिइन्छ?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'लेटर ग्रेडिङमा ३५ र सोभन्दा माथि ४० भन्दा कम प्राप्त गर्ने विद्यार्थीलाई कुन ग्रेड दिइन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'लेटर ग्रेडिङमा ३५ र सोभन्दा माथि ४० भन्दा कम प्राप्त गर्ने विद्यार्थीलाई कुन ग्रेड दिइन्छ?', E'C (Acceptable)', E'D (Basic)', E'C+ (Satisfactory)', E'NG', E'B', E'**लेटर ग्रेडिङमा ३५ र सोभन्दा माथि ४० भन्दा कम प्राप्त गर्ने विद्यार्थीलाई D ग्रेड (आधारभूत/Basic, स्तरीकृत अङ्क १.६) दिइन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:लेटर ग्रेडिङमा ३५ र सोभन्दा माथि ४० भन्दा कम प्राप्त गर्ने विद्यार्थीलाई कुन ग्रेड दिइन्छ?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालको अक्षराङ्कन प्रयोगमा प्राविधिक धारका विद्यालयमा सुरुमा कति ग्रेड कायम गरिएको थियो, र पछि कति ग्रेड भयो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'नेपालको अक्षराङ्कन प्रयोगमा प्राविधिक धारका विद्यालयमा सुरुमा कति ग्रेड कायम गरिएको थियो, र पछि कति ग्रेड भयो?', E'सुरुमा ६ ग्रेड, पछि ९ ग्रेड', E'सुरुमा ९ ग्रेड, पछि ६ ग्रेड', E'सुरुमा ५ ग्रेड, पछि ८ ग्रेड', E'सधैं ९ ग्रेड नै रह्यो', E'A', E'**नेपालमा सुरुमा (२०७१ मंसिर) प्राविधिक धारका ९९ सामुदायिक विद्यालयमा ६ ग्रेड हुने गरी लेटर ग्रेडिङ लागू भएको थियो, पछि विद्यालय शिक्षामा अक्षराङ्कन पद्धति कार्यान्वयन कार्यविधि, २०७२ स्वीकृत भएपछि ९ ग्रेड कायम गरियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालको अक्षराङ्कन प्रयोगमा प्राविधिक धारका विद्यालयमा सुरुमा कति ग्रेड कायम गरिएको थियो, र पछि कति ग्रेड भयो?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: लेटर ग्रेडिङ कार्यान्वयन नियम (आधारभूत तह) (11 Q)
  v_set_id := extensions.uuid_generate_v5('47b7b17e-774a-4b15-8720-aa233edf30f8'::uuid, E'लेटर ग्रेडिङ कार्यान्वयन नियम (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '33e33b97-b080-4e2e-9c20-198b6cba350b'::uuid, '47b7b17e-774a-4b15-8720-aa233edf30f8'::uuid, E'लेटर ग्रेडिङ कार्यान्वयन नियम (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '47b7b17e-774a-4b15-8720-aa233edf30f8'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'लेटर ग्रेडिङ कार्यान्वयनको प्रमुख उद्देश्य के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'लेटर ग्रेडिङ कार्यान्वयनको प्रमुख उद्देश्य के हो?', E'विद्यार्थीको सिकाइ सक्षमतालाई यथारूपमा प्रमाणीकरण गर्ने', E'विद्यार्थी संख्या घटाउने', E'शिक्षक तलब निर्धारण गर्ने', E'पाठ्यक्रम खारेज गर्ने', E'A', E'**लेटर ग्रेडिङ कार्यान्वयनको प्रमुख उद्देश्य विद्यार्थीको सिकाइ सक्षमतालाई यथारूपमा प्रमाणीकरण गर्नु हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:लेटर ग्रेडिङ कार्यान्वयनको प्रमुख उद्देश्य के हो?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षक र विद्यार्थीबिचमा प्रत्यक्ष संवाद र सहकार्य गरी गरिने सिकाइसम्बद्ध क्रियाकलाप र अतिरिक्त क्रियाकलापलाई केमा गणना गर्नुपर्ने छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'शिक्षक र विद्यार्थीबिचमा प्रत्यक्ष संवाद र सहकार्य गरी गरिने सिकाइसम्बद्ध क्रियाकलाप र अतिरिक्त क्रियाकलापलाई केमा गणना गर्नुपर्ने छ?', E'पाठ्यघण्टामा', E'परीक्षा शुल्कमा', E'हाजिरी दण्डमा', E'विद्यालय बजेटमा', E'A', E'**शिक्षक र विद्यार्थीबिचमा प्रत्यक्ष संवाद र सहकार्य गरी गरिने सिकाइसम्बद्ध क्रियाकलाप र अतिरिक्त क्रियाकलापलाई पाठ्यघण्टामा गणना गर्नुपर्ने छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षक र विद्यार्थीबिचमा प्रत्यक्ष संवाद र सहकार्य गरी गरिने सिकाइसम्बद्ध क्रियाकलाप र अतिरिक्त क्रियाकलापलाई केमा गणना गर्नुपर्ने छ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'निर्णयात्मक मूल्याङ्कनका लागि लिइने परीक्षामा सहभागी हुन विद्यालय खुलेको वा पठनपाठन भएको कुल दिनको कति प्रतिशत हाजिरी हुनुपर्ने छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'निर्णयात्मक मूल्याङ्कनका लागि लिइने परीक्षामा सहभागी हुन विद्यालय खुलेको वा पठनपाठन भएको कुल दिनको कति प्रतिशत हाजिरी हुनुपर्ने छ?', E'६० प्रतिशत', E'६५ प्रतिशत', E'७५ प्रतिशत', E'९० प्रतिशत', E'C', E'**निर्णयात्मक मूल्याङ्कनका लागि लिइने परीक्षामा सहभागी हुन विद्यालय खुलेको वा पठनपाठन भएको कुल दिनको ७५ प्रतिशत हाजिरी भएको हुनुपर्ने छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:निर्णयात्मक मूल्याङ्कनका लागि लिइने परीक्षामा सहभागी हुन विद्यालय खुलेको वा पठनपाठन भएको कुल दिनको कति प्रतिशत हाजिरी हुनुपर्ने छ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कक्षा आठ, दश र बाह्रमा मूल प्रमाणपत्र कहिले उपलब्ध गराइन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'कक्षा आठ, दश र बाह्रमा मूल प्रमाणपत्र कहिले उपलब्ध गराइन्छ?', E'सबै विषयमा न्यूनतम ग्रेड पूरा गरेपछि मात्र', E'पहिलो त्रैमासिक परीक्षापछि नै', E'दाखिला हुनासाथ', E'उमेर पुगेपछि मात्र', E'A', E'**कक्षा आठ, कक्षा दश र कक्षा बाह्रमा सबै विषयमा न्यूनतम ग्रेड पूरा गरेपछि मात्र सम्बन्धित निकायले मूल प्रमाणपत्र उपलब्ध गराउने व्यवस्था छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कक्षा आठ, दश र बाह्रमा मूल प्रमाणपत्र कहिले उपलब्ध गराइन्छ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विषयगत रूपमा आन्तरिकतर्फ C र सैद्धान्तिकतर्फ D ग्रेड प्राप्त गर्न नसक्ने विद्यार्थीलाई के दिइँदैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'विषयगत रूपमा आन्तरिकतर्फ C र सैद्धान्तिकतर्फ D ग्रेड प्राप्त गर्न नसक्ने विद्यार्थीलाई के दिइँदैन?', E'मूल प्रमाणपत्र', E'ग्रेड सिट', E'पाठ्यपुस्तक', E'कक्षा प्रवेश अनुमति', E'A', E'**विषयगत रूपमा आन्तरिकतर्फ C र सैद्धान्तिकतर्फ D ग्रेड प्राप्त गर्न नसक्ने विद्यार्थीका लागि मूल प्रमाणपत्र उपलब्ध गराइँदैन।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विषयगत रूपमा आन्तरिकतर्फ C र सैद्धान्तिकतर्फ D ग्रेड प्राप्त गर्न नसक्ने विद्यार्थीलाई के दिइँदैन?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'अग्र अध्ययन (उच्च तहको अध्ययन) का लागि के अनिवार्य हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'अग्र अध्ययन (उच्च तहको अध्ययन) का लागि के अनिवार्य हुन्छ?', E'मूल प्रमाणपत्र', E'केवल ग्रेड सिट', E'केवल हाजिरी विवरण', E'केवल शिक्षकको सिफारिस पत्र', E'A', E'**अग्र अध्ययनका लागि मूल प्रमाणपत्र अनिवार्य हुन्छ; मूल प्रमाणपत्र नलिई अग्र अध्ययन गरेमा समकक्षता प्रदान गरिँदैन।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:अग्र अध्ययन (उच्च तहको अध्ययन) का लागि के अनिवार्य हुन्छ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नियमित वा ग्रेड वृद्धि परीक्षामा तोकिएको ग्रेड प्राप्त गर्न नसकेका परीक्षार्थीले सोही विषयमा कति वर्षसम्म वार्षिक परीक्षामा सहभागी हुन पाउने व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'नियमित वा ग्रेड वृद्धि परीक्षामा तोकिएको ग्रेड प्राप्त गर्न नसकेका परीक्षार्थीले सोही विषयमा कति वर्षसम्म वार्षिक परीक्षामा सहभागी हुन पाउने व्यवस्था छ?', E'एक वर्ष', E'दुई वर्ष', E'तीन वर्ष', E'असीमित वर्ष', E'C', E'**नियमित वा ग्रेड वृद्धि परीक्षामा तोकिएको ग्रेड प्राप्त गर्न नसकेका परीक्षार्थीले जुन विषयमा तोकिएको ग्रेड प्राप्त गर्न नसकेको हो सोही विषयमा मात्र तीन वर्षसम्म वार्षिक परीक्षामा सहभागी हुन पाउने छन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नियमित वा ग्रेड वृद्धि परीक्षामा तोकिएको ग्रेड प्राप्त गर्न नसकेका परीक्षार्थीले सोही विषयमा कति वर्षसम्म वार्षिक परीक्षामा सहभागी हुन पाउने व्यवस्था छ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कक्षा १० को अन्त्यको वार्षिक परीक्षामा अनुपस्थित भएको वा अवर्गीकृत (NG) प्राप्त गरेको विद्यार्थीलाई के हुँदैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'कक्षा १० को अन्त्यको वार्षिक परीक्षामा अनुपस्थित भएको वा अवर्गीकृत (NG) प्राप्त गरेको विद्यार्थीलाई के हुँदैन?', E'ग्रेडवृद्धि मौका परीक्षामा सहभागी हुन बाधा पर्दैन', E'पूर्णतया परीक्षाबाट वञ्चित गरिन्छ', E'अर्को विद्यालयमा भर्ना दिइँदैन', E'मूल प्रमाणपत्र स्वतः दिइन्छ', E'A', E'**कक्षा १० को अन्त्यको वार्षिक परीक्षामा अनुपस्थित भएको वा अवर्गीकृत (NG) प्राप्त गरेको विद्यार्थीलाई त्यस्तो विषयमा ग्रेडवृद्धि मौका परीक्षामा सहभागी हुन बाधा पर्दैन।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कक्षा १० को अन्त्यको वार्षिक परीक्षामा अनुपस्थित भएको वा अवर्गीकृत (NG) प्राप्त गरेको विद्यार्थीलाई के हुँदैन?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'लेटर ग्रेडिङबाट प्राप्त ग्रेडको समकक्षता कुन आधारमा निर्धारण गरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'लेटर ग्रेडिङबाट प्राप्त ग्रेडको समकक्षता कुन आधारमा निर्धारण गरिन्छ?', E'मान्यता तथा समकक्षता निर्धारण निर्देशिका', E'व्यक्तिगत शिक्षकको राय', E'अभिभावकको सहमति', E'विद्यार्थीको स्वेच्छा', E'A', E'**लेटर ग्रेडिङबाट प्राप्त ग्रेडको अङ्काङ्कनको समकक्षता माध्यमिक शिक्षासरह मान्यता तथा समकक्षता निर्धारण निर्देशिकामा व्यवस्था भएबमोजिम हुने छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:लेटर ग्रेडिङबाट प्राप्त ग्रेडको समकक्षता कुन आधारमा निर्धारण गरिन्छ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'"लेटर ग्रेडिङ निर्देशिका, २०७८" को हालको अवस्था के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'"लेटर ग्रेडिङ निर्देशिका, २०७८" को हालको अवस्था के हो?', E'खारेज गरिएको छ', E'अझै लागू छ र संशोधन गर्न बाँकी छ', E'कहिल्यै जारी भएकै छैन', E'स्वतः लागू हुनेछ', E'A', E'**लेटर ग्रेडिङ निर्देशिका, २०७८ खारेज गरिएको छ।**\\nनोट: यसको सट्टामा "लेटर ग्रेडिङ निर्देशिका, २०८३" जारी भएको छ, जुन शिक्षा, विज्ञान तथा प्रविधि मन्त्रालयले स्वीकृत गरेको मितिदेखि लागू हुनेछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:"लेटर ग्रेडिङ निर्देशिका, २०७८" को हालको अवस्था के हो?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'"लेटर ग्रेडिङ निर्देशिका, २०८३" कसले स्वीकृत गरेको मितिदेखि लागू हुनेछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'"लेटर ग्रेडिङ निर्देशिका, २०८३" कसले स्वीकृत गरेको मितिदेखि लागू हुनेछ?', E'राष्ट्रिय परीक्षा बोर्डले', E'शिक्षा, विज्ञान तथा प्रविधि मन्त्रालयले', E'पाठ्यक्रम विकास केन्द्रले', E'स्थानीय तहले', E'B', E'**"लेटर ग्रेडिङ निर्देशिका, २०८३" शिक्षा, विज्ञान तथा प्रविधि मन्त्रालयले स्वीकृत गरेको मितिदेखि लागू हुनेछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:"लेटर ग्रेडिङ निर्देशिका, २०८३" कसले स्वीकृत गरेको मितिदेखि लागू हुनेछ?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  RAISE NOTICE 'Unit ख-७ मूल्याङ्कन batch upsert complete: 10 sets, 135 questions.';
END $$;
