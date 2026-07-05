-- Create new overflow sets for tsc_aptitude_bank batch (beyond the 30Q cap of existing sets).
-- Generated 2026-07-05T13:20:24.234Z.
DO $$
DECLARE
  v_module_id uuid := '6695669a-f40e-421a-a4ec-b09bbeaf56c4'::uuid;
  v_set_id uuid;
  v_q_id uuid;
BEGIN

  -- Set: शाब्दिक बौद्धिक परीक्षणः समरूपता/Analogies - खण्ड 2 (आधारभूत तह) (30 Q)
  v_set_id := extensions.uuid_generate_v5('91240d83-acef-40dd-9fa2-412f8b797e45'::uuid, E'शाब्दिक बौद्धिक परीक्षणः समरूपता/Analogies - खण्ड 2 (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'efc9184a-c265-4fd8-bb99-aad431aefc58'::uuid, '91240d83-acef-40dd-9fa2-412f8b797e45'::uuid, E'शाब्दिक बौद्धिक परीक्षणः समरूपता/Analogies - खण्ड 2 (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '91240d83-acef-40dd-9fa2-412f8b797e45'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'म्यानमार : क्यात :: भुटान : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'म्यानमार : क्यात :: भुटान : ?', E'नुल्ट्रम', E'टाका', E'रुपैयाँ', E'रिंगिट', E'A', E'जसरी म्यानमारको मुद्रा क्यात हो, त्यसैगरी भुटानको मुद्रा नुल्ट्रम हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:म्यानमार : क्यात :: भुटान : ?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'गाई : बाच्छो :: कुकुर : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'गाई : बाच्छो :: कुकुर : ?', E'पाठो', E'छाउरो', E'डमरु', E'चल्ला', E'B', E'जसरी गाईको बच्चालाई बाच्छो भनिन्छ, त्यसैगरी कुकुरको बच्चालाई छाउरो भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:गाई : बाच्छो :: कुकुर : ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'घोडा : बछेडो :: भेडा : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'घोडा : बछेडो :: भेडा : ?', E'पाठो', E'डमरु', E'थुमा', E'छाउरो', E'C', E'जसरी घोडाको बच्चालाई बछेडो भनिन्छ, त्यसैगरी भेडाको बच्चालाई थुमा (वा पाठा) भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:घोडा : बछेडो :: भेडा : ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'मृग : पाठा :: भ्यागुतो : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'मृग : पाठा :: भ्यागुतो : ?', E'भुरा', E'चल्ला', E'छाउरो', E'चेपागाँडा', E'D', E'जसरी मृगको बच्चालाई पाठा भनिन्छ, त्यसैगरी भ्यागुतोको बच्चालाई चेपागाँडा भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:मृग : पाठा :: भ्यागुतो : ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'चरा : चल्ला :: हाँस : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'चरा : चल्ला :: हाँस : ?', E'चल्ला', E'भुरा', E'पाठा', E'छावा', E'A', E'जसरी चराको बच्चालाई चल्ला भनिन्छ, त्यसैगरी हाँसको बच्चालाई पनि चल्ला भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:चरा : चल्ला :: हाँस : ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'भैंसी : पाडो :: गधा : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'भैंसी : पाडो :: गधा : ?', E'पाठा', E'बछेडो', E'डमरु', E'छाउरो', E'B', E'जसरी भैंसीको बच्चालाई पाडो भनिन्छ, त्यसैगरी गधाको बच्चालाई बछेडो भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:भैंसी : पाडो :: गधा : ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'बाँदर : बच्चा :: माछा : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'बाँदर : बच्चा :: माछा : ?', E'चल्ला', E'पाठा', E'भुरा', E'चेपागाँडा', E'C', E'जसरी बाँदरको बच्चालाई बच्चा भनिन्छ, त्यसैगरी माछाको बच्चालाई भुरा भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:बाँदर : बच्चा :: माछा : ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुकुर : भुक्नु :: बिरालो : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'कुकुर : भुक्नु :: बिरालो : ?', E'भुक्नु', E'गर्जिनु', E'रम्भाउनु', E'म्याउँ गर्नु', E'D', E'जसरी कुकुरको आवाजलाई भुक्नु भनिन्छ, त्यसैगरी बिरालोको आवाजलाई म्याउँ गर्नु भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुकुर : भुक्नु :: बिरालो : ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'गाई : रम्भाउनु :: सिंह : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'गाई : रम्भाउनु :: सिंह : ?', E'गर्जिनु', E'कराउनु', E'भुक्नु', E'हिनहिनाउनु', E'A', E'जसरी गाई कराउने आवाजलाई रम्भाउनु भनिन्छ, त्यसैगरी सिंह कराउने आवाजलाई गर्जिनु भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:गाई : रम्भाउनु :: सिंह : ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'घोडा : हिनहिनाउनु :: हात्ती : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'घोडा : हिनहिनाउनु :: हात्ती : ?', E'रम्भाउनु', E'चिङ्घार्नु', E'गर्जिनु', E'कराउनु', E'B', E'जसरी घोडाको आवाजलाई हिनहिनाउनु भनिन्छ, त्यसैगरी हात्तीको आवाजलाई चिङ्घार्नु भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:घोडा : हिनहिनाउनु :: हात्ती : ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सर्प : फुँफकार :: भ्यागुतो : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'सर्प : फुँफकार :: भ्यागुतो : ?', E'म्याउँ गर्नु', E'भुक्नु', E'टर्टराउनु', E'गर्जिनु', E'C', E'जसरी सर्पको आवाजलाई फुँफकार भनिन्छ, त्यसैगरी भ्यागुतोको आवाजलाई टर्टराउनु भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सर्प : फुँफकार :: भ्यागुतो : ?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'बाघ : गर्जिनु :: स्याल : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'बाघ : गर्जिनु :: स्याल : ?', E'भुक्नु', E'म्याउँ गर्नु', E'कराउनु', E'हुइयाँ गर्नु', E'D', E'जसरी बाघ गर्जिन्छ, त्यसैगरी स्यालले हुइयाँ गर्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:बाघ : गर्जिनु :: स्याल : ?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'भेडा : म्याँ म्याँ :: गधा : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'भेडा : म्याँ म्याँ :: गधा : ?', E'रेङ्नु', E'हिनहिनाउनु', E'चिङ्घार्नु', E'भुक्नु', E'A', E'जसरी भेडाले म्याँ म्याँ गर्छ, त्यसैगरी गधाले रेङ्नु (कराउनु) गर्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:भेडा : म्याँ म्याँ :: गधा : ?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सुँगुर : घुँरघुँर :: बाँदर : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'सुँगुर : घुँरघुँर :: बाँदर : ?', E'म्याउँ गर्नु', E'चिटीचिटी', E'टर्टराउनु', E'गर्जिनु', E'B', E'जसरी सुँगुरले घुँरघुँर गर्छ, त्यसैगरी बाँदरले चिटीचिटी गर्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सुँगुर : घुँरघुँर :: बाँदर : ?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कोइली : कुहुकुहु :: कुखुरा : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'कोइली : कुहुकुहु :: कुखुरा : ?', E'भुनभुन', E'घुरघुर', E'बास्नु', E'काँ काँ', E'C', E'जसरी कोइलीले कुहुकुहु गर्छ, त्यसैगरी कुखुरा बास्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कोइली : कुहुकुहु :: कुखुरा : ?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'माहुरी : भुनभुन :: झिँगा : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'माहुरी : भुनभुन :: झिँगा : ?', E'कुहुकुहु', E'बास्नु', E'टर्टराउनु', E'भुनभुन', E'D', E'जसरी माहुरीले भुनभुन गर्छ, त्यसैगरी झिँगाले पनि भुनभुन गर्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:माहुरी : भुनभुन :: झिँगा : ?'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सिकर्मी : आरी :: डकर्मी : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'सिकर्मी : आरी :: डकर्मी : ?', E'करणी', E'हलो', E'कलम', E'स्टेथोस्कोप', E'A', E'जसरी सिकर्मीको मुख्य औजार आरी हो, त्यसैगरी डकर्मीको मुख्य औजार करणी हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सिकर्मी : आरी :: डकर्मी : ?'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'डाक्टर : स्टेथोस्कोप :: किसान : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'डाक्टर : स्टेथोस्कोप :: किसान : ?', E'बन्दुक', E'हलो', E'जाल', E'ब्रस', E'B', E'जसरी डाक्टरले प्रयोग गर्ने मुख्य उपकरण स्टेथोस्कोप हो, त्यसैगरी किसानले प्रयोग गर्ने मुख्य औजार हलो हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:डाक्टर : स्टेथोस्कोप :: किसान : ?'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षक : चक :: विद्यार्थी : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'शिक्षक : चक :: विद्यार्थी : ?', E'हलो', E'कैंची', E'कलम', E'चक्कु', E'C', E'जसरी शिक्षकको मुख्य साधन चक हो, त्यसैगरी विद्यार्थीको मुख्य साधन कलम हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षक : चक :: विद्यार्थी : ?'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'लेखक : कलम :: चित्रकार : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 20, E'लेखक : कलम :: चित्रकार : ?', E'आरी', E'करणी', E'जाल', E'ब्रस', E'D', E'जसरी लेखकको औजार कलम हो, त्यसैगरी चित्रकारको औजार ब्रस हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:लेखक : कलम :: चित्रकार : ?'), v_set_id, v_q_id, 20)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दर्जी : सियो :: हजाम : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 21, E'दर्जी : सियो :: हजाम : ?', E'कैंची', E'हलो', E'बन्दुक', E'चक्र', E'A', E'जसरी दर्जीको मुख्य औजार सियो हो, त्यसैगरी हजामको मुख्य औजार कैंची हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दर्जी : सियो :: हजाम : ?'), v_set_id, v_q_id, 21)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सिकारी : बन्दुक :: माझी : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 22, E'सिकारी : बन्दुक :: माझी : ?', E'ब्रस', E'जाल', E'हलो', E'कलम', E'B', E'जसरी सिकारीले बन्दुक प्रयोग गर्छ, त्यसैगरी माझीले माछा मार्न जाल प्रयोग गर्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सिकारी : बन्दुक :: माझी : ?'), v_set_id, v_q_id, 22)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'लोहार : हथौडा :: सुनार : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 23, E'लोहार : हथौडा :: सुनार : ?', E'आरी', E'करणी', E'चिम्ता', E'बन्दुक', E'C', E'जसरी लोहारको मुख्य औजार हथौडा हो, त्यसैगरी सुनारको मुख्य औजार चिम्ता हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:लोहार : हथौडा :: सुनार : ?'), v_set_id, v_q_id, 23)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वैज्ञानिक : माइक्रोस्कोप :: खगोलविद : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 24, E'वैज्ञानिक : माइक्रोस्कोप :: खगोलविद : ?', E'स्टेथोस्कोप', E'हलो', E'ब्रस', E'टेलिस्कोप', E'D', E'जसरी वैज्ञानिकले सुक्ष्म जीव हेर्न माइक्रोस्कोप प्रयोग गर्छन्, त्यसैगरी खगोलविदले आकाशीय पिण्ड हेर्न टेलिस्कोप प्रयोग गर्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वैज्ञानिक : माइक्रोस्कोप :: खगोलविद : ?'), v_set_id, v_q_id, 24)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सैनिक : बन्दुक :: भान्से : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 25, E'सैनिक : बन्दुक :: भान्से : ?', E'चक्कु', E'कलम', E'जाल', E'करणी', E'A', E'जसरी सैनिकको हतियार बन्दुक हो, त्यसैगरी भान्सेको मुख्य औजार चक्कु हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सैनिक : बन्दुक :: भान्से : ?'), v_set_id, v_q_id, 25)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुम्हाले : चक्र :: माली : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 26, E'कुम्हाले : चक्र :: माली : ?', E'हलो', E'कुटो', E'बन्दुक', E'चिम्ता', E'B', E'जसरी कुम्हालेले भाँडा बनाउन चक्र प्रयोग गर्छ, त्यसैगरी मालीले बगैंचा गोड्न कुटो प्रयोग गर्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुम्हाले : चक्र :: माली : ?'), v_set_id, v_q_id, 26)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'डाक्टर : अस्पताल :: शिक्षक : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 27, E'डाक्टर : अस्पताल :: शिक्षक : ?', E'खेत', E'अदालत', E'विद्यालय', E'मञ्च', E'C', E'जसरी डाक्टरको कार्यस्थल अस्पताल हो, त्यसैगरी शिक्षकको कार्यस्थल विद्यालय हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:डाक्टर : अस्पताल :: शिक्षक : ?'), v_set_id, v_q_id, 27)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'किसान : खेत :: सिकर्मी : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 28, E'किसान : खेत :: सिकर्मी : ?', E'अस्पताल', E'विद्यालय', E'प्रयोगशाला', E'कारखाना', E'D', E'जसरी किसानले खेतमा काम गर्छ, त्यसैगरी सिकर्मीले कारखाना (वर्कसप) मा काम गर्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:किसान : खेत :: सिकर्मी : ?'), v_set_id, v_q_id, 28)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वकिल : अदालत :: वैज्ञानिक : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 29, E'वकिल : अदालत :: वैज्ञानिक : ?', E'प्रयोगशाला', E'मन्दिर', E'भान्सा', E'ग्यारेज', E'A', E'जसरी वकिलको कार्यस्थल अदालत हो, त्यसैगरी वैज्ञानिकको कार्यस्थल प्रयोगशाला हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वकिल : अदालत :: वैज्ञानिक : ?'), v_set_id, v_q_id, 29)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'भान्से : भान्सा :: अभिनेता : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 30, E'भान्से : भान्सा :: अभिनेता : ?', E'खेत', E'मञ्च', E'अदालत', E'कारखाना', E'B', E'जसरी भान्सेले भान्सामा काम गर्छ, त्यसैगरी अभिनेताले मञ्च (स्टेज) मा आफ्नो कला प्रस्तुत गर्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:भान्से : भान्सा :: अभिनेता : ?'), v_set_id, v_q_id, 30)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: शाब्दिक बौद्धिक परीक्षणः समरूपता/Analogies - खण्ड 3 (आधारभूत तह) (30 Q)
  v_set_id := extensions.uuid_generate_v5('91240d83-acef-40dd-9fa2-412f8b797e45'::uuid, E'शाब्दिक बौद्धिक परीक्षणः समरूपता/Analogies - खण्ड 3 (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'efc9184a-c265-4fd8-bb99-aad431aefc58'::uuid, '91240d83-acef-40dd-9fa2-412f8b797e45'::uuid, E'शाब्दिक बौद्धिक परीक्षणः समरूपता/Analogies - खण्ड 3 (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '91240d83-acef-40dd-9fa2-412f8b797e45'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सैनिक : ब्यारेक :: प्रहरी : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'सैनिक : ब्यारेक :: प्रहरी : ?', E'प्रहरी चौकी', E'मञ्च', E'प्रयोगशाला', E'खेत', E'A', E'जसरी सैनिक ब्यारेकमा बस्छन् वा काम गर्छन्, त्यसैगरी प्रहरीको कार्यस्थल प्रहरी चौकी हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सैनिक : ब्यारेक :: प्रहरी : ?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पुजारी : मन्दिर :: पादरी : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'पुजारी : मन्दिर :: पादरी : ?', E'मस्जिद', E'चर्च', E'गुम्बा', E'अदालत', E'B', E'जसरी पुजारीको कार्यस्थल मन्दिर हो, त्यसैगरी इसाई धर्मका पादरीको कार्यस्थल चर्च हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पुजारी : मन्दिर :: पादरी : ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वेटर : रेस्टुरेन्ट :: क्लर्क : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'वेटर : रेस्टुरेन्ट :: क्लर्क : ?', E'खेत', E'ग्यारेज', E'कार्यालय', E'मञ्च', E'C', E'जसरी वेटरले रेस्टुरेन्टमा काम गर्छ, त्यसैगरी क्लर्कले कार्यालयमा काम गर्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वेटर : रेस्टुरेन्ट :: क्लर्क : ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'मेकानिक : ग्यारेज :: खेलाडी : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'मेकानिक : ग्यारेज :: खेलाडी : ?', E'रेस्टुरेन्ट', E'कारखाना', E'अदालत', E'मैदान', E'D', E'जसरी मेकानिकले ग्यारेजमा मर्मतको काम गर्छ, त्यसैगरी खेलाडीले मैदानमा खेल्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:मेकानिक : ग्यारेज :: खेलाडी : ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कलाकार : स्टुडियो :: माझी : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'कलाकार : स्टुडियो :: माझी : ?', E'नदी', E'ग्यारेज', E'मैदान', E'भान्सा', E'A', E'जसरी कलाकारले स्टुडियोमा काम गर्छ, त्यसैगरी माझीले नदीमा डुङ्गा चलाउँछ वा माछा मार्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कलाकार : स्टुडियो :: माझी : ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पाइलट : ककपिट :: ड्राइभर : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'पाइलट : ककपिट :: ड्राइभर : ?', E'ग्यारेज', E'क्याबिन', E'सडक', E'मैदान', E'B', E'जसरी पाइलट जहाजको ककपिटमा बस्छ, त्यसैगरी ड्राइभर गाडीको क्याबिनमा बस्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पाइलट : ककपिट :: ड्राइभर : ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सुख : आनन्द :: दुःख : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'सुख : आनन्द :: दुःख : ?', E'हाँसो', E'खुशी', E'पीडा', E'रिस', E'C', E'जसरी सुख र आनन्द समानार्थी शब्द हुन्, त्यसैगरी दुःख र पीडा समानार्थी शब्द हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सुख : आनन्द :: दुःख : ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'घमण्ड : अहंकार :: विनम्रता : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'घमण्ड : अहंकार :: विनम्रता : ?', E'कठोरता', E'रिस', E'दया', E'नम्रता', E'D', E'जसरी घमण्ड र अहंकार उस्तै अर्थ दिने शब्द हुन्, त्यसैगरी विनम्रता र नम्रता पनि उस्तै हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:घमण्ड : अहंकार :: विनम्रता : ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सुन्दर : आकर्षक :: कुरूप : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'सुन्दर : आकर्षक :: कुरूप : ?', E'बदसूरत', E'राम्रो', E'असल', E'ज्ञानी', E'A', E'जसरी सुन्दर र आकर्षक समानार्थी हुन्, त्यसैगरी कुरूप र बदसूरत (नराम्रो) समानार्थी हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सुन्दर : आकर्षक :: कुरूप : ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'साहसी : वीर :: काँतर : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'साहसी : वीर :: काँतर : ?', E'बलियो', E'डरपोक', E'कमजोर', E'मूर्ख', E'B', E'जसरी साहसीलाई वीर पनि भनिन्छ, त्यसैगरी काँतरलाई डरपोक भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:साहसी : वीर :: काँतर : ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'चतुर : बाठो :: मूर्ख : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'चतुर : बाठो :: मूर्ख : ?', E'ज्ञानी', E'चलाख', E'बुद्धु', E'इमान्दार', E'C', E'जसरी चतुर र बाठो समानार्थी हुन्, त्यसैगरी मूर्ख र बुद्धु समानार्थी हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:चतुर : बाठो :: मूर्ख : ?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'आकाश : गगन :: धर्ती : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'आकाश : गगन :: धर्ती : ?', E'पाताल', E'सूर्य', E'तारा', E'पृथ्वी', E'D', E'जसरी आकाशको पर्यायवाची शब्द गगन हो, त्यसैगरी धर्तीको पर्यायवाची शब्द पृथ्वी हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:आकाश : गगन :: धर्ती : ?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पानी : जल :: आगो : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'पानी : जल :: आगो : ?', E'अग्नि', E'हावा', E'माटो', E'आकाश', E'A', E'जसरी पानीको अर्को नाम जल हो, त्यसैगरी आगोको अर्को नाम अग्नि हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पानी : जल :: आगो : ?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'घर : गृह :: जंगल : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'घर : गृह :: जंगल : ?', E'सहर', E'वन', E'गाउँ', E'बाटो', E'B', E'जसरी घरलाई गृह भनिन्छ, त्यसैगरी जंगललाई वन भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:घर : गृह :: जंगल : ?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'बाटो : मार्ग :: आँखा : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'बाटो : मार्ग :: आँखा : ?', E'कान', E'नाक', E'नेत्र', E'हात', E'C', E'जसरी बाटोको समानार्थी मार्ग हो, त्यसैगरी आँखाको समानार्थी नेत्र हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:बाटो : मार्ग :: आँखा : ?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'राति : निशा :: दिन : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'राति : निशा :: दिन : ?', E'बिहान', E'बेलुका', E'उज्यालो', E'दिवस', E'D', E'जसरी रातिको पर्यायवाची निशा हो, त्यसैगरी दिनको पर्यायवाची दिवस हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:राति : निशा :: दिन : ?'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिन : रात :: उज्यालो : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'दिन : रात :: उज्यालो : ?', E'अँध्यारो', E'प्रकाश', E'सूर्य', E'चन्द्रमा', E'A', E'जसरी दिनको विपरितार्थी शब्द रात हो, त्यसैगरी उज्यालोको विपरितार्थी शब्द अँध्यारो हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिन : रात :: उज्यालो : ?'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सुख : दुःख :: लाभ : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'सुख : दुःख :: लाभ : ?', E'फाइदा', E'हानी', E'नाफा', E'खर्च', E'B', E'जसरी सुखको उल्टो दुःख हुन्छ, त्यसैगरी लाभको उल्टो हानी हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सुख : दुःख :: लाभ : ?'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'जन्म : मृत्यु :: सुरुवात : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'जन्म : मृत्यु :: सुरुवात : ?', E'बीच', E'अन्तिम', E'अन्त्य', E'सुरु', E'C', E'जसरी जन्मको विपरितार्थी शब्द मृत्यु हो, त्यसैगरी सुरुवातको विपरितार्थी शब्द अन्त्य हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:जन्म : मृत्यु :: सुरुवात : ?'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'स्वर्ग : नरक :: धर्म : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 20, E'स्वर्ग : नरक :: धर्म : ?', E'पाप', E'पुण्य', E'ज्ञान', E'अधर्म', E'D', E'जसरी स्वर्गको उल्टो नरक हुन्छ, त्यसैगरी धर्मको उल्टो अधर्म हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:स्वर्ग : नरक :: धर्म : ?'), v_set_id, v_q_id, 20)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'न्याय : अन्याय :: सत्य : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 21, E'न्याय : अन्याय :: सत्य : ?', E'असत्य', E'झुट', E'साँचो', E'इमान्दार', E'A', E'जसरी न्यायको विपरितार्थी अन्याय हो, त्यसैगरी सत्यको विपरितार्थी असत्य हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:न्याय : अन्याय :: सत्य : ?'), v_set_id, v_q_id, 21)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सफलता : असफलता :: जीत : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 22, E'सफलता : असफलता :: जीत : ?', E'विजय', E'हार', E'सफल', E'प्रयास', E'B', E'जसरी सफलताको उल्टो असफलता हो, त्यसैगरी जीतको उल्टो हार हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सफलता : असफलता :: जीत : ?'), v_set_id, v_q_id, 22)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'स्वतन्त्र : परतन्त्र :: धनी : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 23, E'स्वतन्त्र : परतन्त्र :: धनी : ?', E'पैसा', E'गरिबी', E'गरिब', E'धनीपन', E'C', E'जसरी स्वतन्त्रको उल्टो परतन्त्र हो, त्यसैगरी धनीको उल्टो गरिब हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:स्वतन्त्र : परतन्त्र :: धनी : ?'), v_set_id, v_q_id, 23)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'मित्र : शत्रु :: प्रेम : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 24, E'मित्र : शत्रु :: प्रेम : ?', E'माया', E'रिस', E'दया', E'घृणा', E'D', E'जसरी मित्रको विपरितार्थी शत्रु हो, त्यसैगरी प्रेमको विपरितार्थी घृणा हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:मित्र : शत्रु :: प्रेम : ?'), v_set_id, v_q_id, 24)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'ज्ञान : अज्ञान :: प्रकाश : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 25, E'ज्ञान : अज्ञान :: प्रकाश : ?', E'अन्धकार', E'उज्यालो', E'अँध्यारो', E'किरण', E'A', E'जसरी ज्ञानको विपरितार्थी अज्ञान हो, त्यसैगरी प्रकाशको विपरितार्थी अन्धकार हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:ज्ञान : अज्ञान :: प्रकाश : ?'), v_set_id, v_q_id, 25)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'साहसी : काँतर :: बलियो : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 26, E'साहसी : काँतर :: बलियो : ?', E'शक्ति', E'कमजोर', E'डरपोक', E'वीर', E'B', E'जसरी साहसीको उल्टो काँतर हो, त्यसैगरी बलियोको उल्टो कमजोर हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:साहसी : काँतर :: बलियो : ?'), v_set_id, v_q_id, 26)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'थर्मोमिटर : तापक्रम :: ब्यारोमिटर : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 27, E'थर्मोमिटर : तापक्रम :: ब्यारोमिटर : ?', E'आर्द्रता', E'गति', E'वायुमण्डलीय चाप', E'दुरी', E'C', E'जसरी थर्मोमिटरले तापक्रम नाप्छ, त्यसैगरी ब्यारोमिटरले वायुमण्डलीय चाप नाप्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:थर्मोमिटर : तापक्रम :: ब्यारोमिटर : ?'), v_set_id, v_q_id, 27)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सिस्मोग्राफ : भूकम्प :: एनिमोमिटर : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 28, E'सिस्मोग्राफ : भूकम्प :: एनिमोमिटर : ?', E'तापक्रम', E'रक्तचाप', E'प्रकाश', E'हावाको गति', E'D', E'जसरी सिस्मोग्राफले भूकम्पको तीव्रता नाप्छ, त्यसैगरी एनिमोमिटरले हावाको गति नाप्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सिस्मोग्राफ : भूकम्प :: एनिमोमिटर : ?'), v_set_id, v_q_id, 28)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'हाइग्रोमिटर : आर्द्रता :: ल्याक्टोमिटर : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 29, E'हाइग्रोमिटर : आर्द्रता :: ल्याक्टोमिटर : ?', E'दुधको शुद्धता', E'पानीको गहिराइ', E'भूकम्प', E'तापक्रम', E'A', E'जसरी हाइग्रोमिटरले आर्द्रता नाप्छ, त्यसैगरी ल्याक्टोमिटरले दुधको शुद्धता नाप्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:हाइग्रोमिटर : आर्द्रता :: ल्याक्टोमिटर : ?'), v_set_id, v_q_id, 29)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'एमिटर : विद्युत प्रवाह :: भोल्टमिटर : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 30, E'एमिटर : विद्युत प्रवाह :: भोल्टमिटर : ?', E'प्रतिरोध', E'भोल्टेज', E'चाप', E'गति', E'B', E'जसरी एमिटरले विद्युत प्रवाह (Current) नाप्छ, त्यसैगरी भोल्टमिटरले भोल्टेज नाप्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:एमिटर : विद्युत प्रवाह :: भोल्टमिटर : ?'), v_set_id, v_q_id, 30)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: शाब्दिक बौद्धिक परीक्षणः समरूपता/Analogies - खण्ड 4 (आधारभूत तह) (15 Q)
  v_set_id := extensions.uuid_generate_v5('91240d83-acef-40dd-9fa2-412f8b797e45'::uuid, E'शाब्दिक बौद्धिक परीक्षणः समरूपता/Analogies - खण्ड 4 (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'efc9184a-c265-4fd8-bb99-aad431aefc58'::uuid, '91240d83-acef-40dd-9fa2-412f8b797e45'::uuid, E'शाब्दिक बौद्धिक परीक्षणः समरूपता/Analogies - खण्ड 4 (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '91240d83-acef-40dd-9fa2-412f8b797e45'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'अडोमिटर : दुरी :: स्पिडोमिटर : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'अडोमिटर : दुरी :: स्पिडोमिटर : ?', E'गति', E'समय', E'तापक्रम', E'प्रकाश', E'A', E'जसरी गाडीमा अडोमिटरले पार गरेको दुरी देखाउँछ, त्यसैगरी स्पिडोमिटरले गाडीको गति देखाउँछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:अडोमिटर : दुरी :: स्पिडोमिटर : ?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'ब्यालेन्स : तौल :: स्केल : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'ब्यालेन्स : तौल :: स्केल : ?', E'चौडाइ', E'लम्बाइ', E'उचाइ', E'क्षेत्रफल', E'B', E'जसरी ब्यालेन्स (तराजु) ले तौल नाप्छ, त्यसैगरी स्केलले लम्बाइ नाप्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:ब्यालेन्स : तौल :: स्केल : ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'घडी : समय :: क्यालेन्डर : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'घडी : समय :: क्यालेन्डर : ?', E'वर्ष', E'महिना', E'मिति', E'दिन', E'C', E'जसरी घडीले समय देखाउँछ, त्यसैगरी क्यालेन्डरले मिति (तारीख) देखाउँछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:घडी : समय :: क्यालेन्डर : ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'ग्याल्भानोमिटर : विद्युत धारा :: स्फिग्मोम्यानोमिटर : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'ग्याल्भानोमिटर : विद्युत धारा :: स्फिग्मोम्यानोमिटर : ?', E'मुटुको धड्कन', E'हावाको गति', E'तापक्रम', E'रक्तचाप', E'D', E'जसरी ग्याल्भानोमिटरले विद्युत धारा पत्ता लगाउँछ, त्यसैगरी स्फिग्मोम्यानोमिटरले रक्तचाप (Blood pressure) नाप्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:ग्याल्भानोमिटर : विद्युत धारा :: स्फिग्मोम्यानोमिटर : ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कम्पास : दिशा :: स्टेथोस्कोप : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'कम्पास : दिशा :: स्टेथोस्कोप : ?', E'मुटुको धड्कन', E'रक्तचाप', E'श्वासप्रश्वास', E'दृष्टि', E'A', E'जसरी कम्पासले दिशा देखाउँछ, त्यसैगरी स्टेथोस्कोपले मुटुको धड्कन सुन्न मद्दत गर्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कम्पास : दिशा :: स्टेथोस्कोप : ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'अडियोमिटर : आवाज :: फोटोमिटर : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'अडियोमिटर : आवाज :: फोटोमिटर : ?', E'रंग', E'प्रकाशको तीव्रता', E'ताप', E'चाप', E'B', E'जसरी अडियोमिटरले आवाजको मापन गर्छ, त्यसैगरी फोटोमिटरले प्रकाशको तीव्रता नाप्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:अडियोमिटर : आवाज :: फोटोमिटर : ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कपडा : धागो :: कागज : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'कपडा : धागो :: कागज : ?', E'फलाम', E'सिसा', E'काठ', E'माटो', E'C', E'जसरी कपडा धागोबाट बन्छ, त्यसैगरी कागज काठ (वा बाँस) बाट बन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कपडा : धागो :: कागज : ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'जुत्ता : छाला :: फर्निचर : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'जुत्ता : छाला :: फर्निचर : ?', E'फलाम', E'सिसा', E'माटो', E'काठ', E'D', E'जसरी जुत्ता छालाबाट बन्छ, त्यसैगरी फर्निचर काठबाट बन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:जुत्ता : छाला :: फर्निचर : ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'रोटी : पीठो :: वाइन : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'रोटी : पीठो :: वाइन : ?', E'अंगुर', E'स्याउ', E'सुन्तला', E'केरा', E'A', E'जसरी रोटी पीठोबाट बन्छ, त्यसैगरी वाइन (मदिरा) अंगुरबाट बन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:रोटी : पीठो :: वाइन : ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तेल : तोरी :: चिनी : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'तेल : तोरी :: चिनी : ?', E'गहुँ', E'उखु', E'धान', E'मकै', E'B', E'जसरी तेल तोरीबाट निकालिन्छ, त्यसैगरी चिनी उखुबाट निकालिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तेल : तोरी :: चिनी : ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'धातु : धाउ :: सिसा : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'धातु : धाउ :: सिसा : ?', E'माटो', E'ढुंगा', E'बालुवा', E'काठ', E'C', E'जसरी धातु धाउ (Ore) बाट निकालिन्छ, त्यसैगरी सिसा बालुवा (सिलिका) बाट बन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:धातु : धाउ :: सिसा : ?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'स्वेटर : ऊन :: डोरी : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'स्वेटर : ऊन :: डोरी : ?', E'कपास', E'सिल्क', E'नाइलन', E'सनपाट', E'D', E'जसरी स्वेटर ऊनबाट बुनिन्छ, त्यसैगरी डोरी सनपाट (Jute) बाट बाटिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:स्वेटर : ऊन :: डोरी : ?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'किताब : कागज :: पर्खाल : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'किताब : कागज :: पर्खाल : ?', E'इँटा', E'सिमेन्ट', E'बालुवा', E'फलाम', E'A', E'जसरी किताब कागजबाट बन्छ, त्यसैगरी पर्खाल इँटाबाट बन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:किताब : कागज :: पर्खाल : ?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'चक्कु : स्टिल :: टायर : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'चक्कु : स्टिल :: टायर : ?', E'प्लास्टिक', E'रबर', E'सिसा', E'काठ', E'B', E'जसरी चक्कु स्टिलबाट बन्छ, त्यसैगरी टायर रबरबाट बन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:चक्कु : स्टिल :: टायर : ?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दही : दुध :: पनीर : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'दही : दुध :: पनीर : ?', E'पानी', E'मोही', E'दुध', E'घिउ', E'C', E'जसरी दही दुधबाट बन्छ, त्यसैगरी पनीर पनि दुधबाटै बन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दही : दुध :: पनीर : ?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: शाब्दिक बौद्धिक परीक्षणः विपरीतार्थक र समानार्थी शब्द - खण्ड 2 (आधारभूत तह) (30 Q)
  v_set_id := extensions.uuid_generate_v5('075f71e5-93ca-40d5-8bbb-f671e74eab47'::uuid, E'शाब्दिक बौद्धिक परीक्षणः विपरीतार्थक र समानार्थी शब्द - खण्ड 2 (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'efc9184a-c265-4fd8-bb99-aad431aefc58'::uuid, '075f71e5-93ca-40d5-8bbb-f671e74eab47'::uuid, E'शाब्दिक बौद्धिक परीक्षणः विपरीतार्थक र समानार्थी शब्द - खण्ड 2 (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '075f71e5-93ca-40d5-8bbb-f671e74eab47'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''नदी'' शब्दको समानार्थी शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'तलका मध्ये ''नदी'' शब्दको समानार्थी शब्द कुन हो?', E'सरिता', E'पोखरी', E'ताल', E'कुवा', E'A', E'''नदी'' लाई ''सरिता'' पनि भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''नदी'' शब्दको समानार्थी शब्द कुन हो?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''समुद्र'' शब्दको समानार्थी शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'तलका मध्ये ''समुद्र'' शब्दको समानार्थी शब्द कुन हो?', E'नदी', E'सागर', E'कुवा', E'झरना', E'B', E'''समुद्र'' र ''सागर'' समानार्थी हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''समुद्र'' शब्दको समानार्थी शब्द कुन हो?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''बाटो'' शब्दको समानार्थी शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'तलका मध्ये ''बाटो'' शब्दको समानार्थी शब्द कुन हो?', E'घर', E'पुल', E'मार्ग', E'चौतारो', E'C', E'''बाटो'' लाई ''मार्ग'' पनि भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''बाटो'' शब्दको समानार्थी शब्द कुन हो?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''जङ्गल'' शब्दको समानार्थी शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'तलका मध्ये ''जङ्गल'' शब्दको समानार्थी शब्द कुन हो?', E'गाउँ', E'सहर', E'घर', E'वन', E'D', E'''जङ्गल'' र ''वन'' एउटै अर्थ राख्ने शब्द हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''जङ्गल'' शब्दको समानार्थी शब्द कुन हो?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''रुख'' शब्दको समानार्थी शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'तलका मध्ये ''रुख'' शब्दको समानार्थी शब्द कुन हो?', E'वृक्ष', E'पात', E'फूल', E'फल', E'A', E'''रुख'' लाई ''वृक्ष'' पनि भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''रुख'' शब्दको समानार्थी शब्द कुन हो?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''गाउँ'' शब्दको समानार्थी शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'तलका मध्ये ''गाउँ'' शब्दको समानार्थी शब्द कुन हो?', E'सहर', E'ग्राम', E'नगर', E'प्रान्त', E'B', E'''गाउँ'' र ''ग्राम'' को अर्थ समान हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''गाउँ'' शब्दको समानार्थी शब्द कुन हो?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''घर'' शब्दको समानार्थी शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'तलका मध्ये ''घर'' शब्दको समानार्थी शब्द कुन हो?', E'वन', E'खेत', E'गृह', E'बाटो', E'C', E'''घर'' लाई ''गृह'' पनि भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''घर'' शब्दको समानार्थी शब्द कुन हो?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''आमा'' शब्दको समानार्थी शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'तलका मध्ये ''आमा'' शब्दको समानार्थी शब्द कुन हो?', E'पिता', E'दिदी', E'बहिनी', E'माता', E'D', E'''आमा'' र ''माता'' समानार्थी हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''आमा'' शब्दको समानार्थी शब्द कुन हो?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''बुबा'' शब्दको समानार्थी शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'तलका मध्ये ''बुबा'' शब्दको समानार्थी शब्द कुन हो?', E'पिता', E'माता', E'दाइ', E'भाइ', E'A', E'''बुबा'' लाई ''पिता'' पनि भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''बुबा'' शब्दको समानार्थी शब्द कुन हो?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''आँखा'' शब्दको समानार्थी शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'तलका मध्ये ''आँखा'' शब्दको समानार्थी शब्द कुन हो?', E'कान', E'नयन', E'नाक', E'मुख', E'B', E'''आँखा'' को समानार्थी शब्द ''नयन'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''आँखा'' शब्दको समानार्थी शब्द कुन हो?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''हात'' शब्दको समानार्थी शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'तलका मध्ये ''हात'' शब्दको समानार्थी शब्द कुन हो?', E'पाउ', E'शिर', E'कर', E'पेट', E'C', E'''हात'' लाई ''कर'' पनि भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''हात'' शब्दको समानार्थी शब्द कुन हो?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''खुट्टा'' शब्दको समानार्थी शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'तलका मध्ये ''खुट्टा'' शब्दको समानार्थी शब्द कुन हो?', E'हात', E'पेट', E'टाउको', E'पाउ', E'D', E'''खुट्टा'' र ''पाउ'' एउटै अर्थ हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''खुट्टा'' शब्दको समानार्थी शब्द कुन हो?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''कपाल'' शब्दको समानार्थी शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'तलका मध्ये ''कपाल'' शब्दको समानार्थी शब्द कुन हो?', E'केश', E'नङ', E'छाला', E'दाँत', E'A', E'''कपाल'' को समानार्थी शब्द ''केश'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''कपाल'' शब्दको समानार्थी शब्द कुन हो?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''कपडा'' शब्दको समानार्थी शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'तलका मध्ये ''कपडा'' शब्दको समानार्थी शब्द कुन हो?', E'जुत्ता', E'वस्त्र', E'टोपी', E'झोला', E'B', E'''कपडा'' र ''वस्त्र'' समानार्थी शब्द हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''कपडा'' शब्दको समानार्थी शब्द कुन हो?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''सुन'' शब्दको समानार्थी शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'तलका मध्ये ''सुन'' शब्दको समानार्थी शब्द कुन हो?', E'चाँदी', E'फलाम', E'स्वर्ण', E'तामा', E'C', E'''सुन'' लाई ''स्वर्ण'' पनि भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''सुन'' शब्दको समानार्थी शब्द कुन हो?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''चाँदी'' शब्दको समानार्थी शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'तलका मध्ये ''चाँदी'' शब्दको समानार्थी शब्द कुन हो?', E'स्वर्ण', E'फलाम', E'सिसा', E'रजत', E'D', E'''चाँदी'' को समानार्थी शब्द ''रजत'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''चाँदी'' शब्दको समानार्थी शब्द कुन हो?'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''ढुङ्गा'' शब्दको समानार्थी शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'तलका मध्ये ''ढुङ्गा'' शब्दको समानार्थी शब्द कुन हो?', E'पत्थर', E'माटो', E'बालुवा', E'काठ', E'A', E'''ढुङ्गा'' र ''पत्थर'' समान अर्थ राख्ने शब्द हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''ढुङ्गा'' शब्दको समानार्थी शब्द कुन हो?'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''माटो'' शब्दको समानार्थी शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'तलका मध्ये ''माटो'' शब्दको समानार्थी शब्द कुन हो?', E'बालुवा', E'मृत्तिका', E'ढुङ्गा', E'पानी', E'B', E'''माटो'' लाई ''मृत्तिका'' पनि भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''माटो'' शब्दको समानार्थी शब्द कुन हो?'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''बादल'' शब्दको समानार्थी शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'तलका मध्ये ''बादल'' शब्दको समानार्थी शब्द कुन हो?', E'आकाश', E'तारा', E'मेघ', E'घाम', E'C', E'''बादल'' र ''मेघ'' एउटै अर्थ हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''बादल'' शब्दको समानार्थी शब्द कुन हो?'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''भगवान'' शब्दको समानार्थी शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 20, E'तलका मध्ये ''भगवान'' शब्दको समानार्थी शब्द कुन हो?', E'मानिस', E'राक्षस', E'दानव', E'ईश्वर', E'D', E'''भगवान'' लाई ''ईश्वर'' पनि भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''भगवान'' शब्दको समानार्थी शब्द कुन हो?'), v_set_id, v_q_id, 20)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''देवता'' शब्दको समानार्थी शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 21, E'तलका मध्ये ''देवता'' शब्दको समानार्थी शब्द कुन हो?', E'सुर', E'असुर', E'दानव', E'मानव', E'A', E'''देवता'' को समानार्थी शब्द ''सुर'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''देवता'' शब्दको समानार्थी शब्द कुन हो?'), v_set_id, v_q_id, 21)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''राक्षस'' शब्दको समानार्थी शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 22, E'तलका मध्ये ''राक्षस'' शब्दको समानार्थी शब्द कुन हो?', E'देवता', E'दानव', E'मानव', E'सुर', E'B', E'''राक्षस'' र ''दानव'' समानार्थी हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''राक्षस'' शब्दको समानार्थी शब्द कुन हो?'), v_set_id, v_q_id, 22)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''मानिस'' शब्दको समानार्थी शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 23, E'तलका मध्ये ''मानिस'' शब्दको समानार्थी शब्द कुन हो?', E'दानव', E'पशु', E'मानव', E'पन्छी', E'C', E'''मानिस'' लाई ''मानव'' पनि भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''मानिस'' शब्दको समानार्थी शब्द कुन हो?'), v_set_id, v_q_id, 23)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''राजा'' शब्दको समानार्थी शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 24, E'तलका मध्ये ''राजा'' शब्दको समानार्थी शब्द कुन हो?', E'रङ्क', E'मन्त्री', E'सेना', E'नरेश', E'D', E'''राजा'' को समानार्थी शब्द ''नरेश'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''राजा'' शब्दको समानार्थी शब्द कुन हो?'), v_set_id, v_q_id, 24)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''विद्वान'' शब्दको समानार्थी शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 25, E'तलका मध्ये ''विद्वान'' शब्दको समानार्थी शब्द कुन हो?', E'ज्ञानी', E'मूर्ख', E'अज्ञानी', E'पागल', E'A', E'''विद्वान'' र ''ज्ञानी'' समान अर्थ राख्ने शब्द हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''विद्वान'' शब्दको समानार्थी शब्द कुन हो?'), v_set_id, v_q_id, 25)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''मूर्ख'' शब्दको समानार्थी शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 26, E'तलका मध्ये ''मूर्ख'' शब्दको समानार्थी शब्द कुन हो?', E'ज्ञानी', E'अज्ञानी', E'विद्वान', E'चतुर', E'B', E'''मूर्ख'' लाई ''अज्ञानी'' पनि भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''मूर्ख'' शब्दको समानार्थी शब्द कुन हो?'), v_set_id, v_q_id, 26)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''सुन्दर'' शब्दको समानार्थी शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 27, E'तलका मध्ये ''सुन्दर'' शब्दको समानार्थी शब्द कुन हो?', E'कुरुप', E'भद्दा', E'मनोहर', E'नराम्रो', E'C', E'''सुन्दर'' र ''मनोहर'' एउटै अर्थ हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''सुन्दर'' शब्दको समानार्थी शब्द कुन हो?'), v_set_id, v_q_id, 27)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''हर्ष'' शब्दको समानार्थी शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 28, E'तलका मध्ये ''हर्ष'' शब्दको समानार्थी शब्द कुन हो?', E'दुःख', E'शोक', E'रुवाइ', E'खुसी', E'D', E'''हर्ष'' को समानार्थी शब्द ''खुसी'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''हर्ष'' शब्दको समानार्थी शब्द कुन हो?'), v_set_id, v_q_id, 28)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''दुःख'' शब्दको समानार्थी शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 29, E'तलका मध्ये ''दुःख'' शब्दको समानार्थी शब्द कुन हो?', E'पीडा', E'सुख', E'हर्ष', E'आनन्द', E'A', E'''दुःख'' लाई ''पीडा'' पनि भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''दुःख'' शब्दको समानार्थी शब्द कुन हो?'), v_set_id, v_q_id, 29)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''प्रेम'' शब्दको समानार्थी शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 30, E'तलका मध्ये ''प्रेम'' शब्दको समानार्थी शब्द कुन हो?', E'घृणा', E'माया', E'रिस', E'तिरस्कार', E'B', E'''प्रेम'' र ''माया'' समानार्थी हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''प्रेम'' शब्दको समानार्थी शब्द कुन हो?'), v_set_id, v_q_id, 30)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: शाब्दिक बौद्धिक परीक्षणः विपरीतार्थक र समानार्थी शब्द - खण्ड 3 (आधारभूत तह) (30 Q)
  v_set_id := extensions.uuid_generate_v5('075f71e5-93ca-40d5-8bbb-f671e74eab47'::uuid, E'शाब्दिक बौद्धिक परीक्षणः विपरीतार्थक र समानार्थी शब्द - खण्ड 3 (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'efc9184a-c265-4fd8-bb99-aad431aefc58'::uuid, '075f71e5-93ca-40d5-8bbb-f671e74eab47'::uuid, E'शाब्दिक बौद्धिक परीक्षणः विपरीतार्थक र समानार्थी शब्द - खण्ड 3 (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '075f71e5-93ca-40d5-8bbb-f671e74eab47'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''डर'' शब्दको समानार्थी शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'तलका मध्ये ''डर'' शब्दको समानार्थी शब्द कुन हो?', E'भय', E'साहस', E'निडर', E'वीरता', E'A', E'''डर'' को समानार्थी शब्द ''भय'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''डर'' शब्दको समानार्थी शब्द कुन हो?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''शत्रु'' शब्दको समानार्थी शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'तलका मध्ये ''शत्रु'' शब्दको समानार्थी शब्द कुन हो?', E'मित्र', E'दुश्मन', E'साथी', E'गुरु', E'B', E'''शत्रु'' र ''दुश्मन'' समान अर्थ राख्ने शब्द हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''शत्रु'' शब्दको समानार्थी शब्द कुन हो?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''मित्र'' शब्दको समानार्थी शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'तलका मध्ये ''मित्र'' शब्दको समानार्थी शब्द कुन हो?', E'शत्रु', E'दुश्मन', E'साथी', E'अपरिचित', E'C', E'''मित्र'' लाई ''साथी'' पनि भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''मित्र'' शब्दको समानार्थी शब्द कुन हो?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''सम्मान'' शब्दको समानार्थी शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'तलका मध्ये ''सम्मान'' शब्दको समानार्थी शब्द कुन हो?', E'अपमान', E'तिरस्कार', E'बेइज्जत', E'आदर', E'D', E'''सम्मान'' र ''आदर'' एउटै अर्थ हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''सम्मान'' शब्दको समानार्थी शब्द कुन हो?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''अपमान'' शब्दको समानार्थी शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'तलका मध्ये ''अपमान'' शब्दको समानार्थी शब्द कुन हो?', E'तिरस्कार', E'सम्मान', E'आदर', E'पुरस्कार', E'A', E'''अपमान'' को समानार्थी शब्द ''तिरस्कार'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''अपमान'' शब्दको समानार्थी शब्द कुन हो?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''उन्नति'' शब्दको समानार्थी शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'तलका मध्ये ''उन्नति'' शब्दको समानार्थी शब्द कुन हो?', E'अवनति', E'प्रगति', E'पतन', E'विनाश', E'B', E'''उन्नति'' र ''प्रगति'' समानार्थी हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''उन्नति'' शब्दको समानार्थी शब्द कुन हो?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''स्वतन्त्रता'' शब्दको समानार्थी शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'तलका मध्ये ''स्वतन्त्रता'' शब्दको समानार्थी शब्द कुन हो?', E'परतन्त्रता', E'दासत्व', E'स्वाधीनता', E'बन्धन', E'C', E'''स्वतन्त्रता'' लाई ''स्वाधीनता'' पनि भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''स्वतन्त्रता'' शब्दको समानार्थी शब्द कुन हो?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''निर्माण'' शब्दको समानार्थी शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'तलका मध्ये ''निर्माण'' शब्दको समानार्थी शब्द कुन हो?', E'विनाश', E'पतन', E'भत्काउनु', E'रचना', E'D', E'''निर्माण'' र ''रचना'' समान अर्थ राख्ने शब्द हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''निर्माण'' शब्दको समानार्थी शब्द कुन हो?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''खोज'' शब्दको समानार्थी शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'तलका मध्ये ''खोज'' शब्दको समानार्थी शब्द कुन हो?', E'अनुसन्धान', E'अज्ञान', E'हराउनु', E'बिर्सनु', E'A', E'''खोज'' को समानार्थी शब्द ''अनुसन्धान'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''खोज'' शब्दको समानार्थी शब्द कुन हो?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''उज्यालो'' शब्दको विपरीतार्थक शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'तलका मध्ये ''उज्यालो'' शब्दको विपरीतार्थक शब्द कुन हो?', E'प्रकाश', E'अँध्यारो', E'घाम', E'किरण', E'B', E'''उज्यालो'' को उल्टो अर्थ ''अँध्यारो'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''उज्यालो'' शब्दको विपरीतार्थक शब्द कुन हो?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''दिन'' शब्दको विपरीतार्थक शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'तलका मध्ये ''दिन'' शब्दको विपरीतार्थक शब्द कुन हो?', E'उज्यालो', E'बिहान', E'रात', E'साँझ', E'C', E'''दिन'' को उल्टो अर्थ ''रात'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''दिन'' शब्दको विपरीतार्थक शब्द कुन हो?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''आकाश'' शब्दको विपरीतार्थक शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'तलका मध्ये ''आकाश'' शब्दको विपरीतार्थक शब्द कुन हो?', E'गगन', E'बादल', E'तारा', E'पाताल', E'D', E'''आकाश'' को विपरीतार्थक शब्द ''पाताल'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''आकाश'' शब्दको विपरीतार्थक शब्द कुन हो?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''जीवन'' शब्दको विपरीतार्थक शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'तलका मध्ये ''जीवन'' शब्दको विपरीतार्थक शब्द कुन हो?', E'मरण', E'जिन्दगी', E'प्राण', E'सास', E'A', E'''जीवन'' को उल्टो अर्थ ''मरण'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''जीवन'' शब्दको विपरीतार्थक शब्द कुन हो?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''जन्म'' शब्दको विपरीतार्थक शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'तलका मध्ये ''जन्म'' शब्दको विपरीतार्थक शब्द कुन हो?', E'जीवन', E'मृत्यु', E'आयु', E'सुरुवात', E'B', E'''जन्म'' को उल्टो अर्थ ''मृत्यु'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''जन्म'' शब्दको विपरीतार्थक शब्द कुन हो?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''जय'' शब्दको विपरीतार्थक शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'तलका मध्ये ''जय'' शब्दको विपरीतार्थक शब्द कुन हो?', E'जित', E'विजय', E'पराजय', E'सफलता', E'C', E'''जय'' को उल्टो अर्थ ''पराजय'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''जय'' शब्दको विपरीतार्थक शब्द कुन हो?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''आदि'' शब्दको विपरीतार्थक शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'तलका मध्ये ''आदि'' शब्दको विपरीतार्थक शब्द कुन हो?', E'सुरुवात', E'मध्य', E'पहिलो', E'अन्त', E'D', E'''आदि'' (सुरु) को विपरीतार्थक शब्द ''अन्त'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''आदि'' शब्दको विपरीतार्थक शब्द कुन हो?'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''आशा'' शब्दको विपरीतार्थक शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'तलका मध्ये ''आशा'' शब्दको विपरीतार्थक शब्द कुन हो?', E'निराशा', E'भरोसा', E'विश्वास', E'इच्छा', E'A', E'''आशा'' को उल्टो अर्थ ''निराशा'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''आशा'' शब्दको विपरीतार्थक शब्द कुन हो?'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''इहलोक'' शब्दको विपरीतार्थक शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'तलका मध्ये ''इहलोक'' शब्दको विपरीतार्थक शब्द कुन हो?', E'पृथ्वी', E'परलोक', E'संसार', E'जगत्', E'B', E'''इहलोक'' (यो संसार) को उल्टो ''परलोक'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''इहलोक'' शब्दको विपरीतार्थक शब्द कुन हो?'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''देव'' शब्दको विपरीतार्थक शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'तलका मध्ये ''देव'' शब्दको विपरीतार्थक शब्द कुन हो?', E'भगवान', E'ईश्वर', E'दानव', E'सुर', E'C', E'''देव'' को विपरीतार्थक शब्द ''दानव'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''देव'' शब्दको विपरीतार्थक शब्द कुन हो?'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''धर्म'' शब्दको विपरीतार्थक शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 20, E'तलका मध्ये ''धर्म'' शब्दको विपरीतार्थक शब्द कुन हो?', E'सत्य', E'न्याय', E'पुण्य', E'अधर्म', E'D', E'''धर्म'' को उल्टो अर्थ ''अधर्म'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''धर्म'' शब्दको विपरीतार्थक शब्द कुन हो?'), v_set_id, v_q_id, 20)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''पाप'' शब्दको विपरीतार्थक शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 21, E'तलका मध्ये ''पाप'' शब्दको विपरीतार्थक शब्द कुन हो?', E'पुण्य', E'धर्म', E'न्याय', E'सत्य', E'A', E'''पाप'' को उल्टो अर्थ ''पुण्य'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''पाप'' शब्दको विपरीतार्थक शब्द कुन हो?'), v_set_id, v_q_id, 21)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''न्याय'' शब्दको विपरीतार्थक शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 22, E'तलका मध्ये ''न्याय'' शब्दको विपरीतार्थक शब्द कुन हो?', E'सत्य', E'अन्याय', E'धर्म', E'कानुन', E'B', E'''न्याय'' को विपरीतार्थक शब्द ''अन्याय'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''न्याय'' शब्दको विपरीतार्थक शब्द कुन हो?'), v_set_id, v_q_id, 22)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''सत्य'' शब्दको विपरीतार्थक शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 23, E'तलका मध्ये ''सत्य'' शब्दको विपरीतार्थक शब्द कुन हो?', E'साँचो', E'धर्म', E'असत्य', E'न्याय', E'C', E'''सत्य'' को उल्टो अर्थ ''असत्य'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''सत्य'' शब्दको विपरीतार्थक शब्द कुन हो?'), v_set_id, v_q_id, 23)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''ज्ञानी'' शब्दको विपरीतार्थक शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 24, E'तलका मध्ये ''ज्ञानी'' शब्दको विपरीतार्थक शब्द कुन हो?', E'विद्वान', E'पण्डित', E'चतुर', E'अज्ञानी', E'D', E'''ज्ञानी'' को उल्टो अर्थ ''अज्ञानी'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''ज्ञानी'' शब्दको विपरीतार्थक शब्द कुन हो?'), v_set_id, v_q_id, 24)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''असल'' शब्दको विपरीतार्थक शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 25, E'तलका मध्ये ''असल'' शब्दको विपरीतार्थक शब्द कुन हो?', E'खराब', E'राम्रो', E'सत्य', E'ज्ञानी', E'A', E'''असल'' को विपरीतार्थक शब्द ''खराब'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''असल'' शब्दको विपरीतार्थक शब्द कुन हो?'), v_set_id, v_q_id, 25)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''सज्जन'' शब्दको विपरीतार्थक शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 26, E'तलका मध्ये ''सज्जन'' शब्दको विपरीतार्थक शब्द कुन हो?', E'ज्ञानी', E'दुर्जन', E'असल', E'राम्रो', E'B', E'''सज्जन'' (राम्रो मान्छे) को उल्टो ''दुर्जन'' (खराब मान्छे) हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''सज्जन'' शब्दको विपरीतार्थक शब्द कुन हो?'), v_set_id, v_q_id, 26)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''स्वदेश'' शब्दको विपरीतार्थक शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 27, E'तलका मध्ये ''स्वदेश'' शब्दको विपरीतार्थक शब्द कुन हो?', E'गाउँ', E'सहर', E'विदेश', E'घर', E'C', E'''स्वदेश'' (आफ्नो देश) को उल्टो ''विदेश'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''स्वदेश'' शब्दको विपरीतार्थक शब्द कुन हो?'), v_set_id, v_q_id, 27)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''एकता'' शब्दको विपरीतार्थक शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 28, E'तलका मध्ये ''एकता'' शब्दको विपरीतार्थक शब्द कुन हो?', E'मेल', E'मित्रता', E'सङ्गठन', E'अनेकता', E'D', E'''एकता'' को विपरीतार्थक शब्द ''अनेकता'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''एकता'' शब्दको विपरीतार्थक शब्द कुन हो?'), v_set_id, v_q_id, 28)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''अनुकूल'' शब्दको विपरीतार्थक शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 29, E'तलका मध्ये ''अनुकूल'' शब्दको विपरीतार्थक शब्द कुन हो?', E'प्रतिकूल', E'सजिलो', E'राम्रो', E'असल', E'A', E'''अनुकूल'' को उल्टो अर्थ ''प्रतिकूल'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''अनुकूल'' शब्दको विपरीतार्थक शब्द कुन हो?'), v_set_id, v_q_id, 29)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''अनुराग'' शब्दको विपरीतार्थक शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 30, E'तलका मध्ये ''अनुराग'' शब्दको विपरीतार्थक शब्द कुन हो?', E'प्रेम', E'विराग', E'माया', E'स्नेह', E'B', E'''अनुराग'' (प्रेम) को उल्टो ''विराग'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''अनुराग'' शब्दको विपरीतार्थक शब्द कुन हो?'), v_set_id, v_q_id, 30)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: शाब्दिक बौद्धिक परीक्षणः विपरीतार्थक र समानार्थी शब्द - खण्ड 4 (आधारभूत तह) (27 Q)
  v_set_id := extensions.uuid_generate_v5('075f71e5-93ca-40d5-8bbb-f671e74eab47'::uuid, E'शाब्दिक बौद्धिक परीक्षणः विपरीतार्थक र समानार्थी शब्द - खण्ड 4 (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'efc9184a-c265-4fd8-bb99-aad431aefc58'::uuid, '075f71e5-93ca-40d5-8bbb-f671e74eab47'::uuid, E'शाब्दिक बौद्धिक परीक्षणः विपरीतार्थक र समानार्थी शब्द - खण्ड 4 (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '075f71e5-93ca-40d5-8bbb-f671e74eab47'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''आरोह'' शब्दको विपरीतार्थक शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'तलका मध्ये ''आरोह'' शब्दको विपरीतार्थक शब्द कुन हो?', E'अवरोह', E'उकालो', E'माथि', E'चढ्नु', E'A', E'''आरोह'' (चढ्ने काम) को उल्टो ''अवरोह'' (ओर्लने काम) हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''आरोह'' शब्दको विपरीतार्थक शब्द कुन हो?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''उत्कर्ष'' शब्दको विपरीतार्थक शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'तलका मध्ये ''उत्कर्ष'' शब्दको विपरीतार्थक शब्द कुन हो?', E'प्रगति', E'अपकर्ष', E'विकास', E'उन्नति', E'B', E'''उत्कर्ष'' (उन्नति) को उल्टो ''अपकर्ष'' (अवनति) हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''उत्कर्ष'' शब्दको विपरीतार्थक शब्द कुन हो?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''उन्नति'' शब्दको विपरीतार्थक शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'तलका मध्ये ''उन्नति'' शब्दको विपरीतार्थक शब्द कुन हो?', E'प्रगति', E'विकास', E'अवनति', E'सुधार', E'C', E'''उन्नति'' को विपरीतार्थक शब्द ''अवनति'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''उन्नति'' शब्दको विपरीतार्थक शब्द कुन हो?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''उर्वर'' शब्दको विपरीतार्थक शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'तलका मध्ये ''उर्वर'' शब्दको विपरीतार्थक शब्द कुन हो?', E'मलिलो', E'हरियो', E'राम्रो', E'ऊषर', E'D', E'''उर्वर'' (मलिलो) को उल्टो ''ऊषर'' (उब्जनी नहुने) हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''उर्वर'' शब्दको विपरीतार्थक शब्द कुन हो?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''कठोर'' शब्दको विपरीतार्थक शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'तलका मध्ये ''कठोर'' शब्दको विपरीतार्थक शब्द कुन हो?', E'कोमल', E'कडा', E'सारो', E'बलियो', E'A', E'''कठोर'' को उल्टो अर्थ ''कोमल'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''कठोर'' शब्दको विपरीतार्थक शब्द कुन हो?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''कृतज्ञ'' शब्दको विपरीतार्थक शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'तलका मध्ये ''कृतज्ञ'' शब्दको विपरीतार्थक शब्द कुन हो?', E'ज्ञानी', E'कृतघ्न', E'असल', E'सज्जन', E'B', E'''कृतज्ञ'' (गुण मान्ने) को उल्टो ''कृतघ्न'' (गुण नमान्ने) हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''कृतज्ञ'' शब्दको विपरीतार्थक शब्द कुन हो?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''कृत्रिम'' शब्दको विपरीतार्थक शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'तलका मध्ये ''कृत्रिम'' शब्दको विपरीतार्थक शब्द कुन हो?', E'बनावटी', E'नक्कली', E'प्राकृतिक', E'झुटो', E'C', E'''कृत्रिम'' (बनावटी) को उल्टो ''प्राकृतिक'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''कृत्रिम'' शब्दको विपरीतार्थक शब्द कुन हो?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''गुप्त'' शब्दको विपरीतार्थक शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'तलका मध्ये ''गुप्त'' शब्दको विपरीतार्थक शब्द कुन हो?', E'लुकेको', E'रहस्य', E'अँध्यारो', E'प्रकट', E'D', E'''गुप्त'' (लुकेको) को उल्टो ''प्रकट'' (देखिएको) हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''गुप्त'' शब्दको विपरीतार्थक शब्द कुन हो?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''चेतन'' शब्दको विपरीतार्थक शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'तलका मध्ये ''चेतन'' शब्दको विपरीतार्थक शब्द कुन हो?', E'जड', E'सजीव', E'प्राणी', E'मानिस', E'A', E'''चेतन'' (प्राण भएको) को उल्टो ''जड'' (निर्जीव) हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''चेतन'' शब्दको विपरीतार्थक शब्द कुन हो?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''जेठो'' शब्दको विपरीतार्थक शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'तलका मध्ये ''जेठो'' शब्दको विपरीतार्थक शब्द कुन हो?', E'ठूलो', E'कान्छो', E'माइलो', E'सानो', E'B', E'''जेठो'' को उल्टो अर्थ ''कान्छो'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''जेठो'' शब्दको विपरीतार्थक शब्द कुन हो?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''नवीन'' शब्दको विपरीतार्थक शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'तलका मध्ये ''नवीन'' शब्दको विपरीतार्थक शब्द कुन हो?', E'नयाँ', E'आधुनिक', E'प्राचीन', E'राम्रो', E'C', E'''नवीन'' (नयाँ) को उल्टो ''प्राचीन'' (पुरानो) हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''नवीन'' शब्दको विपरीतार्थक शब्द कुन हो?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''निन्दा'' शब्दको विपरीतार्थक शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'तलका मध्ये ''निन्दा'' शब्दको विपरीतार्थक शब्द कुन हो?', E'गाली', E'अपमान', E'विरोध', E'स्तुति', E'D', E'''निन्दा'' (विरोध/गाली) को उल्टो ''स्तुति'' (प्रशंसा) हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''निन्दा'' शब्दको विपरीतार्थक शब्द कुन हो?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''निर्माण'' शब्दको विपरीतार्थक शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'तलका मध्ये ''निर्माण'' शब्दको विपरीतार्थक शब्द कुन हो?', E'विनाश', E'रचना', E'विकास', E'सिर्जना', E'A', E'''निर्माण'' को विपरीतार्थक शब्द ''विनाश'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''निर्माण'' शब्दको विपरीतार्थक शब्द कुन हो?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''पुरस्कार'' शब्दको विपरीतार्थक शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'तलका मध्ये ''पुरस्कार'' शब्दको विपरीतार्थक शब्द कुन हो?', E'उपहार', E'दण्ड', E'सम्मान', E'मेडल', E'B', E'''पुरस्कार'' को उल्टो अर्थ ''दण्ड'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''पुरस्कार'' शब्दको विपरीतार्थक शब्द कुन हो?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''बन्धन'' शब्दको विपरीतार्थक शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'तलका मध्ये ''बन्धन'' शब्दको विपरीतार्थक शब्द कुन हो?', E'जेल', E'कैद', E'मुक्ति', E'डोरी', E'C', E'''बन्धन'' को विपरीतार्थक शब्द ''मुक्ति'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''बन्धन'' शब्दको विपरीतार्थक शब्द कुन हो?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''मिलन'' शब्दको विपरीतार्थक शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'तलका मध्ये ''मिलन'' शब्दको विपरीतार्थक शब्द कुन हो?', E'भेट', E'साथ', E'प्रेम', E'विछोड', E'D', E'''मिलन'' को उल्टो अर्थ ''विछोड'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''मिलन'' शब्दको विपरीतार्थक शब्द कुन हो?'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''लाभ'' शब्दको विपरीतार्थक शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'तलका मध्ये ''लाभ'' शब्दको विपरीतार्थक शब्द कुन हो?', E'हानि', E'नाफा', E'फाइदा', E'प्रगति', E'A', E'''लाभ'' को उल्टो अर्थ ''हानि'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''लाभ'' शब्दको विपरीतार्थक शब्द कुन हो?'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''सुख'' शब्दको विपरीतार्थक शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'तलका मध्ये ''सुख'' शब्दको विपरीतार्थक शब्द कुन हो?', E'आनन्द', E'दुःख', E'शान्ति', E'खुसी', E'B', E'''सुख'' को विपरीतार्थक शब्द ''दुःख'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''सुख'' शब्दको विपरीतार्थक शब्द कुन हो?'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''स्वार्थ'' शब्दको विपरीतार्थक शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'तलका मध्ये ''स्वार्थ'' शब्दको विपरीतार्थक शब्द कुन हो?', E'लोभ', E'लालच', E'परमार्थ', E'घमण्ड', E'C', E'''स्वार्थ'' (आफ्नो मात्र भलाइ चाहने) को उल्टो ''परमार्थ'' (अरूको भलाइ चाहने) हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''स्वार्थ'' शब्दको विपरीतार्थक शब्द कुन हो?'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''आय'' शब्दको विपरीतार्थक शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 20, E'तलका मध्ये ''आय'' शब्दको विपरीतार्थक शब्द कुन हो?', E'आम्दानी', E'कमाइ', E'पैसा', E'व्यय', E'D', E'''आय'' (आम्दानी) को उल्टो ''व्यय'' (खर्च) हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''आय'' शब्दको विपरीतार्थक शब्द कुन हो?'), v_set_id, v_q_id, 20)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''आदान'' शब्दको विपरीतार्थक शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 21, E'तलका मध्ये ''आदान'' शब्दको विपरीतार्थक शब्द कुन हो?', E'प्रदान', E'लिनु', E'दिनु', E'पाउनु', E'A', E'''आदान'' (लिनु) को विपरीतार्थक शब्द ''प्रदान'' (दिनु) हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''आदान'' शब्दको विपरीतार्थक शब्द कुन हो?'), v_set_id, v_q_id, 21)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''उदय'' शब्दको विपरीतार्थक शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 22, E'तलका मध्ये ''उदय'' शब्दको विपरीतार्थक शब्द कुन हो?', E'सुरुवात', E'अस्त', E'जन्म', E'बिहान', E'B', E'''उदय'' को उल्टो अर्थ ''अस्त'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''उदय'' शब्दको विपरीतार्थक शब्द कुन हो?'), v_set_id, v_q_id, 22)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''आकर्षण'' शब्दको विपरीतार्थक शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 23, E'तलका मध्ये ''आकर्षण'' शब्दको विपरीतार्थक शब्द कुन हो?', E'प्रेम', E'सुन्दरता', E'विकर्षण', E'मोह', E'C', E'''आकर्षण'' को विपरीतार्थक शब्द ''विकर्षण'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''आकर्षण'' शब्दको विपरीतार्थक शब्द कुन हो?'), v_set_id, v_q_id, 23)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''इच्छा'' शब्दको विपरीतार्थक शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 24, E'तलका मध्ये ''इच्छा'' शब्दको विपरीतार्थक शब्द कुन हो?', E'चाहना', E'रहर', E'आशा', E'अनिच्छा', E'D', E'''इच्छा'' को उल्टो अर्थ ''अनिच्छा'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''इच्छा'' शब्दको विपरीतार्थक शब्द कुन हो?'), v_set_id, v_q_id, 24)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''उपस्थित'' शब्दको विपरीतार्थक शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 25, E'तलका मध्ये ''उपस्थित'' शब्दको विपरीतार्थक शब्द कुन हो?', E'अनुपस्थित', E'हाजिर', E'बिदा', E'घर', E'A', E'''उपस्थित'' को विपरीतार्थक शब्द ''अनुपस्थित'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''उपस्थित'' शब्दको विपरीतार्थक शब्द कुन हो?'), v_set_id, v_q_id, 25)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''धनी'' शब्दको विपरीतार्थक शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 26, E'तलका मध्ये ''धनी'' शब्दको विपरीतार्थक शब्द कुन हो?', E'सम्पन्न', E'गरिब', E'व्यापारी', E'साहु', E'B', E'''धनी'' को उल्टो अर्थ ''गरिब'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''धनी'' शब्दको विपरीतार्थक शब्द कुन हो?'), v_set_id, v_q_id, 26)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''साक्षर'' शब्दको विपरीतार्थक शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 27, E'तलका मध्ये ''साक्षर'' शब्दको विपरीतार्थक शब्द कुन हो?', E'शिक्षित', E'विद्वान', E'निरक्षर', E'पढेको', E'C', E'''साक्षर'' (पढ्न लेख्न जान्ने) को उल्टो ''निरक्षर'' (पढ्न लेख्न नजान्ने) हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''साक्षर'' शब्दको विपरीतार्थक शब्द कुन हो?'), v_set_id, v_q_id, 27)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: गणितीय क्षमताः श्रेणीक्रम समस्याहरू - खण्ड 2 (आधारभूत तह) (30 Q)
  v_set_id := extensions.uuid_generate_v5('1e60e4c1-6741-4d59-9131-fbcd078b4e43'::uuid, E'गणितीय क्षमताः श्रेणीक्रम समस्याहरू - खण्ड 2 (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'db9d9515-ced5-4a90-a4ac-3a8927342e98'::uuid, '1e60e4c1-6741-4d59-9131-fbcd078b4e43'::uuid, E'गणितीय क्षमताः श्रेणीक्रम समस्याहरू - खण्ड 2 (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '1e60e4c1-6741-4d59-9131-fbcd078b4e43'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'60, 58, 54, 48, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'60, 58, 54, 48, ?', E'40', E'38', E'42', E'44', E'A', E'क्रमशः -2, -4, -6, र -8 घटाइएको छ (48 - 8 = 40)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:60, 58, 54, 48, ?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'85, 80, 70, 55, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'85, 80, 70, 55, ?', E'30', E'35', E'40', E'45', E'B', E'क्रमशः -5, -10, -15, र -20 घटाइएको छ (55 - 20 = 35)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:85, 80, 70, 55, ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'100, 99, 96, 91, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'100, 99, 96, 91, ?', E'82', E'83', E'84', E'85', E'C', E'क्रमशः -1, -3, -5, र -7 घटाइएको छ (91 - 7 = 84)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:100, 99, 96, 91, ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'50, 49, 45, 36, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'50, 49, 45, 36, ?', E'18', E'22', E'25', E'20', E'D', E'क्रमशः -1, -4, -9, र -16 (वर्ग सङ्ख्याहरू) घटाइएको छ (36 - 16 = 20)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:50, 49, 45, 36, ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'30, 28, 25, 21, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'30, 28, 25, 21, ?', E'16', E'14', E'15', E'17', E'A', E'क्रमशः -2, -3, -4, र -5 घटाइएको छ (21 - 5 = 16)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:30, 28, 25, 21, ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'2, 4, 8, 16, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'2, 4, 8, 16, ?', E'24', E'32', E'28', E'30', E'B', E'प्रत्येक पदलाई 2 ले गुणन गरिएको छ (16 × 2 = 32)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:2, 4, 8, 16, ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'3, 9, 27, 81, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'3, 9, 27, 81, ?', E'162', E'200', E'243', E'300', E'C', E'प्रत्येक पदलाई 3 ले गुणन गरिएको छ (81 × 3 = 243)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:3, 9, 27, 81, ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'5, 10, 20, 40, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'5, 10, 20, 40, ?', E'60', E'70', E'90', E'80', E'D', E'प्रत्येक पदलाई 2 ले गुणन गरिएको छ (40 × 2 = 80)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:5, 10, 20, 40, ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'4, 12, 36, 108, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'4, 12, 36, 108, ?', E'324', E'216', E'432', E'500', E'A', E'प्रत्येक पदलाई 3 ले गुणन गरिएको छ (108 × 3 = 324)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:4, 12, 36, 108, ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1, 5, 25, 125, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'1, 5, 25, 125, ?', E'250', E'625', E'500', E'700', E'B', E'प्रत्येक पदलाई 5 ले गुणन गरिएको छ (125 × 5 = 625)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1, 5, 25, 125, ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'2, 6, 18, 54, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'2, 6, 18, 54, ?', E'108', E'150', E'162', E'200', E'C', E'प्रत्येक पदलाई 3 ले गुणन गरिएको छ (54 × 3 = 162)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:2, 6, 18, 54, ?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1, 2, 6, 24, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'1, 2, 6, 24, ?', E'48', E'96', E'100', E'120', E'D', E'क्रमशः ×2, ×3, ×4, र ×5 गरिएको छ (24 × 5 = 120)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1, 2, 6, 24, ?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'2, 2, 4, 12, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'2, 2, 4, 12, ?', E'48', E'24', E'36', E'60', E'A', E'क्रमशः ×1, ×2, ×3, र ×4 गरिएको छ (12 × 4 = 48)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:2, 2, 4, 12, ?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'3, 6, 18, 72, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'3, 6, 18, 72, ?', E'144', E'360', E'216', E'288', E'B', E'क्रमशः ×2, ×3, ×4, र ×5 गरिएको छ (72 × 5 = 360)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:3, 6, 18, 72, ?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'5, 5, 10, 30, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'5, 5, 10, 30, ?', E'60', E'90', E'120', E'150', E'C', E'क्रमशः ×1, ×2, ×3, र ×4 गरिएको छ (30 × 4 = 120)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:5, 5, 10, 30, ?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'160, 80, 40, 20, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'160, 80, 40, 20, ?', E'5', E'12', E'15', E'10', E'D', E'प्रत्येक पदलाई 2 ले भाग गरिएको छ (20 ÷ 2 = 10)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:160, 80, 40, 20, ?'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'243, 81, 27, 9, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'243, 81, 27, 9, ?', E'3', E'1', E'2', E'4', E'A', E'प्रत्येक पदलाई 3 ले भाग गरिएको छ (9 ÷ 3 = 3)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:243, 81, 27, 9, ?'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'512, 256, 128, 64, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'512, 256, 128, 64, ?', E'16', E'32', E'24', E'48', E'B', E'प्रत्येक पदलाई 2 ले भाग गरिएको छ (64 ÷ 2 = 32)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:512, 256, 128, 64, ?'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'400, 200, 100, 50, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'400, 200, 100, 50, ?', E'15', E'20', E'25', E'30', E'C', E'प्रत्येक पदलाई 2 ले भाग गरिएको छ (50 ÷ 2 = 25)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:400, 200, 100, 50, ?'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'720, 120, 24, 6, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 20, E'720, 120, 24, 6, ?', E'1', E'3', E'4', E'2', E'D', E'क्रमशः ÷6, ÷5, ÷4, र ÷3 गरिएको छ (6 ÷ 3 = 2)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:720, 120, 24, 6, ?'), v_set_id, v_q_id, 20)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'120, 60, 20, 5, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 21, E'120, 60, 20, 5, ?', E'1', E'2', E'3', E'4', E'A', E'क्रमशः ÷2, ÷3, ÷4, र ÷5 गरिएको छ (5 ÷ 5 = 1)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:120, 60, 20, 5, ?'), v_set_id, v_q_id, 21)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'5000, 1000, 200, 40, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 22, E'5000, 1000, 200, 40, ?', E'5', E'8', E'10', E'12', E'B', E'प्रत्येक पदलाई 5 ले भाग गरिएको छ (40 ÷ 5 = 8)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:5000, 1000, 200, 40, ?'), v_set_id, v_q_id, 22)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'144, 72, 36, 18, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 23, E'144, 72, 36, 18, ?', E'6', E'8', E'9', E'12', E'C', E'प्रत्येक पदलाई 2 ले भाग गरिएको छ (18 ÷ 2 = 9)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:144, 72, 36, 18, ?'), v_set_id, v_q_id, 23)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'64, 32, 16, 8, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 24, E'64, 32, 16, 8, ?', E'2', E'6', E'8', E'4', E'D', E'प्रत्येक पदलाई 2 ले भाग गरिएको छ (8 ÷ 2 = 4)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:64, 32, 16, 8, ?'), v_set_id, v_q_id, 24)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'10000, 1000, 100, 10, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 25, E'10000, 1000, 100, 10, ?', E'1', E'0', E'2', E'5', E'A', E'प्रत्येक पदलाई 10 ले भाग गरिएको छ (10 ÷ 10 = 1)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:10000, 1000, 100, 10, ?'), v_set_id, v_q_id, 25)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1, 4, 9, 16, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 26, E'1, 4, 9, 16, ?', E'20', E'25', E'24', E'36', E'B', E'यो क्रमशः 1, 2, 3, 4, 5 को वर्ग सङ्ख्याहरूको क्रम हो (5² = 25)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1, 4, 9, 16, ?'), v_set_id, v_q_id, 26)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'36, 49, 64, 81, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 27, E'36, 49, 64, 81, ?', E'90', E'110', E'100', E'121', E'C', E'यो क्रमशः 6, 7, 8, 9, 10 को वर्ग सङ्ख्याहरूको क्रम हो (10² = 100)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:36, 49, 64, 81, ?'), v_set_id, v_q_id, 27)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'4, 16, 36, 64, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 28, E'4, 16, 36, 64, ?', E'81', E'90', E'144', E'100', E'D', E'यो क्रमशः जोर सङ्ख्याहरू 2, 4, 6, 8, 10 को वर्ग सङ्ख्या हो (10² = 100)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:4, 16, 36, 64, ?'), v_set_id, v_q_id, 28)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1, 9, 25, 49, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 29, E'1, 9, 25, 49, ?', E'81', E'64', E'100', E'121', E'A', E'यो क्रमशः बिजोर सङ्ख्याहरू 1, 3, 5, 7, 9 को वर्ग सङ्ख्या हो (9² = 81)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1, 9, 25, 49, ?'), v_set_id, v_q_id, 29)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'0, 3, 8, 15, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 30, E'0, 3, 8, 15, ?', E'20', E'24', E'22', E'26', E'B', E'प्रत्येक पद (n² - 1) को रूपमा छ। पालो 5² - 1 को हो (25 - 1 = 24)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:0, 3, 8, 15, ?'), v_set_id, v_q_id, 30)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: गणितीय क्षमताः श्रेणीक्रम समस्याहरू - खण्ड 3 (आधारभूत तह) (30 Q)
  v_set_id := extensions.uuid_generate_v5('1e60e4c1-6741-4d59-9131-fbcd078b4e43'::uuid, E'गणितीय क्षमताः श्रेणीक्रम समस्याहरू - खण्ड 3 (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'db9d9515-ced5-4a90-a4ac-3a8927342e98'::uuid, '1e60e4c1-6741-4d59-9131-fbcd078b4e43'::uuid, E'गणितीय क्षमताः श्रेणीक्रम समस्याहरू - खण्ड 3 (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '1e60e4c1-6741-4d59-9131-fbcd078b4e43'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'121, 144, 169, 196, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'121, 144, 169, 196, ?', E'225', E'210', E'256', E'289', E'A', E'यो क्रमशः 11, 12, 13, 14, 15 को वर्ग सङ्ख्याहरूको क्रम हो (15² = 225)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:121, 144, 169, 196, ?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'9, 25, 49, 81, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'9, 25, 49, 81, ?', E'100', E'121', E'144', E'169', E'B', E'यो क्रमशः बिजोर सङ्ख्याहरू 3, 5, 7, 9, 11 को वर्ग सङ्ख्या हो (11² = 121)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:9, 25, 49, 81, ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'3, 8, 15, 24, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'3, 8, 15, 24, ?', E'33', E'34', E'35', E'36', E'C', E'प्रत्येक पद (n² - 1) को रूपमा छ (क्रमशः 2, 3, 4, 5 का लागि)। पालो 6² - 1 को हो (36 - 1 = 35)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:3, 8, 15, 24, ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'5, 10, 17, 26, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'5, 10, 17, 26, ?', E'35', E'36', E'38', E'37', E'D', E'प्रत्येक पद (n² + 1) को रूपमा छ (क्रमशः 2, 3, 4, 5 का लागि)। पालो 6² + 1 को हो (36 + 1 = 37)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:5, 10, 17, 26, ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1, 8, 27, 64, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'1, 8, 27, 64, ?', E'125', E'100', E'121', E'216', E'A', E'यो क्रमशः 1, 2, 3, 4, 5 को घन (Cube) सङ्ख्याहरूको क्रम हो (5³ = 125)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1, 8, 27, 64, ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'8, 27, 64, 125, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'8, 27, 64, 125, ?', E'144', E'216', E'256', E'343', E'B', E'यो क्रमशः 2, 3, 4, 5, 6 को घन सङ्ख्याहरूको क्रम हो (6³ = 216)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:8, 27, 64, 125, ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'0, 7, 26, 63, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'0, 7, 26, 63, ?', E'125', E'126', E'124', E'215', E'C', E'प्रत्येक पद (n³ - 1) को रूपमा छ। पालो 5³ - 1 को हो (125 - 1 = 124)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:0, 7, 26, 63, ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'2, 9, 28, 65, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'2, 9, 28, 65, ?', E'125', E'127', E'217', E'126', E'D', E'प्रत्येक पद (n³ + 1) को रूपमा छ। पालो 5³ + 1 को हो (125 + 1 = 126)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:2, 9, 28, 65, ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'64, 125, 216, 343, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'64, 125, 216, 343, ?', E'512', E'400', E'441', E'500', E'A', E'यो क्रमशः 4, 5, 6, 7, 8 को घन सङ्ख्याहरूको क्रम हो (8³ = 512)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:64, 125, 216, 343, ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1000, 729, 512, 343, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'1000, 729, 512, 343, ?', E'256', E'216', E'289', E'300', E'B', E'यो क्रमशः 10, 9, 8, 7, 6 को घन सङ्ख्याहरूको उल्टो क्रम हो (6³ = 216)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1000, 729, 512, 343, ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'8, 64, 216, 512, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'8, 64, 216, 512, ?', E'729', E'800', E'1000', E'900', E'C', E'यो क्रमशः जोर सङ्ख्याहरू 2, 4, 6, 8, 10 को घन सङ्ख्या हो (10³ = 1000)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:8, 64, 216, 512, ?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1, 27, 125, 343, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'1, 27, 125, 343, ?', E'512', E'1000', E'1331', E'729', E'D', E'यो क्रमशः बिजोर सङ्ख्याहरू 1, 3, 5, 7, 9 को घन सङ्ख्या हो (9³ = 729)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1, 27, 125, 343, ?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'6, 25, 62, 123, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'6, 25, 62, 123, ?', E'214', E'212', E'216', E'218', E'A', E'प्रत्येक पद (n³ - 2) को रूपमा छ (क्रमशः 2, 3, 4, 5 का लागि)। पालो 6³ - 2 को हो (216 - 2 = 214)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:6, 25, 62, 123, ?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'10, 29, 66, 127, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'10, 29, 66, 127, ?', E'216', E'218', E'220', E'222', E'B', E'प्रत्येक पद (n³ + 2) को रूपमा छ (क्रमशः 2, 3, 4, 5 का लागि)। पालो 6³ + 2 को हो (216 + 2 = 218)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:10, 29, 66, 127, ?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'5, 10, 7, 12, 9, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'5, 10, 7, 12, 9, ?', E'11', E'12', E'14', E'13', E'C', E'यसमा पालैपालो +5 र -3 गरिएको छ (9 + 5 = 14)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:5, 10, 7, 12, 9, ?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'2, 5, 4, 7, 6, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'2, 5, 4, 7, 6, ?', E'8', E'10', E'11', E'9', E'D', E'यसमा पालैपालो +3 र -1 गरिएको छ (6 + 3 = 9)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:2, 5, 4, 7, 6, ?'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'10, 15, 13, 18, 16, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'10, 15, 13, 18, 16, ?', E'21', E'19', E'20', E'22', E'A', E'यसमा पालैपालो +5 र -2 गरिएको छ (16 + 5 = 21)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:10, 15, 13, 18, 16, ?'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'20, 18, 22, 20, 24, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'20, 18, 22, 20, 24, ?', E'20', E'22', E'24', E'26', E'B', E'यसमा पालैपालो -2 र +4 गरिएको छ (24 - 2 = 22)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:20, 18, 22, 20, 24, ?'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'3, 8, 5, 10, 7, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'3, 8, 5, 10, 7, ?', E'11', E'13', E'12', E'14', E'C', E'यसमा पालैपालो +5 र -3 गरिएको छ (7 + 5 = 12)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:3, 8, 5, 10, 7, ?'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'100, 50, 90, 45, 80, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 20, E'100, 50, 90, 45, 80, ?', E'30', E'35', E'45', E'40', E'D', E'दुई फरक श्रेणीहरूको मिश्रण: पहिलो (100, 90, 80) र दोस्रो (50, 45, 40)। दोस्रो श्रेणीको अर्को पद 40 हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:100, 50, 90, 45, 80, ?'), v_set_id, v_q_id, 20)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'2, 3, 4, 6, 6, 9, 8, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 21, E'2, 3, 4, 6, 6, 9, 8, ?', E'12', E'10', E'11', E'13', E'A', E'दुई फरक श्रेणीहरूको मिश्रण: पहिलो (2, 4, 6, 8) र दोस्रो (3, 6, 9, 12)। दोस्रो श्रेणीको अर्को पद 12 हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:2, 3, 4, 6, 6, 9, 8, ?'), v_set_id, v_q_id, 21)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'5, 25, 7, 35, 9, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 22, E'5, 25, 7, 35, 9, ?', E'40', E'45', E'50', E'55', E'B', E'दुई फरक श्रेणीहरूको मिश्रण: पहिलो (5, 7, 9) र दोस्रो (25, 35, 45)। दोस्रो श्रेणीको अर्को पद 45 हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:5, 25, 7, 35, 9, ?'), v_set_id, v_q_id, 22)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'8, 4, 12, 6, 16, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 23, E'8, 4, 12, 6, 16, ?', E'6', E'10', E'8', E'12', E'C', E'दुई फरक श्रेणीहरूको मिश्रण: पहिलो (8, 12, 16) र दोस्रो (4, 6, 8)। दोस्रो श्रेणीको अर्को पद 8 हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:8, 4, 12, 6, 16, ?'), v_set_id, v_q_id, 23)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'10, 1, 20, 2, 30, 3, 40, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 24, E'10, 1, 20, 2, 30, 3, 40, ?', E'5', E'6', E'50', E'4', E'D', E'दुई फरक श्रेणीहरूको मिश्रण: पहिलो (10, 20, 30, 40) र दोस्रो (1, 2, 3, 4)। दोस्रो श्रेणीको अर्को पद 4 हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:10, 1, 20, 2, 30, 3, 40, ?'), v_set_id, v_q_id, 24)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'2, 3, 5, 7, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 25, E'2, 3, 5, 7, ?', E'11', E'8', E'9', E'10', E'A', E'यी लगातार आउने रूढ सङ्ख्याहरू (Prime numbers) हुन्। 7 पछि 11 आउँछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:2, 3, 5, 7, ?'), v_set_id, v_q_id, 25)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'11, 13, 17, 19, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 26, E'11, 13, 17, 19, ?', E'21', E'23', E'25', E'27', E'B', E'यी लगातार आउने रूढ सङ्ख्याहरू हुन्। 19 पछि 23 आउँछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:11, 13, 17, 19, ?'), v_set_id, v_q_id, 26)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'23, 29, 31, 37, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 27, E'23, 29, 31, 37, ?', E'39', E'43', E'41', E'47', E'C', E'यी लगातार आउने रूढ सङ्ख्याहरू हुन्। 37 पछि 41 आउँछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:23, 29, 31, 37, ?'), v_set_id, v_q_id, 27)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'53, 59, 61, 67, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 28, E'53, 59, 61, 67, ?', E'69', E'73', E'77', E'71', E'D', E'यी लगातार आउने रूढ सङ्ख्याहरू हुन्। 67 पछि 71 आउँछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:53, 59, 61, 67, ?'), v_set_id, v_q_id, 28)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'3, 5, 7, 11, 13, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 29, E'3, 5, 7, 11, 13, ?', E'17', E'14', E'15', E'16', E'A', E'यी लगातार आउने रूढ सङ्ख्याहरू हुन्। 13 पछि 17 आउँछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:3, 5, 7, 11, 13, ?'), v_set_id, v_q_id, 29)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'17, 19, 23, 29, 31, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 30, E'17, 19, 23, 29, 31, ?', E'33', E'37', E'35', E'39', E'B', E'यी लगातार आउने रूढ सङ्ख्याहरू हुन्। 31 पछि 37 आउँछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:17, 19, 23, 29, 31, ?'), v_set_id, v_q_id, 30)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: गणितीय क्षमताः श्रेणीक्रम समस्याहरू - खण्ड 4 (आधारभूत तह) (24 Q)
  v_set_id := extensions.uuid_generate_v5('1e60e4c1-6741-4d59-9131-fbcd078b4e43'::uuid, E'गणितीय क्षमताः श्रेणीक्रम समस्याहरू - खण्ड 4 (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'db9d9515-ced5-4a90-a4ac-3a8927342e98'::uuid, '1e60e4c1-6741-4d59-9131-fbcd078b4e43'::uuid, E'गणितीय क्षमताः श्रेणीक्रम समस्याहरू - खण्ड 4 (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '1e60e4c1-6741-4d59-9131-fbcd078b4e43'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'41, 43, 47, 53, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'41, 43, 47, 53, ?', E'59', E'55', E'57', E'61', E'A', E'यी लगातार आउने रूढ सङ्ख्याहरू हुन्। 53 पछि 59 आउँछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:41, 43, 47, 53, ?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'71, 73, 79, 83, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'71, 73, 79, 83, ?', E'85', E'89', E'87', E'91', E'B', E'यी लगातार आउने रूढ सङ्ख्याहरू हुन्। 83 पछि 89 आउँछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:71, 73, 79, 83, ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'7, 11, 13, 17, 19, 23, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'7, 11, 13, 17, 19, 23, ?', E'25', E'27', E'29', E'31', E'C', E'यी लगातार आउने रूढ सङ्ख्याहरू हुन्। 23 पछि 29 आउँछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:7, 11, 13, 17, 19, 23, ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'31, 37, 41, 43, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'31, 37, 41, 43, ?', E'45', E'49', E'51', E'47', E'D', E'यी लगातार आउने रूढ सङ्ख्याहरू हुन्। 43 पछि 47 आउँछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:31, 37, 41, 43, ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1, 1, 2, 3, 5, 8, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'1, 1, 2, 3, 5, 8, ?', E'13', E'11', E'12', E'15', E'A', E'यो फिवोनाची (Fibonacci) श्रेणी हो, जहाँ अघिल्ला दुई पद जोडेर नयाँ पद बन्छ (5 + 8 = 13)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1, 1, 2, 3, 5, 8, ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'2, 3, 5, 8, 13, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'2, 3, 5, 8, 13, ?', E'18', E'21', E'19', E'20', E'B', E'अघिल्ला दुई पद जोडेर नयाँ पद बन्छ (8 + 13 = 21)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:2, 3, 5, 8, 13, ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'3, 4, 7, 11, 18, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'3, 4, 7, 11, 18, ?', E'27', E'28', E'29', E'30', E'C', E'अघिल्ला दुई पद जोडेर नयाँ पद बन्छ (11 + 18 = 29)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:3, 4, 7, 11, 18, ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'5, 7, 12, 19, 31, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'5, 7, 12, 19, 31, ?', E'45', E'55', E'60', E'50', E'D', E'अघिल्ला दुई पद जोडेर नयाँ पद बन्छ (19 + 31 = 50)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:5, 7, 12, 19, 31, ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'10, 10, 20, 30, 50, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'10, 10, 20, 30, 50, ?', E'80', E'60', E'70', E'90', E'A', E'अघिल्ला दुई पद जोडेर नयाँ पद बन्छ (30 + 50 = 80)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:10, 10, 20, 30, 50, ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'4, 6, 10, 16, 26, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'4, 6, 10, 16, 26, ?', E'36', E'42', E'38', E'40', E'B', E'अघिल्ला दुई पद जोडेर नयाँ पद बन्छ (16 + 26 = 42)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:4, 6, 10, 16, 26, ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1, 3, 4, 7, 11, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'1, 3, 4, 7, 11, ?', E'15', E'16', E'18', E'17', E'C', E'अघिल्ला दुई पद जोडेर नयाँ पद बन्छ (7 + 11 = 18)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1, 3, 4, 7, 11, ?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'2, 5, 7, 12, 19, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'2, 5, 7, 12, 19, ?', E'29', E'30', E'32', E'31', E'D', E'अघिल्ला दुई पद जोडेर नयाँ पद बन्छ (12 + 19 = 31)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:2, 5, 7, 12, 19, ?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'8, 13, 21, 34, 55, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'8, 13, 21, 34, 55, ?', E'89', E'76', E'98', E'100', E'A', E'अघिल्ला दुई पद जोडेर नयाँ पद बन्छ (34 + 55 = 89)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:8, 13, 21, 34, 55, ?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1, 4, 5, 9, 14, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'1, 4, 5, 9, 14, ?', E'21', E'23', E'22', E'24', E'B', E'अघिल्ला दुई पद जोडेर नयाँ पद बन्छ (9 + 14 = 23)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1, 4, 5, 9, 14, ?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'2, 5, 11, 23, 47, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'2, 5, 11, 23, 47, ?', E'93', E'94', E'95', E'96', E'C', E'प्रत्येक पदलाई 2 ले गुणन गरी 1 जोडिएको छ (47 × 2 + 1 = 95)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:2, 5, 11, 23, 47, ?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'3, 5, 9, 17, 33, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'3, 5, 9, 17, 33, ?', E'63', E'64', E'66', E'65', E'D', E'प्रत्येक पदलाई 2 ले गुणन गरी 1 घटाइएको छ (33 × 2 - 1 = 65)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:3, 5, 9, 17, 33, ?'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'5, 11, 24, 51, 106, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'5, 11, 24, 51, 106, ?', E'217', E'215', E'216', E'218', E'A', E'प्रत्येक पदलाई 2 ले गुणन गरी क्रमशः +1, +2, +3, +4, +5 जोडिएको छ (106 × 2 + 5 = 217)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:5, 11, 24, 51, 106, ?'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1, 2, 6, 21, 88, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'1, 2, 6, 21, 88, ?', E'442', E'445', E'443', E'444', E'B', E'क्रमशः (×1+1), (×2+2), (×3+3), (×4+4), र (×5+5) गरिएको छ (88 × 5 + 5 = 445)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1, 2, 6, 21, 88, ?'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'10, 11, 24, 75, 304, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'10, 11, 24, 75, 304, ?', E'1520', E'1522', E'1525', E'1524', E'C', E'क्रमशः (×1+1), (×2+2), (×3+3), (×4+4), र (×5+5) गरिएको छ (304 × 5 + 5 = 1525)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:10, 11, 24, 75, 304, ?'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'4, 9, 20, 43, 90, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 20, E'4, 9, 20, 43, 90, ?', E'180', E'182', E'190', E'185', E'D', E'प्रत्येक पदलाई 2 ले गुणन गरी क्रमशः +1, +2, +3, +4, +5 जोडिएको छ (90 × 2 + 5 = 185)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:4, 9, 20, 43, 90, ?'), v_set_id, v_q_id, 20)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'12, 26, 54, 110, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 21, E'12, 26, 54, 110, ?', E'222', E'220', E'224', E'226', E'A', E'प्रत्येक पदलाई 2 ले गुणन गरी 2 जोडिएको छ (110 × 2 + 2 = 222)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:12, 26, 54, 110, ?'), v_set_id, v_q_id, 21)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'8, 15, 29, 57, 113, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 22, E'8, 15, 29, 57, 113, ?', E'223', E'225', E'224', E'226', E'B', E'प्रत्येक पदलाई 2 ले गुणन गरी 1 घटाइएको छ (113 × 2 - 1 = 225)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:8, 15, 29, 57, 113, ?'), v_set_id, v_q_id, 22)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'5, 12, 31, 68, 129, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 23, E'5, 12, 31, 68, 129, ?', E'216', E'218', E'220', E'222', E'C', E'प्रत्येक पद (n³ + 4) को रूपमा छ (क्रमशः 1, 2, 3, 4, 5 का लागि)। पालो 6³ + 4 को हो (216 + 4 = 220)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:5, 12, 31, 68, 129, ?'), v_set_id, v_q_id, 23)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'2, 6, 12, 20, 30, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 24, E'2, 6, 12, 20, 30, ?', E'40', E'44', E'46', E'42', E'D', E'प्रत्येक पद (n² + n) को रूपमा छ (क्रमशः 1, 2, 3, 4, 5 का लागि)। पालो 6² + 6 को हो (36 + 6 = 42)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:2, 6, 12, 20, 30, ?'), v_set_id, v_q_id, 24)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: गणितीय क्षमताः गणितीय पजलहरू - खण्ड 2 (आधारभूत तह) (30 Q)
  v_set_id := extensions.uuid_generate_v5('8b41dcb1-7155-4d8d-9f86-9764a3ff8f79'::uuid, E'गणितीय क्षमताः गणितीय पजलहरू - खण्ड 2 (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'db9d9515-ced5-4a90-a4ac-3a8927342e98'::uuid, '8b41dcb1-7155-4d8d-9f86-9764a3ff8f79'::uuid, E'गणितीय क्षमताः गणितीय पजलहरू - खण्ड 2 (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '8b41dcb1-7155-4d8d-9f86-9764a3ff8f79'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै संख्याको 1/3 भाग भनेको 20 हुन्छ भने, सोही संख्याको 1/4 भाग कति होला?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'कुनै संख्याको 1/3 भाग भनेको 20 हुन्छ भने, सोही संख्याको 1/4 भाग कति होला?', E'15', E'10', E'25', E'12', E'A', E'संख्या = 20 × 3 = 60। 60 को 1/4 भाग = 60 / 4 = 15।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै संख्याको 1/3 भाग भनेको 20 हुन्छ भने, सोही संख्याको 1/4 भाग कति होला?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'200 मिटर लामो एउटा ट्रेनले एउटा पोललाई 10 सेकेन्डमा पार गर्छ भने, ट्रेनको गति कति किमी/घण्टा होला?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'200 मिटर लामो एउटा ट्रेनले एउटा पोललाई 10 सेकेन्डमा पार गर्छ भने, ट्रेनको गति कति किमी/घण्टा होला?', E'54 km/hr', E'72 km/hr', E'90 km/hr', E'60 km/hr', E'B', E'गति = 200 / 10 = 20 m/s। किमी/घण्टामा: 20 × 18/5 = 72 km/hr।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:200 मिटर लामो एउटा ट्रेनले एउटा पोललाई 10 सेकेन्डमा पार गर्छ भने, ट्रेनको गति कति किमी/घण्टा होला?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएको संख्या श्रेणीमा प्रश्नचिह्न (?) भएको ठाउँमा कुन संख्या हुन्छ? 2, 5, 10, 17, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'दिइएको संख्या श्रेणीमा प्रश्नचिह्न (?) भएको ठाउँमा कुन संख्या हुन्छ? 2, 5, 10, 17, ?', E'24', E'25', E'26', E'27', E'C', E'प्रत्येक पद n² + 1 को रूपमा छ (1²+1=2, 2²+1=5, 3²+1=10, 4²+1=17)। त्यसैले अर्को पद 5² + 1 = 26 हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएको संख्या श्रेणीमा प्रश्नचिह्न (?) भएको ठाउँमा कुन संख्या हुन्छ? 2, 5, 10, 17, ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'एउटा खोरमा गाई र कुखुरा छन्। टाउकोको संख्या 30 र खुट्टाको संख्या 100 छ भने गाई कति होलान्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'एउटा खोरमा गाई र कुखुरा छन्। टाउकोको संख्या 30 र खुट्टाको संख्या 100 छ भने गाई कति होलान्?', E'10', E'15', E'25', E'20', E'D', E'4x + 2y = 100 र x + y = 30। हल गर्दा x (गाई) = 20 र y (कुखुरा) = 10 हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:एउटा खोरमा गाई र कुखुरा छन्। टाउकोको संख्या 30 र खुट्टाको संख्या 100 छ भने गाई कति होलान्?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'12 जना मानिसहरूले एकआपसमा हात मिलाउँदा जम्मा कति पटक हात मिलाइन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'12 जना मानिसहरूले एकआपसमा हात मिलाउँदा जम्मा कति पटक हात मिलाइन्छ?', E'66', E'72', E'60', E'54', E'A', E'(12 × 11) / 2 = 66 पटक।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:12 जना मानिसहरूले एकआपसमा हात मिलाउँदा जम्मा कति पटक हात मिलाइन्छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दुई संख्याको योगफल 80 र फरक 20 छ भने सानो संख्या कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'दुई संख्याको योगफल 80 र फरक 20 छ भने सानो संख्या कुन हो?', E'20', E'30', E'40', E'50', E'B', E'सानो संख्या = (योगफल - फरक) / 2 = (80 - 20) / 2 = 60 / 2 = 30।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दुई संख्याको योगफल 80 र फरक 20 छ भने सानो संख्या कुन हो?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'एउटा मुढालाई 4 टुक्रा बनाउन 15 मिनेट लाग्छ भने 7 टुक्रा बनाउन कति समय लाग्ला?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'एउटा मुढालाई 4 टुक्रा बनाउन 15 मिनेट लाग्छ भने 7 टुक्रा बनाउन कति समय लाग्ला?', E'25 मिनेट', E'28 मिनेट', E'30 मिनेट', E'35 मिनेट', E'C', E'4 टुक्रा बनाउन 3 पटक काट्नुपर्छ, त्यसैले 1 पटकको 5 मिनेट। 7 टुक्रा बनाउन 6 पटक काट्नुपर्छ। 6 × 5 = 30 मिनेट।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:एउटा मुढालाई 4 टुक्रा बनाउन 15 मिनेट लाग्छ भने 7 टुक्रा बनाउन कति समय लाग्ला?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'एउटा बाँदर 45 मिटर अग्लो खम्बामा चढ्दैछ। पहिलो मिनेटमा 7 मिटर चढ्छ र दोस्रो मिनेटमा 3 मिटर झर्छ। टुप्पोमा पुग्न कति समय लाग्ला?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'एउटा बाँदर 45 मिटर अग्लो खम्बामा चढ्दैछ। पहिलो मिनेटमा 7 मिटर चढ्छ र दोस्रो मिनेटमा 3 मिटर झर्छ। टुप्पोमा पुग्न कति समय लाग्ला?', E'20 मिनेट', E'22 मिनेट', E'23 मिनेट', E'21 मिनेट', E'D', E'2 मिनेटमा 4 मिटर चढ्छ। अन्तिम 7 मिटर 1 मिनेटमा चढ्छ। बाँकी (45-7) = 38 मिटर चढ्न 38/4 = 9.5 अर्थात् 10 चक्र (20 मिनेट) लाग्छ। 20 मिनेटमा 40 मिटर पुग्छ। २१ औं मिनेटमा 40+7=47 मिटर पुग्छ जुन टुप्पो पार गर्छ। त्यसैले 21 मिनेट।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:एउटा बाँदर 45 मिटर अग्लो खम्बामा चढ्दैछ। पहिलो मिनेटमा 7 मिटर चढ्छ र दोस्रो मिनेटमा 3 मिटर झर्छ। टुप्पोमा पुग्न कति समय लाग्ला?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'A ले एउटा काम 20 दिनमा र B ले 30 दिनमा गर्न सक्छ। दुवै मिलेर कति दिनमा गर्लान्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'A ले एउटा काम 20 दिनमा र B ले 30 दिनमा गर्न सक्छ। दुवै मिलेर कति दिनमा गर्लान्?', E'12 दिन', E'10 दिन', E'15 दिन', E'18 दिन', E'A', E'(20 × 30) / (20 + 30) = 600 / 50 = 12 दिन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:A ले एउटा काम 20 दिनमा र B ले 30 दिनमा गर्न सक्छ। दुवै मिलेर कति दिनमा गर्लान्?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै रकम साधारण ब्याज अनुसार 20 वर्षमा दोब्बर हुन्छ भने ब्याजदर कति होला?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'कुनै रकम साधारण ब्याज अनुसार 20 वर्षमा दोब्बर हुन्छ भने ब्याजदर कति होला?', E'4%', E'5%', E'8%', E'10%', E'B', E'दर = 100 / 20 = 5%।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै रकम साधारण ब्याज अनुसार 20 वर्षमा दोब्बर हुन्छ भने ब्याजदर कति होला?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'परीक्षामा पास हुन 30% अंक चाहिन्छ। एक विद्यार्थीले 60 अंक ल्यायो र 30 अंकले फेल भयो भने पूर्णांक कति होला?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'परीक्षामा पास हुन 30% अंक चाहिन्छ। एक विद्यार्थीले 60 अंक ल्यायो र 30 अंकले फेल भयो भने पूर्णांक कति होला?', E'200', E'250', E'300', E'350', E'C', E'पास अंक = 60 + 30 = 90। पूर्णांक = (90 × 100) / 30 = 300।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:परीक्षामा पास हुन 30% अंक चाहिन्छ। एक विद्यार्थीले 60 अंक ल्यायो र 30 अंकले फेल भयो भने पूर्णांक कति होला?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'रु. 1200 लाई A र B बीच बाँड्दा A ले B भन्दा रु. 200 कम पायो भने A ले कति पायो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'रु. 1200 लाई A र B बीच बाँड्दा A ले B भन्दा रु. 200 कम पायो भने A ले कति पायो?', E'400', E'600', E'700', E'500', E'D', E'A + B = 1200, B - A = 200। हल गर्दा 2B = 1400 => B = 700, र A = 500।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:रु. 1200 लाई A र B बीच बाँड्दा A ले B भन्दा रु. 200 कम पायो भने A ले कति पायो?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दुई लगातार बिजोर संख्याहरूको गुणनफल 143 छ भने सानो संख्या कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'दुई लगातार बिजोर संख्याहरूको गुणनफल 143 छ भने सानो संख्या कुन हो?', E'11', E'9', E'13', E'15', E'A', E'11 × 13 = 143। सानो संख्या 11 हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दुई लगातार बिजोर संख्याहरूको गुणनफल 143 छ भने सानो संख्या कुन हो?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'एउटा पाइपले ट्यांकी 10 घण्टामा र अर्कोले 15 घण्टामा भर्न सक्छन्। दुवै एकैपटक खोल्दा कति समयमा भरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'एउटा पाइपले ट्यांकी 10 घण्टामा र अर्कोले 15 घण्टामा भर्न सक्छन्। दुवै एकैपटक खोल्दा कति समयमा भरिन्छ?', E'5 घण्टा', E'6 घण्टा', E'7 घण्टा', E'8 घण्टा', E'B', E'(10 × 15) / (10 + 15) = 150 / 25 = 6 घण्टा।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:एउटा पाइपले ट्यांकी 10 घण्टामा र अर्कोले 15 घण्टामा भर्न सक्छन्। दुवै एकैपटक खोल्दा कति समयमा भरिन्छ?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'बुवा र छोराको उमेरको योगफल 60 वर्ष छ। 10 वर्ष अगाडि बुवाको उमेर छोराको भन्दा 3 गुणा थियो भने अहिले छोराको उमेर कति होला?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'बुवा र छोराको उमेरको योगफल 60 वर्ष छ। 10 वर्ष अगाडि बुवाको उमेर छोराको भन्दा 3 गुणा थियो भने अहिले छोराको उमेर कति होला?', E'15 वर्ष', E'25 वर्ष', E'20 वर्ष', E'30 वर्ष', E'C', E'10 वर्ष अघि योगफल 40 थियो। x + 3x = 40 => 4x = 40 => x = 10। हाल छोराको उमेर = 10 + 10 = 20 वर्ष।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:बुवा र छोराको उमेरको योगफल 60 वर्ष छ। 10 वर्ष अगाडि बुवाको उमेर छोराको भन्दा 3 गुणा थियो भने अहिले छोराको उमेर कति होला?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै संख्याको 2/3 भाग 40 हुन्छ भने सो संख्याको आधा (1/2) कति होला?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'कुनै संख्याको 2/3 भाग 40 हुन्छ भने सो संख्याको आधा (1/2) कति होला?', E'20', E'40', E'60', E'30', E'D', E'संख्या = 40 × 3/2 = 60। यसको आधा = 30।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै संख्याको 2/3 भाग 40 हुन्छ भने सो संख्याको आधा (1/2) कति होला?'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'150 मिटर लामो ट्रेनले 15 सेकेन्डमा पोल पार गर्छ भने ट्रेनको गति कति किमी/घण्टा होला?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'150 मिटर लामो ट्रेनले 15 सेकेन्डमा पोल पार गर्छ भने ट्रेनको गति कति किमी/घण्टा होला?', E'36 km/hr', E'45 km/hr', E'54 km/hr', E'60 km/hr', E'A', E'गति = 150 / 15 = 10 m/s। 10 × 18/5 = 36 km/hr।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:150 मिटर लामो ट्रेनले 15 सेकेन्डमा पोल पार गर्छ भने ट्रेनको गति कति किमी/घण्टा होला?'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1, 4, 9, 16, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'1, 4, 9, 16, ?', E'20', E'25', E'24', E'30', E'B', E'सबै संख्याहरू पूर्ण वर्ग हुन् (1², 2², 3², 4²)। अर्को 5² = 25 हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1, 4, 9, 16, ?'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'एउटा खोरमा बाख्रा र कुखुरा छन्। टाउकोको संख्या 40 र खुट्टाको संख्या 130 छ भने बाख्रा कति होलान्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'एउटा खोरमा बाख्रा र कुखुरा छन्। टाउकोको संख्या 40 र खुट्टाको संख्या 130 छ भने बाख्रा कति होलान्?', E'15', E'20', E'25', E'30', E'C', E'4x + 2y = 130 र x + y = 40। 4x + 2(40-x) = 130 => 2x = 50 => x = 25। बाख्रा 25 वटा छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:एउटा खोरमा बाख्रा र कुखुरा छन्। टाउकोको संख्या 40 र खुट्टाको संख्या 130 छ भने बाख्रा कति होलान्?'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'15 जना मानिसहरूले एकआपसमा हात मिलाउँदा जम्मा कति पटक हात मिलाइन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 20, E'15 जना मानिसहरूले एकआपसमा हात मिलाउँदा जम्मा कति पटक हात मिलाइन्छ?', E'115', E'120', E'150', E'105', E'D', E'(15 × 14) / 2 = 105 पटक।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:15 जना मानिसहरूले एकआपसमा हात मिलाउँदा जम्मा कति पटक हात मिलाइन्छ?'), v_set_id, v_q_id, 20)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दुई संख्याको योगफल 100 र फरक 40 छ भने ठूलो संख्या कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 21, E'दुई संख्याको योगफल 100 र फरक 40 छ भने ठूलो संख्या कुन हो?', E'70', E'60', E'80', E'90', E'A', E'(100 + 40) / 2 = 70।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दुई संख्याको योगफल 100 र फरक 40 छ भने ठूलो संख्या कुन हो?'), v_set_id, v_q_id, 21)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'एउटा मुढालाई 6 टुक्रा बनाउन 20 मिनेट लाग्छ भने 9 टुक्रा बनाउन कति समय लाग्ला?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 22, E'एउटा मुढालाई 6 टुक्रा बनाउन 20 मिनेट लाग्छ भने 9 टुक्रा बनाउन कति समय लाग्ला?', E'30 मिनेट', E'32 मिनेट', E'36 मिनेट', E'40 मिनेट', E'B', E'5 पटक काट्न 20 मिनेट (प्रति काट 4 मिनेट)। 9 टुक्रा बनाउन 8 पटक काट्नुपर्छ। 8 × 4 = 32 मिनेट।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:एउटा मुढालाई 6 टुक्रा बनाउन 20 मिनेट लाग्छ भने 9 टुक्रा बनाउन कति समय लाग्ला?'), v_set_id, v_q_id, 22)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'बाँदर 50 मिटर खम्बामा चढ्दैछ। 1 मिनेटमा 8 मिटर चढ्छ र 1 मिनेटमा 4 मिटर झर्छ। कति समय लाग्ला?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 23, E'बाँदर 50 मिटर खम्बामा चढ्दैछ। 1 मिनेटमा 8 मिटर चढ्छ र 1 मिनेटमा 4 मिटर झर्छ। कति समय लाग्ला?', E'20 मिनेट', E'21 मिनेट', E'23 मिनेट', E'22 मिनेट', E'C', E'२ मिनेटमा ४ मिटर। (५०-८)/४ = १०.५ अर्थात् ११ चक्र (२२ मिनेट)। २२ मिनेटमा ४४ मिटर। २३ औं मिनेटमा ४४+८=५२ मिटर (टुप्पो पार)। त्यसैले २३ मिनेट।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:बाँदर 50 मिटर खम्बामा चढ्दैछ। 1 मिनेटमा 8 मिटर चढ्छ र 1 मिनेटमा 4 मिटर झर्छ। कति समय लाग्ला?'), v_set_id, v_q_id, 23)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'A ले 12 दिन र B ले 24 दिनमा काम सक्छन्। सँगै गर्दा कति दिन लाग्ला?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 24, E'A ले 12 दिन र B ले 24 दिनमा काम सक्छन्। सँगै गर्दा कति दिन लाग्ला?', E'6 दिन', E'10 दिन', E'12 दिन', E'8 दिन', E'D', E'(12 × 24) / 36 = 8 दिन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:A ले 12 दिन र B ले 24 दिनमा काम सक्छन्। सँगै गर्दा कति दिन लाग्ला?'), v_set_id, v_q_id, 24)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'रकम 8 वर्षमा दोब्बर हुन कति ब्याजदर चाहिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 25, E'रकम 8 वर्षमा दोब्बर हुन कति ब्याजदर चाहिन्छ?', E'12.5%', E'10%', E'12%', E'15%', E'A', E'100 / 8 = 12.5%।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:रकम 8 वर्षमा दोब्बर हुन कति ब्याजदर चाहिन्छ?'), v_set_id, v_q_id, 25)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पास हुन 50% चाहिन्छ। 200 अंक ल्याउँदा 50 अंकले फेल भयो। पूर्णांक कति?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 26, E'पास हुन 50% चाहिन्छ। 200 अंक ल्याउँदा 50 अंकले फेल भयो। पूर्णांक कति?', E'400', E'500', E'450', E'600', E'B', E'पास अंक = 250। पूर्णांक = (250 × 100) / 50 = 500।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पास हुन 50% चाहिन्छ। 200 अंक ल्याउँदा 50 अंकले फेल भयो। पूर्णांक कति?'), v_set_id, v_q_id, 26)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'रु. 2000 लाई A र B बीच बाँड्दा A ले B भन्दा रु. 400 बढी पायो। B ले कति पायो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 27, E'रु. 2000 लाई A र B बीच बाँड्दा A ले B भन्दा रु. 400 बढी पायो। B ले कति पायो?', E'1000', E'1200', E'800', E'1400', E'C', E'A = B + 400। B + B + 400 = 2000 => 2B = 1600 => B = 800।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:रु. 2000 लाई A र B बीच बाँड्दा A ले B भन्दा रु. 400 बढी पायो। B ले कति पायो?'), v_set_id, v_q_id, 27)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दुई लगातार जोर संख्याको गुणनफल 288 छ। ठूलो संख्या कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 28, E'दुई लगातार जोर संख्याको गुणनफल 288 छ। ठूलो संख्या कुन हो?', E'16', E'20', E'22', E'18', E'D', E'16 × 18 = 288। ठूलो संख्या 18 हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दुई लगातार जोर संख्याको गुणनफल 288 छ। ठूलो संख्या कुन हो?'), v_set_id, v_q_id, 28)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दुई पाइपले क्रमशः 15 र 30 घण्टामा ट्यांकी भर्छन्। सँगै खोल्दा कति घण्टा लाग्ला?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 29, E'दुई पाइपले क्रमशः 15 र 30 घण्टामा ट्यांकी भर्छन्। सँगै खोल्दा कति घण्टा लाग्ला?', E'10 घण्टा', E'8 घण्टा', E'12 घण्टा', E'15 घण्टा', E'A', E'(15 × 30) / (15 + 30) = 450 / 45 = 10 घण्टा।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दुई पाइपले क्रमशः 15 र 30 घण्टामा ट्यांकी भर्छन्। सँगै खोल्दा कति घण्टा लाग्ला?'), v_set_id, v_q_id, 29)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'बुवा र छोराको उमेरको योगफल 50 छ। 5 वर्ष पछि उनीहरूको उमेरको योगफल कति होला?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 30, E'बुवा र छोराको उमेरको योगफल 50 छ। 5 वर्ष पछि उनीहरूको उमेरको योगफल कति होला?', E'55', E'60', E'65', E'70', E'B', E'दुवैको उमेर ५-५ वर्षले बढ्छ। त्यसैले ५० + १० = ६० वर्ष।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:बुवा र छोराको उमेरको योगफल 50 छ। 5 वर्ष पछि उनीहरूको उमेरको योगफल कति होला?'), v_set_id, v_q_id, 30)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: गणितीय क्षमताः गणितीय पजलहरू - खण्ड 3 (आधारभूत तह) (30 Q)
  v_set_id := extensions.uuid_generate_v5('8b41dcb1-7155-4d8d-9f86-9764a3ff8f79'::uuid, E'गणितीय क्षमताः गणितीय पजलहरू - खण्ड 3 (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'db9d9515-ced5-4a90-a4ac-3a8927342e98'::uuid, '8b41dcb1-7155-4d8d-9f86-9764a3ff8f79'::uuid, E'गणितीय क्षमताः गणितीय पजलहरू - खण्ड 3 (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '8b41dcb1-7155-4d8d-9f86-9764a3ff8f79'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै संख्याको 3/4 भाग 60 हुन्छ भने संख्याको 1/5 कति होला?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'कुनै संख्याको 3/4 भाग 60 हुन्छ भने संख्याको 1/5 कति होला?', E'16', E'12', E'15', E'20', E'A', E'संख्या = 60 × 4/3 = 80। 80 को 1/5 = 16।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै संख्याको 3/4 भाग 60 हुन्छ भने संख्याको 1/5 कति होला?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'250 मिटर लामो ट्रेनले 20 सेकेन्डमा पोल पार गर्छ। गति कति km/hr होला?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'250 मिटर लामो ट्रेनले 20 सेकेन्डमा पोल पार गर्छ। गति कति km/hr होला?', E'36 km/hr', E'45 km/hr', E'54 km/hr', E'60 km/hr', E'B', E'गति = 250/20 = 12.5 m/s। 12.5 × 18/5 = 45 km/hr।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:250 मिटर लामो ट्रेनले 20 सेकेन्डमा पोल पार गर्छ। गति कति km/hr होला?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'3, 6, 11, 18, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'3, 6, 11, 18, ?', E'25', E'29', E'27', E'31', E'C', E'फरकहरू: 3, 5, 7 हुन्। अर्को फरक 9 हुनुपर्छ। 18 + 9 = 27।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:3, 6, 11, 18, ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'एउटा खोरमा कुखुरा र गाई छन्। टाउकोको संख्या 50 र खुट्टाको संख्या 160 छ। कुखुरा कति होलान्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'एउटा खोरमा कुखुरा र गाई छन्। टाउकोको संख्या 50 र खुट्टाको संख्या 160 छ। कुखुरा कति होलान्?', E'10', E'15', E'25', E'20', E'D', E'4x + 2y = 160, x + y = 50। हल गर्दा x = 30 (गाई) र y = 20 (कुखुरा)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:एउटा खोरमा कुखुरा र गाई छन्। टाउकोको संख्या 50 र खुट्टाको संख्या 160 छ। कुखुरा कति होलान्?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'20 जनाले एकआपसमा हात मिलाउँदा कति पटक हात मिलाइन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'20 जनाले एकआपसमा हात मिलाउँदा कति पटक हात मिलाइन्छ?', E'190', E'180', E'200', E'210', E'A', E'(20 × 19) / 2 = 190।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:20 जनाले एकआपसमा हात मिलाउँदा कति पटक हात मिलाइन्छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'योगफल 120 र फरक 30 भएका दुई संख्यामध्ये सानो संख्या कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'योगफल 120 र फरक 30 भएका दुई संख्यामध्ये सानो संख्या कुन हो?', E'40', E'45', E'50', E'55', E'B', E'(120 - 30) / 2 = 90 / 2 = 45।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:योगफल 120 र फरक 30 भएका दुई संख्यामध्ये सानो संख्या कुन हो?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'8 टुक्रा बनाउन 35 मिनेट लाग्छ भने 10 टुक्रा बनाउन कति समय लाग्ला?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'8 टुक्रा बनाउन 35 मिनेट लाग्छ भने 10 टुक्रा बनाउन कति समय लाग्ला?', E'40 मिनेट', E'50 मिनेट', E'45 मिनेट', E'55 मिनेट', E'C', E'7 पटक काट्न 35 मिनेट (1 पटकको 5 मिनेट)। 9 पटक काट्न 9 × 5 = 45 मिनेट।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:8 टुक्रा बनाउन 35 मिनेट लाग्छ भने 10 टुक्रा बनाउन कति समय लाग्ला?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'60 मिटर खम्बामा बाँदर 10 मिटर चढ्छ, 4 मिटर झर्छ। कति समयमा टुप्पो पुग्ला?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'60 मिटर खम्बामा बाँदर 10 मिटर चढ्छ, 4 मिटर झर्छ। कति समयमा टुप्पो पुग्ला?', E'17 मिनेट', E'18 मिनेट', E'20 मिनेट', E'19 मिनेट', E'D', E'२ मिनेटको चक्रमा बाँदर खुद ६ मिटर माथि जान्छ। ८ पूर्ण चक्र (१६ मिनेट) पछि ४८ मिटर, १७ औं मिनेटमा चढेर ५८ मिटर (टुप्पो ६० भन्दा कम), १८ औं मिनेटमा झरेर ५४ मिटर, अनि १९ औं मिनेटमा चढेर ६४ मिटर (टुप्पो नाघ्यो)। जम्मा **१९ मिनेट** लाग्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:60 मिटर खम्बामा बाँदर 10 मिटर चढ्छ, 4 मिटर झर्छ। कति समयमा टुप्पो पुग्ला?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'A ले 15 दिन र B ले 30 दिनमा काम गर्छन्। सँगै गर्दा कति दिन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'A ले 15 दिन र B ले 30 दिनमा काम गर्छन्। सँगै गर्दा कति दिन?', E'10', E'8', E'12', E'15', E'A', E'(15 × 30) / 45 = 10 दिन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:A ले 15 दिन र B ले 30 दिनमा काम गर्छन्। सँगै गर्दा कति दिन?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'रकम 5 वर्षमा दोब्बर हुन ब्याजदर कति चाहिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'रकम 5 वर्षमा दोब्बर हुन ब्याजदर कति चाहिन्छ?', E'15%', E'20%', E'25%', E'30%', E'B', E'100 / 5 = 20%।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:रकम 5 वर्षमा दोब्बर हुन ब्याजदर कति चाहिन्छ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पास हुन 45% चाहिन्छ। 150 अंक ल्याउँदा 30 अंकले फेल भयो। पूर्णांक कति?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'पास हुन 45% चाहिन्छ। 150 अंक ल्याउँदा 30 अंकले फेल भयो। पूर्णांक कति?', E'300', E'350', E'400', E'450', E'C', E'पास अंक = 180। पूर्णांक = (180 × 100) / 45 = 400।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पास हुन 45% चाहिन्छ। 150 अंक ल्याउँदा 30 अंकले फेल भयो। पूर्णांक कति?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'रु. 3000 लाई A र B बीच बाँड्दा A ले B भन्दा रु. 600 बढी पायो। A ले कति पायो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'रु. 3000 लाई A र B बीच बाँड्दा A ले B भन्दा रु. 600 बढी पायो। A ले कति पायो?', E'1600', E'2000', E'2200', E'1800', E'D', E'B = x, A = x + 600। 2x + 600 = 3000 => x = 1200। A = 1200 + 600 = 1800।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:रु. 3000 लाई A र B बीच बाँड्दा A ले B भन्दा रु. 600 बढी पायो। A ले कति पायो?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दुई लगातार बिजोर संख्याको गुणनफल 323 छ। सानो संख्या कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'दुई लगातार बिजोर संख्याको गुणनफल 323 छ। सानो संख्या कुन हो?', E'17', E'15', E'19', E'21', E'A', E'17 × 19 = 323। सानो संख्या 17 हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दुई लगातार बिजोर संख्याको गुणनफल 323 छ। सानो संख्या कुन हो?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पाइप 12 घण्टा र 24 घण्टामा भर्छन्। सँगै खोल्दा कति घण्टा लाग्ला?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'पाइप 12 घण्टा र 24 घण्टामा भर्छन्। सँगै खोल्दा कति घण्टा लाग्ला?', E'6', E'8', E'10', E'12', E'B', E'(12 × 24) / 36 = 8 घण्टा।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पाइप 12 घण्टा र 24 घण्टामा भर्छन्। सँगै खोल्दा कति घण्टा लाग्ला?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'बुवा र छोराको हालको उमेरको अनुपात 3:1 छ। 10 वर्षपछि उनीहरूको उमेरको योगफल 80 हुनेछ। बुवाको हालको उमेर कति?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'बुवा र छोराको हालको उमेरको अनुपात 3:1 छ। 10 वर्षपछि उनीहरूको उमेरको योगफल 80 हुनेछ। बुवाको हालको उमेर कति?', E'30', E'40', E'45', E'50', E'C', E'हालको योगफल = 80 - 20 = 60। 3x + x = 60 => 4x = 60 => x = 15। बुवा = 3 × 15 = 45 वर्ष।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:बुवा र छोराको हालको उमेरको अनुपात 3:1 छ। 10 वर्षपछि उनीहरूको उमेरको योगफल 80 हुनेछ। बुवाको हालको उमेर कति?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै संख्याको 4/5 भाग 80 हुन्छ भने सो संख्याको 1/4 कति होला?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'कुनै संख्याको 4/5 भाग 80 हुन्छ भने सो संख्याको 1/4 कति होला?', E'20', E'30', E'35', E'25', E'D', E'संख्या = 80 × 5/4 = 100। 100 को 1/4 = 25।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै संख्याको 4/5 भाग 80 हुन्छ भने सो संख्याको 1/4 कति होला?'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'300 मिटर लामो ट्रेनले 20 सेकेन्डमा पोल पार गर्छ। गति कति km/hr?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'300 मिटर लामो ट्रेनले 20 सेकेन्डमा पोल पार गर्छ। गति कति km/hr?', E'54', E'45', E'60', E'72', E'A', E'गति = 300/20 = 15 m/s। 15 × 18/5 = 54 km/hr।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:300 मिटर लामो ट्रेनले 20 सेकेन्डमा पोल पार गर्छ। गति कति km/hr?'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'0, 3, 8, 15, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'0, 3, 8, 15, ?', E'20', E'24', E'22', E'26', E'B', E'संख्या n² - 1 हुन्। 1²-1=0, 2²-1=3, 3²-1=8, 4²-1=15। अर्को 5²-1 = 24।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:0, 3, 8, 15, ?'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'खोरमा 60 टाउको र 170 खुट्टा छन् भने कुखुरा कति?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'खोरमा 60 टाउको र 170 खुट्टा छन् भने कुखुरा कति?', E'20', E'25', E'35', E'30', E'C', E'4x + 2y = 170 र x + y = 60। हल गर्दा x = 25 (गाई) र y = 35 (कुखुरा)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:खोरमा 60 टाउको र 170 खुट्टा छन् भने कुखुरा कति?'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'8 जनाले हात मिलाउँदा कति पटक हात मिलाइन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 20, E'8 जनाले हात मिलाउँदा कति पटक हात मिलाइन्छ?', E'24', E'32', E'36', E'28', E'D', E'(8 × 7) / 2 = 28 पटक।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:8 जनाले हात मिलाउँदा कति पटक हात मिलाइन्छ?'), v_set_id, v_q_id, 20)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दुई संख्याको योग 150 र फरक 50 छ। ठूलो संख्या कुन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 21, E'दुई संख्याको योग 150 र फरक 50 छ। ठूलो संख्या कुन?', E'100', E'90', E'110', E'120', E'A', E'(150 + 50) / 2 = 100।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दुई संख्याको योग 150 र फरक 50 छ। ठूलो संख्या कुन?'), v_set_id, v_q_id, 21)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'10 टुक्रा बनाउन 45 मिनेट लाग्छ भने 12 टुक्रा बनाउन कति समय लाग्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 22, E'10 टुक्रा बनाउन 45 मिनेट लाग्छ भने 12 टुक्रा बनाउन कति समय लाग्छ?', E'50', E'55', E'60', E'65', E'B', E'9 पटक काट्न 45 मिनेट (1 पटकको 5 मिनेट)। 11 पटक काट्न 11 × 5 = 55 मिनेट।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:10 टुक्रा बनाउन 45 मिनेट लाग्छ भने 12 टुक्रा बनाउन कति समय लाग्छ?'), v_set_id, v_q_id, 22)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'40 मिटर खम्बामा बाँदर 6 मिटर चढ्छ, 2 मिटर झर्छ। कति समय लाग्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 23, E'40 मिटर खम्बामा बाँदर 6 मिटर चढ्छ, 2 मिटर झर्छ। कति समय लाग्छ?', E'17', E'18', E'19', E'20', E'C', E'2 मिनेटमा 4 मिटर। (40-6)/4 = 34/4 = 8.5 अर्थात् 9 चक्र (18 मिनेट)। 18 मिनेटमा 36 मिटर पुग्छ। 19 औं मिनेटमा 36+6=42 मिटर। तसर्थ 19 मिनेट।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:40 मिटर खम्बामा बाँदर 6 मिटर चढ्छ, 2 मिटर झर्छ। कति समय लाग्छ?'), v_set_id, v_q_id, 23)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'A ले 8 दिन र B ले 24 दिनमा काम सक्छन्। सँगै गर्दा कति दिन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 24, E'A ले 8 दिन र B ले 24 दिनमा काम सक्छन्। सँगै गर्दा कति दिन?', E'4', E'5', E'7', E'6', E'D', E'(8 × 24) / 32 = 6 दिन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:A ले 8 दिन र B ले 24 दिनमा काम सक्छन्। सँगै गर्दा कति दिन?'), v_set_id, v_q_id, 24)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'25 वर्षमा दोब्बर हुन ब्याजदर कति चाहिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 25, E'25 वर्षमा दोब्बर हुन ब्याजदर कति चाहिन्छ?', E'4%', E'2%', E'3%', E'5%', E'A', E'100 / 25 = 4%।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:25 वर्षमा दोब्बर हुन ब्याजदर कति चाहिन्छ?'), v_set_id, v_q_id, 25)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पास हुन 35% चाहिन्छ। 105 अंक ल्याउने विद्यार्थी पास भयो भने पूर्णांक कति? (ठीक पास मात्र भयो भने)');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 26, E'पास हुन 35% चाहिन्छ। 105 अंक ल्याउने विद्यार्थी पास भयो भने पूर्णांक कति? (ठीक पास मात्र भयो भने)', E'250', E'300', E'350', E'400', E'B', E'पूर्णांक = (105 × 100) / 35 = 300।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पास हुन 35% चाहिन्छ। 105 अंक ल्याउने विद्यार्थी पास भयो भने पूर्णांक कति? (ठीक पास मात्र भयो भने)'), v_set_id, v_q_id, 26)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'रु. 4000 लाई A र B बीच बाँड्दा A ले B भन्दा रु. 1000 कम पायो। A ले कति पायो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 27, E'रु. 4000 लाई A र B बीच बाँड्दा A ले B भन्दा रु. 1000 कम पायो। A ले कति पायो?', E'1000', E'2000', E'1500', E'2500', E'C', E'A + B = 4000, B - A = 1000। 2A = 3000 => A = 1500।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:रु. 4000 लाई A र B बीच बाँड्दा A ले B भन्दा रु. 1000 कम पायो। A ले कति पायो?'), v_set_id, v_q_id, 27)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दुई लगातार जोर संख्याको गुणनफल 80 छ। ठूलो संख्या कुन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 28, E'दुई लगातार जोर संख्याको गुणनफल 80 छ। ठूलो संख्या कुन?', E'8', E'12', E'14', E'10', E'D', E'8 × 10 = 80। ठूलो 10 हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दुई लगातार जोर संख्याको गुणनफल 80 छ। ठूलो संख्या कुन?'), v_set_id, v_q_id, 28)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'20 र 30 घण्टामा ट्यांकी भर्ने पाइपहरू सँगै खोल्दा कति घण्टा लाग्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 29, E'20 र 30 घण्टामा ट्यांकी भर्ने पाइपहरू सँगै खोल्दा कति घण्टा लाग्छ?', E'12', E'10', E'15', E'18', E'A', E'(20 × 30) / 50 = 12 घण्टा।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:20 र 30 घण्टामा ट्यांकी भर्ने पाइपहरू सँगै खोल्दा कति घण्टा लाग्छ?'), v_set_id, v_q_id, 29)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'हाल बुवा र छोराको उमेरको योग 70 छ। 5 वर्ष अघि उनीहरूको उमेरको योगफल कति थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 30, E'हाल बुवा र छोराको उमेरको योग 70 छ। 5 वर्ष अघि उनीहरूको उमेरको योगफल कति थियो?', E'55', E'60', E'65', E'70', E'B', E'दुवैको 5-5 वर्ष घट्दा, 70 - 10 = 60 वर्ष।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:हाल बुवा र छोराको उमेरको योग 70 छ। 5 वर्ष अघि उनीहरूको उमेरको योगफल कति थियो?'), v_set_id, v_q_id, 30)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: गणितीय क्षमताः गणितीय पजलहरू - खण्ड 4 (आधारभूत तह) (28 Q)
  v_set_id := extensions.uuid_generate_v5('8b41dcb1-7155-4d8d-9f86-9764a3ff8f79'::uuid, E'गणितीय क्षमताः गणितीय पजलहरू - खण्ड 4 (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'db9d9515-ced5-4a90-a4ac-3a8927342e98'::uuid, '8b41dcb1-7155-4d8d-9f86-9764a3ff8f79'::uuid, E'गणितीय क्षमताः गणितीय पजलहरू - खण्ड 4 (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '8b41dcb1-7155-4d8d-9f86-9764a3ff8f79'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै संख्याको 5/6 भाग 100 हुन्छ भने सो संख्याको 1/2 कति होला?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'कुनै संख्याको 5/6 भाग 100 हुन्छ भने सो संख्याको 1/2 कति होला?', E'60', E'40', E'50', E'70', E'A', E'संख्या = 100 × 6/5 = 120। 120 को 1/2 = 60।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै संख्याको 5/6 भाग 100 हुन्छ भने सो संख्याको 1/2 कति होला?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'180 मिटर ट्रेनले 12 सेकेन्डमा पोल पार गर्छ। गति कति km/hr?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'180 मिटर ट्रेनले 12 सेकेन्डमा पोल पार गर्छ। गति कति km/hr?', E'45', E'54', E'60', E'72', E'B', E'गति = 180/12 = 15 m/s। 15 × 18/5 = 54 km/hr।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:180 मिटर ट्रेनले 12 सेकेन्डमा पोल पार गर्छ। गति कति km/hr?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'2, 6, 12, 20, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'2, 6, 12, 20, ?', E'24', E'28', E'30', E'32', E'C', E'संख्याहरू n² + n हुन् (1²+1=2, 2²+2=6, 3²+3=12, 4²+4=20)। अर्को 5²+5 = 30।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:2, 6, 12, 20, ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'25 टाउको र 80 खुट्टा भए गाई कति?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'25 टाउको र 80 खुट्टा भए गाई कति?', E'10', E'12', E'20', E'15', E'D', E'4x + 2(25-x) = 80 => 2x = 30 => x = 15।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:25 टाउको र 80 खुट्टा भए गाई कति?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'25 जनाले हात मिलाउँदा कति पटक?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'25 जनाले हात मिलाउँदा कति पटक?', E'300', E'280', E'320', E'350', E'A', E'(25 × 24) / 2 = 300।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:25 जनाले हात मिलाउँदा कति पटक?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'योग 200, फरक 60। सानो संख्या कुन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'योग 200, फरक 60। सानो संख्या कुन?', E'60', E'70', E'80', E'90', E'B', E'(200 - 60) / 2 = 70।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:योग 200, फरक 60। सानो संख्या कुन?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'11 टुक्रा बनाउन 40 मिनेट, 16 टुक्रा बनाउन कति समय?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'11 टुक्रा बनाउन 40 मिनेट, 16 टुक्रा बनाउन कति समय?', E'50', E'55', E'60', E'65', E'C', E'10 पटक काट्न 40 मिनेट (प्रति पटक 4 मिनेट)। 15 पटक काट्न 15 × 4 = 60 मिनेट।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:11 टुक्रा बनाउन 40 मिनेट, 16 टुक्रा बनाउन कति समय?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'35 मिटर खम्बामा 5 मिटर चढ्छ 2 मिटर झर्छ। कति समय लाग्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'35 मिटर खम्बामा 5 मिटर चढ्छ 2 मिटर झर्छ। कति समय लाग्छ?', E'20', E'22', E'23', E'21', E'D', E'2 मिनेटमा 3 मिटर। (35-5)/3 = 10 चक्र (20 मिनेट)। 20 मिनेटमा 30 मिटर पुग्छ। 21 औं मिनेटमा 35 मिटर (टुप्पो)। त्यसैले 21 मिनेट।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:35 मिटर खम्बामा 5 मिटर चढ्छ 2 मिटर झर्छ। कति समय लाग्छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'A ले 10 दिन र B ले 40 दिनमा काम गर्छन्। सँगै कति दिन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'A ले 10 दिन र B ले 40 दिनमा काम गर्छन्। सँगै कति दिन?', E'8', E'5', E'6', E'10', E'A', E'(10 × 40) / 50 = 8 दिन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:A ले 10 दिन र B ले 40 दिनमा काम गर्छन्। सँगै कति दिन?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'रकम 4 वर्षमा दोब्बर हुन ब्याजदर कति?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'रकम 4 वर्षमा दोब्बर हुन ब्याजदर कति?', E'20%', E'25%', E'22.5%', E'30%', E'B', E'100 / 4 = 25%।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:रकम 4 वर्षमा दोब्बर हुन ब्याजदर कति?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'40% ले पास हुन्छ। 200 अंक ल्याउँदा 40 ले फेल भयो। पूर्णांक कति?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'40% ले पास हुन्छ। 200 अंक ल्याउँदा 40 ले फेल भयो। पूर्णांक कति?', E'500', E'700', E'600', E'800', E'C', E'पास अंक = 240। पूर्णांक = (240 × 100) / 40 = 600।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:40% ले पास हुन्छ। 200 अंक ल्याउँदा 40 ले फेल भयो। पूर्णांक कति?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'5000 लाई A र B मा बाँड्दा A ले B भन्दा 1000 बढी पायो। B ले कति पायो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'5000 लाई A र B मा बाँड्दा A ले B भन्दा 1000 बढी पायो। B ले कति पायो?', E'1500', E'2500', E'3000', E'2000', E'D', E'2B + 1000 = 5000 => 2B = 4000 => B = 2000।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:5000 लाई A र B मा बाँड्दा A ले B भन्दा 1000 बढी पायो। B ले कति पायो?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दुई लगातार बिजोर संख्याको गुणनफल 63 छ। ठूलो संख्या कुन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'दुई लगातार बिजोर संख्याको गुणनफल 63 छ। ठूलो संख्या कुन?', E'9', E'7', E'11', E'13', E'A', E'7 × 9 = 63। ठूलो 9 हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दुई लगातार बिजोर संख्याको गुणनफल 63 छ। ठूलो संख्या कुन?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'6 र 12 घण्टामा ट्यांकी भर्ने पाइप सँगै खोल्दा कति घण्टा?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'6 र 12 घण्टामा ट्यांकी भर्ने पाइप सँगै खोल्दा कति घण्टा?', E'3', E'4', E'5', E'6', E'B', E'(6 × 12) / 18 = 4 घण्टा।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:6 र 12 घण्टामा ट्यांकी भर्ने पाइप सँगै खोल्दा कति घण्टा?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'बुवाको उमेर छोराको भन्दा 3 गुणा छ। उनीहरूको योगफल 48 छ। छोराको उमेर कति?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'बुवाको उमेर छोराको भन्दा 3 गुणा छ। उनीहरूको योगफल 48 छ। छोराको उमेर कति?', E'10', E'14', E'12', E'16', E'C', E'x + 3x = 48 => 4x = 48 => x = 12।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:बुवाको उमेर छोराको भन्दा 3 गुणा छ। उनीहरूको योगफल 48 छ। छोराको उमेर कति?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'संख्याको 2/5 भाग 40 हुन्छ भने 3/5 कति होला?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'संख्याको 2/5 भाग 40 हुन्छ भने 3/5 कति होला?', E'50', E'70', E'80', E'60', E'D', E'संख्या = 40 × 5/2 = 100। 100 को 3/5 = 60।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:संख्याको 2/5 भाग 40 हुन्छ भने 3/5 कति होला?'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'100 मिटर ट्रेनले 5 सेकेन्डमा पोल पार गर्छ। गति कति km/hr?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'100 मिटर ट्रेनले 5 सेकेन्डमा पोल पार गर्छ। गति कति km/hr?', E'72', E'54', E'60', E'90', E'A', E'गति = 100/5 = 20 m/s। 20 × 18/5 = 72 km/hr।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:100 मिटर ट्रेनले 5 सेकेन्डमा पोल पार गर्छ। गति कति km/hr?'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'5, 10, 20, 40, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'5, 10, 20, 40, ?', E'60', E'80', E'70', E'100', E'B', E'प्रत्येक संख्या दोब्बर हुँदैछ। 40 × 2 = 80।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:5, 10, 20, 40, ?'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'35 टाउको र 110 खुट्टा भए गाई कति?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'35 टाउको र 110 खुट्टा भए गाई कति?', E'15', E'25', E'20', E'30', E'C', E'4x + 2(35-x) = 110 => 2x = 40 => x = 20।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:35 टाउको र 110 खुट्टा भए गाई कति?'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'5 जनाले हात मिलाउँदा कति पटक?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 20, E'5 जनाले हात मिलाउँदा कति पटक?', E'15', E'20', E'25', E'10', E'D', E'(5 × 4) / 2 = 10।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:5 जनाले हात मिलाउँदा कति पटक?'), v_set_id, v_q_id, 20)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'योग 300, फरक 100। सानो संख्या कुन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 21, E'योग 300, फरक 100। सानो संख्या कुन?', E'100', E'50', E'150', E'200', E'A', E'(300 - 100) / 2 = 100।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:योग 300, फरक 100। सानो संख्या कुन?'), v_set_id, v_q_id, 21)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'5 टुक्रा बनाउन 16 मिनेट, 10 टुक्रा बनाउन कति समय?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 22, E'5 टुक्रा बनाउन 16 मिनेट, 10 टुक्रा बनाउन कति समय?', E'32', E'36', E'40', E'45', E'B', E'4 पटक काट्न 16 मिनेट (प्रति पटक 4 मिनेट)। 9 पटक काट्न 9 × 4 = 36 मिनेट।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:5 टुक्रा बनाउन 16 मिनेट, 10 टुक्रा बनाउन कति समय?'), v_set_id, v_q_id, 22)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'25 मिटर खम्बामा 4 मिटर चढ्छ 1 मिटर झर्छ। समय कति?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 23, E'25 मिटर खम्बामा 4 मिटर चढ्छ 1 मिटर झर्छ। समय कति?', E'14', E'16', E'15', E'17', E'C', E'2 मिनेटमा 3 मिटर। (25-4)/3 = 7 चक्र (14 मिनेट)। 14 मिनेटमा 21 मिटर। 15 औं मिनेटमा 21+4=25 मिटर (टुप्पो)। 15 मिनेट।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:25 मिटर खम्बामा 4 मिटर चढ्छ 1 मिटर झर्छ। समय कति?'), v_set_id, v_q_id, 23)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'A ले 15 दिन र B ले 10 दिनमा काम गर्छन्। सँगै कति दिन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 24, E'A ले 15 दिन र B ले 10 दिनमा काम गर्छन्। सँगै कति दिन?', E'5', E'7', E'8', E'6', E'D', E'(15 × 10) / 25 = 6 दिन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:A ले 15 दिन र B ले 10 दिनमा काम गर्छन्। सँगै कति दिन?'), v_set_id, v_q_id, 24)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'रकम 10 वर्षमा दोब्बर हुन ब्याजदर कति?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 25, E'रकम 10 वर्षमा दोब्बर हुन ब्याजदर कति?', E'10%', E'8%', E'12%', E'15%', E'A', E'100 / 10 = 10%।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:रकम 10 वर्षमा दोब्बर हुन ब्याजदर कति?'), v_set_id, v_q_id, 25)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पास हुन 50% चाहिन्छ। 150 अंक ल्याउँदा 50 ले फेल भयो। पूर्णांक कति?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 26, E'पास हुन 50% चाहिन्छ। 150 अंक ल्याउँदा 50 ले फेल भयो। पूर्णांक कति?', E'300', E'400', E'350', E'450', E'B', E'पास अंक = 200। पूर्णांक = (200 × 100) / 50 = 400।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पास हुन 50% चाहिन्छ। 150 अंक ल्याउँदा 50 ले फेल भयो। पूर्णांक कति?'), v_set_id, v_q_id, 26)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'6000 लाई A र B मा बाँड्दा A ले B भन्दा 2000 बढी पायो। A ले कति पायो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 27, E'6000 लाई A र B मा बाँड्दा A ले B भन्दा 2000 बढी पायो। A ले कति पायो?', E'3000', E'3500', E'4000', E'4500', E'C', E'2B + 2000 = 6000 => 2B = 4000 => B = 2000। A = 2000 + 2000 = 4000।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:6000 लाई A र B मा बाँड्दा A ले B भन्दा 2000 बढी पायो। A ले कति पायो?'), v_set_id, v_q_id, 27)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'7, 14, 21, 28, ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 28, E'7, 14, 21, 28, ?', E'32', E'34', E'36', E'35', E'D', E'यो 7 को गुणन तालिका (multiples) हो। अर्को पद 35 हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:7, 14, 21, 28, ?'), v_set_id, v_q_id, 28)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: स्थानिक तथा प्रत्यक्षात्मक क्षमताः Coding-Decoding - खण्ड 2 (आधारभूत तह) (30 Q)
  v_set_id := extensions.uuid_generate_v5('83123770-9e69-4d49-b231-b112c95d2692'::uuid, E'स्थानिक तथा प्रत्यक्षात्मक क्षमताः Coding-Decoding - खण्ड 2 (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '69c87a98-20d9-4fd7-a596-37eaa6fdc55b'::uuid, '83123770-9e69-4d49-b231-b112c95d2692'::uuid, E'स्थानिक तथा प्रत्यक्षात्मक क्षमताः Coding-Decoding - खण्ड 2 (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '83123770-9e69-4d49-b231-b112c95d2692'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि कुनै कोड भाषामा ''BROTHER'' लाई ''REHTORB'' लेखिन्छ भने, ''SISTER'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'यदि कुनै कोड भाषामा ''BROTHER'' लाई ''REHTORB'' लेखिन्छ भने, ''SISTER'' लाई के लेखिन्छ?', E'RETSIS', E'RESTIS', E'RETISS', E'RESIST', E'A', E'यहाँ शब्दका अक्षरहरूलाई उल्टो क्रम (Reverse order) मा लेखिएको छ। ''SISTER'' को उल्टो ''RETSIS'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि कुनै कोड भाषामा ''BROTHER'' लाई ''REHTORB'' लेखिन्छ भने, ''SISTER'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि कुनै कोड भाषामा ''SYSTEM'' लाई ''METSYS'' लेखिन्छ भने, ''PUBLIC'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'यदि कुनै कोड भाषामा ''SYSTEM'' लाई ''METSYS'' लेखिन्छ भने, ''PUBLIC'' लाई के लेखिन्छ?', E'CILBPU', E'CILBUP', E'CIBLUP', E'CLIBUP', E'B', E'यहाँ शब्दका अक्षरहरूलाई उल्टो क्रम (Reverse order) मा लेखिएको छ। ''PUBLIC'' को उल्टो ''CILBUP'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि कुनै कोड भाषामा ''SYSTEM'' लाई ''METSYS'' लेखिन्छ भने, ''PUBLIC'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि कुनै कोड भाषामा ''NATION'' लाई ''NOITAN'' लेखिन्छ भने, ''COUNTRY'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'यदि कुनै कोड भाषामा ''NATION'' लाई ''NOITAN'' लेखिन्छ भने, ''COUNTRY'' लाई के लेखिन्छ?', E'YRTNCOU', E'YRNTOUC', E'YRTNUOC', E'YTRNUOC', E'C', E'यहाँ शब्दका अक्षरहरूलाई उल्टो क्रम (Reverse order) मा लेखिएको छ। ''COUNTRY'' को उल्टो ''YRTNUOC'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि कुनै कोड भाषामा ''NATION'' लाई ''NOITAN'' लेखिन्छ भने, ''COUNTRY'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि कुनै कोड भाषामा ''PEOPLE'' लाई ''ELPOEP'' लेखिन्छ भने, ''PERSON'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'यदि कुनै कोड भाषामा ''PEOPLE'' लाई ''ELPOEP'' लेखिन्छ भने, ''PERSON'' लाई के लेखिन्छ?', E'NOSRPE', E'NSOREP', E'NSORPE', E'NOSREP', E'D', E'यहाँ शब्दका अक्षरहरूलाई उल्टो क्रम (Reverse order) मा लेखिएको छ। ''PERSON'' को उल्टो ''NOSREP'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि कुनै कोड भाषामा ''PEOPLE'' लाई ''ELPOEP'' लेखिन्छ भने, ''PERSON'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि कुनै कोड भाषामा ''ANIMAL'' लाई ''LAMINA'' लेखिन्छ भने, ''BIRD'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'यदि कुनै कोड भाषामा ''ANIMAL'' लाई ''LAMINA'' लेखिन्छ भने, ''BIRD'' लाई के लेखिन्छ?', E'DRIB', E'DRBI', E'DIBR', E'DBRI', E'A', E'यहाँ शब्दका अक्षरहरूलाई उल्टो क्रम (Reverse order) मा लेखिएको छ। ''BIRD'' को उल्टो ''DRIB'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि कुनै कोड भाषामा ''ANIMAL'' लाई ''LAMINA'' लेखिन्छ भने, ''BIRD'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि कुनै कोड भाषामा ''MARKET'' लाई ''TEKRAM'' लेखिन्छ भने, ''SHOP'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'यदि कुनै कोड भाषामा ''MARKET'' लाई ''TEKRAM'' लेखिन्छ भने, ''SHOP'' लाई के लेखिन्छ?', E'PHOS', E'POHS', E'PSHO', E'POSH', E'B', E'यहाँ शब्दका अक्षरहरूलाई उल्टो क्रम (Reverse order) मा लेखिएको छ। ''SHOP'' को उल्टो ''POHS'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि कुनै कोड भाषामा ''MARKET'' लाई ''TEKRAM'' लेखिन्छ भने, ''SHOP'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि कुनै कोड भाषामा ''SCHOOL'' लाई ''LOOHCS'' लेखिन्छ भने, ''COLLEGE'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'यदि कुनै कोड भाषामा ''SCHOOL'' लाई ''LOOHCS'' लेखिन्छ भने, ''COLLEGE'' लाई के लेखिन्छ?', E'EGLELOC', E'EEGLOLC', E'EGELLOC', E'EGELLCO', E'C', E'यहाँ शब्दका अक्षरहरूलाई उल्टो क्रम (Reverse order) मा लेखिएको छ। ''COLLEGE'' को उल्टो ''EGELLOC'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि कुनै कोड भाषामा ''SCHOOL'' लाई ''LOOHCS'' लेखिन्छ भने, ''COLLEGE'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि कुनै कोड भाषामा ''VILLAGE'' लाई ''EGALLIV'' लेखिन्छ भने, ''CITY'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'यदि कुनै कोड भाषामा ''VILLAGE'' लाई ''EGALLIV'' लेखिन्छ भने, ''CITY'' लाई के लेखिन्छ?', E'YITC', E'YCTI', E'YICT', E'YTIC', E'D', E'यहाँ शब्दका अक्षरहरूलाई उल्टो क्रम (Reverse order) मा लेखिएको छ। ''CITY'' को उल्टो ''YTIC'' हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि कुनै कोड भाषामा ''VILLAGE'' लाई ''EGALLIV'' लेखिन्छ भने, ''CITY'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि अङ्ग्रेजी वर्णमालामा A=1, B=2 ... Z=26 हुन्छ र ''CAT'' = 24 हुन्छ भने, ''DOG'' को मान कति हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'यदि अङ्ग्रेजी वर्णमालामा A=1, B=2 ... Z=26 हुन्छ र ''CAT'' = 24 हुन्छ भने, ''DOG'' को मान कति हुन्छ?', E'26', E'27', E'28', E'25', E'A', E'यहाँ शब्दमा भएका प्रत्येक अक्षरको अङ्ग्रेजी वर्णमालाको स्थान मान जोडेर कोड बनाइएको छ। (D=4, O=15, G=7; 4+15+7 = 26)', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि अङ्ग्रेजी वर्णमालामा A=1, B=2 ... Z=26 हुन्छ र ''CAT'' = 24 हुन्छ भने, ''DOG'' को मान कति हुन्छ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि अङ्ग्रेजी वर्णमालामा A=1, B=2 ... Z=26 हुन्छ र ''BAT'' = 23 हुन्छ भने, ''BALL'' को मान कति हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'यदि अङ्ग्रेजी वर्णमालामा A=1, B=2 ... Z=26 हुन्छ र ''BAT'' = 23 हुन्छ भने, ''BALL'' को मान कति हुन्छ?', E'28', E'27', E'29', E'30', E'B', E'(B=2, A=1, L=12, L=12; 2+1+12+12 = 27)', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि अङ्ग्रेजी वर्णमालामा A=1, B=2 ... Z=26 हुन्छ र ''BAT'' = 23 हुन्छ भने, ''BALL'' को मान कति हुन्छ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि अङ्ग्रेजी वर्णमालामा A=1, B=2 ... Z=26 हुन्छ र ''SUN'' = 54 हुन्छ भने, ''MOON'' को मान कति हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'यदि अङ्ग्रेजी वर्णमालामा A=1, B=2 ... Z=26 हुन्छ र ''SUN'' = 54 हुन्छ भने, ''MOON'' को मान कति हुन्छ?', E'58', E'59', E'57', E'60', E'C', E'(M=13, O=15, O=15, N=14; 13+15+15+14 = 57)', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि अङ्ग्रेजी वर्णमालामा A=1, B=2 ... Z=26 हुन्छ र ''SUN'' = 54 हुन्छ भने, ''MOON'' को मान कति हुन्छ?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि अङ्ग्रेजी वर्णमालामा A=1, B=2 ... Z=26 हुन्छ र ''CAR'' = 22 हुन्छ भने, ''BUS'' को मान कति हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'यदि अङ्ग्रेजी वर्णमालामा A=1, B=2 ... Z=26 हुन्छ र ''CAR'' = 22 हुन्छ भने, ''BUS'' को मान कति हुन्छ?', E'43', E'44', E'45', E'42', E'D', E'(B=2, U=21, S=19; 2+21+19 = 42)', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि अङ्ग्रेजी वर्णमालामा A=1, B=2 ... Z=26 हुन्छ र ''CAR'' = 22 हुन्छ भने, ''BUS'' को मान कति हुन्छ?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि अङ्ग्रेजी वर्णमालामा A=1, B=2 ... Z=26 हुन्छ र ''PEN'' = 35 हुन्छ भने, ''INK'' को मान कति हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'यदि अङ्ग्रेजी वर्णमालामा A=1, B=2 ... Z=26 हुन्छ र ''PEN'' = 35 हुन्छ भने, ''INK'' को मान कति हुन्छ?', E'34', E'35', E'36', E'37', E'A', E'(I=9, N=14, K=11; 9+14+11 = 34)', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि अङ्ग्रेजी वर्णमालामा A=1, B=2 ... Z=26 हुन्छ र ''PEN'' = 35 हुन्छ भने, ''INK'' को मान कति हुन्छ?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि अङ्ग्रेजी वर्णमालामा A=1, B=2 ... Z=26 हुन्छ र ''RED'' = 27 हुन्छ भने, ''BLUE'' को मान कति हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'यदि अङ्ग्रेजी वर्णमालामा A=1, B=2 ... Z=26 हुन्छ र ''RED'' = 27 हुन्छ भने, ''BLUE'' को मान कति हुन्छ?', E'41', E'40', E'42', E'43', E'B', E'(B=2, L=12, U=21, E=5; 2+12+21+5 = 40)', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि अङ्ग्रेजी वर्णमालामा A=1, B=2 ... Z=26 हुन्छ र ''RED'' = 27 हुन्छ भने, ''BLUE'' को मान कति हुन्छ?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि अङ्ग्रेजी वर्णमालामा A=1, B=2 ... Z=26 हुन्छ र ''MAN'' = 28 हुन्छ भने, ''WOMAN'' को मान कति हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'यदि अङ्ग्रेजी वर्णमालामा A=1, B=2 ... Z=26 हुन्छ र ''MAN'' = 28 हुन्छ भने, ''WOMAN'' को मान कति हुन्छ?', E'67', E'68', E'66', E'69', E'C', E'(W=23, O=15, M=13, A=1, N=14; 23+15+13+1+14 = 66)', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि अङ्ग्रेजी वर्णमालामा A=1, B=2 ... Z=26 हुन्छ र ''MAN'' = 28 हुन्छ भने, ''WOMAN'' को मान कति हुन्छ?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि अङ्ग्रेजी वर्णमालामा A=1, B=2 ... Z=26 हुन्छ र ''BOY'' = 42 हुन्छ भने, ''GIRL'' को मान कति हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'यदि अङ्ग्रेजी वर्णमालामा A=1, B=2 ... Z=26 हुन्छ र ''BOY'' = 42 हुन्छ भने, ''GIRL'' को मान कति हुन्छ?', E'47', E'48', E'49', E'46', E'D', E'(G=7, I=9, R=18, L=12; 7+9+18+12 = 46)', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि अङ्ग्रेजी वर्णमालामा A=1, B=2 ... Z=26 हुन्छ र ''BOY'' = 42 हुन्छ भने, ''GIRL'' को मान कति हुन्छ?'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि अङ्ग्रेजी वर्णमालामा A=1, B=2 ... Z=26 हुन्छ र ''HOT'' = 43 हुन्छ भने, ''COLD'' को मान कति हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'यदि अङ्ग्रेजी वर्णमालामा A=1, B=2 ... Z=26 हुन्छ र ''HOT'' = 43 हुन्छ भने, ''COLD'' को मान कति हुन्छ?', E'34', E'35', E'36', E'37', E'A', E'(C=3, O=15, L=12, D=4; 3+15+12+4 = 34)', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि अङ्ग्रेजी वर्णमालामा A=1, B=2 ... Z=26 हुन्छ र ''HOT'' = 43 हुन्छ भने, ''COLD'' को मान कति हुन्छ?'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि अङ्ग्रेजी वर्णमालामा A=1, B=2 ... Z=26 हुन्छ र ''DAY'' = 30 हुन्छ भने, ''NIGHT'' को मान कति हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'यदि अङ्ग्रेजी वर्णमालामा A=1, B=2 ... Z=26 हुन्छ र ''DAY'' = 30 हुन्छ भने, ''NIGHT'' को मान कति हुन्छ?', E'59', E'58', E'60', E'61', E'B', E'(N=14, I=9, G=7, H=8, T=20; 14+9+7+8+20 = 58)', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि अङ्ग्रेजी वर्णमालामा A=1, B=2 ... Z=26 हुन्छ र ''DAY'' = 30 हुन्छ भने, ''NIGHT'' को मान कति हुन्छ?'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि ''रातो'' लाई ''निलो'', ''निलो'' लाई ''पहेँलो'', ''पहेँलो'' लाई ''हरियो'', र ''हरियो'' लाई ''कालो'' भनिन्छ भने, सफा आकाशको रङ कस्तो हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'यदि ''रातो'' लाई ''निलो'', ''निलो'' लाई ''पहेँलो'', ''पहेँलो'' लाई ''हरियो'', र ''हरियो'' लाई ''कालो'' भनिन्छ भने, सफा आकाशको रङ कस्तो हुन्छ?', E'रातो', E'निलो', E'पहेँलो', E'हरियो', E'C', E'वास्तविक रूपमा सफा आकाशको रङ ''निलो'' हुन्छ, तर प्रश्नअनुसार ''निलो'' लाई ''पहेँलो'' भनिएको छ। त्यसैले सही उत्तर ''पहेँलो'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि ''रातो'' लाई ''निलो'', ''निलो'' लाई ''पहेँलो'', ''पहेँलो'' लाई ''हरियो'', र ''हरियो'' लाई ''कालो'' भनिन्छ भने, सफा आकाशको रङ कस्तो हुन्छ?'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि ''स्याउ'' लाई ''सुन्तला'', ''सुन्तला'' लाई ''केरा'', ''केरा'' लाई ''आँप'', र ''आँप'' लाई ''अम्बा'' भनिन्छ भने, बाँदरले कुन फल बढी मन पराउँछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 20, E'यदि ''स्याउ'' लाई ''सुन्तला'', ''सुन्तला'' लाई ''केरा'', ''केरा'' लाई ''आँप'', र ''आँप'' लाई ''अम्बा'' भनिन्छ भने, बाँदरले कुन फल बढी मन पराउँछ?', E'स्याउ', E'सुन्तला', E'केरा', E'आँप', E'D', E'वास्तविक रूपमा बाँदरले ''केरा'' मन पराउँछ, तर प्रश्नअनुसार ''केरा'' लाई ''आँप'' भनिएको छ। त्यसैले सही उत्तर ''आँप'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि ''स्याउ'' लाई ''सुन्तला'', ''सुन्तला'' लाई ''केरा'', ''केरा'' लाई ''आँप'', र ''आँप'' लाई ''अम्बा'' भनिन्छ भने, बाँदरले कुन फल बढी मन पराउँछ?'), v_set_id, v_q_id, 20)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि ''पानी'' लाई ''हावा'', ''हावा'' लाई ''माटो'', ''माटो'' लाई ''आगो'', र ''आगो'' लाई ''आकाश'' भनिन्छ भने, माछा कहाँ बस्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 21, E'यदि ''पानी'' लाई ''हावा'', ''हावा'' लाई ''माटो'', ''माटो'' लाई ''आगो'', र ''आगो'' लाई ''आकाश'' भनिन्छ भने, माछा कहाँ बस्छ?', E'हावा', E'पानी', E'माटो', E'आगो', E'A', E'वास्तविक रूपमा माछा ''पानी'' मा बस्छ, तर प्रश्नअनुसार ''पानी'' लाई ''हावा'' भनिएको छ। त्यसैले सही उत्तर ''हावा'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि ''पानी'' लाई ''हावा'', ''हावा'' लाई ''माटो'', ''माटो'' लाई ''आगो'', र ''आगो'' लाई ''आकाश'' भनिन्छ भने, माछा कहाँ बस्छ?'), v_set_id, v_q_id, 21)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि ''आँखा'' लाई ''कान'', ''कान'' लाई ''नाक'', ''नाक'' लाई ''मुख'', र ''मुख'' लाई ''हात'' भनिन्छ भने, हामीले सुन्नको लागि कुन अङ्ग प्रयोग गर्छौं?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 22, E'यदि ''आँखा'' लाई ''कान'', ''कान'' लाई ''नाक'', ''नाक'' लाई ''मुख'', र ''मुख'' लाई ''हात'' भनिन्छ भने, हामीले सुन्नको लागि कुन अङ्ग प्रयोग गर्छौं?', E'आँखा', E'नाक', E'कान', E'मुख', E'B', E'वास्तविक रूपमा हामीले सुन्न ''कान'' प्रयोग गर्छौं, तर प्रश्नअनुसार ''कान'' लाई ''नाक'' भनिएको छ। त्यसैले सही उत्तर ''नाक'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि ''आँखा'' लाई ''कान'', ''कान'' लाई ''नाक'', ''नाक'' लाई ''मुख'', र ''मुख'' लाई ''हात'' भनिन्छ भने, हामीले सुन्नको लागि कुन अङ्ग प्रयोग गर्छौं?'), v_set_id, v_q_id, 22)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि ''गाई'' लाई ''बाख्रा'', ''बाख्रा'' लाई ''भैँसी'', ''भैँसी'' लाई ''कुकुर'', र ''कुकुर'' लाई ''बिरालो'' भनिन्छ भने, घर कुरुवाको काम कुन जनावरले गर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 23, E'यदि ''गाई'' लाई ''बाख्रा'', ''बाख्रा'' लाई ''भैँसी'', ''भैँसी'' लाई ''कुकुर'', र ''कुकुर'' लाई ''बिरालो'' भनिन्छ भने, घर कुरुवाको काम कुन जनावरले गर्छ?', E'गाई', E'बाख्रा', E'बिरालो', E'कुकुर', E'C', E'वास्तविक रूपमा घर कुरुवाको काम ''कुकुर'' ले गर्छ, तर प्रश्नअनुसार ''कुकुर'' लाई ''बिरालो'' भनिएको छ। त्यसैले सही उत्तर ''बिरालो'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि ''गाई'' लाई ''बाख्रा'', ''बाख्रा'' लाई ''भैँसी'', ''भैँसी'' लाई ''कुकुर'', र ''कुकुर'' लाई ''बिरालो'' भनिन्छ भने, घर कुरुवाको काम कुन जनावरले गर्छ?'), v_set_id, v_q_id, 23)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि ''कालो'' लाई ''सेतो'', ''सेतो'' लाई ''रातो'', ''रातो'' लाई ''निलो'', र ''निलो'' लाई ''पहेँलो'' भनिन्छ भने, दूधको रङ कस्तो हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 24, E'यदि ''कालो'' लाई ''सेतो'', ''सेतो'' लाई ''रातो'', ''रातो'' लाई ''निलो'', र ''निलो'' लाई ''पहेँलो'' भनिन्छ भने, दूधको रङ कस्तो हुन्छ?', E'कालो', E'सेतो', E'निलो', E'रातो', E'D', E'वास्तविक रूपमा दूधको रङ ''सेतो'' हुन्छ, तर प्रश्नअनुसार ''सेतो'' लाई ''रातो'' भनिएको छ। त्यसैले सही उत्तर ''रातो'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि ''कालो'' लाई ''सेतो'', ''सेतो'' लाई ''रातो'', ''रातो'' लाई ''निलो'', र ''निलो'' लाई ''पहेँलो'' भनिन्छ भने, दूधको रङ कस्तो हुन्छ?'), v_set_id, v_q_id, 24)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि ''दिन'' लाई ''रात'', ''रात'' लाई ''साँझ'', ''साँझ'' लाई ''बिहान'', र ''बिहान'' लाई ''दिउँसो'' भनिन्छ भने, हामी साधारणतया कतिखेर सुत्छौं?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 25, E'यदि ''दिन'' लाई ''रात'', ''रात'' लाई ''साँझ'', ''साँझ'' लाई ''बिहान'', र ''बिहान'' लाई ''दिउँसो'' भनिन्छ भने, हामी साधारणतया कतिखेर सुत्छौं?', E'साँझ', E'दिन', E'रात', E'बिहान', E'A', E'वास्तविक रूपमा हामी ''रात'' मा सुत्छौं, तर प्रश्नअनुसार ''रात'' लाई ''साँझ'' भनिएको छ। त्यसैले सही उत्तर ''साँझ'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि ''दिन'' लाई ''रात'', ''रात'' लाई ''साँझ'', ''साँझ'' लाई ''बिहान'', र ''बिहान'' लाई ''दिउँसो'' भनिन्छ भने, हामी साधारणतया कतिखेर सुत्छौं?'), v_set_id, v_q_id, 25)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि ''कापी'' लाई ''कलम'', ''कलम'' लाई ''मसी'', ''मसी'' लाई ''झोला'', र ''झोला'' लाई ''किताब'' भनिन्छ भने, हामी केले लेख्छौं?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 26, E'यदि ''कापी'' लाई ''कलम'', ''कलम'' लाई ''मसी'', ''मसी'' लाई ''झोला'', र ''झोला'' लाई ''किताब'' भनिन्छ भने, हामी केले लेख्छौं?', E'कापी', E'मसी', E'कलम', E'झोला', E'B', E'वास्तविक रूपमा हामी ''कलम'' ले लेख्छौं, तर प्रश्नअनुसार ''कलम'' लाई ''मसी'' भनिएको छ। त्यसैले सही उत्तर ''मसी'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि ''कापी'' लाई ''कलम'', ''कलम'' लाई ''मसी'', ''मसी'' लाई ''झोला'', र ''झोला'' लाई ''किताब'' भनिन्छ भने, हामी केले लेख्छौं?'), v_set_id, v_q_id, 26)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि ''शिक्षक'' लाई ''विद्यार्थी'', ''विद्यार्थी'' लाई ''डाक्टर'', ''डाक्टर'' लाई ''नर्स'', र ''नर्स'' लाई ''प्रहरी'' भनिन्छ भने, बिरामीको उपचार कसले गर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 27, E'यदि ''शिक्षक'' लाई ''विद्यार्थी'', ''विद्यार्थी'' लाई ''डाक्टर'', ''डाक्टर'' लाई ''नर्स'', र ''नर्स'' लाई ''प्रहरी'' भनिन्छ भने, बिरामीको उपचार कसले गर्छ?', E'शिक्षक', E'विद्यार्थी', E'नर्स', E'डाक्टर', E'C', E'वास्तविक रूपमा बिरामीको उपचार ''डाक्टर'' ले गर्छ, तर प्रश्नअनुसार ''डाक्टर'' लाई ''नर्स'' भनिएको छ। त्यसैले सही उत्तर ''नर्स'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि ''शिक्षक'' लाई ''विद्यार्थी'', ''विद्यार्थी'' लाई ''डाक्टर'', ''डाक्टर'' लाई ''नर्स'', र ''नर्स'' लाई ''प्रहरी'' भनिन्छ भने, बिरामीको उपचार कसले गर्छ?'), v_set_id, v_q_id, 27)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि ''माटो'' लाई ''बाटो'', ''बाटो'' लाई ''पुल'', ''पुल'' लाई ''नदी'', र ''नदी'' लाई ''खोला'' भनिन्छ भने, गाडी कहाँ गुड्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 28, E'यदि ''माटो'' लाई ''बाटो'', ''बाटो'' लाई ''पुल'', ''पुल'' लाई ''नदी'', र ''नदी'' लाई ''खोला'' भनिन्छ भने, गाडी कहाँ गुड्छ?', E'माटो', E'बाटो', E'नदी', E'पुल', E'D', E'वास्तविक रूपमा गाडी ''बाटो'' मा गुड्छ, तर प्रश्नअनुसार ''बाटो'' लाई ''पुल'' भनिएको छ। त्यसैले सही उत्तर ''पुल'' हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि ''माटो'' लाई ''बाटो'', ''बाटो'' लाई ''पुल'', ''पुल'' लाई ''नदी'', र ''नदी'' लाई ''खोला'' भनिन्छ भने, गाडी कहाँ गुड्छ?'), v_set_id, v_q_id, 28)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि कुनै कोड भाषामा ''BOOK'' लाई ''CQPM'' लेखिन्छ भने, ''COPY'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 29, E'यदि कुनै कोड भाषामा ''BOOK'' लाई ''CQPM'' लेखिन्छ भने, ''COPY'' लाई के लेखिन्छ?', E'DQQA', E'DQQZ', E'DPQZ', E'DPQA', E'A', E'यहाँ पहिलो अक्षरलाई +1, दोस्रोलाई +2, तेस्रोलाई +1, चौथोलाई +2 गरिएको छ। C+1=D, O+2=Q, P+1=Q, Y+2=A.', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि कुनै कोड भाषामा ''BOOK'' लाई ''CQPM'' लेखिन्छ भने, ''COPY'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 29)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि कुनै कोड भाषामा ''DOG'' लाई ''EPH'' लेखिन्छ भने, ''CAT'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 30, E'यदि कुनै कोड भाषामा ''DOG'' लाई ''EPH'' लेखिन्छ भने, ''CAT'' लाई के लेखिन्छ?', E'EBU', E'DBU', E'DCV', E'DBV', E'B', E'यहाँ सबै अक्षरहरूलाई +1, +1, +1 गरिएको छ। CAT मा C+1=D, A+1=B, T+1=U (DBU).', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि कुनै कोड भाषामा ''DOG'' लाई ''EPH'' लेखिन्छ भने, ''CAT'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 30)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: स्थानिक तथा प्रत्यक्षात्मक क्षमताः Coding-Decoding - खण्ड 3 (आधारभूत तह) (30 Q)
  v_set_id := extensions.uuid_generate_v5('83123770-9e69-4d49-b231-b112c95d2692'::uuid, E'स्थानिक तथा प्रत्यक्षात्मक क्षमताः Coding-Decoding - खण्ड 3 (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '69c87a98-20d9-4fd7-a596-37eaa6fdc55b'::uuid, '83123770-9e69-4d49-b231-b112c95d2692'::uuid, E'स्थानिक तथा प्रत्यक्षात्मक क्षमताः Coding-Decoding - खण्ड 3 (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '83123770-9e69-4d49-b231-b112c95d2692'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि कुनै कोड भाषामा ''WATER'' लाई ''XCVGT'' लेखिन्छ भने, ''FIRE'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'यदि कुनै कोड भाषामा ''WATER'' लाई ''XCVGT'' लेखिन्छ भने, ''FIRE'' लाई के लेखिन्छ?', E'GKTG', E'GJTG', E'GKTH', E'GJTH', E'A', E'W(+1)=X, A(+2)=C, T(+2)=V, E(+2)=G, R(+2)=T. FIRE: F+1=G, I+2=K, R+2=T, E+2=G.', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि कुनै कोड भाषामा ''WATER'' लाई ''XCVGT'' लेखिन्छ भने, ''FIRE'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि कुनै कोड भाषामा ''NIGHT'' लाई ''OJHJU'' लेखिन्छ भने, ''LIGHT'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'यदि कुनै कोड भाषामा ''NIGHT'' लाई ''OJHJU'' लेखिन्छ भने, ''LIGHT'' लाई के लेखिन्छ?', E'MKIJU', E'MJHJU', E'MJIJU', E'MIHJU', E'B', E'N(+1)=O, I(+1)=J, G(+1)=H, H(+2)=J, T(+1)=U. LIGHT मा L+1=M, I+1=J, G+1=H, H+2=J, T+1=U.', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि कुनै कोड भाषामा ''NIGHT'' लाई ''OJHJU'' लेखिन्छ भने, ''LIGHT'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि ''APPLE'' लाई ''ELPPA'' लेखिन्छ भने, ''MANGO'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'यदि ''APPLE'' लाई ''ELPPA'' लेखिन्छ भने, ''MANGO'' लाई के लेखिन्छ?', E'OGMAN', E'ONGAM', E'OGNAM', E'OGNMA', E'C', E'यहाँ शब्दका अक्षरहरूलाई उल्टो क्रम (Reverse) मा राखिएको छ। MANGO को उल्टो OGNAM हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि ''APPLE'' लाई ''ELPPA'' लेखिन्छ भने, ''MANGO'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि ''BIRD'' लाई ''DRIB'' लेखिन्छ भने, ''ANIMAL'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'यदि ''BIRD'' लाई ''DRIB'' लेखिन्छ भने, ''ANIMAL'' लाई के लेखिन्छ?', E'LAMANI', E'LMINAA', E'LANIMA', E'LAMINA', E'D', E'शब्दका अक्षरहरूलाई उल्टो क्रममा राखिएको छ। ANIMAL को उल्टो LAMINA हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि ''BIRD'' लाई ''DRIB'' लेखिन्छ भने, ''ANIMAL'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि कुनै कोडमा ''TIGER'' लाई ''REGIT'' लेखिन्छ भने, ''LION'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'यदि कुनै कोडमा ''TIGER'' लाई ''REGIT'' लेखिन्छ भने, ''LION'' लाई के लेखिन्छ?', E'NOIL', E'NOLI', E'NLOI', E'NIOL', E'A', E'अक्षरहरूलाई उल्टो क्रममा राखिएको छ। LION को उल्टो NOIL हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि कुनै कोडमा ''TIGER'' लाई ''REGIT'' लेखिन्छ भने, ''LION'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि ''FLOWER'' लाई ''REWOLF'' लेखिन्छ भने, ''LEAF'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'यदि ''FLOWER'' लाई ''REWOLF'' लेखिन्छ भने, ''LEAF'' लाई के लेखिन्छ?', E'FEAL', E'FAEL', E'FALE', E'FELA', E'B', E'अक्षरहरूलाई उल्टो क्रममा राखिएको छ। LEAF को उल्टो FAEL हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि ''FLOWER'' लाई ''REWOLF'' लेखिन्छ भने, ''LEAF'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि ''COMPUTER'' लाई ''RETUPMOC'' लेखिन्छ भने, ''MOBILE'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'यदि ''COMPUTER'' लाई ''RETUPMOC'' लेखिन्छ भने, ''MOBILE'' लाई के लेखिन्छ?', E'ELBIOM', E'ELIOBM', E'ELIBOM', E'ELIBMO', E'C', E'अक्षरहरूलाई उल्टो क्रममा राखिएको छ। MOBILE को उल्टो ELIBOM हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि ''COMPUTER'' लाई ''RETUPMOC'' लेखिन्छ भने, ''MOBILE'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि ''FRIEND'' लाई ''DNEIRF'' लेखिन्छ भने, ''ENEMY'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'यदि ''FRIEND'' लाई ''DNEIRF'' लेखिन्छ भने, ''ENEMY'' लाई के लेखिन्छ?', E'YNEME', E'YMEEN', E'YNEEM', E'YMENE', E'D', E'अक्षरहरूलाई उल्टो क्रममा राखिएको छ। ENEMY को उल्टो YMENE हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि ''FRIEND'' लाई ''DNEIRF'' लेखिन्छ भने, ''ENEMY'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि ''FATHER'' लाई ''REHTAF'' लेखिन्छ भने, ''MOTHER'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'यदि ''FATHER'' लाई ''REHTAF'' लेखिन्छ भने, ''MOTHER'' लाई के लेखिन्छ?', E'REHTOM', E'REHMOT', E'REHTMO', E'REHTAM', E'A', E'अक्षरहरूलाई उल्टो क्रममा राखिएको छ। MOTHER को उल्टो REHTOM हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि ''FATHER'' लाई ''REHTAF'' लेखिन्छ भने, ''MOTHER'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि ''SUMMER'' लाई ''REMMUS'' लेखिन्छ भने, ''WINTER'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'यदि ''SUMMER'' लाई ''REMMUS'' लेखिन्छ भने, ''WINTER'' लाई के लेखिन्छ?', E'RETINW', E'RETNIW', E'RENITW', E'RENTIW', E'B', E'अक्षरहरूलाई उल्टो क्रममा राखिएको छ। WINTER को उल्टो RETNIW हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि ''SUMMER'' लाई ''REMMUS'' लेखिन्छ भने, ''WINTER'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि ''MORNING'' लाई ''GNINROM'' लेखिन्छ भने, ''EVENING'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'यदि ''MORNING'' लाई ''GNINROM'' लेखिन्छ भने, ''EVENING'' लाई के लेखिन्छ?', E'GNINEEV', E'GNINVE', E'GNINEVE', E'GNIENVE', E'C', E'अक्षरहरूलाई उल्टो क्रममा राखिएको छ। EVENING को उल्टो GNINEVE हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि ''MORNING'' लाई ''GNINROM'' लेखिन्छ भने, ''EVENING'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि ''NEPAL'' लाई ''LAPEN'' लेखिन्छ भने, ''BHUTAN'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'यदि ''NEPAL'' लाई ''LAPEN'' लेखिन्छ भने, ''BHUTAN'' लाई के लेखिन्छ?', E'NATUH', E'NATHUB', E'NTAUHB', E'NATUHB', E'D', E'अक्षरहरूलाई उल्टो क्रममा राखिएको छ। BHUTAN को उल्टो NATUHB हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि ''NEPAL'' लाई ''LAPEN'' लेखिन्छ भने, ''BHUTAN'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि A=2, B=4, C=6 हुन्छ भने, ''CAT'' को मान कति हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'यदि A=2, B=4, C=6 हुन्छ भने, ''CAT'' को मान कति हुन्छ?', E'48', E'46', E'44', E'50', E'A', E'C=6, A=2, T=40 (20*2). जम्मा = 6+2+40 = 48.', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि A=2, B=4, C=6 हुन्छ भने, ''CAT'' को मान कति हुन्छ?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि A=2, B=4, C=6 हुन्छ भने, ''DOG'' को मान कति हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'यदि A=2, B=4, C=6 हुन्छ भने, ''DOG'' को मान कति हुन्छ?', E'54', E'52', E'56', E'50', E'B', E'D=8, O=30, G=14. जम्मा = 8+30+14 = 52.', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि A=2, B=4, C=6 हुन्छ भने, ''DOG'' को मान कति हुन्छ?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि Z=26, Y=25, X=24 हुन्छ भने, ''BOY'' को मान कति हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'यदि Z=26, Y=25, X=24 हुन्छ भने, ''BOY'' को मान कति हुन्छ?', E'43', E'44', E'42', E'45', E'C', E'सामान्य स्थान मान। B=2, O=15, Y=25. जम्मा = 2+15+25 = 42.', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि Z=26, Y=25, X=24 हुन्छ भने, ''BOY'' को मान कति हुन्छ?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि Z=1, Y=2, X=3 हुन्छ भने (उल्टो क्रम), ''ABC'' को मान कति हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'यदि Z=1, Y=2, X=3 हुन्छ भने (उल्टो क्रम), ''ABC'' को मान कति हुन्छ?', E'76', E'77', E'78', E'75', E'D', E'उल्टो क्रममा A=26, B=25, C=24. जम्मा = 26+25+24 = 75.', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि Z=1, Y=2, X=3 हुन्छ भने (उल्टो क्रम), ''ABC'' को मान कति हुन्छ?'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि कुनै कोड भाषामा ''DESK'' लाई ''FDUM'' लेखिन्छ भने, ''CHAIR'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'यदि कुनै कोड भाषामा ''DESK'' लाई ''FDUM'' लेखिन्छ भने, ''CHAIR'' लाई के लेखिन्छ?', E'EJCKS', E'EJCKU', E'EJDKT', E'EKDKU', E'A', E'सबै अक्षरलाई +2 गरिएको छ। CHAIR मा C+2=E, H+2=J, A+2=C, I+2=K, R+2=T -> EJCKS.', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि कुनै कोड भाषामा ''DESK'' लाई ''FDUM'' लेखिन्छ भने, ''CHAIR'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि ''ROSE'' लाई ''6821'' र ''CHAIR'' लाई ''73456'' लेखिन्छ भने, ''SEARCH'' लाई कसरी लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'यदि ''ROSE'' लाई ''6821'' र ''CHAIR'' लाई ''73456'' लेखिन्छ भने, ''SEARCH'' लाई कसरी लेखिन्छ?', E'214763', E'214673', E'214637', E'214736', E'B', E'R=6, O=8, S=2, E=1, C=7, H=3, A=4, I=5, R=6. S=2, E=1, A=4, R=6, C=7, H=3 -> 214673.', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि ''ROSE'' लाई ''6821'' र ''CHAIR'' लाई ''73456'' लेखिन्छ भने, ''SEARCH'' लाई कसरी लेखिन्छ?'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि ''DEAL'' लाई ''4-5-1-12'' लेखिन्छ भने, ''LADY'' लाई कसरी लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'यदि ''DEAL'' लाई ''4-5-1-12'' लेखिन्छ भने, ''LADY'' लाई कसरी लेखिन्छ?', E'12-1-4-24', E'12-1-3-25', E'12-1-4-25', E'12-1-5-25', E'C', E'यहाँ अक्षरहरूको अङ्ग्रेजी वर्णमालाको स्थानलाई अङ्कमा लेखिएको छ। L=12, A=1, D=4, Y=25.', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि ''DEAL'' लाई ''4-5-1-12'' लेखिन्छ भने, ''LADY'' लाई कसरी लेखिन्छ?'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि ''APPLE'' लाई 50 र ''ORANGE'' लाई 60 लेखिन्छ भने, ''MANGO'' लाई कति लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 20, E'यदि ''APPLE'' लाई 50 र ''ORANGE'' लाई 60 लेखिन्छ भने, ''MANGO'' लाई कति लेखिन्छ?', E'48', E'52', E'54', E'50', E'D', E'M=13, A=1, N=14, G=7, O=15. जम्मा = 13+1+14+7+15 = 50.', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि ''APPLE'' लाई 50 र ''ORANGE'' लाई 60 लेखिन्छ भने, ''MANGO'' लाई कति लेखिन्छ?'), v_set_id, v_q_id, 20)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि ''MILK'' लाई ''N J M L'' लेखिन्छ भने, ''WATER'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 21, E'यदि ''MILK'' लाई ''N J M L'' लेखिन्छ भने, ''WATER'' लाई के लेखिन्छ?', E'X B U F S', E'X Z U F S', E'X B U D S', E'X Z S F S', E'A', E'सबै अक्षरहरूमा +1 गरिएको छ। W+1=X, A+1=B, T+1=U, E+1=F, R+1=S.', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि ''MILK'' लाई ''N J M L'' लेखिन्छ भने, ''WATER'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 21)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि ''CAT'' लाई 3120 लेखिन्छ भने, ''DOG'' लाई कति लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 22, E'यदि ''CAT'' लाई 3120 लेखिन्छ भने, ''DOG'' लाई कति लेखिन्छ?', E'4158', E'4157', E'4159', E'4160', E'B', E'C=3, A=1, T=20 (3-1-20 -> 3120). D=4, O=15, G=7 -> 4157.', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि ''CAT'' लाई 3120 लेखिन्छ भने, ''DOG'' लाई कति लेखिन्छ?'), v_set_id, v_q_id, 22)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि ''RAT'' लाई 18120 लेखिन्छ भने, ''BAT'' लाई कति लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 23, E'यदि ''RAT'' लाई 18120 लेखिन्छ भने, ''BAT'' लाई कति लेखिन्छ?', E'2121', E'2122', E'2120', E'2123', E'C', E'R=18, A=1, T=20 -> 18120. B=2, A=1, T=20 -> 2120.', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि ''RAT'' लाई 18120 लेखिन्छ भने, ''BAT'' लाई कति लेखिन्छ?'), v_set_id, v_q_id, 23)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि ''APPLE'' लाई ''EPPLA'' लेखिन्छ भने, ''BANANA'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 24, E'यदि ''APPLE'' लाई ''EPPLA'' लेखिन्छ भने, ''BANANA'' लाई के लेखिन्छ?', E'ANANBA', E'AANANB', E'ANNAAB', E'ANANAB', E'D', E'पूरै शब्द उल्टो। APPLE को उल्टो ELPPA हुन्छ, BANANA को उल्टो ANANAB.', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि ''APPLE'' लाई ''EPPLA'' लेखिन्छ भने, ''BANANA'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 24)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि ''PENCIL'' लाई ''LICNEP'' लेखिन्छ भने, ''MARKER'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 25, E'यदि ''PENCIL'' लाई ''LICNEP'' लेखिन्छ भने, ''MARKER'' लाई के लेखिन्छ?', E'REKRAM', E'REKARM', E'REKMAR', E'REKRM', E'A', E'शब्दलाई उल्टो क्रममा लेखिएको छ। MARKER को उल्टो REKRAM हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि ''PENCIL'' लाई ''LICNEP'' लेखिन्छ भने, ''MARKER'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 25)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि ''CLOCK'' लाई ''KCOLC'' लेखिन्छ भने, ''WATCH'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 26, E'यदि ''CLOCK'' लाई ''KCOLC'' लेखिन्छ भने, ''WATCH'' लाई के लेखिन्छ?', E'HCWAW', E'HCTAW', E'HCTWA', E'HCAWT', E'B', E'शब्दलाई उल्टो क्रममा लेखिएको छ। WATCH को उल्टो HCTAW हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि ''CLOCK'' लाई ''KCOLC'' लेखिन्छ भने, ''WATCH'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 26)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि ''GREEN'' लाई ''NEERG'' लेखिन्छ भने, ''YELLOW'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 27, E'यदि ''GREEN'' लाई ''NEERG'' लेखिन्छ भने, ''YELLOW'' लाई के लेखिन्छ?', E'WOLLEYY', E'WLOLEY', E'WOLLEY', E'WOLYEY', E'C', E'शब्दलाई उल्टो क्रममा लेखिएको छ। YELLOW को उल्टो WOLLEY हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि ''GREEN'' लाई ''NEERG'' लेखिन्छ भने, ''YELLOW'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 27)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि ''NIGHT'' लाई ''THGIN'' लेखिन्छ भने, ''MORNING'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 28, E'यदि ''NIGHT'' लाई ''THGIN'' लेखिन्छ भने, ''MORNING'' लाई के लेखिन्छ?', E'GNINORM', E'GNIROMN', E'GNNIROM', E'GNINROM', E'D', E'शब्दलाई उल्टो क्रममा लेखिएको छ। MORNING को उल्टो GNINROM हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि ''NIGHT'' लाई ''THGIN'' लेखिन्छ भने, ''MORNING'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 28)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि ''EARTH'' लाई ''HTRAE'' लेखिन्छ भने, ''SPACE'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 29, E'यदि ''EARTH'' लाई ''HTRAE'' लेखिन्छ भने, ''SPACE'' लाई के लेखिन्छ?', E'ECAPS', E'ECASP', E'ECSPA', E'ECPSA', E'A', E'शब्दलाई उल्टो क्रममा लेखिएको छ। SPACE को उल्टो ECAPS हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि ''EARTH'' लाई ''HTRAE'' लेखिन्छ भने, ''SPACE'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 29)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि ''WORLD'' लाई ''DLROW'' लेखिन्छ भने, ''GLOBE'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 30, E'यदि ''WORLD'' लाई ''DLROW'' लेखिन्छ भने, ''GLOBE'' लाई के लेखिन्छ?', E'EBOGL', E'EBOLG', E'EBLOG', E'EBGLO', E'B', E'शब्दलाई उल्टो क्रममा लेखिएको छ। GLOBE को उल्टो EBOLG हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि ''WORLD'' लाई ''DLROW'' लेखिन्छ भने, ''GLOBE'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 30)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: स्थानिक तथा प्रत्यक्षात्मक क्षमताः Coding-Decoding - खण्ड 4 (आधारभूत तह) (5 Q)
  v_set_id := extensions.uuid_generate_v5('83123770-9e69-4d49-b231-b112c95d2692'::uuid, E'स्थानिक तथा प्रत्यक्षात्मक क्षमताः Coding-Decoding - खण्ड 4 (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '69c87a98-20d9-4fd7-a596-37eaa6fdc55b'::uuid, '83123770-9e69-4d49-b231-b112c95d2692'::uuid, E'स्थानिक तथा प्रत्यक्षात्मक क्षमताः Coding-Decoding - खण्ड 4 (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '83123770-9e69-4d49-b231-b112c95d2692'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि ''PAPER'' लाई 16-1-16-5-18 लेखिन्छ भने, ''BOOK'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'यदि ''PAPER'' लाई 16-1-16-5-18 लेखिन्छ भने, ''BOOK'' लाई के लेखिन्छ?', E'2-15-15-11', E'2-14-14-11', E'2-15-16-11', E'2-16-16-11', E'A', E'अङ्ग्रेजी वर्णमालाको स्थान अङ्क। B=2, O=15, O=15, K=11.', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि ''PAPER'' लाई 16-1-16-5-18 लेखिन्छ भने, ''BOOK'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि ''CAR'' लाई 3-1-18 लेखिन्छ भने, ''BUS'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'यदि ''CAR'' लाई 3-1-18 लेखिन्छ भने, ''BUS'' लाई के लेखिन्छ?', E'2-20-19', E'2-21-19', E'2-22-19', E'2-21-20', E'B', E'वर्णमालाको स्थान अङ्क। B=2, U=21, S=19.', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि ''CAR'' लाई 3-1-18 लेखिन्छ भने, ''BUS'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि ''BIRD'' लाई 2-9-18-4 लेखिन्छ भने, ''FISH'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'यदि ''BIRD'' लाई 2-9-18-4 लेखिन्छ भने, ''FISH'' लाई के लेखिन्छ?', E'6-8-19-8', E'6-9-18-8', E'6-9-19-8', E'5-9-19-8', E'C', E'वर्णमालाको स्थान अङ्क। F=6, I=9, S=19, H=8.', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि ''BIRD'' लाई 2-9-18-4 लेखिन्छ भने, ''FISH'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि ''LION'' लाई 12-9-15-14 लेखिन्छ भने, ''TIGER'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'यदि ''LION'' लाई 12-9-15-14 लेखिन्छ भने, ''TIGER'' लाई के लेखिन्छ?', E'20-8-7-5-18', E'20-9-8-5-18', E'19-9-7-5-18', E'20-9-7-5-18', E'D', E'वर्णमालाको स्थान अङ्क। T=20, I=9, G=7, E=5, R=18.', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि ''LION'' लाई 12-9-15-14 लेखिन्छ भने, ''TIGER'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि ''NEPAL'' लाई 14-5-16-1-12 लेखिन्छ भने, ''INDIA'' लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'यदि ''NEPAL'' लाई 14-5-16-1-12 लेखिन्छ भने, ''INDIA'' लाई के लेखिन्छ?', E'9-14-4-9-1', E'9-13-4-9-1', E'9-14-5-9-1', E'8-14-4-9-1', E'A', E'अङ्ग्रेजी वर्णमालाको स्थान अङ्क। I=9, N=14, D=4, I=9, A=1.', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि ''NEPAL'' लाई 14-5-16-1-12 लेखिन्छ भने, ''INDIA'' लाई के लेखिन्छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: स्थानिक तथा प्रत्यक्षात्मक क्षमताः Matrix Reasoning - खण्ड 2 (आधारभूत तह) (30 Q)
  v_set_id := extensions.uuid_generate_v5('ff8f1833-290a-491e-9e40-b7b4474942d1'::uuid, E'स्थानिक तथा प्रत्यक्षात्मक क्षमताः Matrix Reasoning - खण्ड 2 (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '69c87a98-20d9-4fd7-a596-37eaa6fdc55b'::uuid, 'ff8f1833-290a-491e-9e40-b7b4474942d1'::uuid, E'स्थानिक तथा प्रत्यक्षात्मक क्षमताः Matrix Reasoning - खण्ड 2 (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'ff8f1833-290a-491e-9e40-b7b4474942d1'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 2 | 4 | 6 |
| 3 | 5 | 8 |
| 4 | 7 | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 2 | 4 | 6 |
| 3 | 5 | 8 |
| 4 | 7 | ? |', E'11', E'10', E'9', E'12', E'A', E'तेस्रो कोलमको संख्या पहिलो र दोस्रो कोलमको योगफल हो (4+7 = 11)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 2 | 4 | 6 |
| 3 | 5 | 8 |
| 4 | 7 | ? |'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 8 | 3 | 24 |
| 5 | 4 | 20 |
| 7 | 6 | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 8 | 3 | 24 |
| 5 | 4 | 20 |
| 7 | 6 | ? |', E'40', E'42', E'44', E'46', E'B', E'तेस्रो कोलमको संख्या पहिलो र दोस्रो कोलमको गुणनफल हो (7×6 = 42)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 8 | 3 | 24 |
| 5 | 4 | 20 |
| 7 | 6 | ? |'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 15 | 5 | 10 |
| 20 | 8 | 12 |
| 18 | 9 | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 15 | 5 | 10 |
| 20 | 8 | 12 |
| 18 | 9 | ? |', E'8', E'10', E'9', E'7', E'C', E'तेस्रो कोलमको संख्या पहिलोबाट दोस्रो घटाउँदा आउने परिणाम हो (18-9 = 9)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 15 | 5 | 10 |
| 20 | 8 | 12 |
| 18 | 9 | ? |'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 1 | 2 | 3 |
| 4 | 5 | 9 |
| 6 | 3 | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 1 | 2 | 3 |
| 4 | 5 | 9 |
| 6 | 3 | ? |', E'8', E'10', E'11', E'9', E'D', E'तेस्रो कोलमको संख्या पहिलो र दोस्रो कोलमको योगफल हो (6+3 = 9)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 1 | 2 | 3 |
| 4 | 5 | 9 |
| 6 | 3 | ? |'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 9 | 9 | 81 |
| 8 | 8 | 64 |
| 7 | 7 | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 9 | 9 | 81 |
| 8 | 8 | 64 |
| 7 | 7 | ? |', E'49', E'42', E'56', E'54', E'A', E'तेस्रो कोलमको संख्या पहिलो र दोस्रो कोलमको गुणनफल हो (7×7 = 49)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 9 | 9 | 81 |
| 8 | 8 | 64 |
| 7 | 7 | ? |'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 25 | 10 | 15 |
| 30 | 12 | 18 |
| 28 | 14 | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 25 | 10 | 15 |
| 30 | 12 | 18 |
| 28 | 14 | ? |', E'12', E'14', E'13', E'15', E'B', E'तेस्रो कोलमको संख्या पहिलोबाट दोस्रो घटाउँदा आउने परिणाम हो (28-14 = 14)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 25 | 10 | 15 |
| 30 | 12 | 18 |
| 28 | 14 | ? |'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 10 | 10 | 20 |
| 15 | 15 | 30 |
| 20 | 20 | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 10 | 10 | 20 |
| 15 | 15 | 30 |
| 20 | 20 | ? |', E'30', E'50', E'40', E'60', E'C', E'तेस्रो कोलमको संख्या पहिलो र दोस्रो कोलमको योगफल हो (20+20 = 40)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 10 | 10 | 20 |
| 15 | 15 | 30 |
| 20 | 20 | ? |'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 3 | 3 | 9 |
| 4 | 4 | 16 |
| 5 | 5 | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 3 | 3 | 9 |
| 4 | 4 | 16 |
| 5 | 5 | ? |', E'20', E'30', E'35', E'25', E'D', E'तेस्रो कोलमको संख्या पहिलो र दोस्रो कोलमको गुणनफल हो (5×5 = 25)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 3 | 3 | 9 |
| 4 | 4 | 16 |
| 5 | 5 | ? |'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 40 | 20 | 20 |
| 50 | 25 | 25 |
| 60 | 30 | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 40 | 20 | 20 |
| 50 | 25 | 25 |
| 60 | 30 | ? |', E'30', E'20', E'40', E'50', E'A', E'तेस्रो कोलमको संख्या पहिलोबाट दोस्रो घटाउँदा आउने परिणाम हो (60-30 = 30)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 40 | 20 | 20 |
| 50 | 25 | 25 |
| 60 | 30 | ? |'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 11 | 22 | 33 |
| 12 | 24 | 36 |
| 13 | 26 | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 11 | 22 | 33 |
| 12 | 24 | 36 |
| 13 | 26 | ? |', E'37', E'39', E'38', E'40', E'B', E'तेस्रो कोलमको संख्या पहिलो र दोस्रो कोलमको योगफल हो (13+26 = 39)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 11 | 22 | 33 |
| 12 | 24 | 36 |
| 13 | 26 | ? |'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 2 | 8 | 16 |
| 3 | 7 | 21 |
| 4 | 9 | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 2 | 8 | 16 |
| 3 | 7 | 21 |
| 4 | 9 | ? |', E'32', E'34', E'36', E'38', E'C', E'तेस्रो कोलमको संख्या पहिलो र दोस्रो कोलमको गुणनफल हो (4×9 = 36)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 2 | 8 | 16 |
| 3 | 7 | 21 |
| 4 | 9 | ? |'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 55 | 25 | 30 |
| 65 | 35 | 30 |
| 75 | 45 | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 55 | 25 | 30 |
| 65 | 35 | 30 |
| 75 | 45 | ? |', E'20', E'40', E'50', E'30', E'D', E'तेस्रो कोलमको संख्या पहिलोबाट दोस्रो घटाउँदा आउने परिणाम हो (75-45 = 30)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 55 | 25 | 30 |
| 65 | 35 | 30 |
| 75 | 45 | ? |'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 7 | 3 | 10 |
| 8 | 4 | 12 |
| 9 | 5 | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 7 | 3 | 10 |
| 8 | 4 | 12 |
| 9 | 5 | ? |', E'14', E'12', E'13', E'15', E'A', E'तेस्रो कोलमको संख्या पहिलो र दोस्रो कोलमको योगफल हो (9+5 = 14)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 7 | 3 | 10 |
| 8 | 4 | 12 |
| 9 | 5 | ? |'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 6 | 6 | 36 |
| 7 | 7 | 49 |
| 8 | 8 | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 6 | 6 | 36 |
| 7 | 7 | 49 |
| 8 | 8 | ? |', E'56', E'64', E'72', E'80', E'B', E'तेस्रो कोलमको संख्या पहिलो र दोस्रो कोलमको गुणनफल हो (8×8 = 64)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 6 | 6 | 36 |
| 7 | 7 | 49 |
| 8 | 8 | ? |'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 80 | 40 | 40 |
| 90 | 45 | 45 |
| 100| 50 | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 80 | 40 | 40 |
| 90 | 45 | 45 |
| 100| 50 | ? |', E'40', E'60', E'50', E'70', E'C', E'तेस्रो कोलमको संख्या पहिलोबाट दोस्रो घटाउँदा आउने परिणाम हो (100-50 = 50)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 80 | 40 | 40 |
| 90 | 45 | 45 |
| 100| 50 | ? |'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 5 | 10 | 15 |
| 10| 20 | 30 |
| 15| 30 | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 5 | 10 | 15 |
| 10| 20 | 30 |
| 15| 30 | ? |', E'40', E'50', E'55', E'45', E'D', E'तेस्रो कोलमको संख्या पहिलो र दोस्रो कोलमको योगफल हो (15+30 = 45)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 5 | 10 | 15 |
| 10| 20 | 30 |
| 15| 30 | ? |'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 5 | 8 | 40 |
| 6 | 9 | 54 |
| 7 | 10| ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 5 | 8 | 40 |
| 6 | 9 | 54 |
| 7 | 10| ? |', E'70', E'60', E'80', E'90', E'A', E'तेस्रो कोलमको संख्या पहिलो र दोस्रो कोलमको गुणनफल हो (7×10 = 70)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 5 | 8 | 40 |
| 6 | 9 | 54 |
| 7 | 10| ? |'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 42 | 21 | 21 |
| 52 | 26 | 26 |
| 62 | 31 | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 42 | 21 | 21 |
| 52 | 26 | 26 |
| 62 | 31 | ? |', E'21', E'31', E'41', E'51', E'B', E'तेस्रो कोलमको संख्या पहिलोबाट दोस्रो घटाउँदा आउने परिणाम हो (62-31 = 31)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 42 | 21 | 21 |
| 52 | 26 | 26 |
| 62 | 31 | ? |'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 12 | 13 | 25 |
| 14 | 15 | 29 |
| 16 | 17 | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 12 | 13 | 25 |
| 14 | 15 | 29 |
| 16 | 17 | ? |', E'31', E'32', E'33', E'34', E'C', E'तेस्रो कोलमको संख्या पहिलो र दोस्रो कोलमको योगफल हो (16+17 = 33)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 12 | 13 | 25 |
| 14 | 15 | 29 |
| 16 | 17 | ? |'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 9 | 5 | 45 |
| 10| 6 | 60 |
| 11| 7 | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 20, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 9 | 5 | 45 |
| 10| 6 | 60 |
| 11| 7 | ? |', E'66', E'88', E'99', E'77', E'D', E'तेस्रो कोलमको संख्या पहिलो र दोस्रो कोलमको गुणनफल हो (11×7 = 77)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 9 | 5 | 45 |
| 10| 6 | 60 |
| 11| 7 | ? |'), v_set_id, v_q_id, 20)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 35 | 15 | 20 |
| 45 | 25 | 20 |
| 55 | 35 | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 21, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 35 | 15 | 20 |
| 45 | 25 | 20 |
| 55 | 35 | ? |', E'20', E'10', E'30', E'40', E'A', E'तेस्रो कोलमको संख्या पहिलोबाट दोस्रो घटाउँदा आउने परिणाम हो (55-35 = 20)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 35 | 15 | 20 |
| 45 | 25 | 20 |
| 55 | 35 | ? |'), v_set_id, v_q_id, 21)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 4 | 9 | 13 |
| 5 | 10| 15 |
| 6 | 11| ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 22, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 4 | 9 | 13 |
| 5 | 10| 15 |
| 6 | 11| ? |', E'16', E'17', E'18', E'19', E'B', E'तेस्रो कोलमको संख्या पहिलो र दोस्रो कोलमको योगफल हो (6+11 = 17)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 4 | 9 | 13 |
| 5 | 10| 15 |
| 6 | 11| ? |'), v_set_id, v_q_id, 22)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 1 | 9 | 9 |
| 2 | 8 | 16|
| 3 | 7 | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 23, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 1 | 9 | 9 |
| 2 | 8 | 16|
| 3 | 7 | ? |', E'22', E'23', E'21', E'24', E'C', E'तेस्रो कोलमको संख्या पहिलो र दोस्रो कोलमको गुणनफल हो (3×7 = 21)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 1 | 9 | 9 |
| 2 | 8 | 16|
| 3 | 7 | ? |'), v_set_id, v_q_id, 23)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 77 | 33 | 44 |
| 88 | 44 | 44 |
| 99 | 55 | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 24, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 77 | 33 | 44 |
| 88 | 44 | 44 |
| 99 | 55 | ? |', E'33', E'55', E'66', E'44', E'D', E'तेस्रो कोलमको संख्या पहिलोबाट दोस्रो घटाउँदा आउने परिणाम हो (99-55 = 44)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 77 | 33 | 44 |
| 88 | 44 | 44 |
| 99 | 55 | ? |'), v_set_id, v_q_id, 24)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 18 | 12 | 30 |
| 19 | 13 | 32 |
| 20 | 14 | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 25, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 18 | 12 | 30 |
| 19 | 13 | 32 |
| 20 | 14 | ? |', E'34', E'32', E'36', E'38', E'A', E'तेस्रो कोलमको संख्या पहिलो र दोस्रो कोलमको योगफल हो (20+14 = 34)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 18 | 12 | 30 |
| 19 | 13 | 32 |
| 20 | 14 | ? |'), v_set_id, v_q_id, 25)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 2 | 12 | 24 |
| 3 | 11 | 33 |
| 4 | 10 | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 26, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 2 | 12 | 24 |
| 3 | 11 | 33 |
| 4 | 10 | ? |', E'38', E'40', E'42', E'44', E'B', E'तेस्रो कोलमको संख्या पहिलो र दोस्रो कोलमको गुणनफल हो (4×10 = 40)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 2 | 12 | 24 |
| 3 | 11 | 33 |
| 4 | 10 | ? |'), v_set_id, v_q_id, 26)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 27 | 17 | 10 |
| 37 | 27 | 10 |
| 47 | 37 | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 27, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 27 | 17 | 10 |
| 37 | 27 | 10 |
| 47 | 37 | ? |', E'8', E'9', E'10', E'11', E'C', E'तेस्रो कोलमको संख्या पहिलोबाट दोस्रो घटाउँदा आउने परिणाम हो (47-37 = 10)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 27 | 17 | 10 |
| 37 | 27 | 10 |
| 47 | 37 | ? |'), v_set_id, v_q_id, 27)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 22 | 8 | 30 |
| 23 | 9 | 32 |
| 24 | 10| ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 28, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 22 | 8 | 30 |
| 23 | 9 | 32 |
| 24 | 10| ? |', E'32', E'36', E'38', E'34', E'D', E'तेस्रो कोलमको संख्या पहिलो र दोस्रो कोलमको योगफल हो (24+10 = 34)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 22 | 8 | 30 |
| 23 | 9 | 32 |
| 24 | 10| ? |'), v_set_id, v_q_id, 28)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 5 | 11 | 55 |
| 6 | 12 | 72 |
| 7 | 13 | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 29, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 5 | 11 | 55 |
| 6 | 12 | 72 |
| 7 | 13 | ? |', E'91', E'90', E'92', E'93', E'A', E'तेस्रो कोलमको संख्या पहिलो र दोस्रो कोलमको गुणनफल हो (7×13 = 91)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 5 | 11 | 55 |
| 6 | 12 | 72 |
| 7 | 13 | ? |'), v_set_id, v_q_id, 29)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 50 | 15 | 35 |
| 60 | 25 | 35 |
| 70 | 35 | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 30, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 50 | 15 | 35 |
| 60 | 25 | 35 |
| 70 | 35 | ? |', E'25', E'35', E'45', E'55', E'B', E'तेस्रो कोलमको संख्या पहिलोबाट दोस्रो घटाउँदा आउने परिणाम हो (70-35 = 35)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 50 | 15 | 35 |
| 60 | 25 | 35 |
| 70 | 35 | ? |'), v_set_id, v_q_id, 30)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: स्थानिक तथा प्रत्यक्षात्मक क्षमताः Matrix Reasoning - खण्ड 3 (आधारभूत तह) (30 Q)
  v_set_id := extensions.uuid_generate_v5('ff8f1833-290a-491e-9e40-b7b4474942d1'::uuid, E'स्थानिक तथा प्रत्यक्षात्मक क्षमताः Matrix Reasoning - खण्ड 3 (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '69c87a98-20d9-4fd7-a596-37eaa6fdc55b'::uuid, 'ff8f1833-290a-491e-9e40-b7b4474942d1'::uuid, E'स्थानिक तथा प्रत्यक्षात्मक क्षमताः Matrix Reasoning - खण्ड 3 (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'ff8f1833-290a-491e-9e40-b7b4474942d1'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 31 | 11 | 42 |
| 32 | 12 | 44 |
| 33 | 13 | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 31 | 11 | 42 |
| 32 | 12 | 44 |
| 33 | 13 | ? |', E'46', E'44', E'45', E'47', E'A', E'तेस्रो कोलमको संख्या पहिलो र दोस्रो कोलमको योगफल हो (33+13 = 46)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 31 | 11 | 42 |
| 32 | 12 | 44 |
| 33 | 13 | ? |'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 8 | 2 | 16 |
| 9 | 3 | 27 |
| 10| 4 | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 8 | 2 | 16 |
| 9 | 3 | 27 |
| 10| 4 | ? |', E'30', E'40', E'50', E'60', E'B', E'तेस्रो कोलमको संख्या पहिलो र दोस्रो कोलमको गुणनफल हो (10×4 = 40)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 8 | 2 | 16 |
| 9 | 3 | 27 |
| 10| 4 | ? |'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 68 | 34 | 34 |
| 78 | 39 | 39 |
| 88 | 44 | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 68 | 34 | 34 |
| 78 | 39 | 39 |
| 88 | 44 | ? |', E'34', E'54', E'44', E'64', E'C', E'तेस्रो कोलमको संख्या पहिलोबाट दोस्रो घटाउँदा आउने परिणाम हो (88-44 = 44)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 68 | 34 | 34 |
| 78 | 39 | 39 |
| 88 | 44 | ? |'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 14 | 16 | 30 |
| 15 | 17 | 32 |
| 16 | 18 | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 14 | 16 | 30 |
| 15 | 17 | 32 |
| 16 | 18 | ? |', E'32', E'36', E'38', E'34', E'D', E'तेस्रो कोलमको संख्या पहिलो र दोस्रो कोलमको योगफल हो (16+18 = 34)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन संख्या हुन्छ?
| 14 | 16 | 30 |
| 15 | 17 | 32 |
| 16 | 18 | ? |'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| A | B | C |
| D | E | F |
| G | H | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| A | B | C |
| D | E | F |
| G | H | ? |', E'I', E'H', E'J', E'K', E'A', E'अक्षरहरू क्रमशः वर्णमाला अनुसार छन् (+1 को वृद्धि)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| A | B | C |
| D | E | F |
| G | H | ? |'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| A | C | E |
| F | H | J |
| K | M | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| A | C | E |
| F | H | J |
| K | M | ? |', E'N', E'O', E'P', E'Q', E'B', E'अक्षरहरू +2 को फरकमा राखिएका छन् (K -> M -> O)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| A | C | E |
| F | H | J |
| K | M | ? |'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| J | K | L |
| M | N | O |
| P | Q | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| J | K | L |
| M | N | O |
| P | Q | ? |', E'S', E'T', E'R', E'U', E'C', E'अक्षरहरू क्रमशः वर्णमाला अनुसार छन् (+1 को वृद्धि)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| J | K | L |
| M | N | O |
| P | Q | ? |'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| B | D | F |
| G | I | K |
| L | N | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| B | D | F |
| G | I | K |
| L | N | ? |', E'O', E'Q', E'R', E'P', E'D', E'अक्षरहरू +2 को फरकमा राखिएका छन् (L -> N -> P)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| B | D | F |
| G | I | K |
| L | N | ? |'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| C | D | E |
| F | G | H |
| I | J | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| C | D | E |
| F | G | H |
| I | J | ? |', E'K', E'J', E'L', E'M', E'A', E'अक्षरहरू क्रमशः वर्णमाला अनुसार छन् (+1 को वृद्धि)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| C | D | E |
| F | G | H |
| I | J | ? |'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| C | E | G |
| H | J | L |
| M | O | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| C | E | G |
| H | J | L |
| M | O | ? |', E'P', E'Q', E'R', E'S', E'B', E'अक्षरहरू +2 को फरकमा राखिएका छन् (M -> O -> Q)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| C | E | G |
| H | J | L |
| M | O | ? |'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| X | Y | Z |
| U | V | W |
| R | S | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| X | Y | Z |
| U | V | W |
| R | S | ? |', E'U', E'V', E'T', E'W', E'C', E'अक्षरहरू क्रमशः वर्णमाला अनुसार छन् (+1 को वृद्धि)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| X | Y | Z |
| U | V | W |
| R | S | ? |'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| D | F | H |
| I | K | M |
| N | P | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| D | F | H |
| I | K | M |
| N | P | ? |', E'Q', E'S', E'T', E'R', E'D', E'अक्षरहरू +2 को फरकमा राखिएका छन् (N -> P -> R)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| D | F | H |
| I | K | M |
| N | P | ? |'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| E | F | G |
| H | I | J |
| K | L | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| E | F | G |
| H | I | J |
| K | L | ? |', E'M', E'L', E'N', E'O', E'A', E'अक्षरहरू क्रमशः वर्णमाला अनुसार छन् (+1 को वृद्धि)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| E | F | G |
| H | I | J |
| K | L | ? |'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| E | G | I |
| J | L | N |
| O | Q | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| E | G | I |
| J | L | N |
| O | Q | ? |', E'R', E'S', E'T', E'U', E'B', E'अक्षरहरू +2 को फरकमा राखिएका छन् (O -> Q -> S)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| E | G | I |
| J | L | N |
| O | Q | ? |'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| L | M | N |
| O | P | Q |
| R | S | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| L | M | N |
| O | P | Q |
| R | S | ? |', E'U', E'V', E'T', E'W', E'C', E'अक्षरहरू क्रमशः वर्णमाला अनुसार छन् (+1 को वृद्धि)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| L | M | N |
| O | P | Q |
| R | S | ? |'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| F | H | J |
| K | M | O |
| P | R | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| F | H | J |
| K | M | O |
| P | R | ? |', E'S', E'U', E'V', E'T', E'D', E'अक्षरहरू +2 को फरकमा राखिएका छन् (P -> R -> T)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| F | H | J |
| K | M | O |
| P | R | ? |'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| N | O | P |
| Q | R | S |
| T | U | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| N | O | P |
| Q | R | S |
| T | U | ? |', E'V', E'W', E'X', E'Y', E'A', E'अक्षरहरू क्रमशः वर्णमाला अनुसार छन् (+1 को वृद्धि)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| N | O | P |
| Q | R | S |
| T | U | ? |'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| G | I | K |
| L | N | P |
| Q | S | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| G | I | K |
| L | N | P |
| Q | S | ? |', E'T', E'U', E'V', E'W', E'B', E'अक्षरहरू +2 को फरकमा राखिएका छन् (Q -> S -> U)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| G | I | K |
| L | N | P |
| Q | S | ? |'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| P | Q | R |
| S | T | U |
| V | W | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| P | Q | R |
| S | T | U |
| V | W | ? |', E'Y', E'Z', E'X', E'A', E'C', E'अक्षरहरू क्रमशः वर्णमाला अनुसार छन् (+1 को वृद्धि)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| P | Q | R |
| S | T | U |
| V | W | ? |'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| H | J | L |
| M | O | Q |
| R | T | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 20, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| H | J | L |
| M | O | Q |
| R | T | ? |', E'U', E'W', E'X', E'V', E'D', E'अक्षरहरू +2 को फरकमा राखिएका छन् (R -> T -> V)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| H | J | L |
| M | O | Q |
| R | T | ? |'), v_set_id, v_q_id, 20)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| O | P | Q |
| R | S | T |
| U | V | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 21, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| O | P | Q |
| R | S | T |
| U | V | ? |', E'W', E'X', E'Y', E'Z', E'A', E'अक्षरहरू क्रमशः वर्णमाला अनुसार छन् (+1 को वृद्धि)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| O | P | Q |
| R | S | T |
| U | V | ? |'), v_set_id, v_q_id, 21)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| I | K | M |
| N | P | R |
| S | U | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 22, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| I | K | M |
| N | P | R |
| S | U | ? |', E'V', E'W', E'X', E'Y', E'B', E'अक्षरहरू +2 को फरकमा राखिएका छन् (S -> U -> W)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| I | K | M |
| N | P | R |
| S | U | ? |'), v_set_id, v_q_id, 22)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| Q | R | S |
| T | U | V |
| W | X | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 23, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| Q | R | S |
| T | U | V |
| W | X | ? |', E'Z', E'A', E'Y', E'B', E'C', E'अक्षरहरू क्रमशः वर्णमाला अनुसार छन् (+1 को वृद्धि)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| Q | R | S |
| T | U | V |
| W | X | ? |'), v_set_id, v_q_id, 23)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| J | L | N |
| O | Q | S |
| T | V | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 24, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| J | L | N |
| O | Q | S |
| T | V | ? |', E'W', E'Y', E'Z', E'X', E'D', E'अक्षरहरू +2 को फरकमा राखिएका छन् (T -> V -> X)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| J | L | N |
| O | Q | S |
| T | V | ? |'), v_set_id, v_q_id, 24)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| S | T | U |
| V | W | X |
| Y | Z | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 25, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| S | T | U |
| V | W | X |
| Y | Z | ? |', E'A', E'B', E'C', E'D', E'A', E'अक्षरहरू क्रमशः वर्णमाला अनुसार छन् (+1 को वृद्धि, Z पछि A)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| S | T | U |
| V | W | X |
| Y | Z | ? |'), v_set_id, v_q_id, 25)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| K | M | O |
| P | R | T |
| U | W | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 26, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| K | M | O |
| P | R | T |
| U | W | ? |', E'X', E'Y', E'Z', E'A', E'B', E'अक्षरहरू +2 को फरकमा राखिएका छन् (U -> W -> Y)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| K | M | O |
| P | R | T |
| U | W | ? |'), v_set_id, v_q_id, 26)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| Z | A | B |
| C | D | E |
| F | G | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 27, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| Z | A | B |
| C | D | E |
| F | G | ? |', E'I', E'J', E'H', E'K', E'C', E'अक्षरहरू क्रमशः वर्णमाला अनुसार छन् (+1 को वृद्धि)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| Z | A | B |
| C | D | E |
| F | G | ? |'), v_set_id, v_q_id, 27)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| L | N | P |
| Q | S | U |
| V | X | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 28, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| L | N | P |
| Q | S | U |
| V | X | ? |', E'Y', E'A', E'B', E'Z', E'D', E'अक्षरहरू +2 को फरकमा राखिएका छन् (V -> X -> Z)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| L | N | P |
| Q | S | U |
| V | X | ? |'), v_set_id, v_q_id, 28)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| R | S | T |
| U | V | W |
| X | Y | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 29, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| R | S | T |
| U | V | W |
| X | Y | ? |', E'Z', E'A', E'B', E'C', E'A', E'अक्षरहरू क्रमशः वर्णमाला अनुसार छन् (+1 को वृद्धि)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| R | S | T |
| U | V | W |
| X | Y | ? |'), v_set_id, v_q_id, 29)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| M | O | Q |
| R | T | V |
| W | Y | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 30, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| M | O | Q |
| R | T | V |
| W | Y | ? |', E'Z', E'A', E'B', E'C', E'B', E'अक्षरहरू +2 को फरकमा राखिएका छन् (W -> Y -> A)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| M | O | Q |
| R | T | V |
| W | Y | ? |'), v_set_id, v_q_id, 30)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: स्थानिक तथा प्रत्यक्षात्मक क्षमताः Matrix Reasoning - खण्ड 4 (आधारभूत तह) (30 Q)
  v_set_id := extensions.uuid_generate_v5('ff8f1833-290a-491e-9e40-b7b4474942d1'::uuid, E'स्थानिक तथा प्रत्यक्षात्मक क्षमताः Matrix Reasoning - खण्ड 4 (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '69c87a98-20d9-4fd7-a596-37eaa6fdc55b'::uuid, 'ff8f1833-290a-491e-9e40-b7b4474942d1'::uuid, E'स्थानिक तथा प्रत्यक्षात्मक क्षमताः Matrix Reasoning - खण्ड 4 (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'ff8f1833-290a-491e-9e40-b7b4474942d1'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| U | V | W |
| X | Y | Z |
| A | B | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| U | V | W |
| X | Y | Z |
| A | B | ? |', E'C', E'D', E'E', E'F', E'A', E'अक्षरहरू क्रमशः वर्णमाला अनुसार छन् (+1 को वृद्धि)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| U | V | W |
| X | Y | Z |
| A | B | ? |'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| N | P | R |
| S | U | W |
| X | Z | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| N | P | R |
| S | U | W |
| X | Z | ? |', E'A', E'B', E'C', E'D', E'B', E'अक्षरहरू +2 को फरकमा राखिएका छन् (X -> Z -> B)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| N | P | R |
| S | U | W |
| X | Z | ? |'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| W | X | Y |
| Z | A | B |
| C | D | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| W | X | Y |
| Z | A | B |
| C | D | ? |', E'F', E'G', E'E', E'H', E'C', E'अक्षरहरू क्रमशः वर्णमाला अनुसार छन् (+1 को वृद्धि)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| W | X | Y |
| Z | A | B |
| C | D | ? |'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| O | Q | S |
| T | V | X |
| Y | A | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| O | Q | S |
| T | V | X |
| Y | A | ? |', E'B', E'D', E'E', E'C', E'D', E'अक्षरहरू +2 को फरकमा राखिएका छन् (Y -> A -> C)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| O | Q | S |
| T | V | X |
| Y | A | ? |'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| B | C | D |
| E | F | G |
| H | I | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| B | C | D |
| E | F | G |
| H | I | ? |', E'J', E'K', E'L', E'M', E'A', E'अक्षरहरू क्रमशः वर्णमाला अनुसार छन् (+1 को वृद्धि)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| B | C | D |
| E | F | G |
| H | I | ? |'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| P | R | T |
| U | W | Y |
| Z | B | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| P | R | T |
| U | W | Y |
| Z | B | ? |', E'C', E'D', E'E', E'F', E'B', E'अक्षरहरू +2 को फरकमा राखिएका छन् (Z -> B -> D)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| P | R | T |
| U | W | Y |
| Z | B | ? |'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| D | E | F |
| G | H | I |
| J | K | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| D | E | F |
| G | H | I |
| J | K | ? |', E'M', E'N', E'L', E'O', E'C', E'अक्षरहरू क्रमशः वर्णमाला अनुसार छन् (+1 को वृद्धि)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन अक्षर हुन्छ?
| D | E | F |
| G | H | I |
| J | K | ? |'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन आउँछ?
| माथि बाण | दायाँ बाण | तल बाण |
| तल बाण | बायाँ बाण | माथि बाण |
| बायाँ बाण | माथि बाण | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन आउँछ?
| माथि बाण | दायाँ बाण | तल बाण |
| तल बाण | बायाँ बाण | माथि बाण |
| बायाँ बाण | माथि बाण | ? |', E'तल बाण', E'बायाँ बाण', E'माथि बाण', E'दायाँ बाण', E'D', E'प्रत्येक रोमा बाण 90 डिग्री घडीको दिशामा घुमेको छ (बायाँ -> माथि -> दायाँ)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन आउँछ?
| माथि बाण | दायाँ बाण | तल बाण |
| तल बाण | बायाँ बाण | माथि बाण |
| बायाँ बाण | माथि बाण | ? |'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा के आउँछ?
| 1 वृत्त | 2 वृत्त | 3 वृत्त |
| 2 वृत्त | 3 वृत्त | 4 वृत्त |
| 3 वृत्त | 4 वृत्त | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा के आउँछ?
| 1 वृत्त | 2 वृत्त | 3 वृत्त |
| 2 वृत्त | 3 वृत्त | 4 वृत्त |
| 3 वृत्त | 4 वृत्त | ? |', E'5 वृत्त', E'4 वृत्त', E'6 वृत्त', E'7 वृत्त', E'A', E'प्रत्येक रोमा आकृतिहरूको संख्या क्रमशः 1 ले बढ्दै गएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा के आउँछ?
| 1 वृत्त | 2 वृत्त | 3 वृत्त |
| 2 वृत्त | 3 वृत्त | 4 वृत्त |
| 3 वृत्त | 4 वृत्त | ? |'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन आउँछ?
| दायाँ बाण | तल बाण | बायाँ बाण |
| बायाँ बाण | माथि बाण | दायाँ बाण |
| माथि बाण | दायाँ बाण | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन आउँछ?
| दायाँ बाण | तल बाण | बायाँ बाण |
| बायाँ बाण | माथि बाण | दायाँ बाण |
| माथि बाण | दायाँ बाण | ? |', E'बायाँ बाण', E'तल बाण', E'माथि बाण', E'दायाँ बाण', E'B', E'प्रत्येक रोमा बाण 90 डिग्री घडीको दिशामा घुमेको छ (माथि -> दायाँ -> तल)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन आउँछ?
| दायाँ बाण | तल बाण | बायाँ बाण |
| बायाँ बाण | माथि बाण | दायाँ बाण |
| माथि बाण | दायाँ बाण | ? |'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा के आउँछ?
| 2 वर्ग | 3 वर्ग | 4 वर्ग |
| 3 वर्ग | 4 वर्ग | 5 वर्ग |
| 4 वर्ग | 5 वर्ग | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा के आउँछ?
| 2 वर्ग | 3 वर्ग | 4 वर्ग |
| 3 वर्ग | 4 वर्ग | 5 वर्ग |
| 4 वर्ग | 5 वर्ग | ? |', E'4 वर्ग', E'5 वर्ग', E'6 वर्ग', E'7 वर्ग', E'C', E'प्रत्येक रोमा आकृतिहरूको संख्या क्रमशः 1 ले बढ्दै गएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा के आउँछ?
| 2 वर्ग | 3 वर्ग | 4 वर्ग |
| 3 वर्ग | 4 वर्ग | 5 वर्ग |
| 4 वर्ग | 5 वर्ग | ? |'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन आउँछ?
| तल बाण | बायाँ बाण | माथि बाण |
| माथि बाण | दायाँ बाण | तल बाण |
| दायाँ बाण | तल बाण | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन आउँछ?
| तल बाण | बायाँ बाण | माथि बाण |
| माथि बाण | दायाँ बाण | तल बाण |
| दायाँ बाण | तल बाण | ? |', E'माथि बाण', E'दायाँ बाण', E'तल बाण', E'बायाँ बाण', E'D', E'प्रत्येक रोमा बाण 90 डिग्री घडीको दिशामा घुमेको छ (दायाँ -> तल -> बायाँ)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन आउँछ?
| तल बाण | बायाँ बाण | माथि बाण |
| माथि बाण | दायाँ बाण | तल बाण |
| दायाँ बाण | तल बाण | ? |'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा के आउँछ?
| 1 त्रिभुज | 2 त्रिभुज | 3 त्रिभुज |
| 2 त्रिभुज | 3 त्रिभुज | 4 त्रिभुज |
| 3 त्रिभुज | 4 त्रिभुज | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा के आउँछ?
| 1 त्रिभुज | 2 त्रिभुज | 3 त्रिभुज |
| 2 त्रिभुज | 3 त्रिभुज | 4 त्रिभुज |
| 3 त्रिभुज | 4 त्रिभुज | ? |', E'5 त्रिभुज', E'4 त्रिभुज', E'6 त्रिभुज', E'7 त्रिभुज', E'A', E'प्रत्येक रोमा आकृतिहरूको संख्या क्रमशः 1 ले बढ्दै गएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा के आउँछ?
| 1 त्रिभुज | 2 त्रिभुज | 3 त्रिभुज |
| 2 त्रिभुज | 3 त्रिभुज | 4 त्रिभुज |
| 3 त्रिभुज | 4 त्रिभुज | ? |'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन आउँछ?
| बायाँ बाण | माथि बाण | दायाँ बाण |
| दायाँ बाण | तल बाण | बायाँ बाण |
| तल बाण | बायाँ बाण | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन आउँछ?
| बायाँ बाण | माथि बाण | दायाँ बाण |
| दायाँ बाण | तल बाण | बायाँ बाण |
| तल बाण | बायाँ बाण | ? |', E'दायाँ बाण', E'माथि बाण', E'तल बाण', E'बायाँ बाण', E'B', E'प्रत्येक रोमा बाण 90 डिग्री घडीको दिशामा घुमेको छ (तल -> बायाँ -> माथि)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन आउँछ?
| बायाँ बाण | माथि बाण | दायाँ बाण |
| दायाँ बाण | तल बाण | बायाँ बाण |
| तल बाण | बायाँ बाण | ? |'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा के आउँछ?
| 2 तारा | 3 तारा | 4 तारा |
| 3 तारा | 4 तारा | 5 तारा |
| 4 तारा | 5 तारा | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा के आउँछ?
| 2 तारा | 3 तारा | 4 तारा |
| 3 तारा | 4 तारा | 5 तारा |
| 4 तारा | 5 तारा | ? |', E'5 तारा', E'7 तारा', E'6 तारा', E'8 तारा', E'C', E'प्रत्येक रोमा आकृतिहरूको संख्या क्रमशः 1 ले बढ्दै गएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा के आउँछ?
| 2 तारा | 3 तारा | 4 तारा |
| 3 तारा | 4 तारा | 5 तारा |
| 4 तारा | 5 तारा | ? |'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन आउँछ?
| माथि बाण | दायाँ बाण | तल बाण |
| दायाँ बाण | तल बाण | बायाँ बाण |
| बायाँ बाण | माथि बाण | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन आउँछ?
| माथि बाण | दायाँ बाण | तल बाण |
| दायाँ बाण | तल बाण | बायाँ बाण |
| बायाँ बाण | माथि बाण | ? |', E'तल बाण', E'बायाँ बाण', E'माथि बाण', E'दायाँ बाण', E'D', E'प्रत्येक रोमा बाण 90 डिग्री घडीको दिशामा घुमेको छ (बायाँ -> माथि -> दायाँ)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन आउँछ?
| माथि बाण | दायाँ बाण | तल बाण |
| दायाँ बाण | तल बाण | बायाँ बाण |
| बायाँ बाण | माथि बाण | ? |'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा के आउँछ?
| 1 आयत | 2 आयत | 3 आयत |
| 2 आयत | 3 आयत | 4 आयत |
| 3 आयत | 4 आयत | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा के आउँछ?
| 1 आयत | 2 आयत | 3 आयत |
| 2 आयत | 3 आयत | 4 आयत |
| 3 आयत | 4 आयत | ? |', E'5 आयत', E'4 आयत', E'6 आयत', E'7 आयत', E'A', E'प्रत्येक रोमा आकृतिहरूको संख्या क्रमशः 1 ले बढ्दै गएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा के आउँछ?
| 1 आयत | 2 आयत | 3 आयत |
| 2 आयत | 3 आयत | 4 आयत |
| 3 आयत | 4 आयत | ? |'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन आउँछ?
| दायाँ बाण | तल बाण | बायाँ बाण |
| तल बाण | बायाँ बाण | माथि बाण |
| माथि बाण | दायाँ बाण | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन आउँछ?
| दायाँ बाण | तल बाण | बायाँ बाण |
| तल बाण | बायाँ बाण | माथि बाण |
| माथि बाण | दायाँ बाण | ? |', E'बायाँ बाण', E'तल बाण', E'माथि बाण', E'दायाँ बाण', E'B', E'प्रत्येक रोमा बाण 90 डिग्री घडीको दिशामा घुमेको छ (माथि -> दायाँ -> तल)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन आउँछ?
| दायाँ बाण | तल बाण | बायाँ बाण |
| तल बाण | बायाँ बाण | माथि बाण |
| माथि बाण | दायाँ बाण | ? |'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा के आउँछ?
| 3 वृत्त | 4 वृत्त | 5 वृत्त |
| 4 वृत्त | 5 वृत्त | 6 वृत्त |
| 5 वृत्त | 6 वृत्त | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा के आउँछ?
| 3 वृत्त | 4 वृत्त | 5 वृत्त |
| 4 वृत्त | 5 वृत्त | 6 वृत्त |
| 5 वृत्त | 6 वृत्त | ? |', E'6 वृत्त', E'8 वृत्त', E'7 वृत्त', E'9 वृत्त', E'C', E'प्रत्येक रोमा आकृतिहरूको संख्या क्रमशः 1 ले बढ्दै गएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा के आउँछ?
| 3 वृत्त | 4 वृत्त | 5 वृत्त |
| 4 वृत्त | 5 वृत्त | 6 वृत्त |
| 5 वृत्त | 6 वृत्त | ? |'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन आउँछ?
| तल बाण | बायाँ बाण | माथि बाण |
| बायाँ बाण | माथि बाण | दायाँ बाण |
| दायाँ बाण | तल बाण | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 20, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन आउँछ?
| तल बाण | बायाँ बाण | माथि बाण |
| बायाँ बाण | माथि बाण | दायाँ बाण |
| दायाँ बाण | तल बाण | ? |', E'माथि बाण', E'दायाँ बाण', E'तल बाण', E'बायाँ बाण', E'D', E'प्रत्येक रोमा बाण 90 डिग्री घडीको दिशामा घुमेको छ (दायाँ -> तल -> बायाँ)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन आउँछ?
| तल बाण | बायाँ बाण | माथि बाण |
| बायाँ बाण | माथि बाण | दायाँ बाण |
| दायाँ बाण | तल बाण | ? |'), v_set_id, v_q_id, 20)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा के आउँछ?
| 4 वर्ग | 5 वर्ग | 6 वर्ग |
| 5 वर्ग | 6 वर्ग | 7 वर्ग |
| 6 वर्ग | 7 वर्ग | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 21, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा के आउँछ?
| 4 वर्ग | 5 वर्ग | 6 वर्ग |
| 5 वर्ग | 6 वर्ग | 7 वर्ग |
| 6 वर्ग | 7 वर्ग | ? |', E'8 वर्ग', E'7 वर्ग', E'9 वर्ग', E'10 वर्ग', E'A', E'प्रत्येक रोमा आकृतिहरूको संख्या क्रमशः 1 ले बढ्दै गएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा के आउँछ?
| 4 वर्ग | 5 वर्ग | 6 वर्ग |
| 5 वर्ग | 6 वर्ग | 7 वर्ग |
| 6 वर्ग | 7 वर्ग | ? |'), v_set_id, v_q_id, 21)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन आउँछ?
| बायाँ बाण | माथि बाण | दायाँ बाण |
| माथि बाण | दायाँ बाण | तल बाण |
| तल बाण | बायाँ बाण | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 22, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन आउँछ?
| बायाँ बाण | माथि बाण | दायाँ बाण |
| माथि बाण | दायाँ बाण | तल बाण |
| तल बाण | बायाँ बाण | ? |', E'दायाँ बाण', E'माथि बाण', E'तल बाण', E'बायाँ बाण', E'B', E'प्रत्येक रोमा बाण 90 डिग्री घडीको दिशामा घुमेको छ (तल -> बायाँ -> माथि)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा कुन आउँछ?
| बायाँ बाण | माथि बाण | दायाँ बाण |
| माथि बाण | दायाँ बाण | तल बाण |
| तल बाण | बायाँ बाण | ? |'), v_set_id, v_q_id, 22)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा के आउँछ?
| 2 त्रिभुज | 3 त्रिभुज | 4 त्रिभुज |
| 3 त्रिभुज | 4 त्रिभुज | 5 त्रिभुज |
| 4 त्रिभुज | 5 त्रिभुज | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 23, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा के आउँछ?
| 2 त्रिभुज | 3 त्रिभुज | 4 त्रिभुज |
| 3 त्रिभुज | 4 त्रिभुज | 5 त्रिभुज |
| 4 त्रिभुज | 5 त्रिभुज | ? |', E'5 त्रिभुज', E'7 त्रिभुज', E'6 त्रिभुज', E'8 त्रिभुज', E'C', E'प्रत्येक रोमा आकृतिहरूको संख्या क्रमशः 1 ले बढ्दै गएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा के आउँछ?
| 2 त्रिभुज | 3 त्रिभुज | 4 त्रिभुज |
| 3 त्रिभुज | 4 त्रिभुज | 5 त्रिभुज |
| 4 त्रिभुज | 5 त्रिभुज | ? |'), v_set_id, v_q_id, 23)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा के आउँछ?
| 3 तारा | 4 तारा | 5 तारा |
| 4 तारा | 5 तारा | 6 तारा |
| 5 तारा | 6 तारा | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 24, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा के आउँछ?
| 3 तारा | 4 तारा | 5 तारा |
| 4 तारा | 5 तारा | 6 तारा |
| 5 तारा | 6 तारा | ? |', E'6 तारा', E'8 तारा', E'9 तारा', E'7 तारा', E'D', E'प्रत्येक रोमा आकृतिहरूको संख्या क्रमशः 1 ले बढ्दै गएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा के आउँछ?
| 3 तारा | 4 तारा | 5 तारा |
| 4 तारा | 5 तारा | 6 तारा |
| 5 तारा | 6 तारा | ? |'), v_set_id, v_q_id, 24)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा के आउँछ?
| 2 आयत | 3 आयत | 4 आयत |
| 3 आयत | 4 आयत | 5 आयत |
| 4 आयत | 5 आयत | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 25, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा के आउँछ?
| 2 आयत | 3 आयत | 4 आयत |
| 3 आयत | 4 आयत | 5 आयत |
| 4 आयत | 5 आयत | ? |', E'6 आयत', E'5 आयत', E'7 आयत', E'8 आयत', E'A', E'प्रत्येक रोमा आकृतिहरूको संख्या क्रमशः 1 ले बढ्दै गएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा के आउँछ?
| 2 आयत | 3 आयत | 4 आयत |
| 3 आयत | 4 आयत | 5 आयत |
| 4 आयत | 5 आयत | ? |'), v_set_id, v_q_id, 25)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा के आउँछ?
| 5 वर्ग | 6 वर्ग | 7 वर्ग |
| 6 वर्ग | 7 वर्ग | 8 वर्ग |
| 7 वर्ग | 8 वर्ग | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 26, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा के आउँछ?
| 5 वर्ग | 6 वर्ग | 7 वर्ग |
| 6 वर्ग | 7 वर्ग | 8 वर्ग |
| 7 वर्ग | 8 वर्ग | ? |', E'8 वर्ग', E'9 वर्ग', E'10 वर्ग', E'11 वर्ग', E'B', E'प्रत्येक रोमा आकृतिहरूको संख्या क्रमशः 1 ले बढ्दै गएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा के आउँछ?
| 5 वर्ग | 6 वर्ग | 7 वर्ग |
| 6 वर्ग | 7 वर्ग | 8 वर्ग |
| 7 वर्ग | 8 वर्ग | ? |'), v_set_id, v_q_id, 26)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा के आउँछ?
| 4 त्रिभुज | 5 त्रिभुज | 6 त्रिभुज |
| 5 त्रिभुज | 6 त्रिभुज | 7 त्रिभुज |
| 6 त्रिभुज | 7 त्रिभुज | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 27, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा के आउँछ?
| 4 त्रिभुज | 5 त्रिभुज | 6 त्रिभुज |
| 5 त्रिभुज | 6 त्रिभुज | 7 त्रिभुज |
| 6 त्रिभुज | 7 त्रिभुज | ? |', E'7 त्रिभुज', E'9 त्रिभुज', E'8 त्रिभुज', E'10 त्रिभुज', E'C', E'प्रत्येक रोमा आकृतिहरूको संख्या क्रमशः 1 ले बढ्दै गएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा के आउँछ?
| 4 त्रिभुज | 5 त्रिभुज | 6 त्रिभुज |
| 5 त्रिभुज | 6 त्रिभुज | 7 त्रिभुज |
| 6 त्रिभुज | 7 त्रिभुज | ? |'), v_set_id, v_q_id, 27)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा के आउँछ?
| 1 तारा | 2 तारा | 3 तारा |
| 2 तारा | 3 तारा | 4 तारा |
| 3 तारा | 4 तारा | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 28, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा के आउँछ?
| 1 तारा | 2 तारा | 3 तारा |
| 2 तारा | 3 तारा | 4 तारा |
| 3 तारा | 4 तारा | ? |', E'4 तारा', E'6 तारा', E'7 तारा', E'5 तारा', E'D', E'प्रत्येक रोमा आकृतिहरूको संख्या क्रमशः 1 ले बढ्दै गएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा के आउँछ?
| 1 तारा | 2 तारा | 3 तारा |
| 2 तारा | 3 तारा | 4 तारा |
| 3 तारा | 4 तारा | ? |'), v_set_id, v_q_id, 28)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा के आउँछ?
| 3 आयत | 4 आयत | 5 आयत |
| 4 आयत | 5 आयत | 6 आयत |
| 5 आयत | 6 आयत | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 29, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा के आउँछ?
| 3 आयत | 4 आयत | 5 आयत |
| 4 आयत | 5 आयत | 6 आयत |
| 5 आयत | 6 आयत | ? |', E'7 आयत', E'6 आयत', E'8 आयत', E'9 आयत', E'A', E'प्रत्येक रोमा आकृतिहरूको संख्या क्रमशः 1 ले बढ्दै गएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा के आउँछ?
| 3 आयत | 4 आयत | 5 आयत |
| 4 आयत | 5 आयत | 6 आयत |
| 5 आयत | 6 आयत | ? |'), v_set_id, v_q_id, 29)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा के आउँछ?
| 2 वृत्त | 3 वृत्त | 4 वृत्त |
| 3 वृत्त | 4 वृत्त | 5 वृत्त |
| 4 वृत्त | 5 वृत्त | ? |');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 30, E'तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा के आउँछ?
| 2 वृत्त | 3 वृत्त | 4 वृत्त |
| 3 वृत्त | 4 वृत्त | 5 वृत्त |
| 4 वृत्त | 5 वृत्त | ? |', E'5 वृत्त', E'6 वृत्त', E'7 वृत्त', E'8 वृत्त', E'B', E'प्रत्येक रोमा आकृतिहरूको संख्या क्रमशः 1 ले बढ्दै गएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएको म्याट्रिक्समा प्रश्नवाचक चिन्ह (?) को ठाउँमा के आउँछ?
| 2 वृत्त | 3 वृत्त | 4 वृत्त |
| 3 वृत्त | 4 वृत्त | 5 वृत्त |
| 4 वृत्त | 5 वृत्त | ? |'), v_set_id, v_q_id, 30)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  RAISE NOTICE 'aptitude batch overflow complete: 18 sets, 489 questions.';
END $$;
