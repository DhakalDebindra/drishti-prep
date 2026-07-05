-- Idempotent UPSERT import: निमावि प्रथम पत्र — ग-२ IEMIS: विद्यालयमा प्रयोग गरिने साधारण सफ्टवेयर (Level I topic-wise sets)
-- Override same-identity sets/questions; never deletes. Generated 2026-07-05T06:42:45.273Z.
DO $$
DECLARE
  v_module_id uuid := '6695669a-f40e-421a-a4ec-b09bbeaf56c4'::uuid;
  v_set_id uuid;
  v_q_id uuid;
BEGIN

  -- Set: IEMIS को परिचय, लगइन र विद्यार्थी ट्र्याकिङ (आधारभूत तह) (10 Q)
  v_set_id := extensions.uuid_generate_v5('bd7226f8-060a-4009-b0bd-cdd4f279475b'::uuid, E'IEMIS को परिचय, लगइन र विद्यार्थी ट्र्याकिङ (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'f2406808-49ed-4b71-b2e7-cb2e4d8967a5'::uuid, 'bd7226f8-060a-4009-b0bd-cdd4f279475b'::uuid, E'IEMIS को परिचय, लगइन र विद्यार्थी ट्र्याकिङ (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'bd7226f8-060a-4009-b0bd-cdd4f279475b'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'IEMIS को पूरा रूप के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'IEMIS को पूरा रूप के हो?', E'Integrated Educational Management Information System', E'International Education Monitoring Information System', E'Integrated Examination Management Information System', E'Institutional Education Management Information System', E'A', E'**IEMIS को पूरा रूप Integrated Educational Management Information System हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:IEMIS को पूरा रूप के हो?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालमा IEMIS को मुख्य उद्देश्य के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'नेपालमा IEMIS को मुख्य उद्देश्य के हो?', E'विद्यार्थीलाई अनलाइन कक्षा सञ्चालन गर्नु', E'विद्यालय, विद्यार्थी र शिक्षकको यथार्थ विवरण अनलाइन प्रणालीमा व्यवस्थित गर्नु', E'शिक्षकको तलब बैंकमार्फत भुक्तानी गर्नु मात्र', E'विद्यालयको पाठ्यक्रम अनलाइन प्रकाशन गर्नु', E'B', E'**IEMIS को मुख्य उद्देश्य विद्यालय, विद्यार्थी र शिक्षकको यथार्थ विवरण अनलाइन प्रणालीमा व्यवस्थित गर्नु हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालमा IEMIS को मुख्य उद्देश्य के हो?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालमा IEMIS प्रणाली कुन निकायले सञ्चालन र व्यवस्थापन गर्दछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'नेपालमा IEMIS प्रणाली कुन निकायले सञ्चालन र व्यवस्थापन गर्दछ?', E'शिक्षा, विज्ञान तथा प्रविधि मन्त्रालय', E'राष्ट्रिय सूचना प्रविधि केन्द्र', E'शिक्षा तथा मानव स्रोत विकास केन्द्र (CEHRD)', E'शिक्षक सेवा आयोग', E'C', E'**IEMIS प्रणाली शिक्षा तथा मानव स्रोत विकास केन्द्र (CEHRD) ले सञ्चालन र व्यवस्थापन गर्दछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालमा IEMIS प्रणाली कुन निकायले सञ्चालन र व्यवस्थापन गर्दछ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'IEMIS प्रणालीमा कस्तो प्रकारको प्रविधिको प्रयोग गरिएको छ, र इन्टरनेट नभएको अवस्थामा विद्यालयले कुन विकल्प प्रयोग गर्न सक्छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'IEMIS प्रणालीमा कस्तो प्रकारको प्रविधिको प्रयोग गरिएको छ, र इन्टरनेट नभएको अवस्थामा विद्यालयले कुन विकल्प प्रयोग गर्न सक्छन्?', E'मोबाइल एपमा आधारित प्रणाली — SMS मार्फत', E'डेस्कटप सफ्टवेयर — USB मार्फत डाटा सार्ने', E'वेबमा आधारित प्रणाली — कागजी फारम मात्र', E'वेबमा आधारित प्रणाली — एक्सेलमा आधारित अफलाइन टेम्प्लेट', E'D', E'**IEMIS वेबमा आधारित (Web-based) प्रणाली हो। इन्टरनेट नभएको अवस्थामा विद्यालयले एक्सेलमा आधारित अफलाइन टेम्प्लेट प्रयोग गर्न सक्छन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:IEMIS प्रणालीमा कस्तो प्रकारको प्रविधिको प्रयोग गरिएको छ, र इन्टरनेट नभएको अवस्थामा विद्यालयले कुन विकल्प प्रयोग गर्न सक्छन्?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा विभाग (हाल CEHRD) ले कहिलेदेखि वेबमा आधारित IEMIS प्रणाली सुरु गरेको हो, र सुरुवाती चरणमा तथ्याङ्क सङ्कलनका लागि कुन-कुन कार्यक्रम प्रयोग गरिन्थ्यो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'शिक्षा विभाग (हाल CEHRD) ले कहिलेदेखि वेबमा आधारित IEMIS प्रणाली सुरु गरेको हो, र सुरुवाती चरणमा तथ्याङ्क सङ्कलनका लागि कुन-कुन कार्यक्रम प्रयोग गरिन्थ्यो?', E'आर्थिक वर्ष २०७१/७२ देखि — MS Access र MS Excel', E'आर्थिक वर्ष २०६५/६६ देखि — MS Word', E'आर्थिक वर्ष २०७५/७६ देखि — Google Sheets', E'आर्थिक वर्ष २०६८/६९ देखि — MS Access मात्र', E'A', E'**वेबमा आधारित IEMIS प्रणाली आर्थिक वर्ष २०७१/७२ देखि सुरु भएको हो। सुरुवाती चरणमा MS Access र MS Excel प्रयोग गरिन्थ्यो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा विभाग (हाल CEHRD) ले कहिलेदेखि वेबमा आधारित IEMIS प्रणाली सुरु गरेको हो, र सुरुवाती चरणमा तथ्याङ्क सङ्कलनका लागि कुन-कुन कार्यक्रम प्रयोग गरिन्थ्यो?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'IEMIS पोर्टलमा लगइन गर्न विद्यालयलाई के-के आवश्यक पर्दछ, र School Code कति अंकको हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'IEMIS पोर्टलमा लगइन गर्न विद्यालयलाई के-के आवश्यक पर्दछ, र School Code कति अंकको हुन्छ?', E'Email र Password — १० अंक', E'School Code र Password — ९ अंक', E'Username र OTP — ६ अंक', E'School Code मात्र — ८ अंक', E'B', E'**IEMIS पोर्टलमा लगइन गर्न विद्यालयको कोड (School Code) र पासवर्ड चाहिन्छ। School Code ९ अंकको हुन्छ, जुन युजरनेमको रूपमा पनि प्रयोग हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:IEMIS पोर्टलमा लगइन गर्न विद्यालयलाई के-के आवश्यक पर्दछ, र School Code कति अंकको हुन्छ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यालयको IEMIS पासवर्ड बिर्सिएमा वा रिसेट गर्नुपरेमा कुन निकायमा सम्पर्क गर्नुपर्दछ, र नयाँ विद्यालय दर्ता गर्ने कार्य कसले गर्दछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'विद्यालयको IEMIS पासवर्ड बिर्सिएमा वा रिसेट गर्नुपरेमा कुन निकायमा सम्पर्क गर्नुपर्दछ, र नयाँ विद्यालय दर्ता गर्ने कार्य कसले गर्दछ?', E'जिल्ला प्रशासन कार्यालय — मन्त्रालयले सिधै', E'शिक्षक सेवा आयोग — प्रधानाध्यापकले आफैं', E'स्थानीय तहको शिक्षा शाखा — CEHRD ले स्थानीय तहको सिफारिसमा', E'राष्ट्रिय सूचना प्रविधि केन्द्र — CEHRD ले सिधै', E'C', E'**पासवर्ड रिसेटका लागि स्थानीय तहको शिक्षा शाखामा सम्पर्क गर्नुपर्दछ। नयाँ विद्यालय दर्ता CEHRD ले स्थानीय तहको सिफारिसमा गर्दछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यालयको IEMIS पासवर्ड बिर्सिएमा वा रिसेट गर्नुपरेमा कुन निकायमा सम्पर्क गर्नुपर्दछ, र नयाँ विद्यालय दर्ता गर्ने कार्य कसले गर्दछ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'PMT को पूरा रूप के हो, र यो कुन प्रयोजनका लागि प्रयोग गरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'PMT को पूरा रूप के हो, र यो कुन प्रयोजनका लागि प्रयोग गरिन्छ?', E'Primary Merit Test — भर्ना परीक्षाका लागि', E'Public Monitoring Tool — शिक्षक अनुगमनका लागि', E'Proxy Marking Test — परीक्षा मूल्याङ्कनका लागि', E'Proxy Means Testing — छात्रवृत्ति छनोटका लागि', E'D', E'**PMT (Proxy Means Testing) गरिब तथा विपन्न लक्षित छात्रवृत्तिका लागि विद्यार्थी छनोट गर्ने विधि हो, जुन IEMIS को PMT मोड्युलमार्फत भरिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:PMT को पूरा रूप के हो, र यो कुन प्रयोजनका लागि प्रयोग गरिन्छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विपन्न लक्षित छात्रवृत्तिका लागि कक्षा कतिमा अध्ययनरत विद्यार्थीले PMT फारम भर्न पाउँछन्, र यसमा कुन विवरण अनिवार्य छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'विपन्न लक्षित छात्रवृत्तिका लागि कक्षा कतिमा अध्ययनरत विद्यार्थीले PMT फारम भर्न पाउँछन्, र यसमा कुन विवरण अनिवार्य छ?', E'कक्षा ८ र १० — जन्म दर्ता नम्बर र अभिभावकको नागरिकता नम्बर', E'कक्षा ५ र ८ — विद्यार्थीको नागरिकता नम्बर', E'कक्षा १० र १२ — जन्म दर्ता नम्बर मात्र', E'सबै कक्षा — अभिभावकको नागरिकता नम्बर मात्र', E'A', E'**कक्षा ८ र १० मा अध्ययनरत विद्यार्थीले PMT फारम भर्न पाउँछन्; यसमा जन्म दर्ता नम्बर र अभिभावकको नागरिकता नम्बर अनिवार्य हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विपन्न लक्षित छात्रवृत्तिका लागि कक्षा कतिमा अध्ययनरत विद्यार्थीले PMT फारम भर्न पाउँछन्, र यसमा कुन विवरण अनिवार्य छ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यार्थी अर्को विद्यालयमा सरुवा भई जाँदा IEMIS मा कुन प्रक्रिया अपनाइन्छ, र यसका लागि के अनिवार्य चाहिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'विद्यार्थी अर्को विद्यालयमा सरुवा भई जाँदा IEMIS मा कुन प्रक्रिया अपनाइन्छ, र यसका लागि के अनिवार्य चाहिन्छ?', E'विद्यार्थीको खाता स्थायी रूपमा मेटाइन्छ — जन्ममिति', E'विद्यार्थीलाई Transfer गरिन्छ र अर्को विद्यालयले Fetch गर्दछ — Student ID', E'अर्को विद्यालयले नयाँ खाता खोल्छ — School Code', E'प्रधानाध्यापकले फोनमार्फत जानकारी दिन्छन् — केही चाहिँदैन', E'B', E'**सरुवा हुँदा विद्यार्थीलाई Transfer गरिन्छ र अर्को विद्यालयले Fetch Student मेनुबाट तान्दछ, जसका लागि विद्यार्थीको Student ID (ट्र्याकिङ नम्बर) अनिवार्य चाहिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यार्थी अर्को विद्यालयमा सरुवा भई जाँदा IEMIS मा कुन प्रक्रिया अपनाइन्छ, र यसका लागि के अनिवार्य चाहिन्छ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: IEMIS: फ्ल्यास रिपोर्ट, शिक्षक व्यवस्थापन र भौतिक पूर्वाधार मोड्युल (आधारभूत तह) (10 Q)
  v_set_id := extensions.uuid_generate_v5('247c0466-884e-46ba-8506-571bce01f16b'::uuid, E'IEMIS: फ्ल्यास रिपोर्ट, शिक्षक व्यवस्थापन र भौतिक पूर्वाधार मोड्युल (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'f2406808-49ed-4b71-b2e7-cb2e4d8967a5'::uuid, '247c0466-884e-46ba-8506-571bce01f16b'::uuid, E'IEMIS: फ्ल्यास रिपोर्ट, शिक्षक व्यवस्थापन र भौतिक पूर्वाधार मोड्युल (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '247c0466-884e-46ba-8506-571bce01f16b'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यालयको शैक्षिक तथ्याङ्क सङ्कलन गर्ने मुख्य दुई प्रतिवेदनलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'विद्यालयको शैक्षिक तथ्याङ्क सङ्कलन गर्ने मुख्य दुई प्रतिवेदनलाई के भनिन्छ?', E'फ्ल्यास प्रथम (Flash I) र फ्ल्यास द्वितीय (Flash II)', E'वार्षिक प्रतिवेदन र मासिक प्रतिवेदन', E'शैक्षिक अडिट र वित्तीय अडिट', E'सामान्य फारम र विशेष फारम', E'A', E'**विद्यालयको शैक्षिक तथ्याङ्क सङ्कलन गर्ने मुख्य दुई प्रतिवेदन फ्ल्यास प्रथम (Flash I) र फ्ल्यास द्वितीय (Flash II) हुन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यालयको शैक्षिक तथ्याङ्क सङ्कलन गर्ने मुख्य दुई प्रतिवेदनलाई के भनिन्छ?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'फ्ल्यास प्रथम (Flash I) प्रतिवेदन कहिले भरिन्छ, र यसले मुख्यतया कस्तो तथ्याङ्क समेट्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'फ्ल्यास प्रथम (Flash I) प्रतिवेदन कहिले भरिन्छ, र यसले मुख्यतया कस्तो तथ्याङ्क समेट्छ?', E'शैक्षिक सत्रको अन्त्यमा — परीक्षा नतिजा', E'शैक्षिक सत्रको सुरुमा (जेठ ७ गतेभित्र) — विद्यार्थी भर्ना, शिक्षक दरबन्दी र भौतिक पूर्वाधार', E'वर्षको बीचमा — शिक्षक तालिम विवरण', E'शैक्षिक सत्रको सुरुमा — केवल शिक्षक तलब विवरण', E'B', E'**फ्ल्यास प्रथम शैक्षिक सत्रको सुरुमा (जेठ ७ गतेभित्र) भरिन्छ र विद्यार्थी भर्ना अवस्था, शिक्षक दरबन्दी र भौतिक पूर्वाधार समेट्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:फ्ल्यास प्रथम (Flash I) प्रतिवेदन कहिले भरिन्छ, र यसले मुख्यतया कस्तो तथ्याङ्क समेट्छ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'फ्ल्यास द्वितीय (Flash II) प्रतिवेदन कहिले भरिन्छ, र यसले मुख्यतया कस्तो तथ्याङ्क समेट्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'फ्ल्यास द्वितीय (Flash II) प्रतिवेदन कहिले भरिन्छ, र यसले मुख्यतया कस्तो तथ्याङ्क समेट्छ?', E'शैक्षिक सत्रको सुरुमा — शिक्षक दरबन्दी', E'शैक्षिक सत्रको अन्त्यमा — विद्यार्थी भर्ना अवस्था मात्र', E'शैक्षिक सत्रको अन्त्यमा (चैत मसान्त वा वैशाख ७ भित्र) — शैक्षिक उपलब्धि, परीक्षा नतिजा र टिकाउ/छाड्ने दर', E'प्रत्येक महिना — भौतिक पूर्वाधार', E'C', E'**फ्ल्यास द्वितीय शैक्षिक सत्रको अन्त्यमा भरिन्छ र विद्यार्थीको शैक्षिक उपलब्धि, परीक्षा नतिजा र टिकाउ/छाड्ने दर समेट्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:फ्ल्यास द्वितीय (Flash II) प्रतिवेदन कहिले भरिन्छ, र यसले मुख्यतया कस्तो तथ्याङ्क समेट्छ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालमा फ्ल्यास रिपोर्टिङ प्रणाली (Flash Reporting System) कहिलेदेखि सुरु भएको हो, र विद्यालयले भरेको फ्ल्यास रिपोर्टको प्रमाणीकरण कसले गर्दछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'नेपालमा फ्ल्यास रिपोर्टिङ प्रणाली (Flash Reporting System) कहिलेदेखि सुरु भएको हो, र विद्यालयले भरेको फ्ल्यास रिपोर्टको प्रमाणीकरण कसले गर्दछ?', E'शैक्षिक सत्र २०७१ देखि — CEHRD ले सिधै', E'शैक्षिक सत्र २०५५ देखि — जिल्ला शिक्षा समितिले', E'शैक्षिक सत्र २०६५ देखि — प्रधानाध्यापकले आफैं', E'शैक्षिक सत्र २०६१ देखि — स्थानीय तहको शिक्षा शाखाले', E'D', E'**फ्ल्यास रिपोर्टिङ प्रणाली शैक्षिक सत्र २०६१ देखि सुरु भएको हो। विद्यालयले भरेको फ्ल्यास रिपोर्टको प्रमाणीकरण स्थानीय तहको शिक्षा शाखाले गर्दछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालमा फ्ल्यास रिपोर्टिङ प्रणाली (Flash Reporting System) कहिलेदेखि सुरु भएको हो, र विद्यालयले भरेको फ्ल्यास रिपोर्टको प्रमाणीकरण कसले गर्दछ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यालयमा कार्यरत शिक्षकको विवरण IEMIS को कुन मेनुमा राखिन्छ, र शिक्षकको तलब-भत्ता निकासाको आधार कुन प्रणाली मानिएको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'विद्यालयमा कार्यरत शिक्षकको विवरण IEMIS को कुन मेनुमा राखिन्छ, र शिक्षकको तलब-भत्ता निकासाको आधार कुन प्रणाली मानिएको छ?', E'Staff मेनु — IEMIS मा रहेको शिक्षक दरबन्दी र विवरण', E'Financial मेनु — अलग्गै तलब प्रणाली', E'Physical मेनु — जिल्ला शिक्षा समितिको सिफारिस', E'PMT मेनु — विद्यार्थी सङ्ख्या', E'A', E'**शिक्षकको विवरण Staff मेनुमा राखिन्छ; तलब-भत्ता निकासाको आधार IEMIS मा रहेको शिक्षक दरबन्दी र विवरणलाई मानिएको छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यालयमा कार्यरत शिक्षकको विवरण IEMIS को कुन मेनुमा राखिन्छ, र शिक्षकको तलब-भत्ता निकासाको आधार कुन प्रणाली मानिएको छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षकको कुन-कुन नम्बर IEMIS मा अनिवार्य अद्यावधिक गर्नुपर्दछ, र निवृत्तिभरण (Pension) वा अवकाश प्राप्त शिक्षकलाई IEMIS मा के गरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'शिक्षकको कुन-कुन नम्बर IEMIS मा अनिवार्य अद्यावधिक गर्नुपर्दछ, र निवृत्तिभरण (Pension) वा अवकाश प्राप्त शिक्षकलाई IEMIS मा के गरिन्छ?', E'नागरिकता नम्बर मात्र — खाता स्थायी मेटाइन्छ', E'शिक्षक सङ्केत नम्बर (Teacher ID) र प्यान नम्बर — Retired/Resigned जनाई प्रोफाइल निष्क्रिय गरिन्छ', E'बैंक खाता नम्बर मात्र — केही परिवर्तन गरिँदैन', E'पासपोर्ट नम्बर — नयाँ खाता खोलिन्छ', E'B', E'**शिक्षकको Teacher ID र PAN नम्बर IEMIS मा अनिवार्य अद्यावधिक गर्नुपर्दछ। अवकाश प्राप्त शिक्षकलाई Retired वा Resigned जनाई प्रोफाइल निष्क्रिय गरिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षकको कुन-कुन नम्बर IEMIS मा अनिवार्य अद्यावधिक गर्नुपर्दछ, र निवृत्तिभरण (Pension) वा अवकाश प्राप्त शिक्षकलाई IEMIS मा के गरिन्छ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'राहत, करार र अस्थायी शिक्षकको विवरण पनि IEMIS मा राख्नुपर्छ कि पर्दैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'राहत, करार र अस्थायी शिक्षकको विवरण पनि IEMIS मा राख्नुपर्छ कि पर्दैन?', E'पर्दैन — केवल स्थायी शिक्षकको मात्र राख्नुपर्छ', E'पर्छ — तर करार शिक्षकको मात्र', E'पर्छ — सबै प्रकारका शिक्षक र कर्मचारीको विवरण राख्नुपर्छ', E'पर्दैन — यो अनिवार्य होइन', E'C', E'**राहत, करार र अस्थायी शिक्षक सबैको विवरण IEMIS मा राख्नु अनिवार्य छ।**\\nनोट: ECD (प्रारम्भिक बालविकास) सहजकर्ताको विवरण पनि Staff मेनुमै राखिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:राहत, करार र अस्थायी शिक्षकको विवरण पनि IEMIS मा राख्नुपर्छ कि पर्दैन?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यालयको जग्गा, भवन, कक्षाकोठा, शौचालय आदिको विवरण IEMIS को कुन खण्डमा भरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'विद्यालयको जग्गा, भवन, कक्षाकोठा, शौचालय आदिको विवरण IEMIS को कुन खण्डमा भरिन्छ?', E'Financial मोड्युलमा', E'Textbook मोड्युलमा', E'Staff मोड्युलमा', E'Physical (भौतिक पूर्वाधार) मोड्युलमा', E'D', E'**विद्यालयको जग्गा, भवन, कक्षाकोठा, शौचालय आदिको विवरण Physical (भौतिक पूर्वाधार) मोड्युलमा भरिन्छ।**\\nनोट: खानेपानी र कम्प्युटरको विवरण पनि यही Physical Information मा इन्ट्री गरिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यालयको जग्गा, भवन, कक्षाकोठा, शौचालय आदिको विवरण IEMIS को कुन खण्डमा भरिन्छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कक्षा ८ को आधारभूत तहको परीक्षा व्यवस्थापनका लागि IEMIS को कुन मेनु प्रयोग गरिन्छ, र स्थानीय तहले प्रवेशपत्र (Admit Card) कहाँबाट जेनेरेट गर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'कक्षा ८ को आधारभूत तहको परीक्षा व्यवस्थापनका लागि IEMIS को कुन मेनु प्रयोग गरिन्छ, र स्थानीय तहले प्रवेशपत्र (Admit Card) कहाँबाट जेनेरेट गर्छ?', E'BEE (Basic Education Examination) मोड्युल — यही IEMIS प्रणालीबाटै', E'Textbook मोड्युल — कागजी रूपमा छुट्टै', E'Financial मोड्युल — शिक्षा शाखाबाट म्यानुअल', E'Staff मोड्युल — जिल्ला शिक्षा समितिबाट', E'A', E'**कक्षा ८ को आधारभूत तहको परीक्षा व्यवस्थापनका लागि BEE (Basic Education Examination) मोड्युल प्रयोग गरिन्छ, र प्रवेशपत्र पनि IEMIS प्रणालीबाटै जेनेरेट हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कक्षा ८ को आधारभूत तहको परीक्षा व्यवस्थापनका लागि IEMIS को कुन मेनु प्रयोग गरिन्छ, र स्थानीय तहले प्रवेशपत्र (Admit Card) कहाँबाट जेनेरेट गर्छ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यालयले लिने त्रैमासिक र वार्षिक परीक्षाको अंक कहाँ भर्न सकिन्छ, र लेटर ग्रेडिङ निर्देशिका अनुसार विद्यार्थीको ग्रेडसिट IEMIS बाट निकाल्न सकिन्छ कि सकिँदैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'विद्यालयले लिने त्रैमासिक र वार्षिक परीक्षाको अंक कहाँ भर्न सकिन्छ, र लेटर ग्रेडिङ निर्देशिका अनुसार विद्यार्थीको ग्रेडसिट IEMIS बाट निकाल्न सकिन्छ कि सकिँदैन?', E'Staff मोड्युलमा — सकिँदैन', E'Mark Ledger (अंकपुस्तिका) मोड्युलमा — सकिन्छ, अटोमेटिक तयार हुन्छ', E'Financial मोड्युलमा — म्यानुअल गणना गर्नुपर्छ', E'Physical मोड्युलमा — केवल कागजी रूपमा मात्र', E'B', E'**त्रैमासिक र वार्षिक परीक्षाको अंक Mark Ledger (अंकपुस्तिका) मोड्युलमा भरिन्छ। IEMIS ले अटोमेटिक ग्रेडसिट तयार गर्दछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यालयले लिने त्रैमासिक र वार्षिक परीक्षाको अंक कहाँ भर्न सकिन्छ, र लेटर ग्रेडिङ निर्देशिका अनुसार विद्यार्थीको ग्रेडसिट IEMIS बाट निकाल्न सकिन्छ कि सकिँदैन?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: IEMIS: तथ्याङ्क सूचकांक, प्राविधिक पक्ष र सरोकारवाला भूमिका (आधारभूत तह) (12 Q)
  v_set_id := extensions.uuid_generate_v5('fe40aa9d-a4d8-44b2-b88a-44545809085d'::uuid, E'IEMIS: तथ्याङ्क सूचकांक, प्राविधिक पक्ष र सरोकारवाला भूमिका (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'f2406808-49ed-4b71-b2e7-cb2e4d8967a5'::uuid, 'fe40aa9d-a4d8-44b2-b88a-44545809085d'::uuid, E'IEMIS: तथ्याङ्क सूचकांक, प्राविधिक पक्ष र सरोकारवाला भूमिका (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'fe40aa9d-a4d8-44b2-b88a-44545809085d'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'IEMIS को डाटाबाट निकालिने NER र GER को पूरा रूप के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'IEMIS को डाटाबाट निकालिने NER र GER को पूरा रूप के हो?', E'NER=Net Enrolment Rate; GER=Gross Enrolment Rate', E'NER=National Enrolment Rate; GER=General Enrolment Rate', E'NER=Net Education Rate; GER=Gross Education Rate', E'NER=New Enrolment Rate; GER=Grade Enrolment Rate', E'A', E'**NER को पूरा रूप Net Enrolment Rate (खुद भर्ना दर) हो, र GER को Gross Enrolment Rate (कुल भर्ना दर) हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:IEMIS को डाटाबाट निकालिने NER र GER को पूरा रूप के हो?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'GPI को पूरा रूप के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'GPI को पूरा रूप के हो?', E'General Population Index', E'Gender Parity Index', E'Gross Progress Indicator', E'Grade Performance Index', E'B', E'**GPI को पूरा रूप Gender Parity Index (लैङ्गिक समता सूचकांक) हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:GPI को पूरा रूप के हो?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुन उमेर समूहका बालबालिकालाई आधारभूत तह (कक्षा १-५) को खुद भर्ना दर (NER) मा गणना गरिन्छ, र विद्यालय छाड्ने दर (Dropout Rate) निकाल्न कुन रिपोर्टको तथ्याङ्क प्रयोग हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'कुन उमेर समूहका बालबालिकालाई आधारभूत तह (कक्षा १-५) को खुद भर्ना दर (NER) मा गणना गरिन्छ, र विद्यालय छाड्ने दर (Dropout Rate) निकाल्न कुन रिपोर्टको तथ्याङ्क प्रयोग हुन्छ?', E'६ देखि १० वर्षसम्म — Flash I', E'४ देखि ८ वर्षसम्म — PMT रिपोर्ट', E'५ देखि ९ वर्षसम्म — Flash II', E'५ देखि ९ वर्षसम्म — Mark Ledger', E'C', E'**आधारभूत तहको NER गणनामा ५ देखि ९ वर्षसम्मका बालबालिका पर्दछन्। Dropout Rate निकाल्न Flash II को तथ्याङ्क प्रयोग हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुन उमेर समूहका बालबालिकालाई आधारभूत तह (कक्षा १-५) को खुद भर्ना दर (NER) मा गणना गरिन्छ, र विद्यालय छाड्ने दर (Dropout Rate) निकाल्न कुन रिपोर्टको तथ्याङ्क प्रयोग हुन्छ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'ASIP र PCF को पूरा रूप के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'ASIP र PCF को पूरा रूप के हो?', E'ASIP=Annual School Improvement Plan; PCF=Public Capital Fund', E'ASIP=Academic Strategic Investment Plan; PCF=Per Class Funding', E'ASIP=Annual Sector Investment Programme; PCF=Personal Capacity Fund', E'ASIP=Annual Strategic Implementation Plan; PCF=Per Capita Funding', E'D', E'**ASIP को पूरा रूप Annual Strategic Implementation Plan हो, र PCF को Per Capita Funding (प्रति विद्यार्थी लगानी) हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:ASIP र PCF को पूरा रूप के हो?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यालय अनुदान (School Grants) वितरणको मुख्य आधार कुन डाटालाई मानिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'विद्यालय अनुदान (School Grants) वितरणको मुख्य आधार कुन डाटालाई मानिन्छ?', E'IEMIS मा इन्ट्री भएको विद्यार्थी र शिक्षक सङ्ख्या', E'जिल्ला शिक्षा समितिको सिफारिस मात्र', E'विद्यालयको भवन क्षेत्रफल', E'अघिल्लो वर्षको जरिवाना रेकर्ड', E'A', E'**विद्यालय अनुदान वितरणको मुख्य आधार IEMIS मा इन्ट्री भएको विद्यार्थी र शिक्षक सङ्ख्यालाई मानिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यालय अनुदान (School Grants) वितरणको मुख्य आधार कुन डाटालाई मानिन्छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'IEMIS को अफलाइन एक्सेल टेम्प्लेट कुन भर्सनमा राम्रोसँग खुल्छ, र म्याक्रो (Macro) इनेबल गर्नुपर्छ कि पर्दैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'IEMIS को अफलाइन एक्सेल टेम्प्लेट कुन भर्सनमा राम्रोसँग खुल्छ, र म्याक्रो (Macro) इनेबल गर्नुपर्छ कि पर्दैन?', E'MS Excel 2003 मा मात्र — पर्दैन', E'MS Excel 2007 र त्यसभन्दा माथिको भर्सनमा — पर्छ', E'कुनै पनि भर्सनमा — पर्दैन', E'Google Sheets मा मात्र — पर्छ', E'B', E'**IEMIS को अफलाइन एक्सेल टेम्प्लेट MS Excel 2007 र माथिको भर्सनमा राम्रोसँग खुल्छ। Macro Enable नगरेसम्म बटनहरूले काम गर्दैनन्, त्यसैले यो अनिवार्य छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:IEMIS को अफलाइन एक्सेल टेम्प्लेट कुन भर्सनमा राम्रोसँग खुल्छ, र म्याक्रो (Macro) इनेबल गर्नुपर्छ कि पर्दैन?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'एक्सेल टेम्प्लेटलाई पोर्टलमा अपलोड गर्नुभन्दा अघि कुन बटन थिच्नुपर्छ, र वेब पोर्टलमा कुन फर्म्याटको फाइल अपलोड गरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'एक्सेल टेम्प्लेटलाई पोर्टलमा अपलोड गर्नुभन्दा अघि कुन बटन थिच्नुपर्छ, र वेब पोर्टलमा कुन फर्म्याटको फाइल अपलोड गरिन्छ?', E'Save बटन — .docx फाइल', E'Print बटन — .pdf फाइल', E'Export बटन (जसले XML फाइल तयार गर्छ) — .xml वा .json फाइल', E'Submit बटन — .csv फाइल मात्र', E'C', E'**अपलोड गर्नुअघि Export बटन थिच्नुपर्छ, जसले XML फाइल तयार गर्छ। पोर्टलमा एक्सेलबाट जनरेट भएको .xml वा .json फाइल अपलोड गरिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:एक्सेल टेम्प्लेटलाई पोर्टलमा अपलोड गर्नुभन्दा अघि कुन बटन थिच्नुपर्छ, र वेब पोर्टलमा कुन फर्म्याटको फाइल अपलोड गरिन्छ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यार्थीको उमेर भर्दा IEMIS ले जन्म मिति कुन संवतमा माग्छ, र IEMIS मा रातो तारा चिन्ह (*) भएको बक्सको अर्थ के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'विद्यार्थीको उमेर भर्दा IEMIS ले जन्म मिति कुन संवतमा माग्छ, र IEMIS मा रातो तारा चिन्ह (*) भएको बक्सको अर्थ के हो?', E'ईश्वी संवत (A.D.) मा — विवरण ऐच्छिक छ', E'दुवै संवतमा — विवरण पछि भर्न सकिने', E'विक्रम संवत मा — विवरण मेटाइएको', E'विक्रम संवत (B.S.) मा — उक्त विवरण अनिवार्य भर्नुपर्छ (Mandatory Field)', E'D', E'**IEMIS ले जन्म मिति विक्रम संवत (B.S.) मा माग्छ (प्रणालीले आफै A.D. मा परिणत गर्न सक्छ)। रातो तारा चिन्ह (*) भएको बक्स अनिवार्य भर्नुपर्ने (Mandatory Field) हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यार्थीको उमेर भर्दा IEMIS ले जन्म मिति कुन संवतमा माग्छ, र IEMIS मा रातो तारा चिन्ह (*) भएको बक्सको अर्थ के हो?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'IEMIS मा डाटा प्रविष्टिको प्रथम र मुख्य जिम्मेवारी कसको हो, र विद्यालयले अपलोड गरेको डाटालाई स्वीकृत (Approve) गर्ने कार्य कसले गर्दछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'IEMIS मा डाटा प्रविष्टिको प्रथम र मुख्य जिम्मेवारी कसको हो, र विद्यालयले अपलोड गरेको डाटालाई स्वीकृत (Approve) गर्ने कार्य कसले गर्दछ?', E'विद्यालयका प्रधानाध्यापक र शिक्षकको — स्थानीय तहको शिक्षा शाखाले', E'CEHRD को — जिल्ला प्रशासन कार्यालयले', E'अभिभावकको — विद्यार्थीले आफैं', E'जिल्ला शिक्षा समितिको — मन्त्रालयले', E'A', E'**IEMIS मा डाटा प्रविष्टिको प्रथम जिम्मेवारी विद्यालयका प्रधानाध्यापक र शिक्षकको हो। स्वीकृत गर्ने कार्य स्थानीय तहको शिक्षा शाखाले गर्दछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:IEMIS मा डाटा प्रविष्टिको प्रथम र मुख्य जिम्मेवारी कसको हो, र विद्यालयले अपलोड गरेको डाटालाई स्वीकृत (Approve) गर्ने कार्य कसले गर्दछ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'प्रदेश स्तरमा IEMIS को डाटा हेर्ने र विश्लेषण गर्ने निकाय कुन हो, र राष्ट्रिय स्तरमा शैक्षिक तथ्याङ्कको प्रकाशन (Consolidated Report) कसले गर्दछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'प्रदेश स्तरमा IEMIS को डाटा हेर्ने र विश्लेषण गर्ने निकाय कुन हो, र राष्ट्रिय स्तरमा शैक्षिक तथ्याङ्कको प्रकाशन (Consolidated Report) कसले गर्दछ?', E'जिल्ला शिक्षा समिति — शिक्षक सेवा आयोग', E'शिक्षा विकास निर्देशनालय (EDD) — शिक्षा तथा मानव स्रोत विकास केन्द्र (CEHRD)', E'स्थानीय तह — शिक्षा मन्त्रालय मात्र', E'राष्ट्रिय सूचना प्रविधि केन्द्र — राष्ट्रिय योजना आयोग', E'B', E'**प्रदेश स्तरमा शिक्षा विकास निर्देशनालय (EDD) ले IEMIS डाटा विश्लेषण गर्दछ। राष्ट्रिय स्तरमा CEHRD ले शैक्षिक तथ्याङ्क प्रकाशन गर्दछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:प्रदेश स्तरमा IEMIS को डाटा हेर्ने र विश्लेषण गर्ने निकाय कुन हो, र राष्ट्रिय स्तरमा शैक्षिक तथ्याङ्कको प्रकाशन (Consolidated Report) कसले गर्दछ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'IEMIS प्रणालीलाई कस्तो सफ्टवेयरको रूपमा लिइन्छ, र नेपालमा शैक्षिक तथ्याङ्क व्यवस्थापनलाई संस्थागत गर्न कुन विकास साझेदारहरूले सहयोग गर्दै आएका छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'IEMIS प्रणालीलाई कस्तो सफ्टवेयरको रूपमा लिइन्छ, र नेपालमा शैक्षिक तथ्याङ्क व्यवस्थापनलाई संस्थागत गर्न कुन विकास साझेदारहरूले सहयोग गर्दै आएका छन्?', E'ERP प्रणाली — WHO र UNDP', E'CRM प्रणाली — Asian Development Bank मात्र', E'MIS (Management Information System) — युनिसेफ र विश्व बैंक', E'MIS प्रणाली — केवल नेपाल सरकार आफैं', E'C', E'**IEMIS लाई MIS (Management Information System) को उदाहरणको रूपमा लिइन्छ। यसलाई संस्थागत गर्न युनिसेफ (UNICEF) र विश्व बैंकले सहयोग गर्दै आएका छन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:IEMIS प्रणालीलाई कस्तो सफ्टवेयरको रूपमा लिइन्छ, र नेपालमा शैक्षिक तथ्याङ्क व्यवस्थापनलाई संस्थागत गर्न कुन विकास साझेदारहरूले सहयोग गर्दै आएका छन्?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'IEMIS एप (Mobile App) हाल कुन अपरेटिङ सिस्टमका लागि उपलब्ध छ, र IEMIS बाट विद्यार्थीको परिचयपत्र (ID Card) प्रिन्ट गर्न सकिन्छ कि सकिँदैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'IEMIS एप (Mobile App) हाल कुन अपरेटिङ सिस्टमका लागि उपलब्ध छ, र IEMIS बाट विद्यार्थीको परिचयपत्र (ID Card) प्रिन्ट गर्न सकिन्छ कि सकिँदैन?', E'iOS का लागि मात्र — सकिँदैन', E'एन्ड्रोइड र iOS दुवैका लागि — सकिँदैन', E'विन्डोज मोबाइलका लागि — सकिन्छ', E'एन्ड्रोइड (Android) का लागि — सकिन्छ', E'D', E'**IEMIS एप हाल एन्ड्रोइड (Android) का लागि मात्र उपलब्ध छ। IEMIS बाट विद्यार्थीको परिचयपत्र प्रिन्ट गर्न सकिन्छ, यसका लागि ID Card जेनेरेट गर्ने सुविधा छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:IEMIS एप (Mobile App) हाल कुन अपरेटिङ सिस्टमका लागि उपलब्ध छ, र IEMIS बाट विद्यार्थीको परिचयपत्र (ID Card) प्रिन्ट गर्न सकिन्छ कि सकिँदैन?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  RAISE NOTICE 'ग-२ IEMIS upsert complete: 3 sets, 32 questions.';
END $$;
