-- Idempotent UPSERT import: निमावि प्रथम पत्र — unit ख-५ पाठ्यक्रम तथा पाठ्यपुस्तक
-- Adds Level I sets alongside preserved model sets. Override same-identity; never deletes. Generated 2026-07-01T14:32:13.735Z.
DO $$
DECLARE
  v_module_id uuid := '6695669a-f40e-421a-a4ec-b09bbeaf56c4'::uuid;
  v_set_id uuid;
  v_q_id uuid;
BEGIN

  -- Set: पाठ्यक्रमको अर्थ र परिभाषा (आधारभूत तह) (14 Q)
  v_set_id := extensions.uuid_generate_v5('208f57ad-5caf-48df-8c09-dbaf55a84caf'::uuid, E'पाठ्यक्रमको अर्थ र परिभाषा (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '2d308800-85c4-4945-b7b2-3b2ac8831074'::uuid, '208f57ad-5caf-48df-8c09-dbaf55a84caf'::uuid, E'पाठ्यक्रमको अर्थ र परिभाषा (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '208f57ad-5caf-48df-8c09-dbaf55a84caf'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'"Curriculum" शब्दको सर्वप्रथम प्रयोग गर्ने विद्वान को हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'"Curriculum" शब्दको सर्वप्रथम प्रयोग गर्ने विद्वान को हुन्?', E'राल्फ डब्लु टायलर', E'फ्रैंकलिन बबिट', E'हिल्डा टावा', E'डी.के. व्हीलर', E'B', E'**"Curriculum" शब्दको सर्वप्रथम प्रयोग फ्रैंकलिन बबिटले सन् १९१८ मा गरेका थिए।**\\n- राल्फ डब्लु टायलरलाई पाठ्यक्रमका पिता (Father of Curriculum) मानिन्छ।\\n- हिल्डा टावाले पाठ्यक्रमलाई अपेक्षित उपलब्धि हासिल गर्ने सम्पूर्ण प्रयासका रूपमा परिभाषित गरेकी छन्।\\n- डी.के. व्हीलरले पाठ्यक्रम विकासको चक्रीय नमूना (Cyclical Model) प्रस्तुत गरेका थिए।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:"Curriculum" शब्दको सर्वप्रथम प्रयोग गर्ने विद्वान को हुन्?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पाठ्यक्रमका पिता (Father of Curriculum) भनेर कसलाई चिनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'पाठ्यक्रमका पिता (Father of Curriculum) भनेर कसलाई चिनिन्छ?', E'फ्रैंकलिन बबिट', E'राल्फ डब्लु टायलर', E'हिल्डा टावा', E'डी.के. व्हीलर', E'B', E'**राल्फ डब्लु टायलरलाई पाठ्यक्रमका पिता (Father of Curriculum) मानिन्छ।**\\n- फ्रैंकलिन बबिटले सन् १९१८ मा सर्वप्रथम Curriculum शब्दको प्रयोग गरेका थिए।\\n- हिल्डा टावाले ग्रासरुट (तल्लो तहबाट माथि जाने) नमूना प्रस्तुत गरेकी छन्।\\n- डी.के. व्हीलरले चक्रीय नमूना प्रस्तुत गरेका थिए।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पाठ्यक्रमका पिता (Father of Curriculum) भनेर कसलाई चिनिन्छ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'"पाठ्यक्रम भनेको अपेक्षित उपलब्धि प्राप्त गर्नका लागि गरिने सम्पूर्ण प्रयास हो" भनी कसले परिभाषित गरेकी छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'"पाठ्यक्रम भनेको अपेक्षित उपलब्धि प्राप्त गर्नका लागि गरिने सम्पूर्ण प्रयास हो" भनी कसले परिभाषित गरेकी छन्?', E'हिल्डा टावा', E'टान्नर', E'नाग्ले र इभन्स', E'रोवर्ट उलिच', E'A', E'**हिल्डा टावाले पाठ्यक्रमलाई अपेक्षित उपलब्धि प्राप्त गर्न गरिने सम्पूर्ण प्रयासका रूपमा परिभाषित गरेकी छन्।**\\n- टान्नरले पाठ्यक्रमलाई विद्यालयमा गरिने सम्पूर्ण योजनाबद्ध अनुभवका रूपमा परिभाषित गरेका छन्।\\n- नाग्ले र इभन्सले पाठ्यक्रमलाई मानव जातिको सम्पूर्ण ज्ञान तथा अनुभवको सार भनेका छन्।\\n- रोवर्ट उलिचले पाठ्यक्रमलाई धावन मार्ग (Race Course) सँग तुलना गरेका छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:"पाठ्यक्रम भनेको अपेक्षित उपलब्धि प्राप्त गर्नका लागि गरिने सम्पूर्ण प्रयास हो" भनी कसले परिभाषित गरेकी छन्?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पाठ्यक्रमलाई "धावन मार्ग (Race Course)" सँग तुलना गर्दै व्यक्तिले निश्चित उद्देश्य प्राप्त गर्न त्यसमा दौडने कुरा कसले भनेका छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'पाठ्यक्रमलाई "धावन मार्ग (Race Course)" सँग तुलना गर्दै व्यक्तिले निश्चित उद्देश्य प्राप्त गर्न त्यसमा दौडने कुरा कसले भनेका छन्?', E'वेर्रेट चार्टर्स', E'रोवर्ट उलिच', E'टान्नर', E'मोसे', E'B', E'**रोवर्ट उलिचले पाठ्यक्रमलाई धावन मार्ग (Race Course) भनी परिभाषित गरेका छन्, जहाँ व्यक्ति निश्चित उद्देश्य प्राप्त गर्न दौडिन्छ।**\\n- वेर्रेट चार्टर्सले पाठ्यक्रमलाई एउटा विज्ञान (Science) भनेका छन्।\\n- टान्नरले पाठ्यक्रमलाई विद्यालयमा गरिने सम्पूर्ण योजनाबद्ध अनुभवका रूपमा परिभाषित गरेका छन्।\\n- मोसेले पाठ्यक्रमलाई विद्यालयको निर्देशनभित्र रहेर सिकारुले प्राप्त गर्ने सम्पूर्ण अनुभव भनेका छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पाठ्यक्रमलाई "धावन मार्ग (Race Course)" सँग तुलना गर्दै व्यक्तिले निश्चित उद्देश्य प्राप्त गर्न त्यसमा दौडने कुरा कसले भनेका छन्?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पाठ्यक्रमलाई "एउटा विज्ञान (Science)" हो भनी कसले परिभाषित गरेका छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'पाठ्यक्रमलाई "एउटा विज्ञान (Science)" हो भनी कसले परिभाषित गरेका छन्?', E'वेर्रेट चार्टर्स', E'राल्फ डब्लु टायलर', E'युनेस्को', E'मोसे', E'A', E'**वेर्रेट चार्टर्सले पाठ्यक्रमलाई एउटा विज्ञान (Science) हो भनी परिभाषित गरेका छन्।**\\n- राल्फ डब्लु टायलरलाई पाठ्यक्रमका पिता मानिन्छ।\\n- युनेस्कोका अनुसार पाठ्यक्रम भनेको विद्यालयद्वारा योजनाबद्ध र निर्देशित विद्यार्थीका सम्पूर्ण क्रियाकलाप हो।\\n- मोसेले पाठ्यक्रमलाई सिकारुले प्राप्त गर्ने सम्पूर्ण अनुभव भनेका छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पाठ्यक्रमलाई "एउटा विज्ञान (Science)" हो भनी कसले परिभाषित गरेका छन्?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'युनेस्कोका अनुसार पाठ्यक्रम भनेको के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'युनेस्कोका अनुसार पाठ्यक्रम भनेको के हो?', E'शिक्षकले पढाउने विषयवस्तुको क्रमबद्ध सूची', E'विद्यालयद्वारा योजनाबद्ध र निर्देशित विद्यार्थीका सम्पूर्ण क्रियाकलाप', E'मानव जातिको सम्पूर्ण ज्ञान तथा अनुभवको सार', E'धावन मार्ग', E'B', E'**युनेस्कोका अनुसार पाठ्यक्रम भनेको विद्यालयद्वारा योजनाबद्ध र निर्देशित विद्यार्थीका सम्पूर्ण क्रियाकलाप हो।**\\n- शिक्षकले पढाउने विषयवस्तुको क्रमबद्ध सूची भनेको पाठ्यक्रमको संकुचित अर्थ हो।\\n- मानव जातिको सम्पूर्ण ज्ञान तथा अनुभवको सार भनी नाग्ले र इभन्सले परिभाषित गरेका छन्।\\n- धावन मार्ग भनी रोवर्ट उलिचले परिभाषित गरेका छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:युनेस्कोका अनुसार पाठ्यक्रम भनेको के हो?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'राष्ट्रिय शिक्षा पद्धति योजना (रा.शि.प.यो.), २०२८ अनुसार पाठ्यक्रम भनेको के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'राष्ट्रिय शिक्षा पद्धति योजना (रा.शि.प.यो.), २०२८ अनुसार पाठ्यक्रम भनेको के हो?', E'विद्यालय तथा शिक्षकद्वारा विद्यार्थीका लागि तयार गरिएको योजना र निर्देशन अनुसारको सम्पूर्ण अनुभव', E'एउटा विज्ञान', E'धावन मार्ग', E'मानव जातिको सम्पूर्ण ज्ञानको सार', E'A', E'**रा.शि.प.यो., २०२८ अनुसार पाठ्यक्रम भनेको विद्यालय तथा शिक्षकद्वारा विद्यार्थीका लागि तयार गरिएको योजना र निर्देशन अनुसारको सम्पूर्ण अनुभव हो।**\\n- वेर्रेट चार्टर्सले पाठ्यक्रमलाई एउटा विज्ञान भनेका छन्।\\n- रोवर्ट उलिचले पाठ्यक्रमलाई धावन मार्ग भनेका छन्।\\n- नाग्ले र इभन्सले पाठ्यक्रमलाई मानव जातिको सम्पूर्ण ज्ञानको सार भनेका छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:राष्ट्रिय शिक्षा पद्धति योजना (रा.शि.प.यो.), २०२८ अनुसार पाठ्यक्रम भनेको के हो?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'मोसेका अनुसार पाठ्यक्रम भनेको के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'मोसेका अनुसार पाठ्यक्रम भनेको के हो?', E'विद्यालयको निर्देशनभित्र रहेर सिकारुले प्राप्त गर्ने सम्पूर्ण अनुभव', E'शिक्षकले पढाउने विषयवस्तुको क्रमबद्ध सूची', E'सर्वाङ्गीण विकासका लागि आवश्यक अनुभवको उपयुक्त संगठन', E'एउटा विज्ञान', E'A', E'**मोसेका अनुसार पाठ्यक्रम भनेको विद्यालयको निर्देशनभित्र रहेर सिकारुले प्राप्त गर्ने सम्पूर्ण अनुभव हो।**\\n- शिक्षकले पढाउने विषयवस्तुको क्रमबद्ध सूची पाठ्यक्रमको संकुचित अर्थ हो।\\n- सर्वाङ्गीण विकासका लागि आवश्यक अनुभवको उपयुक्त संगठन पाठ्यक्रमको व्यापक अर्थ हो।\\n- वेर्रेट चार्टर्सले पाठ्यक्रमलाई विज्ञान भनेका छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:मोसेका अनुसार पाठ्यक्रम भनेको के हो?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पाठ्यक्रमको संकुचित अर्थ के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'पाठ्यक्रमको संकुचित अर्थ के हो?', E'सर्वाङ्गीण विकासका लागि आवश्यक अनुभव र व्यावहारिक ज्ञानको उपयुक्त संगठन', E'एक शैक्षिक अवधिमा शिक्षकले पढाउने विषयवस्तु वा पाठ्यांशको क्रमबद्ध सूची', E'मानव जातिको सम्पूर्ण ज्ञानको सार', E'धावन मार्ग', E'B', E'**पाठ्यक्रमको संकुचित अर्थ भनेको एक शैक्षिक अवधिमा शिक्षकले पढाउने विषयवस्तु वा पाठ्यांशको क्रमबद्ध सूची हो।**\\n- यसको ठीक विपरीत, व्यापक अर्थमा पाठ्यक्रमलाई सर्वाङ्गीण विकासका लागि आवश्यक अनुभव र व्यावहारिक ज्ञानको उपयुक्त संगठन मानिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पाठ्यक्रमको संकुचित अर्थ के हो?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पाठ्यक्रमको व्यापक अर्थ के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'पाठ्यक्रमको व्यापक अर्थ के हो?', E'शिक्षकले पढाउने विषयवस्तुको क्रमबद्ध सूची', E'सर्वाङ्गीण विकासका लागि आवश्यक अनुभव र व्यावहारिक ज्ञानको उपयुक्त संगठन', E'धावन मार्ग', E'एउटा विज्ञान', E'B', E'**पाठ्यक्रमको व्यापक अर्थ भनेको विद्यार्थीको सर्वाङ्गीण विकासका लागि आवश्यक अनुभव र व्यावहारिक ज्ञानको उपयुक्त संगठन हो।**\\n- यसको विपरीत, संकुचित अर्थमा पाठ्यक्रमलाई एक शैक्षिक अवधिमा शिक्षकले पढाउने विषयवस्तुको क्रमबद्ध सूची मात्र मानिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पाठ्यक्रमको व्यापक अर्थ के हो?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पाठ्यक्रम विकास केन्द्र (Curriculum Development Centre) को मुख्य कार्य के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'पाठ्यक्रम विकास केन्द्र (Curriculum Development Centre) को मुख्य कार्य के हो?', E'शिक्षक तालिम सञ्चालन गर्नु', E'पाठ्यक्रम, पाठ्यपुस्तक तथा अन्य शैक्षणिक सामग्रीको विकास, परिमार्जन र सुधार गरी शिक्षाको राष्ट्रिय उद्देश्य प्राप्तिमा सहयोग गर्नु', E'विद्यालय भवन निर्माण गर्नु', E'शिक्षक दरबन्दी विनियोजन गर्नु', E'B', E'**पाठ्यक्रम विकास केन्द्रको मुख्य कार्य पाठ्यक्रम, पाठ्यपुस्तक तथा अन्य शैक्षणिक सामग्रीको विकास, परिमार्जन र सुधार गरी शिक्षाको राष्ट्रिय उद्देश्य प्राप्तिमा सहयोग पुर्‍याउनु हो।**\\n- शिक्षक तालिम सञ्चालन शिक्षा तालिम केन्द्रको कार्यक्षेत्र हो।\\nनोट: पाठ्यक्रम विकास केन्द्र (CDC) शिक्षा, विज्ञान तथा प्रविधि मन्त्रालय अन्तर्गतको निकाय हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पाठ्यक्रम विकास केन्द्र (Curriculum Development Centre) को मुख्य कार्य के हो?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'संकुचित शिक्षा (Narrow Education) को मुख्य उद्देश्य र स्रोत के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'संकुचित शिक्षा (Narrow Education) को मुख्य उद्देश्य र स्रोत के हो?', E'जीवन जिउन सिकाउनु; सम्पूर्ण समाज र अनुभव', E'शैक्षिक उपाधि वा प्रमाणपत्र प्राप्त गर्नु; शिक्षक र पाठ्यपुस्तक', E'चरित्र निर्माण गर्नु; परिवार', E'सीप विकास गर्नु; समुदाय', E'B', E'**संकुचित शिक्षाको मुख्य उद्देश्य शैक्षिक उपाधि वा प्रमाणपत्र प्राप्त गर्नु हो, र यसको स्रोत शिक्षक र पाठ्यपुस्तक हुन्।**\\n- व्यापक शिक्षाको उद्देश्य जीवन जिउन सिकाउनु हो र यसको स्रोत सम्पूर्ण समाज र अनुभव हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:संकुचित शिक्षा (Narrow Education) को मुख्य उद्देश्य र स्रोत के हो?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'टान्नरका अनुसार पाठ्यक्रम भनेको के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'टान्नरका अनुसार पाठ्यक्रम भनेको के हो?', E'विद्यालयमा गरिने सम्पूर्ण योजनाबद्ध अनुभवहरू', E'एउटा विज्ञान', E'धावन मार्ग', E'मानव जातिको सम्पूर्ण ज्ञानको सार', E'A', E'**टान्नरका अनुसार पाठ्यक्रम भनेको विद्यालयमा गरिने सम्पूर्ण योजनाबद्ध अनुभवहरू हुन्।**\\n- वेर्रेट चार्टर्सले पाठ्यक्रमलाई विज्ञान भनेका छन्।\\n- रोवर्ट उलिचले पाठ्यक्रमलाई धावन मार्ग भनेका छन्।\\n- नाग्ले र इभन्सले पाठ्यक्रमलाई मानव जातिको सम्पूर्ण ज्ञानको सार भनेका छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:टान्नरका अनुसार पाठ्यक्रम भनेको के हो?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नाग्ले र इभन्सका अनुसार पाठ्यक्रम भनेको के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'नाग्ले र इभन्सका अनुसार पाठ्यक्रम भनेको के हो?', E'एउटा विज्ञान', E'मानव जातिको सम्पूर्ण ज्ञान तथा अनुभवहरूको सार', E'धावन मार्ग', E'अपेक्षित उपलब्धि प्राप्त गर्ने प्रयास', E'B', E'**नाग्ले र इभन्सका अनुसार पाठ्यक्रम भनेको मानव जातिको सम्पूर्ण ज्ञान तथा अनुभवहरूको सार हो।**\\n- वेर्रेट चार्टर्सले पाठ्यक्रमलाई विज्ञान भनेका छन्।\\n- रोवर्ट उलिचले पाठ्यक्रमलाई धावन मार्ग भनेका छन्।\\n- हिल्डा टावाले पाठ्यक्रमलाई अपेक्षित उपलब्धि प्राप्त गर्ने प्रयास भनेकी छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नाग्ले र इभन्सका अनुसार पाठ्यक्रम भनेको के हो?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: पाठ्यक्रमका तत्त्व, उद्देश्य र नमूनाहरू (आधारभूत तह) (16 Q)
  v_set_id := extensions.uuid_generate_v5('208f57ad-5caf-48df-8c09-dbaf55a84caf'::uuid, E'पाठ्यक्रमका तत्त्व, उद्देश्य र नमूनाहरू (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '2d308800-85c4-4945-b7b2-3b2ac8831074'::uuid, '208f57ad-5caf-48df-8c09-dbaf55a84caf'::uuid, E'पाठ्यक्रमका तत्त्व, उद्देश्य र नमूनाहरू (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '208f57ad-5caf-48df-8c09-dbaf55a84caf'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पाठ्यक्रमको मार्गदर्शक (guiding) तत्त्व के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'पाठ्यक्रमको मार्गदर्शक (guiding) तत्त्व के हो?', E'विषयवस्तु', E'उद्देश्य', E'मूल्याङ्कन', E'सिकाइ अनुभव', E'B', E'**पाठ्यक्रमको मार्गदर्शक तत्त्व उद्देश्य (Objective) हो।**\\n- विषयवस्तु (Content) ले पाठ्यक्रमलाई ठोस स्वरूप दिन्छ।\\n- सिकाइ अनुभवले विद्यार्थीको व्यवहार परिवर्तन ल्याउँछ।\\n- मूल्याङ्कनले सिकाइ उपलब्धिको जाँच गर्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पाठ्यक्रमको मार्गदर्शक (guiding) तत्त्व के हो?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पाठ्यक्रमलाई ठोस स्वरूप प्रदान गर्ने तत्त्व कुन हो, जसको अनुपस्थितिमा पाठ्यक्रमले पूर्णता प्राप्त गर्दैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'पाठ्यक्रमलाई ठोस स्वरूप प्रदान गर्ने तत्त्व कुन हो, जसको अनुपस्थितिमा पाठ्यक्रमले पूर्णता प्राप्त गर्दैन?', E'उद्देश्य', E'विषयवस्तु', E'सिकाइ अनुभव', E'मूल्याङ्कन', E'B', E'**विषयवस्तु (Content) ले पाठ्यक्रमलाई ठोस स्वरूप प्रदान गर्छ; विषयवस्तुको अनुपस्थितिमा पाठ्यक्रमले पूर्णता प्राप्त गर्दैन।**\\n- उद्देश्य पाठ्यक्रमको मार्गदर्शक तत्त्व हो।\\n- सिकाइ अनुभवले विद्यार्थीमा व्यवहार परिवर्तन ल्याउँछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पाठ्यक्रमलाई ठोस स्वरूप प्रदान गर्ने तत्त्व कुन हो, जसको अनुपस्थितिमा पाठ्यक्रमले पूर्णता प्राप्त गर्दैन?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पाठ्यक्रमका उद्देश्यहरू कति तहमा विभाजित हुन्छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'पाठ्यक्रमका उद्देश्यहरू कति तहमा विभाजित हुन्छन्?', E'दुई', E'तीन', E'चार', E'पाँच', E'B', E'**पाठ्यक्रमका उद्देश्यहरू तीन तहमा विभाजित हुन्छन्।**\\n- यी तीन तह हुन्: लक्ष्य (Aim), ध्येय (Goal), र उद्देश्य (Objective)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पाठ्यक्रमका उद्देश्यहरू कति तहमा विभाजित हुन्छन्?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'औपचारिक शिक्षा (Formal Education) मा हुने तत्त्वहरू के-के हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'औपचारिक शिक्षा (Formal Education) मा हुने तत्त्वहरू के-के हुन्?', E'निश्चित पाठ्यक्रम, शिक्षण विधि, समय र स्थान', E'असंरचित समय र खुला ठाउँ मात्र', E'केवल पाठ्यपुस्तक', E'केवल शिक्षक', E'A', E'**औपचारिक शिक्षामा निश्चित पाठ्यक्रम, शिक्षण विधि, समय र स्थान हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:औपचारिक शिक्षा (Formal Education) मा हुने तत्त्वहरू के-के हुन्?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शैक्षणिक उद्देश्यको वर्गीकरण (Bloom''s Taxonomy अनुसार) कति क्षेत्रमा विभाजन गरिएको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'शैक्षणिक उद्देश्यको वर्गीकरण (Bloom''s Taxonomy अनुसार) कति क्षेत्रमा विभाजन गरिएको छ?', E'दुई', E'तीन', E'चार', E'पाँच', E'B', E'**शैक्षणिक उद्देश्यको वर्गीकरण तीन क्षेत्रमा विभाजन गरिएको छ।**\\n- यी हुन्: संज्ञानात्मक (Cognitive), भावनात्मक (Affective) र मनोक्रियात्मक (Psychomotor)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शैक्षणिक उद्देश्यको वर्गीकरण (Bloom''s Taxonomy अनुसार) कति क्षेत्रमा विभाजन गरिएको छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सिकाइ अनुभव पाठ्यक्रममा कुन उद्देश्यले समावेश गरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'सिकाइ अनुभव पाठ्यक्रममा कुन उद्देश्यले समावेश गरिन्छ?', E'विद्यार्थीको व्यवहारमा परिवर्तन ल्याउन', E'परीक्षा लिन', E'शिक्षकको कार्यभार बढाउन', E'विद्यालय भवन निर्माण गर्न', E'A', E'**सिकाइ अनुभव विद्यार्थीको व्यवहारमा परिवर्तन ल्याउने उद्देश्यले पाठ्यक्रममा समावेश गरिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सिकाइ अनुभव पाठ्यक्रममा कुन उद्देश्यले समावेश गरिन्छ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'संज्ञानात्मक क्षेत्र (Cognitive Domain) अन्तर्गत सबैभन्दा उच्च तह कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'संज्ञानात्मक क्षेत्र (Cognitive Domain) अन्तर्गत सबैभन्दा उच्च तह कुन हो?', E'ज्ञान (Knowledge)', E'बोध (Comprehension)', E'मूल्याङ्कन (Evaluation)', E'प्रयोग (Application)', E'C', E'**संज्ञानात्मक क्षेत्रमा सबैभन्दा उच्च तह मूल्याङ्कन (Evaluation) हो।**\\n- ज्ञान (Knowledge) सबैभन्दा आधारभूत तह हो।\\n- बोध (Comprehension) दोस्रो तह हो।\\n- प्रयोग (Application) तेस्रो तह हो।\\nनोट: संज्ञानात्मक क्षेत्रमा जम्मा ६ तह छन्: ज्ञान, बोध, प्रयोग, विश्लेषण, संश्लेषण र मूल्याङ्कन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:संज्ञानात्मक क्षेत्र (Cognitive Domain) अन्तर्गत सबैभन्दा उच्च तह कुन हो?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'संज्ञानात्मक क्षेत्रको सबैभन्दा आधारभूत (पहिलो) तह कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'संज्ञानात्मक क्षेत्रको सबैभन्दा आधारभूत (पहिलो) तह कुन हो?', E'बोध', E'ज्ञान', E'विश्लेषण', E'संश्लेषण', E'B', E'**संज्ञानात्मक क्षेत्रको सबैभन्दा आधारभूत तह ज्ञान (Knowledge) हो।**\\n- बोध दोस्रो तह हो।\\n- विश्लेषण चौथो तह हो।\\n- संश्लेषण पाँचौं तह हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:संज्ञानात्मक क्षेत्रको सबैभन्दा आधारभूत (पहिलो) तह कुन हो?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सिकाइ अनुभव (Learning Experience) कति प्रकारका हुन्छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'सिकाइ अनुभव (Learning Experience) कति प्रकारका हुन्छन्?', E'दुई', E'तीन', E'चार', E'पाँच', E'C', E'**सिकाइ अनुभव चार प्रकारका हुन्छन्।**\\n- यी हुन्: चिन्तन सिप विकास गर्ने, सूचना प्रदान गर्ने, रुचि विकास गर्ने, र सामाजिक प्रवृत्ति विकास गर्ने।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सिकाइ अनुभव (Learning Experience) कति प्रकारका हुन्छन्?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सिकाइ अनुभवको छनोट मुख्यतया केबाट गरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'सिकाइ अनुभवको छनोट मुख्यतया केबाट गरिन्छ?', E'उद्देश्यबाट', E'विषयवस्तुबाट', E'मूल्याङ्कनबाट', E'शिक्षण विधिबाट', E'B', E'**सिकाइ अनुभवको छनोट विषयवस्तुबाट गरिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सिकाइ अनुभवको छनोट मुख्यतया केबाट गरिन्छ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सिकाइ अनुभवको संगठन (Organization) कति प्रकारको हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'सिकाइ अनुभवको संगठन (Organization) कति प्रकारको हुन्छ?', E'एक', E'दुई', E'तीन', E'चार', E'B', E'**सिकाइ अनुभवको संगठन दुई प्रकारको हुन्छ।**\\n- यी हुन्: लम्बीय समन्वय (Vertical Integration) र समतलीय समन्वय (Horizontal Integration)।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सिकाइ अनुभवको संगठन (Organization) कति प्रकारको हुन्छ?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कक्षा ५ र कक्षा ६ को गणित विषयवस्तुबीच क्रमबद्ध तालमेल मिलाउनुलाई सिकाइ अनुभवको कुन संगठन भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'कक्षा ५ र कक्षा ६ को गणित विषयवस्तुबीच क्रमबद्ध तालमेल मिलाउनुलाई सिकाइ अनुभवको कुन संगठन भनिन्छ?', E'समतलीय समन्वय (Horizontal Integration)', E'लम्बीय समन्वय (Vertical Integration)', E'चक्रीय संगठन', E'रेखीय संगठन', E'B', E'**फरक-फरक कक्षाहरूबीच (जस्तै कक्षा ५ र ६) क्रमबद्ध तालमेल मिलाउनुलाई लम्बीय समन्वय (Vertical Integration) भनिन्छ।**\\n- समतलीय समन्वय (Horizontal Integration) मा भने एउटै कक्षाका विभिन्न विषयहरूबीच तालमेल मिलाइन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कक्षा ५ र कक्षा ६ को गणित विषयवस्तुबीच क्रमबद्ध तालमेल मिलाउनुलाई सिकाइ अनुभवको कुन संगठन भनिन्छ?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पाठ्यक्रम निर्माणको तार्किक वा रेखीय नमूना (Rational/Linear Model) का प्रवर्तक को हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'पाठ्यक्रम निर्माणको तार्किक वा रेखीय नमूना (Rational/Linear Model) का प्रवर्तक को हुन्?', E'डी.के. व्हीलर', E'डेकर वाकर र माल्कम स्किलबेक', E'राल्फ डब्लु टायलर र हिल्डा टावा', E'फ्रैंकलिन बबिट', E'C', E'**पाठ्यक्रम निर्माणको तार्किक वा रेखीय नमूना (Rational/Linear Model) का प्रवर्तक राल्फ डब्लु टायलर र हिल्डा टावा हुन्।**\\n- डी.के. व्हीलरले तार्किक नमूनाको विस्तारित रूप चक्रीय नमूना (Cyclical Model) प्रस्तुत गरे।\\n- डेकर वाकर र माल्कम स्किलबेकले गतिशील नमूना (Dynamic Model) प्रस्तुत गरे।\\nनोट: टायलर-टावाको नमूनालाई उद्देश्यात्मक नमूना पनि भनिन्छ, किनभने यसको सुरुवात नै उद्देश्यबाट हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पाठ्यक्रम निर्माणको तार्किक वा रेखीय नमूना (Rational/Linear Model) का प्रवर्तक को हुन्?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'टायलर-टावाको तार्किक नमूनालाई "उद्देश्यात्मक नमूना" पनि किन भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'टायलर-टावाको तार्किक नमूनालाई "उद्देश्यात्मक नमूना" पनि किन भनिन्छ?', E'यसको सम्पूर्ण गतिविधि उद्देश्यबाटै सुरु भई उद्देश्यमै केन्द्रित हुने भएकाले', E'यो चक्रीय भएकाले', E'यो गतिशील भएकाले', E'यसमा विषयवस्तु मात्र हुने भएकाले', E'A', E'**टायलर-टावाको तार्किक नमूनाको सम्पूर्ण गतिविधि उद्देश्यबाटै सुरु भई उद्देश्यमै केन्द्रित हुने हुनाले यसलाई "उद्देश्यात्मक नमूना" पनि भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:टायलर-टावाको तार्किक नमूनालाई "उद्देश्यात्मक नमूना" पनि किन भनिन्छ?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पाठ्यक्रम विकासको "चक्रीय नमूना (Cyclical Model)" का प्रवर्तक को हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'पाठ्यक्रम विकासको "चक्रीय नमूना (Cyclical Model)" का प्रवर्तक को हुन्?', E'राल्फ डब्लु टायलर र हिल्डा टावा', E'डी.के. व्हीलर र निकोल्स-निकोल्स', E'डेकर वाकर र माल्कम स्किलबेक', E'फ्रैंकलिन बबिट', E'B', E'**पाठ्यक्रम विकासको चक्रीय नमूना (Cyclical Model) का प्रवर्तक डी.के. व्हीलर (सन् १९६७) र अड्रे निकोल्स-एस. हावर्ड निकोल्स (सन् १९७२) हुन्।**\\n- राल्फ डब्लु टायलर र हिल्डा टावाले तार्किक/रेखीय नमूना दिए।\\n- डेकर वाकर र माल्कम स्किलबेकले गतिशील नमूना दिए।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पाठ्यक्रम विकासको "चक्रीय नमूना (Cyclical Model)" का प्रवर्तक को हुन्?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पाठ्यक्रम विकासको "गतिशील नमूना (Dynamic Model)" का प्रवर्तक को हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'पाठ्यक्रम विकासको "गतिशील नमूना (Dynamic Model)" का प्रवर्तक को हुन्?', E'डी.के. व्हीलर', E'राल्फ डब्लु टायलर', E'डेकर वाकर र माल्कम स्किलबेक', E'हिल्डा टावा', E'C', E'**पाठ्यक्रम विकासको गतिशील नमूना (Dynamic Model) का प्रवर्तक डेकर वाकर (सन् १९७१) र माल्कम स्किलबेक (सन् १९७६) हुन्।**\\n- डी.के. व्हीलरले चक्रीय नमूना दिए।\\n- राल्फ डब्लु टायलर र हिल्डा टावाले तार्किक/रेखीय नमूना दिए।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पाठ्यक्रम विकासको "गतिशील नमूना (Dynamic Model)" का प्रवर्तक को हुन्?'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: पाठ्यक्रमका प्रकार, विकासका चरण र आधारहरू (आधारभूत तह) (18 Q)
  v_set_id := extensions.uuid_generate_v5('208f57ad-5caf-48df-8c09-dbaf55a84caf'::uuid, E'पाठ्यक्रमका प्रकार, विकासका चरण र आधारहरू (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '2d308800-85c4-4945-b7b2-3b2ac8831074'::uuid, '208f57ad-5caf-48df-8c09-dbaf55a84caf'::uuid, E'पाठ्यक्रमका प्रकार, विकासका चरण र आधारहरू (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '208f57ad-5caf-48df-8c09-dbaf55a84caf'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यालयको वातावरण, मूल्य-मान्यता र अनुशासनबाट औपचारिक पाठ्यक्रम बाहिर अनजानमा हुने सिकाइलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'विद्यालयको वातावरण, मूल्य-मान्यता र अनुशासनबाट औपचारिक पाठ्यक्रम बाहिर अनजानमा हुने सिकाइलाई के भनिन्छ?', E'लुप्त पाठ्यक्रम (Hidden Curriculum)', E'विषय केन्द्रित पाठ्यक्रम', E'सिकारु केन्द्रित पाठ्यक्रम', E'मुख्य पाठ्यक्रम (Core Curriculum)', E'A', E'**विद्यालयको वातावरण, मूल्य-मान्यता र अनुशासनबाट औपचारिक पाठ्यक्रम बाहिर अनजानमा हुने सिकाइलाई लुप्त पाठ्यक्रम (Hidden Curriculum) भनिन्छ।**\\n- विषय केन्द्रित पाठ्यक्रम (Subject Centred Curriculum) मा विषयवस्तुलाई केन्द्रमा राखी शिक्षण गरिन्छ।\\n- सिकारु केन्द्रित पाठ्यक्रम (Learner Centred Curriculum) मा विद्यार्थीको आवश्यकता र रुचिलाई केन्द्रमा राखिन्छ।\\n- मुख्य पाठ्यक्रम (Core Curriculum) मा सबै विद्यार्थीका लागि अनिवार्य साझा विषयवस्तु राखिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यालयको वातावरण, मूल्य-मान्यता र अनुशासनबाट औपचारिक पाठ्यक्रम बाहिर अनजानमा हुने सिकाइलाई के भनिन्छ?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विषयवस्तुलाई केन्द्रमा राखी परम्परागत ढंगले संगठित गरिने पाठ्यक्रमलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'विषयवस्तुलाई केन्द्रमा राखी परम्परागत ढंगले संगठित गरिने पाठ्यक्रमलाई के भनिन्छ?', E'सिकारु केन्द्रित पाठ्यक्रम', E'विषय केन्द्रित पाठ्यक्रम (Subject Centred Curriculum)', E'लुप्त पाठ्यक्रम', E'समस्या केन्द्रित ढाँचा', E'B', E'**विषयवस्तुलाई केन्द्रमा राखी संगठित गरिने पाठ्यक्रमलाई विषय केन्द्रित पाठ्यक्रम (Subject Centred Curriculum) भनिन्छ।**\\n- सिकारु केन्द्रित पाठ्यक्रममा भने विद्यार्थीको आवश्यकता र रुचिलाई केन्द्रमा राखिन्छ।\\n- लुप्त पाठ्यक्रम अनजानमा हुने सिकाइ हो।\\n- समस्या केन्द्रित ढाँचामा वास्तविक जीवनका समस्यालाई आधार बनाइन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विषयवस्तुलाई केन्द्रमा राखी परम्परागत ढंगले संगठित गरिने पाठ्यक्रमलाई के भनिन्छ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यार्थीको आवश्यकता, रुचि र क्षमतालाई केन्द्रमा राखी संगठित गरिने पाठ्यक्रमलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'विद्यार्थीको आवश्यकता, रुचि र क्षमतालाई केन्द्रमा राखी संगठित गरिने पाठ्यक्रमलाई के भनिन्छ?', E'विषय केन्द्रित पाठ्यक्रम', E'लुप्त पाठ्यक्रम', E'सिकारु केन्द्रित पाठ्यक्रम (Learner Centred Curriculum)', E'मुख्य पाठ्यक्रम', E'C', E'**विद्यार्थीको आवश्यकता, रुचि र क्षमतालाई केन्द्रमा राखी संगठित गरिने पाठ्यक्रमलाई सिकारु केन्द्रित पाठ्यक्रम (Learner Centred Curriculum) भनिन्छ।**\\n- विषय केन्द्रित पाठ्यक्रममा विषयवस्तुलाई केन्द्रमा राखिन्छ।\\n- लुप्त पाठ्यक्रम अनजानमा हुने सिकाइ हो।\\n- मुख्य पाठ्यक्रम सबैका लागि अनिवार्य साझा विषयवस्तु हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यार्थीको आवश्यकता, रुचि र क्षमतालाई केन्द्रमा राखी संगठित गरिने पाठ्यक्रमलाई के भनिन्छ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै साझा विषय वा मुद्दालाई केन्द्रमा राखी विभिन्न विषयका ज्ञानलाई एकीकृत गरी पढाइने ढाँचालाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'कुनै साझा विषय वा मुद्दालाई केन्द्रमा राखी विभिन्न विषयका ज्ञानलाई एकीकृत गरी पढाइने ढाँचालाई के भनिन्छ?', E'विषयगत/विषयसम्बन्धी ढाँचा (Thematic Design)', E'समस्या केन्द्रित ढाँचा (Problem Design)', E'मुख्य पाठ्यक्रम (Core Curriculum)', E'लुप्त पाठ्यक्रम', E'A', E'**कुनै साझा विषय वा मुद्दालाई केन्द्रमा राखी विभिन्न विषयका ज्ञानलाई एकीकृत गरी पढाइने ढाँचालाई विषयगत ढाँचा (Thematic Design) भनिन्छ।**\\n- समस्या केन्द्रित ढाँचा (Problem Design) मा वास्तविक जीवनका समस्या समाधानमा केन्द्रित हुन्छ।\\n- मुख्य पाठ्यक्रम (Core Curriculum) मा सबैका लागि अनिवार्य साझा विषयवस्तु राखिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै साझा विषय वा मुद्दालाई केन्द्रमा राखी विभिन्न विषयका ज्ञानलाई एकीकृत गरी पढाइने ढाँचालाई के भनिन्छ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वास्तविक जीवनका समस्याहरूको समाधानलाई आधार बनाई संगठित गरिने पाठ्यक्रम ढाँचालाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'वास्तविक जीवनका समस्याहरूको समाधानलाई आधार बनाई संगठित गरिने पाठ्यक्रम ढाँचालाई के भनिन्छ?', E'विषयगत ढाँचा', E'समस्या केन्द्रित ढाँचा (Problem Design)', E'मुख्य पाठ्यक्रम', E'लुप्त पाठ्यक्रम', E'B', E'**वास्तविक जीवनका समस्याहरूको समाधानलाई आधार बनाई संगठित गरिने पाठ्यक्रम ढाँचालाई समस्या केन्द्रित ढाँचा (Problem Design) भनिन्छ।**\\n- विषयगत ढाँचामा साझा विषय वा मुद्दालाई केन्द्रमा राखिन्छ।\\n- मुख्य पाठ्यक्रममा सबैका लागि अनिवार्य साझा विषयवस्तु राखिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वास्तविक जीवनका समस्याहरूको समाधानलाई आधार बनाई संगठित गरिने पाठ्यक्रम ढाँचालाई के भनिन्छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सबै विद्यार्थीका लागि अनिवार्य साझा विषयवस्तु समावेश गरिने पाठ्यक्रमलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'सबै विद्यार्थीका लागि अनिवार्य साझा विषयवस्तु समावेश गरिने पाठ्यक्रमलाई के भनिन्छ?', E'मुख्य पाठ्यक्रम (Core Curriculum)', E'विषयगत ढाँचा', E'समस्या केन्द्रित ढाँचा', E'लुप्त पाठ्यक्रम', E'A', E'**सबै विद्यार्थीका लागि अनिवार्य साझा विषयवस्तु समावेश गरिने पाठ्यक्रमलाई मुख्य पाठ्यक्रम (Core Curriculum) भनिन्छ।**\\n- विषयगत ढाँचामा कुनै साझा मुद्दालाई केन्द्रमा राखी विषयहरू एकीकृत गरिन्छ।\\n- समस्या केन्द्रित ढाँचामा वास्तविक जीवनका समस्या आधार बनाइन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सबै विद्यार्थीका लागि अनिवार्य साझा विषयवस्तु समावेश गरिने पाठ्यक्रमलाई के भनिन्छ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पुरानो पाठ्यक्रम उद्देश्यमा आधारित (KSA) थियो भने नयाँ पाठ्यक्रम केमा आधारित छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'पुरानो पाठ्यक्रम उद्देश्यमा आधारित (KSA) थियो भने नयाँ पाठ्यक्रम केमा आधारित छ?', E'KSA नै', E'सक्षमतामा आधारित (KSAVA)', E'केवल विषयवस्तुमा आधारित', E'केवल परीक्षामा आधारित', E'B', E'**पुरानो पाठ्यक्रम उद्देश्यमा आधारित (KSA — Knowledge, Skill, Attitude) थियो भने नयाँ पाठ्यक्रम सक्षमतामा आधारित (KSAVA — Knowledge, Skill, Attitude, Value, Aspiration) छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पुरानो पाठ्यक्रम उद्देश्यमा आधारित (KSA) थियो भने नयाँ पाठ्यक्रम केमा आधारित छ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पुरानो पाठ्यक्रममा साधारण उद्देश्य र विशिष्ट उद्देश्य रहन्थ्यो भने नयाँ पाठ्यक्रममा के-के राखिएको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'पुरानो पाठ्यक्रममा साधारण उद्देश्य र विशिष्ट उद्देश्य रहन्थ्यो भने नयाँ पाठ्यक्रममा के-के राखिएको छ?', E'पाठ्यभार र पूर्णाङ्क', E'सक्षमता र सिकाइ उपलब्धि', E'पाठ्यघण्टा र कार्यघण्टा', E'लक्ष्य र ध्येय', E'B', E'**पुरानो पाठ्यक्रममा साधारण उद्देश्य र विशिष्ट उद्देश्य थियो भने नयाँ पाठ्यक्रममा सक्षमता र सिकाइ उपलब्धि राखिएको छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पुरानो पाठ्यक्रममा साधारण उद्देश्य र विशिष्ट उद्देश्य रहन्थ्यो भने नयाँ पाठ्यक्रममा के-के राखिएको छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पुरानो पाठ्यक्रममा पाठ्यभार र पूर्णाङ्क हुन्थ्यो भने नयाँ पाठ्यक्रममा के हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'पुरानो पाठ्यक्रममा पाठ्यभार र पूर्णाङ्क हुन्थ्यो भने नयाँ पाठ्यक्रममा के हुन्छ?', E'पाठ्यघण्टा र कार्यघण्टा', E'सक्षमता र मूल्य', E'लक्ष्य र ध्येय', E'उद्देश्य र विषयवस्तु', E'A', E'**पुरानो पाठ्यक्रममा पाठ्यभार र पूर्णाङ्क थियो भने नयाँ पाठ्यक्रममा पाठ्यघण्टा र कार्यघण्टा हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पुरानो पाठ्यक्रममा पाठ्यभार र पूर्णाङ्क हुन्थ्यो भने नयाँ पाठ्यक्रममा के हुन्छ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'एक पाठ्यघण्टा (Credit Hour) बराबर कति कार्यघण्टा (Working Hour) हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'एक पाठ्यघण्टा (Credit Hour) बराबर कति कार्यघण्टा (Working Hour) हुन्छ?', E'१६', E'२४', E'३२', E'४०', E'C', E'**एक पाठ्यघण्टा (Credit Hour) बराबर ३२ कार्यघण्टा (Working Hour) हुन्छ।**\\n- अर्थात् वर्षभरिमा ३२ हप्ता पठनपाठन हुने गरी पाठ्यघण्टा निर्धारण गरिएको हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:एक पाठ्यघण्टा (Credit Hour) बराबर कति कार्यघण्टा (Working Hour) हुन्छ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालमा पाठ्यक्रम विकासका चरणहरू जम्मा कति वटा मानिन्छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'नेपालमा पाठ्यक्रम विकासका चरणहरू जम्मा कति वटा मानिन्छन्?', E'तीन', E'चार', E'पाँच', E'छ', E'C', E'**नेपालमा पाठ्यक्रम विकासका चरणहरू पाँच वटा मानिन्छन्।**\\n- यी हुन्: क) आवश्यकताको पहिचान, ख) नीतिगत निर्णय, ग) पाठ्यक्रम विकास, घ) पाठ्यक्रम स्वीकृति र कार्यान्वयन, ङ) पाठ्यक्रम मूल्याङ्कन र सुधार।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालमा पाठ्यक्रम विकासका चरणहरू जम्मा कति वटा मानिन्छन्?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पाठ्यक्रम विकास प्रक्रियाको सबैभन्दा पहिलो चरण के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'पाठ्यक्रम विकास प्रक्रियाको सबैभन्दा पहिलो चरण के हो?', E'नीतिगत निर्णय', E'आवश्यकताको पहिचान', E'पाठ्यक्रम स्वीकृति र कार्यान्वयन', E'पाठ्यक्रम मूल्याङ्कन र सुधार', E'B', E'**पाठ्यक्रम विकास प्रक्रियाको सबैभन्दा पहिलो चरण आवश्यकताको पहिचान हो।**\\n- नीतिगत निर्णय दोस्रो चरण हो।\\n- पाठ्यक्रम स्वीकृति र कार्यान्वयन चौथो चरण हो।\\n- पाठ्यक्रम मूल्याङ्कन र सुधार अन्तिम चरण हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पाठ्यक्रम विकास प्रक्रियाको सबैभन्दा पहिलो चरण के हो?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पाठ्यक्रम विकास प्रक्रियाको अन्तिम चरण के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'पाठ्यक्रम विकास प्रक्रियाको अन्तिम चरण के हो?', E'आवश्यकताको पहिचान', E'नीतिगत निर्णय', E'पाठ्यक्रम विकास', E'पाठ्यक्रम मूल्याङ्कन र सुधार', E'D', E'**पाठ्यक्रम विकास प्रक्रियाको अन्तिम चरण पाठ्यक्रम मूल्याङ्कन र सुधार हो।**\\n- आवश्यकताको पहिचान पहिलो चरण हो।\\n- नीतिगत निर्णय दोस्रो चरण हो।\\n- पाठ्यक्रम विकास तेस्रो चरण हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पाठ्यक्रम विकास प्रक्रियाको अन्तिम चरण के हो?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पाठ्यक्रम विकासका सैद्धान्तिक आधारहरू जम्मा कति वटा मानिन्छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'पाठ्यक्रम विकासका सैद्धान्तिक आधारहरू जम्मा कति वटा मानिन्छन्?', E'आठ', E'दश', E'एघार', E'तेह्र', E'D', E'**पाठ्यक्रम विकासका सैद्धान्तिक आधारहरू तेह्र वटा मानिन्छन्।**\\n- यी हुन्: संवैधानिक-कानुनी, ऐतिहासिक, दार्शनिक, आर्थिक, सामाजिक, प्राकृतिक, धार्मिक-सांस्कृतिक, संवेगात्मक-मनोवैज्ञानिक, विश्वव्यापीकरण-भूमण्डलीय, परम्परागत ज्ञान, सिप-अनुभवजन्य, आधुनिक प्रवृत्तिगत, र प्रचलित नीति-समसामयिक मुद्दा।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पाठ्यक्रम विकासका सैद्धान्तिक आधारहरू जम्मा कति वटा मानिन्छन्?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पाठ्यक्रम विकासमा राज्यको कानुन र संविधानसँग सम्बन्धित आधारलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'पाठ्यक्रम विकासमा राज्यको कानुन र संविधानसँग सम्बन्धित आधारलाई के भनिन्छ?', E'दार्शनिक आधार', E'संवैधानिक तथा कानुनी आधार', E'प्राकृतिक आधार', E'ऐतिहासिक आधार', E'B', E'**पाठ्यक्रम विकासमा राज्यको कानुन र संविधानसँग सम्बन्धित आधारलाई संवैधानिक तथा कानुनी आधार भनिन्छ।**\\n- दार्शनिक आधार शिक्षाको दर्शनसँग सम्बन्धित हुन्छ।\\n- प्राकृतिक आधार भौगोलिक तथा प्राकृतिक परिस्थितिसँग सम्बन्धित हुन्छ।\\n- ऐतिहासिक आधार विगतका शैक्षिक परम्परा र अनुभवसँग सम्बन्धित हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पाठ्यक्रम विकासमा राज्यको कानुन र संविधानसँग सम्बन्धित आधारलाई के भनिन्छ?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विश्वव्यापीकरण र भूमण्डलीयकरणको प्रभावलाई पाठ्यक्रम निर्माणको कुन आधारअन्तर्गत राखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'विश्वव्यापीकरण र भूमण्डलीयकरणको प्रभावलाई पाठ्यक्रम निर्माणको कुन आधारअन्तर्गत राखिन्छ?', E'सामाजिक आधार', E'विश्वव्यापीकरण र भूमण्डलीय आधार', E'धार्मिक तथा सांस्कृतिक आधार', E'परम्परागत ज्ञान', E'B', E'**विश्वव्यापीकरण र भूमण्डलीयकरणको प्रभावलाई पाठ्यक्रम निर्माणको विश्वव्यापीकरण र भूमण्डलीय आधारअन्तर्गत राखिन्छ।**\\n- सामाजिक आधार समाजका आवश्यकता र मूल्य-मान्यतासँग सम्बन्धित हुन्छ।\\n- धार्मिक तथा सांस्कृतिक आधार धर्म र संस्कृतिसँग सम्बन्धित हुन्छ।\\n- परम्परागत ज्ञान पुर्खौली सीप र ज्ञानसँग सम्बन्धित हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विश्वव्यापीकरण र भूमण्डलीयकरणको प्रभावलाई पाठ्यक्रम निर्माणको कुन आधारअन्तर्गत राखिन्छ?'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'निम्नमध्ये कुन पाठ्यक्रम विकासको सैद्धान्तिक आधार होइन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'निम्नमध्ये कुन पाठ्यक्रम विकासको सैद्धान्तिक आधार होइन?', E'आर्थिक आधार', E'सामाजिक आधार', E'प्राविधिक आधार', E'दार्शनिक आधार', E'C', E'**आर्थिक, सामाजिक र दार्शनिक आधारहरू पाठ्यक्रम विकासका तेह्र सैद्धान्तिक आधारहरूमध्ये पर्छन्।**\\n- प्राविधिक आधार भन्ने छुट्टै वर्गीकरण यी आधारहरूमा पर्दैन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:निम्नमध्ये कुन पाठ्यक्रम विकासको सैद्धान्तिक आधार होइन?'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समाजका आवश्यकता, मूल्य-मान्यता र समस्यासँग सम्बन्धित पाठ्यक्रम विकासको आधारलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'समाजका आवश्यकता, मूल्य-मान्यता र समस्यासँग सम्बन्धित पाठ्यक्रम विकासको आधारलाई के भनिन्छ?', E'सामाजिक आधार', E'आर्थिक आधार', E'प्राकृतिक आधार', E'ऐतिहासिक आधार', E'A', E'**समाजका आवश्यकता, मूल्य-मान्यता र समस्यासँग सम्बन्धित आधारलाई सामाजिक आधार भनिन्छ।**\\n- आर्थिक आधार देशको आर्थिक अवस्था र स्रोतसाधनसँग सम्बन्धित हुन्छ।\\n- प्राकृतिक आधार भौगोलिक तथा प्राकृतिक परिस्थितिसँग सम्बन्धित हुन्छ।\\n- ऐतिहासिक आधार विगतका शैक्षिक परम्परासँग सम्बन्धित हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समाजका आवश्यकता, मूल्य-मान्यता र समस्यासँग सम्बन्धित पाठ्यक्रम विकासको आधारलाई के भनिन्छ?'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ (आधारभूत तह) (15 Q)
  v_set_id := extensions.uuid_generate_v5('e4c591e2-ee54-421f-995d-0827223ef4fd'::uuid, E'राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '2d308800-85c4-4945-b7b2-3b2ac8831074'::uuid, 'e4c591e2-ee54-421f-995d-0827223ef4fd'::uuid, E'राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'e4c591e2-ee54-421f-995d-0827223ef4fd'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ अनुसार विद्यालय शिक्षाका राष्ट्रिय उद्देश्यहरू जम्मा कति वटा छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ अनुसार विद्यालय शिक्षाका राष्ट्रिय उद्देश्यहरू जम्मा कति वटा छन्?', E'८', E'१०', E'१२', E'१५', E'C', E'**राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ अनुसार विद्यालय शिक्षाका राष्ट्रिय उद्देश्यहरू जम्मा १२ वटा छन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ अनुसार विद्यालय शिक्षाका राष्ट्रिय उद्देश्यहरू जम्मा कति वटा छन्?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ अनुसार बालविकासका सक्षमता (Competency) कति वटा तोकिएका छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ अनुसार बालविकासका सक्षमता (Competency) कति वटा तोकिएका छन्?', E'६', E'८', E'१०', E'१२', E'A', E'**राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ अनुसार बालविकासका सक्षमता ६ वटा तोकिएका छन्।**\\n- आधारभूत शिक्षाका सक्षमता भने १२ वटा तोकिएका छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ अनुसार बालविकासका सक्षमता (Competency) कति वटा तोकिएका छन्?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ अनुसार आधारभूत शिक्षाका सक्षमता (Competency) कति वटा तोकिएका छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ अनुसार आधारभूत शिक्षाका सक्षमता (Competency) कति वटा तोकिएका छन्?', E'६', E'८', E'१०', E'१२', E'D', E'**राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ अनुसार आधारभूत शिक्षाका सक्षमता १२ वटा तोकिएका छन्।**\\n- बालविकासका सक्षमता भने ६ वटा तोकिएका छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ अनुसार आधारभूत शिक्षाका सक्षमता (Competency) कति वटा तोकिएका छन्?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ मा समावेशी पद्दतिअनुसारका लक्षित वर्गहरू कति समूहमा वर्गीकरण गरिएका छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ मा समावेशी पद्दतिअनुसारका लक्षित वर्गहरू कति समूहमा वर्गीकरण गरिएका छन्?', E'१०', E'१२', E'१५', E'२०', E'C', E'**राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ मा समावेशी पद्दतिअनुसारका लक्षित वर्गहरू १५ समूहमा वर्गीकरण गरिएका छन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ मा समावेशी पद्दतिअनुसारका लक्षित वर्गहरू कति समूहमा वर्गीकरण गरिएका छन्?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ अघि विद्यालय शिक्षाको संरचना कस्तो थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ अघि विद्यालय शिक्षाको संरचना कस्तो थियो?', E'८+४ = १२', E'५+३+४ = १२', E'८+४+१ = १३', E'६+६ = १२', E'A', E'**राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ अघि (विद्यालय क्षेत्र सुधार कार्यक्रम SSRP र राष्ट्रिय पाठ्यक्रम प्रारूप २०६३ अनुसार) विद्यालय शिक्षाको संरचना ८+४ = १२ वर्ष थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ अघि विद्यालय शिक्षाको संरचना कस्तो थियो?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ अनुसार विद्यालय शिक्षा कति तहमा विभाजित छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ अनुसार विद्यालय शिक्षा कति तहमा विभाजित छ?', E'एक', E'दुई', E'तीन', E'चार', E'B', E'**राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ अनुसार नेपालको विद्यालय शिक्षा आधारभूत र माध्यमिक गरी दुई तहमा रहेको छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ अनुसार विद्यालय शिक्षा कति तहमा विभाजित छ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ अनुसार आधारभूत शिक्षा कक्षा १ देखि कक्षा कतिसम्म हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ अनुसार आधारभूत शिक्षा कक्षा १ देखि कक्षा कतिसम्म हुन्छ?', E'कक्षा ५', E'कक्षा ६', E'कक्षा ७', E'कक्षा ८', E'D', E'**राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ अनुसार आधारभूत शिक्षा कक्षा १ देखि कक्षा ८ सम्म गरी जम्मा आठ वर्षको हुन्छ।**\\nनोट: आधारभूत शिक्षाभन्दा अघि एक वर्षको पूर्व प्राथमिक शिक्षाको व्यवस्था पनि रहन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ अनुसार आधारभूत शिक्षा कक्षा १ देखि कक्षा कतिसम्म हुन्छ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ अनुसार माध्यमिक शिक्षा कति प्रकारको हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ अनुसार माध्यमिक शिक्षा कति प्रकारको हुन्छ?', E'दुई', E'तीन', E'चार', E'पाँच', E'B', E'**राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ अनुसार माध्यमिक शिक्षा साधारण, परम्परागत र प्राविधिक तथा व्यावसायिक गरी तीन प्रकारको हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ अनुसार माध्यमिक शिक्षा कति प्रकारको हुन्छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ अनुसार माध्यमिक शिक्षाको प्राविधिक तथा व्यावसायिक धारमा थप कति वर्षको व्यावहारिक अभ्यास समेटिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ अनुसार माध्यमिक शिक्षाको प्राविधिक तथा व्यावसायिक धारमा थप कति वर्षको व्यावहारिक अभ्यास समेटिन्छ?', E'आधा वर्ष', E'एक वर्ष', E'दुई वर्ष', E'तीन वर्ष', E'B', E'**राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ अनुसार माध्यमिक शिक्षाको प्राविधिक तथा व्यावसायिक धारतर्फ थप एक वर्ष अवधिको व्यावहारिक अभ्यास समेटिनेछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ अनुसार माध्यमिक शिक्षाको प्राविधिक तथा व्यावसायिक धारमा थप कति वर्षको व्यावहारिक अभ्यास समेटिन्छ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ अनुसार आधारभूत शिक्षापूर्व कति वर्षको पूर्व प्राथमिक शिक्षाको व्यवस्था रहन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ अनुसार आधारभूत शिक्षापूर्व कति वर्षको पूर्व प्राथमिक शिक्षाको व्यवस्था रहन्छ?', E'आधा वर्ष', E'एक वर्ष', E'दुई वर्ष', E'व्यवस्था छैन', E'B', E'**राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ अनुसार आधारभूत शिक्षापूर्व एक वर्षको पूर्व प्राथमिक शिक्षाको व्यवस्था रहनेछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ अनुसार आधारभूत शिक्षापूर्व कति वर्षको पूर्व प्राथमिक शिक्षाको व्यवस्था रहन्छ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ अनुसार विद्यालय शिक्षाको तहगत र कक्षागत खाका मुख्यतया केको आधारमा निर्धारण गरिएको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ अनुसार विद्यालय शिक्षाको तहगत र कक्षागत खाका मुख्यतया केको आधारमा निर्धारण गरिएको छ?', E'बालमनोविज्ञान, सिकारुको उमेर र सिकाइ क्षमतास्तर', E'शिक्षकको उपलब्धता', E'विद्यालयको भौतिक पूर्वाधार', E'अभिभावकको आर्थिक अवस्था', E'A', E'**राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ अनुसार विद्यालय शिक्षाको तहगत र कक्षागत खाका बालमनोविज्ञान, सिकारुको उमेर तथा सिकाइ क्षमतास्तरका आधारमा निर्धारण गरिएको छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ अनुसार विद्यालय शिक्षाको तहगत र कक्षागत खाका मुख्यतया केको आधारमा निर्धारण गरिएको छ?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ तथा आधारभूत शिक्षा पाठ्यक्रम, २०७६ अनुसार आधारभूत तह (कक्षा १ देखि ३) मा मातृभाषिक सिप÷स्थानीय विषयवस्तुका लागि वार्षिक पाठ्यघण्टा कति तोकिएको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ तथा आधारभूत शिक्षा पाठ्यक्रम, २०७६ अनुसार आधारभूत तह (कक्षा १ देखि ३) मा मातृभाषिक सिप÷स्थानीय विषयवस्तुका लागि वार्षिक पाठ्यघण्टा कति तोकिएको छ?', E'१००', E'१३०', E'१६०', E'२००', E'C', E'**आधारभूत तह (कक्षा १ देखि ३) मा मातृभाषिक सिप÷स्थानीय विषयवस्तुसम्बन्धी क्रियाकलापका लागि पाठ्यभार ५ र वार्षिक पाठ्यघण्टा १६० तोकिएको छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ तथा आधारभूत शिक्षा पाठ्यक्रम, २०७६ अनुसार आधारभूत तह (कक्षा १ देखि ३) मा मातृभाषिक सिप÷स्थानीय विषयवस्तुका लागि वार्षिक पाठ्यघण्टा कति तोकिएको छ?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शैक्षिक तथा शैक्षणिक योजना (Educational Planning) मुख्यतया केको आधारमा तयार गरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'शैक्षिक तथा शैक्षणिक योजना (Educational Planning) मुख्यतया केको आधारमा तयार गरिन्छ?', E'राष्ट्रिय पाठ्यक्रम निर्माणको आधारमा', E'शिक्षक संघको सुझावमा', E'अभिभावकको माग अनुसार', E'दातृ निकायको निर्देशनमा', E'A', E'**शैक्षिक तथा शैक्षणिक योजना राष्ट्रिय पाठ्यक्रम निर्माणको आधारमा बनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शैक्षिक तथा शैक्षणिक योजना (Educational Planning) मुख्यतया केको आधारमा तयार गरिन्छ?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'निम्नमध्ये कुन राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ अनुसारको विद्यालय शिक्षाको राष्ट्रिय उद्देश्य होइन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'निम्नमध्ये कुन राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ अनुसारको विद्यालय शिक्षाको राष्ट्रिय उद्देश्य होइन?', E'प्रतिभा प्रस्फुटन गरी व्यक्तित्व विकास गर्ने', E'चरित्रवान्, नैतिकवान् एवम् जिम्मेवार नागरिक तयार गर्ने', E'निजी क्षेत्रको नाफा बढाउने', E'राष्ट्रिय एकता सुदृढ गर्न सहयोग पुर्‍याउने', E'C', E'**प्रतिभा प्रस्फुटन गरी व्यक्तित्व विकास गर्ने, चरित्रवान् नागरिक तयार गर्ने र राष्ट्रिय एकता सुदृढ गर्ने कुरा राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ का राष्ट्रिय उद्देश्यहरूमा पर्छन्।**\\n- निजी क्षेत्रको नाफा बढाउने कुरा शिक्षाको राष्ट्रिय उद्देश्यमा पर्दैन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:निम्नमध्ये कुन राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ अनुसारको विद्यालय शिक्षाको राष्ट्रिय उद्देश्य होइन?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ को दिगो विकाससँग सम्बन्धित राष्ट्रिय उद्देश्य के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ को दिगो विकाससँग सम्बन्धित राष्ट्रिय उद्देश्य के हो?', E'रोजगार तथा स्वरोजगार उन्मुख जनशक्ति तयार गर्ने', E'दिगो विकासमा योगदान गर्ने सचेत नागरिक तयार गर्ने', E'विश्वपरिवेश सुहाउँदो दक्ष जनशक्ति तयार गर्ने', E'वैज्ञानिक सुझबुझ भएको जनशक्ति तयार गर्ने', E'B', E'**राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ अनुसार दिगो विकासमा योगदान गर्ने सचेत नागरिक तयार गर्नु शिक्षाको एउटा राष्ट्रिय उद्देश्य हो।**\\n- रोजगार तथा स्वरोजगार उन्मुख जनशक्ति तयार गर्ने पनि यसैको अर्को उद्देश्य हो।\\n- विश्वपरिवेश सुहाउँदो दक्ष जनशक्ति तयार गर्ने पनि अर्को राष्ट्रिय उद्देश्य हो।\\n- वैज्ञानिक सुझबुझ भएको जनशक्ति तयार गर्ने पनि यसैको अर्को उद्देश्य हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:राष्ट्रिय पाठ्यक्रम प्रारूप, २०७६ को दिगो विकाससँग सम्बन्धित राष्ट्रिय उद्देश्य के हो?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: स्थानीय पाठ्यक्रम, विविधता र एकीकृत पाठ्यक्रम (आधारभूत तह) (15 Q)
  v_set_id := extensions.uuid_generate_v5('3aa334f6-9cd1-4609-b8c4-645b929b760f'::uuid, E'स्थानीय पाठ्यक्रम, विविधता र एकीकृत पाठ्यक्रम (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '2d308800-85c4-4945-b7b2-3b2ac8831074'::uuid, '3aa334f6-9cd1-4609-b8c4-645b929b760f'::uuid, E'स्थानीय पाठ्यक्रम, विविधता र एकीकृत पाठ्यक्रम (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '3aa334f6-9cd1-4609-b8c4-645b929b760f'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'स्थानीय पाठ्यक्रमको आवश्यकता पर्नुको एउटा प्रमुख कारण के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'स्थानीय पाठ्यक्रमको आवश्यकता पर्नुको एउटा प्रमुख कारण के हो?', E'स्थानीय पेसा, व्यापार र व्यवसायलाई प्रवर्द्धन गर्न', E'केन्द्रीय पाठ्यक्रमलाई खारेज गर्न', E'राष्ट्रिय परीक्षा प्रणाली हटाउन', E'शिक्षक दरबन्दी घटाउन', E'A', E'**स्थानीय पाठ्यक्रमको आवश्यकता स्थानीय पेसा, व्यापार र व्यवसायलाई प्रवर्द्धन गर्न पर्दछ।**\\n- यसैगरी स्थानीय ऐतिहासिक तथा धार्मिक सम्पदाको संरक्षण र स्थानीय स्रोतसाधनको अधिकतम परिचालनका लागि पनि स्थानीय पाठ्यक्रम आवश्यक हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:स्थानीय पाठ्यक्रमको आवश्यकता पर्नुको एउटा प्रमुख कारण के हो?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालको हालको एकीकृत पाठ्यक्रमको स्वरूप कस्तो ढाँचामा रहेको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'नेपालको हालको एकीकृत पाठ्यक्रमको स्वरूप कस्तो ढाँचामा रहेको छ?', E'विषय-केन्द्रित ढाँचा', E'अन्तरविषयक ढाँचा (Interdisciplinary Design)', E'समस्या-केन्द्रित ढाँचा', E'लुप्त ढाँचा', E'B', E'**नेपालको हालको एकीकृत पाठ्यक्रमको स्वरूप अन्तरविषयक ढाँचा (Interdisciplinary Design) मा रहेको छ, जसअन्तर्गत "हाम्रो सेरोफेरो" जस्ता विषयक्षेत्र समावेश गरिएको छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालको हालको एकीकृत पाठ्यक्रमको स्वरूप कस्तो ढाँचामा रहेको छ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'आधारभूत तह कक्षा (१–३) को पाठ्यक्रमको विशेषता के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'आधारभूत तह कक्षा (१–३) को पाठ्यक्रमको विशेषता के हो?', E'एकल-विषय ढाँचा', E'बहुविषयक ढाँचाको एकीकृत पाठ्यक्रम', E'परीक्षा-केन्द्रित ढाँचा', E'प्राविधिक ढाँचा', E'B', E'**आधारभूत तह कक्षा (१–३) को पाठ्यक्रमको विशेषता समग्रमा बहुविषयक ढाँचाको एकीकृत पाठ्यक्रम तयार गरिएको हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:आधारभूत तह कक्षा (१–३) को पाठ्यक्रमको विशेषता के हो?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पाठ्यक्रम विकास तथा परिमार्जन प्रक्रियामा सामान्यतया सूचना तथा पृष्ठपोषण कोबाट लिने गरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'पाठ्यक्रम विकास तथा परिमार्जन प्रक्रियामा सामान्यतया सूचना तथा पृष्ठपोषण कोबाट लिने गरिन्छ?', E'केवल विषय विशेषज्ञबाट', E'विद्यार्थी, शिक्षक, अभिभावक, विद्यालय व्यवस्थापन समिति र नागरिक समाजका अगुवाबाट', E'केवल मन्त्रालयबाट', E'केवल दातृ निकायबाट', E'B', E'**पाठ्यक्रम विकास प्रक्रियामा विद्यार्थी, शिक्षक, जनप्रतिनिधि, अभिभावक, विद्यालय व्यवस्थापन समिति, शिक्षा समितिका सदस्य, नागरिक समाजका अगुवा तथा उद्यमी-व्यवसायीबाट पाठ्यक्रम तथा पाठ्यसामग्री परिमार्जनका सम्बन्धमा सूचना तथा पृष्ठपोषण लिने गरिएको छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पाठ्यक्रम विकास तथा परिमार्जन प्रक्रियामा सामान्यतया सूचना तथा पृष्ठपोषण कोबाट लिने गरिन्छ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पाठ्यक्रम विकास तथा परिमार्जन प्रक्रियाले सामना गर्नुपर्ने चुनौतीमध्ये एक के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'पाठ्यक्रम विकास तथा परिमार्जन प्रक्रियाले सामना गर्नुपर्ने चुनौतीमध्ये एक के हो?', E'पाठ्यक्रमलाई पूर्णतया केन्द्रीकृत गर्नु', E'सरोकारवालाको मागबमोजिम प्रक्रियालाई विकेन्द्रीकृत गर्नु', E'सरोकारवालाको सहभागिता घटाउनु', E'पाठ्यक्रम परिमार्जन नै नगर्नु', E'B', E'**पाठ्यक्रम विकास तथा परिमार्जन प्रक्रियालाई सरोकारवालाको मागबमोजिम विकेन्द्रीकृत गर्नु यसको एउटा प्रमुख चुनौती हो।**\\n- यसैगरी सरोकारवालाहरूको पूर्ण सहभागिता सुनिश्चित गर्नु र समावेशी अवधारणाअनुरूप पाठ्यक्रम विकास गर्नु पनि चुनौतीका रूपमा रहेका छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पाठ्यक्रम विकास तथा परिमार्जन प्रक्रियाले सामना गर्नुपर्ने चुनौतीमध्ये एक के हो?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पाठ्यक्रम विकास तथा परिमार्जनका चुनौतीहरूमध्ये प्रादेशिक तथा स्थानीय तहसँग सम्बन्धित कुन कुरा पर्दछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'पाठ्यक्रम विकास तथा परिमार्जनका चुनौतीहरूमध्ये प्रादेशिक तथा स्थानीय तहसँग सम्बन्धित कुन कुरा पर्दछ?', E'प्रादेशिक तथा स्थानीय तहसम्म संस्थागत संयन्त्रको विकास र सबलीकरण गर्नु', E'प्रादेशिक तहलाई पाठ्यक्रमबाट बाहिर राख्नु', E'केन्द्रीय तहमा मात्र अधिकार केन्द्रित गर्नु', E'स्थानीय तहलाई कुनै भूमिका नदिनु', E'A', E'**पाठ्यक्रम विकास एवम् कार्यान्वयनका लागि प्रादेशिक तथा स्थानीय तहसम्म संस्थागत संयन्त्रको विकास गर्नु र भएका संयन्त्रको संस्थागत क्षमता सबलीकरण गर्नु एउटा प्रमुख चुनौती हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पाठ्यक्रम विकास तथा परिमार्जनका चुनौतीहरूमध्ये प्रादेशिक तथा स्थानीय तहसँग सम्बन्धित कुन कुरा पर्दछ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'स्थानीय तहले पाठ्यपुस्तक, पाठ्यसामग्री तथा अन्य सिकाइ सामग्रीका सम्बन्धमा के गर्ने जिम्मेवारी पाउँछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'स्थानीय तहले पाठ्यपुस्तक, पाठ्यसामग्री तथा अन्य सिकाइ सामग्रीका सम्बन्धमा के गर्ने जिम्मेवारी पाउँछ?', E'स्वीकृत पाठ्यपुस्तक/सामग्री लागु गर्ने, विद्यार्थी सङ्ख्याका आधारमा अनुदान उपलब्ध गराउने र गुणस्तर, वितरण तथा प्रयोगमा अनुगमन गर्ने', E'पाठ्यक्रम स्वयं स्वीकृत गर्ने', E'राष्ट्रिय परीक्षा सञ्चालन गर्ने', E'शिक्षक सेवा आयोगको परीक्षा लिने', E'A', E'**स्थानीय तहले स्वीकृत पाठ्यपुस्तक, पाठ्यसामग्री तथा अन्य सिकाइ सामग्री लागु गर्ने, विद्यार्थी सङ्ख्याका आधारमा अनुदान उपलब्ध गराउने, र गुणस्तर, वितरण तथा प्रयोग सम्बन्धमा अनुगमन गर्ने जिम्मेवारी पाउँछ।**\\n- पाठ्यक्रम स्वीकृति र राष्ट्रिय परीक्षा सञ्चालन केन्द्रीय निकायको जिम्मेवारी हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:स्थानीय तहले पाठ्यपुस्तक, पाठ्यसामग्री तथा अन्य सिकाइ सामग्रीका सम्बन्धमा के गर्ने जिम्मेवारी पाउँछ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यालयमा पठनपाठन हुने मातृभाषाको छनोट र स्थानीय पाठ्यक्रम निर्माणको जिम्मेवारी कसको हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'विद्यालयमा पठनपाठन हुने मातृभाषाको छनोट र स्थानीय पाठ्यक्रम निर्माणको जिम्मेवारी कसको हो?', E'केन्द्रीय मन्त्रालयको', E'विद्यालय वा सम्बन्धित शैक्षिक संस्था आफैंको (स्थानीय तहको समन्वय÷सहजीकरणमा)', E'प्रदेश सरकारको एकल अधिकार', E'निजी प्रकाशकको', E'B', E'**विद्यालयमा पठनपाठन हुने मातृभाषाको छनोट, पाठ्यक्रम निर्माण र पाठ्यपुस्तक विकास÷कार्यान्वयन स्थानीय तहको समन्वय र सहजीकरणमा विद्यालय वा सम्बन्धित शैक्षिक संस्था आफैंले गर्ने व्यवस्था छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यालयमा पठनपाठन हुने मातृभाषाको छनोट र स्थानीय पाठ्यक्रम निर्माणको जिम्मेवारी कसको हो?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वि.सं. २०६७ मा स्थानीय पाठ्यक्रम विकासका लागि प्राविधिक सहयोग प्रदान गर्न कति विकास क्षेत्रका विद्यालयहरूमा स्थलगत भ्रमण गरिएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'वि.सं. २०६७ मा स्थानीय पाठ्यक्रम विकासका लागि प्राविधिक सहयोग प्रदान गर्न कति विकास क्षेत्रका विद्यालयहरूमा स्थलगत भ्रमण गरिएको थियो?', E'तीन', E'चार', E'पाँच', E'सात', E'C', E'**वि.सं. २०६७ मा तत्कालीन पाँच विकास क्षेत्रका एक-एक जिल्लाका एक-एक विद्यालयमा स्थलगत भ्रमण गरी स्थानीय पाठ्यक्रम विकासका लागि प्राविधिक सहयोग प्रदान गरिएको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वि.सं. २०६७ मा स्थानीय पाठ्यक्रम विकासका लागि प्राविधिक सहयोग प्रदान गर्न कति विकास क्षेत्रका विद्यालयहरूमा स्थलगत भ्रमण गरिएको थियो?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वि.सं. २०६८ मा स्थानीय पाठ्यक्रम विकास तथा कार्यान्वयनमा सहयोगका लागि कुन जिल्लाका ५०० विद्यालयमा तालिम सञ्चालन गरिएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'वि.सं. २०६८ मा स्थानीय पाठ्यक्रम विकास तथा कार्यान्वयनमा सहयोगका लागि कुन जिल्लाका ५०० विद्यालयमा तालिम सञ्चालन गरिएको थियो?', E'काभ्रेपलाञ्चोक', E'सिन्धुपाल्चोक', E'धादिङ', E'नुवाकोट', E'B', E'**वि.सं. २०६८ मा सिन्धुपाल्चोक जिल्लाका ५०० विद्यालयमा स्थानीय पाठ्यक्रम विकास तथा कार्यान्वयनमा सहयोग पुर्‍याउने उद्देश्यले जिल्ला तथा स्रोतकेन्द्रस्तरमा तालिम सञ्चालन गरिएको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वि.सं. २०६८ मा स्थानीय पाठ्यक्रम विकास तथा कार्यान्वयनमा सहयोगका लागि कुन जिल्लाका ५०० विद्यालयमा तालिम सञ्चालन गरिएको थियो?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'जिल्लास्तरमा मातृभाषामा आधारित बहुभाषी शिक्षाको कार्यान्वयनमा सहयोग तथा समन्वय गर्ने जिम्मेवारी कुन निकायको हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'जिल्लास्तरमा मातृभाषामा आधारित बहुभाषी शिक्षाको कार्यान्वयनमा सहयोग तथा समन्वय गर्ने जिम्मेवारी कुन निकायको हो?', E'जिल्ला शिक्षा कार्यालय', E'जिल्ला पाठ्यक्रम समन्वय समिति', E'विद्यालय व्यवस्थापन समिति', E'शिक्षा तालिम केन्द्र', E'B', E'**जिल्लास्तरमा मातृभाषामा आधारित बहुभाषी शिक्षाको कार्यान्वयनमा सहयोग एवम् समन्वय गर्ने जिम्मेवारी जिल्ला पाठ्यक्रम समन्वय समितिको हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:जिल्लास्तरमा मातृभाषामा आधारित बहुभाषी शिक्षाको कार्यान्वयनमा सहयोग तथा समन्वय गर्ने जिम्मेवारी कुन निकायको हो?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालमा प्राथमिक तहको पाठ्यक्रममा मातृभाषाको पाठ्यक्रम कुन साल (वि.सं.) को पाठ्यक्रमबाट समावेश गरिएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'नेपालमा प्राथमिक तहको पाठ्यक्रममा मातृभाषाको पाठ्यक्रम कुन साल (वि.सं.) को पाठ्यक्रमबाट समावेश गरिएको थियो?', E'२०२८', E'२०४९', E'२०६३', E'२०७६', E'B', E'**नेपालमा वि.सं. २०४९ सालको पाठ्यक्रममा प्राथमिक तहमा मातृभाषाको पाठ्यक्रम समावेश गरिएको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालमा प्राथमिक तहको पाठ्यक्रममा मातृभाषाको पाठ्यक्रम कुन साल (वि.सं.) को पाठ्यक्रमबाट समावेश गरिएको थियो?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'माध्यमिक शिक्षा पाठ्यक्रम (कक्षा ९–१०), वि.सं. २०७८ लाई वि.सं. २०७१ को सोही पाठ्यक्रमसँग तुलना गर्दा के देखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'माध्यमिक शिक्षा पाठ्यक्रम (कक्षा ९–१०), वि.सं. २०७८ लाई वि.सं. २०७१ को सोही पाठ्यक्रमसँग तुलना गर्दा के देखिन्छ?', E'२०७८ को पाठ्यक्रम बढी सैद्धान्तिक छ', E'२०७८ को पाठ्यक्रममा प्रयोगात्मक पक्षलाई बढी जोड दिइएको छ', E'दुवैमा कुनै भिन्नता छैन', E'२०७८ मा प्रयोगात्मक पक्ष पूर्णतया हटाइएको छ', E'B', E'**माध्यमिक शिक्षा पाठ्यक्रम (कक्षा ९–१०), वि.सं. २०७८ मा वि.सं. २०७१ को सोही पाठ्यक्रमको तुलनामा प्रयोगात्मक पक्षलाई बढी जोड दिइएको छ।**\\nनोट: वि.सं. २०७१ को पाठ्यक्रम तुलनात्मक रूपमा बढी सैद्धान्तिक र कम प्रयोगात्मक थियो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:माध्यमिक शिक्षा पाठ्यक्रम (कक्षा ९–१०), वि.सं. २०७८ लाई वि.सं. २०७१ को सोही पाठ्यक्रमसँग तुलना गर्दा के देखिन्छ?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पाठ्यक्रम विकास तथा परिमार्जन गर्दा विद्यार्थीसँग सम्बन्धित कुन चुनौती रहेको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'पाठ्यक्रम विकास तथा परिमार्जन गर्दा विद्यार्थीसँग सम्बन्धित कुन चुनौती रहेको छ?', E'विद्यार्थीलाई पाठ्यक्रम विकास प्रक्रियामा सहभागी गराउनु', E'विद्यार्थीलाई प्रक्रियाबाट पूर्णतया बाहिर राख्नु', E'विद्यार्थीको राय नलिनु', E'विद्यार्थीलाई मात्र निर्णयकर्ता बनाउनु', E'A', E'**विद्यार्थीलाई पाठ्यक्रम विकास प्रक्रियामा सहभागी गराउनु पाठ्यक्रम विकास तथा परिमार्जनको एउटा प्रमुख चुनौती हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पाठ्यक्रम विकास तथा परिमार्जन गर्दा विद्यार्थीसँग सम्बन्धित कुन चुनौती रहेको छ?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पाठ्यक्रम विकास तथा परिमार्जन प्रक्रियाको चुनौतीमा नेपालको मौलिक मूल्य-मान्यतासँग सम्बन्धित कुन पक्ष पर्दछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'पाठ्यक्रम विकास तथा परिमार्जन प्रक्रियाको चुनौतीमा नेपालको मौलिक मूल्य-मान्यतासँग सम्बन्धित कुन पक्ष पर्दछ?', E'नेपालको मौलिक मूल्य तथा मान्यता एवम् आस्थाको संवर्धन गर्दै विद्यार्थीमा असल चरित्र विकास गर्नु', E'मौलिक मूल्य-मान्यतालाई पाठ्यक्रमबाट हटाउनु', E'विदेशी पाठ्यक्रम जस्ताको तस्तै लागू गर्नु', E'चरित्र विकासलाई पाठ्यक्रमबाट अलग राख्नु', E'A', E'**नेपालको मौलिक मूल्य तथा मान्यता एवम् आस्था-विश्वासको संवर्धन र प्रवर्द्धन गर्दै विद्यार्थीमा असल चरित्र विकास गर्नु पाठ्यक्रम विकास तथा परिमार्जनको एउटा चुनौती हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पाठ्यक्रम विकास तथा परिमार्जन प्रक्रियाको चुनौतीमा नेपालको मौलिक मूल्य-मान्यतासँग सम्बन्धित कुन पक्ष पर्दछ?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: पाठ्यपुस्तक विकास, विशेषता र शिक्षक निर्देशिका (आधारभूत तह) (17 Q)
  v_set_id := extensions.uuid_generate_v5('15f070d3-67f2-44f8-9fb1-09b4b8bfcacb'::uuid, E'पाठ्यपुस्तक विकास, विशेषता र शिक्षक निर्देशिका (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '2d308800-85c4-4945-b7b2-3b2ac8831074'::uuid, '15f070d3-67f2-44f8-9fb1-09b4b8bfcacb'::uuid, E'पाठ्यपुस्तक विकास, विशेषता र शिक्षक निर्देशिका (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '15f070d3-67f2-44f8-9fb1-09b4b8bfcacb'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पाठ्यपुस्तक भनेको के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'पाठ्यपुस्तक भनेको के हो?', E'पाठ्यक्रमलाई प्रभावकारी रूपमा कार्यान्वयन गर्न सहयोग पुर्‍याउने दृष्टिले तयार पारिएको सामग्री', E'पाठ्यक्रम आफैं', E'शिक्षकको व्यक्तिगत नोट', E'परीक्षा प्रश्नपत्र', E'A', E'**पाठ्यपुस्तक भनेको पाठ्यक्रमलाई प्रभावकारी रूपमा कार्यान्वयन गर्न सहयोग पुर्‍याउने दृष्टिले तयार पारिएको सामग्री हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पाठ्यपुस्तक भनेको के हो?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'आधारभूत तथा माध्यमिक तहका पाठ्यपुस्तकको साइज (Trim Size) कति हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'आधारभूत तथा माध्यमिक तहका पाठ्यपुस्तकको साइज (Trim Size) कति हुन्छ?', E'१० से.मि. × १५ से.मि.', E'१८ से.मि. × २४ से.मि. वा २१ से.मि. × २८ से.मि.', E'३० से.मि. × ४० से.मि.', E'कुनै निश्चित नाप हुँदैन', E'B', E'**आधारभूत तथा माध्यमिक तहका पाठ्यपुस्तकको साइज (Trim Size) १८ से.मि. × २४ से.मि. वा २१ से.मि. × २८ से.मि. हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:आधारभूत तथा माध्यमिक तहका पाठ्यपुस्तकको साइज (Trim Size) कति हुन्छ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पाठ्यपुस्तकको विषयवस्तुको आकार (Running Text) कति हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'पाठ्यपुस्तकको विषयवस्तुको आकार (Running Text) कति हुन्छ?', E'१४ से.मि. × २० से.मि. वा १७ से.मि. × २४ से.मि.', E'१८ से.मि. × २४ से.मि.', E'२५ से.मि. × ३० से.मि.', E'निश्चित हुँदैन', E'A', E'**पाठ्यपुस्तकको विषयवस्तुको आकार (Running Text) १४ से.मि. × २० से.मि. वा १७ से.मि. × २४ से.मि. हुन्छ।**\\n- १८ से.मि. × २४ से.मि. भने सम्पूर्ण पुस्तकको बाहिरी साइज (Trim Size) हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पाठ्यपुस्तकको विषयवस्तुको आकार (Running Text) कति हुन्छ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पाठ्यपुस्तकमा सामान्यतया कति पेज सङ्ख्या रहनुपर्ने छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'पाठ्यपुस्तकमा सामान्यतया कति पेज सङ्ख्या रहनुपर्ने छ?', E'४०-८० पेज', E'८०-१५० पेज', E'२००-२५० पेज', E'निश्चित सीमा छैन', E'B', E'**पुस्तकमा सामान्यतया ८० देखि १५० सम्मको पेज सङ्ख्या रहनुपर्ने छ।**\\nनोट: अभ्यास पुस्तिकासमेत समावेश भएका पाठ्यपुस्तक बढीमा २०० पेजसम्म हुन सक्ने छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पाठ्यपुस्तकमा सामान्यतया कति पेज सङ्ख्या रहनुपर्ने छ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'प्रतिपाठ (per lesson) पेज सङ्ख्या औसत कम्तीमा कति हुनुपर्ने छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'प्रतिपाठ (per lesson) पेज सङ्ख्या औसत कम्तीमा कति हुनुपर्ने छ?', E'२ पेज', E'४ पेज', E'६ पेज', E'१० पेज', E'B', E'**प्रतिपाठ पेज सङ्ख्या अभ्यास तथा क्रियाकलापसहित औसत कम्तीमा ४ पेज हुनुपर्ने छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:प्रतिपाठ (per lesson) पेज सङ्ख्या औसत कम्तीमा कति हुनुपर्ने छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'भाषा सिकाउनका लागि पाठ्यपुस्तकमा समेटिनुपर्ने विधाहरूमा निम्नमध्ये कुन पर्दैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'भाषा सिकाउनका लागि पाठ्यपुस्तकमा समेटिनुपर्ने विधाहरूमा निम्नमध्ये कुन पर्दैन?', E'बालकथा', E'बालगीत÷बालकविता', E'अनुसन्धान प्रतिवेदन', E'चिठी', E'C', E'**भाषा सिकाउनका लागि पाठ्यपुस्तकमा बालकथा, बालगीत÷बालकविता, संवाद, प्रबन्ध÷निबन्ध, चिठी, जीवनी, दैनिकी र वादविवाद जस्ता विधाहरू समेटिनुपर्ने छ।**\\n- अनुसन्धान प्रतिवेदन (Research Report) यी विधाहरूमा पर्दैन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:भाषा सिकाउनका लागि पाठ्यपुस्तकमा समेटिनुपर्ने विधाहरूमा निम्नमध्ये कुन पर्दैन?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पाठ्यपुस्तकमा समावेश गरिने विषयवस्तु तथा चित्र कस्तो हुनुपर्ने छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'पाठ्यपुस्तकमा समावेश गरिने विषयवस्तु तथा चित्र कस्तो हुनुपर्ने छ?', E'राष्ट्रिय अखण्डतामा आँच नपुग्ने', E'विदेशी सामग्रीबाट प्रत्यक्ष सारिएको', E'कुनै मापदण्ड आवश्यक नपर्ने', E'केवल शहरी परिवेशसँग मात्र सम्बन्धित', E'A', E'**पाठ्यपुस्तकमा समावेश गरिने विषयवस्तु तथा चित्र राष्ट्रिय अखण्डतामा आँच नपुग्ने हुनुपर्ने छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पाठ्यपुस्तकमा समावेश गरिने विषयवस्तु तथा चित्र कस्तो हुनुपर्ने छ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पाठ्यक्रम विकास केन्द्रले कुन साल (वि.सं.) देखि मातृभाषाका पाठ्यसामग्रीको विकास गर्दै आइरहेको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'पाठ्यक्रम विकास केन्द्रले कुन साल (वि.सं.) देखि मातृभाषाका पाठ्यसामग्रीको विकास गर्दै आइरहेको छ?', E'२०४९', E'२०५१', E'२०६३', E'२०७६', E'B', E'**पाठ्यक्रम विकास केन्द्रले वि.सं. २०५१ सालदेखि मातृभाषाका पाठ्यसामग्रीको विकास गर्दै आइरहेको छ।**\\nनोट: हालसम्म मातृभाषामा आधारभूत तहका पाठ्यपुस्तक तथा १५ मातृभाषामा बालसन्दर्भ सामग्री तयार गरिएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पाठ्यक्रम विकास केन्द्रले कुन साल (वि.सं.) देखि मातृभाषाका पाठ्यसामग्रीको विकास गर्दै आइरहेको छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पाठ्यक्रम विकास केन्द्रले हालसम्म कति मातृभाषामा बालसन्दर्भ सामग्री तयार गरेको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'पाठ्यक्रम विकास केन्द्रले हालसम्म कति मातृभाषामा बालसन्दर्भ सामग्री तयार गरेको छ?', E'१०', E'१२', E'१५', E'२०', E'C', E'**पाठ्यक्रम विकास केन्द्रले हालसम्म १५ मातृभाषामा बालसन्दर्भ सामग्री तयार गरेको छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पाठ्यक्रम विकास केन्द्रले हालसम्म कति मातृभाषामा बालसन्दर्भ सामग्री तयार गरेको छ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पाठ्यक्रम विकास केन्द्र (CDC) ले पाठ्यपुस्तक मुद्रण÷वितरणसँग सम्बन्धित के गर्ने कार्य गर्दछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'पाठ्यक्रम विकास केन्द्र (CDC) ले पाठ्यपुस्तक मुद्रण÷वितरणसँग सम्बन्धित के गर्ने कार्य गर्दछ?', E'मुद्रक तथा वितरक सूचीकरण गर्ने र मुद्रणीय प्रति तोकिएको समयमै उपलब्ध गराउने', E'विद्यालय भवन निर्माण गर्ने', E'शिक्षक सेवा आयोगको परीक्षा सञ्चालन गर्ने', E'राष्ट्रिय परीक्षा बोर्डको काम गर्ने', E'A', E'**पाठ्यक्रम विकास केन्द्रले मुद्रक तथा वितरक सूचीकरण सम्बन्धी कार्य गर्ने, विद्यालयस्तरका नमुना पाठ्यपुस्तक विकास गर्ने एवम् मुद्रणीय प्रति तोकिएको समयमै जनक शिक्षा सामग्री केन्द्र वा सूचीकरण भएका निजी क्षेत्रका मुद्रक÷वितरकलाई उपलब्ध गराउने कार्य गर्दछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पाठ्यक्रम विकास केन्द्र (CDC) ले पाठ्यपुस्तक मुद्रण÷वितरणसँग सम्बन्धित के गर्ने कार्य गर्दछ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'प्रदेशले पाठ्यपुस्तक तथा सिकाइ सामग्रीका सम्बन्धमा के जिम्मेवारी पाउँछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'प्रदेशले पाठ्यपुस्तक तथा सिकाइ सामग्रीका सम्बन्धमा के जिम्मेवारी पाउँछ?', E'पाठ्यपुस्तक÷सामग्रीको गुणस्तर, वितरण तथा कार्यान्वयनको अनुगमन गर्ने र अन्य शैक्षणिक सामग्रीको सर्वसुलभताका लागि समन्वय गर्ने', E'पाठ्यक्रम स्वीकृत गर्ने', E'राष्ट्रिय परीक्षा सञ्चालन गर्ने', E'मातृभाषा छनोट गर्ने', E'A', E'**प्रदेशले पाठ्यपुस्तक, पाठ्यसामग्री, सन्दर्भ सामग्री तथा अन्य सिकाइ सामग्रीहरूको गुणस्तर, वितरण तथा कार्यान्वयन सम्बन्धमा अनुगमन गर्ने र पाठ्यपुस्तक बाहेकका अन्य शैक्षणिक सामग्रीको सर्वसुलभताका लागि समन्वय गर्ने जिम्मेवारी पाउँछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:प्रदेशले पाठ्यपुस्तक तथा सिकाइ सामग्रीका सम्बन्धमा के जिम्मेवारी पाउँछ?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'निःशुल्क पाठ्यपुस्तकका लागि विद्यालयले शैक्षिक सत्र सुरु हुनुभन्दा कति महिना अगाडि अनुदान रकम माग गर्नुपर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'निःशुल्क पाठ्यपुस्तकका लागि विद्यालयले शैक्षिक सत्र सुरु हुनुभन्दा कति महिना अगाडि अनुदान रकम माग गर्नुपर्छ?', E'एक महिना', E'दुई महिना', E'तीन महिना', E'छ महिना', E'C', E'**निःशुल्क पाठ्यपुस्तकका लागि विद्यालयले शैक्षिक सत्र सुरु हुनुभन्दा तीन महिना अगाडि नै अनुदान रकम माग गरी सबै विद्यार्थीका लागि पाठ्यपुस्तक उपलब्ध गराउनुपर्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:निःशुल्क पाठ्यपुस्तकका लागि विद्यालयले शैक्षिक सत्र सुरु हुनुभन्दा कति महिना अगाडि अनुदान रकम माग गर्नुपर्छ?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षक निर्देशिका (Teacher''s Guide) मूलतः कस्तो प्रकारको शैक्षिक सामग्री हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'शिक्षक निर्देशिका (Teacher''s Guide) मूलतः कस्तो प्रकारको शैक्षिक सामग्री हो?', E'कार्यान्वयनमुखी शैक्षिक सामग्री', E'मूल्याङ्कनमुखी सामग्री', E'मनोरञ्जनात्मक सामग्री', E'विज्ञापन सामग्री', E'A', E'**शिक्षक निर्देशिका कार्यान्वयनमुखी शैक्षिक सामग्री हो, जसले पाठको पूर्व तयारी, शैक्षिक सामग्रीको छनोट र शैक्षणिक योजना निर्माणमा शिक्षकलाई सहयोग गर्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षक निर्देशिका (Teacher''s Guide) मूलतः कस्तो प्रकारको शैक्षिक सामग्री हो?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षक निर्देशिकाको मस्यौदा तयार गर्ने काम सामान्यतया कसलाई दिइन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'शिक्षक निर्देशिकाको मस्यौदा तयार गर्ने काम सामान्यतया कसलाई दिइन्छ?', E'विषय विशेषज्ञलाई (छलफल, अन्तर्क्रिया र कार्यशाला गोष्ठीका सुझाव समेटेर)', E'विद्यार्थीलाई', E'अभिभावकलाई', E'निजी प्रकाशकलाई मात्र', E'A', E'**छलफल, अन्तर्क्रिया तथा कार्यशाला गोष्ठीबाट निस्किएका सुझावलाई एकीकृत गरी विषय विशेषज्ञलाई शिक्षक निर्देशिकाको मस्यौदा तयार गर्न दिइन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षक निर्देशिकाको मस्यौदा तयार गर्ने काम सामान्यतया कसलाई दिइन्छ?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पाठ्यपुस्तक र शिक्षक निर्देशिकाबीचको सम्बन्धका बारेमा के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'पाठ्यपुस्तक र शिक्षक निर्देशिकाबीचको सम्बन्धका बारेमा के भनिन्छ?', E'दुवै एकआपसमा पूर्णतया स्वतन्त्र हुन्छन्', E'पाठ्यपुस्तक पाठ्यक्रमबाट निर्देशित वा शासित हुन्छ, र शिक्षक निर्देशिका पाठ्यक्रम र पाठ्यपुस्तक दुवैबाट बाँधिएर तयार हुन्छ', E'शिक्षक निर्देशिका पाठ्यपुस्तकभन्दा पहिले तयार गरिन्छ', E'दुवै एउटै दस्तावेज हुन्', E'B', E'**पाठ्यपुस्तक पाठ्यक्रमबाट निर्देशित वा शासित हुन्छ, र शिक्षक निर्देशिका पाठ्यक्रम र पाठ्यपुस्तक दुवैबाट बाँधिएर तयार हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पाठ्यपुस्तक र शिक्षक निर्देशिकाबीचको सम्बन्धका बारेमा के भनिन्छ?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यालय पुस्तकालयमा पाठ्यक्रम, पाठ्यपुस्तक र शिक्षक निर्देशिकासहितको कति प्रति किताब प्रति विद्यार्थी उपलब्ध हुनुपर्ने व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'विद्यालय पुस्तकालयमा पाठ्यक्रम, पाठ्यपुस्तक र शिक्षक निर्देशिकासहितको कति प्रति किताब प्रति विद्यार्थी उपलब्ध हुनुपर्ने व्यवस्था छ?', E'१ विद्यार्थी बराबर १ प्रति', E'१ विद्यार्थी बराबर कम्तीमा २ प्रति', E'१० विद्यार्थी बराबर १ प्रति', E'कुनै अनुपात तोकिएको छैन', E'B', E'**विद्यालय पुस्तकालयमा पाठ्यक्रम, पाठ्यपुस्तक र शिक्षक निर्देशिकासहितको १ विद्यार्थी बराबर कम्तीमा २ प्रतिका दरले पुस्तक उपलब्ध हुनुपर्ने व्यवस्था छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यालय पुस्तकालयमा पाठ्यक्रम, पाठ्यपुस्तक र शिक्षक निर्देशिकासहितको कति प्रति किताब प्रति विद्यार्थी उपलब्ध हुनुपर्ने व्यवस्था छ?'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षण सिकाइमा प्रयोग गरिने त्यस्ता सामग्री, जसलाई सुनेर मात्र विषयवस्तुको ज्ञान प्राप्त गर्न सकिन्छ, त्यसलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'शिक्षण सिकाइमा प्रयोग गरिने त्यस्ता सामग्री, जसलाई सुनेर मात्र विषयवस्तुको ज्ञान प्राप्त गर्न सकिन्छ, त्यसलाई के भनिन्छ?', E'श्रव्य सामग्री (Audio Material)', E'दृश्य सामग्री', E'श्रव्य-दृश्य सामग्री', E'मुद्रित सामग्री', E'A', E'**शिक्षण सिकाइमा प्रयोग गरिने र सुनेर मात्र विषयवस्तुको ज्ञान प्राप्त गर्न सकिने सामग्रीलाई श्रव्य सामग्री (Audio Material) भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षण सिकाइमा प्रयोग गरिने त्यस्ता सामग्री, जसलाई सुनेर मात्र विषयवस्तुको ज्ञान प्राप्त गर्न सकिन्छ, त्यसलाई के भनिन्छ?'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  RAISE NOTICE 'Unit ख-५ पाठ्यक्रम batch upsert complete: 6 sets, 95 questions.';
END $$;
