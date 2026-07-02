-- Idempotent UPSERT import: निमावि प्रथम पत्र — unit घ-२ शिक्षा ऐन, २०२८ (Level I topic-wise sets)
-- Override same-identity sets/questions; never deletes. Generated 2026-07-02T11:04:28.925Z.
DO $$
DECLARE
  v_module_id uuid := '6695669a-f40e-421a-a4ec-b09bbeaf56c4'::uuid;
  v_set_id uuid;
  v_q_id uuid;
BEGIN

  -- Set: शिक्षा ऐन, २०२८: ऐनको परिचय, शिक्षाको माध्यम र विद्यालय वर्गीकरण (आधारभूत तह) (8 Q)
  v_set_id := extensions.uuid_generate_v5('209f1c03-55a8-4a24-83d2-394016971f86'::uuid, E'शिक्षा ऐन, २०२८: ऐनको परिचय, शिक्षाको माध्यम र विद्यालय वर्गीकरण (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '4e931234-3a51-422d-b861-caf5849aafc8'::uuid, '209f1c03-55a8-4a24-83d2-394016971f86'::uuid, E'शिक्षा ऐन, २०२८: ऐनको परिचय, शिक्षाको माध्यम र विद्यालय वर्गीकरण (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '209f1c03-55a8-4a24-83d2-394016971f86'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा ऐन, २०२८ कहिले लालमोहर र प्रकाशन भई प्रमाणीकरण भएको हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'शिक्षा ऐन, २०२८ कहिले लालमोहर र प्रकाशन भई प्रमाणीकरण भएको हो?', E'२०२८/५/२४', E'२०२८/६/२४', E'२०२८/४/२४', E'२०२८/६/१४', E'A', E'**शिक्षा ऐन, २०२८ मिति २०२८/५/२४ मा लालमोहर र प्रकाशन भई प्रमाणीकरण भएको हो।**\\nनोट: हालसम्म यसमा नौपटक संशोधन भइसकेको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा ऐन, २०२८ कहिले लालमोहर र प्रकाशन भई प्रमाणीकरण भएको हो?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा ऐन, २०२८ सर्वप्रथम कुन कुन जिल्लामा लागू भएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'शिक्षा ऐन, २०२८ सर्वप्रथम कुन कुन जिल्लामा लागू भएको थियो?', E'सिन्धुपाल्चोक र काभ्रे', E'चितवन र कास्की', E'काठमाडौं र स्याङ्जा', E'मकवानपुर र कास्की', E'B', E'**शिक्षा ऐन, २०२८ मिति २०२८।७।१५ देखि सर्वप्रथम चितवन र कास्की जिल्लामा लागू भएको थियो, त्यसपछि चरणबद्ध रूपमा अन्य जिल्लामा विस्तार भयो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा ऐन, २०२८ सर्वप्रथम कुन कुन जिल्लामा लागू भएको थियो?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'राष्ट्रिय शिक्षा बोर्डको स्थापना नेपालको शिक्षा ऐनको कतिऔँ संशोधनले गरेको हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'राष्ट्रिय शिक्षा बोर्डको स्थापना नेपालको शिक्षा ऐनको कतिऔँ संशोधनले गरेको हो?', E'सातौं संशोधन', E'नवौं संशोधन', E'आठौं संशोधन', E'छैठौं संशोधन', E'C', E'**राष्ट्रिय शिक्षा बोर्डको स्थापना शिक्षा ऐनको आठौं संशोधन (मिति २०७३/३/१५) ले गरेको हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:राष्ट्रिय शिक्षा बोर्डको स्थापना नेपालको शिक्षा ऐनको कतिऔँ संशोधनले गरेको हो?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा ऐन, २०२८ मा भएको शिक्षाको माध्यमसम्बन्धी व्यवस्था अनुसार तलकामध्ये कुन व्यवस्था होइन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'शिक्षा ऐन, २०२८ मा भएको शिक्षाको माध्यमसम्बन्धी व्यवस्था अनुसार तलकामध्ये कुन व्यवस्था होइन?', E'शिक्षाको माध्यम नेपाली भाषा, अङ्ग्रेजी भाषा वा दुवै भाषा हुनेछ।', E'गैर नेपाली नागरिकले नेपालका विद्यालयमा अध्ययन गर्दा अनिवार्य नेपाली विषयको सट्टा अन्य कुनै भाषाको विषय अध्ययन गर्न सक्नेछन्।', E'प्राथमिक शिक्षा मातृभाषामा दिन सकिनेछ।', E'प्रदेशहरूले प्रदेश भाषा आयोग गठन गरी सिफारिस गरिएको भाषामा शिक्षा दिन सकिनेछ।', E'D', E'**प्रदेशहरूले प्रदेश भाषा आयोग गठन गरी सिफारिस गरिएको भाषामा शिक्षा दिन सक्ने भन्ने व्यवस्था दफा ७ मा छैन।**\\nनोट: शिक्षाको माध्यम नेपाली/अंग्रेजी/दुवै भाषा, प्राथमिक तहमा मातृभाषामा शिक्षा, र गैर नेपाली नागरिकलाई अनिवार्य नेपाली विषयको सट्टा अन्य भाषा पढ्न पाउने — यी तीनवटा दफा ७ का वास्तविक व्यवस्था हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा ऐन, २०२८ मा भएको शिक्षाको माध्यमसम्बन्धी व्यवस्था अनुसार तलकामध्ये कुन व्यवस्था होइन?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा ऐन, २०२८ अनुसार तलकामध्ये कस्ता विद्यालयको नाममा जुनसुकै लिखत पारित गर्दा रजिस्ट्रेसन दस्तुर लाग्दैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'शिक्षा ऐन, २०२८ अनुसार तलकामध्ये कस्ता विद्यालयको नाममा जुनसुकै लिखत पारित गर्दा रजिस्ट्रेसन दस्तुर लाग्दैन?', E'सामुदायिक विद्यालय र शैक्षिक गुठी दुवै', E'सामुदायिक विद्यालय मात्र', E'सामुदायिक विद्यालय र शैक्षिक गुठी मात्र', E'सामुदायिक विद्यालय र निजी विद्यालय मात्र', E'A', E'**सामुदायिक विद्यालय र शैक्षिक गुठी — दुवैको नाममा जुनसुकै लिखत पारित गर्दा रजिस्ट्रेसन दस्तुर लाग्दैन।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा ऐन, २०२८ अनुसार तलकामध्ये कस्ता विद्यालयको नाममा जुनसुकै लिखत पारित गर्दा रजिस्ट्रेसन दस्तुर लाग्दैन?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा ऐन, २०२८ अनुसार कुनै सामुदायिक विद्यालयले ऐनमा तोकिएभन्दा बढी शुल्क लिएमा कति जरिवाना गर्न सकिने व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'शिक्षा ऐन, २०२८ अनुसार कुनै सामुदायिक विद्यालयले ऐनमा तोकिएभन्दा बढी शुल्क लिएमा कति जरिवाना गर्न सकिने व्यवस्था छ?', E'५० हजार रुपैयाँसम्म', E'२५ हजार रुपैयाँसम्म', E'२० हजार रुपैयाँसम्म', E'३५ हजार रुपैयाँसम्म', E'B', E'**ऐनमा तोकिएभन्दा बढी शुल्क लिने सामुदायिक विद्यालयलाई २५ हजार रुपैयाँसम्म जरिवाना गर्न सकिन्छ।**\\nनोट: सामुदायिक विद्यालयका विद्यार्थीबाट ऐनले नतोकेको कुनै किसिमको शुल्क लिन पाइँदैन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा ऐन, २०२८ अनुसार कुनै सामुदायिक विद्यालयले ऐनमा तोकिएभन्दा बढी शुल्क लिएमा कति जरिवाना गर्न सकिने व्यवस्था छ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा ऐन, २०२८ अनुसार विद्यालय कोषमा तलकामध्ये कुन रकम जम्मा हुँदैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'शिक्षा ऐन, २०२८ अनुसार विद्यालय कोषमा तलकामध्ये कुन रकम जम्मा हुँदैन?', E'शुल्कबाट उठेको रकम', E'चन्दा वा दान दातव्यबाट प्राप्त रकम', E'शैक्षिक कारोबारबाट उठेको रकम', E'गाउँ वा नगरपालिकाबाट प्राप्त अनुदान', E'C', E'**शैक्षिक कारोबारबाट उठेको रकम विद्यालय कोषमा जम्मा हुँदैन।**\\nनोट: शुल्क, चन्दा-दान र गाउँ/नगरपालिकाको अनुदान भने विद्यालय कोषमा जम्मा हुने आम्दानीका स्रोत हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा ऐन, २०२८ अनुसार विद्यालय कोषमा तलकामध्ये कुन रकम जम्मा हुँदैन?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा ऐन, २०२८ अनुसार संस्थागत विद्यालयले कुनै व्यक्ति वा संघसंस्थाबाट दानका रूपमा कुनै किसिमको चल-अचल सम्पत्ति प्राप्त गर्नुअघि कसको स्वीकृति लिनुपर्ने व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'शिक्षा ऐन, २०२८ अनुसार संस्थागत विद्यालयले कुनै व्यक्ति वा संघसंस्थाबाट दानका रूपमा कुनै किसिमको चल-अचल सम्पत्ति प्राप्त गर्नुअघि कसको स्वीकृति लिनुपर्ने व्यवस्था छ?', E'शिक्षा, विज्ञान तथा प्रविधि मन्त्रालय', E'शिक्षा विकास तथा समन्वय इकाई प्रमुख', E'नगर शिक्षा समिति', E'जिल्ला शिक्षा समिति', E'D', E'**संस्थागत विद्यालयले दानका रूपमा चल-अचल सम्पत्ति प्राप्त गर्नुअघि जिल्ला शिक्षा समितिको स्वीकृति लिनुपर्दछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा ऐन, २०२८ अनुसार संस्थागत विद्यालयले कुनै व्यक्ति वा संघसंस्थाबाट दानका रूपमा कुनै किसिमको चल-अचल सम्पत्ति प्राप्त गर्नुअघि कसको स्वीकृति लिनुपर्ने व्यवस्था छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: शिक्षा ऐन, २०२८: शिक्षक व्यवस्था, समिति संरचना र विद्यालय प्रशासन (आधारभूत तह) (16 Q)
  v_set_id := extensions.uuid_generate_v5('d8a931d2-86a2-4fc7-9af4-fe1e50600df7'::uuid, E'शिक्षा ऐन, २०२८: शिक्षक व्यवस्था, समिति संरचना र विद्यालय प्रशासन (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '4e931234-3a51-422d-b861-caf5849aafc8'::uuid, 'd8a931d2-86a2-4fc7-9af4-fe1e50600df7'::uuid, E'शिक्षा ऐन, २०२८: शिक्षक व्यवस्था, समिति संरचना र विद्यालय प्रशासन (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'd8a931d2-86a2-4fc7-9af4-fe1e50600df7'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सामुदायिक विद्यालयको विद्यालय व्यवस्थापन समितिमा तलकामध्ये कुन सदस्य रहने व्यवस्था शिक्षा ऐनमा छैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'सामुदायिक विद्यालयको विद्यालय व्यवस्थापन समितिमा तलकामध्ये कुन सदस्य रहने व्यवस्था शिक्षा ऐनमा छैन?', E'सम्बन्धित क्षेत्रको विद्यालय निरीक्षक', E'शिक्षक प्रतिनिधि', E'अभिभावकले आफूमध्येबाट छानी पठाएको व्यक्ति', E'वडाध्यक्ष वा वडा समितिका सदस्य', E'A', E'**सम्बन्धित क्षेत्रको विद्यालय निरीक्षक विद्यालय व्यवस्थापन समितिको सदस्य रहने व्यवस्था छैन।**\\nनोट: सामुदायिक विद्यालयको व्यवस्थापन समितिमा ९ सदस्य र संस्थागत विद्यालयमा ७ सदस्य रहन्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सामुदायिक विद्यालयको विद्यालय व्यवस्थापन समितिमा तलकामध्ये कुन सदस्य रहने व्यवस्था शिक्षा ऐनमा छैन?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षक सेवा आयोगको सचिवको रूपमा कसले काम गर्ने व्यवस्था शिक्षा ऐनमा छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'शिक्षक सेवा आयोगको सचिवको रूपमा कसले काम गर्ने व्यवस्था शिक्षा ऐनमा छ?', E'आयोगको वरिष्ठ कर्मचारीले', E'नेपाल सरकारले तोकेको कर्मचारीले', E'आयोगले तोकेको कर्मचारीले', E'आयोगका अध्यक्षले तोकेको कर्मचारीले', E'B', E'**शिक्षक सेवा आयोगको सचिवको रूपमा नेपाल सरकारले तोकेको कर्मचारीले काम गर्दछन्।**\\nनोट: आयोगमा अध्यक्ष र एकजना महिलासहित अन्य दुईजना गरी जम्मा तीन सदस्य रहन्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षक सेवा आयोगको सचिवको रूपमा कसले काम गर्ने व्यवस्था शिक्षा ऐनमा छ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा ऐन, २०२८ मा उल्लेख भएको मुख्य शिक्षा समितिहरूमध्ये तलकामध्ये कुन पर्दैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'शिक्षा ऐन, २०२८ मा उल्लेख भएको मुख्य शिक्षा समितिहरूमध्ये तलकामध्ये कुन पर्दैन?', E'जिल्ला शिक्षा समिति', E'शिक्षा विकास कोष', E'मान्यता तथा समकक्षता निर्धारण समिति', E'गाउँ वा नगर शिक्षा समिति', E'C', E'**मान्यता तथा समकक्षता निर्धारण समिति शिक्षा ऐनमा उल्लिखित मुख्य शिक्षा समितिहरूमध्ये पर्दैन।**\\nनोट: अन्य मुख्य समितिहरूमा राष्ट्रिय परीक्षा बोर्ड, सामुदायिक तथा संस्थागत विद्यालय व्यवस्थापन समिति, राष्ट्रिय शिक्षा परिषद् र शिक्षक सेवा आयोग पर्दछन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा ऐन, २०२८ मा उल्लेख भएको मुख्य शिक्षा समितिहरूमध्ये तलकामध्ये कुन पर्दैन?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा ऐन, २०२८ (संशोधनसहित) अनुसार शिक्षकलाई पदबाट हटाउन सकिने व्यवस्था तलकामध्ये कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'शिक्षा ऐन, २०२८ (संशोधनसहित) अनुसार शिक्षकलाई पदबाट हटाउन सकिने व्यवस्था तलकामध्ये कुन हो?', E'राजनीतिक दलको कार्यकारिणी समितिमा सदस्य रहेको पाइएमा', E'पदीय दायित्व पूरा नगरेमा', E'माथिका सबै', E'कार्यालय समयमा अन्यत्र अध्यापन वा काम गरेमा', E'D', E'**कार्यालय समयमा अन्यत्र अध्यापन वा काम गरेमा शिक्षकलाई पदबाट हटाउन सकिन्छ।**\\nनोट: लगातार १५ दिनसम्म विद्यालयलाई जानकारी नगराई अनुपस्थित भएमा पनि यस्तै कारबाही हुन सक्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा ऐन, २०२८ (संशोधनसहित) अनुसार शिक्षकलाई पदबाट हटाउन सकिने व्यवस्था तलकामध्ये कुन हो?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा ऐन, २०२८ (संशोधनसहित) अनुसार एडहक पदमा कति सेवा अवधि पुगेको स्थायी शिक्षकलाई बढुवा गर्न सकिने व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'शिक्षा ऐन, २०२८ (संशोधनसहित) अनुसार एडहक पदमा कति सेवा अवधि पुगेको स्थायी शिक्षकलाई बढुवा गर्न सकिने व्यवस्था छ?', E'पाँच वर्ष', E'सात वर्ष', E'छ वर्ष', E'तीन वर्ष', E'A', E'**एडहक पदमा पाँच वर्ष सेवा अवधि पुगेको स्थायी शिक्षकलाई बढुवा गर्न सकिने व्यवस्था छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा ऐन, २०२८ (संशोधनसहित) अनुसार एडहक पदमा कति सेवा अवधि पुगेको स्थायी शिक्षकलाई बढुवा गर्न सकिने व्यवस्था छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा ऐन, २०२८ अनुसार ऐन कार्यान्वयनका लागि मन्त्रालयलाई निर्देशिका बनाउने अधिकार कुन दफाले दिएको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'शिक्षा ऐन, २०२८ अनुसार ऐन कार्यान्वयनका लागि मन्त्रालयलाई निर्देशिका बनाउने अधिकार कुन दफाले दिएको छ?', E'दफा १९ ख', E'दफा १९ क', E'दफा २१', E'दफा २०', E'B', E'**ऐन कार्यान्वयनका लागि मन्त्रालयलाई निर्देशिका बनाउने अधिकार दफा १९ क ले दिएको छ।**\\nनोट: बाधा अड्काउ फुकाउने अधिकार भने दफा २० ले नेपाल सरकारलाई दिएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा ऐन, २०२८ अनुसार ऐन कार्यान्वयनका लागि मन्त्रालयलाई निर्देशिका बनाउने अधिकार कुन दफाले दिएको छ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा ऐन, २०२८ (संशोधनसहित) अनुसार सरुवा हुन चाहने शिक्षकले निवेदन कहाँ दिनुपर्ने व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'शिक्षा ऐन, २०२८ (संशोधनसहित) अनुसार सरुवा हुन चाहने शिक्षकले निवेदन कहाँ दिनुपर्ने व्यवस्था छ?', E'शिक्षा विकास निर्देशनालयमा', E'विद्यालयमा', E'शिक्षा विकास तथा समन्वय इकाइमा', E'स्थानीय तहमा', E'C', E'**सरुवा हुन चाहने शिक्षकले शिक्षा विकास तथा समन्वय इकाइमा निवेदन दिनुपर्दछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा ऐन, २०२८ (संशोधनसहित) अनुसार सरुवा हुन चाहने शिक्षकले निवेदन कहाँ दिनुपर्ने व्यवस्था छ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा ऐन, २०२८ (संशोधनसहित) अनुसार शैक्षिक गुणस्तर परीक्षण केन्द्रको प्रमुखको नियुक्तिका लागि नेपाल सरकारलाई सिफारिस गर्ने समितिमा तलकामध्ये को पर्दैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'शिक्षा ऐन, २०२८ (संशोधनसहित) अनुसार शैक्षिक गुणस्तर परीक्षण केन्द्रको प्रमुखको नियुक्तिका लागि नेपाल सरकारलाई सिफारिस गर्ने समितिमा तलकामध्ये को पर्दैन?', E'लोकसेवा आयोगको अध्यक्ष', E'शिक्षा सचिव', E'राष्ट्रिय योजना आयोगको शिक्षा हेर्ने सदस्य', E'त्रिभुवन विश्वविद्यालयको उपकुलपति', E'D', E'**त्रिभुवन विश्वविद्यालयको उपकुलपति शैक्षिक गुणस्तर परीक्षण केन्द्रको प्रमुख सिफारिस समितिमा पर्दैनन्।**\\nनोट: यो तीन सदस्यीय समिति हो, जसमा लोकसेवा आयोगको अध्यक्ष नै अध्यक्ष रहन्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा ऐन, २०२८ (संशोधनसहित) अनुसार शैक्षिक गुणस्तर परीक्षण केन्द्रको प्रमुखको नियुक्तिका लागि नेपाल सरकारलाई सिफारिस गर्ने समितिमा तलकामध्ये को पर्दैन?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा ऐन, २०२८ (संशोधनसहित) अनुसार राष्ट्रिय परीक्षा बोर्डको अध्यक्षको नियुक्तिका लागि गठित सिफारिस समितिको अध्यक्ष को हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'शिक्षा ऐन, २०२८ (संशोधनसहित) अनुसार राष्ट्रिय परीक्षा बोर्डको अध्यक्षको नियुक्तिका लागि गठित सिफारिस समितिको अध्यक्ष को हुन्छ?', E'लोकसेवा आयोगको अध्यक्ष', E'त्रिभुवन विश्वविद्यालयको उपकुलपति', E'राष्ट्रिय योजना आयोगको सदस्य (शिक्षा)', E'मन्त्रालयको सचिव', E'A', E'**राष्ट्रिय परीक्षा बोर्डको अध्यक्ष सिफारिस समितिको अध्यक्ष लोकसेवा आयोगको अध्यक्ष हुन्छन्।**\\nनोट: यसमा ख्याति प्राप्त शिक्षाविद्हरूमध्येबाट मन्त्रालयले मनोनीत गरेका एकजना महिलासहित दुई सदस्य पनि रहन्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा ऐन, २०२८ (संशोधनसहित) अनुसार राष्ट्रिय परीक्षा बोर्डको अध्यक्षको नियुक्तिका लागि गठित सिफारिस समितिको अध्यक्ष को हुन्छ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विकट हिमाली क्षेत्रमा पुनः विद्यालय सञ्चालन गर्न सक्ने अधिकार शिक्षा ऐन, २०२८ संशोधनबमोजिम कसलाई दिएको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'विकट हिमाली क्षेत्रमा पुनः विद्यालय सञ्चालन गर्न सक्ने अधिकार शिक्षा ऐन, २०२८ संशोधनबमोजिम कसलाई दिएको छ?', E'सम्बन्धित जिल्लाको शिक्षा विकास तथा समन्वय एकाइ', E'नेपाल सरकार', E'शिक्षा तथा मानव स्रोत विकास केन्द्र', E'शिक्षा, विज्ञान तथा प्रविधि मन्त्रालय', E'B', E'**विकट हिमाली क्षेत्रमा पुनः विद्यालय सञ्चालन गर्न सक्ने अधिकार नेपाल सरकारलाई दिइएको छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विकट हिमाली क्षेत्रमा पुनः विद्यालय सञ्चालन गर्न सक्ने अधिकार शिक्षा ऐन, २०२८ संशोधनबमोजिम कसलाई दिएको छ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा ऐन, २०२८ अनुसार संस्थागत विद्यालयले प्रत्येक वर्ष तोकिएबमोजिमको विवरणसहित प्रगति विवरण कहाँ पेश गर्नुपर्ने व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'शिक्षा ऐन, २०२८ अनुसार संस्थागत विद्यालयले प्रत्येक वर्ष तोकिएबमोजिमको विवरणसहित प्रगति विवरण कहाँ पेश गर्नुपर्ने व्यवस्था छ?', E'गाउँ वा नगरपालिका', E'वडा समिति', E'शिक्षा विकास तथा समन्वय इकाई', E'शिक्षा प्रशासन कार्यालय', E'C', E'**संस्थागत विद्यालयले प्रत्येक वर्ष प्रगति विवरण शिक्षा विकास तथा समन्वय इकाईमा पेश गर्नुपर्दछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा ऐन, २०२८ अनुसार संस्थागत विद्यालयले प्रत्येक वर्ष तोकिएबमोजिमको विवरणसहित प्रगति विवरण कहाँ पेश गर्नुपर्ने व्यवस्था छ?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'आफ्नो खर्चमा पूर्व-प्राथमिक विद्यालय खोल्ने स्वीकृति वा अनुमति कसले दिने व्यवस्था शिक्षा ऐनमा गरिएको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'आफ्नो खर्चमा पूर्व-प्राथमिक विद्यालय खोल्ने स्वीकृति वा अनुमति कसले दिने व्यवस्था शिक्षा ऐनमा गरिएको छ?', E'वडा कार्यालय', E'विद्यालय निरीक्षक', E'शिक्षा विकास तथा समन्वय इकाई प्रमुख', E'गाउँपालिका वा नगरपालिका', E'D', E'**पूर्व-प्राथमिक विद्यालय खोल्ने स्वीकृति वा अनुमति गाउँपालिका वा नगरपालिकाले दिने व्यवस्था छ।**\\nनोट: आधारभूत विद्यालय खोल्नका लागि भने गाउँपालिका वा नगरपालिकाले सिफारिस गर्ने व्यवस्था छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:आफ्नो खर्चमा पूर्व-प्राथमिक विद्यालय खोल्ने स्वीकृति वा अनुमति कसले दिने व्यवस्था शिक्षा ऐनमा गरिएको छ?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा ऐन, २०२८ (संशोधनसहित) अनुसार शिक्षक सेवा आयोगको अध्यक्ष र सदस्यको सिफारिस गर्न गठित समितिको अध्यक्ष को रहने व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'शिक्षा ऐन, २०२८ (संशोधनसहित) अनुसार शिक्षक सेवा आयोगको अध्यक्ष र सदस्यको सिफारिस गर्न गठित समितिको अध्यक्ष को रहने व्यवस्था छ?', E'लोकसेवा आयोगको अध्यक्ष', E'विश्वविद्यालयको उपकुलपति', E'शिक्षा सचिव', E'शिक्षामन्त्री र निजले तोकेको व्यक्ति', E'A', E'**शिक्षक सेवा आयोगको अध्यक्ष र सदस्यको सिफारिस समितिको अध्यक्ष लोकसेवा आयोगको अध्यक्ष हुन्छन्।**\\nनोट: यस समितिमा विश्वविद्यालयको उपकुलपति र शिक्षा सचिव सदस्य रहन्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा ऐन, २०२८ (संशोधनसहित) अनुसार शिक्षक सेवा आयोगको अध्यक्ष र सदस्यको सिफारिस गर्न गठित समितिको अध्यक्ष को रहने व्यवस्था छ?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा ऐन, २०२८ अनुसार सामुदायिक विद्यालयमा कार्यरत शिक्षक वा कर्मचारीले स्थायी अनुमतिपत्र बिना तीन वर्षभन्दा माथि सेवा गरेको भए त्यस्तो शिक्षक वा कर्मचारीलाई कस्तो कारबाही गरिने व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'शिक्षा ऐन, २०२८ अनुसार सामुदायिक विद्यालयमा कार्यरत शिक्षक वा कर्मचारीले स्थायी अनुमतिपत्र बिना तीन वर्षभन्दा माथि सेवा गरेको भए त्यस्तो शिक्षक वा कर्मचारीलाई कस्तो कारबाही गरिने व्यवस्था छ?', E'भविष्यमा अयोग्य ठहरिने गरी सेवाबाट बर्खास्त गरिने', E'भविष्यमा अयोग्य नठहरिने गरी सेवाबाट बर्खास्त गरिने', E'कुनै पनि किसिमको कारबाही नगरिने', E'आफैंले लिएको अनुमति परित्याग गरेमा कारबाही नगरिने', E'B', E'**स्थायी अनुमतिपत्र बिना तीन वर्षभन्दा माथि सेवा गरेको शिक्षक वा कर्मचारीलाई भविष्यमा अयोग्य नठहरिने गरी सेवाबाट बर्खास्त गरिने व्यवस्था छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा ऐन, २०२८ अनुसार सामुदायिक विद्यालयमा कार्यरत शिक्षक वा कर्मचारीले स्थायी अनुमतिपत्र बिना तीन वर्षभन्दा माथि सेवा गरेको भए त्यस्तो शिक्षक वा कर्मचारीलाई कस्तो कारबाही गरिने व्यवस्था छ?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा ऐन, २०२८ (संशोधनसहित) अनुसार राष्ट्रिय परीक्षा बोर्डको उपाध्यक्ष हुन आवश्यक योग्यता तलकामध्ये कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'शिक्षा ऐन, २०२८ (संशोधनसहित) अनुसार राष्ट्रिय परीक्षा बोर्डको उपाध्यक्ष हुन आवश्यक योग्यता तलकामध्ये कुन हो?', E'शिक्षा तथा परीक्षा क्षेत्रमा कम्तीमा पाँच वर्षको अनुभव', E'दुई वर्षदेखि कुनै राजनीतिक दलको सदस्य नरहेको', E'कुनै पनि होइन', E'स्नातकोत्तर उपाधि उत्तीर्ण', E'C', E'**राष्ट्रिय परीक्षा बोर्डको उपाध्यक्षका लागि छुट्टै योग्यता तोकिएको छैन — उपाध्यक्ष पदमा मन्त्रालयको सचिव नै रहने व्यवस्था छ।**\\nनोट: बोर्डको अध्यक्ष हुनका लागि भने स्नातकोत्तर उपाधि र शिक्षा-परीक्षा क्षेत्रमा कम्तीमा १२ वर्षको अनुभव आवश्यक पर्दछ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा ऐन, २०२८ (संशोधनसहित) अनुसार राष्ट्रिय परीक्षा बोर्डको उपाध्यक्ष हुन आवश्यक योग्यता तलकामध्ये कुन हो?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'स्थानीय निकाय वा व्यवस्थापन समितिले कुनै सामुदायिक विद्यालयको व्यवस्थापन जिम्मा लिन चाहेमा आवश्यक कागजातसहित कहाँ निवेदन दिनुपर्ने व्यवस्था शिक्षा ऐन, २०२८ ले गरेको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'स्थानीय निकाय वा व्यवस्थापन समितिले कुनै सामुदायिक विद्यालयको व्यवस्थापन जिम्मा लिन चाहेमा आवश्यक कागजातसहित कहाँ निवेदन दिनुपर्ने व्यवस्था शिक्षा ऐन, २०२८ ले गरेको छ?', E'शिक्षा, विज्ञान तथा प्रविधि मन्त्रालय समक्ष', E'गाउँ वा नगरपालिका समक्ष', E'शिक्षा तथा मानव स्रोत विकास केन्द्र समक्ष', E'सरकारले तोकेको अधिकारी समक्ष', E'D', E'**यस्तो निवेदन सरकारले तोकेको अधिकारी समक्ष दिनुपर्दछ।**\\nनोट: सामुदायिक विद्यालयको व्यवस्थापन समिति विघटन गर्ने अधिकार जिल्ला शिक्षा समितिलाई छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:स्थानीय निकाय वा व्यवस्थापन समितिले कुनै सामुदायिक विद्यालयको व्यवस्थापन जिम्मा लिन चाहेमा आवश्यक कागजातसहित कहाँ निवेदन दिनुपर्ने व्यवस्था शिक्षा ऐन, २०२८ ले गरेको छ?'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  RAISE NOTICE 'Unit घ-२ upsert complete: 2 sets, 24 questions.';
END $$;
