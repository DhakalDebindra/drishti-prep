-- Idempotent UPSERT import: निमावि प्रथम पत्र — unit घ-४ शिक्षक सेवा आयोग नियमावली, २०५७ (Level I topic-wise sets)
-- Override same-identity sets/questions; never deletes. Generated 2026-07-02T12:17:58.335Z.
DO $$
DECLARE
  v_module_id uuid := '6695669a-f40e-421a-a4ec-b09bbeaf56c4'::uuid;
  v_set_id uuid;
  v_q_id uuid;
BEGIN

  -- Set: शिक्षक सेवा आयोग नियमावली, २०५७: आयोगको गठन, अधिकार र समावेशीकरण (आधारभूत तह) (11 Q)
  v_set_id := extensions.uuid_generate_v5('8058e27e-a84a-4285-bac4-591457fd8a71'::uuid, E'शिक्षक सेवा आयोग नियमावली, २०५७: आयोगको गठन, अधिकार र समावेशीकरण (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'ced477be-47df-4849-af09-6f1d593cd180'::uuid, '8058e27e-a84a-4285-bac4-591457fd8a71'::uuid, E'शिक्षक सेवा आयोग नियमावली, २०५७: आयोगको गठन, अधिकार र समावेशीकरण (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '8058e27e-a84a-4285-bac4-591457fd8a71'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षक सेवा आयोग नियमावली, २०५७ अनुसार शिक्षक सेवा आयोगको काम, कर्तव्य र अधिकारमा तलकामध्ये कुन पर्दैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'शिक्षक सेवा आयोग नियमावली, २०५७ अनुसार शिक्षक सेवा आयोगको काम, कर्तव्य र अधिकारमा तलकामध्ये कुन पर्दैन?', E'शिक्षकको स्थायी नियुक्ति प्रदान गर्ने', E'विद्यालयमा अध्यापन गर्न चाहने व्यक्तिलाई अध्यापन अनुमतिपत्र दिने', E'शिक्षकको सेवा, शर्त र सुविधासम्बन्धी विषयमा मन्त्रालयलाई सुझाव दिने', E'शिक्षकको नियुक्ति तथा बढुवाका लागि लिइने परीक्षाको पाठ्यक्रम निर्माण गर्ने तथा परीक्षा सम्बन्धी अन्य कार्य गर्ने', E'A', E'**शिक्षकको स्थायी नियुक्ति प्रदान गर्ने कार्य आयोगको अधिकारमा पर्दैन — यो शिक्षा विकास तथा समन्वय इकाई प्रमुखले गर्दछन्।**\\nनोट: आयोगले सिफारिस गरेको सूचीका आधारमा नियुक्ति इकाई प्रमुखले दिन्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षक सेवा आयोग नियमावली, २०५७ अनुसार शिक्षक सेवा आयोगको काम, कर्तव्य र अधिकारमा तलकामध्ये कुन पर्दैन?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षक सेवा आयोगको अध्यक्षले आफ्नो बिदा र काज कसरी स्वीकृत गराउनुपर्ने व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'शिक्षक सेवा आयोगको अध्यक्षले आफ्नो बिदा र काज कसरी स्वीकृत गराउनुपर्ने व्यवस्था छ?', E'मन्त्रालयबाट', E'आफैले गर्न सक्ने', E'आयोगको बैठकबाट', E'आयोगको सचिवबाट', E'B', E'**आयोगको अध्यक्षले आफ्नो बिदा र काज आफैले स्वीकृत गर्न सक्दछन्।**\\nनोट: आयोगका सदस्यको भने बिदा र काज अध्यक्षले नै स्वीकृत गर्नुपर्दछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षक सेवा आयोगको अध्यक्षले आफ्नो बिदा र काज कसरी स्वीकृत गराउनुपर्ने व्यवस्था छ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षक सेवा आयोगको सदस्य पदमा नियुक्त हुनका लागि आवश्यक योग्यता तलकामध्ये कुन होइन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'शिक्षक सेवा आयोगको सदस्य पदमा नियुक्त हुनका लागि आवश्यक योग्यता तलकामध्ये कुन होइन?', E'नेपाल सरकारबाट मान्यता प्राप्त विश्वविद्यालयबाट स्नातकोत्तर उपाधि प्राप्त गरेको', E'४० वर्ष उमेर पूरा भएको', E'नियुक्ति हुनुभन्दा कम्तीमा पाँच वर्ष अगाडिदेखि कुनै राजनीतिक दलको सदस्य नरहेको', E'कानुन, शिक्षा वा प्रशासनको क्षेत्रमा कम्तीमा १५ वर्ष काम गरेको', E'C', E'**नियुक्ति हुनुभन्दा पाँच वर्ष अगाडिदेखि राजनीतिक दलको सदस्य नरहेको भन्ने प्रावधान सदस्यको योग्यतामा पर्दैन — वास्तविक अवधि दुई वर्ष हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षक सेवा आयोगको सदस्य पदमा नियुक्त हुनका लागि आवश्यक योग्यता तलकामध्ये कुन होइन?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षक सेवा आयोग नियमावली, २०५७ को नियम १० बमोजिम तलकामध्ये कस्तो व्यक्ति शिक्षक पदमा उम्मेदवार हुन अयोग्य ठहरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'शिक्षक सेवा आयोग नियमावली, २०५७ को नियम १० बमोजिम तलकामध्ये कस्तो व्यक्ति शिक्षक पदमा उम्मेदवार हुन अयोग्य ठहरिन्छ?', E'स्नातक तह उत्तीर्ण गरेको व्यक्ति', E'पैंतीस वर्ष उमेर पूरा गरेको व्यक्ति', E'एक वर्षअघि अन्य सरकारी सेवामा कार्यरत रहेको व्यक्ति', E'गैर नेपाली नागरिक', E'D', E'**नियम १० बमोजिम गैर नेपाली नागरिक शिक्षक पदमा उम्मेदवार हुन अयोग्य ठहरिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षक सेवा आयोग नियमावली, २०५७ को नियम १० बमोजिम तलकामध्ये कस्तो व्यक्ति शिक्षक पदमा उम्मेदवार हुन अयोग्य ठहरिन्छ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'देहायमध्ये कस्तो अवस्थामा भएको व्यक्ति अध्यापन अनुमतिपत्रका लागि लिइने परीक्षाको उम्मेदवार हुन सक्नेछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'देहायमध्ये कस्तो अवस्थामा भएको व्यक्ति अध्यापन अनुमतिपत्रका लागि लिइने परीक्षाको उम्मेदवार हुन सक्नेछ?', E'भविष्यमा सरकारी नोकरी वा शिक्षक सेवाका लागि अयोग्य नठहरिने गरी सेवाबाट बर्खास्त गरिएको', E'१८ वर्ष उमेर नपुगेको', E'नैतिक पतन देखिने फौजदारी अभियोगमा अदालतबाट कसुरदार ठहरिएको', E'मगज बिग्रिएको', E'A', E'**भविष्यमा सरकारी नोकरी वा शिक्षक सेवाका लागि अयोग्य नठहरिने गरी सेवाबाट बर्खास्त गरिएको व्यक्ति उम्मेदवार हुन सक्दछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:देहायमध्ये कस्तो अवस्थामा भएको व्यक्ति अध्यापन अनुमतिपत्रका लागि लिइने परीक्षाको उम्मेदवार हुन सक्नेछ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षक सेवा आयोगले आफ्ना काम-कारबाहीको वार्षिक प्रतिवेदन नेपाल सरकार समक्ष कहिलेसम्म पेश गर्नुपर्ने कानुनी प्रावधान छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'शिक्षक सेवा आयोगले आफ्ना काम-कारबाहीको वार्षिक प्रतिवेदन नेपाल सरकार समक्ष कहिलेसम्म पेश गर्नुपर्ने कानुनी प्रावधान छ?', E'प्रत्येक शैक्षिक वर्ष समाप्त भएको तीन महिनाभित्र', E'प्रत्येक आर्थिक वर्ष समाप्त भएको तीन महिनाभित्र', E'प्रत्येक आर्थिक वर्ष समाप्त भएको छ महिनाभित्र', E'नेपाल सरकारले मागेको समयमा', E'B', E'**आयोगले वार्षिक प्रतिवेदन प्रत्येक आर्थिक वर्ष समाप्त भएको तीन महिनाभित्र नेपाल सरकार समक्ष पेश गर्नुपर्दछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षक सेवा आयोगले आफ्ना काम-कारबाहीको वार्षिक प्रतिवेदन नेपाल सरकार समक्ष कहिलेसम्म पेश गर्नुपर्ने कानुनी प्रावधान छ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षक सेवा आयोगलाई समावेशी बनाउनका लागि पिछडिएको क्षेत्रको रूपमा तोकिएका जिल्लामा तलकामध्ये कुन पर्दैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'शिक्षक सेवा आयोगलाई समावेशी बनाउनका लागि पिछडिएको क्षेत्रको रूपमा तोकिएका जिल्लामा तलकामध्ये कुन पर्दैन?', E'डोल्पा', E'मुगु', E'मुस्ताङ', E'कालिकोट', E'C', E'**मुस्ताङ पिछडिएको क्षेत्रको रूपमा तोकिएका जिल्लाहरूमा पर्दैन।**\\nनोट: पिछडिएको क्षेत्र भनेर अछाम, कालिकोट, जाजरकोट, जुम्ला, डोल्पा, बझाङ, बाजुरा, मुगु र हुम्ला गरी ९ जिल्ला तोकिएका छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षक सेवा आयोगलाई समावेशी बनाउनका लागि पिछडिएको क्षेत्रको रूपमा तोकिएका जिल्लामा तलकामध्ये कुन पर्दैन?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षक सेवालाई समावेशी बनाउन समावेशी प्रयोजनका लागि कतिवटा समूहमा समूहीकृत गरिएको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'शिक्षक सेवालाई समावेशी बनाउन समावेशी प्रयोजनका लागि कतिवटा समूहमा समूहीकृत गरिएको छ?', E'पाँचवटा', E'सातवटा', E'चारवटा', E'छवटा', E'D', E'**समावेशी प्रयोजनका लागि छवटा समूहमा समूहीकृत गरिएको छ: महिला, आदिवासी/जनजाति, मधेसी, दलित, अपाङ्ग र पिछडिएको क्षेत्र।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षक सेवालाई समावेशी बनाउन समावेशी प्रयोजनका लागि कतिवटा समूहमा समूहीकृत गरिएको छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षक पदपूर्ति गर्दा महिलाको समावेशी पदको जम्मा सङ्ख्याको कति प्रतिशत पदमा मुस्लिम महिलाका लागि विज्ञापन गर्नुपर्ने हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'शिक्षक पदपूर्ति गर्दा महिलाको समावेशी पदको जम्मा सङ्ख्याको कति प्रतिशत पदमा मुस्लिम महिलाका लागि विज्ञापन गर्नुपर्ने हुन्छ?', E'२%', E'३%', E'४%', E'५%', E'A', E'**महिला समावेशी पदको जम्मा सङ्ख्याको २% पदमा मुस्लिम महिलाका लागि विज्ञापन गर्नुपर्दछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षक पदपूर्ति गर्दा महिलाको समावेशी पदको जम्मा सङ्ख्याको कति प्रतिशत पदमा मुस्लिम महिलाका लागि विज्ञापन गर्नुपर्ने हुन्छ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षक सेवालाई समावेशी बनाउन निर्धारण गरिएको प्रतिशतद्वारा पदपूर्ति गर्ने व्यवस्था कति वर्षमा पुनरावलोकन गर्नुपर्ने व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'शिक्षक सेवालाई समावेशी बनाउन निर्धारण गरिएको प्रतिशतद्वारा पदपूर्ति गर्ने व्यवस्था कति वर्षमा पुनरावलोकन गर्नुपर्ने व्यवस्था छ?', E'प्रत्येक पाँच वर्षमा', E'प्रत्येक १० वर्षमा', E'प्रत्येक १५ वर्षमा', E'प्रत्येक सात वर्षमा', E'B', E'**समावेशी पदपूर्ति प्रतिशतको व्यवस्था प्रत्येक १० वर्षमा पुनरावलोकन गर्नुपर्दछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षक सेवालाई समावेशी बनाउन निर्धारण गरिएको प्रतिशतद्वारा पदपूर्ति गर्ने व्यवस्था कति वर्षमा पुनरावलोकन गर्नुपर्ने व्यवस्था छ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'१० देखि १५ वर्षसम्म स्थायी सेवा गरेका शिक्षकले अवकाश लिएमा निजले कति उपदान पाउने व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'१० देखि १५ वर्षसम्म स्थायी सेवा गरेका शिक्षकले अवकाश लिएमा निजले कति उपदान पाउने व्यवस्था छ?', E'प्रत्येक वर्षका लागि अन्तिम डेढ महिनाको तलब', E'प्रत्येक वर्षका लागि अन्तिम दुई महिनाको तलब', E'प्रत्येक वर्षका लागि अन्तिम एक महिनाको तलब', E'प्रत्येक वर्षका लागि अन्तिम आधा महिनाको तलब', E'C', E'**१० देखि १५ वर्षसम्म स्थायी सेवा गरेका शिक्षकले अवकाश लिएमा प्रत्येक वर्षका लागि अन्तिम एक महिनाको तलब बराबर उपदान पाउँछन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:१० देखि १५ वर्षसम्म स्थायी सेवा गरेका शिक्षकले अवकाश लिएमा निजले कति उपदान पाउने व्यवस्था छ?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: शिक्षक सेवा आयोग नियमावली, २०५७: खुला प्रतियोगितात्मक परीक्षा र बढुवा प्रक्रिया (आधारभूत तह) (16 Q)
  v_set_id := extensions.uuid_generate_v5('675a42c0-d77d-4d6e-bd5e-c651cf6c51a6'::uuid, E'शिक्षक सेवा आयोग नियमावली, २०५७: खुला प्रतियोगितात्मक परीक्षा र बढुवा प्रक्रिया (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'ced477be-47df-4849-af09-6f1d593cd180'::uuid, '675a42c0-d77d-4d6e-bd5e-c651cf6c51a6'::uuid, E'शिक्षक सेवा आयोग नियमावली, २०५७: खुला प्रतियोगितात्मक परीक्षा र बढुवा प्रक्रिया (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '675a42c0-d77d-4d6e-bd5e-c651cf6c51a6'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षक सेवा आयोगबाट लिइने शिक्षक पदको खुला प्रतियोगितात्मक परीक्षाको उत्तीर्णाङ्क तलकामध्ये कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'शिक्षक सेवा आयोगबाट लिइने शिक्षक पदको खुला प्रतियोगितात्मक परीक्षाको उत्तीर्णाङ्क तलकामध्ये कुन हो?', E'सामान्य परीक्षा ४० अङ्क, विषयगत परीक्षा ४० अङ्क र प्रयोगात्मक परीक्षाको १५ अङ्क', E'सामान्य परीक्षा ४० अङ्क, विषयगत परीक्षा ४० अङ्क र प्रयोगात्मक परीक्षाको १० अङ्क', E'सामान्य परीक्षा ४० अङ्क, विषयगत परीक्षा ४० अङ्क र प्रयोगात्मक परीक्षाको २० अङ्क', E'सामान्य परीक्षा ५० अङ्क, विषयगत परीक्षा ५० अङ्क र प्रयोगात्मक परीक्षाको १० अङ्क', E'D', E'**खुला प्रतियोगितात्मक परीक्षाको उत्तीर्णाङ्क सामान्य परीक्षामा ५०, विषयगत परीक्षामा ५० र प्रयोगात्मक परीक्षामा १० हो।**\\nनोट: अन्तर्वार्ताको भने छुट्टै उत्तीर्णाङ्क निर्धारण गरिएको छैन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षक सेवा आयोगबाट लिइने शिक्षक पदको खुला प्रतियोगितात्मक परीक्षाको उत्तीर्णाङ्क तलकामध्ये कुन हो?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षक सेवा आयोगले प्राथमिक, निम्न माध्यमिक र माध्यमिक तहको कुन श्रेणीको रिक्त पदमा खुला प्रतियोगितामार्फत पूर्ति गर्दछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'शिक्षक सेवा आयोगले प्राथमिक, निम्न माध्यमिक र माध्यमिक तहको कुन श्रेणीको रिक्त पदमा खुला प्रतियोगितामार्फत पूर्ति गर्दछ?', E'प्रथम श्रेणी', E'तृतीय श्रेणी', E'द्वितीय श्रेणी', E'माथिका सबै', E'A', E'**प्रथम श्रेणीको रिक्त पद खुला प्रतियोगितामार्फत पूर्ति गरिन्छ।**\\nनोट: द्वितीय र तृतीय श्रेणीका लागि भने कार्यसम्पादन मूल्याङ्कन र आन्तरिक प्रतियोगितात्मक परीक्षामार्फत पूर्ति गरिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षक सेवा आयोगले प्राथमिक, निम्न माध्यमिक र माध्यमिक तहको कुन श्रेणीको रिक्त पदमा खुला प्रतियोगितामार्फत पूर्ति गर्दछ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'खुला प्रतियोगितात्मक परीक्षामा शिक्षक पदको अन्तर्वार्ताका लागि छुट्ट्याइएको अङ्कमध्ये कति अङ्क शैक्षिक योग्यताबापत छुट्ट्याइएको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'खुला प्रतियोगितात्मक परीक्षामा शिक्षक पदको अन्तर्वार्ताका लागि छुट्ट्याइएको अङ्कमध्ये कति अङ्क शैक्षिक योग्यताबापत छुट्ट्याइएको छ?', E'चार', E'पाँच', E'तीन', E'दुई', E'B', E'**अन्तर्वार्तामा शैक्षिक योग्यताबापत ५ अङ्क छुट्ट्याइएको छ।**\\nनोट: अनुभवबापत पनि ५ अङ्क र समग्र अन्तर्वार्तामा जम्मा १५ अङ्क तोकिएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:खुला प्रतियोगितात्मक परीक्षामा शिक्षक पदको अन्तर्वार्ताका लागि छुट्ट्याइएको अङ्कमध्ये कति अङ्क शैक्षिक योग्यताबापत छुट्ट्याइएको छ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षक सेवा आयोगबाट लिइने शिक्षक पदको खुला प्रतियोगितात्मक लिखित परीक्षाको नतिजा प्रकाशन गर्दा विषयगत परीक्षामा प्राप्त अङ्कको कति अङ्क गणना गरिने व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'शिक्षक सेवा आयोगबाट लिइने शिक्षक पदको खुला प्रतियोगितात्मक लिखित परीक्षाको नतिजा प्रकाशन गर्दा विषयगत परीक्षामा प्राप्त अङ्कको कति अङ्क गणना गरिने व्यवस्था छ?', E'५०%', E'३०%', E'शतप्रतिशत', E'७५%', E'C', E'**विषयगत परीक्षामा प्राप्त अङ्कको शतप्रतिशत गणना गरिन्छ।**\\nनोट: सामान्य परीक्षामा प्राप्त अङ्कको भने ५०% मात्र गणना गरिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षक सेवा आयोगबाट लिइने शिक्षक पदको खुला प्रतियोगितात्मक लिखित परीक्षाको नतिजा प्रकाशन गर्दा विषयगत परीक्षामा प्राप्त अङ्कको कति अङ्क गणना गरिने व्यवस्था छ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षक सेवा आयोगले खुला प्रतियोगितात्मक परीक्षा सञ्चालन गरी लिखित र प्रयोगात्मक परीक्षापछि सफल उम्मेदवारहरूको सूची प्रकाशन गर्दा रिक्त पद सङ्ख्या ३५ भएमा थप कतिजनाको नाम प्रकाशन गरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'शिक्षक सेवा आयोगले खुला प्रतियोगितात्मक परीक्षा सञ्चालन गरी लिखित र प्रयोगात्मक परीक्षापछि सफल उम्मेदवारहरूको सूची प्रकाशन गर्दा रिक्त पद सङ्ख्या ३५ भएमा थप कतिजनाको नाम प्रकाशन गरिन्छ?', E'पाँच जना', E'सात जना', E'आठ जना', E'नौ जना', E'D', E'**रिक्त पद सङ्ख्या ३५ भएमा थप नौ जनाको नाम प्रकाशन गरिन्छ।**\\nनोट: ४१ र सोभन्दा माथिको पद सङ्ख्यामा थप २०% का दरले नाम प्रकाशन गरिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षक सेवा आयोगले खुला प्रतियोगितात्मक परीक्षा सञ्चालन गरी लिखित र प्रयोगात्मक परीक्षापछि सफल उम्मेदवारहरूको सूची प्रकाशन गर्दा रिक्त पद सङ्ख्या ३५ भएमा थप कतिजनाको नाम प्रकाशन गरिन्छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षक सेवा आयोगले शिक्षक नियुक्तिका लागि सिफारिस गरिएको पद सङ्ख्याको आधारमा माध्यमिक तहको विज्ञापन भएको पदको वैकल्पिक (प्रतीक्षा) सूची कति सङ्ख्यामा प्रकाशन गर्नुपर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'शिक्षक सेवा आयोगले शिक्षक नियुक्तिका लागि सिफारिस गरिएको पद सङ्ख्याको आधारमा माध्यमिक तहको विज्ञापन भएको पदको वैकल्पिक (प्रतीक्षा) सूची कति सङ्ख्यामा प्रकाशन गर्नुपर्छ?', E'विज्ञापन सङ्ख्याको दोब्बर', E'विज्ञापन सङ्ख्या बराबर', E'विज्ञापन सङ्ख्याको २५ प्रतिशत', E'विज्ञापन सङ्ख्याको आधा', E'A', E'**माध्यमिक तहको वैकल्पिक सूची विज्ञापन सङ्ख्याको दोब्बर प्रकाशन गर्नुपर्दछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षक सेवा आयोगले शिक्षक नियुक्तिका लागि सिफारिस गरिएको पद सङ्ख्याको आधारमा माध्यमिक तहको विज्ञापन भएको पदको वैकल्पिक (प्रतीक्षा) सूची कति सङ्ख्यामा प्रकाशन गर्नुपर्छ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षक सेवा आयोगबाट सञ्चालन हुने खुला प्रतियोगितात्मक परीक्षाको अन्तर्वार्तामा छुटेमा उम्मेदवारले आयोगसमक्ष कति दिनभित्र मनासिब कारणसहित निवेदन दिनुपर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'शिक्षक सेवा आयोगबाट सञ्चालन हुने खुला प्रतियोगितात्मक परीक्षाको अन्तर्वार्तामा छुटेमा उम्मेदवारले आयोगसमक्ष कति दिनभित्र मनासिब कारणसहित निवेदन दिनुपर्छ?', E'१० दिन', E'पाँच दिन', E'१५ दिन', E'२० दिन', E'B', E'**अन्तर्वार्तामा छुटेमा उम्मेदवारले पाँच दिनभित्र मनासिब कारणसहित निवेदन दिनुपर्दछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षक सेवा आयोगबाट सञ्चालन हुने खुला प्रतियोगितात्मक परीक्षाको अन्तर्वार्तामा छुटेमा उम्मेदवारले आयोगसमक्ष कति दिनभित्र मनासिब कारणसहित निवेदन दिनुपर्छ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षक सेवा आयोगले निर्धारित पाठ्यक्रममा कुनै संशोधन गरेमा परीक्षाको मितिभन्दा कति समय अगाडि सूचना प्रकाशन गर्नुपर्ने व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'शिक्षक सेवा आयोगले निर्धारित पाठ्यक्रममा कुनै संशोधन गरेमा परीक्षाको मितिभन्दा कति समय अगाडि सूचना प्रकाशन गर्नुपर्ने व्यवस्था छ?', E'एक महिना अगाडि', E'छ महिना अगाडि', E'तीन महिना अगाडि', E'चार महिना अगाडि', E'C', E'**पाठ्यक्रम संशोधन भएमा परीक्षाको मितिभन्दा तीन महिना अगाडि सूचना प्रकाशन गर्नुपर्दछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षक सेवा आयोगले निर्धारित पाठ्यक्रममा कुनै संशोधन गरेमा परीक्षाको मितिभन्दा कति समय अगाडि सूचना प्रकाशन गर्नुपर्ने व्यवस्था छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षकको कार्यसम्पादनको आधारमा हुने बढुवामा पछिल्लो कति वर्षको कार्यसम्पादन मूल्याङ्कनबापतको अङ्क गणना गरिने व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'शिक्षकको कार्यसम्पादनको आधारमा हुने बढुवामा पछिल्लो कति वर्षको कार्यसम्पादन मूल्याङ्कनबापतको अङ्क गणना गरिने व्यवस्था छ?', E'चार वर्ष', E'तीन वर्ष', E'सात वर्ष', E'पाँच वर्ष', E'D', E'**कार्यसम्पादनको आधारमा हुने बढुवामा पछिल्लो पाँच वर्षको कार्यसम्पादन मूल्याङ्कनबापतको अङ्क गणना गरिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षकको कार्यसम्पादनको आधारमा हुने बढुवामा पछिल्लो कति वर्षको कार्यसम्पादन मूल्याङ्कनबापतको अङ्क गणना गरिने व्यवस्था छ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षकहरूको कार्यसम्पादन मूल्याङ्कनको आधारमा हुने बढुवा सिफारिस उपर परेको उजुरी गलत मनसायले गरिएको प्रमाणित भएमा उजुरीकर्ताको कति अङ्क कट्टा हुने व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'शिक्षकहरूको कार्यसम्पादन मूल्याङ्कनको आधारमा हुने बढुवा सिफारिस उपर परेको उजुरी गलत मनसायले गरिएको प्रमाणित भएमा उजुरीकर्ताको कति अङ्क कट्टा हुने व्यवस्था छ?', E'पहिलो पटकको उजुरी भए एक अङ्क, दोस्रो पटकको उजुरी भए तीन अङ्क', E'पहिलो पटकको उजुरी भए एक अङ्क र दोस्रो पटकको उजुरी भए दुई अङ्क', E'पहिलो पटकको उजुरी भए दोस्रो पटकको उजुरी भए चार अङ्क', E'पहिलो र दोस्रो पटकको उजुरी भए दुई-दुई अङ्क', E'A', E'**गलत मनसायले गरिएको उजुरी प्रमाणित भएमा पहिलो पटकको उजुरीमा एक अङ्क र दोस्रो पटकको उजुरीमा तीन अङ्क कट्टा हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षकहरूको कार्यसम्पादन मूल्याङ्कनको आधारमा हुने बढुवा सिफारिस उपर परेको उजुरी गलत मनसायले गरिएको प्रमाणित भएमा उजुरीकर्ताको कति अङ्क कट्टा हुने व्यवस्था छ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षकहरूको आन्तरिक प्रतियोगितात्मक परीक्षाको माध्यमबाट हुने बढुवाको अन्तर्वार्तामा अनुभवबापत बढीमा कति अङ्क दिने व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'शिक्षकहरूको आन्तरिक प्रतियोगितात्मक परीक्षाको माध्यमबाट हुने बढुवाको अन्तर्वार्तामा अनुभवबापत बढीमा कति अङ्क दिने व्यवस्था छ?', E'५ अङ्क', E'१० अङ्क', E'१५ अङ्क', E'सात अङ्क', E'B', E'**आन्तरिक प्रतियोगितात्मक परीक्षाको अन्तर्वार्तामा अनुभवबापत बढीमा १० अङ्क दिइन्छ।**\\nनोट: प्रत्येक वर्ष १ अङ्कका दरले यो अङ्क गणना गरिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षकहरूको आन्तरिक प्रतियोगितात्मक परीक्षाको माध्यमबाट हुने बढुवाको अन्तर्वार्तामा अनुभवबापत बढीमा कति अङ्क दिने व्यवस्था छ?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षकले शैक्षिक सत्र प्रारम्भ भएको कति दिनभित्र कार्यसम्पादन मूल्याङ्कन फाराम भरी विद्यालयमा दर्ता गराउनुपर्ने व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'शिक्षकले शैक्षिक सत्र प्रारम्भ भएको कति दिनभित्र कार्यसम्पादन मूल्याङ्कन फाराम भरी विद्यालयमा दर्ता गराउनुपर्ने व्यवस्था छ?', E'३० दिन', E'७ दिन', E'१५ दिन', E'४५ दिन', E'C', E'**शिक्षकले शैक्षिक सत्र प्रारम्भ भएको १५ दिनभित्र कार्यसम्पादन मूल्याङ्कन फाराम भरी विद्यालयमा दर्ता गराउनुपर्दछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षकले शैक्षिक सत्र प्रारम्भ भएको कति दिनभित्र कार्यसम्पादन मूल्याङ्कन फाराम भरी विद्यालयमा दर्ता गराउनुपर्ने व्यवस्था छ?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षकहरूको कार्यसम्पादन मूल्याङ्कनको आधारमा हुने बढुवा सिफारिस उपर उजुरी परेमा आयोगले कति दिनभित्र उजुरीको टुङ्गो लगाइसक्नुपर्दछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'शिक्षकहरूको कार्यसम्पादन मूल्याङ्कनको आधारमा हुने बढुवा सिफारिस उपर उजुरी परेमा आयोगले कति दिनभित्र उजुरीको टुङ्गो लगाइसक्नुपर्दछ?', E'३५ दिन', E'६० दिन', E'९० दिन', E'४५ दिन', E'D', E'**आयोगले उजुरी परेको मितिले ४५ दिनभित्र टुङ्गो लगाइसक्नुपर्दछ।**\\nनोट: बढुवा सिफारिसमा चित्त नबुझेको उम्मेदवारले ३५ दिनभित्र आयोगमा उजुरी दिन सक्दछन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षकहरूको कार्यसम्पादन मूल्याङ्कनको आधारमा हुने बढुवा सिफारिस उपर उजुरी परेमा आयोगले कति दिनभित्र उजुरीको टुङ्गो लगाइसक्नुपर्दछ?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षक सेवा आयोग नियमावली, २०५७ अनुसार उजुरी नपरेको अवस्थामा नतिजा प्रकाशन भएको कति समयभित्र परीक्षा सम्बन्धी कागजात गुल्याउनुपर्ने व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'शिक्षक सेवा आयोग नियमावली, २०५७ अनुसार उजुरी नपरेको अवस्थामा नतिजा प्रकाशन भएको कति समयभित्र परीक्षा सम्बन्धी कागजात गुल्याउनुपर्ने व्यवस्था छ?', E'तीन महिना', E'छ महिना', E'नौ महिना', E'एक वर्ष', E'A', E'**उजुरी नपरेको अवस्थामा नतिजा प्रकाशन भएको तीन महिनाभित्र परीक्षा सम्बन्धी कागजात गुल्याउनुपर्दछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षक सेवा आयोग नियमावली, २०५७ अनुसार उजुरी नपरेको अवस्थामा नतिजा प्रकाशन भएको कति समयभित्र परीक्षा सम्बन्धी कागजात गुल्याउनुपर्ने व्यवस्था छ?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कार्यसम्पादनको आधारमा बढुवा भएका शिक्षकहरूको बढुवा नामावली प्रकाशित भएको मितिले नियुक्तिका लागि कति दिनसम्म प्रतीक्षा सूचीमा राखिनेछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'कार्यसम्पादनको आधारमा बढुवा भएका शिक्षकहरूको बढुवा नामावली प्रकाशित भएको मितिले नियुक्तिका लागि कति दिनसम्म प्रतीक्षा सूचीमा राखिनेछ?', E'१५ दिन', E'३५ दिन', E'३० दिन', E'९० दिन', E'B', E'**बढुवा नामावली प्रकाशित भएको मितिले ३५ दिनसम्म प्रतीक्षा सूचीमा राखिनेछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कार्यसम्पादनको आधारमा बढुवा भएका शिक्षकहरूको बढुवा नामावली प्रकाशित भएको मितिले नियुक्तिका लागि कति दिनसम्म प्रतीक्षा सूचीमा राखिनेछ?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षक सेवा आयोगले सञ्चालन गर्ने कार्यसम्पादन मूल्याङ्कनको आधारमा बढुवा गर्दा शिक्षकको प्रधानाध्यापकको हकमा शिक्षण कार्यसँग सम्बन्धित विषयको अनुसन्धान र प्रतिवेदन कसले प्रमाणित गर्ने व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'शिक्षक सेवा आयोगले सञ्चालन गर्ने कार्यसम्पादन मूल्याङ्कनको आधारमा बढुवा गर्दा शिक्षकको प्रधानाध्यापकको हकमा शिक्षण कार्यसँग सम्बन्धित विषयको अनुसन्धान र प्रतिवेदन कसले प्रमाणित गर्ने व्यवस्था छ?', E'विद्यालय व्यवस्थापन समिति अध्यक्ष', E'शिक्षक अभिभावक सङ्घको अध्यक्ष', E'स्थानीय तहको शिक्षा हेर्ने प्रमुख', E'इकाई प्रमुख', E'C', E'**प्रधानाध्यापकको हकमा शिक्षण कार्यसँग सम्बन्धित अनुसन्धान र प्रतिवेदन स्थानीय तहको शिक्षा हेर्ने प्रमुखले प्रमाणित गर्दछन्।**\\nनोट: सामान्य शिक्षकको हकमा भने प्रधानाध्यापकले नै प्रमाणित गर्ने व्यवस्था छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षक सेवा आयोगले सञ्चालन गर्ने कार्यसम्पादन मूल्याङ्कनको आधारमा बढुवा गर्दा शिक्षकको प्रधानाध्यापकको हकमा शिक्षण कार्यसँग सम्बन्धित विषयको अनुसन्धान र प्रतिवेदन कसले प्रमाणित गर्ने व्यवस्था छ?'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  RAISE NOTICE 'Unit घ-४ upsert complete: 2 sets, 27 questions.';
END $$;
