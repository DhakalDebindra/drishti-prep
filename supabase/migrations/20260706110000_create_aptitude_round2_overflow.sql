-- Create overflow sets for round-2 aptitude batch (verbal-5, math-2).
-- Generated 2026-07-05T14:24:36.464Z.
DO $$
DECLARE
  v_module_id uuid := '6695669a-f40e-421a-a4ec-b09bbeaf56c4'::uuid;
  v_set_id uuid;
  v_q_id uuid;
BEGIN

  -- Set: शाब्दिक बौद्धिक परीक्षणः शाब्दिक पजल र अमिल्दा शब्द - खण्ड 2 (आधारभूत तह) (30 Q)
  v_set_id := extensions.uuid_generate_v5('fa0af7e0-6bb7-4c25-b62f-d2d8ce99f610'::uuid, E'शाब्दिक बौद्धिक परीक्षणः शाब्दिक पजल र अमिल्दा शब्द - खण्ड 2 (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'efc9184a-c265-4fd8-bb99-aad431aefc58'::uuid, 'fa0af7e0-6bb7-4c25-b62f-d2d8ce99f610'::uuid, E'शाब्दिक बौद्धिक परीक्षणः शाब्दिक पजल र अमिल्दा शब्द - खण्ड 2 (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'fa0af7e0-6bb7-4c25-b62f-d2d8ce99f610'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1. धन 2. स्वास्थ्य 3. ठूलो 4. मानिसको 5. हो|A:2, 4, 3, 1, 5|B:1, 2, 3, 4, 5|C:4, 2, 3, 1, 5|D:2, 3, 4, 1, 5');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'1. धन 2. स्वास्थ्य 3. ठूलो 4. मानिसको 5. हो', E'2, 4, 3, 1, 5', E'1, 2, 3, 4, 5', E'4, 2, 3, 1, 5', E'2, 3, 4, 1, 5', E'A', E'''स्वास्थ्य मानिसको ठूलो धन हो'' सही वाक्य हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1. धन 2. स्वास्थ्य 3. ठूलो 4. मानिसको 5. हो|A:2, 4, 3, 1, 5|B:1, 2, 3, 4, 5|C:4, 2, 3, 1, 5|D:2, 3, 4, 1, 5'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1. असफलता 2. सोचले 3. नकारात्मक 4. निम्त्याउँछ|A:1, 2, 3, 4|B:3, 2, 1, 4|C:2, 3, 1, 4|D:3, 1, 2, 4');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'1. असफलता 2. सोचले 3. नकारात्मक 4. निम्त्याउँछ', E'1, 2, 3, 4', E'3, 2, 1, 4', E'2, 3, 1, 4', E'3, 1, 2, 4', E'B', E'''नकारात्मक सोचले असफलता निम्त्याउँछ'' सही वाक्य हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1. असफलता 2. सोचले 3. नकारात्मक 4. निम्त्याउँछ|A:1, 2, 3, 4|B:3, 2, 1, 4|C:2, 3, 1, 4|D:3, 1, 2, 4'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'REVOLUTION|A:VOLT|B:LION|C:RIVER|D:TORN');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'REVOLUTION', E'VOLT', E'LION', E'RIVER', E'TORN', E'C', E'RIVER मा दुईवटा ''R'' आवश्यक छ, तर REVOLUTION मा एउटा मात्र ''R'' छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:REVOLUTION|A:VOLT|B:LION|C:RIVER|D:TORN'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'COMMUNICATION|A:ACTION|B:UNION|C:MINT|D:MUSIC');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'COMMUNICATION', E'ACTION', E'UNION', E'MINT', E'MUSIC', E'D', E'MUSIC मा भएको ''S'' अक्षर COMMUNICATION मा छैन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:COMMUNICATION|A:ACTION|B:UNION|C:MINT|D:MUSIC'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'DEPARTMENT|A:PARADE|B:TENT|C:PART|D:DEER');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'DEPARTMENT', E'PARADE', E'TENT', E'PART', E'DEER', E'A', E'PARADE मा दुईवटा ''A'' आवश्यक छ, तर DEPARTMENT मा एउटा मात्र ''A'' छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:DEPARTMENT|A:PARADE|B:TENT|C:PART|D:DEER'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'ENVIRONMENT|A:IRON|B:RIVER|C:ENTER|D:MINT');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'ENVIRONMENT', E'IRON', E'RIVER', E'ENTER', E'MINT', E'B', E'RIVER मा दुईवटा ''R'' आवश्यक छ, तर ENVIRONMENT मा एउटा मात्र ''R'' छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:ENVIRONMENT|A:IRON|B:RIVER|C:ENTER|D:MINT'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'INTERNATIONAL|A:INTERNAL|B:NATION|C:RADIO|D:LION');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'INTERNATIONAL', E'INTERNAL', E'NATION', E'RADIO', E'LION', E'C', E'RADIO मा भएको ''D'' अक्षर INTERNATIONAL मा छैन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:INTERNATIONAL|A:INTERNAL|B:NATION|C:RADIO|D:LION'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'EXAMINATION|A:NATION|B:MINE|C:TIME|D:ANIMAL');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'EXAMINATION', E'NATION', E'MINE', E'TIME', E'ANIMAL', E'D', E'ANIMAL मा भएको ''L'' अक्षर EXAMINATION मा छैन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:EXAMINATION|A:NATION|B:MINE|C:TIME|D:ANIMAL'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'CONSTITUTION|A:TRACTOR|B:COIN|C:TUITION|D:UNIT');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'CONSTITUTION', E'TRACTOR', E'COIN', E'TUITION', E'UNIT', E'A', E'TRACTOR मा भएका ''R'' र ''A'' अक्षर CONSTITUTION मा छैनन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:CONSTITUTION|A:TRACTOR|B:COIN|C:TUITION|D:UNIT'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'KATHMANDU|A:HAND|B:MIND|C:TANK|D:MATH');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'KATHMANDU', E'HAND', E'MIND', E'TANK', E'MATH', E'B', E'MIND मा भएको ''I'' अक्षर KATHMANDU मा छैन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:KATHMANDU|A:HAND|B:MIND|C:TANK|D:MATH'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'EDUCATION|A:CAT|B:NOTE|C:DOG|D:COIN');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'EDUCATION', E'CAT', E'NOTE', E'DOG', E'COIN', E'C', E'DOG मा भएको ''G'' अक्षर EDUCATION मा छैन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:EDUCATION|A:CAT|B:NOTE|C:DOG|D:COIN'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'TEACHER|A:HERE|B:HEAR|C:CHEAT|D:CHAIR');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'TEACHER', E'HERE', E'HEAR', E'CHEAT', E'CHAIR', E'D', E'CHAIR मा भएको ''I'' अक्षर TEACHER मा छैन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:TEACHER|A:HERE|B:HEAR|C:CHEAT|D:CHAIR'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'GOVERNMENT|A:GOAT|B:ENTER|C:GREEN|D:TERM');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'GOVERNMENT', E'GOAT', E'ENTER', E'GREEN', E'TERM', E'A', E'GOAT मा भएको ''A'' अक्षर GOVERNMENT मा छैन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:GOVERNMENT|A:GOAT|B:ENTER|C:GREEN|D:TERM'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'BEAUTIFUL|A:TUBE|B:FULL|C:FLUTE|D:LIFE');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'BEAUTIFUL', E'TUBE', E'FULL', E'FLUTE', E'LIFE', E'B', E'FULL बनाउन ''L'' अक्षर दुई पटक चाहिन्छ, तर BEAUTIFUL मा ''L'' एक पटक मात्र छ, त्यसैले FULL बनाउन सकिँदैन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:BEAUTIFUL|A:TUBE|B:FULL|C:FLUTE|D:LIFE'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'UNIVERSITY|A:REST|B:SURE|C:NEVER|D:VERY');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'UNIVERSITY', E'REST', E'SURE', E'NEVER', E'VERY', E'C', E'NEVER मा दुईवटा ''E'' आवश्यक छ, तर UNIVERSITY मा एउटा मात्र ''E'' छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:UNIVERSITY|A:REST|B:SURE|C:NEVER|D:VERY'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'AGRICULTURE|A:GREAT|B:TRUE|C:RULE|D:GOLD');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'AGRICULTURE', E'GREAT', E'TRUE', E'RULE', E'GOLD', E'D', E'GOLD मा भएको ''O'' र ''D'' अक्षर AGRICULTURE मा छैनन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:AGRICULTURE|A:GREAT|B:TRUE|C:RULE|D:GOLD'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'TEMPERATURE|A:PAPER|B:PURE|C:TREE|D:MEET');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'TEMPERATURE', E'PAPER', E'PURE', E'TREE', E'MEET', E'A', E'PAPER मा दुईवटा ''P'' आवश्यक छ, तर TEMPERATURE मा एउटा मात्र ''P'' छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:TEMPERATURE|A:PAPER|B:PURE|C:TREE|D:MEET'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'PHOTOGRAPH|A:PHOTO|B:PAGE|C:GRAPH|D:PORT');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'PHOTOGRAPH', E'PHOTO', E'PAGE', E'GRAPH', E'PORT', E'B', E'PAGE मा भएको ''E'' अक्षर PHOTOGRAPH मा छैन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:PHOTOGRAPH|A:PHOTO|B:PAGE|C:GRAPH|D:PORT'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'KNOWLEDGE|A:KNOW|B:EDGE|C:WORLD|D:LODGE');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'KNOWLEDGE', E'KNOW', E'EDGE', E'WORLD', E'LODGE', E'C', E'WORLD मा भएको ''R'' अक्षर KNOWLEDGE मा छैन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:KNOWLEDGE|A:KNOW|B:EDGE|C:WORLD|D:LODGE'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'DICTIONARY|A:DIARY|B:RADIO|C:YARN|D:MONEY');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 20, E'DICTIONARY', E'DIARY', E'RADIO', E'YARN', E'MONEY', E'D', E'MONEY मा भएका ''M'' र ''E'' अक्षर DICTIONARY मा छैनन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:DICTIONARY|A:DIARY|B:RADIO|C:YARN|D:MONEY'), v_set_id, v_q_id, 20)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'LEADERSHIP|A:PLAY|B:LEAD|C:SHIP|D:DEAL');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 21, E'LEADERSHIP', E'PLAY', E'LEAD', E'SHIP', E'DEAL', E'A', E'PLAY मा भएको ''Y'' अक्षर LEADERSHIP मा छैन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:LEADERSHIP|A:PLAY|B:LEAD|C:SHIP|D:DEAL'), v_set_id, v_q_id, 21)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'EXPERIENCE|A:PRICE|B:EXPERT|C:PIECE|D:RICE');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 22, E'EXPERIENCE', E'PRICE', E'EXPERT', E'PIECE', E'RICE', E'B', E'EXPERT मा भएको ''T'' अक्षर EXPERIENCE मा छैन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:EXPERIENCE|A:PRICE|B:EXPERT|C:PIECE|D:RICE'), v_set_id, v_q_id, 22)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'अंग्रेजी वर्णमालामा बायाँबाट ५ औं अक्षर कुन हुन्छ?|A:D|B:F|C:E|D:G');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 23, E'अंग्रेजी वर्णमालामा बायाँबाट ५ औं अक्षर कुन हुन्छ?', E'D', E'F', E'E', E'G', E'C', E'बायाँबाट (A बाट) गन्दा ५ औं स्थानमा ''E'' पर्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:अंग्रेजी वर्णमालामा बायाँबाट ५ औं अक्षर कुन हुन्छ?|A:D|B:F|C:E|D:G'), v_set_id, v_q_id, 23)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'अंग्रेजी वर्णमालामा बायाँबाट १० औं अक्षर कुन हुन्छ?|A:I|B:K|C:L|D:J');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 24, E'अंग्रेजी वर्णमालामा बायाँबाट १० औं अक्षर कुन हुन्छ?', E'I', E'K', E'L', E'J', E'D', E'बायाँबाट १० औं स्थानमा ''J'' पर्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:अंग्रेजी वर्णमालामा बायाँबाट १० औं अक्षर कुन हुन्छ?|A:I|B:K|C:L|D:J'), v_set_id, v_q_id, 24)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'अंग्रेजी वर्णमालामा बायाँबाट १५ औं अक्षर कुन हुन्छ?|A:O|B:N|C:M|D:P');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 25, E'अंग्रेजी वर्णमालामा बायाँबाट १५ औं अक्षर कुन हुन्छ?', E'O', E'N', E'M', E'P', E'A', E'बायाँबाट १५ औं स्थानमा ''O'' पर्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:अंग्रेजी वर्णमालामा बायाँबाट १५ औं अक्षर कुन हुन्छ?|A:O|B:N|C:M|D:P'), v_set_id, v_q_id, 25)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'अंग्रेजी वर्णमालामा बायाँबाट २० औं अक्षर कुन हुन्छ?|A:S|B:T|C:U|D:V');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 26, E'अंग्रेजी वर्णमालामा बायाँबाट २० औं अक्षर कुन हुन्छ?', E'S', E'T', E'U', E'V', E'B', E'बायाँबाट २० औं स्थानमा ''T'' पर्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:अंग्रेजी वर्णमालामा बायाँबाट २० औं अक्षर कुन हुन्छ?|A:S|B:T|C:U|D:V'), v_set_id, v_q_id, 26)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'अंग्रेजी वर्णमालामा दायाँबाट (Z तर्फबाट) ५ औं अक्षर कुन हुन्छ?|A:U|B:W|C:V|D:X');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 27, E'अंग्रेजी वर्णमालामा दायाँबाट (Z तर्फबाट) ५ औं अक्षर कुन हुन्छ?', E'U', E'W', E'V', E'X', E'C', E'दायाँबाट ५ औं भनेको बायाँबाट (२७ - ५) = २२ औं अक्षर हो, जुन ''V'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:अंग्रेजी वर्णमालामा दायाँबाट (Z तर्फबाट) ५ औं अक्षर कुन हुन्छ?|A:U|B:W|C:V|D:X'), v_set_id, v_q_id, 27)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'अंग्रेजी वर्णमालामा दायाँबाट १० औं अक्षर कुन हुन्छ?|A:P|B:R|C:S|D:Q');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 28, E'अंग्रेजी वर्णमालामा दायाँबाट १० औं अक्षर कुन हुन्छ?', E'P', E'R', E'S', E'Q', E'D', E'दायाँबाट १० औं भनेको बायाँबाट (२७ - १०) = १७ औं अक्षर हो, जुन ''Q'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:अंग्रेजी वर्णमालामा दायाँबाट १० औं अक्षर कुन हुन्छ?|A:P|B:R|C:S|D:Q'), v_set_id, v_q_id, 28)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'अंग्रेजी वर्णमालामा दायाँबाट १५ औं अक्षर कुन हुन्छ?|A:L|B:K|C:M|D:N');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 29, E'अंग्रेजी वर्णमालामा दायाँबाट १५ औं अक्षर कुन हुन्छ?', E'L', E'K', E'M', E'N', E'A', E'दायाँबाट १५ औं भनेको बायाँबाट (२७ - १५) = १२ औं अक्षर हो, जुन ''L'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:अंग्रेजी वर्णमालामा दायाँबाट १५ औं अक्षर कुन हुन्छ?|A:L|B:K|C:M|D:N'), v_set_id, v_q_id, 29)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'अंग्रेजी वर्णमालामा दायाँबाट २० औं अक्षर कुन हुन्छ?|A:F|B:G|C:H|D:I');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 30, E'अंग्रेजी वर्णमालामा दायाँबाट २० औं अक्षर कुन हुन्छ?', E'F', E'G', E'H', E'I', E'B', E'दायाँबाट २० औं भनेको बायाँबाट (२७ - २०) = ७ औं अक्षर हो, जुन ''G'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:अंग्रेजी वर्णमालामा दायाँबाट २० औं अक्षर कुन हुन्छ?|A:F|B:G|C:H|D:I'), v_set_id, v_q_id, 30)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: शाब्दिक बौद्धिक परीक्षणः शाब्दिक पजल र अमिल्दा शब्द - खण्ड 3 (आधारभूत तह) (30 Q)
  v_set_id := extensions.uuid_generate_v5('fa0af7e0-6bb7-4c25-b62f-d2d8ce99f610'::uuid, E'शाब्दिक बौद्धिक परीक्षणः शाब्दिक पजल र अमिल्दा शब्द - खण्ड 3 (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'efc9184a-c265-4fd8-bb99-aad431aefc58'::uuid, 'fa0af7e0-6bb7-4c25-b62f-d2d8ce99f610'::uuid, E'शाब्दिक बौद्धिक परीक्षणः शाब्दिक पजल र अमिल्दा शब्द - खण्ड 3 (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'fa0af7e0-6bb7-4c25-b62f-d2d8ce99f610'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि अंग्रेजी वर्णमालालाई उल्टो क्रम (Z देखि A) मा लेख्ने हो भने, बायाँबाट ५ औं अक्षर कुन हुन्छ?|A:मा लेख्ने हो भने, बायाँबाट ५ औं अक्षर कुन हुन्छ?**|B:U|C:W|D:X');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'यदि अंग्रेजी वर्णमालालाई उल्टो क्रम (Z देखि A) मा लेख्ने हो भने, बायाँबाट ५ औं अक्षर कुन हुन्छ?', E'मा लेख्ने हो भने, बायाँबाट ५ औं अक्षर कुन हुन्छ?**', E'U', E'W', E'X', E'A', E'उल्टो क्रममा बायाँबाट ५ औं भनेको सामान्य क्रमको दायाँबाट ५ औं हो, जुन ''V'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि अंग्रेजी वर्णमालालाई उल्टो क्रम (Z देखि A) मा लेख्ने हो भने, बायाँबाट ५ औं अक्षर कुन हुन्छ?|A:मा लेख्ने हो भने, बायाँबाट ५ औं अक्षर कुन हुन्छ?**|B:U|C:W|D:X'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि अंग्रेजी वर्णमालालाई उल्टो क्रममा लेख्ने हो भने, बायाँबाट १० औं अक्षर कुन हुन्छ?|A:P|B:Q|C:R|D:S');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'यदि अंग्रेजी वर्णमालालाई उल्टो क्रममा लेख्ने हो भने, बायाँबाट १० औं अक्षर कुन हुन्छ?', E'P', E'Q', E'R', E'S', E'B', E'उल्टो क्रममा बायाँबाट १० औं भनेको सामान्य क्रमको दायाँबाट १० औं हो, जुन ''Q'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि अंग्रेजी वर्णमालालाई उल्टो क्रममा लेख्ने हो भने, बायाँबाट १० औं अक्षर कुन हुन्छ?|A:P|B:Q|C:R|D:S'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि अंग्रेजी वर्णमालालाई उल्टो क्रममा लेख्ने हो भने, बायाँबाट १५ औं अक्षर कुन हुन्छ?|A:K|B:M|C:L|D:N');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'यदि अंग्रेजी वर्णमालालाई उल्टो क्रममा लेख्ने हो भने, बायाँबाट १५ औं अक्षर कुन हुन्छ?', E'K', E'M', E'L', E'N', E'C', E'उल्टो क्रममा बायाँबाट १५ औं भनेको सामान्य क्रमको दायाँबाट १५ औं हो, जुन ''L'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि अंग्रेजी वर्णमालालाई उल्टो क्रममा लेख्ने हो भने, बायाँबाट १५ औं अक्षर कुन हुन्छ?|A:K|B:M|C:L|D:N'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि अंग्रेजी वर्णमालालाई उल्टो क्रममा लेख्ने हो भने, बायाँबाट २० औं अक्षर कुन हुन्छ?|A:H|B:F|C:I|D:G');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'यदि अंग्रेजी वर्णमालालाई उल्टो क्रममा लेख्ने हो भने, बायाँबाट २० औं अक्षर कुन हुन्छ?', E'H', E'F', E'I', E'G', E'D', E'उल्टो क्रममा बायाँबाट २० औं भनेको सामान्य क्रमको दायाँबाट २० औं हो, जुन ''G'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि अंग्रेजी वर्णमालालाई उल्टो क्रममा लेख्ने हो भने, बायाँबाट २० औं अक्षर कुन हुन्छ?|A:H|B:F|C:I|D:G'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'बायाँबाट ५ औं अक्षरको दायाँतर्फ ३ औं अक्षर कुन हुन्छ?|A:H|B:G|C:I|D:J');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'बायाँबाट ५ औं अक्षरको दायाँतर्फ ३ औं अक्षर कुन हुन्छ?', E'H', E'G', E'I', E'J', E'A', E'५ + ३ = ८ औं अक्षर ''H'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:बायाँबाट ५ औं अक्षरको दायाँतर्फ ३ औं अक्षर कुन हुन्छ?|A:H|B:G|C:I|D:J'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'बायाँबाट १० औं अक्षरको दायाँतर्फ ४ औं अक्षर कुन हुन्छ?|A:M|B:N|C:O|D:P');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'बायाँबाट १० औं अक्षरको दायाँतर्फ ४ औं अक्षर कुन हुन्छ?', E'M', E'N', E'O', E'P', E'B', E'१० + ४ = १४ औं अक्षर ''N'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:बायाँबाट १० औं अक्षरको दायाँतर्फ ४ औं अक्षर कुन हुन्छ?|A:M|B:N|C:O|D:P'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'बायाँबाट १५ औं अक्षरको दायाँतर्फ ५ औं अक्षर कुन हुन्छ?|A:S|B:U|C:T|D:V');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'बायाँबाट १५ औं अक्षरको दायाँतर्फ ५ औं अक्षर कुन हुन्छ?', E'S', E'U', E'T', E'V', E'C', E'१५ + ५ = २० औं अक्षर ''T'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:बायाँबाट १५ औं अक्षरको दायाँतर्फ ५ औं अक्षर कुन हुन्छ?|A:S|B:U|C:T|D:V'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दायाँबाट ५ औं अक्षरको बायाँतर्फ ३ औं अक्षर कुन हुन्छ?|A:R|B:T|C:Q|D:S');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'दायाँबाट ५ औं अक्षरको बायाँतर्फ ३ औं अक्षर कुन हुन्छ?', E'R', E'T', E'Q', E'S', E'D', E'दायाँबाट (५ + ३) = ८ औं अक्षर। बायाँबाट यो (२७ - ८) = १९ औं अक्षर ''S'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दायाँबाट ५ औं अक्षरको बायाँतर्फ ३ औं अक्षर कुन हुन्छ?|A:R|B:T|C:Q|D:S'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दायाँबाट १० औं अक्षरको बायाँतर्फ ४ औं अक्षर कुन हुन्छ?|A:M|B:N|C:L|D:O');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'दायाँबाट १० औं अक्षरको बायाँतर्फ ४ औं अक्षर कुन हुन्छ?', E'M', E'N', E'L', E'O', E'A', E'दायाँबाट (१० + ४) = १४ औं अक्षर। बायाँबाट यो (२७ - १४) = १३ औं अक्षर ''M'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दायाँबाट १० औं अक्षरको बायाँतर्फ ४ औं अक्षर कुन हुन्छ?|A:M|B:N|C:L|D:O'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दायाँबाट १५ औं अक्षरको बायाँतर्फ ५ औं अक्षर कुन हुन्छ?|A:F|B:G|C:H|D:I');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'दायाँबाट १५ औं अक्षरको बायाँतर्फ ५ औं अक्षर कुन हुन्छ?', E'F', E'G', E'H', E'I', E'B', E'दायाँबाट (१५ + ५) = २० औं अक्षर। बायाँबाट यो (२७ - २०) = ७ औं अक्षर ''G'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दायाँबाट १५ औं अक्षरको बायाँतर्फ ५ औं अक्षर कुन हुन्छ?|A:F|B:G|C:H|D:I'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''C'' र ''W'' को ठिक बीचमा पर्ने अक्षर कुन हो?|A:L|B:N|C:M|D:O');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'''C'' र ''W'' को ठिक बीचमा पर्ने अक्षर कुन हो?', E'L', E'N', E'M', E'O', E'C', E'C(३) र W(२३) को बीचमा (३+२३)/२ = १३ औं अक्षर ''M'' पर्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''C'' र ''W'' को ठिक बीचमा पर्ने अक्षर कुन हो?|A:L|B:N|C:M|D:O'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''E'' र ''O'' को ठिक बीचमा पर्ने अक्षर कुन हो?|A:I|B:K|C:L|D:J');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'''E'' र ''O'' को ठिक बीचमा पर्ने अक्षर कुन हो?', E'I', E'K', E'L', E'J', E'D', E'E(५) र O(१५) को बीचमा (५+१५)/२ = १० औं अक्षर ''J'' पर्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''E'' र ''O'' को ठिक बीचमा पर्ने अक्षर कुन हो?|A:I|B:K|C:L|D:J'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1. बिउ 2. बिरुवा 3. रुख 4. फूल 5. फल|A:1, 2, 3, 4, 5|B:2, 1, 3, 4, 5|C:1, 3, 2, 4, 5|D:3, 2, 1, 4, 5');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'1. बिउ 2. बिरुवा 3. रुख 4. फूल 5. फल', E'1, 2, 3, 4, 5', E'2, 1, 3, 4, 5', E'1, 3, 2, 4, 5', E'3, 2, 1, 4, 5', E'A', E'बिउ रोपेपछि बिरुवा, रुख, फूल र अन्त्यमा फल लाग्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1. बिउ 2. बिरुवा 3. रुख 4. फूल 5. फल|A:1, 2, 3, 4, 5|B:2, 1, 3, 4, 5|C:1, 3, 2, 4, 5|D:3, 2, 1, 4, 5'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1. जन्म 2. बाल्यकाल 3. किशोर 4. यौवन 5. वृद्ध|A:2, 3, 1, 4, 5|B:1, 2, 3, 4, 5|C:1, 3, 2, 4, 5|D:1, 2, 4, 3, 5');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'1. जन्म 2. बाल्यकाल 3. किशोर 4. यौवन 5. वृद्ध', E'2, 3, 1, 4, 5', E'1, 2, 3, 4, 5', E'1, 3, 2, 4, 5', E'1, 2, 4, 3, 5', E'B', E'यो मानव जीवनको विकासको प्राकृतिक बढ्दो क्रम हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1. जन्म 2. बाल्यकाल 3. किशोर 4. यौवन 5. वृद्ध|A:2, 3, 1, 4, 5|B:1, 2, 3, 4, 5|C:1, 3, 2, 4, 5|D:1, 2, 4, 3, 5'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1. अक्षर 2. शब्द 3. वाक्यांश 4. वाक्य 5. अनुच्छेद|A:2, 1, 3, 4, 5|B:1, 3, 2, 4, 5|C:1, 2, 3, 4, 5|D:5, 4, 3, 2, 1');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'1. अक्षर 2. शब्द 3. वाक्यांश 4. वाक्य 5. अनुच्छेद', E'2, 1, 3, 4, 5', E'1, 3, 2, 4, 5', E'1, 2, 3, 4, 5', E'5, 4, 3, 2, 1', E'C', E'अक्षर मिलेर शब्द, शब्दबाट वाक्यांश, वाक्य र अन्त्यमा अनुच्छेद बन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1. अक्षर 2. शब्द 3. वाक्यांश 4. वाक्य 5. अनुच्छेद|A:2, 1, 3, 4, 5|B:1, 3, 2, 4, 5|C:1, 2, 3, 4, 5|D:5, 4, 3, 2, 1'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1. टोल 2. वडा 3. गाउँ 4. नगर 5. महानगर|A:2, 1, 3, 4, 5|B:1, 3, 2, 4, 5|C:5, 4, 3, 2, 1|D:1, 2, 3, 4, 5');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'1. टोल 2. वडा 3. गाउँ 4. नगर 5. महानगर', E'2, 1, 3, 4, 5', E'1, 3, 2, 4, 5', E'5, 4, 3, 2, 1', E'1, 2, 3, 4, 5', E'D', E'यो सानो भौगोलिक एकाइबाट ठूलो एकाइ तर्फको क्रम हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1. टोल 2. वडा 3. गाउँ 4. नगर 5. महानगर|A:2, 1, 3, 4, 5|B:1, 3, 2, 4, 5|C:5, 4, 3, 2, 1|D:1, 2, 3, 4, 5'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1. सेकेन्ड 2. मिनेट 3. घण्टा 4. दिन 5. हप्ता|A:1, 2, 3, 4, 5|B:2, 1, 3, 4, 5|C:1, 3, 2, 4, 5|D:5, 4, 3, 2, 1');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'1. सेकेन्ड 2. मिनेट 3. घण्टा 4. दिन 5. हप्ता', E'1, 2, 3, 4, 5', E'2, 1, 3, 4, 5', E'1, 3, 2, 4, 5', E'5, 4, 3, 2, 1', E'A', E'यो समयको सानो एकाइबाट ठूलो एकाइको बढ्दो क्रम हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1. सेकेन्ड 2. मिनेट 3. घण्टा 4. दिन 5. हप्ता|A:1, 2, 3, 4, 5|B:2, 1, 3, 4, 5|C:1, 3, 2, 4, 5|D:5, 4, 3, 2, 1'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1. माटो 2. बीज 3. पानी 4. मल 5. फसल|A:2, 1, 3, 4, 5|B:1, 2, 3, 4, 5|C:1, 3, 2, 4, 5|D:1, 2, 4, 3, 5');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'1. माटो 2. बीज 3. पानी 4. मल 5. फसल', E'2, 1, 3, 4, 5', E'1, 2, 3, 4, 5', E'1, 3, 2, 4, 5', E'1, 2, 4, 3, 5', E'B', E'खेती गर्दा पहिले माटो तयार गरिन्छ, बीज रोपिन्छ, पानी/मल हालिन्छ अनि फसल तयार हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1. माटो 2. बीज 3. पानी 4. मल 5. फसल|A:2, 1, 3, 4, 5|B:1, 2, 3, 4, 5|C:1, 3, 2, 4, 5|D:1, 2, 4, 3, 5'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1. विज्ञापन 2. निवेदन 3. परीक्षा 4. छनोट 5. नियुक्ति|A:2, 1, 3, 4, 5|B:1, 3, 2, 4, 5|C:1, 2, 3, 4, 5|D:5, 4, 3, 2, 1');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'1. विज्ञापन 2. निवेदन 3. परीक्षा 4. छनोट 5. नियुक्ति', E'2, 1, 3, 4, 5', E'1, 3, 2, 4, 5', E'1, 2, 3, 4, 5', E'5, 4, 3, 2, 1', E'C', E'यो रोजगारी वा पदपूर्तिको स्वाभाविक प्रक्रिया हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1. विज्ञापन 2. निवेदन 3. परीक्षा 4. छनोट 5. नियुक्ति|A:2, 1, 3, 4, 5|B:1, 3, 2, 4, 5|C:1, 2, 3, 4, 5|D:5, 4, 3, 2, 1'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1. रोग 2. डाक्टर 3. निदान 4. औषधि 5. निको|A:2, 1, 3, 4, 5|B:1, 3, 2, 4, 5|C:1, 2, 4, 3, 5|D:1, 2, 3, 4, 5');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 20, E'1. रोग 2. डाक्टर 3. निदान 4. औषधि 5. निको', E'2, 1, 3, 4, 5', E'1, 3, 2, 4, 5', E'1, 2, 4, 3, 5', E'1, 2, 3, 4, 5', E'D', E'पहिले रोग लाग्छ, डाक्टरकहाँ गइन्छ, निदान हुन्छ, औषधि खाइन्छ र निको हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1. रोग 2. डाक्टर 3. निदान 4. औषधि 5. निको|A:2, 1, 3, 4, 5|B:1, 3, 2, 4, 5|C:1, 2, 4, 3, 5|D:1, 2, 3, 4, 5'), v_set_id, v_q_id, 20)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1. सोच 2. योजना 3. काम 4. नतिजा 5. समीक्षा|A:1, 2, 3, 4, 5|B:2, 1, 3, 4, 5|C:1, 3, 2, 4, 5|D:5, 4, 3, 2, 1');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 21, E'1. सोच 2. योजना 3. काम 4. नतिजा 5. समीक्षा', E'1, 2, 3, 4, 5', E'2, 1, 3, 4, 5', E'1, 3, 2, 4, 5', E'5, 4, 3, 2, 1', E'A', E'कुनै पनि कार्य गर्दा सोच, योजना, काम, नतिजा र अन्त्यमा समीक्षा गरिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1. सोच 2. योजना 3. काम 4. नतिजा 5. समीक्षा|A:1, 2, 3, 4, 5|B:2, 1, 3, 4, 5|C:1, 3, 2, 4, 5|D:5, 4, 3, 2, 1'), v_set_id, v_q_id, 21)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1. अपराध 2. प्रहरी 3. अदालत 4. फैसला 5. सजाय|A:2, 1, 3, 4, 5|B:1, 2, 3, 4, 5|C:1, 3, 2, 4, 5|D:1, 2, 4, 3, 5');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 22, E'1. अपराध 2. प्रहरी 3. अदालत 4. फैसला 5. सजाय', E'2, 1, 3, 4, 5', E'1, 2, 3, 4, 5', E'1, 3, 2, 4, 5', E'1, 2, 4, 3, 5', E'B', E'अपराध भएपछि प्रहरी, अदालत, फैसला र अन्त्यमा सजाय हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1. अपराध 2. प्रहरी 3. अदालत 4. फैसला 5. सजाय|A:2, 1, 3, 4, 5|B:1, 2, 3, 4, 5|C:1, 3, 2, 4, 5|D:1, 2, 4, 3, 5'), v_set_id, v_q_id, 22)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1. कपास 2. धागो 3. कपडा 4. लुगा 5. लगाउने|A:2, 1, 3, 4, 5|B:1, 3, 2, 4, 5|C:1, 2, 3, 4, 5|D:5, 4, 3, 2, 1');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 23, E'1. कपास 2. धागो 3. कपडा 4. लुगा 5. लगाउने', E'2, 1, 3, 4, 5', E'1, 3, 2, 4, 5', E'1, 2, 3, 4, 5', E'5, 4, 3, 2, 1', E'C', E'कपासबाट धागो, कपडा, लुगा बन्छ र त्यसलाई लगाइन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1. कपास 2. धागो 3. कपडा 4. लुगा 5. लगाउने|A:2, 1, 3, 4, 5|B:1, 3, 2, 4, 5|C:1, 2, 3, 4, 5|D:5, 4, 3, 2, 1'), v_set_id, v_q_id, 23)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1. बालुवा 2. इँटा 3. पर्खाल 4. कोठा 5. घर|A:2, 1, 3, 4, 5|B:1, 3, 2, 4, 5|C:1, 2, 4, 3, 5|D:1, 2, 3, 4, 5');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 24, E'1. बालुवा 2. इँटा 3. पर्खाल 4. कोठा 5. घर', E'2, 1, 3, 4, 5', E'1, 3, 2, 4, 5', E'1, 2, 4, 3, 5', E'1, 2, 3, 4, 5', E'D', E'निर्माण सामग्री र संरचनाहरूको सानोदेखि ठूलो क्रम हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1. बालुवा 2. इँटा 3. पर्खाल 4. कोठा 5. घर|A:2, 1, 3, 4, 5|B:1, 3, 2, 4, 5|C:1, 2, 4, 3, 5|D:1, 2, 3, 4, 5'), v_set_id, v_q_id, 24)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1. आय 2. बचत 3. लगानी 4. नाफा 5. समृद्धि|A:1, 2, 3, 4, 5|B:2, 1, 3, 4, 5|C:1, 3, 2, 4, 5|D:5, 4, 3, 2, 1');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 25, E'1. आय 2. बचत 3. लगानी 4. नाफा 5. समृद्धि', E'1, 2, 3, 4, 5', E'2, 1, 3, 4, 5', E'1, 3, 2, 4, 5', E'5, 4, 3, 2, 1', E'A', E'आयबाट बचत, लगानी, नाफा हुँदै समृद्धि आउँछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1. आय 2. बचत 3. लगानी 4. नाफा 5. समृद्धि|A:1, 2, 3, 4, 5|B:2, 1, 3, 4, 5|C:1, 3, 2, 4, 5|D:5, 4, 3, 2, 1'), v_set_id, v_q_id, 25)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1. दिन 2. हप्ता 3. महिना 4. वर्ष 5. दशक|A:2, 1, 3, 4, 5|B:1, 2, 3, 4, 5|C:1, 3, 2, 4, 5|D:5, 4, 3, 2, 1');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 26, E'1. दिन 2. हप्ता 3. महिना 4. वर्ष 5. दशक', E'2, 1, 3, 4, 5', E'1, 2, 3, 4, 5', E'1, 3, 2, 4, 5', E'5, 4, 3, 2, 1', E'B', E'यो समयको सानोबाट ठूलो एकाइको क्रम हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1. दिन 2. हप्ता 3. महिना 4. वर्ष 5. दशक|A:2, 1, 3, 4, 5|B:1, 2, 3, 4, 5|C:1, 3, 2, 4, 5|D:5, 4, 3, 2, 1'), v_set_id, v_q_id, 26)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1. बीज 2. अंकुरण 3. हाँगा 4. पात 5. फूल|A:2, 1, 3, 4, 5|B:1, 3, 2, 4, 5|C:1, 2, 3, 4, 5|D:1, 2, 4, 3, 5');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 27, E'1. बीज 2. अंकुरण 3. हाँगा 4. पात 5. फूल', E'2, 1, 3, 4, 5', E'1, 3, 2, 4, 5', E'1, 2, 3, 4, 5', E'1, 2, 4, 3, 5', E'C', E'यो बिरुवाको प्राकृतिक विकास क्रम हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1. बीज 2. अंकुरण 3. हाँगा 4. पात 5. फूल|A:2, 1, 3, 4, 5|B:1, 3, 2, 4, 5|C:1, 2, 3, 4, 5|D:1, 2, 4, 3, 5'), v_set_id, v_q_id, 27)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1. बिहान 2. दिउँसो 3. साँझ 4. राति 5. मध्यरात|A:2, 1, 3, 4, 5|B:1, 3, 2, 4, 5|C:5, 4, 3, 2, 1|D:1, 2, 3, 4, 5');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 28, E'1. बिहान 2. दिउँसो 3. साँझ 4. राति 5. मध्यरात', E'2, 1, 3, 4, 5', E'1, 3, 2, 4, 5', E'5, 4, 3, 2, 1', E'1, 2, 3, 4, 5', E'D', E'यो दिनको समय चक्रको सही क्रम हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1. बिहान 2. दिउँसो 3. साँझ 4. राति 5. मध्यरात|A:2, 1, 3, 4, 5|B:1, 3, 2, 4, 5|C:5, 4, 3, 2, 1|D:1, 2, 3, 4, 5'), v_set_id, v_q_id, 28)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1. लाइन 2. अनुच्छेद 3. पृष्ठ 4. अध्याय 5. पुस्तक|A:1, 2, 3, 4, 5|B:2, 1, 3, 4, 5|C:1, 3, 2, 4, 5|D:5, 4, 3, 2, 1');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 29, E'1. लाइन 2. अनुच्छेद 3. पृष्ठ 4. अध्याय 5. पुस्तक', E'1, 2, 3, 4, 5', E'2, 1, 3, 4, 5', E'1, 3, 2, 4, 5', E'5, 4, 3, 2, 1', E'A', E'सानो एकाइबाट ठूलो एकाइ मिल्दै पुस्तक बन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1. लाइन 2. अनुच्छेद 3. पृष्ठ 4. अध्याय 5. पुस्तक|A:1, 2, 3, 4, 5|B:2, 1, 3, 4, 5|C:1, 3, 2, 4, 5|D:5, 4, 3, 2, 1'), v_set_id, v_q_id, 29)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1. धान 2. चामल 3. भात 4. खाना 5. ऊर्जा|A:2, 1, 3, 4, 5|B:1, 2, 3, 4, 5|C:1, 3, 2, 4, 5|D:1, 2, 4, 3, 5');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 30, E'1. धान 2. चामल 3. भात 4. खाना 5. ऊर्जा', E'2, 1, 3, 4, 5', E'1, 2, 3, 4, 5', E'1, 3, 2, 4, 5', E'1, 2, 4, 3, 5', E'B', E'धानबाट चामल, भात, खाना र ऊर्जा प्राप्त हुने क्रम हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1. धान 2. चामल 3. भात 4. खाना 5. ऊर्जा|A:2, 1, 3, 4, 5|B:1, 2, 3, 4, 5|C:1, 3, 2, 4, 5|D:1, 2, 4, 3, 5'), v_set_id, v_q_id, 30)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: शाब्दिक बौद्धिक परीक्षणः शाब्दिक पजल र अमिल्दा शब्द - खण्ड 4 (आधारभूत तह) (22 Q)
  v_set_id := extensions.uuid_generate_v5('fa0af7e0-6bb7-4c25-b62f-d2d8ce99f610'::uuid, E'शाब्दिक बौद्धिक परीक्षणः शाब्दिक पजल र अमिल्दा शब्द - खण्ड 4 (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'efc9184a-c265-4fd8-bb99-aad431aefc58'::uuid, 'fa0af7e0-6bb7-4c25-b62f-d2d8ce99f610'::uuid, E'शाब्दिक बौद्धिक परीक्षणः शाब्दिक पजल र अमिल्दा शब्द - खण्ड 4 (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'fa0af7e0-6bb7-4c25-b62f-d2d8ce99f610'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1. काठ 2. सिकर्मी 3. फर्निचर 4. शोरुम 5. खरिद|A:1, 2, 3, 4, 5|B:2, 1, 3, 4, 5|C:1, 3, 2, 4, 5|D:5, 4, 3, 2, 1');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'1. काठ 2. सिकर्मी 3. फर्निचर 4. शोरुम 5. खरिद', E'1, 2, 3, 4, 5', E'2, 1, 3, 4, 5', E'1, 3, 2, 4, 5', E'5, 4, 3, 2, 1', E'A', E'काठलाई सिकर्मीले फर्निचर बनाई शोरुममा राखेपछि खरिद हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1. काठ 2. सिकर्मी 3. फर्निचर 4. शोरुम 5. खरिद|A:1, 2, 3, 4, 5|B:2, 1, 3, 4, 5|C:1, 3, 2, 4, 5|D:5, 4, 3, 2, 1'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1. सुन 2. सुनार 3. गहना 4. पसल 5. ग्राहक|A:2, 1, 3, 4, 5|B:1, 2, 3, 4, 5|C:1, 3, 2, 4, 5|D:1, 2, 4, 3, 5');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'1. सुन 2. सुनार 3. गहना 4. पसल 5. ग्राहक', E'2, 1, 3, 4, 5', E'1, 2, 3, 4, 5', E'1, 3, 2, 4, 5', E'1, 2, 4, 3, 5', E'B', E'सुनलाई सुनारले गहना बनाउँछ र पसल मार्फत ग्राहकसम्म पुग्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1. सुन 2. सुनार 3. गहना 4. पसल 5. ग्राहक|A:2, 1, 3, 4, 5|B:1, 2, 3, 4, 5|C:1, 3, 2, 4, 5|D:1, 2, 4, 3, 5'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै कोडमा ''WATER'' लाई ''RETAW'' लेखिन्छ भने, ''TEACH'' लाई के लेखिन्छ?|A:CHEAT|B:TEACH|C:HCAET|D:THECA');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'कुनै कोडमा ''WATER'' लाई ''RETAW'' लेखिन्छ भने, ''TEACH'' लाई के लेखिन्छ?', E'CHEAT', E'TEACH', E'HCAET', E'THECA', E'C', E'यहाँ शब्दका अक्षरहरूलाई उल्टो क्रम (Reverse) मा लेखिएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै कोडमा ''WATER'' लाई ''RETAW'' लेखिन्छ भने, ''TEACH'' लाई के लेखिन्छ?|A:CHEAT|B:TEACH|C:HCAET|D:THECA'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै कोडमा ''BOARD'' लाई ''DRAOB'' लेखिन्छ भने, ''LIGHT'' लाई के लेखिन्छ?|A:THIGL|B:LIGTH|C:GITHL|D:THGIL');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'कुनै कोडमा ''BOARD'' लाई ''DRAOB'' लेखिन्छ भने, ''LIGHT'' लाई के लेखिन्छ?', E'THIGL', E'LIGTH', E'GITHL', E'THGIL', E'D', E'शब्दका अक्षरहरूलाई उल्टो क्रममा लेखिएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै कोडमा ''BOARD'' लाई ''DRAOB'' लेखिन्छ भने, ''LIGHT'' लाई के लेखिन्छ?|A:THIGL|B:LIGTH|C:GITHL|D:THGIL'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै कोडमा ''BOOK'' लाई ''CPPL'' लेखिन्छ भने, ''DESK'' लाई के लेखिन्छ?|A:EFTL|B:EFUL|C:DTRL|D:EDSL');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'कुनै कोडमा ''BOOK'' लाई ''CPPL'' लेखिन्छ भने, ''DESK'' लाई के लेखिन्छ?', E'EFTL', E'EFUL', E'DTRL', E'EDSL', E'A', E'प्रत्येक अक्षरलाई +1 (लगत्तै आउने अर्को अक्षर) ले कोड गरिएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै कोडमा ''BOOK'' लाई ''CPPL'' लेखिन्छ भने, ''DESK'' लाई के लेखिन्छ?|A:EFTL|B:EFUL|C:DTRL|D:EDSL'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै कोडमा ''CAR'' लाई ''DBS'' लेखिन्छ भने, ''PEN'' लाई के लेखिन्छ?|A:QEP|B:QFO|C:OMD|D:QGN');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'कुनै कोडमा ''CAR'' लाई ''DBS'' लेखिन्छ भने, ''PEN'' लाई के लेखिन्छ?', E'QEP', E'QFO', E'OMD', E'QGN', E'B', E'प्रत्येक अक्षरलाई +1 ले कोड गरिएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै कोडमा ''CAR'' लाई ''DBS'' लेखिन्छ भने, ''PEN'' लाई के लेखिन्छ?|A:QEP|B:QFO|C:OMD|D:QGN'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै कोडमा ''FIRE'' लाई ''EHQD'' लेखिन्छ भने, ''COLD'' लाई के लेखिन्छ?|A:BMLC|B:DPMF|C:BNKC|D:AMJB');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'कुनै कोडमा ''FIRE'' लाई ''EHQD'' लेखिन्छ भने, ''COLD'' लाई के लेखिन्छ?', E'BMLC', E'DPMF', E'BNKC', E'AMJB', E'C', E'प्रत्येक अक्षरलाई -1 (एक स्थान अगाडिको अक्षर) ले कोड गरिएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै कोडमा ''FIRE'' लाई ''EHQD'' लेखिन्छ भने, ''COLD'' लाई के लेखिन्छ?|A:BMLC|B:DPMF|C:BNKC|D:AMJB'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै कोडमा ''SUN'' लाई ''RTM'' लेखिन्छ भने, ''BOY'' लाई के लेखिन्छ?|A:CPZ|B:AMX|C:COZ|D:ANX');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'कुनै कोडमा ''SUN'' लाई ''RTM'' लेखिन्छ भने, ''BOY'' लाई के लेखिन्छ?', E'CPZ', E'AMX', E'COZ', E'ANX', E'D', E'प्रत्येक अक्षरलाई -1 ले कोड गरिएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै कोडमा ''SUN'' लाई ''RTM'' लेखिन्छ भने, ''BOY'' लाई के लेखिन्छ?|A:CPZ|B:AMX|C:COZ|D:ANX'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै कोडमा ''CAT'' लाई ''ECV'' लेखिन्छ भने, ''DOG'' लाई के लेखिन्छ?|A:FQI|B:FPH|C:EQH|D:FPI');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'कुनै कोडमा ''CAT'' लाई ''ECV'' लेखिन्छ भने, ''DOG'' लाई के लेखिन्छ?', E'FQI', E'FPH', E'EQH', E'FPI', E'A', E'प्रत्येक अक्षरलाई +2 (दुई स्थान पछाडिको अक्षर) ले कोड गरिएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै कोडमा ''CAT'' लाई ''ECV'' लेखिन्छ भने, ''DOG'' लाई के लेखिन्छ?|A:FQI|B:FPH|C:EQH|D:FPI'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै कोडमा ''MAN'' लाई ''OCP'' लेखिन्छ भने, ''BAT'' लाई के लेखिन्छ?|A:CBU|B:DCV|C:DAW|D:CBV');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'कुनै कोडमा ''MAN'' लाई ''OCP'' लेखिन्छ भने, ''BAT'' लाई के लेखिन्छ?', E'CBU', E'DCV', E'DAW', E'CBV', E'B', E'प्रत्येक अक्षरलाई +2 ले कोड गरिएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै कोडमा ''MAN'' लाई ''OCP'' लेखिन्छ भने, ''BAT'' लाई के लेखिन्छ?|A:CBU|B:DCV|C:DAW|D:CBV'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै कोडमा ''TOP'' लाई ''RMN'' लेखिन्छ भने, ''CUP'' लाई के लेखिन्छ?|A:BTO|B:ARM|C:ASN|D:BSN');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'कुनै कोडमा ''TOP'' लाई ''RMN'' लेखिन्छ भने, ''CUP'' लाई के लेखिन्छ?', E'BTO', E'ARM', E'ASN', E'BSN', E'C', E'प्रत्येक अक्षरलाई -2 ले कोड गरिएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै कोडमा ''TOP'' लाई ''RMN'' लेखिन्छ भने, ''CUP'' लाई के लेखिन्छ?|A:BTO|B:ARM|C:ASN|D:BSN'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै कोडमा ''RED'' लाई ''PCB'' लेखिन्छ भने, ''FOX'' लाई के लेखिन्छ?|A:DMW|B:ENV|C:EMW|D:DMV');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'कुनै कोडमा ''RED'' लाई ''PCB'' लेखिन्छ भने, ''FOX'' लाई के लेखिन्छ?', E'DMW', E'ENV', E'EMW', E'DMV', E'D', E'प्रत्येक अक्षरलाई -2 ले कोड गरिएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै कोडमा ''RED'' लाई ''PCB'' लेखिन्छ भने, ''FOX'' लाई के लेखिन्छ?|A:DMW|B:ENV|C:EMW|D:DMV'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै कोडमा ''BIRD'' लाई ''DIRB'' लेखिन्छ भने, ''FISH'' लाई के लेखिन्छ?|A:HISF|B:SHIF|C:HSFI|D:FHIS');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'कुनै कोडमा ''BIRD'' लाई ''DIRB'' लेखिन्छ भने, ''FISH'' लाई के लेखिन्छ?', E'HISF', E'SHIF', E'HSFI', E'FHIS', E'A', E'शब्दको पहिलो र अन्तिम अक्षरलाई आपसमा साटासाट गरिएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै कोडमा ''BIRD'' लाई ''DIRB'' लेखिन्छ भने, ''FISH'' लाई के लेखिन्छ?|A:HISF|B:SHIF|C:HSFI|D:FHIS'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै कोडमा ''ROAD'' लाई ''DOAR'' लेखिन्छ भने, ''TREE'' लाई के लेखिन्छ?|A:EERT|B:ERET|C:TEER|D:ETER');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'कुनै कोडमा ''ROAD'' लाई ''DOAR'' लेखिन्छ भने, ''TREE'' लाई के लेखिन्छ?', E'EERT', E'ERET', E'TEER', E'ETER', E'B', E'पहिलो र अन्तिम अक्षरलाई आपसमा साटासाट गरिएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै कोडमा ''ROAD'' लाई ''DOAR'' लेखिन्छ भने, ''TREE'' लाई के लेखिन्छ?|A:EERT|B:ERET|C:TEER|D:ETER'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै कोडमा ''HEAT'' लाई ''HFBT'' लेखिन्छ भने, ''COLD'' लाई के लेखिन्छ?|A:DPMF|B:DPLD|C:CPLD|D:CPMF');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'कुनै कोडमा ''HEAT'' लाई ''HFBT'' लेखिन्छ भने, ''COLD'' लाई के लेखिन्छ?', E'DPMF', E'DPLD', E'CPLD', E'CPMF', E'C', E'स्वर वर्ण (Vowels) लाई +1 गरिएको छ र व्यञ्जन (Consonants) उस्तै राखिएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै कोडमा ''HEAT'' लाई ''HFBT'' लेखिन्छ भने, ''COLD'' लाई के लेखिन्छ?|A:DPMF|B:DPLD|C:CPLD|D:CPMF'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै कोडमा ''BOAT'' लाई ''BPBT'' लेखिन्छ भने, ''READ'' लाई के लेखिन्छ?|A:SEBE|B:REBD|C:SFBD|D:RFBD');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'कुनै कोडमा ''BOAT'' लाई ''BPBT'' लेखिन्छ भने, ''READ'' लाई के लेखिन्छ?', E'SEBE', E'REBD', E'SFBD', E'RFBD', E'D', E'स्वर वर्णलाई +1 गरिएको छ, व्यञ्जन उस्तै छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै कोडमा ''BOAT'' लाई ''BPBT'' लेखिन्छ भने, ''READ'' लाई के लेखिन्छ?|A:SEBE|B:REBD|C:SFBD|D:RFBD'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै कोडमा ''RAT'' लाई ''SAU'' लेखिन्छ भने, ''PIG'' लाई के लेखिन्छ?|A:QIH|B:QJG|C:PJH|D:QIG');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'कुनै कोडमा ''RAT'' लाई ''SAU'' लेखिन्छ भने, ''PIG'' लाई के लेखिन्छ?', E'QIH', E'QJG', E'PJH', E'QIG', E'A', E'व्यञ्जन वर्णलाई +1 गरिएको छ र स्वर वर्ण उस्तै राखिएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै कोडमा ''RAT'' लाई ''SAU'' लेखिन्छ भने, ''PIG'' लाई के लेखिन्छ?|A:QIH|B:QJG|C:PJH|D:QIG'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै कोडमा ''CAT'' लाई ''DAU'' लेखिन्छ भने, ''DOG'' लाई के लेखिन्छ?|A:FPH|B:EOH|C:EPG|D:DOH');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'कुनै कोडमा ''CAT'' लाई ''DAU'' लेखिन्छ भने, ''DOG'' लाई के लेखिन्छ?', E'FPH', E'EOH', E'EPG', E'DOH', E'B', E'व्यञ्जन वर्णलाई +1 गरिएको छ, स्वर उस्तै छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै कोडमा ''CAT'' लाई ''DAU'' लेखिन्छ भने, ''DOG'' लाई के लेखिन्छ?|A:FPH|B:EOH|C:EPG|D:DOH'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै कोडमा ''RED'' लाई ''27'' लेखिन्छ भने, ''CAB'' लाई के लेखिन्छ?|A:7|B:5|C:6|D:8');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'कुनै कोडमा ''RED'' लाई ''27'' लेखिन्छ भने, ''CAB'' लाई के लेखिन्छ?', E'7', E'5', E'6', E'8', E'C', E'अक्षरहरूको वर्णमालाको स्थान अनुसारको संख्या जोडिएको छ (C=3, A=1, B=2; 3+1+2=6)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै कोडमा ''RED'' लाई ''27'' लेखिन्छ भने, ''CAB'' लाई के लेखिन्छ?|A:7|B:5|C:6|D:8'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै कोडमा ''BOY'' लाई ''42'' लेखिन्छ भने, ''PEN'' लाई के लेखिन्छ?|A:36|B:34|C:37|D:35');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 20, E'कुनै कोडमा ''BOY'' लाई ''42'' लेखिन्छ भने, ''PEN'' लाई के लेखिन्छ?', E'36', E'34', E'37', E'35', E'D', E'अक्षरहरूको स्थान अंक जोड्दा P(16)+E(5)+N(14) = 35 हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै कोडमा ''BOY'' लाई ''42'' लेखिन्छ भने, ''PEN'' लाई के लेखिन्छ?|A:36|B:34|C:37|D:35'), v_set_id, v_q_id, 20)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि A=1, B=2 हुँदै अगाडि बढ्छ भने ''CAB'' लाई ''312'' लेखिन्छ। त्यसो भए ''BAD'' लाई के लेखिन्छ?|A:214|B:241|C:124|D:412');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 21, E'यदि A=1, B=2 हुँदै अगाडि बढ्छ भने ''CAB'' लाई ''312'' लेखिन्छ। त्यसो भए ''BAD'' लाई के लेखिन्छ?', E'214', E'241', E'124', E'412', E'A', E'अक्षरहरूको वर्णमालाको स्थानलाई सोझै अंकमा लेखिएको छ (B=2, A=1, D=4)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि A=1, B=2 हुँदै अगाडि बढ्छ भने ''CAB'' लाई ''312'' लेखिन्छ। त्यसो भए ''BAD'' लाई के लेखिन्छ?|A:214|B:241|C:124|D:412'), v_set_id, v_q_id, 21)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि A=1, B=2 हुँदै अगाडि बढ्छ भने ''DAD'' लाई ''414'' लेखिन्छ। त्यसो भए ''BEE'' लाई के लेखिन्छ?|A:266|B:255|C:254|D:355');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 22, E'यदि A=1, B=2 हुँदै अगाडि बढ्छ भने ''DAD'' लाई ''414'' लेखिन्छ। त्यसो भए ''BEE'' लाई के लेखिन्छ?', E'266', E'255', E'254', E'355', E'B', E'स्थानलाई सोझै अंकमा लेख्दा B=2, E=5, E=5 (255) हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि A=1, B=2 हुँदै अगाडि बढ्छ भने ''DAD'' लाई ''414'' लेखिन्छ। त्यसो भए ''BEE'' लाई के लेखिन्छ?|A:266|B:255|C:254|D:355'), v_set_id, v_q_id, 22)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: गणितीय क्षमताः छुटेका सङ्ख्याहरू पुरा गर्ने - खण्ड 2 (आधारभूत तह) (30 Q)
  v_set_id := extensions.uuid_generate_v5('d912e8af-d7b4-4104-8bd0-e478e3f530a1'::uuid, E'गणितीय क्षमताः छुटेका सङ्ख्याहरू पुरा गर्ने - खण्ड 2 (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'db9d9515-ced5-4a90-a4ac-3a8927342e98'::uuid, 'd912e8af-d7b4-4104-8bd0-e478e3f530a1'::uuid, E'गणितीय क्षमताः छुटेका सङ्ख्याहरू पुरा गर्ने - खण्ड 2 (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'd912e8af-d7b4-4104-8bd0-e478e3f530a1'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| २ | ३ | २५ |
|---|---|---|
| ४ | ५ | ८१ |
| ५ | ३ | ? ||A:६४|B:४९|C:३६|D:८१');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| २ | ३ | २५ |
|---|---|---|
| ४ | ५ | ८१ |
| ५ | ३ | ? |', E'६४', E'४९', E'३६', E'८१', E'A', E'म्याट्रिक्सको प्रत्येक पङ्क्तिमा (Row), पहिलो र दोस्रो सङ्ख्या जोडेर वर्ग गर्दा तेस्रो सङ्ख्या हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| २ | ३ | २५ |
|---|---|---|
| ४ | ५ | ८१ |
| ५ | ३ | ? ||A:६४|B:४९|C:३६|D:८१'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ५ | ६ | २५ |
|---|---|---|
| ७ | ४ | २३ |
| ८ | ५ | ? ||A:४०|B:३५|C:४५|D:३०');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ५ | ६ | २५ |
|---|---|---|
| ७ | ४ | २३ |
| ८ | ५ | ? |', E'४०', E'३५', E'४५', E'३०', E'B', E'म्याट्रिक्सको प्रत्येक पङ्क्तिमा (Row), पहिलो र दोस्रो सङ्ख्या गुणन गरी ५ घटाउँदा तेस्रो सङ्ख्या हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ५ | ६ | २५ |
|---|---|---|
| ७ | ४ | २३ |
| ८ | ५ | ? ||A:४०|B:३५|C:४५|D:३०'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
२, २, ४, १२, ४८, ?|A:१२०|B:२८८|C:२४०|D:१५०');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
२, २, ४, १२, ४८, ?', E'१२०', E'२८८', E'२४०', E'१५०', E'C', E'प्रत्येक पदलाई क्रमशः १, २, ३, ४ र ५ ले गुणन गरिएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
२, २, ४, १२, ४८, ?|A:१२०|B:२८८|C:२४०|D:१५०'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
५, ६, १०, १९, ३५, ?|A:५५|B:५०|C:६५|D:६०');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
५, ६, १०, १९, ३५, ?', E'५५', E'५०', E'६५', E'६०', E'D', E'प्रत्येक पदमा क्रमशः १, ४, ९, १६ (प्राकृतिक सङ्ख्याको वर्ग) जोडिएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
५, ६, १०, १९, ३५, ?|A:५५|B:५०|C:६५|D:६०'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
२, ५, १२, २७, ५८, ?|A:१२१|B:१२०|C:११५|D:११६');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
२, ५, १२, २७, ५८, ?', E'१२१', E'१२०', E'११५', E'११६', E'A', E'प्रत्येक पदलाई २ ले गुणन गरी क्रमशः १, २, ३, ४, ५ जोडिएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
२, ५, १२, २७, ५८, ?|A:१२१|B:१२०|C:११५|D:११६'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
३, ८, २२, ६३, १८५, ?|A:५४५|B:५५०|C:५४०|D:५६०');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
३, ८, २२, ६३, १८५, ?', E'५४५', E'५५०', E'५४०', E'५६०', E'B', E'प्रत्येक पदलाई ३ ले गुणन गरी क्रमशः १, २, ३, ४, ५ घटाइएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
३, ८, २२, ६३, १८५, ?|A:५४५|B:५५०|C:५४०|D:५६०'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
१, २, ११, ३६, ८५, ?|A:१५०|B:१७०|C:१६६|D:१६०');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
१, २, ११, ३६, ८५, ?', E'१५०', E'१७०', E'१६६', E'१६०', E'C', E'प्रत्येक पदमा क्रमशः १, ९, २५, ४९, ८१ (बिजोर सङ्ख्याको वर्ग) जोडिएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
१, २, ११, ३६, ८५, ?|A:१५०|B:१७०|C:१६६|D:१६०'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
१६, २४, ४८, १२०, ३६०, ?|A:१०८०|B:११५०|C:१०००|D:१२६०');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
१६, २४, ४८, १२०, ३६०, ?', E'१०८०', E'११५०', E'१०००', E'१२६०', E'D', E'क्रमशः १.५, २, २.५, ३, ३.५ ले गुणन गरिएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
१६, २४, ४८, १२०, ३६०, ?|A:१०८०|B:११५०|C:१०००|D:१२६०'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
४, ६, ९, १४, २१, ?|A:३२|B:३०|C:३४|D:२८');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
४, ६, ९, १४, २१, ?', E'३२', E'३०', E'३४', E'२८', E'A', E'क्रमशः रूढ सङ्ख्याहरू (Prime numbers: २, ३, ५, ७, ११) जोडिएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
४, ६, ९, १४, २१, ?|A:३२|B:३०|C:३४|D:२८'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
१, २, ६, ३०, २१०, ?|A:२५००|B:२३१०|C:२२००|D:२०००');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
१, २, ६, ३०, २१०, ?', E'२५००', E'२३१०', E'२२००', E'२०००', E'B', E'क्रमशः रूढ सङ्ख्याहरू (Prime numbers: २, ३, ५, ७, ११) ले गुणन गरिएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
१, २, ६, ३०, २१०, ?|A:२५००|B:२३१०|C:२२००|D:२०००'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
१५०, १४९, १४५, १३६, १२०, ?|A:९०|B:१००|C:९५|D:८५');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
१५०, १४९, १४५, १३६, १२०, ?', E'९०', E'१००', E'९५', E'८५', E'C', E'प्रत्येक पदबाट क्रमशः १, ४, ९, १६, २५ (सङ्ख्याको वर्ग) घटाइएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
१५०, १४९, १४५, १३६, १२०, ?|A:९०|B:१००|C:९५|D:८५'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
१, २, १०, ३७, १०१, ?|A:२००|B:२२०|C:२५०|D:२२६');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
१, २, १०, ३७, १०१, ?', E'२००', E'२२०', E'२५०', E'२२६', E'D', E'प्रत्येक पदमा क्रमशः १, ८, २७, ६४, १२५ (सङ्ख्याको घन) जोडिएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
१, २, १०, ३७, १०१, ?|A:२००|B:२२०|C:२५०|D:२२६'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
१०, २०, १०, २०, १०, ?|A:२०|B:१०|C:५|D:१५');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
१०, २०, १०, २०, १०, ?', E'२०', E'१०', E'५', E'१५', E'A', E'क्रमशः २ ले गुणन गर्ने र २ ले भाग गर्ने गरिएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
१०, २०, १०, २०, १०, ?|A:२०|B:१०|C:५|D:१५'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
१५, २५, २०, ३०, २५, ?|A:३०|B:३५|C:४०|D:२०');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
१५, २५, २०, ३०, २५, ?', E'३०', E'३५', E'४०', E'२०', E'B', E'क्रमशः १० जोड्ने र ५ घटाउने गरिएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
१५, २५, २०, ३०, २५, ?|A:३०|B:३५|C:४०|D:२०'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
२, ६, १४, ३०, sixty-two, ? (६२, ?)|A:१२०|B:१२४|C:१२६|D:१२८');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
२, ६, १४, ३०, sixty-two, ? (६२, ?)', E'१२०', E'१२४', E'१२६', E'१२८', E'C', E'प्रत्येक सङ्ख्यामा १ जोडेर २ ले गुणन गरिएको छ (वा x२ + २)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
२, ६, १४, ३०, sixty-two, ? (६२, ?)|A:१२०|B:१२४|C:१२६|D:१२८'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
३, ६, १५, ४२, १२३, ?|A:३५०|B:३६०|C:३८०|D:३६६');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
३, ६, १५, ४२, १२३, ?', E'३५०', E'३६०', E'३८०', E'३६६', E'D', E'प्रत्येक सङ्ख्याबाट १ घटाएर ३ ले गुणन गरिएको छ (वा x३ - ३)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
३, ६, १५, ४२, १२३, ?|A:३५०|B:३६०|C:३८०|D:३६६'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
५, ७, १३, २५, ४५, ?|A:७५|B:७०|C:६५|D:८०');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
५, ७, १३, २५, ४५, ?', E'७५', E'७०', E'६५', E'८०', E'A', E'क्रमशः २, ६, १२, २०, ३० (लगातार सङ्ख्याको गुणनफल) जोडिएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
५, ७, १३, २५, ४५, ?|A:७५|B:७०|C:६५|D:८०'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
१०, ११, १२, १४, १७, ?|A:२०|B:२२|C:२५|D:२१');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
१०, ११, १२, १४, १७, ?', E'२०', E'२२', E'२५', E'२१', E'B', E'फिबोननाची (Fibonacci) शृङ्खलाका सङ्ख्याहरू (१, १, २, ३, ५) जोडिएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
१०, ११, १२, १४, १७, ?|A:२०|B:२२|C:२५|D:२१'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
१०, १९, ३४, ५९, १०२, ?|A:१७५|B:१८०|C:१७९|D:१६०');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
१०, १९, ३४, ५९, १०२, ?', E'१७५', E'१८०', E'१७९', E'१६०', E'C', E'२ ले गुणन गरी क्रमशः १, ४, ९, १६, २५ (वर्ग सङ्ख्या) घटाइएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
१०, १९, ३४, ५९, १०२, ?|A:१७५|B:१८०|C:१७९|D:१६०'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
५, १५, ३५, ६५, १०५, ?|A:१५०|B:१४०|C:१६०|D:१५५');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 20, E'दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
५, १५, ३५, ६५, १०५, ?', E'१५०', E'१४०', E'१६०', E'१५५', E'D', E'क्रमशः १०, २०, ३०, ४०, ५० जोडिएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
५, १५, ३५, ६५, १०५, ?|A:१५०|B:१४०|C:१६०|D:१५५'), v_set_id, v_q_id, 20)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
२, ३, ८, २७, ११२, ?|A:५६५|B:५५०|C:५४०|D:५६०');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 21, E'दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
२, ३, ८, २७, ११२, ?', E'५६५', E'५५०', E'५४०', E'५६०', E'A', E'क्रमशः १ ले गुणन गरी १ जोड्ने, २ ले गुणन गरी २ जोड्ने, ३ ले गुणन गरी ३ जोड्ने गरिएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
२, ३, ८, २७, ११२, ?|A:५६५|B:५५०|C:५४०|D:५६०'), v_set_id, v_q_id, 21)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
१६, ४०, १००, २५०, ६२५, ?|A:१५००|B:१५६२.५|C:१५५०|D:१६००');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 22, E'दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
१६, ४०, १००, २५०, ६२५, ?', E'१५००', E'१५६२.५', E'१५५०', E'१६००', E'B', E'प्रत्येक सङ्ख्यालाई २.५ ले गुणन गरिएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
१६, ४०, १००, २५०, ६२५, ?|A:१५००|B:१५६२.५|C:१५५०|D:१६००'), v_set_id, v_q_id, 22)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
१२, १४, १८, २६, ३२, ?|A:३६|B:४०|C:३४|D:३८');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 23, E'दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
१२, १४, १८, २६, ३२, ?', E'३६', E'४०', E'३४', E'३८', E'C', E'अघिल्लो सङ्ख्यामा त्यसकै अन्तिम अङ्क जोडिएको छ (३२+२=३४)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
१२, १४, १८, २६, ३२, ?|A:३६|B:४०|C:३४|D:३८'), v_set_id, v_q_id, 23)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
१५, २१, २४, ३०, ३३, ?|A:३६|B:४०|C:४५|D:३९');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 24, E'दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
१५, २१, २४, ३०, ३३, ?', E'३६', E'४०', E'४५', E'३९', E'D', E'अघिल्लो सङ्ख्यामा त्यसका अङ्कहरूको योगफल जोडिएको छ (३३+३+३=३९)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
१५, २१, २४, ३०, ३३, ?|A:३६|B:४०|C:४५|D:३९'), v_set_id, v_q_id, 24)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
१, ५, १७, ५३, १६१, ?|A:४८५|B:४८०|C:४७०|D:५००');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 25, E'दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
१, ५, १७, ५३, १६१, ?', E'४८५', E'४८०', E'४७०', E'५००', E'A', E'प्रत्येक सङ्ख्यालाई ३ ले गुणन गरी २ जोडिएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
१, ५, १७, ५३, १६१, ?|A:४८५|B:४८०|C:४७०|D:५००'), v_set_id, v_q_id, 25)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
५, ५, ६, १४, ४१, ?|A:१००|B:१०५|C:११०|D:९५');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 26, E'दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
५, ५, ६, १४, ४१, ?', E'१००', E'१०५', E'११०', E'९५', E'B', E'क्रमशः ०, १, ८, २७, ६४ (घन सङ्ख्या) जोडिएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएको शृङ्खलामा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
५, ५, ६, १४, ४१, ?|A:१००|B:१०५|C:११०|D:९५'), v_set_id, v_q_id, 26)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै सङ्ख्याको आधामा ५ जोड्दा १५ हुन्छ भने त्यो सङ्ख्या कति होला?|A:२५|B:३०|C:२०|D:१५');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 27, E'कुनै सङ्ख्याको आधामा ५ जोड्दा १५ हुन्छ भने त्यो सङ्ख्या कति होला?', E'२५', E'३०', E'२०', E'१५', E'C', E'x/२ + ५ = १५ => x = २०', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै सङ्ख्याको आधामा ५ जोड्दा १५ हुन्छ भने त्यो सङ्ख्या कति होला?|A:२५|B:३०|C:२०|D:१५'), v_set_id, v_q_id, 27)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै दुई लगातार सङ्ख्याहरूको वर्गको फरक २५ छ भने सानो सङ्ख्या कुन हो?|A:१३|B:१४|C:११|D:१२');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 28, E'कुनै दुई लगातार सङ्ख्याहरूको वर्गको फरक २५ छ भने सानो सङ्ख्या कुन हो?', E'१३', E'१४', E'११', E'१२', E'D', E'(x+१)² - x² = २५ => २x + १ = २५ => x = १२', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै दुई लगातार सङ्ख्याहरूको वर्गको फरक २५ छ भने सानो सङ्ख्या कुन हो?|A:१३|B:१४|C:११|D:१२'), v_set_id, v_q_id, 28)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै सङ्ख्याको २/३ भाग २४ हुन्छ भने त्यो सङ्ख्या कति हो?|A:३६|B:४०|C:३२|D:२८');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 29, E'कुनै सङ्ख्याको २/३ भाग २४ हुन्छ भने त्यो सङ्ख्या कति हो?', E'३६', E'४०', E'३२', E'२८', E'A', E'(२/३)x = २४ => x = ३६', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै सङ्ख्याको २/३ भाग २४ हुन्छ भने त्यो सङ्ख्या कति हो?|A:३६|B:४०|C:३२|D:२८'), v_set_id, v_q_id, 29)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै सङ्ख्यामा त्यसकै वर्ग (square) जोड्दा ४२ हुन्छ भने त्यो सङ्ख्या कुन हो?|A:७|B:६|C:५|D:८');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 30, E'कुनै सङ्ख्यामा त्यसकै वर्ग (square) जोड्दा ४२ हुन्छ भने त्यो सङ्ख्या कुन हो?', E'७', E'६', E'५', E'८', E'B', E'x + x² = ४२ => x(x+१) = ६*७ => x = ६', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै सङ्ख्यामा त्यसकै वर्ग (square) जोड्दा ४२ हुन्छ भने त्यो सङ्ख्या कुन हो?|A:७|B:६|C:५|D:८'), v_set_id, v_q_id, 30)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: गणितीय क्षमताः छुटेका सङ्ख्याहरू पुरा गर्ने - खण्ड 3 (आधारभूत तह) (30 Q)
  v_set_id := extensions.uuid_generate_v5('d912e8af-d7b4-4104-8bd0-e478e3f530a1'::uuid, E'गणितीय क्षमताः छुटेका सङ्ख्याहरू पुरा गर्ने - खण्ड 3 (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'db9d9515-ced5-4a90-a4ac-3a8927342e98'::uuid, 'd912e8af-d7b4-4104-8bd0-e478e3f530a1'::uuid, E'गणितीय क्षमताः छुटेका सङ्ख्याहरू पुरा गर्ने - खण्ड 3 (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'd912e8af-d7b4-4104-8bd0-e478e3f530a1'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै सङ्ख्याको ५ गुणाबाट १० घटाउँदा सोही सङ्ख्याको ३ गुणामा २० जोडे बराबर हुन्छ भने त्यो सङ्ख्या कति हो?|A:१५|B:१०|C:२०|D:२५');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'कुनै सङ्ख्याको ५ गुणाबाट १० घटाउँदा सोही सङ्ख्याको ३ गुणामा २० जोडे बराबर हुन्छ भने त्यो सङ्ख्या कति हो?', E'१५', E'१०', E'२०', E'२५', E'A', E'५x - १० = ३x + २० => २x = ३० => x = १५', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै सङ्ख्याको ५ गुणाबाट १० घटाउँदा सोही सङ्ख्याको ३ गुणामा २० जोडे बराबर हुन्छ भने त्यो सङ्ख्या कति हो?|A:१५|B:१०|C:२०|D:२५'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै ३ वटा लगातार जोर (Even) सङ्ख्याहरूको योगफल ३६ छ भने सबैभन्दा ठूलो सङ्ख्या कुन हो?|A:१२|B:१४|C:१६|D:१८');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'कुनै ३ वटा लगातार जोर (Even) सङ्ख्याहरूको योगफल ३६ छ भने सबैभन्दा ठूलो सङ्ख्या कुन हो?', E'१२', E'१४', E'१६', E'१८', E'B', E'x + (x+२) + (x+४) = ३६ => ३x = ३० => x=१०. ठूलो सङ्ख्या = १४', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै ३ वटा लगातार जोर (Even) सङ्ख्याहरूको योगफल ३६ छ भने सबैभन्दा ठूलो सङ्ख्या कुन हो?|A:१२|B:१४|C:१६|D:१८'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै ३ वटा लगातार बिजोर (Odd) सङ्ख्याहरूको योगफल ५१ छ भने बिचको सङ्ख्या कुन हो?|A:१५|B:१९|C:१७|D:२१');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'कुनै ३ वटा लगातार बिजोर (Odd) सङ्ख्याहरूको योगफल ५१ छ भने बिचको सङ्ख्या कुन हो?', E'१५', E'१९', E'१७', E'२१', E'C', E'(x-२) + x + (x+२) = ५१ => ३x = ५१ => x = १७', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै ३ वटा लगातार बिजोर (Odd) सङ्ख्याहरूको योगफल ५१ छ भने बिचको सङ्ख्या कुन हो?|A:१५|B:१९|C:१७|D:२१'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै सङ्ख्या र त्यसको ३/५ भाग बिचको फरक १८ छ भने त्यो सङ्ख्या कति हो?|A:४०|B:५०|C:५५|D:४५');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'कुनै सङ्ख्या र त्यसको ३/५ भाग बिचको फरक १८ छ भने त्यो सङ्ख्या कति हो?', E'४०', E'५०', E'५५', E'४५', E'D', E'x - (३/५)x = १८ => (२/५)x = १८ => x = ४५', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै सङ्ख्या र त्यसको ३/५ भाग बिचको फरक १८ छ भने त्यो सङ्ख्या कति हो?|A:४०|B:५०|C:५५|D:४५'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै सङ्ख्यालाई दोब्बर गरी १० जोड्दा ५० हुन्छ भने त्यो सङ्ख्या कुन हो?|A:२०|B:२५|C:१५|D:३०');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'कुनै सङ्ख्यालाई दोब्बर गरी १० जोड्दा ५० हुन्छ भने त्यो सङ्ख्या कुन हो?', E'२०', E'२५', E'१५', E'३०', E'A', E'२x + १० = ५० => x = २०', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै सङ्ख्यालाई दोब्बर गरी १० जोड्दा ५० हुन्छ भने त्यो सङ्ख्या कुन हो?|A:२०|B:२५|C:१५|D:३०'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै सङ्ख्याको वर्गमूल (Square root) मा ५ जोड्दा १३ हुन्छ भने त्यो सङ्ख्या कति होला?|A:४९|B:६४|C:८१|D:१००');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'कुनै सङ्ख्याको वर्गमूल (Square root) मा ५ जोड्दा १३ हुन्छ भने त्यो सङ्ख्या कति होला?', E'४९', E'६४', E'८१', E'१००', E'B', E'√x + ५ = १३ => √x = ८ => x = ६४', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै सङ्ख्याको वर्गमूल (Square root) मा ५ जोड्दा १३ हुन्छ भने त्यो सङ्ख्या कति होला?|A:४९|B:६४|C:८१|D:१००'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै सङ्ख्यालाई ५ ले भाग गर्दा शेष ३ आउँछ र भागफल ४ आउँछ भने त्यो सङ्ख्या कुन हो?|A:२०|B:२५|C:२३|D:२८');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'कुनै सङ्ख्यालाई ५ ले भाग गर्दा शेष ३ आउँछ र भागफल ४ आउँछ भने त्यो सङ्ख्या कुन हो?', E'२०', E'२५', E'२३', E'२८', E'C', E'सङ्ख्या = ५ × ४ + ३ = २३', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै सङ्ख्यालाई ५ ले भाग गर्दा शेष ३ आउँछ र भागफल ४ आउँछ भने त्यो सङ्ख्या कुन हो?|A:२०|B:२५|C:२३|D:२८'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दुई सङ्ख्याहरूको योग २१ र गुणनफल १०८ छ भने तीमध्ये ठूलो सङ्ख्या कुन हो?|A:९|B:१५|C:१४|D:१२');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'दुई सङ्ख्याहरूको योग २१ र गुणनफल १०८ छ भने तीमध्ये ठूलो सङ्ख्या कुन हो?', E'९', E'१५', E'१४', E'१२', E'D', E'x + y = २१, xy = १०८. सङ्ख्याहरू ९ र १२ हुन्। ठूलो = १२', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दुई सङ्ख्याहरूको योग २१ र गुणनफल १०८ छ भने तीमध्ये ठूलो सङ्ख्या कुन हो?|A:९|B:१५|C:१४|D:१२'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै सङ्ख्याको ३/४ भाग सोही सङ्ख्याको १/२ भागभन्दा १० ले बढी छ भने त्यो सङ्ख्या कति हो?|A:४०|B:३०|C:५०|D:४५');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'कुनै सङ्ख्याको ३/४ भाग सोही सङ्ख्याको १/२ भागभन्दा १० ले बढी छ भने त्यो सङ्ख्या कति हो?', E'४०', E'३०', E'५०', E'४५', E'A', E'(३/४)x - (१/२)x = १० => (१/४)x = १० => x = ४०', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै सङ्ख्याको ३/४ भाग सोही सङ्ख्याको १/२ भागभन्दा १० ले बढी छ भने त्यो सङ्ख्या कति हो?|A:४०|B:३०|C:५०|D:४५'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै सङ्ख्यामा त्यसको १०% जोड्दा ५५ हुन्छ भने त्यो सङ्ख्या कुन हो?|A:४५|B:५०|C:६०|D:४०');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'कुनै सङ्ख्यामा त्यसको १०% जोड्दा ५५ हुन्छ भने त्यो सङ्ख्या कुन हो?', E'४५', E'५०', E'६०', E'४०', E'B', E'x + ०.१x = ५५ => १.१x = ५५ => x = ५०', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै सङ्ख्यामा त्यसको १०% जोड्दा ५५ हुन्छ भने त्यो सङ्ख्या कुन हो?|A:४५|B:५०|C:६०|D:४०'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै सङ्ख्याको ४०% र २०% बिचको फरक ३० छ भने त्यो सङ्ख्या कति हो?|A:१००|B:२००|C:१५०|D:२५०');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'कुनै सङ्ख्याको ४०% र २०% बिचको फरक ३० छ भने त्यो सङ्ख्या कति हो?', E'१००', E'२००', E'१५०', E'२५०', E'C', E'४०% - २०% = २०%. २०% of x = ३० => x = १५०', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै सङ्ख्याको ४०% र २०% बिचको फरक ३० छ भने त्यो सङ्ख्या कति हो?|A:१००|B:२००|C:१५०|D:२५०'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै दुई अङ्कको सङ्ख्या जसका अङ्कहरूको योग ९ छ, यदि अङ्कहरूको स्थान परिवर्तन गर्दा बन्ने नयाँ सङ्ख्या पुरानो भन्दा २७ ले बढी छ भने त्यो सङ्ख्या कुन हो?|A:४५|B:२७|C:१८|D:३६');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'कुनै दुई अङ्कको सङ्ख्या जसका अङ्कहरूको योग ९ छ, यदि अङ्कहरूको स्थान परिवर्तन गर्दा बन्ने नयाँ सङ्ख्या पुरानो भन्दा २७ ले बढी छ भने त्यो सङ्ख्या कुन हो?', E'४५', E'२७', E'१८', E'३६', E'D', E'१०y+x - (१०x+y) = २७ => y-x = ३. र x+y = ९. हल गर्दा x=३, y=६. सङ्ख्या ३६', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै दुई अङ्कको सङ्ख्या जसका अङ्कहरूको योग ९ छ, यदि अङ्कहरूको स्थान परिवर्तन गर्दा बन्ने नयाँ सङ्ख्या पुरानो भन्दा २७ ले बढी छ भने त्यो सङ्ख्या कुन हो?|A:४५|B:२७|C:१८|D:३६'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै सङ्ख्यालाई त्यही सङ्ख्याको आधाले गुणन गर्दा १८ हुन्छ भने त्यो सङ्ख्या कुन हो?|A:६|B:४|C:८|D:९');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'कुनै सङ्ख्यालाई त्यही सङ्ख्याको आधाले गुणन गर्दा १८ हुन्छ भने त्यो सङ्ख्या कुन हो?', E'६', E'४', E'८', E'९', E'A', E'x * (x/२) = १८ => x² = ३६ => x = ६ (धनात्मक मान)', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै सङ्ख्यालाई त्यही सङ्ख्याको आधाले गुणन गर्दा १८ हुन्छ भने त्यो सङ्ख्या कुन हो?|A:६|B:४|C:८|D:९'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै सङ्ख्या आफ्नो एक चौथाइ (1/4) भन्दा २४ ले ठूलो छ भने त्यो सङ्ख्या कति हो?|A:२८|B:३२|C:३६|D:४०');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'कुनै सङ्ख्या आफ्नो एक चौथाइ (1/4) भन्दा २४ ले ठूलो छ भने त्यो सङ्ख्या कति हो?', E'२८', E'३२', E'३६', E'४०', E'B', E'x - x/४ = २४ => (३/४)x = २४ => x = ३२', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै सङ्ख्या आफ्नो एक चौथाइ (1/4) भन्दा २४ ले ठूलो छ भने त्यो सङ्ख्या कति हो?|A:२८|B:३२|C:३६|D:४०'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै दुई सङ्ख्याहरूको अनुपात ३:५ छ र तिनीहरूको फरक १४ छ भने सानो सङ्ख्या कुन हो?|A:१४|B:२८|C:२१|D:३५');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'कुनै दुई सङ्ख्याहरूको अनुपात ३:५ छ र तिनीहरूको फरक १४ छ भने सानो सङ्ख्या कुन हो?', E'१४', E'२८', E'२१', E'३५', E'C', E'५x - ३x = १४ => २x = १४ => x=७. सानो = ३*७ = २१', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै दुई सङ्ख्याहरूको अनुपात ३:५ छ र तिनीहरूको फरक १४ छ भने सानो सङ्ख्या कुन हो?|A:१४|B:२८|C:२१|D:३५'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'एउटा सङ्ख्याको दोब्बर अर्को सङ्ख्याको तेब्बरसँग बराबर छ। यदि तिनीहरूको योगफल ३५ छ भने ठूलो सङ्ख्या कुन हो?|A:१४|B:२८|C:३०|D:२१');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'एउटा सङ्ख्याको दोब्बर अर्को सङ्ख्याको तेब्बरसँग बराबर छ। यदि तिनीहरूको योगफल ३५ छ भने ठूलो सङ्ख्या कुन हो?', E'१४', E'२८', E'३०', E'२१', E'D', E'२x = ३y => x/y = ३/२. योग = ५ भाग = ३५ => १ भाग = ७. ठूलो = ३*७ = २१', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:एउटा सङ्ख्याको दोब्बर अर्को सङ्ख्याको तेब्बरसँग बराबर छ। यदि तिनीहरूको योगफल ३५ छ भने ठूलो सङ्ख्या कुन हो?|A:१४|B:२८|C:३०|D:२१'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै सङ्ख्याको ५०% मा ५० जोड्दा त्यही सङ्ख्या बन्छ भने त्यो सङ्ख्या कति हो?|A:१००|B:५०|C:१५०|D:२००');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'कुनै सङ्ख्याको ५०% मा ५० जोड्दा त्यही सङ्ख्या बन्छ भने त्यो सङ्ख्या कति हो?', E'१००', E'५०', E'१५०', E'२००', E'A', E'५०% of x + ५० = x => ५०% of x = ५० => x = १००', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै सङ्ख्याको ५०% मा ५० जोड्दा त्यही सङ्ख्या बन्छ भने त्यो सङ्ख्या कति हो?|A:१००|B:५०|C:१५०|D:२००'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै सङ्ख्यालाई ४ ले गुणन गर्नुको साटो ४ ले भाग गर्दा उत्तर १५ आयो भने सही उत्तर कति आउनुपर्थ्यो?|A:६०|B:२४०|C:१२०|D:३००');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'कुनै सङ्ख्यालाई ४ ले गुणन गर्नुको साटो ४ ले भाग गर्दा उत्तर १५ आयो भने सही उत्तर कति आउनुपर्थ्यो?', E'६०', E'२४०', E'१२०', E'३००', E'B', E'x/४ = १५ => x = ६०. सही उत्तर = ६० * ४ = २४०', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै सङ्ख्यालाई ४ ले गुणन गर्नुको साटो ४ ले भाग गर्दा उत्तर १५ आयो भने सही उत्तर कति आउनुपर्थ्यो?|A:६०|B:२४०|C:१२०|D:३००'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै सङ्ख्यामा ५ घटाएर ३ ले भाग गर्दा ७ हुन्छ भने त्यो सङ्ख्या कति हो?|A:२१|B:२८|C:२६|D:२४');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'कुनै सङ्ख्यामा ५ घटाएर ३ ले भाग गर्दा ७ हुन्छ भने त्यो सङ्ख्या कति हो?', E'२१', E'२८', E'२६', E'२४', E'C', E'(x-५)/३ = ७ => x-५ = २१ => x = २६', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै सङ्ख्यामा ५ घटाएर ३ ले भाग गर्दा ७ हुन्छ भने त्यो सङ्ख्या कति हो?|A:२१|B:२८|C:२६|D:२४'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दुई लगातार जोर सङ्ख्याहरूको गुणनफल १६८ छ भने तीमध्ये सानो सङ्ख्या कुन हो?|A:१४|B:१०|C:१६|D:१२');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 20, E'दुई लगातार जोर सङ्ख्याहरूको गुणनफल १६८ छ भने तीमध्ये सानो सङ्ख्या कुन हो?', E'१४', E'१०', E'१६', E'१२', E'D', E'x(x+२) = १६८. १२ * १४ = १६८ => सानो = १२', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दुई लगातार जोर सङ्ख्याहरूको गुणनफल १६८ छ भने तीमध्ये सानो सङ्ख्या कुन हो?|A:१४|B:१०|C:१६|D:१२'), v_set_id, v_q_id, 20)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै सङ्ख्याको १/३ र १/५ को योगफल ३२ हुन्छ भने त्यो सङ्ख्या कति हो?|A:६०|B:५०|C:४५|D:७५');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 21, E'कुनै सङ्ख्याको १/३ र १/५ को योगफल ३२ हुन्छ भने त्यो सङ्ख्या कति हो?', E'६०', E'५०', E'४५', E'७५', E'A', E'(१/३ + १/५)x = ३२ => (८/१५)x = ३२ => x = ६०', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै सङ्ख्याको १/३ र १/५ को योगफल ३२ हुन्छ भने त्यो सङ्ख्या कति हो?|A:६०|B:५०|C:४५|D:७५'), v_set_id, v_q_id, 21)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'एउटा कक्षामा केटा र केटीको अनुपात ३:४ छ। यदि जम्मा विद्यार्थी सङ्ख्या ३५ छ भने केटीहरूको सङ्ख्या कति होला?|A:१५|B:२०|C:२५|D:२१');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 22, E'एउटा कक्षामा केटा र केटीको अनुपात ३:४ छ। यदि जम्मा विद्यार्थी सङ्ख्या ३५ छ भने केटीहरूको सङ्ख्या कति होला?', E'१५', E'२०', E'२५', E'२१', E'B', E'जम्मा भाग = ३+४=७। ७ भाग = ३५, १ भाग = ५। केटीको सङ्ख्या = ४ * ५ = २०', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:एउटा कक्षामा केटा र केटीको अनुपात ३:४ छ। यदि जम्मा विद्यार्थी सङ्ख्या ३५ छ भने केटीहरूको सङ्ख्या कति होला?|A:१५|B:२०|C:२५|D:२१'), v_set_id, v_q_id, 22)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दुई सङ्ख्याहरूको अनुपात ४:७ छ। यदि तिनीहरूको योगफल १२१ छ भने तीमध्ये ठूलो सङ्ख्या कुन हो?|A:४४|B:६६|C:७७|D:८८');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 23, E'दुई सङ्ख्याहरूको अनुपात ४:७ छ। यदि तिनीहरूको योगफल १२१ छ भने तीमध्ये ठूलो सङ्ख्या कुन हो?', E'४४', E'६६', E'७७', E'८८', E'C', E'४+७ = ११ भाग = १२१ => १ भाग = ११। ठूलो सङ्ख्या = ७ * ११ = ७७', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दुई सङ्ख्याहरूको अनुपात ४:७ छ। यदि तिनीहरूको योगफल १२१ छ भने तीमध्ये ठूलो सङ्ख्या कुन हो?|A:४४|B:६६|C:७७|D:८८'), v_set_id, v_q_id, 23)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै सङ्ख्याको १५% ले ४५ हुन्छ भने त्यो सङ्ख्याको शतप्रतिशत (१००%) कति होला?|A:२००|B:२५०|C:३५०|D:३००');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 24, E'कुनै सङ्ख्याको १५% ले ४५ हुन्छ भने त्यो सङ्ख्याको शतप्रतिशत (१००%) कति होला?', E'२००', E'२५०', E'३५०', E'३००', E'D', E'१५% = ४५ => १% = ३ => १००% = ३००', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै सङ्ख्याको १५% ले ४५ हुन्छ भने त्यो सङ्ख्याको शतप्रतिशत (१००%) कति होला?|A:२००|B:२५०|C:३५०|D:३००'), v_set_id, v_q_id, 24)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'एउटा झोलामा भएका रातो र नीलो बलको अनुपात ५:३ छ। यदि रातो बलको सङ्ख्या २० छ भने नीलो बल कतिवटा होलान्?|A:१२|B:१५|C:१०|D:१४');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 25, E'एउटा झोलामा भएका रातो र नीलो बलको अनुपात ५:३ छ। यदि रातो बलको सङ्ख्या २० छ भने नीलो बल कतिवटा होलान्?', E'१२', E'१५', E'१०', E'१४', E'A', E'५ भाग = २० => १ भाग = ४। नीलो बल = ३ * ४ = १२', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:एउटा झोलामा भएका रातो र नीलो बलको अनुपात ५:३ छ। यदि रातो बलको सङ्ख्या २० छ भने नीलो बल कतिवटा होलान्?|A:१२|B:१५|C:१०|D:१४'), v_set_id, v_q_id, 25)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'रमेश र श्यामको हालको उमेरको अनुपात ५:६ छ। यदि ५ वर्षपछि उनीहरूको उमेरको योगफल ५४ हुन्छ भने रमेशको हालको उमेर कति हो?|A:२४|B:२०|C:२५|D:३०');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 26, E'रमेश र श्यामको हालको उमेरको अनुपात ५:६ छ। यदि ५ वर्षपछि उनीहरूको उमेरको योगफल ५४ हुन्छ भने रमेशको हालको उमेर कति हो?', E'२४', E'२०', E'२५', E'३०', E'B', E'हालको योग = ५x+६x = ११x. ५ वर्षपछिको योग = ११x + १० = ५४ => ११x = ४४ => x=४. रमेश = ५*४ = २०', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:रमेश र श्यामको हालको उमेरको अनुपात ५:६ छ। यदि ५ वर्षपछि उनीहरूको उमेरको योगफल ५४ हुन्छ भने रमेशको हालको उमेर कति हो?|A:२४|B:२०|C:२५|D:३०'), v_set_id, v_q_id, 26)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै मिश्रणमा दूध र पानीको अनुपात ७:२ छ। यदि मिश्रणको जम्मा मात्रा ३६ लिटर छ भने पानी कति लिटर होला?|A:२८|B:१०|C:८|D:१२');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 27, E'कुनै मिश्रणमा दूध र पानीको अनुपात ७:२ छ। यदि मिश्रणको जम्मा मात्रा ३६ लिटर छ भने पानी कति लिटर होला?', E'२८', E'१०', E'८', E'१२', E'C', E'७+२ = ९ भाग = ३६ लिटर => १ भाग = ४ लिटर। पानी = २ * ४ = ८ लिटर', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै मिश्रणमा दूध र पानीको अनुपात ७:२ छ। यदि मिश्रणको जम्मा मात्रा ३६ लिटर छ भने पानी कति लिटर होला?|A:२८|B:१०|C:८|D:१२'), v_set_id, v_q_id, 27)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै सङ्ख्याको १२.५% ले ५० हुन्छ भने त्यो सङ्ख्या कति हो?|A:३५०|B:४५०|C:५००|D:४००');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 28, E'कुनै सङ्ख्याको १२.५% ले ५० हुन्छ भने त्यो सङ्ख्या कति हो?', E'३५०', E'४५०', E'५००', E'४००', E'D', E'१२.५% = १/८ भाग = ५० => पूरा सङ्ख्या = ४००', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै सङ्ख्याको १२.५% ले ५० हुन्छ भने त्यो सङ्ख्या कति हो?|A:३५०|B:४५०|C:५००|D:४००'), v_set_id, v_q_id, 28)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दुई सङ्ख्याहरू ५:८ को अनुपातमा छन्। यदि दुवैमा ४ जोड्यो भने अनुपात २:३ हुन्छ। तीमध्ये सानो सङ्ख्या कुन हो?|A:२०|B:१५|C:२५|D:३०');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 29, E'दुई सङ्ख्याहरू ५:८ को अनुपातमा छन्। यदि दुवैमा ४ जोड्यो भने अनुपात २:३ हुन्छ। तीमध्ये सानो सङ्ख्या कुन हो?', E'२०', E'१५', E'२५', E'३०', E'A', E'(५x+४)/(८x+४) = २/३ => १५x+१२ = १६x+८ => x=४. सानो सङ्ख्या = ५*४ = २०', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दुई सङ्ख्याहरू ५:८ को अनुपातमा छन्। यदि दुवैमा ४ जोड्यो भने अनुपात २:३ हुन्छ। तीमध्ये सानो सङ्ख्या कुन हो?|A:२०|B:१५|C:२५|D:३०'), v_set_id, v_q_id, 29)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'रामले आफ्नो तलबको ३०% बचत गर्छ। यदि उसको मासिक खर्च रु. १४,००० छ भने उसको जम्मा तलब कति होला?|A:१५०००|B:२००००|C:२५०००|D:१८०००');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 30, E'रामले आफ्नो तलबको ३०% बचत गर्छ। यदि उसको मासिक खर्च रु. १४,००० छ भने उसको जम्मा तलब कति होला?', E'१५०००', E'२००००', E'२५०००', E'१८०००', E'B', E'खर्च = ७०% = १४,००० => १% = २०० => १००% = २०,०००', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:रामले आफ्नो तलबको ३०% बचत गर्छ। यदि उसको मासिक खर्च रु. १४,००० छ भने उसको जम्मा तलब कति होला?|A:१५०००|B:२००००|C:२५०००|D:१८०००'), v_set_id, v_q_id, 30)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: गणितीय क्षमताः छुटेका सङ्ख्याहरू पुरा गर्ने - खण्ड 4 (आधारभूत तह) (16 Q)
  v_set_id := extensions.uuid_generate_v5('d912e8af-d7b4-4104-8bd0-e478e3f530a1'::uuid, E'गणितीय क्षमताः छुटेका सङ्ख्याहरू पुरा गर्ने - खण्ड 4 (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'db9d9515-ced5-4a90-a4ac-3a8927342e98'::uuid, 'd912e8af-d7b4-4104-8bd0-e478e3f530a1'::uuid, E'गणितीय क्षमताः छुटेका सङ्ख्याहरू पुरा गर्ने - खण्ड 4 (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'd912e8af-d7b4-4104-8bd0-e478e3f530a1'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'एउटा त्रिभुजका तीन कोणहरूको अनुपात २:३:४ छ। सबैभन्दा ठूलो कोण कति डिग्रीको होला?|A:८०|B:६०|C:४०|D:१००');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'एउटा त्रिभुजका तीन कोणहरूको अनुपात २:३:४ छ। सबैभन्दा ठूलो कोण कति डिग्रीको होला?', E'८०', E'६०', E'४०', E'१००', E'A', E'२+३+४ = ९ भाग = १८०° => १ भाग = २०°। ठूलो कोण = ४ * २० = ८०°', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:एउटा त्रिभुजका तीन कोणहरूको अनुपात २:३:४ छ। सबैभन्दा ठूलो कोण कति डिग्रीको होला?|A:८०|B:६०|C:४०|D:१००'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै सङ्ख्याको ७५% मा ७५ जोड्दा सोही सङ्ख्या बन्छ भने त्यो सङ्ख्या कति हो?|A:२००|B:३००|C:२५०|D:४००');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'कुनै सङ्ख्याको ७५% मा ७५ जोड्दा सोही सङ्ख्या बन्छ भने त्यो सङ्ख्या कति हो?', E'२००', E'३००', E'२५०', E'४००', E'B', E'७५% + ७५ = १००% => २५% = ७५ => १००% = ३००', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै सङ्ख्याको ७५% मा ७५ जोड्दा सोही सङ्ख्या बन्छ भने त्यो सङ्ख्या कति हो?|A:२००|B:३००|C:२५०|D:४००'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'A र B को आम्दानीको अनुपात ३:२ छ र खर्चको अनुपात ५:३ छ। यदि दुवैले रु. १,००० बचत गर्छन् भने A को आम्दानी कति होला?|A:४०००|B:५०००|C:६०००|D:७०००');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'A र B को आम्दानीको अनुपात ३:२ छ र खर्चको अनुपात ५:३ छ। यदि दुवैले रु. १,००० बचत गर्छन् भने A को आम्दानी कति होला?', E'४०००', E'५०००', E'६०००', E'७०००', E'C', E'३x - ५y = १०००, २x - ३y = १०००. हल गर्दा x=२०००. A को आम्दानी = ३*२००० = ६०००', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:A र B को आम्दानीको अनुपात ३:२ छ र खर्चको अनुपात ५:३ छ। यदि दुवैले रु. १,००० बचत गर्छन् भने A को आम्दानी कति होला?|A:४०००|B:५०००|C:६०००|D:७०००'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'एउटा सामान रु. ४५० मा बेच्दा १०% घाटा हुन्छ। २०% नाफा कमाउन कतिमा बेच्नुपर्ला?|A:५५०|B:५००|C:६५०|D:६००');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'एउटा सामान रु. ४५० मा बेच्दा १०% घाटा हुन्छ। २०% नाफा कमाउन कतिमा बेच्नुपर्ला?', E'५५०', E'५००', E'६५०', E'६००', E'D', E'९०% = ४५० => १% = ५ => १२०% = ६००', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:एउटा सामान रु. ४५० मा बेच्दा १०% घाटा हुन्छ। २०% नाफा कमाउन कतिमा बेच्नुपर्ला?|A:५५०|B:५००|C:६५०|D:६००'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दुई सङ्ख्याहरूको ल.स. (LCM) र म.स. (HCF) क्रमशः १२० र ५ हुन्। यदि एउटा सङ्ख्या १५ छ भने अर्को सङ्ख्या कुन हो?|A:४०|B:३५|C:४५|D:३०');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'दुई सङ्ख्याहरूको ल.स. (LCM) र म.स. (HCF) क्रमशः १२० र ५ हुन्। यदि एउटा सङ्ख्या १५ छ भने अर्को सङ्ख्या कुन हो?', E'४०', E'३५', E'४५', E'३०', E'A', E'पहिलो × दोस्रो = ल.स. × म.स. => १५ × x = १२० × ५ => x = ४०', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दुई सङ्ख्याहरूको ल.स. (LCM) र म.स. (HCF) क्रमशः १२० र ५ हुन्। यदि एउटा सङ्ख्या १५ छ भने अर्को सङ्ख्या कुन हो?|A:४०|B:३५|C:४५|D:३०'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दुई सङ्ख्याहरूको अनुपात ३:४ छ र तिनीहरूको म.स. (HCF) १२ छ भने ती सङ्ख्याहरूको योगफल कति होला?|A:७२|B:८४|C:९६|D:६०');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'दुई सङ्ख्याहरूको अनुपात ३:४ छ र तिनीहरूको म.स. (HCF) १२ छ भने ती सङ्ख्याहरूको योगफल कति होला?', E'७२', E'८४', E'९६', E'६०', E'B', E'सङ्ख्याहरू ३x र ४x हुन्, जहाँ x = म.स. = १२। योगफल = ७x = ७ * १२ = ८४', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दुई सङ्ख्याहरूको अनुपात ३:४ छ र तिनीहरूको म.स. (HCF) १२ छ भने ती सङ्ख्याहरूको योगफल कति होला?|A:७२|B:८४|C:९६|D:६०'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'एउटा बाकसमा रु. १, ५० पैसा र २५ पैसाका सिक्काहरूको सङ्ख्याको अनुपात १:२:४ छ। यदि बाकसमा जम्मा रु. ६० छ भने ५० पैसाका सिक्का कतिवटा होलान्?|A:२०|B:६०|C:४०|D:८०');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'एउटा बाकसमा रु. १, ५० पैसा र २५ पैसाका सिक्काहरूको सङ्ख्याको अनुपात १:२:४ छ। यदि बाकसमा जम्मा रु. ६० छ भने ५० पैसाका सिक्का कतिवटा होलान्?', E'२०', E'६०', E'४०', E'८०', E'C', E'मूल्य अनुपात = १ : १ : १ (१*१, २*०.५, ४*०.२५)। जम्मा ३ भाग = रु. ६० => १ भाग = रु. २०। ५० पैसाको सिक्का = २ * २० = ४० वटा', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:एउटा बाकसमा रु. १, ५० पैसा र २५ पैसाका सिक्काहरूको सङ्ख्याको अनुपात १:२:४ छ। यदि बाकसमा जम्मा रु. ६० छ भने ५० पैसाका सिक्का कतिवटा होलान्?|A:२०|B:६०|C:४०|D:८०'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै परीक्षामा ४०% विद्यार्थी गणितमा र ३०% अङ्ग्रेजीमा अनुत्तीर्ण भए। १०% दुवैमा अनुत्तीर्ण भए। यदि जम्मा १४० जना दुवैमा उत्तीर्ण भए भने जम्मा विद्यार्थी कति थिए?|A:३००|B:४००|C:२५०|D:३५०');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'कुनै परीक्षामा ४०% विद्यार्थी गणितमा र ३०% अङ्ग्रेजीमा अनुत्तीर्ण भए। १०% दुवैमा अनुत्तीर्ण भए। यदि जम्मा १४० जना दुवैमा उत्तीर्ण भए भने जम्मा विद्यार्थी कति थिए?', E'३००', E'४००', E'२५०', E'३५०', E'D', E'अनुत्तीर्ण = ४० + ३० - १० = ६०%। उत्तीर्ण = ४०% = १४० => १००% = ३५०', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै परीक्षामा ४०% विद्यार्थी गणितमा र ३०% अङ्ग्रेजीमा अनुत्तीर्ण भए। १०% दुवैमा अनुत्तीर्ण भए। यदि जम्मा १४० जना दुवैमा उत्तीर्ण भए भने जम्मा विद्यार्थी कति थिए?|A:३००|B:४००|C:२५०|D:३५०'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दुई सङ्ख्याहरूको गुणनफल १५०० छ र तिनीहरूको अनुपात ३:५ छ भने सानो सङ्ख्या कुन हो?|A:३०|B:५०|C:२०|D:४०');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'दुई सङ्ख्याहरूको गुणनफल १५०० छ र तिनीहरूको अनुपात ३:५ छ भने सानो सङ्ख्या कुन हो?', E'३०', E'५०', E'२०', E'४०', E'A', E'(३x)(५x) = १५०० => १५x² = १५०० => x²=१०० => x=१०. सानो सङ्ख्या = ३*१० = ३०', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दुई सङ्ख्याहरूको गुणनफल १५०० छ र तिनीहरूको अनुपात ३:५ छ भने सानो सङ्ख्या कुन हो?|A:३०|B:५०|C:२०|D:४०'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै रकम A, B र C बिच ३:५:७ को अनुपातमा बाँडिदा C ले A भन्दा रु. ८०० बढी पायो भने जम्मा रकम कति होला?|A:२५००|B:३०००|C:३५००|D:२०००');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'कुनै रकम A, B र C बिच ३:५:७ को अनुपातमा बाँडिदा C ले A भन्दा रु. ८०० बढी पायो भने जम्मा रकम कति होला?', E'२५००', E'३०००', E'३५००', E'२०००', E'B', E'C - A = ७ - ३ = ४ भाग = ८०० => १ भाग = २००. जम्मा = १५ भाग = १५*२०० = ३०००', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै रकम A, B र C बिच ३:५:७ को अनुपातमा बाँडिदा C ले A भन्दा रु. ८०० बढी पायो भने जम्मा रकम कति होला?|A:२५००|B:३०००|C:३५००|D:२०००'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'एउटा सङ्ख्या अर्को सङ्ख्याभन्दा २५% ले ठूलो छ। त्यसोभए सानो सङ्ख्या ठूलो सङ्ख्याभन्दा कति प्रतिशतले सानो होला?|A:२५|B:१५|C:२०|D:१०');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'एउटा सङ्ख्या अर्को सङ्ख्याभन्दा २५% ले ठूलो छ। त्यसोभए सानो सङ्ख्या ठूलो सङ्ख्याभन्दा कति प्रतिशतले सानो होला?', E'२५', E'१५', E'२०', E'१०', E'C', E'(२५ / १२५) * १००% = २०%', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:एउटा सङ्ख्या अर्को सङ्ख्याभन्दा २५% ले ठूलो छ। त्यसोभए सानो सङ्ख्या ठूलो सङ्ख्याभन्दा कति प्रतिशतले सानो होला?|A:२५|B:१५|C:२०|D:१०'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै गाउँको जनसङ्ख्या १०% ले बढ्दा ५५०० पुग्छ भने पहिले जनसङ्ख्या कति थियो?|A:४५००|B:५२००|C:४८००|D:५०००');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'कुनै गाउँको जनसङ्ख्या १०% ले बढ्दा ५५०० पुग्छ भने पहिले जनसङ्ख्या कति थियो?', E'४५००', E'५२००', E'४८००', E'५०००', E'D', E'११०% = ५५०० => १% = ५० => १००% = ५०००', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै गाउँको जनसङ्ख्या १०% ले बढ्दा ५५०० पुग्छ भने पहिले जनसङ्ख्या कति थियो?|A:४५००|B:५२००|C:४८००|D:५०००'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'A ले एउटा काम १० दिनमा र B ले १५ दिनमा गर्न सक्छन्। दुवै मिलेर सो काम कति दिनमा सक्लान्?|A:६|B:८|C:५|D:७');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'A ले एउटा काम १० दिनमा र B ले १५ दिनमा गर्न सक्छन्। दुवै मिलेर सो काम कति दिनमा सक्लान्?', E'६', E'८', E'५', E'७', E'A', E'१/१० + १/१५ = ५/३० = १/६ => ६ दिन', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:A ले एउटा काम १० दिनमा र B ले १५ दिनमा गर्न सक्छन्। दुवै मिलेर सो काम कति दिनमा सक्लान्?|A:६|B:८|C:५|D:७'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'३० लिटरको नुन र पानीको मिश्रणमा १०% नुन छ। त्यसमा कति पानी मिसाउँदा नुनको मात्रा ५% होला?|A:२०|B:३०|C:१५|D:१०');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'३० लिटरको नुन र पानीको मिश्रणमा १०% नुन छ। त्यसमा कति पानी मिसाउँदा नुनको मात्रा ५% होला?', E'२०', E'३०', E'१५', E'१०', E'B', E'सुरुमा नुन = ३ लिटर। नयाँ मिश्रणमा ५% = ३ लिटर => १००% = ६० लिटर। थप्नुपर्ने पानी = ६० - ३० = ३० लिटर', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:३० लिटरको नुन र पानीको मिश्रणमा १०% नुन छ। त्यसमा कति पानी मिसाउँदा नुनको मात्रा ५% होला?|A:२०|B:३०|C:१५|D:१०'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दुई सङ्ख्याहरूको अनुपात ७:९ छ। यदि प्रत्येकबाट १२ घटायो भने नयाँ अनुपात ३:४ हुन्छ। ती सङ्ख्याहरूको योगफल कति होला?|A:१८०|B:२००|C:१९२|D:१७५');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'दुई सङ्ख्याहरूको अनुपात ७:९ छ। यदि प्रत्येकबाट १२ घटायो भने नयाँ अनुपात ३:४ हुन्छ। ती सङ्ख्याहरूको योगफल कति होला?', E'१८०', E'२००', E'१९२', E'१७५', E'C', E'(७x-१२)/(९x-१२) = ३/४ => २८x-४८ = २७x-३६ => x=१२. योग = १६x = १६*१२ = १९२', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दुई सङ्ख्याहरूको अनुपात ७:९ छ। यदि प्रत्येकबाट १२ घटायो भने नयाँ अनुपात ३:४ हुन्छ। ती सङ्ख्याहरूको योगफल कति होला?|A:१८०|B:२००|C:१९२|D:१७५'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'एउटा चुनावमा दुई उम्मेदवार थिए। जित्नेले ६०% मत ल्याएर ४०० मतको अन्तरले चुनाव जित्यो। जम्मा खसेको मत कति होला?|A:१५००|B:२५००|C:१८००|D:२०००');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'एउटा चुनावमा दुई उम्मेदवार थिए। जित्नेले ६०% मत ल्याएर ४०० मतको अन्तरले चुनाव जित्यो। जम्मा खसेको मत कति होला?', E'१५००', E'२५००', E'१८००', E'२०००', E'D', E'जित्ने = ६०%, हार्ने = ४०%। अन्तर = २०% = ४०० => १००% = २०००', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:एउटा चुनावमा दुई उम्मेदवार थिए। जित्नेले ६०% मत ल्याएर ४०० मतको अन्तरले चुनाव जित्यो। जम्मा खसेको मत कति होला?|A:१५००|B:२५००|C:१८००|D:२०००'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  RAISE NOTICE 'round-2 overflow complete: 6 sets, 158 questions.';
END $$;
