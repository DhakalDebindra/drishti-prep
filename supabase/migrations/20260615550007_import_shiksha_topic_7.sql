-- Migration for Topic 7 Ingestion
-- Generated deterministically. Idempotent.
DO $$
DECLARE
  v_module_id uuid := '6695669a-f40e-421a-a4ec-b09bbeaf56c4'::uuid;
  v_topic_id uuid := '33e33b97-b080-4e2e-9c20-198b6cba350b'::uuid;
  v_set_id uuid;
  v_q_id uuid;
  v_jq_id uuid;
BEGIN
  RAISE NOTICE 'Starting migration for Topic 7...';

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "मापन र मूल्याङ्कनको परिचय र भिन्नता" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := '9ec8af5f-da5b-596f-81af-1c2ec9992e15'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, '529c541d-c7b9-4af8-874e-7623be4b9b80'::uuid, E'मापन र मूल्याङ्कनको परिचय र भिन्नता', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '529c541d-c7b9-4af8-874e-7623be4b9b80'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "परीक्षाको अर्थ, महत्त्व र प्रकारहरू" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := 'cddbba9f-2bf4-5fe2-8d4d-e86d520b8fe0'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, '8b858502-60a4-4e5b-a411-3ad13deec9dd'::uuid, E'परीक्षाको अर्थ, महत्त्व र प्रकारहरू', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '8b858502-60a4-4e5b-a411-3ad13deec9dd'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "प्रश्नपत्र निर्माण र विशिष्टिकरण तालिका" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := '8f9a6edb-761d-586f-aba3-eef1a45c91dd'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, '13fd152a-d851-41bb-81f2-a8278052af6f'::uuid, E'प्रश्नपत्र निर्माण र विशिष्टिकरण तालिका', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '13fd152a-d851-41bb-81f2-a8278052af6f'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "प्रश्नहरूको विश्लेषण र वैधता मापन" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := '2a7ee6a4-c6ad-5025-9c77-df69b3a10b97'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, '13fd152a-d851-41bb-81f2-a8278052af6f'::uuid, E'प्रश्नहरूको विश्लेषण र वैधता मापन', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '13fd152a-d851-41bb-81f2-a8278052af6f'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "लेटर ग्रेडिङ निर्देशिका र कार्यान्वयनको अवस्था" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := 'f605c060-0cfe-575b-a486-09f46dd519a6'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, '47b7b17e-774a-4b15-8720-aa233edf30f8'::uuid, E'लेटर ग्रेडिङ निर्देशिका र कार्यान्वयनको अवस्था', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '47b7b17e-774a-4b15-8720-aa233edf30f8'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "निरन्तर मूल्याङ्कन प्रणाली र अक्षराङ्कन पद्धति" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := '2483b454-825d-5366-95a0-af348492d8bc'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, '47b7b17e-774a-4b15-8720-aa233edf30f8'::uuid, E'निरन्तर मूल्याङ्कन प्रणाली र अक्षराङ्कन पद्धति', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '47b7b17e-774a-4b15-8720-aa233edf30f8'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  RAISE NOTICE 'Topic 7 Ingestion Complete.';
END $$;
