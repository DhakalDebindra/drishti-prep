-- Idempotent UPSERT import: निमावि प्रथम पत्र — ङ-३ स्थानिक तथा प्रत्यक्षात्मक क्षमता (spatial-1 Coding-Decoding only; spatial-2/3/4 pending richer source/image support)
-- Override same-identity sets/questions; never deletes. Generated 2026-07-05T12:24:40.244Z.
DO $$
DECLARE
  v_module_id uuid := '6695669a-f40e-421a-a4ec-b09bbeaf56c4'::uuid;
  v_set_id uuid;
  v_q_id uuid;
BEGIN

  -- Set: स्थानिक तथा प्रत्यक्षात्मक क्षमताः Coding-Decoding (आधारभूत तह) (3 Q)
  v_set_id := extensions.uuid_generate_v5('83123770-9e69-4d49-b231-b112c95d2692'::uuid, E'स्थानिक तथा प्रत्यक्षात्मक क्षमताः Coding-Decoding (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '69c87a98-20d9-4fd7-a596-37eaa6fdc55b'::uuid, '83123770-9e69-4d49-b231-b112c95d2692'::uuid, E'स्थानिक तथा प्रत्यक्षात्मक क्षमताः Coding-Decoding (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '83123770-9e69-4d49-b231-b112c95d2692'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि एउटा कोडमा CAT = 24, RAT = 39 हुन्छ भने SWAN को कोड कति हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'यदि एउटा कोडमा CAT = 24, RAT = 39 हुन्छ भने SWAN को कोड कति हुन्छ?', E'57', E'56', E'58', E'59', E'A', E'**यहाँ कोड भनेको शब्दका अक्षरहरूको वर्णमाला-स्थान (A=1,B=2...) को योग हो — CAT: C(3)+A(1)+T(20)=24 ✓, RAT: R(18)+A(1)+T(20)=39 ✓। SWAN: S(19)+W(23)+A(1)+N(14)=57 हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि एउटा कोडमा CAT = 24, RAT = 39 हुन्छ भने SWAN को कोड कति हुन्छ?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि कोडभाषामा SWEET लाई TXFFU लेखिन्छ भने सोही नियम अनुसार BITTER लाई के लेखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'यदि कोडभाषामा SWEET लाई TXFFU लेखिन्छ भने सोही नियम अनुसार BITTER लाई के लेखिन्छ?', E'CIUUFS', E'CJUUFS', E'CJTUFS', E'BJUUFS', E'B', E'**यहाँ नियम भनेको हरेक अक्षरलाई वर्णमालामा एक स्थान अगाडि सार्नु हो (S→T, W→X, E→F, T→U)। BITTER लाई सोही नियम लागू गर्दा B→C, I→J, T→U, T→U, E→F, R→S = CJUUFS हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि कोडभाषामा SWEET लाई TXFFU लेखिन्छ भने सोही नियम अनुसार BITTER लाई के लेखिन्छ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'यदि TIGER को कोड 2/3, BUFFALO को कोड 3/4, र CROCODILE को कोड 4/5 हुन्छ भने ELEPHANT को कोड कति हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'यदि TIGER को कोड 2/3, BUFFALO को कोड 3/4, र CROCODILE को कोड 4/5 हुन्छ भने ELEPHANT को कोड कति हुन्छ?', E'5/6', E'3/8', E'3/5', E'4/7', E'C', E'**यहाँ कोड भनेको शब्दमा भएका स्वर वर्ण (Vowel) र व्यञ्जन वर्ण (Consonant) को अनुपात हो — TIGER मा 2 स्वर/3 व्यञ्जन, BUFFALO मा 3 स्वर/4 व्यञ्जन। ELEPHANT (E,L,E,P,H,A,N,T) मा 3 स्वर (E,E,A) र 5 व्यञ्जन (L,P,H,N,T) छन्, त्यसैले कोड 3/5 हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:यदि TIGER को कोड 2/3, BUFFALO को कोड 3/4, र CROCODILE को कोड 4/5 हुन्छ भने ELEPHANT को कोड कति हुन्छ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  RAISE NOTICE 'ङ-३ spatial-1 upsert complete: 1 sets, 3 questions.';
END $$;
