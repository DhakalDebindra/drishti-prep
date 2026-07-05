-- Append round-2 aptitude batch (verbal-5, math-2): top-up existing sets to the 30Q cap.
-- Generated 2026-07-05T14:24:36.440Z.
DO $$
DECLARE
  v_set_id uuid;
  v_q_id uuid;
BEGIN

  -- Top-up: शाब्दिक बौद्धिक परीक्षणः शाब्दिक पजल र अमिल्दा शब्द (आधारभूत तह) (+18 Q, 12->30)
  v_set_id := extensions.uuid_generate_v5('fa0af7e0-6bb7-4c25-b62f-d2d8ce99f610'::uuid, E'शाब्दिक बौद्धिक परीक्षणः शाब्दिक पजल र अमिल्दा शब्द (आधारभूत तह)');

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1. शिक्षा 2. देशको 3. विकासको 4. मूल 5. आधार 6. हो|A:1, 2, 3, 4, 5, 6|B:2, 1, 3, 4, 5, 6|C:3, 2, 1, 4, 5, 6|D:1, 3, 2, 4, 5, 6');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'1. शिक्षा 2. देशको 3. विकासको 4. मूल 5. आधार 6. हो', E'1, 2, 3, 4, 5, 6', E'2, 1, 3, 4, 5, 6', E'3, 2, 1, 4, 5, 6', E'1, 3, 2, 4, 5, 6', E'A', E'''शिक्षा देशको विकासको मूल आधार हो'' अर्थपूर्ण वाक्य हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1. शिक्षा 2. देशको 3. विकासको 4. मूल 5. आधार 6. हो|A:1, 2, 3, 4, 5, 6|B:2, 1, 3, 4, 5, 6|C:3, 2, 1, 4, 5, 6|D:1, 3, 2, 4, 5, 6'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1. विना 2. सफलता 3. परिश्रम 4. प्राप्त 5. गर्न 6. सकिँदैन|A:1, 2, 3, 4, 5, 6|B:3, 1, 2, 4, 5, 6|C:2, 3, 1, 4, 5, 6|D:3, 2, 1, 5, 4, 6');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'1. विना 2. सफलता 3. परिश्रम 4. प्राप्त 5. गर्न 6. सकिँदैन', E'1, 2, 3, 4, 5, 6', E'3, 1, 2, 4, 5, 6', E'2, 3, 1, 4, 5, 6', E'3, 2, 1, 5, 4, 6', E'B', E'''परिश्रम विना सफलता प्राप्त गर्न सकिँदैन'' सही वाक्य हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1. विना 2. सफलता 3. परिश्रम 4. प्राप्त 5. गर्न 6. सकिँदैन|A:1, 2, 3, 4, 5, 6|B:3, 1, 2, 4, 5, 6|C:2, 3, 1, 4, 5, 6|D:3, 2, 1, 5, 4, 6'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1. अनुशासन 2. विद्यार्थीको 3. गहना 4. हो|A:2, 1, 3, 4|B:3, 2, 1, 4|C:1, 2, 3, 4|D:1, 3, 2, 4');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'1. अनुशासन 2. विद्यार्थीको 3. गहना 4. हो', E'2, 1, 3, 4', E'3, 2, 1, 4', E'1, 2, 3, 4', E'1, 3, 2, 4', E'C', E'''अनुशासन विद्यार्थीको गहना हो'' सही वाक्य हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1. अनुशासन 2. विद्यार्थीको 3. गहना 4. हो|A:2, 1, 3, 4|B:3, 2, 1, 4|C:1, 2, 3, 4|D:1, 3, 2, 4'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1. संरक्षणमा 2. हामीले 3. वातावरण 4. ध्यान 5. दिनुपर्छ|A:1, 2, 3, 4, 5|B:3, 1, 2, 4, 5|C:2, 1, 3, 5, 4|D:2, 3, 1, 4, 5');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'1. संरक्षणमा 2. हामीले 3. वातावरण 4. ध्यान 5. दिनुपर्छ', E'1, 2, 3, 4, 5', E'3, 1, 2, 4, 5', E'2, 1, 3, 5, 4', E'2, 3, 1, 4, 5', E'D', E'''हामीले वातावरण संरक्षणमा ध्यान दिनुपर्छ'' सही वाक्य हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1. संरक्षणमा 2. हामीले 3. वातावरण 4. ध्यान 5. दिनुपर्छ|A:1, 2, 3, 4, 5|B:3, 1, 2, 4, 5|C:2, 1, 3, 5, 4|D:2, 3, 1, 4, 5'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1. स्वस्थ 2. शरीरमा 3. मस्तिष्कको 4. वास 5. हुन्छ|A:1, 2, 3, 4, 5|B:2, 1, 3, 4, 5|C:3, 4, 1, 2, 5|D:1, 3, 2, 4, 5');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'1. स्वस्थ 2. शरीरमा 3. मस्तिष्कको 4. वास 5. हुन्छ', E'1, 2, 3, 4, 5', E'2, 1, 3, 4, 5', E'3, 4, 1, 2, 5', E'1, 3, 2, 4, 5', E'A', E'''स्वस्थ शरीरमा मस्तिष्कको वास हुन्छ'' सही वाक्य हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1. स्वस्थ 2. शरीरमा 3. मस्तिष्कको 4. वास 5. हुन्छ|A:1, 2, 3, 4, 5|B:2, 1, 3, 4, 5|C:3, 4, 1, 2, 5|D:1, 3, 2, 4, 5'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1. सदुपयोग 2. समयको 3. गर्ने 4. सफल 5. हुन्छ|A:1, 2, 3, 4, 5|B:2, 1, 3, 4, 5|C:3, 2, 1, 4, 5|D:2, 3, 1, 5, 4');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'1. सदुपयोग 2. समयको 3. गर्ने 4. सफल 5. हुन्छ', E'1, 2, 3, 4, 5', E'2, 1, 3, 4, 5', E'3, 2, 1, 4, 5', E'2, 3, 1, 5, 4', E'B', E'''समयको सदुपयोग गर्ने सफल हुन्छ'' सही वाक्य हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1. सदुपयोग 2. समयको 3. गर्ने 4. सफल 5. हुन्छ|A:1, 2, 3, 4, 5|B:2, 1, 3, 4, 5|C:3, 2, 1, 4, 5|D:2, 3, 1, 5, 4'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1. बाँड्यो 2. ज्ञान 3. बढ्छ 4. जति|A:1, 2, 3, 4|B:4, 2, 1, 3|C:2, 4, 1, 3|D:2, 1, 4, 3');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'1. बाँड्यो 2. ज्ञान 3. बढ्छ 4. जति', E'1, 2, 3, 4', E'4, 2, 1, 3', E'2, 4, 1, 3', E'2, 1, 4, 3', E'C', E'''ज्ञान जति बाँड्यो बढ्छ'' सही वाक्य हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1. बाँड्यो 2. ज्ञान 3. बढ्छ 4. जति|A:1, 2, 3, 4|B:4, 2, 1, 3|C:2, 4, 1, 3|D:2, 1, 4, 3'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1. शान्ति 2. सत्यको 3. मार्गमा 4. पाउँछ 5. हिँड्नेले|A:1, 2, 3, 4, 5|B:5, 2, 3, 1, 4|C:2, 5, 3, 1, 4|D:2, 3, 5, 1, 4');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 20, E'1. शान्ति 2. सत्यको 3. मार्गमा 4. पाउँछ 5. हिँड्नेले', E'1, 2, 3, 4, 5', E'5, 2, 3, 1, 4', E'2, 5, 3, 1, 4', E'2, 3, 5, 1, 4', E'D', E'''सत्यको मार्गमा हिँड्नेले शान्ति पाउँछ'' सही वाक्य हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1. शान्ति 2. सत्यको 3. मार्गमा 4. पाउँछ 5. हिँड्नेले|A:1, 2, 3, 4, 5|B:5, 2, 3, 1, 4|C:2, 5, 3, 1, 4|D:2, 3, 5, 1, 4'), v_set_id, v_q_id, 20)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1. बानी 2. राम्रो 3. आफ्नो काम 4. आफैं गर्नु 5. हो|A:3, 4, 2, 1, 5|B:1, 2, 3, 4, 5|C:4, 3, 2, 1, 5|D:3, 2, 4, 1, 5');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 21, E'1. बानी 2. राम्रो 3. आफ्नो काम 4. आफैं गर्नु 5. हो', E'3, 4, 2, 1, 5', E'1, 2, 3, 4, 5', E'4, 3, 2, 1, 5', E'3, 2, 4, 1, 5', E'A', E'''आफ्नो काम आफैं गर्नु राम्रो बानी हो'' सही वाक्य हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1. बानी 2. राम्रो 3. आफ्नो काम 4. आफैं गर्नु 5. हो|A:3, 4, 2, 1, 5|B:1, 2, 3, 4, 5|C:4, 3, 2, 1, 5|D:3, 2, 4, 1, 5'), v_set_id, v_q_id, 21)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1. प्यारो 2. असल 3. चरित्र 4. हुन्छ 5. सबैको|A:1, 2, 3, 4, 5|B:2, 3, 5, 1, 4|C:3, 2, 1, 5, 4|D:2, 5, 3, 1, 4');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 22, E'1. प्यारो 2. असल 3. चरित्र 4. हुन्छ 5. सबैको', E'1, 2, 3, 4, 5', E'2, 3, 5, 1, 4', E'3, 2, 1, 5, 4', E'2, 5, 3, 1, 4', E'B', E'''असल चरित्र सबैको प्यारो हुन्छ'' सही वाक्य हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1. प्यारो 2. असल 3. चरित्र 4. हुन्छ 5. सबैको|A:1, 2, 3, 4, 5|B:2, 3, 5, 1, 4|C:3, 2, 1, 5, 4|D:2, 5, 3, 1, 4'), v_set_id, v_q_id, 22)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1. प्रयास 2. सफलताको 3. निरन्तर 4. जरुरी 5. छ 6. लागि|A:1, 2, 3, 4, 5, 6|B:3, 1, 2, 6, 4, 5|C:2, 6, 3, 1, 4, 5|D:2, 3, 1, 6, 4, 5');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 23, E'1. प्रयास 2. सफलताको 3. निरन्तर 4. जरुरी 5. छ 6. लागि', E'1, 2, 3, 4, 5, 6', E'3, 1, 2, 6, 4, 5', E'2, 6, 3, 1, 4, 5', E'2, 3, 1, 6, 4, 5', E'C', E'''सफलताको लागि निरन्तर प्रयास जरुरी छ'' सही वाक्य हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1. प्रयास 2. सफलताको 3. निरन्तर 4. जरुरी 5. छ 6. लागि|A:1, 2, 3, 4, 5, 6|B:3, 1, 2, 6, 4, 5|C:2, 6, 3, 1, 4, 5|D:2, 3, 1, 6, 4, 5'), v_set_id, v_q_id, 23)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1. ठूलो 2. इमानदारी 3. सम्पत्ति 4. मानिसको 5. हो|A:1, 2, 3, 4, 5|B:4, 2, 1, 3, 5|C:2, 1, 4, 3, 5|D:2, 4, 1, 3, 5');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 24, E'1. ठूलो 2. इमानदारी 3. सम्पत्ति 4. मानिसको 5. हो', E'1, 2, 3, 4, 5', E'4, 2, 1, 3, 5', E'2, 1, 4, 3, 5', E'2, 4, 1, 3, 5', E'D', E'''इमानदारी मानिसको ठूलो सम्पत्ति हो'' सही वाक्य हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1. ठूलो 2. इमानदारी 3. सम्पत्ति 4. मानिसको 5. हो|A:1, 2, 3, 4, 5|B:4, 2, 1, 3, 5|C:2, 1, 4, 3, 5|D:2, 4, 1, 3, 5'), v_set_id, v_q_id, 24)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1. भविष्यका 2. बालबालिका 3. देशका 4. कर्णधार 5. हुन्|A:2, 3, 1, 4, 5|B:1, 2, 3, 4, 5|C:3, 2, 1, 4, 5|D:2, 1, 3, 4, 5');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 25, E'1. भविष्यका 2. बालबालिका 3. देशका 4. कर्णधार 5. हुन्', E'2, 3, 1, 4, 5', E'1, 2, 3, 4, 5', E'3, 2, 1, 4, 5', E'2, 1, 3, 4, 5', E'A', E'''बालबालिका देशका भविष्यका कर्णधार हुन्'' सही वाक्य हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1. भविष्यका 2. बालबालिका 3. देशका 4. कर्णधार 5. हुन्|A:2, 3, 1, 4, 5|B:1, 2, 3, 4, 5|C:3, 2, 1, 4, 5|D:2, 1, 3, 4, 5'), v_set_id, v_q_id, 25)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1. उज्यालोतिर 2. अध्ययनले 3. डोर्याउँछ 4. मानिसलाई|A:1, 2, 3, 4|B:2, 4, 1, 3|C:4, 2, 1, 3|D:2, 1, 4, 3');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 26, E'1. उज्यालोतिर 2. अध्ययनले 3. डोर्याउँछ 4. मानिसलाई', E'1, 2, 3, 4', E'2, 4, 1, 3', E'4, 2, 1, 3', E'2, 1, 4, 3', E'B', E'''अध्ययनले मानिसलाई उज्यालोतिर डोर्याउँछ'' सही वाक्य हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1. उज्यालोतिर 2. अध्ययनले 3. डोर्याउँछ 4. मानिसलाई|A:1, 2, 3, 4|B:2, 4, 1, 3|C:4, 2, 1, 3|D:2, 1, 4, 3'), v_set_id, v_q_id, 26)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1. पाठ 2. गल्तीबाट 3. सिक्ने 4. अघि बढ्छ|A:1, 2, 3, 4|B:3, 2, 1, 4|C:2, 1, 3, 4|D:2, 3, 1, 4');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 27, E'1. पाठ 2. गल्तीबाट 3. सिक्ने 4. अघि बढ्छ', E'1, 2, 3, 4', E'3, 2, 1, 4', E'2, 1, 3, 4', E'2, 3, 1, 4', E'C', E'''गल्तीबाट पाठ सिक्ने अघि बढ्छ'' सही वाक्य हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1. पाठ 2. गल्तीबाट 3. सिक्ने 4. अघि बढ्छ|A:1, 2, 3, 4|B:3, 2, 1, 4|C:2, 1, 3, 4|D:2, 3, 1, 4'), v_set_id, v_q_id, 27)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1. बल 2. एकतामा 3. ठूलो 4. लुकेको 5. हुन्छ|A:1, 2, 3, 4, 5|B:3, 1, 2, 4, 5|C:2, 1, 3, 4, 5|D:2, 3, 1, 4, 5');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 28, E'1. बल 2. एकतामा 3. ठूलो 4. लुकेको 5. हुन्छ', E'1, 2, 3, 4, 5', E'3, 1, 2, 4, 5', E'2, 1, 3, 4, 5', E'2, 3, 1, 4, 5', E'D', E'''एकतामा ठूलो बल लुकेको हुन्छ'' सही वाक्य हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1. बल 2. एकतामा 3. ठूलो 4. लुकेको 5. हुन्छ|A:1, 2, 3, 4, 5|B:3, 1, 2, 4, 5|C:2, 1, 3, 4, 5|D:2, 3, 1, 4, 5'), v_set_id, v_q_id, 28)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1. समाजलाई 2. सहयोगले 3. सकारात्मक 4. बनाउँछ|A:2, 1, 3, 4|B:1, 2, 3, 4|C:3, 2, 1, 4|D:2, 3, 1, 4');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 29, E'1. समाजलाई 2. सहयोगले 3. सकारात्मक 4. बनाउँछ', E'2, 1, 3, 4', E'1, 2, 3, 4', E'3, 2, 1, 4', E'2, 3, 1, 4', E'A', E'''सहयोगले समाजलाई सकारात्मक बनाउँछ'' सही वाक्य हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1. समाजलाई 2. सहयोगले 3. सकारात्मक 4. बनाउँछ|A:2, 1, 3, 4|B:1, 2, 3, 4|C:3, 2, 1, 4|D:2, 3, 1, 4'), v_set_id, v_q_id, 29)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'1. परम 2. आमाबाबुको 3. कर्तव्य 4. आदर गर्नु 5. हो|A:1, 2, 3, 4, 5|B:2, 4, 1, 3, 5|C:4, 2, 1, 3, 5|D:2, 1, 4, 3, 5');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 30, E'1. परम 2. आमाबाबुको 3. कर्तव्य 4. आदर गर्नु 5. हो', E'1, 2, 3, 4, 5', E'2, 4, 1, 3, 5', E'4, 2, 1, 3, 5', E'2, 1, 4, 3, 5', E'B', E'''आमाबाबुको आदर गर्नु परम कर्तव्य हो'' सही वाक्य हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:1. परम 2. आमाबाबुको 3. कर्तव्य 4. आदर गर्नु 5. हो|A:1, 2, 3, 4, 5|B:2, 4, 1, 3, 5|C:4, 2, 1, 3, 5|D:2, 1, 4, 3, 5'), v_set_id, v_q_id, 30)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Top-up: गणितीय क्षमताः छुटेका सङ्ख्याहरू पुरा गर्ने (आधारभूत तह) (+23 Q, 7->30)
  v_set_id := extensions.uuid_generate_v5('d912e8af-d7b4-4104-8bd0-e478e3f530a1'::uuid, E'गणितीय क्षमताः छुटेका सङ्ख्याहरू पुरा गर्ने (आधारभूत तह)');

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ५ | ७ | १२ |
|---|---|---|
| ८ | ३ | ११ |
| ९ | ६ | ? ||A:१५|B:१३|C:१४|D:१६');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ५ | ७ | १२ |
|---|---|---|
| ८ | ३ | ११ |
| ९ | ६ | ? |', E'१५', E'१३', E'१४', E'१६', E'A', E'म्याट्रिक्सको प्रत्येक पङ्क्तिमा (Row), पहिलो र दोस्रो सङ्ख्याको योगफल तेस्रो सङ्ख्या हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ५ | ७ | १२ |
|---|---|---|
| ८ | ३ | ११ |
| ९ | ६ | ? ||A:१५|B:१३|C:१४|D:१६'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ४ | ५ | २० |
|---|---|---|
| ६ | ३ | १८ |
| ७ | ८ | ? ||A:४९|B:५६|C:६४|D:५४');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ४ | ५ | २० |
|---|---|---|
| ६ | ३ | १८ |
| ७ | ८ | ? |', E'४९', E'५६', E'६४', E'५४', E'B', E'म्याट्रिक्सको प्रत्येक पङ्क्तिमा (Row), पहिलो र दोस्रो सङ्ख्याको गुणनफल तेस्रो सङ्ख्या हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ४ | ५ | २० |
|---|---|---|
| ६ | ३ | १८ |
| ७ | ८ | ? ||A:४९|B:५६|C:६४|D:५४'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| १५ | ६ | ९ |
|---|---|---|
| २० | ८ | १२ |
| २५ | १० | ? ||A:१०|B:२०|C:१५|D:२५');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| १५ | ६ | ९ |
|---|---|---|
| २० | ८ | १२ |
| २५ | १० | ? |', E'१०', E'२०', E'१५', E'२५', E'C', E'म्याट्रिक्सको प्रत्येक पङ्क्तिमा (Row), पहिलोबाट दोस्रो सङ्ख्या घटाउँदा तेस्रो सङ्ख्या हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| १५ | ६ | ९ |
|---|---|---|
| २० | ८ | १२ |
| २५ | १० | ? ||A:१०|B:२०|C:१५|D:२५'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ४ | १२ | ८ |
|---|---|---|
| ५ | १५ | १० |
| ६ | १८ | ? ||A:१४|B:१६|C:१८|D:१२');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ४ | १२ | ८ |
|---|---|---|
| ५ | १५ | १० |
| ६ | १८ | ? |', E'१४', E'१६', E'१८', E'१२', E'D', E'म्याट्रिक्सको प्रत्येक पङ्क्तिमा (Row), दोस्रोबाट पहिलो सङ्ख्या घटाउँदा तेस्रो सङ्ख्या हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ४ | १२ | ८ |
|---|---|---|
| ५ | १५ | १० |
| ६ | १८ | ? ||A:१४|B:१६|C:१८|D:१२'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ३ | ४ | १३ |
|---|---|---|
| ५ | २ | २७ | (२७)
| ४ | ५ | ? ||A:२१|B:१६|C:२५|D:१८');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ३ | ४ | १३ |
|---|---|---|
| ५ | २ | २७ | (२७)
| ४ | ५ | ? |', E'२१', E'१६', E'२५', E'१८', E'A', E'म्याट्रिक्सको प्रत्येक पङ्क्तिमा (Row), पहिलो सङ्ख्याको वर्गमा दोस्रो सङ्ख्या जोड्दा तेस्रो सङ्ख्या हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ३ | ४ | १३ |
|---|---|---|
| ५ | २ | २७ | (२७)
| ४ | ५ | ? ||A:२१|B:१६|C:२५|D:१८'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ५ | ३ | २२ |
|---|---|---|
| ६ | ४ | ३२ |
| ७ | ५ | ? ||A:४९|B:४४|C:४५|D:५०');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ५ | ३ | २२ |
|---|---|---|
| ६ | ४ | ३२ |
| ७ | ५ | ? |', E'४९', E'४४', E'४५', E'५०', E'B', E'म्याट्रिक्सको प्रत्येक पङ्क्तिमा (Row), पहिलो सङ्ख्याको वर्गबाट दोस्रो सङ्ख्या घटाउँदा तेस्रो सङ्ख्या हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ५ | ३ | २२ |
|---|---|---|
| ६ | ४ | ३२ |
| ७ | ५ | ? ||A:४९|B:४४|C:४५|D:५०'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| २ | ३ | ११ |
|---|---|---|
| ४ | ५ | २९ |
| ३ | ४ | ? ||A:१६|B:२०|C:१९|D:१८');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| २ | ३ | ११ |
|---|---|---|
| ४ | ५ | २९ |
| ३ | ४ | ? |', E'१६', E'२०', E'१९', E'१८', E'C', E'म्याट्रिक्सको प्रत्येक पङ्क्तिमा (Row), पहिलो सङ्ख्यामा दोस्रो सङ्ख्याको वर्ग जोड्दा तेस्रो सङ्ख्या हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| २ | ३ | ११ |
|---|---|---|
| ४ | ५ | २९ |
| ३ | ४ | ? ||A:१६|B:२०|C:१९|D:१८'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ३ | ४ | १५ |
|---|---|---|
| ५ | २ | १५ |
| ४ | ६ | ? ||A:२४|B:३०|C:२६|D:२८');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ३ | ४ | १५ |
|---|---|---|
| ५ | २ | १५ |
| ४ | ६ | ? |', E'२४', E'३०', E'२६', E'२८', E'D', E'म्याट्रिक्सको प्रत्येक पङ्क्तिमा (Row), पहिलो र दोस्रो सङ्ख्या गुणन गरी पहिलो जोड्दा तेस्रो सङ्ख्या हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ३ | ४ | १५ |
|---|---|---|
| ५ | २ | १५ |
| ४ | ६ | ? ||A:२४|B:३०|C:२६|D:२८'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ५ | ३ | १८ |
|---|---|---|
| ४ | ६ | ३० |
| ६ | २ | ? ||A:१४|B:१२|C:१६|D:१८');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ५ | ३ | १८ |
|---|---|---|
| ४ | ६ | ३० |
| ६ | २ | ? |', E'१४', E'१२', E'१६', E'१८', E'A', E'म्याट्रिक्सको प्रत्येक पङ्क्तिमा (Row), पहिलो र दोस्रो सङ्ख्या गुणन गरी दोस्रो जोड्दा तेस्रो सङ्ख्या हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ५ | ३ | १८ |
|---|---|---|
| ४ | ६ | ३० |
| ६ | २ | ? ||A:१४|B:१२|C:१६|D:१८'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ४ | ५ | १६ |
|---|---|---|
| ६ | ३ | १२ |
| ७ | ४ | ? ||A:२८|B:२१|C:२४|D:२६');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ४ | ५ | १६ |
|---|---|---|
| ६ | ३ | १२ |
| ७ | ४ | ? |', E'२८', E'२१', E'२४', E'२६', E'B', E'म्याट्रिक्सको प्रत्येक पङ्क्तिमा (Row), पहिलो र दोस्रो सङ्ख्या गुणन गरी पहिलो घटाउँदा तेस्रो सङ्ख्या हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ४ | ५ | १६ |
|---|---|---|
| ६ | ३ | १२ |
| ७ | ४ | ? ||A:२८|B:२१|C:२४|D:२६'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ५ | ४ | १६ |
|---|---|---|
| ६ | ५ | २५ |
| ७ | ३ | ? ||A:१९|B:२०|C:१८|D:२१');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ५ | ४ | १६ |
|---|---|---|
| ६ | ५ | २५ |
| ७ | ३ | ? |', E'१९', E'२०', E'१८', E'२१', E'C', E'म्याट्रिक्सको प्रत्येक पङ्क्तिमा (Row), पहिलो र दोस्रो सङ्ख्या गुणन गरी दोस्रो घटाउँदा तेस्रो सङ्ख्या हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ५ | ४ | १६ |
|---|---|---|
| ६ | ५ | २५ |
| ७ | ३ | ? ||A:१९|B:२०|C:१८|D:२१'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ३ | ४ | १४ |
|---|---|---|
| ५ | २ | १४ |
| ६ | ५ | ? ||A:२०|B:१८|C:२४|D:२२');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 19, E'तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ३ | ४ | १४ |
|---|---|---|
| ५ | २ | १४ |
| ६ | ५ | ? |', E'२०', E'१८', E'२४', E'२२', E'D', E'म्याट्रिक्सको प्रत्येक पङ्क्तिमा (Row), पहिलो र दोस्रो सङ्ख्या जोडेर २ ले गुणन गर्दा तेस्रो सङ्ख्या हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ३ | ४ | १४ |
|---|---|---|
| ५ | २ | १४ |
| ६ | ५ | ? ||A:२०|B:१८|C:२४|D:२२'), v_set_id, v_q_id, 19)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| १० | ४ | ७ |
|---|---|---|
| १२ | ८ | १० |
| १८ | ६ | ? ||A:१२|B:१०|C:१४|D:१६');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 20, E'तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| १० | ४ | ७ |
|---|---|---|
| १२ | ८ | १० |
| १८ | ६ | ? |', E'१२', E'१०', E'१४', E'१६', E'A', E'म्याट्रिक्सको प्रत्येक पङ्क्तिमा (Row), पहिलो र दोस्रो सङ्ख्या जोडेर २ ले भाग गर्दा तेस्रो सङ्ख्या हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| १० | ४ | ७ |
|---|---|---|
| १२ | ८ | १० |
| १८ | ६ | ? ||A:१२|B:१०|C:१४|D:१६'), v_set_id, v_q_id, 20)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ४ | ६ | १२ |
|---|---|---|
| ८ | ३ | १२ |
| ५ | ८ | ? ||A:१५|B:२०|C:१८|D:२२');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 21, E'तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ४ | ६ | १२ |
|---|---|---|
| ८ | ३ | १२ |
| ५ | ८ | ? |', E'१५', E'२०', E'१८', E'२२', E'B', E'म्याट्रिक्सको प्रत्येक पङ्क्तिमा (Row), पहिलो र दोस्रो सङ्ख्या गुणन गरी २ ले भाग गर्दा तेस्रो सङ्ख्या हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ४ | ६ | १२ |
|---|---|---|
| ८ | ३ | १२ |
| ५ | ८ | ? ||A:१५|B:२०|C:१८|D:२२'), v_set_id, v_q_id, 21)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ५ | ४ | १४ |
|---|---|---|
| ६ | ३ | १५ |
| ७ | ५ | ? ||A:१८|B:२०|C:१९|D:२१');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 22, E'तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ५ | ४ | १४ |
|---|---|---|
| ६ | ३ | १५ |
| ७ | ५ | ? |', E'१८', E'२०', E'१९', E'२१', E'C', E'म्याट्रिक्सको प्रत्येक पङ्क्तिमा (Row), पहिलोलाई २ ले गुणन गरी दोस्रो जोड्दा तेस्रो सङ्ख्या हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ५ | ४ | १४ |
|---|---|---|
| ६ | ३ | १५ |
| ७ | ५ | ? ||A:१८|B:२०|C:१९|D:२१'), v_set_id, v_q_id, 22)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ४ | ५ | १४ |
|---|---|---|
| ५ | ६ | १७ |
| ६ | ७ | ? ||A:१८|B:२२|C:२४|D:२०');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 23, E'तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ४ | ५ | १४ |
|---|---|---|
| ५ | ६ | १७ |
| ६ | ७ | ? |', E'१८', E'२२', E'२४', E'२०', E'D', E'म्याट्रिक्सको प्रत्येक पङ्क्तिमा (Row), पहिलोमा दोस्रोलाई २ ले गुणन गरी जोड्दा तेस्रो सङ्ख्या हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ४ | ५ | १४ |
|---|---|---|
| ५ | ६ | १७ |
| ६ | ७ | ? ||A:१८|B:२२|C:२४|D:२०'), v_set_id, v_q_id, 23)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ५ | ३ | १२ |
|---|---|---|
| ६ | ४ | १४ |
| ७ | ५ | ? ||A:१६|B:१५|C:१७|D:१८');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 24, E'तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ५ | ३ | १२ |
|---|---|---|
| ६ | ४ | १४ |
| ७ | ५ | ? |', E'१६', E'१५', E'१७', E'१८', E'A', E'म्याट्रिक्सको प्रत्येक पङ्क्तिमा (Row), पहिलोलाई ३ ले गुणन गरी दोस्रो घटाउँदा तेस्रो सङ्ख्या हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ५ | ३ | १२ |
|---|---|---|
| ६ | ४ | १४ |
| ७ | ५ | ? ||A:१६|B:१५|C:१७|D:१८'), v_set_id, v_q_id, 24)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| १० | ४ | १८ |
|---|---|---|
| १२ | ७ | १५ |
| १५ | ८ | ? ||A:२४|B:२१|C:२७|D:१८');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 25, E'तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| १० | ४ | १८ |
|---|---|---|
| १२ | ७ | १५ |
| १५ | ८ | ? |', E'२४', E'२१', E'२७', E'१८', E'B', E'म्याट्रिक्सको प्रत्येक पङ्क्तिमा (Row), पहिलो र दोस्रोको फरकलाई ३ ले गुणन गर्दा तेस्रो सङ्ख्या हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| १० | ४ | १८ |
|---|---|---|
| १२ | ७ | १५ |
| १५ | ८ | ? ||A:२४|B:२१|C:२७|D:१८'), v_set_id, v_q_id, 25)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ४ | ५ | १८ |
|---|---|---|
| ६ | ३ | १८ |
| ७ | ४ | ? ||A:२०|B:२४|C:२२|D:२६');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 26, E'तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ४ | ५ | १८ |
|---|---|---|
| ६ | ३ | १८ |
| ७ | ४ | ? |', E'२०', E'२४', E'२२', E'२६', E'C', E'म्याट्रिक्सको प्रत्येक पङ्क्तिमा (Row), पहिलो र दोस्रो दुवैलाई २ ले गुणन गरी जोड्दा तेस्रो सङ्ख्या हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ४ | ५ | १८ |
|---|---|---|
| ६ | ३ | १८ |
| ७ | ४ | ? ||A:२०|B:२४|C:२२|D:२६'), v_set_id, v_q_id, 26)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ५ | ४ | १४ |
|---|---|---|
| ६ | ३ | १४ |
| ७ | ८ | ? ||A:१५|B:१८|C:२२|D:२०');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 27, E'तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ५ | ४ | १४ |
|---|---|---|
| ६ | ३ | १४ |
| ७ | ८ | ? |', E'१५', E'१८', E'२२', E'२०', E'D', E'म्याट्रिक्सको प्रत्येक पङ्क्तिमा (Row), पहिलो र दोस्रो सङ्ख्या जोडेर ५ थप्दा तेस्रो सङ्ख्या हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ५ | ४ | १४ |
|---|---|---|
| ६ | ३ | १४ |
| ७ | ८ | ? ||A:१५|B:१८|C:२२|D:२०'), v_set_id, v_q_id, 27)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ५ | ४ | २५ |
|---|---|---|
| ६ | ३ | २३ |
| ७ | ४ | ? ||A:३३|B:२८|C:३५|D:३२');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 28, E'तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ५ | ४ | २५ |
|---|---|---|
| ६ | ३ | २३ |
| ७ | ४ | ? |', E'३३', E'२८', E'३५', E'३२', E'A', E'म्याट्रिक्सको प्रत्येक पङ्क्तिमा (Row), पहिलो र दोस्रो सङ्ख्या गुणन गरी ५ थप्दा तेस्रो सङ्ख्या हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ५ | ४ | २५ |
|---|---|---|
| ६ | ३ | २३ |
| ७ | ४ | ? ||A:३३|B:२८|C:३५|D:३२'), v_set_id, v_q_id, 28)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ३ | ४ | २५ |
|---|---|---|
| ५ | २ | २९ |
| ६ | ८ | ? ||A:६४|B:१००|C:३६|D:८०');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 29, E'तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ३ | ४ | २५ |
|---|---|---|
| ५ | २ | २९ |
| ६ | ८ | ? |', E'६४', E'१००', E'३६', E'८०', E'B', E'म्याट्रिक्सको प्रत्येक पङ्क्तिमा (Row), दुवै सङ्ख्याको वर्ग जोड्दा तेस्रो सङ्ख्या हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| ३ | ४ | २५ |
|---|---|---|
| ५ | २ | २९ |
| ६ | ८ | ? ||A:६४|B:१००|C:३६|D:८०'), v_set_id, v_q_id, 29)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| २ | ५ | १३ |
|---|---|---|
| ३ | ४ | ३१ |
| ४ | ५ | ? ||A:६४|B:७२|C:६९|D:६०');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 30, E'तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| २ | ५ | १३ |
|---|---|---|
| ३ | ४ | ३१ |
| ४ | ५ | ? |', E'६४', E'७२', E'६९', E'६०', E'C', E'म्याट्रिक्सको प्रत्येक पङ्क्तिमा (Row), पहिलोको घनमा दोस्रो जोड्दा तेस्रो सङ्ख्या हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिएको म्याट्रिक्समा ''?'' भएको ठाउँमा कुन सङ्ख्या हुन्छ?
| २ | ५ | १३ |
|---|---|---|
| ३ | ४ | ३१ |
| ४ | ५ | ? ||A:६४|B:७२|C:६९|D:६०'), v_set_id, v_q_id, 30)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  RAISE NOTICE 'round-2 top-up complete: 41 questions.';
END $$;
