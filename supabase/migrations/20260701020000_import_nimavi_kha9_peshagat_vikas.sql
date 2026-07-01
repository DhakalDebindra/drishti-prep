-- Idempotent UPSERT import: निमावि प्रथम पत्र — unit ख-९ शिक्षक पेशागत विकास र शैक्षिक अनुसन्धान
-- Adds Level I sets alongside preserved model sets. Override same-identity; never deletes. Generated 2026-07-01T15:35:53.501Z.
DO $$
DECLARE
  v_module_id uuid := '6695669a-f40e-421a-a4ec-b09bbeaf56c4'::uuid;
  v_set_id uuid;
  v_q_id uuid;
BEGIN

  -- Set: शिक्षक तालिमको ऐतिहासिक विकासक्रम (आधारभूत तह) (18 Q)
  v_set_id := extensions.uuid_generate_v5('5031ae33-4e11-461b-aa7a-d2670e908b30'::uuid, E'शिक्षक तालिमको ऐतिहासिक विकासक्रम (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'f7ab6c7c-21c8-4214-baf0-ec92ef9ac5d9'::uuid, '5031ae33-4e11-461b-aa7a-d2670e908b30'::uuid, E'शिक्षक तालिमको ऐतिहासिक विकासक्रम (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '5031ae33-4e11-461b-aa7a-d2670e908b30'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विश्वकै पहिलो शिक्षक प्रशिक्षण कक्षा सन् १६७२ मा कुन देशमा सञ्चालन भएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'विश्वकै पहिलो शिक्षक प्रशिक्षण कक्षा सन् १६७२ मा कुन देशमा सञ्चालन भएको थियो?', E'फ्रान्स', E'जर्मनी', E'अमेरिका', E'डेनमार्क', E'A', E'**सन् १६७२ मा फ्रान्सको लाइयनमा विश्वकै पहिलो शिक्षक प्रशिक्षण कक्षा सञ्चालन भएको थियो।**\\nनोट: सन् १७८९ मा डेनमार्कले राज्यस्तरबाट पहिलो शिक्षक प्रशिक्षण केन्द्र स्थापना गर्‍यो र सन् १८३६ मा अमेरिकामा नर्मल स्कुल स्थापना भयो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विश्वकै पहिलो शिक्षक प्रशिक्षण कक्षा सन् १६७२ मा कुन देशमा सञ्चालन भएको थियो?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षक तालिमको अवधारणालाई प्रचार गर्ने पहिलो विद्वान् (शिक्षक तालिमका पिता) का रूपमा कसलाई मानिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'शिक्षक तालिमको अवधारणालाई प्रचार गर्ने पहिलो विद्वान् (शिक्षक तालिमका पिता) का रूपमा कसलाई मानिन्छ?', E'जोन डिवी', E'पेस्तालोजी', E'हर्बर्ट', E'फ्रोबेल', E'B', E'**पेस्तालोजीलाई शिक्षक तालिमको अवधारणा प्रचार गर्ने पहिलो विद्वान् (शिक्षक तालिमका पिता) मानिन्छ।**\\n- जोन डिवी अनुभवमूलक शिक्षा र प्रयोजनवादका प्रवर्तक हुन्।\\n- हर्बर्ट शिक्षणका पाँच पदहरूका प्रवर्तक हुन्।\\n- फ्रोबेल किन्डरगार्टेन (बालोद्यान) शिक्षाका जनक हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षक तालिमको अवधारणालाई प्रचार गर्ने पहिलो विद्वान् (शिक्षक तालिमका पिता) का रूपमा कसलाई मानिन्छ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालमा आधार स्कुलमा पढाउने शिक्षक तयार गर्न पहिलो शिक्षक शिक्षण केन्द्र कहिले र कहाँ स्थापना भएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'नेपालमा आधार स्कुलमा पढाउने शिक्षक तयार गर्न पहिलो शिक्षक शिक्षण केन्द्र कहिले र कहाँ स्थापना भएको थियो?', E'वि.सं. २०१३ भदौ २४, कीर्तिपुर', E'वि.सं. २०११ भाद्र २४, कीर्तिपुर', E'वि.सं. २००४ जेठ १०, ताहाचल', E'वि.सं. २०२३, काठमाडौं', E'C', E'**नेपालको पहिलो शिक्षक शिक्षण केन्द्र वि.सं. २००४ जेठ १० मा ताहाचलमा स्थापना भएको थियो।**\\nनोट: यही केन्द्रलाई वि.सं. २०११ भाद्र २४ बाट राष्ट्रिय शिक्षक शिक्षण केन्द्रमा रूपान्तरण गरियो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालमा आधार स्कुलमा पढाउने शिक्षक तयार गर्न पहिलो शिक्षक शिक्षण केन्द्र कहिले र कहाँ स्थापना भएको थियो?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वि.सं. २०११ भाद्र २४ देखि आधार शिक्षक शिक्षण केन्द्रलाई कुन नाममा रूपान्तरण गरियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'वि.सं. २०११ भाद्र २४ देखि आधार शिक्षक शिक्षण केन्द्रलाई कुन नाममा रूपान्तरण गरियो?', E'प्राथमिक शिक्षक तालिम केन्द्र', E'शैक्षिक जनशक्ति विकास केन्द्र', E'कलेज अफ एजुकेसन', E'राष्ट्रिय शिक्षक शिक्षण केन्द्र', E'D', E'**वि.सं. २०११ भाद्र २४ देखि आधार शिक्षक शिक्षण केन्द्रलाई राष्ट्रिय शिक्षक शिक्षण केन्द्रमा रूपान्तरण गरियो।**\\n- कलेज अफ एजुकेसनको स्थापना छुट्टै रूपमा वि.सं. २०१३ मा भएको थियो।\\n- प्राथमिक शिक्षक तालिम केन्द्रको स्थापना वि.सं. २०२३ मा भयो।\\n- शैक्षिक जनशक्ति विकास केन्द्रको स्थापना वि.सं. २०५० मा भयो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वि.सं. २०११ भाद्र २४ देखि आधार शिक्षक शिक्षण केन्द्रलाई कुन नाममा रूपान्तरण गरियो?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'माध्यमिक विद्यालय शिक्षक, प्रधानाध्यापक, शिक्षा निरीक्षक र शिक्षा प्रशासक तयार पार्ने उद्देश्यले कलेज अफ एजुकेसनको स्थापना कहिले भएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'माध्यमिक विद्यालय शिक्षक, प्रधानाध्यापक, शिक्षा निरीक्षक र शिक्षा प्रशासक तयार पार्ने उद्देश्यले कलेज अफ एजुकेसनको स्थापना कहिले भएको थियो?', E'वि.सं. २०१३।०५।२४', E'वि.सं. २०२३', E'वि.सं. २०११ भाद्र २४', E'वि.सं. २०५०', E'A', E'**कलेज अफ एजुकेसनको स्थापना वि.सं. २०१३।०५।२४ मा भएको थियो।**\\nनोट: यसले पछि वि.सं. २०२९ साउनदेखि त्रिभुवन विश्वविद्यालयको शिक्षाशास्त्र अध्ययन संस्थानअन्तर्गत गाभिने व्यवस्था भयो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:माध्यमिक विद्यालय शिक्षक, प्रधानाध्यापक, शिक्षा निरीक्षक र शिक्षा प्रशासक तयार पार्ने उद्देश्यले कलेज अफ एजुकेसनको स्थापना कहिले भएको थियो?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वि.सं. २०२९ साउनदेखि कलेज अफ एजुकेसन कुन विश्वविद्यालयअन्तर्गत गाभियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'वि.सं. २०२९ साउनदेखि कलेज अफ एजुकेसन कुन विश्वविद्यालयअन्तर्गत गाभियो?', E'पूर्वाञ्चल विश्वविद्यालय', E'त्रिभुवन विश्वविद्यालय', E'काठमाडौं विश्वविद्यालय', E'पोखरा विश्वविद्यालय', E'B', E'**कलेज अफ एजुकेसन वि.सं. २०२९ साउनदेखि त्रिभुवन विश्वविद्यालयको शिक्षाशास्त्र अध्ययन संस्थानअन्तर्गत गाभियो।**\\nनोट: वि.सं. २०४३ मा यही शिक्षाशास्त्र अध्ययन संस्थानलाई शिक्षाशास्त्र संकायमा परिणत गरियो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वि.सं. २०२९ साउनदेखि कलेज अफ एजुकेसन कुन विश्वविद्यालयअन्तर्गत गाभियो?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वि.सं. २०२३ मा शिक्षा मन्त्रालयअन्तर्गत कुन तालिम केन्द्रको स्थापना भएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'वि.सं. २०२३ मा शिक्षा मन्त्रालयअन्तर्गत कुन तालिम केन्द्रको स्थापना भएको थियो?', E'शैक्षिक जनशक्ति विकास केन्द्र', E'राष्ट्रिय शिक्षक शिक्षण केन्द्र', E'प्राथमिक शिक्षक तालिम केन्द्र', E'राष्ट्रिय व्यावसायिक प्रशिक्षण केन्द्र', E'C', E'**वि.सं. २०२३ मा शिक्षा मन्त्रालयअन्तर्गत प्राथमिक शिक्षक तालिम केन्द्रको स्थापना भएको थियो।**\\n- राष्ट्रिय शिक्षक शिक्षण केन्द्र यसभन्दा पहिले नै वि.सं. २०११ मा स्थापना भइसकेको थियो।\\n- राष्ट्रिय व्यावसायिक प्रशिक्षण केन्द्रको स्थापना सानोठिमी भक्तपुरमा वि.सं. २०२४।०२।२९ मा भयो।\\n- शैक्षिक जनशक्ति विकास केन्द्रको स्थापना पछि वि.सं. २०५० मा भयो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वि.सं. २०२३ मा शिक्षा मन्त्रालयअन्तर्गत कुन तालिम केन्द्रको स्थापना भएको थियो?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'राष्ट्रिय शिक्षक सेवा आयोगको स्थापना कहिले भएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'राष्ट्रिय शिक्षक सेवा आयोगको स्थापना कहिले भएको थियो?', E'वि.सं. २०६२', E'वि.सं. २०७५', E'वि.सं. २०५०', E'वि.सं. २०५६', E'D', E'**राष्ट्रिय शिक्षक सेवा आयोगको स्थापना वि.सं. २०५६ मा भएको थियो।**\\nनोट: यसको ६ वर्षपछि वि.सं. २०६२ जेठ २४ मा शिक्षक तालिम नीति स्वीकृत भयो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:राष्ट्रिय शिक्षक सेवा आयोगको स्थापना कहिले भएको थियो?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षक तालिम नीति कहिले स्वीकृत भएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'शिक्षक तालिम नीति कहिले स्वीकृत भएको थियो?', E'वि.सं. २०६२ जेठ २४', E'वि.सं. २०५६', E'वि.सं. २०५८', E'वि.सं. २०६१', E'A', E'**शिक्षक तालिम नीति वि.सं. २०६२ जेठ २४ मा स्वीकृत भएको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षक तालिम नीति कहिले स्वीकृत भएको थियो?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा ऐन, २०२८ को कुन संशोधनले शिक्षक हुनका लागि तालिम अनिवार्य गर्‍यो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'शिक्षा ऐन, २०२८ को कुन संशोधनले शिक्षक हुनका लागि तालिम अनिवार्य गर्‍यो?', E'सातौँ संशोधन', E'पाँचौँ संशोधन', E'पहिलो संशोधन', E'तेस्रो संशोधन', E'B', E'**शिक्षा ऐन, २०२८ को पाँचौँ संशोधनले शिक्षक हुनका लागि तालिम अनिवार्य गर्‍यो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा ऐन, २०२८ को कुन संशोधनले शिक्षक हुनका लागि तालिम अनिवार्य गर्‍यो?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वि.सं. २०३५ सालमा स्थापना भएको रेडियो शिक्षा शिक्षक तालिम आयोजनालाई वि.सं. २०५० साउन १ बाट कुन नाममा रूपान्तरण गरियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'वि.सं. २०३५ सालमा स्थापना भएको रेडियो शिक्षा शिक्षक तालिम आयोजनालाई वि.सं. २०५० साउन १ बाट कुन नाममा रूपान्तरण गरियो?', E'राष्ट्रिय शिक्षक शिक्षण केन्द्र', E'शिक्षा तालिम केन्द्र', E'दूर शिक्षा केन्द्र', E'शैक्षिक जनशक्ति विकास केन्द्र', E'C', E'**रेडियो शिक्षा शिक्षक तालिम आयोजनालाई वि.सं. २०५० साउन १ बाट दूर शिक्षा केन्द्रमा रूपान्तरण गरियो।**\\nनोट: सोही वर्ष शैक्षिक जनशक्ति विकास केन्द्रको पनि छुट्टै स्थापना भएको थियो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वि.सं. २०३५ सालमा स्थापना भएको रेडियो शिक्षा शिक्षक तालिम आयोजनालाई वि.सं. २०५० साउन १ बाट कुन नाममा रूपान्तरण गरियो?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शैक्षिक जनशक्ति विकास केन्द्रको स्थापना कहिले भएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'शैक्षिक जनशक्ति विकास केन्द्रको स्थापना कहिले भएको थियो?', E'वि.सं. २०७५', E'वि.सं. २०५६', E'वि.सं. २०६१', E'वि.सं. २०५०/०४/०१', E'D', E'**शैक्षिक जनशक्ति विकास केन्द्रको स्थापना वि.सं. २०५०/०४/०१ मा भएको थियो।**\\nनोट: यसैलाई वि.सं. २०६१ मा नाम परिवर्तन गरी शैक्षिक तालिम केन्द्र बनाइयो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शैक्षिक जनशक्ति विकास केन्द्रको स्थापना कहिले भएको थियो?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा क्षेत्रमा कार्यरत जनशक्तिको सेवाकालीन तालिममार्फत् पेसागत कार्यदक्षता विकासका लागि छाता संगठनका रूपमा शैक्षिक जनशक्ति विकास केन्द्र स्थापना गर्न कुन आयोगले सिफारिस गरेको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'शिक्षा क्षेत्रमा कार्यरत जनशक्तिको सेवाकालीन तालिममार्फत् पेसागत कार्यदक्षता विकासका लागि छाता संगठनका रूपमा शैक्षिक जनशक्ति विकास केन्द्र स्थापना गर्न कुन आयोगले सिफारिस गरेको थियो?', E'राष्ट्रिय शिक्षा आयोग २०४९', E'शिक्षा सुधार आयोग २०७२', E'उच्च स्तरीय राष्ट्रिय शिक्षा आयोग २०५५', E'राष्ट्रिय शिक्षा पद्दतिको योजना आयोग २०२८', E'A', E'**राष्ट्रिय शिक्षा आयोग, २०४९ को सिफारिसअनुसार वि.सं. २०५०/०४/०१ मा शैक्षिक जनशक्ति विकास केन्द्रको स्थापना भएको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा क्षेत्रमा कार्यरत जनशक्तिको सेवाकालीन तालिममार्फत् पेसागत कार्यदक्षता विकासका लागि छाता संगठनका रूपमा शैक्षिक जनशक्ति विकास केन्द्र स्थापना गर्न कुन आयोगले सिफारिस गरेको थियो?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वि.सं. २०६१ सालमा शैक्षिक जनशक्ति विकास केन्द्रलाई नाम परिवर्तन गरी के बनाइयो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'वि.सं. २०६१ सालमा शैक्षिक जनशक्ति विकास केन्द्रलाई नाम परिवर्तन गरी के बनाइयो?', E'प्रादेशिक शिक्षा तालिम केन्द्र', E'शैक्षिक तालिम केन्द्र', E'शिक्षा तथा मानव स्रोत विकास केन्द्र', E'राष्ट्रिय शिक्षक शिक्षण केन्द्र', E'B', E'**वि.सं. २०६१ सालमा शैक्षिक जनशक्ति विकास केन्द्रलाई नाम परिवर्तन गरी शैक्षिक तालिम केन्द्र बनाइयो।**\\nनोट: सङ्घीयता कार्यान्वयनपछि यही संरचना शिक्षा तथा मानव स्रोत विकास केन्द्रमा रूपान्तरण भयो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वि.सं. २०६१ सालमा शैक्षिक जनशक्ति विकास केन्द्रलाई नाम परिवर्तन गरी के बनाइयो?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सङ्घीयता कार्यान्वयनसँगै वि.सं. २०७५ मा देशभर रहेका २९ ओटा शैक्षिक तालिम केन्द्रहरू खारेज गरी सात प्रदेशमा कति ओटा शिक्षा तालिम केन्द्र कायम गरियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'सङ्घीयता कार्यान्वयनसँगै वि.सं. २०७५ मा देशभर रहेका २९ ओटा शैक्षिक तालिम केन्द्रहरू खारेज गरी सात प्रदेशमा कति ओटा शिक्षा तालिम केन्द्र कायम गरियो?', E'९ ओटा', E'५ ओटा', E'७ ओटा', E'११ ओटा', E'C', E'**वि.सं. २०७५ मा सात प्रदेशमा ७ ओटा प्रादेशिक शिक्षा तालिम केन्द्र कायम गरियो।**\\nनोट: मुलुकभर सञ्चालनमा रहेका १,०५३ ओटा स्रोतकेन्द्र र ४६ ओटा अगुवा स्रोतकेन्द्र समेत यही क्रममा खारेज भए।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सङ्घीयता कार्यान्वयनसँगै वि.सं. २०७५ मा देशभर रहेका २९ ओटा शैक्षिक तालिम केन्द्रहरू खारेज गरी सात प्रदेशमा कति ओटा शिक्षा तालिम केन्द्र कायम गरियो?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'गण्डकी प्रदेशको प्रादेशिक शिक्षा तालिम केन्द्र कुन जिल्लामा स्थापना गरिएको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'गण्डकी प्रदेशको प्रादेशिक शिक्षा तालिम केन्द्र कुन जिल्लामा स्थापना गरिएको छ?', E'रूपन्देही', E'काभ्रे', E'सुर्खेत', E'तनहुँ', E'D', E'**गण्डकी प्रदेशको शिक्षा तालिम केन्द्र तनहुँ जिल्लामा रहेको छ।**\\n- लुम्बिनी प्रदेशको शिक्षा तालिम केन्द्र रूपन्देहीमा छ।\\n- बागमती प्रदेशको शिक्षा तालिम केन्द्र काभ्रेमा छ।\\n- कर्णाली प्रदेशको शिक्षा तालिम केन्द्र सुर्खेतमा छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:गण्डकी प्रदेशको प्रादेशिक शिक्षा तालिम केन्द्र कुन जिल्लामा स्थापना गरिएको छ?'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कोशी प्रदेशको प्रादेशिक शिक्षा तालिम केन्द्र कुन जिल्लामा स्थापना गरिएको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'कोशी प्रदेशको प्रादेशिक शिक्षा तालिम केन्द्र कुन जिल्लामा स्थापना गरिएको छ?', E'सुनसरी', E'बारा', E'डोटी', E'तनहुँ', E'A', E'**कोशी प्रदेशको शिक्षा तालिम केन्द्र सुनसरी जिल्लामा रहेको छ।**\\n- मधेश प्रदेशको शिक्षा तालिम केन्द्र बारामा छ।\\n- सुदूरपश्चिम प्रदेशको शिक्षा तालिम केन्द्र डोटीमा छ।\\n- गण्डकी प्रदेशको शिक्षा तालिम केन्द्र तनहुँमा छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कोशी प्रदेशको प्रादेशिक शिक्षा तालिम केन्द्र कुन जिल्लामा स्थापना गरिएको छ?'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'हाल मुलुकभर जम्मा कति ओटा शिक्षा तालिम केन्द्रहरू मात्र कायम रहेकाले शिक्षक तालिममा सबैको पहुँच सुनिश्चित गर्ने कार्य चुनौतीपूर्ण मानिएको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'हाल मुलुकभर जम्मा कति ओटा शिक्षा तालिम केन्द्रहरू मात्र कायम रहेकाले शिक्षक तालिममा सबैको पहुँच सुनिश्चित गर्ने कार्य चुनौतीपूर्ण मानिएको छ?', E'२९ ओटा', E'७ ओटा', E'५ ओटा', E'९ ओटा', E'B', E'**हाल मुलुकभर जम्मा ७ ओटा मात्र शिक्षा तालिम केन्द्रहरू कायम रहेका छन्।**\\nनोट: सङ्घीयता कार्यान्वयनअघि २९ ओटा शैक्षिक तालिम केन्द्रहरू सञ्चालनमा थिए।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:हाल मुलुकभर जम्मा कति ओटा शिक्षा तालिम केन्द्रहरू मात्र कायम रहेकाले शिक्षक तालिममा सबैको पहुँच सुनिश्चित गर्ने कार्य चुनौतीपूर्ण मानिएको छ?'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: शिक्षक सक्षमता प्रारूप र वृत्ति विकास (आधारभूत तह) (13 Q)
  v_set_id := extensions.uuid_generate_v5('5031ae33-4e11-461b-aa7a-d2670e908b30'::uuid, E'शिक्षक सक्षमता प्रारूप र वृत्ति विकास (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'f7ab6c7c-21c8-4214-baf0-ec92ef9ac5d9'::uuid, '5031ae33-4e11-461b-aa7a-d2670e908b30'::uuid, E'शिक्षक सक्षमता प्रारूप र वृत्ति विकास (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '5031ae33-4e11-461b-aa7a-d2670e908b30'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षक सक्षमता प्रारूप र शिक्षक पेसागत विकास प्रारूप कहिले स्वीकृत भएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'शिक्षक सक्षमता प्रारूप र शिक्षक पेसागत विकास प्रारूप कहिले स्वीकृत भएको थियो?', E'२०५०/०४/०१', E'२०८०/०७/१२', E'२०७२/१२/०३', E'२०७५/०१/०१', E'C', E'**शिक्षकको सक्षमता प्रारूप २०७२ र शिक्षकको पेसागत विकास प्रारूप २०७२ दुवै २०७२/१२/०३ मा स्वीकृत भएका थिए।**\\nनोट: यही प्रारूपको परिमार्जित संस्करण पछि २०८०/०७/१२ मा स्वीकृत भयो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षक सक्षमता प्रारूप र शिक्षक पेसागत विकास प्रारूप कहिले स्वीकृत भएको थियो?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षक पेसागत विकास प्रारूपको परिमार्जित संस्करण कहिले स्वीकृत भएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'शिक्षक पेसागत विकास प्रारूपको परिमार्जित संस्करण कहिले स्वीकृत भएको थियो?', E'२०७२/१२/०३', E'२०७५/०६/१०', E'२०७८/०३/१५', E'२०८०/०७/१२', E'D', E'**शिक्षक पेसागत विकास प्रारूप, २०८० (परिमार्जित संस्करण) २०८०/०७/१२ मा स्वीकृत भएको हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षक पेसागत विकास प्रारूपको परिमार्जित संस्करण कहिले स्वीकृत भएको थियो?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षक सक्षमता प्रारूप, २०७२ ले शिक्षकका कति ओटा सक्षमताहरू निर्धारण गरेको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'शिक्षक सक्षमता प्रारूप, २०७२ ले शिक्षकका कति ओटा सक्षमताहरू निर्धारण गरेको छ?', E'८ ओटा', E'१० ओटा', E'६ ओटा', E'७ ओटा', E'A', E'**शिक्षक सक्षमता प्रारूप, २०७२ ले शिक्षकका आठ ओटा सक्षमताहरू निर्धारण गरेको छ।**\\nनोट: यी ८ सक्षमतालाई थप ३९ ओटा उपसक्षमतामा विस्तार गरिएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षक सक्षमता प्रारूप, २०७२ ले शिक्षकका कति ओटा सक्षमताहरू निर्धारण गरेको छ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षक सक्षमता प्रारूप, २०७२ अनुसार शिक्षकका ८ सक्षमताहरूलाई कति ओटा उपसक्षमतामा विस्तार गरिएको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'शिक्षक सक्षमता प्रारूप, २०७२ अनुसार शिक्षकका ८ सक्षमताहरूलाई कति ओटा उपसक्षमतामा विस्तार गरिएको छ?', E'५० ओटा', E'३९ ओटा', E'२५ ओटा', E'४५ ओटा', E'B', E'**शिक्षकका ८ सक्षमतालाई ३९ ओटा उपसक्षमतामा विस्तार गरिएको छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षक सक्षमता प्रारूप, २०७२ अनुसार शिक्षकका ८ सक्षमताहरूलाई कति ओटा उपसक्षमतामा विस्तार गरिएको छ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षक सक्षमता प्रारूप, २०७२ अनुसार निम्नमध्ये कुन शिक्षकको आठ सक्षमतामध्ये पर्दैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'शिक्षक सक्षमता प्रारूप, २०७२ अनुसार निम्नमध्ये कुन शिक्षकको आठ सक्षमतामध्ये पर्दैन?', E'सूचना तथा सञ्चार प्रविधि (ICT)', E'विषयवस्तुको ज्ञान (Content knowledge)', E'अनुसन्धान पद्धतिको विशेषज्ञता', E'सिकाइ वातावरण तथा कक्षा व्यवस्थापन', E'C', E'**"अनुसन्धान पद्धतिको विशेषज्ञता" शिक्षकको ८ सक्षमतामध्ये पर्दैन।**\\n- विषयवस्तुको ज्ञान, सिकाइ वातावरण तथा कक्षा व्यवस्थापन र सूचना तथा सञ्चार प्रविधि (ICT) तीनवटै वास्तविक ८ सक्षमतामध्येका हुन्।\\nनोट: बाँकी सक्षमतामा पेडागोजिक ज्ञान, बालबालिकाको ज्ञान, सञ्चार तथा सहकार्य, निरन्तर सिकाइ तथा पेसागत विकास र कानुनी आधार तथा पेसागत आचारसंहिता पर्दछन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षक सक्षमता प्रारूप, २०७२ अनुसार निम्नमध्ये कुन शिक्षकको आठ सक्षमतामध्ये पर्दैन?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षक पेसागत विकास प्रारूप, २०८० अनुसार वृत्ति विकासका लागि शिक्षकलाई कति श्रेणीमा विभाजन गरिएको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'शिक्षक पेसागत विकास प्रारूप, २०८० अनुसार वृत्ति विकासका लागि शिक्षकलाई कति श्रेणीमा विभाजन गरिएको छ?', E'३ श्रेणी', E'२ श्रेणी', E'५ श्रेणी', E'४ श्रेणी', E'D', E'**वृत्ति विकासका लागि शिक्षकलाई नवप्रवेशी, अनुभवी, निपुण र विशेषज्ञ गरी ४ श्रेणीमा विभाजन गरिएको छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षक पेसागत विकास प्रारूप, २०८० अनुसार वृत्ति विकासका लागि शिक्षकलाई कति श्रेणीमा विभाजन गरिएको छ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षक पेसागत विकास प्रारूप, २०८० अनुसार वृत्ति विकासका चार श्रेणीमध्ये कुन पर्दैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'शिक्षक पेसागत विकास प्रारूप, २०८० अनुसार वृत्ति विकासका चार श्रेणीमध्ये कुन पर्दैन?', E'प्रवीण', E'अनुभवी', E'निपुण', E'नवप्रवेशी', E'A', E'**"प्रवीण" शिक्षकको वृत्ति विकासको ४ श्रेणीमध्ये पर्दैन।**\\n- वास्तविक ४ श्रेणी नवप्रवेशी, अनुभवी, निपुण र विशेषज्ञ हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षक पेसागत विकास प्रारूप, २०८० अनुसार वृत्ति विकासका चार श्रेणीमध्ये कुन पर्दैन?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'Glathorn का अनुसार शिक्षकको पेसागत विकास भन्नाले के बुझिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'Glathorn का अनुसार शिक्षकको पेसागत विकास भन्नाले के बुझिन्छ?', E'शिक्षकको तलब वृद्धि हुनु', E'व्यक्तिको व्यावसायिक दक्षता वृद्धि जसले अनुभव वृद्धि गरी शिक्षणलाई व्यवस्थित गर्न सक्षम बनाउँछ', E'शिक्षकलाई प्रशासकीय जिम्मेवारी दिनु', E'शिक्षकको विद्यालय सरुवा गर्नु', E'B', E'**Glathorn का अनुसार शिक्षकको पेसागत विकास भनेको व्यक्तिको व्यावसायिक दक्षता वृद्धि हो, जसले अनुभव वृद्धि गरी शिक्षणलाई व्यवस्थित गर्न शिक्षकलाई सक्षम बनाउँछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:Glathorn का अनुसार शिक्षकको पेसागत विकास भन्नाले के बुझिन्छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षक पेसागत विकास (TPD) को अवधारणा नेपालमा औपचारिक रूपमा कुन कार्यक्रमबाट प्रारम्भ भएको हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'शिक्षक पेसागत विकास (TPD) को अवधारणा नेपालमा औपचारिक रूपमा कुन कार्यक्रमबाट प्रारम्भ भएको हो?', E'शिक्षा सबैका लागि कार्यक्रम (EFA)', E'आधारभूत तथा प्राथमिक शिक्षा परियोजना (BPEP)', E'विद्यालय क्षेत्र सुधार कार्यक्रम (SSRP)', E'विद्यालय क्षेत्र विकास योजना (SSDP)', E'C', E'**शिक्षक पेसागत विकास (TPD) को अवधारणा औपचारिक रूपमा विद्यालय क्षेत्र सुधार कार्यक्रम (SSRP) बाट प्रारम्भ भएको हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षक पेसागत विकास (TPD) को अवधारणा नेपालमा औपचारिक रूपमा कुन कार्यक्रमबाट प्रारम्भ भएको हो?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दिगो विकास लक्ष्य ४ (SDG4): शिक्षा २०३० कार्यान्वयनको राष्ट्रिय प्रारूपअनुसार नेपालले सन् २०३० सम्ममा आधारभूत र माध्यमिक तहका शत-प्रतिशत शिक्षकलाई के प्रदान गर्ने लक्ष्य राखेको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'दिगो विकास लक्ष्य ४ (SDG4): शिक्षा २०३० कार्यान्वयनको राष्ट्रिय प्रारूपअनुसार नेपालले सन् २०३० सम्ममा आधारभूत र माध्यमिक तहका शत-प्रतिशत शिक्षकलाई के प्रदान गर्ने लक्ष्य राखेको छ?', E'विदेशी छात्रवृत्ति', E'स्वचालित बढुवा', E'स्नातकोत्तर उपाधि', E'न्यूनतम सङ्गठित शिक्षक तालिम', E'D', E'**नेपालले सन् २०३० सम्ममा आधारभूत र माध्यमिक तहमा कार्यरत शत-प्रतिशत शिक्षकहरूलाई न्यूनतम सङ्गठित शिक्षक तालिम प्रदान गर्ने लक्ष्य राखेको छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दिगो विकास लक्ष्य ४ (SDG4): शिक्षा २०३० कार्यान्वयनको राष्ट्रिय प्रारूपअनुसार नेपालले सन् २०३० सम्ममा आधारभूत र माध्यमिक तहका शत-प्रतिशत शिक्षकलाई के प्रदान गर्ने लक्ष्य राखेको छ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षक पेसागत क्षमता अभिवृद्धि गर्ने उद्देश्यले वि.सं. २०५० सालमा आधारभूत तथा प्राथमिक शिक्षा परियोजनासँगै मुलुकभर कति ओटा प्राथमिक शिक्षक तालिम केन्द्रहरू स्थापना भए?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'शिक्षक पेसागत क्षमता अभिवृद्धि गर्ने उद्देश्यले वि.सं. २०५० सालमा आधारभूत तथा प्राथमिक शिक्षा परियोजनासँगै मुलुकभर कति ओटा प्राथमिक शिक्षक तालिम केन्द्रहरू स्थापना भए?', E'९ ओटा', E'५ ओटा', E'११ ओटा', E'७ ओटा', E'A', E'**वि.सं. २०५० सालमा केन्द्रमा शैक्षिक जनशक्ति विकास केन्द्र र मुलुकभर ९ ओटा प्राथमिक शिक्षक तालिम केन्द्रहरू स्थापना भए।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षक पेसागत क्षमता अभिवृद्धि गर्ने उद्देश्यले वि.सं. २०५० सालमा आधारभूत तथा प्राथमिक शिक्षा परियोजनासँगै मुलुकभर कति ओटा प्राथमिक शिक्षक तालिम केन्द्रहरू स्थापना भए?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षक पेसागत विकास प्रारूप, २०८० (परिमार्जित संस्करण) को मुख्य उद्देश्य के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'शिक्षक पेसागत विकास प्रारूप, २०८० (परिमार्जित संस्करण) को मुख्य उद्देश्य के हो?', E'शिक्षक सेवा आयोगको परीक्षा प्रणाली खारेज गर्नु', E'निरन्तर शिक्षक पेसागत विकासका अवसरहरूमा सबै शिक्षकको समतामूलक पहुँच सुनिश्चित गर्दै विद्यार्थीको सिकाइ उपलब्धिमा सुधार ल्याउनु', E'विद्यालयको भौतिक पूर्वाधार निर्माण गर्नु', E'शिक्षकको तलब संरचना परिवर्तन गर्नु', E'B', E'**परिमार्जित प्रारूपको मुख्य उद्देश्य निरन्तर शिक्षक पेसागत विकासका अवसरहरूमा सबै शिक्षकको समतामूलक पहुँच सुनिश्चित गर्दै विद्यार्थीको सिकाइ उपलब्धिमा बढोत्तरी ल्याउनु रहेको छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षक पेसागत विकास प्रारूप, २०८० (परिमार्जित संस्करण) को मुख्य उद्देश्य के हो?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षक पेसागत विकास प्रारूप, २०८० अनुसार निरन्तर शिक्षक पेसागत विकासका विधिहरूमध्ये निम्नमध्ये कुन पर्दैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'शिक्षक पेसागत विकास प्रारूप, २०८० अनुसार निरन्तर शिक्षक पेसागत विकासका विधिहरूमध्ये निम्नमध्ये कुन पर्दैन?', E'पाठ अध्ययन (Lesson Study)', E'शिक्षक मेन्टरिङ', E'वार्षिक विदेश भ्रमण', E'कार्यमूलक अनुसन्धान', E'C', E'**"वार्षिक विदेश भ्रमण" प्रारूपमा उल्लिखित निरन्तर पेसागत विकास विधिहरूमध्ये पर्दैन।**\\n- शिक्षक मेन्टरिङ, पाठ अध्ययन र कार्यमूलक अनुसन्धान तीनवटै वास्तविक विधिहरू हुन्, साथसाथै सेवा प्रवेश तालिम, एक महिने प्रमाणीकरण तालिम, स्वनिर्देशित सिकाइ र सिकाइ सञ्जाल निर्माण पनि यसैमा समावेश छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षक पेसागत विकास प्रारूप, २०८० अनुसार निरन्तर शिक्षक पेसागत विकासका विधिहरूमध्ये निम्नमध्ये कुन पर्दैन?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: सेवा प्रवेश र प्रमाणीकरण तालिम प्रक्रिया (आधारभूत तह) (18 Q)
  v_set_id := extensions.uuid_generate_v5('5031ae33-4e11-461b-aa7a-d2670e908b30'::uuid, E'सेवा प्रवेश र प्रमाणीकरण तालिम प्रक्रिया (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'f7ab6c7c-21c8-4214-baf0-ec92ef9ac5d9'::uuid, '5031ae33-4e11-461b-aa7a-d2670e908b30'::uuid, E'सेवा प्रवेश र प्रमाणीकरण तालिम प्रक्रिया (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '5031ae33-4e11-461b-aa7a-d2670e908b30'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षक सेवा आयोगबाट नियुक्तिका लागि सिफारिस भई पदस्थापनामा गएका नवप्रवेशी शिक्षकहरूलाई कति अवधिको सेवा प्रवेश तालिम सञ्चालन गरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'शिक्षक सेवा आयोगबाट नियुक्तिका लागि सिफारिस भई पदस्थापनामा गएका नवप्रवेशी शिक्षकहरूलाई कति अवधिको सेवा प्रवेश तालिम सञ्चालन गरिन्छ?', E'१५ कार्यदिन', E'६ महिना', E'५ वर्ष', E'एक महिना (३० कार्यदिन)', E'D', E'**नवप्रवेशी शिक्षकहरूलाई एक महिना (३० कार्यदिन) को सेवा प्रवेश तालिम सञ्चालन गरिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षक सेवा आयोगबाट नियुक्तिका लागि सिफारिस भई पदस्थापनामा गएका नवप्रवेशी शिक्षकहरूलाई कति अवधिको सेवा प्रवेश तालिम सञ्चालन गरिन्छ?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'एक महिने सेवा प्रवेश तालिमको ३० कार्यदिनलाई कसरी विभाजन गरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'एक महिने सेवा प्रवेश तालिमको ३० कार्यदिनलाई कसरी विभाजन गरिन्छ?', E'१५/१५ दिन गरी दुई खण्डमा', E'१० दिनका तीन खण्डमा', E'एकैचोटि ३० दिनको एउटै खण्डमा', E'१० र २० दिन गरी दुई खण्डमा', E'A', E'**एक महिने सेवा प्रवेश तालिमलाई १५/१५ दिन गरी दुई खण्डमा विभाजन गरिन्छ।**\\nनोट: प्रमाणीकरण तालिम पनि यही १५/१५ दिनको दुई-खण्ड ढाँचामा सञ्चालन हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:एक महिने सेवा प्रवेश तालिमको ३० कार्यदिनलाई कसरी विभाजन गरिन्छ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'एक महिने सेवा प्रवेश तालिमको पहिलो खण्ड (१५ दिन) कुन पद्धतिमा आधारित हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'एक महिने सेवा प्रवेश तालिमको पहिलो खण्ड (१५ दिन) कुन पद्धतिमा आधारित हुन्छ?', E'पूर्णतया रेडियो प्रसारणमार्फत्', E'आमनेसामने, अनलाइन वा मिश्रित (Blended)', E'पूर्णतया लिखित पत्राचारमार्फत्', E'पूर्णतया विद्यालयमा आधारित', E'B', E'**सेवा प्रवेश तालिमको पहिलो खण्ड आमनेसामने, अनलाइन वा मिश्रित (Blended) विधिबाट सञ्चालन हुन्छ।**\\nनोट: दोस्रो खण्डको बाँकी १५ दिन विद्यालयमा आधारित हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:एक महिने सेवा प्रवेश तालिमको पहिलो खण्ड (१५ दिन) कुन पद्धतिमा आधारित हुन्छ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सेवा प्रवेश तालिम कुन निकायबाट प्रदान गरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'सेवा प्रवेश तालिम कुन निकायबाट प्रदान गरिन्छ?', E'शिक्षा तथा मानव स्रोत विकास केन्द्र', E'स्थानीय तह', E'प्रदेश शिक्षा तालिम केन्द्र', E'शिक्षक सेवा आयोग', E'C', E'**सेवा प्रवेश तालिम प्रदेश शिक्षा तालिम केन्द्रबाट प्रदान गरिन्छ।**\\nनोट: तालिमको अभिलेख व्यवस्थापन र प्रमाणीकरण गर्ने काम पनि शिक्षा तालिम केन्द्रबाटै हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सेवा प्रवेश तालिम कुन निकायबाट प्रदान गरिन्छ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षण सेवामा प्रवेश गरेको कति वर्षभित्र शिक्षकले प्रमाणीकरण तालिम पाउने व्यवस्था गरिएको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'शिक्षण सेवामा प्रवेश गरेको कति वर्षभित्र शिक्षकले प्रमाणीकरण तालिम पाउने व्यवस्था गरिएको छ?', E'७ वर्ष', E'२ वर्ष', E'३ वर्ष', E'५ वर्ष', E'D', E'**शिक्षण सेवामा प्रवेश गरेको ५ वर्षभित्र प्रमाणीकरण तालिम पाउने व्यवस्था गरिएको छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षण सेवामा प्रवेश गरेको कति वर्षभित्र शिक्षकले प्रमाणीकरण तालिम पाउने व्यवस्था गरिएको छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'प्रमाणीकरण तालिम कति कार्यदिनको हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'प्रमाणीकरण तालिम कति कार्यदिनको हुन्छ?', E'३० कार्यदिन', E'४५ कार्यदिन', E'६० कार्यदिन', E'१५ कार्यदिन', E'A', E'**प्रमाणीकरण तालिम ३० कार्यदिनको हुन्छ, जसलाई १५/१५ दिन गरी दुई चरणमा सञ्चालन गरिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:प्रमाणीकरण तालिम कति कार्यदिनको हुन्छ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'प्रमाणीकरण तालिममा सहभागी शिक्षकको मूल्याङ्कनको कुल भार कति अङ्कको हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'प्रमाणीकरण तालिममा सहभागी शिक्षकको मूल्याङ्कनको कुल भार कति अङ्कको हुन्छ?', E'१२० अङ्क', E'१०० अङ्क', E'८० अङ्क', E'५० अङ्क', E'B', E'**प्रमाणीकरण तालिममा सहभागी शिक्षकको मूल्याङ्कनको कुल भार १०० अङ्कको हुन्छ।**\\nनोट: यो १०० अङ्क पहिलो खण्डको ५० र दोस्रो खण्डको ५० अङ्कमा विभाजित हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:प्रमाणीकरण तालिममा सहभागी शिक्षकको मूल्याङ्कनको कुल भार कति अङ्कको हुन्छ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'प्रमाणीकरण तालिमको पहिलो खण्ड (आमनेसामने/अनलाइन/मिश्रित कार्यशाला) मा सहभागिताको लागि कति अङ्क छुट्याइएको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'प्रमाणीकरण तालिमको पहिलो खण्ड (आमनेसामने/अनलाइन/मिश्रित कार्यशाला) मा सहभागिताको लागि कति अङ्क छुट्याइएको छ?', E'३० अङ्क', E'५ अङ्क', E'१५ अङ्क', E'५० अङ्क', E'C', E'**प्रमाणीकरण तालिमको पहिलो खण्डमा सहभागिताका लागि १५ अङ्क छुट्याइएको छ।**\\nनोट: सोही खण्डमा लिखित परीक्षाका लागि ३० अङ्क र कार्ययोजना निर्माणका लागि ५ अङ्क गरी कुल ५० अङ्क हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:प्रमाणीकरण तालिमको पहिलो खण्ड (आमनेसामने/अनलाइन/मिश्रित कार्यशाला) मा सहभागिताको लागि कति अङ्क छुट्याइएको छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'प्रमाणीकरण तालिमको पहिलो खण्डको लिखित परीक्षा कति अङ्कको हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'प्रमाणीकरण तालिमको पहिलो खण्डको लिखित परीक्षा कति अङ्कको हुन्छ?', E'५० अङ्क', E'१५ अङ्क', E'२१ अङ्क', E'३० अङ्क', E'D', E'**प्रमाणीकरण तालिमको पहिलो खण्डको लिखित परीक्षा ३० अङ्कको हुन्छ।**\\nनोट: यो ३० अङ्क १० ओटा बहुवैकल्पिक प्रश्न (५ अङ्क), ५ ओटा संक्षिप्त उत्तरात्मक प्रश्न (१५ अङ्क) र २ ओटा लामो उत्तरका प्रश्न (१० अङ्क) मा विभाजित हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:प्रमाणीकरण तालिमको पहिलो खण्डको लिखित परीक्षा कति अङ्कको हुन्छ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'प्रमाणीकरण तालिमको ३० अङ्कको लिखित परीक्षामा ५ ओटा संक्षिप्त उत्तरात्मक प्रश्नका लागि कति अङ्क छुट्याइएको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'प्रमाणीकरण तालिमको ३० अङ्कको लिखित परीक्षामा ५ ओटा संक्षिप्त उत्तरात्मक प्रश्नका लागि कति अङ्क छुट्याइएको छ?', E'१५ अङ्क', E'१० अङ्क', E'२० अङ्क', E'५ अङ्क', E'A', E'**५ ओटा संक्षिप्त उत्तरात्मक प्रश्नका लागि १५ अङ्क छुट्याइएको छ।**\\nनोट: बाँकी १० ओटा बहुवैकल्पिक प्रश्नमा ५ अङ्क र २ ओटा लामो उत्तरका प्रश्नमा १० अङ्क रहन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:प्रमाणीकरण तालिमको ३० अङ्कको लिखित परीक्षामा ५ ओटा संक्षिप्त उत्तरात्मक प्रश्नका लागि कति अङ्क छुट्याइएको छ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'प्रमाणीकरण तालिमको दोस्रो खण्ड (विद्यालयमा आधारित तालिम क्रियाकलाप) मा कार्यसम्पादनका लागि कति अङ्क छुट्याइएको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'प्रमाणीकरण तालिमको दोस्रो खण्ड (विद्यालयमा आधारित तालिम क्रियाकलाप) मा कार्यसम्पादनका लागि कति अङ्क छुट्याइएको छ?', E'३० अङ्क', E'२१ अङ्क', E'१५ अङ्क', E'८ अङ्क', E'B', E'**दोस्रो खण्डमा कार्यसम्पादनका लागि २१ अङ्क छुट्याइएको छ।**\\nनोट: सोही खण्डमा प्रतिवेदनका लागि पनि २१ अङ्क र प्रस्तुतीकरणका लागि ८ अङ्क गरी कुल ५० अङ्क हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:प्रमाणीकरण तालिमको दोस्रो खण्ड (विद्यालयमा आधारित तालिम क्रियाकलाप) मा कार्यसम्पादनका लागि कति अङ्क छुट्याइएको छ?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'प्रमाणीकरण तालिमको दोस्रो खण्डमा प्रस्तुतीकरणका लागि कति अङ्क छुट्याइएको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'प्रमाणीकरण तालिमको दोस्रो खण्डमा प्रस्तुतीकरणका लागि कति अङ्क छुट्याइएको छ?', E'५ अङ्क', E'२१ अङ्क', E'८ अङ्क', E'१५ अङ्क', E'C', E'**दोस्रो खण्डको प्रस्तुतीकरणका लागि ८ अङ्क छुट्याइएको छ।**\\nनोट: कार्यसम्पादन र प्रतिवेदनमा भने प्रत्येकलाई २१/२१ अङ्क तोकिएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:प्रमाणीकरण तालिमको दोस्रो खण्डमा प्रस्तुतीकरणका लागि कति अङ्क छुट्याइएको छ?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यालयमा आधारित तालिमका क्रियाकलापहरू (दोस्रो खण्ड) अन्तर्गत कार्यसम्पादनमा कम्तिमा कति ओटा पाठयोजनासहितको अभ्यास शिक्षणको मूल्याङ्कन गरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'विद्यालयमा आधारित तालिमका क्रियाकलापहरू (दोस्रो खण्ड) अन्तर्गत कार्यसम्पादनमा कम्तिमा कति ओटा पाठयोजनासहितको अभ्यास शिक्षणको मूल्याङ्कन गरिन्छ?', E'१५ ओटा', E'२० ओटा', E'५ ओटा', E'१० ओटा', E'D', E'**दोस्रो खण्डको कार्यसम्पादनमा कम्तिमा दस ओटा पाठयोजनासहित अभ्यास शिक्षणको मूल्याङ्कन गरिन्छ।**\\nनोट: यसैसाथ शिक्षण सुधार योजना (TIP), कार्यमूलक अनुसन्धान, पाठ अध्ययन अभ्यास र सञ्चार प्रविधिको उपयोग पनि यसै खण्डमा मूल्याङ्कन गरिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यालयमा आधारित तालिमका क्रियाकलापहरू (दोस्रो खण्ड) अन्तर्गत कार्यसम्पादनमा कम्तिमा कति ओटा पाठयोजनासहितको अभ्यास शिक्षणको मूल्याङ्कन गरिन्छ?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'प्रमाणीकरण तालिममा सफल हुन शिक्षकले दुवै खण्डमा कम्तिमा कति प्रतिशत अङ्क प्राप्त गर्नुपर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'प्रमाणीकरण तालिममा सफल हुन शिक्षकले दुवै खण्डमा कम्तिमा कति प्रतिशत अङ्क प्राप्त गर्नुपर्छ?', E'५०/५० प्रतिशत', E'६०/६० प्रतिशत', E'६५/६५ प्रतिशत', E'४०/४० प्रतिशत', E'A', E'**प्रमाणीकरण तालिममा सफल हुन दुवै खण्डमा कम्तिमा ५०/५० प्रतिशत अङ्क प्राप्त गर्नुपर्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:प्रमाणीकरण तालिममा सफल हुन शिक्षकले दुवै खण्डमा कम्तिमा कति प्रतिशत अङ्क प्राप्त गर्नुपर्छ?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'प्रमाणीकरण तालिममा प्राप्त अङ्कका आधारमा ९० र सोभन्दा माथि अङ्क ल्याउने सहभागीलाई कुन श्रेणी दिइन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'प्रमाणीकरण तालिममा प्राप्त अङ्कका आधारमा ९० र सोभन्दा माथि अङ्क ल्याउने सहभागीलाई कुन श्रेणी दिइन्छ?', E'प्रथम श्रेणी', E'विशिष्टतासहितको प्रथम श्रेणी', E'द्वितीय श्रेणी', E'तृतीय श्रेणी', E'B', E'**९० वा सोभन्दा माथि अङ्क ल्याउने सहभागीलाई विशिष्टतासहितको प्रथम श्रेणी प्रदान गरिन्छ।**\\nनोट: ८० देखि ९० भन्दा कम अङ्कमा प्रथम श्रेणी, ६५ देखि ८० भन्दा कममा द्वितीय श्रेणी र ५० देखि ६५ भन्दा कममा तृतीय श्रेणी दिइन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:प्रमाणीकरण तालिममा प्राप्त अङ्कका आधारमा ९० र सोभन्दा माथि अङ्क ल्याउने सहभागीलाई कुन श्रेणी दिइन्छ?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'प्रमाणीकरण तालिममा ६५ देखि ८० अङ्कभन्दा कम प्राप्त गर्ने सहभागीलाई कुन श्रेणी दिइन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'प्रमाणीकरण तालिममा ६५ देखि ८० अङ्कभन्दा कम प्राप्त गर्ने सहभागीलाई कुन श्रेणी दिइन्छ?', E'तृतीय श्रेणी', E'विशिष्टतासहितको प्रथम श्रेणी', E'द्वितीय श्रेणी', E'प्रथम श्रेणी', E'C', E'**६५ देखि ८० अङ्कभन्दा कम प्राप्त गर्नेलाई द्वितीय श्रेणी दिइन्छ।**\\nनोट: ५० देखि ६५ भन्दा कममा तृतीय श्रेणी दिइन्छ भने ८० देखि ९० भन्दा कममा प्रथम श्रेणी दिइन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:प्रमाणीकरण तालिममा ६५ देखि ८० अङ्कभन्दा कम प्राप्त गर्ने सहभागीलाई कुन श्रेणी दिइन्छ?'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'प्रमाणीकरण तालिममा कति सत्र अनुपस्थित हुने सहभागीको तालिम पूरा नभएको मानिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'प्रमाणीकरण तालिममा कति सत्र अनुपस्थित हुने सहभागीको तालिम पूरा नभएको मानिन्छ?', E'५ सत्र', E'२ सत्र', E'१ सत्र', E'३ सत्र', E'D', E'**तीन सत्र अनुपस्थित हुने सहभागीको तालिम पूरा नभएको मानिन्छ।**\\nनोट: तालिममा अनुपस्थित रहँदा प्रति सत्र ०.५ अङ्क घटाइन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:प्रमाणीकरण तालिममा कति सत्र अनुपस्थित हुने सहभागीको तालिम पूरा नभएको मानिन्छ?'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षकले एउटै तहमा दुईपटक प्रमाणीकरण तालिम लिएको प्रमाणित भएमा के हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'शिक्षकले एउटै तहमा दुईपटक प्रमाणीकरण तालिम लिएको प्रमाणित भएमा के हुन्छ?', E'दोस्रोपटकको प्रमाणीकरण तालिमको वैधता हुँदैन', E'शिक्षकलाई सोझै विशेषज्ञ श्रेणीमा राखिन्छ', E'पहिलो पटकको तालिम स्वतः रद्द हुन्छ', E'शिक्षकलाई थप ५ अङ्क थपिन्छ', E'A', E'**एउटै तहमा दुईपटक प्रमाणीकरण तालिम लिएको प्रमाणित भएमा दोस्रोपटकको प्रमाणीकरण तालिमको वैधता हुँदैन।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षकले एउटै तहमा दुईपटक प्रमाणीकरण तालिम लिएको प्रमाणित भएमा के हुन्छ?'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: शिक्षक मेन्टरिङ, पाठ अध्ययन र स्वनिर्देशित सिकाइ (आधारभूत तह) (15 Q)
  v_set_id := extensions.uuid_generate_v5('5031ae33-4e11-461b-aa7a-d2670e908b30'::uuid, E'शिक्षक मेन्टरिङ, पाठ अध्ययन र स्वनिर्देशित सिकाइ (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'f7ab6c7c-21c8-4214-baf0-ec92ef9ac5d9'::uuid, '5031ae33-4e11-461b-aa7a-d2670e908b30'::uuid, E'शिक्षक मेन्टरिङ, पाठ अध्ययन र स्वनिर्देशित सिकाइ (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '5031ae33-4e11-461b-aa7a-d2670e908b30'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षक मेन्टरिङको अवधि कति हुने व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'शिक्षक मेन्टरिङको अवधि कति हुने व्यवस्था छ?', E'५ वर्ष', E'६ महिना', E'१ वर्ष', E'३ महिना', E'B', E'**शिक्षक मेन्टरिङको अवधि ६ महिनाको हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षक मेन्टरिङको अवधि कति हुने व्यवस्था छ?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षक मेन्टरिङमा बाइस हप्ताको अवधिमा कम्तिमा कति घण्टाको सक्रिय सहयोग रहने गरी न्यूनतम प्याकेजबाट नवप्रवेशी शिक्षकहरू लाभान्वित हुन्छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'शिक्षक मेन्टरिङमा बाइस हप्ताको अवधिमा कम्तिमा कति घण्टाको सक्रिय सहयोग रहने गरी न्यूनतम प्याकेजबाट नवप्रवेशी शिक्षकहरू लाभान्वित हुन्छन्?', E'१५ घण्टा', E'२० घण्टा', E'३५ घण्टा', E'५० घण्टा', E'C', E'**बाइस हप्ताको अवधिमा कम्तिमा ३५ घण्टाको सक्रिय सहयोग रहने गरी नवप्रवेशी शिक्षकहरू लाभान्वित हुन्छन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षक मेन्टरिङमा बाइस हप्ताको अवधिमा कम्तिमा कति घण्टाको सक्रिय सहयोग रहने गरी न्यूनतम प्याकेजबाट नवप्रवेशी शिक्षकहरू लाभान्वित हुन्छन्?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'"मेन्टर" भन्नाले के बुझिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'"मेन्टर" भन्नाले के बुझिन्छ?', E'शिक्षा तालिम केन्द्रको प्रशिक्षक मात्र', E'नयाँ नियुक्त कुनै पनि शिक्षक', E'विद्यालयको प्रधानाध्यापक', E'नवप्रवेशी शिक्षकलाई पेसागत सहायता प्रदान गर्ने तालिम प्राप्त, दक्ष तथा अनुभवी शिक्षक', E'D', E'**मेन्टर भन्नाले नवप्रवेशी शिक्षकलाई पेसागत सहायता प्रदान गर्ने तालिम प्राप्त, दक्ष तथा अनुभवी शिक्षक सम्झनुपर्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:"मेन्टर" भन्नाले के बुझिन्छ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षक मेन्टरिङलाई शिक्षकको कस्तो पेसागत विकासको महत्त्वपूर्ण माध्यमका रूपमा कार्यान्वयनमा ल्याइन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'शिक्षक मेन्टरिङलाई शिक्षकको कस्तो पेसागत विकासको महत्त्वपूर्ण माध्यमका रूपमा कार्यान्वयनमा ल्याइन्छ?', E'विद्यालयमा आधारित निरन्तर पेसागत विकास', E'अन्तर्राष्ट्रिय अध्ययन भ्रमण', E'विद्यालयबाहिरको वार्षिक तालिम', E'प्रदेशस्तरीय एकपटके गोष्ठी', E'A', E'**शिक्षक मेन्टरिङलाई शिक्षकको विद्यालयमा आधारित निरन्तर पेसागत विकासको महत्त्वपूर्ण माध्यमका रूपमा कार्यान्वयनमा ल्याइन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षक मेन्टरिङलाई शिक्षकको कस्तो पेसागत विकासको महत्त्वपूर्ण माध्यमका रूपमा कार्यान्वयनमा ल्याइन्छ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यालयमा आधारित शिक्षक पेसागत विकासको नमुनाका रूपमा शिक्षकहरूको सहकार्यात्मक अभ्यास गरिने प्रक्रियालाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'विद्यालयमा आधारित शिक्षक पेसागत विकासको नमुनाका रूपमा शिक्षकहरूको सहकार्यात्मक अभ्यास गरिने प्रक्रियालाई के भनिन्छ?', E'सिकाइ सञ्जाल', E'पाठ अध्ययन (Lesson Study)', E'कार्यमूलक अनुसन्धान', E'स्वनिर्देशित सिकाइ', E'B', E'**विद्यालयमा आधारित शिक्षक पेसागत विकासको नमुनाका रूपमा पाठ अध्ययनलाई शिक्षकहरूको सहकार्यात्मक अभ्यासका रूपमा कार्यान्वयन गरिन्छ।**\\nनोट: यसमा पाठको योजना निर्माण, पाठ शिक्षण तथा अवलोकन, र त्यसपछिको छलफल तथा प्रतिबिम्बनका आधारमा विद्यार्थीको सिकाइमा सुधार ल्याइन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यालयमा आधारित शिक्षक पेसागत विकासको नमुनाका रूपमा शिक्षकहरूको सहकार्यात्मक अभ्यास गरिने प्रक्रियालाई के भनिन्छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पाठ अध्ययन (Lesson Study) प्रक्रियामा पाठ शिक्षण तथा अवलोकनपछि के गरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'पाठ अध्ययन (Lesson Study) प्रक्रियामा पाठ शिक्षण तथा अवलोकनपछि के गरिन्छ?', E'शिक्षकलाई पुरस्कार दिइन्छ', E'तत्काल अर्को पाठको योजना बनाइन्छ', E'पाठ शिक्षणबारे छलफल र प्रतिबिम्बन गरिन्छ', E'विद्यार्थीलाई परीक्षा लिइन्छ', E'C', E'**पाठ शिक्षण तथा अवलोकनपछि पाठ शिक्षणबारे छलफल र प्रतिबिम्बन गरी विद्यार्थीको सिकाइमा सुधार ल्याइन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पाठ अध्ययन (Lesson Study) प्रक्रियामा पाठ शिक्षण तथा अवलोकनपछि के गरिन्छ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'स्वनिर्देशित सिकाइ अभ्यासअन्तर्गत शिक्षकले स्वसिकाइ योजना निर्माण र कार्यान्वयनपछि कसलाई प्रतिवेदन पेस गर्नुपर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'स्वनिर्देशित सिकाइ अभ्यासअन्तर्गत शिक्षकले स्वसिकाइ योजना निर्माण र कार्यान्वयनपछि कसलाई प्रतिवेदन पेस गर्नुपर्छ?', E'शिक्षक सेवा आयोगलाई', E'स्थानीय तहको प्रमुखलाई', E'शिक्षा तथा मानव स्रोत विकास केन्द्रलाई', E'प्रधानाध्यापकलाई', E'D', E'**स्वनिर्देशित सिकाइको स्वसिकाइ योजना निर्माण, कार्यान्वयन र सिकाइमा आएको सुधारलाई समेटी शिक्षकले प्रधानाध्यापकलाई प्रतिवेदन पेस गर्नुपर्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:स्वनिर्देशित सिकाइ अभ्यासअन्तर्गत शिक्षकले स्वसिकाइ योजना निर्माण र कार्यान्वयनपछि कसलाई प्रतिवेदन पेस गर्नुपर्छ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'हरेक स्थानीय तहले प्रधानाध्यापक र शिक्षक पेसागत महासङ्घको स्थानीय समितिसँगको समन्वयमा शिक्षक पेसागत विकासका लागि आफ्ना विषयगत शिक्षकहरूको के निर्माण गर्नुपर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'हरेक स्थानीय तहले प्रधानाध्यापक र शिक्षक पेसागत महासङ्घको स्थानीय समितिसँगको समन्वयमा शिक्षक पेसागत विकासका लागि आफ्ना विषयगत शिक्षकहरूको के निर्माण गर्नुपर्छ?', E'सिकाइ सञ्जाल', E'छुट्टै तालिम केन्द्र', E'अलग्गै पाठ्यक्रम', E'स्वतन्त्र परीक्षा प्रणाली', E'A', E'**हरेक स्थानीय तहले आफ्ना विषयगत शिक्षकहरूको सिकाइ सञ्जाल बनाई शिक्षक पेसागत विकासका लागि आवश्यक व्यवस्था मिलाउनुपर्छ।**\\nनोट: सिकाइ सञ्जालमा शिक्षकहरूले अनलाइनबाट पाठ्यक्रम तथा शिक्षणसिकाइ सम्बन्धी असल अभ्यास तथा समस्याहरू प्रस्तुत गर्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:हरेक स्थानीय तहले प्रधानाध्यापक र शिक्षक पेसागत महासङ्घको स्थानीय समितिसँगको समन्वयमा शिक्षक पेसागत विकासका लागि आफ्ना विषयगत शिक्षकहरूको के निर्माण गर्नुपर्छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षक पेसागत विकासको तालिम सञ्चालनमा कुन मोडेलको अवलम्बन गरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'शिक्षक पेसागत विकासको तालिम सञ्चालनमा कुन मोडेलको अवलम्बन गरिन्छ?', E'लेक्चर मोडेल मात्र', E'फ्लिप्ड मोडेल (Flipped Model)', E'पूर्णतया अनलाइन मोडेल', E'परीक्षा-केन्द्रित मोडेल', E'B', E'**शिक्षक पेसागत विकासको तालिम सञ्चालनमा फ्लिप्ड मोडेल (Flipped Model) को अवलम्बन गरिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षक पेसागत विकासको तालिम सञ्चालनमा कुन मोडेलको अवलम्बन गरिन्छ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षकको स्वमूल्याङ्कनका लागि शिक्षक स्वमूल्याङ्कन फाराम कुन निकायले विकास गर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'शिक्षकको स्वमूल्याङ्कनका लागि शिक्षक स्वमूल्याङ्कन फाराम कुन निकायले विकास गर्छ?', E'शिक्षक सेवा आयोग', E'स्थानीय तह', E'शिक्षा तथा मानव स्रोत विकास केन्द्र', E'विद्यालय व्यवस्थापन समिति', E'C', E'**शिक्षकको स्वमूल्याङ्कनका लागि शिक्षा तथा मानव स्रोत विकास केन्द्रले शिक्षक स्वमूल्याङ्कन फाराम विकास गरी कार्यान्वयनमा ल्याउँछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षकको स्वमूल्याङ्कनका लागि शिक्षक स्वमूल्याङ्कन फाराम कुन निकायले विकास गर्छ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षक पेसागत विकास प्रारूप स्वीकृत गर्ने भूमिका कुन निकायको हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'शिक्षक पेसागत विकास प्रारूप स्वीकृत गर्ने भूमिका कुन निकायको हो?', E'शिक्षा तथा मानव स्रोत विकास केन्द्र', E'स्थानीय तह', E'प्रदेशस्तरीय शिक्षा तालिम केन्द्र', E'मन्त्रालय (शिक्षा, विज्ञान तथा प्रविधि मन्त्रालय)', E'D', E'**शिक्षक पेसागत विकास प्रारूप स्वीकृत गर्ने भूमिका मन्त्रालय (शिक्षा, विज्ञान तथा प्रविधि मन्त्रालय) को हो।**\\n- शिक्षा तथा मानव स्रोत विकास केन्द्रको भूमिका नीतिको प्रभावकारी कार्यान्वयन गर्नु हो।\\n- प्रदेशस्तरीय शिक्षा तालिम केन्द्रको भूमिका तालिम कार्यक्रम सञ्चालन गर्नु हो।\\n- स्थानीय तहको भूमिका मेन्टरिङ कार्यक्रम सञ्चालन तथा व्यवस्थापन गर्नु हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षक पेसागत विकास प्रारूप स्वीकृत गर्ने भूमिका कुन निकायको हो?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'एक महिने प्रमाणीकरण शिक्षक पेसागत विकास तालिमको प्रमाणीकरण गर्ने भूमिका कुन निकायको हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'एक महिने प्रमाणीकरण शिक्षक पेसागत विकास तालिमको प्रमाणीकरण गर्ने भूमिका कुन निकायको हो?', E'शिक्षा तथा मानव स्रोत विकास केन्द्र', E'शिक्षा विकास तथा समन्वय इकाइ', E'विद्यालय व्यवस्थापन समिति', E'मन्त्रालय', E'A', E'**एक महिने प्रमाणीकरण शिक्षक पेसागत विकास तालिमको प्रमाणीकरण गर्ने भूमिका शिक्षा तथा मानव स्रोत विकास केन्द्रको हो।**\\nनोट: यही केन्द्रले शिक्षक पेसागत विकाससम्बन्धी अध्ययन-अनुसन्धान सञ्चालन गर्ने भूमिका पनि निर्वाह गर्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:एक महिने प्रमाणीकरण शिक्षक पेसागत विकास तालिमको प्रमाणीकरण गर्ने भूमिका कुन निकायको हो?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'प्रदेशस्थित शिक्षा तालिम केन्द्रको भूमिकाअन्तर्गत निम्नमध्ये कुन कार्य पर्दैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'प्रदेशस्थित शिक्षा तालिम केन्द्रको भूमिकाअन्तर्गत निम्नमध्ये कुन कार्य पर्दैन?', E'स्थानीय तहमा कार्यरत शिक्षक मेन्टरहरूलाई तालिम प्रदान गर्ने', E'शिक्षक पेसागत विकास प्रारूप स्वीकृत गर्ने', E'एक महिने शिक्षक पेसागत विकास तालिमका लागि प्रशिक्षक निर्देशिका र स्रोत सामग्री विकास गर्ने', E'कस्टमाइज्ड शिक्षक तालिम पाठ्यक्रम तथा तालिम सामग्री विकास गर्ने', E'B', E'**"शिक्षक पेसागत विकास प्रारूप स्वीकृत गर्ने" काम शिक्षा तालिम केन्द्रको भूमिकामा पर्दैन।**\\n- यो कार्य मन्त्रालयको भूमिकाअन्तर्गत पर्छ।\\n- प्रशिक्षक निर्देशिका विकास, मेन्टर तालिम र कस्टमाइज्ड तालिम सामग्री विकास तीनवटै शिक्षा तालिम केन्द्रकै वास्तविक भूमिका हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:प्रदेशस्थित शिक्षा तालिम केन्द्रको भूमिकाअन्तर्गत निम्नमध्ये कुन कार्य पर्दैन?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यालयमा आधारित अनुगमन प्रणालीलाई सुदृढ बनाउन प्रधानाध्यापकबाट निम्नमध्ये केको नियमित अनुगमन गरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'विद्यालयमा आधारित अनुगमन प्रणालीलाई सुदृढ बनाउन प्रधानाध्यापकबाट निम्नमध्ये केको नियमित अनुगमन गरिन्छ?', E'केवल शिक्षकको हाजिरी', E'केवल विद्यार्थीको उपस्थिति', E'शिक्षक मेन्टरिङ, कार्यमूलक अनुसन्धान, सहपाठी कक्षा अवलोकन र पाठ अध्ययन', E'केवल विद्यालयको भौतिक पूर्वाधार', E'C', E'**प्रधानाध्यापकबाट शिक्षक मेन्टरिङ, कार्यमूलक अनुसन्धान, सहपाठी कक्षा अवलोकन र पाठ अध्ययनको नियमित अनुगमन गरिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यालयमा आधारित अनुगमन प्रणालीलाई सुदृढ बनाउन प्रधानाध्यापकबाट निम्नमध्ये केको नियमित अनुगमन गरिन्छ?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'मेन्टरिङ सहायताबाट विद्यार्थीको सिकाइ उपलब्धि बढाउने शिक्षक र मेन्टरलाई कुन तहबाट सम्मान तथा पुरस्कृत गर्ने व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'मेन्टरिङ सहायताबाट विद्यार्थीको सिकाइ उपलब्धि बढाउने शिक्षक र मेन्टरलाई कुन तहबाट सम्मान तथा पुरस्कृत गर्ने व्यवस्था छ?', E'केन्द्रीय मन्त्रालयबाट मात्र', E'शिक्षक सेवा आयोगबाट', E'अन्तर्राष्ट्रिय संस्थाबाट', E'विद्यालय तथा स्थानीय तहबाट', E'D', E'**मेन्टरिङ सहायताबाट विद्यार्थीको सिकाइ उपलब्धि बढाउने शिक्षक र मेन्टरलाई विद्यालय तथा स्थानीय तहबाट सम्मान तथा पुरस्कृत गर्ने व्यवस्था छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:मेन्टरिङ सहायताबाट विद्यार्थीको सिकाइ उपलब्धि बढाउने शिक्षक र मेन्टरलाई कुन तहबाट सम्मान तथा पुरस्कृत गर्ने व्यवस्था छ?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: शैक्षिक अनुसन्धानः अर्थ, आवश्यकता र महत्त्व (आधारभूत तह) (18 Q)
  v_set_id := extensions.uuid_generate_v5('aaa2cd91-88d2-432e-807a-a64e22cbdc51'::uuid, E'शैक्षिक अनुसन्धानः अर्थ, आवश्यकता र महत्त्व (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'f7ab6c7c-21c8-4214-baf0-ec92ef9ac5d9'::uuid, 'aaa2cd91-88d2-432e-807a-a64e22cbdc51'::uuid, E'शैक्षिक अनुसन्धानः अर्थ, आवश्यकता र महत्त्व (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'aaa2cd91-88d2-432e-807a-a64e22cbdc51'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'"Research" शब्द कुन दुई अंश मिलेर बनेको हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'"Research" शब्द कुन दुई अंश मिलेर बनेको हो?', E'Re + Search', E'Re + Search + Ch', E'Res + Search', E'Real + Search', E'A', E'**"Research" शब्द Re र Search गरी दुई अंश मिलेर बनेको हो, जहाँ Re को अर्थ पटक-पटक र Search को अर्थ खोजी गर्नु भन्ने बुझिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:"Research" शब्द कुन दुई अंश मिलेर बनेको हो?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'"कुनै समस्याको समाधानका लागि वस्तुगत र व्यवस्थित विधिद्वारा गरिने ज्ञानको खोज नै अनुसन्धान हो" भन्ने परिभाषा कसले दिएका हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'"कुनै समस्याको समाधानका लागि वस्तुगत र व्यवस्थित विधिद्वारा गरिने ज्ञानको खोज नै अनुसन्धान हो" भन्ने परिभाषा कसले दिएका हुन्?', E'Travers', E'C.R. Kothari', E'Best and Kahn', E'Kerlinger', E'B', E'**यो परिभाषा C.R. Kothari ले दिएका हुन्।**\\n- Kerlinger ले अनुसन्धानलाई निश्चित परिकल्पना निर्माण गरी योजनाबद्ध र नियन्त्रित प्रत्यक्ष प्रमाणका आधारमा गरिने वैज्ञानिक खोजीका रूपमा परिभाषित गरेका छन्।\\n- Best and Kahn ले अनुसन्धानलाई व्यवस्थित र वस्तुगत विश्लेषण तथा नियन्त्रित अवलोकनको अभिलेख राख्ने कार्यका रूपमा व्याख्या गरेका छन्।\\n- Travers ले शैक्षिक अनुसन्धानलाई शैक्षिक कार्यकर्ताहरूद्वारा इंगित घटनासम्बन्धी सङ्गठित वैज्ञानिक ज्ञान विकास गर्ने प्रक्रिया भनेका छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:"कुनै समस्याको समाधानका लागि वस्तुगत र व्यवस्थित विधिद्वारा गरिने ज्ञानको खोज नै अनुसन्धान हो" भन्ने परिभाषा कसले दिएका हुन्?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'"अनुसन्धान भनेको व्यवस्थित र वस्तुगत विश्लेषण तथा नियन्त्रित अवलोकनको अभिलेख राख्ने कार्य हो, जसले विभिन्न घटनाको सामान्यीकरण गरी सिद्धान्तको विकासमा सहयोग पुर्‍याउँछ" भन्ने परिभाषा कसको हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'"अनुसन्धान भनेको व्यवस्थित र वस्तुगत विश्लेषण तथा नियन्त्रित अवलोकनको अभिलेख राख्ने कार्य हो, जसले विभिन्न घटनाको सामान्यीकरण गरी सिद्धान्तको विकासमा सहयोग पुर्‍याउँछ" भन्ने परिभाषा कसको हो?', E'C.R. Kothari', E'Kerlinger', E'Best and Kahn', E'युनेस्को', E'C', E'**यो परिभाषा Best and Kahn को हो।**\\n- C.R. Kothari का अनुसार अनुसन्धान समस्या समाधानका लागि गरिने वस्तुगत र व्यवस्थित ज्ञानको खोज हो।\\n- Kerlinger ले अनुसन्धानलाई परिकल्पनामा आधारित वैज्ञानिक खोजी भनेका छन्।\\n- युनेस्कोको प्रकाशनअनुसार शिक्षा-अनुसन्धान भन्नाले शैक्षिक विधि र कार्यमा सुधार ल्याउने राज्य, व्यक्ति वा संस्थाका सबै प्रयासहरू बुझिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:"अनुसन्धान भनेको व्यवस्थित र वस्तुगत विश्लेषण तथा नियन्त्रित अवलोकनको अभिलेख राख्ने कार्य हो, जसले विभिन्न घटनाको सामान्यीकरण गरी सिद्धान्तको विकासमा सहयोग पुर्‍याउँछ" भन्ने परिभाषा कसको हो?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'निश्चित परिकल्पना निर्माण गरी योजनाबद्ध, नियन्त्रित र प्रत्यक्ष प्रमाणका आधारमा गरिने खोजी कार्यलाई वैज्ञानिक अनुसन्धान भन्ने परिभाषा कसले दिएका हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'निश्चित परिकल्पना निर्माण गरी योजनाबद्ध, नियन्त्रित र प्रत्यक्ष प्रमाणका आधारमा गरिने खोजी कार्यलाई वैज्ञानिक अनुसन्धान भन्ने परिभाषा कसले दिएका हुन्?', E'कर्नेल', E'युनेस्को', E'भिटनी', E'Kerlinger', E'D', E'**यो परिभाषा Kerlinger ले दिएका हुन्।**\\n- भिटनी (१९५४) ले शिक्षा-अनुसन्धानलाई वैज्ञानिक, दार्शनिक र आलोचनात्मक सोचविधिको प्रयोगमार्फत शिक्षा क्षेत्रका समस्या समाधान गर्ने प्रयासका रूपमा व्याख्या गरेका छन्।\\n- कर्नेलका अनुसार पेडागोजी-अनुसन्धान भनेको विद्यालयका बालबालिका, सामाजिक संरचना र विद्यार्थीका विशेषता र अन्तरक्रियाबारेको व्यवस्थित सूचना सङ्ग्रह हो।\\n- युनेस्कोको प्रकाशनमा शिक्षा-अनुसन्धानलाई शैक्षिक सुधारका सबै प्रयासका रूपमा लिइएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:निश्चित परिकल्पना निर्माण गरी योजनाबद्ध, नियन्त्रित र प्रत्यक्ष प्रमाणका आधारमा गरिने खोजी कार्यलाई वैज्ञानिक अनुसन्धान भन्ने परिभाषा कसले दिएका हुन्?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शैक्षिक अनुसन्धानलाई "शैक्षिक कार्यकर्ताहरूद्वारा इंगित गरिएका घटनाहरूसम्बन्धमा सङ्गठित वैज्ञानिक ज्ञानको विकास गर्ने प्रक्रिया" भनी कसले परिभाषित गरेका छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'शैक्षिक अनुसन्धानलाई "शैक्षिक कार्यकर्ताहरूद्वारा इंगित गरिएका घटनाहरूसम्बन्धमा सङ्गठित वैज्ञानिक ज्ञानको विकास गर्ने प्रक्रिया" भनी कसले परिभाषित गरेका छन्?', E'Travers', E'कर्नेल', E'भिटनी', E'C.R. Kothari', E'A', E'**Travers ले शैक्षिक अनुसन्धानलाई शैक्षिक कार्यकर्ताहरूद्वारा इंगित गरिएका घटनासम्बन्धी सङ्गठित वैज्ञानिक ज्ञानको विकास गर्ने प्रक्रिया भनेका छन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शैक्षिक अनुसन्धानलाई "शैक्षिक कार्यकर्ताहरूद्वारा इंगित गरिएका घटनाहरूसम्बन्धमा सङ्गठित वैज्ञानिक ज्ञानको विकास गर्ने प्रक्रिया" भनी कसले परिभाषित गरेका छन्?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'अनुसन्धानको मूल उद्देश्य के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'अनुसन्धानको मूल उद्देश्य के हो?', E'पुरानो ज्ञानलाई दोहोर्‍याउनु', E'नयाँ सामान्यीकरण तथा सिद्धान्तको विकास गर्नु', E'परीक्षामा राम्रो अङ्क ल्याउनु', E'विद्यालयको भौतिक सुधार गर्नु', E'B', E'**अनुसन्धानको मूल उद्देश्य नयाँ सामान्यीकरण तथा सिद्धान्तको विकास हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:अनुसन्धानको मूल उद्देश्य के हो?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'अनुसन्धानको थालनी सामान्यतया केबाट हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'अनुसन्धानको थालनी सामान्यतया केबाट हुन्छ?', E'नमुना छनोटबाट', E'प्रतिवेदन लेखनबाट', E'समस्याको पहिचानबाट', E'तथ्याङ्क विश्लेषणबाट', E'C', E'**अनुसन्धानको थालनी समस्याको पहिचानबाट हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:अनुसन्धानको थालनी सामान्यतया केबाट हुन्छ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तथ्याङ्कको प्रकृति र विश्लेषण प्रक्रियाको आधारमा अनुसन्धानलाई मूलतः कति वर्गमा विभाजन गरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'तथ्याङ्कको प्रकृति र विश्लेषण प्रक्रियाको आधारमा अनुसन्धानलाई मूलतः कति वर्गमा विभाजन गरिन्छ?', E'४ वर्ग', E'५ वर्ग', E'३ वर्ग: गुणात्मक, परिमाणात्मक र मिश्रित', E'२ वर्ग: गुणात्मक र परिमाणात्मक', E'D', E'**तथ्याङ्कको प्रकृति र विश्लेषण प्रक्रियाको आधारमा अनुसन्धानलाई गुणात्मक र परिमाणात्मक गरी दुई वर्गमा विभाजन गरिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तथ्याङ्कको प्रकृति र विश्लेषण प्रक्रियाको आधारमा अनुसन्धानलाई मूलतः कति वर्गमा विभाजन गरिन्छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'आगमन ढाँचामा खोजी हुने र विषयगत तथ्याङ्क भएको अनुसन्धानलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'आगमन ढाँचामा खोजी हुने र विषयगत तथ्याङ्क भएको अनुसन्धानलाई के भनिन्छ?', E'गुणात्मक अनुसन्धान', E'परिमाणात्मक अनुसन्धान', E'प्रयोगात्मक अनुसन्धान', E'सहसम्बन्ध अनुसन्धान', E'A', E'**आगमन ढाँचामा खोजी हुने र विषयगत तथ्याङ्क भएको अनुसन्धानलाई गुणात्मक अनुसन्धान भनिन्छ।**\\nनोट: परिमाणात्मक अनुसन्धानका तथ्याङ्क वस्तुगत हुन्छन् र यसको खोजी प्रक्रिया निगमन ढाँचाको हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:आगमन ढाँचामा खोजी हुने र विषयगत तथ्याङ्क भएको अनुसन्धानलाई के भनिन्छ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'औपचारिक सिद्धान्त निर्माण गर्नका लागि गरिने र निष्कर्षलाई सामान्यीकरण गर्न सकिने अनुसन्धानलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'औपचारिक सिद्धान्त निर्माण गर्नका लागि गरिने र निष्कर्षलाई सामान्यीकरण गर्न सकिने अनुसन्धानलाई के भनिन्छ?', E'व्यावहारिक अनुसन्धान (Applied Research)', E'आधारभूत अनुसन्धान (Basic Research)', E'कार्यमूलक अनुसन्धान (Action Research)', E'वर्णनात्मक अनुसन्धान (Descriptive Research)', E'B', E'**औपचारिक सिद्धान्त निर्माणका लागि गरिने र निष्कर्ष सामान्यीकरण गर्न सकिने अनुसन्धानलाई आधारभूत अनुसन्धान भनिन्छ।**\\n- व्यावहारिक अनुसन्धान स्वीकृत सिद्धान्तका आधारमा तत्कालै उपयोग गर्न सकिने समस्या समाधानमा केन्द्रित हुन्छ।\\n- कार्यमूलक अनुसन्धान आफ्नै कार्यक्षेत्रको तत्कालीन समस्या समाधानमा प्रयोग हुन्छ।\\n- वर्णनात्मक अनुसन्धान वर्तमान घटना वा परिस्थितिको सूचनामा आधारित हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:औपचारिक सिद्धान्त निर्माण गर्नका लागि गरिने र निष्कर्षलाई सामान्यीकरण गर्न सकिने अनुसन्धानलाई के भनिन्छ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पि. भी. योङका अनुसार व्यावहारिक अनुसन्धान (Applied Research) को तात्पर्य के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'पि. भी. योङका अनुसार व्यावहारिक अनुसन्धान (Applied Research) को तात्पर्य के हो?', E'शिक्षकको दैनिक हाजिरी अभिलेख राख्ने कार्य', E'पूर्णतः प्रयोगशालामा गरिने अनुसन्धान', E'ज्ञानको त्यो समस्या जसलाई मानवताको भलाइको कार्यमा लगाउन सकिन्छ', E'परीक्षाको उत्तरपुस्तिका जाँच्ने प्रक्रिया', E'C', E'**पि. भी. योङका अनुसार व्यावहारिक अनुसन्धानको तात्पर्य ज्ञानको त्यो समस्या हो जसलाई मानवताको भलाइको कार्यमा लगाउन सकिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पि. भी. योङका अनुसार व्यावहारिक अनुसन्धान (Applied Research) को तात्पर्य के हो?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विगतका ऐतिहासिक घटनाक्रम, अवस्था वा प्रावधानहरूबारे वर्णनात्मक रूपमा गरिने अनुसन्धानलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'विगतका ऐतिहासिक घटनाक्रम, अवस्था वा प्रावधानहरूबारे वर्णनात्मक रूपमा गरिने अनुसन्धानलाई के भनिन्छ?', E'Ethnographic Research', E'Empirical Research', E'Correlational Research', E'Historical Research', E'D', E'**विगतका ऐतिहासिक घटनाक्रमबारे जानकारी लिन गरिने वर्णनात्मक अनुसन्धानलाई Historical Research भनिन्छ।**\\n- Empirical Research अवलोकन र प्रयोगमा आधारित हुन्छ।\\n- Correlational Research दुई वा दुईभन्दा बढी चरहरूबिचको सहसम्बन्ध अध्ययन गर्दछ।\\n- Ethnographic Research आर्थिक, सामाजिक र सांस्कृतिक परिवेशसँग नजिकिएर गरिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विगतका ऐतिहासिक घटनाक्रम, अवस्था वा प्रावधानहरूबारे वर्णनात्मक रूपमा गरिने अनुसन्धानलाई के भनिन्छ?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'एउटै समूह वा विषय क्षेत्रका दुई वा दुईभन्दा बढी चरहरूबिचको सम्बन्ध अध्ययन गर्न कुन प्रकारको अनुसन्धान गरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'एउटै समूह वा विषय क्षेत्रका दुई वा दुईभन्दा बढी चरहरूबिचको सम्बन्ध अध्ययन गर्न कुन प्रकारको अनुसन्धान गरिन्छ?', E'Correlational Research', E'Ethnographic Research', E'Historical Research', E'Experimental Research', E'A', E'**दुई वा दुईभन्दा बढी चरहरूबिचको सहसम्बन्धको अवस्था अध्ययन गर्न Correlational Research (सहसम्बन्ध अनुसन्धान) गरिन्छ।**\\nनोट: यसप्रकारको अनुसन्धान परिमाणात्मक (Quantitative) प्रकृतिको हुन्छ; जस्तै शिक्षकको जागिरसँगको सन्तुष्टि अध्ययन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:एउटै समूह वा विषय क्षेत्रका दुई वा दुईभन्दा बढी चरहरूबिचको सम्बन्ध अध्ययन गर्न कुन प्रकारको अनुसन्धान गरिन्छ?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'आर्थिक, सामाजिक र सांस्कृतिक परिवेशसँग नजिकिएर सूक्ष्म तवरबाट गरिने अनुसन्धानलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'आर्थिक, सामाजिक र सांस्कृतिक परिवेशसँग नजिकिएर सूक्ष्म तवरबाट गरिने अनुसन्धानलाई के भनिन्छ?', E'Experimental Research', E'Ethnographic Research', E'Causal Research', E'Descriptive Research', E'B', E'**आर्थिक, सामाजिक र सांस्कृतिक परिवेशसँग नजिकिएर सूक्ष्म तवरबाट गरिने अनुसन्धानलाई Ethnographic Research भनिन्छ।**\\nनोट: यो विशेष गरी मानवशास्त्रसँग सम्बन्धित छ र कुनै व्यक्तिको जीवनसँग जोडिएका घटनाको गहिरो अध्ययन गर्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:आर्थिक, सामाजिक र सांस्कृतिक परिवेशसँग नजिकिएर सूक्ष्म तवरबाट गरिने अनुसन्धानलाई के भनिन्छ?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वर्तमानको सूचनालाई विगतको अवस्थासँग दाँजेर कारणहरू खोजी गरी सहसम्बन्ध भए/नभएको हेर्ने अनुसन्धानलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'वर्तमानको सूचनालाई विगतको अवस्थासँग दाँजेर कारणहरू खोजी गरी सहसम्बन्ध भए/नभएको हेर्ने अनुसन्धानलाई के भनिन्छ?', E'Empirical Research', E'Descriptive Research', E'Causal Research', E'Correlational Research', E'C', E'**वर्तमानको सूचनालाई विगतको अवस्थासँग दाँजेर कारण खोजी गर्ने अनुसन्धानलाई Causal Research भनिन्छ।**\\nनोट: उदाहरणका लागि विगत पाँच वर्षको विद्यालय तथ्याङ्कका आधारमा विद्यार्थीले कक्षा छाड्ने कारण यकिन गर्ने अनुसन्धान यसैअन्तर्गत पर्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वर्तमानको सूचनालाई विगतको अवस्थासँग दाँजेर कारणहरू खोजी गरी सहसम्बन्ध भए/नभएको हेर्ने अनुसन्धानलाई के भनिन्छ?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'काम गर्दै, अनुभव गर्दै कार्यशैलीमा सुधार ल्याउने र समस्या समाधान गर्ने रणनीतिक कार्यप्रणालीलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'काम गर्दै, अनुभव गर्दै कार्यशैलीमा सुधार ल्याउने र समस्या समाधान गर्ने रणनीतिक कार्यप्रणालीलाई के भनिन्छ?', E'Historical Research', E'Correlational Research', E'Ethnographic Research', E'Action Research (कार्यमूलक अनुसन्धान)', E'D', E'**काम गर्दै कार्यशैलीमा सुधार ल्याउने र समस्या समाधान गर्ने रणनीतिक कार्यप्रणालीलाई Action Research (कार्यमूलक अनुसन्धान) भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:काम गर्दै, अनुभव गर्दै कार्यशैलीमा सुधार ल्याउने र समस्या समाधान गर्ने रणनीतिक कार्यप्रणालीलाई के भनिन्छ?'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'अनुसन्धान र शैक्षिक अनुसन्धानबिचको भिन्नताअनुसार शैक्षिक अनुसन्धानको मूल विषय के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'अनुसन्धान र शैक्षिक अनुसन्धानबिचको भिन्नताअनुसार शैक्षिक अनुसन्धानको मूल विषय के हो?', E'शिक्षा क्षेत्रमा देखापरेका समस्या र मुद्दाहरू', E'औद्योगिक उत्पादन प्रक्रिया', E'स्वास्थ्य क्षेत्रका महामारी अध्ययन', E'अन्तर्राष्ट्रिय व्यापार तथ्याङ्क', E'A', E'**शैक्षिक अनुसन्धानको मूल विषय भनेको नै शिक्षा क्षेत्रमा देखापरेका समस्या र मुद्दाहरू हुन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:अनुसन्धान र शैक्षिक अनुसन्धानबिचको भिन्नताअनुसार शैक्षिक अनुसन्धानको मूल विषय के हो?'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शैक्षिक अनुसन्धानको आवश्यकता र महत्त्वअन्तर्गत निम्नमध्ये कुन उद्देश्य पर्दैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'शैक्षिक अनुसन्धानको आवश्यकता र महत्त्वअन्तर्गत निम्नमध्ये कुन उद्देश्य पर्दैन?', E'पाठ्यक्रम र मूल्याङ्कन क्षेत्रका सैद्धान्तिक तथा व्यावहारिक समस्या समाधान गर्न', E'विद्यालयको वार्षिक बजेट स्वीकृत गर्न', E'शिक्षण कला/सीप पक्षमा सुधारका लागि नयाँ रणनीति विकास गर्न', E'विद्यमान नीति तथा कार्यक्रमको मूल्याङ्कन गरी नयाँ नीति निर्माणमा मार्गदर्शन गर्न', E'B', E'**"विद्यालयको वार्षिक बजेट स्वीकृत गर्न" शैक्षिक अनुसन्धानको आवश्यकता र महत्त्वअन्तर्गत पर्दैन।**\\n- नीति मूल्याङ्कन, पाठ्यक्रम-मूल्याङ्कन समस्या समाधान र शिक्षण सीप सुधार तीनवटै शैक्षिक अनुसन्धानका वास्तविक उद्देश्यहरू हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शैक्षिक अनुसन्धानको आवश्यकता र महत्त्वअन्तर्गत निम्नमध्ये कुन उद्देश्य पर्दैन?'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: घटना/मामला अध्ययन (Case Study) — आधारभूत तह (15 Q)
  v_set_id := extensions.uuid_generate_v5('a483ac23-07f8-470a-ac94-2e72f60f9d81'::uuid, E'घटना/मामला अध्ययन (Case Study) — आधारभूत तह');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'f7ab6c7c-21c8-4214-baf0-ec92ef9ac5d9'::uuid, 'a483ac23-07f8-470a-ac94-2e72f60f9d81'::uuid, E'घटना/मामला अध्ययन (Case Study) — आधारभूत तह', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'a483ac23-07f8-470a-ac94-2e72f60f9d81'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'मामला अध्ययनको प्रयोग सर्वप्रथम सामाजिक विज्ञानअन्तर्गत पारिवारिक बजेटको अध्ययनका सन्दर्भमा कसले गरेको मानिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'मामला अध्ययनको प्रयोग सर्वप्रथम सामाजिक विज्ञानअन्तर्गत पारिवारिक बजेटको अध्ययनका सन्दर्भमा कसले गरेको मानिन्छ?', E'Paul Lawrence', E'Kurt Lewin', E'Frederic Le Play', E'Robert Park', E'C', E'**मामला अध्ययनको प्रयोग सर्वप्रथम Frederic Le Play (सन् १८२९) ले सामाजिक विज्ञानअन्तर्गत पारिवारिक बजेटको अध्ययनमा गरेको मानिन्छ।**\\n- Robert Park यूनिभर्सिटी अफ शिकागोका प्राध्यापक थिए जसले घटना अध्ययन विधिमा "Scientific" र "Depth" शब्दको प्रयोग गरे।\\n- Paul Lawrence ले मामला अध्ययनलाई कक्षाकोठामा यथार्थ ल्याउने "मोटर" को उपमा दिएका छन्।\\n- Kurt Lewin कार्यमूलक अनुसन्धानका प्रवर्तक हुन्, मामला अध्ययनका होइनन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:मामला अध्ययनको प्रयोग सर्वप्रथम सामाजिक विज्ञानअन्तर्गत पारिवारिक बजेटको अध्ययनका सन्दर्भमा कसले गरेको मानिन्छ?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'प्रोफेसर पाउल लउरेन्सले मामला अध्ययनलाई केसँग तुलना गर्दै व्याख्या गरेका छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'प्रोफेसर पाउल लउरेन्सले मामला अध्ययनलाई केसँग तुलना गर्दै व्याख्या गरेका छन्?', E'एउटा किताब जसमा सबै उत्तर हुन्छ', E'एउटा पुल जसले दुई विषयलाई जोड्छ', E'एउटा दर्पण जसले भविष्य देखाउँछ', E'एउटा मोटर जसले कक्षाकोठामा थुप्रै यथार्थ लिएर आउँछ', E'D', E'**प्रोफेसर पाउल लउरेन्सले मामला अध्ययनलाई एउटा मोटरसँग तुलना गरेका छन्, जसले कक्षाकोठामा थुप्रै यथार्थ लिएर आउँछ र विद्यार्थी तथा शिक्षकले त्यसलाई केलाउने गर्छन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:प्रोफेसर पाउल लउरेन्सले मामला अध्ययनलाई केसँग तुलना गर्दै व्याख्या गरेका छन्?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'University of Chicago मा प्रभावशाली Sociological Case Studies पढाउने प्राध्यापक, जसले घटना अध्ययन विधिमा "Scientific" र "Depth" शब्दको प्रयोग गरे, को हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'University of Chicago मा प्रभावशाली Sociological Case Studies पढाउने प्राध्यापक, जसले घटना अध्ययन विधिमा "Scientific" र "Depth" शब्दको प्रयोग गरे, को हुन्?', E'Robert Park', E'Frederic Le Play', E'Stephen Corey', E'Lawrence Stenhouse', E'A', E'**Robert Park University of Chicago मा प्रभावशाली Sociological Case Studies पढाउने प्राध्यापक थिए, जसले यस विधिमा "Scientific" र "Depth" शब्दको प्रयोग गरेका थिए।**\\nनोट: उनी पहिले Ex-news paper reporter/Novelist (१९२०) थिए।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:University of Chicago मा प्रभावशाली Sociological Case Studies पढाउने प्राध्यापक, जसले घटना अध्ययन विधिमा "Scientific" र "Depth" शब्दको प्रयोग गरे, को हुन्?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सन् १९२० को दशकमा घटना अध्ययन विधिको अवैज्ञानिक र आधारहीन भनी विरोध हुँदा कुन दुई पक्षबिच चर्को बहस चलेको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'सन् १९२० को दशकमा घटना अध्ययन विधिको अवैज्ञानिक र आधारहीन भनी विरोध हुँदा कुन दुई पक्षबिच चर्को बहस चलेको थियो?', E'Pro-empirical र Pro-ethnographic', E'Pro-qualitative र Pro-quantitative', E'Pro-basic र Pro-applied', E'Pro-historical र Pro-descriptive', E'B', E'**सन् १९२० को दशकमा घटना अध्ययन विधिको वैधतामाथि Pro-qualitative र Pro-quantitative पक्षधरबिच चर्को बहस चलेको थियो।**\\nनोट: सन् १९५० तिर quantitative survey research प्रयोगमा आएपछि मात्र Case Study ले खास अनुसन्धान विधिको रूपमा स्थान र महत्त्व पायो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सन् १९२० को दशकमा घटना अध्ययन विधिको अवैज्ञानिक र आधारहीन भनी विरोध हुँदा कुन दुई पक्षबिच चर्को बहस चलेको थियो?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'मामला अध्ययन (Case Study) सुरु सुरुमा कुन दुई विषयक्षेत्रमा प्रयोगमा आएको पाइन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'मामला अध्ययन (Case Study) सुरु सुरुमा कुन दुई विषयक्षेत्रमा प्रयोगमा आएको पाइन्छ?', E'Physics र Chemistry', E'Mathematics र Statistics', E'Sociology र Anthropology', E'Botany र Zoology', E'C', E'**मामला अध्ययन सुरु सुरुमा Sociology र Anthropology मा प्रयोगमा आएको पाइन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:मामला अध्ययन (Case Study) सुरु सुरुमा कुन दुई विषयक्षेत्रमा प्रयोगमा आएको पाइन्छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'मामला अध्ययन खासगरी कस्तो अध्ययन प्रकृतिको हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'मामला अध्ययन खासगरी कस्तो अध्ययन प्रकृतिको हो?', E'पूर्णतया सांख्यिकीय सर्वेक्षण', E'प्रयोगशालामा मात्र गरिने प्रयोग', E'केवल पाठ्यपुस्तकको समीक्षा', E'यथार्थ जीवनको अनुभवलाई सम्बोधन गर्ने एक किसिमको कथा', E'D', E'**मामला अध्ययन खासगरी एक किसिमको कथा हो, जसले यथार्थ जीवनको अनुभवलाई सम्बोधन गर्दछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:मामला अध्ययन खासगरी कस्तो अध्ययन प्रकृतिको हो?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'मामला अध्ययन खासगरी कुन दुई क्षेत्रमा उस्तै प्रकृतिका समस्या समाधानका लागि गतिलो औजारका रूपमा लिइन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'मामला अध्ययन खासगरी कुन दुई क्षेत्रमा उस्तै प्रकृतिका समस्या समाधानका लागि गतिलो औजारका रूपमा लिइन्छ?', E'चिकित्सा शास्त्र र कानुन', E'वाणिज्य र लेखा', E'कृषि र पशुपालन', E'इन्जिनियरिङ र वास्तुकला', E'A', E'**मामला अध्ययन खासगरी चिकित्सा शास्त्र र कानुन जस्ता क्षेत्रमा शिक्षण विधिको गतिलो औजारका रूपमा लिइन्छ।**\\nनोट: तथापि यो अन्य क्षेत्रमा पनि उत्तिकै प्रभावकारी विधिका रूपमा प्रयोग गरिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:मामला अध्ययन खासगरी कुन दुई क्षेत्रमा उस्तै प्रकृतिका समस्या समाधानका लागि गतिलो औजारका रूपमा लिइन्छ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'मामला अध्ययनका चरणहरूमा "शीर्षकको छनोट" पछि सामान्यतया कुन चरण आउँछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'मामला अध्ययनका चरणहरूमा "शीर्षकको छनोट" पछि सामान्यतया कुन चरण आउँछ?', E'तथ्याङ्कको प्रस्तुतीकरण तथा विश्लेषण', E'उद्देश्यको निर्धारण', E'साधन/प्रश्नावली निर्माण', E'निष्कर्षको सामान्यीकरण र प्रतिवेदन', E'B', E'**मामला अध्ययनमा शीर्षकको छनोटपछि उद्देश्यको निर्धारण गरिन्छ, त्यसपछि अध्ययनको विधि, अध्ययनको क्षेत्र निर्धारण, साधन निर्माण, सूचना सङ्कलन हुँदै अन्त्यमा तथ्याङ्कको प्रस्तुतीकरण/विश्लेषण र निष्कर्षको सामान्यीकरण/प्रतिवेदनमा टुङ्गिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:मामला अध्ययनका चरणहरूमा "शीर्षकको छनोट" पछि सामान्यतया कुन चरण आउँछ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'University of Texas का अनुसार मामला अध्ययनका चरणहरू कति ओटा छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'University of Texas का अनुसार मामला अध्ययनका चरणहरू कति ओटा छन्?', E'४ चरण', E'८ चरण', E'६ चरण', E'१० चरण', E'C', E'**University of Texas का अनुसार मामला अध्ययनका ६ चरण हुन्छन्: अनुसन्धान प्रश्नको निर्धारण, घटनाको छनोट तथा तथ्याङ्क सङ्कलन विधिको निर्धारण, तथ्याङ्क सङ्कलन विधि, सङ्कलन तथा प्रस्तुतीकरण, विश्लेषण, र प्रतिवेदन तयारी।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:University of Texas का अनुसार मामला अध्ययनका चरणहरू कति ओटा छन्?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'मामला अध्ययनलाई विद्यालय वा कुनै पनि कार्यथलोमा प्रयोग हुने सिद्धान्त र अभ्यासबिचको सीमितता पूरा गर्न केका रूपमा लिइन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'मामला अध्ययनलाई विद्यालय वा कुनै पनि कार्यथलोमा प्रयोग हुने सिद्धान्त र अभ्यासबिचको सीमितता पूरा गर्न केका रूपमा लिइन्छ?', E'प्रतिस्पर्धाको रूपमा', E'अवरोधको रूपमा', E'विकल्पहीन उपायको रूपमा', E'पुलको रूपमा', E'D', E'**मामला अध्ययनले विद्यालय वा कार्यथलोमा प्रयोग हुने सिद्धान्त तथा अभ्यासबिचको सीमितता पूरा गर्न पुलको रूपमा काम गर्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:मामला अध्ययनलाई विद्यालय वा कुनै पनि कार्यथलोमा प्रयोग हुने सिद्धान्त र अभ्यासबिचको सीमितता पूरा गर्न केका रूपमा लिइन्छ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कक्षाकोठामा मामला अध्ययनको मुख्य फाइदा के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'कक्षाकोठामा मामला अध्ययनको मुख्य फाइदा के हो?', E'विद्यार्थी वा तालिम सहभागीलाई सहभागितामूलक अनि सक्रिय बनाउनु', E'परीक्षामा राम्रो अङ्क सुनिश्चित गर्नु', E'शिक्षकको कार्यभार घटाउनु', E'पाठ्यपुस्तकको खर्च घटाउनु', E'A', E'**मामला अध्ययनको मुख्य फाइदा भनेको नै विद्यार्थी वा तालिम सहभागीलाई सहभागितामूलक अनि सक्रिय बनाउनु हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कक्षाकोठामा मामला अध्ययनको मुख्य फाइदा के हो?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'मामला अध्ययनको आवश्यकता/महत्त्वअन्तर्गत निम्नमध्ये कुन पर्दैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'मामला अध्ययनको आवश्यकता/महत्त्वअन्तर्गत निम्नमध्ये कुन पर्दैन?', E'समस्या समाधान गर्ने सीपको विकास गर्न', E'शिक्षकको पारिश्रमिक बढाउन', E'वास्तविक समस्या पहिचान गर्न', E'दुई वा दुईभन्दा बढी एकाइबिचको तुलनात्मक अध्ययन गर्न', E'B', E'**"शिक्षकको पारिश्रमिक बढाउन" मामला अध्ययनको आवश्यकता/महत्त्वअन्तर्गत पर्दैन।**\\n- वास्तविक समस्या पहिचान, तुलनात्मक अध्ययन र समस्या समाधान सीप विकास तीनवटै मामला अध्ययनका वास्तविक आवश्यकताहरू हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:मामला अध्ययनको आवश्यकता/महत्त्वअन्तर्गत निम्नमध्ये कुन पर्दैन?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'मामला अध्ययनको सीमा/आलोचनाका रूपमा निम्नमध्ये के औंल्याइन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'मामला अध्ययनको सीमा/आलोचनाका रूपमा निम्नमध्ये के औंल्याइन्छ?', E'यो सबै उमेर समूहका लागि उत्तिकै उपयोगी हुन्छ', E'यसले सधैँ स्थिर ज्ञान प्रदान गर्छ', E'यो खर्चिलो र समय लाग्ने हुन्छ', E'यसमा वास्तविकता पत्ता लगाउन सजिलो हुन्छ', E'C', E'**मामला अध्ययनको सीमाका रूपमा यो खर्चिलो हुनु र वास्तविकता पत्ता लगाउन बढी समय लाग्नुलाई औंल्याइन्छ।**\\nनोट: शीर्षक छनोटमा समस्या हुनु र यो उच्च तहका शिक्षकका लागि मात्र बढी उपयोगी हुनु पनि यसका अन्य सीमाहरू हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:मामला अध्ययनको सीमा/आलोचनाका रूपमा निम्नमध्ये के औंल्याइन्छ?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'मामला विकासका अङ्गहरूमध्ये "The Set or Hook" ले के जनाउँछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'मामला विकासका अङ्गहरूमध्ये "The Set or Hook" ले के जनाउँछ?', E'केसको पृष्ठभूमि मात्र', E'प्रशिक्षकका लागि निर्देशिका', E'समाधानका लागि अपनाइएको एउटा अनुभव', E'ध्यानाकृष्ट गराउने रोचक पक्ष', E'D', E'**"The Set or Hook" ले ध्यानाकृष्ट गराउने त्यस्तो रोचक पक्ष जनाउँछ जुन शिक्षक, प्रशिक्षक वा शैक्षिक व्यवस्थापकका लागि महत्त्वपूर्ण हुन्छ।**\\nनोट: यसपछिका अङ्गमा अवस्थाको पृष्ठभूमि (Background), अवस्था (The Case), सम्भावित समाधान र प्रशिक्षकका लागि निर्देशिका पर्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:मामला विकासका अङ्गहरूमध्ये "The Set or Hook" ले के जनाउँछ?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'मामला अध्ययनको शिक्षा क्षेत्रमा उपादेयताअनुसार यसले परिमाणात्मकभन्दा कुन पक्षमा विशेष जोड दिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'मामला अध्ययनको शिक्षा क्षेत्रमा उपादेयताअनुसार यसले परिमाणात्मकभन्दा कुन पक्षमा विशेष जोड दिन्छ?', E'गुणात्मक अध्ययनको पक्षमा', E'तथ्याङ्कीय अनुमानको पक्षमा', E'प्रयोगशाला परीक्षणको पक्षमा', E'सर्वेक्षण नमुनाकरणको पक्षमा', E'A', E'**मामला अध्ययनले परिमाणात्मकभन्दा गुणात्मक अध्ययनको पक्षमा विशेष जोड दिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:मामला अध्ययनको शिक्षा क्षेत्रमा उपादेयताअनुसार यसले परिमाणात्मकभन्दा कुन पक्षमा विशेष जोड दिन्छ?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: कार्यमूलक अनुसन्धानः उद्देश्य र प्रयोग (आधारभूत तह) (17 Q)
  v_set_id := extensions.uuid_generate_v5('a483ac23-07f8-470a-ac94-2e72f60f9d81'::uuid, E'कार्यमूलक अनुसन्धानः उद्देश्य र प्रयोग (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'f7ab6c7c-21c8-4214-baf0-ec92ef9ac5d9'::uuid, 'a483ac23-07f8-470a-ac94-2e72f60f9d81'::uuid, E'कार्यमूलक अनुसन्धानः उद्देश्य र प्रयोग (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'a483ac23-07f8-470a-ac94-2e72f60f9d81'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कार्यमूलक अनुसन्धानको सुरुवात कुन मनोविज्ञानवेत्ताले सन् १९४६ मा गरेका थिए?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'कार्यमूलक अनुसन्धानको सुरुवात कुन मनोविज्ञानवेत्ताले सन् १९४६ मा गरेका थिए?', E'Stephen Corey', E'Kurt Lewin', E'Lawrence Stenhouse', E'Kerlinger', E'B', E'**कार्यमूलक अनुसन्धानको सुरुवात मनोविज्ञानवेत्ता कुर्ट लेविन (Kurt Lewin) ले सन् १९४६ मा गरेका हुन्।**\\n- Stephen Corey ले सन् १९५३ मा कार्यमूलक अनुसन्धानलाई अभ्यासकर्ताले आफ्नो समस्याको वैज्ञानिक अध्ययन गरी सुधार्ने प्रक्रियाका रूपमा व्याख्या गरे।\\n- Lawrence Stenhouse ले सन् १९७० मा अमेरिकामा मानविकी पाठ्यक्रम परियोजना सुरु गरी शिक्षा क्षेत्रमा यसको व्यापक प्रयोग गराए।\\n- Kerlinger शैक्षिक अनुसन्धानका सामान्य परिभाषाकार हुन्, कार्यमूलक अनुसन्धानका प्रवर्तक होइनन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कार्यमूलक अनुसन्धानको सुरुवात कुन मनोविज्ञानवेत्ताले सन् १९४६ मा गरेका थिए?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुर्ट लेविनका अनुसार कार्यमूलक अनुसन्धान भनेको के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'कुर्ट लेविनका अनुसार कार्यमूलक अनुसन्धान भनेको के हो?', E'विज्ञहरूले मात्र गर्ने सैद्धान्तिक खोज', E'परीक्षा प्रणालीको तथ्याङ्कीय विश्लेषण', E'योजना, कार्यान्वयन र नतिजाको पहिचानसहितको चक्रीय प्रक्रिया', E'पूर्णतः प्रयोगशालामा गरिने प्रयोग', E'C', E'**कुर्ट लेविनका अनुसार कार्यमूलक अनुसन्धान भनेको योजना, कार्यान्वयन र नतिजाको पहिचानसहितको चक्रीय प्रक्रिया हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुर्ट लेविनका अनुसार कार्यमूलक अनुसन्धान भनेको के हो?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सन् १९७० मा अमेरिकामा मानविकी पाठ्यक्रम परियोजनाको सुरुवात गरी शिक्षा क्षेत्रमा कार्यमूलक अनुसन्धानको व्यापक प्रयोग गराउने विद्वान् को हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'सन् १९७० मा अमेरिकामा मानविकी पाठ्यक्रम परियोजनाको सुरुवात गरी शिक्षा क्षेत्रमा कार्यमूलक अनुसन्धानको व्यापक प्रयोग गराउने विद्वान् को हुन्?', E'Stephen Corey', E'Koul', E'Kurt Lewin', E'Lawrence Stenhouse', E'D', E'**Lawrence Stenhouse ले सन् १९७० मा अमेरिकामा मानविकी पाठ्यक्रम परियोजनाको सुरुवात गरेपछि शिक्षा क्षेत्रमा कार्यमूलक अनुसन्धानको व्यापक प्रयोग हुन थाल्यो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सन् १९७० मा अमेरिकामा मानविकी पाठ्यक्रम परियोजनाको सुरुवात गरी शिक्षा क्षेत्रमा कार्यमूलक अनुसन्धानको व्यापक प्रयोग गराउने विद्वान् को हुन्?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कार्यमूलक अनुसन्धानका प्रकारहरूमध्ये दुई वा दुईभन्दा बढी व्यक्ति मिलेर साझा समस्याबारे गरिने अनुसन्धानलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'कार्यमूलक अनुसन्धानका प्रकारहरूमध्ये दुई वा दुईभन्दा बढी व्यक्ति मिलेर साझा समस्याबारे गरिने अनुसन्धानलाई के भनिन्छ?', E'सहकार्यात्मक कार्यमूलक अनुसन्धान', E'व्यक्तिगत कार्यमूलक अनुसन्धान', E'आधारभूत अनुसन्धान', E'विद्यालयगत/संस्थागत कार्यमूलक अनुसन्धान', E'A', E'**दुई वा दुईभन्दा बढी व्यक्ति मिलेर साझा समस्याबारे गर्ने अनुसन्धानलाई सहकार्यात्मक (Collaborative) कार्यमूलक अनुसन्धान भनिन्छ।**\\n- व्यक्तिगत कार्यमूलक अनुसन्धान शिक्षकको व्यक्तिगत रुचिअनुसार सञ्चालन हुन्छ।\\n- विद्यालयगत/संस्थागत कार्यमूलक अनुसन्धान विद्यालय सुधार तथा साझा समस्यामा केन्द्रित हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कार्यमूलक अनुसन्धानका प्रकारहरूमध्ये दुई वा दुईभन्दा बढी व्यक्ति मिलेर साझा समस्याबारे गरिने अनुसन्धानलाई के भनिन्छ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यालय सुधार तथा साझा समस्यालाई मुख्य केन्द्रमा राखी सम्पूर्ण विद्यालय परिवार सहभागी हुने कार्यमूलक अनुसन्धानलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'विद्यालय सुधार तथा साझा समस्यालाई मुख्य केन्द्रमा राखी सम्पूर्ण विद्यालय परिवार सहभागी हुने कार्यमूलक अनुसन्धानलाई के भनिन्छ?', E'वर्णनात्मक अनुसन्धान', E'विद्यालयगत/संस्थागत कार्यमूलक अनुसन्धान', E'व्यक्तिगत कार्यमूलक अनुसन्धान', E'सहकार्यात्मक कार्यमूलक अनुसन्धान', E'B', E'**विद्यालय सुधार तथा साझा समस्यामा केन्द्रित भई सम्पूर्ण विद्यालय परिवार सहभागी हुने अनुसन्धानलाई विद्यालयगत/संस्थागत कार्यमूलक अनुसन्धान भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यालय सुधार तथा साझा समस्यालाई मुख्य केन्द्रमा राखी सम्पूर्ण विद्यालय परिवार सहभागी हुने कार्यमूलक अनुसन्धानलाई के भनिन्छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'आधारभूत अनुसन्धान र कार्यमूलक अनुसन्धानबिचको भिन्नताअनुसार कार्यमूलक अनुसन्धान सामान्यतया कसद्वारा गरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'आधारभूत अनुसन्धान र कार्यमूलक अनुसन्धानबिचको भिन्नताअनुसार कार्यमूलक अनुसन्धान सामान्यतया कसद्वारा गरिन्छ?', E'अन्तर्राष्ट्रिय संस्थाद्वारा', E'विद्यार्थीहरूद्वारा मात्र', E'अभ्यासकर्ता वा शिक्षकद्वारा स्वयम्', E'बाहिरका विज्ञहरूद्वारा', E'C', E'**कार्यमूलक अनुसन्धान अभ्यासकर्ता वा शिक्षकद्वारा स्वयम् गरिन्छ, जबकि आधारभूत अनुसन्धान सामान्यतया बाहिरका विज्ञहरूद्वारा गरिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:आधारभूत अनुसन्धान र कार्यमूलक अनुसन्धानबिचको भिन्नताअनुसार कार्यमूलक अनुसन्धान सामान्यतया कसद्वारा गरिन्छ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'आधारभूत अनुसन्धान र कार्यमूलक अनुसन्धानबिचको भिन्नताअनुसार आधारभूत अनुसन्धानको उद्देश्य के हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'आधारभूत अनुसन्धान र कार्यमूलक अनुसन्धानबिचको भिन्नताअनुसार आधारभूत अनुसन्धानको उद्देश्य के हुन्छ?', E'कुनै एक विद्यालयको समस्या समाधान गर्नु मात्र', E'सुझाव कार्यान्वयन गर्नु', E'आफ्नो कार्यमा तत्काल सुधार ल्याउनु', E'प्रमाणित गर्नु र सुझाव दिनु', E'D', E'**आधारभूत अनुसन्धानको उद्देश्य प्रमाणित गर्नु र सुझाव दिनु हो, जबकि कार्यमूलक अनुसन्धानको उद्देश्य सुधार गर्नु र सुझाव कार्यान्वयन गर्नु हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:आधारभूत अनुसन्धान र कार्यमूलक अनुसन्धानबिचको भिन्नताअनुसार आधारभूत अनुसन्धानको उद्देश्य के हुन्छ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कार्यमूलक अनुसन्धानका आधारभूत विशेषताहरूमध्ये यसमा सङ्ख्यात्मकभन्दा गुणात्मक सूचनालाई बढी प्राथमिकता दिइने विशेषतालाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'कार्यमूलक अनुसन्धानका आधारभूत विशेषताहरूमध्ये यसमा सङ्ख्यात्मकभन्दा गुणात्मक सूचनालाई बढी प्राथमिकता दिइने विशेषतालाई के भनिन्छ?', E'गुणात्मक', E'योजनाबद्ध', E'सान्दर्भिक', E'लचकता', E'A', E'**कार्यमूलक अनुसन्धान गुणात्मक हुन्छ, अर्थात् यसमा सङ्ख्यात्मकभन्दा गुणात्मक सूचना वा तथ्याङ्कलाई बढी प्राथमिकता दिइन्छ र मानवीय अनुभूति, संवेग जस्ता भावनात्मक पक्ष समेटिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कार्यमूलक अनुसन्धानका आधारभूत विशेषताहरूमध्ये यसमा सङ्ख्यात्मकभन्दा गुणात्मक सूचनालाई बढी प्राथमिकता दिइने विशेषतालाई के भनिन्छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कार्यमूलक अनुसन्धानको कुन विशेषताले यो कुनै प्राज्ञ वा बाह्य विशेषज्ञबाट नभई कार्यान्वयनकर्ता स्वयम्बाट गरिने भएकाले यसलाई स्वनिर्दिष्ट बनाउँछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'कार्यमूलक अनुसन्धानको कुन विशेषताले यो कुनै प्राज्ञ वा बाह्य विशेषज्ञबाट नभई कार्यान्वयनकर्ता स्वयम्बाट गरिने भएकाले यसलाई स्वनिर्दिष्ट बनाउँछ?', E'सिकाइ', E'अभ्यासकर्ताको प्रत्यक्ष सहभागिता', E'एकीकृत', E'योजनाबद्ध', E'B', E'**अभ्यासकर्ताको प्रत्यक्ष सहभागिता भन्ने विशेषताले कार्यमूलक अनुसन्धानलाई स्वनिर्दिष्ट बनाउँछ, किनभने यो कुनै प्राज्ञ, बाह्य विशेषज्ञ वा तेस्रो पक्षबाट नभई कार्यान्वयनकर्ता स्वयम्बाट गरिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कार्यमूलक अनुसन्धानको कुन विशेषताले यो कुनै प्राज्ञ वा बाह्य विशेषज्ञबाट नभई कार्यान्वयनकर्ता स्वयम्बाट गरिने भएकाले यसलाई स्वनिर्दिष्ट बनाउँछ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कार्यमूलक अनुसन्धानको कुन विशेषताअन्तर्गत योजना विकास, कार्यान्वयन, अवलोकन, स्वप्रत्यावर्तन र पुनः योजनाको चक्र चलिरहन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'कार्यमूलक अनुसन्धानको कुन विशेषताअन्तर्गत योजना विकास, कार्यान्वयन, अवलोकन, स्वप्रत्यावर्तन र पुनः योजनाको चक्र चलिरहन्छ?', E'एकीकृत', E'विशिष्ट विषयमा केन्द्रित', E'चक्रीय', E'लचकता', E'C', E'**चक्रीय विशेषताअन्तर्गत योजना विकास, कार्यान्वयन, अवलोकन, स्वप्रत्यावर्तन र पुनः योजनाको चक्र भोगेको समस्या समाधान नहुँदासम्म चलिरहन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कार्यमूलक अनुसन्धानको कुन विशेषताअन्तर्गत योजना विकास, कार्यान्वयन, अवलोकन, स्वप्रत्यावर्तन र पुनः योजनाको चक्र चलिरहन्छ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कार्यमूलक अनुसन्धानको महत्त्वपूर्ण चरणमध्ये अनुसन्धान रणनीति र समस्याबिचको सम्बन्ध के रह्यो भनी चिन्तन गरिने चरणलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'कार्यमूलक अनुसन्धानको महत्त्वपूर्ण चरणमध्ये अनुसन्धान रणनीति र समस्याबिचको सम्बन्ध के रह्यो भनी चिन्तन गरिने चरणलाई के भनिन्छ?', E'क्रियाशीलता', E'परिवर्तनमुखी', E'सान्दर्भिक', E'स्वप्रत्यावर्तन', E'D', E'**स्वप्रत्यावर्तन कार्यमूलक अनुसन्धानको सबैभन्दा महत्त्वपूर्ण चरण मानिन्छ, जसमा रणनीति र समस्याबिचको सम्बन्ध के रह्यो र के सिकाइ भयो भनी चिन्तन गरिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कार्यमूलक अनुसन्धानको महत्त्वपूर्ण चरणमध्ये अनुसन्धान रणनीति र समस्याबिचको सम्बन्ध के रह्यो भनी चिन्तन गरिने चरणलाई के भनिन्छ?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'PAOR चरणमा आधारित कार्यमूलक अनुसन्धानको प्रक्रियामा "योजना" पछि दोस्रो चरण के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'PAOR चरणमा आधारित कार्यमूलक अनुसन्धानको प्रक्रियामा "योजना" पछि दोस्रो चरण के हो?', E'कार्य (Action)', E'प्रतिबिम्बन (Reflection)', E'प्रतिवेदन तयारी', E'अवलोकन (Observation)', E'A', E'**PAOR चरणअनुसार योजना (Plan) पछि कार्य (Act) चरण आउँछ, त्यसपछि अवलोकन (Observation) र अन्त्यमा प्रतिबिम्बन (Reflection) गरिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:PAOR चरणमा आधारित कार्यमूलक अनुसन्धानको प्रक्रियामा "योजना" पछि दोस्रो चरण के हो?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'J.W. Creswell का अनुसार कार्यमूलक अनुसन्धानका चरणहरू कति ओटा छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'J.W. Creswell का अनुसार कार्यमूलक अनुसन्धानका चरणहरू कति ओटा छन्?', E'६ ओटा', E'८ ओटा', E'१० ओटा', E'४ ओटा', E'B', E'**J.W. Creswell का अनुसार कार्यमूलक अनुसन्धानका आठ ओटा चरणहरू छन्, जुन कार्यमूलक अनुसन्धान नै उपयुक्त हो भन्ने निर्धारणदेखि सुरु भई कार्ययोजना कार्यान्वयन र समीक्षामा टुङ्गिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:J.W. Creswell का अनुसार कार्यमूलक अनुसन्धानका चरणहरू कति ओटा छन्?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'प्रत्येक शिक्षकले वर्षमा कम्तिमा कति वटा कार्यमूलक अनुसन्धान सम्पन्न गरी प्रधानाध्यापकलाई प्रतिवेदन बुझाउनुपर्ने व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'प्रत्येक शिक्षकले वर्षमा कम्तिमा कति वटा कार्यमूलक अनुसन्धान सम्पन्न गरी प्रधानाध्यापकलाई प्रतिवेदन बुझाउनुपर्ने व्यवस्था छ?', E'३ वटा', E'५ वटा', E'१ वटा', E'२ वटा', E'C', E'**हरेक वर्ष प्रत्येक शिक्षकले कम्तिमा एउटा कार्यमूलक अनुसन्धान सम्पन्न गरी प्रतिवेदन प्रधानाध्यापकलाई बुझाउनुपर्ने व्यवस्था छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:प्रत्येक शिक्षकले वर्षमा कम्तिमा कति वटा कार्यमूलक अनुसन्धान सम्पन्न गरी प्रधानाध्यापकलाई प्रतिवेदन बुझाउनुपर्ने व्यवस्था छ?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कार्यक्षमताका आधारमा बढुवा हुने प्रयोजनका लागि कार्यमूलक अनुसन्धानबापत शिक्षकले पछिल्लो ५ वर्षको जम्मा कति अङ्क प्राप्त गर्न सक्छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'कार्यक्षमताका आधारमा बढुवा हुने प्रयोजनका लागि कार्यमूलक अनुसन्धानबापत शिक्षकले पछिल्लो ५ वर्षको जम्मा कति अङ्क प्राप्त गर्न सक्छन्?', E'३ अङ्क', E'८ अङ्क', E'१० अङ्क', E'५ अङ्क', E'D', E'**कार्यमूलक अनुसन्धानबापत शिक्षकले प्रतिवर्ष १ अङ्कका दरले पछिल्लो ५ वर्षको जम्मा ५ अङ्क प्राप्त गर्न सक्छन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कार्यक्षमताका आधारमा बढुवा हुने प्रयोजनका लागि कार्यमूलक अनुसन्धानबापत शिक्षकले पछिल्लो ५ वर्षको जम्मा कति अङ्क प्राप्त गर्न सक्छन्?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कार्यमूलक अनुसन्धान गर्नुका कारणहरूमध्ये निम्नमध्ये कुन पर्दैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'कार्यमूलक अनुसन्धान गर्नुका कारणहरूमध्ये निम्नमध्ये कुन पर्दैन?', E'विद्यालयको भवन निर्माण गर्न', E'सिकाइका पुराना तथा नयाँ सिद्धान्तको परीक्षण गरी उपयोगी सिद्धान्त प्रयोग गर्न', E'कार्यसम्पादनस्तरमा सुधार ल्याउन र पेसागत दक्षता बढाउन', E'कार्यस्थलमा आइपरेका समस्याको कारण पहिचान गरी सुधारका उपाय पहिचान गर्न', E'A', E'**"विद्यालयको भवन निर्माण गर्न" कार्यमूलक अनुसन्धान गर्नुका कारणहरूमध्ये पर्दैन।**\\n- कार्यसम्पादन सुधार, समस्या-कारण पहिचान र सिद्धान्त परीक्षण तीनवटै वास्तविक कारणहरू हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कार्यमूलक अनुसन्धान गर्नुका कारणहरूमध्ये निम्नमध्ये कुन पर्दैन?'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'आधारभूत अनुसन्धान र कार्यमूलक अनुसन्धानबिचको भिन्नताअनुसार आधारभूत अनुसन्धानको योजना कस्तो प्रकृतिको बनाइन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'आधारभूत अनुसन्धान र कार्यमूलक अनुसन्धानबिचको भिन्नताअनुसार आधारभूत अनुसन्धानको योजना कस्तो प्रकृतिको बनाइन्छ?', E'एकल-चरणमा सीमित', E'क्षितिजीय (Horizontal) र वृहत् किसिमको', E'पूर्णतः अनौपचारिक', E'चक्रीय (Spiral) र छोटो किसिमको', E'B', E'**आधारभूत अनुसन्धानको योजना क्षितिजीय (Horizontal) र वृहत् किसिमले बनाइन्छ, जसमा स्रोतसाधन पनि बढी खर्च हुन सक्छ।**\\nनोट: कार्यमूलक अनुसन्धानको भने छोटा-छोटा योजना चक्रीय (Spiral) हिसाबले बनाइन्छ र थोरै स्रोतसाधनबाटै सम्पन्न गर्न सकिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:आधारभूत अनुसन्धान र कार्यमूलक अनुसन्धानबिचको भिन्नताअनुसार आधारभूत अनुसन्धानको योजना कस्तो प्रकृतिको बनाइन्छ?'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  RAISE NOTICE 'Unit ख-९ शिक्षक पेशागत विकास batch upsert complete: 7 sets, 114 questions.';
END $$;
