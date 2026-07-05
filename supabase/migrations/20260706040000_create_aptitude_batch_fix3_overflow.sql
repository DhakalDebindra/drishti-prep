-- FIX re-apply: create overflow sets for verbal-1/verbal-3/spatial-4 using a content+options fingerprint.
-- Generated 2026-07-05T13:18:30.190Z.
DO $$
DECLARE
  v_module_id uuid := '6695669a-f40e-421a-a4ec-b09bbeaf56c4'::uuid;
  v_set_id uuid;
  v_q_id uuid;
BEGIN

  -- Set: शाब्दिक बौद्धिक परीक्षणः शब्द ज्ञान - खण्ड 2 (आधारभूत तह) (30 Q)
  v_set_id := extensions.uuid_generate_v5('7d4b6d71-7451-4e67-91fe-5323380a3258'::uuid, E'शाब्दिक बौद्धिक परीक्षणः शब्द ज्ञान - खण्ड 2 (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'efc9184a-c265-4fd8-bb99-aad431aefc58'::uuid, '7d4b6d71-7451-4e67-91fe-5323380a3258'::uuid, E'शाब्दिक बौद्धिक परीक्षणः शब्द ज्ञान - खण्ड 2 (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '7d4b6d71-7451-4e67-91fe-5323380a3258'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''उज्यालो'' को विपरीतार्थक शब्द कुन हो?|A:अँध्यारो|B:घाम|C:छायाँ|D:प्रकाश');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'''उज्यालो'' को विपरीतार्थक शब्द कुन हो?', E'अँध्यारो', E'घाम', E'छायाँ', E'प्रकाश', E'A', E'''उज्यालो'' को उल्टो ''अँध्यारो'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''उज्यालो'' को विपरीतार्थक शब्द कुन हो?|A:अँध्यारो|B:घाम|C:छायाँ|D:प्रकाश'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''सुख'' को विपरीतार्थक शब्द कुन हो?|A:आनन्द|B:दुःख|C:शान्ति|D:खुसी');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'''सुख'' को विपरीतार्थक शब्द कुन हो?', E'आनन्द', E'दुःख', E'शान्ति', E'खुसी', E'B', E'''सुख'' को विपरीत अर्थ ''दुःख'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''सुख'' को विपरीतार्थक शब्द कुन हो?|A:आनन्द|B:दुःख|C:शान्ति|D:खुसी'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''धर्म'' को विपरीतार्थक शब्द कुन हो?|A:पुण्य|B:पाप|C:अधर्म|D:कर्म');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'''धर्म'' को विपरीतार्थक शब्द कुन हो?', E'पुण्य', E'पाप', E'अधर्म', E'कर्म', E'C', E'''धर्म'' को उल्टो ''अधर्म'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''धर्म'' को विपरीतार्थक शब्द कुन हो?|A:पुण्य|B:पाप|C:अधर्म|D:कर्म'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''न्याय'' को विपरीतार्थक शब्द कुन हो?|A:निर्णय|B:सत्य|C:कानुन|D:अन्याय');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'''न्याय'' को विपरीतार्थक शब्द कुन हो?', E'निर्णय', E'सत्य', E'कानुन', E'अन्याय', E'D', E'''न्याय'' को विपरीतार्थक शब्द ''अन्याय'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''न्याय'' को विपरीतार्थक शब्द कुन हो?|A:निर्णय|B:सत्य|C:कानुन|D:अन्याय'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''सत्य'' को विपरीतार्थक शब्द कुन हो?|A:असत्य|B:झुटो|C:साँचो|D:तथ्य');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'''सत्य'' को विपरीतार्थक शब्द कुन हो?', E'असत्य', E'झुटो', E'साँचो', E'तथ्य', E'A', E'सत्यको उल्टो अर्थ ''असत्य'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''सत्य'' को विपरीतार्थक शब्द कुन हो?|A:असत्य|B:झुटो|C:साँचो|D:तथ्य'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''ज्ञान'' को विपरीतार्थक शब्द कुन हो?|A:विज्ञान|B:अज्ञान|C:बुद्धि|D:विवेक');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'''ज्ञान'' को विपरीतार्थक शब्द कुन हो?', E'विज्ञान', E'अज्ञान', E'बुद्धि', E'विवेक', E'B', E'ज्ञानको विपरीतार्थक शब्द ''अज्ञान'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''ज्ञान'' को विपरीतार्थक शब्द कुन हो?|A:विज्ञान|B:अज्ञान|C:बुद्धि|D:विवेक'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''जीवन'' को विपरीतार्थक शब्द कुन हो?|A:जन्म|B:आयु|C:मरण|D:मृत्यु');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'''जीवन'' को विपरीतार्थक शब्द कुन हो?', E'जन्म', E'आयु', E'मरण', E'मृत्यु', E'C', E'''जीवन'' को उल्टो ''मरण'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''जीवन'' को विपरीतार्थक शब्द कुन हो?|A:जन्म|B:आयु|C:मरण|D:मृत्यु'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''लाभ'' को विपरीतार्थक शब्द कुन हो?|A:फाइदा|B:नाफा|C:नोक्सान|D:हानि');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'''लाभ'' को विपरीतार्थक शब्द कुन हो?', E'फाइदा', E'नाफा', E'नोक्सान', E'हानि', E'D', E'''लाभ'' को विपरीतार्थक शब्द ''हानि'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''लाभ'' को विपरीतार्थक शब्द कुन हो?|A:फाइदा|B:नाफा|C:नोक्सान|D:हानि'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''जय'' को विपरीतार्थक शब्द कुन हो?|A:पराजय|B:विजय|C:हार|D:जित');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'''जय'' को विपरीतार्थक शब्द कुन हो?', E'पराजय', E'विजय', E'हार', E'जित', E'A', E'जयको उल्टो ''पराजय'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''जय'' को विपरीतार्थक शब्द कुन हो?|A:पराजय|B:विजय|C:हार|D:जित'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''मान'' को विपरीतार्थक शब्द कुन हो?|A:सम्मान|B:अपमान|C:आदर|D:गौरव');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'''मान'' को विपरीतार्थक शब्द कुन हो?', E'सम्मान', E'अपमान', E'आदर', E'गौरव', E'B', E'''मान'' को विपरीतार्थक शब्द ''अपमान'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''मान'' को विपरीतार्थक शब्द कुन हो?|A:सम्मान|B:अपमान|C:आदर|D:गौरव'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''मित्र'' को विपरीतार्थक शब्द कुन हो?|A:साथी|B:सखा|C:शत्रु|D:दुश्मन');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'''मित्र'' को विपरीतार्थक शब्द कुन हो?', E'साथी', E'सखा', E'शत्रु', E'दुश्मन', E'C', E'मित्रको उल्टो ''शत्रु'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''मित्र'' को विपरीतार्थक शब्द कुन हो?|A:साथी|B:सखा|C:शत्रु|D:दुश्मन'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''स्वर्ग'' को विपरीतार्थक शब्द कुन हो?|A:पाताल|B:मर्त्य|C:लोक|D:नर्क');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'''स्वर्ग'' को विपरीतार्थक शब्द कुन हो?', E'पाताल', E'मर्त्य', E'लोक', E'नर्क', E'D', E'स्वर्गको उल्टो ''नर्क'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''स्वर्ग'' को विपरीतार्थक शब्द कुन हो?|A:पाताल|B:मर्त्य|C:लोक|D:नर्क'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''पाप'' को विपरीतार्थक शब्द कुन हो?|A:पुण्य|B:धर्म|C:कर्म|D:अधर्म');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'''पाप'' को विपरीतार्थक शब्द कुन हो?', E'पुण्य', E'धर्म', E'कर्म', E'अधर्म', E'A', E'''पाप'' को विपरीतार्थक शब्द ''पुण्य'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''पाप'' को विपरीतार्थक शब्द कुन हो?|A:पुण्य|B:धर्म|C:कर्म|D:अधर्म'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''आशा'' को विपरीतार्थक शब्द कुन हो?|A:भरोसा|B:निराशा|C:इच्छा|D:चाहना');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'''आशा'' को विपरीतार्थक शब्द कुन हो?', E'भरोसा', E'निराशा', E'इच्छा', E'चाहना', E'B', E'आशाको उल्टो ''निराशा'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''आशा'' को विपरीतार्थक शब्द कुन हो?|A:भरोसा|B:निराशा|C:इच्छा|D:चाहना'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''धनी'' को विपरीतार्थक शब्द कुन हो?|A:सम्पन्न|B:निर्धन|C:गरिब|D:भिखारी');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'''धनी'' को विपरीतार्थक शब्द कुन हो?', E'सम्पन्न', E'निर्धन', E'गरिब', E'भिखारी', E'C', E'''धनी'' को विपरीत अर्थ ''गरिब'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''धनी'' को विपरीतार्थक शब्द कुन हो?|A:सम्पन्न|B:निर्धन|C:गरिब|D:भिखारी'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''भारी'' को विपरीतार्थक शब्द कुन हो?|A:गहु्रङ्गो|B:तौल|C:वजन|D:हलुका');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'''भारी'' को विपरीतार्थक शब्द कुन हो?', E'गहु्रङ्गो', E'तौल', E'वजन', E'हलुका', E'D', E'''भारी'' को उल्टो ''हलुका'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''भारी'' को विपरीतार्थक शब्द कुन हो?|A:गहु्रङ्गो|B:तौल|C:वजन|D:हलुका'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''राम्रो'' को विपरीतार्थक शब्द कुन हो?|A:नराम्रो|B:सुन्दर|C:असल|D:खराब');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'''राम्रो'' को विपरीतार्थक शब्द कुन हो?', E'नराम्रो', E'सुन्दर', E'असल', E'खराब', E'A', E'राम्रोको उल्टो ''नराम्रो'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''राम्रो'' को विपरीतार्थक शब्द कुन हो?|A:नराम्रो|B:सुन्दर|C:असल|D:खराब'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''सानो'' को विपरीतार्थक शब्द कुन हो?|A:विशाल|B:ठूलो|C:कनिष्ठ|D:क्षुद्र');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'''सानो'' को विपरीतार्थक शब्द कुन हो?', E'विशाल', E'ठूलो', E'कनिष्ठ', E'क्षुद्र', E'B', E'''सानो'' को विपरीत अर्थ ''ठूलो'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''सानो'' को विपरीतार्थक शब्द कुन हो?|A:विशाल|B:ठूलो|C:कनिष्ठ|D:क्षुद्र'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''कालो'' को विपरीतार्थक शब्द कुन हो?|A:श्याम|B:रङ्गीन|C:सेतो|D:नीलो');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'''कालो'' को विपरीतार्थक शब्द कुन हो?', E'श्याम', E'रङ्गीन', E'सेतो', E'नीलो', E'C', E'''कालो'' को उल्टो ''सेतो'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''कालो'' को विपरीतार्थक शब्द कुन हो?|A:श्याम|B:रङ्गीन|C:सेतो|D:नीलो'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''अकिञ्चन'' शब्दको अर्थ के हो?|A:धनी|B:विद्वान|C:मूर्ख|D:गरिब');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 20, E'''अकिञ्चन'' शब्दको अर्थ के हो?', E'धनी', E'विद्वान', E'मूर्ख', E'गरिब', E'D', E'''अकिञ्चन'' भन्नाले केही नभएको वा ''गरिब'' लाई बुझाउँछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''अकिञ्चन'' शब्दको अर्थ के हो?|A:धनी|B:विद्वान|C:मूर्ख|D:गरिब'), v_set_id, v_q_id, 20)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''अगम'' शब्दको अर्थ के हो?|A:पुग्न नसकिने|B:सजिलै पुगिने|C:नजिकको|D:टाढाको');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 21, E'''अगम'' शब्दको अर्थ के हो?', E'पुग्न नसकिने', E'सजिलै पुगिने', E'नजिकको', E'टाढाको', E'A', E'जहाँ पुग्न सकिँदैन, त्यसलाई ''अगम'' भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''अगम'' शब्दको अर्थ के हो?|A:पुग्न नसकिने|B:सजिलै पुगिने|C:नजिकको|D:टाढाको'), v_set_id, v_q_id, 21)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''अघोर'' शब्दको अर्थ के हो?|A:थोरै|B:धेरै|C:ठिक्क|D:कम');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 22, E'''अघोर'' शब्दको अर्थ के हो?', E'थोरै', E'धेरै', E'ठिक्क', E'कम', E'B', E'''अघोर'' भन्नाले ज्यादै वा ''धेरै'' भन्ने बुझिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''अघोर'' शब्दको अर्थ के हो?|A:थोरै|B:धेरै|C:ठिक्क|D:कम'), v_set_id, v_q_id, 22)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''अचाक्ली'' शब्दको अर्थ के हो?|A:कम|B:सामान्य|C:ज्यादै|D:अलिअलि');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 23, E'''अचाक्ली'' शब्दको अर्थ के हो?', E'कम', E'सामान्य', E'ज्यादै', E'अलिअलि', E'C', E'''अचाक्ली'' को अर्थ ''ज्यादै'' वा ''हदैसम्म'' भन्ने हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''अचाक्ली'' शब्दको अर्थ के हो?|A:कम|B:सामान्य|C:ज्यादै|D:अलिअलि'), v_set_id, v_q_id, 23)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''अठोट'' शब्दको अर्थ के हो?|A:दुविधा|B:विचार|C:सल्लाह|D:निश्चय');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 24, E'''अठोट'' शब्दको अर्थ के हो?', E'दुविधा', E'विचार', E'सल्लाह', E'निश्चय', E'D', E'''अठोट'' भन्नाले पक्का ''निश्चय'' वा दृढ सङ्कल्पलाई बुझाउँछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''अठोट'' शब्दको अर्थ के हो?|A:दुविधा|B:विचार|C:सल्लाह|D:निश्चय'), v_set_id, v_q_id, 24)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''अतीत'' शब्दको अर्थ के हो?|A:बितेको समय|B:आउने समय|C:वर्तमान|D:भविष्य');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 25, E'''अतीत'' शब्दको अर्थ के हो?', E'बितेको समय', E'आउने समय', E'वर्तमान', E'भविष्य', E'A', E'''अतीत'' भन्नाले भूतकाल वा ''बितेको समय'' बुझिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''अतीत'' शब्दको अर्थ के हो?|A:बितेको समय|B:आउने समय|C:वर्तमान|D:भविष्य'), v_set_id, v_q_id, 25)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''अतुल'' शब्दको अर्थ के हो?|A:तुलना गर्न सकिने|B:तुलना गर्न नसकिने|C:समान|D:फरक');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 26, E'''अतुल'' शब्दको अर्थ के हो?', E'तुलना गर्न सकिने', E'तुलना गर्न नसकिने', E'समान', E'फरक', E'B', E'जसको तुलना हुँदैन, त्यसलाई ''अतुल'' भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''अतुल'' शब्दको अर्थ के हो?|A:तुलना गर्न सकिने|B:तुलना गर्न नसकिने|C:समान|D:फरक'), v_set_id, v_q_id, 26)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''अदम्य'' शब्दको अर्थ के हो?|A:सजिलै दबिने|B:कमजोर|C:दबाउन नसकिने|D:डरपोक');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 27, E'''अदम्य'' शब्दको अर्थ के हो?', E'सजिलै दबिने', E'कमजोर', E'दबाउन नसकिने', E'डरपोक', E'C', E'जसलाई दबाउन सकिँदैन, त्यसलाई ''अदम्य'' भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''अदम्य'' शब्दको अर्थ के हो?|A:सजिलै दबिने|B:कमजोर|C:दबाउन नसकिने|D:डरपोक'), v_set_id, v_q_id, 27)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''अनन्त'' शब्दको अर्थ के हो?|A:अन्त भएको|B:सुरुवात|C:मध्य|D:अन्त नभएको');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 28, E'''अनन्त'' शब्दको अर्थ के हो?', E'अन्त भएको', E'सुरुवात', E'मध्य', E'अन्त नभएको', E'D', E'जसको अन्त छैन, त्यसलाई ''अनन्त'' भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''अनन्त'' शब्दको अर्थ के हो?|A:अन्त भएको|B:सुरुवात|C:मध्य|D:अन्त नभएको'), v_set_id, v_q_id, 28)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''अनाहक'' शब्दको अर्थ के हो?|A:विना कारण|B:कारणसहित|C:प्रयोजन|D:उद्देश्य');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 29, E'''अनाहक'' शब्दको अर्थ के हो?', E'विना कारण', E'कारणसहित', E'प्रयोजन', E'उद्देश्य', E'A', E'''अनाहक'' भन्नाले ''विना कारण'' वा व्यर्थमा भन्ने बुझिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''अनाहक'' शब्दको अर्थ के हो?|A:विना कारण|B:कारणसहित|C:प्रयोजन|D:उद्देश्य'), v_set_id, v_q_id, 29)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''अनुज'' शब्दको अर्थ के हो?|A:जेठो दाइ|B:कान्छो भाइ|C:दिदी|D:बहिनी');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 30, E'''अनुज'' शब्दको अर्थ के हो?', E'जेठो दाइ', E'कान्छो भाइ', E'दिदी', E'बहिनी', E'B', E'''अनुज'' भन्नाले आफूभन्दा पछि जन्मेको ''कान्छो भाइ'' लाई बुझाउँछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''अनुज'' शब्दको अर्थ के हो?|A:जेठो दाइ|B:कान्छो भाइ|C:दिदी|D:बहिनी'), v_set_id, v_q_id, 30)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: शाब्दिक बौद्धिक परीक्षणः शब्द ज्ञान - खण्ड 3 (आधारभूत तह) (30 Q)
  v_set_id := extensions.uuid_generate_v5('7d4b6d71-7451-4e67-91fe-5323380a3258'::uuid, E'शाब्दिक बौद्धिक परीक्षणः शब्द ज्ञान - खण्ड 3 (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'efc9184a-c265-4fd8-bb99-aad431aefc58'::uuid, '7d4b6d71-7451-4e67-91fe-5323380a3258'::uuid, E'शाब्दिक बौद्धिक परीक्षणः शब्द ज्ञान - खण्ड 3 (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '7d4b6d71-7451-4e67-91fe-5323380a3258'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''अनुपम'' शब्दको अर्थ के हो?|A:उपमा दिन नसकिने|B:उपमा दिन मिल्ने|C:सामान्य|D:साधारण');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'''अनुपम'' शब्दको अर्थ के हो?', E'उपमा दिन नसकिने', E'उपमा दिन मिल्ने', E'सामान्य', E'साधारण', E'A', E'जसको उपमा दिन सकिँदैन, त्यसलाई ''अनुपम'' भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''अनुपम'' शब्दको अर्थ के हो?|A:उपमा दिन नसकिने|B:उपमा दिन मिल्ने|C:सामान्य|D:साधारण'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''अभिमान'' शब्दको अर्थ के हो?|A:स्वाभिमान|B:घमण्ड|C:आदर|D:सम्मान');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'''अभिमान'' शब्दको अर्थ के हो?', E'स्वाभिमान', E'घमण्ड', E'आदर', E'सम्मान', E'B', E'''अभिमान'' भन्नाले ''घमण्ड'' वा अहङ्कारलाई बुझाउँछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''अभिमान'' शब्दको अर्थ के हो?|A:स्वाभिमान|B:घमण्ड|C:आदर|D:सम्मान'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''अरण्य'' शब्दको अर्थ के हो?|A:सहर|B:गाउँ|C:जङ्गल|D:मरुभूमि');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'''अरण्य'' शब्दको अर्थ के हो?', E'सहर', E'गाउँ', E'जङ्गल', E'मरुभूमि', E'C', E'''अरण्य'' भन्नाले ''जङ्गल'' वा वनलाई बुझाउँछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''अरण्य'' शब्दको अर्थ के हो?|A:सहर|B:गाउँ|C:जङ्गल|D:मरुभूमि'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''अवशेष'' शब्दको अर्थ के हो?|A:सुरुको|B:पूर्ण|C:नयाँ|D:बाँकी रहेको');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'''अवशेष'' शब्दको अर्थ के हो?', E'सुरुको', E'पूर्ण', E'नयाँ', E'बाँकी रहेको', E'D', E'''अवशेष'' भन्नाले ''बाँकी रहेको'' अंश भन्ने बुझिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''अवशेष'' शब्दको अर्थ के हो?|A:सुरुको|B:पूर्ण|C:नयाँ|D:बाँकी रहेको'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''असीम'' शब्दको अर्थ के हो?|A:सीमा नभएको|B:सीमा भएको|C:थोरै|D:साँघुरो');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'''असीम'' शब्दको अर्थ के हो?', E'सीमा नभएको', E'सीमा भएको', E'थोरै', E'साँघुरो', E'A', E'जसको सीमा छैन, त्यसलाई ''असीम'' भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''असीम'' शब्दको अर्थ के हो?|A:सीमा नभएको|B:सीमा भएको|C:थोरै|D:साँघुरो'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''आकर्षण'' शब्दको अर्थ के हो?|A:धकेल्ने शक्ति|B:तान्ने शक्ति|C:विकर्षण|D:दूरी');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'''आकर्षण'' शब्दको अर्थ के हो?', E'धकेल्ने शक्ति', E'तान्ने शक्ति', E'विकर्षण', E'दूरी', E'B', E'''आकर्षण'' भन्नाले आफूतिर ''तान्ने शक्ति'' लाई बुझाउँछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''आकर्षण'' शब्दको अर्थ के हो?|A:धकेल्ने शक्ति|B:तान्ने शक्ति|C:विकर्षण|D:दूरी'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''आविष्कार'' शब्दको अर्थ के हो?|A:पुरानो कुरा|B:चोरी|C:नयाँ कुरा पत्ता लगाउने काम|D:नक्कल');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'''आविष्कार'' शब्दको अर्थ के हो?', E'पुरानो कुरा', E'चोरी', E'नयाँ कुरा पत्ता लगाउने काम', E'नक्कल', E'C', E'नयाँ कुराको सिर्जना वा खोजीलाई ''आविष्कार'' भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''आविष्कार'' शब्दको अर्थ के हो?|A:पुरानो कुरा|B:चोरी|C:नयाँ कुरा पत्ता लगाउने काम|D:नक्कल'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''उत्साह'' शब्दको अर्थ के हो?|A:अल्छीपन|B:थकाइ|C:निराशा|D:काम गर्ने जाँगर');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'''उत्साह'' शब्दको अर्थ के हो?', E'अल्छीपन', E'थकाइ', E'निराशा', E'काम गर्ने जाँगर', E'D', E'कुनै काम गर्ने उमङ्ग वा ''जाँगर'' लाई ''उत्साह'' भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''उत्साह'' शब्दको अर्थ के हो?|A:अल्छीपन|B:थकाइ|C:निराशा|D:काम गर्ने जाँगर'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कहिल्यै नमर्नेलाई एक शब्दमा के भनिन्छ?|A:अमर|B:मृत्युञ्जय|C:अजर|D:अविनाशी');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'कहिल्यै नमर्नेलाई एक शब्दमा के भनिन्छ?', E'अमर', E'मृत्युञ्जय', E'अजर', E'अविनाशी', E'A', E'कहिल्यै मृत्यु नहुनेलाई ''अमर'' भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कहिल्यै नमर्नेलाई एक शब्दमा के भनिन्छ?|A:अमर|B:मृत्युञ्जय|C:अजर|D:अविनाशी'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सबै कुरा जान्नेलाई एक शब्दमा के भनिन्छ?|A:अल्पज्ञ|B:सर्वज्ञ|C:विद्वान|D:मूर्ख');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'सबै कुरा जान्नेलाई एक शब्दमा के भनिन्छ?', E'अल्पज्ञ', E'सर्वज्ञ', E'विद्वान', E'मूर्ख', E'B', E'सबै कुराको ज्ञान भएको व्यक्तिलाई ''सर्वज्ञ'' भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सबै कुरा जान्नेलाई एक शब्दमा के भनिन्छ?|A:अल्पज्ञ|B:सर्वज्ञ|C:विद्वान|D:मूर्ख'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कम बोल्ने व्यक्तिलाई एक शब्दमा के भनिन्छ?|A:वाचाल|B:बहुभाषी|C:मितभाषी|D:मौन');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'कम बोल्ने व्यक्तिलाई एक शब्दमा के भनिन्छ?', E'वाचाल', E'बहुभाषी', E'मितभाषी', E'मौन', E'C', E'थोरै वा चाहिने जति मात्र बोल्नेलाई ''मितभाषी'' भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कम बोल्ने व्यक्तिलाई एक शब्दमा के भनिन्छ?|A:वाचाल|B:बहुभाषी|C:मितभाषी|D:मौन'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'जसको शत्रु जन्मेको छैन, उसलाई के भनिन्छ?|A:मित्र|B:शत्रुघ्न|C:अजेय|D:अजातशत्रु');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'जसको शत्रु जन्मेको छैन, उसलाई के भनिन्छ?', E'मित्र', E'शत्रुघ्न', E'अजेय', E'अजातशत्रु', E'D', E'कुनै शत्रु नभएको व्यक्तिलाई ''अजातशत्रु'' भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:जसको शत्रु जन्मेको छैन, उसलाई के भनिन्छ?|A:मित्र|B:शत्रुघ्न|C:अजेय|D:अजातशत्रु'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'आकाशमा उड्ने प्राणीलाई के भनिन्छ?|A:नभचर|B:जलचर|C:थलचर|D:उभयचर');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'आकाशमा उड्ने प्राणीलाई के भनिन्छ?', E'नभचर', E'जलचर', E'थलचर', E'उभयचर', E'A', E'आकाश (नभ) मा विचरण गर्नेलाई ''नभचर'' भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:आकाशमा उड्ने प्राणीलाई के भनिन्छ?|A:नभचर|B:जलचर|C:थलचर|D:उभयचर'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पानीमा बस्ने प्राणीलाई के भनिन्छ?|A:थलचर|B:जलचर|C:नभचर|D:निशाचर');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'पानीमा बस्ने प्राणीलाई के भनिन्छ?', E'थलचर', E'जलचर', E'नभचर', E'निशाचर', E'B', E'पानी (जल) मा बस्नेलाई ''जलचर'' भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पानीमा बस्ने प्राणीलाई के भनिन्छ?|A:थलचर|B:जलचर|C:नभचर|D:निशाचर'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'जमिनमा बस्ने प्राणीलाई के भनिन्छ?|A:जलचर|B:नभचर|C:थलचर|D:उभयचर');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'जमिनमा बस्ने प्राणीलाई के भनिन्छ?', E'जलचर', E'नभचर', E'थलचर', E'उभयचर', E'C', E'जमिन (थल) मा बस्नेलाई ''थलचर'' भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:जमिनमा बस्ने प्राणीलाई के भनिन्छ?|A:जलचर|B:नभचर|C:थलचर|D:उभयचर'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'राति हिँड्ने प्राणीलाई के भनिन्छ?|A:दिनचर|B:जलचर|C:थलचर|D:निशाचर');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'राति हिँड्ने प्राणीलाई के भनिन्छ?', E'दिनचर', E'जलचर', E'थलचर', E'निशाचर', E'D', E'राति (निशा) विचरण गर्नेलाई ''निशाचर'' भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:राति हिँड्ने प्राणीलाई के भनिन्छ?|A:दिनचर|B:जलचर|C:थलचर|D:निशाचर'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'मासु मात्र खाने प्राणीलाई के भनिन्छ?|A:मांसाहारी|B:शाकाहारी|C:सर्वाहारी|D:फलाहारी');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'मासु मात्र खाने प्राणीलाई के भनिन्छ?', E'मांसाहारी', E'शाकाहारी', E'सर्वाहारी', E'फलाहारी', E'A', E'मासु आहार गर्नेलाई ''मांसाहारी'' भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:मासु मात्र खाने प्राणीलाई के भनिन्छ?|A:मांसाहारी|B:शाकाहारी|C:सर्वाहारी|D:फलाहारी'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सागपात खाने प्राणीलाई के भनिन्छ?|A:मांसाहारी|B:शाकाहारी|C:सर्वाहारी|D:फलाहारी');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'सागपात खाने प्राणीलाई के भनिन्छ?', E'मांसाहारी', E'शाकाहारी', E'सर्वाहारी', E'फलाहारी', E'B', E'सागपात वा वनस्पति आहार गर्नेलाई ''शाकाहारी'' भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सागपात खाने प्राणीलाई के भनिन्छ?|A:मांसाहारी|B:शाकाहारी|C:सर्वाहारी|D:फलाहारी'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'अरूले गरेको उपकार मान्ने व्यक्तिलाई के भनिन्छ?|A:कृतघ्न|B:परोपकारी|C:कृतज्ञ|D:स्वार्थी');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'अरूले गरेको उपकार मान्ने व्यक्तिलाई के भनिन्छ?', E'कृतघ्न', E'परोपकारी', E'कृतज्ञ', E'स्वार्थी', E'C', E'लगाएको गुन वा उपकार मान्नेलाई ''कृतज्ञ'' भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:अरूले गरेको उपकार मान्ने व्यक्तिलाई के भनिन्छ?|A:कृतघ्न|B:परोपकारी|C:कृतज्ञ|D:स्वार्थी'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'अरूले गरेको उपकार नमान्ने व्यक्तिलाई के भनिन्छ?|A:कृतज्ञ|B:उपकारी|C:अहङ्कारी|D:कृतघ्न');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 20, E'अरूले गरेको उपकार नमान्ने व्यक्तिलाई के भनिन्छ?', E'कृतज्ञ', E'उपकारी', E'अहङ्कारी', E'कृतघ्न', E'D', E'लगाएको गुन बिर्सने वा नमान्नेलाई ''कृतघ्न'' भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:अरूले गरेको उपकार नमान्ने व्यक्तिलाई के भनिन्छ?|A:कृतज्ञ|B:उपकारी|C:अहङ्कारी|D:कृतघ्न'), v_set_id, v_q_id, 20)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'जसको पार पाउन सकिँदैन, त्यसलाई के भनिन्छ?|A:अथाह|B:पारदर्शी|C:अगम|D:अपार');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 21, E'जसको पार पाउन सकिँदैन, त्यसलाई के भनिन्छ?', E'अथाह', E'पारदर्शी', E'अगम', E'अपार', E'A', E'''जसको पार (अन्त) पाउन सकिँदैन'' भन्ने भाव दिने शब्द ''अथाह'' हो (अपार भनेको विशाल/असीम हुन्छ, यो ठ्याक्कै ''end-reaching'' भावलाई जनाउँदैन)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:जसको पार पाउन सकिँदैन, त्यसलाई के भनिन्छ?|A:अथाह|B:पारदर्शी|C:अगम|D:अपार'), v_set_id, v_q_id, 21)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'जसको वर्णन गर्न सकिँदैन, त्यसलाई के भनिन्छ?|A:वर्णनीय|B:अवर्णनीय|C:अतुलनीय|D:कथनीय');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 22, E'जसको वर्णन गर्न सकिँदैन, त्यसलाई के भनिन्छ?', E'वर्णनीय', E'अवर्णनीय', E'अतुलनीय', E'कथनीय', E'B', E'वर्णन गर्न नसकिनेलाई ''अवर्णनीय'' भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:जसको वर्णन गर्न सकिँदैन, त्यसलाई के भनिन्छ?|A:वर्णनीय|B:अवर्णनीय|C:अतुलनीय|D:कथनीय'), v_set_id, v_q_id, 22)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'जो कहिल्यै बुढो हुँदैन, उसलाई के भनिन्छ?|A:अमर|B:युवा|C:अजर|D:किशोर');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 23, E'जो कहिल्यै बुढो हुँदैन, उसलाई के भनिन्छ?', E'अमर', E'युवा', E'अजर', E'किशोर', E'C', E'बुढ्यौली नआउनेलाई ''अजर'' भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:जो कहिल्यै बुढो हुँदैन, उसलाई के भनिन्छ?|A:अमर|B:युवा|C:अजर|D:किशोर'), v_set_id, v_q_id, 23)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'आँखाले देख्न नसकिने कुरालाई के भनिन्छ?|A:दृश्य|B:पारदर्शी|C:अपारदर्शी|D:अदृश्य');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 24, E'आँखाले देख्न नसकिने कुरालाई के भनिन्छ?', E'दृश्य', E'पारदर्शी', E'अपारदर्शी', E'अदृश्य', E'D', E'देख्न नसकिनेलाई ''अदृश्य'' भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:आँखाले देख्न नसकिने कुरालाई के भनिन्छ?|A:दृश्य|B:पारदर्शी|C:अपारदर्शी|D:अदृश्य'), v_set_id, v_q_id, 24)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कानले सुन्न नसकिने कुरालाई के भनिन्छ?|A:अश्राव्य|B:श्राव्य|C:मधुर|D:कर्कश');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 25, E'कानले सुन्न नसकिने कुरालाई के भनिन्छ?', E'अश्राव्य', E'श्राव्य', E'मधुर', E'कर्कश', E'A', E'सुन्न नसकिनेलाई ''अश्राव्य'' भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कानले सुन्न नसकिने कुरालाई के भनिन्छ?|A:अश्राव्य|B:श्राव्य|C:मधुर|D:कर्कश'), v_set_id, v_q_id, 25)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'गर्न नहुने कामलाई के भनिन्छ?|A:कार्य|B:अकार्य|C:सत्कर्म|D:कुकर्म');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 26, E'गर्न नहुने कामलाई के भनिन्छ?', E'कार्य', E'अकार्य', E'सत्कर्म', E'कुकर्म', E'B', E'गर्न अयोग्य कामलाई ''अकार्य'' भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:गर्न नहुने कामलाई के भनिन्छ?|A:कार्य|B:अकार्य|C:सत्कर्म|D:कुकर्म'), v_set_id, v_q_id, 26)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'जान्न योग्य कुरालाई के भनिन्छ?|A:अज्ञात|B:गोप्य|C:ज्ञातव्य|D:रहस्य');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 27, E'जान्न योग्य कुरालाई के भनिन्छ?', E'अज्ञात', E'गोप्य', E'ज्ञातव्य', E'रहस्य', E'C', E'जान्नुपर्ने वा जान्न योग्यलाई ''ज्ञातव्य'' भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:जान्न योग्य कुरालाई के भनिन्छ?|A:अज्ञात|B:गोप्य|C:ज्ञातव्य|D:रहस्य'), v_set_id, v_q_id, 27)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समाजसँग सम्बन्धित कुरालाई के भनिन्छ?|A:पारिवारिक|B:व्यक्तिगत|C:राष्ट्रिय|D:सामाजिक');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 28, E'समाजसँग सम्बन्धित कुरालाई के भनिन्छ?', E'पारिवारिक', E'व्यक्तिगत', E'राष्ट्रिय', E'सामाजिक', E'D', E'समाजसँग सम्बन्ध राख्नेलाई ''सामाजिक'' भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समाजसँग सम्बन्धित कुरालाई के भनिन्छ?|A:पारिवारिक|B:व्यक्तिगत|C:राष्ट्रिय|D:सामाजिक'), v_set_id, v_q_id, 28)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन शब्दको हिज्जे शुद्ध छ?|A:आशीर्वाद|B:आशिर्वाद|C:आशीर्बाद|D:आशिर्बाद');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 29, E'तलका मध्ये कुन शब्दको हिज्जे शुद्ध छ?', E'आशीर्वाद', E'आशिर्वाद', E'आशीर्बाद', E'आशिर्बाद', E'A', E'''आशीर्वाद'' शब्द शुद्ध हो, जसमा ''श'' मा दीर्घ ''ी'' र ''व'' को माथि रेफ हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन शब्दको हिज्जे शुद्ध छ?|A:आशीर्वाद|B:आशिर्वाद|C:आशीर्बाद|D:आशिर्बाद'), v_set_id, v_q_id, 29)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन शब्द शुद्ध छ?|A:उज्वल|B:उज्ज्वल|C:उज्वोल|D:उज्जोल');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 30, E'तलका मध्ये कुन शब्द शुद्ध छ?', E'उज्वल', E'उज्ज्वल', E'उज्वोल', E'उज्जोल', E'B', E'''उज्ज्वल'' शुद्ध हो, जसमा दुईवटा आधा ''ज'' हुन्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन शब्द शुद्ध छ?|A:उज्वल|B:उज्ज्वल|C:उज्वोल|D:उज्जोल'), v_set_id, v_q_id, 30)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: शाब्दिक बौद्धिक परीक्षणः शब्द ज्ञान - खण्ड 4 (आधारभूत तह) (18 Q)
  v_set_id := extensions.uuid_generate_v5('7d4b6d71-7451-4e67-91fe-5323380a3258'::uuid, E'शाब्दिक बौद्धिक परीक्षणः शब्द ज्ञान - खण्ड 4 (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'efc9184a-c265-4fd8-bb99-aad431aefc58'::uuid, '7d4b6d71-7451-4e67-91fe-5323380a3258'::uuid, E'शाब्दिक बौद्धिक परीक्षणः शब्द ज्ञान - खण्ड 4 (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '7d4b6d71-7451-4e67-91fe-5323380a3258'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन शब्द शुद्ध छ?|A:विद्यार्थी|B:बिद्यार्थी|C:विद्यार्ति|D:बिद्यार्ति');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'तलका मध्ये कुन शब्द शुद्ध छ?', E'विद्यार्थी', E'बिद्यार्थी', E'विद्यार्ति', E'बिद्यार्ति', E'A', E'''विद्यार्थी'' शुद्ध शब्द हो जसमा ''व'' र ''थ'' मा दीर्घ ''ी'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन शब्द शुद्ध छ?|A:विद्यार्थी|B:बिद्यार्थी|C:विद्यार्ति|D:बिद्यार्ति'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन शब्द शुद्ध छ?|A:एतिहासिक|B:ऐतिहासिक|C:ऐतिहासीक|D:एतिहासीक');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'तलका मध्ये कुन शब्द शुद्ध छ?', E'एतिहासिक', E'ऐतिहासिक', E'ऐतिहासीक', E'एतिहासीक', E'B', E'''इतिहास'' मा ''इक'' प्रत्यय लागेर ''ऐतिहासिक'' बन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन शब्द शुद्ध छ?|A:एतिहासिक|B:ऐतिहासिक|C:ऐतिहासीक|D:एतिहासीक'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन शब्द शुद्ध छ?|A:भोगोलिक|B:भौगोलीक|C:भौगोलिक|D:भोगोलीक');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'तलका मध्ये कुन शब्द शुद्ध छ?', E'भोगोलिक', E'भौगोलीक', E'भौगोलिक', E'भोगोलीक', E'C', E'''भूगोल'' मा ''इक'' प्रत्यय लागेर ''भौगोलिक'' बन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन शब्द शुद्ध छ?|A:भोगोलिक|B:भौगोलीक|C:भौगोलिक|D:भोगोलीक'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन शब्द शुद्ध छ?|A:शारीरीक|B:शारिरिक|C:सारिरिक|D:शारीरिक');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'तलका मध्ये कुन शब्द शुद्ध छ?', E'शारीरीक', E'शारिरिक', E'सारिरिक', E'शारीरिक', E'D', E'''शरीर'' मा ''इक'' प्रत्यय लागेर ''श शारीरिक'' बन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन शब्द शुद्ध छ?|A:शारीरीक|B:शारिरिक|C:सारिरिक|D:शारीरिक'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन शब्द शुद्ध छ?|A:परिस्थिति|B:परिस्थिती|C:परीस्थिति|D:परीस्थिती');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'तलका मध्ये कुन शब्द शुद्ध छ?', E'परिस्थिति', E'परिस्थिती', E'परीस्थिति', E'परीस्थिती', E'A', E'''परिस्थिति'' मा ''र'' र ''त'' दुवैमा ह्रस्व ''ि'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन शब्द शुद्ध छ?|A:परिस्थिति|B:परिस्थिती|C:परीस्थिति|D:परीस्थिती'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन शब्द शुद्ध छ?|A:परिक्षा|B:परीक्षा|C:परिकक्षा|D:परीक्छा');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'तलका मध्ये कुन शब्द शुद्ध छ?', E'परिक्षा', E'परीक्षा', E'परिकक्षा', E'परीक्छा', E'B', E'''परीक्षा'' शब्दमा ''र'' मा दीर्घ ''ी'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन शब्द शुद्ध छ?|A:परिक्षा|B:परीक्षा|C:परिकक्षा|D:परीक्छा'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन शब्द शुद्ध छ?|A:पुरुस्कार|B:पुु्रस्कार|C:पुरस्कार|D:पुुरूसकार');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'तलका मध्ये कुन शब्द शुद्ध छ?', E'पुरुस्कार', E'पुु्रस्कार', E'पुरस्कार', E'पुुरूसकार', E'C', E'''पुरस्कार'' शब्दमा आधा ''स'' र ''क'' हुन्छ, ''रु'' हुँदैन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन शब्द शुद्ध छ?|A:पुरुस्कार|B:पुु्रस्कार|C:पुरस्कार|D:पुुरूसकार'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन शब्द शुद्ध छ?|A:महत्व|B:महत्तो|C:माहत्व|D:महत्त्व');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'तलका मध्ये कुन शब्द शुद्ध छ?', E'महत्व', E'महत्तो', E'माहत्व', E'महत्त्व', E'D', E'''महत्त्व'' शब्दमा दुईवटा आधा ''त'' मिलेर बनेको हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन शब्द शुद्ध छ?|A:महत्व|B:महत्तो|C:माहत्व|D:महत्त्व'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन शब्द शुद्ध छ?|A:साहित्यिक|B:साहित्तीक|C:साहित्यीक|D:साहित्तिक');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'तलका मध्ये कुन शब्द शुद्ध छ?', E'साहित्यिक', E'साहित्तीक', E'साहित्यीक', E'साहित्तिक', E'A', E'''साहित्य'' मा ''इक'' प्रत्यय लागेर ''साहित्यिक'' बन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन शब्द शुद्ध छ?|A:साहित्यिक|B:साहित्तीक|C:साहित्यीक|D:साहित्तिक'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन शब्द शुद्ध छ?|A:मनोबैज्ञानिक|B:मनोवैज्ञानिक|C:मनोवेज्ञानिक|D:मनोविज्ञानिक');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'तलका मध्ये कुन शब्द शुद्ध छ?', E'मनोबैज्ञानिक', E'मनोवैज्ञानिक', E'मनोवेज्ञानिक', E'मनोविज्ञानिक', E'B', E'''मनोविज्ञान'' बाट ''मनोवैज्ञानिक'' बन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन शब्द शुद्ध छ?|A:मनोबैज्ञानिक|B:मनोवैज्ञानिक|C:मनोवेज्ञानिक|D:मनोविज्ञानिक'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन शब्द शुद्ध छ?|A:ओद्योगिक|B:औद्योगीक|C:औद्योगिक|D:अौधोगिक');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'तलका मध्ये कुन शब्द शुद्ध छ?', E'ओद्योगिक', E'औद्योगीक', E'औद्योगिक', E'अौधोगिक', E'C', E'''उद्योग'' मा ''इक'' प्रत्यय लागेर ''औद्योगिक'' बन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन शब्द शुद्ध छ?|A:ओद्योगिक|B:औद्योगीक|C:औद्योगिक|D:अौधोगिक'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन शब्द शुद्ध छ?|A:दृष्टीकोण|B:दृष्ट्रिकोण|C:दृस्टीकोण|D:दृष्टिकोण');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'तलका मध्ये कुन शब्द शुद्ध छ?', E'दृष्टीकोण', E'दृष्ट्रिकोण', E'दृस्टीकोण', E'दृष्टिकोण', E'D', E'''दृष्टि'' शब्दमा ह्रस्व ''ि'' हुन्छ, त्यसैले ''दृष्टिकोण'' शुद्ध हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन शब्द शुद्ध छ?|A:दृष्टीकोण|B:दृष्ट्रिकोण|C:दृस्टीकोण|D:दृष्टिकोण'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन शब्द शुद्ध छ?|A:व्यावहारिक|B:व्यवहारिक|C:व्याबहारीक|D:व्यवहारीक');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'तलका मध्ये कुन शब्द शुद्ध छ?', E'व्यावहारिक', E'व्यवहारिक', E'व्याबहारीक', E'व्यवहारीक', E'A', E'''व्यवहार'' मा ''इक'' प्रत्यय लागेर ''व्यावहारिक'' बन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन शब्द शुद्ध छ?|A:व्यावहारिक|B:व्यवहारिक|C:व्याबहारीक|D:व्यवहारीक'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन शब्द शुद्ध छ?|A:सहानुभुति|B:सहानुभूति|C:सहनाभूति|D:साहानुभूति');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'तलका मध्ये कुन शब्द शुद्ध छ?', E'सहानुभुति', E'सहानुभूति', E'सहनाभूति', E'साहानुभूति', E'B', E'''सहानुभूति'' मा ''भ'' मा दीर्घ ''ू'' र ''त'' मा ह्रस्व ''ि'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन शब्द शुद्ध छ?|A:सहानुभुति|B:सहानुभूति|C:सहनाभूति|D:साहानुभूति'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन शब्द शुद्ध छ?|A:शताब्दि|B:सताब्दी|C:शताब्दी|D:सताब्दि');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'तलका मध्ये कुन शब्द शुद्ध छ?', E'शताब्दि', E'सताब्दी', E'शताब्दी', E'सताब्दि', E'C', E'''शताब्दी'' मा ''द'' मा दीर्घ ''ी'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन शब्द शुद्ध छ?|A:शताब्दि|B:सताब्दी|C:शताब्दी|D:सताब्दि'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन शब्द शुद्ध छ?|A:निरन्तरर|B:निरन्तरता|C:निरन्त्तर|D:निरन्तर');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'तलका मध्ये कुन शब्द शुद्ध छ?', E'निरन्तरर', E'निरन्तरता', E'निरन्त्तर', E'निरन्तर', E'D', E'''निरन्तर'' शब्द शुद्ध हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन शब्द शुद्ध छ?|A:निरन्तरर|B:निरन्तरता|C:निरन्त्तर|D:निरन्तर'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन शब्द शुद्ध छ?|A:निष्कर्ष|B:निस्कर्ष|C:निसकर्ष|D:निष्कर्श');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'तलका मध्ये कुन शब्द शुद्ध छ?', E'निष्कर्ष', E'निस्कर्ष', E'निसकर्ष', E'निष्कर्श', E'A', E'''निष्कर्ष'' शब्दमा मूर्धन्य ''ष'' को प्रयोग हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन शब्द शुद्ध छ?|A:निष्कर्ष|B:निस्कर्ष|C:निसकर्ष|D:निष्कर्श'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन शब्द शुद्ध छ?|A:मूल्यांकन|B:मूल्याङ्कन|C:मुल्याङ्कन|D:मुल्यांकन');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'तलका मध्ये कुन शब्द शुद्ध छ?', E'मूल्यांकन', E'मूल्याङ्कन', E'मुल्याङ्कन', E'मुल्यांकन', E'B', E'''मूल्याङ्कन'' शब्दमा ''म'' मा दीर्घ ''ू'' र ङ+क हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन शब्द शुद्ध छ?|A:मूल्यांकन|B:मूल्याङ्कन|C:मुल्याङ्कन|D:मुल्यांकन'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: शाब्दिक बौद्धिक परीक्षणः शाब्दिक वर्गीकरण - खण्ड 2 (आधारभूत तह) (30 Q)
  v_set_id := extensions.uuid_generate_v5('ae5f551c-9daa-4651-bf85-7891ea89c25c'::uuid, E'शाब्दिक बौद्धिक परीक्षणः शाब्दिक वर्गीकरण - खण्ड 2 (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'efc9184a-c265-4fd8-bb99-aad431aefc58'::uuid, 'ae5f551c-9daa-4651-bf85-7891ea89c25c'::uuid, E'शाब्दिक बौद्धिक परीक्षणः शाब्दिक वर्गीकरण - खण्ड 2 (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'ae5f551c-9daa-4651-bf85-7891ea89c25c'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:महिना|B:सेकेन्ड|C:मिनेट|D:घण्टा');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'समूहमा नमिल्ने शब्द कुन हो?', E'महिना', E'सेकेन्ड', E'मिनेट', E'घण्टा', E'A', E'महिना क्यालेन्डरमा हुन्छ, अन्य सबै घडीले देखाउने समयका एकाइ हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:महिना|B:सेकेन्ड|C:मिनेट|D:घण्टा'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:आँप|B:प्याज|C:कटहर|D:केरा');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'समूहमा नमिल्ने शब्द कुन हो?', E'आँप', E'प्याज', E'कटहर', E'केरा', E'B', E'प्याज तरकारी तथा मसला हो, अन्य सबै फलफूल हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:आँप|B:प्याज|C:कटहर|D:केरा'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:मुसा|B:बिरालो|C:हात्ती|D:कुकुर');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'समूहमा नमिल्ने शब्द कुन हो?', E'मुसा', E'बिरालो', E'हात्ती', E'कुकुर', E'C', E'हात्ती शाकाहारी र विशाल जनावर हो, अन्य घरवरिपरि पाइने साना जनावर हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:मुसा|B:बिरालो|C:हात्ती|D:कुकुर'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:टेबल|B:कुर्सी|C:ओछ्यान|D:कम्प्युटर');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'समूहमा नमिल्ने शब्द कुन हो?', E'टेबल', E'कुर्सी', E'ओछ्यान', E'कम्प्युटर', E'D', E'कम्प्युटर विद्युतीय उपकरण हो, अन्य सबै फर्निचर हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:टेबल|B:कुर्सी|C:ओछ्यान|D:कम्प्युटर'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:समुद्र|B:हिमाल|C:पहाड|D:तराई');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'समूहमा नमिल्ने शब्द कुन हो?', E'समुद्र', E'हिमाल', E'पहाड', E'तराई', E'A', E'समुद्र पानीको विशाल भण्डार हो, अन्य सबै जमिनका भौगोलिक स्वरूप हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:समुद्र|B:हिमाल|C:पहाड|D:तराई'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:बैशाख|B:आइतबार|C:जेठ|D:असार');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'समूहमा नमिल्ने शब्द कुन हो?', E'बैशाख', E'आइतबार', E'जेठ', E'असार', E'B', E'आइतबार बारको नाम हो, अन्य सबै महिनाका नाम हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:बैशाख|B:आइतबार|C:जेठ|D:असार'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:औँला|B:हत्केला|C:टाउको|D:कुम');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'समूहमा नमिल्ने शब्द कुन हो?', E'औँला', E'हत्केला', E'टाउको', E'कुम', E'C', E'टाउको हातको भाग होइन, अन्य सबै हातसँग सम्बन्धित अंग हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:औँला|B:हत्केला|C:टाउको|D:कुम'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:सुई|B:धागो|C:कैंची|D:चक्कु');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'समूहमा नमिल्ने शब्द कुन हो?', E'सुई', E'धागो', E'कैंची', E'चक्कु', E'D', E'चक्कु भान्सामा प्रयोग हुन्छ, अन्य सबै लुगा सिलाउने कार्यमा प्रयोग हुन्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:सुई|B:धागो|C:कैंची|D:चक्कु'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:रेखा|B:त्रिकोण|C:वर्ग|D:वृत्त');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'समूहमा नमिल्ने शब्द कुन हो?', E'रेखा', E'त्रिकोण', E'वर्ग', E'वृत्त', E'A', E'रेखा एकआयामिक (1D) हुन्छ, अन्य सबै बहुआयामिक (2D) बन्द आकृति हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:रेखा|B:त्रिकोण|C:वर्ग|D:वृत्त'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:कमिला|B:माकुरा|C:मौरी|D:झिँगा');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'समूहमा नमिल्ने शब्द कुन हो?', E'कमिला', E'माकुरा', E'मौरी', E'झिँगा', E'B', E'माकुराका ८ खुट्टा हुन्छन् र यो किरा (Insect) वर्गमा पर्दैन, अन्य सबैका ६ खुट्टा हुन्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:कमिला|B:माकुरा|C:मौरी|D:झिँगा'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:चिया|B:कफी|C:पानी|D:कोको');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'समूहमा नमिल्ने शब्द कुन हो?', E'चिया', E'कफी', E'पानी', E'कोको', E'C', E'पानी प्राकृतिक र स्वादहीन पेय हो, अन्य सबै प्रशोधित पेय पदार्थ हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:चिया|B:कफी|C:पानी|D:कोको'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:टेलिभिजन|B:रेडियो|C:मोबाइल|D:किताब');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'समूहमा नमिल्ने शब्द कुन हो?', E'टेलिभिजन', E'रेडियो', E'मोबाइल', E'किताब', E'D', E'किताब विद्युतीय वा सञ्चार उपकरण होइन, अन्य सबै विद्युतीय सञ्चारका साधन हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:टेलिभिजन|B:रेडियो|C:मोबाइल|D:किताब'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:अदालत|B:सिपाही|C:वकिल|D:न्यायाधीश');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'समूहमा नमिल्ने शब्द कुन हो?', E'अदालत', E'सिपाही', E'वकिल', E'न्यायाधीश', E'A', E'अदालत न्याय सम्पादन गर्ने स्थान/संस्था हो, अन्य सबै व्यक्ति/पेसा हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:अदालत|B:सिपाही|C:वकिल|D:न्यायाधीश'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:काँक्रो|B:चना|C:फर्सी|D:लौका');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'समूहमा नमिल्ने शब्द कुन हो?', E'काँक्रो', E'चना', E'फर्सी', E'लौका', E'B', E'चना गेडागुडी हो, अन्य सबै लहरामा फल्ने तरकारी हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:काँक्रो|B:चना|C:फर्सी|D:लौका'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:फलाम|B:तामा|C:पित्तल|D:सुन');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'समूहमा नमिल्ने शब्द कुन हो?', E'फलाम', E'तामा', E'पित्तल', E'सुन', E'C', E'पित्तल मिश्रित धातु (Alloy) हो, अन्य सबै शुद्ध धातु हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:फलाम|B:तामा|C:पित्तल|D:सुन'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:किलोमिटर|B:मिटर|C:सेन्टिमिटर|D:किलोग्राम');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'समूहमा नमिल्ने शब्द कुन हो?', E'किलोमिटर', E'मिटर', E'सेन्टिमिटर', E'किलोग्राम', E'D', E'किलोग्राम तौल नाप्ने एकाइ हो, अन्य सबै लम्बाइ नाप्ने एकाइ हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:किलोमिटर|B:मिटर|C:सेन्टिमिटर|D:किलोग्राम'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:कान|B:दाँत|C:जिब्रो|D:ओठ');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'समूहमा नमिल्ने शब्द कुन हो?', E'कान', E'दाँत', E'जिब्रो', E'ओठ', E'A', E'कान मुखको भाग होइन, अन्य सबै मुखभित्र वा मुखसँग सम्बन्धित अंग हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:कान|B:दाँत|C:जिब्रो|D:ओठ'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:ढोका|B:खाट|C:झ्याल|D:पर्खाल');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'समूहमा नमिल्ने शब्द कुन हो?', E'ढोका', E'खाट', E'झ्याल', E'पर्खाल', E'B', E'खाट फर्निचर हो, अन्य सबै घरका संरचनात्मक भाग हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:ढोका|B:खाट|C:झ्याल|D:पर्खाल'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:प्याज|B:लसुन|C:गोलभेँडा|D:अदुवा');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'समूहमा नमिल्ने शब्द कुन हो?', E'प्याज', E'लसुन', E'गोलभेँडा', E'अदुवा', E'C', E'गोलभेँडा जमिनमाथि फल्छ, अन्य सबै जमिनमुनि फल्ने तरकारी/मसला हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:प्याज|B:लसुन|C:गोलभेँडा|D:अदुवा'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:गरुड|B:चिल|C:गिद्ध|D:सुँगा');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 20, E'समूहमा नमिल्ने शब्द कुन हो?', E'गरुड', E'चिल', E'गिद्ध', E'सुँगा', E'D', E'सुँगा शाकाहारी र घरपालुवा चरा हो, अन्य सबै सिकारी वा मांसाहारी चरा हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:गरुड|B:चिल|C:गिद्ध|D:सुँगा'), v_set_id, v_q_id, 20)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:दाउरा|B:पेट्रोल|C:डिजेल|D:मट्टितेल');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 21, E'समूहमा नमिल्ने शब्द कुन हो?', E'दाउरा', E'पेट्रोल', E'डिजेल', E'मट्टितेल', E'A', E'दाउरा ठोस इन्धन हो, अन्य सबै तरल पेट्रोलियम पदार्थ हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:दाउरा|B:पेट्रोल|C:डिजेल|D:मट्टितेल'), v_set_id, v_q_id, 21)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:पुतली|B:चमेरो|C:भँगेरा|D:ढुकुर');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 22, E'समूहमा नमिल्ने शब्द कुन हो?', E'पुतली', E'चमेरो', E'भँगेरा', E'ढुकुर', E'B', E'चमेरो स्तनधारी जीव हो (बच्चा जन्माउँछ), अन्यले फुल पार्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:पुतली|B:चमेरो|C:भँगेरा|D:ढुकुर'), v_set_id, v_q_id, 22)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:गुलाब|B:कमल|C:गोभी|D:सयपत्री');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 23, E'समूहमा नमिल्ने शब्द कुन हो?', E'गुलाब', E'कमल', E'गोभी', E'सयपत्री', E'C', E'गोभी तरकारी हो, अन्य सबै फूलका नाम हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:गुलाब|B:कमल|C:गोभी|D:सयपत्री'), v_set_id, v_q_id, 23)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:उपन्यास|B:कथा|C:कविता|D:लेखक');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 24, E'समूहमा नमिल्ने शब्द कुन हो?', E'उपन्यास', E'कथा', E'कविता', E'लेखक', E'D', E'लेखक व्यक्ति हो, अन्य सबै साहित्यका विधा हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:उपन्यास|B:कथा|C:कविता|D:लेखक'), v_set_id, v_q_id, 24)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:माछा|B:भ्यागुतो|C:गोही|D:कछुवा');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 25, E'समूहमा नमिल्ने शब्द कुन हो?', E'माछा', E'भ्यागुतो', E'गोही', E'कछुवा', E'A', E'माछा पानीमा मात्र बाँच्न सक्छ, अन्य सबै पानी र जमिन दुवैमा बाँच्न सक्छन् (उभयचर)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:माछा|B:भ्यागुतो|C:गोही|D:कछुवा'), v_set_id, v_q_id, 25)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:आँधी|B:भूकम्प|C:हुरी|D:वर्षा');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 26, E'समूहमा नमिल्ने शब्द कुन हो?', E'आँधी', E'भूकम्प', E'हुरी', E'वर्षा', E'B', E'भूकम्प जमिनको कम्पन हो, अन्य सबै मौसम र वायुमण्डलसँग सम्बन्धित हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:आँधी|B:भूकम्प|C:हुरी|D:वर्षा'), v_set_id, v_q_id, 26)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:गणित|B:विज्ञान|C:विद्यालय|D:इतिहास');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 27, E'समूहमा नमिल्ने शब्द कुन हो?', E'गणित', E'विज्ञान', E'विद्यालय', E'इतिहास', E'C', E'विद्यालय शैक्षिक संस्था हो, अन्य सबै अध्ययनका विषय हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:गणित|B:विज्ञान|C:विद्यालय|D:इतिहास'), v_set_id, v_q_id, 27)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:टर्च|B:मैनबत्ती|C:चिम|D:ऐना');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 28, E'समूहमा नमिल्ने शब्द कुन हो?', E'टर्च', E'मैनबत्ती', E'चिम', E'ऐना', E'D', E'ऐनाले आफैँ प्रकाश उत्पादन गर्दैन, अन्य सबै प्रकाशका स्रोत हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:टर्च|B:मैनबत्ती|C:चिम|D:ऐना'), v_set_id, v_q_id, 28)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:फलाम|B:हीरा|C:पन्ना|D:रुबी');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 29, E'समूहमा नमिल्ने शब्द कुन हो?', E'फलाम', E'हीरा', E'पन्ना', E'रुबी', E'A', E'फलाम साधारण धातु हो, अन्य सबै बहुमूल्य पत्थर (Gems) हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:फलाम|B:हीरा|C:पन्ना|D:रुबी'), v_set_id, v_q_id, 29)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:जिराफ|B:उँट|C:हात्ती|D:गैंडा');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 30, E'समूहमा नमिल्ने शब्द कुन हो?', E'जिराफ', E'उँट', E'हात्ती', E'गैंडा', E'B', E'उँट मरुभूमिमा पाइने जनावर हो, अन्य सबै सामान्य जंगलमा पाइन्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:जिराफ|B:उँट|C:हात्ती|D:गैंडा'), v_set_id, v_q_id, 30)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: शाब्दिक बौद्धिक परीक्षणः शाब्दिक वर्गीकरण - खण्ड 3 (आधारभूत तह) (30 Q)
  v_set_id := extensions.uuid_generate_v5('ae5f551c-9daa-4651-bf85-7891ea89c25c'::uuid, E'शाब्दिक बौद्धिक परीक्षणः शाब्दिक वर्गीकरण - खण्ड 3 (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'efc9184a-c265-4fd8-bb99-aad431aefc58'::uuid, 'ae5f551c-9daa-4651-bf85-7891ea89c25c'::uuid, E'शाब्दिक बौद्धिक परीक्षणः शाब्दिक वर्गीकरण - खण्ड 3 (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'ae5f551c-9daa-4651-bf85-7891ea89c25c'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:साथी|B:भतिजा|C:भान्जा|D:काका');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'समूहमा नमिल्ने शब्द कुन हो?', E'साथी', E'भतिजा', E'भान्जा', E'काका', E'A', E'साथी पारिवारिक वा रगतको नाता होइन, अन्य सबै पारिवारिक नाता हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:साथी|B:भतिजा|C:भान्जा|D:काका'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:नुन|B:चिनी|C:मरिच|D:खुर्सानी');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'समूहमा नमिल्ने शब्द कुन हो?', E'नुन', E'चिनी', E'मरिच', E'खुर्सानी', E'B', E'चिनी गुलियो हुन्छ, अन्य सबै नुनिलो वा पिरो/मसलादार हुन्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:नुन|B:चिनी|C:मरिच|D:खुर्सानी'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:जुत्ता|B:चप्पल|C:पन्जा|D:मोजा');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'समूहमा नमिल्ने शब्द कुन हो?', E'जुत्ता', E'चप्पल', E'पन्जा', E'मोजा', E'C', E'पन्जा हातमा लगाइन्छ, अन्य सबै खुट्टामा लगाइन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:जुत्ता|B:चप्पल|C:पन्जा|D:मोजा'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:कुचो|B:डस्टर|C:भ्याकुम|D:पकाउने भाँडो');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'समूहमा नमिल्ने शब्द कुन हो?', E'कुचो', E'डस्टर', E'भ्याकुम', E'पकाउने भाँडो', E'D', E'पकाउने भाँडो भान्साको सामान हो, अन्य सबै सरसफाइका साधन हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:कुचो|B:डस्टर|C:भ्याकुम|D:पकाउने भाँडो'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:कार|B:साइकल|C:मोटरसाइकल|D:स्कुटर');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'समूहमा नमिल्ने शब्द कुन हो?', E'कार', E'साइकल', E'मोटरसाइकल', E'स्कुटर', E'A', E'कारका ४ पाङ्ग्रा हुन्छन्, अन्य सबै २ पाङ्ग्रे सवारी साधन हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:कार|B:साइकल|C:मोटरसाइकल|D:स्कुटर'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:फेसबुक|B:गुगल|C:ट्विटर|D:इन्स्टाग्राम');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'समूहमा नमिल्ने शब्द कुन हो?', E'फेसबुक', E'गुगल', E'ट्विटर', E'इन्स्टाग्राम', E'B', E'गुगल सर्च इन्जिन हो, अन्य सबै सामाजिक सञ्जाल (Social Media) हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:फेसबुक|B:गुगल|C:ट्विटर|D:इन्स्टाग्राम'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:कालो|B:सेतो|C:उज्यालो|D:खैरो');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'समूहमा नमिल्ने शब्द कुन हो?', E'कालो', E'सेतो', E'उज्यालो', E'खैरो', E'C', E'उज्यालो प्रकाशको अवस्था हो, अन्य सबै रङका नाम हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:कालो|B:सेतो|C:उज्यालो|D:खैरो'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:डलर|B:रुपैयाँ|C:युरो|D:सुन');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'समूहमा नमिल्ने शब्द कुन हो?', E'डलर', E'रुपैयाँ', E'युरो', E'सुन', E'D', E'सुन बहुमूल्य धातु हो, अन्य सबै मुद्रा (Currency) का नाम हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:डलर|B:रुपैयाँ|C:युरो|D:सुन'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:सिमेन्ट|B:माटो|C:बालुवा|D:ढुङ्गा');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'समूहमा नमिल्ने शब्द कुन हो?', E'सिमेन्ट', E'माटो', E'बालुवा', E'ढुङ्गा', E'A', E'सिमेन्ट मानव निर्मित निर्माण सामग्री हो, अन्य सबै प्राकृतिक हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:सिमेन्ट|B:माटो|C:बालुवा|D:ढुङ्गा'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:तातो|B:हिउँ|C:चिसो|D:मनतातो');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'समूहमा नमिल्ने शब्द कुन हो?', E'तातो', E'हिउँ', E'चिसो', E'मनतातो', E'B', E'हिउँ पानीको ठोस रूप हो, अन्य सबै तापक्रमका अवस्था हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:तातो|B:हिउँ|C:चिसो|D:मनतातो'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:कुँवा|B:पोखरी|C:नदी|D:इनार');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'समूहमा नमिल्ने शब्द कुन हो?', E'कुँवा', E'पोखरी', E'नदी', E'इनार', E'C', E'नदीको पानी बग्ने प्रकृतिको हुन्छ, अन्य सबै जमेको वा स्थिर पानीका स्रोत हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:कुँवा|B:पोखरी|C:नदी|D:इनार'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:चस्मा|B:लेन्स|C:माइक्रोस्कोप|D:स्टेथेस्कोप');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'समूहमा नमिल्ने शब्द कुन हो?', E'चस्मा', E'लेन्स', E'माइक्रोस्कोप', E'स्टेथेस्कोप', E'D', E'स्टेथेस्कोप सुन्नका लागि प्रयोग हुन्छ, अन्य सबै हेर्नका लागि प्रयोग हुने प्रकाशिक (Optical) साधन हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:चस्मा|B:लेन्स|C:माइक्रोस्कोप|D:स्टेथेस्कोप'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:मुकुण्डो|B:टोपी|C:हेल्मेट|D:पगरी');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'समूहमा नमिल्ने शब्द कुन हो?', E'मुकुण्डो', E'टोपी', E'हेल्मेट', E'पगरी', E'A', E'मुकुण्डो अनुहारमा लगाइन्छ, अन्य सबै टाउकोमा लगाइन्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:मुकुण्डो|B:टोपी|C:हेल्मेट|D:पगरी'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:बाघ|B:स्याल|C:चितुवा|D:बिरालो');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'समूहमा नमिल्ने शब्द कुन हो?', E'बाघ', E'स्याल', E'चितुवा', E'बिरालो', E'B', E'स्याल कुकुर प्रजाति (Canine) मा पर्छ, अन्य सबै बिरालो प्रजाति (Feline) मा पर्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:बाघ|B:स्याल|C:चितुवा|D:बिरालो'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:जिरा|B:धनिया|C:केरा|D:बेसार');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'समूहमा नमिल्ने शब्द कुन हो?', E'जिरा', E'धनिया', E'केरा', E'बेसार', E'C', E'केरा फलफूल हो, अन्य सबै भान्सामा प्रयोग हुने मसला हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:जिरा|B:धनिया|C:केरा|D:बेसार'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:बुध|B:शुक्र|C:शनि|D:चन्द्रमा');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'समूहमा नमिल्ने शब्द कुन हो?', E'बुध', E'शुक्र', E'शनि', E'चन्द्रमा', E'D', E'चन्द्रमा उपग्रह हो, अन्य सबै ग्रह हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:बुध|B:शुक्र|C:शनि|D:चन्द्रमा'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:वैशाख|B:हिउँद|C:वर्षा|D:वसन्त');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'समूहमा नमिल्ने शब्द कुन हो?', E'वैशाख', E'हिउँद', E'वर्षा', E'वसन्त', E'A', E'वैशाख महिना हो, अन्य सबै ऋतुका नाम हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:वैशाख|B:हिउँद|C:वर्षा|D:वसन्त'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:गहुँगोरो|B:अग्लो|C:कालो|D:गोरो');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'समूहमा नमिल्ने शब्द कुन हो?', E'गहुँगोरो', E'अग्लो', E'कालो', E'गोरो', E'B', E'अग्लो उचाइसँग सम्बन्धित छ, अन्य सबै मानिसको वर्ण वा रङसँग सम्बन्धित छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:गहुँगोरो|B:अग्लो|C:कालो|D:गोरो'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:गुँड|B:घार|C:गाई|D:गोठ');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'समूहमा नमिल्ने शब्द कुन हो?', E'गुँड', E'घार', E'गाई', E'गोठ', E'C', E'गाई जनावर हो, अन्य सबै जीवजन्तुका बासस्थान हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:गुँड|B:घार|C:गाई|D:गोठ'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:हँसिया|B:कोदालो|C:बन्चरो|D:बन्दुक');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 20, E'समूहमा नमिल्ने शब्द कुन हो?', E'हँसिया', E'कोदालो', E'बन्चरो', E'बन्दुक', E'D', E'बन्दुक हतियार हो, अन्य सबै कृषि वा घरायसी औजार हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:हँसिया|B:कोदालो|C:बन्चरो|D:बन्दुक'), v_set_id, v_q_id, 20)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:तेल|B:दही|C:मही|D:घिउ');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 21, E'समूहमा नमिल्ने शब्द कुन हो?', E'तेल', E'दही', E'मही', E'घिउ', E'A', E'तेल वनस्पति वा तोरीबाट बन्छ, अन्य सबै दूधबाट बन्ने परिकार हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:तेल|B:दही|C:मही|D:घिउ'), v_set_id, v_q_id, 21)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:ग्यास|B:दाउरा|C:बिजुली|D:सोलार');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 22, E'समूहमा नमिल्ने शब्द कुन हो?', E'ग्यास', E'दाउरा', E'बिजुली', E'सोलार', E'B', E'दाउरा परम्परागत र ठोस इन्धन हो, अन्य आधुनिक वा स्वच्छ ऊर्जाका स्रोत हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:ग्यास|B:दाउरा|C:बिजुली|D:सोलार'), v_set_id, v_q_id, 22)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:मादल|B:ढोलक|C:गितार|D:डमरु');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 23, E'समूहमा नमिल्ने शब्द कुन हो?', E'मादल', E'ढोलक', E'गितार', E'डमरु', E'C', E'गितार तारको माध्यमबाट बज्छ, अन्य सबै छाला मोडेर बनाइएका तालबाजा हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:मादल|B:ढोलक|C:गितार|D:डमरु'), v_set_id, v_q_id, 23)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:कचौरा|B:थाल|C:गिलाँस|D:चम्चा');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 24, E'समूहमा नमिल्ने शब्द कुन हो?', E'कचौरा', E'थाल', E'गिलाँस', E'चम्चा', E'D', E'चम्चा खाना पस्किन वा खान प्रयोग हुने औजार हो, अन्य सबै खाना वा पानी राख्ने भाँडा हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:कचौरा|B:थाल|C:गिलाँस|D:चम्चा'), v_set_id, v_q_id, 24)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:रगत|B:कलेजो|C:मुटु|D:मिर्गौला');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 25, E'समूहमा नमिल्ने शब्द कुन हो?', E'रगत', E'कलेजो', E'मुटु', E'मिर्गौला', E'A', E'रगत तरल पदार्थ हो, अन्य सबै शरीरका ठोस अंग हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:रगत|B:कलेजो|C:मुटु|D:मिर्गौला'), v_set_id, v_q_id, 25)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:फलाम|B:काठ|C:आल्मुनियम|D:तामा');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 26, E'समूहमा नमिल्ने शब्द कुन हो?', E'फलाम', E'काठ', E'आल्मुनियम', E'तामा', E'B', E'काठ रुखबाट प्राप्त हुन्छ र धातु होइन, अन्य सबै धातु हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:फलाम|B:काठ|C:आल्मुनियम|D:तामा'), v_set_id, v_q_id, 26)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:बाघ|B:भालु|C:मृग|D:स्याल');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 27, E'समूहमा नमिल्ने शब्द कुन हो?', E'बाघ', E'भालु', E'मृग', E'स्याल', E'C', E'मृग पूर्ण रूपमा शाकाहारी जनावर हो, अन्य मांसाहारी वा सर्वाहारी हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:बाघ|B:भालु|C:मृग|D:स्याल'), v_set_id, v_q_id, 27)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:बाहुन|B:क्षेत्री|C:नेवार|D:नेपाली');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 28, E'समूहमा नमिल्ने शब्द कुन हो?', E'बाहुन', E'क्षेत्री', E'नेवार', E'नेपाली', E'D', E'नेपाली राष्ट्रियता हो, अन्य सबै नेपालभित्रका जातजाति हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:बाहुन|B:क्षेत्री|C:नेवार|D:नेपाली'), v_set_id, v_q_id, 28)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:दायाँ|B:पूर्व|C:पश्चिम|D:उत्तर');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 29, E'समूहमा नमिल्ने शब्द कुन हो?', E'दायाँ', E'पूर्व', E'पश्चिम', E'उत्तर', E'A', E'दायाँ सापेक्षिक दिशा हो, अन्य सबै भौगोलिक दिशा हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:दायाँ|B:पूर्व|C:पश्चिम|D:उत्तर'), v_set_id, v_q_id, 29)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:कागज|B:किबोर्ड|C:मसी|D:कलम');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 30, E'समूहमा नमिल्ने शब्द कुन हो?', E'कागज', E'किबोर्ड', E'मसी', E'कलम', E'B', E'किबोर्ड कम्प्युटरको विद्युतीय उपकरण हो, अन्य परम्परागत लेखन सामग्री हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:कागज|B:किबोर्ड|C:मसी|D:कलम'), v_set_id, v_q_id, 30)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: शाब्दिक बौद्धिक परीक्षणः शाब्दिक वर्गीकरण - खण्ड 4 (आधारभूत तह) (15 Q)
  v_set_id := extensions.uuid_generate_v5('ae5f551c-9daa-4651-bf85-7891ea89c25c'::uuid, E'शाब्दिक बौद्धिक परीक्षणः शाब्दिक वर्गीकरण - खण्ड 4 (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'efc9184a-c265-4fd8-bb99-aad431aefc58'::uuid, 'ae5f551c-9daa-4651-bf85-7891ea89c25c'::uuid, E'शाब्दिक बौद्धिक परीक्षणः शाब्दिक वर्गीकरण - खण्ड 4 (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'ae5f551c-9daa-4651-bf85-7891ea89c25c'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:स्याउ|B:गहुँ|C:जौ|D:मकै');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'समूहमा नमिल्ने शब्द कुन हो?', E'स्याउ', E'गहुँ', E'जौ', E'मकै', E'A', E'स्याउ फलफूल हो, अन्य सबै अन्नबाली हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:स्याउ|B:गहुँ|C:जौ|D:मकै'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:बस|B:रेल|C:मिनिबस|D:माइक्रोबस');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'समूहमा नमिल्ने शब्द कुन हो?', E'बस', E'रेल', E'मिनिबस', E'माइक्रोबस', E'B', E'रेल लिक (पटरी) मा गुड्छ, अन्य सबै सडकमा गुड्ने सवारी साधन हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:बस|B:रेल|C:मिनिबस|D:माइक्रोबस'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:सुन|B:चाँदी|C:प्लाष्टिक|D:फलाम');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'समूहमा नमिल्ने शब्द कुन हो?', E'सुन', E'चाँदी', E'प्लाष्टिक', E'फलाम', E'C', E'प्लाष्टिक कृत्रिम सामग्री (धातु होइन), अन्य सबै प्राकृतिक धातु हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:सुन|B:चाँदी|C:प्लाष्टिक|D:फलाम'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:माछा|B:भ्यागुतो|C:सर्प|D:कुकुर');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'समूहमा नमिल्ने शब्द कुन हो?', E'माछा', E'भ्यागुतो', E'सर्प', E'कुकुर', E'D', E'कुकुर स्तनधारी जीव हो र यसले अण्डा पार्दैन, अन्य सबैले अण्डा पार्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:माछा|B:भ्यागुतो|C:सर्प|D:कुकुर'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:जंगल|B:घर|C:झोपडी|D:महल');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'समूहमा नमिल्ने शब्द कुन हो?', E'जंगल', E'घर', E'झोपडी', E'महल', E'A', E'जंगल प्राकृतिक बासस्थान हो, अन्य सबै मानिसले बनाएका संरचना हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:जंगल|B:घर|C:झोपडी|D:महल'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:घडी|B:थर्मोमिटर|C:क्यालेन्डर|D:डायरी');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'समूहमा नमिल्ने शब्द कुन हो?', E'घडी', E'थर्मोमिटर', E'क्यालेन्डर', E'डायरी', E'B', E'थर्मोमिटरले तापक्रम नाप्छ, अन्य सबैले समय वा मितिको रेकर्ड राख्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:घडी|B:थर्मोमिटर|C:क्यालेन्डर|D:डायरी'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:आँप|B:लिची|C:कागती|D:केरा');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'समूहमा नमिल्ने शब्द कुन हो?', E'आँप', E'लिची', E'कागती', E'केरा', E'C', E'कागती अमिलो (Citrus) फल हो, अन्य सामान्य गुलिया फलफूल हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:आँप|B:लिची|C:कागती|D:केरा'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:फुटबल|B:भलिबल|C:क्रिकेट|D:पौडी');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'समूहमा नमिल्ने शब्द कुन हो?', E'फुटबल', E'भलिबल', E'क्रिकेट', E'पौडी', E'D', E'पौडी खेल्दा बलको प्रयोग हुँदैन, अन्य सबै बलको प्रयोग गरिने खेल हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:फुटबल|B:भलिबल|C:क्रिकेट|D:पौडी'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:बस्नु|B:हिँड्नु|C:दौडनु|D:उफ्रनु');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'समूहमा नमिल्ने शब्द कुन हो?', E'बस्नु', E'हिँड्नु', E'दौडनु', E'उफ्रनु', E'A', E'बस्नु स्थिर अवस्था हो, अन्य सबैमा शारीरिक चाल (Motion) हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:बस्नु|B:हिँड्नु|C:दौडनु|D:उफ्रनु'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:जहाज|B:बस|C:डुङ्गा|D:पनडुब्बी');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'समूहमा नमिल्ने शब्द कुन हो?', E'जहाज', E'बस', E'डुङ्गा', E'पनडुब्बी', E'B', E'बस जमिनमा गुड्छ, अन्य सबै पानीमा चल्ने यातायातका साधन हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:जहाज|B:बस|C:डुङ्गा|D:पनडुब्बी'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:नाक|B:मुख|C:कपाल|D:दाँत');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'समूहमा नमिल्ने शब्द कुन हो?', E'नाक', E'मुख', E'कपाल', E'दाँत', E'C', E'कपाल निर्जीव कोषबाट बन्छ जसमा स्नायु हुँदैन (काट्दा दुख्दैन), अन्य सबै संवेदनशील अंग हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:नाक|B:मुख|C:कपाल|D:दाँत'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:कपास|B:ऊन|C:रेशम|D:नायलन');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'समूहमा नमिल्ने शब्द कुन हो?', E'कपास', E'ऊन', E'रेशम', E'नायलन', E'D', E'नायलन कृत्रिम (मानव निर्मित) रेशा हो, अन्य सबै प्राकृतिक रेशा हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:कपास|B:ऊन|C:रेशम|D:नायलन'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:ताजमहल|B:सिंहदबार|C:पशुपतिनाथ|D:धरहरा');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'समूहमा नमिल्ने शब्द कुन हो?', E'ताजमहल', E'सिंहदबार', E'पशुपतिनाथ', E'धरहरा', E'A', E'ताजमहल भारतमा पर्छ, अन्य सबै नेपालका ऐतिहासिक/धार्मिक स्थल हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:ताजमहल|B:सिंहदबार|C:पशुपतिनाथ|D:धरहरा'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:कम्प्युटर|B:क्याल्कुलेटर|C:ल्यापटप|D:मोबाइल');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'समूहमा नमिल्ने शब्द कुन हो?', E'कम्प्युटर', E'क्याल्कुलेटर', E'ल्यापटप', E'मोबाइल', E'B', E'क्याल्कुलेटर केवल हिसाब गर्न प्रयोग हुन्छ, अन्य सबै सञ्चार र बहुउद्देश्यीय विद्युतीय उपकरण हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:कम्प्युटर|B:क्याल्कुलेटर|C:ल्यापटप|D:मोबाइल'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द कुन हो?|A:विद्यालय|B:क्याम्पस|C:अस्पताल|D:विश्वविद्यालय');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'समूहमा नमिल्ने शब्द कुन हो?', E'विद्यालय', E'क्याम्पस', E'अस्पताल', E'विश्वविद्यालय', E'C', E'अस्पताल स्वास्थ्य उपचार गर्ने स्थान हो, अन्य सबै शैक्षिक संस्थाहरू हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द कुन हो?|A:विद्यालय|B:क्याम्पस|C:अस्पताल|D:विश्वविद्यालय'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: स्थानिक तथा प्रत्यक्षात्मक क्षमताः Odd One Out - खण्ड 2 (आधारभूत तह) (30 Q)
  v_set_id := extensions.uuid_generate_v5('96ee3c21-fa8a-4f7e-bc81-11eb02607561'::uuid, E'स्थानिक तथा प्रत्यक्षात्मक क्षमताः Odd One Out - खण्ड 2 (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '69c87a98-20d9-4fd7-a596-37eaa6fdc55b'::uuid, '96ee3c21-fa8a-4f7e-bc81-11eb02607561'::uuid, E'स्थानिक तथा प्रत्यक्षात्मक क्षमताः Odd One Out - खण्ड 2 (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '96ee3c21-fa8a-4f7e-bc81-11eb02607561'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन आकार अन्य भन्दा फरक छ?|A:गोला (Sphere)|B:वृत्त (Circle)|C:वर्ग (Square)|D:त्रिभुज (Triangle)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'तलका मध्ये कुन आकार अन्य भन्दा फरक छ?', E'गोला (Sphere)', E'वृत्त (Circle)', E'वर्ग (Square)', E'त्रिभुज (Triangle)', E'A', E'गोला ३D (3-Dimensional) आकार हो, जबकि अन्य सबै २D (2-Dimensional) आकारहरू हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन आकार अन्य भन्दा फरक छ?|A:गोला (Sphere)|B:वृत्त (Circle)|C:वर्ग (Square)|D:त्रिभुज (Triangle)'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएका विकल्पहरूमध्ये कुन समूहमा मिल्दैन?|A:आयत (Rectangle)|B:घन (Cube)|C:पञ्चभुज (Pentagon)|D:षट्भुज (Hexagon)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'दिइएका विकल्पहरूमध्ये कुन समूहमा मिल्दैन?', E'आयत (Rectangle)', E'घन (Cube)', E'पञ्चभुज (Pentagon)', E'षट्भुज (Hexagon)', E'B', E'घन ३D आकार हो, जबकि अन्य सबै २D आकारहरू हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएका विकल्पहरूमध्ये कुन समूहमा मिल्दैन?|A:आयत (Rectangle)|B:घन (Cube)|C:पञ्चभुज (Pentagon)|D:षट्भुज (Hexagon)'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुन ज्यामितीय आकृति अरू भन्दा फरक छ?|A:समबाहु त्रिभुज (Equilateral Triangle)|B:अष्टभुज (Octagon)|C:बेलना (Cylinder)|D:समानान्तर चतुर्भुज (Parallelogram)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'कुन ज्यामितीय आकृति अरू भन्दा फरक छ?', E'समबाहु त्रिभुज (Equilateral Triangle)', E'अष्टभुज (Octagon)', E'बेलना (Cylinder)', E'समानान्तर चतुर्भुज (Parallelogram)', E'C', E'बेलना ३D आकार हो, जबकि अन्य सबै २D आकारहरू हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुन ज्यामितीय आकृति अरू भन्दा फरक छ?|A:समबाहु त्रिभुज (Equilateral Triangle)|B:अष्टभुज (Octagon)|C:बेलना (Cylinder)|D:समानान्तर चतुर्भुज (Parallelogram)'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन विकल्प भिन्न छ?|A:अण्डाकार (Ellipse)|B:वृत्त (Circle)|C:वर्ग (Square)|D:सोली (Cone)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'तलका मध्ये कुन विकल्प भिन्न छ?', E'अण्डाकार (Ellipse)', E'वृत्त (Circle)', E'वर्ग (Square)', E'सोली (Cone)', E'D', E'सोली ३D आकार हो, जबकि अन्य सबै २D आकारहरू हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन विकल्प भिन्न छ?|A:अण्डाकार (Ellipse)|B:वृत्त (Circle)|C:वर्ग (Square)|D:सोली (Cone)'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुन आकृति अन्य भन्दा फरक प्रकारको हो?|A:प्रिज्म (Prism)|B:आयत (Rectangle)|C:त्रिभुज (Triangle)|D:षट्भुज (Hexagon)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'कुन आकृति अन्य भन्दा फरक प्रकारको हो?', E'प्रिज्म (Prism)', E'आयत (Rectangle)', E'त्रिभुज (Triangle)', E'षट्भुज (Hexagon)', E'A', E'प्रिज्म ३D आकार हो, जबकि अन्य सबै २D आकारहरू हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुन आकृति अन्य भन्दा फरक प्रकारको हो?|A:प्रिज्म (Prism)|B:आयत (Rectangle)|C:त्रिभुज (Triangle)|D:षट्भुज (Hexagon)'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएका मध्ये कुन विकल्प अन्य भन्दा फरक छ?|A:पञ्चभुज (Pentagon)|B:पिरामिड (Pyramid)|C:समद्विबाहु त्रिभुज (Isosceles Triangle)|D:वर्ग (Square)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'दिइएका मध्ये कुन विकल्प अन्य भन्दा फरक छ?', E'पञ्चभुज (Pentagon)', E'पिरामिड (Pyramid)', E'समद्विबाहु त्रिभुज (Isosceles Triangle)', E'वर्ग (Square)', E'B', E'पिरामिड ३D आकार हो, जबकि अन्य सबै २D आकारहरू हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएका मध्ये कुन विकल्प अन्य भन्दा फरक छ?|A:पञ्चभुज (Pentagon)|B:पिरामिड (Pyramid)|C:समद्विबाहु त्रिभुज (Isosceles Triangle)|D:वर्ग (Square)'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने चित्रको नाम छान्नुहोस्।|A:समानान्तर चतुर्भुज (Parallelogram)|B:वृत्त (Circle)|C:घनाकार (Cuboid)|D:अष्टभुज (Octagon)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'समूहमा नमिल्ने चित्रको नाम छान्नुहोस्।', E'समानान्तर चतुर्भुज (Parallelogram)', E'वृत्त (Circle)', E'घनाकार (Cuboid)', E'अष्टभुज (Octagon)', E'C', E'घनाकार ३D आकार हो, जबकि अन्य सबै २D आकारहरू हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने चित्रको नाम छान्नुहोस्।|A:समानान्तर चतुर्भुज (Parallelogram)|B:वृत्त (Circle)|C:घनाकार (Cuboid)|D:अष्टभुज (Octagon)'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन आकार अरू भन्दा भिन्न छ?|A:आयत (Rectangle)|B:अण्डाकार (Ellipse)|C:समबाहु त्रिभुज (Equilateral Triangle)|D:गोला (Sphere)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'तलका मध्ये कुन आकार अरू भन्दा भिन्न छ?', E'आयत (Rectangle)', E'अण्डाकार (Ellipse)', E'समबाहु त्रिभुज (Equilateral Triangle)', E'गोला (Sphere)', E'D', E'गोला ३D आकार हो, जबकि अन्य सबै २D आकारहरू हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन आकार अरू भन्दा भिन्न छ?|A:आयत (Rectangle)|B:अण्डाकार (Ellipse)|C:समबाहु त्रिभुज (Equilateral Triangle)|D:गोला (Sphere)'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएका विकल्पहरूमध्ये कुन फरक छ?|A:घन (Cube)|B:षट्भुज (Hexagon)|C:पञ्चभुज (Pentagon)|D:त्रिभुज (Triangle)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'दिइएका विकल्पहरूमध्ये कुन फरक छ?', E'घन (Cube)', E'षट्भुज (Hexagon)', E'पञ्चभुज (Pentagon)', E'त्रिभुज (Triangle)', E'A', E'घन ३D आकार हो, जबकि अन्य सबै २D आकारहरू हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएका विकल्पहरूमध्ये कुन फरक छ?|A:घन (Cube)|B:षट्भुज (Hexagon)|C:पञ्चभुज (Pentagon)|D:त्रिभुज (Triangle)'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुन ज्यामितीय आकृति अरू भन्दा फरक छ?|A:वर्ग (Square)|B:बेलना (Cylinder)|C:अष्टभुज (Octagon)|D:आयत (Rectangle)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'कुन ज्यामितीय आकृति अरू भन्दा फरक छ?', E'वर्ग (Square)', E'बेलना (Cylinder)', E'अष्टभुज (Octagon)', E'आयत (Rectangle)', E'B', E'बेलना ३D आकार हो, जबकि अन्य सबै २D आकारहरू हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुन ज्यामितीय आकृति अरू भन्दा फरक छ?|A:वर्ग (Square)|B:बेलना (Cylinder)|C:अष्टभुज (Octagon)|D:आयत (Rectangle)'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन आकार अन्य भन्दा फरक छ?|A:गोला (Sphere)|B:घन (Cube)|C:वृत्त (Circle)|D:बेलना (Cylinder)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'तलका मध्ये कुन आकार अन्य भन्दा फरक छ?', E'गोला (Sphere)', E'घन (Cube)', E'वृत्त (Circle)', E'बेलना (Cylinder)', E'C', E'वृत्त २D आकार हो, जबकि अन्य सबै ३D आकारहरू हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन आकार अन्य भन्दा फरक छ?|A:गोला (Sphere)|B:घन (Cube)|C:वृत्त (Circle)|D:बेलना (Cylinder)'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएका विकल्पहरूमध्ये कुन समूहमा मिल्दैन?|A:सोली (Cone)|B:प्रिज्म (Prism)|C:पिरामिड (Pyramid)|D:वर्ग (Square)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'दिइएका विकल्पहरूमध्ये कुन समूहमा मिल्दैन?', E'सोली (Cone)', E'प्रिज्म (Prism)', E'पिरामिड (Pyramid)', E'वर्ग (Square)', E'D', E'वर्ग २D आकार हो, जबकि अन्य सबै ३D आकारहरू हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएका विकल्पहरूमध्ये कुन समूहमा मिल्दैन?|A:सोली (Cone)|B:प्रिज्म (Prism)|C:पिरामिड (Pyramid)|D:वर्ग (Square)'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुन ज्यामितीय आकृति अरू भन्दा फरक छ?|A:आयत (Rectangle)|B:घनाकार (Cuboid)|C:गोला (Sphere)|D:घन (Cube)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'कुन ज्यामितीय आकृति अरू भन्दा फरक छ?', E'आयत (Rectangle)', E'घनाकार (Cuboid)', E'गोला (Sphere)', E'घन (Cube)', E'A', E'आयत २D आकार हो, जबकि अन्य सबै ३D आकारहरू हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुन ज्यामितीय आकृति अरू भन्दा फरक छ?|A:आयत (Rectangle)|B:घनाकार (Cuboid)|C:गोला (Sphere)|D:घन (Cube)'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन विकल्प भिन्न छ?|A:बेलना (Cylinder)|B:त्रिभुज (Triangle)|C:सोली (Cone)|D:प्रिज्म (Prism)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'तलका मध्ये कुन विकल्प भिन्न छ?', E'बेलना (Cylinder)', E'त्रिभुज (Triangle)', E'सोली (Cone)', E'प्रिज्म (Prism)', E'B', E'त्रिभुज २D आकार हो, जबकि अन्य सबै ३D आकारहरू हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन विकल्प भिन्न छ?|A:बेलना (Cylinder)|B:त्रिभुज (Triangle)|C:सोली (Cone)|D:प्रिज्म (Prism)'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुन आकृति अन्य भन्दा फरक प्रकारको हो?|A:पिरामिड (Pyramid)|B:घनाकार (Cuboid)|C:पञ्चभुज (Pentagon)|D:गोला (Sphere)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'कुन आकृति अन्य भन्दा फरक प्रकारको हो?', E'पिरामिड (Pyramid)', E'घनाकार (Cuboid)', E'पञ्चभुज (Pentagon)', E'गोला (Sphere)', E'C', E'पञ्चभुज २D आकार हो, जबकि अन्य सबै ३D आकारहरू हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुन आकृति अन्य भन्दा फरक प्रकारको हो?|A:पिरामिड (Pyramid)|B:घनाकार (Cuboid)|C:पञ्चभुज (Pentagon)|D:गोला (Sphere)'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएका मध्ये कुन विकल्प अन्य भन्दा फरक छ?|A:घन (Cube)|B:बेलना (Cylinder)|C:सोली (Cone)|D:षट्भुज (Hexagon)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'दिइएका मध्ये कुन विकल्प अन्य भन्दा फरक छ?', E'घन (Cube)', E'बेलना (Cylinder)', E'सोली (Cone)', E'षट्भुज (Hexagon)', E'D', E'षट्भुज २D आकार हो, जबकि अन्य सबै ३D आकारहरू हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएका मध्ये कुन विकल्प अन्य भन्दा फरक छ?|A:घन (Cube)|B:बेलना (Cylinder)|C:सोली (Cone)|D:षट्भुज (Hexagon)'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने चित्रको नाम छान्नुहोस्।|A:अष्टभुज (Octagon)|B:प्रिज्म (Prism)|C:पिरामिड (Pyramid)|D:घनाकार (Cuboid)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'समूहमा नमिल्ने चित्रको नाम छान्नुहोस्।', E'अष्टभुज (Octagon)', E'प्रिज्म (Prism)', E'पिरामिड (Pyramid)', E'घनाकार (Cuboid)', E'A', E'अष्टभुज २D आकार हो, जबकि अन्य सबै ३D आकारहरू हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने चित्रको नाम छान्नुहोस्।|A:अष्टभुज (Octagon)|B:प्रिज्म (Prism)|C:पिरामिड (Pyramid)|D:घनाकार (Cuboid)'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन आकार अरू भन्दा भिन्न छ?|A:गोला (Sphere)|B:समानान्तर चतुर्भुज (Parallelogram)|C:घन (Cube)|D:बेलना (Cylinder)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'तलका मध्ये कुन आकार अरू भन्दा भिन्न छ?', E'गोला (Sphere)', E'समानान्तर चतुर्भुज (Parallelogram)', E'घन (Cube)', E'बेलना (Cylinder)', E'B', E'समानान्तर चतुर्भुज २D आकार हो, जबकि अन्य सबै ३D आकारहरू हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन आकार अरू भन्दा भिन्न छ?|A:गोला (Sphere)|B:समानान्तर चतुर्भुज (Parallelogram)|C:घन (Cube)|D:बेलना (Cylinder)'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएका विकल्पहरूमध्ये कुन फरक छ?|A:सोली (Cone)|B:प्रिज्म (Prism)|C:अण्डाकार (Ellipse)|D:पिरामिड (Pyramid)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'दिइएका विकल्पहरूमध्ये कुन फरक छ?', E'सोली (Cone)', E'प्रिज्म (Prism)', E'अण्डाकार (Ellipse)', E'पिरामिड (Pyramid)', E'C', E'अण्डाकार २D आकार हो, जबकि अन्य सबै ३D आकारहरू हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएका विकल्पहरूमध्ये कुन फरक छ?|A:सोली (Cone)|B:प्रिज्म (Prism)|C:अण्डाकार (Ellipse)|D:पिरामिड (Pyramid)'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुन ज्यामितीय आकृति अरू भन्दा फरक छ?|A:घनाकार (Cuboid)|B:गोला (Sphere)|C:घन (Cube)|D:समबाहु त्रिभुज (Equilateral Triangle)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 20, E'कुन ज्यामितीय आकृति अरू भन्दा फरक छ?', E'घनाकार (Cuboid)', E'गोला (Sphere)', E'घन (Cube)', E'समबाहु त्रिभुज (Equilateral Triangle)', E'D', E'समबाहु त्रिभुज २D आकार हो, जबकि अन्य सबै ३D आकारहरू हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुन ज्यामितीय आकृति अरू भन्दा फरक छ?|A:घनाकार (Cuboid)|B:गोला (Sphere)|C:घन (Cube)|D:समबाहु त्रिभुज (Equilateral Triangle)'), v_set_id, v_q_id, 20)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन आकार अन्य भन्दा फरक छ?|A:वृत्त (Circle)|B:वर्ग (Square)|C:आयत (Rectangle)|D:त्रिभुज (Triangle)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 21, E'तलका मध्ये कुन आकार अन्य भन्दा फरक छ?', E'वृत्त (Circle)', E'वर्ग (Square)', E'आयत (Rectangle)', E'त्रिभुज (Triangle)', E'A', E'वृत्त वक्र रेखा (Curved line) बाट बनेको हुन्छ, जबकि अन्य सबै सिधा रेखाहरू (Straight lines) बाट बनेका हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन आकार अन्य भन्दा फरक छ?|A:वृत्त (Circle)|B:वर्ग (Square)|C:आयत (Rectangle)|D:त्रिभुज (Triangle)'), v_set_id, v_q_id, 21)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएका विकल्पहरूमध्ये कुन समूहमा मिल्दैन?|A:पञ्चभुज (Pentagon)|B:अण्डाकार (Ellipse)|C:षट्भुज (Hexagon)|D:अष्टभुज (Octagon)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 22, E'दिइएका विकल्पहरूमध्ये कुन समूहमा मिल्दैन?', E'पञ्चभुज (Pentagon)', E'अण्डाकार (Ellipse)', E'षट्भुज (Hexagon)', E'अष्टभुज (Octagon)', E'B', E'अण्डाकार वक्र रेखाबाट बनेको हुन्छ, जबकि अन्य सबै सिधा रेखाहरूबाट बनेका हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएका विकल्पहरूमध्ये कुन समूहमा मिल्दैन?|A:पञ्चभुज (Pentagon)|B:अण्डाकार (Ellipse)|C:षट्भुज (Hexagon)|D:अष्टभुज (Octagon)'), v_set_id, v_q_id, 22)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुन आकृति अरू भन्दा फरक छ?|A:समानान्तर चतुर्भुज (Parallelogram)|B:समबाहु त्रिभुज (Equilateral Triangle)|C:अर्धवृत्त (Semicircle)|D:वर्ग (Square)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 23, E'कुन आकृति अरू भन्दा फरक छ?', E'समानान्तर चतुर्भुज (Parallelogram)', E'समबाहु त्रिभुज (Equilateral Triangle)', E'अर्धवृत्त (Semicircle)', E'वर्ग (Square)', E'C', E'अर्धवृत्तमा वक्र रेखा हुन्छ, जबकि अन्य सबै केवल सिधा रेखाहरूबाट बनेका हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुन आकृति अरू भन्दा फरक छ?|A:समानान्तर चतुर्भुज (Parallelogram)|B:समबाहु त्रिभुज (Equilateral Triangle)|C:अर्धवृत्त (Semicircle)|D:वर्ग (Square)'), v_set_id, v_q_id, 23)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन विकल्प भिन्न छ?|A:आयत (Rectangle)|B:पञ्चभुज (Pentagon)|C:षट्भुज (Hexagon)|D:चन्द्रमा आकार (Crescent)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 24, E'तलका मध्ये कुन विकल्प भिन्न छ?', E'आयत (Rectangle)', E'पञ्चभुज (Pentagon)', E'षट्भुज (Hexagon)', E'चन्द्रमा आकार (Crescent)', E'D', E'चन्द्रमा आकार वक्र रेखाबाट बनेको हुन्छ, जबकि अन्य सबै सिधा रेखाहरूबाट बनेका हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन विकल्प भिन्न छ?|A:आयत (Rectangle)|B:पञ्चभुज (Pentagon)|C:षट्भुज (Hexagon)|D:चन्द्रमा आकार (Crescent)'), v_set_id, v_q_id, 24)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुन चित्र अन्य भन्दा फरक प्रकारको हो?|A:वृत्त (Circle)|B:अष्टभुज (Octagon)|C:तारा (Star)|D:त्रिभुज (Triangle)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 25, E'कुन चित्र अन्य भन्दा फरक प्रकारको हो?', E'वृत्त (Circle)', E'अष्टभुज (Octagon)', E'तारा (Star)', E'त्रिभुज (Triangle)', E'A', E'वृत्त वक्र रेखाबाट बनेको हुन्छ, जबकि अन्य सबै सिधा रेखाहरूबाट बनेका हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुन चित्र अन्य भन्दा फरक प्रकारको हो?|A:वृत्त (Circle)|B:अष्टभुज (Octagon)|C:तारा (Star)|D:त्रिभुज (Triangle)'), v_set_id, v_q_id, 25)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएका मध्ये कुन विकल्प अन्य भन्दा फरक छ?|A:वर्ग (Square)|B:अण्डाकार (Ellipse)|C:आयत (Rectangle)|D:पञ्चभुज (Pentagon)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 26, E'दिइएका मध्ये कुन विकल्प अन्य भन्दा फरक छ?', E'वर्ग (Square)', E'अण्डाकार (Ellipse)', E'आयत (Rectangle)', E'पञ्चभुज (Pentagon)', E'B', E'अण्डाकार वक्र रेखाबाट बनेको हुन्छ, जबकि अन्य सबै सिधा रेखाहरूबाट बनेका हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएका मध्ये कुन विकल्प अन्य भन्दा फरक छ?|A:वर्ग (Square)|B:अण्डाकार (Ellipse)|C:आयत (Rectangle)|D:पञ्चभुज (Pentagon)'), v_set_id, v_q_id, 26)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने चित्रको नाम छान्नुहोस्।|A:षट्भुज (Hexagon)|B:अष्टभुज (Octagon)|C:अर्धवृत्त (Semicircle)|D:समानान्तर चतुर्भुज (Parallelogram)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 27, E'समूहमा नमिल्ने चित्रको नाम छान्नुहोस्।', E'षट्भुज (Hexagon)', E'अष्टभुज (Octagon)', E'अर्धवृत्त (Semicircle)', E'समानान्तर चतुर्भुज (Parallelogram)', E'C', E'अर्धवृत्तमा वक्र रेखा समावेश छ, जबकि अन्य सबै सिधा रेखाहरूबाट बनेका हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने चित्रको नाम छान्नुहोस्।|A:षट्भुज (Hexagon)|B:अष्टभुज (Octagon)|C:अर्धवृत्त (Semicircle)|D:समानान्तर चतुर्भुज (Parallelogram)'), v_set_id, v_q_id, 27)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन आकार अरू भन्दा भिन्न छ?|A:समबाहु त्रिभुज (Equilateral Triangle)|B:वर्ग (Square)|C:आयत (Rectangle)|D:चन्द्रमा आकार (Crescent)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 28, E'तलका मध्ये कुन आकार अरू भन्दा भिन्न छ?', E'समबाहु त्रिभुज (Equilateral Triangle)', E'वर्ग (Square)', E'आयत (Rectangle)', E'चन्द्रमा आकार (Crescent)', E'D', E'चन्द्रमा आकार वक्र रेखाबाट बनेको हुन्छ, जबकि अन्य सबै सिधा रेखाहरूबाट बनेका हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन आकार अरू भन्दा भिन्न छ?|A:समबाहु त्रिभुज (Equilateral Triangle)|B:वर्ग (Square)|C:आयत (Rectangle)|D:चन्द्रमा आकार (Crescent)'), v_set_id, v_q_id, 28)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएका विकल्पहरूमध्ये कुन फरक छ?|A:वृत्त (Circle)|B:पञ्चभुज (Pentagon)|C:षट्भुज (Hexagon)|D:अष्टभुज (Octagon)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 29, E'दिइएका विकल्पहरूमध्ये कुन फरक छ?', E'वृत्त (Circle)', E'पञ्चभुज (Pentagon)', E'षट्भुज (Hexagon)', E'अष्टभुज (Octagon)', E'A', E'वृत्त वक्र रेखाबाट बनेको हुन्छ, जबकि अन्य सबै सिधा रेखाहरूबाट बनेका हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएका विकल्पहरूमध्ये कुन फरक छ?|A:वृत्त (Circle)|B:पञ्चभुज (Pentagon)|C:षट्भुज (Hexagon)|D:अष्टभुज (Octagon)'), v_set_id, v_q_id, 29)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुन ज्यामितीय आकृति अरू भन्दा फरक छ?|A:तारा (Star)|B:अण्डाकार (Ellipse)|C:त्रिभुज (Triangle)|D:वर्ग (Square)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 30, E'कुन ज्यामितीय आकृति अरू भन्दा फरक छ?', E'तारा (Star)', E'अण्डाकार (Ellipse)', E'त्रिभुज (Triangle)', E'वर्ग (Square)', E'B', E'अण्डाकार वक्र रेखाबाट बनेको हुन्छ, जबकि अन्य सबै सिधा रेखाहरूबाट बनेका हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुन ज्यामितीय आकृति अरू भन्दा फरक छ?|A:तारा (Star)|B:अण्डाकार (Ellipse)|C:त्रिभुज (Triangle)|D:वर्ग (Square)'), v_set_id, v_q_id, 30)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: स्थानिक तथा प्रत्यक्षात्मक क्षमताः Odd One Out - खण्ड 3 (आधारभूत तह) (30 Q)
  v_set_id := extensions.uuid_generate_v5('96ee3c21-fa8a-4f7e-bc81-11eb02607561'::uuid, E'स्थानिक तथा प्रत्यक्षात्मक क्षमताः Odd One Out - खण्ड 3 (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '69c87a98-20d9-4fd7-a596-37eaa6fdc55b'::uuid, '96ee3c21-fa8a-4f7e-bc81-11eb02607561'::uuid, E'स्थानिक तथा प्रत्यक्षात्मक क्षमताः Odd One Out - खण्ड 3 (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '96ee3c21-fa8a-4f7e-bc81-11eb02607561'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन आकार अन्य भन्दा फरक छ?|A:त्रिभुज (३ भुज)|B:वर्ग (४ भुज)|C:षट्भुज (६ भुज)|D:अष्टभुज (८ भुज)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'तलका मध्ये कुन आकार अन्य भन्दा फरक छ?', E'त्रिभुज (३ भुज)', E'वर्ग (४ भुज)', E'षट्भुज (६ भुज)', E'अष्टभुज (८ भुज)', E'A', E'त्रिभुजमा बिजोर संख्यामा (३) भुजाहरू हुन्छन्, जबकि अन्य सबैमा जोर संख्यामा (४, ६, ८) भुजाहरू हुन्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन आकार अन्य भन्दा फरक छ?|A:त्रिभुज (३ भुज)|B:वर्ग (४ भुज)|C:षट्भुज (६ भुज)|D:अष्टभुज (८ भुज)'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएका विकल्पहरूमध्ये कुन समूहमा मिल्दैन?|A:दशभुज (१० भुज)|B:पञ्चभुज (५ भुज)|C:वर्ग (४ भुज)|D:षट्भुज (६ भुज)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'दिइएका विकल्पहरूमध्ये कुन समूहमा मिल्दैन?', E'दशभुज (१० भुज)', E'पञ्चभुज (५ भुज)', E'वर्ग (४ भुज)', E'षट्भुज (६ भुज)', E'B', E'पञ्चभुजमा बिजोर संख्यामा (५) भुजाहरू हुन्छन्, जबकि अन्य सबैमा जोर संख्यामा भुजाहरू हुन्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएका विकल्पहरूमध्ये कुन समूहमा मिल्दैन?|A:दशभुज (१० भुज)|B:पञ्चभुज (५ भुज)|C:वर्ग (४ भुज)|D:षट्भुज (६ भुज)'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुन बहुभुज अरू भन्दा फरक छ?|A:अष्टभुज (८ भुज)|B:दशभुज (१० भुज)|C:सप्तभुज (७ भुज)|D:वर्ग (४ भुज)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'कुन बहुभुज अरू भन्दा फरक छ?', E'अष्टभुज (८ भुज)', E'दशभुज (१० भुज)', E'सप्तभुज (७ भुज)', E'वर्ग (४ भुज)', E'C', E'सप्तभुजमा बिजोर संख्यामा (७) भुजाहरू हुन्छन्, जबकि अन्य सबैमा जोर संख्यामा भुजाहरू हुन्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुन बहुभुज अरू भन्दा फरक छ?|A:अष्टभुज (८ भुज)|B:दशभुज (१० भुज)|C:सप्तभुज (७ भुज)|D:वर्ग (४ भुज)'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन विकल्प भिन्न छ?|A:षट्भुज (६ भुज)|B:अष्टभुज (८ भुज)|C:दशभुज (१० भुज)|D:नवभुज (९ भुज)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'तलका मध्ये कुन विकल्प भिन्न छ?', E'षट्भुज (६ भुज)', E'अष्टभुज (८ भुज)', E'दशभुज (१० भुज)', E'नवभुज (९ भुज)', E'D', E'नवभुजमा बिजोर संख्यामा (९) भुजाहरू हुन्छन्, जबकि अन्य सबैमा जोर संख्यामा भुजाहरू हुन्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन विकल्प भिन्न छ?|A:षट्भुज (६ भुज)|B:अष्टभुज (८ भुज)|C:दशभुज (१० भुज)|D:नवभुज (९ भुज)'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुन आकृति अन्य भन्दा फरक प्रकारको हो?|A:त्रिभुज (३ भुज)|B:वर्ग (४ भुज)|C:षट्भुज (६ भुज)|D:अष्टभुज (८ भुज)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'कुन आकृति अन्य भन्दा फरक प्रकारको हो?', E'त्रिभुज (३ भुज)', E'वर्ग (४ भुज)', E'षट्भुज (६ भुज)', E'अष्टभुज (८ भुज)', E'A', E'त्रिभुजमा बिजोर संख्यामा भुजाहरू हुन्छन्, जबकि अन्य सबैमा जोर संख्यामा भुजाहरू हुन्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुन आकृति अन्य भन्दा फरक प्रकारको हो?|A:त्रिभुज (३ भुज)|B:वर्ग (४ भुज)|C:षट्भुज (६ भुज)|D:अष्टभुज (८ भुज)'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएका मध्ये कुन विकल्प अन्य भन्दा फरक छ?|A:दशभुज (१० भुज)|B:पञ्चभुज (५ भुज)|C:वर्ग (४ भुज)|D:षट्भुज (६ भुज)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'दिइएका मध्ये कुन विकल्प अन्य भन्दा फरक छ?', E'दशभुज (१० भुज)', E'पञ्चभुज (५ भुज)', E'वर्ग (४ भुज)', E'षट्भुज (६ भुज)', E'B', E'पञ्चभुजमा बिजोर संख्यामा भुजाहरू हुन्छन्, जबकि अन्य सबैमा जोर संख्यामा भुजाहरू हुन्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएका मध्ये कुन विकल्प अन्य भन्दा फरक छ?|A:दशभुज (१० भुज)|B:पञ्चभुज (५ भुज)|C:वर्ग (४ भुज)|D:षट्भुज (६ भुज)'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने चित्रको नाम छान्नुहोस्।|A:अष्टभुज (८ भुज)|B:दशभुज (१० भुज)|C:सप्तभुज (७ भुज)|D:वर्ग (४ भुज)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'समूहमा नमिल्ने चित्रको नाम छान्नुहोस्।', E'अष्टभुज (८ भुज)', E'दशभुज (१० भुज)', E'सप्तभुज (७ भुज)', E'वर्ग (४ भुज)', E'C', E'सप्तभुजमा बिजोर संख्यामा भुजाहरू हुन्छन्, जबकि अन्य सबैमा जोर संख्यामा भुजाहरू हुन्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने चित्रको नाम छान्नुहोस्।|A:अष्टभुज (८ भुज)|B:दशभुज (१० भुज)|C:सप्तभुज (७ भुज)|D:वर्ग (४ भुज)'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन आकार अरू भन्दा भिन्न छ?|A:षट्भुज (६ भुज)|B:अष्टभुज (८ भुज)|C:दशभुज (१० भुज)|D:नवभुज (९ भुज)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'तलका मध्ये कुन आकार अरू भन्दा भिन्न छ?', E'षट्भुज (६ भुज)', E'अष्टभुज (८ भुज)', E'दशभुज (१० भुज)', E'नवभुज (९ भुज)', E'D', E'नवभुजमा बिजोर संख्यामा भुजाहरू हुन्छन्, जबकि अन्य सबैमा जोर संख्यामा भुजाहरू हुन्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन आकार अरू भन्दा भिन्न छ?|A:षट्भुज (६ भुज)|B:अष्टभुज (८ भुज)|C:दशभुज (१० भुज)|D:नवभुज (९ भुज)'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएका विकल्पहरूमध्ये कुन फरक छ?|A:त्रिभुज (३ भुज)|B:वर्ग (४ भुज)|C:अष्टभुज (८ भुज)|D:दशभुज (१० भुज)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'दिइएका विकल्पहरूमध्ये कुन फरक छ?', E'त्रिभुज (३ भुज)', E'वर्ग (४ भुज)', E'अष्टभुज (८ भुज)', E'दशभुज (१० भुज)', E'A', E'त्रिभुजमा बिजोर संख्यामा भुजाहरू हुन्छन्, जबकि अन्य सबैमा जोर संख्यामा भुजाहरू हुन्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएका विकल्पहरूमध्ये कुन फरक छ?|A:त्रिभुज (३ भुज)|B:वर्ग (४ भुज)|C:अष्टभुज (८ भुज)|D:दशभुज (१० भुज)'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुन ज्यामितीय आकृति अरू भन्दा फरक छ?|A:षट्भुज (६ भुज)|B:पञ्चभुज (५ भुज)|C:वर्ग (४ भुज)|D:अष्टभुज (८ भुज)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'कुन ज्यामितीय आकृति अरू भन्दा फरक छ?', E'षट्भुज (६ भुज)', E'पञ्चभुज (५ भुज)', E'वर्ग (४ भुज)', E'अष्टभुज (८ भुज)', E'B', E'पञ्चभुजमा बिजोर संख्यामा भुजाहरू हुन्छन्, जबकि अन्य सबैमा जोर संख्यामा भुजाहरू हुन्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुन ज्यामितीय आकृति अरू भन्दा फरक छ?|A:षट्भुज (६ भुज)|B:पञ्चभुज (५ भुज)|C:वर्ग (४ भुज)|D:अष्टभुज (८ भुज)'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन बहुभुज अन्य भन्दा फरक छ?|A:त्रिभुज (३ भुज)|B:पञ्चभुज (५ भुज)|C:वर्ग (४ भुज)|D:सप्तभुज (७ भुज)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'तलका मध्ये कुन बहुभुज अन्य भन्दा फरक छ?', E'त्रिभुज (३ भुज)', E'पञ्चभुज (५ भुज)', E'वर्ग (४ भुज)', E'सप्तभुज (७ भुज)', E'C', E'वर्गमा जोर संख्यामा (४) भुजाहरू हुन्छन्, जबकि अन्य सबैमा बिजोर संख्यामा (३, ५, ७) भुजाहरू हुन्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन बहुभुज अन्य भन्दा फरक छ?|A:त्रिभुज (३ भुज)|B:पञ्चभुज (५ भुज)|C:वर्ग (४ भुज)|D:सप्तभुज (७ भुज)'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएका विकल्पहरूमध्ये कुन समूहमा मिल्दैन?|A:नवभुज (९ भुज)|B:त्रिभुज (३ भुज)|C:पञ्चभुज (५ भुज)|D:षट्भुज (६ भुज)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'दिइएका विकल्पहरूमध्ये कुन समूहमा मिल्दैन?', E'नवभुज (९ भुज)', E'त्रिभुज (३ भुज)', E'पञ्चभुज (५ भुज)', E'षट्भुज (६ भुज)', E'D', E'षट्भुजमा जोर संख्यामा (६) भुजाहरू हुन्छन्, जबकि अन्य सबैमा बिजोर संख्यामा भुजाहरू हुन्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएका विकल्पहरूमध्ये कुन समूहमा मिल्दैन?|A:नवभुज (९ भुज)|B:त्रिभुज (३ भुज)|C:पञ्चभुज (५ भुज)|D:षट्भुज (६ भुज)'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुन बहुभुज अरू भन्दा फरक छ?|A:अष्टभुज (८ भुज)|B:सप्तभुज (७ भुज)|C:नवभुज (९ भुज)|D:त्रिभुज (३ भुज)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'कुन बहुभुज अरू भन्दा फरक छ?', E'अष्टभुज (८ भुज)', E'सप्तभुज (७ भुज)', E'नवभुज (९ भुज)', E'त्रिभुज (३ भुज)', E'A', E'अष्टभुजमा जोर संख्यामा (८) भुजाहरू हुन्छन्, जबकि अन्य सबैमा बिजोर संख्यामा भुजाहरू हुन्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुन बहुभुज अरू भन्दा फरक छ?|A:अष्टभुज (८ भुज)|B:सप्तभुज (७ भुज)|C:नवभुज (९ भुज)|D:त्रिभुज (३ भुज)'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन विकल्प भिन्न छ?|A:पञ्चभुज (५ भुज)|B:दशभुज (१० भुज)|C:सप्तभुज (७ भुज)|D:नवभुज (९ भुज)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'तलका मध्ये कुन विकल्प भिन्न छ?', E'पञ्चभुज (५ भुज)', E'दशभुज (१० भुज)', E'सप्तभुज (७ भुज)', E'नवभुज (९ भुज)', E'B', E'दशभुजमा जोर संख्यामा (१०) भुजाहरू हुन्छन्, जबकि अन्य सबैमा बिजोर संख्यामा भुजाहरू हुन्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन विकल्प भिन्न छ?|A:पञ्चभुज (५ भुज)|B:दशभुज (१० भुज)|C:सप्तभुज (७ भुज)|D:नवभुज (९ भुज)'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुन आकृति अन्य भन्दा फरक प्रकारको हो?|A:त्रिभुज (३ भुज)|B:पञ्चभुज (५ भुज)|C:वर्ग (४ भुज)|D:सप्तभुज (७ भुज)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'कुन आकृति अन्य भन्दा फरक प्रकारको हो?', E'त्रिभुज (३ भुज)', E'पञ्चभुज (५ भुज)', E'वर्ग (४ भुज)', E'सप्तभुज (७ भुज)', E'C', E'वर्गमा जोर संख्यामा भुजाहरू हुन्छन्, जबकि अन्य सबैमा बिजोर संख्यामा भुजाहरू हुन्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुन आकृति अन्य भन्दा फरक प्रकारको हो?|A:त्रिभुज (३ भुज)|B:पञ्चभुज (५ भुज)|C:वर्ग (४ भुज)|D:सप्तभुज (७ भुज)'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएका मध्ये कुन विकल्प अन्य भन्दा फरक छ?|A:नवभुज (९ भुज)|B:त्रिभुज (३ भुज)|C:पञ्चभुज (५ भुज)|D:षट्भुज (६ भुज)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'दिइएका मध्ये कुन विकल्प अन्य भन्दा फरक छ?', E'नवभुज (९ भुज)', E'त्रिभुज (३ भुज)', E'पञ्चभुज (५ भुज)', E'षट्भुज (६ भुज)', E'D', E'षट्भुजमा जोर संख्यामा भुजाहरू हुन्छन्, जबकि अन्य सबैमा बिजोर संख्यामा भुजाहरू हुन्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएका मध्ये कुन विकल्प अन्य भन्दा फरक छ?|A:नवभुज (९ भुज)|B:त्रिभुज (३ भुज)|C:पञ्चभुज (५ भुज)|D:षट्भुज (६ भुज)'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने चित्रको नाम छान्नुहोस्।|A:अष्टभुज (८ भुज)|B:सप्तभुज (७ भुज)|C:नवभुज (९ भुज)|D:त्रिभुज (३ भुज)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'समूहमा नमिल्ने चित्रको नाम छान्नुहोस्।', E'अष्टभुज (८ भुज)', E'सप्तभुज (७ भुज)', E'नवभुज (९ भुज)', E'त्रिभुज (३ भुज)', E'A', E'अष्टभुजमा जोर संख्यामा भुजाहरू हुन्छन्, जबकि अन्य सबैमा बिजोर संख्यामा भुजाहरू हुन्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने चित्रको नाम छान्नुहोस्।|A:अष्टभुज (८ भुज)|B:सप्तभुज (७ भुज)|C:नवभुज (९ भुज)|D:त्रिभुज (३ भुज)'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन आकार अरू भन्दा भिन्न छ?|A:पञ्चभुज (५ भुज)|B:दशभुज (१० भुज)|C:सप्तभुज (७ भुज)|D:नवभुज (९ भुज)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'तलका मध्ये कुन आकार अरू भन्दा भिन्न छ?', E'पञ्चभुज (५ भुज)', E'दशभुज (१० भुज)', E'सप्तभुज (७ भुज)', E'नवभुज (९ भुज)', E'B', E'दशभुजमा जोर संख्यामा भुजाहरू हुन्छन्, जबकि अन्य सबैमा बिजोर संख्यामा भुजाहरू हुन्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन आकार अरू भन्दा भिन्न छ?|A:पञ्चभुज (५ भुज)|B:दशभुज (१० भुज)|C:सप्तभुज (७ भुज)|D:नवभुज (९ भुज)'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएका विकल्पहरूमध्ये कुन फरक छ?|A:त्रिभुज (३ भुज)|B:पञ्चभुज (५ भुज)|C:वर्ग (४ भुज)|D:नवभुज (९ भुज)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'दिइएका विकल्पहरूमध्ये कुन फरक छ?', E'त्रिभुज (३ भुज)', E'पञ्चभुज (५ भुज)', E'वर्ग (४ भुज)', E'नवभुज (९ भुज)', E'C', E'वर्गमा जोर संख्यामा भुजाहरू हुन्छन्, जबकि अन्य सबैमा बिजोर संख्यामा भुजाहरू हुन्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएका विकल्पहरूमध्ये कुन फरक छ?|A:त्रिभुज (३ भुज)|B:पञ्चभुज (५ भुज)|C:वर्ग (४ भुज)|D:नवभुज (९ भुज)'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुन ज्यामितीय आकृति अरू भन्दा फरक छ?|A:सप्तभुज (७ भुज)|B:नवभुज (९ भुज)|C:त्रिभुज (३ भुज)|D:षट्भुज (६ भुज)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 20, E'कुन ज्यामितीय आकृति अरू भन्दा फरक छ?', E'सप्तभुज (७ भुज)', E'नवभुज (९ भुज)', E'त्रिभुज (३ भुज)', E'षट्भुज (६ भुज)', E'D', E'षट्भुजमा जोर संख्यामा भुजाहरू हुन्छन्, जबकि अन्य सबैमा बिजोर संख्यामा भुजाहरू हुन्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुन ज्यामितीय आकृति अरू भन्दा फरक छ?|A:सप्तभुज (७ भुज)|B:नवभुज (९ भुज)|C:त्रिभुज (३ भुज)|D:षट्भुज (६ भुज)'), v_set_id, v_q_id, 20)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएका अक्षरहरू (जसलाई चित्रको रूपमा मान्न सकिन्छ) मध्ये कुन फरक छ?|A:F|B:A|C:H|D:M');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 21, E'दिइएका अक्षरहरू (जसलाई चित्रको रूपमा मान्न सकिन्छ) मध्ये कुन फरक छ?', E'F', E'A', E'H', E'M', E'A', E'अक्षर ''F'' मा ठाडो सममिति (Vertical Symmetry) छैन, जबकि अन्य सबै अक्षरहरू ठाडो रूपमा सममित (Symmetrical) छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएका अक्षरहरू (जसलाई चित्रको रूपमा मान्न सकिन्छ) मध्ये कुन फरक छ?|A:F|B:A|C:H|D:M'), v_set_id, v_q_id, 21)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन विकल्प भिन्न छ?|A:I|B:G|C:O|D:T');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 22, E'तलका मध्ये कुन विकल्प भिन्न छ?', E'I', E'G', E'O', E'T', E'B', E'अक्षर ''G'' मा ठाडो सममिति छैन, जबकि अन्य सबै अक्षरहरू ठाडो रूपमा सममित छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन विकल्प भिन्न छ?|A:I|B:G|C:O|D:T'), v_set_id, v_q_id, 22)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने अक्षर कुन हो?|A:U|B:V|C:J|D:W');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 23, E'समूहमा नमिल्ने अक्षर कुन हो?', E'U', E'V', E'J', E'W', E'C', E'अक्षर ''J'' मा ठाडो सममिति छैन, जबकि अन्य सबै अक्षरहरू ठाडो रूपमा सममित छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने अक्षर कुन हो?|A:U|B:V|C:J|D:W'), v_set_id, v_q_id, 23)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएका मध्ये कुन विकल्प अन्य भन्दा फरक छ?|A:X|B:Y|C:M|D:L');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 24, E'दिइएका मध्ये कुन विकल्प अन्य भन्दा फरक छ?', E'X', E'Y', E'M', E'L', E'D', E'अक्षर ''L'' मा ठाडो सममिति छैन, जबकि अन्य सबै अक्षरहरू ठाडो रूपमा सममित छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएका मध्ये कुन विकल्प अन्य भन्दा फरक छ?|A:X|B:Y|C:M|D:L'), v_set_id, v_q_id, 24)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुन अक्षर अरू भन्दा फरक प्रकारको हो?|A:N|B:A|C:H|D:I');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 25, E'कुन अक्षर अरू भन्दा फरक प्रकारको हो?', E'N', E'A', E'H', E'I', E'A', E'अक्षर ''N'' मा ठाडो सममिति छैन, जबकि अन्य सबै अक्षरहरू ठाडो रूपमा सममित छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुन अक्षर अरू भन्दा फरक प्रकारको हो?|A:N|B:A|C:H|D:I'), v_set_id, v_q_id, 25)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन अक्षर समूहमा मिल्दैन?|A:O|B:P|C:T|D:U');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 26, E'तलका मध्ये कुन अक्षर समूहमा मिल्दैन?', E'O', E'P', E'T', E'U', E'B', E'अक्षर ''P'' मा ठाडो सममिति छैन, जबकि अन्य सबै अक्षरहरू ठाडो रूपमा सममित छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन अक्षर समूहमा मिल्दैन?|A:O|B:P|C:T|D:U'), v_set_id, v_q_id, 26)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएका विकल्पहरूमध्ये कुन फरक छ?|A:V|B:W|C:Q|D:X');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 27, E'दिइएका विकल्पहरूमध्ये कुन फरक छ?', E'V', E'W', E'Q', E'X', E'C', E'अक्षर ''Q'' मा ठाडो सममिति छैन, जबकि अन्य सबै अक्षरहरू ठाडो रूपमा सममित छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएका विकल्पहरूमध्ये कुन फरक छ?|A:V|B:W|C:Q|D:X'), v_set_id, v_q_id, 27)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुन अक्षर अरू भन्दा भिन्न छ?|A:Y|B:A|C:H|D:R');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 28, E'कुन अक्षर अरू भन्दा भिन्न छ?', E'Y', E'A', E'H', E'R', E'D', E'अक्षर ''R'' मा ठाडो सममिति छैन, जबकि अन्य सबै अक्षरहरू ठाडो रूपमा सममित छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुन अक्षर अरू भन्दा भिन्न छ?|A:Y|B:A|C:H|D:R'), v_set_id, v_q_id, 28)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने विकल्प छान्नुहोस्।|A:S|B:I|C:M|D:O');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 29, E'समूहमा नमिल्ने विकल्प छान्नुहोस्।', E'S', E'I', E'M', E'O', E'A', E'अक्षर ''S'' मा ठाडो सममिति छैन, जबकि अन्य सबै अक्षरहरू ठाडो रूपमा सममित छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने विकल्प छान्नुहोस्।|A:S|B:I|C:M|D:O'), v_set_id, v_q_id, 29)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन अक्षर अन्य भन्दा फरक छ?|A:T|B:Z|C:U|D:V');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 30, E'तलका मध्ये कुन अक्षर अन्य भन्दा फरक छ?', E'T', E'Z', E'U', E'V', E'B', E'अक्षर ''Z'' मा ठाडो सममिति छैन, जबकि अन्य सबै अक्षरहरू ठाडो रूपमा सममित छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन अक्षर अन्य भन्दा फरक छ?|A:T|B:Z|C:U|D:V'), v_set_id, v_q_id, 30)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: स्थानिक तथा प्रत्यक्षात्मक क्षमताः Odd One Out - खण्ड 4 (आधारभूत तह) (30 Q)
  v_set_id := extensions.uuid_generate_v5('96ee3c21-fa8a-4f7e-bc81-11eb02607561'::uuid, E'स्थानिक तथा प्रत्यक्षात्मक क्षमताः Odd One Out - खण्ड 4 (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '69c87a98-20d9-4fd7-a596-37eaa6fdc55b'::uuid, '96ee3c21-fa8a-4f7e-bc81-11eb02607561'::uuid, E'स्थानिक तथा प्रत्यक्षात्मक क्षमताः Odd One Out - खण्ड 4 (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '96ee3c21-fa8a-4f7e-bc81-11eb02607561'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुन अक्षरको तेर्सो सममिति (Horizontal Symmetry) वा पानीको प्रतिबिम्ब फरक हुन्छ?|A:A|B:B|C:C|D:D');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'कुन अक्षरको तेर्सो सममिति (Horizontal Symmetry) वा पानीको प्रतिबिम्ब फरक हुन्छ?', E'A', E'B', E'C', E'D', E'A', E'अक्षर ''A'' मा तेर्सो सममिति (Horizontal Symmetry) छैन (पानीमा उल्टो देखिन्छ), जबकि अन्य सबै अक्षरहरू तेर्सो रूपमा सममित छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुन अक्षरको तेर्सो सममिति (Horizontal Symmetry) वा पानीको प्रतिबिम्ब फरक हुन्छ?|A:A|B:B|C:C|D:D'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएका अक्षरहरूमध्ये कुन फरक छ?|A:E|B:F|C:H|D:I');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'दिइएका अक्षरहरूमध्ये कुन फरक छ?', E'E', E'F', E'H', E'I', E'B', E'अक्षर ''F'' मा तेर्सो सममिति छैन, जबकि अन्य सबै अक्षरहरू तेर्सो रूपमा सममित छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएका अक्षरहरूमध्ये कुन फरक छ?|A:E|B:F|C:H|D:I'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन विकल्प भिन्न छ?|A:K|B:O|C:G|D:X');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'तलका मध्ये कुन विकल्प भिन्न छ?', E'K', E'O', E'G', E'X', E'C', E'अक्षर ''G'' मा तेर्सो सममिति छैन, जबकि अन्य सबै अक्षरहरू तेर्सो रूपमा सममित छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन विकल्प भिन्न छ?|A:K|B:O|C:G|D:X'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने अक्षर कुन हो?|A:B|B:C|C:D|D:J');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'समूहमा नमिल्ने अक्षर कुन हो?', E'B', E'C', E'D', E'J', E'D', E'अक्षर ''J'' मा तेर्सो सममिति छैन, जबकि अन्य सबै अक्षरहरू तेर्सो रूपमा सममित छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने अक्षर कुन हो?|A:B|B:C|C:D|D:J'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएका मध्ये कुन विकल्प अन्य भन्दा फरक छ?|A:L|B:E|C:H|D:I');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'दिइएका मध्ये कुन विकल्प अन्य भन्दा फरक छ?', E'L', E'E', E'H', E'I', E'A', E'अक्षर ''L'' मा तेर्सो सममिति छैन, जबकि अन्य सबै अक्षरहरू तेर्सो रूपमा सममित छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएका मध्ये कुन विकल्प अन्य भन्दा फरक छ?|A:L|B:E|C:H|D:I'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुन अक्षर अरू भन्दा फरक प्रकारको हो?|A:K|B:N|C:O|D:X');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'कुन अक्षर अरू भन्दा फरक प्रकारको हो?', E'K', E'N', E'O', E'X', E'B', E'अक्षर ''N'' मा तेर्सो सममिति छैन, जबकि अन्य सबै अक्षरहरू तेर्सो रूपमा सममित छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुन अक्षर अरू भन्दा फरक प्रकारको हो?|A:K|B:N|C:O|D:X'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन अक्षर समूहमा मिल्दैन?|A:B|B:C|C:P|D:D');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'तलका मध्ये कुन अक्षर समूहमा मिल्दैन?', E'B', E'C', E'P', E'D', E'C', E'अक्षर ''P'' मा तेर्सो सममिति छैन, जबकि अन्य सबै अक्षरहरू तेर्सो रूपमा सममित छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन अक्षर समूहमा मिल्दैन?|A:B|B:C|C:P|D:D'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएका विकल्पहरूमध्ये कुन फरक छ?|A:E|B:H|C:I|D:Q');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'दिइएका विकल्पहरूमध्ये कुन फरक छ?', E'E', E'H', E'I', E'Q', E'D', E'अक्षर ''Q'' मा तेर्सो सममिति छैन, जबकि अन्य सबै अक्षरहरू तेर्सो रूपमा सममित छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएका विकल्पहरूमध्ये कुन फरक छ?|A:E|B:H|C:I|D:Q'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुन अक्षर अरू भन्दा भिन्न छ?|A:R|B:K|C:O|D:X');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'कुन अक्षर अरू भन्दा भिन्न छ?', E'R', E'K', E'O', E'X', E'A', E'अक्षर ''R'' मा तेर्सो सममिति छैन, जबकि अन्य सबै अक्षरहरू तेर्सो रूपमा सममित छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुन अक्षर अरू भन्दा भिन्न छ?|A:R|B:K|C:O|D:X'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने विकल्प छान्नुहोस्।|A:B|B:S|C:C|D:D');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'समूहमा नमिल्ने विकल्प छान्नुहोस्।', E'B', E'S', E'C', E'D', E'B', E'अक्षर ''S'' मा तेर्सो सममिति छैन, जबकि अन्य सबै अक्षरहरू तेर्सो रूपमा सममित छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने विकल्प छान्नुहोस्।|A:B|B:S|C:C|D:D'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन ज्यामितीय आकृति अन्य भन्दा फरक छ?|A:वृत्त (Circle)|B:वर्ग (Square)|C:कोण (Angle)|D:आयत (Rectangle)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'तलका मध्ये कुन ज्यामितीय आकृति अन्य भन्दा फरक छ?', E'वृत्त (Circle)', E'वर्ग (Square)', E'कोण (Angle)', E'आयत (Rectangle)', E'C', E'कोण एउटा खुल्ला आकृति (Open figure) हो, जबकि अन्य सबै बन्द आकृतिहरू (Closed figures) हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन ज्यामितीय आकृति अन्य भन्दा फरक छ?|A:वृत्त (Circle)|B:वर्ग (Square)|C:कोण (Angle)|D:आयत (Rectangle)'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएका विकल्पहरूमध्ये कुन समूहमा मिल्दैन?|A:त्रिभुज (Triangle)|B:पञ्चभुज (Pentagon)|C:षट्भुज (Hexagon)|D:चाप (Arc)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'दिइएका विकल्पहरूमध्ये कुन समूहमा मिल्दैन?', E'त्रिभुज (Triangle)', E'पञ्चभुज (Pentagon)', E'षट्भुज (Hexagon)', E'चाप (Arc)', E'D', E'चाप खुल्ला आकृति हो, जबकि अन्य सबै बन्द आकृतिहरू हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएका विकल्पहरूमध्ये कुन समूहमा मिल्दैन?|A:त्रिभुज (Triangle)|B:पञ्चभुज (Pentagon)|C:षट्भुज (Hexagon)|D:चाप (Arc)'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुन आकृति अरू भन्दा फरक छ?|A:सिधा रेखा (Line)|B:अष्टभुज (Octagon)|C:वृत्त (Circle)|D:वर्ग (Square)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'कुन आकृति अरू भन्दा फरक छ?', E'सिधा रेखा (Line)', E'अष्टभुज (Octagon)', E'वृत्त (Circle)', E'वर्ग (Square)', E'A', E'सिधा रेखा खुल्ला आकृति हो, जबकि अन्य सबै बन्द आकृतिहरू हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुन आकृति अरू भन्दा फरक छ?|A:सिधा रेखा (Line)|B:अष्टभुज (Octagon)|C:वृत्त (Circle)|D:वर्ग (Square)'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन विकल्प भिन्न छ?|A:आयत (Rectangle)|B:खुल्ला वक्र (Open Curve)|C:त्रिभुज (Triangle)|D:पञ्चभुज (Pentagon)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'तलका मध्ये कुन विकल्प भिन्न छ?', E'आयत (Rectangle)', E'खुल्ला वक्र (Open Curve)', E'त्रिभुज (Triangle)', E'पञ्चभुज (Pentagon)', E'B', E'खुल्ला वक्र खुल्ला आकृति हो, जबकि अन्य सबै बन्द आकृतिहरू हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन विकल्प भिन्न छ?|A:आयत (Rectangle)|B:खुल्ला वक्र (Open Curve)|C:त्रिभुज (Triangle)|D:पञ्चभुज (Pentagon)'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुन चित्र अन्य भन्दा फरक प्रकारको हो?|A:षट्भुज (Hexagon)|B:अष्टभुज (Octagon)|C:समानान्तर रेखाहरू (Parallel Lines)|D:वृत्त (Circle)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'कुन चित्र अन्य भन्दा फरक प्रकारको हो?', E'षट्भुज (Hexagon)', E'अष्टभुज (Octagon)', E'समानान्तर रेखाहरू (Parallel Lines)', E'वृत्त (Circle)', E'C', E'समानान्तर रेखाहरू खुल्ला आकृति हुन्, जबकि अन्य सबै बन्द आकृतिहरू हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुन चित्र अन्य भन्दा फरक प्रकारको हो?|A:षट्भुज (Hexagon)|B:अष्टभुज (Octagon)|C:समानान्तर रेखाहरू (Parallel Lines)|D:वृत्त (Circle)'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएका मध्ये कुन विकल्प अन्य भन्दा फरक छ?|A:वर्ग (Square)|B:आयत (Rectangle)|C:त्रिभुज (Triangle)|D:कोण (Angle)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'दिइएका मध्ये कुन विकल्प अन्य भन्दा फरक छ?', E'वर्ग (Square)', E'आयत (Rectangle)', E'त्रिभुज (Triangle)', E'कोण (Angle)', E'D', E'कोण खुल्ला आकृति हो, जबकि अन्य सबै बन्द आकृतिहरू हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएका मध्ये कुन विकल्प अन्य भन्दा फरक छ?|A:वर्ग (Square)|B:आयत (Rectangle)|C:त्रिभुज (Triangle)|D:कोण (Angle)'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने चित्रको नाम छान्नुहोस्।|A:चाप (Arc)|B:पञ्चभुज (Pentagon)|C:षट्भुज (Hexagon)|D:अष्टभुज (Octagon)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'समूहमा नमिल्ने चित्रको नाम छान्नुहोस्।', E'चाप (Arc)', E'पञ्चभुज (Pentagon)', E'षट्भुज (Hexagon)', E'अष्टभुज (Octagon)', E'A', E'चाप खुल्ला आकृति हो, जबकि अन्य सबै बन्द आकृतिहरू हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने चित्रको नाम छान्नुहोस्।|A:चाप (Arc)|B:पञ्चभुज (Pentagon)|C:षट्भुज (Hexagon)|D:अष्टभुज (Octagon)'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन आकार अरू भन्दा भिन्न छ?|A:वृत्त (Circle)|B:सिधा रेखा (Line)|C:वर्ग (Square)|D:आयत (Rectangle)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'तलका मध्ये कुन आकार अरू भन्दा भिन्न छ?', E'वृत्त (Circle)', E'सिधा रेखा (Line)', E'वर्ग (Square)', E'आयत (Rectangle)', E'B', E'सिधा रेखा खुल्ला आकृति हो, जबकि अन्य सबै बन्द आकृतिहरू हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन आकार अरू भन्दा भिन्न छ?|A:वृत्त (Circle)|B:सिधा रेखा (Line)|C:वर्ग (Square)|D:आयत (Rectangle)'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएका विकल्पहरूमध्ये कुन फरक छ?|A:त्रिभुज (Triangle)|B:पञ्चभुज (Pentagon)|C:खुल्ला वक्र (Open Curve)|D:षट्भुज (Hexagon)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'दिइएका विकल्पहरूमध्ये कुन फरक छ?', E'त्रिभुज (Triangle)', E'पञ्चभुज (Pentagon)', E'खुल्ला वक्र (Open Curve)', E'षट्भुज (Hexagon)', E'C', E'खुल्ला वक्र खुल्ला आकृति हो, जबकि अन्य सबै बन्द आकृतिहरू हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएका विकल्पहरूमध्ये कुन फरक छ?|A:त्रिभुज (Triangle)|B:पञ्चभुज (Pentagon)|C:खुल्ला वक्र (Open Curve)|D:षट्भुज (Hexagon)'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुन ज्यामितीय आकृति अरू भन्दा फरक छ?|A:अष्टभुज (Octagon)|B:वृत्त (Circle)|C:वर्ग (Square)|D:समानान्तर रेखाहरू (Parallel Lines)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 20, E'कुन ज्यामितीय आकृति अरू भन्दा फरक छ?', E'अष्टभुज (Octagon)', E'वृत्त (Circle)', E'वर्ग (Square)', E'समानान्तर रेखाहरू (Parallel Lines)', E'D', E'समानान्तर रेखाहरू खुल्ला आकृति हुन्, जबकि अन्य सबै बन्द आकृतिहरू हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुन ज्यामितीय आकृति अरू भन्दा फरक छ?|A:अष्टभुज (Octagon)|B:वृत्त (Circle)|C:वर्ग (Square)|D:समानान्तर रेखाहरू (Parallel Lines)'), v_set_id, v_q_id, 20)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुन आकृति अरू भन्दा भिन्न छ?|A:वर्ग (Square)|B:समबाहु त्रिभुज (Equilateral Triangle)|C:नियमित पञ्चभुज (Regular Pentagon)|D:नियमित षट्भुज (Regular Hexagon)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 21, E'कुन आकृति अरू भन्दा भिन्न छ?', E'वर्ग (Square)', E'समबाहु त्रिभुज (Equilateral Triangle)', E'नियमित पञ्चभुज (Regular Pentagon)', E'नियमित षट्भुज (Regular Hexagon)', E'A', E'वर्गमा ९० डिग्री (समकोण) हुन्छ, जबकि अन्य आकृतिहरूमा समकोण हुँदैन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुन आकृति अरू भन्दा भिन्न छ?|A:वर्ग (Square)|B:समबाहु त्रिभुज (Equilateral Triangle)|C:नियमित पञ्चभुज (Regular Pentagon)|D:नियमित षट्भुज (Regular Hexagon)'), v_set_id, v_q_id, 21)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन विकल्प अन्य भन्दा फरक छ?|A:समानान्तर चतुर्भुज (Parallelogram)|B:आयत (Rectangle)|C:समचतुर्भुज (Rhombus)|D:नियमित पञ्चभुज (Regular Pentagon)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 22, E'तलका मध्ये कुन विकल्प अन्य भन्दा फरक छ?', E'समानान्तर चतुर्भुज (Parallelogram)', E'आयत (Rectangle)', E'समचतुर्भुज (Rhombus)', E'नियमित पञ्चभुज (Regular Pentagon)', E'B', E'आयतमा ९० डिग्री (समकोण) हुन्छ, जबकि अन्य आकृतिहरूमा समकोण हुँदैन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन विकल्प अन्य भन्दा फरक छ?|A:समानान्तर चतुर्भुज (Parallelogram)|B:आयत (Rectangle)|C:समचतुर्भुज (Rhombus)|D:नियमित पञ्चभुज (Regular Pentagon)'), v_set_id, v_q_id, 22)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएका विकल्पहरूमध्ये कुन समूहमा मिल्दैन?|A:समबाहु त्रिभुज (Equilateral Triangle)|B:नियमित षट्भुज (Regular Hexagon)|C:समकोण त्रिभुज (Right-angled Triangle)|D:समचतुर्भुज (Rhombus)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 23, E'दिइएका विकल्पहरूमध्ये कुन समूहमा मिल्दैन?', E'समबाहु त्रिभुज (Equilateral Triangle)', E'नियमित षट्भुज (Regular Hexagon)', E'समकोण त्रिभुज (Right-angled Triangle)', E'समचतुर्भुज (Rhombus)', E'C', E'समकोण त्रिभुजमा एउटा ९० डिग्री (समकोण) हुन्छ, जबकि अन्य आकृतिहरूमा समकोण हुँदैन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएका विकल्पहरूमध्ये कुन समूहमा मिल्दैन?|A:समबाहु त्रिभुज (Equilateral Triangle)|B:नियमित षट्भुज (Regular Hexagon)|C:समकोण त्रिभुज (Right-angled Triangle)|D:समचतुर्भुज (Rhombus)'), v_set_id, v_q_id, 23)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुन ज्यामितीय आकृति अरू भन्दा फरक छ?|A:नियमित पञ्चभुज (Regular Pentagon)|B:समानान्तर चतुर्भुज (Parallelogram)|C:समबाहु त्रिभुज (Equilateral Triangle)|D:वर्ग (Square)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 24, E'कुन ज्यामितीय आकृति अरू भन्दा फरक छ?', E'नियमित पञ्चभुज (Regular Pentagon)', E'समानान्तर चतुर्भुज (Parallelogram)', E'समबाहु त्रिभुज (Equilateral Triangle)', E'वर्ग (Square)', E'D', E'वर्गमा ९० डिग्री (समकोण) हुन्छ, जबकि अन्य आकृतिहरूमा समकोण हुँदैन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुन ज्यामितीय आकृति अरू भन्दा फरक छ?|A:नियमित पञ्चभुज (Regular Pentagon)|B:समानान्तर चतुर्भुज (Parallelogram)|C:समबाहु त्रिभुज (Equilateral Triangle)|D:वर्ग (Square)'), v_set_id, v_q_id, 24)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन विकल्प भिन्न छ?|A:आयत (Rectangle)|B:समचतुर्भुज (Rhombus)|C:नियमित षट्भुज (Regular Hexagon)|D:समानान्तर चतुर्भुज (Parallelogram)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 25, E'तलका मध्ये कुन विकल्प भिन्न छ?', E'आयत (Rectangle)', E'समचतुर्भुज (Rhombus)', E'नियमित षट्भुज (Regular Hexagon)', E'समानान्तर चतुर्भुज (Parallelogram)', E'A', E'आयतमा ९० डिग्री (समकोण) हुन्छ, जबकि अन्य आकृतिहरूमा समकोण हुँदैन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन विकल्प भिन्न छ?|A:आयत (Rectangle)|B:समचतुर्भुज (Rhombus)|C:नियमित षट्भुज (Regular Hexagon)|D:समानान्तर चतुर्भुज (Parallelogram)'), v_set_id, v_q_id, 25)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुन आकृति अन्य भन्दा फरक प्रकारको हो?|A:समबाहु त्रिभुज (Equilateral Triangle)|B:समकोण त्रिभुज (Right-angled Triangle)|C:नियमित पञ्चभुज (Regular Pentagon)|D:समचतुर्भुज (Rhombus)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 26, E'कुन आकृति अन्य भन्दा फरक प्रकारको हो?', E'समबाहु त्रिभुज (Equilateral Triangle)', E'समकोण त्रिभुज (Right-angled Triangle)', E'नियमित पञ्चभुज (Regular Pentagon)', E'समचतुर्भुज (Rhombus)', E'B', E'समकोण त्रिभुजमा ९० डिग्री (समकोण) हुन्छ, जबकि अन्य आकृतिहरूमा समकोण हुँदैन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुन आकृति अन्य भन्दा फरक प्रकारको हो?|A:समबाहु त्रिभुज (Equilateral Triangle)|B:समकोण त्रिभुज (Right-angled Triangle)|C:नियमित पञ्चभुज (Regular Pentagon)|D:समचतुर्भुज (Rhombus)'), v_set_id, v_q_id, 26)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएका मध्ये कुन विकल्प अन्य भन्दा फरक छ?|A:समानान्तर चतुर्भुज (Parallelogram)|B:नियमित षट्भुज (Regular Hexagon)|C:वर्ग (Square)|D:समबाहु त्रिभुज (Equilateral Triangle)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 27, E'दिइएका मध्ये कुन विकल्प अन्य भन्दा फरक छ?', E'समानान्तर चतुर्भुज (Parallelogram)', E'नियमित षट्भुज (Regular Hexagon)', E'वर्ग (Square)', E'समबाहु त्रिभुज (Equilateral Triangle)', E'C', E'वर्गमा ९० डिग्री (समकोण) हुन्छ, जबकि अन्य आकृतिहरूमा समकोण हुँदैन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएका मध्ये कुन विकल्प अन्य भन्दा फरक छ?|A:समानान्तर चतुर्भुज (Parallelogram)|B:नियमित षट्भुज (Regular Hexagon)|C:वर्ग (Square)|D:समबाहु त्रिभुज (Equilateral Triangle)'), v_set_id, v_q_id, 27)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने चित्रको नाम छान्नुहोस्।|A:नियमित पञ्चभुज (Regular Pentagon)|B:समचतुर्भुज (Rhombus)|C:समानान्तर चतुर्भुज (Parallelogram)|D:आयत (Rectangle)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 28, E'समूहमा नमिल्ने चित्रको नाम छान्नुहोस्।', E'नियमित पञ्चभुज (Regular Pentagon)', E'समचतुर्भुज (Rhombus)', E'समानान्तर चतुर्भुज (Parallelogram)', E'आयत (Rectangle)', E'D', E'आयतमा ९० डिग्री (समकोण) हुन्छ, जबकि अन्य आकृतिहरूमा समकोण हुँदैन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने चित्रको नाम छान्नुहोस्।|A:नियमित पञ्चभुज (Regular Pentagon)|B:समचतुर्भुज (Rhombus)|C:समानान्तर चतुर्भुज (Parallelogram)|D:आयत (Rectangle)'), v_set_id, v_q_id, 28)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन आकार अरू भन्दा भिन्न छ?|A:समकोण त्रिभुज (Right-angled Triangle)|B:नियमित षट्भुज (Regular Hexagon)|C:समबाहु त्रिभुज (Equilateral Triangle)|D:नियमित पञ्चभुज (Regular Pentagon)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 29, E'तलका मध्ये कुन आकार अरू भन्दा भिन्न छ?', E'समकोण त्रिभुज (Right-angled Triangle)', E'नियमित षट्भुज (Regular Hexagon)', E'समबाहु त्रिभुज (Equilateral Triangle)', E'नियमित पञ्चभुज (Regular Pentagon)', E'A', E'समकोण त्रिभुजमा ९० डिग्री (समकोण) हुन्छ, जबकि अन्य आकृतिहरूमा समकोण हुँदैन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन आकार अरू भन्दा भिन्न छ?|A:समकोण त्रिभुज (Right-angled Triangle)|B:नियमित षट्भुज (Regular Hexagon)|C:समबाहु त्रिभुज (Equilateral Triangle)|D:नियमित पञ्चभुज (Regular Pentagon)'), v_set_id, v_q_id, 29)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएका विकल्पहरूमध्ये कुन फरक छ?|A:समचतुर्भुज (Rhombus)|B:वर्ग (Square)|C:समानान्तर चतुर्भुज (Parallelogram)|D:नियमित षट्भुज (Regular Hexagon)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 30, E'दिइएका विकल्पहरूमध्ये कुन फरक छ?', E'समचतुर्भुज (Rhombus)', E'वर्ग (Square)', E'समानान्तर चतुर्भुज (Parallelogram)', E'नियमित षट्भुज (Regular Hexagon)', E'B', E'वर्गमा ९० डिग्री (समकोण) हुन्छ, जबकि अन्य आकृतिहरूमा समकोण हुँदैन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएका विकल्पहरूमध्ये कुन फरक छ?|A:समचतुर्भुज (Rhombus)|B:वर्ग (Square)|C:समानान्तर चतुर्भुज (Parallelogram)|D:नियमित षट्भुज (Regular Hexagon)'), v_set_id, v_q_id, 30)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: स्थानिक तथा प्रत्यक्षात्मक क्षमताः Odd One Out - खण्ड 5 (आधारभूत तह) (8 Q)
  v_set_id := extensions.uuid_generate_v5('96ee3c21-fa8a-4f7e-bc81-11eb02607561'::uuid, E'स्थानिक तथा प्रत्यक्षात्मक क्षमताः Odd One Out - खण्ड 5 (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '69c87a98-20d9-4fd7-a596-37eaa6fdc55b'::uuid, '96ee3c21-fa8a-4f7e-bc81-11eb02607561'::uuid, E'स्थानिक तथा प्रत्यक्षात्मक क्षमताः Odd One Out - खण्ड 5 (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '96ee3c21-fa8a-4f7e-bc81-11eb02607561'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिएका कोणहरूमध्ये कुन फरक छ?|A:सरल कोण (Straight Angle)|B:न्यून कोण (Acute Angle)|C:अधिक कोण (Obtuse Angle)|D:समकोण (Right Angle)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'दिएका कोणहरूमध्ये कुन फरक छ?', E'सरल कोण (Straight Angle)', E'न्यून कोण (Acute Angle)', E'अधिक कोण (Obtuse Angle)', E'समकोण (Right Angle)', E'A', E'सरल कोण १८० डिग्रीको हुन्छ (जुन सिधा रेखा बनाउँछ), जबकि अन्य सबै कोणहरू १८० डिग्रीभन्दा साना हुन्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिएका कोणहरूमध्ये कुन फरक छ?|A:सरल कोण (Straight Angle)|B:न्यून कोण (Acute Angle)|C:अधिक कोण (Obtuse Angle)|D:समकोण (Right Angle)'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन कोण अन्य भन्दा फरक छ?|A:न्यून कोण (Acute Angle)|B:पूर्ण कोण (Complete Angle)|C:अधिक कोण (Obtuse Angle)|D:समकोण (Right Angle)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'तलका मध्ये कुन कोण अन्य भन्दा फरक छ?', E'न्यून कोण (Acute Angle)', E'पूर्ण कोण (Complete Angle)', E'अधिक कोण (Obtuse Angle)', E'समकोण (Right Angle)', E'B', E'पूर्ण कोण ३६० डिग्रीको हुन्छ, जबकि अन्य सबै कोणहरू १८० डिग्रीभन्दा साना हुन्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन कोण अन्य भन्दा फरक छ?|A:न्यून कोण (Acute Angle)|B:पूर्ण कोण (Complete Angle)|C:अधिक कोण (Obtuse Angle)|D:समकोण (Right Angle)'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएका चित्रका नामहरूमध्ये कुन फरक छ?|A:पञ्चभुज (Pentagon)|B:तारा (Star)|C:वृत्त (Circle)|D:आयत (Rectangle)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'दिइएका चित्रका नामहरूमध्ये कुन फरक छ?', E'पञ्चभुज (Pentagon)', E'तारा (Star)', E'वृत्त (Circle)', E'आयत (Rectangle)', E'C', E'वृत्तको कुनै पनि कुना (Vertex) हुँदैन, जबकि अन्य सबै आकृतिहरूमा कुनाहरू हुन्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएका चित्रका नामहरूमध्ये कुन फरक छ?|A:पञ्चभुज (Pentagon)|B:तारा (Star)|C:वृत्त (Circle)|D:आयत (Rectangle)'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुन ३D आकार अरू भन्दा फरक छ?|A:गोला (Sphere)|B:बेलना (Cylinder)|C:सोली (Cone)|D:घन (Cube)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'कुन ३D आकार अरू भन्दा फरक छ?', E'गोला (Sphere)', E'बेलना (Cylinder)', E'सोली (Cone)', E'घन (Cube)', E'D', E'घन पूर्ण रूपमा समतल सतहहरू (Flat surfaces) बाट बनेको हुन्छ, जबकि अन्य सबैमा वक्र सतह (Curved surface) हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुन ३D आकार अरू भन्दा फरक छ?|A:गोला (Sphere)|B:बेलना (Cylinder)|C:सोली (Cone)|D:घन (Cube)'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन विकल्प भिन्न छ?|A:गोला (Sphere)|B:घन (Cube)|C:घनाकार (Cuboid)|D:प्रिज्म (Prism)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'तलका मध्ये कुन विकल्प भिन्न छ?', E'गोला (Sphere)', E'घन (Cube)', E'घनाकार (Cuboid)', E'प्रिज्म (Prism)', E'A', E'गोलामा वक्र सतह हुन्छ, जबकि अन्य सबै समतल सतहहरू (Flat surfaces) बाट बनेका ३D आकृति हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन विकल्प भिन्न छ?|A:गोला (Sphere)|B:घन (Cube)|C:घनाकार (Cuboid)|D:प्रिज्म (Prism)'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुन आकृति अन्य भन्दा फरक प्रकारको हो?|A:आयत (Rectangle)|B:त्रिभुज (Triangle)|C:वर्ग (Square)|D:समचतुर्भुज (Rhombus)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'कुन आकृति अन्य भन्दा फरक प्रकारको हो?', E'आयत (Rectangle)', E'त्रिभुज (Triangle)', E'वर्ग (Square)', E'समचतुर्भुज (Rhombus)', E'B', E'त्रिभुजमा ३ वटा भुजाहरू हुन्छन्, जबकि अन्य सबै चतुर्भुज (४ वटा भुजाहरू भएका) हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुन आकृति अन्य भन्दा फरक प्रकारको हो?|A:आयत (Rectangle)|B:त्रिभुज (Triangle)|C:वर्ग (Square)|D:समचतुर्भुज (Rhombus)'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन आकार अरू भन्दा भिन्न छ?|A:समबाहु त्रिभुज (Equilateral Triangle)|B:समद्विबाहु त्रिभुज (Isosceles Triangle)|C:वर्ग (Square)|D:विषमबाहु त्रिभुज (Scalene Triangle)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'तलका मध्ये कुन आकार अरू भन्दा भिन्न छ?', E'समबाहु त्रिभुज (Equilateral Triangle)', E'समद्विबाहु त्रिभुज (Isosceles Triangle)', E'वर्ग (Square)', E'विषमबाहु त्रिभुज (Scalene Triangle)', E'C', E'वर्ग एउटा चतुर्भुज हो, जबकि अन्य सबै त्रिभुजका विभिन्न प्रकारहरू हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन आकार अरू भन्दा भिन्न छ?|A:समबाहु त्रिभुज (Equilateral Triangle)|B:समद्विबाहु त्रिभुज (Isosceles Triangle)|C:वर्ग (Square)|D:विषमबाहु त्रिभुज (Scalene Triangle)'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएका विकल्पहरूमध्ये कुन फरक छ?|A:वृत्त (Circle)|B:अर्धवृत्त (Semicircle)|C:चन्द्रमा आकार (Crescent)|D:समबाहु त्रिभुज (Equilateral Triangle)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'दिइएका विकल्पहरूमध्ये कुन फरक छ?', E'वृत्त (Circle)', E'अर्धवृत्त (Semicircle)', E'चन्द्रमा आकार (Crescent)', E'समबाहु त्रिभुज (Equilateral Triangle)', E'D', E'समबाहु त्रिभुज पूर्ण रूपमा सिधा रेखाहरूबाट बनेको हुन्छ, जबकि अन्य सबैमा वक्र रेखाहरू (Curved lines) समावेश हुन्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएका विकल्पहरूमध्ये कुन फरक छ?|A:वृत्त (Circle)|B:अर्धवृत्त (Semicircle)|C:चन्द्रमा आकार (Crescent)|D:समबाहु त्रिभुज (Equilateral Triangle)'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  RAISE NOTICE 'fix overflow complete: 10 sets, 251 questions.';
END $$;
