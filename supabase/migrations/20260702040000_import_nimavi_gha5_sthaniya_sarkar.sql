-- Idempotent UPSERT import: निमावि प्रथम पत्र — unit घ-५ स्थानीय सरकार सञ्चालन ऐन, २०७४ (Level I topic-wise sets)
-- Override same-identity sets/questions; never deletes. Generated 2026-07-02T10:50:45.026Z.
DO $$
DECLARE
  v_module_id uuid := '6695669a-f40e-421a-a4ec-b09bbeaf56c4'::uuid;
  v_set_id uuid;
  v_q_id uuid;
BEGIN

  -- Set: स्थानीय सरकार सञ्चालन ऐन, २०७४: गाउँपालिका र नगरपालिकाको शिक्षा सम्बन्धी अधिकार (आधारभूत तह) (12 Q)
  v_set_id := extensions.uuid_generate_v5('d6729472-31f4-41a7-96da-1f99974d09ed'::uuid, E'स्थानीय सरकार सञ्चालन ऐन, २०७४: गाउँपालिका र नगरपालिकाको शिक्षा सम्बन्धी अधिकार (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '5990f855-fa68-49f4-8585-afe97511b950'::uuid, 'd6729472-31f4-41a7-96da-1f99974d09ed'::uuid, E'स्थानीय सरकार सञ्चालन ऐन, २०७४: गाउँपालिका र नगरपालिकाको शिक्षा सम्बन्धी अधिकार (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'd6729472-31f4-41a7-96da-1f99974d09ed'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'स्थानीय सरकार सञ्चालन ऐन, २०७४ ले अनौपचारिक शिक्षा कार्यक्रम सञ्चालन तथा व्यवस्थापन गर्ने अधिकार कसलाई दिएको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'स्थानीय सरकार सञ्चालन ऐन, २०७४ ले अनौपचारिक शिक्षा कार्यक्रम सञ्चालन तथा व्यवस्थापन गर्ने अधिकार कसलाई दिएको छ?', E'गाउँपालिका वा नगरपालिका', E'वडा समिति', E'वडा शिक्षा समिति', E'गाउँ वा नगर शिक्षा समिति', E'A', E'**अनौपचारिक शिक्षा कार्यक्रमको सञ्चालन तथा व्यवस्थापन गर्ने अधिकार गाउँपालिका वा नगरपालिकालाई दिइएको छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:स्थानीय सरकार सञ्चालन ऐन, २०७४ ले अनौपचारिक शिक्षा कार्यक्रम सञ्चालन तथा व्यवस्थापन गर्ने अधिकार कसलाई दिएको छ?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'स्थानीय सरकार सञ्चालन ऐन, २०७४ अनुसार सामुदायिक विद्यालयको शिक्षक तथा कर्मचारीको दरबन्दी मिलान कसको अधिकार क्षेत्रभित्र पर्दछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'स्थानीय सरकार सञ्चालन ऐन, २०७४ अनुसार सामुदायिक विद्यालयको शिक्षक तथा कर्मचारीको दरबन्दी मिलान कसको अधिकार क्षेत्रभित्र पर्दछ?', E'शिक्षा विकास तथा समन्वय इकाई', E'गाउँपालिका वा नगरपालिका', E'जिल्ला शिक्षा समिति', E'वडा समिति', E'B', E'**सामुदायिक विद्यालयको शिक्षक तथा कर्मचारीको दरबन्दी मिलान गाउँपालिका वा नगरपालिकाको अधिकार क्षेत्रभित्र पर्दछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:स्थानीय सरकार सञ्चालन ऐन, २०७४ अनुसार सामुदायिक विद्यालयको शिक्षक तथा कर्मचारीको दरबन्दी मिलान कसको अधिकार क्षेत्रभित्र पर्दछ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'गाउँ वा नगरपालिकाको शिक्षा सम्बन्धी कार्यमा तलकामध्ये कुन पर्दछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'गाउँ वा नगरपालिकाको शिक्षा सम्बन्धी कार्यमा तलकामध्ये कुन पर्दछ?', E'प्रधानाध्यापक नियुक्ति', E'विद्यार्थी मूल्याङ्कनको राष्ट्रिय ढाँचा तयार गर्ने', E'विद्यार्थी सिकाइ उपलब्धिको परीक्षण र व्यवस्थापन', E'शिक्षकउपर विभागीय कारबाही चलाउने', E'C', E'**विद्यार्थी सिकाइ उपलब्धिको परीक्षण र व्यवस्थापन गाउँ वा नगरपालिकाको शिक्षा सम्बन्धी कार्य हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:गाउँ वा नगरपालिकाको शिक्षा सम्बन्धी कार्यमा तलकामध्ये कुन पर्दछ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'बाल क्लब तथा बाल सञ्जालको निर्माण, सञ्चालन तथा व्यवस्थापन गर्ने कार्य स्थानीय सरकार सञ्चालन ऐन अनुसार कसको हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'बाल क्लब तथा बाल सञ्जालको निर्माण, सञ्चालन तथा व्यवस्थापन गर्ने कार्य स्थानीय सरकार सञ्चालन ऐन अनुसार कसको हो?', E'वडा समिति', E'नगर बालबालिका शाखा', E'गाउँ वा नगर शिक्षा समिति', E'गाउँपालिका वा नगरपालिका', E'D', E'**बाल क्लब तथा बाल सञ्जालको निर्माण, सञ्चालन तथा व्यवस्थापन गाउँपालिका वा नगरपालिकाको कार्य हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:बाल क्लब तथा बाल सञ्जालको निर्माण, सञ्चालन तथा व्यवस्थापन गर्ने कार्य स्थानीय सरकार सञ्चालन ऐन अनुसार कसको हो?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'स्थानीय सरकार सञ्चालन ऐन, २०७४ अनुसार गाउँ वा नगरपालिकाको काममा तलकामध्ये कुन पर्दछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'स्थानीय सरकार सञ्चालन ऐन, २०७४ अनुसार गाउँ वा नगरपालिकाको काममा तलकामध्ये कुन पर्दछ?', E'निःशुल्क शिक्षा, विद्यार्थी प्रोत्साहन तथा छात्रवृत्तिको व्यवस्थापन', E'नमुना विद्यालयसम्बन्धी राष्ट्रिय नीति, कानुन तथा मापदण्ड विकास', E'पाठ्यक्रम तथा पाठ्यसामग्रीको राष्ट्रिय विकास, कार्यान्वयन र परिमार्जन', E'आवासीय विद्यालय सञ्चालन तथा व्यवस्थापनसम्बन्धी राष्ट्रिय मापदण्ड निर्माण', E'A', E'**निःशुल्क शिक्षा, विद्यार्थी प्रोत्साहन तथा छात्रवृत्तिको व्यवस्थापन गाउँ वा नगरपालिकाको शिक्षा सम्बन्धी काम हो।**\\nनोट: पाठ्यक्रम विकास र नमुना विद्यालय मापदण्ड जस्ता राष्ट्रिय-स्तरीय काम केन्द्रीय निकायको जिम्मेवारी हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:स्थानीय सरकार सञ्चालन ऐन, २०७४ अनुसार गाउँ वा नगरपालिकाको काममा तलकामध्ये कुन पर्दछ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'स्थानीय सरकार सञ्चालन ऐन, २०७४ अनुसार गाउँ वा नगरपालिकाको शिक्षा सम्बन्धी कार्यक्रममा तलकामध्ये कुन पर्दैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'स्थानीय सरकार सञ्चालन ऐन, २०७४ अनुसार गाउँ वा नगरपालिकाको शिक्षा सम्बन्धी कार्यक्रममा तलकामध्ये कुन पर्दैन?', E'आधारभूत शिक्षाको सक्षमता निर्माण', E'स्थानीय पुस्तकालय र वाचनालयको सञ्चालन', E'शिक्षक र कर्मचारीको तालिम तथा क्षमता विकास', E'माध्यमिक तहसम्मको शैक्षिक कार्यक्रमको समन्वय र नियमन', E'B', E'**स्थानीय पुस्तकालय र वाचनालयको सञ्चालन गाउँ वा नगरपालिकाको शिक्षा सम्बन्धी कार्यक्रममा पर्दैन — यो वडा समितिको कार्य हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:स्थानीय सरकार सञ्चालन ऐन, २०७४ अनुसार गाउँ वा नगरपालिकाको शिक्षा सम्बन्धी कार्यक्रममा तलकामध्ये कुन पर्दैन?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'स्थानीय सरकार सञ्चालन ऐन, २०७४ अनुसार गाउँपालिका वा नगरपालिकाले अन्तरपालिका स्तरको आधारभूत तथा माध्यमिक तहको कस्तो शिक्षाको सञ्चालन, प्रवर्द्धन र विकास गर्न सक्नेछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'स्थानीय सरकार सञ्चालन ऐन, २०७४ अनुसार गाउँपालिका वा नगरपालिकाले अन्तरपालिका स्तरको आधारभूत तथा माध्यमिक तहको कस्तो शिक्षाको सञ्चालन, प्रवर्द्धन र विकास गर्न सक्नेछ?', E'अनौपचारिक शिक्षा', E'खुला तथा दूर शिक्षा', E'प्राविधिक शिक्षा', E'अभिभावक शिक्षा', E'C', E'**गाउँपालिका वा नगरपालिकाले अन्तरपालिका स्तरमा आधारभूत तथा माध्यमिक तहको प्राविधिक शिक्षाको सञ्चालन, प्रवर्द्धन र विकास गर्न सक्नेछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:स्थानीय सरकार सञ्चालन ऐन, २०७४ अनुसार गाउँपालिका वा नगरपालिकाले अन्तरपालिका स्तरको आधारभूत तथा माध्यमिक तहको कस्तो शिक्षाको सञ्चालन, प्रवर्द्धन र विकास गर्न सक्नेछ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'स्थानीय सरकार सञ्चालन ऐन, २०७४ अनुसार गाउँ वा नगरपालिकाले अन्य गाउँपालिका वा नगरपालिकासँग साझेदारी सम्झौता वा संयुक्त व्यवस्थापन गरी गर्न सक्ने कार्य कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'स्थानीय सरकार सञ्चालन ऐन, २०७४ अनुसार गाउँ वा नगरपालिकाले अन्य गाउँपालिका वा नगरपालिकासँग साझेदारी सम्झौता वा संयुक्त व्यवस्थापन गरी गर्न सक्ने कार्य कुन हो?', E'गाभिएका वा बन्द गरिएका विद्यालयहरूको सम्पत्ति व्यवस्थापन', E'शिक्षण सिकाइ, शिक्षक र कर्मचारीको सञ्चालन सम्बन्धी व्यवस्था', E'आधारभूत तथा माध्यमिक तहको प्राविधिक शिक्षाको सञ्चालन, प्रवर्द्धन र विकास', E'ट्युसन, कोचिङ जस्ता विद्यालय बाहिर हुने अध्ययन सेवाको नियमन र अनुमति', E'D', E'**ट्युसन, कोचिङ जस्ता विद्यालय बाहिर हुने अध्ययन सेवाको नियमन र अनुमति गाउँ वा नगरपालिकाले अन्य गाउँपालिका वा नगरपालिकासँग साझेदारी सम्झौता वा संयुक्त व्यवस्थापन गरी गर्न सक्ने कार्य हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:स्थानीय सरकार सञ्चालन ऐन, २०७४ अनुसार गाउँ वा नगरपालिकाले अन्य गाउँपालिका वा नगरपालिकासँग साझेदारी सम्झौता वा संयुक्त व्यवस्थापन गरी गर्न सक्ने कार्य कुन हो?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'स्थानीय सरकार सञ्चालन ऐन, २०७४ अनुसार गाउँ/नगरपालिकामा कस्ता प्रकृतिका विद्यालयहरूलाई अनुदान दिन सक्ने अधिकार रहेको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'स्थानीय सरकार सञ्चालन ऐन, २०७४ अनुसार गाउँ/नगरपालिकामा कस्ता प्रकृतिका विद्यालयहरूलाई अनुदान दिन सक्ने अधिकार रहेको छ?', E'सामुदायिक विद्यालय', E'संस्थागत विद्यालय', E'गुठी विद्यालय', E'माथिका सबै', E'A', E'**गाउँ वा नगरपालिकामा सामुदायिक विद्यालयलाई मात्र अनुदान दिन सक्ने अधिकार रहेको छ।**\\nनोट: संस्थागत र गुठी विद्यालय आफ्नै स्रोतबाट सञ्चालित हुन्छन्, तिनलाई सरकारी अनुदान दिइँदैन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:स्थानीय सरकार सञ्चालन ऐन, २०७४ अनुसार गाउँ/नगरपालिकामा कस्ता प्रकृतिका विद्यालयहरूलाई अनुदान दिन सक्ने अधिकार रहेको छ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'स्थानीय सरकार सञ्चालन ऐन, २०७४ अनुसार गाँउ/नगरपालिकाको शिक्षा सम्बन्धी अधिकारमा तलकामध्ये कुन पर्दछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'स्थानीय सरकार सञ्चालन ऐन, २०७४ अनुसार गाँउ/नगरपालिकाको शिक्षा सम्बन्धी अधिकारमा तलकामध्ये कुन पर्दछ?', E'बाल क्लब तथा बाल सञ्जालको खेलकुद प्रतियोगिता आयोजना', E'गाँउ/नगर शिक्षा समिति गठन तथा व्यवस्थापन', E'सामुदायिक सिकाइ केन्द्रको राष्ट्रिय पाठ्यक्रम निर्धारण', E'जिल्ला शिक्षा समितिको गठन', E'B', E'**गाँउ/नगर शिक्षा समिति गठन तथा व्यवस्थापन गाउँपालिका वा नगरपालिकाको शिक्षा सम्बन्धी अधिकारमा पर्दछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:स्थानीय सरकार सञ्चालन ऐन, २०७४ अनुसार गाँउ/नगरपालिकाको शिक्षा सम्बन्धी अधिकारमा तलकामध्ये कुन पर्दछ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'स्थानीय शिक्षा सञ्चालन ऐन, २०७४ अनुसार गाउँपालिका वा नगरपालिकामा कस्ता प्रकृतिको शिक्षाको अधिकार रहन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'स्थानीय शिक्षा सञ्चालन ऐन, २०७४ अनुसार गाउँपालिका वा नगरपालिकामा कस्ता प्रकृतिको शिक्षाको अधिकार रहन्छ?', E'अभिभावक शिक्षा', E'खुला तथा दूर शिक्षा', E'आधारभूत शिक्षा', E'प्रारम्भिक बाल विकास तथा शिक्षा', E'C', E'**गाउँपालिका वा नगरपालिकामा आधारभूत शिक्षाको अधिकार रहन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:स्थानीय शिक्षा सञ्चालन ऐन, २०७४ अनुसार गाउँपालिका वा नगरपालिकामा कस्ता प्रकृतिको शिक्षाको अधिकार रहन्छ?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'स्थानीय सरकार सञ्चालन ऐन, २०७४ बमोजिम गाँभिएका वा बन्द गरिएका विद्यालयहरूको सम्पत्ति व्यवस्थापन गर्ने जिम्मेवारी कसलाई तोकिएको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'स्थानीय सरकार सञ्चालन ऐन, २०७४ बमोजिम गाँभिएका वा बन्द गरिएका विद्यालयहरूको सम्पत्ति व्यवस्थापन गर्ने जिम्मेवारी कसलाई तोकिएको छ?', E'विद्यालय व्यवस्थापन समिति', E'शिक्षा विकास तथा समन्वय इकाई', E'प्रदेश शिक्षा विकास निर्देशनालय', E'स्थानीय तह (गाउँपालिका वा नगरपालिका)', E'D', E'**गाँभिएका वा बन्द गरिएका विद्यालयहरूको सम्पत्ति व्यवस्थापनको जिम्मेवारी स्थानीय तह (गाउँपालिका वा नगरपालिका) लाई तोकिएको छ, वडा समितिलाई होइन।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:स्थानीय सरकार सञ्चालन ऐन, २०७४ बमोजिम गाँभिएका वा बन्द गरिएका विद्यालयहरूको सम्पत्ति व्यवस्थापन गर्ने जिम्मेवारी कसलाई तोकिएको छ?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: स्थानीय सरकार सञ्चालन ऐन, २०७४: वडा समितिको शिक्षा सम्बन्धी कार्य र ऐनको सामान्य परिचय (आधारभूत तह) (11 Q)
  v_set_id := extensions.uuid_generate_v5('0ec9032f-9d6f-48cd-a21d-38dabae32f70'::uuid, E'स्थानीय सरकार सञ्चालन ऐन, २०७४: वडा समितिको शिक्षा सम्बन्धी कार्य र ऐनको सामान्य परिचय (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '5990f855-fa68-49f4-8585-afe97511b950'::uuid, '0ec9032f-9d6f-48cd-a21d-38dabae32f70'::uuid, E'स्थानीय सरकार सञ्चालन ऐन, २०७४: वडा समितिको शिक्षा सम्बन्धी कार्य र ऐनको सामान्य परिचय (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '0ec9032f-9d6f-48cd-a21d-38dabae32f70'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'स्थानीय सरकार सञ्चालन ऐन, २०७४ अनुसार वडा समितिको सिफारिस कार्यमा तलकामध्ये कुन पर्दछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'स्थानीय सरकार सञ्चालन ऐन, २०७४ अनुसार वडा समितिको सिफारिस कार्यमा तलकामध्ये कुन पर्दछ?', E'प्राथमिक बाल विकास केन्द्र सञ्चालनको सिफारिस', E'विद्यालय समायोजन गर्ने सिफारिस', E'अनौपचारिक शिक्षा कार्यक्रम सञ्चालनको सिफारिस', E'आधारभूत विद्यालय खोल्ने राष्ट्रिय सिफारिस', E'A', E'**प्राथमिक बाल विकास केन्द्र सञ्चालनको सिफारिस गर्ने कार्य वडा समितिको सिफारिस कार्यमा पर्दछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:स्थानीय सरकार सञ्चालन ऐन, २०७४ अनुसार वडा समितिको सिफारिस कार्यमा तलकामध्ये कुन पर्दछ?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यालयमा विद्यार्थी भर्ना र बालमैत्री शासन जस्ता कार्यहरूको प्रबर्द्धन गर्ने कार्य स्थानीय सरकार सञ्चालन ऐनले कसको कार्यक्षेत्रभित्र राखेको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'विद्यालयमा विद्यार्थी भर्ना र बालमैत्री शासन जस्ता कार्यहरूको प्रबर्द्धन गर्ने कार्य स्थानीय सरकार सञ्चालन ऐनले कसको कार्यक्षेत्रभित्र राखेको छ?', E'गाउँ वा नगरपालिका', E'वडा समिति', E'वडा शिक्षा समिति', E'नगर शिक्षा समिति', E'B', E'**विद्यार्थी भर्ना र बालमैत्री शासन प्रबर्द्धन गर्ने कार्य वडा समितिको कार्यक्षेत्रभित्र पर्दछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यालयमा विद्यार्थी भर्ना र बालमैत्री शासन जस्ता कार्यहरूको प्रबर्द्धन गर्ने कार्य स्थानीय सरकार सञ्चालन ऐनले कसको कार्यक्षेत्रभित्र राखेको छ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'गाउँ वा नगरपालिकाभित्रको वडालाई बालमैत्री बनाउने कार्य स्थानीय सरकार सञ्चालन ऐन, २०७४ अनुसार कसको हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'गाउँ वा नगरपालिकाभित्रको वडालाई बालमैत्री बनाउने कार्य स्थानीय सरकार सञ्चालन ऐन, २०७४ अनुसार कसको हो?', E'वडा शिक्षा समिति', E'गाउँपालिका वा नगरपालिका', E'वडा समिति', E'गाउँ वा नगर शिक्षा समिति', E'C', E'**वडालाई बालमैत्री बनाउने कार्य वडा समितिको जिम्मेवारी हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:गाउँ वा नगरपालिकाभित्रको वडालाई बालमैत्री बनाउने कार्य स्थानीय सरकार सञ्चालन ऐन, २०७४ अनुसार कसको हो?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'गाउँ वा नगरपालिकाको वडाभित्र खेलकुद पूर्वाधारको विकास गर्ने कार्य स्थानीय सरकार सञ्चालन ऐनले कसको अधिकार क्षेत्रभित्र राखेको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'गाउँ वा नगरपालिकाको वडाभित्र खेलकुद पूर्वाधारको विकास गर्ने कार्य स्थानीय सरकार सञ्चालन ऐनले कसको अधिकार क्षेत्रभित्र राखेको छ?', E'गाउँ वा नगरपालिका', E'जिल्ला खेलकुद परिषद्', E'माथिका सबै', E'सम्बन्धित वडा समिति', E'D', E'**वडाभित्रको खेलकुद पूर्वाधार विकास सम्बन्धित वडा समितिको अधिकार क्षेत्रभित्र पर्दछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:गाउँ वा नगरपालिकाको वडाभित्र खेलकुद पूर्वाधारको विकास गर्ने कार्य स्थानीय सरकार सञ्चालन ऐनले कसको अधिकार क्षेत्रभित्र राखेको छ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'स्थानीय मौलिकता झल्काउने सांस्कृतिक रीतिरिवाजको संरक्षण तथा प्रवर्द्धन गर्ने कार्य स्थानीय सरकार सञ्चालन ऐन, २०७४ अनुसार कसको हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'स्थानीय मौलिकता झल्काउने सांस्कृतिक रीतिरिवाजको संरक्षण तथा प्रवर्द्धन गर्ने कार्य स्थानीय सरकार सञ्चालन ऐन, २०७४ अनुसार कसको हो?', E'वडा समिति', E'गाउँ वा नगरपालिका', E'गाउँ वा नगर शिक्षा समिति', E'विद्यालयहरू', E'A', E'**स्थानीय मौलिकता झल्काउने सांस्कृतिक रीतिरिवाजको संरक्षण तथा प्रवर्द्धन वडा समितिको कार्य हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:स्थानीय मौलिकता झल्काउने सांस्कृतिक रीतिरिवाजको संरक्षण तथा प्रवर्द्धन गर्ने कार्य स्थानीय सरकार सञ्चालन ऐन, २०७४ अनुसार कसको हो?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'स्थानीय सरकार सञ्चालन ऐन, २०७४ अनुसार वडा समितिको शिक्षासम्बन्धी कार्यमा तलकामध्ये कुन पर्दछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'स्थानीय सरकार सञ्चालन ऐन, २०७४ अनुसार वडा समितिको शिक्षासम्बन्धी कार्यमा तलकामध्ये कुन पर्दछ?', E'विद्यालय समायोजन गर्ने', E'स्थानीय पुस्तकालय र वाचनालयको सञ्चालन र व्यवस्थापन', E'विद्यालय खोल्ने राष्ट्रिय मापदण्ड बनाउने', E'विद्यालय बन्द गर्ने अन्तिम निर्देशन दिने', E'B', E'**स्थानीय पुस्तकालय र वाचनालयको सञ्चालन र व्यवस्थापन वडा समितिको शिक्षासम्बन्धी कार्य हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:स्थानीय सरकार सञ्चालन ऐन, २०७४ अनुसार वडा समितिको शिक्षासम्बन्धी कार्यमा तलकामध्ये कुन पर्दछ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'तल दिएका विद्यालय-सम्बन्धी सिफारिस कार्यमध्ये वडा समितिले सिफारिस प्रदान गर्न नसक्ने कार्य कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'तल दिएका विद्यालय-सम्बन्धी सिफारिस कार्यमध्ये वडा समितिले सिफारिस प्रदान गर्न नसक्ने कार्य कुन हो?', E'विद्यालयको कक्षा थप गर्न', E'आधारभूत विद्यालय खोल्न', E'प्राविधिक शिक्षा तथा व्यावसायिक तालिम केन्द्र खोल्न', E'विद्यालय ठाउँसारी गर्न', E'C', E'**वडा समितिले प्राविधिक शिक्षा तथा व्यावसायिक तालिम केन्द्र खोल्नका लागि सिफारिस दिन सक्दैन — यो गाउँपालिका/नगरपालिका तहको अधिकार हो।**\\nनोट: कक्षा थप, आधारभूत विद्यालय खोल्ने र विद्यालय ठाउँसारी गर्ने सिफारिस वडा समितिले नै दिन सक्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:तल दिएका विद्यालय-सम्बन्धी सिफारिस कार्यमध्ये वडा समितिले सिफारिस प्रदान गर्न नसक्ने कार्य कुन हो?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'स्थानीय सरकार सञ्चालन ऐन, २०७४ अनुसार वडा समितिको शिक्षासम्बन्धी कार्यमा तलकामध्ये कुन पर्दैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'स्थानीय सरकार सञ्चालन ऐन, २०७४ अनुसार वडा समितिको शिक्षासम्बन्धी कार्यमा तलकामध्ये कुन पर्दैन?', E'आधारभूत विद्यालय खोल्न सिफारिस गर्ने', E'वडास्तरीय बालमेला आयोजना गर्ने', E'आधारभूत ठाउँसारी विद्यालयहरूको सम्पत्ति व्यवस्थापन गर्ने', E'गाभिएका वा बन्द गरिएका विद्यालयहरूको सम्पत्ति व्यवस्थापन गर्ने', E'D', E'**गाभिएका वा बन्द गरिएका विद्यालयहरूको सम्पत्ति व्यवस्थापन वडा समितिको कार्यमा पर्दैन — यो जिम्मेवारी स्थानीय तह (गाउँपालिका/नगरपालिका) को हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:स्थानीय सरकार सञ्चालन ऐन, २०७४ अनुसार वडा समितिको शिक्षासम्बन्धी कार्यमा तलकामध्ये कुन पर्दैन?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'स्थानीय सरकार सञ्चालन ऐन, २०७४ कहिले जारी भएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'स्थानीय सरकार सञ्चालन ऐन, २०७४ कहिले जारी भएको थियो?', E'२०७४/६/२९', E'२०७४/५/२९', E'२०७४/६/२८', E'२०७४/७/२९', E'A', E'**स्थानीय सरकार सञ्चालन ऐन, २०७४ मिति २०७४/६/२९ मा जारी भएको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:स्थानीय सरकार सञ्चालन ऐन, २०७४ कहिले जारी भएको थियो?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'स्थानीय सरकार सञ्चालन ऐनको कुन दफामा गाउँ/नगरपालिकाको शिक्षासम्बन्धी अधिकारको उल्लेख गरिएको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'स्थानीय सरकार सञ्चालन ऐनको कुन दफामा गाउँ/नगरपालिकाको शिक्षासम्बन्धी अधिकारको उल्लेख गरिएको छ?', E'दफा १०(२) ज', E'दफा ११(२) ज', E'दफा ११(२) त', E'दफा ११(२) झ', E'B', E'**गाउँ/नगरपालिकाको शिक्षासम्बन्धी अधिकार दफा ११(२)(ज) मा उल्लेख गरिएको छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:स्थानीय सरकार सञ्चालन ऐनको कुन दफामा गाउँ/नगरपालिकाको शिक्षासम्बन्धी अधिकारको उल्लेख गरिएको छ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालको संविधानको कुन धाराले दिएको अधिकार प्रयोग गरी स्थानीय सरकार सञ्चालन ऐन, २०७४ बनाइएको हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'नेपालको संविधानको कुन धाराले दिएको अधिकार प्रयोग गरी स्थानीय सरकार सञ्चालन ऐन, २०७४ बनाइएको हो?', E'धारा २८६', E'धारा २९६', E'धारा २६८', E'धारा २६९', E'C', E'**नेपालको संविधानको धारा २६८ ले दिएको अधिकार प्रयोग गरी स्थानीय सरकार सञ्चालन ऐन, २०७४ निर्माण गरिएको हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालको संविधानको कुन धाराले दिएको अधिकार प्रयोग गरी स्थानीय सरकार सञ्चालन ऐन, २०७४ बनाइएको हो?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  RAISE NOTICE 'Unit घ-५ upsert complete: 2 sets, 23 questions.';
END $$;
