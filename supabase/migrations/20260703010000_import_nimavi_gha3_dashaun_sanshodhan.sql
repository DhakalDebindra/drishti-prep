-- Idempotent UPSERT import: निमावि प्रथम पत्र — घ-३ शिक्षा नियमावली supplementary set on दशौं संशोधन, २०८३
-- Override same-identity sets/questions; never deletes. Generated 2026-07-03T16:35:40.909Z.
DO $$
DECLARE
  v_module_id uuid := '6695669a-f40e-421a-a4ec-b09bbeaf56c4'::uuid;
  v_set_id uuid;
  v_q_id uuid;
BEGIN

  -- Set: शिक्षा नियमावली, २०५९: दशौं संशोधन, २०८३ का प्रमुख परिवर्तनहरू (आधारभूत तह) (10 Q)
  v_set_id := extensions.uuid_generate_v5('e678c282-ceaf-4f41-b689-6c5092f6d1ab'::uuid, E'शिक्षा नियमावली, २०५९: दशौं संशोधन, २०८३ का प्रमुख परिवर्तनहरू (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'af1b68f3-8f5e-4735-8f1e-3e5960ba3403'::uuid, 'e678c282-ceaf-4f41-b689-6c5092f6d1ab'::uuid, E'शिक्षा नियमावली, २०५९: दशौं संशोधन, २०८३ का प्रमुख परिवर्तनहरू (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'e678c282-ceaf-4f41-b689-6c5092f6d1ab'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा नियमावली (दशौं संशोधन), २०८३ अनुसार सामुदायिक विद्यालयको प्रत्येक कक्षामा हुनुपर्ने विद्यार्थी सङ्ख्या उपत्यका-तराई, पहाड र हिमाली क्षेत्रमा नयाँ रूपमा कति तोकिएको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'शिक्षा नियमावली (दशौं संशोधन), २०८३ अनुसार सामुदायिक विद्यालयको प्रत्येक कक्षामा हुनुपर्ने विद्यार्थी सङ्ख्या उपत्यका-तराई, पहाड र हिमाली क्षेत्रमा नयाँ रूपमा कति तोकिएको छ?', E'५०, ४०, ३०', E'५०, ४५, ४०', E'३०, २५, २०', E'४४, ३३, २२', E'A', E'**दशौं संशोधन, २०८३ ले सामुदायिक विद्यालयको कक्षागत विद्यार्थी सङ्ख्या उपत्यका-तराईमा ५० यथावत् राखी, पहाडमा ४० र हिमालमा ३० मा घटाएको छ।**\\nनोट: यसअघि पहाडमा ४५ र हिमालमा ४० तोकिएको थियो — यो पुरानो व्यवस्था हो, हाल लागू हुने संशोधित संख्या माथि उल्लिखित छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा नियमावली (दशौं संशोधन), २०८३ अनुसार सामुदायिक विद्यालयको प्रत्येक कक्षामा हुनुपर्ने विद्यार्थी सङ्ख्या उपत्यका-तराई, पहाड र हिमाली क्षेत्रमा नयाँ रूपमा कति तोकिएको छ?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा नियमावली (दशौं संशोधन), २०८३ ले विद्यालय खोल्ने र सञ्चालनको स्वीकृति दिने जिम्मेवारी कसलाई थप स्पष्ट रूपमा दिएको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'शिक्षा नियमावली (दशौं संशोधन), २०८३ ले विद्यालय खोल्ने र सञ्चालनको स्वीकृति दिने जिम्मेवारी कसलाई थप स्पष्ट रूपमा दिएको छ?', E'शिक्षा विकास तथा समन्वय इकाई', E'स्थानीय सरकार (गाउँपालिका/नगरपालिका)', E'जिल्ला शिक्षा समिति', E'शिक्षा, विज्ञान तथा प्रविधि मन्त्रालय', E'B', E'**दशौं संशोधनले विद्यालय खोल्ने र स्वीकृति दिने जिम्मेवारी स्थानीय सरकारलाई थप स्पष्ट रूपमा दिएको छ, र स्थानीय सरकार सञ्चालन ऐन, २०७४ सँग यसलाई थप मिलाइएको छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा नियमावली (दशौं संशोधन), २०८३ ले विद्यालय खोल्ने र सञ्चालनको स्वीकृति दिने जिम्मेवारी कसलाई थप स्पष्ट रूपमा दिएको छ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा नियमावली (दशौं संशोधन), २०८३ ले तलकामध्ये कुन अधिकार वा प्रावधान हटाएको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'शिक्षा नियमावली (दशौं संशोधन), २०८३ ले तलकामध्ये कुन अधिकार वा प्रावधान हटाएको छ?', E'जिल्ला शिक्षा समितिको अस्तित्व', E'प्रधानाध्यापकको प्रशासकीय भूमिका', E'निर्देशकको काम, कर्तव्य र अधिकार', E'विद्यालय व्यवस्थापन समितिको अस्तित्व', E'C', E'**दशौं संशोधनले निर्देशकको काम, कर्तव्य र अधिकार सम्बन्धी प्रावधान हटाएको छ, साथै समुदायद्वारा व्यवस्थापन भएको विद्यालयको प्रावधान पनि हटाएको छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा नियमावली (दशौं संशोधन), २०८३ ले तलकामध्ये कुन अधिकार वा प्रावधान हटाएको छ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा नियमावली (दशौं संशोधन), २०८३ अनुसार प्रधानाध्यापकको मासिक भत्ता प्राथमिक, आधारभूत (कक्षा ८ सम्म) र माध्यमिक तहमा क्रमशः कति वृद्धि गरिएको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'शिक्षा नियमावली (दशौं संशोधन), २०८३ अनुसार प्रधानाध्यापकको मासिक भत्ता प्राथमिक, आधारभूत (कक्षा ८ सम्म) र माध्यमिक तहमा क्रमशः कति वृद्धि गरिएको छ?', E'५००, १०००, १५००', E'२०००, ३०००, ४०००', E'१०००, १५००, २०००', E'१०००, २०००, ३०००', E'D', E'**दशौं संशोधनले प्रधानाध्यापकको मासिक भत्ता प्राथमिक तहमा १०००, आधारभूत (कक्षा ८ सम्म) तहमा २००० र माध्यमिक तहमा ३००० वृद्धि गरेको छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा नियमावली (दशौं संशोधन), २०८३ अनुसार प्रधानाध्यापकको मासिक भत्ता प्राथमिक, आधारभूत (कक्षा ८ सम्म) र माध्यमिक तहमा क्रमशः कति वृद्धि गरिएको छ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा नियमावली (दशौं संशोधन), २०८३ ले लामो अवधिको बिदा (असाधारण जस्ता) पहिले ४५ दिन रहेकोमा घटाएर कति दिन कायम गरेको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'शिक्षा नियमावली (दशौं संशोधन), २०८३ ले लामो अवधिको बिदा (असाधारण जस्ता) पहिले ४५ दिन रहेकोमा घटाएर कति दिन कायम गरेको छ?', E'३० दिन', E'१५ दिन', E'२० दिन', E'४० दिन', E'A', E'**दशौं संशोधनले लामो अवधिको बिदा पहिले ४५ दिन रहेकोमा घटाएर ३० दिन कायम गरेको छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा नियमावली (दशौं संशोधन), २०८३ ले लामो अवधिको बिदा (असाधारण जस्ता) पहिले ४५ दिन रहेकोमा घटाएर कति दिन कायम गरेको छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा नियमावली (दशौं संशोधन), २०८३ ले तलकामध्ये कुन शब्द/तह वर्गीकरण नियमावलीबाट हटाएको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'शिक्षा नियमावली (दशौं संशोधन), २०८३ ले तलकामध्ये कुन शब्द/तह वर्गीकरण नियमावलीबाट हटाएको छ?', E'आधारभूत तह', E'निम्न माध्यमिक तह', E'प्राथमिक तह', E'माध्यमिक तह', E'B', E'**दशौं संशोधनले ''निम्न माध्यमिक तह'' भन्ने शब्द नियमावलीबाट हटाएको छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा नियमावली (दशौं संशोधन), २०८३ ले तलकामध्ये कुन शब्द/तह वर्गीकरण नियमावलीबाट हटाएको छ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा नियमावली (दशौं संशोधन), २०८३ ले शिक्षकको कुन सेवा-सुविधा प्रणालीलाई नियमावलीमै उल्लेख गरेको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'शिक्षा नियमावली (दशौं संशोधन), २०८३ ले शिक्षकको कुन सेवा-सुविधा प्रणालीलाई नियमावलीमै उल्लेख गरेको छ?', E'स्वास्थ्य बिमा प्रणाली', E'आवास सुविधा प्रणाली', E'E-pension प्रणाली', E'यातायात भत्ता प्रणाली', E'C', E'**दशौं संशोधनले शिक्षकको E-pension प्रणालीलाई नियमावलीमै उल्लेख गरेको छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा नियमावली (दशौं संशोधन), २०८३ ले शिक्षकको कुन सेवा-सुविधा प्रणालीलाई नियमावलीमै उल्लेख गरेको छ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा नियमावली (दशौं संशोधन), २०८३ ले माध्यमिक तह उत्तीर्ण परीक्षा (SEE) सहभागिताका लागि पहिले तोकिएको कस्तो प्रावधान हटाएको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'शिक्षा नियमावली (दशौं संशोधन), २०८३ ले माध्यमिक तह उत्तीर्ण परीक्षा (SEE) सहभागिताका लागि पहिले तोकिएको कस्तो प्रावधान हटाएको छ?', E'हाजिरी प्रतिशतको सर्त', E'पाठ्यपुस्तक अनिवार्यताको सर्त', E'नागरिकताको सर्त', E'उमेरको हद (कक्षा १ मा ५ वर्ष भर्ना भएको भए SEE मा १४ वर्ष पुगेको हुनुपर्ने)', E'D', E'**दशौं संशोधनले SEE सहभागिताका लागि उमेरको हद (कक्षा १ मा ५ वर्षमा भर्ना भएको भए SEE मा १४ वर्ष पुगेको हुनुपर्ने प्रावधान) हटाएको छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा नियमावली (दशौं संशोधन), २०८३ ले माध्यमिक तह उत्तीर्ण परीक्षा (SEE) सहभागिताका लागि पहिले तोकिएको कस्तो प्रावधान हटाएको छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा नियमावली (दशौं संशोधन), २०८३ ले नेपाल शिक्षक महासंघको निर्वाचनका सन्दर्भमा के सुनिश्चित गरेको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'शिक्षा नियमावली (दशौं संशोधन), २०८३ ले नेपाल शिक्षक महासंघको निर्वाचनका सन्दर्भमा के सुनिश्चित गरेको छ?', E'सबै शिक्षकले मतदान गर्न पाउने', E'केवल स्थायी शिक्षकले मात्र मतदान गर्न पाउने', E'प्रधानाध्यापकहरूले मात्र मतदान गर्न पाउने', E'निर्वाचन नै खारेज गरिएको', E'A', E'**दशौं संशोधनले नेपाल शिक्षक महासंघको निर्वाचनमा सबै शिक्षकले मतदान गर्न पाउने सुनिश्चितता गरेको छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा नियमावली (दशौं संशोधन), २०८३ ले नेपाल शिक्षक महासंघको निर्वाचनका सन्दर्भमा के सुनिश्चित गरेको छ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा नियमावली (दशौं संशोधन), २०८३ अनुसार कस्तो विद्यालयलाई तत्काल समायोजन गरिने व्यवस्था गरिएको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'शिक्षा नियमावली (दशौं संशोधन), २०८३ अनुसार कस्तो विद्यालयलाई तत्काल समायोजन गरिने व्यवस्था गरिएको छ?', E'५० भन्दा कम विद्यार्थी भएको विद्यालय', E'शून्य (Zero) विद्यार्थी भएको विद्यालय', E'एक शिक्षक मात्र भएको विद्यालय', E'भवन नभएको विद्यालय', E'B', E'**दशौं संशोधनले शून्य (Zero) विद्यार्थी भएका विद्यालयलाई तत्काल समायोजन गर्ने व्यवस्था गरी विद्यालय समायोजन/एकीकरण प्रक्रियालाई वस्तुनिष्ठ र सहज बनाएको छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा नियमावली (दशौं संशोधन), २०८३ अनुसार कस्तो विद्यालयलाई तत्काल समायोजन गरिने व्यवस्था गरिएको छ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  RAISE NOTICE 'घ-३ दशौं संशोधन supplement upsert complete: 1 sets, 10 questions.';
END $$;
