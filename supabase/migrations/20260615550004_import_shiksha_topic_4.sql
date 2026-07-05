-- Migration for Topic 4 Ingestion
-- Generated deterministically. Idempotent.
DO $$
DECLARE
  v_module_id uuid := '6695669a-f40e-421a-a4ec-b09bbeaf56c4'::uuid;
  v_topic_id uuid := '33eadd7e-4fa5-4c91-a18a-850a6af93275'::uuid;
  v_set_id uuid;
  v_q_id uuid;
  v_jq_id uuid;
BEGIN
  RAISE NOTICE 'Starting migration for Topic 4...';

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "सिकाइका सिद्धान्तहरूको परिचय र विशेषता" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := '855b94fa-c0ef-58f1-807b-8903e8b6caac'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, 'e36b2b2e-9195-45ea-a5e2-6d4dec987e72'::uuid, E'सिकाइका सिद्धान्तहरूको परिचय र विशेषता', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'e36b2b2e-9195-45ea-a5e2-6d4dec987e72'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "सिकाइका सिद्धान्तहरू (विश्लेषणात्मक तह - ६०/४० ढाँचा)" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := '3dbbcf92-0b8f-5182-8408-9dfd4a25cd8a'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, 'e36b2b2e-9195-45ea-a5e2-6d4dec987e72'::uuid, E'सिकाइका सिद्धान्तहरू (विश्लेषणात्मक तह - ६०/४० ढाँचा)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'e36b2b2e-9195-45ea-a5e2-6d4dec987e72'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "शास्त्रीय सम्बन्धन सिकाइ सिद्धान्त (Pavlov)" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := '1c26f8ff-acd0-52a0-9242-34519afe3153'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, '0d569671-39de-4aff-a46c-ce9ab71ec100'::uuid, E'शास्त्रीय सम्बन्धन सिकाइ सिद्धान्त (Pavlov)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '0d569671-39de-4aff-a46c-ce9ab71ec100'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "स्वाभाविक र अस्वाभाविक उत्तेजना तथा प्रतिक्रिया" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := '162eb6a8-e474-592b-b0f4-c5f700695012'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, '0d569671-39de-4aff-a46c-ce9ab71ec100'::uuid, E'स्वाभाविक र अस्वाभाविक उत्तेजना तथा प्रतिक्रिया', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '0d569671-39de-4aff-a46c-ce9ab71ec100'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- Question 3
  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शास्त्रीय सम्बन्धन सिकाइ सिद्धान्त अनुसार के के स्वाभाविक र अस्वाभाविक उत्तेजनाको स्थापना गरी समान फ्रतिव्रिया हुन्छ ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (
    v_q_id,
    v_set_id,
    3,
    E'शास्त्रीय सम्बन्धन सिकाइ सिद्धान्त अनुसार के के स्वाभाविक र अस्वाभाविक उत्तेजनाको स्थापना गरी समान फ्रतिव्रिया हुन्छ ?',
    E'स्वाभाविक र अस्वाभाविक उत्तेजनाको स्थापना गरी समान फ्रतिव्रिया हुन्छ',
    E'स्वाभाविक र अस्वाभाविक उत्तेजनाको स्थापना गरी भिन्न फ्रतिव्रिया हुन्छ',
    E'स्वाभाविक र अस्वाभाविक उत्तेजनाको स्थापना गरी समान फ्रतिव्रिया हुँदैन',
    E'स्वाभाविक र अस्वाभाविक उत्तेजनाको स्थापना गरी भिन्न फ्रतिव्रिया हुँदैन',
    E'A',
    E'**शास्त्रीय सम्बन्धन सिकाइ सिद्धान्त अनुसार स्वाभाविक र अस्वाभाविक उत्तेजनाको स्थापना गरी समान फ्रतिव्रिया हुन्छ** को कारण यसमा दुवै उत्तेजनाको स्थापना गरी समान फ्रतिव्रिया हुन्छ।',
    'nepali',
    true,
    1,
    false
  )
  ON CONFLICT (id) DO NOTHING;

  v_jq_id := extensions.uuid_generate_v5(v_set_id, 'junction:' || extensions.uuid_generate_v5(v_set_id, E'शास्त्रीय सम्बन्धन सिकाइ सिद्धान्त अनुसार के के स्वाभाविक र अस्वाभाविक उत्तेजनाको स्थापना गरी समान फ्रतिव्रिया हुन्छ ?'));
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (
    v_jq_id,
    v_set_id,
    v_q_id,
    3
  )
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "सिकाइका सिद्धान्तहरू - पाभलभ (आधारभूत तह - सेट क)" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := '2647cbf2-98aa-5364-b0ef-647d7d0a51c4'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, '0d569671-39de-4aff-a46c-ce9ab71ec100'::uuid, E'सिकाइका सिद्धान्तहरू - पाभलभ (आधारभूत तह - सेट क)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '0d569671-39de-4aff-a46c-ce9ab71ec100'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "कार्यपरक सिकाइमा पुनर्बल र आकस्मिकताको भूमिका" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := 'ed85c6d8-b1bc-5b11-bb00-8fa19906293b'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, 'ae53051f-5f42-49ce-8e36-508fb656fa90'::uuid, E'कार्यपरक सिकाइमा पुनर्बल र आकस्मिकताको भूमिका', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'ae53051f-5f42-49ce-8e36-508fb656fa90'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "कार्यपरक सम्बन्धन सिकाइ सिद्धान्त (Skinner)" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := '89ab0b47-c52d-5599-8281-c7fe185b9633'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, 'ae53051f-5f42-49ce-8e36-508fb656fa90'::uuid, E'कार्यपरक सम्बन्धन सिकाइ सिद्धान्त (Skinner)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'ae53051f-5f42-49ce-8e36-508fb656fa90'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "सिकाइका सिद्धान्तहरू - स्किनर (आधारभूत तह - सेट ख)" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := 'f34791ea-07eb-5f04-8b1e-08c3d8205f2b'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, 'ae53051f-5f42-49ce-8e36-508fb656fa90'::uuid, E'सिकाइका सिद्धान्तहरू - स्किनर (आधारभूत तह - सेट ख)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'ae53051f-5f42-49ce-8e36-508fb656fa90'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  RAISE NOTICE 'Topic 4 Ingestion Complete.';
END $$;
