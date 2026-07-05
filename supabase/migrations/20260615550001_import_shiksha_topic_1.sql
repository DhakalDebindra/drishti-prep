-- Migration for Topic 1 Ingestion
-- Generated deterministically. Idempotent.
DO $$
DECLARE
  v_module_id uuid := '6695669a-f40e-421a-a4ec-b09bbeaf56c4'::uuid;
  v_topic_id uuid := '9b5be12e-0497-4716-ab14-356d4d19e7be'::uuid;
  v_set_id uuid;
  v_q_id uuid;
  v_jq_id uuid;
BEGIN
  RAISE NOTICE 'Starting migration for Topic 1...';

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "शिक्षाको शाब्दिक तथा अवधारणात्मक अर्थसम्बन्धी अभ्यास" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := 'e72e41e2-8136-5269-a168-ed6d7430683a'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, '70023fdf-26dc-4bd4-9777-5800c874c1b7'::uuid, E'शिक्षाको शाब्दिक तथा अवधारणात्मक अर्थसम्बन्धी अभ्यास', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '70023fdf-26dc-4bd4-9777-5800c874c1b7'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "शिक्षाको विश्लेषणात्मक अर्थ र परिभाषाहरू (कथन र जोडा मिलाउने अभ्यास)" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := 'b0f61165-55c4-53ee-9c3f-1839d57642b2'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, '70023fdf-26dc-4bd4-9777-5800c874c1b7'::uuid, E'शिक्षाको विश्लेषणात्मक अर्थ र परिभाषाहरू (कथन र जोडा मिलाउने अभ्यास)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '70023fdf-26dc-4bd4-9777-5800c874c1b7'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "शिक्षाको सामाजिक र राष्ट्रिय भूमिका" (New)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := extensions.uuid_generate_v5('70023fdf-26dc-4bd4-9777-5800c874c1b7'::uuid, E'शिक्षाको सामाजिक र राष्ट्रिय भूमिका');

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, '70023fdf-26dc-4bd4-9777-5800c874c1b7'::uuid, E'शिक्षाको सामाजिक र राष्ट्रिय भूमिका', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '70023fdf-26dc-4bd4-9777-5800c874c1b7'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- Question 1
  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पाठ्यक्रम विकास केन्द्रको मुख्य कार्य क्यो हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (
    v_q_id,
    v_set_id,
    1,
    E'पाठ्यक्रम विकास केन्द्रको मुख्य कार्य क्यो हो?',
    E'पाठ्यक्रम, पाठ्यपुस्तक तथा अन्य शैक्षणिक सामाग्रीको विकास, परिमार्जन र सुधार गरी शिक्षाको राष्ट्रिय उद्देश्य प्राप्तिमा सहयोग प्रुयाउनु हो',
    E'शिक्षा व्यवस्थाको सुधार गरी शिक्षा प्रवेशमा सहयोग प्रुयाउनु हो',
    E'शिक्षा व्यवस्थाको विकास गरी शिक्षा प्रवेशमा सहयोग प्रुयाउनु हो',
    E'शिक्षा व्यवस्थाको विकास गरी शिक्षा प्रवेशमा सहयोग प्रुयाउनु हो',
    E'A',
    E'**पाठ्यक्रम, पाठ्यपुस्तक तथा अन्य शैक्षणिक सामाग्रीको विकास, परिमार्जन र सुधार** गरी शिक्षाको राष्ट्रिय उद्देश्य प्राप्तिमा सहयोग प्रुयाउनु हो',
    'nepali',
    true,
    1,
    false
  )
  ON CONFLICT (id) DO NOTHING;

  v_jq_id := extensions.uuid_generate_v5(v_set_id, 'junction:' || extensions.uuid_generate_v5(v_set_id, E'पाठ्यक्रम विकास केन्द्रको मुख्य कार्य क्यो हो?'));
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (
    v_jq_id,
    v_set_id,
    v_q_id,
    1
  )
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Question 2
  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षाको परिभाषा अनुसार, शिक्षाले व्यक्तिको कुन-कुन पक्षमा परिवर्तन ल्याई आन्तरिक क्षमता प्रस्फुटन गर्ने प्रक्रिया हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (
    v_q_id,
    v_set_id,
    2,
    E'शिक्षाको परिभाषा अनुसार, शिक्षाले व्यक्तिको कुन-कुन पक्षमा परिवर्तन ल्याई आन्तरिक क्षमता प्रस्फुटन गर्ने प्रक्रिया हो?',
    E'ज्ञान, शारीरिक क्षमता र सामाजिक विकास',
    E'सीप, व्यवहार र आर्थिक उन्नति',
    E'ज्ञान, सीप र प्रवृत्ति',
    E'संवेग, नैतिकता र बाह्य क्षमता',
    E'C',
    E'शिक्षा भनेको व्यक्तिको **ज्ञान, सीप र प्रवृत्तिमा परिवर्तन** गरी उसको आन्तरिक क्षमता प्रस्फुटन गर्ने प्रक्रिया हो।',
    'nepali',
    true,
    1,
    false
  )
  ON CONFLICT (id) DO NOTHING;

  v_jq_id := extensions.uuid_generate_v5(v_set_id, 'junction:' || extensions.uuid_generate_v5(v_set_id, E'शिक्षाको परिभाषा अनुसार, शिक्षाले व्यक्तिको कुन-कुन पक्षमा परिवर्तन ल्याई आन्तरिक क्षमता प्रस्फुटन गर्ने प्रक्रिया हो?'));
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (
    v_jq_id,
    v_set_id,
    v_q_id,
    2
  )
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Question 3
  v_q_id := extensions.uuid_generate_v5(v_set_id, E'औपचारिक शिक्षाको एक प्रमुख विशेषता के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (
    v_q_id,
    v_set_id,
    3,
    E'औपचारिक शिक्षाको एक प्रमुख विशेषता के हो?',
    E'यो तहगत रूपमा संरचना गरिएको हुन्छ।',
    E'यो अनौपचारिक वातावरणमा प्रदान गरिन्छ।',
    E'यसको कुनै निश्चित पाठ्यक्रम हुँदैन।',
    E'यो जीवनभरि निरन्तर चलिरहन्छ र कुनै निश्चित अवधि हुँदैन।',
    E'A',
    E'औपचारिक शिक्षाको एक महत्त्वपूर्ण विशेषता भनेको यो **तहगत रूपमा संरचना गरिएको** हुन्छ।',
    'nepali',
    true,
    1,
    false
  )
  ON CONFLICT (id) DO NOTHING;

  v_jq_id := extensions.uuid_generate_v5(v_set_id, 'junction:' || extensions.uuid_generate_v5(v_set_id, E'औपचारिक शिक्षाको एक प्रमुख विशेषता के हो?'));
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (
    v_jq_id,
    v_set_id,
    v_q_id,
    3
  )
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Question 4
  v_q_id := extensions.uuid_generate_v5(v_set_id, E'औपचारिक शिक्षाको प्रमुख विशेषता के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (
    v_q_id,
    v_set_id,
    4,
    E'औपचारिक शिक्षाको प्रमुख विशेषता के हो?',
    E'यो समयअनुसार श्रेणीवद्ध गरिएको पद्दति हो।',
    E'यो अनौपचारिक र लचिलो हुन्छ।',
    E'यसमा कुनै निश्चित पाठ्यक्रम हुँदैन।',
    E'यो व्यक्तिगत रुचिमा मात्र आधारित हुन्छ।',
    E'A',
    E'औपचारिक शिक्षाको एक प्रमुख विशेषता यो **समयअनुसार श्रेणीवद्ध गरिएको पद्दति** हो।',
    'nepali',
    true,
    1,
    false
  )
  ON CONFLICT (id) DO NOTHING;

  v_jq_id := extensions.uuid_generate_v5(v_set_id, 'junction:' || extensions.uuid_generate_v5(v_set_id, E'औपचारिक शिक्षाको प्रमुख विशेषता के हो?'));
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (
    v_jq_id,
    v_set_id,
    v_q_id,
    4
  )
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Question 5
  v_q_id := extensions.uuid_generate_v5(v_set_id, E'औपचारिक शिक्षा कहाँबाट सुरु भई कहाँसम्म पुगेको हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (
    v_q_id,
    v_set_id,
    5,
    E'औपचारिक शिक्षा कहाँबाट सुरु भई कहाँसम्म पुगेको हुन्छ?',
    E'प्रारम्भिक बाल विकास विद्यालयबाट सुरु भई विश्वविद्यालयसम्म',
    E'प्राथमिक विद्यालयबाट सुरु भई माध्यमिक विद्यालयसम्म',
    E'माध्यमिक विद्यालयबाट सुरु भई कलेजसम्म',
    E'घरबाट सुरु भई विद्यालयसम्म',
    E'A',
    E'औपचारिक शिक्षा **प्रारम्भिक बाल विकास विद्यालयबाट सुरु भई विश्वविद्यालयसम्म** पुगेको हुन्छ।',
    'nepali',
    true,
    1,
    false
  )
  ON CONFLICT (id) DO NOTHING;

  v_jq_id := extensions.uuid_generate_v5(v_set_id, 'junction:' || extensions.uuid_generate_v5(v_set_id, E'औपचारिक शिक्षा कहाँबाट सुरु भई कहाँसम्म पुगेको हुन्छ?'));
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (
    v_jq_id,
    v_set_id,
    v_q_id,
    5
  )
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Question 6
  v_q_id := extensions.uuid_generate_v5(v_set_id, E'औपचारिक शिक्षाको प्रमुख विशेषता के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (
    v_q_id,
    v_set_id,
    6,
    E'औपचारिक शिक्षाको प्रमुख विशेषता के हो?',
    E'यसको समय र स्थान निश्चित गरिएको हुन्छ।',
    E'यसको समय र स्थान लचिलो हुन्छ।',
    E'यसको समय निश्चित भए पनि स्थान लचिलो हुन्छ।',
    E'यसको स्थान निश्चित भए पनि समय लचिलो हुन्छ।',
    E'A',
    E'औपचारिक शिक्षाको एक महत्वपूर्ण विशेषता भनेको यसको **समय र स्थान निश्चित गरिएको हुन्छ**।',
    'nepali',
    true,
    1,
    false
  )
  ON CONFLICT (id) DO NOTHING;

  v_jq_id := extensions.uuid_generate_v5(v_set_id, 'junction:' || extensions.uuid_generate_v5(v_set_id, E'औपचारिक शिक्षाको प्रमुख विशेषता के हो?'));
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (
    v_jq_id,
    v_set_id,
    v_q_id,
    6
  )
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Question 7
  v_q_id := extensions.uuid_generate_v5(v_set_id, E'औपचारिक शिक्षाको एउटा प्रमुख विशेषता के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (
    v_q_id,
    v_set_id,
    7,
    E'औपचारिक शिक्षाको एउटा प्रमुख विशेषता के हो?',
    E'वर्षभरि निरन्तर मूल्याङ्कन मात्र गरिन्छ र प्रमाणपत्र दिइँदैन।',
    E'सहभागिताको आधारमा मात्र प्रमाणपत्र प्रदान गरिन्छ।',
    E'वर्षको अन्त्यमा उर्त्तीण र अनुर्त्तीण छुट्याएर निश्चित प्रमाणपत्र प्रदान गरिन्छ।',
    E'कुनै औपचारिक मूल्याङ्कन वा प्रमाणपत्रको व्यवस्था हुँदैन।',
    E'C',
    E'औपचारिक शिक्षामा **वर्षको अन्त्यमा उर्त्तीण र अनुर्त्तीण छुट्याएर निश्चित प्रमाणपत्र प्रदान गरिन्छ**।',
    'nepali',
    true,
    1,
    false
  )
  ON CONFLICT (id) DO NOTHING;

  v_jq_id := extensions.uuid_generate_v5(v_set_id, 'junction:' || extensions.uuid_generate_v5(v_set_id, E'औपचारिक शिक्षाको एउटा प्रमुख विशेषता के हो?'));
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (
    v_jq_id,
    v_set_id,
    v_q_id,
    7
  )
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Question 8
  v_q_id := extensions.uuid_generate_v5(v_set_id, E'औपचारिक शिक्षामा कुन प्रक्रिया अनुसार अर्को तहका लागि प्रवेश पाउँछ ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (
    v_q_id,
    v_set_id,
    8,
    E'औपचारिक शिक्षामा कुन प्रक्रिया अनुसार अर्को तहका लागि प्रवेश पाउँछ ?',
    E'एक तह पूरा गर्दा',
    E'दुई तह पूरा गर्दा',
    E'एक तह उर्त्तीण गर्दा',
    E'तीन तह पूरा गर्दा',
    E'C',
    E'**एक तह उर्त्तीण गरेकाले मात्र अर्को तहका लागि प्रवेश पाउँछ**।',
    'nepali',
    true,
    1,
    false
  )
  ON CONFLICT (id) DO NOTHING;

  v_jq_id := extensions.uuid_generate_v5(v_set_id, 'junction:' || extensions.uuid_generate_v5(v_set_id, E'औपचारिक शिक्षामा कुन प्रक्रिया अनुसार अर्को तहका लागि प्रवेश पाउँछ ?'));
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (
    v_jq_id,
    v_set_id,
    v_q_id,
    8
  )
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Question 9
  v_q_id := extensions.uuid_generate_v5(v_set_id, E'औपचारिक शिक्षा कुन समूहसँग सम्बन्धित हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (
    v_q_id,
    v_set_id,
    9,
    E'औपचारिक शिक्षा कुन समूहसँग सम्बन्धित हुन्छ?',
    E'विशेष समूह',
    E'विशिष्ट उमेर र समूह',
    E'सामान्य समाज',
    E'व्यक्तिगत समूह',
    E'B',
    E'औपचारिक शिक्षा **विशिष्ट उमेर र समूहसँग सम्बन्धित** हुन्छ ।',
    'nepali',
    true,
    1,
    false
  )
  ON CONFLICT (id) DO NOTHING;

  v_jq_id := extensions.uuid_generate_v5(v_set_id, 'junction:' || extensions.uuid_generate_v5(v_set_id, E'औपचारिक शिक्षा कुन समूहसँग सम्बन्धित हुन्छ?'));
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (
    v_jq_id,
    v_set_id,
    v_q_id,
    9
  )
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Question 10
  v_q_id := extensions.uuid_generate_v5(v_set_id, E'औपचारिक शिक्षामा अध्ययन गर्ने कक्षाकोठामा कति समय उपस्थित हुनुपर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (
    v_q_id,
    v_set_id,
    10,
    E'औपचारिक शिक्षामा अध्ययन गर्ने कक्षाकोठामा कति समय उपस्थित हुनुपर्छ?',
    E'कक्षाकोठामा केही समय उपस्थित हुनुपर्छ',
    E'कक्षाकोठामा पूरा समय उपस्थित हुनुपर्छ',
    E'कक्षाकोठामा केही समय उपस्थित हुन सक्छ, तर पूरा समय आवश्यक नहुन्छ',
    E'कक्षाकोठामा उपस्थित हुने आवश्यकता नहुन्छ',
    E'B',
    E'**कक्षाकोठामा पूरा समय उपस्थित हुनुपर्छ** किनभने औपचारिक शिक्षामा अध्ययन गर्ने कक्षाकोठामा पूरा समय उपस्थित हुनुपर्छ।',
    'nepali',
    true,
    1,
    false
  )
  ON CONFLICT (id) DO NOTHING;

  v_jq_id := extensions.uuid_generate_v5(v_set_id, 'junction:' || extensions.uuid_generate_v5(v_set_id, E'औपचारिक शिक्षामा अध्ययन गर्ने कक्षाकोठामा कति समय उपस्थित हुनुपर्छ?'));
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (
    v_jq_id,
    v_set_id,
    v_q_id,
    10
  )
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Question 11
  v_q_id := extensions.uuid_generate_v5(v_set_id, E'औपचारिक शिक्षाको विशेषता के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (
    v_q_id,
    v_set_id,
    11,
    E'औपचारिक शिक्षाको विशेषता के हो?',
    E'शिक्षा अनुसन्धानमा आधारित हुन्छ',
    E'पूर्वनिर्धारित सिकाइ लक्ष्य र उद्देश्य प्राप्तिका लागि योजनाबद्ध रूपमा दिइने शिक्षा हो',
    E'व्यक्तिगत शिक्षा प्रदान गर्छ',
    E'शिक्षा पूर्णता प्राप्त गर्ने लागि स्वतन्त्र रूपमा दिइने शिक्षा हो',
    E'B',
    E'**पूर्वनिर्धारित सिकाइ लक्ष्य र उद्देश्य प्राप्तिका लागि योजनाबद्ध रूपमा दिइने शिक्षा** औपचारिक शिक्षाको विशेषता हो ।',
    'nepali',
    true,
    1,
    false
  )
  ON CONFLICT (id) DO NOTHING;

  v_jq_id := extensions.uuid_generate_v5(v_set_id, 'junction:' || extensions.uuid_generate_v5(v_set_id, E'औपचारिक शिक्षाको विशेषता के हो?'));
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (
    v_jq_id,
    v_set_id,
    v_q_id,
    11
  )
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Question 12
  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यालयबाट दिइने शिक्षाले मात्र व्यक्ति र समाजको आवश्यकता पूरा गर्न नसक्केकाले प्रचलनमा आएको शिक्षाको वैकल्पिक विधि र पद्धतिमा देहायको कुन पर्दछ ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (
    v_q_id,
    v_set_id,
    12,
    E'विद्यालयबाट दिइने शिक्षाले मात्र व्यक्ति र समाजको आवश्यकता पूरा गर्न नसक्केकाले प्रचलनमा आएको शिक्षाको वैकल्पिक विधि र पद्धतिमा देहायको कुन पर्दछ ?',
    E'अनौपचारिक शिक्षा',
    E'खुल्ला तथा दूरशिक्षा',
    E'पत्राचार शिक्षा',
    E'माथिका सबै',
    E'D',
    E'पिट्म्यानद्वारा सन् १८४० को दशकमा इङ्ल्यान्डबाट पत्राचार शिक्षाको सुरुवात भएको।',
    'nepali',
    true,
    1,
    false
  )
  ON CONFLICT (id) DO NOTHING;

  v_jq_id := extensions.uuid_generate_v5(v_set_id, 'junction:' || extensions.uuid_generate_v5(v_set_id, E'विद्यालयबाट दिइने शिक्षाले मात्र व्यक्ति र समाजको आवश्यकता पूरा गर्न नसक्केकाले प्रचलनमा आएको शिक्षाको वैकल्पिक विधि र पद्धतिमा देहायको कुन पर्दछ ?'));
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (
    v_jq_id,
    v_set_id,
    v_q_id,
    12
  )
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Question 13
  v_q_id := extensions.uuid_generate_v5(v_set_id, E'राष्ट्रिय शिक्षा नीति २०७६ जारी भएसँगै खारेज भएको नीति कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (
    v_q_id,
    v_set_id,
    13,
    E'राष्ट्रिय शिक्षा नीति २०७६ जारी भएसँगै खारेज भएको नीति कुन हो?',
    E'शैक्षिक जनशक्ति विकास केन्द्रको तालिम नीति, २०६२',
    E'अनौपचारिक शिक्षा नीति, २०६३',
    E'उच्च शिक्षा नीति, २०७२',
    E'माथिका सबै',
    E'D',
    E'(थप खारेज भएका नीति: अपाङ्गता भएका बालबालिकालाई समावेशी शिक्षा नीति, २०७३, प्राविधिक तथा व्यावसायिक शिक्षा नीति, तालिम नीति, २०६५)',
    'nepali',
    true,
    1,
    false
  )
  ON CONFLICT (id) DO NOTHING;

  v_jq_id := extensions.uuid_generate_v5(v_set_id, 'junction:' || extensions.uuid_generate_v5(v_set_id, E'राष्ट्रिय शिक्षा नीति २०७६ जारी भएसँगै खारेज भएको नीति कुन हो?'));
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (
    v_jq_id,
    v_set_id,
    v_q_id,
    13
  )
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Question 14
  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यालय शिक्षा क्षेत्र योजना (वि.सं. २०७९ - २०८४) ले तय गरेको ''समृद्ध नेपाल, सुखी नेपाली'' को आकांक्षा पुरा गर्ने निर्धारण गरिएको उद्देश्य कुन होइन ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (
    v_q_id,
    v_set_id,
    14,
    E'विद्यालय शिक्षा क्षेत्र योजना (वि.सं. २०७९ - २०८४) ले तय गरेको ''समृद्ध नेपाल, सुखी नेपाली'' को आकांक्षा पुरा गर्ने निर्धारण गरिएको उद्देश्य कुन होइन ?',
    E'समतामूलक पहुँच र सहभागिता',
    E'गुणस्तर तथा सान्दर्भिकता',
    E'साक्षरता, अनौपचारिक शिक्षा र जीवन पर्यन्त शिक्षा',
    E'मातृभाषामा शिक्षा',
    E'D',
    E'थप उद्देश्य: सुशासन र व्यवस्थापन',
    'nepali',
    true,
    1,
    false
  )
  ON CONFLICT (id) DO NOTHING;

  v_jq_id := extensions.uuid_generate_v5(v_set_id, 'junction:' || extensions.uuid_generate_v5(v_set_id, E'विद्यालय शिक्षा क्षेत्र योजना (वि.सं. २०७९ - २०८४) ले तय गरेको ''समृद्ध नेपाल, सुखी नेपाली'' को आकांक्षा पुरा गर्ने निर्धारण गरिएको उद्देश्य कुन होइन ?'));
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (
    v_jq_id,
    v_set_id,
    v_q_id,
    14
  )
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Question 15
  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षाको कार्यक्षेत्रलाई विभिन्न तहमा विभाजन गरिएको छ, यसरी विभाजन गरिएको कार्यक्षेत्रहरूमा देहायको कुन पर्दैन ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (
    v_q_id,
    v_set_id,
    15,
    E'शिक्षाको कार्यक्षेत्रलाई विभिन्न तहमा विभाजन गरिएको छ, यसरी विभाजन गरिएको कार्यक्षेत्रहरूमा देहायको कुन पर्दैन ?',
    E'व्यक्तिगत तह',
    E'सामाजिक तह',
    E'राष्ट्रिय तह',
    E'मनोवैज्ञानिक तथा व्यवहारिक तह',
    E'D',
    E'(John S. Brubacher का अनुसार शिक्षाको चारवटा कार्य)',
    'nepali',
    true,
    1,
    false
  )
  ON CONFLICT (id) DO NOTHING;

  v_jq_id := extensions.uuid_generate_v5(v_set_id, 'junction:' || extensions.uuid_generate_v5(v_set_id, E'शिक्षाको कार्यक्षेत्रलाई विभिन्न तहमा विभाजन गरिएको छ, यसरी विभाजन गरिएको कार्यक्षेत्रहरूमा देहायको कुन पर्दैन ?'));
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (
    v_jq_id,
    v_set_id,
    v_q_id,
    15
  )
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Question 16
  v_q_id := extensions.uuid_generate_v5(v_set_id, E'मोटरसाइकल मर्मत गर्ने कारखानामा सिकारु कामदारले जानकार पुराना कामदारहरूसँग सिर्के सैद्धान्तिक र व्यवहारिक दुवै ज्ञान र सिप हासिल गर्नु कस्तो किसिमको शिक्षा हो ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (
    v_q_id,
    v_set_id,
    16,
    E'मोटरसाइकल मर्मत गर्ने कारखानामा सिकारु कामदारले जानकार पुराना कामदारहरूसँग सिर्के सैद्धान्तिक र व्यवहारिक दुवै ज्ञान र सिप हासिल गर्नु कस्तो किसिमको शिक्षा हो ?',
    E'औपचारिक शिक्षा',
    E'अनौपचारिक शिक्षा',
    E'अतिरिक्त शिक्षा',
    E'माथिका सबै',
    E'C',
    E'(व्यक्तिले औपचारिक, अनौपचारिक र आत्रिक गरी तीनवटा धारहरूको प्रयोग गरे आजीवन सिकाइका अनुभव प्राप्त गर्दछ ।)',
    'nepali',
    true,
    1,
    false
  )
  ON CONFLICT (id) DO NOTHING;

  v_jq_id := extensions.uuid_generate_v5(v_set_id, 'junction:' || extensions.uuid_generate_v5(v_set_id, E'मोटरसाइकल मर्मत गर्ने कारखानामा सिकारु कामदारले जानकार पुराना कामदारहरूसँग सिर्के सैद्धान्तिक र व्यवहारिक दुवै ज्ञान र सिप हासिल गर्नु कस्तो किसिमको शिक्षा हो ?'));
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (
    v_jq_id,
    v_set_id,
    v_q_id,
    16
  )
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Question 17
  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समाजमा आमूल परिवर्तन ल्याउन अभिप्रेरित गर्ने शिक्षाको कार्यलाई कस्तो कार्य भनिन्छ ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (
    v_q_id,
    v_set_id,
    17,
    E'समाजमा आमूल परिवर्तन ल्याउन अभिप्रेरित गर्ने शिक्षाको कार्यलाई कस्तो कार्य भनिन्छ ?',
    E'प्रगतिशील कार्य',
    E'तदर्थ कार्य',
    E'क्रान्तिकारी कार्य',
    E'परम्परागत कार्य',
    E'C',
    E'(परम्पराको संरक्षण-परम्परागत कार्य, कसैको पक्ष लिने - तदर्थ कार्य, आधुनिक समाज निर्माण - प्रगतिशील कार्य)',
    'nepali',
    true,
    1,
    false
  )
  ON CONFLICT (id) DO NOTHING;

  v_jq_id := extensions.uuid_generate_v5(v_set_id, 'junction:' || extensions.uuid_generate_v5(v_set_id, E'समाजमा आमूल परिवर्तन ल्याउन अभिप्रेरित गर्ने शिक्षाको कार्यलाई कस्तो कार्य भनिन्छ ?'));
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (
    v_jq_id,
    v_set_id,
    v_q_id,
    17
  )
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Question 18
  v_q_id := extensions.uuid_generate_v5(v_set_id, E'बालबालिकाहरूले शिक्षा ग्रहण गर्दा सहभागिताको आधारमा शिक्षा ग्रहण गर्ने प्रकृतिमा देहायकोमध्ये कुन पर्दैन ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (
    v_q_id,
    v_set_id,
    18,
    E'बालबालिकाहरूले शिक्षा ग्रहण गर्दा सहभागिताको आधारमा शिक्षा ग्रहण गर्ने प्रकृतिमा देहायकोमध्ये कुन पर्दैन ?',
    E'साधारण र विशिष्ट शिक्षा',
    E'प्रत्यक्ष र परोक्ष शिक्षा',
    E'वैयक्तिक र सामूहिक शिक्षा',
    E'औपचारिक, अनौपचारिक र अनिर्क शिक्षा',
    E'C',
    E'साधारण र विशिष्ट, विशिष्टीकरणको आधारमा, प्रत्यक्ष र अप्रत्यक्ष: शिक्षकको उपस्थितिको आधारमा, औपचारिक अनौपचारिक र अनिर्क।',
    'nepali',
    true,
    1,
    false
  )
  ON CONFLICT (id) DO NOTHING;

  v_jq_id := extensions.uuid_generate_v5(v_set_id, 'junction:' || extensions.uuid_generate_v5(v_set_id, E'बालबालिकाहरूले शिक्षा ग्रहण गर्दा सहभागिताको आधारमा शिक्षा ग्रहण गर्ने प्रकृतिमा देहायकोमध्ये कुन पर्दैन ?'));
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (
    v_jq_id,
    v_set_id,
    v_q_id,
    18
  )
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Question 19
  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षाका सामाजिक उद्देश्य देहायको मध्ये कुन पर्दैन ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (
    v_q_id,
    v_set_id,
    19,
    E'शिक्षाका सामाजिक उद्देश्य देहायको मध्ये कुन पर्दैन ?',
    E'मानवीय सम्बन्ध',
    E'आर्थिक दक्षता',
    E'नागरिकताको ज्ञान',
    E'आन्तरिक प्रतिभाको प्रस्फुटन',
    E'C',
    E'(राशि पर्व २०२८ अनुसार शिक्षाका राष्ट्रिय उद्देश्य सातवटा, उच्चस्तरीय राष्ट्रिय शिक्षा आयोग २०५५ ले निर्धारण गरेको शिक्षाको उद्देश्य ६ वटा)',
    'nepali',
    true,
    1,
    false
  )
  ON CONFLICT (id) DO NOTHING;

  v_jq_id := extensions.uuid_generate_v5(v_set_id, 'junction:' || extensions.uuid_generate_v5(v_set_id, E'शिक्षाका सामाजिक उद्देश्य देहायको मध्ये कुन पर्दैन ?'));
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (
    v_jq_id,
    v_set_id,
    v_q_id,
    19
  )
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Question 20
  v_q_id := extensions.uuid_generate_v5(v_set_id, E'राष्ट्रिय शिक्षा नीति २०७६ जारी भएसँगै खारेज भएको नीतिमा देहायको कुन पर्दैन ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (
    v_q_id,
    v_set_id,
    20,
    E'राष्ट्रिय शिक्षा नीति २०७६ जारी भएसँगै खारेज भएको नीतिमा देहायको कुन पर्दैन ?',
    E'शैक्षिक जनशक्ति विकास केन्द्रको तालिम नीति, २०६२',
    E'अनौपचारिक शिक्षा नीति, २०६३',
    E'उच्च शिक्षा नीति, २०७२',
    E'आधारभूत शिक्षा नीति, २०६१',
    E'D',
    E'(अन्य खारेज भएका नीति : प्राविधिक तथा व्यावसायिक शिक्षा एवम् तालिम नीति, २०६१ र अपाङ्गता भएका बालबालिकाहरूका लागि समावेशी शिक्षा नीति, २०७३)',
    'nepali',
    true,
    1,
    false
  )
  ON CONFLICT (id) DO NOTHING;

  v_jq_id := extensions.uuid_generate_v5(v_set_id, 'junction:' || extensions.uuid_generate_v5(v_set_id, E'राष्ट्रिय शिक्षा नीति २०७६ जारी भएसँगै खारेज भएको नीतिमा देहायको कुन पर्दैन ?'));
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (
    v_jq_id,
    v_set_id,
    v_q_id,
    20
  )
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "शिक्षाको साधारण तथा विशिष्ट वर्गीकरण" (New)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := extensions.uuid_generate_v5('70023fdf-26dc-4bd4-9777-5800c874c1b7'::uuid, E'शिक्षाको साधारण तथा विशिष्ट वर्गीकरण');

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, '70023fdf-26dc-4bd4-9777-5800c874c1b7'::uuid, E'शिक्षाको साधारण तथा विशिष्ट वर्गीकरण', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '70023fdf-26dc-4bd4-9777-5800c874c1b7'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- Question 1
  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिएका मध्ये कुन विशेषता औपचारिक शिक्षाको स्वरुप संग मेल खाँदैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (
    v_q_id,
    v_set_id,
    1,
    E'तल दिएका मध्ये कुन विशेषता औपचारिक शिक्षाको स्वरुप संग मेल खाँदैन?',
    E'आपूर्तिमा आधारित शिक्षाको रुप',
    E'शिक्षाको उद्देश्य, पाठ्यक्रम, विषयवस्तु, विधि, मूल्याङ्कन पद्धति पूर्वनिर्धारित',
    E'निरन्तर र सीपमुखी',
    E'प्रमाणीकरण मुखी शिक्षा',
    E'C',
    E'(समयावधिको अनुसार, सैद्धान्तिक र साधारण शिक्षा जोड औपचारिक शिक्षाको विशेषता)',
    'nepali',
    true,
    1,
    false
  )
  ON CONFLICT (id) DO NOTHING;

  v_jq_id := extensions.uuid_generate_v5(v_set_id, 'junction:' || extensions.uuid_generate_v5(v_set_id, E'तल दिएका मध्ये कुन विशेषता औपचारिक शिक्षाको स्वरुप संग मेल खाँदैन?'));
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (
    v_jq_id,
    v_set_id,
    v_q_id,
    1
  )
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Question 2
  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यालय शिक्षा क्षेत्र योजना (२०७९-२०८८) मे विद्यालयको शैक्षिक सुधारसँग सम्बन्धित रही तय गरेको उद्देश्य तलका मध्ये कुन होइन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (
    v_q_id,
    v_set_id,
    2,
    E'विद्यालय शिक्षा क्षेत्र योजना (२०७९-२०८८) मे विद्यालयको शैक्षिक सुधारसँग सम्बन्धित रही तय गरेको उद्देश्य तलका मध्ये कुन होइन?',
    E'शिक्षामा आर्थिक, सुविधाविहीन, सीमान्तकृत तथा अपाङ्गता भएका बालबालिकाको समतामूलक पहुँच र सहभागिता सुनिश्चित गर्नु',
    E'प्रत्येक बालबालिकाको लागि तयारी, आधारभूत शिक्षक र गुणस्तरीय शिक्षा उपलब्ध सुनिश्चित गरी विद्यालय शिक्षाको गुणस्तर तथा सान्दर्भिकता अभिवृद्धि गर्नु',
    E'अनौपचारिक तवरबाट सिकेको ज्ञान तथा शिक्षको प्रमाणीकरण गरी औपचारिक शिक्षाको सम्बन्ध स्थापित गर्नु',
    E'क्षेत्रीय तथा अन्तर्राष्ट्रिय स्तरसँग तुलनायोग्य गुणस्तर सहितको सान्दर्भिक शिक्षा प्राप्त नागरिक विकास गर्नु',
    E'D',
    E'(विद्यालय शिक्षाका सबै प्रणालीमा सुशासन प्रवर्द्धन, प्रभावकारी शैक्षिक सेवा प्रवाह सुनिश्चित गर्नु ।)',
    'nepali',
    true,
    1,
    false
  )
  ON CONFLICT (id) DO NOTHING;

  v_jq_id := extensions.uuid_generate_v5(v_set_id, 'junction:' || extensions.uuid_generate_v5(v_set_id, E'विद्यालय शिक्षा क्षेत्र योजना (२०७९-२०८८) मे विद्यालयको शैक्षिक सुधारसँग सम्बन्धित रही तय गरेको उद्देश्य तलका मध्ये कुन होइन?'));
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (
    v_jq_id,
    v_set_id,
    v_q_id,
    2
  )
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Question 3
  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यालय शिक्षाको राष्ट्रिय उद्देश्य देहायमा मध्ये कुन तहको उद्देश्यको उदाहरण हो ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (
    v_q_id,
    v_set_id,
    3,
    E'विद्यालय शिक्षाको राष्ट्रिय उद्देश्य देहायमा मध्ये कुन तहको उद्देश्यको उदाहरण हो ?',
    E'साधारण उद्देश्य',
    E'विशिष्ट उद्देश्य',
    E'ध्येय',
    E'लक्ष्य',
    E'D',
    E'(लक्ष्य: समाज वा राज्यको व्यापक चाहना लाग्यो समय आवश्यक्ता, ध्येय: शिक्षाविदले चाहना मध्यकालीन उद्देश्य/उद्देश्य: चाहिने हुनुपर्ने व्यवहार परिवर्तन शिक्षकको चाहना ।)',
    'nepali',
    true,
    1,
    false
  )
  ON CONFLICT (id) DO NOTHING;

  v_jq_id := extensions.uuid_generate_v5(v_set_id, 'junction:' || extensions.uuid_generate_v5(v_set_id, E'विद्यालय शिक्षाको राष्ट्रिय उद्देश्य देहायमा मध्ये कुन तहको उद्देश्यको उदाहरण हो ?'));
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (
    v_jq_id,
    v_set_id,
    v_q_id,
    3
  )
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Question 4
  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यालय क्षेत्र विकास योजनाले लक्ष्य उद्देश्यहरू हासिल गर्न निर्धारण गरेका प्रमुख आयाममा मा कुन पर्दैन ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (
    v_q_id,
    v_set_id,
    4,
    E'विद्यालय क्षेत्र विकास योजनाले लक्ष्य उद्देश्यहरू हासिल गर्न निर्धारण गरेका प्रमुख आयाममा मा कुन पर्दैन ?',
    E'समता र गुणस्तर',
    E'प्रविधि र प्रयोग',
    E'सक्षमता र सुशासन तथा व्यवस्थापन',
    E'उत्थानशीलता',
    E'B',
    E'(जम्मा पञ्चवटा आयामको व्यवस्था, चारवटा तहको अवस्था: आधारभूत, अनौपचारिक शिक्षा, माध्यमिक शिक्षा तथा जीवन पर्यन्त सिकाइ)',
    'nepali',
    true,
    1,
    false
  )
  ON CONFLICT (id) DO NOTHING;

  v_jq_id := extensions.uuid_generate_v5(v_set_id, 'junction:' || extensions.uuid_generate_v5(v_set_id, E'विद्यालय क्षेत्र विकास योजनाले लक्ष्य उद्देश्यहरू हासिल गर्न निर्धारण गरेका प्रमुख आयाममा मा कुन पर्दैन ?'));
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (
    v_jq_id,
    v_set_id,
    v_q_id,
    4
  )
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Question 5
  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यालय शिक्षा क्षेत्र योजना (२०७९-२०८८) ले योजनाको दूरदृष्टि तथा लक्ष्य हासिल गर्न पहिचान गरिएका मुख्य क्रियाकलाप कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (
    v_q_id,
    v_set_id,
    5,
    E'विद्यालय शिक्षा क्षेत्र योजना (२०७९-२०८८) ले योजनाको दूरदृष्टि तथा लक्ष्य हासिल गर्न पहिचान गरिएका मुख्य क्रियाकलाप कुन हो?',
    E'पहुँच र सहभागिता',
    E'समता तथा समावेशिता',
    E'गुणस्तर र साम्दर्भिकता',
    E'माथिका सबै',
    E'D',
    E'(थप क्रियाकलापः अनौपचारिक शिक्षा तथा जीवन पर्यन्त सिकाइ र सुशासन, व्यवस्थापन तथा समन्वय)',
    'nepali',
    true,
    1,
    false
  )
  ON CONFLICT (id) DO NOTHING;

  v_jq_id := extensions.uuid_generate_v5(v_set_id, 'junction:' || extensions.uuid_generate_v5(v_set_id, E'विद्यालय शिक्षा क्षेत्र योजना (२०७९-२०८८) ले योजनाको दूरदृष्टि तथा लक्ष्य हासिल गर्न पहिचान गरिएका मुख्य क्रियाकलाप कुन हो?'));
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (
    v_jq_id,
    v_set_id,
    v_q_id,
    5
  )
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Question 6
  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालका अधिकांश भूगोलहरूमा औपचारिक शिक्षा दिने विद्यालयहरू खुले तापनि खुला विद्यालयको औचित्य कायम छ हुनुको प्रमुख कारण कुन होइन ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (
    v_q_id,
    v_set_id,
    6,
    E'नेपालका अधिकांश भूगोलहरूमा औपचारिक शिक्षा दिने विद्यालयहरू खुले तापनि खुला विद्यालयको औचित्य कायम छ हुनुको प्रमुख कारण कुन होइन ?',
    E'विभिन्न कारणले विद्यालयको अवसरबाट वञ्चित समूहको आवश्यकता अनुसार शिक्षा प्रदान गर्नु',
    E'तोकिएको न्यूनतम शिक्षा हासिल गर्न नसकेका तर उच्च शिक्षा हासिल गर्न नसकेमा समूहलाई रोजगारीमा प्रवेशका लागि व्यावसायिक तालिम प्रदान गर्नु',
    E'भौगोलिक दृष्टिले अतिविकट, सामाजिक, आर्थिक कारणले पिछडिएको जनसमुदायको विद्यार्थीहरूलाई शैक्षिक अवसर सुनिश्चित गर्नु',
    E'गुणस्तरीय शिक्षाको माध्यमबाट सिकाइ अभिवृद्धि गर्नुमा समग्र शैक्षिक नतिजा सुधार गर्नु',
    E'D',
    E'अन्य कारण/औचित्य: द्वन्द्व प्रभावित भएका कारणले विद्यालय जान नसकेका वञ्चित समूहलाई शिक्षा आर्जन गर्ने अवसर सिर्जना, नियमित विद्यालयमा उपस्थित हुन नसकेका विद्यार्थीलाई लागि सो अध्ययनको माध्यमबाट न्यूनतम आवश्यकता पुर्‍याउन गरी शिक्षा प्रदान गर्न अवसर प्रदान गर्नु, विद्यालय उमेरसम्मका विद्यार्थीहरूले ठूलो समूह विद्यालय बाहिर रहेको।',
    'nepali',
    true,
    1,
    false
  )
  ON CONFLICT (id) DO NOTHING;

  v_jq_id := extensions.uuid_generate_v5(v_set_id, 'junction:' || extensions.uuid_generate_v5(v_set_id, E'नेपालका अधिकांश भूगोलहरूमा औपचारिक शिक्षा दिने विद्यालयहरू खुले तापनि खुला विद्यालयको औचित्य कायम छ हुनुको प्रमुख कारण कुन होइन ?'));
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (
    v_jq_id,
    v_set_id,
    v_q_id,
    6
  )
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "नेपालको आधुनिक शैक्षिक इतिहास र राणाकालीन शिक्षा" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := '65babe40-0fe2-51e3-9bb1-de2ef515f576'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, '472e95ab-622e-48d9-9b70-b68afccc8589'::uuid, E'नेपालको आधुनिक शैक्षिक इतिहास र राणाकालीन शिक्षा', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '472e95ab-622e-48d9-9b70-b68afccc8589'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "शैक्षिक संगठन, संरचना र मन्त्रालयको भूमिका" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := '6321478a-d11c-5be9-937a-e5ecb9f38e25'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, '78064cb5-7e3a-4be6-bbf8-2ff364bdc4e4'::uuid, E'शैक्षिक संगठन, संरचना र मन्त्रालयको भूमिका', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '78064cb5-7e3a-4be6-bbf8-2ff364bdc4e4'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  RAISE NOTICE 'Topic 1 Ingestion Complete.';
END $$;
