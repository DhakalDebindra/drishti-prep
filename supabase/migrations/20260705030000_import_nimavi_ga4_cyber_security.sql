-- Idempotent UPSERT import: निमावि प्रथम पत्र — ग-४ साइबर अपराध र सुरक्षा सम्बन्धी आधारभूत ज्ञान (Level I topic-wise sets)
-- Override same-identity sets/questions; never deletes. Generated 2026-07-05T06:53:08.321Z.
DO $$
DECLARE
  v_module_id uuid := '6695669a-f40e-421a-a4ec-b09bbeaf56c4'::uuid;
  v_set_id uuid;
  v_q_id uuid;
BEGIN

  -- Set: साइबर सुरक्षा सामान्य शब्दावली (आधारभूत तह) (9 Q)
  v_set_id := extensions.uuid_generate_v5('ef718e6e-0a44-4c23-92c4-4f24221b285e'::uuid, E'साइबर सुरक्षा सामान्य शब्दावली (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '53492ac2-434b-4c11-bb7f-bec8f7ebe83b'::uuid, 'ef718e6e-0a44-4c23-92c4-4f24221b285e'::uuid, E'साइबर सुरक्षा सामान्य शब्दावली (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'ef718e6e-0a44-4c23-92c4-4f24221b285e'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कम्प्युटर, नेटवर्क र डाटालाई अनधिकृत पहुँचबाट जोगाउने प्रक्रियालाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'कम्प्युटर, नेटवर्क र डाटालाई अनधिकृत पहुँचबाट जोगाउने प्रक्रियालाई के भनिन्छ?', E'साइबर सेक्युरिटी (Cyber Security)', E'साइबर बुलिङ', E'फिसिङ', E'इ-कमर्स', E'A', E'**कम्प्युटर, नेटवर्क र डाटालाई अनधिकृत पहुँचबाट जोगाउने प्रक्रियालाई साइबर सेक्युरिटी भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कम्प्युटर, नेटवर्क र डाटालाई अनधिकृत पहुँचबाट जोगाउने प्रक्रियालाई के भनिन्छ?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कम्प्युटरको डाटा वा पासवर्ड चोर्ने वा बिगार्ने व्यक्तिलाई के भनिन्छ, र अनधिकृत पहुँचलाई रोक्न नेटवर्कको सुरक्षा गर्ने प्रणालीलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'कम्प्युटरको डाटा वा पासवर्ड चोर्ने वा बिगार्ने व्यक्तिलाई के भनिन्छ, र अनधिकृत पहुँचलाई रोक्न नेटवर्कको सुरक्षा गर्ने प्रणालीलाई के भनिन्छ?', E'फायरवाल — ह्याकर', E'ह्याकर (Hacker) — फायरवाल (Firewall)', E'फिसर (Phisher) — भाइरस', E'बग — फायरवाल', E'B', E'**कम्प्युटरको डाटा वा पासवर्ड चोर्ने व्यक्तिलाई ह्याकर भनिन्छ। अनधिकृत पहुँच रोक्ने नेटवर्क सुरक्षा प्रणालीलाई फायरवाल भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कम्प्युटरको डाटा वा पासवर्ड चोर्ने वा बिगार्ने व्यक्तिलाई के भनिन्छ, र अनधिकृत पहुँचलाई रोक्न नेटवर्कको सुरक्षा गर्ने प्रणालीलाई के भनिन्छ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'इन्टरनेटको माध्यमबाट अरूलाई दुःख दिने वा धम्काउने कार्यलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'इन्टरनेटको माध्यमबाट अरूलाई दुःख दिने वा धम्काउने कार्यलाई के भनिन्छ?', E'फिसिङ', E'ह्याकिङ', E'साइबर बुलिङ (Cyberbullying)', E'स्पुफिङ', E'C', E'**इन्टरनेटमार्फत अरूलाई दुःख दिने वा धम्काउने कार्यलाई साइबर बुलिङ भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:इन्टरनेटको माध्यमबाट अरूलाई दुःख दिने वा धम्काउने कार्यलाई के भनिन्छ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नक्कली इमेल वा वेबसाइट बनाएर प्रयोगकर्ताको पासवर्ड वा बैंकिङ विवरण चोर्ने कार्यलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'नक्कली इमेल वा वेबसाइट बनाएर प्रयोगकर्ताको पासवर्ड वा बैंकिङ विवरण चोर्ने कार्यलाई के भनिन्छ?', E'साइबर बुलिङ', E'क्यास मेमोरी', E'फर्मवेयर', E'फिसिङ (Phishing)', E'D', E'**नक्कली इमेल वा वेबसाइट बनाएर पासवर्ड वा बैंकिङ विवरण चोर्ने कार्यलाई फिसिङ भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नक्कली इमेल वा वेबसाइट बनाएर प्रयोगकर्ताको पासवर्ड वा बैंकिङ विवरण चोर्ने कार्यलाई के भनिन्छ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'OTP र CAPTCHA को पूरा रूप/प्रयोजन के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'OTP र CAPTCHA को पूरा रूप/प्रयोजन के हो?', E'OTP=One Time Password; CAPTCHA=प्रयोगकर्ता मान्छे हो वा मेसिन (Bot) भनेर छुट्याउन', E'OTP=Online Test Protocol; CAPTCHA=पासवर्ड सेभ गर्न', E'OTP=One Time Protocol; CAPTCHA=फाइल कम्प्रेस गर्न', E'OTP=Online Time Password; CAPTCHA=भाइरस हटाउन', E'A', E'**OTP को पूरा रूप One Time Password हो। CAPTCHA प्रयोगकर्ता मान्छे हो वा मेसिन (Bot) भनेर छुट्याउन प्रयोग गरिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:OTP र CAPTCHA को पूरा रूप/प्रयोजन के हो?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुकिज (Cookies) ले कम्प्युटर वा ब्राउजरमा के काम गर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'कुकिज (Cookies) ले कम्प्युटर वा ब्राउजरमा के काम गर्छ?', E'कम्प्युटरको भाइरस हटाउँछ', E'प्रयोगकर्ताको वेब ब्राउजिङ विवरण र प्राथमिकताहरू सेभ गरेर राख्छ', E'फाइल स्थायी रूपमा डिलिट गर्छ', E'इन्टरनेट स्पिड बढाउँछ', E'B', E'**कुकिजले प्रयोगकर्ताको वेब ब्राउजिङ विवरण र प्राथमिकताहरू सेभ गरेर राख्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुकिज (Cookies) ले कम्प्युटर वा ब्राउजरमा के काम गर्छ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'इ-कमर्स (E-Commerce) भनेको के हो, र B2B, B2C, C2C कुन व्यवसायका प्रकार हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'इ-कमर्स (E-Commerce) भनेको के हो, र B2B, B2C, C2C कुन व्यवसायका प्रकार हुन्?', E'सरकारी सेवा अनलाइन दिने कार्य — इ-गभर्नेन्सका प्रकार', E'इमेल पठाउने कार्य — नेटवर्किङका प्रकार', E'इन्टरनेटको माध्यमबाट सामान खरिद र बिक्री गर्ने कार्य — इ-कमर्सका प्रकार', E'सफ्टवेयर बेच्ने कार्य मात्र — सफ्टवेयरका प्रकार', E'C', E'**इ-कमर्स इन्टरनेटमार्फत सामान खरिद-बिक्री गर्ने कार्य हो (जस्तै Daraz, Amazon)। B2B, B2C, C2C इ-कमर्सकै प्रकार हुन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:इ-कमर्स (E-Commerce) भनेको के हो, र B2B, B2C, C2C कुन व्यवसायका प्रकार हुन्?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'इ-गभर्नेन्स (E-Governance) भनेको के हो, र G2C कुन कुराको उदाहरण हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'इ-गभर्नेन्स (E-Governance) भनेको के हो, र G2C कुन कुराको उदाहरण हो?', E'निजी क्षेत्रको व्यापार — इ-कमर्सको उदाहरण', E'सामाजिक सञ्जाल प्रयोग — साइबर बुलिङको उदाहरण', E'अनलाइन कक्षा सञ्चालन — E-Learning को उदाहरण', E'सरकारी सेवा सूचना प्रविधिमार्फत जनतालाई प्रदान गर्ने कार्य — इ-गभर्नेन्सको उदाहरण (Government to Citizen)', E'D', E'**इ-गभर्नेन्स सरकारी सेवा-सुविधा सूचना प्रविधिमार्फत जनतालाई प्रदान गर्ने कार्य हो। G2C (Government to Citizen) यसैको एउटा उदाहरण हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:इ-गभर्नेन्स (E-Governance) भनेको के हो, र G2C कुन कुराको उदाहरण हो?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपाल प्रहरीमा साइबर अपराध अनुसन्धान गर्ने छुट्टै निकाय कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'नेपाल प्रहरीमा साइबर अपराध अनुसन्धान गर्ने छुट्टै निकाय कुन हो?', E'साइबर ब्युरो (Cyber Bureau)', E'अपराध अनुसन्धान महाशाखा', E'राष्ट्रिय सूचना प्रविधि केन्द्र', E'प्रहरी प्रधान कार्यालय', E'A', E'**नेपाल प्रहरीमा साइबर अपराध अनुसन्धान गर्ने छुट्टै निकाय साइबर ब्युरो (Cyber Bureau) हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपाल प्रहरीमा साइबर अपराध अनुसन्धान गर्ने छुट्टै निकाय कुन हो?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: विद्युतीय कारोबार ऐन, २०६३ र साइबर कसुर-सजाय (आधारभूत तह) (6 Q)
  v_set_id := extensions.uuid_generate_v5('52a91643-958e-414b-8a68-6a115a5ad302'::uuid, E'विद्युतीय कारोबार ऐन, २०६३ र साइबर कसुर-सजाय (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '53492ac2-434b-4c11-bb7f-bec8f7ebe83b'::uuid, '52a91643-958e-414b-8a68-6a115a5ad302'::uuid, E'विद्युतीय कारोबार ऐन, २०६३ र साइबर कसुर-सजाय (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '52a91643-958e-414b-8a68-6a115a5ad302'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालको विद्युतीय (इलेक्ट्रोनिक) कारोबार ऐन, २०६३ ले मुख्यतया के-के कुरालाई नियमन गर्दछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'नेपालको विद्युतीय (इलेक्ट्रोनिक) कारोबार ऐन, २०६३ ले मुख्यतया के-के कुरालाई नियमन गर्दछ?', E'साइबर अपराध र विद्युतीय हस्ताक्षर (Digital Signature)', E'इन्टरनेट स्पिड र ब्यान्डविड्थ', E'मोबाइल फोन आयात-निर्यात', E'विद्यालयको पाठ्यक्रम निर्माण', E'A', E'**विद्युतीय कारोबार ऐन, २०६३ ले साइबर अपराध र विद्युतीय हस्ताक्षर (Digital Signature) लाई नियमन गर्दछ।**\\nनोट: यसैलाई नेपालको मूल साइबर कानून मानिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालको विद्युतीय (इलेक्ट्रोनिक) कारोबार ऐन, २०६३ ले मुख्यतया के-के कुरालाई नियमन गर्दछ?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्युतीय कारोबार ऐन, २०६३ को दफा ४४ अनुसार कसैले जानीजानी कम्प्युटर सोर्स कोड चोरी, नष्ट वा परिवर्तन गरेमा कस्तो सजायको व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'विद्युतीय कारोबार ऐन, २०६३ को दफा ४४ अनुसार कसैले जानीजानी कम्प्युटर सोर्स कोड चोरी, नष्ट वा परिवर्तन गरेमा कस्तो सजायको व्यवस्था छ?', E'बढीमा ५ वर्ष कैद वा १ लाख रुपैयाँसम्म जरिवाना वा दुवै', E'बढीमा ३ वर्ष कैद वा २ लाख रुपैयाँसम्म जरिवाना वा दुवै', E'बढीमा २ वर्ष कैद वा १ लाख रुपैयाँसम्म जरिवाना वा दुवै', E'बढीमा १ वर्ष कैद वा ५० हजार रुपैयाँसम्म जरिवाना वा दुवै', E'B', E'**दफा ४४ अनुसार कम्प्युटर सोर्स कोड चोरी, नष्ट वा परिवर्तन गरेमा बढीमा ३ वर्ष कैद वा २ लाख रुपैयाँसम्म जरिवाना वा दुवै सजाय हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्युतीय कारोबार ऐन, २०६३ को दफा ४४ अनुसार कसैले जानीजानी कम्प्युटर सोर्स कोड चोरी, नष्ट वा परिवर्तन गरेमा कस्तो सजायको व्यवस्था छ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्युतीय कारोबार ऐन, २०६३ को दफा ४६ अनुसार कसैले अनधिकृत रूपमा कम्प्युटर प्रणालीमा पहुँच (ह्याकिङ) गरेमा कस्तो सजायको व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'विद्युतीय कारोबार ऐन, २०६३ को दफा ४६ अनुसार कसैले अनधिकृत रूपमा कम्प्युटर प्रणालीमा पहुँच (ह्याकिङ) गरेमा कस्तो सजायको व्यवस्था छ?', E'बढीमा ५ वर्ष कैद वा १ लाख रुपैयाँसम्म जरिवाना वा दुवै', E'बढीमा २ वर्ष कैद वा १ लाख रुपैयाँसम्म जरिवाना वा दुवै', E'बढीमा ३ वर्ष कैद वा २ लाख रुपैयाँसम्म जरिवाना वा दुवै', E'बढीमा १० वर्ष कैद वा १० लाख रुपैयाँसम्म जरिवाना वा दुवै', E'C', E'**दफा ४६ अनुसार अख्तियारी नलिई कम्प्युटर प्रणालीमा पहुँच (ह्याकिङ) गरेमा बढीमा ३ वर्ष कैद वा २ लाख रुपैयाँसम्म जरिवाना वा दुवै सजाय हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्युतीय कारोबार ऐन, २०६३ को दफा ४६ अनुसार कसैले अनधिकृत रूपमा कम्प्युटर प्रणालीमा पहुँच (ह्याकिङ) गरेमा कस्तो सजायको व्यवस्था छ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्युतीय कारोबार ऐन, २०६३ को दफा ४७ अनुसार विद्युतीय रूपमा अश्लील वा घृणा फैलाउने सामग्री प्रकाशन गरेमा कस्तो सजायको व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'विद्युतीय कारोबार ऐन, २०६३ को दफा ४७ अनुसार विद्युतीय रूपमा अश्लील वा घृणा फैलाउने सामग्री प्रकाशन गरेमा कस्तो सजायको व्यवस्था छ?', E'बढीमा ३ वर्ष कैद वा २ लाख रुपैयाँसम्म जरिवाना वा दुवै', E'बढीमा २ वर्ष कैद वा १ लाख रुपैयाँसम्म जरिवाना वा दुवै', E'बढीमा ६ महिना कैद वा २५ हजार रुपैयाँसम्म जरिवाना वा दुवै', E'बढीमा ५ वर्ष कैद वा १ लाख रुपैयाँसम्म जरिवाना वा दुवै', E'D', E'**दफा ४७ अनुसार विद्युतीय माध्यमबाट अश्लील वा घृणा-द्वेष फैलाउने सामग्री प्रकाशन वा प्रदर्शन गरेमा बढीमा ५ वर्ष कैद वा १ लाख रुपैयाँसम्म जरिवाना वा दुवै सजाय हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्युतीय कारोबार ऐन, २०६३ को दफा ४७ अनुसार विद्युतीय रूपमा अश्लील वा घृणा फैलाउने सामग्री प्रकाशन गरेमा कस्तो सजायको व्यवस्था छ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्युतीय कारोबार ऐन, २०६३ को दफा ४८ अनुसार कसैको विद्युतीय अभिलेख वा सूचनाको गोपनीयता भङ्ग गरेमा कस्तो सजायको व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'विद्युतीय कारोबार ऐन, २०६३ को दफा ४८ अनुसार कसैको विद्युतीय अभिलेख वा सूचनाको गोपनीयता भङ्ग गरेमा कस्तो सजायको व्यवस्था छ?', E'बढीमा २ वर्ष कैद वा १ लाख रुपैयाँसम्म जरिवाना वा दुवै', E'बढीमा ५ वर्ष कैद वा १ लाख रुपैयाँसम्म जरिवाना वा दुवै', E'बढीमा ३ वर्ष कैद वा २ लाख रुपैयाँसम्म जरिवाना वा दुवै', E'बढीमा १ वर्ष कैद वा ५० हजार रुपैयाँसम्म जरिवाना वा दुवै', E'A', E'**दफा ४८ अनुसार विद्युतीय अभिलेख, सूचना वा कागजातको गोपनीयता भङ्ग गरेमा बढीमा २ वर्ष कैद वा १ लाख रुपैयाँसम्म जरिवाना वा दुवै सजाय हुन्छ।**\\nनोट: दफा ४४ (सोर्स कोड) र दफा ४६ (अनधिकृत पहुँच) मा भने ३ वर्ष कैद वा २ लाख जरिवानासम्मको सजाय हुन्छ — गोपनीयता भङ्गको सजाय यीभन्दा कम छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्युतीय कारोबार ऐन, २०६३ को दफा ४८ अनुसार कसैको विद्युतीय अभिलेख वा सूचनाको गोपनीयता भङ्ग गरेमा कस्तो सजायको व्यवस्था छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्युतीय कारोबार ऐन, २०६३ अनुसार साइबर अपराधसम्बन्धी दफाहरू ऐनको कुन परिच्छेदमा राखिएका छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'विद्युतीय कारोबार ऐन, २०६३ अनुसार साइबर अपराधसम्बन्धी दफाहरू ऐनको कुन परिच्छेदमा राखिएका छन्?', E'परिच्छेद ३ (विद्युतीय अभिलेख)', E'परिच्छेद ९ (कम्प्युटर सम्बन्धी कसुर)', E'परिच्छेद ५ (डिजिटल हस्ताक्षर)', E'परिच्छेद १ (प्रारम्भिक व्यवस्था)', E'B', E'**साइबर अपराधसम्बन्धी दफाहरू (सोर्स कोड चोरी, अनधिकृत पहुँच, गैरकानुनी प्रकाशन, गोपनीयता भङ्ग आदि) ऐनको परिच्छेद ९ (कम्प्युटर सम्बन्धी कसुर) मा राखिएका छन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्युतीय कारोबार ऐन, २०६३ अनुसार साइबर अपराधसम्बन्धी दफाहरू ऐनको कुन परिच्छेदमा राखिएका छन्?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  RAISE NOTICE 'ग-४ साइबर अपराध र सुरक्षा upsert complete: 2 sets, 15 questions.';
END $$;
