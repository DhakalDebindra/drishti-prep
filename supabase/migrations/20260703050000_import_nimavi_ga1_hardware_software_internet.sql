-- Idempotent UPSERT import: निमावि प्रथम पत्र — ग-१ कम्प्युटर, subtopics १.२-१.४ (Level I topic-wise sets)
-- Override same-identity sets/questions; never deletes. Generated 2026-07-05T06:16:25.426Z.
DO $$
DECLARE
  v_module_id uuid := '6695669a-f40e-421a-a4ec-b09bbeaf56c4'::uuid;
  v_set_id uuid;
  v_q_id uuid;
BEGIN

  -- Set: हार्डवेयर: इनपुट, आउटपुट, CPU र मेमोरी (आधारभूत तह) (15 Q)
  v_set_id := extensions.uuid_generate_v5('72898f78-15bf-4f10-85ae-9bfd9f1f0e6f'::uuid, E'हार्डवेयर: इनपुट, आउटपुट, CPU र मेमोरी (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '3550276d-035c-4369-8511-78c34093d306'::uuid, '72898f78-15bf-4f10-85ae-9bfd9f1f0e6f'::uuid, E'हार्डवेयर: इनपुट, आउटपुट, CPU र मेमोरी (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '72898f78-15bf-4f10-85ae-9bfd9f1f0e6f'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कम्प्युटरलाई डाटा वा निर्देशन दिन प्रयोग गरिने उपकरणलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'कम्प्युटरलाई डाटा वा निर्देशन दिन प्रयोग गरिने उपकरणलाई के भनिन्छ?', E'इनपुट डिभाइस', E'आउटपुट डिभाइस', E'स्टोरेज डिभाइस', E'प्रोसेसिङ डिभाइस', E'A', E'**कम्प्युटरलाई डाटा वा निर्देशन दिन प्रयोग गरिने उपकरणलाई इनपुट डिभाइस भनिन्छ।**\\nनोट: कि-बोर्ड, माउस, स्क्यानर, ट्र्याक बल, ज्वाइस्टिक, लाइट पेन र वेब क्यामेरा इनपुट डिभाइसका उदाहरण हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कम्प्युटरलाई डाटा वा निर्देशन दिन प्रयोग गरिने उपकरणलाई के भनिन्छ?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'OCR को पूरा रूप के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'OCR को पूरा रूप के हो?', E'Optical Colour Reader', E'Optical Character Reader/Recognition', E'Output Character Recognition', E'Online Character Recognition', E'B', E'**OCR को पूरा रूप Optical Character Reader/Recognition हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:OCR को पूरा रूप के हो?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'बैंकको चेक रिड गर्न प्रयोग गरिने प्रविधि MICR को पूरा रूप के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'बैंकको चेक रिड गर्न प्रयोग गरिने प्रविधि MICR को पूरा रूप के हो?', E'Machine Interpreted Character Reader', E'Magnetic Information Code Reader', E'Magnetic Ink Character Recognition', E'Multiple Ink Character Recorder', E'C', E'**MICR को पूरा रूप Magnetic Ink Character Recognition हो, जुन बैंकको चेक रिड गर्न प्रयोग गरिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:बैंकको चेक रिड गर्न प्रयोग गरिने प्रविधि MICR को पूरा रूप के हो?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'VDU (Visual Display Unit) भनेर कुन उपकरणलाई चिनिन्छ, र यसले दिने आउटपुटलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'VDU (Visual Display Unit) भनेर कुन उपकरणलाई चिनिन्छ, र यसले दिने आउटपुटलाई के भनिन्छ?', E'प्रिन्टर — हार्ड कपी', E'मनिटर — हार्ड कपी', E'स्पिकर — सफ्ट कपी', E'मनिटर — सफ्ट कपी', E'D', E'**VDU भनेर मनिटरलाई चिनिन्छ, जसले दिने आउटपुटलाई सफ्ट कपी भनिन्छ।**\\nनोट: प्रिन्टरले दिने आउटपुटलाई हार्ड कपी भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:VDU (Visual Display Unit) भनेर कुन उपकरणलाई चिनिन्छ, र यसले दिने आउटपुटलाई के भनिन्छ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कम्प्युटरको मस्तिष्क (Brain of Computer) भनेर कसलाई चिनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'कम्प्युटरको मस्तिष्क (Brain of Computer) भनेर कसलाई चिनिन्छ?', E'CPU (Central Processing Unit)', E'RAM', E'ROM', E'मनिटर', E'A', E'**CPU (Central Processing Unit) लाई कम्प्युटरको मस्तिष्क भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कम्प्युटरको मस्तिष्क (Brain of Computer) भनेर कसलाई चिनिन्छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'CPU का मुख्य तीन भागहरू के-के हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'CPU का मुख्य तीन भागहरू के-के हुन्?', E'RAM, ROM र Cache', E'ALU, CU र Memory/Registers', E'Input, Output र Storage', E'BIOS, CMOS र Clock', E'B', E'**CPU का मुख्य तीन भाग ALU (Arithmetic Logic Unit), CU (Control Unit) र Memory/Registers हुन्।**\\nनोट: ALU ले गणितीय र तार्किक कार्य गर्छ; CU ले कम्प्युटरका सम्पूर्ण गतिविधि नियन्त्रण र समन्वय गर्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:CPU का मुख्य तीन भागहरू के-के हुन्?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कम्प्युटरको मुख्य मेमोरी (Primary Memory) कुन-कुन हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'कम्प्युटरको मुख्य मेमोरी (Primary Memory) कुन-कुन हुन्?', E'Hard Disk र SSD', E'Cache र Register मात्र', E'RAM र ROM', E'Pen Drive र CD', E'C', E'**कम्प्युटरको मुख्य मेमोरी RAM र ROM हुन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कम्प्युटरको मुख्य मेमोरी (Primary Memory) कुन-कुन हुन्?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुन मेमोरीलाई Volatile Memory (विद्युत आपूर्ति बन्द हुँदा डाटा नष्ट हुने) भनिन्छ, र कुनलाई Non-Volatile Memory भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'कुन मेमोरीलाई Volatile Memory (विद्युत आपूर्ति बन्द हुँदा डाटा नष्ट हुने) भनिन्छ, र कुनलाई Non-Volatile Memory भनिन्छ?', E'ROM = Volatile, RAM = Non-Volatile', E'दुवै Volatile', E'दुवै Non-Volatile', E'RAM = Volatile, ROM = Non-Volatile', E'D', E'**RAM लाई Volatile Memory र ROM लाई Non-Volatile Memory भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुन मेमोरीलाई Volatile Memory (विद्युत आपूर्ति बन्द हुँदा डाटा नष्ट हुने) भनिन्छ, र कुनलाई Non-Volatile Memory भनिन्छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कम्प्युटरमा डाटालाई स्थायी रूपमा भण्डारण गर्न कुन मेमोरीको प्रयोग गरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'कम्प्युटरमा डाटालाई स्थायी रूपमा भण्डारण गर्न कुन मेमोरीको प्रयोग गरिन्छ?', E'सेकेन्डरी मेमोरी (Hard Disk, SSD, Pen Drive)', E'RAM', E'Cache Memory', E'Register', E'A', E'**डाटालाई स्थायी रूपमा भण्डारण गर्न सेकेन्डरी मेमोरी (Hard Disk, SSD, Pen Drive जस्ता) को प्रयोग गरिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कम्प्युटरमा डाटालाई स्थायी रूपमा भण्डारण गर्न कुन मेमोरीको प्रयोग गरिन्छ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'१ Byte मा कति Bit हुन्छ, र १०२४ Bytes बराबर कति हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'१ Byte मा कति Bit हुन्छ, र १०२४ Bytes बराबर कति हुन्छ?', E'१६ Bits; १ Megabyte', E'८ Bits; १ Kilobyte', E'८ Bits; १ Megabyte', E'४ Bits; १ Kilobyte', E'B', E'**१ Byte मा ८ Bits हुन्छ, र १०२४ Bytes बराबर १ Kilobyte (KB) हुन्छ।**\\nनोट: यसैगरी १०२४ KB = १ MB, १०२४ MB = १ GB।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:१ Byte मा कति Bit हुन्छ, र १०२४ Bytes बराबर कति हुन्छ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कम्प्युटरको सबैभन्दा छिटो काम गर्ने मेमोरी कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'कम्प्युटरको सबैभन्दा छिटो काम गर्ने मेमोरी कुन हो?', E'RAM', E'ROM', E'क्यास मेमोरी (Cache Memory) वा रजिस्टर', E'Hard Disk', E'C', E'**क्यास मेमोरी (Cache Memory) वा रजिस्टर कम्प्युटरको सबैभन्दा छिटो काम गर्ने मेमोरी हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कम्प्युटरको सबैभन्दा छिटो काम गर्ने मेमोरी कुन हो?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'हार्ड डिस्क र CD/DVD क्रमशः कुन-कुन प्रकारको भण्डारण (Storage) हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'हार्ड डिस्क र CD/DVD क्रमशः कुन-कुन प्रकारको भण्डारण (Storage) हुन्?', E'हार्ड डिस्क = अप्टिकल स्टोरेज; CD/DVD = म्याग्नेटिक स्टोरेज', E'दुवै म्याग्नेटिक स्टोरेज', E'दुवै फ्ल्यास स्टोरेज', E'हार्ड डिस्क = म्याग्नेटिक स्टोरेज; CD/DVD = अप्टिकल स्टोरेज', E'D', E'**हार्ड डिस्क म्याग्नेटिक स्टोरेज हो, जबकि CD/DVD अप्टिकल स्टोरेज हुन्।**\\nनोट: एउटा CD को भण्डारण क्षमता सामान्यतया ७०० MB हुन्छ, DVD को ४.७ देखि ८.५ GB सम्म हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:हार्ड डिस्क र CD/DVD क्रमशः कुन-कुन प्रकारको भण्डारण (Storage) हुन्?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पेन ड्राइभ (Pen Drive) ले कुन प्रविधिको प्रयोग गर्दछ, र SSD को पूरा रूप के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'पेन ड्राइभ (Pen Drive) ले कुन प्रविधिको प्रयोग गर्दछ, र SSD को पूरा रूप के हो?', E'फ्ल्यास मेमोरी; Solid State Drive', E'म्याग्नेटिक मेमोरी; Serial State Drive', E'अप्टिकल मेमोरी; Solid Storage Device', E'क्यास मेमोरी; Static State Drive', E'A', E'**पेन ड्राइभले फ्ल्यास मेमोरीको प्रविधि प्रयोग गर्दछ। SSD को पूरा रूप Solid State Drive हो।**\\nनोट: SSD हार्ड डिस्कभन्दा छिटो र भरपर्दो मानिन्छ किनभने यसमा घुम्ने पुर्जा हुँदैन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पेन ड्राइभ (Pen Drive) ले कुन प्रविधिको प्रयोग गर्दछ, र SSD को पूरा रूप के हो?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'BIOS को पूरा रूप के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'BIOS को पूरा रूप के हो?', E'Binary Input Output System', E'Basic Input Output System', E'Basic Internal Operating System', E'Basic Input Operating Software', E'B', E'**BIOS को पूरा रूप Basic Input Output System हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:BIOS को पूरा रूप के हो?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कम्प्युटरमा समय र मिति (Time and Date) कहाँ सुरक्षित हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'कम्प्युटरमा समय र मिति (Time and Date) कहाँ सुरक्षित हुन्छ?', E'RAM मा', E'हार्ड डिस्कमा मात्र', E'CMOS ब्याट्री र सिस्टम घडी (System Clock) मा', E'CPU को Register मा', E'C', E'**कम्प्युटरमा समय र मिति CMOS ब्याट्री र सिस्टम घडीमा सुरक्षित हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कम्प्युटरमा समय र मिति (Time and Date) कहाँ सुरक्षित हुन्छ?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: सफ्टवेयर, अपरेटिङ सिस्टम र अफिस प्याकेज (आधारभूत तह) (18 Q)
  v_set_id := extensions.uuid_generate_v5('bf667584-5813-497d-9225-d7b80435794a'::uuid, E'सफ्टवेयर, अपरेटिङ सिस्टम र अफिस प्याकेज (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '3550276d-035c-4369-8511-78c34093d306'::uuid, 'bf667584-5813-497d-9225-d7b80435794a'::uuid, E'सफ्टवेयर, अपरेटिङ सिस्टम र अफिस प्याकेज (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'bf667584-5813-497d-9225-d7b80435794a'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कम्प्युटरलाई के काम कसरी गर्ने भनेर दिइएको निर्देशनहरूको समूहलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'कम्प्युटरलाई के काम कसरी गर्ने भनेर दिइएको निर्देशनहरूको समूहलाई के भनिन्छ?', E'सफ्टवेयर वा प्रोग्राम', E'हार्डवेयर', E'फर्मवेयर', E'डाटाबेस', E'A', E'**कम्प्युटरलाई काम गर्ने तरिका बताउने निर्देशनहरूको समूहलाई सफ्टवेयर वा प्रोग्राम भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कम्प्युटरलाई के काम कसरी गर्ने भनेर दिइएको निर्देशनहरूको समूहलाई के भनिन्छ?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सफ्टवेयरलाई मुख्यतया कति भागमा बाँड्न सकिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'सफ्टवेयरलाई मुख्यतया कति भागमा बाँड्न सकिन्छ?', E'३ भागमा', E'२ भागमा (System Software र Application Software)', E'४ भागमा', E'५ भागमा', E'B', E'**सफ्टवेयरलाई System Software र Application Software गरी २ भागमा बाँड्न सकिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सफ्टवेयरलाई मुख्यतया कति भागमा बाँड्न सकिन्छ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विन्डोज (Windows), लिनक्स (Linux), म्याक (Mac OS) के का उदाहरण हुन्, र यी कुन प्रकारको सफ्टवेयर हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'विन्डोज (Windows), लिनक्स (Linux), म्याक (Mac OS) के का उदाहरण हुन्, र यी कुन प्रकारको सफ्टवेयर हुन्?', E'एप्लिकेशन सफ्टवेयर', E'युटिलिटी सफ्टवेयर', E'अपरेटिङ सिस्टम (OS) — System Software', E'फर्मवेयर', E'C', E'**Windows, Linux, Mac OS अपरेटिङ सिस्टम (OS) का उदाहरण हुन्, जुन System Software अन्तर्गत पर्दछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विन्डोज (Windows), लिनक्स (Linux), म्याक (Mac OS) के का उदाहरण हुन्, र यी कुन प्रकारको सफ्टवेयर हुन्?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'MS Word, Excel, PowerPoint कुन सफ्टवेयर अन्तर्गत पर्दछन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'MS Word, Excel, PowerPoint कुन सफ्टवेयर अन्तर्गत पर्दछन्?', E'सिस्टम सफ्टवेयर', E'फर्मवेयर', E'युटिलिटी सफ्टवेयर', E'एप्लिकेशन सफ्टवेयर (Application Software)', E'D', E'**MS Word, Excel, PowerPoint प्रयोगकर्ताको विशेष कार्य सम्पादन गर्न बनाइएको एप्लिकेशन सफ्टवेयर अन्तर्गत पर्दछन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:MS Word, Excel, PowerPoint कुन सफ्टवेयर अन्तर्गत पर्दछन्?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'GUI र CLI/CUI को पूरा रूप के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'GUI र CLI/CUI को पूरा रूप के हो?', E'GUI=Graphical User Interface; CLI/CUI=Command/Character Line Interface', E'GUI=General User Interface; CLI=Common Line Interface', E'GUI=Graphic Utility Interface; CUI=Character Utility Interface', E'GUI=Global User Icon; CLI=Command Line Icon', E'A', E'**GUI को पूरा रूप Graphical User Interface हो, र CLI/CUI को Command Line Interface / Character User Interface हो।**\\nनोट: MS DOS CLI/CUI को उदाहरण हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:GUI र CLI/CUI को पूरा रूप के हो?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'खुला स्रोत (Open Source) भएको अपरेटिङ सिस्टम कुन हो, र मोबाइलमा प्रयोग हुने सबैभन्दा प्रख्यात OS कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'खुला स्रोत (Open Source) भएको अपरेटिङ सिस्टम कुन हो, र मोबाइलमा प्रयोग हुने सबैभन्दा प्रख्यात OS कुन हो?', E'विन्डोज; iOS', E'लिनक्स; एन्ड्रोइड', E'म्याक OS; एन्ड्रोइड', E'लिनक्स; iOS', E'B', E'**लिनक्स खुला स्रोत (Open Source) अपरेटिङ सिस्टम हो। मोबाइलमा सबैभन्दा प्रख्यात OS एन्ड्रोइड हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:खुला स्रोत (Open Source) भएको अपरेटिङ सिस्टम कुन हो, र मोबाइलमा प्रयोग हुने सबैभन्दा प्रख्यात OS कुन हो?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सफ्टवेयरमा आउने त्रुटि (Error) लाई प्राविधिक भाषामा के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'सफ्टवेयरमा आउने त्रुटि (Error) लाई प्राविधिक भाषामा के भनिन्छ?', E'क्र्यास (Crash)', E'भाइरस (Virus)', E'बग (Bug)', E'ग्लिच (Glitch)', E'C', E'**सफ्टवेयरमा आउने त्रुटिलाई प्राविधिक भाषामा बग (Bug) भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सफ्टवेयरमा आउने त्रुटि (Error) लाई प्राविधिक भाषामा के भनिन्छ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'MS Word कुन प्रकारको प्रोग्राम हो, र यसमा बनाइएको फाइलको Extension के हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'MS Word कुन प्रकारको प्रोग्राम हो, र यसमा बनाइएको फाइलको Extension के हुन्छ?', E'स्प्रेडसिट सफ्टवेयर — .xlsx', E'प्रस्तुतीकरण सफ्टवेयर — .pptx', E'वर्ड प्रोसेसिङ सफ्टवेयर — .pdf', E'वर्ड प्रोसेसिङ सफ्टवेयर — .docx', E'D', E'**MS Word वर्ड प्रोसेसिङ सफ्टवेयर हो, जसमा बनाइएको फाइलको Extension .docx हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:MS Word कुन प्रकारको प्रोग्राम हो, र यसमा बनाइएको फाइलको Extension के हुन्छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'MS Word मा डकुमेन्ट सेभ (Save) गर्ने र प्रिन्ट प्रिभ्यू हेर्ने सर्टकट की क्रमशः के हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'MS Word मा डकुमेन्ट सेभ (Save) गर्ने र प्रिन्ट प्रिभ्यू हेर्ने सर्टकट की क्रमशः के हुन्?', E'Ctrl+S; Ctrl+P', E'Ctrl+N; Ctrl+O', E'Ctrl+V; Ctrl+C', E'Ctrl+Z; Ctrl+Y', E'A', E'**डकुमेन्ट सेभ गर्ने सर्टकट Ctrl+S हो, र प्रिन्ट (Print Preview समेत हेर्न) गर्ने सर्टकट Ctrl+P हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:MS Word मा डकुमेन्ट सेभ (Save) गर्ने र प्रिन्ट प्रिभ्यू हेर्ने सर्टकट की क्रमशः के हुन्?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'MS Word मा Text लाई बाक्लो (Bold), छड्के (Italic) र तल धर्का (Underline) बनाउने सर्टकट की क्रमशः के-के हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'MS Word मा Text लाई बाक्लो (Bold), छड्के (Italic) र तल धर्का (Underline) बनाउने सर्टकट की क्रमशः के-के हुन्?', E'Ctrl+D, Ctrl+E, Ctrl+F', E'Ctrl+B, Ctrl+I, Ctrl+U', E'Ctrl+X, Ctrl+Y, Ctrl+Z', E'Ctrl+1, Ctrl+2, Ctrl+3', E'B', E'**Bold=Ctrl+B, Italic=Ctrl+I, Underline=Ctrl+U हुन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:MS Word मा Text लाई बाक्लो (Bold), छड्के (Italic) र तल धर्का (Underline) बनाउने सर्टकट की क्रमशः के-के हुन्?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'MS Word मा स्पेलिङ र ग्रामर (Spelling & Grammar) चेक गर्न कुन Function Key प्रयोग गरिन्छ, र मेल मर्ज (Mail Merge) फिचरको प्रयोजन के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'MS Word मा स्पेलिङ र ग्रामर (Spelling & Grammar) चेक गर्न कुन Function Key प्रयोग गरिन्छ, र मेल मर्ज (Mail Merge) फिचरको प्रयोजन के हो?', E'F5 — प्रिन्ट प्रिभ्यू हेर्न', E'F2 — फन्ट बदल्न', E'F7 — एउटै डकुमेन्ट धेरै जनालाई एकैपटक पठाउन', E'F7 — फाइल सेभ गर्न', E'C', E'**स्पेलिङ/ग्रामर चेक गर्न F7 प्रयोग गरिन्छ। मेल मर्ज एउटै डकुमेन्ट धेरै जनालाई एकैपटक पठाउने फिचर हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:MS Word मा स्पेलिङ र ग्रामर (Spelling & Grammar) चेक गर्न कुन Function Key प्रयोग गरिन्छ, र मेल मर्ज (Mail Merge) फिचरको प्रयोजन के हो?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'MS Excel कुन प्रकारको प्रोग्राम हो, र यसको फाइल Extension के हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'MS Excel कुन प्रकारको प्रोग्राम हो, र यसको फाइल Extension के हुन्छ?', E'वर्ड प्रोसेसिङ सफ्टवेयर — .docx', E'प्रस्तुतीकरण सफ्टवेयर — .pptx', E'स्प्रेडसिट सफ्टवेयर — .csv मात्र', E'स्प्रेडसिट सफ्टवेयर — .xlsx', E'D', E'**MS Excel स्प्रेडसिट सफ्टवेयर हो, जसको फाइल Extension .xlsx हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:MS Excel कुन प्रकारको प्रोग्राम हो, र यसको फाइल Extension के हुन्छ?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'MS Excel मा Row (तेर्सो लाइन) र Column (ठाडो लाइन) लाई क्रमशः केले जनाइन्छ, र कुनै फर्मुला सुरु गर्नुभन्दा अगाडि कुन चिन्ह प्रयोग गरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'MS Excel मा Row (तेर्सो लाइन) र Column (ठाडो लाइन) लाई क्रमशः केले जनाइन्छ, र कुनै फर्मुला सुरु गर्नुभन्दा अगाडि कुन चिन्ह प्रयोग गरिन्छ?', E'नम्बर (1,2,3...); अक्षर (A,B,C...); बराबर (=) चिन्ह', E'अक्षर; नम्बर; प्रतिशत (%) चिन्ह', E'नम्बर; नम्बर; डलर ($) चिन्ह', E'अक्षर; अक्षर; बराबर (=) चिन्ह', E'A', E'**Row लाई नम्बरले (1,2,3...) र Column लाई अंग्रेजी अक्षरले (A,B,C...) जनाइन्छ। फर्मुला बराबर (=) चिन्हबाट सुरु हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:MS Excel मा Row (तेर्सो लाइन) र Column (ठाडो लाइन) लाई क्रमशः केले जनाइन्छ, र कुनै फर्मुला सुरु गर्नुभन्दा अगाडि कुन चिन्ह प्रयोग गरिन्छ?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'MS Excel मा जोड (Addition) र औसत (Average) निकाल्न प्रयोग गरिने फर्मुला क्रमशः के-के हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'MS Excel मा जोड (Addition) र औसत (Average) निकाल्न प्रयोग गरिने फर्मुला क्रमशः के-के हुन्?', E'=ADD() र =MEAN()', E'=SUM() र =AVERAGE()', E'=TOTAL() र =AVG()', E'=PLUS() र =AVERAGE()', E'B', E'**जोड निकाल्न =SUM() र औसत निकाल्न =AVERAGE() फर्मुला प्रयोग गरिन्छ।**\\nनोट: सबैभन्दा ठूलो/सानो अंक पत्ता लगाउन क्रमशः =MAX() र =MIN() फर्मुला प्रयोग गरिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:MS Excel मा जोड (Addition) र औसत (Average) निकाल्न प्रयोग गरिने फर्मुला क्रमशः के-के हुन्?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'MS PowerPoint कुन कार्यका लागि प्रयोग गरिन्छ, र यसको एउटा पेजलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'MS PowerPoint कुन कार्यका लागि प्रयोग गरिन्छ, र यसको एउटा पेजलाई के भनिन्छ?', E'स्प्रेडसिट बनाउन — सेल', E'डकुमेन्ट बनाउन — पेज', E'प्रस्तुतीकरण (Presentation) बनाउन — स्लाइड (Slide)', E'डाटाबेस बनाउन — रेकर्ड', E'C', E'**MS PowerPoint प्रस्तुतीकरण (Presentation) बनाउन प्रयोग गरिन्छ; यसको एउटा पेजलाई स्लाइड भनिन्छ।**\\nनोट: PowerPoint फाइलको Extension .pptx हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:MS PowerPoint कुन कार्यका लागि प्रयोग गरिन्छ, र यसको एउटा पेजलाई के भनिन्छ?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'PowerPoint मा स्लाइड शो (Slide Show) सुरु गर्न कुन Function Key को प्रयोग गरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'PowerPoint मा स्लाइड शो (Slide Show) सुरु गर्न कुन Function Key को प्रयोग गरिन्छ?', E'F1', E'F9', E'F11', E'F5', E'D', E'**PowerPoint मा स्लाइड शो सुरु गर्न F5 Function Key प्रयोग गरिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:PowerPoint मा स्लाइड शो (Slide Show) सुरु गर्न कुन Function Key को प्रयोग गरिन्छ?'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कम्प्युटरमा डिलिट (Delete) गरिएका फाइलहरू सामान्यतया कहाँ गएर बस्छन्, र रिसाइकल बिनमा नगई फाइल स्थायी रूपमा डिलिट गर्न कुन सर्टकट प्रयोग गरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'कम्प्युटरमा डिलिट (Delete) गरिएका फाइलहरू सामान्यतया कहाँ गएर बस्छन्, र रिसाइकल बिनमा नगई फाइल स्थायी रूपमा डिलिट गर्न कुन सर्टकट प्रयोग गरिन्छ?', E'रिसाइकल बिन — Shift+Delete', E'क्लिपबोर्ड — Ctrl+Delete', E'टेम्प फोल्डर — Alt+Delete', E'रिसाइकल बिन — Ctrl+Shift+Delete', E'A', E'**डिलिट गरिएका फाइलहरू रिसाइकल बिनमा जान्छन्। रिसाइकल बिनमा नगई स्थायी रूपमा डिलिट गर्न Shift+Delete प्रयोग गरिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कम्प्युटरमा डिलिट (Delete) गरिएका फाइलहरू सामान्यतया कहाँ गएर बस्छन्, र रिसाइकल बिनमा नगई फाइल स्थायी रूपमा डिलिट गर्न कुन सर्टकट प्रयोग गरिन्छ?'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''कट'' वा ''कपी'' गरिएको डाटा पेस्ट गर्नुभन्दा अगाडि अस्थायी रूपमा कहाँ गएर बसेको हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'''कट'' वा ''कपी'' गरिएको डाटा पेस्ट गर्नुभन्दा अगाडि अस्थायी रूपमा कहाँ गएर बसेको हुन्छ?', E'रिसाइकल बिनमा', E'क्लिपबोर्ड (Clipboard) मा', E'कम्प्युटरको हार्ड डिस्कमा स्थायी रूपमा', E'RAM बाहिर', E'B', E'**''कट'' वा ''कपी'' गरिएको डाटा पेस्ट गर्नुभन्दा अगाडि क्लिपबोर्डमा अस्थायी रूपमा बसेको हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''कट'' वा ''कपी'' गरिएको डाटा पेस्ट गर्नुभन्दा अगाडि अस्थायी रूपमा कहाँ गएर बसेको हुन्छ?'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: इन्टरनेट, नेटवर्क र सामान्य शब्दावली (आधारभूत तह) (14 Q)
  v_set_id := extensions.uuid_generate_v5('a0794319-c0ba-4d34-b09a-53426453e503'::uuid, E'इन्टरनेट, नेटवर्क र सामान्य शब्दावली (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '3550276d-035c-4369-8511-78c34093d306'::uuid, 'a0794319-c0ba-4d34-b09a-53426453e503'::uuid, E'इन्टरनेट, नेटवर्क र सामान्य शब्दावली (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'a0794319-c0ba-4d34-b09a-53426453e503'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'इन्टरनेटका पिता (Father of Internet) भनेर कसलाई चिनिन्छ, र WWW को आविष्कार कसले गरेका हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'इन्टरनेटका पिता (Father of Internet) भनेर कसलाई चिनिन्छ, र WWW को आविष्कार कसले गरेका हुन्?', E'भिन्ट सर्फ; टिम बर्नर्स ली', E'टिम बर्नर्स ली; भिन्ट सर्फ', E'रे टमलिन्सन; बिल गेट्स', E'स्टिभ जब्स; भिन्ट सर्फ', E'A', E'**इन्टरनेटका पिता भिन्ट सर्फ (Vint Cerf) हुन्, र WWW को आविष्कार टिम बर्नर्स ली (Tim Berners-Lee) ले गरेका हुन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:इन्टरनेटका पिता (Father of Internet) भनेर कसलाई चिनिन्छ, र WWW को आविष्कार कसले गरेका हुन्?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'इमेल (Email) को पूरा रूप के हो, र यसका जन्मदाता कसलाई मानिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'इमेल (Email) को पूरा रूप के हो, र यसका जन्मदाता कसलाई मानिन्छ?', E'Electronic Message; टिम बर्नर्स ली', E'Electronic Mail; रे टमलिन्सन', E'Express Mail; भिन्ट सर्फ', E'Electronic Mail; बिल गेट्स', E'B', E'**इमेलको पूरा रूप Electronic Mail हो, र यसका जन्मदाता रे टमलिन्सन (Ray Tomlinson) लाई मानिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:इमेल (Email) को पूरा रूप के हो, र यसका जन्मदाता कसलाई मानिन्छ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'URL र HTTP को पूरा रूप के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'URL र HTTP को पूरा रूप के हो?', E'URL=Universal Record Locator; HTTP=High Text Transfer Protocol', E'URL=Uniform Reference Link; HTTP=Hyper Transfer Text Protocol', E'URL=Uniform Resource Locator; HTTP=Hyper Text Transfer Protocol', E'URL=User Resource Link; HTTP=Home Text Transfer Protocol', E'C', E'**URL को पूरा रूप Uniform Resource Locator हो (वेबसाइटको ठेगाना), र HTTP को Hyper Text Transfer Protocol हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:URL र HTTP को पूरा रूप के हो?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वेबसाइटहरू हेर्न प्रयोग गरिने सफ्टवेयर (जस्तै Chrome, Firefox) लाई के भनिन्छ, र इन्टरनेटमा कुरा खोज्न प्रयोग गरिने साइटलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'वेबसाइटहरू हेर्न प्रयोग गरिने सफ्टवेयर (जस्तै Chrome, Firefox) लाई के भनिन्छ, र इन्टरनेटमा कुरा खोज्न प्रयोग गरिने साइटलाई के भनिन्छ?', E'सर्च इन्जिन; वेब ब्राउजर', E'वेब सर्भर; वेब क्लाइन्ट', E'वेब पोर्टल; वेब ब्राउजर', E'वेब ब्राउजर; सर्च इन्जिन', E'D', E'**Chrome/Firefox जस्ता वेबसाइट हेर्ने सफ्टवेयरलाई वेब ब्राउजर भनिन्छ। Google/Bing जस्ता खोज्ने साइटलाई सर्च इन्जिन भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वेबसाइटहरू हेर्न प्रयोग गरिने सफ्टवेयर (जस्तै Chrome, Firefox) लाई के भनिन्छ, र इन्टरनेटमा कुरा खोज्न प्रयोग गरिने साइटलाई के भनिन्छ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'LAN, MAN र WAN को पूरा रूप के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'LAN, MAN र WAN को पूरा रूप के हो?', E'Local/Metropolitan/Wide Area Network', E'Large/Main/Wide Area Network', E'Local/Main/Wireless Area Network', E'Limited/Metro/Web Area Network', E'A', E'**LAN=Local Area Network (सानो क्षेत्र, जस्तै अफिस), MAN=Metropolitan Area Network (एक शहरभर), WAN=Wide Area Network (विश्वव्यापी, जस्तै इन्टरनेट)।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:LAN, MAN र WAN को पूरा रूप के हो?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'Wi-Fi र IP Address को पूरा रूप के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'Wi-Fi र IP Address को पूरा रूप के हो?', E'Wireless Fibre; Internal Protocol Address', E'Wireless Fidelity; Internet Protocol Address', E'Wide Fidelity; Internet Provider Address', E'Wireless Frequency; Information Protocol Address', E'B', E'**Wi-Fi को पूरा रूप Wireless Fidelity हो, र IP Address को Internet Protocol Address हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:Wi-Fi र IP Address को पूरा रूप के हो?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेटवर्कमा मुख्य कम्प्युटर (जसले अन्य कम्प्युटरलाई सेवा प्रदान गर्दछ) लाई के भनिन्छ, र सेवा लिने कम्प्युटरलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'नेटवर्कमा मुख्य कम्प्युटर (जसले अन्य कम्प्युटरलाई सेवा प्रदान गर्दछ) लाई के भनिन्छ, र सेवा लिने कम्प्युटरलाई के भनिन्छ?', E'क्लाइन्ट; सर्भर', E'होस्ट; गेस्ट', E'सर्भर; क्लाइन्ट वा नोड', E'नोड; सर्भर', E'C', E'**सेवा प्रदान गर्ने मुख्य कम्प्युटरलाई सर्भर भनिन्छ, र सेवा लिने कम्प्युटरलाई क्लाइन्ट वा नोड भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेटवर्कमा मुख्य कम्प्युटर (जसले अन्य कम्प्युटरलाई सेवा प्रदान गर्दछ) लाई के भनिन्छ, र सेवा लिने कम्प्युटरलाई के भनिन्छ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेटवर्कमा कम्प्युटरहरूलाई जोड्ने भौतिक ढाँचालाई के भनिन्छ, र एउटै केबलमा सबै कम्प्युटर जोडिने ढाँचालाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'नेटवर्कमा कम्प्युटरहरूलाई जोड्ने भौतिक ढाँचालाई के भनिन्छ, र एउटै केबलमा सबै कम्प्युटर जोडिने ढाँचालाई के भनिन्छ?', E'नेटवर्क आर्किटेक्चर; स्टार टोपोलोजी', E'नेटवर्क प्रोटोकल; रिङ टोपोलोजी', E'नेटवर्क ढाँचा; मेश टोपोलोजी', E'नेटवर्क टोपोलोजी; बस टोपोलोजी', E'D', E'**कम्प्युटरहरू जोड्ने भौतिक ढाँचालाई नेटवर्क टोपोलोजी भनिन्छ। एउटै केबलमा सबै जोडिने ढाँचालाई बस टोपोलोजी भनिन्छ।**\\nनोट: हब/स्विच मार्फत जोडिने ढाँचा स्टार टोपोलोजी हो; गोलो घेरा बन्ने ढाँचा रिङ टोपोलोजी हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेटवर्कमा कम्प्युटरहरूलाई जोड्ने भौतिक ढाँचालाई के भनिन्छ, र एउटै केबलमा सबै कम्प्युटर जोडिने ढाँचालाई के भनिन्छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'मोडेम (Modem) को पूरा रूप के हो, र यसको मुख्य काम के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'मोडेम (Modem) को पूरा रूप के हो, र यसको मुख्य काम के हो?', E'Modulator-Demodulator — एनालग सिग्नललाई डिजिटलमा र डिजिटललाई एनालगमा परिणत गर्ने', E'Mode-Manager — नेटवर्क गति बढाउने', E'Module-Data — फाइल कम्प्रेस गर्ने', E'Modern-Device — भाइरस हटाउने', E'A', E'**मोडेमको पूरा रूप Modulator-Demodulator हो, जसले एनालग सिग्नललाई डिजिटलमा र डिजिटललाई एनालगमा परिणत गर्दछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:मोडेम (Modem) को पूरा रूप के हो, र यसको मुख्य काम के हो?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'ISP को पूरा रूप के हो, र नेपालमा यसका उदाहरणहरू के-के हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'ISP को पूरा रूप के हो, र नेपालमा यसका उदाहरणहरू के-के हुन्?', E'Internal Server Provider — Google, Microsoft', E'Internet Service Provider — NTC, Ncell, Vianet', E'Internet Software Program — Windows, Linux', E'Information Service Provider — Facebook, YouTube', E'B', E'**ISP को पूरा रूप Internet Service Provider हो; नेपालमा NTC, Ncell, Vianet यसका उदाहरण हुन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:ISP को पूरा रूप के हो, र नेपालमा यसका उदाहरणहरू के-के हुन्?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'इन्टरनेटमा फाइलहरू अपलोड र डाउनलोड गर्न कुन प्रोटोकलको प्रयोग हुन्छ, र HTML को पूरा रूप के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'इन्टरनेटमा फाइलहरू अपलोड र डाउनलोड गर्न कुन प्रोटोकलको प्रयोग हुन्छ, र HTML को पूरा रूप के हो?', E'HTTP; Hyper Transfer Markup Language', E'SMTP; Home Text Markup Language', E'FTP (File Transfer Protocol); Hyper Text Markup Language', E'FTP; High Transfer Machine Language', E'C', E'**फाइल अपलोड-डाउनलोड गर्न FTP (File Transfer Protocol) प्रयोग हुन्छ। HTML को पूरा रूप Hyper Text Markup Language हो (वेब पेज बनाउन प्रयोग हुन्छ)।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:इन्टरनेटमा फाइलहरू अपलोड र डाउनलोड गर्न कुन प्रोटोकलको प्रयोग हुन्छ, र HTML को पूरा रूप के हो?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'MAC Address कति बिटको हुन्छ, र IPv4 तथा IPv6 Address क्रमशः कति बिटका हुन्छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'MAC Address कति बिटको हुन्छ, र IPv4 तथा IPv6 Address क्रमशः कति बिटका हुन्छन्?', E'MAC=३२ बिट; IPv4=४८ बिट; IPv6=६४ बिट', E'MAC=६४ बिट; IPv4=१२८ बिट; IPv6=३२ बिट', E'MAC=१६ बिट; IPv4=६४ बिट; IPv6=२५६ बिट', E'MAC=४८ बिट; IPv4=३२ बिट; IPv6=१२८ बिट', E'D', E'**MAC Address ४८ बिटको, IPv4 Address ३२ बिटको र IPv6 Address १२८ बिटको हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:MAC Address कति बिटको हुन्छ, र IPv4 तथा IPv6 Address क्रमशः कति बिटका हुन्छन्?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'इमेल पठाउँदा प्रयोग हुने CC र BCC को पूरा रूप के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'इमेल पठाउँदा प्रयोग हुने CC र BCC को पूरा रूप के हो?', E'CC=Carbon Copy; BCC=Blind Carbon Copy', E'CC=Copy Content; BCC=Basic Copy Content', E'CC=Cloud Copy; BCC=Blind Cloud Copy', E'CC=Client Copy; BCC=Broadcast Copy', E'A', E'**CC को पूरा रूप Carbon Copy हो, र BCC को Blind Carbon Copy हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:इमेल पठाउँदा प्रयोग हुने CC र BCC को पूरा रूप के हो?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'ब्लुटुथ (Bluetooth) कस्तो प्रकारको नेटवर्कको उदाहरण हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'ब्लुटुथ (Bluetooth) कस्तो प्रकारको नेटवर्कको उदाहरण हो?', E'LAN (Local Area Network)', E'PAN (Personal Area Network)', E'WAN (Wide Area Network)', E'MAN (Metropolitan Area Network)', E'B', E'**ब्लुटुथ PAN (Personal Area Network) को उदाहरण हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:ब्लुटुथ (Bluetooth) कस्तो प्रकारको नेटवर्कको उदाहरण हो?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  RAISE NOTICE 'ग-१ subtopics १.२-१.४ upsert complete: 3 sets, 47 questions.';
END $$;
