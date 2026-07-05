-- Idempotent UPSERT import: निमावि प्रथम पत्र — ङ-२ गणितीय क्षमता (Level I topic-wise sets)
-- Override same-identity sets/questions; never deletes. Generated 2026-07-05T12:13:52.889Z.
DO $$
DECLARE
  v_module_id uuid := '6695669a-f40e-421a-a4ec-b09bbeaf56c4'::uuid;
  v_set_id uuid;
  v_q_id uuid;
BEGIN

  -- Set: गणितीय क्षमताः श्रेणीक्रम समस्याहरू (आधारभूत तह) (15 Q)
  v_set_id := extensions.uuid_generate_v5('1e60e4c1-6741-4d59-9131-fbcd078b4e43'::uuid, E'गणितीय क्षमताः श्रेणीक्रम समस्याहरू (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'db9d9515-ced5-4a90-a4ac-3a8927342e98'::uuid, '1e60e4c1-6741-4d59-9131-fbcd078b4e43'::uuid, E'गणितीय क्षमताः श्रेणीक्रम समस्याहरू (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '1e60e4c1-6741-4d59-9131-fbcd078b4e43'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'Complete the given series: 1, 1, 2, 6, 24, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'Complete the given series: 1, 1, 2, 6, 24, ?', E'120', E'100', E'110', E'104', E'A', E'**यो श्रेणी फ्याक्टोरियल (0!,1!,2!,3!,4!,5!) मा आधारित छ — अर्थात् 1,1,2,6,24,120। अर्को पद 120 हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:Complete the given series: 1, 1, 2, 6, 24, ?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'Find the wrong number in the series: 1, 2, 6, 15, 31, 56, 91');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'Find the wrong number in the series: 1, 2, 6, 15, 31, 56, 91', E'15', E'91', E'56', E'31', E'B', E'**हरेक पदबीचको अन्तर पूर्ण वर्ग (1,4,9,16,25,36) हुनुपर्छ। 56 सम्म ठीक अन्तर मिल्छ, तर अर्को अन्तर 36 भएमा पद 92 हुनुपर्ने हो — दिइएको 91 गलत हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:Find the wrong number in the series: 1, 2, 6, 15, 31, 56, 91'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'Complete the given series: 6, 11, 21, 36, 56, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'Complete the given series: 6, 11, 21, 36, 56, ?', E'42', E'71', E'81', E'91', E'C', E'**पदहरूबीचको अन्तर 5, 10, 15, 20 (५ को गुणनमा बढ्दै) हुन्छ, त्यसैले अर्को अन्तर 25 हुन्छ र अर्को पद 56+25=81 हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:Complete the given series: 6, 11, 21, 36, 56, ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'Complete the given series: 3, 4, 7, 11, 18, 29, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'Complete the given series: 3, 4, 7, 11, 18, 29, ?', E'45', E'49', E'50', E'47', E'D', E'**यो फिबोनाची-शैलीको श्रेणी हो, जहाँ हरेक पद अघिल्ला दुई पदको योग हुन्छ (11+18=29, अर्को: 18+29=47)।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:Complete the given series: 3, 4, 7, 11, 18, 29, ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'Complete the given series: 1, 1, 4, 8, 9, 27, 16, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'Complete the given series: 1, 1, 4, 8, 9, 27, 16, ?', E'64', E'32', E'81', E'256', E'A', E'**यो दुई श्रेणी मिसिएको हो: विषम स्थानमा पूर्ण वर्ग (1,4,9,16 = 1²,2²,3²,4²) र सम स्थानमा पूर्ण घन (1,8,27 = 1³,2³,3³)। अर्को (आठौं) पद 4³=64 हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:Complete the given series: 1, 1, 4, 8, 9, 27, 16, ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'Complete the given series: 9050, 5675, 3478, 2147, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'Complete the given series: 9050, 5675, 3478, 2147, ?', E'3478', E'1418', E'2428', E'3678', E'B', E'**पदहरूबीचको अन्तर विषम सङ्ख्याको घन (15³=3375, 13³=2197, 11³=1331) हो। अर्को अन्तर 9³=729 हुन्छ, त्यसैले अर्को पद 2147-729=1418 हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:Complete the given series: 9050, 5675, 3478, 2147, ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'Complete the given series: 4, 4, ?, 12, 30');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'Complete the given series: 4, 4, ?, 12, 30', E'5', E'9', E'6', E'11', E'C', E'**हरेक पद अघिल्लो पदलाई क्रमशः १, १.५, २, २.५ ले गुणन गरेर आउँछ (4×1=4, 4×1.5=6, 6×2=12, 12×2.5=30)। छुटेको पद 6 हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:Complete the given series: 4, 4, ?, 12, 30'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'Complete the given series: DFI, KMP, ?, YAD');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'Complete the given series: DFI, KMP, ?, YAD', E'QSV', E'SUX', E'RTV', E'RTW', E'D', E'**हरेक समूहका अक्षरहरू अघिल्लो समूहभन्दा ७ स्थान पछाडि सर्छन् (D→K→R→Y, F→M→T→A, I→P→W→D)। छुटेको समूह RTW हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:Complete the given series: DFI, KMP, ?, YAD'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'Complete the given series: AMV, FOX, KUZ, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'Complete the given series: AMV, FOX, KUZ, ?', E'PYB', E'NYB', E'OXA', E'MYB', E'A', E'**पहिलो अक्षर A, F, K मा ५-५ स्थान बढ्छ (अर्को P हुन्छ) र अन्तिम अक्षर V, X, Z मा २-२ स्थान बढ्छ (अर्को B हुन्छ, Z पछि वर्णमाला दोहोरिँदा)। अर्को समूह PYB हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:Complete the given series: AMV, FOX, KUZ, ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'Complete the given series: T, R, P, N, L, ?, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'Complete the given series: T, R, P, N, L, ?, ?', E'J, G', E'J, H', E'K, L', E'K, N', E'B', E'**वर्णमालाको उल्टो क्रममा हरेक अक्षर २-२ स्थान घट्दै जान्छ (T,R,P,N,L,J,H)। छुटेका अक्षरहरू J र H हुन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:Complete the given series: T, R, P, N, L, ?, ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'Complete the given series: A, D, H, M, ?, Z');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'Complete the given series: A, D, H, M, ?, Z', E'Q', E'B', E'S', E'N', E'C', E'**पदहरूबीचको अन्तर १-१ ले बढ्दै जान्छ (A→D=3, D→H=4, H→M=5, अर्को अन्तर 6 भएर M→S, त्यसपछि 7 ले S→Z जुन दिइएको अन्तिम अक्षरसँग मिल्छ)। छुटेको अक्षर S हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:Complete the given series: A, D, H, M, ?, Z'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'Complete the given series: KM, NP, QS, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'Complete the given series: KM, NP, QS, ?', E'ST', E'TU', E'SU', E'TV', E'D', E'**हरेक समूहका दुवै अक्षर ३-३ स्थान बढ्दै जान्छन् (K→N→Q→T, M→P→S→V)। छुटेको समूह TV हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:Complete the given series: KM, NP, QS, ?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'श्रेणीक्रममा आउने सङ्ख्या कुन हो? १०, १७, २६, ३७, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'श्रेणीक्रममा आउने सङ्ख्या कुन हो? १०, १७, २६, ३७, ?', E'५०', E'४६', E'५२', E'५६', E'A', E'**पदहरूबीचको अन्तर ७, ९, ११ (२-२ ले बढ्दै) हुन्छ, त्यसैले अर्को अन्तर १३ हुन्छ र अर्को पद ३७+१३=५० हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:श्रेणीक्रममा आउने सङ्ख्या कुन हो? १०, १७, २६, ३७, ?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएको श्रेणीमा छुट्टेको सङ्ख्या पत्ता लगाउनुहोस्: 1, 6, 15, ?, 45, 66, 91');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'दिइएको श्रेणीमा छुट्टेको सङ्ख्या पत्ता लगाउनुहोस्: 1, 6, 15, ?, 45, 66, 91', E'25', E'28', E'26', E'27', E'B', E'**पदहरूबीचको अन्तर 5, 9, 13, 17, 21, 25 (४-४ ले बढ्दै) हुन्छ। तेस्रो र चौथो पदबीचको अन्तर १३ हो, त्यसैले छुटेको पद 15+13=28 हुन्छ (जसले चौथो अन्तर १७ लागू गर्दा 28+17=45 मिल्छ)।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएको श्रेणीमा छुट्टेको सङ्ख्या पत्ता लगाउनुहोस्: 1, 6, 15, ?, 45, 66, 91'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'Complete the given series: 120, 99, 80, 63, 48, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'Complete the given series: 120, 99, 80, 63, 48, ?', E'38', E'39', E'35', E'40', E'C', E'**पदहरूबीचको अन्तर -21, -19, -17, -15 (२-२ ले बढ्दै/घट्दै) हुन्छ, त्यसैले अर्को अन्तर -13 हुन्छ र अर्को पद 48-13=35 हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:Complete the given series: 120, 99, 80, 63, 48, ?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: गणितीय क्षमताः छुटेका सङ्ख्याहरू पुरा गर्ने (आधारभूत तह) (7 Q)
  v_set_id := extensions.uuid_generate_v5('d912e8af-d7b4-4104-8bd0-e478e3f530a1'::uuid, E'गणितीय क्षमताः छुटेका सङ्ख्याहरू पुरा गर्ने (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'db9d9515-ced5-4a90-a4ac-3a8927342e98'::uuid, 'd912e8af-d7b4-4104-8bd0-e478e3f530a1'::uuid, E'गणितीय क्षमताः छुटेका सङ्ख्याहरू पुरा गर्ने (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'd912e8af-d7b4-4104-8bd0-e478e3f530a1'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'Find the missing number: पंक्ति १: 6 7 4, पंक्ति २: 8 4 5, पंक्ति ३: 3 6 ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'Find the missing number: पंक्ति १: 6 7 4, पंक्ति २: 8 4 5, पंक्ति ३: 3 6 ?', E'8', E'5', E'6', E'9', E'A', E'**हरेक पंक्तिका तीन सङ्ख्याहरूको योग 17 हुन्छ (6+7+4=17, 8+4+5=17)। तेस्रो पंक्तिमा 3+6+?=17 भएकाले छुटेको सङ्ख्या 8 हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:Find the missing number: पंक्ति १: 6 7 4, पंक्ति २: 8 4 5, पंक्ति ३: 3 6 ?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलको मेट्रिक्समा प्रश्नवाचक चिन्हको ठाउँमा कुन सङ्ख्या उपयुक्त हुन्छ? पंक्ति १: 2 4 16, पंक्ति २: 3 9 81, पंक्ति ३: 4 16 ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'तलको मेट्रिक्समा प्रश्नवाचक चिन्हको ठाउँमा कुन सङ्ख्या उपयुक्त हुन्छ? पंक्ति १: 2 4 16, पंक्ति २: 3 9 81, पंक्ति ३: 4 16 ?', E'125', E'256', E'169', E'196', E'B', E'**हरेक पंक्तिमा दोस्रो सङ्ख्या पहिलोको वर्ग हो र तेस्रो सङ्ख्या दोस्रोको वर्ग हो (2→4→16, 3→9→81)। तेस्रो पंक्तिमा 4→16→256 हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलको मेट्रिक्समा प्रश्नवाचक चिन्हको ठाउँमा कुन सङ्ख्या उपयुक्त हुन्छ? पंक्ति १: 2 4 16, पंक्ति २: 3 9 81, पंक्ति ३: 4 16 ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएकोमा छुट्टेको सङ्ख्या पत्ता लगाउनुहोस्: 240, ?, 120, 40, 10, 2');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'दिइएकोमा छुट्टेको सङ्ख्या पत्ता लगाउनुहोस्: 240, ?, 120, 40, 10, 2', E'180', E'420', E'240', E'480', E'C', E'**हरेक पद अघिल्लो पदलाई क्रमशः १, २, ३, ४, ५ ले भाग गरेर आउँछ (240÷1=240, 240÷2=120, 120÷3=40, 40÷4=10, 10÷5=2)। छुटेको सङ्ख्या 240 हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएकोमा छुट्टेको सङ्ख्या पत्ता लगाउनुहोस्: 240, ?, 120, 40, 10, 2'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन सङ्ख्याको ५० प्रतिशतबाट ५० घटाउँदा ५० नै बाँकी रहन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'तलका मध्ये कुन सङ्ख्याको ५० प्रतिशतबाट ५० घटाउँदा ५० नै बाँकी रहन्छ?', E'250', E'300', E'350', E'200', E'D', E'**x को ५०%-५०=५० भएमा x×0.5=100, अर्थात् x=200 हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन सङ्ख्याको ५० प्रतिशतबाट ५० घटाउँदा ५० नै बाँकी रहन्छ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तीन अङ्कले बनेको सबैभन्दा ठूलो सङ्ख्यामा दुई अङ्कले बनेको सबैभन्दा सानो सङ्ख्याको वर्ग घटाउँदा बन्ने सङ्ख्या कति हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'तीन अङ्कले बनेको सबैभन्दा ठूलो सङ्ख्यामा दुई अङ्कले बनेको सबैभन्दा सानो सङ्ख्याको वर्ग घटाउँदा बन्ने सङ्ख्या कति हुन्छ?', E'899', E'989', E'945', E'890', E'A', E'**सबैभन्दा ठूलो ३-अङ्क सङ्ख्या 999 हो; सबैभन्दा सानो २-अङ्क सङ्ख्या 10 हो, जसको वर्ग 100 हुन्छ। 999-100=899 हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तीन अङ्कले बनेको सबैभन्दा ठूलो सङ्ख्यामा दुई अङ्कले बनेको सबैभन्दा सानो सङ्ख्याको वर्ग घटाउँदा बन्ने सङ्ख्या कति हुन्छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दुई सङ्ख्याहरूको अनुपात 2:3 छ र तिनीहरूको योग 30 छ भने ती सङ्ख्याहरू कुन कुन हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'दुई सङ्ख्याहरूको अनुपात 2:3 छ र तिनीहरूको योग 30 छ भने ती सङ्ख्याहरू कुन कुन हुन्?', E'14 र 16', E'12 र 18', E'10 र 20', E'18 र 12', E'B', E'**अनुपात 2:3 का ५ भाग जम्मा 30 हुन्, त्यसैले एक भाग=6। सङ्ख्याहरू 2×6=12 र 3×6=18 हुन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दुई सङ्ख्याहरूको अनुपात 2:3 छ र तिनीहरूको योग 30 छ भने ती सङ्ख्याहरू कुन कुन हुन्?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दुईवटा सङ्ख्याहरू 7:5 को अनुपातमा छन्। यदि तिनीहरूको फरक 60 रहेको छ भने ती सङ्ख्याहरू पत्ता लगाउनुहोस्।');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'दुईवटा सङ्ख्याहरू 7:5 को अनुपातमा छन्। यदि तिनीहरूको फरक 60 रहेको छ भने ती सङ्ख्याहरू पत्ता लगाउनुहोस्।', E'210, 205', E'140, 100', E'210, 150', E'280, 220', E'C', E'**अनुपात 7:5 को फरक 2 भाग 60 हुन्, त्यसैले एक भाग=30। सङ्ख्याहरू 7×30=210 र 5×30=150 हुन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दुईवटा सङ्ख्याहरू 7:5 को अनुपातमा छन्। यदि तिनीहरूको फरक 60 रहेको छ भने ती सङ्ख्याहरू पत्ता लगाउनुहोस्।'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: गणितीय क्षमताः गणितीय पजलहरू (आधारभूत तह) (18 Q)
  v_set_id := extensions.uuid_generate_v5('8b41dcb1-7155-4d8d-9f86-9764a3ff8f79'::uuid, E'गणितीय क्षमताः गणितीय पजलहरू (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'db9d9515-ced5-4a90-a4ac-3a8927342e98'::uuid, '8b41dcb1-7155-4d8d-9f86-9764a3ff8f79'::uuid, E'गणितीय क्षमताः गणितीय पजलहरू (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '8b41dcb1-7155-4d8d-9f86-9764a3ff8f79'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'3, 4, 5 फलफूलले एक-एक प्याक बनाउँदा एकवटा फलफूल बाँकी रहन्छ, तर 11 ओटाको दरले प्याक बनाउँदा बाँकी रहँदैन भने न्यूनतम कति फलफूल छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'3, 4, 5 फलफूलले एक-एक प्याक बनाउँदा एकवटा फलफूल बाँकी रहन्छ, तर 11 ओटाको दरले प्याक बनाउँदा बाँकी रहँदैन भने न्यूनतम कति फलफूल छन्?', E'121', E'242', E'73', E'79', E'A', E'**3, 4, 5 को ल.स.गु. 60 हो, त्यसैले सङ्ख्या 60k+1 रूपको हुनुपर्छ र 11 ले पनि विभाज्य हुनुपर्छ। यसको सबैभन्दा सानो मान 121 हो (60×2+1=121, जुन 11×11 पनि हो)।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:3, 4, 5 फलफूलले एक-एक प्याक बनाउँदा एकवटा फलफूल बाँकी रहन्छ, तर 11 ओटाको दरले प्याक बनाउँदा बाँकी रहँदैन भने न्यूनतम कति फलफूल छन्?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'750 ग्राम पानीमा 250 ग्राम चिनी राखेर घोल बनाइएको छ। उक्त घोलमा भएको चिनी र पानीको अनुपात कति हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'750 ग्राम पानीमा 250 ग्राम चिनी राखेर घोल बनाइएको छ। उक्त घोलमा भएको चिनी र पानीको अनुपात कति हुन्छ?', E'5:7', E'1:3', E'7:5', E'2:7', E'B', E'**चिनी : पानी = 250 : 750 = 1 : 3 हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:750 ग्राम पानीमा 250 ग्राम चिनी राखेर घोल बनाइएको छ। उक्त घोलमा भएको चिनी र पानीको अनुपात कति हुन्छ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'जम्मा ४८० विद्यार्थी भएको विद्यालयमा केटा र केटीको अनुपात ८:७ छ भने विद्यालयमा कति केटीहरू पढ्छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'जम्मा ४८० विद्यार्थी भएको विद्यालयमा केटा र केटीको अनुपात ८:७ छ भने विद्यालयमा कति केटीहरू पढ्छन्?', E'१९२', E'२२१', E'२२४', E'२२०', E'C', E'**अनुपातका १५ भाग जम्मा ४८० हुन्, त्यसैले एक भाग=३२। केटीको सङ्ख्या=७×३२=२२४ हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:जम्मा ४८० विद्यार्थी भएको विद्यालयमा केटा र केटीको अनुपात ८:७ छ भने विद्यालयमा कति केटीहरू पढ्छन्?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'किशोरले आफ्नो आयको २० प्रतिशत आफ्ना बच्चाको शिक्षामा खर्च गर्छ। उसले खर्च रु २८०० गरेको भए उसको आय कति होला?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'किशोरले आफ्नो आयको २० प्रतिशत आफ्ना बच्चाको शिक्षामा खर्च गर्छ। उसले खर्च रु २८०० गरेको भए उसको आय कति होला?', E'१०,०००', E'१२,०००', E'१६,०००', E'१४,०००', E'D', E'**आय = खर्च ÷ प्रतिशत = २८०० ÷ ०.२० = १४,००० हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:किशोरले आफ्नो आयको २० प्रतिशत आफ्ना बच्चाको शिक्षामा खर्च गर्छ। उसले खर्च रु २८०० गरेको भए उसको आय कति होला?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'१०० लिटर दूध-पानीको मिश्रणमा दूध र पानीको अनुपात ४:१ छ। पसलेले मिश्रणको एक चौथाइ बेचेर बेचेको बराबर परिमाण पानी थपेर परिपूर्ति गर्दा पानी र दूधको नयाँ अनुपात कति हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'१०० लिटर दूध-पानीको मिश्रणमा दूध र पानीको अनुपात ४:१ छ। पसलेले मिश्रणको एक चौथाइ बेचेर बेचेको बराबर परिमाण पानी थपेर परिपूर्ति गर्दा पानी र दूधको नयाँ अनुपात कति हुन्छ?', E'2 : 3', E'1 : 2', E'1 : 3', E'3 : 4', E'A', E'**सुरुमा दूध=८०ली, पानी=२०ली। १/४ (२५ली) बेच्दा दूध २०ली र पानी ५ली घट्छ (दूध=६०ली, पानी=१५ली)। २५ली पानी थप्दा पानी=४०ली हुन्छ। नयाँ अनुपात पानी:दूध = ४०:६० = 2:3 हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:१०० लिटर दूध-पानीको मिश्रणमा दूध र पानीको अनुपात ४:१ छ। पसलेले मिश्रणको एक चौथाइ बेचेर बेचेको बराबर परिमाण पानी थपेर परिपूर्ति गर्दा पानी र दूधको नयाँ अनुपात कति हुन्छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'रु १ मा १५ वटा कागती किनेर २५ प्रतिशत नाफा गरी बेच्दा रु १ मा कतिवटा बेच्नुपर्ला?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'रु १ मा १५ वटा कागती किनेर २५ प्रतिशत नाफा गरी बेच्दा रु १ मा कतिवटा बेच्नुपर्ला?', E'14 वटा', E'12 वटा', E'13 वटा', E'17 वटा', E'B', E'**१ वटाको लागत=१/१५। २५% नाफासहित बिक्री मूल्य=(१/१५)×१.२५=१/१२। त्यसैले रु १ मा १२ वटा बेच्न सकिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:रु १ मा १५ वटा कागती किनेर २५ प्रतिशत नाफा गरी बेच्दा रु १ मा कतिवटा बेच्नुपर्ला?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'प्रतिगोटा रु १० पर्ने कलम १० प्रतिशत छुट दिएर दुई दर्जन बेच्दा जम्मा बिक्री मूल्य कति हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'प्रतिगोटा रु १० पर्ने कलम १० प्रतिशत छुट दिएर दुई दर्जन बेच्दा जम्मा बिक्री मूल्य कति हुन्छ?', E'200', E'240', E'216', E'252', E'C', E'**१ कलमको बिक्री मूल्य=१०×०.९=रु ९। २ दर्जन (२४ वटा) को बिक्री मूल्य=२४×९=रु २१६ हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:प्रतिगोटा रु १० पर्ने कलम १० प्रतिशत छुट दिएर दुई दर्जन बेच्दा जम्मा बिक्री मूल्य कति हुन्छ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै विद्यालयमा रहेका शिक्षकहरूमध्ये ७०% पुरुष छन् र बाँकी महिला हुन्। महिला शिक्षकको जम्मा सङ्ख्या ४५ रहेछ भने सो विद्यालयमा कति पुरुष शिक्षक होलान्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'कुनै विद्यालयमा रहेका शिक्षकहरूमध्ये ७०% पुरुष छन् र बाँकी महिला हुन्। महिला शिक्षकको जम्मा सङ्ख्या ४५ रहेछ भने सो विद्यालयमा कति पुरुष शिक्षक होलान्?', E'११५ जना', E'१२५ जना', E'१३० जना', E'१०५ जना', E'D', E'**महिला(३०%)=४५ भएमा जम्मा शिक्षक=४५÷०.३=१५०। पुरुष(७०%)=१५०×०.७=१०५ जना हुन्छन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै विद्यालयमा रहेका शिक्षकहरूमध्ये ७०% पुरुष छन् र बाँकी महिला हुन्। महिला शिक्षकको जम्मा सङ्ख्या ४५ रहेछ भने सो विद्यालयमा कति पुरुष शिक्षक होलान्?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'गाई र कुखुराको एक समूहमा खुट्टाको सङ्ख्या टाउकोको सङ्ख्याको दोब्बरभन्दा १४ ले बढी छ भने कतिवटा गाई रहेछन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'गाई र कुखुराको एक समूहमा खुट्टाको सङ्ख्या टाउकोको सङ्ख्याको दोब्बरभन्दा १४ ले बढी छ भने कतिवटा गाई रहेछन्?', E'7', E'5', E'9', E'11', E'A', E'**गाईका ४ र कुखुराका २ खुट्टा हुन्छन्; गाई प्रत्येकले टाउको-हिसाबभन्दा २ थप खुट्टा योगदान गर्छ। थप खुट्टा जम्मा १४ भएकाले गाईको सङ्ख्या = १४÷२ = ७ हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:गाई र कुखुराको एक समूहमा खुट्टाको सङ्ख्या टाउकोको सङ्ख्याको दोब्बरभन्दा १४ ले बढी छ भने कतिवटा गाई रहेछन्?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'55 लिटर मिश्रणमा दूध र पानीको अनुपात 7:4 छ। सो अनुपात 7:6 बनाउन कति पानी मिलाउनुपर्ला?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'55 लिटर मिश्रणमा दूध र पानीको अनुपात 7:4 छ। सो अनुपात 7:6 बनाउन कति पानी मिलाउनुपर्ला?', E'15 लिटर', E'10 लिटर', E'5 लिटर', E'12 लिटर', E'B', E'**दूध=35ली (स्थिर रहन्छ), पानी=20ली। 7:6 को अनुपातमा (7 भाग=35ली भएकाले 1भाग=5ली) पानी 6×5=30ली हुनुपर्छ। थप्नुपर्ने पानी=30-20=10ली हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:55 लिटर मिश्रणमा दूध र पानीको अनुपात 7:4 छ। सो अनुपात 7:6 बनाउन कति पानी मिलाउनुपर्ला?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै सामान क्रयमूल्य रु २५०० मा किनेर क्रयमूल्यको ३/५ मा बेच्दा कति प्रतिशत नोक्सान हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'कुनै सामान क्रयमूल्य रु २५०० मा किनेर क्रयमूल्यको ३/५ मा बेच्दा कति प्रतिशत नोक्सान हुन्छ?', E'२५', E'३०', E'४०', E'४५', E'C', E'**बिक्री मूल्य=२५००×३/५=१५००। नोक्सान=२५००-१५००=१०००। नोक्सान%=१०००/२५००×१००=४० प्रतिशत हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै सामान क्रयमूल्य रु २५०० मा किनेर क्रयमूल्यको ३/५ मा बेच्दा कति प्रतिशत नोक्सान हुन्छ?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'एउटा रेडियोको मूल्य रु २५०० र एउटा क्यामेराको मूल्य रु १५०० भए रेडियो र क्यामेराको मूल्यको अनुपात कति हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'एउटा रेडियोको मूल्य रु २५०० र एउटा क्यामेराको मूल्य रु १५०० भए रेडियो र क्यामेराको मूल्यको अनुपात कति हुन्छ?', E'३:२', E'४:३', E'७:५', E'५:३', E'D', E'**रेडियो:क्यामेरा = २५००:१५०० = ५:३ हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:एउटा रेडियोको मूल्य रु २५०० र एउटा क्यामेराको मूल्य रु १५०० भए रेडियो र क्यामेराको मूल्यको अनुपात कति हुन्छ?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तीनवटा मोटरसाइकलको गति १:२:३ को अनुपातमा छ भने बराबर दूरी पार गर्न तिनीहरूलाई लाग्ने समयको अनुपात कति हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'तीनवटा मोटरसाइकलको गति १:२:३ को अनुपातमा छ भने बराबर दूरी पार गर्न तिनीहरूलाई लाग्ने समयको अनुपात कति हुन्छ?', E'6:3:2', E'3:2:1', E'1:2:3', E'2:3:6', E'A', E'**बराबर दूरीका लागि लाग्ने समय गतिको उल्टो अनुपातमा हुन्छ। गति १:२:३ को उल्टो १/१:१/२:१/३ लाई ६ ले गुणन गर्दा ६:३:२ हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तीनवटा मोटरसाइकलको गति १:२:३ को अनुपातमा छ भने बराबर दूरी पार गर्न तिनीहरूलाई लाग्ने समयको अनुपात कति हुन्छ?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'हरिले एउटा सामान रु ३५५० मा बेच्दा रु ४६० नोक्सान भएछ भने नोक्सान प्रतिशत पत्ता लगाउनुहोस्।');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'हरिले एउटा सामान रु ३५५० मा बेच्दा रु ४६० नोक्सान भएछ भने नोक्सान प्रतिशत पत्ता लगाउनुहोस्।', E'१३.५%', E'११.५%', E'१२%', E'११%', E'B', E'**क्रयमूल्य=३५५०+४६०=४०१०। नोक्सान%=४६०/४०१०×१००≈११.५% हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:हरिले एउटा सामान रु ३५५० मा बेच्दा रु ४६० नोक्सान भएछ भने नोक्सान प्रतिशत पत्ता लगाउनुहोस्।'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'एउटा विक्रेताले रेडियो रु २२५ मा खरिद गरी रु १५ मर्मत गर्न खर्च गर्छ। यदि उसले सो रेडियो रु ३०० मा बिक्री गर्छ भने उसको नाफा प्रतिशत कति होला?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'एउटा विक्रेताले रेडियो रु २२५ मा खरिद गरी रु १५ मर्मत गर्न खर्च गर्छ। यदि उसले सो रेडियो रु ३०० मा बिक्री गर्छ भने उसको नाफा प्रतिशत कति होला?', E'२०%', E'२३%', E'२५%', E'३०%', E'C', E'**जम्मा लागत=२२५+१५=२४०। नाफा=३००-२४०=६०। नाफा%=६०/२४०×१००=२५% हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:एउटा विक्रेताले रेडियो रु २२५ मा खरिद गरी रु १५ मर्मत गर्न खर्च गर्छ। यदि उसले सो रेडियो रु ३०० मा बिक्री गर्छ भने उसको नाफा प्रतिशत कति होला?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'रामले एउटा वस्तु रु ५०० मा किनेर ५ प्रतिशत घाटामा बेचेको रहेछ। त्यही पैसाबाट अर्को वस्तु किनी १० प्रतिशत नाफामा बेच्यो भने उसको समग्र लाभ कति हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'रामले एउटा वस्तु रु ५०० मा किनेर ५ प्रतिशत घाटामा बेचेको रहेछ। त्यही पैसाबाट अर्को वस्तु किनी १० प्रतिशत नाफामा बेच्यो भने उसको समग्र लाभ कति हुन्छ?', E'रु २० नाफा', E'रु २१ घाटा', E'रु २२.५ घाटा', E'रु २२.५ नाफा', E'D', E'**पहिलो बिक्री=५००×०.९५=४७५। दोस्रो बिक्री=४७५×१.१०=५२२.५। सुरुको ५०० बाट अन्त्यमा ५२२.५ भएकाले समग्र लाभ=रु २२.५ नाफा हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:रामले एउटा वस्तु रु ५०० मा किनेर ५ प्रतिशत घाटामा बेचेको रहेछ। त्यही पैसाबाट अर्को वस्तु किनी १० प्रतिशत नाफामा बेच्यो भने उसको समग्र लाभ कति हुन्छ?'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'15 वटा सुन्तलाको क्रयमूल्य 12 वटा सुन्तलाको विक्रय मूल्यसँग बराबर भए नाफा प्रतिशत कति होला?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'15 वटा सुन्तलाको क्रयमूल्य 12 वटा सुन्तलाको विक्रय मूल्यसँग बराबर भए नाफा प्रतिशत कति होला?', E'25%', E'20%', E'22.22%', E'16.67%', E'A', E'**१ सुन्तलाको क्रयमूल्य=१ मान्दा, १५ को क्रयमूल्य=१५=१२ को विक्रय मूल्य, त्यसैले १ को विक्रय मूल्य=१५/१२=१.२५। नाफा%=(१.२५-१)/१×१००=२५% हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:15 वटा सुन्तलाको क्रयमूल्य 12 वटा सुन्तलाको विक्रय मूल्यसँग बराबर भए नाफा प्रतिशत कति होला?'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'एउटा विद्यालयको परीक्षामा ३३.५% विद्यार्थी उत्तीर्ण भएछन्। यदि अनुत्तीर्ण हुनेहरूको सङ्ख्या १२० जना भए जम्मा कति जनाले परीक्षा दिएका होलान्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'एउटा विद्यालयको परीक्षामा ३३.५% विद्यार्थी उत्तीर्ण भएछन्। यदि अनुत्तीर्ण हुनेहरूको सङ्ख्या १२० जना भए जम्मा कति जनाले परीक्षा दिएका होलान्?', E'140', E'180', E'160', E'240', E'B', E'**अनुत्तीर्ण(६६.५%)=१२० भएमा जम्मा=१२०÷०.६६५≈१८० हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:एउटा विद्यालयको परीक्षामा ३३.५% विद्यार्थी उत्तीर्ण भएछन्। यदि अनुत्तीर्ण हुनेहरूको सङ्ख्या १२० जना भए जम्मा कति जनाले परीक्षा दिएका होलान्?'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  RAISE NOTICE 'ङ-२ गणितीय क्षमता upsert complete: 3 sets, 40 questions.';
END $$;
