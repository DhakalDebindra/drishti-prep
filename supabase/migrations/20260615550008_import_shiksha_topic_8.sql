-- Migration for Topic 8 Ingestion
-- Generated deterministically. Idempotent.
DO $$
DECLARE
  v_module_id uuid := '6695669a-f40e-421a-a4ec-b09bbeaf56c4'::uuid;
  v_topic_id uuid := '060fd749-1aa6-4771-b4b3-db5eafd0ef97'::uuid;
  v_set_id uuid;
  v_q_id uuid;
  v_jq_id uuid;
BEGIN
  RAISE NOTICE 'Starting migration for Topic 8...';

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "कक्षाकोठा व्यवस्थापनको अवधारणा र महत्त्व" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := 'd82f5bdd-d848-53d2-b06e-5d09e7e9ab19'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, '78cc19b3-711d-41e8-ad52-82ce09d996c2'::uuid, E'कक्षाकोठा व्यवस्थापनको अवधारणा र महत्त्व', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '78cc19b3-711d-41e8-ad52-82ce09d996c2'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "कक्षाकोठामा विविधता व्यवस्थापनका उपायहरू" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := '7a6e0765-d141-5206-937c-54cbf05a7b30'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, 'e5cf55e9-7d6b-430a-a348-a96385884d42'::uuid, E'कक्षाकोठामा विविधता व्यवस्थापनका उपायहरू', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'e5cf55e9-7d6b-430a-a348-a96385884d42'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "शैक्षणिक संगठन: कक्षा शिक्षण र विषय शिक्षण" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := 'e51dabeb-d5e1-5872-a4ef-d054e2e15515'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, 'ff890dbb-ffda-4f02-8111-ee66c3964d76'::uuid, E'शैक्षणिक संगठन: कक्षा शिक्षण र विषय शिक्षण', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'ff890dbb-ffda-4f02-8111-ee66c3964d76'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "बहुकक्षा शिक्षण र मिश्रित शिक्षणको प्रयोग" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := '1888bced-1cc2-5b02-a054-1ea96bcf30ad'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, 'ff890dbb-ffda-4f02-8111-ee66c3964d76'::uuid, E'बहुकक्षा शिक्षण र मिश्रित शिक्षणको प्रयोग', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'ff890dbb-ffda-4f02-8111-ee66c3964d76'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "विद्यालयमा द्वन्द्व व्यवस्थापन र समाधानका उपायहरू" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := '569099be-b398-5ea6-8b97-2acc55f3d70a'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, '586f5768-b479-4427-b2c8-22a19aa8d491'::uuid, E'विद्यालयमा द्वन्द्व व्यवस्थापन र समाधानका उपायहरू', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '586f5768-b479-4427-b2c8-22a19aa8d491'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  RAISE NOTICE 'Topic 8 Ingestion Complete.';
END $$;
