-- Idempotent UPSERT import: निमावि प्रथम पत्र — unit ख-६ शिक्षण सिकाइको योजना, विधि र शिक्षण सामग्री
-- Adds Level I sets alongside preserved model sets. Override same-identity; never deletes. Generated 2026-07-01T16:11:16.248Z.
DO $$
DECLARE
  v_module_id uuid := '6695669a-f40e-421a-a4ec-b09bbeaf56c4'::uuid;
  v_set_id uuid;
  v_q_id uuid;
BEGIN

  -- Set: शैक्षणिक योजनाको अर्थ, विशेषता र समय-आधारित प्रकार (आधारभूत तह) (12 Q)
  v_set_id := extensions.uuid_generate_v5('4de2104d-650e-4026-9b3b-114ccbf9a759'::uuid, E'शैक्षणिक योजनाको अर्थ, विशेषता र समय-आधारित प्रकार (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'acf58395-316c-4a70-b7b3-5470be568528'::uuid, '4de2104d-650e-4026-9b3b-114ccbf9a759'::uuid, E'शैक्षणिक योजनाको अर्थ, विशेषता र समय-आधारित प्रकार (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '4de2104d-650e-4026-9b3b-114ccbf9a759'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'प्रभावकारी शिक्षण भन्नाले के बुझिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'प्रभावकारी शिक्षण भन्नाले के बुझिन्छ?', E'व्यक्तिको रुचि, चाहना, आफ्नो क्षमता र स्तरअनुसार सिक्ने अवसर पाउनु', E'विद्यार्थीलाई पाठ घोकाउनु', E'जति सकिन्छ छिटो पाठ्यक्रम सक्नु', E'परीक्षामा उच्च अङ्क ल्याउनु मात्र', E'A', E'**प्रभावकारी शिक्षण भन्नाले व्यक्तिको रुचि, चाहना, आफ्नो क्षमता र स्तरअनुसार सिक्ने अवसर पाउनु बुझिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:प्रभावकारी शिक्षण भन्नाले के बुझिन्छ?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शैक्षणिक योजना भनेको के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'शैक्षणिक योजना भनेको के हो?', E'विद्यार्थीको परीक्षा नतिजाको अभिलेख', E'एक शैक्षिक सत्रमा विद्यालयभित्र र बाहिर के-कस्ता क्रियाकलाप, कसरी र कुन समयमा गर्ने भन्ने पक्ष समावेश गरी तयार गरिएको योजना', E'शिक्षकको तलब वृद्धिको योजना', E'राष्ट्रिय स्तरको दीर्घकालीन जनशक्ति योजना', E'B', E'**शैक्षणिक योजना भनेको एक शैक्षिक सत्रमा विद्यालयभित्र र बाहिर के-कस्ता क्रियाकलाप, कसरी र कुन समयमा गर्ने भन्ने पक्ष समावेश गरी तयार गरिएको योजना हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शैक्षणिक योजना भनेको के हो?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शैक्षणिक योजनाको विशेषताअन्तर्गत निम्नमध्ये कुन पर्दैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'शैक्षणिक योजनाको विशेषताअन्तर्गत निम्नमध्ये कुन पर्दैन?', E'विधि र सामग्रीको बनोट', E'शिक्षकबाट तयार र निश्चित समय', E'राष्ट्रिय बजेट विनियोजन', E'निश्चित उद्देश्य', E'C', E'**"राष्ट्रिय बजेट विनियोजन" शैक्षणिक योजनाको विशेषताअन्तर्गत पर्दैन।**\\n- निश्चित उद्देश्य, विधि-सामग्रीको बनोट र शिक्षकबाट निश्चित समयमा तयार हुनु तीनवटै शैक्षणिक योजनाका वास्तविक विशेषता हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शैक्षणिक योजनाको विशेषताअन्तर्गत निम्नमध्ये कुन पर्दैन?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शैक्षिक योजना र शैक्षणिक योजनाबिचको भिन्नताअनुसार कुन योजना व्यापक र विस्तृत हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'शैक्षिक योजना र शैक्षणिक योजनाबिचको भिन्नताअनुसार कुन योजना व्यापक र विस्तृत हुन्छ?', E'शैक्षणिक योजना', E'दुवै सीमित हुन्छन्', E'दुवै उस्तै विस्तृत हुन्छन्', E'शैक्षिक योजना', E'D', E'**शैक्षिक योजना व्यापक र विस्तृत हुन्छ, जबकि शैक्षणिक योजना सीमित र कक्षाकोठामा आधारित हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शैक्षिक योजना र शैक्षणिक योजनाबिचको भिन्नताअनुसार कुन योजना व्यापक र विस्तृत हुन्छ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शैक्षिक योजना र शैक्षणिक योजनाबिचको भिन्नताअनुसार कुन योजनाले विद्यालय र कक्षाकोठाको प्रतिनिधित्व गर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'शैक्षिक योजना र शैक्षणिक योजनाबिचको भिन्नताअनुसार कुन योजनाले विद्यालय र कक्षाकोठाको प्रतिनिधित्व गर्छ?', E'शैक्षणिक योजना', E'एकाइ योजना मात्र', E'शैक्षिक योजना', E'वार्षिक कार्यतालिका मात्र', E'A', E'**शैक्षणिक योजनाले विद्यालय र कक्षाकोठाको प्रतिनिधित्व गर्छ, जबकि शैक्षिक योजनाले राष्ट्र वा क्षेत्रको प्रतिनिधित्व गर्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शैक्षिक योजना र शैक्षणिक योजनाबिचको भिन्नताअनुसार कुन योजनाले विद्यालय र कक्षाकोठाको प्रतिनिधित्व गर्छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शैक्षिक योजना र शैक्षणिक योजनाबिचको भिन्नताअनुसार कुन योजनाले राष्ट्रिय जनशक्ति उत्पादनको लक्ष्य राख्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'शैक्षिक योजना र शैक्षणिक योजनाबिचको भिन्नताअनुसार कुन योजनाले राष्ट्रिय जनशक्ति उत्पादनको लक्ष्य राख्छ?', E'एकाइ योजना', E'शैक्षिक योजना', E'दैनिक पाठयोजना', E'शैक्षणिक योजना', E'B', E'**शैक्षिक योजनाले राष्ट्रिय जनशक्ति उत्पादनको लक्ष्य राख्छ, जबकि शैक्षणिक योजनाले जनशक्ति उत्पादनका विभिन्न कार्यक्रम सञ्चालन गर्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शैक्षिक योजना र शैक्षणिक योजनाबिचको भिन्नताअनुसार कुन योजनाले राष्ट्रिय जनशक्ति उत्पादनको लक्ष्य राख्छ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शैक्षिक योजना समय अवधिको आधारमा कति प्रकारमा विभाजित हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'शैक्षिक योजना समय अवधिको आधारमा कति प्रकारमा विभाजित हुन्छ?', E'५ प्रकार', E'४ प्रकार', E'३ प्रकार: दीर्घकालीन, मध्यकालीन र अल्पकालीन', E'२ प्रकार', E'C', E'**शैक्षिक योजना समय अवधिको आधारमा दीर्घकालीन, मध्यकालीन र अल्पकालीन गरी ३ प्रकारमा विभाजित हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शैक्षिक योजना समय अवधिको आधारमा कति प्रकारमा विभाजित हुन्छ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दीर्घकालीन योजना सामान्यतया कति वर्षसम्मको हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'दीर्घकालीन योजना सामान्यतया कति वर्षसम्मको हुन्छ?', E'सामान्यतया ५-७ वर्षको', E'सामान्यतया १ वर्षको', E'सामान्यतया ५० वर्षको', E'सामान्यतया २० वर्षको (कहिलेकाहीं १५-२५ वर्षसम्म)', E'D', E'**दीर्घकालीन योजना सामान्यतया २० वर्षको हुन्छ, कहिलेकाहीं यो १५-२५ वर्षसम्म पनि रहन्छ।**\\nनोट: मध्यकालीन योजना ५-७ वर्षको र अल्पकालीन योजना १ वर्षको हुन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दीर्घकालीन योजना सामान्यतया कति वर्षसम्मको हुन्छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'मध्यकालीन योजना सामान्यतया कति वर्षसम्मको हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'मध्यकालीन योजना सामान्यतया कति वर्षसम्मको हुन्छ?', E'५-७ वर्षको', E'५० वर्षको', E'१ वर्षको', E'२० वर्षको', E'A', E'**मध्यकालीन योजना सामान्यतया ५-७ वर्षको हुन्छ।**\\nनोट: यसले दीर्घकालीन र अल्पकालीन योजनाबिचको पुलको रूपमा काम गर्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:मध्यकालीन योजना सामान्यतया कति वर्षसम्मको हुन्छ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'अल्पकालीन योजना सामान्यतया कति वर्षको हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'अल्पकालीन योजना सामान्यतया कति वर्षको हुन्छ?', E'२० वर्षको', E'१ वर्षको', E'३ वर्षको', E'५-७ वर्षको', E'B', E'**अल्पकालीन योजना सामान्यतया १ वर्षको हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:अल्पकालीन योजना सामान्यतया कति वर्षको हुन्छ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'योजनाका प्रकारमध्ये दीर्घकालीन र अल्पकालीन योजनाको पुलको रूपमा कुन योजना रहन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'योजनाका प्रकारमध्ये दीर्घकालीन र अल्पकालीन योजनाको पुलको रूपमा कुन योजना रहन्छ?', E'वार्षिक कार्यतालिका', E'दैनिक पाठयोजना', E'मध्यकालीन योजना', E'एकाइ योजना', E'C', E'**मध्यकालीन योजना दीर्घकालीन र अल्पकालीन योजनाको पुलको रूपमा रहन्छ।**\\nनोट: अल्पकालीन योजना भने दीर्घकालीन र मध्यकालीन दुवैको लक्ष्यसँग तादात्म्यता राखी निर्माण गरिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:योजनाका प्रकारमध्ये दीर्घकालीन र अल्पकालीन योजनाको पुलको रूपमा कुन योजना रहन्छ?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शैक्षिक योजना र शैक्षणिक योजनाबिचको भिन्नताअनुसार शैक्षिक योजना कस्तो योजनाको भाग हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'शैक्षिक योजना र शैक्षणिक योजनाबिचको भिन्नताअनुसार शैक्षिक योजना कस्तो योजनाको भाग हो?', E'अल्पकालीन योजनाको भाग', E'दैनिक पाठयोजनाको भाग', E'साप्ताहिक तालिकाको भाग', E'दीर्घकालीन योजनाको भाग', E'D', E'**शैक्षिक योजना दीर्घकालीन योजनाको भाग हो, जबकि शैक्षणिक योजना शैक्षिक योजना पूरा गर्ने अल्पकालीन योजना हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शैक्षिक योजना र शैक्षणिक योजनाबिचको भिन्नताअनुसार शैक्षिक योजना कस्तो योजनाको भाग हो?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: वार्षिक कार्यतालिका र वार्षिक शैक्षणिक योजना (आधारभूत तह) (14 Q)
  v_set_id := extensions.uuid_generate_v5('4de2104d-650e-4026-9b3b-114ccbf9a759'::uuid, E'वार्षिक कार्यतालिका र वार्षिक शैक्षणिक योजना (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'acf58395-316c-4a70-b7b3-5470be568528'::uuid, '4de2104d-650e-4026-9b3b-114ccbf9a759'::uuid, E'वार्षिक कार्यतालिका र वार्षिक शैक्षणिक योजना (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '4de2104d-650e-4026-9b3b-114ccbf9a759'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वार्षिक कार्यतालिका (वार्षिक कार्यपात्रो) भनेको के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'वार्षिक कार्यतालिका (वार्षिक कार्यपात्रो) भनेको के हो?', E'कुनै एक शैक्षिक संस्थामा एक शैक्षिक सत्रभित्र गरिने सम्पूर्ण कार्यक्रमहरूको योजना', E'एक विषय शिक्षकले आफ्नो विषयको लागि बनाउने योजना', E'एक पिरियडका लागि बनाइने पाठ योजना', E'एउटा एकाइभित्रका पाठहरूको मात्र योजना', E'A', E'**वार्षिक कार्यतालिका भनेको कुनै एक शैक्षिक संस्थामा एक शैक्षिक सत्रभित्र गरिने सम्पूर्ण कार्यक्रमहरूको योजना हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वार्षिक कार्यतालिका (वार्षिक कार्यपात्रो) भनेको के हो?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वार्षिक कार्यतालिका सामान्यतया कसले निर्माण गर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'वार्षिक कार्यतालिका सामान्यतया कसले निर्माण गर्छ?', E'विद्यालय व्यवस्थापन समितिका अभिभावकले', E'प्रधानाध्यापकले शिक्षक तथा विद्यार्थीको सहयोग लिई', E'विषय शिक्षकले मात्र', E'शिक्षा तालिम केन्द्रले', E'B', E'**वार्षिक कार्यतालिका प्रधानाध्यापकले शिक्षक तथा विद्यार्थीहरूको सहयोग लिई निर्माण गर्छन्।**\\nनोट: यसैले विद्यालयको सम्पूर्ण गतिविधि समावेश गरेकाले यसलाई विद्यालयको ऐना पनि भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वार्षिक कार्यतालिका सामान्यतया कसले निर्माण गर्छ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यालयको सम्पूर्ण गतिविधि समावेश गरी बनाइने हुनाले कुन योजनालाई "विद्यालयको ऐना" पनि भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'विद्यालयको सम्पूर्ण गतिविधि समावेश गरी बनाइने हुनाले कुन योजनालाई "विद्यालयको ऐना" पनि भनिन्छ?', E'दैनिक पाठयोजना', E'वार्षिक शैक्षणिक योजना', E'वार्षिक कार्यतालिका', E'एकाइ योजना', E'C', E'**वार्षिक कार्यतालिकालाई विद्यालयको ऐना पनि भनिन्छ, किनभने यसले विद्यालयको सम्पूर्ण गतिविधि समावेश गर्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यालयको सम्पूर्ण गतिविधि समावेश गरी बनाइने हुनाले कुन योजनालाई "विद्यालयको ऐना" पनि भनिन्छ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वार्षिक कार्यतालिका/क्यालेण्डर बनाउँदा ध्यान दिनुपर्ने कुराहरूमध्ये निम्नमध्ये कुन पर्दैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'वार्षिक कार्यतालिका/क्यालेण्डर बनाउँदा ध्यान दिनुपर्ने कुराहरूमध्ये निम्नमध्ये कुन पर्दैन?', E'उपलब्ध स्रोतसाधनको समयमै पहिचान गरी निर्माण गर्ने', E'शैक्षिक सत्र सुरु हुनुअघि नै समयमै निर्माण गर्ने', E'विद्यालय शिक्षाको राष्ट्रिय पाठ्यक्रम र राष्ट्रिय उद्देश्यलाई ख्याल गर्ने', E'छिमेकी विद्यालयको तालिका जस्तै बनाउने', E'D', E'**"छिमेकी विद्यालयको तालिका जस्तै बनाउने" वार्षिक कार्यतालिका निर्माणमा ध्यान दिनुपर्ने कुरामा पर्दैन।**\\n- समयमै निर्माण गर्ने, स्रोतसाधन पहिचान गर्ने र राष्ट्रिय पाठ्यक्रम/उद्देश्य ख्याल गर्ने तीनवटै वास्तविक ध्यान दिनुपर्ने पक्षहरू हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वार्षिक कार्यतालिका/क्यालेण्डर बनाउँदा ध्यान दिनुपर्ने कुराहरूमध्ये निम्नमध्ये कुन पर्दैन?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वार्षिक शैक्षणिक योजना (वार्षिक पाठयोजना) भनेको के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'वार्षिक शैक्षणिक योजना (वार्षिक पाठयोजना) भनेको के हो?', E'विषय शिक्षकले आफूले अध्यापन गर्ने विषयको एक शैक्षिक वर्षभित्र गर्ने शिक्षण योजना', E'विद्यार्थीले तयार गर्ने अध्ययन तालिका', E'प्रधानाध्यापकले बनाउने विद्यालयको समग्र वार्षिक तालिका', E'विद्यालय व्यवस्थापन समितिको वार्षिक प्रतिवेदन', E'A', E'**वार्षिक शैक्षणिक योजना भनेको विषय शिक्षकले आफूले अध्यापन गर्ने विषयको एक शैक्षिक वर्षभित्र गर्ने शिक्षण योजना हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वार्षिक शैक्षणिक योजना (वार्षिक पाठयोजना) भनेको के हो?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वार्षिक कार्यतालिका र वार्षिक शैक्षणिक योजनाबिचको भिन्नताअनुसार वार्षिक कार्यतालिका कसले निर्माण गर्छ र वार्षिक शैक्षणिक योजना कसले निर्माण गर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'वार्षिक कार्यतालिका र वार्षिक शैक्षणिक योजनाबिचको भिन्नताअनुसार वार्षिक कार्यतालिका कसले निर्माण गर्छ र वार्षिक शैक्षणिक योजना कसले निर्माण गर्छ?', E'दुवै विद्यालय व्यवस्थापन समितिले', E'वार्षिक कार्यतालिका प्रधानाध्यापकले, वार्षिक शैक्षणिक योजना विषय शिक्षकले', E'दुवै प्रधानाध्यापकले', E'वार्षिक कार्यतालिका विषय शिक्षकले, वार्षिक शैक्षणिक योजना प्रधानाध्यापकले', E'B', E'**वार्षिक कार्यतालिका प्रधानाध्यापकले निर्माण गर्दछन् भने वार्षिक शैक्षणिक योजना विषय शिक्षकले निर्माण गर्दछन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वार्षिक कार्यतालिका र वार्षिक शैक्षणिक योजनाबिचको भिन्नताअनुसार वार्षिक कार्यतालिका कसले निर्माण गर्छ र वार्षिक शैक्षणिक योजना कसले निर्माण गर्छ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वार्षिक कार्यतालिका र वार्षिक शैक्षणिक योजनाबिचको भिन्नताअनुसार कुनमा शैक्षणिक र गैरशैक्षणिक दुवै प्रकृतिका क्रियाकलाप समावेश हुन्छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'वार्षिक कार्यतालिका र वार्षिक शैक्षणिक योजनाबिचको भिन्नताअनुसार कुनमा शैक्षणिक र गैरशैक्षणिक दुवै प्रकृतिका क्रियाकलाप समावेश हुन्छन्?', E'दुवैमा उस्तै हुन्छ', E'कुनैमा पनि हुँदैन', E'वार्षिक कार्यतालिकामा मात्र', E'वार्षिक शैक्षणिक योजनामा मात्र', E'C', E'**वार्षिक कार्यतालिकामा शैक्षणिक र गैरशैक्षणिक दुवै प्रकृतिका क्रियाकलाप समावेश हुन्छन्, जबकि वार्षिक शैक्षणिक योजनामा शैक्षणिक प्रकृतिका क्रियाकलाप मात्र समावेश हुन्छन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वार्षिक कार्यतालिका र वार्षिक शैक्षणिक योजनाबिचको भिन्नताअनुसार कुनमा शैक्षणिक र गैरशैक्षणिक दुवै प्रकृतिका क्रियाकलाप समावेश हुन्छन्?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वार्षिक कार्यतालिका र वार्षिक शैक्षणिक योजनाबिचको भिन्नताअनुसार शिक्षण विधि, शैक्षिक सामग्री, उद्देश्य र मूल्याङ्कनका तरिकाहरू कुनमा उल्लेख भएका हुन्छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'वार्षिक कार्यतालिका र वार्षिक शैक्षणिक योजनाबिचको भिन्नताअनुसार शिक्षण विधि, शैक्षिक सामग्री, उद्देश्य र मूल्याङ्कनका तरिकाहरू कुनमा उल्लेख भएका हुन्छन्?', E'वार्षिक कार्यतालिकामा', E'दुवैमा', E'कुनैमा पनि हुँदैन', E'वार्षिक शैक्षणिक योजनामा', E'D', E'**शिक्षण विधि, शैक्षिक सामग्री, उद्देश्य र मूल्याङ्कनका तरिकाहरू वार्षिक शैक्षणिक योजनामा उल्लेख हुन्छन्, वार्षिक कार्यतालिकामा भने यी उल्लेख हुँदैनन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वार्षिक कार्यतालिका र वार्षिक शैक्षणिक योजनाबिचको भिन्नताअनुसार शिक्षण विधि, शैक्षिक सामग्री, उद्देश्य र मूल्याङ्कनका तरिकाहरू कुनमा उल्लेख भएका हुन्छन्?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वार्षिक कार्यतालिका र वार्षिक शैक्षणिक योजनाबिचको भिन्नताअनुसार कुनमा शिक्षण सिकाइको विशिष्ट जानकारी हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'वार्षिक कार्यतालिका र वार्षिक शैक्षणिक योजनाबिचको भिन्नताअनुसार कुनमा शिक्षण सिकाइको विशिष्ट जानकारी हुन्छ?', E'वार्षिक शैक्षणिक योजनामा', E'एकाइ योजनामा मात्र', E'वार्षिक कार्यतालिकामा', E'दुवैमा उस्तै विशिष्ट जानकारी हुन्छ', E'A', E'**वार्षिक शैक्षणिक योजनामा शिक्षण सिकाइको विशिष्ट जानकारी हुन्छ, जबकि वार्षिक कार्यतालिकामा सामान्य जानकारी मात्र हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वार्षिक कार्यतालिका र वार्षिक शैक्षणिक योजनाबिचको भिन्नताअनुसार कुनमा शिक्षण सिकाइको विशिष्ट जानकारी हुन्छ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वार्षिक कार्यतालिका र वार्षिक शैक्षणिक योजनाबिचको भिन्नताअनुसार कुन बनाउन तुलनात्मक रूपमा गाह्रो र लामो समय लाग्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'वार्षिक कार्यतालिका र वार्षिक शैक्षणिक योजनाबिचको भिन्नताअनुसार कुन बनाउन तुलनात्मक रूपमा गाह्रो र लामो समय लाग्छ?', E'दुवै उस्तै समय लाग्छ', E'वार्षिक शैक्षणिक योजना', E'दुवै छिटो बन्छन्', E'वार्षिक कार्यतालिका', E'B', E'**वार्षिक शैक्षणिक योजना बनाउन तुलनात्मक रूपमा गाह्रो र लामो समय लाग्छ, जबकि वार्षिक कार्यतालिका बनाउन सजिलो र छोटो हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वार्षिक कार्यतालिका र वार्षिक शैक्षणिक योजनाबिचको भिन्नताअनुसार कुन बनाउन तुलनात्मक रूपमा गाह्रो र लामो समय लाग्छ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वार्षिक कार्यतालिका र वार्षिक शैक्षणिक योजनाबिचको भिन्नताअनुसार कुन कक्षाकोठाको शिक्षण सिकाइ क्रियाकलापसँग सम्बन्धित हुँदैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'वार्षिक कार्यतालिका र वार्षिक शैक्षणिक योजनाबिचको भिन्नताअनुसार कुन कक्षाकोठाको शिक्षण सिकाइ क्रियाकलापसँग सम्बन्धित हुँदैन?', E'दैनिक पाठयोजना', E'वार्षिक शैक्षणिक योजना', E'वार्षिक कार्यतालिका', E'एकाइ योजना', E'C', E'**वार्षिक कार्यतालिका कक्षाकोठाको शिक्षण सिकाइ क्रियाकलापसँग सम्बन्धित हुँदैन, जबकि वार्षिक शैक्षणिक योजना यससँग सम्बन्धित हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वार्षिक कार्यतालिका र वार्षिक शैक्षणिक योजनाबिचको भिन्नताअनुसार कुन कक्षाकोठाको शिक्षण सिकाइ क्रियाकलापसँग सम्बन्धित हुँदैन?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वार्षिक कार्यतालिका र वार्षिक शैक्षणिक योजनाबिचको भिन्नताअनुसार कुनले दैनिक पाठयोजना निर्माणका लागि आधार प्रदान गर्दैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'वार्षिक कार्यतालिका र वार्षिक शैक्षणिक योजनाबिचको भिन्नताअनुसार कुनले दैनिक पाठयोजना निर्माणका लागि आधार प्रदान गर्दैन?', E'दुवैले आधार प्रदान गर्छन्', E'वार्षिक शैक्षणिक योजना', E'एकाइ योजना', E'वार्षिक कार्यतालिका', E'D', E'**वार्षिक कार्यतालिकाले दैनिक पाठयोजना निर्माणका लागि कुनै आधार प्रदान गर्दैन, जबकि वार्षिक शैक्षणिक योजनाले आधार प्रदान गर्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वार्षिक कार्यतालिका र वार्षिक शैक्षणिक योजनाबिचको भिन्नताअनुसार कुनले दैनिक पाठयोजना निर्माणका लागि आधार प्रदान गर्दैन?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वार्षिक शैक्षणिक योजना निर्माण गर्दा वार्षिक कार्यतालिकाबाहेक अरू के-के कुराको अध्ययन गर्नुपर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'वार्षिक शैक्षणिक योजना निर्माण गर्दा वार्षिक कार्यतालिकाबाहेक अरू के-के कुराको अध्ययन गर्नुपर्छ?', E'आफूले शिक्षण गर्ने विषयको पाठ्यक्रम, पाठ्यपुस्तक, शिक्षक निर्देशिका र विशिष्टीकरण तालिका', E'अन्य विद्यालयको भवन नक्सा', E'छिमेकी विद्यालयको वार्षिक बजेट', E'विद्यार्थीको जन्मदर्ता प्रमाणपत्र', E'A', E'**वार्षिक शैक्षणिक योजना निर्माण गर्दा आफूले शिक्षण गर्ने विषयको पाठ्यक्रम, पाठ्यपुस्तक, शिक्षक निर्देशिका र विशिष्टीकरण तालिकाको अध्ययन गर्नुपर्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वार्षिक शैक्षणिक योजना निर्माण गर्दा वार्षिक कार्यतालिकाबाहेक अरू के-के कुराको अध्ययन गर्नुपर्छ?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वार्षिक शैक्षणिक योजनाको फाइदा/महत्त्वअन्तर्गत निम्नमध्ये कुन पर्दैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'वार्षिक शैक्षणिक योजनाको फाइदा/महत्त्वअन्तर्गत निम्नमध्ये कुन पर्दैन?', E'शिक्षकलाई एकाइ योजना र दैनिक पाठयोजना बनाउन सहयोग मिल्नु', E'विद्यालयको भौतिक भवन निर्माण सजिलो हुनु', E'पाठ्यक्रमले निर्धारण गरेको सक्षमता वा सिकाइ उपलब्धि हासिल हुन सहयोग हुनु', E'शिक्षण सिकाइ क्रियाकलाप सुव्यवस्थित र योजनाबद्ध हुनु', E'B', E'**"विद्यालयको भौतिक भवन निर्माण सजिलो हुनु" वार्षिक शैक्षणिक योजनाको फाइदा/महत्त्वअन्तर्गत पर्दैन।**\\n- सक्षमता हासिल हुन सहयोग, एकाइ/दैनिक योजना बनाउन सहयोग र क्रियाकलाप सुव्यवस्थित हुनु तीनवटै वास्तविक फाइदा हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वार्षिक शैक्षणिक योजनाको फाइदा/महत्त्वअन्तर्गत निम्नमध्ये कुन पर्दैन?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: एकाइ योजना र दैनिक पाठयोजना (आधारभूत तह) (16 Q)
  v_set_id := extensions.uuid_generate_v5('4de2104d-650e-4026-9b3b-114ccbf9a759'::uuid, E'एकाइ योजना र दैनिक पाठयोजना (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'acf58395-316c-4a70-b7b3-5470be568528'::uuid, '4de2104d-650e-4026-9b3b-114ccbf9a759'::uuid, E'एकाइ योजना र दैनिक पाठयोजना (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '4de2104d-650e-4026-9b3b-114ccbf9a759'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'एकाइ योजना भनेको के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'एकाइ योजना भनेको के हो?', E'एक पिरियडका लागि बनाइने पाठ योजना', E'प्रधानाध्यापकले बनाउने विद्यालयको समग्र तालिका', E'वार्षिक शैक्षणिक योजनाको आधारमा शिक्षण सिकाइका पाठका एकाइहरूको विस्तृत योजना', E'विद्यालयको वार्षिक बजेट योजना', E'C', E'**एकाइ योजना भनेको वार्षिक शैक्षणिक योजनाको आधारमा शिक्षण सिकाइका पाठका एकाइहरूको विस्तृत योजना हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:एकाइ योजना भनेको के हो?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'एकाइ योजना पाठयोजनाको तुलनामा कस्तो हुन्छ र वार्षिक शैक्षणिक योजनाको तुलनामा कस्तो हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'एकाइ योजना पाठयोजनाको तुलनामा कस्तो हुन्छ र वार्षिक शैक्षणिक योजनाको तुलनामा कस्तो हुन्छ?', E'दुवैभन्दा सूक्ष्म', E'पाठयोजनाभन्दा सूक्ष्म र वार्षिक शैक्षणिक योजनाभन्दा वृहत', E'दुवैभन्दा वृहत', E'पाठयोजनाभन्दा वृहत र वार्षिक शैक्षणिक योजनाभन्दा सूक्ष्म', E'D', E'**एकाइ योजना पाठयोजनाभन्दा वृहत र वार्षिक शैक्षणिक योजनाभन्दा सूक्ष्म रूप हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:एकाइ योजना पाठयोजनाको तुलनामा कस्तो हुन्छ र वार्षिक शैक्षणिक योजनाको तुलनामा कस्तो हुन्छ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वार्षिक कार्य योजना र एकाइ योजनाबिचको भिन्नताअनुसार एकाइ योजना पुनः कहिले बनाउनुपर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'वार्षिक कार्य योजना र एकाइ योजनाबिचको भिन्नताअनुसार एकाइ योजना पुनः कहिले बनाउनुपर्छ?', E'कोर्स परिवर्तन नभएसम्म फेरि बनाउनुपर्दैन', E'हरेक पिरियडपछि', E'हरेक महिना', E'हरेक वर्ष अनिवार्य रूपमा', E'A', E'**एकाइ योजना एकपटक बनाइसकेपछि कोर्स परिवर्तन नभएसम्म फेरि अर्को बनाउनुपर्दैन, जबकि वार्षिक कार्य योजना भने हरेक वर्ष बनाउनुपर्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वार्षिक कार्य योजना र एकाइ योजनाबिचको भिन्नताअनुसार एकाइ योजना पुनः कहिले बनाउनुपर्छ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वार्षिक कार्य योजना र एकाइ योजनाबिचको भिन्नताअनुसार एकाइ योजना सामान्यतया कसले निर्माण गर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'वार्षिक कार्य योजना र एकाइ योजनाबिचको भिन्नताअनुसार एकाइ योजना सामान्यतया कसले निर्माण गर्छ?', E'विद्यार्थीहरूले', E'विशेषज्ञहरूको समूहले', E'विद्यालय व्यवस्थापन समितिले', E'प्रधानाध्यापकले', E'B', E'**एकाइ योजना विशेषज्ञहरूको समूहले निर्माण गर्दछ, जबकि वार्षिक कार्य योजना प्रधानाध्यापकले निर्माण गर्दछन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वार्षिक कार्य योजना र एकाइ योजनाबिचको भिन्नताअनुसार एकाइ योजना सामान्यतया कसले निर्माण गर्छ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वार्षिक कार्य योजना र एकाइ योजनाबिचको भिन्नताअनुसार कुनमा मिति, अवधि र पिरियड जस्ता कुरा तोकिएको हुँदैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'वार्षिक कार्य योजना र एकाइ योजनाबिचको भिन्नताअनुसार कुनमा मिति, अवधि र पिरियड जस्ता कुरा तोकिएको हुँदैन?', E'दुवैमा तोकिएको हुन्छ', E'दैनिक पाठयोजनामा', E'एकाइ योजनामा', E'वार्षिक कार्य योजनामा', E'C', E'**एकाइ योजनामा मिति, अवधि र पिरियड जस्ता कुराहरू तोकिएको हुँदैन, जबकि वार्षिक कार्य योजनामा यी तोकिएको हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वार्षिक कार्य योजना र एकाइ योजनाबिचको भिन्नताअनुसार कुनमा मिति, अवधि र पिरियड जस्ता कुरा तोकिएको हुँदैन?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वार्षिक कार्य योजना र एकाइ योजनाबिचको भिन्नताअनुसार कुन बनाउन कठिन, लामो र विस्तृत हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'वार्षिक कार्य योजना र एकाइ योजनाबिचको भिन्नताअनुसार कुन बनाउन कठिन, लामो र विस्तृत हुन्छ?', E'वार्षिक कार्यतालिका', E'वार्षिक कार्य योजना', E'दुवै उस्तै सजिलो हुन्छन्', E'एकाइ योजना', E'D', E'**एकाइ योजना बनाउन कठिन, लामो र विस्तृत हुन्छ, जबकि वार्षिक कार्य योजना बनाउन सजिलो र छोटो हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वार्षिक कार्य योजना र एकाइ योजनाबिचको भिन्नताअनुसार कुन बनाउन कठिन, लामो र विस्तृत हुन्छ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वार्षिक कार्य योजना र एकाइ योजनाबिचको भिन्नताअनुसार कुनले कक्षाकोठाको शिक्षण सिकाइ क्रियाकलापलाई बढी आकर्षक, रोचक र प्रभावकारी बनाउने तर्फ निर्देशित गर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'वार्षिक कार्य योजना र एकाइ योजनाबिचको भिन्नताअनुसार कुनले कक्षाकोठाको शिक्षण सिकाइ क्रियाकलापलाई बढी आकर्षक, रोचक र प्रभावकारी बनाउने तर्फ निर्देशित गर्छ?', E'एकाइ योजनाले', E'वार्षिक कार्य योजनाले', E'वार्षिक कार्यतालिकाले', E'कुनैले पनि गर्दैन', E'A', E'**एकाइ योजनाले कक्षाकोठाको शिक्षण सिकाइ क्रियाकलापलाई बढी आकर्षक, रोचक र प्रभावकारी बनाउनेतर्फ निर्देशित हुन्छ, जबकि वार्षिक कार्य योजना कक्षाकोठाको शिक्षण सिकाइसँग सम्बन्धित हुँदैन।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वार्षिक कार्य योजना र एकाइ योजनाबिचको भिन्नताअनुसार कुनले कक्षाकोठाको शिक्षण सिकाइ क्रियाकलापलाई बढी आकर्षक, रोचक र प्रभावकारी बनाउने तर्फ निर्देशित गर्छ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'एकाइ योजनाको महत्त्व/फाइदाअन्तर्गत निम्नमध्ये कुन पर्दैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'एकाइ योजनाको महत्त्व/फाइदाअन्तर्गत निम्नमध्ये कुन पर्दैन?', E'कमजोर विद्यार्थीलाई पृष्ठपोषण दिई उपचारात्मक शिक्षण गर्न सघाउनु', E'विद्यालयको भवन मर्मत गर्न सघाउनु', E'उपयुक्त शिक्षण सामग्री, विधि र मूल्याङ्कन प्रक्रिया छनोट गर्न सघाउनु', E'शिक्षकलाई उपयुक्त मार्गनिर्देशन दिई आत्मविश्वास बढाउनु', E'B', E'**"विद्यालयको भवन मर्मत गर्न सघाउनु" एकाइ योजनाको महत्त्व/फाइदाअन्तर्गत पर्दैन।**\\n- मार्गनिर्देशन/आत्मविश्वास, सामग्री-विधि-मूल्याङ्कन छनोट र कमजोर विद्यार्थीलाई उपचारात्मक शिक्षण तीनवटै एकाइ योजनाका वास्तविक फाइदा हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:एकाइ योजनाको महत्त्व/फाइदाअन्तर्गत निम्नमध्ये कुन पर्दैन?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दैनिक पाठयोजना भनेको के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'दैनिक पाठयोजना भनेको के हो?', E'वर्षभरिका लागि बनाइने विद्यालयको समग्र तालिका', E'विद्यालयको भौतिक पूर्वाधार योजना', E'नियमित अध्यापन कार्यलाई प्रभावकारी बनाउन प्रत्येक पाठ अध्यापनको पूर्वतयारीको लिखित रूप', E'विद्यार्थीको वार्षिक परीक्षा तालिका', E'C', E'**दैनिक पाठयोजना भनेको नियमित अध्यापन कार्यलाई प्रभावकारी बनाउन प्रत्येक पाठ अध्यापनको पूर्वतयारीको लिखित रूप हो।**\\nनोट: यो एकाइ योजनामा आधारित हुन्छ र विषय शिक्षकद्वारा दैनिक निर्माण गरिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दैनिक पाठयोजना भनेको के हो?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दैनिक पाठयोजना निर्माणका लागि आधार लिइने कुराहरूमध्ये निम्नमध्ये कुन पर्दैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'दैनिक पाठयोजना निर्माणका लागि आधार लिइने कुराहरूमध्ये निम्नमध्ये कुन पर्दैन?', E'पाठ्यक्रम', E'शिक्षक निर्देशिका', E'पाठ्यपुस्तक', E'विद्यार्थीको जन्म प्रमाणपत्र', E'D', E'**"विद्यार्थीको जन्म प्रमाणपत्र" दैनिक पाठयोजना निर्माणको आधार होइन।**\\n- पाठ्यक्रम, पाठ्यपुस्तक र शिक्षक निर्देशिका तीनवटै दैनिक पाठयोजना निर्माणका वास्तविक आधार हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दैनिक पाठयोजना निर्माणका लागि आधार लिइने कुराहरूमध्ये निम्नमध्ये कुन पर्दैन?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दैनिक पाठयोजनाको पहिलो तथा सबैभन्दा महत्त्वपूर्ण अङ्ग कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'दैनिक पाठयोजनाको पहिलो तथा सबैभन्दा महत्त्वपूर्ण अङ्ग कुन हो?', E'विशिष्ट उद्देश्य (Specific Objectives)', E'मूल्याङ्कन', E'गृहकार्य (Homework)', E'शैक्षिक सामग्री', E'A', E'**दैनिक पाठयोजनाको पहिलो तथा सबैभन्दा महत्त्वपूर्ण अङ्ग विशिष्ट उद्देश्य (Specific Objectives) हो।**\\nनोट: गृहकार्य (Homework) दैनिक पाठयोजनाको अन्तिम एवम् तुलनात्मक रूपमा नगण्य अङ्ग मानिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दैनिक पाठयोजनाको पहिलो तथा सबैभन्दा महत्त्वपूर्ण अङ्ग कुन हो?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दैनिक पाठयोजनाको विशिष्ट उद्देश्य SMART हुनुपर्छ भनिन्छ, जहाँ "A" ले केलाई जनाउँछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'दैनिक पाठयोजनाको विशिष्ट उद्देश्य SMART हुनुपर्छ भनिन्छ, जहाँ "A" ले केलाई जनाउँछ?', E'Analytical', E'Achievable', E'Applicable', E'Attractive', E'B', E'**SMART मा "A" ले Achievable (प्राप्त गर्न सकिने) जनाउँछ।**\\nनोट: SMART को पूर्ण रूप हो — Specific, Measurable, Achievable, Reliable, Time-bonded।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दैनिक पाठयोजनाको विशिष्ट उद्देश्य SMART हुनुपर्छ भनिन्छ, जहाँ "A" ले केलाई जनाउँछ?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विशिष्ट उद्देश्य लेख्दा निम्नमध्ये कुन क्रियापद प्रयोग गर्नु हुँदैन भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'विशिष्ट उद्देश्य लेख्दा निम्नमध्ये कुन क्रियापद प्रयोग गर्नु हुँदैन भनिन्छ?', E'पहिचान गर्नेछन्', E'व्याख्या गर्नेछन्', E'जान्नेछन्, बुझ्नेछन्', E'सूचीकरण गर्नेछन्', E'C', E'**विशिष्ट उद्देश्य लेख्दा "जान्नेछन्", "बुझ्नेछन्", "थाहा पाउनेछन्" जस्ता बहुअर्थी र अनिश्चित क्रियापदहरू प्रयोग गर्नु हुँदैन।**\\nनोट: पहिचान गर्ने, व्याख्या गर्ने र सूचीकरण गर्ने जस्ता नापिन सक्ने (Measurable) क्रियापद प्रयोग गर्नुपर्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विशिष्ट उद्देश्य लेख्दा निम्नमध्ये कुन क्रियापद प्रयोग गर्नु हुँदैन भनिन्छ?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दैनिक पाठयोजनाका अङ्गहरूमध्ये शिक्षण सिकाइ क्रियाकलाप कस्तो हुनुपर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'दैनिक पाठयोजनाका अङ्गहरूमध्ये शिक्षण सिकाइ क्रियाकलाप कस्तो हुनुपर्छ?', E'पाठ्यपुस्तक केन्द्रित', E'शिक्षक केन्द्रित', E'परीक्षा केन्द्रित', E'विद्यार्थी केन्द्रित', E'D', E'**दैनिक पाठयोजनाका अङ्गहरूमध्ये शिक्षण सिकाइ क्रियाकलाप विद्यार्थी केन्द्रित हुनुपर्दछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दैनिक पाठयोजनाका अङ्गहरूमध्ये शिक्षण सिकाइ क्रियाकलाप कस्तो हुनुपर्छ?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दैनिक पाठयोजना निर्माण गर्नुपूर्व शिक्षकहरूमा हुनुपर्ने ज्ञानअन्तर्गत निम्नमध्ये कुन पर्दैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'दैनिक पाठयोजना निर्माण गर्नुपूर्व शिक्षकहरूमा हुनुपर्ने ज्ञानअन्तर्गत निम्नमध्ये कुन पर्दैन?', E'विद्यालयको वार्षिक बजेट लेखा राख्ने सीप', E'व्यावहारिक उद्देश्य निर्माण गर्न सक्ने सीप', E'पाठ्यवस्तुको विस्तृत र स्पष्ट ज्ञान', E'स्थानीयस्तरमा पाइने कम/विनामूल्यका सिकाइ सामग्री छनोट-निर्माण गर्ने सीप', E'A', E'**"विद्यालयको वार्षिक बजेट लेखा राख्ने सीप" दैनिक पाठयोजना निर्माणपूर्व शिक्षकमा हुनुपर्ने ज्ञानअन्तर्गत पर्दैन।**\\n- पाठ्यवस्तुको ज्ञान, व्यावहारिक उद्देश्य निर्माण सीप र स्थानीय सिकाइ सामग्री प्रयोग सीप तीनवटै वास्तविक आवश्यक ज्ञान हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दैनिक पाठयोजना निर्माण गर्नुपूर्व शिक्षकहरूमा हुनुपर्ने ज्ञानअन्तर्गत निम्नमध्ये कुन पर्दैन?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दैनिक पाठयोजनाका अङ्गहरूमध्ये "शैक्षिक सामग्री" ले के जनाउँछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'दैनिक पाठयोजनाका अङ्गहरूमध्ये "शैक्षिक सामग्री" ले के जनाउँछ?', E'शिक्षकको व्यक्तिगत डायरी', E'कक्षामा शिक्षण गर्दा प्रयोग गरिने सम्पूर्ण सामग्री', E'प्रधानाध्यापकको वार्षिक प्रतिवेदन', E'विद्यार्थीले घरमा गर्ने कार्य', E'B', E'**शैक्षिक सामग्री (Materials) ले कक्षामा शिक्षण गर्दा प्रयोग गरिने सम्पूर्ण सामग्री जनाउँछ, जसले पाठलाई सरल, सहज र प्रभावकारी बनाउँछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दैनिक पाठयोजनाका अङ्गहरूमध्ये "शैक्षिक सामग्री" ले के जनाउँछ?'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: व्याख्यान, आगमन र निगमन शिक्षण विधि (आधारभूत तह) (15 Q)
  v_set_id := extensions.uuid_generate_v5('335cbffc-fbb1-4ea9-b0d7-ee0cfd62160d'::uuid, E'व्याख्यान, आगमन र निगमन शिक्षण विधि (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'acf58395-316c-4a70-b7b3-5470be568528'::uuid, '335cbffc-fbb1-4ea9-b0d7-ee0cfd62160d'::uuid, E'व्याख्यान, आगमन र निगमन शिक्षण विधि (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '335cbffc-fbb1-4ea9-b0d7-ee0cfd62160d'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'व्याख्यान विधिलाई अन्य कुन नामले पनि चिनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'व्याख्यान विधिलाई अन्य कुन नामले पनि चिनिन्छ?', E'सर्वेक्षण विधि वा अवलोकन विधि', E'आगमन विधि वा निगमन विधि', E'भाषण विधि वा प्रवचन विधि', E'प्रश्नोत्तर विधि वा सोक्रेटिक विधि', E'C', E'**व्याख्यान विधिलाई भाषण विधि वा प्रवचन विधि पनि भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:व्याख्यान विधिलाई अन्य कुन नामले पनि चिनिन्छ?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'व्याख्यान विधिलाई शिक्षक-केन्द्रित विधि किन भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'व्याख्यान विधिलाई शिक्षक-केन्द्रित विधि किन भनिन्छ?', E'यसमा विद्यार्थी बढी सक्रिय हुने भएकाले', E'यसमा शैक्षिक सामग्री प्रयोग नहुने भएकाले', E'यसमा प्रश्नोत्तर मात्र हुने भएकाले', E'यसमा शिक्षक बढी सक्रिय हुने भएकाले', E'D', E'**व्याख्यान विधिमा शिक्षक बढी सक्रिय हुने भएकाले यस विधिलाई शिक्षक-केन्द्रित विधि भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:व्याख्यान विधिलाई शिक्षक-केन्द्रित विधि किन भनिन्छ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'व्याख्यान विधिका विशेषताअन्तर्गत निम्नमध्ये कुन पर्दैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'व्याख्यान विधिका विशेषताअन्तर्गत निम्नमध्ये कुन पर्दैन?', E'साना विद्यार्थीहरूका लागि सर्वाधिक उपयुक्त', E'बढी विद्यार्थी सङ्ख्या भएको कक्षामा उपयोगी', E'स्रोत, साधन र समयको किफायत गर्न उपयोगी', E'सबैभन्दा पुरानो र परम्परागत विधि', E'A', E'**"साना विद्यार्थीहरूका लागि सर्वाधिक उपयुक्त" व्याख्यान विधिको विशेषता होइन।**\\n- व्याख्यान विधि साना विद्यार्थीहरूका लागि अनुपयुक्त मानिन्छ र माथिल्लो तहका कक्षाहरूमा बढी उपयोगी हुन्छ।\\n- सबैभन्दा पुरानो/परम्परागत हुनु, धेरै विद्यार्थी भएको कक्षामा उपयोगी हुनु र स्रोत-साधन-समयको किफायत गर्नु तीनवटै व्याख्यान विधिका वास्तविक विशेषता हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:व्याख्यान विधिका विशेषताअन्तर्गत निम्नमध्ये कुन पर्दैन?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'व्याख्यान विधिमा विद्यार्थीको भूमिका कस्तो हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'व्याख्यान विधिमा विद्यार्थीको भूमिका कस्तो हुन्छ?', E'मनोसक्रिय स्रोता', E'मनोनिष्क्रिय स्रोता', E'स्वतन्त्र अनुसन्धानकर्ता', E'समूह-नेता', E'B', E'**व्याख्यान विधिमा विद्यार्थी मनोनिष्क्रिय स्रोताका रूपमा रहन्छन्, जुन यस विधिको एउटा सीमा पनि मानिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:व्याख्यान विधिमा विद्यार्थीको भूमिका कस्तो हुन्छ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'आगमन विधिका प्रतिपादक को हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'आगमन विधिका प्रतिपादक को हुन्?', E'सुकरात', E'सिम्पसन', E'फ्रान्सिस बेकन', E'कुर्ट लेविन', E'C', E'**आगमन विधिका प्रतिपादक फ्रान्सिस बेकन हुन्।**\\n- सुकरातले प्रश्नोत्तर (सोक्रेटिक) विधिको प्रतिपादन गरेका हुन्।\\n- सिम्पसन अवलोकन विधिसँग सम्बन्धित छन्।\\n- कुर्ट लेविन कार्यमूलक अनुसन्धानका प्रवर्तक हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:आगमन विधिका प्रतिपादक को हुन्?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'आगमन विधि (Inductive Method) मा शिक्षण कसरी गरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'आगमन विधि (Inductive Method) मा शिक्षण कसरी गरिन्छ?', E'मूल्याङ्कनबाट योजनातर्फ', E'परीक्षाबाट पाठ्यक्रमतर्फ', E'सिद्धान्तबाट उदाहरणतर्फ', E'उदाहरणबाट सिद्धान्ततर्फ', E'D', E'**आगमन विधिमा उदाहरणबाट सिद्धान्ततर्फ शिक्षण गरिन्छ — जस्तै धेरै उदाहरण दिएर अन्त्यमा साझा सिद्धान्त निकालिन्छ।**\\nनोट: निगमन विधिमा यसको ठीक उल्टो, सिद्धान्तबाट उदाहरणतर्फ शिक्षण गरिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:आगमन विधि (Inductive Method) मा शिक्षण कसरी गरिन्छ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'आगमन र निगमन विधिबिचको भिन्नताअनुसार कुन विधि विद्यार्थी-केन्द्रित मानिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'आगमन र निगमन विधिबिचको भिन्नताअनुसार कुन विधि विद्यार्थी-केन्द्रित मानिन्छ?', E'आगमन विधि', E'व्याख्यान विधि', E'दुवै शिक्षक-केन्द्रित हुन्छन्', E'निगमन विधि', E'A', E'**आगमन विधि विद्यार्थी-केन्द्रित मानिन्छ, जबकि निगमन विधि शिक्षक-केन्द्रित मानिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:आगमन र निगमन विधिबिचको भिन्नताअनुसार कुन विधि विद्यार्थी-केन्द्रित मानिन्छ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'आगमन र निगमन विधिबिचको भिन्नताअनुसार कुन विधिले नयाँ सिद्धान्त र नियमको प्रतिपादन गर्छ र कुनले प्रतिपादित नियमको परीक्षण गर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'आगमन र निगमन विधिबिचको भिन्नताअनुसार कुन विधिले नयाँ सिद्धान्त र नियमको प्रतिपादन गर्छ र कुनले प्रतिपादित नियमको परीक्षण गर्छ?', E'निगमनले प्रतिपादन गर्छ, आगमनले परीक्षण गर्छ', E'आगमनले प्रतिपादन गर्छ, निगमनले परीक्षण गर्छ', E'दुवैले प्रतिपादन मात्र गर्छन्', E'दुवैले परीक्षण मात्र गर्छन्', E'B', E'**आगमन विधिले नयाँ सिद्धान्त र नियमको प्रतिपादन गर्छ, जबकि निगमन विधिले प्रतिपादित नियम र सिद्धान्तको परीक्षण गर्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:आगमन र निगमन विधिबिचको भिन्नताअनुसार कुन विधिले नयाँ सिद्धान्त र नियमको प्रतिपादन गर्छ र कुनले प्रतिपादित नियमको परीक्षण गर्छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'आगमन र निगमन विधिबिचको भिन्नताअनुसार कुन विधिले विद्यार्थीमा कण्ठ गरेर सिक्ने बानीलाई निरुत्साहित गर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'आगमन र निगमन विधिबिचको भिन्नताअनुसार कुन विधिले विद्यार्थीमा कण्ठ गरेर सिक्ने बानीलाई निरुत्साहित गर्छ?', E'निगमन विधिले', E'व्याख्यान विधिले', E'आगमन विधिले', E'प्रश्नोत्तर विधिले', E'C', E'**आगमन विधिले तर्क, वास्तविक अवलोकन र प्रयोगमा आधारित भएकाले कण्ठ गरेर सिक्ने बानीलाई निरुत्साहित गर्छ।**\\nनोट: निगमन विधि भने सूत्र, नियम र तथ्य घोकाउन सहयोगी मानिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:आगमन र निगमन विधिबिचको भिन्नताअनुसार कुन विधिले विद्यार्थीमा कण्ठ गरेर सिक्ने बानीलाई निरुत्साहित गर्छ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'निगमन विधि (Deductive Method) विज्ञान शिक्षणमा उपयोगी मानिए तापनि यसलाई सामान्यतया के भनी आलोचना गरिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'निगमन विधि (Deductive Method) विज्ञान शिक्षणमा उपयोगी मानिए तापनि यसलाई सामान्यतया के भनी आलोचना गरिन्छ?', E'समय नलाग्ने', E'अत्यधिक खर्चिलो', E'साना कक्षाका लागि मात्र उपयुक्त', E'अवैज्ञानिक', E'D', E'**निगमन विधिलाई अवैज्ञानिक भनी आलोचना गरिन्छ, किनभने यसले सूत्र-नियम घोकाउनमा जोड दिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:निगमन विधि (Deductive Method) विज्ञान शिक्षणमा उपयोगी मानिए तापनि यसलाई सामान्यतया के भनी आलोचना गरिन्छ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'उदाहरण, स्पष्टीकरण, नियमीकरण र अभ्यासका चरणहरू पूरा गर्नुपर्ने भएकाले जटिल मानिने विधि कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'उदाहरण, स्पष्टीकरण, नियमीकरण र अभ्यासका चरणहरू पूरा गर्नुपर्ने भएकाले जटिल मानिने विधि कुन हो?', E'आगमन विधि', E'सर्वेक्षण विधि', E'व्याख्यान विधि', E'प्रश्नोत्तर विधि', E'A', E'**आगमन विधिलाई उदाहरण, स्पष्टीकरण, नियमीकरण र अभ्यासका चरणहरू पूरा गर्नुपर्ने भएकाले जटिल मानिन्छ, र त्यसैले यो सानो कक्षामा प्रयोग गर्न सकिँदैन।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:उदाहरण, स्पष्टीकरण, नियमीकरण र अभ्यासका चरणहरू पूरा गर्नुपर्ने भएकाले जटिल मानिने विधि कुन हो?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'प्रश्नोत्तर विधिका प्रतिपादक को हुन्, जसका कारण यसलाई सोक्रेटिक विधि पनि भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'प्रश्नोत्तर विधिका प्रतिपादक को हुन्, जसका कारण यसलाई सोक्रेटिक विधि पनि भनिन्छ?', E'जोन डिवी', E'सुकरात', E'सिम्पसन', E'फ्रान्सिस बेकन', E'B', E'**प्रश्नोत्तर विधिका प्रतिपादक सुकरात हुन्, जसका कारण यसलाई सोक्रेटिक विधि पनि भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:प्रश्नोत्तर विधिका प्रतिपादक को हुन्, जसका कारण यसलाई सोक्रेटिक विधि पनि भनिन्छ?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'प्रश्नोत्तर विधिको बेफाइदाअन्तर्गत निम्नमध्ये कुन पर्दैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'प्रश्नोत्तर विधिको बेफाइदाअन्तर्गत निम्नमध्ये कुन पर्दैन?', E'कक्षा अनियन्त्रित हुन सक्ने', E'कम बोल्ने विद्यार्थीलाई अनुपयोगी', E'विद्यार्थीको पूर्वज्ञान पत्ता लगाउन असक्षम', E'तल्ला कक्षाका लागि अनुपयोगी', E'C', E'**"विद्यार्थीको पूर्वज्ञान पत्ता लगाउन असक्षम" प्रश्नोत्तर विधिको बेफाइदा होइन।**\\n- यो विधि त पूर्वज्ञानको जानकारी लिन नै प्रयोग गरिन्छ, जुन यसको फाइदा हो।\\n- तल्ला कक्षाका लागि अनुपयोगी हुनु, कम बोल्ने विद्यार्थीलाई अनुपयोगी हुनु र कक्षा अनियन्त्रित हुन सक्नु तीनवटै यसका वास्तविक बेफाइदा हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:प्रश्नोत्तर विधिको बेफाइदाअन्तर्गत निम्नमध्ये कुन पर्दैन?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'APPLE Technique मा दोस्रो "P" ले केलाई जनाउँछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'APPLE Technique मा दोस्रो "P" ले केलाई जनाउँछ?', E'Pause for a while', E'Present the lesson', E'Provide feedback', E'Pick up student', E'D', E'**APPLE Technique मा दोस्रो "P" ले Pick up student (विद्यार्थी छान्नु) जनाउँछ।**\\nनोट: पूर्ण रूप — A: Ask question in group, P: Pause for a while, P: Pick up student, L: Listen carefully, E: Evaluation and feedback।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:APPLE Technique मा दोस्रो "P" ले केलाई जनाउँछ?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'आगमन र निगमन विधिबिचको भिन्नताअनुसार कुन विधि सबै अवस्थामा प्रयोग गर्न सकिने मानिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'आगमन र निगमन विधिबिचको भिन्नताअनुसार कुन विधि सबै अवस्थामा प्रयोग गर्न सकिने मानिन्छ?', E'निगमन विधि', E'आगमन विधि', E'अवलोकन विधि', E'सर्वेक्षण विधि', E'A', E'**निगमन विधि सबै अवस्थामा प्रयोग गर्न सकिने मानिन्छ, जबकि आगमन विधि तर्क र वास्तविक अवलोकनमा आधारित भई अलि जटिल हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:आगमन र निगमन विधिबिचको भिन्नताअनुसार कुन विधि सबै अवस्थामा प्रयोग गर्न सकिने मानिन्छ?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: समस्या समाधान, सर्वेक्षण, अवलोकन र बहुकक्षा शिक्षण विधि (आधारभूत तह) (10 Q)
  v_set_id := extensions.uuid_generate_v5('335cbffc-fbb1-4ea9-b0d7-ee0cfd62160d'::uuid, E'समस्या समाधान, सर्वेक्षण, अवलोकन र बहुकक्षा शिक्षण विधि (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'acf58395-316c-4a70-b7b3-5470be568528'::uuid, '335cbffc-fbb1-4ea9-b0d7-ee0cfd62160d'::uuid, E'समस्या समाधान, सर्वेक्षण, अवलोकन र बहुकक्षा शिक्षण विधि (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '335cbffc-fbb1-4ea9-b0d7-ee0cfd62160d'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समस्या समाधान विधिले विद्यार्थीहरूमा कस्तो सीपको विकास गर्दछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'समस्या समाधान विधिले विद्यार्थीहरूमा कस्तो सीपको विकास गर्दछ?', E'शिक्षकको भाषण सुन्ने बानी मात्र', E'तर्कपूर्ण विचारद्वारा आइपरेका समस्या समाधान गर्ने सीप', E'परीक्षामा नक्कल गर्ने प्रवृत्ति', E'कण्ठ गरेर सिक्ने बानी', E'B', E'**समस्या समाधान विधिले विद्यार्थीहरूमा तर्कपूर्ण विचारद्वारा आइपरेका समस्याहरूलाई समाधान गर्ने सीपको विकास गर्दछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समस्या समाधान विधिले विद्यार्थीहरूमा कस्तो सीपको विकास गर्दछ?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'समस्या समाधान विधिले विद्यार्थीहरूमा के जागृत गराउँछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'समस्या समाधान विधिले विद्यार्थीहरूमा के जागृत गराउँछ?', E'प्रतिस्पर्धाविरोधी भावना', E'उदासीनताको भावना', E'आत्मविश्वासको भावना', E'परनिर्भरताको भावना', E'C', E'**समस्या समाधान विधिले विद्यार्थीहरूमा आत्मविश्वासको भावना जागृत गराउँछ, साथसाथै चिन्तनशीलताको पनि विकास गर्दछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:समस्या समाधान विधिले विद्यार्थीहरूमा के जागृत गराउँछ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सर्वेक्षण विधिले विद्यार्थीहरूमा कस्तो क्षमताको विकास गर्दछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'सर्वेक्षण विधिले विद्यार्थीहरूमा कस्तो क्षमताको विकास गर्दछ?', E'गायन क्षमता', E'खेलकुद क्षमता', E'चित्रकला क्षमता', E'अनुसन्धान क्षमता', E'D', E'**सर्वेक्षण विधिले विद्यार्थीहरूलाई अनुसन्धान क्षमताको विकास गर्न सघाउँछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सर्वेक्षण विधिले विद्यार्थीहरूमा कस्तो क्षमताको विकास गर्दछ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सर्वेक्षण विधिले विद्यार्थीहरूलाई समस्यासम्बन्धी कस्तो सीप प्रदान गर्दछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'सर्वेक्षण विधिले विद्यार्थीहरूलाई समस्यासम्बन्धी कस्तो सीप प्रदान गर्दछ?', E'समस्यालाई बुझ्न, परिभाषित गर्न र सीमाङ्कन गर्न सक्ने क्षमता', E'समस्यालाई सधैँ अस्पष्ट राख्ने बानी', E'समस्यालाई बेवास्ता गर्ने बानी', E'समस्याको दोष अरूलाई दिने बानी', E'A', E'**सर्वेक्षण विधिले विद्यार्थीहरूलाई समस्यालाई बुझ्न, परिभाषित गर्न र सीमाङ्कन गर्न सक्ने क्षमताको विकास गर्दछ, साथै समस्याको निष्कर्ष निकाल्ने विधि पनि प्रदान गर्दछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सर्वेक्षण विधिले विद्यार्थीहरूलाई समस्यासम्बन्धी कस्तो सीप प्रदान गर्दछ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'अवलोकन विधिका प्रतिपादक को हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'अवलोकन विधिका प्रतिपादक को हुन्?', E'कुर्ट लेविन', E'सिम्पसन', E'सुकरात', E'फ्रान्सिस बेकन', E'B', E'**अवलोकन विधिका प्रतिपादक सिम्पसन हुन्।**\\n- फ्रान्सिस बेकन आगमन विधिका प्रतिपादक हुन्।\\n- सुकरातले प्रश्नोत्तर (सोक्रेटिक) विधि प्रतिपादन गरे।\\n- कुर्ट लेविन कार्यमूलक अनुसन्धानका प्रवर्तक हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:अवलोकन विधिका प्रतिपादक को हुन्?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'अवलोकन विधि कति प्रकारका हुन्छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'अवलोकन विधि कति प्रकारका हुन्छन्?', E'३ प्रकार', E'५ प्रकार', E'२ प्रकार: औपचारिक र अनौपचारिक', E'४ प्रकार', E'C', E'**अवलोकन विधि २ प्रकारका हुन्छन्: औपचारिक अवलोकन र अनौपचारिक अवलोकन।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:अवलोकन विधि कति प्रकारका हुन्छन्?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'एक जना शिक्षकले एउटै विषय विभिन्न कक्षाहरूमा विभिन्न समयमा शिक्षण गर्ने प्रक्रियालाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'एक जना शिक्षकले एउटै विषय विभिन्न कक्षाहरूमा विभिन्न समयमा शिक्षण गर्ने प्रक्रियालाई के भनिन्छ?', E'एकीकृत शिक्षण', E'बहुकक्षा शिक्षण', E'सामूहिक शिक्षण', E'विषय शिक्षण', E'D', E'**एक जना शिक्षकले एउटा विषय विभिन्न कक्षाहरूमा विभिन्न समयमा शिक्षण गर्ने प्रक्रियालाई विषय शिक्षण भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:एक जना शिक्षकले एउटै विषय विभिन्न कक्षाहरूमा विभिन्न समयमा शिक्षण गर्ने प्रक्रियालाई के भनिन्छ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'बहुकक्षा शिक्षणका सबल पक्षहरूमध्ये निम्नमध्ये कुन पर्दैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'बहुकक्षा शिक्षणका सबल पक्षहरूमध्ये निम्नमध्ये कुन पर्दैन?', E'प्रत्येक विद्यार्थीलाई छुट्टै शिक्षक उपलब्ध हुनु', E'विद्यार्थी केन्द्रित शिक्षण लागू गर्न सकिनु', E'तुलनात्मक रूपमा कम खर्चिलो हुनु', E'विद्यार्थीहरूले एकअर्कालाई सिकाउने र आपसी सहयोग गर्ने', E'A', E'**"प्रत्येक विद्यार्थीलाई छुट्टै शिक्षक उपलब्ध हुनु" बहुकक्षा शिक्षणको सबल पक्ष होइन।**\\n- विद्यार्थीहरूले एकअर्कालाई सिकाउनु, कम खर्चिलो हुनु र विद्यार्थी केन्द्रित शिक्षण लागू गर्न सकिनु तीनवटै बहुकक्षा शिक्षणका वास्तविक सबल पक्ष हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:बहुकक्षा शिक्षणका सबल पक्षहरूमध्ये निम्नमध्ये कुन पर्दैन?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'बहुकक्षा शिक्षणका लागि कक्षाकोठाको व्यवस्थापनमा कस्तो सुविधा हुनुपर्छ भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'बहुकक्षा शिक्षणका लागि कक्षाकोठाको व्यवस्थापनमा कस्तो सुविधा हुनुपर्छ भनिन्छ?', E'अत्यधिक महँगा उपकरणले सुसज्जित', E'न्यूनतम सुविधायुक्त तर आनन्ददायक र क्रियाकलाप सञ्चालनका लागि पर्याप्त ठाउँ भएको', E'केवल एक विद्यार्थीका लागि मात्र मिल्ने साँघुरो', E'पूर्णतः खाली, कुनै सामग्री नभएको', E'B', E'**बहुकक्षा शिक्षणका लागि कक्षाकोठा न्यूनतम सुविधायुक्त, आनन्ददायक तथा विभिन्न क्रियाकलाप सञ्चालन गर्न पर्याप्त ठाउँ भएको हुनुपर्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:बहुकक्षा शिक्षणका लागि कक्षाकोठाको व्यवस्थापनमा कस्तो सुविधा हुनुपर्छ भनिन्छ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षण विधि छनोट गर्दा मुख्यतया केलाई ध्यान दिनुपर्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'शिक्षण विधि छनोट गर्दा मुख्यतया केलाई ध्यान दिनुपर्छ?', E'विद्यालयको भवन डिजाइन', E'शिक्षकको व्यक्तिगत रुचि मात्र', E'विषयवस्तुको प्रकृति र विद्यार्थीको रुचि-क्षमताअनुसार', E'परीक्षा केन्द्रको दूरी', E'C', E'**शिक्षण विधि छनोट गर्दा विषयवस्तुको प्रकृति अनुसार र विद्यार्थीको रुचि तथा क्षमताअनुसार उपयुक्त विधि छनोट गर्नुपर्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षण विधि छनोट गर्दा मुख्यतया केलाई ध्यान दिनुपर्छ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: शिक्षणका सूत्रहरू (Maxims of Teaching) — आधारभूत तह (12 Q)
  v_set_id := extensions.uuid_generate_v5('335cbffc-fbb1-4ea9-b0d7-ee0cfd62160d'::uuid, E'शिक्षणका सूत्रहरू (Maxims of Teaching) — आधारभूत तह');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'acf58395-316c-4a70-b7b3-5470be568528'::uuid, '335cbffc-fbb1-4ea9-b0d7-ee0cfd62160d'::uuid, E'शिक्षणका सूत्रहरू (Maxims of Teaching) — आधारभूत तह', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '335cbffc-fbb1-4ea9-b0d7-ee0cfd62160d'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षणका सूत्रहरू (Maxims of Teaching) भन्नाले के बुझिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'शिक्षणका सूत्रहरू (Maxims of Teaching) भन्नाले के बुझिन्छ?', E'विद्यार्थीले पास गर्नुपर्ने न्यूनतम अङ्क', E'परीक्षा सञ्चालनका कानुनी प्रावधान', E'पाठ्यपुस्तकमा लेखिएका अध्याय शीर्षक', E'शिक्षण प्रक्रियालाई प्रभावकारी बनाउन शिक्षकले पालना गर्नुपर्ने सामान्य नियम वा मार्गदर्शक सिद्धान्त', E'D', E'**शिक्षणका सूत्रहरू (Maxims of Teaching) भन्नाले शिक्षण प्रक्रियालाई प्रभावकारी बनाउन शिक्षकले पालना गर्नुपर्ने सामान्य नियम वा मार्गदर्शक सिद्धान्तहरू बुझिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षणका सूत्रहरू (Maxims of Teaching) भन्नाले के बुझिन्छ?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षणका सूत्रहरू मुख्यतः केमा आधारित हुन्छन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'शिक्षणका सूत्रहरू मुख्यतः केमा आधारित हुन्छन्?', E'मनोवैज्ञानिक सिद्धान्तहरूमा', E'आर्थिक सिद्धान्तहरूमा', E'राजनीतिक विचारधाराहरूमा', E'कानुनी प्रावधानहरूमा', E'A', E'**शिक्षणका सूत्रहरू मनोवैज्ञानिक सिद्धान्तहरूमा आधारित हुन्छन् र विद्यार्थीको मानसिक विकास तथा सिकाइ प्रक्रियालाई ध्यानमा राखेर बनाइएका हुन्छन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षणका सूत्रहरू मुख्यतः केमा आधारित हुन्छन्?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'"विद्यार्थीलाई पहिले थाहा भएको कुराबाट नयाँ कुरा सिकाउनुपर्छ" भन्ने मान्यता कुन शिक्षण सूत्रले राख्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'"विद्यार्थीलाई पहिले थाहा भएको कुराबाट नयाँ कुरा सिकाउनुपर्छ" भन्ने मान्यता कुन शिक्षण सूत्रले राख्छ?', E'स्थूलबाट सूक्ष्मतातर्फ (Concrete to Abstract)', E'ज्ञातबाट अज्ञाततर्फ (Known to Unknown)', E'पूर्णबाट अंशतातर्फ (Whole to Part)', E'सरलबाट जटिलतर्फ (Simple to Complex)', E'B', E'**ज्ञातबाट अज्ञाततर्फ (Known to Unknown) शिक्षण सूत्रले विद्यार्थीलाई पहिले थाहा भएको कुराबाट नयाँ कुरा सिकाउनुपर्छ भन्ने मान्यता राख्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:"विद्यार्थीलाई पहिले थाहा भएको कुराबाट नयाँ कुरा सिकाउनुपर्छ" भन्ने मान्यता कुन शिक्षण सूत्रले राख्छ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विषयवस्तुलाई सुरुमा सरल रूपमा प्रस्तुत गरी बिस्तारै जटिलतातिर लैजानुपर्छ भन्ने शिक्षण सूत्र कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'विषयवस्तुलाई सुरुमा सरल रूपमा प्रस्तुत गरी बिस्तारै जटिलतातिर लैजानुपर्छ भन्ने शिक्षण सूत्र कुन हो?', E'अनुभवबाट विवेकतातर्फ', E'प्रत्यक्षबाट अप्रत्यक्षतर्फ', E'सरलबाट जटिलतर्फ', E'ज्ञातबाट अज्ञाततर्फ', E'C', E'**सरलबाट जटिलतर्फ (Simple to Complex) शिक्षण सूत्रले विषयवस्तुलाई सुरुमा सरल रूपमा प्रस्तुत गरी बिस्तारै जटिलतातिर लैजानुपर्छ भन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विषयवस्तुलाई सुरुमा सरल रूपमा प्रस्तुत गरी बिस्तारै जटिलतातिर लैजानुपर्छ भन्ने शिक्षण सूत्र कुन हो?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यार्थीलाई मूर्त वस्तु वा अनुभवबाट अमूर्त अवधारणा सिकाउनुपर्छ भन्ने जोड दिने शिक्षण सूत्र कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'विद्यार्थीलाई मूर्त वस्तु वा अनुभवबाट अमूर्त अवधारणा सिकाउनुपर्छ भन्ने जोड दिने शिक्षण सूत्र कुन हो?', E'पूर्णबाट अंशतातर्फ (Whole to Part)', E'मनोवैज्ञानिकबाट तार्किकतातर्फ (Psychological to Logical)', E'प्रत्यक्षबाट अप्रत्यक्षतर्फ (Direct to Indirect)', E'स्थूलबाट सूक्ष्मतातर्फ (Concrete to Abstract)', E'D', E'**स्थूलबाट सूक्ष्मतातर्फ (Concrete to Abstract) शिक्षण सूत्रले विद्यार्थीलाई मूर्त वस्तु वा अनुभवबाट अमूर्त अवधारणा सिकाउनुपर्छ भन्ने जोड दिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यार्थीलाई मूर्त वस्तु वा अनुभवबाट अमूर्त अवधारणा सिकाउनुपर्छ भन्ने जोड दिने शिक्षण सूत्र कुन हो?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै विषयवस्तुलाई पहिले समग्र रूपमा प्रस्तुत गरी त्यसपछि त्यसका विभिन्न अंशहरूमा छलफल गर्नुपर्छ भन्ने शिक्षण सूत्र कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'कुनै विषयवस्तुलाई पहिले समग्र रूपमा प्रस्तुत गरी त्यसपछि त्यसका विभिन्न अंशहरूमा छलफल गर्नुपर्छ भन्ने शिक्षण सूत्र कुन हो?', E'पूर्णबाट अंशतातर्फ (Whole to Part)', E'अनिश्चितबाट निश्चिततर्फ (Indefinite to Definite)', E'अंशबाट पूर्णतातर्फ (Part to Whole)', E'विश्लेषणबाट संश्लेषणतर्फ (Analysis to Synthesis)', E'A', E'**पूर्णबाट अंशतातर्फ (Whole to Part) शिक्षण सूत्रले कुनै विषयवस्तुलाई पहिले समग्र रूपमा प्रस्तुत गरी त्यसपछि त्यसका विभिन्न अंशहरूमा छलफल गर्नुपर्छ भन्छ।**\\nनोट: अंशबाट पूर्णतातर्फ (Part to Whole) यसैको पूरक सूत्र हो, जसले पहिले अंश बुझाएर पछि समग्रतामा जोड्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै विषयवस्तुलाई पहिले समग्र रूपमा प्रस्तुत गरी त्यसपछि त्यसका विभिन्न अंशहरूमा छलफल गर्नुपर्छ भन्ने शिक्षण सूत्र कुन हो?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यार्थीलाई प्रत्यक्ष अनुभव वा अवलोकनबाट अप्रत्यक्ष वा सैद्धान्तिक ज्ञानतर्फ लैजानुपर्छ भन्ने शिक्षण सूत्र कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'विद्यार्थीलाई प्रत्यक्ष अनुभव वा अवलोकनबाट अप्रत्यक्ष वा सैद्धान्तिक ज्ञानतर्फ लैजानुपर्छ भन्ने शिक्षण सूत्र कुन हो?', E'संश्लेषणबाट विश्लेषणतर्फ (Synthesis to Analysis)', E'प्रत्यक्षबाट अप्रत्यक्षतर्फ (Direct to Indirect)', E'प्रकृति पछ्याउने (Following Nature)', E'मनोवैज्ञानिकबाट तार्किकतातर्फ (Psychological to Logical)', E'B', E'**प्रत्यक्षबाट अप्रत्यक्षतर्फ (Direct to Indirect) शिक्षण सूत्रले विद्यार्थीलाई प्रत्यक्ष अनुभव वा अवलोकनबाट अप्रत्यक्ष वा सैद्धान्तिक ज्ञानतर्फ लैजानुपर्छ भन्ने सुझाव दिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यार्थीलाई प्रत्यक्ष अनुभव वा अवलोकनबाट अप्रत्यक्ष वा सैद्धान्तिक ज्ञानतर्फ लैजानुपर्छ भन्ने शिक्षण सूत्र कुन हो?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यार्थीको रुचि, क्षमता र आवश्यकतालाई ध्यानमा राखेर सुरु गरी बिस्तारै विषयको तार्किक क्रममा सिकाउनुपर्छ भन्ने शिक्षण सूत्र कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'विद्यार्थीको रुचि, क्षमता र आवश्यकतालाई ध्यानमा राखेर सुरु गरी बिस्तारै विषयको तार्किक क्रममा सिकाउनुपर्छ भन्ने शिक्षण सूत्र कुन हो?', E'प्रकृति पछ्याउने (Following Nature)', E'अनिश्चितबाट निश्चिततर्फ (Indefinite to Definite)', E'मनोवैज्ञानिकबाट तार्किकतातर्फ (Psychological to Logical)', E'अनुभवबाट विवेकतातर्फ (Empirical to Rational)', E'C', E'**मनोवैज्ञानिकबाट तार्किकतातर्फ (Psychological to Logical) शिक्षण सूत्रले विद्यार्थीको रुचि, क्षमता र आवश्यकतालाई ध्यानमा राखेर सुरु गरी बिस्तारै विषयको तार्किक क्रममा सिकाउनुपर्छ भन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यार्थीको रुचि, क्षमता र आवश्यकतालाई ध्यानमा राखेर सुरु गरी बिस्तारै विषयको तार्किक क्रममा सिकाउनुपर्छ भन्ने शिक्षण सूत्र कुन हो?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै विषयवस्तुलाई पहिले टुक्रा-टुक्रा पारेर अध्ययन गरी त्यसपछि ती टुक्राहरूलाई जोडेर समग्र बुझाइ विकास गर्नुपर्छ भन्ने शिक्षण सूत्र कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'कुनै विषयवस्तुलाई पहिले टुक्रा-टुक्रा पारेर अध्ययन गरी त्यसपछि ती टुक्राहरूलाई जोडेर समग्र बुझाइ विकास गर्नुपर्छ भन्ने शिक्षण सूत्र कुन हो?', E'पूर्णबाट अंशतातर्फ (Whole to Part)', E'संश्लेषणबाट विश्लेषणतर्फ (Synthesis to Analysis)', E'अंशबाट पूर्णतातर्फ (Part to Whole)', E'विश्लेषणबाट संश्लेषणतर्फ (Analysis to Synthesis)', E'D', E'**विश्लेषणबाट संश्लेषणतर्फ (Analysis to Synthesis) शिक्षण सूत्रले विषयवस्तुलाई पहिले टुक्रा-टुक्रा पारेर अध्ययन गरी त्यसपछि ती टुक्राहरूलाई जोडेर समग्र बुझाइ विकास गर्नुपर्छ भन्छ।**\\nनोट: संश्लेषणबाट विश्लेषणतर्फ (Synthesis to Analysis) यसको ठीक उल्टो सूत्र हो, जसले पहिले समग्र अवधारणा प्रस्तुत गरी पछि त्यसका भाग-तत्त्वको अध्ययन गर्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै विषयवस्तुलाई पहिले टुक्रा-टुक्रा पारेर अध्ययन गरी त्यसपछि ती टुक्राहरूलाई जोडेर समग्र बुझाइ विकास गर्नुपर्छ भन्ने शिक्षण सूत्र कुन हो?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यार्थीलाई आफ्नै अनुभवबाट ज्ञान प्राप्त गर्न प्रोत्साहित गरी त्यसलाई तार्किक र विवेकपूर्ण निष्कर्षमा पुर्‍याउन मद्दत गर्ने शिक्षण सूत्र कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'विद्यार्थीलाई आफ्नै अनुभवबाट ज्ञान प्राप्त गर्न प्रोत्साहित गरी त्यसलाई तार्किक र विवेकपूर्ण निष्कर्षमा पुर्‍याउन मद्दत गर्ने शिक्षण सूत्र कुन हो?', E'अनुभवबाट विवेकतातर्फ (Empirical to Rational)', E'प्रत्यक्षबाट अप्रत्यक्षतर्फ (Direct to Indirect)', E'अनिश्चितबाट निश्चिततर्फ (Indefinite to Definite)', E'प्रकृति पछ्याउने (Following Nature)', E'A', E'**अनुभवबाट विवेकतातर्फ (Empirical to Rational) शिक्षण सूत्रले विद्यार्थीलाई आफ्नै अनुभवबाट ज्ञान प्राप्त गर्न प्रोत्साहित गरी त्यसलाई तार्किक र विवेकपूर्ण निष्कर्षमा पुर्‍याउन मद्दत गर्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यार्थीलाई आफ्नै अनुभवबाट ज्ञान प्राप्त गर्न प्रोत्साहित गरी त्यसलाई तार्किक र विवेकपूर्ण निष्कर्षमा पुर्‍याउन मद्दत गर्ने शिक्षण सूत्र कुन हो?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'अस्पष्ट र अनिश्चित विचारहरूबाट सुरु गरी बिस्तारै स्पष्ट र निश्चित ज्ञानतर्फ लैजानुपर्छ भन्ने शिक्षण सूत्र कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'अस्पष्ट र अनिश्चित विचारहरूबाट सुरु गरी बिस्तारै स्पष्ट र निश्चित ज्ञानतर्फ लैजानुपर्छ भन्ने शिक्षण सूत्र कुन हो?', E'स्थूलबाट सूक्ष्मतातर्फ (Concrete to Abstract)', E'अनिश्चितबाट निश्चिततर्फ (Indefinite to Definite)', E'अंशबाट पूर्णतातर्फ (Part to Whole)', E'ज्ञातबाट अज्ञाततर्फ (Known to Unknown)', E'B', E'**अनिश्चितबाट निश्चिततर्फ (Indefinite to Definite) शिक्षण सूत्र अस्पष्ट र अनिश्चित विचारहरूबाट सुरु गरी बिस्तारै स्पष्ट र निश्चित ज्ञानतर्फ लैजानुपर्छ भन्ने सिद्धान्तमा आधारित छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:अस्पष्ट र अनिश्चित विचारहरूबाट सुरु गरी बिस्तारै स्पष्ट र निश्चित ज्ञानतर्फ लैजानुपर्छ भन्ने शिक्षण सूत्र कुन हो?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'विद्यार्थीको प्राकृतिक विकास क्रम र रुचि अनुसार शिक्षण गर्नुपर्छ भन्ने मान्यता राख्ने शिक्षण सूत्र कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'विद्यार्थीको प्राकृतिक विकास क्रम र रुचि अनुसार शिक्षण गर्नुपर्छ भन्ने मान्यता राख्ने शिक्षण सूत्र कुन हो?', E'संश्लेषणबाट विश्लेषणतर्फ', E'अंशबाट पूर्णतातर्फ', E'प्रकृति पछ्याउने (Following Nature)', E'मनोवैज्ञानिकबाट तार्किकतातर्फ', E'C', E'**प्रकृति पछ्याउने (Following Nature) शिक्षण सूत्रले विद्यार्थीको प्राकृतिक विकास क्रम र रुचि अनुसार शिक्षण गर्नुपर्छ भन्ने मान्यता राख्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:विद्यार्थीको प्राकृतिक विकास क्रम र रुचि अनुसार शिक्षण गर्नुपर्छ भन्ने मान्यता राख्ने शिक्षण सूत्र कुन हो?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: शैक्षिक सामग्रीको अर्थ, महत्त्व र वर्गीकरण (आधारभूत तह) (13 Q)
  v_set_id := extensions.uuid_generate_v5('49655ebd-bf99-48e1-8fc6-3317c4505a42'::uuid, E'शैक्षिक सामग्रीको अर्थ, महत्त्व र वर्गीकरण (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'acf58395-316c-4a70-b7b3-5470be568528'::uuid, '49655ebd-bf99-48e1-8fc6-3317c4505a42'::uuid, E'शैक्षिक सामग्रीको अर्थ, महत्त्व र वर्गीकरण (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '49655ebd-bf99-48e1-8fc6-3317c4505a42'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शैक्षिक सामग्रीहरूले कस्तो विषयवस्तुलाई पनि सरल, सहज र अर्थपूर्ण रूपमा शिक्षण गर्न सघाउ पुर्‍याउँछन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'शैक्षिक सामग्रीहरूले कस्तो विषयवस्तुलाई पनि सरल, सहज र अर्थपूर्ण रूपमा शिक्षण गर्न सघाउ पुर्‍याउँछन्?', E'अति सजिलो र सामान्य विषयवस्तुलाई मात्र', E'केवल गणितीय सूत्रलाई मात्र', E'केवल भाषा शिक्षणलाई मात्र', E'कठिन तथा अमूर्त विषयवस्तुलाई पनि', E'D', E'**शैक्षिक सामग्रीहरूले कठिन तथा अमूर्त विषयवस्तुलाई पनि सरल, सहज र अर्थपूर्ण रूपमा शिक्षण गर्न सघाउ पुर्‍याउँछन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शैक्षिक सामग्रीहरूले कस्तो विषयवस्तुलाई पनि सरल, सहज र अर्थपूर्ण रूपमा शिक्षण गर्न सघाउ पुर्‍याउँछन्?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शैक्षिक सामग्रीको प्रयोगले विद्यार्थीहरूमा कस्तो प्रवृत्तिको विकास गराउँछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'शैक्षिक सामग्रीको प्रयोगले विद्यार्थीहरूमा कस्तो प्रवृत्तिको विकास गराउँछ?', E'वैज्ञानिक सोच र वैज्ञानिक अभिवृत्ति', E'पाठ छोड्ने प्रवृत्ति', E'घोक्ने शैलीलाई प्रोत्साहित गर्ने प्रवृत्ति', E'परीक्षामा नक्कल गर्ने प्रवृत्ति', E'A', E'**शैक्षिक सामग्रीको प्रयोगले विद्यार्थीहरूमा वैज्ञानिक सोच र वैज्ञानिक विश्लेषणात्मक रूपमा ज्ञान प्राप्त गर्ने बानीको विकास गराई वैज्ञानिक अभिवृत्ति विकास गराउँछ, र घोक्ने शैलीलाई निरुत्साहित पार्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शैक्षिक सामग्रीको प्रयोगले विद्यार्थीहरूमा कस्तो प्रवृत्तिको विकास गराउँछ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षण सामग्रीको मुख्य महत्त्व के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'शिक्षण सामग्रीको मुख्य महत्त्व के हो?', E'शिक्षकको कार्यबोझ पूर्णतः हटाउनु', E'अमूर्त वा जटिल धारणालाई मूर्त र स्पष्ट रूपमा बुझाएर सिकाइलाई चिरस्थायी बनाउनु', E'परीक्षाको ढाँचा परिवर्तन गर्नु', E'विद्यालयको आम्दानी बढाउनु', E'B', E'**शिक्षण सामग्रीको मुख्य महत्त्व अमूर्त वा जटिल धारणाहरूलाई मूर्त र स्पष्ट रूपमा बुझाएर सिकाइलाई चिरस्थायी (Permanent) बनाउनु हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षण सामग्रीको मुख्य महत्त्व के हो?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'उत्तम शिक्षण सामग्रीको विशेषताअनुसार यो कस्तो हुनुपर्दछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'उत्तम शिक्षण सामग्रीको विशेषताअनुसार यो कस्तो हुनुपर्दछ?', E'केवल सरकारले मात्र उपलब्ध गराउने खालको', E'प्रयोग गर्न जटिल र प्राविधिक ज्ञान चाहिने', E'सस्तो, कम खर्चिलो र स्थानीय स्तरमै प्राप्त हुने खालको', E'महँगो र विदेशबाट आयातित', E'C', E'**उत्तम शिक्षण सामग्री सस्तो, कम खर्चिलो र स्थानीय स्तरमा नै प्राप्त हुने (Locally Available) खालको हुनुपर्दछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:उत्तम शिक्षण सामग्रीको विशेषताअनुसार यो कस्तो हुनुपर्दछ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शिक्षण कार्यमा प्रयोग गरिने वास्तविक जीवन्त वस्तु वा प्राकृतिक सामग्रीहरूलाई शैक्षिक परिभाषामा के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'शिक्षण कार्यमा प्रयोग गरिने वास्तविक जीवन्त वस्तु वा प्राकृतिक सामग्रीहरूलाई शैक्षिक परिभाषामा के भनिन्छ?', E'मोडेल (Model)', E'प्रोजेक्टेड सामग्री', E'अडियो सामग्री', E'रियालिया (Realia)', E'D', E'**शिक्षण कार्यमा प्रयोग गरिने वास्तविक जीवन्त वस्तु वा प्राकृतिक सामग्रीहरूलाई रियालिया (Realia) भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शिक्षण कार्यमा प्रयोग गरिने वास्तविक जीवन्त वस्तु वा प्राकृतिक सामग्रीहरूलाई शैक्षिक परिभाषामा के भनिन्छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'एडगर डेल (Edgar Dale) को अनुभवको शङ्कु (Cone of Experience) अनुसार शिक्षण सामग्रीले सिकाइलाई कस्तो अनुभव प्रदान गर्दछ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'एडगर डेल (Edgar Dale) को अनुभवको शङ्कु (Cone of Experience) अनुसार शिक्षण सामग्रीले सिकाइलाई कस्तो अनुभव प्रदान गर्दछ?', E'प्रत्यक्षदेखि अमूर्त अनुभवसम्म', E'केवल पाठ्यपुस्तकीय अनुभव मात्र', E'केवल परीक्षा-केन्द्रित अनुभव मात्र', E'केवल श्रव्य अनुभव मात्र', E'A', E'**एडगर डेल (Edgar Dale) को अनुभवको शङ्कु (Cone of Experience) अनुसार शिक्षण सामग्रीले सिकाइलाई प्रत्यक्षदेखि अमूर्त अनुभवसम्म प्रदान गर्दछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:एडगर डेल (Edgar Dale) को अनुभवको शङ्कु (Cone of Experience) अनुसार शिक्षण सामग्रीले सिकाइलाई कस्तो अनुभव प्रदान गर्दछ?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'चार्ट, मानचित्र र रेखाचित्रहरूलाई आँखाले मात्र हेरेर सिकिने खालका शैक्षिक सामग्रीलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'चार्ट, मानचित्र र रेखाचित्रहरूलाई आँखाले मात्र हेरेर सिकिने खालका शैक्षिक सामग्रीलाई के भनिन्छ?', E'प्रक्षेपित सामग्री (Projected Materials)', E'दृश्य सामग्री (Visual Materials)', E'श्रव्य-दृश्य सामग्री (Audio-Visual Materials)', E'श्रव्य सामग्री (Audio Materials)', E'B', E'**चार्ट, मानचित्र र रेखाचित्रहरूलाई दृश्य सामग्री (Visual Materials) को रूपमा वर्गीकरण गरिन्छ, जसलाई आँखाले मात्र हेरेर सिकिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:चार्ट, मानचित्र र रेखाचित्रहरूलाई आँखाले मात्र हेरेर सिकिने खालका शैक्षिक सामग्रीलाई के भनिन्छ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'रेडियो, टेपरेकर्डर र अडियो क्यासेटहरूलाई केवल कानले सुनेर ज्ञान आर्जन गरिने के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'रेडियो, टेपरेकर्डर र अडियो क्यासेटहरूलाई केवल कानले सुनेर ज्ञान आर्जन गरिने के भनिन्छ?', E'दृश्य सामग्री', E'श्रव्य-दृश्य सामग्री', E'श्रव्य सामग्री (Audio Materials)', E'मुद्रित सामग्री', E'C', E'**रेडियो, टेपरेकर्डर र अडियो क्यासेटहरूलाई श्रव्य सामग्री (Audio Materials) भनिन्छ, जुन केवल कानले सुनेर ज्ञान आर्जन गरिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:रेडियो, टेपरेकर्डर र अडियो क्यासेटहरूलाई केवल कानले सुनेर ज्ञान आर्जन गरिने के भनिन्छ?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'चलचित्र, टेलिभिजन र भिडियोहरूलाई आँखाले देख्न र कानले सुन्न सकिने कुन श्रेणीमा राखिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'चलचित्र, टेलिभिजन र भिडियोहरूलाई आँखाले देख्न र कानले सुन्न सकिने कुन श्रेणीमा राखिन्छ?', E'अप्रक्षेपित सामग्री', E'मुद्रित सामग्री', E'दृश्य सामग्री मात्र', E'श्रव्य-दृश्य सामग्री (Audio-Visual Materials)', E'D', E'**चलचित्र, टेलिभिजन र भिडियोहरूलाई श्रव्य-दृश्य सामग्री (Audio-Visual Materials) को श्रेणीमा राखिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:चलचित्र, टेलिभिजन र भिडियोहरूलाई आँखाले देख्न र कानले सुन्न सकिने कुन श्रेणीमा राखिन्छ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'ओभरहेड प्रोजेक्टर (OHP) र स्लाइडहरू जस्ता उज्यालोको माध्यमबाट पर्दामा देखाइने सामग्रीलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'ओभरहेड प्रोजेक्टर (OHP) र स्लाइडहरू जस्ता उज्यालोको माध्यमबाट पर्दामा देखाइने सामग्रीलाई के भनिन्छ?', E'प्रक्षेपित सामग्री (Projected Materials)', E'श्रव्य सामग्री', E'मुद्रित सामग्री', E'अप्रक्षेपित सामग्री (Non-projected Materials)', E'A', E'**ओभरहेड प्रोजेक्टर र स्लाइडहरू जस्ता उज्यालोको माध्यमबाट पर्दामा देखाइने सामग्रीलाई प्रक्षेपित सामग्री (Projected Materials) भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:ओभरहेड प्रोजेक्टर (OHP) र स्लाइडहरू जस्ता उज्यालोको माध्यमबाट पर्दामा देखाइने सामग्रीलाई के भनिन्छ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कुनै पनि यन्त्रद्वारा प्रक्षेपण नगरी सिधै प्रयोग गरिने वास्तविक वस्तु (Real Objects) र नमूना (Models) लाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'कुनै पनि यन्त्रद्वारा प्रक्षेपण नगरी सिधै प्रयोग गरिने वास्तविक वस्तु (Real Objects) र नमूना (Models) लाई के भनिन्छ?', E'प्रक्षेपित सामग्री', E'अप्रक्षेपित सामग्री (Non-projected Materials)', E'मुद्रित सामग्री', E'श्रव्य-दृश्य सामग्री', E'B', E'**वास्तविक वस्तु र नमूनाहरूलाई कुनै पनि यन्त्रद्वारा प्रक्षेपण नगरी सिधै प्रयोग गरिने भएकाले अप्रक्षेपित सामग्री (Non-projected Materials) भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कुनै पनि यन्त्रद्वारा प्रक्षेपण नगरी सिधै प्रयोग गरिने वास्तविक वस्तु (Real Objects) र नमूना (Models) लाई के भनिन्छ?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'नेपालको राष्ट्रिय पाठ्यक्रम प्रारूप (National Curriculum Framework) ले शिक्षण सिकाइमा केलाई शैक्षिक सामग्रीको रूपमा एकीकृत गर्ने नीति लिएको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'नेपालको राष्ट्रिय पाठ्यक्रम प्रारूप (National Curriculum Framework) ले शिक्षण सिकाइमा केलाई शैक्षिक सामग्रीको रूपमा एकीकृत गर्ने नीति लिएको छ?', E'केवल मुद्रित सामग्री', E'केवल विदेशी पाठ्यपुस्तक', E'सूचना तथा सञ्चार प्रविधि (ICT)', E'केवल हस्तलिखित नोट', E'C', E'**नेपालको राष्ट्रिय पाठ्यक्रम प्रारूपले शिक्षण सिकाइमा सूचना तथा सञ्चार प्रविधि (ICT) लाई सामग्रीको रूपमा एकीकृत गर्ने नीति लिएको छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:नेपालको राष्ट्रिय पाठ्यक्रम प्रारूप (National Curriculum Framework) ले शिक्षण सिकाइमा केलाई शैक्षिक सामग्रीको रूपमा एकीकृत गर्ने नीति लिएको छ?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शैक्षिक सामग्री कस्तो हुनुपर्छ भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'शैक्षिक सामग्री कस्तो हुनुपर्छ भनिन्छ?', E'केवल एक लिङ्गका विद्यार्थीका लागि उपयुक्त', E'जटिल र प्राविधिक ज्ञान अनिवार्य चाहिने', E'अत्यन्त महँगो र दुर्लभ', E'बालमैत्री, बालकेन्द्रित, लैङ्गिकमैत्री तथा समावेशी', E'D', E'**शैक्षिक सामग्री बालमैत्री, बालकेन्द्रित, लैङ्गिकमैत्री तथा समावेशी हुनुपर्दछ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शैक्षिक सामग्री कस्तो हुनुपर्छ भनिन्छ?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: शैक्षिक सामग्री निर्माण र विशिष्ट उपकरणहरू (आधारभूत तह) (14 Q)
  v_set_id := extensions.uuid_generate_v5('49655ebd-bf99-48e1-8fc6-3317c4505a42'::uuid, E'शैक्षिक सामग्री निर्माण र विशिष्ट उपकरणहरू (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, 'acf58395-316c-4a70-b7b3-5470be568528'::uuid, '49655ebd-bf99-48e1-8fc6-3317c4505a42'::uuid, E'शैक्षिक सामग्री निर्माण र विशिष्ट उपकरणहरू (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '49655ebd-bf99-48e1-8fc6-3317c4505a42'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'फलाटिन बोर्ड सामान्यतया के प्रयोग गरेर बनाइन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'फलाटिन बोर्ड सामान्यतया के प्रयोग गरेर बनाइन्छ?', E'भुवादार फलाटिन कपडा र बोर्ड', E'काठ र धागो', E'लेन्स', E'काठ र किला', E'A', E'**फलाटिन बोर्ड भुवादार फलाटिन कपडा र बोर्ड प्रयोग गरेर बनाइन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:फलाटिन बोर्ड सामान्यतया के प्रयोग गरेर बनाइन्छ?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'गोजी तालिका सामान्यतया के प्रयोग गरेर बनाइन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'गोजी तालिका सामान्यतया के प्रयोग गरेर बनाइन्छ?', E'काठ र फलाम', E'कपडा वा कागज', E'मालाहरू', E'पारो', E'B', E'**गोजी तालिका कपडा वा कागजबाट गोजी बनाएर तयार गरिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:गोजी तालिका सामान्यतया के प्रयोग गरेर बनाइन्छ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'मेटाकार्डमा शब्द लेखेर बनाइने शैक्षिक सामग्रीलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'मेटाकार्डमा शब्द लेखेर बनाइने शैक्षिक सामग्रीलाई के भनिन्छ?', E'जियोबोर्ड', E'गोजी तालिका', E'शब्दपत्ती', E'वाक्यपत्ती', E'C', E'**मेटाकार्डमा शब्द लेखेर बनाइने सामग्रीलाई शब्दपत्ती भनिन्छ।**\\nनोट: कार्डमा वाक्य लेखेर बनाइए वाक्यपत्ती भनिन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:मेटाकार्डमा शब्द लेखेर बनाइने शैक्षिक सामग्रीलाई के भनिन्छ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वर्गाकार काठको सतहमा पिन वा साना किला गाडेर बनाइने शैक्षिक सामग्रीलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'वर्गाकार काठको सतहमा पिन वा साना किला गाडेर बनाइने शैक्षिक सामग्रीलाई के भनिन्छ?', E'एबाकस', E'डाइस वा गोटी', E'क्लिनोमिटर', E'जियोबोर्ड', E'D', E'**वर्गाकार काठको सतहमा पिन वा साना किला गाडेर जियोबोर्ड बनाइन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वर्गाकार काठको सतहमा पिन वा साना किला गाडेर बनाइने शैक्षिक सामग्रीलाई के भनिन्छ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'छ ओटा पाटामा छ थरीका सङ्ख्या लेखेर बनाइने क्युबिकल शैक्षिक सामग्रीलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'छ ओटा पाटामा छ थरीका सङ्ख्या लेखेर बनाइने क्युबिकल शैक्षिक सामग्रीलाई के भनिन्छ?', E'डाइस वा गोटी', E'जियोबोर्ड', E'ज्यामिति बक्स', E'एबाकस', E'A', E'**छ ओटा पाटामा छ थरीका सङ्ख्या लेखेर बनाइने क्युबिकल गोटीलाई डाइस वा गोटी भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:छ ओटा पाटामा छ थरीका सङ्ख्या लेखेर बनाइने क्युबिकल शैक्षिक सामग्रीलाई के भनिन्छ?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'काठ र धागोबाट बनाइने शैक्षिक सामग्री कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'काठ र धागोबाट बनाइने शैक्षिक सामग्री कुन हो?', E'सूक्ष्मदर्शक यन्त्र', E'क्लिनोमिटर', E'ग्लोब', E'थर्मोमिटर', E'B', E'**क्लिनोमिटर काठ र धागोबाट बनाइन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:काठ र धागोबाट बनाइने शैक्षिक सामग्री कुन हो?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'स्केल, कम्पास, प्रोजेक्टर र डिभाइडर आदि राखेर काठ वा फलामबाट बनाइने शैक्षिक सामग्री कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'स्केल, कम्पास, प्रोजेक्टर र डिभाइडर आदि राखेर काठ वा फलामबाट बनाइने शैक्षिक सामग्री कुन हो?', E'नक्सा', E'जियोबोर्ड', E'ज्यामिति बक्स', E'एबाकस', E'C', E'**स्केल, कम्पास, प्रोजेक्टर र डिभाइडर आदि राखेर ज्यामिति बक्स काठ वा फलामको प्रयोगबाट बनाइन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:स्केल, कम्पास, प्रोजेक्टर र डिभाइडर आदि राखेर काठ वा फलामबाट बनाइने शैक्षिक सामग्री कुन हो?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'मालाहरू वा अन्य यस्तै वस्तु प्रयोग गरी गणितीय गणनाका लागि बनाइने शैक्षिक सामग्री कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'मालाहरू वा अन्य यस्तै वस्तु प्रयोग गरी गणितीय गणनाका लागि बनाइने शैक्षिक सामग्री कुन हो?', E'थर्मोमिटर', E'क्लिनोमिटर', E'जियोबोर्ड', E'एबाकस', E'D', E'**मालाहरू वा अन्य यस्तै वस्तु प्रयोग गरी एबाकस बनाइन्छ, जुन गणितीय गणनाका लागि प्रयोग गरिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:मालाहरू वा अन्य यस्तै वस्तु प्रयोग गरी गणितीय गणनाका लागि बनाइने शैक्षिक सामग्री कुन हो?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'कपडा, कागज र फलामको स्क्यान्डबाट सामान्यतया के बनाइन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'कपडा, कागज र फलामको स्क्यान्डबाट सामान्यतया के बनाइन्छ?', E'ग्लोब', E'थर्मोमिटर', E'नक्सा', E'सूक्ष्मदर्शक यन्त्र', E'A', E'**कपडा, कागज र फलामको स्क्यान्डबाट ग्लोब बनाइन्छ।**\\nनोट: नक्सा भने प्लाइउड वा कागज र स्केल प्रयोग गरेर बनाइन्छ।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:कपडा, कागज र फलामको स्क्यान्डबाट सामान्यतया के बनाइन्छ?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'प्लाइउड वा कागज र स्केल प्रयोग गरेर सामान्यतया के बनाइन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'प्लाइउड वा कागज र स्केल प्रयोग गरेर सामान्यतया के बनाइन्छ?', E'डाइस', E'नक्सा', E'ग्लोब', E'एबाकस', E'B', E'**नक्सा प्लाइउड वा कागज र स्केल प्रयोग गरेर बनाइन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:प्लाइउड वा कागज र स्केल प्रयोग गरेर सामान्यतया के बनाइन्छ?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'लेन्स प्रयोग गरी बनाइने शैक्षिक सामग्री कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'लेन्स प्रयोग गरी बनाइने शैक्षिक सामग्री कुन हो?', E'क्लिनोमिटर', E'जियोबोर्ड', E'सूक्ष्मदर्शक यन्त्र', E'थर्मोमिटर', E'C', E'**सूक्ष्मदर्शक यन्त्र लेन्स प्रयोग गरी बनाइएको सामग्री हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:लेन्स प्रयोग गरी बनाइने शैक्षिक सामग्री कुन हो?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'ट्युबभित्र पारो वा सेन्सर राखेर बनाइने शैक्षिक सामग्री कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'ट्युबभित्र पारो वा सेन्सर राखेर बनाइने शैक्षिक सामग्री कुन हो?', E'ग्लोब', E'एबाकस', E'सूक्ष्मदर्शक यन्त्र', E'थर्मोमिटर', E'D', E'**थर्मोमिटर ट्युबभित्र पारो राखेर वा नराखेर सेन्सर राखेर बनाइएको सामग्री हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:ट्युबभित्र पारो वा सेन्सर राखेर बनाइने शैक्षिक सामग्री कुन हो?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'शैक्षिक सामग्रीको निर्माण वा छनोट गर्दा प्राथमिकता दिनुपर्ने कुराहरूमध्ये निम्नमध्ये कुन पर्दैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'शैक्षिक सामग्रीको निर्माण वा छनोट गर्दा प्राथमिकता दिनुपर्ने कुराहरूमध्ये निम्नमध्ये कुन पर्दैन?', E'विदेशबाट मात्र आयात गरिएका महँगा वस्तु', E'प्राकृतिक वस्तु', E'आधुनिक उपकरणहरू', E'शिक्षक वा अन्य निर्मित वस्तु', E'A', E'**"विदेशबाट मात्र आयात गरिएका महँगा वस्तु" शैक्षिक सामग्री निर्माण/छनोटको प्राथमिकतामा पर्दैन।**\\n- प्राकृतिक वस्तु, शिक्षक वा अन्य निर्मित वस्तु र आधुनिक उपकरण तीनवटै वास्तविक प्राथमिकताका आधार हुन्।', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:शैक्षिक सामग्रीको निर्माण वा छनोट गर्दा प्राथमिकता दिनुपर्ने कुराहरूमध्ये निम्नमध्ये कुन पर्दैन?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'स्थानीय सामग्रीको महत्त्वले शिक्षक र विद्यार्थी दुवैमा के-को विकास हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'स्थानीय सामग्रीको महत्त्वले शिक्षक र विद्यार्थी दुवैमा के-को विकास हुन्छ?', E'आर्थिक खर्च बढाउने बानी', E'खोजी गर्ने बानी, सिर्जनात्मक क्षमता र हाते सीप', E'पाठ छाड्ने बानी', E'परीक्षामा नक्कल गर्ने बानी', E'B', E'**स्थानीय सामग्रीको महत्त्वले शिक्षक र विद्यार्थी दुवैमा खोजी गर्ने बानीको विकास हुन्छ, साथै सिर्जनात्मक क्षमता तथा हाते सीपको पनि विकास हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:स्थानीय सामग्रीको महत्त्वले शिक्षक र विद्यार्थी दुवैमा के-को विकास हुन्छ?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  RAISE NOTICE 'Unit ख-६ शिक्षण विधि र प्रक्रिया batch upsert complete: 8 sets, 106 questions.';
END $$;
