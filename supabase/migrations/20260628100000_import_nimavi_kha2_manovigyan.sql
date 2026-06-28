-- Idempotent UPSERT import: निमावि प्रथम पत्र — unit ख-२ शिक्षा मनोविज्ञान (Level I topic-wise sets)
-- Adds redesigned Level I sets alongside preserved model sets. Override same-identity; never deletes. Generated 2026-06-28T04:41:39.580Z.
DO $$
DECLARE
  v_module_id uuid := '6695669a-f40e-421a-a4ec-b09bbeaf56c4'::uuid;
  v_set_id uuid;
  v_q_id uuid;
BEGIN

  -- Set: शैक्षिक मनोविज्ञान — अर्थ, उत्पत्ति र प्रवर्तक (आधारभूत तह — भाग १) (20 Q)
  v_set_id := extensions.uuid_generate_v5('1e24d947-b929-4a1b-a069-d5b1d1136baa'::uuid, E'शैक्षिक मनोविज्ञान — अर्थ, उत्पत्ति र प्रवर्तक (आधारभूत तह — भाग १)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '8dafc3cd-62b2-45e0-905e-aa6c841526f2'::uuid, '1e24d947-b929-4a1b-a069-d5b1d1136baa'::uuid, E'शैक्षिक मनोविज्ञान — अर्थ, उत्पत्ति र प्रवर्तक (आधारभूत तह — भाग १)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '1e24d947-b929-4a1b-a069-d5b1d1136baa'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''Psychology'' (मनोविज्ञान) शब्द कुन भाषाबाट उत्पत्ति भएको हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'''Psychology'' (मनोविज्ञान) शब्द कुन भाषाबाट उत्पत्ति भएको हो?', E'ल्याटिन', E'संस्कृत', E'फ्रान्सेली', E'ग्रीक', E'D', E'**''Psychology'' शब्द ग्रीक (Greek) भाषाको ''Psyche'' र ''Logos'' बाट बनेको हो।**\\n- ल्याटिन भाषाबाट भने ''Education'' (Educatum) जस्ता शिक्षासम्बन्धी शब्दहरू बनेका हुन्।\\n- संस्कृत ''मनस्'' बाट नेपालीमा ''मन'' शब्द आएको हो, तर मनोविज्ञानको मूल शब्द ग्रीक हो।\\nनोट: ''Psyche'' को अर्थ आत्मा र ''Logos'' को अर्थ अध्ययन/विज्ञान हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''Psychology'' (मनोविज्ञान) शब्द कुन भाषाबाट उत्पत्ति भएको हो?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'ग्रीक शब्द ''Psyche'' को शाब्दिक अर्थ के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'ग्रीक शब्द ''Psyche'' को शाब्दिक अर्थ के हो?', E'आत्मा (Soul)', E'मन (Mind)', E'चेतना (Consciousness)', E'व्यवहार (Behavior)', E'A', E'**ग्रीक शब्द ''Psyche'' को शाब्दिक अर्थ आत्मा (Soul) हो।**\\n- मन (Mind) मनोविज्ञानको दोस्रो चरणको अर्थसँग सम्बन्धित छ।\\n- चेतना (Consciousness) मनोविज्ञानको तेस्रो चरणको अर्थ हो।\\n- व्यवहार (Behavior) मनोविज्ञानको वर्तमान अर्थ हो।\\nनोट: ''Logos'' को अर्थ अध्ययन वा विज्ञान भएकाले मनोविज्ञानको आरम्भिक अर्थ ''आत्माको विज्ञान'' थियो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:ग्रीक शब्द ''Psyche'' को शाब्दिक अर्थ के हो?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'मनोविज्ञानको अर्थगत विकासको सही क्रम कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'मनोविज्ञानको अर्थगत विकासको सही क्रम कुन हो?', E'आत्माको विज्ञान → मनको विज्ञान → चेतनाको विज्ञान → व्यवहारको विज्ञान', E'व्यवहारको विज्ञान → चेतनाको विज्ञान → मनको विज्ञान → आत्माको विज्ञान', E'मनको विज्ञान → आत्माको विज्ञान → व्यवहारको विज्ञान → चेतनाको विज्ञान', E'चेतनाको विज्ञान → आत्माको विज्ञान → मनको विज्ञान → व्यवहारको विज्ञान', E'A', E'**मनोविज्ञानको अर्थ क्रमशः आत्माको विज्ञान → मनको विज्ञान → चेतनाको विज्ञान → व्यवहारको विज्ञान हुँदै विकसित भयो।**\\nनोट: उडवर्थका अनुसार मनोविज्ञानले पहिले आत्मा त्याग्यो, त्यसपछि मन त्याग्यो, चेतना त्याग्यो र अन्ततः व्यवहार अपनायो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:मनोविज्ञानको अर्थगत विकासको सही क्रम कुन हो?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'मनोविज्ञानको पिता (Father of Psychology) कसलाई मानिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'मनोविज्ञानको पिता (Father of Psychology) कसलाई मानिन्छ?', E'इ.एल. थर्नडाइक', E'जे.बी. वाट्सन', E'सिग्मण्ड फ्रायड', E'विल्हेल्म वुन्ट', E'D', E'**मनोविज्ञानका पिता र आधुनिक मनोविज्ञानका पिता दुवै विल्हेल्म वुन्ट (Wilhelm Wundt) हुन्।**\\n- इ.एल. थर्नडाइक शिक्षा मनोविज्ञानका पिता हुन्।\\n- जे.बी. वाट्सन व्यवहारवादका पिता हुन्।\\n- सिग्मण्ड फ्रायड मनोविश्लेषणवादका पिता हुन्।\\nनोट: वुन्टले सन् १८७९ मा जर्मनीको लिपजिगमा विश्वको पहिलो मनोविज्ञान प्रयोगशाला स्थापना गरे।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:मनोविज्ञानको पिता (Father of Psychology) कसलाई मानिन्छ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा मनोविज्ञानका पिता (Father of Educational Psychology) कसलाई मानिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'शिक्षा मनोविज्ञानका पिता (Father of Educational Psychology) कसलाई मानिन्छ?', E'विल्हेल्म वुन्ट', E'विलियम जेम्स', E'इ.एल. थर्नडाइक', E'जिन पियाजे', E'C', E'**शिक्षा मनोविज्ञानका पिता इ.एल. थर्नडाइक (E.L. Thorndike) हुन्।**\\n- विल्हेल्म वुन्ट सामान्य मनोविज्ञानका पिता हुन्।\\n- विलियम जेम्स अमेरिकी मनोविज्ञानका पिता हुन्।\\n- जिन पियाजे सञ्ज्ञानवाद (Cognitivism) का पिता हुन्।\\nनोट: थर्नडाइकले सन् १९०३ मा ''Educational Psychology'' पुस्तक प्रकाशित गरे।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा मनोविज्ञानका पिता (Father of Educational Psychology) कसलाई मानिन्छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'अमेरिकी मनोविज्ञानका पिता (Father of American Psychology) कसलाई मानिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'अमेरिकी मनोविज्ञानका पिता (Father of American Psychology) कसलाई मानिन्छ?', E'विलियम जेम्स', E'जोन ड्युयी', E'जे.बी. वाट्सन', E'जी. स्टानले हल', E'A', E'**अमेरिकी मनोविज्ञानका पिता विलियम जेम्स (William James) हुन्।**\\n- जोन ड्युयीले शिकागो विश्वविद्यालयमा पहिलो शैक्षिक मनोविज्ञान प्रयोगशाला स्थापना गरे।\\n- जे.बी. वाट्सन व्यवहारवादका पिता हुन्।\\n- जी. स्टानले हलले अमेरिकामा पहिलो मनोविज्ञान प्रयोगशाला स्थापना गरे।\\nनोट: विलियम जेम्सले सन् १८९९ मा ''Talks to Teachers on Psychology'' पुस्तक लेखे।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:अमेरिकी मनोविज्ञानका पिता (Father of American Psychology) कसलाई मानिन्छ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'व्यवहारवाद (Behaviorism) का पिता कसलाई मानिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'व्यवहारवाद (Behaviorism) का पिता कसलाई मानिन्छ?', E'बी.एफ. स्किनर', E'इभान पाभ्लोव', E'इ.एल. थर्नडाइक', E'जे.बी. वाट्सन', E'D', E'**व्यवहारवादका पिता जे.बी. वाट्सन (J.B. Watson) हुन्।**\\n- बी.एफ. स्किनर क्रियाप्रसूत अनुबन्धन (Operant conditioning) का लागि प्रसिद्ध व्यवहारवादी हुन्।\\n- इभान पाभ्लोव सिद्धान्तप्रसूत अनुबन्धन (Classical conditioning) का प्रतिपादक हुन्।\\n- इ.एल. थर्नडाइक प्रयत्न र भूलको सिद्धान्तका प्रतिपादक हुन्।\\nनोट: वाट्सनले ''मलाई एक दर्जन स्वस्थ शिशु देऊ, म तिमीले जे भन्छौ त्यही बनाइदिन्छु'' भनेका थिए।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:व्यवहारवाद (Behaviorism) का पिता कसलाई मानिन्छ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'मनोविश्लेषणवाद (Psychoanalysis) का पिता कसलाई मानिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'मनोविश्लेषणवाद (Psychoanalysis) का पिता कसलाई मानिन्छ?', E'कार्ल युङ्ग', E'अल्फ्रेड एडलर', E'सिग्मण्ड फ्रायड', E'जे.बी. वाट्सन', E'C', E'**मनोविश्लेषणवादका पिता सिग्मण्ड फ्रायड (Sigmund Freud) हुन्।**\\n- कार्ल युङ्गले विश्लेषणात्मक मनोविज्ञान (Analytical psychology) को विकास गरे।\\n- अल्फ्रेड एडलरले वैयक्तिक मनोविज्ञान (Individual psychology) को विकास गरे।\\n- जे.बी. वाट्सन व्यवहारवादका पिता हुन्।\\nनोट: मनोविश्लेषणवादले अचेतन मन (Unconscious mind) को अध्ययन गर्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:मनोविश्लेषणवाद (Psychoanalysis) का पिता कसलाई मानिन्छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सञ्ज्ञानवाद (Cognitivism) का पिता कसलाई मानिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'सञ्ज्ञानवाद (Cognitivism) का पिता कसलाई मानिन्छ?', E'जिन पियाजे', E'जेरोम ब्रुनर', E'लेभ वाइगोत्स्की', E'सिग्मण्ड फ्रायड', E'A', E'**सञ्ज्ञानवादका पिता जिन पियाजे (Jean Piaget) हुन्।**\\n- जेरोम ब्रुनरले खोज सिकाइ (Discovery learning) को अवधारणा दिए।\\n- लेभ वाइगोत्स्कीले सामाजिक-सांस्कृतिक सिकाइ सिद्धान्त दिए।\\n- सिग्मण्ड फ्रायड मनोविश्लेषणवादका पिता हुन्।\\nनोट: पियाजेले सञ्ज्ञानात्मक विकासका चार चरण प्रतिपादन गरे।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सञ्ज्ञानवाद (Cognitivism) का पिता कसलाई मानिन्छ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विश्वको पहिलो मनोविज्ञान प्रयोगशाला कुन सालमा स्थापना भएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'विश्वको पहिलो मनोविज्ञान प्रयोगशाला कुन सालमा स्थापना भएको थियो?', E'सन् १८७९', E'सन् १८८३', E'सन् १८९०', E'सन् १९००', E'A', E'विल्हेल्म वुन्टले सन् **१८७९** मा जर्मनीको लिपजिग (Leipzig) विश्वविद्यालयमा विश्वको पहिलो मनोविज्ञान प्रयोगशाला स्थापना गरेका थिए। यही घटनालाई मनोविज्ञानलाई स्वतन्त्र विज्ञानको रूपमा स्थापित गर्ने कोशेढुङ्गा मानिन्छ।\\nनोट: अमेरिकामा भने जी. स्टानले हलले सन् १८८३ मा पहिलो प्रयोगशाला स्थापना गरे।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विश्वको पहिलो मनोविज्ञान प्रयोगशाला कुन सालमा स्थापना भएको थियो?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'अमेरिकाको पहिलो मनोविज्ञान प्रयोगशाला कसले स्थापना गरेका थिए?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'अमेरिकाको पहिलो मनोविज्ञान प्रयोगशाला कसले स्थापना गरेका थिए?', E'विल्हेल्म वुन्ट', E'विलियम जेम्स', E'जी. स्टानले हल', E'इ.एल. थर्नडाइक', E'C', E'**अमेरिकाको पहिलो मनोविज्ञान प्रयोगशाला जी. स्टानले हल (G. Stanley Hall) ले सन् १८८३ मा जोन हप्किन्स विश्वविद्यालयमा स्थापना गरेका थिए।**\\n- विल्हेल्म वुन्टले जर्मनीमा विश्वको पहिलो प्रयोगशाला (१८७९) स्थापना गरे।\\n- विलियम जेम्स अमेरिकी मनोविज्ञानका पिता हुन्।\\n- इ.एल. थर्नडाइक शिक्षा मनोविज्ञानका पिता हुन्।\\nनोट: जी. स्टानले हलले बालविकास र किशोरावस्थाको अध्ययनमा महत्त्वपूर्ण योगदान दिए।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:अमेरिकाको पहिलो मनोविज्ञान प्रयोगशाला कसले स्थापना गरेका थिए?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा मनोविज्ञानको प्रारम्भ कुन विद्वान्बाट भएको मानिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'शिक्षा मनोविज्ञानको प्रारम्भ कुन विद्वान्बाट भएको मानिन्छ?', E'पेस्टालोजी', E'रूसो', E'फ्रोबेल', E'हर्बार्ट', E'B', E'**शिक्षा मनोविज्ञानको प्रारम्भ रूसो (Rousseau) बाट भएको पाइन्छ।**\\n- पेस्टालोजीले मस्तिष्क, हृदय र हातको सन्तुलित विकास गर्ने 3H अवधारणा दिए।\\n- फ्रोबेल किण्डरगार्टेन शिक्षा पद्धतिका प्रवर्तक हुन्।\\n- हर्बार्टले शिक्षणका पाँच चरण (Five steps) को सिद्धान्त दिए।\\nनोट: शिक्षा मनोविज्ञान सन् १९०० मा मनोविज्ञानको शाखाको रूपमा देखिएको र सन् १९२० पछि छुट्टै विधा बन्यो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा मनोविज्ञानको प्रारम्भ कुन विद्वान्बाट भएको मानिन्छ?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'इ.एल. थर्नडाइकले ''Educational Psychology'' नामक पुस्तक कुन सालमा प्रकाशित गरेका थिए?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'इ.एल. थर्नडाइकले ''Educational Psychology'' नामक पुस्तक कुन सालमा प्रकाशित गरेका थिए?', E'सन् १८९९', E'सन् १९००', E'सन् १९०३', E'सन् १९२०', E'C', E'इ.एल. थर्नडाइकले सन् **१९०३** मा ''Educational Psychology'' नामक पुस्तक प्रकाशित गरी सिकाइका नियमहरू (Laws of Learning) प्रतिपादन गरेका थिए। यसैले उनलाई शिक्षा मनोविज्ञानका पिता मानिन्छ।\\nनोट: विलियम जेम्सको ''Talks to Teachers on Psychology'' भने सन् १८९९ मा प्रकाशित भएको थियो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:इ.एल. थर्नडाइकले ''Educational Psychology'' नामक पुस्तक कुन सालमा प्रकाशित गरेका थिए?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''Talks to Teachers on Psychology'' (१८९९) पुस्तकका लेखक को हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'''Talks to Teachers on Psychology'' (१८९९) पुस्तकका लेखक को हुन्?', E'इ.एल. थर्नडाइक', E'विल्हेल्म वुन्ट', E'बी.एफ. स्किनर', E'विलियम जेम्स', E'D', E'**''Talks to Teachers on Psychology'' (१८९९) पुस्तकका लेखक विलियम जेम्स (William James) हुन्।**\\n- इ.एल. थर्नडाइकले ''Educational Psychology'' (१९०३) लेखे।\\n- विल्हेल्म वुन्टले विश्वको पहिलो मनोविज्ञान प्रयोगशाला स्थापना गरे।\\n- बी.एफ. स्किनरले मनोविज्ञानलाई ''शिक्षण र सिकाइको अध्ययन'' भनेका छन्।\\nनोट: विलियम जेम्सलाई अमेरिकी मनोविज्ञानका पिता मानिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''Talks to Teachers on Psychology'' (१८९९) पुस्तकका लेखक को हुन्?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा मनोविज्ञानको प्रकृति कस्तो विज्ञानको रूपमा लिइन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'शिक्षा मनोविज्ञानको प्रकृति कस्तो विज्ञानको रूपमा लिइन्छ?', E'विशुद्ध विज्ञान (Pure Science)', E'व्यावहारिक विज्ञान (Applied Science)', E'नियामक विज्ञान (Normative Science)', E'काल्पनिक विज्ञान (Abstract Science)', E'B', E'**शिक्षा मनोविज्ञानको प्रकृति व्यावहारिक विज्ञान (Applied Science) तथा विधायक/सकारात्मक विज्ञान (Positive Science) हो।**\\n- विशुद्ध विज्ञान (Pure Science) भने सामान्य मनोविज्ञानको प्रकृति हो।\\n- नियामक विज्ञान शिक्षा दर्शनको प्रकृति हो, जसले ''के हुनुपर्छ'' भन्ने हेर्छ।\\nनोट: शिक्षा मनोविज्ञानले मनोवैज्ञानिक सिद्धान्तलाई शिक्षाको क्षेत्रमा व्यावहारिक रूपमा प्रयोग गर्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा मनोविज्ञानको प्रकृति कस्तो विज्ञानको रूपमा लिइन्छ?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'निम्नमध्ये कुन नियामक विज्ञान (Normative Science) हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'निम्नमध्ये कुन नियामक विज्ञान (Normative Science) हो?', E'शिक्षा मनोविज्ञान', E'शिक्षा दर्शन', E'शिक्षण विधि', E'शैक्षिक प्रशासन', E'B', E'**शिक्षा दर्शन नियामक विज्ञान (Normative Science) हो, जसले ''के हुनुपर्छ'' भन्ने आदर्शको अध्ययन गर्छ।**\\n- शिक्षा मनोविज्ञान भने विधायक/सकारात्मक विज्ञान (Positive Science) हो, जसले ''जस्तो छ त्यस्तै'' अध्ययन गर्छ।\\n- शिक्षण विधि शिक्षण-सिकाइको व्यावहारिक प्रक्रियासँग सम्बन्धित छ।\\n- शैक्षिक प्रशासन शिक्षा व्यवस्थापनसँग सम्बन्धित छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:निम्नमध्ये कुन नियामक विज्ञान (Normative Science) हो?'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा मनोविज्ञानको अध्ययनको मुख्य केन्द्रविन्दु के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'शिक्षा मनोविज्ञानको अध्ययनको मुख्य केन्द्रविन्दु के हो?', E'सिकारु (मानव)', E'पाठ्यक्रम', E'विद्यालय भवन', E'परीक्षा प्रणाली', E'A', E'**शिक्षा मनोविज्ञानको अध्ययनको मुख्य केन्द्रविन्दु सिकारु (मानव) हो।**\\n- पाठ्यक्रम शिक्षाको साधन हो, अध्ययनको केन्द्रविन्दु होइन।\\n- विद्यालय भवन भौतिक पूर्वाधार हो।\\n- परीक्षा प्रणाली मूल्याङ्कनको साधन हो।\\nनोट: शिक्षा मनोविज्ञानका तीन केन्द्रविन्दु सिकारु, सिकाइ प्रक्रिया र सिकाइ परिस्थिति हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा मनोविज्ञानको अध्ययनको मुख्य केन्द्रविन्दु के हो?'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'बहुबौद्धिकताको सिद्धान्त (Theory of Multiple Intelligence) कुन सालमा प्रतिपादन भएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'बहुबौद्धिकताको सिद्धान्त (Theory of Multiple Intelligence) कुन सालमा प्रतिपादन भएको थियो?', E'सन् १९८३', E'सन् १९०५', E'सन् १९२०', E'सन् १९६०', E'A', E'हावर्ड गार्डनरले सन् **१९८३** मा बहुबौद्धिकताको सिद्धान्त प्रतिपादन गरे, जसअनुसार मानिसमा आठ किसिमका बौद्धिकता हुन्छन्।\\nनोट: यी आठ बौद्धिकतामा शाब्दिक-भाषिक, तार्किक-गणितीय, दृश्य, शारीरिक, सङ्गीत, बहिर्मुखी, अन्तरमुखी र प्राकृतिक बुद्धि पर्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:बहुबौद्धिकताको सिद्धान्त (Theory of Multiple Intelligence) कुन सालमा प्रतिपादन भएको थियो?'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विश्वको पहिलो बुद्धि परीक्षण (Intelligence Test) कसले विकास गरेका थिए?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'विश्वको पहिलो बुद्धि परीक्षण (Intelligence Test) कसले विकास गरेका थिए?', E'इ.एल. थर्नडाइक', E'डेभिड वेक्सलर', E'लुइस टर्मन', E'अल्फ्रेड बिनेट', E'D', E'**विश्वको पहिलो बुद्धि परीक्षण फ्रान्समा अल्फ्रेड बिनेट (Alfred Binet) ले विकास गरेका थिए।**\\n- इ.एल. थर्नडाइक शिक्षा मनोविज्ञानका पिता हुन्।\\n- डेभिड वेक्सलरले वयस्कका लागि बुद्धि परीक्षण (WAIS) बनाए।\\n- लुइस टर्मनले बिनेटको परीक्षणलाई परिमार्जन गरी स्ट्यानफोर्ड-बिनेट परीक्षण बनाए।\\nनोट: बिनेटको परीक्षणले शैक्षिक मनोविज्ञानमा महत्त्वपूर्ण प्रभाव पार्‍यो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विश्वको पहिलो बुद्धि परीक्षण (Intelligence Test) कसले विकास गरेका थिए?'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पहिलो शैक्षिक मनोविज्ञान प्रयोगशाला (शिकागो विश्वविद्यालय, १८९४) कसले स्थापना गरेका थिए?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 20, E'पहिलो शैक्षिक मनोविज्ञान प्रयोगशाला (शिकागो विश्वविद्यालय, १८९४) कसले स्थापना गरेका थिए?', E'विल्हेल्म वुन्ट', E'जोन ड्युयी', E'इ.एल. थर्नडाइक', E'जी. स्टानले हल', E'B', E'**पहिलो शैक्षिक मनोविज्ञान प्रयोगशाला जोन ड्युयी (John Dewey) ले सन् १८९४ मा शिकागो विश्वविद्यालयमा स्थापना गरेका थिए।**\\n- विल्हेल्म वुन्टले जर्मनीमा विश्वको पहिलो (सामान्य) मनोविज्ञान प्रयोगशाला स्थापना गरे।\\n- इ.एल. थर्नडाइक शिक्षा मनोविज्ञानका पिता हुन्।\\n- जी. स्टानले हलले अमेरिकाको पहिलो मनोविज्ञान प्रयोगशाला स्थापना गरे।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पहिलो शैक्षिक मनोविज्ञान प्रयोगशाला (शिकागो विश्वविद्यालय, १८९४) कसले स्थापना गरेका थिए?'), v_set_id, v_q_id, 20)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: शैक्षिक मनोविज्ञान — सम्प्रदाय र अध्ययन विधि (आधारभूत तह — भाग २) (20 Q)
  v_set_id := extensions.uuid_generate_v5('1e24d947-b929-4a1b-a069-d5b1d1136baa'::uuid, E'शैक्षिक मनोविज्ञान — सम्प्रदाय र अध्ययन विधि (आधारभूत तह — भाग २)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '8dafc3cd-62b2-45e0-905e-aa6c841526f2'::uuid, '1e24d947-b929-4a1b-a069-d5b1d1136baa'::uuid, E'शैक्षिक मनोविज्ञान — सम्प्रदाय र अध्ययन विधि (आधारभूत तह — भाग २)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '1e24d947-b929-4a1b-a069-d5b1d1136baa'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'संरचनावाद (Structuralism) का पिता कसलाई मानिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'संरचनावाद (Structuralism) का पिता कसलाई मानिन्छ?', E'विल्हेल्म वुन्ट र एडवार्ड टिचनर', E'विलियम जेम्स र जोन ड्युयी', E'जे.बी. वाट्सन र बी.एफ. स्किनर', E'सिग्मण्ड फ्रायड र कार्ल युङ्ग', E'A', E'**संरचनावादका पिता विल्हेल्म वुन्ट र एडवार्ड टिचनर हुन्, जसले मनका अवयव/संरचनाको अध्ययन गर्छ।**\\n- विलियम जेम्स र जोन ड्युयी प्रकार्यवादसँग सम्बन्धित छन्।\\n- जे.बी. वाट्सन र बी.एफ. स्किनर व्यवहारवादसँग सम्बन्धित छन्।\\n- सिग्मण्ड फ्रायड र कार्ल युङ्ग मनोविश्लेषणसँग सम्बन्धित छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:संरचनावाद (Structuralism) का पिता कसलाई मानिन्छ?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'मनले कसरी काम गर्छ (Function) भन्ने अध्ययन गर्ने प्रकार्यवाद (Functionalism) का पिता को हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'मनले कसरी काम गर्छ (Function) भन्ने अध्ययन गर्ने प्रकार्यवाद (Functionalism) का पिता को हुन्?', E'विल्हेल्म वुन्ट र एडवार्ड टिचनर', E'सिग्मण्ड फ्रायड र अल्फ्रेड एडलर', E'विलियम जेम्स र जोन ड्युयी', E'म्याक्स वर्दिमर र कोफ्का', E'C', E'**प्रकार्यवादका पिता विलियम जेम्स र जोन ड्युयी हुन्, जसले मनले कसरी काम गर्छ भन्ने अध्ययन गर्छ।**\\n- विल्हेल्म वुन्ट र एडवार्ड टिचनर संरचनावादका पिता हुन्।\\n- सिग्मण्ड फ्रायड र अल्फ्रेड एडलर मनोविश्लेषणसँग सम्बन्धित छन्।\\n- म्याक्स वर्दिमर र कोफ्का समग्रवाद (Gestalt) सँग सम्बन्धित छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:मनले कसरी काम गर्छ (Function) भन्ने अध्ययन गर्ने प्रकार्यवाद (Functionalism) का पिता को हुन्?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'अचेतन मन (Unconscious Mind) को अध्ययन कुन सम्प्रदायले गर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'अचेतन मन (Unconscious Mind) को अध्ययन कुन सम्प्रदायले गर्छ?', E'व्यवहारवाद', E'मनोविश्लेषणवाद', E'संरचनावाद', E'समग्रवाद', E'B', E'**अचेतन मन (Unconscious mind) को अध्ययन मनोविश्लेषणवाद (Psychoanalysis) ले गर्छ।**\\n- व्यवहारवादले अवलोकन गर्न सकिने बाह्य व्यवहारको अध्ययन गर्छ।\\n- संरचनावादले मनका अवयव/संरचनाको अध्ययन गर्छ।\\n- समग्रवादले सिकाइलाई पूर्णता/समग्रतामा हेर्छ।\\nनोट: मनोविश्लेषणवादका प्रवर्तक सिग्मण्ड फ्रायड हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:अचेतन मन (Unconscious Mind) को अध्ययन कुन सम्प्रदायले गर्छ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सिकाइलाई पूर्णता वा समग्रतामा हेर्ने सम्प्रदाय कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'सिकाइलाई पूर्णता वा समग्रतामा हेर्ने सम्प्रदाय कुन हो?', E'समग्रवाद (Gestaltism)', E'प्रकार्यवाद', E'व्यवहारवाद', E'संरचनावाद', E'A', E'**सिकाइलाई पूर्णता वा समग्रतामा हेर्ने सम्प्रदाय समग्रवाद (Gestaltism) हो।**\\n- प्रकार्यवादले मनको कार्य (Function) को अध्ययन गर्छ।\\n- व्यवहारवादले अवलोकन गर्न सकिने बाह्य व्यवहारको अध्ययन गर्छ।\\n- संरचनावादले मनका अवयवको अध्ययन गर्छ।\\nनोट: समग्रवादअनुसार पूर्ण वस्तु यसका अंशहरूको योगभन्दा ठूलो हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सिकाइलाई पूर्णता वा समग्रतामा हेर्ने सम्प्रदाय कुन हो?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'अवलोकन गर्न सकिने बाह्य व्यवहार मात्र अध्ययन गर्ने सम्प्रदाय कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'अवलोकन गर्न सकिने बाह्य व्यवहार मात्र अध्ययन गर्ने सम्प्रदाय कुन हो?', E'संरचनावाद', E'प्रकार्यवाद', E'मनोविश्लेषणवाद', E'व्यवहारवाद', E'D', E'**अवलोकन गर्न सकिने बाह्य व्यवहार मात्र अध्ययन गर्ने सम्प्रदाय व्यवहारवाद (Behaviorism) हो।**\\n- संरचनावादले मनका अवयव/संरचनाको अध्ययन गर्छ।\\n- प्रकार्यवादले मनको कार्यको अध्ययन गर्छ।\\n- मनोविश्लेषणवादले अचेतन मनको अध्ययन गर्छ।\\nनोट: व्यवहारवादले चेतना जस्ता अमूर्त कुराको अध्ययनलाई अस्वीकार गर्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:अवलोकन गर्न सकिने बाह्य व्यवहार मात्र अध्ययन गर्ने सम्प्रदाय कुन हो?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'मनोविज्ञानका सम्प्रदायहरूको उदयको सही क्रम कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'मनोविज्ञानका सम्प्रदायहरूको उदयको सही क्रम कुन हो?', E'संरचनावाद → प्रकार्यवाद → मनोविश्लेषणवाद → व्यवहारवाद → समग्रवाद', E'व्यवहारवाद → समग्रवाद → प्रकार्यवाद → संरचनावाद → मनोविश्लेषणवाद', E'प्रकार्यवाद → संरचनावाद → व्यवहारवाद → मनोविश्लेषणवाद → समग्रवाद', E'मनोविश्लेषणवाद → व्यवहारवाद → संरचनावाद → प्रकार्यवाद → समग्रवाद', E'A', E'**सम्प्रदायहरूको उदयक्रम: संरचनावाद (१८७९) → प्रकार्यवाद (१८९०) → मनोविश्लेषणवाद (१९००) → व्यवहारवाद (१९१२/१३) → समग्रवाद (१९१२) हो।**\\nनोट: संरचनावादको उदय वुन्टको प्रयोगशाला स्थापनासँगै भएको हुनाले यो सबैभन्दा पुरानो सम्प्रदाय हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:मनोविज्ञानका सम्प्रदायहरूको उदयको सही क्रम कुन हो?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'मनोविज्ञानको सबैभन्दा पुरानो अध्ययन विधि कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'मनोविज्ञानको सबैभन्दा पुरानो अध्ययन विधि कुन हो?', E'अवलोकन विधि', E'प्रयोगात्मक विधि', E'अन्तर्दर्शन विधि', E'व्यक्ति अध्ययन विधि', E'C', E'**मनोविज्ञानको सबैभन्दा पुरानो विधि अन्तर्दर्शन विधि (Introspection Method) हो, जसमा व्यक्ति आफैंले आफ्नो मनको भित्री अवलोकन गर्छ।**\\n- अवलोकन विधि बाह्य व्यवहारको प्रत्यक्ष अध्ययन गर्ने विधि हो।\\n- प्रयोगात्मक विधि सबैभन्दा वैज्ञानिक विधि हो।\\n- व्यक्ति अध्ययन विधि असामान्य व्यवहारको गहिरो अध्ययनमा प्रयोग हुन्छ।\\nनोट: यो विधि संरचनावादीहरूले विकास गरेका हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:मनोविज्ञानको सबैभन्दा पुरानो अध्ययन विधि कुन हो?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'अन्तर्दर्शन (Introspection) विधि मुख्यतया कुन सम्प्रदायका मनोवैज्ञानिकहरूले प्रयोग गरेका थिए?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'अन्तर्दर्शन (Introspection) विधि मुख्यतया कुन सम्प्रदायका मनोवैज्ञानिकहरूले प्रयोग गरेका थिए?', E'संरचनावादी', E'व्यवहारवादी', E'समग्रवादी', E'मनोविश्लेषणवादी', E'A', E'**अन्तर्दर्शन विधि संरचनावादी (Structuralist) मनोवैज्ञानिक विल्हेल्म वुन्ट र एडवार्ड टिचनरले प्रयोग गरेका थिए।**\\n- व्यवहारवादीहरूले अवलोकन र प्रयोगात्मक विधिमा जोड दिए।\\n- समग्रवादीहरूले सिकाइलाई समग्रतामा अध्ययन गरे।\\n- मनोविश्लेषणवादीहरूले स्वतन्त्र साहचर्य (Free association) जस्ता विधि प्रयोग गरे।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:अन्तर्दर्शन (Introspection) विधि मुख्यतया कुन सम्प्रदायका मनोवैज्ञानिकहरूले प्रयोग गरेका थिए?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कारण र असर (Cause & Effect) सम्बन्ध पत्ता लगाउने सबैभन्दा वैज्ञानिक र वस्तुनिष्ठ विधि कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'कारण र असर (Cause & Effect) सम्बन्ध पत्ता लगाउने सबैभन्दा वैज्ञानिक र वस्तुनिष्ठ विधि कुन हो?', E'अवलोकन विधि', E'सर्वेक्षण विधि', E'अन्तर्दर्शन विधि', E'प्रयोगात्मक विधि', E'D', E'**कारण र असर सम्बन्ध पत्ता लगाउने सबैभन्दा वैज्ञानिक र वस्तुनिष्ठ विधि प्रयोगात्मक विधि (Experimental Method) हो।**\\n- अवलोकन विधि व्यवहारको प्रत्यक्ष अध्ययन गर्छ तर कारण-असर स्थापित गर्न सक्दैन।\\n- सर्वेक्षण विधिले ठूलो जनसंख्याबाट तथ्याङ्क सङ्कलन गर्छ।\\n- अन्तर्दर्शन विधि व्यक्तिपरक हुन्छ।\\nनोट: प्रयोगात्मक विधिको सुरुवात विल्हेल्म वुन्टले गरेका हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कारण र असर (Cause & Effect) सम्बन्ध पत्ता लगाउने सबैभन्दा वैज्ञानिक र वस्तुनिष्ठ विधि कुन हो?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'प्रयोगात्मक विधिमा अनुसन्धानकर्ताले हेरफेर (manipulate) गर्ने चर कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'प्रयोगात्मक विधिमा अनुसन्धानकर्ताले हेरफेर (manipulate) गर्ने चर कुन हो?', E'आश्रित चर (Dependent Variable)', E'स्वतन्त्र चर (Independent Variable)', E'नियन्त्रित चर (Controlled Variable)', E'बाह्य चर (Extraneous Variable)', E'B', E'**प्रयोगात्मक विधिमा अनुसन्धानकर्ताले स्वतन्त्र चर (Independent Variable) लाई हेरफेर गर्छ।**\\n- आश्रित चर (Dependent Variable) त्यो हो जसमा पर्ने प्रभावको अध्ययन गरिन्छ।\\n- नियन्त्रित चरलाई स्थिर राखिन्छ।\\n- बाह्य चरले परिणाममा अवाञ्छित प्रभाव पार्न सक्छ।\\nनोट: स्वतन्त्र चरको परिवर्तनले आश्रित चरमा पार्ने असर नै प्रयोगको मुख्य अध्ययन हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:प्रयोगात्मक विधिमा अनुसन्धानकर्ताले हेरफेर (manipulate) गर्ने चर कुन हो?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सिकाइ कठिनाइ भएका जस्ता असामान्य वा समस्याग्रस्त व्यवहारको अध्ययन गर्ने उत्तम विधि कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'सिकाइ कठिनाइ भएका जस्ता असामान्य वा समस्याग्रस्त व्यवहारको अध्ययन गर्ने उत्तम विधि कुन हो?', E'अवलोकन विधि', E'सर्वेक्षण विधि', E'नैदानिक विधि (Case Study)', E'प्रयोगात्मक विधि', E'C', E'**असामान्य वा समस्याग्रस्त व्यवहारको अध्ययन गर्ने उत्तम विधि नैदानिक विधि वा व्यक्ति अध्ययन (Clinical / Case Study Method) हो।**\\n- अवलोकन विधि सामान्य व्यवहारको प्रत्यक्ष अध्ययनमा उपयुक्त छ।\\n- सर्वेक्षण विधि ठूलो जनसंख्याको तथ्याङ्क सङ्कलनमा प्रयोग हुन्छ।\\n- प्रयोगात्मक विधि कारण-असर अध्ययनमा प्रयोग हुन्छ।\\nनोट: नैदानिक विधिले समस्याको कारण पत्ता लगाई उपचारात्मक उपाय सिफारिस गर्न मद्दत गर्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सिकाइ कठिनाइ भएका जस्ता असामान्य वा समस्याग्रस्त व्यवहारको अध्ययन गर्ने उत्तम विधि कुन हो?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिशु तथा बालबालिकाको व्यवहार ''जस्तो छ त्यस्तै'' अध्ययन गर्न सबैभन्दा उपयुक्त विधि कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'शिशु तथा बालबालिकाको व्यवहार ''जस्तो छ त्यस्तै'' अध्ययन गर्न सबैभन्दा उपयुक्त विधि कुन हो?', E'अवलोकन विधि', E'अन्तर्दर्शन विधि', E'प्रयोगात्मक विधि', E'सर्वेक्षण विधि', E'A', E'**शिशु तथा बालबालिकाको व्यवहार जस्तो छ त्यस्तै अध्ययन गर्न उपयुक्त विधि अवलोकन विधि (Observation Method) हो।**\\n- अन्तर्दर्शन विधिमा आफ्नै मनको भित्री अवलोकन गर्नुपर्ने हुन्छ, जुन बालबालिकाका लागि सम्भव छैन।\\n- प्रयोगात्मक विधि नियन्त्रित प्रयोगशाला अध्ययनमा प्रयोग हुन्छ।\\n- सर्वेक्षण विधि प्रश्नावलीमा आधारित हुन्छ।\\nनोट: अवलोकन विधिको अत्यधिक प्रयोग जे.बी. वाट्सनले गरेका थिए।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिशु तथा बालबालिकाको व्यवहार ''जस्तो छ त्यस्तै'' अध्ययन गर्न सबैभन्दा उपयुक्त विधि कुन हो?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'एउटै व्यक्ति वा समूहलाई लामो समयसम्म क्रमिक रूपमा अध्ययन गर्ने विधि कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'एउटै व्यक्ति वा समूहलाई लामो समयसम्म क्रमिक रूपमा अध्ययन गर्ने विधि कुन हो?', E'क्षितिजीय विधि', E'नैदानिक विधि', E'अनुदैर्ध्य विधि (Longitudinal)', E'सर्वेक्षण विधि', E'C', E'**एउटै व्यक्ति वा समूहलाई लामो समयसम्म अध्ययन गर्ने विधि अनुदैर्ध्य वा लम्बीय विधि (Longitudinal Method) हो।**\\n- क्षितिजीय विधिमा फरक उमेर समूहलाई एकैपटक अध्ययन गरिन्छ।\\n- नैदानिक विधि असामान्य व्यवहारको गहिरो अध्ययनमा प्रयोग हुन्छ।\\n- सर्वेक्षण विधि ठूलो जनसंख्याको तथ्याङ्क सङ्कलनमा प्रयोग हुन्छ।\\nनोट: अनुदैर्ध्य विधिले समयअनुसार हुने विकासात्मक परिवर्तन प्रत्यक्ष देखाउँछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:एउटै व्यक्ति वा समूहलाई लामो समयसम्म क्रमिक रूपमा अध्ययन गर्ने विधि कुन हो?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'फरक-फरक उमेर समूहका व्यक्तिहरूलाई एकैपटक तुलनात्मक रूपमा अध्ययन गर्ने विधि कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'फरक-फरक उमेर समूहका व्यक्तिहरूलाई एकैपटक तुलनात्मक रूपमा अध्ययन गर्ने विधि कुन हो?', E'क्षितिजीय विधि (Cross-sectional)', E'अनुदैर्ध्य विधि', E'प्रयोगात्मक विधि', E'अवलोकन विधि', E'A', E'**फरक-फरक उमेर समूहलाई एकैपटक अध्ययन गर्ने विधि क्षितिजीय विधि (Cross-sectional Method) हो।**\\n- अनुदैर्ध्य विधिमा एउटै समूहलाई लामो समयसम्म अध्ययन गरिन्छ।\\n- प्रयोगात्मक विधि कारण-असर अध्ययनमा प्रयोग हुन्छ।\\n- अवलोकन विधि व्यवहारको प्रत्यक्ष अध्ययनमा प्रयोग हुन्छ।\\nनोट: क्षितिजीय विधि छोटो समयमा सम्पन्न हुने हुँदा अनुदैर्ध्यभन्दा बढी व्यावहारिक मानिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:फरक-फरक उमेर समूहका व्यक्तिहरूलाई एकैपटक तुलनात्मक रूपमा अध्ययन गर्ने विधि कुन हो?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विकासात्मक विधि (Developmental Method) को सबैभन्दा बढी प्रयोग कुन मनोवैज्ञानिकले गरेका थिए?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'विकासात्मक विधि (Developmental Method) को सबैभन्दा बढी प्रयोग कुन मनोवैज्ञानिकले गरेका थिए?', E'जे.बी. वाट्सन', E'जिन पियाजे', E'जे.एल. मोरेनो', E'विल्हेल्म वुन्ट', E'B', E'**विकासात्मक विधिको सबैभन्दा बढी प्रयोग जिन पियाजे (Jean Piaget) ले गरेका थिए।**\\n- जे.बी. वाट्सनले अवलोकन विधिको अत्यधिक प्रयोग गरे।\\n- जे.एल. मोरेनोले समाजमिति (Sociometry) विधि प्रतिपादन गरे।\\n- विल्हेल्म वुन्टले प्रयोगात्मक विधिको सुरुवात गरे।\\nनोट: पियाजेले बालबालिकाको सञ्ज्ञानात्मक विकासको अध्ययनमा यो विधि प्रयोग गरे।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विकासात्मक विधि (Developmental Method) को सबैभन्दा बढी प्रयोग कुन मनोवैज्ञानिकले गरेका थिए?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समाजमिति (Sociometry) विधिको प्रतिपादन कसले गरेका थिए?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'समाजमिति (Sociometry) विधिको प्रतिपादन कसले गरेका थिए?', E'इ.एल. थर्नडाइक', E'अल्फ्रेड बिनेट', E'जिन पियाजे', E'जे.एल. मोरेनो', E'D', E'**समाजमिति विधिको प्रतिपादन जे.एल. मोरेनो (J.L. Moreno) ले गरेका थिए।**\\n- इ.एल. थर्नडाइक शिक्षा मनोविज्ञानका पिता हुन्।\\n- अल्फ्रेड बिनेटले पहिलो बुद्धि परीक्षण विकास गरे।\\n- जिन पियाजेले विकासात्मक विधिको बढी प्रयोग गरे।\\nनोट: समाजमिति विधिले समूहभित्रको सामाजिक सम्बन्ध र अन्तरक्रिया मापन गर्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समाजमिति (Sociometry) विधिको प्रतिपादन कसले गरेका थिए?'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'व्यक्तिपरक (Subjective) भएकाले आधुनिक मनोविज्ञानले कुन विधिलाई अस्वीकार गर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'व्यक्तिपरक (Subjective) भएकाले आधुनिक मनोविज्ञानले कुन विधिलाई अस्वीकार गर्छ?', E'प्रयोगात्मक विधि', E'अन्तर्दर्शन विधि', E'अवलोकन विधि', E'नैदानिक विधि', E'B', E'**व्यक्तिपरक भएकाले आधुनिक मनोविज्ञानले अन्तर्दर्शन विधि (Introspection Method) लाई अस्वीकार गर्छ।**\\n- प्रयोगात्मक विधि वस्तुनिष्ठ र वैज्ञानिक भएकाले स्वीकार्य छ।\\n- अवलोकन विधि बाह्य व्यवहारको प्रत्यक्ष अध्ययन गर्ने हुँदा वस्तुनिष्ठ छ।\\n- नैदानिक विधि असामान्य व्यवहारको अध्ययनमा उपयोगी छ।\\nनोट: अन्तर्दर्शन विधिको वैज्ञानिक परीक्षण गर्न नसकिने हुनाले यसलाई अवैज्ञानिक मानिएको हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:व्यक्तिपरक (Subjective) भएकाले आधुनिक मनोविज्ञानले कुन विधिलाई अस्वीकार गर्छ?'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'जे.बी. वाट्सनले मनोविज्ञानमा कुन कुराको अध्ययनलाई पूर्ण रूपमा खारेज गरे?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'जे.बी. वाट्सनले मनोविज्ञानमा कुन कुराको अध्ययनलाई पूर्ण रूपमा खारेज गरे?', E'व्यवहार', E'उद्दीपन', E'चेतना', E'प्रतिक्रिया', E'C', E'**जे.बी. वाट्सनले चेतना (Consciousness) को अध्ययनलाई पूर्ण रूपमा खारेज गरे, किनभने चेतना अमूर्त हुन्छ र यसलाई बाह्य रूपमा अवलोकन वा मापन गर्न सकिँदैन।**\\n- व्यवहार (Behavior) नै वाट्सनको अध्ययनको केन्द्र थियो।\\n- उद्दीपन (Stimulus) र प्रतिक्रिया (Response) व्यवहारवादका आधारभूत तत्त्व हुन्।\\nनोट: वाट्सनका अनुसार मनोविज्ञान ''व्यवहारको सकारात्मक विज्ञान'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:जे.बी. वाट्सनले मनोविज्ञानमा कुन कुराको अध्ययनलाई पूर्ण रूपमा खारेज गरे?'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'निरीक्षण (अवलोकन) विधिका दुई मुख्य प्रकार कुन-कुन हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'निरीक्षण (अवलोकन) विधिका दुई मुख्य प्रकार कुन-कुन हुन्?', E'सहभागी र असहभागी निरीक्षण', E'प्रत्यक्ष र अप्रत्यक्ष निरीक्षण', E'आन्तरिक र बाह्य निरीक्षण', E'व्यक्तिगत र सामूहिक निरीक्षण', E'A', E'**निरीक्षण विधिका दुई मुख्य प्रकार सहभागी निरीक्षण (Participant Observation) र असहभागी निरीक्षण (Non-participant Observation) हुन्।**\\n- सहभागी निरीक्षणमा अनुसन्धानकर्ता आफैं समूहको सदस्य भई अवलोकन गर्छ।\\n- असहभागी निरीक्षणमा बाहिरबाट मात्र अवलोकन गरिन्छ।\\nनोट: निरीक्षण विधिमा व्यवहारलाई प्राकृतिक वा नियन्त्रित वातावरणमा प्रत्यक्ष अध्ययन गरिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:निरीक्षण (अवलोकन) विधिका दुई मुख्य प्रकार कुन-कुन हुन्?'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'उडवर्थका अनुसार मनोविज्ञानले विकासक्रममा अन्ततः कुन कुरा अपनायो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 20, E'उडवर्थका अनुसार मनोविज्ञानले विकासक्रममा अन्ततः कुन कुरा अपनायो?', E'आत्मा', E'मन', E'चेतना', E'व्यवहार', E'D', E'उडवर्थका अनुसार मनोविज्ञानले पहिले आत्मा त्याग्यो, मन त्याग्यो, चेतना त्याग्यो र अन्ततः **व्यवहार** अपनायो। यसैले वर्तमान मनोविज्ञान ''व्यवहारको विज्ञान'' हो।\\nनोट: व्यवहारको विज्ञानका प्रमुख समर्थक जे.बी. वाट्सन, स्किनर र वुडवर्थ हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:उडवर्थका अनुसार मनोविज्ञानले विकासक्रममा अन्ततः कुन कुरा अपनायो?'), v_set_id, v_q_id, 20)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: शैक्षिक मनोविज्ञान — उत्प्रेरणा र यसका सिद्धान्त (आधारभूत तह — भाग ३) (15 Q)
  v_set_id := extensions.uuid_generate_v5('1e24d947-b929-4a1b-a069-d5b1d1136baa'::uuid, E'शैक्षिक मनोविज्ञान — उत्प्रेरणा र यसका सिद्धान्त (आधारभूत तह — भाग ३)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '8dafc3cd-62b2-45e0-905e-aa6c841526f2'::uuid, '1e24d947-b929-4a1b-a069-d5b1d1136baa'::uuid, E'शैक्षिक मनोविज्ञान — उत्प्रेरणा र यसका सिद्धान्त (आधारभूत तह — भाग ३)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '1e24d947-b929-4a1b-a069-d5b1d1136baa'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''उत्प्रेरणा'' कुन अङ्ग्रेजी शब्दको नेपाली रूपान्तरण हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'''उत्प्रेरणा'' कुन अङ्ग्रेजी शब्दको नेपाली रूपान्तरण हो?', E'Emotion', E'Motivation', E'Inspiration', E'Stimulation', E'B', E'**''उत्प्रेरणा'' अङ्ग्रेजी शब्द ''Motivation'' को नेपाली रूपान्तरण हो।**\\n- Emotion को नेपाली अर्थ संवेग हो।\\n- Inspiration को अर्थ प्रेरणा/स्फूर्ति हो।\\n- Stimulation को अर्थ उद्दीपन हो।\\nनोट: उत्प्रेरणाले व्यक्तिको व्यवहारलाई एउटा विशिष्ट लक्ष्यतर्फ निर्देशित गर्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''उत्प्रेरणा'' कुन अङ्ग्रेजी शब्दको नेपाली रूपान्तरण हो?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'अब्राहम मास्लोले ''A Theory of Human Motivation'' नामक कार्यपत्र कुन सालमा प्रस्तुत गरेका थिए?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'अब्राहम मास्लोले ''A Theory of Human Motivation'' नामक कार्यपत्र कुन सालमा प्रस्तुत गरेका थिए?', E'सन् १९४३', E'सन् १९५४', E'सन् १९६०', E'सन् १९३७', E'A', E'अब्राहम मास्लोले सन् **१९४३** मा ''A Theory of Human Motivation'' नामक कार्यपत्र प्रस्तुत गरेका थिए।\\nनोट: सन् १९५४ मा ''Motivation and Personality'' नामक पुस्तक लेखी उनले यो सिद्धान्तलाई थप समृद्ध बनाए।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:अब्राहम मास्लोले ''A Theory of Human Motivation'' नामक कार्यपत्र कुन सालमा प्रस्तुत गरेका थिए?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'मास्लोको आवश्यकता सोपान सिद्धान्तमा सबैभन्दा तल्लो (आधारभूत) तहमा कुन आवश्यकता पर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'मास्लोको आवश्यकता सोपान सिद्धान्तमा सबैभन्दा तल्लो (आधारभूत) तहमा कुन आवश्यकता पर्छ?', E'सुरक्षासम्बन्धी आवश्यकता', E'शारीरिक आवश्यकता', E'आत्मसम्मानको आवश्यकता', E'आत्मयथार्थीकरण', E'B', E'**मास्लोको आवश्यकता सोपानमा सबैभन्दा तल्लो (आधारभूत) तहमा शारीरिक आवश्यकता (Physiological needs) पर्छ।**\\n- सुरक्षासम्बन्धी आवश्यकता दोस्रो तहमा पर्छ।\\n- आत्मसम्मानको आवश्यकता चौथो तहमा पर्छ।\\n- आत्मयथार्थीकरण सबैभन्दा माथिल्लो तहमा पर्छ।\\nनोट: शारीरिक आवश्यकतामा भोक, प्यास, निद्रा जस्ता आधारभूत आवश्यकता पर्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:मास्लोको आवश्यकता सोपान सिद्धान्तमा सबैभन्दा तल्लो (आधारभूत) तहमा कुन आवश्यकता पर्छ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'मास्लोको आवश्यकता सोपानमा सबैभन्दा माथिल्लो (सर्वोच्च) तहमा कुन आवश्यकता पर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'मास्लोको आवश्यकता सोपानमा सबैभन्दा माथिल्लो (सर्वोच्च) तहमा कुन आवश्यकता पर्छ?', E'आत्मसम्मानको आवश्यकता', E'स्नेह र अपनत्वको आवश्यकता', E'आत्मयथार्थीकरण', E'सुरक्षासम्बन्धी आवश्यकता', E'C', E'**मास्लोको आवश्यकता सोपानमा सबैभन्दा माथिल्लो तहमा आत्मयथार्थीकरण वा आत्मप्रकटीकरण (Self-actualization) पर्छ।**\\n- आत्मसम्मानको आवश्यकता चौथो तहमा पर्छ।\\n- स्नेह र अपनत्वको आवश्यकता तेस्रो तहमा पर्छ।\\n- सुरक्षासम्बन्धी आवश्यकता दोस्रो तहमा पर्छ।\\nनोट: आत्मयथार्थीकरण भनेको व्यक्तिले आफ्नो पूर्ण क्षमता प्राप्त गर्ने अवस्था हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:मास्लोको आवश्यकता सोपानमा सबैभन्दा माथिल्लो (सर्वोच्च) तहमा कुन आवश्यकता पर्छ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'मास्लोको आवश्यकता सोपानको सही क्रम (तलदेखि माथि) कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'मास्लोको आवश्यकता सोपानको सही क्रम (तलदेखि माथि) कुन हो?', E'शारीरिक → सुरक्षा → स्नेह र अपनत्व → आत्मसम्मान → आत्मयथार्थीकरण', E'सुरक्षा → शारीरिक → आत्मसम्मान → स्नेह र अपनत्व → आत्मयथार्थीकरण', E'शारीरिक → स्नेह र अपनत्व → सुरक्षा → आत्मयथार्थीकरण → आत्मसम्मान', E'आत्मयथार्थीकरण → आत्मसम्मान → स्नेह र अपनत्व → सुरक्षा → शारीरिक', E'A', E'**मास्लोको आवश्यकता सोपानको सही क्रम (तलदेखि माथि): शारीरिक → सुरक्षा → स्नेह र अपनत्व → आत्मसम्मान → आत्मयथार्थीकरण हो।**\\nनोट: मास्लोका अनुसार तल्लो तहको आवश्यकता पूरा भएपछि मात्र व्यक्ति माथिल्लो तहको आवश्यकतातर्फ अग्रसर हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:मास्लोको आवश्यकता सोपानको सही क्रम (तलदेखि माथि) कुन हो?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'X र Y सिद्धान्त (Theory X and Theory Y) का प्रतिपादक को हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'X र Y सिद्धान्त (Theory X and Theory Y) का प्रतिपादक को हुन्?', E'अब्राहम मास्लो', E'फ्रेडरिक हर्जबर्ग', E'भिक्टर भ्रुम', E'डगलस म्याकग्रेगर', E'D', E'**X र Y सिद्धान्तका प्रतिपादक डगलस म्याकग्रेगर (Douglas McGregor) हुन्, जुन सन् १९६० मा प्रस्तुत भएको थियो।**\\n- अब्राहम मास्लोले आवश्यकता सोपान सिद्धान्त दिए।\\n- फ्रेडरिक हर्जबर्गले द्वि-तत्त्व (Hygiene) सिद्धान्त दिए।\\n- भिक्टर भ्रुमले अपेक्षा सिद्धान्त दिए।\\nनोट: X सिद्धान्तले कर्मचारीलाई नकारात्मक र Y सिद्धान्तले सकारात्मक दृष्टिले हेर्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:X र Y सिद्धान्त (Theory X and Theory Y) का प्रतिपादक को हुन्?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'Z सिद्धान्त (Theory Z) का प्रतिपादक को हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'Z सिद्धान्त (Theory Z) का प्रतिपादक को हुन्?', E'डगलस म्याकग्रेगर', E'विलियम औचि', E'जे.एस. एडम्स', E'एडविन लक', E'B', E'**Z सिद्धान्तका प्रतिपादक विलियम औचि (William Ouchi) हुन्, जुन सन् १९८१ मा प्रस्तुत भएको थियो।**\\n- डगलस म्याकग्रेगरले X र Y सिद्धान्त दिए।\\n- जे.एस. एडम्सले समता सिद्धान्त दिए।\\n- एडविन लकले लक्ष्य निर्धारण सिद्धान्त दिए।\\nनोट: Z सिद्धान्त जापानी व्यवस्थापन शैलीमा आधारित छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:Z सिद्धान्त (Theory Z) का प्रतिपादक को हुन्?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'ERG सिद्धान्त (ERG Theory) का प्रतिपादक को हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'ERG सिद्धान्त (ERG Theory) का प्रतिपादक को हुन्?', E'अब्राहम मास्लो', E'भिक्टर भ्रुम', E'क्लेटन अल्डरफर', E'एडविन लक', E'C', E'**ERG सिद्धान्तका प्रतिपादक क्लेटन अल्डरफर (Clayton Alderfer) हुन्, जुन सन् १९६१ मा प्रस्तुत भएको थियो।**\\n- अब्राहम मास्लोले आवश्यकता सोपान सिद्धान्त दिए।\\n- भिक्टर भ्रुमले अपेक्षा सिद्धान्त दिए।\\n- एडविन लकले लक्ष्य निर्धारण सिद्धान्त दिए।\\nनोट: ERG मा Existence, Relatedness र Growth गरी तीन आवश्यकता पर्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:ERG सिद्धान्त (ERG Theory) का प्रतिपादक को हुन्?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'अपेक्षा सिद्धान्त (Expectancy Theory) का प्रतिपादक को हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'अपेक्षा सिद्धान्त (Expectancy Theory) का प्रतिपादक को हुन्?', E'जे.एस. एडम्स', E'भिक्टर भ्रुम', E'एडविन लक', E'डेभिड म्याक्लेल्यान्ड', E'B', E'**अपेक्षा सिद्धान्तका प्रतिपादक भिक्टर भ्रुम (Victor Vroom) हुन्, जुन सन् १९६४ मा प्रस्तुत भएको थियो।**\\n- जे.एस. एडम्सले समता सिद्धान्त दिए।\\n- एडविन लकले लक्ष्य निर्धारण सिद्धान्त दिए।\\n- डेभिड म्याक्लेल्यान्डले आवश्यकता (Needs) सिद्धान्त दिए।\\nनोट: अपेक्षा सिद्धान्तअनुसार प्रतिफलको अपेक्षाले उत्प्रेरणा निर्धारण गर्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:अपेक्षा सिद्धान्त (Expectancy Theory) का प्रतिपादक को हुन्?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समता सिद्धान्त (Equity Theory) का प्रतिपादक को हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'समता सिद्धान्त (Equity Theory) का प्रतिपादक को हुन्?', E'भिक्टर भ्रुम', E'विलियम औचि', E'क्लेटन अल्डरफर', E'जे.एस. एडम्स', E'D', E'**समता सिद्धान्तका प्रतिपादक जे.एस. एडम्स (J.S. Adams) हुन्, जुन सन् १९६२ मा प्रस्तुत भएको थियो।**\\n- भिक्टर भ्रुमले अपेक्षा सिद्धान्त दिए।\\n- विलियम औचिले Z सिद्धान्त दिए।\\n- क्लेटन अल्डरफरले ERG सिद्धान्त दिए।\\nनोट: समता सिद्धान्तअनुसार व्यक्तिले आफ्नो योगदान र प्रतिफलको तुलना अरूसँग गर्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समता सिद्धान्त (Equity Theory) का प्रतिपादक को हुन्?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'लक्ष्य निर्धारण सिद्धान्त (Goal Setting Theory) का प्रतिपादक को हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'लक्ष्य निर्धारण सिद्धान्त (Goal Setting Theory) का प्रतिपादक को हुन्?', E'डेभिड म्याक्लेल्यान्ड', E'अब्राहम मास्लो', E'फ्रेडरिक हर्जबर्ग', E'एडविन लक', E'D', E'**लक्ष्य निर्धारण सिद्धान्तका प्रतिपादक एडविन लक (Edwin Locke) हुन्, जुन सन् १९९० मा प्रस्तुत भएको थियो।**\\n- डेभिड म्याक्लेल्यान्डले आवश्यकता सिद्धान्त दिए।\\n- अब्राहम मास्लोले आवश्यकता सोपान सिद्धान्त दिए।\\n- फ्रेडरिक हर्जबर्गले द्वि-तत्त्व सिद्धान्त दिए।\\nनोट: यो सिद्धान्तअनुसार स्पष्ट र चुनौतीपूर्ण लक्ष्यले उच्च कार्यसम्पादन गराउँछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:लक्ष्य निर्धारण सिद्धान्त (Goal Setting Theory) का प्रतिपादक को हुन्?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'फ्रेडरिक हर्जबर्गको द्वि-तत्त्व सिद्धान्तका दुई तत्त्व कुन-कुन हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'फ्रेडरिक हर्जबर्गको द्वि-तत्त्व सिद्धान्तका दुई तत्त्व कुन-कुन हुन्?', E'स्वास्थ्य तत्त्व र प्रेरक तत्त्व', E'X तत्त्व र Y तत्त्व', E'शारीरिक तत्त्व र सामाजिक तत्त्व', E'आन्तरिक तत्त्व र बाह्य तत्त्व', E'A', E'**हर्जबर्गको द्वि-तत्त्व सिद्धान्तका दुई तत्त्व स्वास्थ्य तत्त्व (Hygiene/Maintenance) र प्रेरक तत्त्व (Motivational Factors) हुन्।**\\n- X तत्त्व र Y तत्त्व म्याकग्रेगरको सिद्धान्तसँग सम्बन्धित छन्।\\n- शारीरिक र सामाजिक मास्लोको आवश्यकता वर्गीकरणसँग सम्बन्धित छन्।\\nनोट: स्वास्थ्य तत्त्वको अभावले असन्तुष्टि ल्याउँछ भने प्रेरक तत्त्वले सन्तुष्टि बढाउँछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:फ्रेडरिक हर्जबर्गको द्वि-तत्त्व सिद्धान्तका दुई तत्त्व कुन-कुन हुन्?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'उत्पत्तिको आधारमा उत्प्रेरणालाई मुख्यतया कुन दुई भागमा बाँडिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'उत्पत्तिको आधारमा उत्प्रेरणालाई मुख्यतया कुन दुई भागमा बाँडिन्छ?', E'जन्मजात (जैविक) र आर्जित प्रेरक', E'धनात्मक र ऋणात्मक प्रेरक', E'प्राथमिक र माध्यमिक प्रेरक', E'प्रत्यक्ष र अप्रत्यक्ष प्रेरक', E'A', E'**उत्पत्तिको आधारमा उत्प्रेरणालाई जन्मजात/जैविक प्रेरक र आर्जित प्रेरक गरी दुई भागमा बाँडिन्छ।**\\n- जन्मजात प्रेरक जैविक आवश्यकता (भोक, प्यास) सँग सम्बन्धित हुन्छ।\\n- आर्जित प्रेरक सिकाइ र अनुभवबाट विकसित हुन्छ।\\nनोट: सामाजिक आधारमा भने उत्प्रेरणालाई व्यक्तिगत र सामाजिक प्रेरक भनी छुट्याइन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:उत्पत्तिको आधारमा उत्प्रेरणालाई मुख्यतया कुन दुई भागमा बाँडिन्छ?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'मास्लोको आवश्यकता सोपानमा स्नेह र अपनत्व (Love and Belonging) कुन तहको आवश्यकता हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'मास्लोको आवश्यकता सोपानमा स्नेह र अपनत्व (Love and Belonging) कुन तहको आवश्यकता हो?', E'पहिलो तह', E'दोस्रो तह', E'तेस्रो तह', E'पाँचौँ तह', E'C', E'**मास्लोको आवश्यकता सोपानमा स्नेह र अपनत्व (Love and Belonging) तेस्रो तहको आवश्यकता हो।**\\n- पहिलो तह शारीरिक आवश्यकता हो।\\n- दोस्रो तह सुरक्षासम्बन्धी आवश्यकता हो।\\n- पाँचौँ (सर्वोच्च) तह आत्मयथार्थीकरण हो।\\nनोट: यो तहमा माया, मित्रता र सामाजिक सम्बन्धको आवश्यकता पर्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:मास्लोको आवश्यकता सोपानमा स्नेह र अपनत्व (Love and Belonging) कुन तहको आवश्यकता हो?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'हावर्ड गार्डनरको बहुबौद्धिकता सिद्धान्तअनुसार मानिसमा कति किसिमका बौद्धिकता हुन्छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'हावर्ड गार्डनरको बहुबौद्धिकता सिद्धान्तअनुसार मानिसमा कति किसिमका बौद्धिकता हुन्छन्?', E'छ', E'सात', E'आठ', E'नौ', E'C', E'**हावर्ड गार्डनरको बहुबौद्धिकता सिद्धान्तअनुसार मानिसमा आठ किसिमका बौद्धिकता हुन्छन्।**\\nनोट: यी आठ बौद्धिकतामा शाब्दिक-भाषिक, तार्किक-गणितीय, दृश्य, शारीरिक, सङ्गीत, बहिर्मुखी, अन्तरमुखी र प्राकृतिक बुद्धि पर्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:हावर्ड गार्डनरको बहुबौद्धिकता सिद्धान्तअनुसार मानिसमा कति किसिमका बौद्धिकता हुन्छन्?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: मानव वृद्धि र विकास — अवधारणा, भिन्नता र सिद्धान्त (आधारभूत तह — भाग १) (20 Q)
  v_set_id := extensions.uuid_generate_v5('7848483a-8a9e-4c87-be7f-4506b0fd8fc3'::uuid, E'मानव वृद्धि र विकास — अवधारणा, भिन्नता र सिद्धान्त (आधारभूत तह — भाग १)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '8dafc3cd-62b2-45e0-905e-aa6c841526f2'::uuid, '7848483a-8a9e-4c87-be7f-4506b0fd8fc3'::uuid, E'मानव वृद्धि र विकास — अवधारणा, भिन्नता र सिद्धान्त (आधारभूत तह — भाग १)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '7848483a-8a9e-4c87-be7f-4506b0fd8fc3'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वृद्धि (Growth) को प्रकृति कस्तो हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'वृद्धि (Growth) को प्रकृति कस्तो हुन्छ?', E'गुणात्मक (Qualitative)', E'परिमाणात्मक वा मात्रात्मक (Quantitative)', E'गुणात्मक र परिमाणात्मक दुवै', E'अमूर्त (Abstract)', E'B', E'**वृद्धिको प्रकृति परिमाणात्मक वा मात्रात्मक (Quantitative) हुन्छ।**\\n- विकासको प्रकृति भने गुणात्मक र परिमाणात्मक दुवै हुन्छ।\\nनोट: वृद्धि शरीरका अङ्गहरूको आकार, तौल र लम्बाइमा हुने बढोत्तरीसँग सम्बन्धित छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वृद्धि (Growth) को प्रकृति कस्तो हुन्छ?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विकास (Development) को प्रकृति कस्तो हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'विकास (Development) को प्रकृति कस्तो हुन्छ?', E'परिमाणात्मक मात्र', E'स्थिर रहने', E'गुणात्मक मात्र', E'गुणात्मक र परिमाणात्मक दुवै', E'D', E'**विकासको प्रकृति गुणात्मक र परिमाणात्मक दुवै (Qualitative & Quantitative) हुन्छ।**\\n- परिमाणात्मक मात्र हुने भने वृद्धिको प्रकृति हो।\\nनोट: विकासको सम्बन्ध कार्यक्षमता, सीप र व्यवहारमा आउने परिपक्वतासँग हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विकास (Development) को प्रकृति कस्तो हुन्छ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वृद्धि (Growth) सामान्यतया कहिले रोकिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'वृद्धि (Growth) सामान्यतया कहिले रोकिन्छ?', E'निश्चित उमेर वा परिपक्वता पछि', E'गर्भधारणको अवस्थामा', E'मृत्युको समयमा', E'कहिल्यै रोकिँदैन', E'A', E'**वृद्धि निश्चित उमेर वा परिपक्वता (Maturity) पछि रोकिन्छ।**\\n- विकास भने गर्भधारणदेखि मृत्युसम्म (Womb to Tomb) जीवनभर चलिरहन्छ।\\nनोट: यही नै वृद्धि र विकासबीचको एउटा महत्त्वपूर्ण भिन्नता हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वृद्धि (Growth) सामान्यतया कहिले रोकिन्छ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विकास (Development) कुन अवधिसम्म निरन्तर चलिरहन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'विकास (Development) कुन अवधिसम्म निरन्तर चलिरहन्छ?', E'जन्मदेखि मृत्युसम्म', E'जन्मदेखि १८ वर्षसम्म', E'गर्भधारणदेखि जन्मसम्म', E'गर्भधारणदेखि मृत्युसम्म', E'D', E'**विकास गर्भधारणदेखि मृत्युसम्म (Womb to Tomb / Lifelong) निरन्तर चलिरहने प्रक्रिया हो।**\\nनोट: वृद्धि भने परिपक्वता पछि रोकिन्छ, तर विकास जीवनभर चलिरहन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विकास (Development) कुन अवधिसम्म निरन्तर चलिरहन्छ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'निम्नमध्ये कुनलाई प्रत्यक्ष मापन र अवलोकन गर्न सकिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'निम्नमध्ये कुनलाई प्रत्यक्ष मापन र अवलोकन गर्न सकिन्छ?', E'वृद्धि', E'विकास', E'परिपक्वता', E'सिकाइ', E'A', E'**वृद्धिलाई प्रत्यक्ष मापन र अवलोकन गर्न सकिन्छ (Measurable)।**\\n- विकास भने व्यवहारबाट अवलोकन गरिने हुँदा प्रत्यक्ष मापन कठिन हुन्छ।\\nनोट: उचाइ, तौल र लम्बाइ जस्ता वृद्धिका पक्षलाई नाप्न-तौलन सकिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:निम्नमध्ये कुनलाई प्रत्यक्ष मापन र अवलोकन गर्न सकिन्छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिरोपादीय नियम (Cephalocaudal sequence) ले विकासको कुन दिशा जनाउँछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'शिरोपादीय नियम (Cephalocaudal sequence) ले विकासको कुन दिशा जनाउँछ?', E'खुट्टाबाट टाउकोतर्फ', E'टाउकोबाट खुट्टातर्फ (Head to Toe)', E'शरीरको केन्द्रबाट बाहिरतर्फ', E'बाहिरबाट केन्द्रतर्फ', E'B', E'**शिरोपादीय नियम (Cephalocaudal sequence) ले टाउकोबाट खुट्टातर्फ (Head to Toe) हुने विकास जनाउँछ।**\\n- शरीरको केन्द्रबाट बाहिरी अङ्गतर्फ हुने विकासलाई भने समीप-दूर नियम भनिन्छ।\\nनोट: यसको क्रम टाउको र अनुहार → घाँटी र छाती → धड → खुट्टा हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिरोपादीय नियम (Cephalocaudal sequence) ले विकासको कुन दिशा जनाउँछ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समीप-दूर नियम (Proximodistal sequence) ले विकासको कुन दिशा जनाउँछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'समीप-दूर नियम (Proximodistal sequence) ले विकासको कुन दिशा जनाउँछ?', E'टाउकोबाट खुट्टातर्फ', E'खुट्टाबाट टाउकोतर्फ', E'बाहिरी अङ्गबाट केन्द्रतर्फ', E'शरीरको केन्द्रबाट बाहिरी अङ्गतर्फ', E'D', E'**समीप-दूर नियम (Proximodistal sequence) ले शरीरको केन्द्रबाट बाहिरी अङ्गतर्फ (Center to Outward) हुने विकास जनाउँछ।**\\n- टाउकोबाट खुट्टातर्फ हुने विकासलाई भने शिरोपादीय नियम भनिन्छ।\\nनोट: यसको क्रम मुटु/मेरुदण्ड → पाखुरा → हातका पञ्जा → औंला हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समीप-दूर नियम (Proximodistal sequence) ले विकासको कुन दिशा जनाउँछ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विकासको क्रम सामान्यतया कुन दिशामा अघि बढ्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'विकासको क्रम सामान्यतया कुन दिशामा अघि बढ्छ?', E'विशिष्टबाट सामान्यतर्फ', E'जटिलबाट सरलतर्फ', E'सामान्यबाट विशिष्टतर्फ', E'अनियमित रूपमा', E'C', E'**विकासको क्रम सधैं सामान्यबाट विशिष्टतर्फ (General to Specific) अघि बढ्छ।**\\nनोट: उदाहरणका लागि, बच्चाले पहिले पूरै पाखुरा चलाउँछ र पछि मात्र औंलाहरूले वस्तु समात्न सक्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विकासको क्रम सामान्यतया कुन दिशामा अघि बढ्छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'मानव विकासका प्रमुख दुई निर्धारक तत्त्व कुन-कुन हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'मानव विकासका प्रमुख दुई निर्धारक तत्त्व कुन-कुन हुन्?', E'वंशाणुक्रम र वातावरण', E'शिक्षा र समाज', E'आहार र व्यायाम', E'परिवार र विद्यालय', E'A', E'**मानव विकासका प्रमुख दुई निर्धारक वंशाणुक्रम (Heredity) र वातावरण (Environment) हुन्।**\\n- शिक्षा, समाज, परिवार र विद्यालय भने वातावरणीय तत्त्वका अंश हुन्।\\nनोट: विकासमा वंशाणुगत गुण र वातावरणबीच निरन्तर अन्तरक्रिया हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:मानव विकासका प्रमुख दुई निर्धारक तत्त्व कुन-कुन हुन्?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'मानव कोषभित्र कति जोडा गुणसूत्र (Chromosome) पाइन्छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'मानव कोषभित्र कति जोडा गुणसूत्र (Chromosome) पाइन्छन्?', E'२१ जोडा', E'२२ जोडा', E'२४ जोडा', E'२३ जोडा', E'D', E'**मानव कोषभित्र २३ जोडा गुणसूत्र (Chromosome) पाइन्छन्।**\\nनोट: गुणसूत्रभित्र वंशाणु (Gene) पाइन्छ, जसले पुर्ख्यौली गुण सन्ततिमा सार्ने काम गर्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:मानव कोषभित्र कति जोडा गुणसूत्र (Chromosome) पाइन्छन्?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'गुणसूत्र (Chromosome) मानिसको कुन अङ्गमा पाइन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'गुणसूत्र (Chromosome) मानिसको कुन अङ्गमा पाइन्छ?', E'मानव कोषको केन्द्रिकाभित्र', E'रगतमा', E'मस्तिष्कमा', E'हड्डीको मज्जामा', E'A', E'**गुणसूत्र मानव कोषको केन्द्रिका (Nucleus) भित्र पाइन्छ।**\\nनोट: गुणसूत्रमा रहेको वंशाणु (Gene) ले रूप, रङ, आकृति जस्ता वंशानुगत गुण निर्धारण गर्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:गुणसूत्र (Chromosome) मानिसको कुन अङ्गमा पाइन्छ?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विकासको ''शिरदेखि पैतालाको क्रम र भित्रदेखि बाहिरको क्रम'' प्रस्तुत गर्ने विद्वान् को हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'विकासको ''शिरदेखि पैतालाको क्रम र भित्रदेखि बाहिरको क्रम'' प्रस्तुत गर्ने विद्वान् को हुन्?', E'स्टेनली हल', E'अर्नाल्ड गेसल', E'रबर्ट ह्याभिगहर्स्ट', E'जिन पियाजे', E'B', E'**विकासको शिरदेखि पैतालाको क्रम र भित्रदेखि बाहिरको क्रम प्रस्तुत गर्ने विद्वान् अर्नाल्ड गेसल (Arnold Gesell) हुन्।**\\n- स्टेनली हलले विकासमा कोशेढुङ्गा (Milestones) को अवधारणा दिए।\\n- रबर्ट ह्याभिगहर्स्टले विकासात्मक कार्यको अवधारणा दिए।\\n- जिन पियाजेले सञ्ज्ञानात्मक विकासको सिद्धान्त दिए।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विकासको ''शिरदेखि पैतालाको क्रम र भित्रदेखि बाहिरको क्रम'' प्रस्तुत गर्ने विद्वान् को हुन्?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विकासमा कोशेढुङ्गाहरू (Milestones) को अवधारणा प्रदान गर्ने विद्वान् को हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'विकासमा कोशेढुङ्गाहरू (Milestones) को अवधारणा प्रदान गर्ने विद्वान् को हुन्?', E'अर्नाल्ड गेसल', E'रबर्ट ह्याभिगहर्स्ट', E'स्टेनली हल', E'लरेन्स कोहलबर्ग', E'C', E'**विकासमा कोशेढुङ्गा (Milestones) को अवधारणा प्रदान गर्ने विद्वान् स्टेनली हल (Stanley Hall) हुन्।**\\n- अर्नाल्ड गेसलले शिरोपादीय र समीप-दूर विकासक्रम प्रस्तुत गरे।\\n- रबर्ट ह्याभिगहर्स्टले विकासात्मक कार्यको अवधारणा दिए।\\n- लरेन्स कोहलबर्गले नैतिक विकासको सिद्धान्त दिए।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विकासमा कोशेढुङ्गाहरू (Milestones) को अवधारणा प्रदान गर्ने विद्वान् को हुन्?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'परिपक्वता (Maturation) भनेको के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'परिपक्वता (Maturation) भनेको के हो?', E'सिकाइबाट प्राप्त हुने गुण', E'वंशाणुक्रमद्वारा निर्धारित गुणहरूको क्रमिक विकासको प्रक्रिया', E'वातावरणको प्रत्यक्ष प्रभाव', E'अभ्यासको परिणाम', E'B', E'**परिपक्वता भनेको वंशाणुक्रमद्वारा निर्धारित गुणहरूको क्रमिक विकासको प्रक्रिया हो।**\\n- सिकाइ र अभ्यास भने अनुभव र वातावरणमा आधारित हुन्छन्।\\nनोट: परिपक्वता अचेतन अवस्थामा पनि स्वतः सञ्चालन भइरहने प्रक्रिया हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:परिपक्वता (Maturation) भनेको के हो?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विकासको प्रतिफल कुन दुई कुराको योगफल हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'विकासको प्रतिफल कुन दुई कुराको योगफल हो?', E'वृद्धि र पोषण', E'शिक्षा र अभ्यास', E'परिपक्वता र सिकाइ', E'आहार र व्यायाम', E'C', E'**विकासको प्रतिफल भनेको परिपक्वता र सिकाइ (Maturation and Learning) को योगफल हो।**\\nनोट: परिपक्वता वंशाणुक्रमसँग र सिकाइ वातावरण-अनुभवसँग सम्बन्धित हुन्छ; यी दुवैको अन्तरक्रियाले विकास निर्धारण गर्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विकासको प्रतिफल कुन दुई कुराको योगफल हो?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वृद्धि र विकासको सम्बन्धबारे निम्नमध्ये कुन भनाइ सही हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'वृद्धि र विकासको सम्बन्धबारे निम्नमध्ये कुन भनाइ सही हो?', E'विकास वृद्धिको एउटा अंश मात्र हो', E'वृद्धि र विकास पूर्ण रूपमा उस्तै हुन्', E'वृद्धि विकासभन्दा ठूलो अवधारणा हो', E'वृद्धि विकासको एउटा सानो अंश मात्र हो', E'D', E'**वृद्धि विकासको एउटा सानो अंश मात्र हो।**\\nनोट: वृद्धिबिना पनि विकास सम्भव छ, किनभने शारीरिक आकार नबढे पनि मानिसको मानसिक, सामाजिक र नैतिक कार्यक्षमता बढ्न सक्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वृद्धि र विकासको सम्बन्धबारे निम्नमध्ये कुन भनाइ सही हो?'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''वातावरण त्यो बाहिरी शक्ति हो जसले हामीलाई प्रभावित गर्छ'' भनी कसले परिभाषित गरेका छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'''वातावरण त्यो बाहिरी शक्ति हो जसले हामीलाई प्रभावित गर्छ'' भनी कसले परिभाषित गरेका छन्?', E'ई.जे. रस (E.J. Ross)', E'स्टेनली हल', E'अर्नाल्ड गेसल', E'रबर्ट ह्याभिगहर्स्ट', E'A', E'**''वातावरण त्यो बाहिरी शक्ति हो जसले हामीलाई प्रभावित गर्छ'' भनी ई.जे. रस (E.J. Ross) ले परिभाषित गरेका छन्।**\\n- स्टेनली हलले कोशेढुङ्गाको अवधारणा दिए।\\n- अर्नाल्ड गेसलले विकासक्रमका नियम दिए।\\n- रबर्ट ह्याभिगहर्स्टले विकासात्मक कार्यको अवधारणा दिए।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''वातावरण त्यो बाहिरी शक्ति हो जसले हामीलाई प्रभावित गर्छ'' भनी कसले परिभाषित गरेका छन्?'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'हरेक व्यक्तिको विकासको दर फरक-फरक हुन्छ भन्ने नियमलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'हरेक व्यक्तिको विकासको दर फरक-फरक हुन्छ भन्ने नियमलाई के भनिन्छ?', E'निरन्तरताको नियम', E'वैयक्तिक भिन्नताको नियम', E'सहसम्बन्धको नियम', E'एकीकरणको नियम', E'B', E'**हरेक व्यक्तिको विकासको दर फरक हुन्छ भन्ने नियमलाई वैयक्तिक भिन्नताको नियम (Law of Individual Differences) भनिन्छ।**\\nनोट: यही कारण एउटै कक्षाका विद्यार्थीहरूको शारीरिक, मानसिक र सामाजिक विकासको स्तर फरक-फरक हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:हरेक व्यक्तिको विकासको दर फरक-फरक हुन्छ भन्ने नियमलाई के भनिन्छ?'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वृद्धि (Growth) मुख्यतया शरीरका कुन पक्षसँग सम्बन्धित हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'वृद्धि (Growth) मुख्यतया शरीरका कुन पक्षसँग सम्बन्धित हुन्छ?', E'कार्यक्षमता र सीप', E'व्यवहार र चरित्र', E'आकार, तौल र लम्बाइ', E'बुद्धि र भावना', E'C', E'**वृद्धि शरीरका अङ्गहरूको आकार, तौल र लम्बाइमा हुने परिवर्तनसँग सम्बन्धित हुन्छ।**\\n- कार्यक्षमता, सीप, व्यवहार र भावनासँग भने विकास सम्बन्धित हुन्छ।\\nनोट: वृद्धि परिमाणात्मक हुने हुँदा यसलाई प्रत्यक्ष नाप्न सकिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वृद्धि (Growth) मुख्यतया शरीरका कुन पक्षसँग सम्बन्धित हुन्छ?'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विकास (Development) मुख्यतया कुन पक्षसँग सम्बन्धित हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 20, E'विकास (Development) मुख्यतया कुन पक्षसँग सम्बन्धित हुन्छ?', E'आकार र तौल', E'लम्बाइ र मोटाइ', E'कार्यक्षमता, सीप र व्यवहार', E'हड्डी र मांसपेशी', E'C', E'**विकास कार्यक्षमता, सीप र व्यवहारमा आउने परिपक्वतासँग सम्बन्धित हुन्छ।**\\n- आकार, तौल र लम्बाइसँग भने वृद्धि सम्बन्धित हुन्छ।\\nनोट: विकास गुणात्मक हुने हुँदा यसलाई व्यवहारबाट अवलोकन गरी मात्र थाहा पाउन सकिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विकास (Development) मुख्यतया कुन पक्षसँग सम्बन्धित हुन्छ?'), v_set_id, v_q_id, 20)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: मानव वृद्धि र विकास — विकासका चरणहरू (आधारभूत तह — भाग २) (20 Q)
  v_set_id := extensions.uuid_generate_v5('7848483a-8a9e-4c87-be7f-4506b0fd8fc3'::uuid, E'मानव वृद्धि र विकास — विकासका चरणहरू (आधारभूत तह — भाग २)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '8dafc3cd-62b2-45e0-905e-aa6c841526f2'::uuid, '7848483a-8a9e-4c87-be7f-4506b0fd8fc3'::uuid, E'मानव वृद्धि र विकास — विकासका चरणहरू (आधारभूत तह — भाग २)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '7848483a-8a9e-4c87-be7f-4506b0fd8fc3'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नवजात अवस्था (Infancy Period) कति अवधिको हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'नवजात अवस्था (Infancy Period) कति अवधिको हुन्छ?', E'जन्मदेखि २ हप्तासम्म', E'जन्मदेखि २ वर्षसम्म', E'जन्मदेखि ६ महिनासम्म', E'गर्भधारणदेखि जन्मसम्म', E'A', E'**नवजात अवस्था (Infancy) जन्मदेखि २ हप्तासम्मको अवधि हो।**\\n- जन्मदेखि २ वर्षसम्मको अवधि भने शैशवावस्था हो।\\n- गर्भधारणदेखि जन्मसम्मको अवधि गर्भावस्था हो।\\nनोट: नवजात अवस्था जीवनको सबैभन्दा छोटो अवस्था हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नवजात अवस्था (Infancy Period) कति अवधिको हुन्छ?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शैशव अवस्था (Babyhood Period) कति अवधिको हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'शैशव अवस्था (Babyhood Period) कति अवधिको हुन्छ?', E'जन्मदेखि २ हप्तासम्म', E'२ हप्तादेखि २ वर्षसम्म', E'२ वर्षदेखि ६ वर्षसम्म', E'६ वर्षदेखि १२ वर्षसम्म', E'B', E'**शैशव अवस्था (Babyhood) २ हप्तादेखि २ वर्षसम्मको अवधि हो।**\\n- जन्मदेखि २ हप्तासम्मको अवधि नवजात अवस्था हो।\\n- २ देखि ६ वर्षको अवधि पूर्व बाल्यावस्था हो।\\n- ६ देखि १२ वर्षको अवधि उत्तरबाल्यावस्था हो।\\nनोट: शैशवावस्थालाई विकासको वास्तविक आधारशिला मानिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शैशव अवस्था (Babyhood Period) कति अवधिको हुन्छ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पूर्व बाल्यावस्था (Early Childhood) कति उमेर अवधिको हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'पूर्व बाल्यावस्था (Early Childhood) कति उमेर अवधिको हुन्छ?', E'२ हप्तादेखि २ वर्ष', E'२ वर्षदेखि ६ वर्ष', E'६ वर्षदेखि १२ वर्ष', E'१२ वर्षदेखि १९ वर्ष', E'B', E'**पूर्व बाल्यावस्था (Early Childhood) २ वर्षदेखि ६ वर्षको अवधि हो।**\\n- २ हप्तादेखि २ वर्ष शैशवावस्था हो।\\n- ६ देखि १२ वर्ष उत्तरबाल्यावस्था हो।\\n- १२ देखि १९ वर्ष किशोरावस्था हो।\\nनोट: पूर्व बाल्यावस्थामा बालबालिका जिज्ञासु, उत्सुक र अनुकरण गर्ने स्वभावका हुन्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पूर्व बाल्यावस्था (Early Childhood) कति उमेर अवधिको हुन्छ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'मानव जीवनको सबैभन्दा छोटो विकास अवस्था कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'मानव जीवनको सबैभन्दा छोटो विकास अवस्था कुन हो?', E'गर्भावस्था', E'नवजात अवस्था', E'शैशवावस्था', E'किशोरावस्था', E'B', E'**मानव जीवनको सबैभन्दा छोटो विकास अवस्था नवजात अवस्था (Infancy) हो, जुन जन्मदेखि २ हप्तासम्म मात्र रहन्छ।**\\n- गर्भावस्था लगभग ९ महिनाको हुन्छ।\\n- शैशवावस्था २ हप्तादेखि २ वर्षसम्म रहन्छ।\\n- किशोरावस्था १२ देखि १९ वर्षसम्म रहन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:मानव जीवनको सबैभन्दा छोटो विकास अवस्था कुन हो?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विकासको ''वास्तविक आधारशिला'' कुन अवस्थालाई मानिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'विकासको ''वास्तविक आधारशिला'' कुन अवस्थालाई मानिन्छ?', E'शैशवावस्था', E'नवजात अवस्था', E'किशोरावस्था', E'वृद्धावस्था', E'A', E'**विकासको वास्तविक आधारशिला शैशवावस्था (Babyhood) लाई मानिन्छ।**\\nनोट: यस अवस्थामा बालकको शारीरिक, मानसिक, सामाजिक र संवेगात्मक विकासको जग बस्ने हुनाले यसलाई आधारशिला भनिएको हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विकासको ''वास्तविक आधारशिला'' कुन अवस्थालाई मानिन्छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'उत्तरबाल्यावस्था (Late Childhood) को उमेर समूह कति हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'उत्तरबाल्यावस्था (Late Childhood) को उमेर समूह कति हो?', E'२ देखि ६ वर्ष', E'६ देखि १२ वर्ष', E'१२ देखि १९ वर्ष', E'१८ देखि ४० वर्ष', E'B', E'**उत्तरबाल्यावस्था (Late Childhood) को उमेर समूह ६ देखि १२ वर्ष (स्कुले उमेर) हो।**\\n- २ देखि ६ वर्ष पूर्व बाल्यावस्था हो।\\n- १२ देखि १९ वर्ष किशोरावस्था हो।\\n- १८ देखि ४० वर्ष पूर्व वयस्क अवस्था हो।\\nनोट: यस अवस्थामा शारीरिक विकास सुस्त र स्थिर गतिमा हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:उत्तरबाल्यावस्था (Late Childhood) को उमेर समूह कति हो?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''गिरोहको उमेर'' (Gang Age) भनेर कुन अवस्थालाई चिनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'''गिरोहको उमेर'' (Gang Age) भनेर कुन अवस्थालाई चिनिन्छ?', E'पूर्व बाल्यावस्था', E'किशोरावस्था', E'उत्तरबाल्यावस्था', E'शैशवावस्था', E'C', E'**''गिरोहको उमेर'' (Gang Age) भनेर उत्तरबाल्यावस्थालाई चिनिन्छ, किनभने यस उमेरमा बालबालिकाले अभिभावकभन्दा आफ्ना साथीहरूको समूहलाई बढी महत्त्व दिन्छन्।**\\nनोट: उत्तरबाल्यावस्थालाई ''खेलको उमेर'' र ''विद्यालय जाने उमेर'' पनि भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''गिरोहको उमेर'' (Gang Age) भनेर कुन अवस्थालाई चिनिन्छ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'किशोरावस्था (Adolescence) को उमेर समूह सामान्यतया कति मानिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'किशोरावस्था (Adolescence) को उमेर समूह सामान्यतया कति मानिन्छ?', E'६ देखि १२ वर्ष', E'१२ देखि १९ वर्ष', E'२ देखि ६ वर्ष', E'४० देखि ६० वर्ष', E'B', E'**किशोरावस्था (Adolescence) को उमेर समूह सामान्यतया १२ देखि १९ वर्ष हो।**\\n- ६ देखि १२ वर्ष उत्तरबाल्यावस्था हो।\\n- २ देखि ६ वर्ष पूर्व बाल्यावस्था हो।\\n- ४० देखि ६० वर्ष मध्यावस्था हो।\\nनोट: किशोरावस्थालाई जीवनको सङ्क्रमणकालीन अवस्था मानिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:किशोरावस्था (Adolescence) को उमेर समूह सामान्यतया कति मानिन्छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'किशोरावस्थालाई ''आँधी र हुरीको अवस्था'' (Stress and Storm) भन्ने विद्वान् को हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'किशोरावस्थालाई ''आँधी र हुरीको अवस्था'' (Stress and Storm) भन्ने विद्वान् को हुन्?', E'अर्नाल्ड गेसल', E'रबर्ट ह्याभिगहर्स्ट', E'जी. स्टानले हल', E'लरेन्स कोहलबर्ग', E'C', E'**किशोरावस्थालाई ''आँधी र हुरीको अवस्था'' (Stress and Storm) भन्ने विद्वान् जी. स्टानले हल (G. Stanley Hall) हुन्।**\\n- अर्नाल्ड गेसलले शिरोपादीय विकासक्रम प्रस्तुत गरे।\\n- रबर्ट ह्याभिगहर्स्टले विकासात्मक कार्यको अवधारणा दिए।\\n- लरेन्स कोहलबर्गले नैतिक विकासको सिद्धान्त दिए।\\nनोट: यस अवस्थामा तीव्र हार्मोनल परिवर्तनले संवेगहरू छिटो-छिटो परिवर्तन हुन्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:किशोरावस्थालाई ''आँधी र हुरीको अवस्था'' (Stress and Storm) भन्ने विद्वान् को हुन्?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विकासात्मक कार्य (Developmental Task) को अवधारणाका जनक को हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'विकासात्मक कार्य (Developmental Task) को अवधारणाका जनक को हुन्?', E'रबर्ट जे. ह्याभिगहर्स्ट', E'जी. स्टानले हल', E'अर्नाल्ड गेसल', E'जिन पियाजे', E'A', E'**विकासात्मक कार्यको अवधारणाका जनक रबर्ट जे. ह्याभिगहर्स्ट (Robert J. Havighurst) हुन्।**\\n- जी. स्टानले हलले किशोरावस्थालाई आँधी र हुरीको अवस्था भने।\\n- अर्नाल्ड गेसलले विकासक्रमका नियम दिए।\\n- जिन पियाजेले सञ्ज्ञानात्मक विकासको सिद्धान्त दिए।\\nनोट: विकासात्मक कार्य भनेको जीवनको निश्चित चरणमा व्यक्तिले पूरा गर्नुपर्ने कार्यहरू हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विकासात्मक कार्य (Developmental Task) को अवधारणाका जनक को हुन्?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'ह्याभिगहर्स्टका अनुसार विकासात्मक कार्यको आधार कुन तीन कुराको योगफल हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'ह्याभिगहर्स्टका अनुसार विकासात्मक कार्यको आधार कुन तीन कुराको योगफल हो?', E'वंशाणुक्रम, वातावरण र शिक्षा', E'परिपक्वता, व्यक्तिगत आकांक्षा र सामाजिक अपेक्षा', E'शारीरिक, मानसिक र सामाजिक विकास', E'आहार, व्यायाम र विश्राम', E'B', E'**विकासात्मक कार्यको आधार परिपक्वता (Maturation), व्यक्तिगत आकांक्षा र सामाजिक अपेक्षाको योगफल हो।**\\nनोट: विकासात्मक कार्य पूरा भएमा व्यक्ति खुशी हुन्छ र अर्को चरणमा सफलता मिल्छ; पूरा नभएमा हीनताबोध बढ्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:ह्याभिगहर्स्टका अनुसार विकासात्मक कार्यको आधार कुन तीन कुराको योगफल हो?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कोहलबर्गको नैतिक विकासको सही क्रम कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'कोहलबर्गको नैतिक विकासको सही क्रम कुन हो?', E'परम्परागत → पूर्व-परम्परागत → उत्तर-परम्परागत', E'उत्तर-परम्परागत → परम्परागत → पूर्व-परम्परागत', E'पूर्व-परम्परागत → परम्परागत → उत्तर-परम्परागत', E'पूर्व-परम्परागत → उत्तर-परम्परागत → परम्परागत', E'C', E'**कोहलबर्गको नैतिक विकासको सही क्रम: पूर्व-परम्परागत नैतिकता (पुरस्कार/दण्ड) → परम्परागत नैतिकता (सामाजिक नियम) → उत्तर-परम्परागत नैतिकता (आन्तरिक सिद्धान्त) हो।**\\nनोट: पूर्व-परम्परागत अवस्थामा बालकले पुरस्कार र दण्डका आधारमा सही-गलत छुट्याउँछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कोहलबर्गको नैतिक विकासको सही क्रम कुन हो?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'ह्याभिगहर्स्टका अनुसार किशोरावस्थाको प्रमुख विकासात्मक कार्य कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'ह्याभिगहर्स्टका अनुसार किशोरावस्थाको प्रमुख विकासात्मक कार्य कुन हो?', E'हिँड्न, बोल्न र खान सिक्ने', E'सामाजिक समूहमा खेल्न सिक्ने', E'स्व-पहिचान र पेसा छनोट गर्ने', E'जीवनसाथी रोज्ने र परिवार सुरु गर्ने', E'C', E'**किशोरावस्था (१२-१८ वर्ष) को प्रमुख विकासात्मक कार्य स्व-पहिचान (Self-identity) र पेसा छनोट गर्ने हो।**\\n- हिँड्न, बोल्न र खान सिक्ने शैशवावस्थाको कार्य हो।\\n- सामाजिक समूहमा खेल्न सिक्ने उत्तरबाल्यावस्थाको कार्य हो।\\n- जीवनसाथी रोज्ने प्रारम्भिक वयस्क अवस्थाको कार्य हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:ह्याभिगहर्स्टका अनुसार किशोरावस्थाको प्रमुख विकासात्मक कार्य कुन हो?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'मध्यावस्था (Middle Age) कुन उमेर अवधिलाई भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'मध्यावस्था (Middle Age) कुन उमेर अवधिलाई भनिन्छ?', E'१८ देखि ४० वर्ष', E'४० देखि ६० वर्ष', E'६० वर्षपछि', E'१२ देखि १८ वर्ष', E'B', E'**मध्यावस्था (Middle Age) ४० देखि ६० वर्षको उमेर हो।**\\n- १८ देखि ४० वर्ष पूर्व वयस्क अवस्था हो।\\n- ६० वर्षपछिको अवधि वृद्धावस्था हो।\\n- १२ देखि १८ वर्ष किशोरावस्था हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:मध्यावस्था (Middle Age) कुन उमेर अवधिलाई भनिन्छ?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वृद्धावस्था (Old Age) कुन उमेरदेखि सुरु हुने अवधि हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'वृद्धावस्था (Old Age) कुन उमेरदेखि सुरु हुने अवधि हो?', E'४० वर्षपछि', E'५० वर्षपछि', E'६० वर्षपछि', E'७० वर्षपछि', E'C', E'**वृद्धावस्था ६० वर्षपछिको अवधि हो।**\\n- ४० देखि ६० वर्ष मध्यावस्था हो।\\nनोट: हर्लकका अनुसार विकासका चरणहरू गर्भावस्थादेखि वृद्धावस्थासम्म क्रमिक रूपमा अघि बढ्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वृद्धावस्था (Old Age) कुन उमेरदेखि सुरु हुने अवधि हो?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'किशोरावस्थाको उप-विभाजनको सही क्रम कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'किशोरावस्थाको उप-विभाजनको सही क्रम कुन हो?', E'प्रारम्भिक (१२–१४) → मध्य (१५–१७) → उत्तर (१८–१९)', E'उत्तर (१८–१९) → मध्य (१५–१७) → प्रारम्भिक (१२–१४)', E'मध्य (१५–१७) → प्रारम्भिक (१२–१४) → उत्तर (१८–१९)', E'प्रारम्भिक (१२–१४) → उत्तर (१८–१९) → मध्य (१५–१७)', E'A', E'**किशोरावस्थाको उप-विभाजनको सही क्रम: प्रारम्भिक किशोरावस्था (१२–१४ वर्ष) → मध्य किशोरावस्था (१५–१७ वर्ष) → उत्तर किशोरावस्था (१८–१९ वर्ष) हो।**\\nनोट: यो अवस्थामा अमूर्त सोच र स्व-पहिचानको खोजी प्रमुख हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:किशोरावस्थाको उप-विभाजनको सही क्रम कुन हो?'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'ह्याभिगहर्स्टका अनुसार शैशवावस्था र पूर्व-बाल्यावस्था (०-६ वर्ष) को प्रमुख विकासात्मक कार्य के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'ह्याभिगहर्स्टका अनुसार शैशवावस्था र पूर्व-बाल्यावस्था (०-६ वर्ष) को प्रमुख विकासात्मक कार्य के हो?', E'स्व-पहिचान र पेसा छनोट गर्ने', E'हिँड्न, बोल्न र खान सिक्ने', E'नागरिक दायित्व निर्वाह गर्ने', E'जीवनसाथी रोज्ने', E'B', E'**शैशवावस्था र पूर्व-बाल्यावस्था (०-६ वर्ष) को प्रमुख विकासात्मक कार्य हिँड्न, बोल्न र खान सिक्ने हो।**\\n- स्व-पहिचान र पेसा छनोट किशोरावस्थाको कार्य हो।\\n- नागरिक दायित्व प्रौढावस्थाको कार्य हो।\\n- जीवनसाथी रोज्ने प्रारम्भिक वयस्क अवस्थाको कार्य हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:ह्याभिगहर्स्टका अनुसार शैशवावस्था र पूर्व-बाल्यावस्था (०-६ वर्ष) को प्रमुख विकासात्मक कार्य के हो?'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'किशोरावस्थामा मानसिक विकास कुन अवस्थामा पुग्दछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'किशोरावस्थामा मानसिक विकास कुन अवस्थामा पुग्दछ?', E'न्यूनतम बिन्दुमा', E'उच्चतम बिन्दुमा', E'स्थिर अवस्थामा', E'ह्रासोन्मुख अवस्थामा', E'B', E'**किशोरावस्थामा मानसिक विकास उच्चतम बिन्दुमा पुग्दछ।**\\nनोट: यस अवस्थामा अमूर्त सोच, तार्किक चिन्तन र कल्पनाशीलता उच्च स्तरमा विकसित हुन्छन्, जसले गर्दा किशोरहरूले पेसागत क्षेत्रको छनोट गर्न सक्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:किशोरावस्थामा मानसिक विकास कुन अवस्थामा पुग्दछ?'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'किशोरावस्थालाई नकारात्मक चरण (Negative Phase) भनी कसले उल्लेख गरेका छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'किशोरावस्थालाई नकारात्मक चरण (Negative Phase) भनी कसले उल्लेख गरेका छन्?', E'शार्लोट बुहलर (Charlotte Buhler)', E'जी. स्टानले हल', E'रबर्ट ह्याभिगहर्स्ट', E'अर्नाल्ड गेसल', E'A', E'**किशोरावस्थालाई नकारात्मक चरण (Negative Phase) भनी शार्लोट बुहलर (Charlotte Buhler) ले उल्लेख गरेकी छन्।**\\n- जी. स्टानले हलले यसलाई आँधी र हुरीको अवस्था भने।\\n- रबर्ट ह्याभिगहर्स्टले विकासात्मक कार्यको अवधारणा दिए।\\n- अर्नाल्ड गेसलले विकासक्रमका नियम दिए।\\nनोट: यस अवस्थामा जीवनप्रति नकारात्मक प्रवृत्तिको विकास हुने हुनाले यसो भनिएको हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:किशोरावस्थालाई नकारात्मक चरण (Negative Phase) भनी कसले उल्लेख गरेका छन्?'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'ह्याभिगहर्स्टका अनुसार उत्तरबाल्यावस्था (६-१२ वर्ष) को प्रमुख विकासात्मक कार्य के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 20, E'ह्याभिगहर्स्टका अनुसार उत्तरबाल्यावस्था (६-१२ वर्ष) को प्रमुख विकासात्मक कार्य के हो?', E'यौन परिपक्वता हासिल गर्ने', E'सामाजिक समूहमा खेल्न र आधारभूत सीप सिक्ने', E'नागरिक दायित्व निर्वाह गर्ने', E'आर्थिक स्थिरता कायम गर्ने', E'B', E'**उत्तरबाल्यावस्था (६-१२ वर्ष) को प्रमुख विकासात्मक कार्य सामाजिक समूहमा खेल्न र आधारभूत सीप (पढ्ने, लेख्ने, गणित) सिक्ने हो।**\\n- यौन परिपक्वता किशोरावस्थासँग सम्बन्धित छ।\\n- नागरिक दायित्व र आर्थिक स्थिरता प्रौढावस्थाका कार्य हुन्।\\nनोट: यस अवस्थामा ''गिरोह'' को भावना प्रबल हुने हुनाले समूहगत सीप सिकाइ महत्त्वपूर्ण हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:ह्याभिगहर्स्टका अनुसार उत्तरबाल्यावस्था (६-१२ वर्ष) को प्रमुख विकासात्मक कार्य के हो?'), v_set_id, v_q_id, 20)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: मानव वृद्धि र विकास — बाल्यावस्था, किशोरावस्था र परिवर्तन (आधारभूत तह — भाग ३) (20 Q)
  v_set_id := extensions.uuid_generate_v5('7848483a-8a9e-4c87-be7f-4506b0fd8fc3'::uuid, E'मानव वृद्धि र विकास — बाल्यावस्था, किशोरावस्था र परिवर्तन (आधारभूत तह — भाग ३)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '8dafc3cd-62b2-45e0-905e-aa6c841526f2'::uuid, '7848483a-8a9e-4c87-be7f-4506b0fd8fc3'::uuid, E'मानव वृद्धि र विकास — बाल्यावस्था, किशोरावस्था र परिवर्तन (आधारभूत तह — भाग ३)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '7848483a-8a9e-4c87-be7f-4506b0fd8fc3'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'किशोरावस्थाको मुख्य शारीरिक परिवर्तन के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'किशोरावस्थाको मुख्य शारीरिक परिवर्तन के हो?', E'यौन परिपक्वता (Puberty)', E'अमूर्त सोच', E'गिरोह भावना', E'मूर्त सोच', E'A', E'**किशोरावस्थाको मुख्य शारीरिक परिवर्तन यौन परिपक्वता (Puberty) हो।**\\n- अमूर्त सोच किशोरावस्थाको मानसिक विशेषता हो, शारीरिक होइन।\\n- गिरोह भावना उत्तरबाल्यावस्थाको सामाजिक विशेषता हो।\\n- मूर्त सोच उत्तरबाल्यावस्थाको मानसिक विशेषता हो।\\nनोट: यस अवस्थामा पिट्युटरी र यौन ग्रन्थीहरू क्रियाशील भई प्राथमिक तथा सहायक यौन विशेषताको विकास हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:किशोरावस्थाको मुख्य शारीरिक परिवर्तन के हो?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'किशोरावस्थाको मुख्य मानसिक विशेषता के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'किशोरावस्थाको मुख्य मानसिक विशेषता के हो?', E'मूर्त सोच', E'यौन परिपक्वता', E'अनुकरण गर्ने प्रवृत्ति', E'अमूर्त सोच (Abstract Thinking)', E'D', E'**किशोरावस्थाको मुख्य मानसिक विशेषता अमूर्त सोच (Abstract Thinking) र कल्पनाशीलता हो।**\\n- मूर्त सोच (Concrete) उत्तरबाल्यावस्थाको विशेषता हो।\\n- यौन परिपक्वता शारीरिक परिवर्तन हो।\\n- अनुकरण गर्ने प्रवृत्ति पूर्व बाल्यावस्थाको विशेषता हो।\\nनोट: यही अमूर्त सोचका कारण किशोरहरूले काल्पनिक र आदर्शवादी चिन्तन गर्न थाल्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:किशोरावस्थाको मुख्य मानसिक विशेषता के हो?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'मूर्त सोच (Concrete Thinking) कुन अवस्थाको प्रमुख मानसिक विशेषता हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'मूर्त सोच (Concrete Thinking) कुन अवस्थाको प्रमुख मानसिक विशेषता हो?', E'उत्तरबाल्यावस्था', E'किशोरावस्था', E'शैशवावस्था', E'वृद्धावस्था', E'A', E'**मूर्त सोच (Concrete Thinking) उत्तरबाल्यावस्थाको प्रमुख मानसिक विशेषता हो।**\\n- किशोरावस्थामा भने अमूर्त सोच (Abstract) विकसित हुन्छ।\\nनोट: उत्तरबाल्यावस्थामा तर्क गर्ने क्षमताको सुरुवात र मूर्त अवधारणा (Concrete concepts) को विकास हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:मूर्त सोच (Concrete Thinking) कुन अवस्थाको प्रमुख मानसिक विशेषता हो?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'उत्तरबाल्यावस्थाको सामाजिक विकासमा कुन भावना प्रमुख हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'उत्तरबाल्यावस्थाको सामाजिक विकासमा कुन भावना प्रमुख हुन्छ?', E'स्व-पहिचानको खोजी', E'''हामी'' र गिरोहको भावना (Group identity)', E'आमाबाबुसँग द्वन्द्व', E'एकाकीपनको भावना', E'B', E'**उत्तरबाल्यावस्थाको सामाजिक विकासमा ''हामी'' र गिरोहको भावना (Group identity) प्रमुख हुन्छ।**\\n- स्व-पहिचानको खोजी र आमाबाबुसँग द्वन्द्व किशोरावस्थाका विशेषता हुन्।\\nनोट: यही कारण उत्तरबाल्यावस्थालाई ''गिरोहको उमेर'' (Gang Age) भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:उत्तरबाल्यावस्थाको सामाजिक विकासमा कुन भावना प्रमुख हुन्छ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'किशोरावस्थाको सामाजिक विकासमा आमाबाबुसँग कस्तो भावना देखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'किशोरावस्थाको सामाजिक विकासमा आमाबाबुसँग कस्तो भावना देखिन्छ?', E'पूर्ण सहयोगको भावना', E'उदासीनताको भावना', E'पूर्ण निर्भरताको भावना', E'विरोधी (द्वन्द्व) भावना', E'D', E'**किशोरावस्थाको सामाजिक विकासमा स्वतन्त्रताको चाहना र आमाबाबुसँग विरोधी (द्वन्द्व) भावना देखिन्छ।**\\nनोट: यस अवस्थामा किशोरले स्वतन्त्र पहिचान खोज्ने हुनाले अभिभावकका नियन्त्रणप्रति प्रतिरोध जनाउँछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:किशोरावस्थाको सामाजिक विकासमा आमाबाबुसँग कस्तो भावना देखिन्छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'किशोरावस्थाको मुख्य कार्य (Main Task) कुन मानिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'किशोरावस्थाको मुख्य कार्य (Main Task) कुन मानिन्छ?', E'स्व-पहिचान (Self-identity) को खोजी गर्नु', E'आधारभूत सीप सिक्नु', E'हिँड्न र बोल्न सिक्नु', E'समूहमा खेल्न सिक्नु', E'A', E'**किशोरावस्थाको मुख्य कार्य स्व-पहिचान (Self-identity) को खोजी गर्नु हो।**\\n- आधारभूत सीप र समूहमा खेल्ने उत्तरबाल्यावस्थाका कार्य हुन्।\\n- हिँड्न र बोल्न सिक्नु शैशवावस्थाको कार्य हो।\\nनोट: यस अवस्थामा अति तीव्र संवेग (Extreme emotions) पनि देखिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:किशोरावस्थाको मुख्य कार्य (Main Task) कुन मानिन्छ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कोहलबर्गको ''परम्परागत'' (Conventional) नैतिक अवस्था कुन विकास अवस्थासँग मेल खान्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'कोहलबर्गको ''परम्परागत'' (Conventional) नैतिक अवस्था कुन विकास अवस्थासँग मेल खान्छ?', E'किशोरावस्था', E'शैशवावस्था', E'उत्तरबाल्यावस्था', E'वृद्धावस्था', E'C', E'**कोहलबर्गको ''परम्परागत'' नैतिक अवस्था उत्तरबाल्यावस्थासँग मेल खान्छ, जसमा बालकले सामाजिक नियम र अपेक्षाअनुसार सही-गलत छुट्याउँछ।**\\n- किशोरावस्थामा भने उत्तर-परम्परागत नैतिकताको सुरुवात हुन्छ।\\nनोट: पूर्व-परम्परागत अवस्थामा बालकले पुरस्कार र दण्डका आधारमा नैतिक निर्णय गर्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कोहलबर्गको ''परम्परागत'' (Conventional) नैतिक अवस्था कुन विकास अवस्थासँग मेल खान्छ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिरोपादीय नियम (Cephalocaudal) अनुसार शारीरिक विकासको सही क्रम कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'शिरोपादीय नियम (Cephalocaudal) अनुसार शारीरिक विकासको सही क्रम कुन हो?', E'खुट्टा → धड → छाती → टाउको', E'धड → टाउको → खुट्टा → छाती', E'मुटु → पाखुरा → पञ्जा → औंला', E'टाउको र अनुहार → घाँटी र छाती → धड → खुट्टा', E'D', E'**शिरोपादीय नियमअनुसार विकासको सही क्रम: टाउको र अनुहार → घाँटी र छाती → धड/पेट → खुट्टा र पाउ हो।**\\n- मुटु → पाखुरा → पञ्जा → औंला भने समीप-दूर नियमको क्रम हो।\\nनोट: यसैले शिशुले पहिले टाउको ठाडो पार्न सिक्छ, अनि मात्र हिँड्न सिक्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिरोपादीय नियम (Cephalocaudal) अनुसार शारीरिक विकासको सही क्रम कुन हो?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समीप-दूर नियम (Proximodistal) अनुसार शारीरिक विकासको सही क्रम कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'समीप-दूर नियम (Proximodistal) अनुसार शारीरिक विकासको सही क्रम कुन हो?', E'मुटु/मेरुदण्ड → पाखुरा → हातका पञ्जा → औंला', E'औंला → पञ्जा → पाखुरा → मुटु', E'टाउको → छाती → धड → खुट्टा', E'पाखुरा → मुटु → औंला → पञ्जा', E'A', E'**समीप-दूर नियमअनुसार विकासको सही क्रम: मुटु/मेरुदण्ड → पाखुरा → हातका पञ्जा → औंला हो।**\\n- टाउको → छाती → धड → खुट्टा भने शिरोपादीय नियमको क्रम हो।\\nनोट: यसैले बच्चाले पहिले पूरै पाखुराले वस्तु तान्छ, पछि मात्र औंलाले सूक्ष्म पकड बनाउँछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समीप-दूर नियम (Proximodistal) अनुसार शारीरिक विकासको सही क्रम कुन हो?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तथ्याङ्कअनुसार लगभग ८०% किशोरीहरूमा प्रथम रजस्वला कति वर्षको उमेरमा सुरु हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'तथ्याङ्कअनुसार लगभग ८०% किशोरीहरूमा प्रथम रजस्वला कति वर्षको उमेरमा सुरु हुन्छ?', E'१२ वर्ष', E'१४ वर्ष', E'१५ वर्ष', E'१६ वर्ष', E'B', E'तथ्याङ्कअनुसार लगभग ८०% किशोरीहरूमा प्रथम रजस्वला **१४ वर्ष** को उमेरमा सुरु भइसकेको हुन्छ।\\nनोट: ११ वर्षमा करिब २०%, १२ वर्षमा ४०%, १३ वर्षमा ६०%, १५ वर्षमा ९०% र १६ वर्षमा शतप्रतिशत किशोरीमा रजस्वला सुरु भएको हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तथ्याङ्कअनुसार लगभग ८०% किशोरीहरूमा प्रथम रजस्वला कति वर्षको उमेरमा सुरु हुन्छ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'किशोरहरू (केटा) ले सामान्यतया परिपक्व उचाइ कति वर्षको उमेरमा प्राप्त गर्छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'किशोरहरू (केटा) ले सामान्यतया परिपक्व उचाइ कति वर्षको उमेरमा प्राप्त गर्छन्?', E'१५/१६ वर्ष', E'१७/१८ वर्ष', E'१८/१९ वर्ष', E'२०/२१ वर्ष', E'D', E'**किशोरहरू (केटा) ले सामान्यतया २०/२१ वर्षको उमेरमा परिपक्व उचाइ प्राप्त गर्छन्।**\\n- किशोरीहरू (केटी) ले भने १५/१६ वर्षमै परिपक्व उचाइ प्राप्त गर्छन्।\\nनोट: किशोरावस्थामा उचाइको विकास चरम अवस्थामा पुग्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:किशोरहरू (केटा) ले सामान्यतया परिपक्व उचाइ कति वर्षको उमेरमा प्राप्त गर्छन्?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'उचाइ बढाउने र यौन अङ्ग क्रियाशील बनाउने वृद्धि हार्मोन कुन ग्रन्थीले उत्पादन गर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'उचाइ बढाउने र यौन अङ्ग क्रियाशील बनाउने वृद्धि हार्मोन कुन ग्रन्थीले उत्पादन गर्छ?', E'थाइराइड ग्रन्थी', E'एड्रिनल ग्रन्थी', E'पिट्युटरी ग्रन्थी', E'यौन ग्रन्थी', E'C', E'**उचाइ बढाउने र यौन अङ्ग क्रियाशील बनाउने वृद्धि हार्मोन पिट्युटरी ग्रन्थी (Pituitary Gland) ले उत्पादन गर्छ।**\\n- यौन ग्रन्थी (अण्डकोष/डिम्बकोष) ले प्राथमिक र सहायक यौन विशेषताको विकास गर्छ।\\nनोट: पिट्युटरी ग्रन्थी खप्परको बिचमा अवस्थित हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:उचाइ बढाउने र यौन अङ्ग क्रियाशील बनाउने वृद्धि हार्मोन कुन ग्रन्थीले उत्पादन गर्छ?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'केटाहरूमा प्राथमिक यौन विशेषताको विकास गर्ने यौन ग्रन्थी कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'केटाहरूमा प्राथमिक यौन विशेषताको विकास गर्ने यौन ग्रन्थी कुन हो?', E'अण्डकोष (Testes)', E'डिम्बकोष (Ovary)', E'पिट्युटरी ग्रन्थी', E'थाइराइड ग्रन्थी', E'A', E'**केटाहरूमा प्राथमिक यौन विशेषताको विकास गर्ने यौन ग्रन्थी अण्डकोष (Testes) हो।**\\n- डिम्बकोष (Ovary) भने केटीहरूको यौन ग्रन्थी हो।\\n- पिट्युटरी ग्रन्थीले वृद्धि हार्मोन उत्पादन गर्छ।\\nनोट: यौन ग्रन्थीहरूले प्राथमिकसँगै सहायक यौन विशेषताको पनि विकास गर्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:केटाहरूमा प्राथमिक यौन विशेषताको विकास गर्ने यौन ग्रन्थी कुन हो?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'किशोरावस्थालाई जीवनको कस्तो अवस्था मानिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'किशोरावस्थालाई जीवनको कस्तो अवस्था मानिन्छ?', E'स्थिर अवस्था', E'सङ्क्रमणकालीन अवस्था (Transition)', E'आधारभूत अवस्था', E'अन्तिम अवस्था', E'B', E'**किशोरावस्थालाई जीवनको सङ्क्रमणकालीन अवस्था (Transitional Period) मानिन्छ, जसमा व्यक्ति बालकबाट वयस्कतर्फ विकसित हुन्छ।**\\nनोट: बच्चा र वयस्कबीचको दोधारे अवस्था पार गर्नुपर्ने हुनाले यसलाई जीवनको कठिन सङ्क्रमण पनि भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:किशोरावस्थालाई जीवनको कस्तो अवस्था मानिन्छ?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'६ वर्षको उमेरमा बालबालिकाको औसत उचाइ लगभग कति हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'६ वर्षको उमेरमा बालबालिकाको औसत उचाइ लगभग कति हुन्छ?', E'४२.६ इन्च', E'४४.६ इन्च', E'४६.६ इन्च', E'४८.६ इन्च', E'C', E'६ वर्षको उमेरमा बालबालिकाको औसत उचाइ लगभग **४६.६ इन्च** हुन्छ।\\nनोट: पूर्वबाल्यावस्थामा वार्षिक उचाइ वृद्धिदर करिब २ इन्च र तौल वृद्धिदर ३-५ पाउण्डसम्म हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:६ वर्षको उमेरमा बालबालिकाको औसत उचाइ लगभग कति हुन्छ?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'उत्तरबाल्यावस्थासम्म आइपुग्दा बालबालिकामा कति ओटा स्थायी दाँत आइसकेका हुन्छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'उत्तरबाल्यावस्थासम्म आइपुग्दा बालबालिकामा कति ओटा स्थायी दाँत आइसकेका हुन्छन्?', E'२० ओटा', E'२४ ओटा', E'३२ ओटा', E'२८ ओटा', E'D', E'**उत्तरबाल्यावस्थासम्म आइपुग्दा बालबालिकामा करिब २८ ओटा स्थायी दाँत आइसकेका हुन्छन्।**\\nनोट: अस्थायी (दूधे) दाँत भने शिशु अवस्थामा ६–८ महिनादेखि निस्कन थाल्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:उत्तरबाल्यावस्थासम्म आइपुग्दा बालबालिकामा कति ओटा स्थायी दाँत आइसकेका हुन्छन्?'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'निम्नमध्ये कुन समूहमा सबै सुखदायी (सकारात्मक) संवेग पर्छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'निम्नमध्ये कुन समूहमा सबै सुखदायी (सकारात्मक) संवेग पर्छन्?', E'क्रोध, इर्ष्या, डाह', E'माया, प्रेम, हर्ष, आनन्द', E'डर, चिन्ता, तनाव', E'रिस, घृणा, द्वेष', E'B', E'**माया, प्रेम, हर्ष र आनन्द सबै सुखदायी (सकारात्मक) संवेग हुन्।**\\n- क्रोध, इर्ष्या, डाह, डर, घृणा जस्ता संवेग भने दुःखदायी (नकारात्मक) संवेग हुन्।\\nनोट: संवेगात्मक विकासमा यी सुखदायी र दुःखदायी संवेगबीच सन्तुलन कायम गर्नु महत्त्वपूर्ण हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:निम्नमध्ये कुन समूहमा सबै सुखदायी (सकारात्मक) संवेग पर्छन्?'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'प्राथमिक विद्यालयका बालबालिकालाई ज्ञान दिलाउन सबैभन्दा उपयुक्त आधार कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'प्राथमिक विद्यालयका बालबालिकालाई ज्ञान दिलाउन सबैभन्दा उपयुक्त आधार कुन हो?', E'ठोस वस्तु र अवलोकन', E'अमूर्त अवधारणा', E'केवल रटान', E'केवल व्याख्यान', E'A', E'**प्राथमिक विद्यालयका बालबालिकालाई ठोस वस्तु र अवलोकनका आधारमा ज्ञान दिलाउनु सबैभन्दा उपयुक्त हुन्छ।**\\nनोट: यस उमेरका बालबालिकामा मूर्त सोच (Concrete thinking) हुने हुनाले अमूर्त अवधारणाभन्दा प्रत्यक्ष अनुभवबाट उनीहरूले राम्ररी सिक्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:प्राथमिक विद्यालयका बालबालिकालाई ज्ञान दिलाउन सबैभन्दा उपयुक्त आधार कुन हो?'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''खेलको उमेर'', ''विद्यालय जाने उमेर'' र ''गिरोहको उमेर'' भनेर कुन अवस्थालाई चिनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'''खेलको उमेर'', ''विद्यालय जाने उमेर'' र ''गिरोहको उमेर'' भनेर कुन अवस्थालाई चिनिन्छ?', E'किशोरावस्था', E'पूर्व बाल्यावस्था', E'उत्तरबाल्यावस्था', E'शैशवावस्था', E'C', E'**''खेलको उमेर'' (Play Age), ''विद्यालय जाने उमेर'' (School Age) र ''गिरोहको उमेर'' (Gang Age) भनेर उत्तरबाल्यावस्था (६-१२ वर्ष) लाई चिनिन्छ।**\\nनोट: यस अवस्थामा शारीरिक विकास सुस्त हुन्छ तर सामाजिक र मानसिक विकास उल्लेख्य हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''खेलको उमेर'', ''विद्यालय जाने उमेर'' र ''गिरोहको उमेर'' भनेर कुन अवस्थालाई चिनिन्छ?'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शारीरिक असक्षमताले किशोरहरूमा प्रायः के उत्पन्न गर्न सक्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 20, E'शारीरिक असक्षमताले किशोरहरूमा प्रायः के उत्पन्न गर्न सक्छ?', E'आत्मविश्वास', E'आत्मनिर्भरता', E'आत्महीनता (Inferiority)', E'आत्मसम्मान', E'C', E'**शारीरिक असक्षमताले किशोरहरूमा प्रायः आत्महीनता (Inferiority) उत्पन्न गर्न सक्छ।**\\nनोट: किशोरावस्थामा यौन अनुरूप शरीर विकास नहुनुले स्वधारणा (Self-concept) लाई नकारात्मक रूपमा प्रभावित गर्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शारीरिक असक्षमताले किशोरहरूमा प्रायः के उत्पन्न गर्न सक्छ?'), v_set_id, v_q_id, 20)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  RAISE NOTICE 'Unit ख-२ upsert complete: 6 sets, 115 questions.';
END $$;
