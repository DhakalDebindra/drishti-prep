-- Idempotent UPSERT import: निमावि प्रथम पत्र — unit ख-८ शैक्षिक व्यवस्थापन र शैक्षणिक संगठन
-- Adds Level I sets alongside preserved model sets. Override same-identity; never deletes. Generated 2026-07-02T01:32:40.245Z.
DO $$
DECLARE
  v_module_id uuid := '6695669a-f40e-421a-a4ec-b09bbeaf56c4'::uuid;
  v_set_id uuid;
  v_q_id uuid;
BEGIN

  -- Set: कक्षाकोठा व्यवस्थापनको अवधारणा र विशेषताहरू (आधारभूत तह) (12 Q)
  v_set_id := extensions.uuid_generate_v5('78cc19b3-711d-41e8-ad52-82ce09d996c2'::uuid, E'कक्षाकोठा व्यवस्थापनको अवधारणा र विशेषताहरू (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '060fd749-1aa6-4771-b4b3-db5eafd0ef97'::uuid, '78cc19b3-711d-41e8-ad52-82ce09d996c2'::uuid, E'कक्षाकोठा व्यवस्थापनको अवधारणा र विशेषताहरू (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '78cc19b3-711d-41e8-ad52-82ce09d996c2'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कक्षाकोठा व्यवस्थापन भनेको के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'कक्षाकोठा व्यवस्थापन भनेको के हो?', E'पाठ्यक्रमले राखेका निर्धारित उद्देश्य प्राप्तिका लागि शिक्षणलाई व्यवस्थित र प्रभावकारी बनाउनका लागि गरिने व्यवस्थापन', E'शिक्षकको तलब वृद्धि गर्ने प्रक्रिया', E'विद्यालयको वार्षिक बजेट स्वीकृत गर्ने प्रक्रिया', E'विद्यार्थीको परीक्षा नतिजाको अभिलेख राख्ने कार्य', E'A', E'**कक्षाकोठा व्यवस्थापन भनेको पाठ्यक्रमले राखेका निर्धारित उद्देश्य प्राप्तिका लागि शिक्षणलाई व्यवस्थित र प्रभावकारी बनाउनका लागि गरिने व्यवस्थापन हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कक्षाकोठा व्यवस्थापन भनेको के हो?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'जोन्सन र बानीका अनुसार कक्षाकोठा व्यवस्थापन भनेको के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'जोन्सन र बानीका अनुसार कक्षाकोठा व्यवस्थापन भनेको के हो?', E'विद्यालयको भवन निर्माणको प्राविधिक प्रक्रिया', E'शैक्षिक उद्देश्यहरूको प्राप्तिका लागि समूह र कक्षाकोठाको आन्तरिक अवस्था विकसित गर्ने र बनाउने तरिका', E'परीक्षाको प्रश्नपत्र निर्माणको तरिका', E'शिक्षकको वृत्ति विकासको योजना', E'B', E'**जोन्सन र बानीका अनुसार कक्षाकोठा व्यवस्थापन भनेको शैक्षिक उद्देश्यहरूको प्राप्तिका लागि समूह र कक्षाकोठाको आन्तरिक अवस्था विकसित गर्ने र बनाउने तरिका हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:जोन्सन र बानीका अनुसार कक्षाकोठा व्यवस्थापन भनेको के हो?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कक्षाकोठा व्यवस्थापन उत्तम सिकाइका लागि के मानिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'कक्षाकोठा व्यवस्थापन उत्तम सिकाइका लागि के मानिन्छ?', E'अनावश्यक झन्झट', E'एउटा वैकल्पिक विकल्प मात्र', E'पूर्वसर्त', E'अन्तिम चरणको औपचारिकता', E'C', E'**कक्षाकोठा व्यवस्थापन उत्तम सिकाइका लागि पूर्वसर्त मानिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कक्षाकोठा व्यवस्थापन उत्तम सिकाइका लागि के मानिन्छ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कक्षाकोठा व्यवस्थापनका उद्देश्यहरूमध्ये निम्नमध्ये कुन पर्दैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'कक्षाकोठा व्यवस्थापनका उद्देश्यहरूमध्ये निम्नमध्ये कुन पर्दैन?', E'शिक्षक विद्यार्थीबिच असल शैक्षिक सम्बन्ध विकास गर्नु', E'स्वतन्त्र, सहज र सिर्जनामुखी सिकाइ वातावरण निर्माण गर्नु', E'सकारात्मक सिकाइ वातावरण सिर्जना गर्नु', E'शिक्षकको तलब वृद्धिको माग गर्नु', E'D', E'**"शिक्षकको तलब वृद्धिको माग गर्नु" कक्षाकोठा व्यवस्थापनका उद्देश्यमा पर्दैन।**\\n- सकारात्मक सिकाइ वातावरण सिर्जना, असल शैक्षिक सम्बन्ध विकास र स्वतन्त्र-सिर्जनामुखी सिकाइ वातावरण तीनवटै कक्षाकोठा व्यवस्थापनका वास्तविक उद्देश्य हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कक्षाकोठा व्यवस्थापनका उद्देश्यहरूमध्ये निम्नमध्ये कुन पर्दैन?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कक्षाकोठा व्यवस्थापनका विशेषताहरूमध्ये विद्यार्थीको समूह निर्माण गर्दा आवश्यकताअनुसार कस्ता समूह बनाइन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'कक्षाकोठा व्यवस्थापनका विशेषताहरूमध्ये विद्यार्थीको समूह निर्माण गर्दा आवश्यकताअनुसार कस्ता समूह बनाइन्छ?', E'मिश्रित समूह, रुचि समूह, लैङ्गिक समूह', E'केवल परीक्षा-आधारित समूह', E'केवल छात्र समूह मात्र', E'केवल उमेर-आधारित समूह', E'A', E'**कक्षाकोठा व्यवस्थापनमा आवश्यकताअनुसार मिश्रित समूह, रुचि समूह, छात्रा समूह, छात्र समूह र लैङ्गिक समूह बनाई सहयोगात्मक सिकाइमा जोड दिइन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कक्षाकोठा व्यवस्थापनका विशेषताहरूमध्ये विद्यार्थीको समूह निर्माण गर्दा आवश्यकताअनुसार कस्ता समूह बनाइन्छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कक्षाकोठाको भौतिक पूर्वाधार व्यवस्थापनअन्तर्गत निम्नमध्ये कुन पर्दैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'कक्षाकोठाको भौतिक पूर्वाधार व्यवस्थापनअन्तर्गत निम्नमध्ये कुन पर्दैन?', E'उपयुक्त ताफक्रम र प्रकाशको प्रबन्ध', E'विद्यार्थीको वार्षिक परीक्षा तालिका', E'हावाको आवतजावत गर्न सक्ने भेन्टिलेसनको व्यवस्था', E'अपाङ्गमैत्री बसाइको ध्यान', E'B', E'**"विद्यार्थीको वार्षिक परीक्षा तालिका" भौतिक पूर्वाधार व्यवस्थापनअन्तर्गत पर्दैन।**\\n- भेन्टिलेसन, ताफक्रम-प्रकाश र अपाङ्गमैत्री बसाइ तीनवटै भौतिक पूर्वाधार व्यवस्थापनका वास्तविक अङ्ग हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कक्षाकोठाको भौतिक पूर्वाधार व्यवस्थापनअन्तर्गत निम्नमध्ये कुन पर्दैन?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षण सिकाइका क्रममा गरिने लेखाइ, बोलाइ, छलफल, प्रश्नोत्तर, प्रदर्शन आदिको व्यवस्थापनलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'शिक्षण सिकाइका क्रममा गरिने लेखाइ, बोलाइ, छलफल, प्रश्नोत्तर, प्रदर्शन आदिको व्यवस्थापनलाई के भनिन्छ?', E'शैक्षणिक योजनाको व्यवस्थापन', E'अभिलेखन व्यवस्थापन', E'विद्यार्थी क्रियाकलापको व्यवस्थापन', E'प्रविधि व्यवस्थापन', E'C', E'**शिक्षण सिकाइका क्रममा गरिने लेखाइ, बोलाइ, छलफल, प्रश्नोत्तर, प्रदर्शन आदिको व्यवस्थापनलाई विद्यार्थी क्रियाकलापको व्यवस्थापन भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षण सिकाइका क्रममा गरिने लेखाइ, बोलाइ, छलफल, प्रश्नोत्तर, प्रदर्शन आदिको व्यवस्थापनलाई के भनिन्छ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यार्थीहरूले गरेका कार्यको अभिलेख (पोर्टफोलियो) राख्ने व्यवस्थालाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'विद्यार्थीहरूले गरेका कार्यको अभिलेख (पोर्टफोलियो) राख्ने व्यवस्थालाई के भनिन्छ?', E'बसाइ व्यवस्थापन', E'विविधता व्यवस्थापन', E'प्रविधि व्यवस्थापन', E'अभिलेखन व्यवस्थापन', E'D', E'**विद्यार्थीहरूले गरेका कार्यको अभिलेख (पोर्टफोलियो) राख्ने व्यवस्थालाई अभिलेखन व्यवस्थापन भनिन्छ, जसअन्तर्गत परियोजना कार्य, प्रयोगात्मक क्रियाकलाप र क्षेत्रभ्रमणका अभिलेख पनि समेटिन्छन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यार्थीहरूले गरेका कार्यको अभिलेख (पोर्टफोलियो) राख्ने व्यवस्थालाई के भनिन्छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कक्षाकोठाका मुख्य पक्षहरूमध्ये विद्यार्थी-शिक्षक सम्बन्ध, विद्यार्थी-विद्यार्थी सम्बन्ध र अनुशासन व्यवस्थापन कुन पक्षअन्तर्गत पर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'कक्षाकोठाका मुख्य पक्षहरूमध्ये विद्यार्थी-शिक्षक सम्बन्ध, विद्यार्थी-विद्यार्थी सम्बन्ध र अनुशासन व्यवस्थापन कुन पक्षअन्तर्गत पर्छ?', E'मानवीय व्यवस्थापन', E'भौतिक व्यवस्थापन', E'शैक्षिक व्यवस्थापन', E'प्रविधि व्यवस्थापन', E'A', E'**विद्यार्थी-शिक्षक सम्बन्ध, विद्यार्थी-विद्यार्थी सम्बन्ध र अनुशासन व्यवस्थापन मानवीय व्यवस्थापनअन्तर्गत पर्छन्।**\\nनोट: शैक्षिक व्यवस्थापनमा पाठ्यक्रम योजना, शिक्षण विधि, मूल्याङ्कन र सिकाइ सामग्री पर्छन् भने भौतिक व्यवस्थापनमा फर्निचर, प्रकाश, हावा र तापक्रम पर्छन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कक्षाकोठाका मुख्य पक्षहरूमध्ये विद्यार्थी-शिक्षक सम्बन्ध, विद्यार्थी-विद्यार्थी सम्बन्ध र अनुशासन व्यवस्थापन कुन पक्षअन्तर्गत पर्छ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कक्षाकोठा व्यवस्थापनमा शिक्षकको भूमिका मुख्यतः केका रूपमा हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'कक्षाकोठा व्यवस्थापनमा शिक्षकको भूमिका मुख्यतः केका रूपमा हुन्छ?', E'केवल लेखापाल', E'सहजकर्ता, निर्देशक र परामर्शदाता', E'केवल निरीक्षक', E'केवल परीक्षक', E'B', E'**कक्षाकोठा व्यवस्थापनमा शिक्षकको भूमिका सहजकर्ता (Facilitator), निर्देशक (Director) र परामर्शदाता (Counselor) का रूपमा हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कक्षाकोठा व्यवस्थापनमा शिक्षकको भूमिका मुख्यतः केका रूपमा हुन्छ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'प्रभावकारी कक्षाकोठा व्यवस्थापनको एउटा प्रमुख सिद्धान्त निम्नमध्ये कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'प्रभावकारी कक्षाकोठा व्यवस्थापनको एउटा प्रमुख सिद्धान्त निम्नमध्ये कुन हो?', E'शिक्षकले सधैँ कक्षाबाहिर बस्नु', E'विद्यार्थीलाई निर्णय प्रक्रियाबाट पूर्णतः बाहिर राख्नु', E'स्पष्ट नियम र प्रक्रियाहरू (Clear rules and procedures) स्थापना गर्नु', E'विद्यार्थीलाई कुनै पनि नियम नबताउनु', E'C', E'**प्रभावकारी कक्षाकोठा व्यवस्थापनको एउटा सिद्धान्त स्पष्ट नियम र प्रक्रियाहरू स्थापना गर्नु हो, साथै विद्यार्थीलाई निर्णय प्रक्रियामा सहभागी गराउनु (Student involvement) पनि एउटा प्रजातान्त्रिक सिद्धान्त हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:प्रभावकारी कक्षाकोठा व्यवस्थापनको एउटा प्रमुख सिद्धान्त निम्नमध्ये कुन हो?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'प्रभावकारी कक्षाकोठा व्यवस्थापनले विद्यार्थीको केमा सुधार ल्याउँछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'प्रभावकारी कक्षाकोठा व्यवस्थापनले विद्यार्थीको केमा सुधार ल्याउँछ?', E'विद्यालयको भवनको रङ', E'घरको आर्थिक अवस्था', E'अभिभावकको पेशा', E'शैक्षिक उपलब्धि (Academic achievement)', E'D', E'**प्रभावकारी कक्षाकोठा व्यवस्थापनले विद्यार्थीको शैक्षिक उपलब्धिमा सुधार ल्याउँछ र समस्या व्यवहार तथा अनुशासनहीनता घटाउँछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:प्रभावकारी कक्षाकोठा व्यवस्थापनले विद्यार्थीको केमा सुधार ल्याउँछ?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: शिक्षा नियमावली २०५९ का कक्षाकोठा मापदण्ड र व्यवस्थापन समस्याहरू (आधारभूत तह) (11 Q)
  v_set_id := extensions.uuid_generate_v5('78cc19b3-711d-41e8-ad52-82ce09d996c2'::uuid, E'शिक्षा नियमावली २०५९ का कक्षाकोठा मापदण्ड र व्यवस्थापन समस्याहरू (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '060fd749-1aa6-4771-b4b3-db5eafd0ef97'::uuid, '78cc19b3-711d-41e8-ad52-82ce09d996c2'::uuid, E'शिक्षा नियमावली २०५९ का कक्षाकोठा मापदण्ड र व्यवस्थापन समस्याहरू (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '78cc19b3-711d-41e8-ad52-82ce09d996c2'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा नियमावली २०५९ को अनुसूची ३ अनुसार कक्षाकोठा सामान्यतया कति उचाइको हुनुपर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'शिक्षा नियमावली २०५९ को अनुसूची ३ अनुसार कक्षाकोठा सामान्यतया कति उचाइको हुनुपर्छ?', E'९ फिट', E'१५ फिट', E'१२ फिट', E'६ फिट', E'A', E'**शिक्षा नियमावली २०५९ अनुसार कक्षाकोठा सामान्यतया नौ फिट उचाइको र घाम तथा पानीबाट बचाउ हुने किसिमको हुनुपर्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा नियमावली २०५९ को अनुसूची ३ अनुसार कक्षाकोठा सामान्यतया कति उचाइको हुनुपर्छ?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा नियमावली २०५९ अनुसार पूर्वप्राथमिक र प्राथमिक विद्यालयको हकमा प्रतिविद्यार्थी कक्षागत क्षेत्रफल कति हुनुपर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'शिक्षा नियमावली २०५९ अनुसार पूर्वप्राथमिक र प्राथमिक विद्यालयको हकमा प्रतिविद्यार्थी कक्षागत क्षेत्रफल कति हुनुपर्छ?', E'०.५० वर्ग मिटर', E'०.७५ वर्ग मिटर', E'१.०० वर्ग मिटर', E'१.५० वर्ग मिटर', E'B', E'**पूर्वप्राथमिक र प्राथमिक विद्यालयको हकमा प्रतिविद्यार्थी कक्षागत क्षेत्रफल ०.७५ वर्ग मिटर हुनुपर्छ।**\\nनोट: निम्नमाध्यमिक र माध्यमिक विद्यालयको हकमा यो क्षेत्रफल १.०० वर्ग मिटरभन्दा कम हुन नहुने व्यवस्था छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा नियमावली २०५९ अनुसार पूर्वप्राथमिक र प्राथमिक विद्यालयको हकमा प्रतिविद्यार्थी कक्षागत क्षेत्रफल कति हुनुपर्छ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा नियमावली २०५९ अनुसार निम्नमाध्यमिक र माध्यमिक विद्यालयको हकमा प्रतिविद्यार्थी कक्षागत क्षेत्रफल कति भन्दा कम हुन नहुने व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'शिक्षा नियमावली २०५९ अनुसार निम्नमाध्यमिक र माध्यमिक विद्यालयको हकमा प्रतिविद्यार्थी कक्षागत क्षेत्रफल कति भन्दा कम हुन नहुने व्यवस्था छ?', E'१.२५ वर्ग मिटर', E'०.७५ वर्ग मिटर', E'१.०० वर्ग मिटर', E'२.०० वर्ग मिटर', E'C', E'**निम्नमाध्यमिक र माध्यमिक विद्यालयको हकमा प्रतिविद्यार्थी कक्षागत क्षेत्रफल १.०० वर्ग मिटरभन्दा कम हुन नहुने व्यवस्था छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा नियमावली २०५९ अनुसार निम्नमाध्यमिक र माध्यमिक विद्यालयको हकमा प्रतिविद्यार्थी कक्षागत क्षेत्रफल कति भन्दा कम हुन नहुने व्यवस्था छ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा नियमावली २०५९ अनुसार पूर्वप्राथमिक विद्यालयबाहेक अन्य विद्यालयमा प्रत्येक थप कति जना विद्यार्थीका लागि छात्रछात्राको छुट्टाछुट्टै शौचालयमा एक कम्पार्टमेन्ट थप हुनुपर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'शिक्षा नियमावली २०५९ अनुसार पूर्वप्राथमिक विद्यालयबाहेक अन्य विद्यालयमा प्रत्येक थप कति जना विद्यार्थीका लागि छात्रछात्राको छुट्टाछुट्टै शौचालयमा एक कम्पार्टमेन्ट थप हुनुपर्छ?', E'७५ जना', E'१०० जना', E'२५ जना', E'५० जना', E'D', E'**पूर्वप्राथमिक विद्यालयबाहेक अन्य विद्यालयमा छात्रछात्राका लागि अलग-अलग शौचालयको व्यवस्था हुनुपर्ने र प्रत्येक थप ५० जना विद्यार्थीका लागि एक कम्पार्टमेन्ट थप हुनुपर्ने व्यवस्था छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा नियमावली २०५९ अनुसार पूर्वप्राथमिक विद्यालयबाहेक अन्य विद्यालयमा प्रत्येक थप कति जना विद्यार्थीका लागि छात्रछात्राको छुट्टाछुट्टै शौचालयमा एक कम्पार्टमेन्ट थप हुनुपर्छ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा नियमावली २०५९ अनुसार पुस्तकालयमा १ विद्यार्थी बराबर कम्तीमा कति प्रति पुस्तक उपलब्ध हुनुपर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'शिक्षा नियमावली २०५९ अनुसार पुस्तकालयमा १ विद्यार्थी बराबर कम्तीमा कति प्रति पुस्तक उपलब्ध हुनुपर्छ?', E'२ प्रति', E'३ प्रति', E'१ प्रति', E'५ प्रति', E'A', E'**शिक्षा नियमावली २०५९ अनुसार पाठ्यक्रम, पाठ्यपुस्तक र शिक्षक निर्देशिकासहित १ विद्यार्थी बराबर कम्तीमा २ प्रतिका दरले पुस्तक उपलब्ध भएको पुस्तकालय हुनुपर्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा नियमावली २०५९ अनुसार पुस्तकालयमा १ विद्यार्थी बराबर कम्तीमा कति प्रति पुस्तक उपलब्ध हुनुपर्छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षा नियमावली २०५९ को अनुसूची ३ अनुसार कक्षाकोठासम्बन्धी भौतिक पूर्वाधारमा निम्नमध्ये कुन कुरा उल्लेख छैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'शिक्षा नियमावली २०५९ को अनुसूची ३ अनुसार कक्षाकोठासम्बन्धी भौतिक पूर्वाधारमा निम्नमध्ये कुन कुरा उल्लेख छैन?', E'विद्यार्थी सङ्ख्याको आधारमा फर्निचरको व्यवस्था', E'प्रत्येक विद्यार्थीलाई निःशुल्क मोबाइल फोन वितरण', E'हावाको प्रवाह र प्रकाशको व्यवस्थापन', E'यथेष्ट स्वास्थ्यकर खानेपानीको प्रबन्ध', E'B', E'**"प्रत्येक विद्यार्थीलाई निःशुल्क मोबाइल फोन वितरण" शिक्षा नियमावली २०५९ को अनुसूची ३ मा उल्लेख छैन।**\\n- हावा-प्रकाश व्यवस्थापन, फर्निचरको व्यवस्था र खानेपानीको प्रबन्ध तीनवटै वास्तविक व्यवस्था हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षा नियमावली २०५९ को अनुसूची ३ अनुसार कक्षाकोठासम्बन्धी भौतिक पूर्वाधारमा निम्नमध्ये कुन कुरा उल्लेख छैन?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कक्षाकोठा व्यवस्थापनका समस्याहरूमध्ये निम्नमध्ये कुन पर्दैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'कक्षाकोठा व्यवस्थापनका समस्याहरूमध्ये निम्नमध्ये कुन पर्दैन?', E'कक्षाकोठा व्यवस्थापनमा शिक्षकको रुचि नदेखिनु', E'दक्ष र तालिमप्राप्त जनशक्तिको अभाव', E'विद्यार्थी सङ्ख्यामा अत्यधिक कमी आउनु', E'आवश्यकताअनुसार बजेट र स्रोतसाधनको अभाव', E'C', E'**"विद्यार्थी सङ्ख्यामा अत्यधिक कमी आउनु" कक्षाकोठा व्यवस्थापनको समस्याका रूपमा उल्लेख गरिएको छैन।**\\n- दक्ष जनशक्तिको अभाव, बजेट-स्रोतको अभाव र शिक्षकको रुचि नदेखिनु तीनवटै वास्तविक उल्लिखित समस्या हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कक्षाकोठा व्यवस्थापनका समस्याहरूमध्ये निम्नमध्ये कुन पर्दैन?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कक्षाकोठा व्यवस्थापनका समस्याहरूमध्ये कुन तथ्यले भौतिक पक्ष र शैक्षिक पक्षबिचको असन्तुलन देखाउँछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'कक्षाकोठा व्यवस्थापनका समस्याहरूमध्ये कुन तथ्यले भौतिक पक्ष र शैक्षिक पक्षबिचको असन्तुलन देखाउँछ?', E'दुवै पक्षमा उत्तिकै ध्यान दिइएको', E'कुनै पनि पक्षमा ध्यान नदिइएको', E'शैक्षिक पक्षमा मात्र ध्यान दिइएको', E'भौतिक पक्षमा बढी केन्द्रित भई शैक्षिक पक्षलाई कम महत्त्व दिइएको', E'D', E'**कक्षाकोठा व्यवस्थापनमा भौतिक पक्षमा बढी केन्द्रित भई शैक्षिक पक्षलाई कम महत्त्व दिइनु एउटा प्रमुख समस्या हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कक्षाकोठा व्यवस्थापनका समस्याहरूमध्ये कुन तथ्यले भौतिक पक्ष र शैक्षिक पक्षबिचको असन्तुलन देखाउँछ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'प्रभावकारी कक्षाकोठा व्यवस्थापनका लागि शिक्षकले कस्तो "अपेक्षा" निर्धारण गर्नुपर्छ भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'प्रभावकारी कक्षाकोठा व्यवस्थापनका लागि शिक्षकले कस्तो "अपेक्षा" निर्धारण गर्नुपर्छ भनिन्छ?', E'स्पष्ट अपेक्षा (Clear expectations)', E'अस्पष्ट र अनिश्चित अपेक्षा', E'कुनै पनि अपेक्षा नराख्ने', E'अत्यधिक कठोर र असम्भव अपेक्षा', E'A', E'**प्रभावकारी कक्षाकोठा व्यवस्थापनका लागि शिक्षकले स्पष्ट अपेक्षा (Clear expectations) निर्धारण गर्नुपर्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:प्रभावकारी कक्षाकोठा व्यवस्थापनका लागि शिक्षकले कस्तो "अपेक्षा" निर्धारण गर्नुपर्छ भनिन्छ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कक्षाकोठामा समय व्यवस्थापनका लागि के आवश्यक हुन्छ भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'कक्षाकोठामा समय व्यवस्थापनका लागि के आवश्यक हुन्छ भनिन्छ?', E'विद्यार्थीलाई जहिले पनि ढिलो आउन दिनु', E'स्पष्ट पाठ योजना (Clear lesson plan) र क्रियाकलापको समय निर्धारण', E'पाठ योजना पूर्णतः नबनाउनु', E'समयको कुनै हिसाब नराख्नु', E'B', E'**कक्षाकोठामा समय व्यवस्थापनका लागि स्पष्ट पाठ योजना र क्रियाकलापको समय निर्धारण आवश्यक हुन्छ, साथै संक्रमणकालीन समय (Transition time) घटाउन पूर्वतयारी र स्पष्ट निर्देशन दिनु पनि जरुरी हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कक्षाकोठामा समय व्यवस्थापनका लागि के आवश्यक हुन्छ भनिन्छ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कक्षाकोठा व्यवस्थापनका प्रमुख चुनौतीहरूमध्ये निम्नमध्ये कुन पर्दैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'कक्षाकोठा व्यवस्थापनका प्रमुख चुनौतीहरूमध्ये निम्नमध्ये कुन पर्दैन?', E'स्रोतको अभाव (Lack of resources)', E'शिक्षकको अपर्याप्त तालिम (Insufficient training)', E'विद्यालयको स्थापना वर्ष धेरै पुरानो हुनु', E'ठूलो कक्षा आकार (Large class size)', E'C', E'**"विद्यालयको स्थापना वर्ष धेरै पुरानो हुनु" कक्षाकोठा व्यवस्थापनको चुनौतीका रूपमा उल्लेख गरिएको छैन।**\\n- ठूलो कक्षा आकार, स्रोतको अभाव र शिक्षकको अपर्याप्त तालिम तीनवटै वास्तविक चुनौती हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कक्षाकोठा व्यवस्थापनका प्रमुख चुनौतीहरूमध्ये निम्नमध्ये कुन पर्दैन?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: कक्षाकोठामा विविधता व्यवस्थापन (आधारभूत तह) (11 Q)
  v_set_id := extensions.uuid_generate_v5('e5cf55e9-7d6b-430a-a348-a96385884d42'::uuid, E'कक्षाकोठामा विविधता व्यवस्थापन (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '060fd749-1aa6-4771-b4b3-db5eafd0ef97'::uuid, 'e5cf55e9-7d6b-430a-a348-a96385884d42'::uuid, E'कक्षाकोठामा विविधता व्यवस्थापन (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'e5cf55e9-7d6b-430a-a348-a96385884d42'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विविधता व्यवस्थापनको अवधारणा कहिले र कहाँ विकास भएको मानिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'विविधता व्यवस्थापनको अवधारणा कहिले र कहाँ विकास भएको मानिन्छ?', E'सन् १९५० मा फ्रान्समा', E'सन् २००० मा नेपालमा', E'सन् १९७० मा भारतमा', E'सन् १९८० को मध्य दशकमा अमेरिकामा', E'D', E'**विविधता व्यवस्थापनको अवधारणा सन् १९८० को मध्य दशकमा अमेरिकामा विकास भएको हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विविधता व्यवस्थापनको अवधारणा कहिले र कहाँ विकास भएको मानिन्छ?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विविधता व्यवस्थापन भनेको के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'विविधता व्यवस्थापन भनेको के हो?', E'व्यक्ति-व्यक्तिबिचमा देखापर्न सक्ने विभेदलाई घटाउँदै सबैलाई समान अवसरको सिर्जना गर्ने कार्य', E'केवल विदेशी भाषा सिकाउने कार्य', E'विद्यार्थीलाई एउटै समूहमा जबरजस्ती राख्ने कार्य', E'परीक्षामा सबैलाई समान अङ्क दिने कार्य', E'A', E'**विविधता व्यवस्थापन भनेको व्यक्ति-व्यक्तिबिचमा देखापर्न सक्ने विभिन्न कारणबाट देखिने विभेदलाई घटाउँदै सबैलाई समान अवसरको सिर्जना गर्ने कार्य हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विविधता व्यवस्थापन भनेको के हो?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालको संविधानको धारा ३१ को उपधारा (५) मा प्रत्येक नेपाली समुदायलाई के गर्ने हक हुने व्यवस्था छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'नेपालको संविधानको धारा ३१ को उपधारा (५) मा प्रत्येक नेपाली समुदायलाई के गर्ने हक हुने व्यवस्था छ?', E'जुनसुकै विषयमा परीक्षा नदिई प्रमाणपत्र पाउने', E'मातृभाषामा शिक्षा प्राप्त गर्ने र त्यसका लागि विद्यालय खोल्ने-सञ्चालन गर्ने', E'निजी विद्यालयको सम्पूर्ण स्वामित्व लिने', E'निःशुल्क विदेश अध्ययन गर्ने', E'B', E'**नेपालको संविधानको धारा ३१ को उपधारा (५) अनुसार प्रत्येक नेपाली समुदायलाई कानुनमा व्यवस्था भएबमोजिम मातृभाषामा शिक्षा प्राप्त गर्ने र त्यसका लागि विद्यालय तथा शिक्षण संस्था खोल्न र सञ्चालन गर्न पाउने हक हुनेछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालको संविधानको धारा ३१ को उपधारा (५) मा प्रत्येक नेपाली समुदायलाई के गर्ने हक हुने व्यवस्था छ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'अपाङ्गताको वर्गीकरण अंगको आधारमा गर्दा जम्मा कति प्रकार हुन्छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'अपाङ्गताको वर्गीकरण अंगको आधारमा गर्दा जम्मा कति प्रकार हुन्छन्?', E'८ प्रकार', E'१२ प्रकार', E'१० प्रकार', E'५ प्रकार', E'C', E'**अंगको आधारमा अपाङ्गताको वर्गीकरण गर्दा जम्मा १० प्रकार हुन्छन्: शारीरिक, दृष्टिसम्बन्धी, सुनाइसम्बन्धी, सुनाइ-दृष्टिविहीन, स्वर बोलाइसम्बन्धी, मानसिक वा मनोसामाजिक, बौद्धिक, हेमोफिलिया, अटिज्म र बहु अपाङ्गता।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:अपाङ्गताको वर्गीकरण अंगको आधारमा गर्दा जम्मा कति प्रकार हुन्छन्?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'अपाङ्गताको वर्गीकरण जटिलताका आधारमा गर्दा कति प्रकार हुन्छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'अपाङ्गताको वर्गीकरण जटिलताका आधारमा गर्दा कति प्रकार हुन्छन्?', E'२ प्रकार', E'६ प्रकार', E'३ प्रकार', E'४ प्रकार', E'D', E'**जटिलताका आधारमा अपाङ्गताको वर्गीकरण ४ प्रकारमा गरिन्छ: पूर्ण अशक्त (रातो), अति अशक्त (नीलो), मध्यम अशक्त (पहेँलो) र सामान्य अशक्त (सेतो)।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:अपाङ्गताको वर्गीकरण जटिलताका आधारमा गर्दा कति प्रकार हुन्छन्?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'जटिलताका आधारमा गरिएको अपाङ्गताको वर्गीकरणमा "पूर्ण अशक्त" लाई कुन रङले जनाइन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'जटिलताका आधारमा गरिएको अपाङ्गताको वर्गीकरणमा "पूर्ण अशक्त" लाई कुन रङले जनाइन्छ?', E'रातो', E'सेतो', E'पहेँलो', E'नीलो', E'A', E'**जटिलताका आधारमा गरिएको वर्गीकरणमा पूर्ण अशक्तलाई रातो रङले जनाइन्छ।**\\nनोट: अति अशक्तलाई नीलो, मध्यम अशक्तलाई पहेँलो र सामान्य अशक्तलाई सेतो रङले जनाइन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:जटिलताका आधारमा गरिएको अपाङ्गताको वर्गीकरणमा "पूर्ण अशक्त" लाई कुन रङले जनाइन्छ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालमा विद्यमान व्यवस्थाअनुसार अपाङ्गतासम्बन्धी विविधताको व्यवस्थापन मुख्यतः कति तरिकाबाट गरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'नेपालमा विद्यमान व्यवस्थाअनुसार अपाङ्गतासम्बन्धी विविधताको व्यवस्थापन मुख्यतः कति तरिकाबाट गरिन्छ?', E'४ तरिका', E'२ तरिका: समावेशी शिक्षा र विशेष शिक्षा', E'५ तरिका', E'१ तरिका', E'B', E'**नेपालमा अपाङ्गतासम्बन्धी विविधताको व्यवस्थापन मुख्यतः २ तरिकाबाट गरिन्छ: समावेशी शिक्षा प्रदान गर्ने र विशेष शिक्षा प्रदान गर्ने।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालमा विद्यमान व्यवस्थाअनुसार अपाङ्गतासम्बन्धी विविधताको व्यवस्थापन मुख्यतः कति तरिकाबाट गरिन्छ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कक्षाकोठामा विविधता व्यवस्थापन गर्ने तरिकाहरूमध्ये निम्नमध्ये कुन पर्दैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'कक्षाकोठामा विविधता व्यवस्थापन गर्ने तरिकाहरूमध्ये निम्नमध्ये कुन पर्दैन?', E'विद्यार्थीहरूको दैनिक क्रियाकलापको अवलोकन गरेर', E'विद्यार्थीहरूको संवेगात्मक अवस्था पहिचान गरेर', E'विद्यार्थीहरूलाई सधैँ एउटै ठाउँमा उभ्याई राखेर', E'विद्यार्थीहरूको सामाजिक, पारिवारिक, धार्मिक, सांस्कृतिक र आर्थिक पृष्ठभूमिको अभिलेखीकरण गरेर', E'C', E'**"विद्यार्थीहरूलाई सधैँ एउटै ठाउँमा उभ्याई राखेर" विविधता व्यवस्थापनको तरिका होइन।**\\n- पृष्ठभूमिको अभिलेखीकरण, संवेगात्मक अवस्था पहिचान र दैनिक क्रियाकलापको अवलोकन तीनवटै वास्तविक तरिका हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कक्षाकोठामा विविधता व्यवस्थापन गर्ने तरिकाहरूमध्ये निम्नमध्ये कुन पर्दैन?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'बालबालिकालाई उनीहरूको शिक्षा र विकासमा असर पुग्ने गरी काममा लगाइनुलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'बालबालिकालाई उनीहरूको शिक्षा र विकासमा असर पुग्ने गरी काममा लगाइनुलाई के भनिन्छ?', E'समावेशी शिक्षा', E'बालमैत्री शिक्षा', E'विशेष शिक्षा', E'बालश्रम', E'D', E'**बालबालिकालाई उनीहरूको शिक्षा र विकासमा असर पुग्ने गरी काममा लगाइनुलाई बालश्रम भनिन्छ, र यसरी बालबालिकालाई वृद्धि तथा शिक्षामा हानि पुग्ने गरी काममा लगाउन पाइँदैन।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:बालबालिकालाई उनीहरूको शिक्षा र विकासमा असर पुग्ने गरी काममा लगाइनुलाई के भनिन्छ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विविधता व्यवस्थापनको क्षेत्रअन्तर्गत निम्नमध्ये कुन पर्दैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'विविधता व्यवस्थापनको क्षेत्रअन्तर्गत निम्नमध्ये कुन पर्दैन?', E'विद्यार्थीको पसन्दको खेलकुद टोली', E'आर्थिक अवस्था र उमेर सम्बन्धी विविधता', E'भाषिक, धार्मिक, सांस्कृतिक विविधता', E'लैङ्गिक र अपाङ्गता सम्बन्धी विविधता', E'A', E'**"विद्यार्थीको पसन्दको खेलकुद टोली" विविधता व्यवस्थापनको क्षेत्रअन्तर्गत पर्दैन।**\\n- भाषिक-धार्मिक-सांस्कृतिक विविधता, लैङ्गिक-अपाङ्गता विविधता र आर्थिक-उमेर विविधता तीनवटै वास्तविक क्षेत्रहरू हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विविधता व्यवस्थापनको क्षेत्रअन्तर्गत निम्नमध्ये कुन पर्दैन?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षकले विद्यार्थीको व्यक्तिगत भिन्नतालाई बुझेर के अपनाउनुपर्छ भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'शिक्षकले विद्यार्थीको व्यक्तिगत भिन्नतालाई बुझेर के अपनाउनुपर्छ भनिन्छ?', E'भिन्नतालाई पूर्णतः बेवास्ता गर्ने नीति', E'सोही अनुसारको व्यवहार र शिक्षण रणनीति', E'कमजोर विद्यार्थीलाई कक्षाबाट निकाल्ने नीति', E'सबैलाई एउटै ढाँचामा हेर्ने दृष्टिकोण', E'B', E'**शिक्षकले विद्यार्थीको व्यक्तिगत भिन्नतालाई बुझेर सोही अनुसारको व्यवहार र शिक्षण रणनीति अपनाउनुपर्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षकले विद्यार्थीको व्यक्तिगत भिन्नतालाई बुझेर के अपनाउनुपर्छ भनिन्छ?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: शैक्षणिक सङ्गठन: कक्षा शिक्षण, बहुकक्षा शिक्षण र समय व्यवस्थापन (आधारभूत तह) (9 Q)
  v_set_id := extensions.uuid_generate_v5('ff890dbb-ffda-4f02-8111-ee66c3964d76'::uuid, E'शैक्षणिक सङ्गठन: कक्षा शिक्षण, बहुकक्षा शिक्षण र समय व्यवस्थापन (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '060fd749-1aa6-4771-b4b3-db5eafd0ef97'::uuid, 'ff890dbb-ffda-4f02-8111-ee66c3964d76'::uuid, E'शैक्षणिक सङ्गठन: कक्षा शिक्षण, बहुकक्षा शिक्षण र समय व्यवस्थापन (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, 'ff890dbb-ffda-4f02-8111-ee66c3964d76'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शैक्षणिक सङ्गठनको मुख्य उद्देश्य के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'शैक्षणिक सङ्गठनको मुख्य उद्देश्य के हो?', E'विद्यालयको बजेट स्वीकृत गर्नु', E'परीक्षा केन्द्र छनोट गर्नु', E'कक्षा शिक्षणलाई प्रभावकारी रूपमा सञ्चालन गर्न व्यवहारमूलक प्रबन्ध मिलाउनु', E'शिक्षकको तलब निर्धारण गर्नु', E'C', E'**शैक्षणिक सङ्गठनका मुख्य उद्देश्य कक्षा शिक्षणलाई प्रभावकारी रूपमा सञ्चालन गर्न व्यवहारमूलक प्रबन्ध मिलाउनु हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शैक्षणिक सङ्गठनको मुख्य उद्देश्य के हो?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'एउटा शिक्षकलाई एउटा कक्षाको अध्यापनका लागि सम्पूर्ण जिम्मा दिइएको शैक्षणिक सङ्गठनलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'एउटा शिक्षकलाई एउटा कक्षाको अध्यापनका लागि सम्पूर्ण जिम्मा दिइएको शैक्षणिक सङ्गठनलाई के भनिन्छ?', E'बहुकक्षा शिक्षण', E'विषय शिक्षण', E'मिश्रित शिक्षण', E'कक्षा शिक्षण', E'D', E'**एउटा शिक्षकलाई एउटा कक्षाको अध्यापनका लागि सम्पूर्ण जिम्मा दिइएको प्रणालीलाई कक्षा शिक्षण भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:एउटा शिक्षकलाई एउटा कक्षाको अध्यापनका लागि सम्पूर्ण जिम्मा दिइएको शैक्षणिक सङ्गठनलाई के भनिन्छ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'एक समयमा एक जना शिक्षकले एकभन्दा बढी कक्षाका विद्यार्थीहरूलाई शिक्षण गर्ने पद्दतिलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'एक समयमा एक जना शिक्षकले एकभन्दा बढी कक्षाका विद्यार्थीहरूलाई शिक्षण गर्ने पद्दतिलाई के भनिन्छ?', E'बहुकक्षा शिक्षण', E'कक्षा शिक्षण', E'मिश्रित शिक्षण', E'विषय शिक्षण', E'A', E'**एक समयमा एक जना शिक्षकले एकभन्दा बढी कक्षाका विद्यार्थीहरूलाई शिक्षण गर्ने पद्दतिलाई बहुकक्षा शिक्षण भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:एक समयमा एक जना शिक्षकले एकभन्दा बढी कक्षाका विद्यार्थीहरूलाई शिक्षण गर्ने पद्दतिलाई के भनिन्छ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कक्षा शिक्षण र बहुकक्षा शिक्षणबिचको भिन्नताअनुसार कक्षा शिक्षणमा शिक्षक बारम्बार अरू कक्षामा जानु नपर्ने हुँदा के फाइदा हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'कक्षा शिक्षण र बहुकक्षा शिक्षणबिचको भिन्नताअनुसार कक्षा शिक्षणमा शिक्षक बारम्बार अरू कक्षामा जानु नपर्ने हुँदा के फाइदा हुन्छ?', E'विद्यार्थीको ध्यान भड्किने', E'समयको बचत हुने', E'शिक्षकको कार्यबोझ बढ्ने', E'खर्च बढ्ने', E'B', E'**कक्षा शिक्षणमा शिक्षक बारम्बार अरू कक्षामा जानु नपर्ने हुँदा समयको बचत हुन्छ।**\\nनोट: तर यसमा कक्षा शिक्षणको कार्य र जिम्मेवारी बोझिलो हुने र सबै विषयमा निपुण शिक्षक पाउन कठिन हुने पनि सीमा रहन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कक्षा शिक्षण र बहुकक्षा शिक्षणबिचको भिन्नताअनुसार कक्षा शिक्षणमा शिक्षक बारम्बार अरू कक्षामा जानु नपर्ने हुँदा के फाइदा हुन्छ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कक्षा शिक्षणमा शिक्षकले दैनिक कार्यतालिकालाई कस्तो बनाई विद्यार्थीको आवश्यकताको प्रतिनिधित्व गराउन सक्छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'कक्षा शिक्षणमा शिक्षकले दैनिक कार्यतालिकालाई कस्तो बनाई विद्यार्थीको आवश्यकताको प्रतिनिधित्व गराउन सक्छन्?', E'अत्यन्त कठोर र अपरिवर्तनीय', E'अनिवार्य रूपमा साप्ताहिक परिवर्तन हुने', E'लचिलो', E'पूर्णतः स्थिर', E'C', E'**कक्षा शिक्षणमा दैनिक कार्यतालिकालाई लचिलो बनाई विद्यार्थीको आवश्यकताको प्रतिनिधित्व गराउन सकिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कक्षा शिक्षणमा शिक्षकले दैनिक कार्यतालिकालाई कस्तो बनाई विद्यार्थीको आवश्यकताको प्रतिनिधित्व गराउन सक्छन्?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कक्षाकोठामा समय व्यवस्थापन भन्नाले के जनाउँछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'कक्षाकोठामा समय व्यवस्थापन भन्नाले के जनाउँछ?', E'विद्यालयको बिदा तालिका मात्र', E'विद्यार्थीलाई घडी पढाउने कार्य', E'परीक्षाको समयतालिका मात्र', E'शिक्षण सिकाइ क्रियाकलापका लागि उपलब्ध समयको अधिकतम उपयोग गर्ने प्रक्रिया', E'D', E'**कक्षाकोठामा समय व्यवस्थापनले शिक्षण सिकाइ क्रियाकलापका लागि उपलब्ध समयको अधिकतम उपयोग गर्ने प्रक्रियालाई जनाउँछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कक्षाकोठामा समय व्यवस्थापन भन्नाले के जनाउँछ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कक्षाकोठामा संक्रमणकालीन समय (Transition time) लाई कम गर्ने रणनीति के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'कक्षाकोठामा संक्रमणकालीन समय (Transition time) लाई कम गर्ने रणनीति के हो?', E'पूर्वतयारी र स्पष्ट निर्देशन दिनु', E'विद्यार्थीलाई निर्देशन नदिनु', E'क्रियाकलापबिच लामो समय खेर फाल्नु', E'पाठ योजना नबनाउनु', E'A', E'**कक्षाकोठामा संक्रमणकालीन समय (Transition time) लाई कम गर्न पूर्वतयारी र स्पष्ट निर्देशन दिनु प्रभावकारी रणनीति हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कक्षाकोठामा संक्रमणकालीन समय (Transition time) लाई कम गर्ने रणनीति के हो?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यार्थी सङ्ख्या, कक्षा सङ्ख्या र शिक्षकको दरबन्दीका आधारमा कस्तो शैक्षणिक सङ्गठन व्यवस्थापन गरिन्छ भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'विद्यार्थी सङ्ख्या, कक्षा सङ्ख्या र शिक्षकको दरबन्दीका आधारमा कस्तो शैक्षणिक सङ्गठन व्यवस्थापन गरिन्छ भनिन्छ?', E'केवल विषय शिक्षण मात्र', E'कक्षा शिक्षण, बहुकक्षा शिक्षण वा विषय शिक्षण', E'केवल बहुकक्षा शिक्षण मात्र', E'जुनसुकै अवस्थामा पनि उस्तै व्यवस्थापन', E'B', E'**विद्यार्थी सङ्ख्या, कक्षा सङ्ख्या र शिक्षकको दरबन्दीका आधारमा कक्षा शिक्षण, बहुकक्षा शिक्षण वा विषय शिक्षण व्यवस्थापन गरिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यार्थी सङ्ख्या, कक्षा सङ्ख्या र शिक्षकको दरबन्दीका आधारमा कस्तो शैक्षणिक सङ्गठन व्यवस्थापन गरिन्छ भनिन्छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दैनिक कक्षा तालिका बनाउँदा प्रयोगात्मक विषयहरूलाई सामान्यतया कहाँ राखेर तालिका निर्माण गरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'दैनिक कक्षा तालिका बनाउँदा प्रयोगात्मक विषयहरूलाई सामान्यतया कहाँ राखेर तालिका निर्माण गरिन्छ?', E'बिदाको दिन मात्र', E'पहिलो पिरियडमा मात्र', E'टिफिन (खाजा) पछाडि', E'शनिबार मात्र', E'C', E'**दैनिक कक्षा तालिका बनाउँदा प्रयोगात्मक विषयहरूलाई सामान्यतया टिफिन (खाजा) पछाडि राखी तालिका निर्माण गरिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दैनिक कक्षा तालिका बनाउँदा प्रयोगात्मक विषयहरूलाई सामान्यतया कहाँ राखेर तालिका निर्माण गरिन्छ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: द्वन्द्व व्यवस्थापन (आधारभूत तह) (13 Q)
  v_set_id := extensions.uuid_generate_v5('586f5768-b479-4427-b2c8-22a19aa8d491'::uuid, E'द्वन्द्व व्यवस्थापन (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '060fd749-1aa6-4771-b4b3-db5eafd0ef97'::uuid, '586f5768-b479-4427-b2c8-22a19aa8d491'::uuid, E'द्वन्द्व व्यवस्थापन (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '586f5768-b479-4427-b2c8-22a19aa8d491'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'द्वन्द्वको शाब्दिक अर्थ के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'द्वन्द्वको शाब्दिक अर्थ के हो?', E'योजना र व्यवस्थापन', E'सहयोग र मेलमिलाप', E'उत्सव र खुसी', E'झगडा, मनमुटाव, मनोमालिन्य', E'D', E'**द्वन्द्वको शाब्दिक अर्थ झगडा, मनमुटाव, मनोमालिन्य हो।**\\nनोट: द्वन्द्व भनेको सहयोगको विपरीत स्थिति पनि हो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:द्वन्द्वको शाब्दिक अर्थ के हो?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'द्वन्द्वको अवधारणालाई कति प्रकारमा विभाजन गरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'द्वन्द्वको अवधारणालाई कति प्रकारमा विभाजन गरिन्छ?', E'२ प्रकार: परम्परागत र आधुनिक', E'४ प्रकार', E'५ प्रकार', E'३ प्रकार', E'A', E'**द्वन्द्वको अवधारणा परम्परागत र आधुनिक गरी दुई प्रकारबाट विभाजित हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:द्वन्द्वको अवधारणालाई कति प्रकारमा विभाजन गरिन्छ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'द्वन्द्वको परम्परागत अवधारणाले द्वन्द्वलाई कस्तो मान्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'द्वन्द्वको परम्परागत अवधारणाले द्वन्द्वलाई कस्तो मान्छ?', E'सृजनात्मक अवसर', E'खराब र विनाश निम्त्याउने, तत्कालै दबाउनुपर्ने', E'सधैँ सकारात्मक मात्र', E'प्राकृतिक र आवश्यक', E'B', E'**द्वन्द्वको परम्परागत अवधारणाले द्वन्द्वलाई खराब र विनाश निम्त्याउने, आउन नदिनुपर्ने र तत्कालै दबाउनुपर्ने कुरा मान्छ।**\\nनोट: आधुनिक अवधारणाले भने द्वन्द्वलाई प्राकृतिक कुरा मानी दबाउनुभन्दा व्यवस्थापन गर्नुपर्ने ठान्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:द्वन्द्वको परम्परागत अवधारणाले द्वन्द्वलाई कस्तो मान्छ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'द्वन्द्वको आधुनिक अवधारणाले द्वन्द्वलाई कस्तो मान्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'द्वन्द्वको आधुनिक अवधारणाले द्वन्द्वलाई कस्तो मान्छ?', E'पूर्णतः दबाउनुपर्ने खराब कुरा', E'सधैँ नकारात्मक मात्र परिणाम दिने', E'प्राकृतिक कुरा, जसलाई दबाउनुभन्दा व्यवस्थापन गर्नुपर्छ', E'पूर्णतः बेवास्ता गर्नुपर्ने', E'C', E'**द्वन्द्वको आधुनिक अवधारणाले द्वन्द्वलाई प्राकृतिक कुरा मान्छ, जसलाई दबाउनुभन्दा व्यवस्थापन गर्नुपर्छ भन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:द्वन्द्वको आधुनिक अवधारणाले द्वन्द्वलाई कस्तो मान्छ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'द्वन्द्वका तहहरूमध्ये निम्नमध्ये कुन पर्दैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'द्वन्द्वका तहहरूमध्ये निम्नमध्ये कुन पर्दैन?', E'समूह तह', E'सङ्गठनात्मक र राष्ट्रिय तह', E'व्यक्तिगत तह', E'अन्तर्राष्ट्रिय अन्तरिक्ष तह', E'D', E'**द्वन्द्वका तहहरू व्यक्तिगत, समूह, सङ्गठनात्मक र राष्ट्रिय तह गरी चार हुन्।**\\n- "अन्तर्राष्ट्रिय अन्तरिक्ष तह" द्वन्द्वको वास्तविक तहमा पर्दैन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:द्वन्द्वका तहहरूमध्ये निम्नमध्ये कुन पर्दैन?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'व्यक्तिगत द्वन्द्व सामान्यतया कहिले सृजना हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'व्यक्तिगत द्वन्द्व सामान्यतया कहिले सृजना हुन्छ?', E'व्यक्तिगत अभिष्ट पुरा गर्ने क्रममा देखिने बाधा पार गर्दा', E'परीक्षाको नतिजा प्रकाशन हुँदा', E'विद्यालयको भवन निर्माण हुँदा', E'दुई देशबिच युद्ध हुँदा मात्र', E'A', E'**व्यक्तिगत द्वन्द्व व्यक्तिगत अभिष्ट पुरा गर्ने सन्दर्भमा देखिने बाधा पार गर्ने क्रममा सृजना हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:व्यक्तिगत द्वन्द्व सामान्यतया कहिले सृजना हुन्छ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'द्वन्द्व व्यवस्थापनका पाँच शैलीमध्ये "Avoiding" शैलीलाई कुन प्राणीको प्रतीकसँग तुलना गरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'द्वन्द्व व्यवस्थापनका पाँच शैलीमध्ये "Avoiding" शैलीलाई कुन प्राणीको प्रतीकसँग तुलना गरिन्छ?', E'उल्लू (Owl)', E'कछुवा (Turtle)', E'भालु (Teddy Bear)', E'स्याल (Shark)', E'B', E'**बेवास्ता वा Avoiding शैलीलाई कछुवा (Turtle) को प्रतीकसँग तुलना गरिन्छ, जसमा द्वन्द्व थाहा नपाए जस्तो गरिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:द्वन्द्व व्यवस्थापनका पाँच शैलीमध्ये "Avoiding" शैलीलाई कुन प्राणीको प्रतीकसँग तुलना गरिन्छ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'द्वन्द्व व्यवस्थापनका शैलीमध्ये कुन शैलीमा दुवै पक्षको जीत (Win-Win) हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'द्वन्द्व व्यवस्थापनका शैलीमध्ये कुन शैलीमा दुवै पक्षको जीत (Win-Win) हुन्छ?', E'Competing (Shark)', E'Avoiding (Turtle)', E'Collaborating (Owl)', E'Accommodating (Teddy Bear)', E'C', E'**सहकार्य वा Collaborating (Owl) शैलीमा दुवै पक्षको जीत (Win-Win) हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:द्वन्द्व व्यवस्थापनका शैलीमध्ये कुन शैलीमा दुवै पक्षको जीत (Win-Win) हुन्छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'द्वन्द्व व्यवस्थापनको Competing (Shark) शैलीमा सामान्यतया के हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'द्वन्द्व व्यवस्थापनको Competing (Shark) शैलीमा सामान्यतया के हुन्छ?', E'द्वन्द्व थाहा नपाए जस्तो गरिने', E'समस्या पूर्णतः समाधान भइहाल्ने', E'दुवै पक्षले समान रूपमा जित्ने', E'एक पक्ष कमजोर र अर्को पक्ष बलियो भएमा द्वन्द्व हटाउन सकिने', E'D', E'**दबाबमूलक वा Competing (Shark) शैलीमा एक पक्ष कमजोर र अर्को पक्ष बलियो भएमा यसबाट द्वन्द्व हटाउन सकिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:द्वन्द्व व्यवस्थापनको Competing (Shark) शैलीमा सामान्यतया के हुन्छ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'आफूले जित्ने र अर्कोलाई हराउने रणनीतिलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'आफूले जित्ने र अर्कोलाई हराउने रणनीतिलाई के भनिन्छ?', E'Win-Lose Strategy', E'Win-Win Strategy', E'Neutral Strategy', E'Lose-Lose Strategy', E'A', E'**आफूले जित्ने र अर्कोलाई हराउने रणनीतिलाई Win-Lose Strategy भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:आफूले जित्ने र अर्कोलाई हराउने रणनीतिलाई के भनिन्छ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'द्वन्द्व व्यवस्थापनका तरिकाहरूमध्ये निम्नमध्ये कुन पर्दैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'द्वन्द्व व्यवस्थापनका तरिकाहरूमध्ये निम्नमध्ये कुन पर्दैन?', E'प्रवर्द्धनात्मक', E'विनाशात्मक', E'उपचारात्मक', E'सुधारात्मक', E'B', E'**द्वन्द्व व्यवस्थापनका तरिकाहरू प्रवर्द्धनात्मक, उपचारात्मक र सुधारात्मक हुन्।**\\n- "विनाशात्मक" द्वन्द्व व्यवस्थापनको वास्तविक तरिका होइन।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:द्वन्द्व व्यवस्थापनका तरिकाहरूमध्ये निम्नमध्ये कुन पर्दैन?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'द्वन्द्व समाधानका लागि आवश्यक सीपहरूमध्ये निम्नमध्ये कुन पर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'द्वन्द्व समाधानका लागि आवश्यक सीपहरूमध्ये निम्नमध्ये कुन पर्छ?', E'केवल आर्थिक स्रोत', E'केवल शारीरिक बल', E'समस्या समाधान गर्ने सीप र सञ्चार सीप', E'केवल कानुनी ज्ञान', E'C', E'**द्वन्द्व समाधानका लागि आवश्यक सीपहरू समस्या समाधान गर्ने सीप र सञ्चार सीप हुन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:द्वन्द्व समाधानका लागि आवश्यक सीपहरूमध्ये निम्नमध्ये कुन पर्छ?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'द्वन्द्वको कारण/स्रोतहरूमध्ये निम्नमध्ये कुन पर्दैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'द्वन्द्वको कारण/स्रोतहरूमध्ये निम्नमध्ये कुन पर्दैन?', E'अप्रभावकारी तथा अपर्याप्त सञ्चार प्रणाली', E'संस्थागत संरचनाको अनिश्चितता', E'व्यक्तिगत सोच र धारणाको स्तर', E'विद्यालयको सुन्दर सजावट', E'D', E'**"विद्यालयको सुन्दर सजावट" द्वन्द्वको कारण/स्रोत होइन।**\\n- व्यक्तिगत सोचको स्तर, अप्रभावकारी सञ्चार र संस्थागत संरचनाको अनिश्चितता तीनवटै वास्तविक द्वन्द्वका कारण/स्रोत हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:द्वन्द्वको कारण/स्रोतहरूमध्ये निम्नमध्ये कुन पर्दैन?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: विपद् र सङ्कट व्यवस्थापन (आधारभूत तह) (10 Q)
  v_set_id := extensions.uuid_generate_v5('586f5768-b479-4427-b2c8-22a19aa8d491'::uuid, E'विपद् र सङ्कट व्यवस्थापन (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '060fd749-1aa6-4771-b4b3-db5eafd0ef97'::uuid, '586f5768-b479-4427-b2c8-22a19aa8d491'::uuid, E'विपद् र सङ्कट व्यवस्थापन (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '586f5768-b479-4427-b2c8-22a19aa8d491'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विपद् भनेको के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'विपद् भनेको के हो?', E'प्रभावित समाज वा समुदायले आफ्नै बलबुता र स्रोतसाधनको प्रयोग गरी सामना गर्न नसक्ने गम्भीर प्रकोपजन्य घटना', E'शिक्षकको नियमित सरुवा प्रक्रिया', E'विद्यार्थीको सामान्य परीक्षा असफलता', E'विद्यालयको साधारण बार्षिक कार्यक्रम', E'A', E'**विपद् भनेको प्रभावित समाज वा समुदायले आफ्नै बलबुता र स्रोतसाधनको प्रयोग गरी सामना गर्न नसक्ने त्यस्तो गम्भीर प्रकोपजन्य घटना हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विपद् भनेको के हो?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विपद् भनेको निम्न कति अवस्थाहरूको सम्मिलित परिणाम हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'विपद् भनेको निम्न कति अवस्थाहरूको सम्मिलित परिणाम हो?', E'४ अवस्था', E'३ अवस्था', E'५ अवस्था', E'२ अवस्था', E'B', E'**विपद् भनेको निम्न ३ अवस्थाहरूको सम्मिलित परिणाम हो: प्रकोप सम्मुखता, विद्यमान संकटासन्नता, र जोखिमका सम्भाव्य नकारात्मक परिणामलाई न्यूनीकरण/सामना गर्ने क्षमता वा विधिको अपर्याप्तता।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विपद् भनेको निम्न कति अवस्थाहरूको सम्मिलित परिणाम हो?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विपद् व्यवस्थापन भनेको के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'विपद् व्यवस्थापन भनेको के हो?', E'केवल परीक्षा स्थगन गर्ने प्रक्रिया', E'केवल भवन पुनर्निर्माण', E'जोखिम प्रबन्धन + सङ्कट प्रबन्धन', E'केवल आर्थिक क्षतिपूर्ति वितरण', E'C', E'**विपद् व्यवस्थापन = जोखिम प्रबन्धन + सङ्कट प्रबन्धन।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विपद् व्यवस्थापन भनेको के हो?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विपद् व्यवस्थापनका लागि तर्जुमा गरिएको राष्ट्रिय कार्ययोजना कहिले लागू भएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'विपद् व्यवस्थापनका लागि तर्जुमा गरिएको राष्ट्रिय कार्ययोजना कहिले लागू भएको थियो?', E'सन् २००५ मा', E'सन् २०१५ मा', E'सन् १९९० मा', E'सन् १९९६ मा', E'D', E'**विपद् व्यवस्थापनका लागि तर्जुमा गरिएको राष्ट्रिय कार्ययोजना सन् १९९६ मा लागू भएको थियो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विपद् व्यवस्थापनका लागि तर्जुमा गरिएको राष्ट्रिय कार्ययोजना कहिले लागू भएको थियो?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विपद् जोखिम न्यूनीकरण तथा व्यवस्थापन ऐन कहिले प्रमाणीकरण भएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'विपद् जोखिम न्यूनीकरण तथा व्यवस्थापन ऐन कहिले प्रमाणीकरण भएको थियो?', E'२०७४/०७/०५', E'२०७८/०३/१२', E'२०७२/०५/१०', E'२०७६/०१/२३', E'A', E'**विपद् जोखिम न्यूनीकरण तथा व्यवस्थापन ऐन २०७४/७/५ मा प्रमाणीकरण भएको थियो।**\\nनोट: यसको नियमावली भने २०७६/१/२३ मा प्रमाणीकरण भएको थियो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विपद् जोखिम न्यूनीकरण तथा व्यवस्थापन ऐन कहिले प्रमाणीकरण भएको थियो?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विपद् जोखिम न्यूनीकरण तथा व्यवस्थापन नियमावली कहिले प्रमाणीकरण भएको थियो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'विपद् जोखिम न्यूनीकरण तथा व्यवस्थापन नियमावली कहिले प्रमाणीकरण भएको थियो?', E'२०७८/०५/१५', E'२०७६/०१/२३', E'२०७५/०६/१०', E'२०७४/०७/०५', E'B', E'**विपद् जोखिम न्यूनीकरण तथा व्यवस्थापन नियमावली २०७६/१/२३ मा प्रमाणीकरण भएको थियो।**\\nनोट: सम्बन्धित ऐन भने यसअघि नै २०७४/७/५ मा प्रमाणीकरण भएको थियो।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विपद् जोखिम न्यूनीकरण तथा व्यवस्थापन नियमावली कहिले प्रमाणीकरण भएको थियो?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विपद् व्यवस्थापन चक्रको विपद्पछिको चरणमा निम्नमध्ये कुन कार्य गरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'विपद् व्यवस्थापन चक्रको विपद्पछिको चरणमा निम्नमध्ये कुन कार्य गरिन्छ?', E'नयाँ पाठ्यक्रम निर्माण गर्ने कार्य', E'विद्यालयको वार्षिकोत्सव आयोजना', E'पीडितहरूलाई सान्त्वना, परामर्श र लासहरूको व्यवस्थापन', E'शिक्षक भर्ना परीक्षा सञ्चालन', E'C', E'**विपद् व्यवस्थापन चक्रको विपद्पछिको चरणमा पीडितहरूलाई सान्त्वना, परामर्श, लासहरूको व्यवस्थापन र आपतकालीन योजनाको सुरुवात जस्ता कार्य गरिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विपद् व्यवस्थापन चक्रको विपद्पछिको चरणमा निम्नमध्ये कुन कार्य गरिन्छ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सङ्कट व्यवस्थापनको अर्थ के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'सङ्कट व्यवस्थापनको अर्थ के हो?', E'शिक्षकको दैनिक हाजिरी अभिलेख', E'विद्यालयको नियमित वार्षिक जाँच', E'विद्यार्थीको खेलकुद प्रतियोगिता', E'सङ्गठनात्मक वातावरणमा आउने उतारचढाव, स्रोतको पहुँचमा हुने द्वन्द्व तथा असामान्य र आकस्मिक अवस्था', E'D', E'**सङ्कट व्यवस्थापनको अर्थ सङ्गठनात्मक वातावरणमा आउने उतारचढाव, स्रोतको पहुँच र प्राप्तिमा हुने द्वन्द्व तथा असामान्य र आकस्मिक अवस्था हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सङ्कट व्यवस्थापनको अर्थ के हो?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सङ्कट व्यवस्थापनको उद्देश्य के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'सङ्कट व्यवस्थापनको उद्देश्य के हो?', E'सङ्कटको कारण-प्रभाव पहिचान गरी सम्भावित जोखिमको पूर्व अनुमान गरी जोखिम न्यूनीकरण गर्नु', E'सङ्कटको जानकारी लुकाउनु', E'सङ्कट आएपछि मात्र सोच्नु', E'सङ्कटलाई जानाजान बढाउनु', E'A', E'**सङ्कट व्यवस्थापनलाई सङ्कटको कारण र प्रभाव पहिचान गरी हुनसक्ने सम्भावित जोखिमको पूर्व अनुमान गरी जोखिमको खतराबाट मुक्त वा जोखिम न्यूनीकरण गर्नका लागि अपनाइने सम्पूर्ण प्रयासका रूपमा परिभाषित गरिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सङ्कट व्यवस्थापनको उद्देश्य के हो?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विपद्का परिणामहरूमध्ये निम्नमध्ये कुन पर्दैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'विपद्का परिणामहरूमध्ये निम्नमध्ये कुन पर्दैन?', E'मानव जीवनको नोक्सानी र धनमालको क्षति', E'विद्यालयको स्वतः गुणस्तर वृद्धि', E'सामाजिक तथा आर्थिक गतिरोध', E'सेवाहरूको नोक्सानी र वातावरणीय ह्रास', E'B', E'**"विद्यालयको स्वतः गुणस्तर वृद्धि" विपद्को परिणामका रूपमा उल्लेख गरिएको छैन।**\\n- मानव जीवनको नोक्सानी, सेवाको नोक्सानी र सामाजिक-आर्थिक गतिरोध तीनवटै वास्तविक विपद्का परिणाम हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विपद्का परिणामहरूमध्ये निम्नमध्ये कुन पर्दैन?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  RAISE NOTICE 'Unit ख-८ कक्षाकोठा व्यवस्थापन batch upsert complete: 6 sets, 66 questions.';
END $$;
