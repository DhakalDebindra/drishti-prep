-- Migration for Topic 9 Ingestion
-- Generated deterministically. Idempotent.
DO $$
DECLARE
  v_module_id uuid := '6695669a-f40e-421a-a4ec-b09bbeaf56c4'::uuid;
  v_topic_id uuid := 'f7ab6c7c-21c8-4214-baf0-ec92ef9ac5d9'::uuid;
  v_set_id uuid;
  v_q_id uuid;
  v_jq_id uuid;
BEGIN
  RAISE NOTICE 'Starting migration for Topic 9...';

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "शिक्षक पेशागत विकास (TPD) को प्रारुप" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := '495ef6f9-c5b5-5ca2-859d-830a10c5acb0'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, '5031ae33-4e11-461b-aa7a-d2670e908b30'::uuid, E'शिक्षक पेशागत विकास (TPD) को प्रारुप', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '5031ae33-4e11-461b-aa7a-d2670e908b30'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "शिक्षक तालिम र प्रमाणीकरण तालिम" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := '0f606472-a944-5a2f-be55-87ea53be06a2'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, '5031ae33-4e11-461b-aa7a-d2670e908b30'::uuid, E'शिक्षक तालिम र प्रमाणीकरण तालिम', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '5031ae33-4e11-461b-aa7a-d2670e908b30'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "शैक्षिक अनुसन्धानको अर्थ, क्षेत्र र आवश्यकता" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := 'e03659e3-c937-5910-b392-a26437864aa0'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, 'aaa2cd91-88d2-432e-807a-a64e22cbdc51'::uuid, E'शैक्षिक अनुसन्धानको अर्थ, क्षेत्र र आवश्यकता', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'aaa2cd91-88d2-432e-807a-a64e22cbdc51'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: "घटना अध्ययन र कार्यमूलक अनुसन्धानको परिचय" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := '3012fed6-376c-53af-b7b3-f502e7ea81dd'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, 'a483ac23-07f8-470a-ac94-2e72f60f9d81'::uuid, E'घटना अध्ययन र कार्यमूलक अनुसन्धानको परिचय', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'a483ac23-07f8-470a-ac94-2e72f60f9d81'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  -- ────────────────────────────────────────────────────────────────────────────
  -- Set: " कार्यमूलक अनुसन्धानको उद्देश्य र प्रयोग" (Existing)
  -- ────────────────────────────────────────────────────────────────────────────
  v_set_id := 'e33cc9e3-acce-5cce-bcf5-a4809b5cca67'::uuid;

  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, v_topic_id, 'a483ac23-07f8-470a-ac94-2e72f60f9d81'::uuid, E' कार्यमूलक अनुसन्धानको उद्देश्य र प्रयोग', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET is_verified = true;

  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'a483ac23-07f8-470a-ac94-2e72f60f9d81'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  RAISE NOTICE 'Topic 9 Ingestion Complete.';
END $$;
