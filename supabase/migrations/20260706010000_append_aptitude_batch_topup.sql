-- Append tsc_aptitude_bank batch: top-up existing sets to the 30Q cap.
-- Generated 2026-07-05T13:20:24.233Z.
DO $$
DECLARE
  v_set_id uuid;
  v_q_id uuid;
BEGIN

  -- Top-up: शाब्दिक बौद्धिक परीक्षणः समरूपता/Analogies (आधारभूत तह) (+19 Q, 11->30)
  v_set_id := extensions.uuid_generate_v5('91240d83-acef-40dd-9fa2-412f8b797e45'::uuid, E'शाब्दिक बौद्धिक परीक्षणः समरूपता/Analogies (आधारभूत तह)');

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपाल : काठमाडौं :: भारत : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'नेपाल : काठमाडौं :: भारत : ?', E'नयाँ दिल्ली', E'बेइजिङ', E'ढाका', E'कोलम्बो', E'A', E'जसरी नेपालको राजधानी काठमाडौं हो, त्यसैगरी भारतको राजधानी नयाँ दिल्ली हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपाल : काठमाडौं :: भारत : ?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'चीन : बेइजिङ :: जापान : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'चीन : बेइजिङ :: जापान : ?', E'सियोल', E'टोकियो', E'बैंकक', E'मस्को', E'B', E'जसरी चीनको राजधानी बेइजिङ हो, त्यसैगरी जापानको राजधानी टोकियो हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:चीन : बेइजिङ :: जापान : ?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'भुटान : थिम्पु :: माल्दिभ्स : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'भुटान : थिम्पु :: माल्दिभ्स : ?', E'काबुल', E'तेहरान', E'माले', E'ढाका', E'C', E'जसरी भुटानको राजधानी थिम्पु हो, त्यसैगरी माल्दिभ्सको राजधानी माले हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:भुटान : थिम्पु :: माल्दिभ्स : ?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'फ्रान्स : पेरिस :: बेलायत : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'फ्रान्स : पेरिस :: बेलायत : ?', E'मड्रिड', E'रोम', E'बर्लिन', E'लण्डन', E'D', E'जसरी फ्रान्सको राजधानी पेरिस हो, त्यसैगरी बेलायतको राजधानी लण्डन हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:फ्रान्स : पेरिस :: बेलायत : ?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'रुस : मस्को :: अमेरिका : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'रुस : मस्को :: अमेरिका : ?', E'वासिङ्टन डी.सी.', E'न्युयोर्क', E'लस एन्जलस', E'सिकागो', E'A', E'जसरी रुसको राजधानी मस्को हो, त्यसैगरी अमेरिकाको राजधानी वासिङ्टन डी.सी. हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:रुस : मस्को :: अमेरिका : ?'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'अष्ट्रेलिया : क्यानबेरा :: क्यानडा : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'अष्ट्रेलिया : क्यानबेरा :: क्यानडा : ?', E'सिड्नी', E'ओटावा', E'टोरन्टो', E'भ्यानकुभर', E'B', E'जसरी अष्ट्रेलियाको राजधानी क्यानबेरा हो, त्यसैगरी क्यानडाको राजधानी ओटावा हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:अष्ट्रेलिया : क्यानबेरा :: क्यानडा : ?'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'श्रीलंका : कोलम्बो :: पाकिस्तान : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'श्रीलंका : कोलम्बो :: पाकिस्तान : ?', E'कराँची', E'लाहोर', E'इस्लामावाद', E'ढाका', E'C', E'जसरी श्रीलंकाको राजधानी कोलम्बो हो, त्यसैगरी पाकिस्तानको राजधानी इस्लामावाद हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:श्रीलंका : कोलम्बो :: पाकिस्तान : ?'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'इटाली : रोम :: जर्मनी : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'इटाली : रोम :: जर्मनी : ?', E'म्युनिख', E'पेरिस', E'भियना', E'बर्लिन', E'D', E'जसरी इटालीको राजधानी रोम हो, त्यसैगरी जर्मनीको राजधानी बर्लिन हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:इटाली : रोम :: जर्मनी : ?'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दक्षिण कोरिया : सियोल :: थाइल्याण्ड : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 20, E'दक्षिण कोरिया : सियोल :: थाइल्याण्ड : ?', E'बैंकक', E'मनिला', E'जकार्ता', E'ताइपेई', E'A', E'जसरी दक्षिण कोरियाको राजधानी सियोल हो, त्यसैगरी थाइल्याण्डको राजधानी बैंकक हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दक्षिण कोरिया : सियोल :: थाइल्याण्ड : ?'), v_set_id, v_q_id, 20)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'इजिप्ट : कायरो :: ब्राजिल : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 21, E'इजिप्ट : कायरो :: ब्राजिल : ?', E'रियो दि जेनेरियो', E'ब्रासिलिया', E'साओ पाउलो', E'लिमा', E'B', E'जसरी इजिप्टको राजधानी कायरो हो, त्यसैगरी ब्राजिलको राजधानी ब्रासिलिया हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:इजिप्ट : कायरो :: ब्राजिल : ?'), v_set_id, v_q_id, 21)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपाल : रुपैयाँ :: अमेरिका : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 22, E'नेपाल : रुपैयाँ :: अमेरिका : ?', E'पाउन्ड', E'युरो', E'डलर', E'येन', E'C', E'जसरी नेपालको मुद्रा रुपैयाँ हो, त्यसैगरी अमेरिकाको मुद्रा डलर हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपाल : रुपैयाँ :: अमेरिका : ?'), v_set_id, v_q_id, 22)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'भारत : रुपैयाँ :: जापान : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 23, E'भारत : रुपैयाँ :: जापान : ?', E'युआन', E'वन', E'रियाल', E'येन', E'D', E'जसरी भारतको मुद्रा रुपैयाँ हो, त्यसैगरी जापानको मुद्रा येन हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:भारत : रुपैयाँ :: जापान : ?'), v_set_id, v_q_id, 23)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'बेलायत : पाउन्ड :: युरोपियन युनियन : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 24, E'बेलायत : पाउन्ड :: युरोपियन युनियन : ?', E'युरो', E'फ्र्याङ्क', E'रुबल', E'क्रोन', E'A', E'जसरी बेलायतको मुद्रा पाउन्ड हो, त्यसैगरी युरोपियन युनियनको मुद्रा युरो हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:बेलायत : पाउन्ड :: युरोपियन युनियन : ?'), v_set_id, v_q_id, 24)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'रुस : रुबल :: चीन : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 25, E'रुस : रुबल :: चीन : ?', E'येन', E'युआन', E'वन', E'टाका', E'B', E'जसरी रुसको मुद्रा रुबल हो, त्यसैगरी चीनको मुद्रा युआन हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:रुस : रुबल :: चीन : ?'), v_set_id, v_q_id, 25)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दक्षिण कोरिया : वन :: साउदी अरब : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 26, E'दक्षिण कोरिया : वन :: साउदी अरब : ?', E'दिनार', E'दिराम', E'रियाल', E'भाट', E'C', E'जसरी दक्षिण कोरियाको मुद्रा वन हो, त्यसैगरी साउदी अरबको मुद्रा रियाल हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दक्षिण कोरिया : वन :: साउदी अरब : ?'), v_set_id, v_q_id, 26)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'बंगलादेश : टाका :: मलेसिया : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 27, E'बंगलादेश : टाका :: मलेसिया : ?', E'क्यात', E'पेसो', E'डलर', E'रिंगिट', E'D', E'जसरी बंगलादेशको मुद्रा टाका हो, त्यसैगरी मलेसियाको मुद्रा रिंगिट हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:बंगलादेश : टाका :: मलेसिया : ?'), v_set_id, v_q_id, 27)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'अष्ट्रेलिया : डलर :: कुवेत : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 28, E'अष्ट्रेलिया : डलर :: कुवेत : ?', E'दिनार', E'रियाल', E'दिराम', E'पाउन्ड', E'A', E'जसरी अष्ट्रेलियाको मुद्रा डलर हो, त्यसैगरी कुवेतको मुद्रा दिनार हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:अष्ट्रेलिया : डलर :: कुवेत : ?'), v_set_id, v_q_id, 28)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'थाइल्याण्ड : भाट :: युएई : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 29, E'थाइल्याण्ड : भाट :: युएई : ?', E'रियाल', E'दिराम', E'दिनार', E'रुबल', E'B', E'जसरी थाइल्याण्डको मुद्रा भाट हो, त्यसैगरी युएई (UAE) को मुद्रा दिराम हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:थाइल्याण्ड : भाट :: युएई : ?'), v_set_id, v_q_id, 29)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'इरान : रियाल :: इराक : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 30, E'इरान : रियाल :: इराक : ?', E'दिराम', E'पाउन्ड', E'दिनार', E'येन', E'C', E'जसरी इरानको मुद्रा रियाल हो, त्यसैगरी इराकको मुद्रा दिनार हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:इरान : रियाल :: इराक : ?'), v_set_id, v_q_id, 30)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Top-up: शाब्दिक बौद्धिक परीक्षणः विपरीतार्थक र समानार्थी शब्द (आधारभूत तह) (+11 Q, 19->30)
  v_set_id := extensions.uuid_generate_v5('075f71e5-93ca-40d5-8bbb-f671e74eab47'::uuid, E'शाब्दिक बौद्धिक परीक्षणः विपरीतार्थक र समानार्थी शब्द (आधारभूत तह)');

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''आकाश'' शब्दको समानार्थी शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 20, E'तलका मध्ये ''आकाश'' शब्दको समानार्थी शब्द कुन हो?', E'गगन', E'धर्ती', E'पाताल', E'सागर', E'A', E'''आकाश'' र ''गगन'' ले एउटै अर्थ बुझाउने हुनाले यिनीहरू समानार्थी हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''आकाश'' शब्दको समानार्थी शब्द कुन हो?'), v_set_id, v_q_id, 20)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''पृथ्वी'' शब्दको समानार्थी शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 21, E'तलका मध्ये ''पृथ्वी'' शब्दको समानार्थी शब्द कुन हो?', E'गगन', E'धर्ती', E'चन्द्रमा', E'सूर्य', E'B', E'''पृथ्वी'' र ''धर्ती'' को अर्थ समान हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''पृथ्वी'' शब्दको समानार्थी शब्द कुन हो?'), v_set_id, v_q_id, 21)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''जल'' शब्दको समानार्थी शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 22, E'तलका मध्ये ''जल'' शब्दको समानार्थी शब्द कुन हो?', E'आगो', E'हावा', E'पानी', E'माटो', E'C', E'''जल'' भनेको ''पानी'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''जल'' शब्दको समानार्थी शब्द कुन हो?'), v_set_id, v_q_id, 22)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''हावा'' शब्दको समानार्थी शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 23, E'तलका मध्ये ''हावा'' शब्दको समानार्थी शब्द कुन हो?', E'अग्नि', E'जल', E'आकाश', E'पवन', E'D', E'''हावा'' र ''पवन'' दुवैले वायुलाई जनाउँछन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''हावा'' शब्दको समानार्थी शब्द कुन हो?'), v_set_id, v_q_id, 23)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''सूर्य'' शब्दको समानार्थी शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 24, E'तलका मध्ये ''सूर्य'' शब्दको समानार्थी शब्द कुन हो?', E'रवि', E'चन्द्रमा', E'तारा', E'बादल', E'A', E'''सूर्य'' लाई ''रवि'' पनि भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''सूर्य'' शब्दको समानार्थी शब्द कुन हो?'), v_set_id, v_q_id, 24)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''चन्द्रमा'' शब्दको समानार्थी शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 25, E'तलका मध्ये ''चन्द्रमा'' शब्दको समानार्थी शब्द कुन हो?', E'सूर्य', E'शशि', E'तारा', E'आकाश', E'B', E'''चन्द्रमा'' र ''शशि'' को अर्थ एउटै हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''चन्द्रमा'' शब्दको समानार्थी शब्द कुन हो?'), v_set_id, v_q_id, 25)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''फूल'' शब्दको समानार्थी शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 26, E'तलका मध्ये ''फूल'' शब्दको समानार्थी शब्द कुन हो?', E'पात', E'हाँगा', E'पुष्प', E'काँडा', E'C', E'''फूल'' लाई नेपालीमा ''पुष्प'' पनि भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''फूल'' शब्दको समानार्थी शब्द कुन हो?'), v_set_id, v_q_id, 26)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''आगो'' शब्दको समानार्थी शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 27, E'तलका मध्ये ''आगो'' शब्दको समानार्थी शब्द कुन हो?', E'पानी', E'हावा', E'माटो', E'अग्नि', E'D', E'''आगो'' र ''अग्नि'' समान अर्थ राख्ने शब्द हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''आगो'' शब्दको समानार्थी शब्द कुन हो?'), v_set_id, v_q_id, 27)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''रात'' शब्दको समानार्थी शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 28, E'तलका मध्ये ''रात'' शब्दको समानार्थी शब्द कुन हो?', E'रात्रि', E'दिन', E'उज्यालो', E'बिहान', E'A', E'''रात'' लाई ''रात्रि'' पनि भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''रात'' शब्दको समानार्थी शब्द कुन हो?'), v_set_id, v_q_id, 28)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''दिन'' शब्दको समानार्थी शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 29, E'तलका मध्ये ''दिन'' शब्दको समानार्थी शब्द कुन हो?', E'रात', E'दिवस', E'साँझ', E'बिहान', E'B', E'''दिन'' को समानार्थी शब्द ''दिवस'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''दिन'' शब्दको समानार्थी शब्द कुन हो?'), v_set_id, v_q_id, 29)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''पहाड'' शब्दको समानार्थी शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 30, E'तलका मध्ये ''पहाड'' शब्दको समानार्थी शब्द कुन हो?', E'समुद्र', E'नदी', E'पर्वत', E'मैदान', E'C', E'''पहाड'' र ''पर्वत'' एउटै अर्थ हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''पहाड'' शब्दको समानार्थी शब्द कुन हो?'), v_set_id, v_q_id, 30)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Top-up: गणितीय क्षमताः श्रेणीक्रम समस्याहरू (आधारभूत तह) (+15 Q, 15->30)
  v_set_id := extensions.uuid_generate_v5('1e60e4c1-6741-4d59-9131-fbcd078b4e43'::uuid, E'गणितीय क्षमताः श्रेणीक्रम समस्याहरू (आधारभूत तह)');

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'2, 4, 6, 8, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'2, 4, 6, 8, ?', E'10', E'12', E'14', E'16', E'A', E'प्रत्येक पदमा 2 जोडिएको छ (8 + 2 = 10)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:2, 4, 6, 8, ?'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'5, 10, 15, 20, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'5, 10, 15, 20, ?', E'22', E'25', E'30', E'35', E'B', E'प्रत्येक पदमा 5 जोडिएको छ (20 + 5 = 25)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:5, 10, 15, 20, ?'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'7, 10, 13, 16, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'7, 10, 13, 16, ?', E'17', E'18', E'19', E'20', E'C', E'प्रत्येक पदमा 3 जोडिएको छ (16 + 3 = 19)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:7, 10, 13, 16, ?'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'12, 19, 26, 33, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'12, 19, 26, 33, ?', E'38', E'39', E'41', E'40', E'D', E'प्रत्येक पदमा 7 जोडिएको छ (33 + 7 = 40)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:12, 19, 26, 33, ?'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1, 3, 6, 10, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 20, E'1, 3, 6, 10, ?', E'15', E'12', E'14', E'16', E'A', E'क्रमशः +2, +3, +4, र +5 जोडिएको छ (10 + 5 = 15)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1, 3, 6, 10, ?'), v_set_id, v_q_id, 20)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'5, 6, 8, 11, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 21, E'5, 6, 8, 11, ?', E'13', E'15', E'14', E'16', E'B', E'क्रमशः +1, +2, +3, र +4 जोडिएको छ (11 + 4 = 15)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:5, 6, 8, 11, ?'), v_set_id, v_q_id, 21)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'10, 12, 16, 22, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 22, E'10, 12, 16, 22, ?', E'26', E'28', E'30', E'32', E'C', E'क्रमशः +2, +4, +6, र +8 जोडिएको छ (22 + 8 = 30)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:10, 12, 16, 22, ?'), v_set_id, v_q_id, 22)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'3, 7, 15, 27, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 23, E'3, 7, 15, 27, ?', E'39', E'41', E'45', E'43', E'D', E'क्रमशः +4, +8, +12, र +16 जोडिएको छ (27 + 16 = 43)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:3, 7, 15, 27, ?'), v_set_id, v_q_id, 23)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'20, 25, 35, 50, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 24, E'20, 25, 35, 50, ?', E'70', E'60', E'65', E'75', E'A', E'क्रमशः +5, +10, +15, र +20 जोडिएको छ (50 + 20 = 70)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:20, 25, 35, 50, ?'), v_set_id, v_q_id, 24)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'2, 5, 10, 17, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 25, E'2, 5, 10, 17, ?', E'24', E'26', E'25', E'27', E'B', E'क्रमशः +3, +5, +7, र +9 जोडिएको छ (17 + 9 = 26)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:2, 5, 10, 17, ?'), v_set_id, v_q_id, 25)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'50, 45, 40, 35, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 26, E'50, 45, 40, 35, ?', E'25', E'32', E'30', E'34', E'C', E'प्रत्येक पदमा 5 घटाइएको छ (35 - 5 = 30)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:50, 45, 40, 35, ?'), v_set_id, v_q_id, 26)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'100, 90, 80, 70, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 27, E'100, 90, 80, 70, ?', E'50', E'55', E'65', E'60', E'D', E'प्रत्येक पदमा 10 घटाइएको छ (70 - 10 = 60)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:100, 90, 80, 70, ?'), v_set_id, v_q_id, 27)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'88, 77, 66, 55, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 28, E'88, 77, 66, 55, ?', E'44', E'33', E'45', E'50', E'A', E'प्रत्येक पदमा 11 घटाइएको छ (55 - 11 = 44)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:88, 77, 66, 55, ?'), v_set_id, v_q_id, 28)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'42, 39, 36, 33, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 29, E'42, 39, 36, 33, ?', E'27', E'30', E'29', E'31', E'B', E'प्रत्येक पदमा 3 घटाइएको छ (33 - 3 = 30)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:42, 39, 36, 33, ?'), v_set_id, v_q_id, 29)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'20, 19, 17, 14, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 30, E'20, 19, 17, 14, ?', E'9', E'11', E'10', E'12', E'C', E'क्रमशः -1, -2, -3, र -4 घटाइएको छ (14 - 4 = 10)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:20, 19, 17, 14, ?'), v_set_id, v_q_id, 30)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Top-up: गणितीय क्षमताः गणितीय पजलहरू (आधारभूत तह) (+12 Q, 18->30)
  v_set_id := extensions.uuid_generate_v5('8b41dcb1-7155-4d8d-9f86-9764a3ff8f79'::uuid, E'गणितीय क्षमताः गणितीय पजलहरू (आधारभूत तह)');

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'एउटा खोरमा केही गाई र केही कुखुराहरू छन्। यदि तिनीहरूको जम्मा टाउकोको संख्या 20 र खुट्टाको संख्या 56 छ भने, त्यहाँ कतिवटा कुखुरा होलान्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'एउटा खोरमा केही गाई र केही कुखुराहरू छन्। यदि तिनीहरूको जम्मा टाउकोको संख्या 20 र खुट्टाको संख्या 56 छ भने, त्यहाँ कतिवटा कुखुरा होलान्?', E'12', E'8', E'14', E'10', E'A', E'मानौं गाईको संख्या x र कुखुराको संख्या y छ। x + y = 20 र 4x + 2y = 56। समीकरण हल गर्दा गाई (x) = 8 र कुखुरा (y) = 12 आउँछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:एउटा खोरमा केही गाई र केही कुखुराहरू छन्। यदि तिनीहरूको जम्मा टाउकोको संख्या 20 र खुट्टाको संख्या 56 छ भने, त्यहाँ कतिवटा कुखुरा होलान्?'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'एउटा पार्टीमा 10 जना मानिसहरू छन्। यदि हरेकले हरेकसँग एक-पटक मात्र हात मिलाए भने, जम्मा कति पटक हात मिलाइन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 20, E'एउटा पार्टीमा 10 जना मानिसहरू छन्। यदि हरेकले हरेकसँग एक-पटक मात्र हात मिलाए भने, जम्मा कति पटक हात मिलाइन्छ?', E'100', E'45', E'55', E'90', E'B', E'हात मिलाउने जम्मा संख्या = n(n-1)/2 = 10(9)/2 = 45 पटक।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:एउटा पार्टीमा 10 जना मानिसहरू छन्। यदि हरेकले हरेकसँग एक-पटक मात्र हात मिलाए भने, जम्मा कति पटक हात मिलाइन्छ?'), v_set_id, v_q_id, 20)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दुईवटा संख्याको योगफल 50 र तिनीहरूको फरक 14 छ भने, ती मध्ये ठूलो संख्या कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 21, E'दुईवटा संख्याको योगफल 50 र तिनीहरूको फरक 14 छ भने, ती मध्ये ठूलो संख्या कुन हो?', E'18', E'36', E'32', E'24', E'C', E'ठूलो संख्या = (योगफल + फरक) / 2 = (50 + 14) / 2 = 64 / 2 = 32।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दुईवटा संख्याको योगफल 50 र तिनीहरूको फरक 14 छ भने, ती मध्ये ठूलो संख्या कुन हो?'), v_set_id, v_q_id, 21)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'एउटा काठको मुढालाई 5 टुक्रा बनाउन 12 मिनेट लाग्छ भने, त्यस्तै मुढालाई 8 टुक्रा बनाउन कति समय लाग्ला?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 22, E'एउटा काठको मुढालाई 5 टुक्रा बनाउन 12 मिनेट लाग्छ भने, त्यस्तै मुढालाई 8 टुक्रा बनाउन कति समय लाग्ला?', E'20 मिनेट', E'16 मिनेट', E'24 मिनेट', E'21 मिनेट', E'D', E'5 टुक्रा बनाउन 4 पटक काट्नुपर्छ। 1 पटक काट्न 12/4 = 3 मिनेट लाग्छ। 8 टुक्रा बनाउन 7 पटक काट्नुपर्छ, त्यसैले 7 × 3 = 21 मिनेट लाग्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:एउटा काठको मुढालाई 5 टुक्रा बनाउन 12 मिनेट लाग्छ भने, त्यस्तै मुढालाई 8 टुक्रा बनाउन कति समय लाग्ला?'), v_set_id, v_q_id, 22)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'एउटा बाँदर 30 मिटर अग्लो खम्बामा चढ्दैछ। ऊ पहिलो मिनेटमा 5 मिटर माथि चढ्छ र दोस्रो मिनेटमा 2 मिटर तल झर्छ। खम्बाको टुप्पोमा पुग्न उसलाई जम्मा कति मिनेट लाग्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 23, E'एउटा बाँदर 30 मिटर अग्लो खम्बामा चढ्दैछ। ऊ पहिलो मिनेटमा 5 मिटर माथि चढ्छ र दोस्रो मिनेटमा 2 मिटर तल झर्छ। खम्बाको टुप्पोमा पुग्न उसलाई जम्मा कति मिनेट लाग्छ?', E'19', E'17', E'18', E'20', E'A', E'२ मिनेटको चक्रमा बाँदर खुद ३ मिटर माथि जान्छ। अन्तिम पटक ५ मिटर चढेर टुप्पो टेक्न, त्यसअघि २५ मिटर पुगेको हुनुपर्छ — ८ पूर्ण चक्र (१६ मिनेट) पछि २४ मिटर, त्यसपछि १७ औं मिनेटमा चढेर २९ मिटर (टुप्पो ३० भन्दा कम), १८ औं मिनेटमा झरेर २७ मिटर, अनि १९ औं मिनेटमा चढेर ३२ मिटर (टुप्पो नाघ्यो)। जम्मा **१९ मिनेट** लाग्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:एउटा बाँदर 30 मिटर अग्लो खम्बामा चढ्दैछ। ऊ पहिलो मिनेटमा 5 मिटर माथि चढ्छ र दोस्रो मिनेटमा 2 मिटर तल झर्छ। खम्बाको टुप्पोमा पुग्न उसलाई जम्मा कति मिनेट लाग्छ?'), v_set_id, v_q_id, 23)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'A ले कुनै काम 10 दिनमा र B ले सोही काम 15 दिनमा गर्न सक्छ। दुवै मिलेर सो काम सँगै गर्दा कति दिनमा पूरा गर्न सक्लान्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 24, E'A ले कुनै काम 10 दिनमा र B ले सोही काम 15 दिनमा गर्न सक्छ। दुवै मिलेर सो काम सँगै गर्दा कति दिनमा पूरा गर्न सक्लान्?', E'5 दिन', E'6 दिन', E'8 दिन', E'12 दिन', E'B', E'(A × B) / (A + B) = (10 × 15) / (10 + 15) = 150 / 25 = 6 दिन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:A ले कुनै काम 10 दिनमा र B ले सोही काम 15 दिनमा गर्न सक्छ। दुवै मिलेर सो काम सँगै गर्दा कति दिनमा पूरा गर्न सक्लान्?'), v_set_id, v_q_id, 24)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै रकम साधारण ब्याज अनुसार 10 वर्षमा दोब्बर हुन्छ भने, वार्षिक ब्याजदर कति होला?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 25, E'कुनै रकम साधारण ब्याज अनुसार 10 वर्षमा दोब्बर हुन्छ भने, वार्षिक ब्याजदर कति होला?', E'5%', E'12%', E'10%', E'15%', E'C', E'रकम दोब्बर हुन ब्याज र साँवा बराबर हुनुपर्छ। दर = 100 / समय = 100 / 10 = 10%।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै रकम साधारण ब्याज अनुसार 10 वर्षमा दोब्बर हुन्छ भने, वार्षिक ब्याजदर कति होला?'), v_set_id, v_q_id, 25)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'एउटा परीक्षामा पास हुन 40% अंक चाहिन्छ। एक विद्यार्थीले 140 अंक ल्यायो र 20 अंकले फेल भयो। परीक्षाको पूर्णांक कति होला?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 26, E'एउटा परीक्षामा पास हुन 40% अंक चाहिन्छ। एक विद्यार्थीले 140 अंक ल्यायो र 20 अंकले फेल भयो। परीक्षाको पूर्णांक कति होला?', E'300', E'350', E'500', E'400', E'D', E'पास हुन चाहिने अंक = 140 + 20 = 160। पूर्णांकको 40% भनेको 160 हो भने, पूर्णांक = (160 × 100) / 40 = 400।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:एउटा परीक्षामा पास हुन 40% अंक चाहिन्छ। एक विद्यार्थीले 140 अंक ल्यायो र 20 अंकले फेल भयो। परीक्षाको पूर्णांक कति होला?'), v_set_id, v_q_id, 26)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'रु. 1500 लाई A र B बीच यसरी बाँडियो कि A ले B ले भन्दा रु. 300 बढी पायो। A ले कति रकम पायो होला?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 27, E'रु. 1500 लाई A र B बीच यसरी बाँडियो कि A ले B ले भन्दा रु. 300 बढी पायो। A ले कति रकम पायो होला?', E'900', E'600', E'1000', E'800', E'A', E'मानौं B ले x पायो, A ले x + 300 पायो। 2x + 300 = 1500 => 2x = 1200 => x = 600। A को रकम = 600 + 300 = 900।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:रु. 1500 लाई A र B बीच यसरी बाँडियो कि A ले B ले भन्दा रु. 300 बढी पायो। A ले कति रकम पायो होला?'), v_set_id, v_q_id, 27)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दुई लगातार जोर संख्याहरूको गुणनफल 168 छ भने, ती मध्ये ठूलो संख्या कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 28, E'दुई लगातार जोर संख्याहरूको गुणनफल 168 छ भने, ती मध्ये ठूलो संख्या कुन हो?', E'12', E'14', E'16', E'18', E'B', E'मानौं संख्या x र x+2 हुन्। 12 × 14 = 168 हुन्छ। त्यसैले ठूलो संख्या 14 हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दुई लगातार जोर संख्याहरूको गुणनफल 168 छ भने, ती मध्ये ठूलो संख्या कुन हो?'), v_set_id, v_q_id, 28)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'एउटा पाइपले एउटा ट्यांकी 6 घण्टामा भर्न सक्छ भने अर्को पाइपले सोही ट्यांकी 12 घण्टामा भर्न सक्छ। दुवै पाइप एकैपटक खोल्दा ट्यांकी कति समयमा भरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 29, E'एउटा पाइपले एउटा ट्यांकी 6 घण्टामा भर्न सक्छ भने अर्को पाइपले सोही ट्यांकी 12 घण्टामा भर्न सक्छ। दुवै पाइप एकैपटक खोल्दा ट्यांकी कति समयमा भरिन्छ?', E'3 घण्टा', E'5 घण्टा', E'4 घण्टा', E'6 घण्टा', E'C', E'(T1 × T2) / (T1 + T2) = (6 × 12) / (6 + 12) = 72 / 18 = 4 घण्टा।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:एउटा पाइपले एउटा ट्यांकी 6 घण्टामा भर्न सक्छ भने अर्को पाइपले सोही ट्यांकी 12 घण्टामा भर्न सक्छ। दुवै पाइप एकैपटक खोल्दा ट्यांकी कति समयमा भरिन्छ?'), v_set_id, v_q_id, 29)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'बुवा र छोराको हालको उमेरको योगफल 40 वर्ष छ। 5 वर्ष अगाडि, बुवाको उमेर छोराको उमेरभन्दा 4 गुणा थियो भने, अहिले बुवाको उमेर कति होला?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 30, E'बुवा र छोराको हालको उमेरको योगफल 40 वर्ष छ। 5 वर्ष अगाडि, बुवाको उमेर छोराको उमेरभन्दा 4 गुणा थियो भने, अहिले बुवाको उमेर कति होला?', E'28 वर्ष', E'32 वर्ष', E'30 वर्ष', E'29 वर्ष', E'D', E'५ वर्ष अघि उनीहरूको उमेरको योगफल 40 - 10 = 30 थियो। ५ वर्ष अघि छोरा x र बुवा 4x थिए। 5x = 30 => x = 6। हाल बुवाको उमेर = 4(6) + 5 = 29 वर्ष।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:बुवा र छोराको हालको उमेरको योगफल 40 वर्ष छ। 5 वर्ष अगाडि, बुवाको उमेर छोराको उमेरभन्दा 4 गुणा थियो भने, अहिले बुवाको उमेर कति होला?'), v_set_id, v_q_id, 30)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Top-up: स्थानिक तथा प्रत्यक्षात्मक क्षमताः Coding-Decoding (आधारभूत तह) (+27 Q, 3->30)
  v_set_id := extensions.uuid_generate_v5('83123770-9e69-4d49-b231-b112c95d2692'::uuid, E'स्थानिक तथा प्रत्यक्षात्मक क्षमताः Coding-Decoding (आधारभूत तह)');

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि कुनै कोड भाषामा ''APPLE'' लाई ''BQQMF'' लेखिन्छ भने, सोही कोड भाषामा ''MANGO'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'यदि कुनै कोड भाषामा ''APPLE'' लाई ''BQQMF'' लेखिन्छ भने, सोही कोड भाषामा ''MANGO'' लाई के लेखिन्छ?', E'NBOHP', E'NBPGP', E'OBPGQ', E'NBNGP', E'A', E'यहाँ प्रत्येक अक्षरलाई वर्णमालाको १ स्थान अगाडि (+1) सारिएको छ। ''MANGO'' को प्रत्येक अक्षरलाई १ स्थान अगाडि सार्दा ''NBOHP'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि कुनै कोड भाषामा ''APPLE'' लाई ''BQQMF'' लेखिन्छ भने, सोही कोड भाषामा ''MANGO'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि कुनै कोड भाषामा ''BOY'' लाई ''CPZ'' लेखिन्छ भने, ''GIRL'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'यदि कुनै कोड भाषामा ''BOY'' लाई ''CPZ'' लेखिन्छ भने, ''GIRL'' लाई के लेखिन्छ?', E'HJSK', E'HJSM', E'HJRM', E'HKSM', E'B', E'यहाँ प्रत्येक अक्षरलाई वर्णमालाको १ स्थान अगाडि (+1) सारिएको छ। त्यसैले, ''GIRL'' लाई १ स्थान अगाडि सार्दा ''HJSM'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि कुनै कोड भाषामा ''BOY'' लाई ''CPZ'' लेखिन्छ भने, ''GIRL'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि कुनै कोड भाषामा ''CAT'' लाई ''DCU'' लेखिन्छ भने, ''DOG'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'यदि कुनै कोड भाषामा ''CAT'' लाई ''DCU'' लेखिन्छ भने, ''DOG'' लाई के लेखिन्छ?', E'FPH', E'EPG', E'EPH', E'EQH', E'C', E'यहाँ प्रत्येक अक्षरलाई वर्णमालाको १ स्थान अगाडि (+1) सारिएको छ। ''DOG'' लाई १ स्थान अगाडि सार्दा ''EPH'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि कुनै कोड भाषामा ''CAT'' लाई ''DCU'' लेखिन्छ भने, ''DOG'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि कुनै कोड भाषामा ''SUN'' लाई ''TVO'' लेखिन्छ भने, ''MOON'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'यदि कुनै कोड भाषामा ''SUN'' लाई ''TVO'' लेखिन्छ भने, ''MOON'' लाई के लेखिन्छ?', E'NQPO', E'NPQO', E'NPPM', E'NPPO', E'D', E'यहाँ प्रत्येक अक्षरलाई वर्णमालाको १ स्थान अगाडि (+1) सारिएको छ। ''MOON'' लाई १ स्थान अगाडि सार्दा ''NPPO'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि कुनै कोड भाषामा ''SUN'' लाई ''TVO'' लेखिन्छ भने, ''MOON'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि कुनै कोड भाषामा ''BAT'' लाई ''CBU'' लेखिन्छ भने, ''BALL'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'यदि कुनै कोड भाषामा ''BAT'' लाई ''CBU'' लेखिन्छ भने, ''BALL'' लाई के लेखिन्छ?', E'CBMM', E'CBMK', E'CCNN', E'DBMM', E'A', E'यहाँ प्रत्येक अक्षरलाई वर्णमालाको १ स्थान अगाडि (+1) सारिएको छ। ''BALL'' लाई १ स्थान अगाडि सार्दा ''CBMM'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि कुनै कोड भाषामा ''BAT'' लाई ''CBU'' लेखिन्छ भने, ''BALL'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि कुनै कोड भाषामा ''TEACHER'' लाई ''VGCEJGT'' लेखिन्छ भने, ''STUDENT'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'यदि कुनै कोड भाषामा ''TEACHER'' लाई ''VGCEJGT'' लेखिन्छ भने, ''STUDENT'' लाई के लेखिन्छ?', E'UWWFGPV', E'UVWFGPV', E'UVWFHPU', E'UVXFGQV', E'B', E'यहाँ प्रत्येक अक्षरलाई वर्णमालाको २ स्थान अगाडि (+2) सारिएको छ। ''STUDENT'' लाई २ स्थान अगाडि सार्दा ''UVWFGPV'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि कुनै कोड भाषामा ''TEACHER'' लाई ''VGCEJGT'' लेखिन्छ भने, ''STUDENT'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि कुनै कोड भाषामा ''WATER'' लाई ''YCVGT'' लेखिन्छ भने, ''FIRE'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'यदि कुनै कोड भाषामा ''WATER'' लाई ''YCVGT'' लेखिन्छ भने, ''FIRE'' लाई के लेखिन्छ?', E'HKGS', E'HLGT', E'HKGT', E'HKHT', E'C', E'यहाँ प्रत्येक अक्षरलाई वर्णमालाको २ स्थान अगाडि (+2) सारिएको छ। ''FIRE'' लाई २ स्थान अगाडि सार्दा ''HKGT'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि कुनै कोड भाषामा ''WATER'' लाई ''YCVGT'' लेखिन्छ भने, ''FIRE'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि कुनै कोड भाषामा ''PAPER'' लाई ''RCRGT'' लेखिन्छ भने, ''PENCIL'' KN लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'यदि कुनै कोड भाषामा ''PAPER'' लाई ''RCRGT'' लेखिन्छ भने, ''PENCIL'' KN लाई के लेखिन्छ?', E'RGPELM', E'RFPEKN', E'RGQDKN', E'RGPEKN', E'D', E'यहाँ प्रत्येक अक्षरलाई वर्णमालाको २ स्थान अगाडि (+2) सारिएको छ। ''PENCIL'' लाई २ स्थान अगाडि सार्दा ''RGPEKN'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि कुनै कोड भाषामा ''PAPER'' लाई ''RCRGT'' लेखिन्छ भने, ''PENCIL'' KN लाई के लेखिन्छ?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि कुनै कोड भाषामा ''SCHOOL'' लाई ''UEJQQN'' लेखिन्छ भने, ''CLASS'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'यदि कुनै कोड भाषामा ''SCHOOL'' लाई ''UEJQQN'' लेखिन्छ भने, ''CLASS'' लाई के लेखिन्छ?', E'ENCUU', E'ENCVV', E'FMCUU', E'ENBUU', E'A', E'यहाँ प्रत्येक अक्षरलाई वर्णमालाको २ स्थान अगाडि (+2) सारिएको छ। ''CLASS'' लाई २ स्थान अगाडि सार्दा ''ENCUU'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि कुनै कोड भाषामा ''SCHOOL'' लाई ''UEJQQN'' लेखिन्छ भने, ''CLASS'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि कुनै कोड भाषामा ''NEPAL'' लाई ''PGRCN'' लेखिन्छ भने, ''INDIA'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'यदि कुनै कोड भाषामा ''NEPAL'' लाई ''PGRCN'' लेखिन्छ भने, ''INDIA'' लाई के लेखिन्छ?', E'KPFLC', E'KPFKC', E'KPEKC', E'JPFKC', E'B', E'यहाँ प्रत्येक अक्षरलाई वर्णमालाको २ स्थान अगाडि (+2) सारिएको छ। ''INDIA'' लाई २ स्थान अगाडि सार्दा ''KPFKC'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि कुनै कोड भाषामा ''NEPAL'' लाई ''PGRCN'' लेखिन्छ भने, ''INDIA'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि कुनै कोड भाषामा ''BOOK'' लाई ''ERRN'' लेखिन्छ भने, ''PEN'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'यदि कुनै कोड भाषामा ''BOOK'' लाई ''ERRN'' लेखिन्छ भने, ''PEN'' लाई के लेखिन्छ?', E'SHR', E'THQ', E'SHQ', E'SGQ', E'C', E'यहाँ प्रत्येक अक्षरलाई वर्णमालाको ३ स्थान अगाडि (+3) सारिएको छ। ''PEN'' लाई ३ स्थान अगाडि सार्दा ''SHQ'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि कुनै कोड भाषामा ''BOOK'' लाई ''ERRN'' लेखिन्छ भने, ''PEN'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि कुनै कोड भाषामा ''CHAIR'' लाई ''FKDLU'' लेखिन्छ भने, ''TABLE'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'यदि कुनै कोड भाषामा ''CHAIR'' लाई ''FKDLU'' लेखिन्छ भने, ''TABLE'' लाई के लेखिन्छ?', E'WDEOI', E'VDEOH', E'WDENG', E'WDEOH', E'D', E'यहाँ प्रत्येक अक्षरलाई वर्णमालाको ३ स्थान अगाडि (+3) सारिएको छ। ''TABLE'' लाई ३ स्थान अगाडि सार्दा ''WDEOH'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि कुनै कोड भाषामा ''CHAIR'' लाई ''FKDLU'' लेखिन्छ भने, ''TABLE'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि कुनै कोड भाषामा ''HOUSE'' लाई ''KRXVH'' लेखिन्छ भने, ''DOOR'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'यदि कुनै कोड भाषामा ''HOUSE'' लाई ''KRXVH'' लेखिन्छ भने, ''DOOR'' लाई के लेखिन्छ?', E'GRRU', E'GRSV', E'FQRU', E'GRRT', E'A', E'यहाँ प्रत्येक अक्षरलाई वर्णमालाको ३ स्थान अगाडि (+3) सारिएको छ। ''DOOR'' लाई ३ स्थान अगाडि सार्दा ''GRRU'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि कुनै कोड भाषामा ''HOUSE'' लाई ''KRXVH'' लेखिन्छ भने, ''DOOR'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि कुनै कोड भाषामा ''LIGHT'' लाई ''OLJKW'' लेखिन्छ भने, ''DARK'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'यदि कुनै कोड भाषामा ''LIGHT'' लाई ''OLJKW'' लेखिन्छ भने, ''DARK'' लाई के लेखिन्छ?', E'GDUO', E'GDUN', E'HDUN', E'GDVN', E'B', E'यहाँ प्रत्येक अक्षरलाई वर्णमालाको ३ स्थान अगाडि (+3) सारिएको छ। ''DARK'' लाई ३ स्थान अगाडि सार्दा ''GDUN'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि कुनै कोड भाषामा ''LIGHT'' लाई ''OLJKW'' लेखिन्छ भने, ''DARK'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि कुनै कोड भाषामा ''NIGHT'' लाई ''QLJKW'' लेखिन्छ भने, ''DAY'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'यदि कुनै कोड भाषामा ''NIGHT'' लाई ''QLJKW'' लेखिन्छ भने, ''DAY'' लाई के लेखिन्छ?', E'GDC', E'HDC', E'GDB', E'GDD', E'C', E'यहाँ प्रत्येक अक्षरलाई वर्णमालाको ३ स्थान अगाडि (+3) सारिएको छ। ''DAY'' लाई ३ स्थान अगाडि सार्दा ''GDB'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि कुनै कोड भाषामा ''NIGHT'' लाई ''QLJKW'' लेखिन्छ भने, ''DAY'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि कुनै कोड भाषामा ''BIRD'' लाई ''AQQC'' लेखिन्छ भने, ''CROW'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'यदि कुनै कोड भाषामा ''BIRD'' लाई ''AQQC'' लेखिन्छ भने, ''CROW'' लाई के लेखिन्छ?', E'BQMV', E'CQNV', E'BQNW', E'BQNV', E'D', E'यहाँ प्रत्येक अक्षरलाई वर्णमालाको १ स्थान पछाडि (-1) सारिएको छ। ''CROW'' लाई १ स्थान पछाडि सार्दा ''BQNV'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि कुनै कोड भाषामा ''BIRD'' लाई ''AQQC'' लेखिन्छ भने, ''CROW'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि कुनै कोड भाषामा ''TIGER'' लाई ''SHFDQ'' लेखिन्छ भने, ''LION'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 20, E'यदि कुनै कोड भाषामा ''TIGER'' लाई ''SHFDQ'' लेखिन्छ भने, ''LION'' लाई के लेखिन्छ?', E'KHNM', E'KHMN', E'JGNM', E'KINM', E'A', E'यहाँ प्रत्येक अक्षरलाई वर्णमालाको १ स्थान पछाडि (-1) सारिएको छ। ''LION'' लाई १ स्थान पछाडि सार्दा ''KHNM'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि कुनै कोड भाषामा ''TIGER'' लाई ''SHFDQ'' लेखिन्छ भने, ''LION'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 20)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि कुनै कोड भाषामा ''FISH'' लाई ''EHRG'' लेखिन्छ भने, ''CRAB'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 21, E'यदि कुनै कोड भाषामा ''FISH'' लाई ''EHRG'' लेखिन्छ भने, ''CRAB'' लाई के लेखिन्छ?', E'BQYA', E'BQZA', E'BPZA', E'BQZB', E'B', E'यहाँ प्रत्येक अक्षरलाई वर्णमालाको १ स्थान पछाडि (-1) सारिएको छ। ''CRAB'' लाई १ स्थान पछाडि सार्दा ''BQZA'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि कुनै कोड भाषामा ''FISH'' लाई ''EHRG'' लेखिन्छ भने, ''CRAB'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 21)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि कुनै कोड भाषामा ''SNAKE'' लाई ''RMZJD'' लेखिन्छ भने, ''FROG'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 22, E'यदि कुनै कोड भाषामा ''SNAKE'' लाई ''RMZJD'' लेखिन्छ भने, ''FROG'' लाई के लेखिन्छ?', E'EQME', E'EQNE', E'EQNF', E'EQMF', E'C', E'यहाँ प्रत्येक अक्षरलाई वर्णमालाको १ स्थान पछाडि (-1) सारिएको छ। ''FROG'' लाई १ स्थान पछाडि सार्दा ''EQNF'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि कुनै कोड भाषामा ''SNAKE'' लाई ''RMZJD'' लेखिन्छ भने, ''FROG'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 22)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि कुनै कोड भाषामा ''HORSE'' लाई ''GNQRD'' लेखिन्छ भने, ''CAMEL'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 23, E'यदि कुनै कोड भाषामा ''HORSE'' लाई ''GNQRD'' लेखिन्छ भने, ''CAMEL'' लाई के लेखिन्छ?', E'BZLCK', E'BYLDK', E'BZMDK', E'BZLDK', E'D', E'यहाँ प्रत्येक अक्षरलाई वर्णमालाको १ स्थान पछाडि (-1) सारिएको छ। ''CAMEL'' लाई १ स्थान पछाडि सार्दा ''BZLDK'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि कुनै कोड भाषामा ''HORSE'' लाई ''GNQRD'' लेखिन्छ भने, ''CAMEL'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 23)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि कुनै कोड भाषामा ''MONKEY'' लाई ''KMLICW'' लेखिन्छ भने, ''DONKEY'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 24, E'यदि कुनै कोड भाषामा ''MONKEY'' लाई ''KMLICW'' लेखिन्छ भने, ''DONKEY'' लाई के लेखिन्छ?', E'BMLICW', E'BMLKCW', E'BNLICW', E'CMLICW', E'A', E'यहाँ प्रत्येक अक्षरलाई वर्णमालाको २ स्थान पछाडि (-2) सारिएको छ। ''DONKEY'' लाई २ स्थान पछाडि सार्दा ''BMLICW'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि कुनै कोड भाषामा ''MONKEY'' लाई ''KMLICW'' लेखिन्छ भने, ''DONKEY'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 24)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि कुनै कोड भाषामा ''PIGEON'' लाई ''NGECML'' लेखिन्छ भने, ''EAGLE'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 25, E'यदि कुनै कोड भाषामा ''PIGEON'' लाई ''NGECML'' लेखिन्छ भने, ''EAGLE'' लाई के लेखिन्छ?', E'CYFJC', E'CYEJC', E'CXEJC', E'CYEKC', E'B', E'यहाँ प्रत्येक अक्षरलाई वर्णमालाको २ स्थान पछाडि (-2) सारिएको छ। ''EAGLE'' लाई २ स्थान पछाडि सार्दा ''CYEJC'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि कुनै कोड भाषामा ''PIGEON'' लाई ''NGECML'' लेखिन्छ भने, ''EAGLE'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 25)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि कुनै कोड भाषामा ''PARROT'' लाई ''NYPPMR'' लेखिन्छ भने, ''DOVE'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 26, E'यदि कुनै कोड भाषामा ''PARROT'' लाई ''NYPPMR'' लेखिन्छ भने, ''DOVE'' लाई के लेखिन्छ?', E'BMTD', E'BMSC', E'BMTC', E'BNTC', E'C', E'यहाँ प्रत्येक अक्षरलाई वर्णमालाको २ स्थान पछाडि (-2) सारिएको छ। ''DOVE'' लाई २ स्थान पछाडि सार्दा ''BMTC'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि कुनै कोड भाषामा ''PARROT'' लाई ''NYPPMR'' लेखिन्छ भने, ''DOVE'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 26)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि कुनै कोड भाषामा ''RABBIT'' लाई ''PYZZGR'' लेखिन्छ भने, ''MOUSE'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 27, E'यदि कुनै कोड भाषामा ''RABBIT'' लाई ''PYZZGR'' लेखिन्छ भने, ''MOUSE'' लाई के लेखिन्छ?', E'KNSQC', E'KMRQC', E'KMSPB', E'KMSQC', E'D', E'यहाँ प्रत्येक अक्षरलाई वर्णमालाको २ स्थान पछाडि (-2) सारिएको छ। ''MOUSE'' लाई २ स्थान पछाडि सार्दा ''KMSQC'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि कुनै कोड भाषामा ''RABBIT'' लाई ''PYZZGR'' लेखिन्छ भने, ''MOUSE'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 27)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि कुनै कोड भाषामा ''BEAR'' लाई ''ZCYP'' लेखिन्छ भने, ''WOLF'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 28, E'यदि कुनै कोड भाषामा ''BEAR'' लाई ''ZCYP'' लेखिन्छ भने, ''WOLF'' लाई के लेखिन्छ?', E'UMJD', E'UMKD', E'ULJD', E'VMJD', E'A', E'यहाँ प्रत्येक अक्षरलाई वर्णमालाको २ स्थान पछाडि (-2) सारिएको छ। ''WOLF'' लाई २ स्थान पछाडि सार्दा ''UMJD'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि कुनै कोड भाषामा ''BEAR'' लाई ''ZCYP'' लेखिन्छ भने, ''WOLF'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 28)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि कुनै कोड भाषामा ''FLOWER'' लाई ''REWOLF'' लेखिन्छ भने, ''GARDEN'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 29, E'यदि कुनै कोड भाषामा ''FLOWER'' लाई ''REWOLF'' लेखिन्छ भने, ''GARDEN'' लाई के लेखिन्छ?', E'NEDRGA', E'NEDRAG', E'NDREAG', E'NDERAG', E'B', E'यहाँ शब्दका अक्षरहरूलाई उल्टो क्रम (Reverse order) मा लेखिएको छ। ''GARDEN'' को उल्टो ''NEDRAG'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि कुनै कोड भाषामा ''FLOWER'' लाई ''REWOLF'' लेखिन्छ भने, ''GARDEN'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 29)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि कुनै कोड भाषामा ''MOTHER'' लाई ''REHTOM'' लेखिन्छ भने, ''FATHER'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 30, E'यदि कुनै कोड भाषामा ''MOTHER'' लाई ''REHTOM'' लेखिन्छ भने, ''FATHER'' लाई के लेखिन्छ?', E'REHTFA', E'RHTEAF', E'REHTAF', E'REHFTA', E'C', E'यहाँ शब्दका अक्षरहरूलाई उल्टो क्रम (Reverse order) मा लेखिएको छ। ''FATHER'' को उल्टो ''REHTAF'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि कुनै कोड भाषामा ''MOTHER'' लाई ''REHTOM'' लेखिन्छ भने, ''FATHER'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 30)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  RAISE NOTICE 'aptitude batch top-up complete: 84 questions appended.';
END $$;
