-- Migration for Topic 3 Ingestion
-- Generated deterministically. Idempotent.
DO $$
DECLARE
  v_module_id uuid := '6695669a-f40e-421a-a4ec-b09bbeaf56c4'::uuid;
  v_topic_id uuid := '4752098a-e0df-497d-a58a-61d08d4c6814'::uuid;
  v_set_id uuid;
  v_q_id uuid;
  v_jq_id uuid;
BEGIN
  RAISE NOTICE 'Starting migration for Topic 3...';

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "सिकाइको परिचय, अर्थ र विविध स्वरुप" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := '30af12e4-729b-5bb5-b62f-758263eee2a0'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, '1321484b-4aed-477a-8d70-b5d735dedd94'::uuid, E'सिकाइको परिचय, अर्थ र विविध स्वरुप', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '1321484b-4aed-477a-8d70-b5d735dedd94'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "सिकाइमा परिपक्वता, प्रेरणा र ध्यानको प्रभाव" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := '6e8dac4d-79fa-5b12-bc18-e5834d305c09'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, '1321484b-4aed-477a-8d70-b5d735dedd94'::uuid, E'सिकाइमा परिपक्वता, प्रेरणा र ध्यानको प्रभाव', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '1321484b-4aed-477a-8d70-b5d735dedd94'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "सिकाइ प्रक्रिया र सिकाइका सिद्धान्तहरू (विश्लेषणात्मक तह)" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := 'a69c0d29-61ab-5dcd-88fb-1092efd72378'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, '1321484b-4aed-477a-8d70-b5d735dedd94'::uuid, E'सिकाइ प्रक्रिया र सिकाइका सिद्धान्तहरू (विश्लेषणात्मक तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '1321484b-4aed-477a-8d70-b5d735dedd94'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "सिकाइ प्रक्रिया र सिकाइका सिद्धान्तहरू (आधारभूत तह)" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := 'f2524d77-d4f1-5ab6-9c4c-7c093a6ad0e3'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, '1321484b-4aed-477a-8d70-b5d735dedd94'::uuid, E'सिकाइ प्रक्रिया र सिकाइका सिद्धान्तहरू (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '1321484b-4aed-477a-8d70-b5d735dedd94'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "सिकाइको स्थानान्तरण र यसका सिद्धान्तहरू" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := 'b21c5c7f-4465-589e-84e0-fc7c1d0453f8'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, '3a6a4d23-5a26-4387-bfff-8a6deb23a094'::uuid, E'सिकाइको स्थानान्तरण र यसका सिद्धान्तहरू', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '3a6a4d23-5a26-4387-bfff-8a6deb23a094'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "विद्यार्थीहरूमा उत्प्रेरणा जगाउने उपाय र विधिहरू" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := '45bf0539-a02b-5593-a0f8-4c84183a7735'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, 'db64ad8c-e9dd-4724-bb89-02d5ffd9d705'::uuid, E'विद्यार्थीहरूमा उत्प्रेरणा जगाउने उपाय र विधिहरू', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'db64ad8c-e9dd-4724-bb89-02d5ffd9d705'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "उत्प्रेरणाको अवधारणा र आवश्यकता" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := 'ec692526-72f6-55db-8fe2-da6a6ff59005'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, 'db64ad8c-e9dd-4724-bb89-02d5ffd9d705'::uuid, E'उत्प्रेरणाको अवधारणा र आवश्यकता', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'db64ad8c-e9dd-4724-bb89-02d5ffd9d705'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "पुनर्बलको अवधारणा र यसका प्रकारहरू" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := '23448907-7f49-5c5f-bb14-a764a0af9c2d'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, 'dd368be9-e6a9-496b-903a-374891ecc38f'::uuid, E'पुनर्बलको अवधारणा र यसका प्रकारहरू', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'dd368be9-e6a9-496b-903a-374891ecc38f'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  RAISE NOTICE 'Topic 3 Ingestion Complete.';
END $$;
