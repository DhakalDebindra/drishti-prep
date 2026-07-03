-- Idempotent UPSERT: adds 2 new facts + refines 1 explanation in घ-३ दशौं संशोधन, २०८३ subtopic
-- (based on a cleaner user-provided follow-up text of the same संशोधन summary). Generated 2026-07-03T16:41:08.510Z.
DO $$
DECLARE
  v_module_id uuid := '6695669a-f40e-421a-a4ec-b09bbeaf56c4'::uuid;
  v_set_id uuid := extensions.uuid_generate_v5('e678c282-ceaf-4f41-b689-6c5092f6d1ab'::uuid, E'शिक्षा नियमावली, २०५९: दशौं संशोधन, २०८३ का प्रमुख परिवर्तनहरू (आधारभूत तह)');
  v_q_id uuid;
BEGIN
  -- position offset: append after the existing 10 questions (positions 11-13; note pos 11 refines an existing question in place)

  -- Refine explanation only (position untouched) for the existing SEE question
  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा नियमावली (दशौं संशोधन), २०८३ ले माध्यमिक तह उत्तीर्ण परीक्षा (SEE) सहभागिताका लागि पहिले तोकिएको कस्तो प्रावधान हटाएको छ?');
  UPDATE public.questions SET explanation = E'**दशौं संशोधनले SEE सहभागिताका लागि उमेरको हद (कक्षा १ मा ५ वर्षमा भर्ना भएको भए SEE मा १४ वर्ष पुगेको हुनुपर्ने प्रावधान) हटाएको छ।**\\nनोट: कक्षा १ मा भर्नाका लागि ५ वर्ष उमेर पूरा हुनुपर्ने व्यवस्था भने यथावत् रहेको छ।', is_verified = true WHERE id = v_q_id;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा नियमावली (दशौं संशोधन), २०८३ ले शैक्षिक सत्र, पाठ्यक्रम तथा पाठ्यभार परिवर्तन गर्ने अधिकार कसलाई दिएको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'शिक्षा नियमावली (दशौं संशोधन), २०८३ ले शैक्षिक सत्र, पाठ्यक्रम तथा पाठ्यभार परिवर्तन गर्ने अधिकार कसलाई दिएको छ?', E'स्थानीय तह', E'शिक्षा, विज्ञान तथा प्रविधि मन्त्रालय', E'जिल्ला शिक्षा समिति', E'राष्ट्रिय परीक्षा बोर्ड', E'B', E'**दशौं संशोधनले शैक्षिक सत्र, पाठ्यक्रम तथा पाठ्यभार परिवर्तन गर्ने अधिकार मन्त्रालयलाई दिएको छ।**\\nनोट: यसअघि विशेष गरी विकट हिमाली जिल्लाहरूमा मात्र सीमित गरी शैक्षिक सत्र परिवर्तन हुने व्यवस्था थियो — दशौं संशोधनपछि यो अधिकार सामान्य रूपमा मन्त्रालयसँग रहेको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा नियमावली (दशौं संशोधन), २०८३ ले शैक्षिक सत्र, पाठ्यक्रम तथा पाठ्यभार परिवर्तन गर्ने अधिकार कसलाई दिएको छ?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा नियमावली (दशौं संशोधन), २०८३ अनुसार विज्ञापन भइसकेको वा समायोजनमा परेको पदमा शिक्षकको सरुवा हुन पाउँछ कि पाउँदैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'शिक्षा नियमावली (दशौं संशोधन), २०८३ अनुसार विज्ञापन भइसकेको वा समायोजनमा परेको पदमा शिक्षकको सरुवा हुन पाउँछ कि पाउँदैन?', E'पाउँछ', E'पाउँदैन', E'मन्त्रालयको स्वीकृतिमा मात्र पाउँछ', E'स्थानीय तहको सिफारिसमा मात्र पाउँछ', E'B', E'**दशौं संशोधनले विज्ञापन भइसकेको वा समायोजनमा परेको पदमा शिक्षकको सरुवा हुन नपाइने स्पष्ट व्यवस्था गरेको छ।**\\nनोट: यसैसँगै सरुवा प्रावधानलाई थप वस्तुनिष्ठ बनाइएको छ — विशेष अवस्थाका शिक्षकलाई प्राथमिकता र पारस्परिक सरुवाको व्यवस्था पनि थपिएको छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा नियमावली (दशौं संशोधन), २०८३ अनुसार विज्ञापन भइसकेको वा समायोजनमा परेको पदमा शिक्षकको सरुवा हुन पाउँछ कि पाउँदैन?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  RAISE NOTICE 'घ-३ दशौं संशोधन addendum upsert complete: 1 explanation refined, 2 new questions added.';
END $$;
