-- Migration for Topic 5 Ingestion
-- Generated deterministically. Idempotent.
DO $$
DECLARE
  v_module_id uuid := '6695669a-f40e-421a-a4ec-b09bbeaf56c4'::uuid;
  v_topic_id uuid := '2d308800-85c4-4945-b7b2-3b2ac8831074'::uuid;
  v_set_id uuid;
  v_q_id uuid;
  v_jq_id uuid;
BEGIN
  RAISE NOTICE 'Starting migration for Topic 5...';

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "पाठ्यक्रमको परिचय, अवधारणा, उद्देश्य, क्षेत्र र क्रम - थप अभ्यास 1" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := 'fdc25957-4cd5-5fd7-8176-23c0610c3356'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, '208f57ad-5caf-48df-8c09-dbaf55a84caf'::uuid, E'पाठ्यक्रमको परिचय, अवधारणा, उद्देश्य, क्षेत्र र क्रम - थप अभ्यास 1', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '208f57ad-5caf-48df-8c09-dbaf55a84caf'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "पाठ्यक्रमका उद्देश्य, क्षेत्र र क्रम" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := 'a3ac4963-4b4b-5b94-8cc1-212db05b49a2'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, '208f57ad-5caf-48df-8c09-dbaf55a84caf'::uuid, E'पाठ्यक्रमका उद्देश्य, क्षेत्र र क्रम', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '208f57ad-5caf-48df-8c09-dbaf55a84caf'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "पाठ्यक्रमको परिचय, अर्थ र अवधारणा" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := '13be9bd2-42b2-57a5-9e2c-0195f00513e3'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, '208f57ad-5caf-48df-8c09-dbaf55a84caf'::uuid, E'पाठ्यक्रमको परिचय, अर्थ र अवधारणा', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '208f57ad-5caf-48df-8c09-dbaf55a84caf'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "पाठ्यक्रमका प्रमुख तत्व र अङ्गहरू" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := '7db8e1e1-bfd0-5039-8079-97294877c52d'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, '208f57ad-5caf-48df-8c09-dbaf55a84caf'::uuid, E'पाठ्यक्रमका प्रमुख तत्व र अङ्गहरू', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '208f57ad-5caf-48df-8c09-dbaf55a84caf'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "पाठ्यक्रमको परिचय, अवधारणा, उद्देश्य, क्षेत्र र क्रम - थप अभ्यास 2" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := '5e40d394-a3c1-56b6-ae0b-d48197493be2'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, '208f57ad-5caf-48df-8c09-dbaf55a84caf'::uuid, E'पाठ्यक्रमको परिचय, अवधारणा, उद्देश्य, क्षेत्र र क्रम - थप अभ्यास 2', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '208f57ad-5caf-48df-8c09-dbaf55a84caf'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "पाठ्यक्रम र यसका नमुनाहरू (विश्लेषणात्मक तह - ६०/४० ढाँचा)" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := '8dc502f6-3fcd-5c2f-b4b3-d64e9a03c316'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, '208f57ad-5caf-48df-8c09-dbaf55a84caf'::uuid, E'पाठ्यक्रम र यसका नमुनाहरू (विश्लेषणात्मक तह - ६०/४० ढाँचा)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '208f57ad-5caf-48df-8c09-dbaf55a84caf'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "पाठ्यक्रमको परिचय, अवधारणा र विकास (आधारभूत तह - अति सघन)" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := '145c26b8-2ea9-5e7e-89a3-5c3cd3613042'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, '208f57ad-5caf-48df-8c09-dbaf55a84caf'::uuid, E'पाठ्यक्रमको परिचय, अवधारणा र विकास (आधारभूत तह - अति सघन)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '208f57ad-5caf-48df-8c09-dbaf55a84caf'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "राष्ट्रिय पाठ्यक्रम प्रारुप २०७६ को मार्गनिर्देशन" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := '87a901fe-0828-56f0-a647-e12cbe84b2f2'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, 'e4c591e2-ee54-421f-995d-0827223ef4fd'::uuid, E'राष्ट्रिय पाठ्यक्रम प्रारुप २०७६ को मार्गनिर्देशन', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'e4c591e2-ee54-421f-995d-0827223ef4fd'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "राष्ट्रिय पाठ्यक्रम प्रारुपका सिद्धान्त र संरचना" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := 'fa1be197-92da-557a-80a7-9c74321e6bce'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, 'e4c591e2-ee54-421f-995d-0827223ef4fd'::uuid, E'राष्ट्रिय पाठ्यक्रम प्रारुपका सिद्धान्त र संरचना', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'e4c591e2-ee54-421f-995d-0827223ef4fd'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "पाठ्यक्रममा विविधता व्यवस्थापन र स्थानीय पाठ्यक्रम" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := '4e15e1c2-e581-5fed-a2b2-49a52146d553'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, '3aa334f6-9cd1-4609-b8c4-645b929b760f'::uuid, E'पाठ्यक्रममा विविधता व्यवस्थापन र स्थानीय पाठ्यक्रम', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '3aa334f6-9cd1-4609-b8c4-645b929b760f'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- Question 17
  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालमा स्थानीय पाठ्यक्रम सम्बन्धी विद्यमान नीतिगत व्यवस्था विचार गर्नुहोस्: / a. आधारभूत तहको पाठ्यक्रम अन्तर्गत कक्षा १-३ मा मातृभाषिक शीप, स्थानीय विषयवस्तु सम्बन्धी क्रियाकलापका लागि वार्षिक पाँच पाठ्यघन्टा छुट्याइएको छ। / b. कक्षा १-८ मा स्थानीय समयबाहेक विद्यालयले पुरै समय मातृभाषाको वा केही समय मातृभाषाको र अन्य समय कुनै अन्य एउटा भाषामा विषयवस्तु पनि दिन सक्नेछन्। / c. स्थानीय पाठ्यक्रम स्थानीय तहबाटै स्वीकृत भएपछात मात्र लागु गर्नुपर्ने हुन्छ। / d. स्थानीय पाठ्यक्रम विकास तथा कार्यान्वयनका लागि समिति गठन नगरपालिका वा गाउँपालिकाको आफ्नो संयोजकमा हुन्छ।');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (
    v_q_id,
    v_set_id,
    17,
    E'नेपालमा स्थानीय पाठ्यक्रम सम्बन्धी विद्यमान नीतिगत व्यवस्था विचार गर्नुहोस्: / a. आधारभूत तहको पाठ्यक्रम अन्तर्गत कक्षा १-३ मा मातृभाषिक शीप, स्थानीय विषयवस्तु सम्बन्धी क्रियाकलापका लागि वार्षिक पाँच पाठ्यघन्टा छुट्याइएको छ। / b. कक्षा १-८ मा स्थानीय समयबाहेक विद्यालयले पुरै समय मातृभाषाको वा केही समय मातृभाषाको र अन्य समय कुनै अन्य एउटा भाषामा विषयवस्तु पनि दिन सक्नेछन्। / c. स्थानीय पाठ्यक्रम स्थानीय तहबाटै स्वीकृत भएपछात मात्र लागु गर्नुपर्ने हुन्छ। / d. स्थानीय पाठ्यक्रम विकास तथा कार्यान्वयनका लागि समिति गठन नगरपालिका वा गाउँपालिकाको आफ्नो संयोजकमा हुन्छ।',
    E'सबै बेठीक',
    E'सबै ठीक',
    E'a र c बेठीक',
    E'd मात्र बेठीक',
    E'D',
    E'पाठ्यक्रम विकासका लागि गठन भएको समितिको संयोजक स्थानीय विज्ञ वा शिक्षा शास्त्रको प्रमुख हुन सक्नेछ।',
    'nepali',
    true,
    1,
    false
  )
  ON CONFLICT (id) DO NOTHING;

  v_jq_id := extensions.uuid_generate_v5(v_set_id, 'junction:' || extensions.uuid_generate_v5(v_set_id, E'नेपालमा स्थानीय पाठ्यक्रम सम्बन्धी विद्यमान नीतिगत व्यवस्था विचार गर्नुहोस्: / a. आधारभूत तहको पाठ्यक्रम अन्तर्गत कक्षा १-३ मा मातृभाषिक शीप, स्थानीय विषयवस्तु सम्बन्धी क्रियाकलापका लागि वार्षिक पाँच पाठ्यघन्टा छुट्याइएको छ। / b. कक्षा १-८ मा स्थानीय समयबाहेक विद्यालयले पुरै समय मातृभाषाको वा केही समय मातृभाषाको र अन्य समय कुनै अन्य एउटा भाषामा विषयवस्तु पनि दिन सक्नेछन्। / c. स्थानीय पाठ्यक्रम स्थानीय तहबाटै स्वीकृत भएपछात मात्र लागु गर्नुपर्ने हुन्छ। / d. स्थानीय पाठ्यक्रम विकास तथा कार्यान्वयनका लागि समिति गठन नगरपालिका वा गाउँपालिकाको आफ्नो संयोजकमा हुन्छ।'));
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (
    v_jq_id,
    v_set_id,
    v_q_id,
    17
  )
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "पाठ्यक्रम, पाठ्यपुस्तक र शिक्षक निर्देशिका" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := '81cb6137-bf4b-598a-b1ae-491d41279b04'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, '15f070d3-67f2-44f8-9fb1-09b4b8bfcacb'::uuid, E'पाठ्यक्रम, पाठ्यपुस्तक र शिक्षक निर्देशिका', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '15f070d3-67f2-44f8-9fb1-09b4b8bfcacb'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "पाठ्यपुस्तक र निर्देशिका बीचको सम्बन्ध" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := '88fe0f31-881a-5a2d-83d7-2e25a1b76098'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, '15f070d3-67f2-44f8-9fb1-09b4b8bfcacb'::uuid, E'पाठ्यपुस्तक र निर्देशिका बीचको सम्बन्ध', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '15f070d3-67f2-44f8-9fb1-09b4b8bfcacb'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  RAISE NOTICE 'Topic 5 Ingestion Complete.';
END $$;
