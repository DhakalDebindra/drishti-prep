-- Migration for Topic 2 Ingestion
-- Generated deterministically. Idempotent.
DO $$
DECLARE
  v_module_id uuid := '6695669a-f40e-421a-a4ec-b09bbeaf56c4'::uuid;
  v_topic_id uuid := '8dafc3cd-62b2-45e0-905e-aa6c841526f2'::uuid;
  v_set_id uuid;
  v_q_id uuid;
  v_jq_id uuid;
BEGIN
  RAISE NOTICE 'Starting migration for Topic 2...';

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "व्यवहारको अध्ययन र मनोविज्ञानका विभिन्न विधिहरू" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := 'e12b4e0f-cba1-51b9-bc32-75188920d7a9'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, '1e24d947-b929-4a1b-a069-d5b1d1136baa'::uuid, E'व्यवहारको अध्ययन र मनोविज्ञानका विभिन्न विधिहरू', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '1e24d947-b929-4a1b-a069-d5b1d1136baa'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "शिक्षा मनोविज्ञानको आवश्यकता र शिक्षणमा महत्त्व" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := '8e8147e2-9ded-5988-8d5d-4c8e9a3ff4ef'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, '1e24d947-b929-4a1b-a069-d5b1d1136baa'::uuid, E'शिक्षा मनोविज्ञानको आवश्यकता र शिक्षणमा महत्त्व', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '1e24d947-b929-4a1b-a069-d5b1d1136baa'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "शिक्षा मनोविज्ञानको परिचय, अर्थ र अवधारणा" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := '2fb7c14c-ea69-521e-9484-3ecda0f812e3'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, '1e24d947-b929-4a1b-a069-d5b1d1136baa'::uuid, E'शिक्षा मनोविज्ञानको परिचय, अर्थ र अवधारणा', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '1e24d947-b929-4a1b-a069-d5b1d1136baa'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "शिक्षा मनोविज्ञान: अर्थ, अवधारणा, आवश्यकता र महत्त्व - थप अभ्यास 1" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := '5d492dee-3497-5214-9f9a-f5308865d5b9'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, '1e24d947-b929-4a1b-a069-d5b1d1136baa'::uuid, E'शिक्षा मनोविज्ञान: अर्थ, अवधारणा, आवश्यकता र महत्त्व - थप अभ्यास 1', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '1e24d947-b929-4a1b-a069-d5b1d1136baa'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "शिक्षा मनोविज्ञान (विश्लेषणात्मक तह)" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := 'b732e8d4-518c-589f-8642-1e9a2b534d82'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, '1e24d947-b929-4a1b-a069-d5b1d1136baa'::uuid, E'शिक्षा मनोविज्ञान (विश्लेषणात्मक तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '1e24d947-b929-4a1b-a069-d5b1d1136baa'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "शिक्षा मनोविज्ञान (आधारभूत तह)" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := 'a47b19cf-38a4-57a1-b8d9-2e1c5f3964d1'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, '1e24d947-b929-4a1b-a069-d5b1d1136baa'::uuid, E'शिक्षा मनोविज्ञान (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '1e24d947-b929-4a1b-a069-d5b1d1136baa'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "वंशानुगत गुण, वातावरण र पठारको प्रभाव" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := '647c69b7-f195-5171-a78d-f45711f871b2'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, '7848483a-8a9e-4c87-be7f-4506b0fd8fc3'::uuid, E'वंशानुगत गुण, वातावरण र पठारको प्रभाव', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '7848483a-8a9e-4c87-be7f-4506b0fd8fc3'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "मानव विकास: वृद्धि र विकासको अवधारणा" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := '628ed9bc-2be1-5266-a7d2-f260e2a8faa6'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, '7848483a-8a9e-4c87-be7f-4506b0fd8fc3'::uuid, E'मानव विकास: वृद्धि र विकासको अवधारणा', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '7848483a-8a9e-4c87-be7f-4506b0fd8fc3'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "मानव विकास: वृद्धि र विकासको अवधारणा, चरण र विशेषता - थप अभ्यास 1" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := '655f8ae5-a85e-595e-9ad7-b65231d883d5'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, '7848483a-8a9e-4c87-be7f-4506b0fd8fc3'::uuid, E'मानव विकास: वृद्धि र विकासको अवधारणा, चरण र विशेषता - थप अभ्यास 1', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '7848483a-8a9e-4c87-be7f-4506b0fd8fc3'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "मानव विकासका चरणहरू र विकासात्मक कार्यहरू" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := '77ea5267-045d-5564-9cca-e6aea39a5b2a'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, '7848483a-8a9e-4c87-be7f-4506b0fd8fc3'::uuid, E'मानव विकासका चरणहरू र विकासात्मक कार्यहरू', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '7848483a-8a9e-4c87-be7f-4506b0fd8fc3'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "मानव विकास: वृद्धि र विकासको अवधारणा, चरण र विशेषता - थप अभ्यास 2" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := '075397fa-f50c-5e5a-b35b-06efdb19abb5'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, '7848483a-8a9e-4c87-be7f-4506b0fd8fc3'::uuid, E'मानव विकास: वृद्धि र विकासको अवधारणा, चरण र विशेषता - थप अभ्यास 2', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '7848483a-8a9e-4c87-be7f-4506b0fd8fc3'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "उत्तर बाल्यावस्थाका विशेषता र विकासात्मक कार्य" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := 'dd9676a2-f511-5870-a043-fca1646a8335'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, '6a970980-5fed-4972-8f57-7c582f7ffd42'::uuid, E'उत्तर बाल्यावस्थाका विशेषता र विकासात्मक कार्य', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '6a970980-5fed-4972-8f57-7c582f7ffd42'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "उत्तर बाल्यावस्थाका बालबालिकाको सामाजिकीकरण" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := '0473e5aa-f4fa-51e8-8dff-d91338fef8c7'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, '661d6789-8b81-466c-83c6-41bc38ed8df3'::uuid, E'उत्तर बाल्यावस्थाका बालबालिकाको सामाजिकीकरण', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '661d6789-8b81-466c-83c6-41bc38ed8df3'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  RAISE NOTICE 'Topic 2 Ingestion Complete.';
END $$;
