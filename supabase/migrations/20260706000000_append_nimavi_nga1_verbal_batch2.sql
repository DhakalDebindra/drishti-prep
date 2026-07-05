-- Append 2nd verbal-reasoning batch into the EXISTING ङ-१ शाब्दिक बौद्धिक परीक्षण sets (all below 30Q cap).
-- Does NOT create new question_sets rows -- reuses the same deterministic set UUID and continues order_number.
-- Generated 2026-07-05T12:28:23.948Z.
DO $$
DECLARE
  v_set_id uuid;
  v_q_id uuid;
BEGIN

  -- Append into: शाब्दिक बौद्धिक परीक्षणः शब्द ज्ञान (आधारभूत तह) (+5 Q, starting order 5)
  v_set_id := extensions.uuid_generate_v5('7d4b6d71-7451-4e67-91fe-5323380a3258'::uuid, E'शाब्दिक बौद्धिक परीक्षणः शब्द ज्ञान (आधारभूत तह)');

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन शब्दको हिज्जे (Spelling) सही छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'तलका मध्ये कुन शब्दको हिज्जे (Spelling) सही छ?', E'आशीर्वाद', E'आशिर्बाद', E'आसीर्वाद', E'आशिर्वाद', E'A', E'**नेपाली व्याकरण अनुसार ''आशीर्वाद'' सही हिज्जे हो (श मा दीर्घ ''ई'' र व माथि रेफ)।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन शब्दको हिज्जे (Spelling) सही छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''उक्ति'' शब्दको अर्थ के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'''उक्ति'' शब्दको अर्थ के हो?', E'काम', E'भनाइ वा कथन', E'उपाय', E'कथा', E'B', E'**उक्ति भनेको कसैले भनेको कुरा वा कथन (Statement/Saying) हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''उक्ति'' शब्दको अर्थ के हो?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''अकिञ्चन'' शब्दले के जनाउँछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'''अकिञ्चन'' शब्दले के जनाउँछ?', E'धेरै धन भएको', E'ज्ञानी', E'केही नभएको वा गरिब', E'मुर्ख', E'C', E'**अकिञ्चन भनेको अत्यन्त गरिब, जसको आफ्नो भन्नु केही छैन भन्ने बुझिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''अकिञ्चन'' शब्दले के जनाउँछ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''मृगतृष्णा'' शब्दको सही अर्थ के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'''मृगतृष्णा'' शब्दको सही अर्थ के हो?', E'मृगले पानी खाने ठाउँ', E'मृगको शिकार', E'जंगलको बाटो', E'प्राप्त गर्न नसकिने झुटो आशा', E'D', E'**मरुभूमिमा टाढाबाट पानी जस्तो देखिने तर नजिक जाँदा बालुवा मात्र हुने भ्रमलाई मृगतृष्णा (Mirage) भनिन्छ, जसको अर्थ झुटो आशा हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''मृगतृष्णा'' शब्दको सही अर्थ के हो?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन शब्दले ''सूर्य'' लाई बुझाउँदैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'तलका मध्ये कुन शब्दले ''सूर्य'' लाई बुझाउँदैन?', E'सुधाकर', E'दिनकर', E'भास्कर', E'दिवाकर', E'A', E'**सुधाकर भनेको चन्द्रमा (Moon) हो। दिनकर, भास्कर र दिवाकर सबै सूर्यका पर्यायवाची शब्द हुन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन शब्दले ''सूर्य'' लाई बुझाउँदैन?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Append into: शाब्दिक बौद्धिक परीक्षणः समरूपता/Analogies (आधारभूत तह) (+5 Q, starting order 7)
  v_set_id := extensions.uuid_generate_v5('91240d83-acef-40dd-9fa2-412f8b797e45'::uuid, E'शाब्दिक बौद्धिक परीक्षणः समरूपता/Analogies (आधारभूत तह)');

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'घडी : समय : : थर्मोमिटर : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'घडी : समय : : थर्मोमिटर : ?', E'ज्वरो (तापक्रम)', E'बिरामी', E'डाक्टर', E'औषधि', E'A', E'**घडीले समय नापेजस्तै थर्मोमिटरले तापक्रम (ज्वरो) नाप्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:घडी : समय : : थर्मोमिटर : ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'आँखा : दृष्टि : : कान : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'आँखा : दृष्टि : : कान : ?', E'ध्वनि', E'सुन्नु (श्रवण)', E'संगीत', E'बोल्नु', E'B', E'**आँखाको काम देख्नु (दृष्टि) हो भने कानको काम सुन्नु (श्रवण) हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:आँखा : दृष्टि : : कान : ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'बाघ : मांसाहारी : : गाई : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'बाघ : मांसाहारी : : गाई : ?', E'जनावर', E'दुध', E'शाकाहारी', E'गोठ', E'C', E'**बाघ मांसाहारी (मासु खाने) जनावर हो भने गाई शाकाहारी (घाँसपात खाने) जनावर हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:बाघ : मांसाहारी : : गाई : ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'हिमाल : आरोहण : : नदी : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'हिमाल : आरोहण : : नदी : ?', E'पानी', E'डुंगा', E'माछा', E'पौडी (तैरिनु)', E'D', E'**हिमालमा आरोहण (Climbing) गरिन्छ भने नदीमा पौडी खेलिन्छ वा तरिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:हिमाल : आरोहण : : नदी : ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षक : विद्यालय : : डाक्टर : ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'शिक्षक : विद्यालय : : डाक्टर : ?', E'अस्पताल', E'बिरामी', E'औषधि', E'नर्स', E'A', E'**शिक्षकको कार्यथलो विद्यालय भएजस्तै डाक्टरको कार्यथलो अस्पताल हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षक : विद्यालय : : डाक्टर : ?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Append into: शाब्दिक बौद्धिक परीक्षणः शाब्दिक वर्गीकरण (आधारभूत तह) (+5 Q, starting order 5)
  v_set_id := extensions.uuid_generate_v5('ae5f551c-9daa-4651-bf85-7891ea89c25c'::uuid, E'शाब्दिक बौद्धिक परीक्षणः शाब्दिक वर्गीकरण (आधारभूत तह)');

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा नमिल्ने शब्द छान्नुहोस्।');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'समूहमा नमिल्ने शब्द छान्नुहोस्।', E'गोलभेडा', E'आलु', E'गाजर', E'मुला', E'A', E'**आलु, गाजर र मुला जमिनमुनि फल्छन् भने गोलभेडा जमिनमाथि बोटमा फल्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा नमिल्ने शब्द छान्नुहोस्।'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये कुन अरुभन्दा फरक छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'तलका मध्ये कुन अरुभन्दा फरक छ?', E'कापर (तामा)', E'पित्तल', E'फलाम', E'सिल्भर (चाँदी)', E'B', E'**तामा, फलाम र चाँदी तत्त्व (Elements) हुन् तर पित्तल दुई धातु (तामा र जस्ता) मिलेर बनेको मिश्रित धातु (Alloy) हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये कुन अरुभन्दा फरक छ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समूहमा अमिल्दो शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'समूहमा अमिल्दो शब्द कुन हो?', E'गितार', E'भायोलिन', E'बाँसुरी', E'सारङ्गी', E'C', E'**गितार, भायोलिन र सारङ्गी तार (String) बाट बजाइने बाजा हुन् भने बाँसुरी फुकेर (Wind) बजाइने बाजा हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समूहमा अमिल्दो शब्द कुन हो?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नमिल्ने शब्द पहिचान गर्नुहोस्।');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'नमिल्ने शब्द पहिचान गर्नुहोस्।', E'बाघ', E'सिंह', E'चितुवा', E'स्याल', E'D', E'**बाघ, सिंह र चितुवा बिरालो प्रजाति (Cat family) का ठूला जनावर हुन्, तर स्याल कुकुर प्रजाति (Dog family) मा पर्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नमिल्ने शब्द पहिचान गर्नुहोस्।'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुन शब्द अन्यभन्दा फरक छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'कुन शब्द अन्यभन्दा फरक छ?', E'फेब्रुअरी', E'डिसेम्बर', E'जनवरी', E'मार्च', E'A', E'**डिसेम्बर, जनवरी र मार्च महिनामा ३१ दिन हुन्छन्, तर फेब्रुअरीमा २८ वा २९ दिन मात्र हुन्छन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुन शब्द अन्यभन्दा फरक छ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Append into: शाब्दिक बौद्धिक परीक्षणः विपरीतार्थक र समानार्थी शब्द (आधारभूत तह) (+5 Q, starting order 15)
  v_set_id := extensions.uuid_generate_v5('075f71e5-93ca-40d5-8bbb-f671e74eab47'::uuid, E'शाब्दिक बौद्धिक परीक्षणः विपरीतार्थक र समानार्थी शब्द (आधारभूत तह)');

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''अनुराग'' शब्दको विपरीतार्थक शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'''अनुराग'' शब्दको विपरीतार्थक शब्द कुन हो?', E'विराग', E'प्रेम', E'घृणा', E'रिस', E'A', E'**अनुराग भनेको प्रेम वा आकर्षण हो, यसको उल्टो ''विराग'' (अनाकर्षण वा विरक्ति) हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''अनुराग'' शब्दको विपरीतार्थक शब्द कुन हो?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''अल्पायु'' को उल्टो अर्थ दिने शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'''अल्पायु'' को उल्टो अर्थ दिने शब्द कुन हो?', E'चिरञ्जीवी', E'दीर्घायु', E'अमर', E'युवा', E'B', E'**अल्पायु (छोटो आयु) को ठ्याक्कै उल्टो शब्द दीर्घायु (लामो आयु) हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''अल्पायु'' को उल्टो अर्थ दिने शब्द कुन हो?'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तलका मध्ये ''जंगल'' को समानार्थी शब्द कुन होइन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'तलका मध्ये ''जंगल'' को समानार्थी शब्द कुन होइन?', E'वन', E'अरण्य', E'उद्यान', E'कानन', E'C', E'**वन, अरण्य र कानन भनेको जंगल (Forest) हो, तर उद्यान भनेको बगैँचा (Park/Garden) हो जहाँ रुखबिरुवा योजनाबद्ध रूपमा लगाइएको हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तलका मध्ये ''जंगल'' को समानार्थी शब्द कुन होइन?'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''सज्जन'' शब्दको विपरीतार्थक शब्द के हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'''सज्जन'' शब्दको विपरीतार्थक शब्द के हुन्छ?', E'मूर्ख', E'खराब', E'पापी', E'दुर्जन', E'D', E'**सज्जन (राम्रो मानिस) को उल्टो दुर्जन (खराब मानिस) हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''सज्जन'' शब्दको विपरीतार्थक शब्द के हुन्छ?'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''अग्नि'' (आगो) को समानार्थी (पर्यायवाची) शब्द कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'''अग्नि'' (आगो) को समानार्थी (पर्यायवाची) शब्द कुन हो?', E'अनल', E'अनिल', E'अम्बर', E'अवनी', E'A', E'**अनल भनेको आगो हो। (अनिल भनेको हावा, अम्बर भनेको आकाश र अवनी भनेको पृथ्वी हो।)**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''अग्नि'' (आगो) को समानार्थी (पर्यायवाची) शब्द कुन हो?'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Append into: शाब्दिक बौद्धिक परीक्षणः शाब्दिक पजल र अमिल्दा शब्द (आधारभूत तह) (+5 Q, starting order 8)
  v_set_id := extensions.uuid_generate_v5('fa0af7e0-6bb7-4c25-b62f-d2d8ce99f610'::uuid, E'शाब्दिक बौद्धिक परीक्षणः शाब्दिक पजल र अमिल्दा शब्द (आधारभूत तह)');

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिएका अक्षरहरू ''M L A N I A'' लाई मिलाएर एउटा अर्थपूर्ण शब्द बनाउँदा कुन शब्द बन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'तल दिएका अक्षरहरू ''M L A N I A'' लाई मिलाएर एउटा अर्थपूर्ण शब्द बनाउँदा कुन शब्द बन्छ?', E'ANIMAL', E'MANIAL', E'LAMINA', E'ALMANI', E'A', E'**M, L, A, N, I, A अक्षरहरूलाई सही क्रममा राख्दा ANIMAL (जनावर) बन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिएका अक्षरहरू ''M L A N I A'' लाई मिलाएर एउटा अर्थपूर्ण शब्द बनाउँदा कुन शब्द बन्छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'अक्षरहरू ''K C O L C'' लाई सही क्रममा मिलाउँदा बन्ने शब्द के सँग सम्बन्धित छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'अक्षरहरू ''K C O L C'' लाई सही क्रममा मिलाउँदा बन्ने शब्द के सँग सम्बन्धित छ?', E'दिशा', E'समय', E'तापक्रम', E'तौल', E'B', E'**K C O L C लाई मिलाउँदा ''CLOCK'' (घडी) बन्छ, जुन समय (Time) सँग सम्बन्धित छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:अक्षरहरू ''K C O L C'' लाई सही क्रममा मिलाउँदा बन्ने शब्द के सँग सम्बन्धित छ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि अंग्रेजी वर्णमालाका अक्षरहरूलाई उल्टो क्रममा (Z देखि A सम्म) लेख्ने हो भने ''L'' को स्थानमा कुन अक्षर पर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'यदि अंग्रेजी वर्णमालाका अक्षरहरूलाई उल्टो क्रममा (Z देखि A सम्म) लेख्ने हो भने ''L'' को स्थानमा कुन अक्षर पर्छ?', E'M', E'P', E'O', E'N', E'C', E'**सुल्टो क्रममा L को स्थान १२ औं हो। उल्टो क्रमबाट हेर्दा (२७-१२=१५) औं अक्षर, जुन ''O'' हो, त्यही स्थानमा पर्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि अंग्रेजी वर्णमालाका अक्षरहरूलाई उल्टो क्रममा (Z देखि A सम्म) लेख्ने हो भने ''L'' को स्थानमा कुन अक्षर पर्छ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''R, E, A, D, E, R'' अक्षरहरू मिलाएर पढ्नसँग सम्बन्धित एउटा शब्द बनाउनुहोस्। त्यस शब्दको अन्तिम अक्षर कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'''R, E, A, D, E, R'' अक्षरहरू मिलाएर पढ्नसँग सम्बन्धित एउटा शब्द बनाउनुहोस्। त्यस शब्दको अन्तिम अक्षर कुन हो?', E'E', E'D', E'A', E'R', E'D', E'**ती अक्षरहरू मिलाउँदा ''READER'' बन्छ (पढ्ने मान्छे)। यसको अन्तिम अक्षर R हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''R, E, A, D, E, R'' अक्षरहरू मिलाएर पढ्नसँग सम्बन्धित एउटा शब्द बनाउनुहोस्। त्यस शब्दको अन्तिम अक्षर कुन हो?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि कुनै कोड भाषामा ''WATER'' लाई ''RETAW'' लेखिन्छ भने सोही नियम अनुसार ''TEACH'' लाई कसरी लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'यदि कुनै कोड भाषामा ''WATER'' लाई ''RETAW'' लेखिन्छ भने सोही नियम अनुसार ''TEACH'' लाई कसरी लेखिन्छ?', E'HCAET', E'CHEAT', E'HCEAT', E'HTEAC', E'A', E'**यहाँ शब्दलाई पछाडिबाट अगाडि (उल्टो) लेखिएको छ। TEACH लाई उल्टोबाट लेख्दा HCAET हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि कुनै कोड भाषामा ''WATER'' लाई ''RETAW'' लेखिन्छ भने सोही नियम अनुसार ''TEACH'' लाई कसरी लेखिन्छ?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  RAISE NOTICE 'ङ-१ verbal batch-2 append complete: 25 questions added across 5 existing sets.';
END $$;
