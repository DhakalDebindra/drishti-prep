-- Idempotent UPSERT import: निमावि प्रथम पत्र — ङ-१ शाब्दिक बौद्धिक परीक्षण (Level I topic-wise sets)
-- Override same-identity sets/questions; never deletes. Generated 2026-07-05T12:02:18.098Z.
DO $$
DECLARE
  v_module_id uuid := '6695669a-f40e-421a-a4ec-b09bbeaf56c4'::uuid;
  v_set_id uuid;
  v_q_id uuid;
BEGIN

  -- Set: शाब्दिक बौद्धिक परीक्षणः शब्द ज्ञान (आधारभूत तह) (4 Q)
  v_set_id := extensions.uuid_generate_v5('7d4b6d71-7451-4e67-91fe-5323380a3258'::uuid, E'शाब्दिक बौद्धिक परीक्षणः शब्द ज्ञान (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'efc9184a-c265-4fd8-bb99-aad431aefc58'::uuid, '7d4b6d71-7451-4e67-91fe-5323380a3258'::uuid, E'शाब्दिक बौद्धिक परीक्षणः शब्द ज्ञान (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '7d4b6d71-7451-4e67-91fe-5323380a3258'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'अङ्ग्रेजी वर्णमाला क्रम अनुसार ''War, Wasp, Waste, Wrinkle'' मध्ये कुन शब्द सबैभन्दा पहिले पर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'अङ्ग्रेजी वर्णमाला क्रम अनुसार ''War, Wasp, Waste, Wrinkle'' मध्ये कुन शब्द सबैभन्दा पहिले पर्छ?', E'War', E'Wasp', E'Waste', E'Wrinkle', E'A', E'**वर्णमाला क्रम अनुसार War, Wasp, Waste, Wrinkle मध्ये War सबैभन्दा पहिले पर्छ (Wa पछि r < s हुने भएकाले)।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:अङ्ग्रेजी वर्णमाला क्रम अनुसार ''War, Wasp, Waste, Wrinkle'' मध्ये कुन शब्द सबैभन्दा पहिले पर्छ?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'अङ्ग्रेजी वर्णमाला क्रम अनुसार ''Plane, Plain, Plenty, Player'' मध्ये कुन शब्द सबैभन्दा पहिले पर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'अङ्ग्रेजी वर्णमाला क्रम अनुसार ''Plane, Plain, Plenty, Player'' मध्ये कुन शब्द सबैभन्दा पहिले पर्छ?', E'Plane', E'Plain', E'Plenty', E'Player', E'B', E'**वर्णमाला क्रम अनुसार ''Pla'' पछि Plain(i) < Plane(n) < Player(y) < Plenty(en) हुने भएकाले Plain सबैभन्दा पहिले पर्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:अङ्ग्रेजी वर्णमाला क्रम अनुसार ''Plane, Plain, Plenty, Player'' मध्ये कुन शब्द सबैभन्दा पहिले पर्छ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'अङ्ग्रेजी वर्णमाला क्रम अनुसार ''Nature, Narrate, Nascent, Native'' मध्ये कुन शब्द सबैभन्दा पहिले पर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'अङ्ग्रेजी वर्णमाला क्रम अनुसार ''Nature, Narrate, Nascent, Native'' मध्ये कुन शब्द सबैभन्दा पहिले पर्छ?', E'Nature', E'Nascent', E'Narrate', E'Native', E'C', E'**वर्णमाला क्रम अनुसार Narrate, Nascent, Native, Nature मध्ये Narrate सबैभन्दा पहिले पर्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:अङ्ग्रेजी वर्णमाला क्रम अनुसार ''Nature, Narrate, Nascent, Native'' मध्ये कुन शब्द सबैभन्दा पहिले पर्छ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'अङ्ग्रेजी वर्णमाला क्रम अनुसार ''Rural, Romance, Rejoice, Reveal'' मध्ये कुन शब्द सबैभन्दा अन्तिममा पर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'अङ्ग्रेजी वर्णमाला क्रम अनुसार ''Rural, Romance, Rejoice, Reveal'' मध्ये कुन शब्द सबैभन्दा अन्तिममा पर्छ?', E'Romance', E'Rejoice', E'Reveal', E'Rural', E'D', E'**वर्णमाला क्रम अनुसार Rejoice, Reveal, Romance, Rural मध्ये Rural सबैभन्दा अन्तिममा पर्छ (Re < Ro < Ru)।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:अङ्ग्रेजी वर्णमाला क्रम अनुसार ''Rural, Romance, Rejoice, Reveal'' मध्ये कुन शब्द सबैभन्दा अन्तिममा पर्छ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: शाब्दिक बौद्धिक परीक्षणः समरूपता/Analogies (आधारभूत तह) (6 Q)
  v_set_id := extensions.uuid_generate_v5('91240d83-acef-40dd-9fa2-412f8b797e45'::uuid, E'शाब्दिक बौद्धिक परीक्षणः समरूपता/Analogies (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'efc9184a-c265-4fd8-bb99-aad431aefc58'::uuid, '91240d83-acef-40dd-9fa2-412f8b797e45'::uuid, E'शाब्दिक बौद्धिक परीक्षणः समरूपता/Analogies (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '91240d83-acef-40dd-9fa2-412f8b797e45'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शब्द बीचको अन्तरसम्बन्धको आधारमा सही विकल्प छनोट गर्नुहोस्: फ्रेन्च : फ्रान्स : : पोलिस : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'शब्द बीचको अन्तरसम्बन्धको आधारमा सही विकल्प छनोट गर्नुहोस्: फ्रेन्च : फ्रान्स : : पोलिस : ?', E'पोल्याण्ड', E'फिजी', E'पोर्चुगल', E'पनामा', E'A', E'**''फ्रेन्च'' फ्रान्सको भाषा/नागरिकतासूचक विशेषण हो, त्यसैगरी ''पोलिस'' पोल्याण्डको भाषा/नागरिकतासूचक विशेषण हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शब्द बीचको अन्तरसम्बन्धको आधारमा सही विकल्प छनोट गर्नुहोस्: फ्रेन्च : फ्रान्स : : पोलिस : ?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पहिलो दुई शब्दहरूको सम्बन्धको आधारमा तेस्रो शब्दको उपयुक्त विकल्प छनोट गर्नुहोस्: एसिया : जापान : : अफ्रिका : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'पहिलो दुई शब्दहरूको सम्बन्धको आधारमा तेस्रो शब्दको उपयुक्त विकल्प छनोट गर्नुहोस्: एसिया : जापान : : अफ्रिका : ?', E'भारत', E'घाना', E'अमेरिका', E'रुस', E'B', E'**जापान एसिया महादेशको एउटा देश हो, त्यसैगरी घाना अफ्रिका महादेशको एउटा देश हो (भारत एसियामा नै पर्छ, अमेरिका र रुस अफ्रिकामा पर्दैनन्)।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पहिलो दुई शब्दहरूको सम्बन्धको आधारमा तेस्रो शब्दको उपयुक्त विकल्प छनोट गर्नुहोस्: एसिया : जापान : : अफ्रिका : ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पहिलो दुई शब्दहरूको सम्बन्धको आधारमा तेस्रो शब्दको उपयुक्त विकल्प छनोट गर्नुहोस्: गाडी : चक्का : : लेखक : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'पहिलो दुई शब्दहरूको सम्बन्धको आधारमा तेस्रो शब्दको उपयुक्त विकल्प छनोट गर्नुहोस्: गाडी : चक्का : : लेखक : ?', E'पत्रिका', E'पुस्तिका', E'कलम', E'पुस्तक', E'C', E'**गाडीको मुख्य/अनिवार्य साधन चक्का हो, त्यसैगरी लेखकको मुख्य/अनिवार्य साधन कलम हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पहिलो दुई शब्दहरूको सम्बन्धको आधारमा तेस्रो शब्दको उपयुक्त विकल्प छनोट गर्नुहोस्: गाडी : चक्का : : लेखक : ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'खाली ठाउँमा उपयुक्त शब्द छान्नुहोस्: निरक्षरता – शिक्षा : : बाढी – ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'खाली ठाउँमा उपयुक्त शब्द छान्नुहोस्: निरक्षरता – शिक्षा : : बाढी – ?', E'नदी', E'वर्षा', E'पुल', E'बाँध', E'D', E'**निरक्षरताको समाधान शिक्षा हो, त्यसैगरी बाढी नियन्त्रणको एउटा उपाय बाँध हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:खाली ठाउँमा उपयुक्त शब्द छान्नुहोस्: निरक्षरता – शिक्षा : : बाढी – ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'Complete the given analogy: FOOT : LEG :: HAND : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'Complete the given analogy: FOOT : LEG :: HAND : ?', E'ARM', E'TOE', E'ELBOW', E'PALM', E'A', E'**FOOT हुन्छ LEG को अन्त्यमा, त्यसैगरी HAND हुन्छ ARM को अन्त्यमा।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:Complete the given analogy: FOOT : LEG :: HAND : ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'Complete the following analogy: Menu : Food :: Catalogue : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'Complete the following analogy: Menu : Food :: Catalogue : ?', E'Rack', E'Books', E'Newspaper', E'Library', E'B', E'**Menu ले उपलब्ध Food का सूची दिन्छ, त्यसैगरी Catalogue ले उपलब्ध Books का सूची दिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:Complete the following analogy: Menu : Food :: Catalogue : ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: शाब्दिक बौद्धिक परीक्षणः शाब्दिक वर्गीकरण (आधारभूत तह) (4 Q)
  v_set_id := extensions.uuid_generate_v5('ae5f551c-9daa-4651-bf85-7891ea89c25c'::uuid, E'शाब्दिक बौद्धिक परीक्षणः शाब्दिक वर्गीकरण (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'efc9184a-c265-4fd8-bb99-aad431aefc58'::uuid, 'ae5f551c-9daa-4651-bf85-7891ea89c25c'::uuid, E'शाब्दिक बौद्धिक परीक्षणः शाब्दिक वर्गीकरण (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'ae5f551c-9daa-4651-bf85-7891ea89c25c'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका शब्द समूहबाट नमिल्ने शब्द छुट्याउनुहोस्: थर्मोमिटर, किलोमिटर, ब्यारोमिटर, ल्याक्टोमिटर');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'तलका शब्द समूहबाट नमिल्ने शब्द छुट्याउनुहोस्: थर्मोमिटर, किलोमिटर, ब्यारोमिटर, ल्याक्टोमिटर', E'किलोमिटर', E'थर्मोमिटर', E'ब्यारोमिटर', E'ल्याक्टोमिटर', E'A', E'**थर्मोमिटर, ब्यारोमिटर र ल्याक्टोमिटर नाप्ने यन्त्र (उपकरण) हुन्, तर किलोमिटर दूरी नाप्ने एकाइ (Unit) मात्र हो, यन्त्र होइन।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका शब्द समूहबाट नमिल्ने शब्द छुट्याउनुहोस्: थर्मोमिटर, किलोमिटर, ब्यारोमिटर, ल्याक्टोमिटर'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'देहायको कुन समूहमा नमिल्ने शब्द कुन हो: Asia, Argentina, Africa, Australia');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'देहायको कुन समूहमा नमिल्ने शब्द कुन हो: Asia, Argentina, Africa, Australia', E'Asia', E'Argentina', E'Africa', E'Australia', E'B', E'**Asia, Africa र Australia महादेश (Continent) हुन्, तर Argentina एउटा देश हो, महादेश होइन।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:देहायको कुन समूहमा नमिल्ने शब्द कुन हो: Asia, Argentina, Africa, Australia'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द पत्ता लगाउनुहोस्: काउली, मुला, सिमी, बकुल्ला');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'समूहमा नमिल्ने शब्द पत्ता लगाउनुहोस्: काउली, मुला, सिमी, बकुल्ला', E'काउली', E'मुला', E'बकुल्ला', E'सिमी', E'C', E'**काउली, मुला र सिमी तरकारी (वनस्पति) हुन्, तर बकुल्ला एउटा चरा हो, तरकारी होइन।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द पत्ता लगाउनुहोस्: काउली, मुला, सिमी, बकुल्ला'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिइएका शब्दहरूलाई उल्टो गरी लेख्दा बन्ने शब्दहरूमध्ये (HTRAE, SUNEV, RETIPUJ, THGIN) कुन समूहमा नमिल्ने हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'तल दिइएका शब्दहरूलाई उल्टो गरी लेख्दा बन्ने शब्दहरूमध्ये (HTRAE, SUNEV, RETIPUJ, THGIN) कुन समूहमा नमिल्ने हो?', E'HTRAE', E'SUNEV', E'RETIPUJ', E'THGIN', E'D', E'**उल्टो गरी पढ्दा HTRAE=EARTH, SUNEV=VENUS, RETIPUJ=JUPITER हुन् जुन ग्रहहरू हुन्, तर THGIN=NIGHT हो जुन ग्रह होइन।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिइएका शब्दहरूलाई उल्टो गरी लेख्दा बन्ने शब्दहरूमध्ये (HTRAE, SUNEV, RETIPUJ, THGIN) कुन समूहमा नमिल्ने हो?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: शाब्दिक बौद्धिक परीक्षणः विपरीतार्थक र समानार्थी शब्द (आधारभूत तह) (14 Q)
  v_set_id := extensions.uuid_generate_v5('075f71e5-93ca-40d5-8bbb-f671e74eab47'::uuid, E'शाब्दिक बौद्धिक परीक्षणः विपरीतार्थक र समानार्थी शब्द (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'efc9184a-c265-4fd8-bb99-aad431aefc58'::uuid, '075f71e5-93ca-40d5-8bbb-f671e74eab47'::uuid, E'शाब्दिक बौद्धिक परीक्षणः विपरीतार्थक र समानार्थी शब्द (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '075f71e5-93ca-40d5-8bbb-f671e74eab47'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'What is the antonym of ''Flaunt''?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'What is the antonym of ''Flaunt''?', E'Hide', E'Regard', E'Sink', E'Propose', E'A', E'**''Flaunt'' को अर्थ देखाउनु/प्रदर्शन गर्नु हो, यसको विपरीतार्थक शब्द ''Hide'' (लुकाउनु) हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:What is the antonym of ''Flaunt''?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'What is the synonym of ''Miserable''?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'What is the synonym of ''Miserable''?', E'Cruel', E'Unhappy', E'Wrong', E'Miss', E'B', E'**''Miserable'' को समानार्थी शब्द ''Unhappy'' (दुःखी) हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:What is the synonym of ''Miserable''?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'What is the antonym of ''Cautious''?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'What is the antonym of ''Cautious''?', E'Reasonable', E'Careful', E'Reckless', E'Illogical', E'C', E'**''Cautious'' को अर्थ सतर्क/सावधान हो, यसको विपरीतार्थक शब्द ''Reckless'' (लापरवाह) हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:What is the antonym of ''Cautious''?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'What is the synonym of ''Ambiguous''?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'What is the synonym of ''Ambiguous''?', E'Joy', E'Accuse', E'Afraid', E'Doubtful', E'D', E'**''Ambiguous'' को समानार्थी शब्द ''Doubtful'' (अस्पष्ट/शंकास्पद) हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:What is the synonym of ''Ambiguous''?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'What is the antonym of ''Temporal''?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'What is the antonym of ''Temporal''?', E'Spiritual', E'Elegant', E'Spring', E'Plenty', E'A', E'**''Temporal'' को अर्थ भौतिक/सांसारिक (समय-सीमित) हो, यसको विपरीतार्थक शब्द ''Spiritual'' (आध्यात्मिक) हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:What is the antonym of ''Temporal''?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'What is the antonym of ''Rigid''?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'What is the antonym of ''Rigid''?', E'Tireful', E'Flexible', E'Popular', E'Valuable', E'B', E'**''Rigid'' को अर्थ कडा/कठोर हो, यसको विपरीतार्थक शब्द ''Flexible'' (लचिलो) हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:What is the antonym of ''Rigid''?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'What is the antonym of ''Luminous''?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'What is the antonym of ''Luminous''?', E'Clear', E'Brittle', E'Dim', E'Clever', E'C', E'**''Luminous'' को अर्थ चम्किलो/उज्यालो हो, यसको विपरीतार्थक शब्द ''Dim'' (धमिलो) हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:What is the antonym of ''Luminous''?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''ZENITH'' शब्दको समानार्थी शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'''ZENITH'' शब्दको समानार्थी शब्द कुन हो?', E'Middle', E'Under', E'Across', E'Pinnacle', E'D', E'**''ZENITH'' को अर्थ चुचुरो/उच्चतम बिन्दु हो, यसको समानार्थी शब्द ''Pinnacle'' हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''ZENITH'' शब्दको समानार्थी शब्द कुन हो?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'Which is the antonym of ''Grief''?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'Which is the antonym of ''Grief''?', E'Happiness', E'Attractive', E'Grievance', E'Grave', E'A', E'**''Grief'' को अर्थ शोक/दुःख हो, यसको विपरीतार्थक शब्द ''Happiness'' (खुसी) हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:Which is the antonym of ''Grief''?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'Which is the antonym of ''Heterogeneous''?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'Which is the antonym of ''Heterogeneous''?', E'Unlike', E'Homogeneous', E'Dissimilar', E'Miscellaneous', E'B', E'**''Heterogeneous'' को अर्थ विविध/असमान प्रकारको हो, यसको विपरीतार्थक शब्द ''Homogeneous'' (समरूप) हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:Which is the antonym of ''Heterogeneous''?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''Earthly'' शब्दको विपरीतार्थक शब्द छान्नुहोस्।');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'''Earthly'' शब्दको विपरीतार्थक शब्द छान्नुहोस्।', E'Natural', E'Sensual', E'Spiritual', E'Temporal', E'C', E'**''Earthly'' को अर्थ सांसारिक/भौतिक हो, यसको विपरीतार्थक शब्द ''Spiritual'' (आध्यात्मिक) हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''Earthly'' शब्दको विपरीतार्थक शब्द छान्नुहोस्।'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'Which is the synonym of ''Charges'' (as in a fee)?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'Which is the synonym of ''Charges'' (as in a fee)?', E'Income', E'Payment', E'Profit', E'Fee', E'D', E'**यहाँ ''Charges'' को अर्थ लिइने रकम (शुल्क) हो, यसको समानार्थी शब्द ''Fee'' हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:Which is the synonym of ''Charges'' (as in a fee)?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''Prodigal'' शब्दको समानार्थी शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'''Prodigal'' शब्दको समानार्थी शब्द कुन हो?', E'Excess', E'Moderate', E'Son', E'Frugal', E'A', E'**''Prodigal'' को अर्थ अत्यधिक खर्चिलो/फजुलखर्ची हो, यो ''Excess'' (अत्यधिकता) सँग नजिकको भाव बुझाउँछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''Prodigal'' शब्दको समानार्थी शब्द कुन हो?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''शक्तिका लागि गरिने तछाडमचेलले देश विकास हुनेमा शङ्का छ।'' यस वाक्यमा रेखाङ्कित शब्द ''तछाडमचेल'' को उपयुक्त पर्यायवाची शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'''शक्तिका लागि गरिने तछाडमचेलले देश विकास हुनेमा शङ्का छ।'' यस वाक्यमा रेखाङ्कित शब्द ''तछाडमचेल'' को उपयुक्त पर्यायवाची शब्द कुन हो?', E'खटपटी', E'हानखप', E'अभाव', E'प्रशंसा', E'B', E'**''तछाडमचेल'' को अर्थ आपसी खिचातानी/प्रतिस्पर्धा हो, यसको उपयुक्त पर्यायवाची शब्द ''हानखप'' हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''शक्तिका लागि गरिने तछाडमचेलले देश विकास हुनेमा शङ्का छ।'' यस वाक्यमा रेखाङ्कित शब्द ''तछाडमचेल'' को उपयुक्त पर्यायवाची शब्द कुन हो?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: शाब्दिक बौद्धिक परीक्षणः शाब्दिक पजल र अमिल्दा शब्द (आधारभूत तह) (7 Q)
  v_set_id := extensions.uuid_generate_v5('fa0af7e0-6bb7-4c25-b62f-d2d8ce99f610'::uuid, E'शाब्दिक बौद्धिक परीक्षणः शाब्दिक पजल र अमिल्दा शब्द (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'efc9184a-c265-4fd8-bb99-aad431aefc58'::uuid, 'fa0af7e0-6bb7-4c25-b62f-d2d8ce99f610'::uuid, E'शाब्दिक बौद्धिक परीक्षणः शाब्दिक पजल र अमिल्दा शब्द (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'fa0af7e0-6bb7-4c25-b62f-d2d8ce99f610'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'Which is the meaningful sentence from the given jumbled words: than/ are/ the/ poem/ two/ students/ recitation/ attending/ competition/ more?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'Which is the meaningful sentence from the given jumbled words: than/ are/ the/ poem/ two/ students/ recitation/ attending/ competition/ more?', E'More than two students are attending the poem recitation competition.', E'The poem recitation competition are more than two students attending.', E'Two students are more than attending the poem recitation competition.', E'More than two students are competition the poem recitation attending.', E'A', E'**दिइएका शब्दहरूलाई मिलाउँदा अर्थपूर्ण वाक्य ''More than two students are attending the poem recitation competition.'' बन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:Which is the meaningful sentence from the given jumbled words: than/ are/ the/ poem/ two/ students/ recitation/ attending/ competition/ more?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'Which is the meaningful sentence from the given jumbled words: today/ go/ to/ school/ as/ I/ a lot of/ homework/ to/ do/ didn''t/ I/ had?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'Which is the meaningful sentence from the given jumbled words: today/ go/ to/ school/ as/ I/ a lot of/ homework/ to/ do/ didn''t/ I/ had?', E'I didn''t go school as I had a lot of homework to do today.', E'I didn''t go to school today as I had a lot of homework to do.', E'I go to school as I had didn''t a lot of homework to do today.', E'Today I had go to school as I had didn''t a lot of homework to do.', E'B', E'**दिइएका शब्दहरूलाई मिलाउँदा अर्थपूर्ण वाक्य ''I didn''t go to school today as I had a lot of homework to do.'' बन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:Which is the meaningful sentence from the given jumbled words: today/ go/ to/ school/ as/ I/ a lot of/ homework/ to/ do/ didn''t/ I/ had?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल A, B, C, D मा दिइएका शब्द समूहहरूलाई मिलाएर अर्थपूर्ण वाक्य बनाउनुहोस्: a. To make it because / b. I will be able / c. I missed the bus / d. I don''t think');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'तल A, B, C, D मा दिइएका शब्द समूहहरूलाई मिलाएर अर्थपूर्ण वाक्य बनाउनुहोस्: a. To make it because / b. I will be able / c. I missed the bus / d. I don''t think', E'a b c d', E'b c d a', E'd b a c', E'd c a b', E'C', E'**सही क्रम d-b-a-c हो, जसले ''I don''t think I will be able to make it because I missed the bus.'' वाक्य बनाउँछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल A, B, C, D मा दिइएका शब्द समूहहरूलाई मिलाएर अर्थपूर्ण वाक्य बनाउनुहोस्: a. To make it because / b. I will be able / c. I missed the bus / d. I don''t think'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिएको शब्द ''PHOTOSYNTHETIC'' का अक्षरहरूमा एक-एक पटक मात्र प्रयोग गरेर विकल्पमध्ये कुन शब्द बनाउन सकिँदैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'तल दिएको शब्द ''PHOTOSYNTHETIC'' का अक्षरहरूमा एक-एक पटक मात्र प्रयोग गरेर विकल्पमध्ये कुन शब्द बनाउन सकिँदैन?', E'THOSE', E'SCENT', E'COTTON', E'PRONE', E'D', E'**PHOTOSYNTHETIC मा अक्षर ''R'' छैन, त्यसैले PRONE शब्द यसका अक्षरहरू प्रयोग गरी बनाउन सकिँदैन।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिएको शब्द ''PHOTOSYNTHETIC'' का अक्षरहरूमा एक-एक पटक मात्र प्रयोग गरेर विकल्पमध्ये कुन शब्द बनाउन सकिँदैन?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिएको शब्द ''PROSPECTIVE'' का अक्षरहरूमा एक-एक पटक मात्र प्रयोग गरेर विकल्पमध्ये कुन शब्द बनाउन सकिँदैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'तल दिएको शब्द ''PROSPECTIVE'' का अक्षरहरूमा एक-एक पटक मात्र प्रयोग गरेर विकल्पमध्ये कुन शब्द बनाउन सकिँदैन?', E'PEPPER', E'PEPTIC', E'VECTOR', E'RESET', E'A', E'**PROSPECTIVE मा ''P'' अक्षर जम्मा २ वटा मात्र छ, तर PEPPER बनाउन ३ वटा ''P'' चाहिन्छ — त्यसैले PEPPER बनाउन सकिँदैन।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिएको शब्द ''PROSPECTIVE'' का अक्षरहरूमा एक-एक पटक मात्र प्रयोग गरेर विकल्पमध्ये कुन शब्द बनाउन सकिँदैन?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका शब्दहरूलाई तार्किक क्रममा राख्नुहोस्: (क) नतिजा (ख) प्रतीक्षा (ग) परीक्षा (घ) तत्परता (ङ) मनन');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'तलका शब्दहरूलाई तार्किक क्रममा राख्नुहोस्: (क) नतिजा (ख) प्रतीक्षा (ग) परीक्षा (घ) तत्परता (ङ) मनन', E'ग, क, घ, ख, ङ', E'घ, ग, ख, क, ङ', E'ख, क, ग, घ, ङ', E'ङ, ग, ख, क, घ', E'B', E'**तार्किक क्रम: तत्परता (तयारी) → परीक्षा (दिनु) → प्रतीक्षा (नतिजाको) → नतिजा (आउनु) → मनन (नतिजामाथि विचार गर्नु)।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका शब्दहरूलाई तार्किक क्रममा राख्नुहोस्: (क) नतिजा (ख) प्रतीक्षा (ग) परीक्षा (घ) तत्परता (ङ) मनन'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिइएका शब्दहरूलाई तार्किक क्रममा राख्नुहोस्: (1) Restaurant (2) Eating (3) Cooking (4) Order food (5) Serve food');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'दिइएका शब्दहरूलाई तार्किक क्रममा राख्नुहोस्: (1) Restaurant (2) Eating (3) Cooking (4) Order food (5) Serve food', E'2, 3, 1, 5, 4', E'4, 5, 3, 2, 1', E'1, 4, 3, 5, 2', E'1, 3, 4, 2, 5', E'C', E'**तार्किक क्रम: रेस्टुरेन्ट पुग्नु → खाना अर्डर गर्नु → पकाउनु → पस्किनु → खानु (1, 4, 3, 5, 2)।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिइएका शब्दहरूलाई तार्किक क्रममा राख्नुहोस्: (1) Restaurant (2) Eating (3) Cooking (4) Order food (5) Serve food'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  RAISE NOTICE 'ङ-१ शाब्दिक बौद्धिक परीक्षण upsert complete: 5 sets, 35 questions.';
END $$;
