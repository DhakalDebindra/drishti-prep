-- FIX re-apply: top-up existing sets for verbal-1/verbal-3 using a content+options fingerprint
-- (previous attempt collided because these subtopics reuse a boilerplate question stem).
-- Generated 2026-07-05T13:18:30.173Z.
DO $$
DECLARE
  v_set_id uuid;
  v_q_id uuid;
BEGIN

  -- Top-up: शाब्दिक बौद्धिक परीक्षणः शब्द ज्ञान (आधारभूत तह) (+21 Q, 9->30)
  v_set_id := extensions.uuid_generate_v5('7d4b6d71-7451-4e67-91fe-5323380a3258'::uuid, E'शाब्दिक बौद्धिक परीक्षणः शब्द ज्ञान (आधारभूत तह)');

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''अग्नि'' को पर्यायवाची शब्द कुन हो?|A:आगो|B:हावा|C:पानी|D:माटो');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'''अग्नि'' को पर्यायवाची शब्द कुन हो?', E'आगो', E'हावा', E'पानी', E'माटो', E'A', E'''अग्नि'' र ''आगो'' समान अर्थ दिने पर्यायवाची शब्द हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''अग्नि'' को पर्यायवाची शब्द कुन हो?|A:आगो|B:हावा|C:पानी|D:माटो'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''आकाश'' को पर्यायवाची शब्द कुन हो?|A:धर्ती|B:गगन|C:पाताल|D:सागर');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'''आकाश'' को पर्यायवाची शब्द कुन हो?', E'धर्ती', E'गगन', E'पाताल', E'सागर', E'B', E'''आकाश'' लाई बुझाउने अर्को शब्द ''गगन'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''आकाश'' को पर्यायवाची शब्द कुन हो?|A:धर्ती|B:गगन|C:पाताल|D:सागर'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''सूर्य'' को पर्यायवाची शब्द कुन हो?|A:चन्द्र|B:तारा|C:रवि|D:बादल');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'''सूर्य'' को पर्यायवाची शब्द कुन हो?', E'चन्द्र', E'तारा', E'रवि', E'बादल', E'C', E'''सूर्य'' को अर्को नाम ''रवि'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''सूर्य'' को पर्यायवाची शब्द कुन हो?|A:चन्द्र|B:तारा|C:रवि|D:बादल'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''चन्द्रमा'' को पर्यायवाची शब्द कुन हो?|A:सूर्य|B:ग्रह|C:नक्षत्र|D:शशी');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'''चन्द्रमा'' को पर्यायवाची शब्द कुन हो?', E'सूर्य', E'ग्रह', E'नक्षत्र', E'शशी', E'D', E'साहित्यमा ''चन्द्रमा'' लाई ''शशी'' भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''चन्द्रमा'' को पर्यायवाची शब्द कुन हो?|A:सूर्य|B:ग्रह|C:नक्षत्र|D:शशी'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''पृथ्वी'' को पर्यायवाची शब्द कुन हो?|A:धर्ती|B:आकाश|C:हावा|D:पानी');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'''पृथ्वी'' को पर्यायवाची शब्द कुन हो?', E'धर्ती', E'आकाश', E'हावा', E'पानी', E'A', E'''पृथ्वी'' र ''धर्ती'' पर्यायवाची शब्द हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''पृथ्वी'' को पर्यायवाची शब्द कुन हो?|A:धर्ती|B:आकाश|C:हावा|D:पानी'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''पानी'' को पर्यायवाची शब्द कुन हो?|A:आगो|B:जल|C:माटो|D:हावा');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'''पानी'' को पर्यायवाची शब्द कुन हो?', E'आगो', E'जल', E'माटो', E'हावा', E'B', E'पानीलाई ''जल'' पनि भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''पानी'' को पर्यायवाची शब्द कुन हो?|A:आगो|B:जल|C:माटो|D:हावा'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''हावा'' को पर्यायवाची शब्द कुन हो?|A:जल|B:अग्नि|C:पवन|D:धर्ती');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'''हावा'' को पर्यायवाची शब्द कुन हो?', E'जल', E'अग्नि', E'पवन', E'धर्ती', E'C', E'हावाको पर्यायवाची शब्द ''पवन'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''हावा'' को पर्यायवाची शब्द कुन हो?|A:जल|B:अग्नि|C:पवन|D:धर्ती'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''फूल'' को पर्यायवाची शब्द कुन हो?|A:काँडा|B:पात|C:हाँगा|D:पुष्प');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'''फूल'' को पर्यायवाची शब्द कुन हो?', E'काँडा', E'पात', E'हाँगा', E'पुष्प', E'D', E'फूललाई ''पुष्प'' पनि भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''फूल'' को पर्यायवाची शब्द कुन हो?|A:काँडा|B:पात|C:हाँगा|D:पुष्प'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''रुख'' को पर्यायवाची शब्द कुन हो?|A:वृक्ष|B:झार|C:बुुट्यान|D:लहरा');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'''रुख'' को पर्यायवाची शब्द कुन हो?', E'वृक्ष', E'झार', E'बुुट्यान', E'लहरा', E'A', E'रुखको समानार्थ दिने शब्द ''वृक्ष'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''रुख'' को पर्यायवाची शब्द कुन हो?|A:वृक्ष|B:झार|C:बुुट्यान|D:लहरा'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''दिन'' को पर्यायवाची शब्द कुन हो?|A:रात|B:दिवस|C:साँझ|D:बिहान');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'''दिन'' को पर्यायवाची शब्द कुन हो?', E'रात', E'दिवस', E'साँझ', E'बिहान', E'B', E'दिनलाई ''दिवस'' पनि भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''दिन'' को पर्यायवाची शब्द कुन हो?|A:रात|B:दिवस|C:साँझ|D:बिहान'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''रात'' को पर्यायवाची शब्द कुन हो?|A:दिन|B:उज्यालो|C:रात्री|D:घाम');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 20, E'''रात'' को पर्यायवाची शब्द कुन हो?', E'दिन', E'उज्यालो', E'रात्री', E'घाम', E'C', E'रातको पर्यायवाची शब्द ''रात्री'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''रात'' को पर्यायवाची शब्द कुन हो?|A:दिन|B:उज्यालो|C:रात्री|D:घाम'), v_set_id, v_q_id, 20)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''घर'' को पर्यायवाची शब्द कुन हो?|A:वन|B:गोठ|C:आँगन|D:गृह');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 21, E'''घर'' को पर्यायवाची शब्द कुन हो?', E'वन', E'गोठ', E'आँगन', E'गृह', E'D', E'घरलाई ''गृह'' पनि भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''घर'' को पर्यायवाची शब्द कुन हो?|A:वन|B:गोठ|C:आँगन|D:गृह'), v_set_id, v_q_id, 21)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''बाटो'' को पर्यायवाची शब्द कुन हो?|A:मार्ग|B:पर्खाल|C:खोला|D:पहाड');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 22, E'''बाटो'' को पर्यायवाची शब्द कुन हो?', E'मार्ग', E'पर्खाल', E'खोला', E'पहाड', E'A', E'बाटोको अर्को नाम ''मार्ग'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''बाटो'' को पर्यायवाची शब्द कुन हो?|A:मार्ग|B:पर्खाल|C:खोला|D:पहाड'), v_set_id, v_q_id, 22)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''मानिस'' को पर्यायवाची शब्द कुन हो?|A:दानव|B:मानव|C:पशु|D:पक्षी');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 23, E'''मानिस'' को पर्यायवाची शब्द कुन हो?', E'दानव', E'मानव', E'पशु', E'पक्षी', E'B', E'मानिस र मानव पर्यायवाची शब्द हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''मानिस'' को पर्यायवाची शब्द कुन हो?|A:दानव|B:मानव|C:पशु|D:पक्षी'), v_set_id, v_q_id, 23)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''आँखा'' को पर्यायवाची शब्द कुन हो?|A:कान|B:नाक|C:नयन|D:मुख');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 24, E'''आँखा'' को पर्यायवाची शब्द कुन हो?', E'कान', E'नाक', E'नयन', E'मुख', E'C', E'आँखालाई ''नयन'' पनि भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''आँखा'' को पर्यायवाची शब्द कुन हो?|A:कान|B:नाक|C:नयन|D:मुख'), v_set_id, v_q_id, 24)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''हात'' को पर्यायवाची शब्द कुन हो?|A:पाउ|B:औँला|C:नङ|D:हस्त');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 25, E'''हात'' को पर्यायवाची शब्द कुन हो?', E'पाउ', E'औँला', E'नङ', E'हस्त', E'D', E'हातको पर्यायवाची शब्द ''हस्त'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''हात'' को पर्यायवाची शब्द कुन हो?|A:पाउ|B:औँला|C:नङ|D:हस्त'), v_set_id, v_q_id, 25)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''खुट्टा'' को पर्यायवाची शब्द कुन हो?|A:पाउ|B:हात|C:कपाल|D:कान');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 26, E'''खुट्टा'' को पर्यायवाची शब्द कुन हो?', E'पाउ', E'हात', E'कपाल', E'कान', E'A', E'खुट्टालाई ''पाउ'' पनि भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''खुट्टा'' को पर्यायवाची शब्द कुन हो?|A:पाउ|B:हात|C:कपाल|D:कान'), v_set_id, v_q_id, 26)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''कान'' को पर्यायवाची शब्द कुन हो?|A:नयन|B:कर्ण|C:नासिका|D:ओठ');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 27, E'''कान'' को पर्यायवाची शब्द कुन हो?', E'नयन', E'कर्ण', E'नासिका', E'ओठ', E'B', E'कानको पर्यायवाची शब्द ''कर्ण'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''कान'' को पर्यायवाची शब्द कुन हो?|A:नयन|B:कर्ण|C:नासिका|D:ओठ'), v_set_id, v_q_id, 27)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''कपाल'' को पर्यायवाची शब्द कुन हो?|A:नङ|B:दाँत|C:केश|D:आँखा');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 28, E'''कपाल'' को पर्यायवाची शब्द कुन हो?', E'नङ', E'दाँत', E'केश', E'आँखा', E'C', E'कपाललाई ''केश'' पनि भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''कपाल'' को पर्यायवाची शब्द कुन हो?|A:नङ|B:दाँत|C:केश|D:आँखा'), v_set_id, v_q_id, 28)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''रगत'' को पर्यायवाची शब्द कुन हो?|A:पसिना|B:आँसु|C:पानी|D:रक्त');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 29, E'''रगत'' को पर्यायवाची शब्द कुन हो?', E'पसिना', E'आँसु', E'पानी', E'रक्त', E'D', E'रगतको पर्यायवाची शब्द ''रक्त'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''रगत'' को पर्यायवाची शब्द कुन हो?|A:पसिना|B:आँसु|C:पानी|D:रक्त'), v_set_id, v_q_id, 29)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''दिन'' को विपरीतार्थक शब्द कुन हो?|A:रात|B:उज्यालो|C:बिहान|D:साँझ');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 30, E'''दिन'' को विपरीतार्थक शब्द कुन हो?', E'रात', E'उज्यालो', E'बिहान', E'साँझ', E'A', E'''दिन'' को उल्टो अर्थ दिने शब्द ''रात'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''दिन'' को विपरीतार्थक शब्द कुन हो?|A:रात|B:उज्यालो|C:बिहान|D:साँझ'), v_set_id, v_q_id, 30)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Top-up: शाब्दिक बौद्धिक परीक्षणः शाब्दिक वर्गीकरण (आधारभूत तह) (+21 Q, 9->30)
  v_set_id := extensions.uuid_generate_v5('ae5f551c-9daa-4651-bf85-7891ea89c25c'::uuid, E'शाब्दिक बौद्धिक परीक्षणः शाब्दिक वर्गीकरण (आधारभूत तह)');

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:कुकुर|B:गाई|C:भैंसी|D:बाख्रा');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'समूहमा नमिल्ने शब्द कुन हो?', E'कुकुर', E'गाई', E'भैंसी', E'बाख्रा', E'A', E'कुकुर मांसाहारी जनावर हो, अन्य सबै शाकाहारी हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:कुकुर|B:गाई|C:भैंसी|D:बाख्रा'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:आँप|B:आलु|C:स्याउ|D:सुन्तला');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'समूहमा नमिल्ने शब्द कुन हो?', E'आँप', E'आलु', E'स्याउ', E'सुन्तला', E'B', E'आलु तरकारी हो, अन्य सबै फलफूल हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:आँप|B:आलु|C:स्याउ|D:सुन्तला'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:आँखा|B:कान|C:हात|D:नाक');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'समूहमा नमिल्ने शब्द कुन हो?', E'आँखा', E'कान', E'हात', E'नाक', E'C', E'हात ज्ञानेन्द्रिय (Sense organ) होइन, अन्य सबै ज्ञानेन्द्रिय हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:आँखा|B:कान|C:हात|D:नाक'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:काठमाडौं|B:पोखरा|C:धरान|D:दिल्ली');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'समूहमा नमिल्ने शब्द कुन हो?', E'काठमाडौं', E'पोखरा', E'धरान', E'दिल्ली', E'D', E'दिल्ली भारतको सहर हो, अन्य सबै नेपालका सहर हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:काठमाडौं|B:पोखरा|C:धरान|D:दिल्ली'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:माटो|B:सुन|C:चाँदी|D:फलाम');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'समूहमा नमिल्ने शब्द कुन हो?', E'माटो', E'सुन', E'चाँदी', E'फलाम', E'A', E'माटो धातु होइन, अन्य सबै धातु हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:माटो|B:सुन|C:चाँदी|D:फलाम'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:बागमती|B:सगरमाथा|C:कोशी|D:कर्णाली');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'समूहमा नमिल्ने शब्द कुन हो?', E'बागमती', E'सगरमाथा', E'कोशी', E'कर्णाली', E'B', E'सगरमाथा हिमाल हो, अन्य सबै नदीका नाम हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:बागमती|B:सगरमाथा|C:कोशी|D:कर्णाली'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:बस|B:कार|C:हवाईजहाज|D:ट्रक');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'समूहमा नमिल्ने शब्द कुन हो?', E'बस', E'कार', E'हवाईजहाज', E'ट्रक', E'C', E'हवाईजहाज आकाशमा उड्ने साधन हो, अन्य सबै जमिनमा गुड्ने साधन हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:बस|B:कार|C:हवाईजहाज|D:ट्रक'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:कलम|B:पेन्सिल|C:मार्कर|D:कापी');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'समूहमा नमिल्ने शब्द कुन हो?', E'कलम', E'पेन्सिल', E'मार्कर', E'कापी', E'D', E'कापीमा लेखिन्छ, अन्य सबै लेख्ने साधन हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:कलम|B:पेन्सिल|C:मार्कर|D:कापी'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:विद्यार्थी|B:शिक्षक|C:डाक्टर|D:इन्जिनियर');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'समूहमा नमिल्ने शब्द कुन हो?', E'विद्यार्थी', E'शिक्षक', E'डाक्टर', E'इन्जिनियर', E'A', E'विद्यार्थी कुनै पेसा होइन, अन्य सबै पेसा वा व्यवसाय हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:विद्यार्थी|B:शिक्षक|C:डाक्टर|D:इन्जिनियर'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:रातो|B:कालो|C:नीलो|D:हरियो');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'समूहमा नमिल्ने शब्द कुन हो?', E'रातो', E'कालो', E'नीलो', E'हरियो', E'B', E'कालो इन्द्रेणीमा पर्ने रङ होइन, अन्य सबै इन्द्रेणीका रङ हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:रातो|B:कालो|C:नीलो|D:हरियो'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:बाघ|B:सिंह|C:खरायो|D:चितुवा');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 20, E'समूहमा नमिल्ने शब्द कुन हो?', E'बाघ', E'सिंह', E'खरायो', E'चितुवा', E'C', E'खरायो शाकाहारी जनावर हो, अन्य सबै मांसाहारी हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:बाघ|B:सिंह|C:खरायो|D:चितुवा'), v_set_id, v_q_id, 20)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:मुटु|B:कलेजो|C:फोक्सो|D:छाला');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 21, E'समूहमा नमिल्ने शब्द कुन हो?', E'मुटु', E'कलेजो', E'फोक्सो', E'छाला', E'D', E'छाला शरीरको बाहिरी अंग हो, अन्य सबै भित्री अंग हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:मुटु|B:कलेजो|C:फोक्सो|D:छाला'), v_set_id, v_q_id, 21)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:टोकियो|B:नेपाल|C:भारत|D:चीन');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 22, E'समूहमा नमिल्ने शब्द कुन हो?', E'टोकियो', E'नेपाल', E'भारत', E'चीन', E'A', E'टोकियो जापानको सहर हो, अन्य सबै देशका नाम हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:टोकियो|B:नेपाल|C:भारत|D:चीन'), v_set_id, v_q_id, 22)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:गहुँ|B:तोरी|C:धान|D:मकै');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 23, E'समूहमा नमिल्ने शब्द कुन हो?', E'गहुँ', E'तोरी', E'धान', E'मकै', E'B', E'तोरी तेलहन बाली हो, अन्य सबै अन्नबाली हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:गहुँ|B:तोरी|C:धान|D:मकै'), v_set_id, v_q_id, 23)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:गितार|B:मादल|C:बाँसुरी|D:तबला');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 24, E'समूहमा नमिल्ने शब्द कुन हो?', E'गितार', E'मादल', E'बाँसुरी', E'तबला', E'C', E'बाँसुरी मुखले फुकेर बजाइन्छ, अन्य हात वा औँलाले बजाइन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:गितार|B:मादल|C:बाँसुरी|D:तबला'), v_set_id, v_q_id, 24)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:चन्द्रमा|B:पृथ्वी|C:मंगल|D:सूर्य');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 25, E'समूहमा नमिल्ने शब्द कुन हो?', E'चन्द्रमा', E'पृथ्वी', E'मंगल', E'सूर्य', E'D', E'सूर्य एउटा तारा हो, अन्य ग्रह वा उपग्रह हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:चन्द्रमा|B:पृथ्वी|C:मंगल|D:सूर्य'), v_set_id, v_q_id, 25)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:चेस|B:भलिबल|C:फुटबल|D:बास्केटबल');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 26, E'समूहमा नमिल्ने शब्द कुन हो?', E'चेस', E'भलिबल', E'फुटबल', E'बास्केटबल', E'A', E'चेस भित्री (Indoor) खेल हो, अन्य सबै बाहिरी (Outdoor) खेल हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:चेस|B:भलिबल|C:फुटबल|D:बास्केटबल'), v_set_id, v_q_id, 26)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:पानी|B:रोटी|C:दूध|D:जुस');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 27, E'समूहमा नमिल्ने शब्द कुन हो?', E'पानी', E'रोटी', E'दूध', E'जुस', E'B', E'रोटी ठोस पदार्थ हो, अन्य सबै तरल पदार्थ हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:पानी|B:रोटी|C:दूध|D:जुस'), v_set_id, v_q_id, 27)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:कुखुरा|B:हाँस|C:सर्प|D:परेवा');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 28, E'समूहमा नमिल्ने शब्द कुन हो?', E'कुखुरा', E'हाँस', E'सर्प', E'परेवा', E'C', E'सर्प घिस्रिएर हिँड्ने (Reptile) जीव हो, अन्य सबै चरा वर्ग हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:कुखुरा|B:हाँस|C:सर्प|D:परेवा'), v_set_id, v_q_id, 28)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:मन्दिर|B:मस्जिद|C:चर्च|D:विद्यालय');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 29, E'समूहमा नमिल्ने शब्द कुन हो?', E'मन्दिर', E'मस्जिद', E'चर्च', E'विद्यालय', E'D', E'विद्यालय शैक्षिक संस्था हो, अन्य सबै धार्मिक स्थल हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:मन्दिर|B:मस्जिद|C:चर्च|D:विद्यालय'), v_set_id, v_q_id, 29)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:माघ|B:आइतबार|C:सोमबार|D:मंगलबार');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 30, E'समूहमा नमिल्ने शब्द कुन हो?', E'माघ', E'आइतबार', E'सोमबार', E'मंगलबार', E'A', E'माघ महिनाको नाम हो, अन्य सबै बारका नाम हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:माघ|B:आइतबार|C:सोमबार|D:मंगलबार'), v_set_id, v_q_id, 30)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  RAISE NOTICE 'fix top-up complete: 42 questions.';
END $$;
