-- Migration for Topic 6 Ingestion
-- Generated deterministically. Idempotent.
DO $$
DECLARE
  v_module_id uuid := '6695669a-f40e-421a-a4ec-b09bbeaf56c4'::uuid;
  v_topic_id uuid := 'acf58395-316c-4a70-b7b3-5470be568528'::uuid;
  v_set_id uuid;
  v_q_id uuid;
  v_jq_id uuid;
BEGIN
  RAISE NOTICE 'Starting migration for Topic 6...';

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "शैक्षणिक योजना: वार्षिक कार्ययोजना र एकाइ योजना" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := 'a9ec4dcc-e6e2-5539-82ae-1ec10a1b0e94'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, '4de2104d-650e-4026-9b3b-114ccbf9a759'::uuid, E'शैक्षणिक योजना: वार्षिक कार्ययोजना र एकाइ योजना', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '4de2104d-650e-4026-9b3b-114ccbf9a759'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "विद्यार्थी केन्द्रीत शिक्षण विधि र यसको प्रयोग" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := 'a7a967af-90db-5e97-9b63-a37a9810f976'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, '335cbffc-fbb1-4ea9-b0d7-ee0cfd62160d'::uuid, E'विद्यार्थी केन्द्रीत शिक्षण विधि र यसको प्रयोग', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '335cbffc-fbb1-4ea9-b0d7-ee0cfd62160d'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "शिक्षण सिकाइ विधि: शिक्षक केन्द्रीत र अन्तरक्रियात्मक" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := 'a4ebd340-a54d-5b6a-8811-d41df0cc483a'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, '335cbffc-fbb1-4ea9-b0d7-ee0cfd62160d'::uuid, E'शिक्षण सिकाइ विधि: शिक्षक केन्द्रीत र अन्तरक्रियात्मक', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '335cbffc-fbb1-4ea9-b0d7-ee0cfd62160d'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "छलफल, प्रदर्शन र परियोजना विधिहरू" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := '3a197691-1fcb-53b3-83c4-d6e8f11d06c4'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, '335cbffc-fbb1-4ea9-b0d7-ee0cfd62160d'::uuid, E'छलफल, प्रदर्शन र परियोजना विधिहरू', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '335cbffc-fbb1-4ea9-b0d7-ee0cfd62160d'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "शिक्षण सामग्रीको अर्थ र वर्गीकरण" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := '5cf4d587-7277-593e-9b5c-4b298c57db5f'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, '49655ebd-bf99-48e1-8fc6-3317c4505a42'::uuid, E'शिक्षण सामग्रीको अर्थ र वर्गीकरण', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '49655ebd-bf99-48e1-8fc6-3317c4505a42'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- Question 5
  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षण सामग्रीको प्रयोगले विद्यार्थीहरूमा के विकसित गर्ने हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (
    v_q_id,
    v_set_id,
    5,
    E'शिक्षण सामग्रीको प्रयोगले विद्यार्थीहरूमा के विकसित गर्ने हुन्छ?',
    E'वैज्ञानिक सोच, वैज्ञानिक विश्लेषणात्मक रूपमा ज्ञान प्राप्त गर्ने बानीको विकास गर्ने हुँदा',
    E'वैज्ञानिक अभिवृत्तिको विकास गराउने हुँदा',
    E'विद्यार्थीहरूमा आत्मविश्वास विकसित गर्ने हुँदा',
    E'विद्यार्थीहरूमा भावनात्मक बुद्धिमत्ता विकसित गर्ने हुँदा',
    E'A',
    E'शिक्षण सामग्रीको प्रयोगले विद्यार्थीहरूमा **वैज्ञानिक सोच, वैज्ञानिक विश्लेषणात्मक रूपमा ज्ञान प्राप्त गर्ने बानीको विकास गर्ने हुँदा** वैज्ञानिक अभिवृत्तिको विकास गराउने हुँदा विद्यार्थीहरूमा आत्मविश्वास विकसित गर्ने हुँदा विद्यार्थीहरूमा भावनात्मक बुद्धिमत्ता विकसित गर्ने हुँदा',
    'nepali',
    true,
    1,
    false
  )
  ON CONFLICT (id) DO NOTHING;

  v_jq_id := extensions.uuid_generate_v5(v_set_id, 'junction:' || extensions.uuid_generate_v5(v_set_id, E'शिक्षण सामग्रीको प्रयोगले विद्यार्थीहरूमा के विकसित गर्ने हुन्छ?'));
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (
    v_jq_id,
    v_set_id,
    v_q_id,
    5
  )
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Question 6
  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षण सामग्रीको प्रयोगले विद्यार्थीहरूलाई के प्रभाव पारेको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (
    v_q_id,
    v_set_id,
    6,
    E'शिक्षण सामग्रीको प्रयोगले विद्यार्थीहरूलाई के प्रभाव पारेको छ?',
    E'विद्यार्थीहरू शिक्षकले बुझाउन नसकेका कुरा बुझ्न सक्दैनन्',
    E'विद्यार्थीहरू शिक्षकले बुझाउन नसकेका कुरा बुझ्न सक्दछन्',
    E'विद्यार्थीहरू शिक्षकले बुझाउन सकेका कुरा बुझ्न सक्दैनन्',
    E'विद्यार्थीहरू शिक्षकले बुझाउन सकेका कुरा बुझ्न सक्दछन्',
    E'B',
    E'शिक्षण सामग्रीको प्रयोगले विद्यार्थीहरूलाई शिक्षकले बुझाउन नसकेका अप्ठ्यारा कुरालाई **शिक्षण सामग्रीको प्रयोगले छोटो समय मै बुझाउन सकिने** । यसकारण शिक्षण सामग्रीको प्रयोगले विद्यार्थीहरूलाई शिक्षकले बुझाउन नसकेका कुरा बुझ्न सक्दछन्।',
    'nepali',
    true,
    1,
    false
  )
  ON CONFLICT (id) DO NOTHING;

  v_jq_id := extensions.uuid_generate_v5(v_set_id, 'junction:' || extensions.uuid_generate_v5(v_set_id, E'शिक्षण सामग्रीको प्रयोगले विद्यार्थीहरूलाई के प्रभाव पारेको छ?'));
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (
    v_jq_id,
    v_set_id,
    v_q_id,
    6
  )
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Question 7
  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शैक्षिक सामग्रीको प्रकार कति हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (
    v_q_id,
    v_set_id,
    7,
    E'शैक्षिक सामग्रीको प्रकार कति हुन्छ?',
    E'दुई प्रकार',
    E'चार प्रकार',
    E'पाँच प्रकार',
    E'सात प्रकार',
    E'B',
    E'शैक्षिक सामग्रीको चार प्रकार हुन्छन्। **पाठ्य सामग्री, दृश्य सामग्री, श्रव्य सामग्री र श्रव्य–दृश्य सामग्री**। यी चार प्रकार शैक्षिक सामग्रीको मुख्य वर्गीकरण हुन्छन्।',
    'nepali',
    true,
    1,
    false
  )
  ON CONFLICT (id) DO NOTHING;

  v_jq_id := extensions.uuid_generate_v5(v_set_id, 'junction:' || extensions.uuid_generate_v5(v_set_id, E'शैक्षिक सामग्रीको प्रकार कति हुन्छ?'));
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (
    v_jq_id,
    v_set_id,
    v_q_id,
    7
  )
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Question 8
  v_q_id := extensions.uuid_generate_v5(v_set_id, E'श्रव्य सामग्री शिक्षणमा किन प्रयोग गरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (
    v_q_id,
    v_set_id,
    8,
    E'श्रव्य सामग्री शिक्षणमा किन प्रयोग गरिन्छ?',
    E'श्रव्य सामग्री शिक्षणमा व्याकरण शिक्ने लाग्छ',
    E'श्रव्य सामग्री शिक्षणमा विषयवस्तुको ज्ञान प्राप्त गर्न सकिन्छ',
    E'श्रव्य सामग्री शिक्षणमा गणित शिक्ने लाग्छ',
    E'श्रव्य सामग्री शिक्षणमा भाषा शिक्ने लाग्छ',
    E'B',
    E'श्रव्य सामग्री शिक्षणमा विषयवस्तुको ज्ञान प्राप्त गर्न सकिन्छ किनकि **श्रव्य सामग्री शिक्षणमा सुनेर विषयवस्तुको ज्ञान प्राप्त गर्न सकिन्छ**।',
    'nepali',
    true,
    1,
    false
  )
  ON CONFLICT (id) DO NOTHING;

  v_jq_id := extensions.uuid_generate_v5(v_set_id, 'junction:' || extensions.uuid_generate_v5(v_set_id, E'श्रव्य सामग्री शिक्षणमा किन प्रयोग गरिन्छ?'));
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (
    v_jq_id,
    v_set_id,
    v_q_id,
    8
  )
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Question 9
  v_q_id := extensions.uuid_generate_v5(v_set_id, E'श्रव्य–दृश्य सामग्री को परिभाषा के रूपमा के के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (
    v_q_id,
    v_set_id,
    9,
    E'श्रव्य–दृश्य सामग्री को परिभाषा के रूपमा के के हो?',
    E'श्रव्य सामग्री',
    E'दृश्य सामग्री',
    E'**श्रव्य–दृश्य सामग्री शिक्षणमा सुन्ने र देख्ने दुवै कार्यका लागि प्रयोग गरिने सामग्री वा उपकरण**',
    E'श्रव्य सामग्री र दृश्य सामग्री',
    E'C',
    E'श्रव्य–दृश्य सामग्री शिक्षणमा सुन्ने र देख्ने दुवै कार्यका लागि प्रयोग गरिने सामग्री वा उपकरणलाई श्रव्य–दृश्य सामग्री भनिन्छ । **श्रव्य–दृश्य सामग्री शिक्षणमा सुन्ने र देख्ने दुवै कार्यका लागि प्रयोग गरिने सामग्री वा उपकरण** हो ।',
    'nepali',
    true,
    1,
    false
  )
  ON CONFLICT (id) DO NOTHING;

  v_jq_id := extensions.uuid_generate_v5(v_set_id, 'junction:' || extensions.uuid_generate_v5(v_set_id, E'श्रव्य–दृश्य सामग्री को परिभाषा के रूपमा के के हो?'));
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (
    v_jq_id,
    v_set_id,
    v_q_id,
    9
  )
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  RAISE NOTICE 'Topic 6 Ingestion Complete.';
END $$;
