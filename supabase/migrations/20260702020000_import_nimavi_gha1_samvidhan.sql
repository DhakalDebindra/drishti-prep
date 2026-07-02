-- Idempotent UPSERT import: निमावि प्रथम पत्र — unit घ-१ नेपालको संविधान (Level I topic-wise sets)
-- Override same-identity sets/questions; never deletes. Generated 2026-07-02T09:03:03.074Z.
DO $$
DECLARE
  v_module_id uuid := '6695669a-f40e-421a-a4ec-b09bbeaf56c4'::uuid;
  v_set_id uuid;
  v_q_id uuid;
BEGIN

  -- Set: नेपालको संविधान: मौलिक हक (आधारभूत तह) (13 Q)
  v_set_id := extensions.uuid_generate_v5('09a79d79-6d92-4687-bb88-f7eef73dc145'::uuid, E'नेपालको संविधान: मौलिक हक (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '38021473-9cb4-45f3-8719-3a141424b498'::uuid, '09a79d79-6d92-4687-bb88-f7eef73dc145'::uuid, E'नेपालको संविधान: मौलिक हक (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '09a79d79-6d92-4687-bb88-f7eef73dc145'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'ट्रेड युनियन खोल्ने र संगठित हुन पाउने हक नेपालको संविधानको कुन मौलिक हक अन्तर्गत पर्दछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'ट्रेड युनियन खोल्ने र संगठित हुन पाउने हक नेपालको संविधानको कुन मौलिक हक अन्तर्गत पर्दछ?', E'स्वतन्त्रताको हक', E'समानताको हक', E'राजनीतिक स्वतन्त्रताको हक', E'श्रम सम्बन्धी हक', E'D', E'**ट्रेड युनियन खोल्ने र संगठित हुन पाउने हक धारा ३४ को श्रम सम्बन्धी हक अन्तर्गत पर्दछ।**\\n- स्वतन्त्रताको हक (धारा १७) ले विचार, अभिव्यक्ति, पेसा-व्यवसाय जस्ता स्वतन्त्रता समेट्छ।\\n- समानताको हक (धारा १८) ले कानूनको समान संरक्षणको प्रत्याभूति दिन्छ।\\n- राजनीतिक स्वतन्त्रताको हक (धारा ३७) ले राजनीतिक दल खोल्ने अधिकार दिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:ट्रेड युनियन खोल्ने र संगठित हुन पाउने हक नेपालको संविधानको कुन मौलिक हक अन्तर्गत पर्दछ?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''कसैलाई पनि मृत्युदण्डको सजाय दिनेगरी कानुन बनाउन पाइँदैन'' भन्ने व्यवस्था नेपालको संविधानको कुन मौलिक हकमा गरिएको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'''कसैलाई पनि मृत्युदण्डको सजाय दिनेगरी कानुन बनाउन पाइँदैन'' भन्ने व्यवस्था नेपालको संविधानको कुन मौलिक हकमा गरिएको छ?', E'सम्मानपूर्वक बाँच्न पाउने हक', E'समानताको हक', E'न्याय सम्बन्धी हक', E'यातना विरुद्धको हक', E'A', E'**मृत्युदण्डको सजाय दिन नहुने व्यवस्था धारा १६ को सम्मानपूर्वक बाँच्न पाउने हक अन्तर्गत रहेको छ।**\\nनोट: यही धारामा कसैलाई पनि अंगभंग वा शारीरिक, मानसिक यातना दिन नहुने व्यवस्था पनि समावेश छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''कसैलाई पनि मृत्युदण्डको सजाय दिनेगरी कानुन बनाउन पाइँदैन'' भन्ने व्यवस्था नेपालको संविधानको कुन मौलिक हकमा गरिएको छ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालको संविधान, २०७२ बमोजिम राष्ट्रभाषा भन्नाले के बुझिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'नेपालको संविधान, २०७२ बमोजिम राष्ट्रभाषा भन्नाले के बुझिन्छ?', E'नेपाली भाषा मात्र', E'अङ्ग्रेजी भाषा', E'नेपालमा बोलिने सबै मातृभाषा', E'अङ्ग्रेजी र नेपाली भाषा', E'C', E'**धारा ६ बमोजिम नेपालमा बोलिने सबै मातृभाषा राष्ट्रभाषा हुन्।**\\nनोट: नेपाली भाषा भने सरकारी कामकाजको भाषा (देवनागरी लिपिमा) हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालको संविधान, २०७२ बमोजिम राष्ट्रभाषा भन्नाले के बुझिन्छ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालको राष्ट्रिय गान नेपालको संविधान, २०७२ को कुन अनुसूचीमा उल्लेख गरिएको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'नेपालको राष्ट्रिय गान नेपालको संविधान, २०७२ को कुन अनुसूचीमा उल्लेख गरिएको छ?', E'अनुसूची १', E'अनुसूची २', E'अनुसूची ४', E'अनुसूची ५', E'B', E'**नेपालको राष्ट्रिय गान अनुसूची २ मा उल्लेख गरिएको छ।**\\nनोट: झन्डाको बनोट र नक्सा भने धारा ९ अन्तर्गत अनुसूची १ मा छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालको राष्ट्रिय गान नेपालको संविधान, २०७२ को कुन अनुसूचीमा उल्लेख गरिएको छ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'प्रत्येक किसानलाई कृषि कार्यका लागि भूमिमा पहुँच र परम्परागत स्थानीय बिउबिजनको छनोट तथा संरक्षणको हक कुन मौलिक हक अन्तर्गत पर्दछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'प्रत्येक किसानलाई कृषि कार्यका लागि भूमिमा पहुँच र परम्परागत स्थानीय बिउबिजनको छनोट तथा संरक्षणको हक कुन मौलिक हक अन्तर्गत पर्दछ?', E'स्वच्छ वातावरण सम्बन्धी हक', E'उपभोक्ताको हक', E'सामाजिक न्यायको हक', E'खाद्य सम्बन्धी हक', E'C', E'**किसानको भूमि पहुँच र बिउबिजन संरक्षणको हक धारा ४२ को सामाजिक न्यायको हक अन्तर्गत पर्दछ।**\\n- खाद्य सम्बन्धी हक (धारा ३६) ले खाद्यवस्तुको सुरक्षा र पहुँचमा केन्द्रित छ।\\n- उपभोक्ताको हक (धारा ४४) ले गुणस्तरीय वस्तु तथा सेवा पाउने कुरा समेट्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:प्रत्येक किसानलाई कृषि कार्यका लागि भूमिमा पहुँच र परम्परागत स्थानीय बिउबिजनको छनोट तथा संरक्षणको हक कुन मौलिक हक अन्तर्गत पर्दछ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालमा बसोबास गर्ने प्रत्येक नेपाली समुदायलाई आफ्नो भाषा, लिपि, संस्कृति, सभ्यता र सम्पदाको सम्वर्धन र संरक्षण गर्न पाउने व्यवस्था कुन मौलिक हक अन्तर्गत पर्दछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'नेपालमा बसोबास गर्ने प्रत्येक नेपाली समुदायलाई आफ्नो भाषा, लिपि, संस्कृति, सभ्यता र सम्पदाको सम्वर्धन र संरक्षण गर्न पाउने व्यवस्था कुन मौलिक हक अन्तर्गत पर्दछ?', E'भाषा तथा संस्कृतिको हक', E'समानताको हक', E'धार्मिक स्वतन्त्रताको हक', E'सामाजिक न्यायको हक', E'A', E'**यो व्यवस्था धारा ३२ को भाषा तथा संस्कृतिको हक अन्तर्गत पर्दछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालमा बसोबास गर्ने प्रत्येक नेपाली समुदायलाई आफ्नो भाषा, लिपि, संस्कृति, सभ्यता र सम्पदाको सम्वर्धन र संरक्षण गर्न पाउने व्यवस्था कुन मौलिक हक अन्तर्गत पर्दछ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''लैङ्गिक भेदभाव बिना समान वंशीय हक हुने'' भन्ने व्यवस्था कुन मौलिक हक अन्तर्गत पर्दछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'''लैङ्गिक भेदभाव बिना समान वंशीय हक हुने'' भन्ने व्यवस्था कुन मौलिक हक अन्तर्गत पर्दछ?', E'भेदभाव विरुद्धको हक', E'महिलाको हक', E'सामाजिक न्यायको हक', E'समानताको हक', E'B', E'**यो व्यवस्था धारा ३८ को महिलाको हक अन्तर्गत पर्दछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''लैङ्गिक भेदभाव बिना समान वंशीय हक हुने'' भन्ने व्यवस्था कुन मौलिक हक अन्तर्गत पर्दछ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''प्रत्येक श्रमिकलाई योगदानमा आधारित सामाजिक सुरक्षाको हक हुनेछ'' भन्ने व्यवस्था कुन मौलिक हक अन्तर्गत पर्दछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'''प्रत्येक श्रमिकलाई योगदानमा आधारित सामाजिक सुरक्षाको हक हुनेछ'' भन्ने व्यवस्था कुन मौलिक हक अन्तर्गत पर्दछ?', E'रोजगारीको हक', E'समानताको हक', E'श्रमको हक', E'स्वच्छ वातावरणको हक', E'C', E'**यो व्यवस्था धारा ३४ को श्रमको हक अन्तर्गत पर्दछ।**\\nनोट: रोजगारीको हक (धारा ३३) ले बेरोजगार भत्ता र रोजगारी छनोटको हकमा केन्द्रित छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''प्रत्येक श्रमिकलाई योगदानमा आधारित सामाजिक सुरक्षाको हक हुनेछ'' भन्ने व्यवस्था कुन मौलिक हक अन्तर्गत पर्दछ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालको संविधान, २०७२ को कुन धाराबाट कुन धारासम्म मौलिक हकहरूको व्यवस्था गरिएको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'नेपालको संविधान, २०७२ को कुन धाराबाट कुन धारासम्म मौलिक हकहरूको व्यवस्था गरिएको छ?', E'धारा १५ देखि ४६ सम्म', E'धारा १६ देखि ४८ सम्म', E'धारा १५ देखि ४५ सम्म', E'धारा १६ देखि ४६ सम्म', E'D', E'**संविधानको भाग ३ अन्तर्गत धारा १६ देखि ४६ सम्म जम्मा ३१ वटा मौलिक हकको व्यवस्था गरिएको छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालको संविधान, २०७२ को कुन धाराबाट कुन धारासम्म मौलिक हकहरूको व्यवस्था गरिएको छ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालको संविधान, २०७२ बमोजिम मौलिक हकको कार्यान्वयनका लागि राज्यले संविधान प्रारम्भ भएको कति समयभित्र कानूनी व्यवस्था गर्नुपर्ने प्रावधान छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'नेपालको संविधान, २०७२ बमोजिम मौलिक हकको कार्यान्वयनका लागि राज्यले संविधान प्रारम्भ भएको कति समयभित्र कानूनी व्यवस्था गर्नुपर्ने प्रावधान छ?', E'दुई वर्ष', E'तीन वर्ष', E'चार वर्ष', E'पाँच वर्ष', E'B', E'**धारा ४७ बमोजिम मौलिक हकको कार्यान्वयनका लागि राज्यले संविधान प्रारम्भ भएको मितिले तीन वर्षभित्र आवश्यक कानूनी व्यवस्था गर्नुपर्दछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालको संविधान, २०७२ बमोजिम मौलिक हकको कार्यान्वयनका लागि राज्यले संविधान प्रारम्भ भएको कति समयभित्र कानूनी व्यवस्था गर्नुपर्ने प्रावधान छ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालको संविधान, २०७२ बमोजिम माध्यमिक तहसम्म निःशुल्क शिक्षा पाउने हक तलकामध्ये कसलाई हुनेछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'नेपालको संविधान, २०७२ बमोजिम माध्यमिक तहसम्म निःशुल्क शिक्षा पाउने हक तलकामध्ये कसलाई हुनेछ?', E'दुर्गम क्षेत्रमा बसोबास गर्ने नागरिकलाई मात्र', E'शिक्षाको क्षेत्रमा पछाडि परेका समुदायलाई मात्र', E'प्रत्येक नागरिकलाई', E'आर्थिक रूपले विपन्न समुदायलाई मात्र', E'C', E'**धारा ३१ बमोजिम आधारभूत शिक्षा अनिवार्य र निःशुल्क तथा माध्यमिक तहसम्मको शिक्षा प्रत्येक नागरिकलाई निःशुल्क हुनेछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालको संविधान, २०७२ बमोजिम माध्यमिक तहसम्म निःशुल्क शिक्षा पाउने हक तलकामध्ये कसलाई हुनेछ?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा सम्बन्धी मौलिक हकको सन्दर्भमा नेपालको संविधानमा उल्लेख नभएको विषय तलका मध्ये कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'शिक्षा सम्बन्धी मौलिक हकको सन्दर्भमा नेपालको संविधानमा उल्लेख नभएको विषय तलका मध्ये कुन हो?', E'महिलालाई शिक्षामा सकारात्मक विभेदका आधारमा विशेष अवसरको हक', E'प्रत्येक बालबालिकालाई निःशुल्क उच्च शिक्षा पाउने हक', E'प्रत्येक व्यक्तिलाई आधारभूत शिक्षासम्म पहुँचको हक', E'आर्थिक रूपले विपन्न नागरिकलाई कानुनबमोजिम निःशुल्क उच्च शिक्षा पाउने हक', E'B', E'**धारा ३१ ले सबै बालबालिकालाई होइन, दलित, अपाङ्गता भएका र आर्थिक रूपले विपन्न नागरिकलाई मात्र कानुनबमोजिम निःशुल्क उच्च शिक्षा पाउने हक दिएको छ।**\\nनोट: दृष्टिविहीनलाई ब्रेललिपि र बहिराका लागि साङ्केतिक भाषामार्फत निःशुल्क उच्च शिक्षा पाउने व्यवस्था पनि यसै धारामा छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा सम्बन्धी मौलिक हकको सन्दर्भमा नेपालको संविधानमा उल्लेख नभएको विषय तलका मध्ये कुन हो?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालको संविधान, २०७२ बमोजिम प्रत्येक नेपाली समुदायलाई कानूनी व्यवस्था भएबमोजिम कुन भाषामा शिक्षा प्राप्त गर्ने हक हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'नेपालको संविधान, २०७२ बमोजिम प्रत्येक नेपाली समुदायलाई कानूनी व्यवस्था भएबमोजिम कुन भाषामा शिक्षा प्राप्त गर्ने हक हुन्छ?', E'नेपाली भाषा मात्र', E'अङ्ग्रेजी भाषा', E'राष्ट्रिय सभाले तोकेको भाषा', E'मातृभाषा', E'D', E'**धारा ३१ बमोजिम हरेक नेपाली समुदायलाई कानुनबमोजिम आफ्नो मातृभाषामा शिक्षा पाउने र त्यसका लागि विद्यालय तथा शैक्षिक संस्था खोल्ने र सञ्चालन गर्ने हक हुनेछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालको संविधान, २०७२ बमोजिम प्रत्येक नेपाली समुदायलाई कानूनी व्यवस्था भएबमोजिम कुन भाषामा शिक्षा प्राप्त गर्ने हक हुन्छ?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: नेपालको संविधान: राज्यका निर्देशक सिद्धान्त, नीति र नागरिकको कर्तव्य (आधारभूत तह) (7 Q)
  v_set_id := extensions.uuid_generate_v5('2c23f91e-ebb0-4c64-bd5c-e68c58834ac8'::uuid, E'नेपालको संविधान: राज्यका निर्देशक सिद्धान्त, नीति र नागरिकको कर्तव्य (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '38021473-9cb4-45f3-8719-3a141424b498'::uuid, '2c23f91e-ebb0-4c64-bd5c-e68c58834ac8'::uuid, E'नेपालको संविधान: राज्यका निर्देशक सिद्धान्त, नीति र नागरिकको कर्तव्य (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '2c23f91e-ebb0-4c64-bd5c-e68c58834ac8'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालको संविधान, २०७२ मा राज्यका निर्देशक सिद्धान्त, नीति तथा दायित्व कुन भागमा व्यवस्था गरिएको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'नेपालको संविधान, २०७२ मा राज्यका निर्देशक सिद्धान्त, नीति तथा दायित्व कुन भागमा व्यवस्था गरिएको छ?', E'भाग २', E'भाग ३', E'भाग ४', E'भाग ५', E'C', E'**राज्यका निर्देशक सिद्धान्त, नीति तथा दायित्व भाग ४ मा व्यवस्था गरिएको छ।**\\n- भाग ३ मौलिक हकसम्बन्धी छ।\\n- भाग ५ राज्यको संरचना र राज्यशक्तिको बाँडफाँडसम्बन्धी छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालको संविधान, २०७२ मा राज्यका निर्देशक सिद्धान्त, नीति तथा दायित्व कुन भागमा व्यवस्था गरिएको छ?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालको संविधान, २०७२ को धारा ५१ बमोजिम राज्यका कति वटा नीतिहरू समावेश गरिएका छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'नेपालको संविधान, २०७२ को धारा ५१ बमोजिम राज्यका कति वटा नीतिहरू समावेश गरिएका छन्?', E'१२', E'१३', E'१०', E'११', E'D', E'**धारा ५१ मा राज्यका ११ वटा नीतिहरू समावेश गरिएका छन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालको संविधान, २०७२ को धारा ५१ बमोजिम राज्यका कति वटा नीतिहरू समावेश गरिएका छन्?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नागरिकका आधारभूत आवश्यकता सम्बन्धी नीतिमा उल्लिखित शिक्षासम्बन्धी व्यवस्थाहरूमा तलकामध्ये कुन पर्दैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'नागरिकका आधारभूत आवश्यकता सम्बन्धी नीतिमा उल्लिखित शिक्षासम्बन्धी व्यवस्थाहरूमा तलकामध्ये कुन पर्दैन?', E'शिक्षा क्षेत्रमा भएको निजी लगानीलाई नियमन र व्यवस्थापन गरी सेवामूलक बनाउने', E'वैज्ञानिक, प्राविधिक, बौद्धिक र विशिष्ट प्रतिभाहरूको संरक्षण गर्ने', E'आधारभूत शिक्षालाई अनिवार्य, निःशुल्क र गुणस्तरीय बनाउँदै लैजाने', E'उच्च शिक्षालाई सहज, गुणस्तरीय र पहुँचयोग्य बनाई क्रमशः निःशुल्क बनाउँदै लाने', E'B', E'**वैज्ञानिक, प्राविधिक, बौद्धिक र विशिष्ट प्रतिभाहरूको संरक्षण गर्ने व्यवस्था नागरिकका आधारभूत आवश्यकता सम्बन्धी नीति होइन, सामाजिक न्याय र समावेशीकरण सम्बन्धी नीति अन्तर्गत पर्दछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नागरिकका आधारभूत आवश्यकता सम्बन्धी नीतिमा उल्लिखित शिक्षासम्बन्धी व्यवस्थाहरूमा तलकामध्ये कुन पर्दैन?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा क्षेत्रमा भएको निजी लगानीसम्बन्धी नियमन र व्यवस्थापन गरी सेवामूलक बनाउने विषय नेपालको संविधानको कुन नीतिमा समावेश गरिएको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'शिक्षा क्षेत्रमा भएको निजी लगानीसम्बन्धी नियमन र व्यवस्थापन गरी सेवामूलक बनाउने विषय नेपालको संविधानको कुन नीतिमा समावेश गरिएको छ?', E'विकास सम्बन्धी नीति', E'सामाजिक र सांस्कृतिक रूपान्तरण सम्बन्धी नीति', E'सामाजिक न्याय र समावेशीकरण सम्बन्धी नीति', E'नागरिकका आधारभूत आवश्यकता सम्बन्धी नीति', E'D', E'**शिक्षामा निजी लगानीको नियमनसम्बन्धी व्यवस्था नागरिकका आधारभूत आवश्यकता सम्बन्धी नीति (धारा ५१ ग) अन्तर्गत पर्दछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा क्षेत्रमा भएको निजी लगानीसम्बन्धी नियमन र व्यवस्थापन गरी सेवामूलक बनाउने विषय नेपालको संविधानको कुन नीतिमा समावेश गरिएको छ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालको संविधान, २०७२ ले राज्यशक्तिको बाँडफाँड गर्दा स्थानीय तहको शिक्षासम्बन्धी अधिकार कुन अनुसूचीमा व्यवस्था गरेको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'नेपालको संविधान, २०७२ ले राज्यशक्तिको बाँडफाँड गर्दा स्थानीय तहको शिक्षासम्बन्धी अधिकार कुन अनुसूचीमा व्यवस्था गरेको छ?', E'अनुसूची ५', E'अनुसूची ६', E'अनुसूची ८', E'अनुसूची ९', E'C', E'**स्थानीय तहको एकल अधिकार (आधारभूत र माध्यमिक शिक्षा सहित) अनुसूची ८ मा उल्लेख गरिएको छ।**\\nनोट: अनुसूची ९ मा संघ, प्रदेश र स्थानीय तहको साझा अधिकार (शिक्षा, खेलकूद र पत्रपत्रिका सहित) उल्लेख छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालको संविधान, २०७२ ले राज्यशक्तिको बाँडफाँड गर्दा स्थानीय तहको शिक्षासम्बन्धी अधिकार कुन अनुसूचीमा व्यवस्था गरेको छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालको संविधान, २०७२ को अनुसूची ९ मा उल्लेखित शिक्षा, खेलकूद र पत्रपत्रिका कसको अधिकार क्षेत्रभित्र रहने व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'नेपालको संविधान, २०७२ को अनुसूची ९ मा उल्लेखित शिक्षा, खेलकूद र पत्रपत्रिका कसको अधिकार क्षेत्रभित्र रहने व्यवस्था छ?', E'संघको एकल अधिकार', E'संघ र प्रदेशको साझा अधिकार', E'स्थानीय तहको एकल अधिकार', E'संघ, प्रदेश र स्थानीय तहको साझा अधिकार', E'D', E'**शिक्षा, खेलकूद र पत्रपत्रिका अनुसूची ९ अन्तर्गतका संघ, प्रदेश र स्थानीय तहको साझा अधिकार (जम्मा १५ वटा) मध्ये पर्दछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालको संविधान, २०७२ को अनुसूची ९ मा उल्लेखित शिक्षा, खेलकूद र पत्रपत्रिका कसको अधिकार क्षेत्रभित्र रहने व्यवस्था छ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालको संविधान, २०७२ बमोजिम प्रत्येक नेपाली नागरिकको कर्तव्य तलकामध्ये कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'नेपालको संविधान, २०७२ बमोजिम प्रत्येक नेपाली नागरिकको कर्तव्य तलकामध्ये कुन हो?', E'सार्वजनिक सम्पत्तिको सुरक्षा र संरक्षण गर्नु', E'राष्ट्रको स्वतन्त्रता, सार्वभौमसत्ता र अखण्डताको रक्षा गर्नु', E'संविधान र कानुनको पालना गर्नु', E'माथिका सबै', E'D', E'**धारा ४८ बमोजिम माथिका सबै दायित्व प्रत्येक नागरिकको कर्तव्य अन्तर्गत पर्दछन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालको संविधान, २०७२ बमोजिम प्रत्येक नेपाली नागरिकको कर्तव्य तलकामध्ये कुन हो?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: नेपालको संविधान: राज्य संरचना — व्यवस्थापिका, कार्यपालिका र न्यायपालिका (आधारभूत तह) (18 Q)
  v_set_id := extensions.uuid_generate_v5('7ce4e540-9ae1-4c35-b2f1-6328483777f1'::uuid, E'नेपालको संविधान: राज्य संरचना — व्यवस्थापिका, कार्यपालिका र न्यायपालिका (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '38021473-9cb4-45f3-8719-3a141424b498'::uuid, '7ce4e540-9ae1-4c35-b2f1-6328483777f1'::uuid, E'नेपालको संविधान: राज्य संरचना — व्यवस्थापिका, कार्यपालिका र न्यायपालिका (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '7ce4e540-9ae1-4c35-b2f1-6328483777f1'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालको संविधान, २०७२ जारी हुँदा नेपालका प्रधानमन्त्री को थिए?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'नेपालको संविधान, २०७२ जारी हुँदा नेपालका प्रधानमन्त्री को थिए?', E'पुष्पकमल दाहाल', E'सुशील कोइराला', E'गिरिजाप्रसाद कोइराला', E'के.पी. शर्मा ओली', E'B', E'**संविधान जारी हुँदा (असोज ३, २०७२) नेपालका प्रधानमन्त्री सुशील कोइराला थिए।**\\nनोट: संविधानसभाका सभामुख सुवासचन्द्र नेम्बाङले संविधान प्रमाणीकरण गरेका थिए र त्यतिबेलाका राष्ट्रपति डा. रामवरण यादव थिए।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालको संविधान, २०७२ जारी हुँदा नेपालका प्रधानमन्त्री को थिए?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालको संविधान, २०७२ को कुन अनुसूची दोस्रो संशोधन (२०७७) मार्फत परिवर्तन गरी नेपालको नयाँ नक्सा राखिएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'नेपालको संविधान, २०७२ को कुन अनुसूची दोस्रो संशोधन (२०७७) मार्फत परिवर्तन गरी नेपालको नयाँ नक्सा राखिएको थियो?', E'अनुसूची ३', E'अनुसूची ५', E'अनुसूची ६', E'अनुसूची ७', E'A', E'**दोस्रो संशोधन, २०७७ ले अनुसूची ३ (नेपालको निशान/छाप) मा लिम्पियाधुरा, लिपुलेक र कालापानी समेतको नयाँ नक्सा राखेको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालको संविधान, २०७२ को कुन अनुसूची दोस्रो संशोधन (२०७७) मार्फत परिवर्तन गरी नेपालको नयाँ नक्सा राखिएको थियो?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालको संविधान, २०७२ बमोजिम कुनै विधेयक संशोधन गर्नुपरेमा सङ्घीय संसदका दुवै सदनमा तत्काल कायम रहेको सम्पूर्ण सङ्ख्याको कम्तीमा कति बहुमतबाट पारित गर्नुपर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'नेपालको संविधान, २०७२ बमोजिम कुनै विधेयक संशोधन गर्नुपरेमा सङ्घीय संसदका दुवै सदनमा तत्काल कायम रहेको सम्पूर्ण सङ्ख्याको कम्तीमा कति बहुमतबाट पारित गर्नुपर्छ?', E'दुई तिहाई बहुमत', E'साधारण बहुमत', E'सर्वसम्मत', E'एक तिहाई बहुमत', E'A', E'**संविधान संशोधनका लागि दुवै सदनमा तत्काल कायम सम्पूर्ण सङ्ख्याको कम्तीमा दुई तिहाई बहुमत आवश्यक पर्दछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालको संविधान, २०७२ बमोजिम कुनै विधेयक संशोधन गर्नुपरेमा सङ्घीय संसदका दुवै सदनमा तत्काल कायम रहेको सम्पूर्ण सङ्ख्याको कम्तीमा कति बहुमतबाट पारित गर्नुपर्छ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालको संविधान बमोजिम प्रदेशसभा गठन गर्दा पहिलो हुने निर्वाचित हुने प्रणाली र समानुपातिक निर्वाचन प्रणालीबाट क्रमशः कति प्रतिशत सदस्य निर्वाचित हुन्छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'नेपालको संविधान बमोजिम प्रदेशसभा गठन गर्दा पहिलो हुने निर्वाचित हुने प्रणाली र समानुपातिक निर्वाचन प्रणालीबाट क्रमशः कति प्रतिशत सदस्य निर्वाचित हुन्छन्?', E'५०:५०', E'६०:४०', E'५०:६०', E'४०:६०', E'B', E'**प्रदेशसभा गठन गर्दा ६० प्रतिशत सदस्य पहिलो हुने निर्वाचित हुने प्रणालीबाट र ४० प्रतिशत सदस्य समानुपातिक निर्वाचन प्रणालीबाट निर्वाचित हुन्छन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालको संविधान बमोजिम प्रदेशसभा गठन गर्दा पहिलो हुने निर्वाचित हुने प्रणाली र समानुपातिक निर्वाचन प्रणालीबाट क्रमशः कति प्रतिशत सदस्य निर्वाचित हुन्छन्?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'प्रतिनिधि सभा वा राष्ट्रिय सभाको बैठकको कारबाहीका लागि सम्पूर्ण सदस्य सङ्ख्याको कति उपस्थित भएमा गणपूरक सङ्ख्या पुगेको मानिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'प्रतिनिधि सभा वा राष्ट्रिय सभाको बैठकको कारबाहीका लागि सम्पूर्ण सदस्य सङ्ख्याको कति उपस्थित भएमा गणपूरक सङ्ख्या पुगेको मानिन्छ?', E'एक चौथाई', E'बहुमत', E'दुई तिहाई', E'१० प्रतिशत', E'A', E'**सम्पूर्ण सदस्य सङ्ख्याको एक चौथाई सदस्य उपस्थित भएमा बैठकको कारबाहीका लागि गणपूरक सङ्ख्या पुगेको मानिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:प्रतिनिधि सभा वा राष्ट्रिय सभाको बैठकको कारबाहीका लागि सम्पूर्ण सदस्य सङ्ख्याको कति उपस्थित भएमा गणपूरक सङ्ख्या पुगेको मानिन्छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सङ्घीय संसदको प्रतिनिधि सभामा जम्मा कति सदस्य रहन्छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'सङ्घीय संसदको प्रतिनिधि सभामा जम्मा कति सदस्य रहन्छन्?', E'२५९', E'२६५', E'२७५', E'२९५', E'C', E'**प्रतिनिधि सभामा जम्मा २७५ सदस्य रहन्छन् (१६५ प्रत्यक्ष निर्वाचित र ११० समानुपातिक)।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सङ्घीय संसदको प्रतिनिधि सभामा जम्मा कति सदस्य रहन्छन्?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सङ्घीय संसदको राष्ट्रिय सभामा जम्मा कति सदस्य रहन्छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'सङ्घीय संसदको राष्ट्रिय सभामा जम्मा कति सदस्य रहन्छन्?', E'४५', E'५९', E'६५', E'७५', E'B', E'**राष्ट्रिय सभामा जम्मा ५९ सदस्य रहन्छन् (प्रदेशबाट ५६ र राष्ट्रपतिबाट मनोनीत ३)।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सङ्घीय संसदको राष्ट्रिय सभामा जम्मा कति सदस्य रहन्छन्?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालको संविधान, २०७२ बमोजिम नेपालमा मूलतः कस्ता किसिमका अदालतहरू रहने व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'नेपालको संविधान, २०७२ बमोजिम नेपालमा मूलतः कस्ता किसिमका अदालतहरू रहने व्यवस्था छ?', E'सर्वोच्च अदालत, विशेष अदालत, उच्च अदालत र जिल्ला अदालत', E'सर्वोच्च अदालत र जिल्ला अदालत', E'सर्वोच्च अदालत, उच्च अदालत र जिल्ला अदालत', E'सर्वोच्च अदालत, प्रदेश अदालत र जिल्ला अदालत', E'C', E'**नेपालमा सर्वोच्च अदालत, उच्च अदालत र जिल्ला अदालत गरी तीन तहका अदालतहरू रहन्छन्।**\\nनोट: विशेष अदालत तथा अन्य न्यायाधिकरणहरू यी तीन तहभन्दा बाहिर छुट्टै व्यवस्था अन्तर्गत गठन हुन्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालको संविधान, २०७२ बमोजिम नेपालमा मूलतः कस्ता किसिमका अदालतहरू रहने व्यवस्था छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालको संविधान बमोजिम सर्वोच्च अदालतमा प्रधान न्यायाधीशका अतिरिक्त बढीमा कति न्यायाधीश रहने व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'नेपालको संविधान बमोजिम सर्वोच्च अदालतमा प्रधान न्यायाधीशका अतिरिक्त बढीमा कति न्यायाधीश रहने व्यवस्था छ?', E'१९ जना', E'२० जना', E'२४ जना', E'२५ जना', E'B', E'**सर्वोच्च अदालतमा प्रधान न्यायाधीशका अतिरिक्त बढीमा २० जना न्यायाधीश रहन सक्छन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालको संविधान बमोजिम सर्वोच्च अदालतमा प्रधान न्यायाधीशका अतिरिक्त बढीमा कति न्यायाधीश रहने व्यवस्था छ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालको संविधानको धारा १५३ बमोजिम गठन हुने न्यायपरिषद्मा जम्मा कति सदस्य रहन्छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'नेपालको संविधानको धारा १५३ बमोजिम गठन हुने न्यायपरिषद्मा जम्मा कति सदस्य रहन्छन्?', E'३ सदस्य', E'४ सदस्य', E'५ सदस्य', E'७ सदस्य', E'C', E'**न्यायपरिषद्मा प्रधान न्यायाधीश (अध्यक्ष) सहित जम्मा ५ सदस्य रहन्छन्: संघीय कानून तथा न्यायमन्त्री, सर्वोच्च अदालतको वरिष्ठतम न्यायाधीश, प्रधानमन्त्रीको सिफारिसमा राष्ट्रपतिबाट नियुक्त एक कानूनविद्, र नेपाल बार एसोसिएसनको सिफारिसमा राष्ट्रपतिद्वारा नियुक्त एक जना वरिष्ठ अधिवक्ता वा अधिवक्ता।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालको संविधानको धारा १५३ बमोजिम गठन हुने न्यायपरिषद्मा जम्मा कति सदस्य रहन्छन्?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'प्रधान न्यायाधीश र संवैधानिक निकायका प्रमुख तथा पदाधिकारीहरूको नियुक्तिको सिफारिस गर्न गठन हुने संवैधानिक परिषद्मा तलकामध्ये को सदस्य रहँदैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'प्रधान न्यायाधीश र संवैधानिक निकायका प्रमुख तथा पदाधिकारीहरूको नियुक्तिको सिफारिस गर्न गठन हुने संवैधानिक परिषद्मा तलकामध्ये को सदस्य रहँदैन?', E'प्रधान न्यायाधीश', E'प्रतिनिधि सभाको विपक्षी दलको नेता', E'प्रतिनिधि सभाको उपसभामुख', E'संघीय कानून मन्त्री', E'D', E'**संवैधानिक परिषद्मा संघीय कानून मन्त्री सदस्य रहँदैनन्।**\\nनोट: प्रधानमन्त्रीको अध्यक्षतामा प्रधान न्यायाधीश, प्रतिनिधि सभाको सभामुख, राष्ट्रिय सभाको अध्यक्ष, प्रतिनिधि सभाको उपसभामुख र प्रतिनिधि सभामा विपक्षी दलको नेता सदस्य रहन्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:प्रधान न्यायाधीश र संवैधानिक निकायका प्रमुख तथा पदाधिकारीहरूको नियुक्तिको सिफारिस गर्न गठन हुने संवैधानिक परिषद्मा तलकामध्ये को सदस्य रहँदैन?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालको संविधान बमोजिम राज्यसत्ताको सञ्चालन सम्बन्धी कार्यकारिणी अधिकार कसमा निहित हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'नेपालको संविधान बमोजिम राज्यसत्ताको सञ्चालन सम्बन्धी कार्यकारिणी अधिकार कसमा निहित हुन्छ?', E'सङ्घीय संसद', E'मन्त्रिपरिषद्', E'राष्ट्रपति', E'प्रधान न्यायाधीश', E'B', E'**धारा ७५ बमोजिम नेपालको कार्यकारिणी अधिकार मन्त्रिपरिषद्मा निहित हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालको संविधान बमोजिम राज्यसत्ताको सञ्चालन सम्बन्धी कार्यकारिणी अधिकार कसमा निहित हुन्छ?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालको संविधान बमोजिम उपप्रधानमन्त्रीले पद तथा गोपनीयताको सपथ कसको समक्ष लिनुपर्ने व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'नेपालको संविधान बमोजिम उपप्रधानमन्त्रीले पद तथा गोपनीयताको सपथ कसको समक्ष लिनुपर्ने व्यवस्था छ?', E'प्रधानमन्त्री', E'राष्ट्रपति', E'प्रधान न्यायाधीश', E'उपराष्ट्रपति', E'B', E'**उपप्रधानमन्त्रीले पद तथा गोपनीयताको सपथ राष्ट्रपति समक्ष लिनुपर्दछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालको संविधान बमोजिम उपप्रधानमन्त्रीले पद तथा गोपनीयताको सपथ कसको समक्ष लिनुपर्ने व्यवस्था छ?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालको संविधान बमोजिम सङ्घीय मन्त्रिपरिषद् गठन गर्दा प्रधानमन्त्री सहित बढीमा कति जनाको मन्त्रिपरिषद् गठन गर्न सकिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'नेपालको संविधान बमोजिम सङ्घीय मन्त्रिपरिषद् गठन गर्दा प्रधानमन्त्री सहित बढीमा कति जनाको मन्त्रिपरिषद् गठन गर्न सकिन्छ?', E'२० जना', E'२२ जना', E'२५ जना', E'३० जना', E'C', E'**प्रधानमन्त्री सहित बढीमा २५ जनाको मन्त्रिपरिषद् गठन गर्न सकिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालको संविधान बमोजिम सङ्घीय मन्त्रिपरिषद् गठन गर्दा प्रधानमन्त्री सहित बढीमा कति जनाको मन्त्रिपरिषद् गठन गर्न सकिन्छ?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'प्रधानमन्त्रीले प्रतिनिधित्व गर्ने दल विभाजित भएमा वा सरकारमा सहभागी दलले समर्थन फिर्ता लिएमा प्रधानमन्त्रीले कति दिनभित्र विश्वासको मत लिनुपर्ने व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'प्रधानमन्त्रीले प्रतिनिधित्व गर्ने दल विभाजित भएमा वा सरकारमा सहभागी दलले समर्थन फिर्ता लिएमा प्रधानमन्त्रीले कति दिनभित्र विश्वासको मत लिनुपर्ने व्यवस्था छ?', E'३० दिनभित्र', E'१५ दिनभित्र', E'२० दिनभित्र', E'३५ दिनभित्र', E'A', E'**यस्तो अवस्थामा प्रधानमन्त्रीले ३० दिनभित्र प्रतिनिधि सभाबाट विश्वासको मत लिनुपर्दछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:प्रधानमन्त्रीले प्रतिनिधित्व गर्ने दल विभाजित भएमा वा सरकारमा सहभागी दलले समर्थन फिर्ता लिएमा प्रधानमन्त्रीले कति दिनभित्र विश्वासको मत लिनुपर्ने व्यवस्था छ?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालको संविधान बमोजिम स्थानीय तहमा हुने विवाद निरूपण गर्न गठित न्यायिक समितिको संयोजक को रहने व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'नेपालको संविधान बमोजिम स्थानीय तहमा हुने विवाद निरूपण गर्न गठित न्यायिक समितिको संयोजक को रहने व्यवस्था छ?', E'गाउँपालिका वा नगरपालिकाको प्रमुख', E'गाउँपालिका वा नगरपालिकाको उपप्रमुख', E'गाउँ वा नगर कार्यपालिकाले तोकेको सदस्य', E'प्रमुख प्रशासकीय अधिकृत', E'B', E'**धारा २१७ बमोजिम गठित तीन सदस्यीय न्यायिक समितिको संयोजक गाउँपालिका वा नगरपालिकाको उपप्रमुख हुन्छन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालको संविधान बमोजिम स्थानीय तहमा हुने विवाद निरूपण गर्न गठित न्यायिक समितिको संयोजक को रहने व्यवस्था छ?'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालको संविधानको भाग ५ मा भएको राज्यको संरचना सम्बन्धी व्यवस्था अनुसार ''स्थानीय तह'' भन्नाले कसलाई बुझाउँछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'नेपालको संविधानको भाग ५ मा भएको राज्यको संरचना सम्बन्धी व्यवस्था अनुसार ''स्थानीय तह'' भन्नाले कसलाई बुझाउँछ?', E'गाउँपालिका मात्र', E'नगरपालिका मात्र', E'गाउँपालिका र नगरपालिका मात्र', E'गाउँपालिका, नगरपालिका र जिल्ला सभा', E'D', E'**भाग ५ (राज्यको संरचना र राज्यशक्तिको बाँडफाँड) बमोजिम स्थानीय तह भन्नाले गाउँपालिका, नगरपालिका र जिल्ला सभालाई बुझाउँछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालको संविधानको भाग ५ मा भएको राज्यको संरचना सम्बन्धी व्यवस्था अनुसार ''स्थानीय तह'' भन्नाले कसलाई बुझाउँछ?'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालको संविधान बमोजिम कस्तो विषय सङ्घीय संसदको कुनै पनि सदनमा बहस तथा छलफल गर्न बन्देज छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'नेपालको संविधान बमोजिम कस्तो विषय सङ्घीय संसदको कुनै पनि सदनमा बहस तथा छलफल गर्न बन्देज छ?', E'महाभियोगमा रहेको न्यायाधीशको आचरणसम्बन्धी विषय', E'नेपाल सरकारको काम कारबाहीसम्बन्धी विषय', E'अदालतमा विचाराधीन मुद्दाहरूसम्बन्धी विषय', E'राष्ट्रपतिको भूमिकासम्बन्धी विषय', E'C', E'**न्यायपालिकाको स्वतन्त्रता जोगाउन अदालतमा विचाराधीन मुद्दाहरूसम्बन्धी विषयमा संसदमा बहस तथा छलफल गर्न बन्देज छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालको संविधान बमोजिम कस्तो विषय सङ्घीय संसदको कुनै पनि सदनमा बहस तथा छलफल गर्न बन्देज छ?'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  RAISE NOTICE 'Unit घ-१ upsert complete: 3 sets, 38 questions.';
END $$;
