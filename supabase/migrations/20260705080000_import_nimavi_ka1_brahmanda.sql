-- Idempotent UPSERT import: निमावि प्रथम पत्र — क-१ ब्रह्माण्ड सम्बन्धी जानकारी (Level I topic-wise sets)
-- Override same-identity sets/questions; never deletes. Generated 2026-07-05T07:33:46.946Z.
DO $$
DECLARE
  v_module_id uuid := '6695669a-f40e-421a-a4ec-b09bbeaf56c4'::uuid;
  v_set_id uuid;
  v_q_id uuid;
BEGIN

  -- Set: ब्रह्माण्डः सौर्यमण्डल, सूर्य, ग्रह र तारा (आधारभूत तह) (18 Q)
  v_set_id := extensions.uuid_generate_v5('1a8b18a8-3142-4ab1-85b4-86bc83b37fda'::uuid, E'ब्रह्माण्डः सौर्यमण्डल, सूर्य, ग्रह र तारा (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '6b98c2ef-1abe-4155-ad47-a97d3b790425'::uuid, '1a8b18a8-3142-4ab1-85b4-86bc83b37fda'::uuid, E'ब्रह्माण्डः सौर्यमण्डल, सूर्य, ग्रह र तारा (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '1a8b18a8-3142-4ab1-85b4-86bc83b37fda'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'बिग ब्याङ्ग सिद्धान्त अनुसार ब्रह्माण्डको आयु करिब कति वर्ष अनुमान गरिन्छ, र ''बिग ब्याङ्ग'' शब्द सर्वप्रथम कसले प्रयोग गरेका थिए?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'बिग ब्याङ्ग सिद्धान्त अनुसार ब्रह्माण्डको आयु करिब कति वर्ष अनुमान गरिन्छ, र ''बिग ब्याङ्ग'' शब्द सर्वप्रथम कसले प्रयोग गरेका थिए?', E'साँढे १३.८ अर्ब वर्ष — फ्रेड होइलले सन् १९४९ मा', E'१२.५ अर्ब वर्ष — आइन्स्टाइनले सन् १९०५ मा', E'१५ अर्ब वर्ष — हब्बलले सन् १९२९ मा', E'१४ अर्ब वर्ष — न्युटनले', E'A', E'**बिग ब्याङ्ग सिद्धान्त अनुसार ब्रह्माण्डको आयु करिब साँढे १३.८ अर्ब वर्ष अनुमान गरिन्छ। ''बिग ब्याङ्ग'' शब्द सर्वप्रथम फ्रेड होइलले सन् १९४९ मा प्रयोग गरेका थिए।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:बिग ब्याङ्ग सिद्धान्त अनुसार ब्रह्माण्डको आयु करिब कति वर्ष अनुमान गरिन्छ, र ''बिग ब्याङ्ग'' शब्द सर्वप्रथम कसले प्रयोग गरेका थिए?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सूर्यको सतहको मध्य भागमा देखिने कालो धब्बालाई Umbra भनिन्छ भने त्यसको चम्किलो किनारालाई के भनिन्छ, र सूर्यको सतहमा सबैभन्दा बढी पाइने ग्याँस कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'सूर्यको सतहको मध्य भागमा देखिने कालो धब्बालाई Umbra भनिन्छ भने त्यसको चम्किलो किनारालाई के भनिन्छ, र सूर्यको सतहमा सबैभन्दा बढी पाइने ग्याँस कुन हो?', E'Corona — हिलियम', E'Penumbra — हाइड्रोजन', E'Photosphere — अक्सिजन', E'Chromosphere — नाइट्रोजन', E'B', E'**सूर्यको सतहको मध्य कालो धब्बालाई Umbra र त्यसको चम्किलो किनारालाई Penumbra भनिन्छ। सूर्यको सतहमा सबैभन्दा बढी पाइने ग्याँस हाइड्रोजन हो (त्यसपछि हिलियम)।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सूर्यको सतहको मध्य भागमा देखिने कालो धब्बालाई Umbra भनिन्छ भने त्यसको चम्किलो किनारालाई के भनिन्छ, र सूर्यको सतहमा सबैभन्दा बढी पाइने ग्याँस कुन हो?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पृथ्वीबाट सबैभन्दा नजिकको तारा र ग्रह क्रमशः कुन-कुन हुन्, र पृथ्वीबाट रातको समयमा देखिने सबैभन्दा चम्किलो तारा कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'पृथ्वीबाट सबैभन्दा नजिकको तारा र ग्रह क्रमशः कुन-कुन हुन्, र पृथ्वीबाट रातको समयमा देखिने सबैभन्दा चम्किलो तारा कुन हो?', E'सूर्य र बुध — ध्रुवतारा', E'सूर्य र मङ्गल — सोरन', E'सूर्य र शुक्र — सिरिअस (Sirius)', E'पृथ्वी र चन्द्रमा — चित्रम', E'C', E'**पृथ्वीबाट सबैभन्दा नजिकको तारा सूर्य र सबैभन्दा नजिकको ग्रह शुक्र हो। रातको समयमा देखिने सबैभन्दा चम्किलो तारा सिरिअस (Sirius) हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पृथ्वीबाट सबैभन्दा नजिकको तारा र ग्रह क्रमशः कुन-कुन हुन्, र पृथ्वीबाट रातको समयमा देखिने सबैभन्दा चम्किलो तारा कुन हो?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सूर्यबाट सबैभन्दा नजिकको र आकारमा सबैभन्दा सानो ग्रह कुन हो, र यसले सूर्यलाई परिक्रमा गर्न कति समय लाग्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'सूर्यबाट सबैभन्दा नजिकको र आकारमा सबैभन्दा सानो ग्रह कुन हो, र यसले सूर्यलाई परिक्रमा गर्न कति समय लाग्छ?', E'शुक्र — करिब १०० दिन', E'मङ्गल — करिब ६० दिन', E'पृथ्वी — करिब ३६५ दिन', E'बुध — करिब ८८ दिन', E'D', E'**बुध सूर्यबाट सबैभन्दा नजिकको र आकारमा सबैभन्दा सानो ग्रह हो, जसले सूर्यलाई परिक्रमा गर्न करिब ८८ दिन लगाउँछ (सौर्यमण्डलमा सबैभन्दा छोटो समय)।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सूर्यबाट सबैभन्दा नजिकको र आकारमा सबैभन्दा सानो ग्रह कुन हो, र यसले सूर्यलाई परिक्रमा गर्न कति समय लाग्छ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'आकारमा पृथ्वीसँग मिल्दो भएकाले ''पृथ्वीको जुम्ल्याहा ग्रह'' भनेर चिनिने ग्रह कुन हो, र यसैलाई ''Morning Star'' वा ''Evening Star'' पनि भनिन्छ किन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'आकारमा पृथ्वीसँग मिल्दो भएकाले ''पृथ्वीको जुम्ल्याहा ग्रह'' भनेर चिनिने ग्रह कुन हो, र यसैलाई ''Morning Star'' वा ''Evening Star'' पनि भनिन्छ किन?', E'शुक्र — घाम लाग्नु/अस्ताउनुअघि आकाशमा सबैभन्दा छिटो/ढिलासम्म देखिने चम्किलो ग्रह भएकाले', E'मङ्गल — रातो रङको कारण', E'बुध — सूर्यको धेरै नजिक भएकाले', E'अरुण — हरियो रङको कारण', E'A', E'**शुक्र आकारमा पृथ्वीसँग मिल्दो भएकाले ''पृथ्वीको जुम्ल्याहा ग्रह'' भनिन्छ। सूर्योदय/सूर्यास्तको समयमा आकाशमा सबैभन्दा चम्किलो देखिने भएकाले यसलाई Morning Star/Evening Star पनि भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:आकारमा पृथ्वीसँग मिल्दो भएकाले ''पृथ्वीको जुम्ल्याहा ग्रह'' भनेर चिनिने ग्रह कुन हो, र यसैलाई ''Morning Star'' वा ''Evening Star'' पनि भनिन्छ किन?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'रातो रङको कारण ''रातो ग्रह'' भनेर चिनिने ग्रह कुन हो, र सबैभन्दा ठूलो ग्रह भएकाले ''King of Planet'' भनेर चिनिने ग्रह कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'रातो रङको कारण ''रातो ग्रह'' भनेर चिनिने ग्रह कुन हो, र सबैभन्दा ठूलो ग्रह भएकाले ''King of Planet'' भनेर चिनिने ग्रह कुन हो?', E'शुक्र — शनि', E'मङ्गल — बृहस्पति', E'बुध — अरुण', E'शनि — मङ्गल', E'B', E'**मङ्गल ग्रहलाई यसको रातो रङको कारण ''रातो ग्रह'' भनिन्छ। बृहस्पति सौर्यमण्डलको सबैभन्दा ठूलो ग्रह भएकाले यसलाई ''King of Planet'' भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:रातो रङको कारण ''रातो ग्रह'' भनेर चिनिने ग्रह कुन हो, र सबैभन्दा ठूलो ग्रह भएकाले ''King of Planet'' भनेर चिनिने ग्रह कुन हो?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'बृहस्पतिले सूर्यलाई एक पटक परिक्रमा गर्न करिब कति वर्ष लगाउँछ, र सौर्यमण्डलको सबैभन्दा ठूलो उपग्रह के हो (जुन बृहस्पतिको उपग्रह हो)?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'बृहस्पतिले सूर्यलाई एक पटक परिक्रमा गर्न करिब कति वर्ष लगाउँछ, र सौर्यमण्डलको सबैभन्दा ठूलो उपग्रह के हो (जुन बृहस्पतिको उपग्रह हो)?', E'करिब ५ वर्ष — टाइटन', E'करिब २० वर्ष — डेमोस', E'करिब १२ वर्ष — गेनिमेड (Ganymede)', E'करिब १ वर्ष — फोबोस', E'C', E'**बृहस्पतिले सूर्यलाई एक पटक परिक्रमा गर्न करिब १२ वर्ष लगाउँछ। सौर्यमण्डलको सबैभन्दा ठूलो उपग्रह गेनिमेड (Ganymede) हो, जुन बृहस्पतिको उपग्रह हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:बृहस्पतिले सूर्यलाई एक पटक परिक्रमा गर्न करिब कति वर्ष लगाउँछ, र सौर्यमण्डलको सबैभन्दा ठूलो उपग्रह के हो (जुन बृहस्पतिको उपग्रह हो)?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सुनौलो/पहेँलो रङको कारण ''सुनौलो ग्रह'' भनेर चिनिने र सबैभन्दा धेरै उपग्रह भएको ग्रह कुन हो, र हरियो रङको कारण चिनिने ग्रह कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'सुनौलो/पहेँलो रङको कारण ''सुनौलो ग्रह'' भनेर चिनिने र सबैभन्दा धेरै उपग्रह भएको ग्रह कुन हो, र हरियो रङको कारण चिनिने ग्रह कुन हो?', E'बृहस्पति — वरुण', E'मङ्गल — शुक्र', E'बुध — पृथ्वी', E'शनि — अरुण', E'D', E'**शनि सुनौलो/पहेँलो रङको कारण ''सुनौलो ग्रह'' भनिन्छ र यसमा सबैभन्दा धेरै उपग्रह छन्। अरुण ग्रह हरियो रङको कारण चिनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सुनौलो/पहेँलो रङको कारण ''सुनौलो ग्रह'' भनेर चिनिने र सबैभन्दा धेरै उपग्रह भएको ग्रह कुन हो, र हरियो रङको कारण चिनिने ग्रह कुन हो?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'चट्टानद्वारा निर्मित (Terrestrial) ग्रहहरू कुन-कुन हुन्, र ग्याँसले बनेका (Gas Giant) ग्रहहरू कुन-कुन हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 9, E'चट्टानद्वारा निर्मित (Terrestrial) ग्रहहरू कुन-कुन हुन्, र ग्याँसले बनेका (Gas Giant) ग्रहहरू कुन-कुन हुन्?', E'बुध, शुक्र, पृथ्वी र मङ्गल — बृहस्पति र शनि', E'बुध, शुक्र, पृथ्वी र शनि — अरुण र वरुण', E'बृहस्पति, शनि, अरुण र वरुण — बुध र शुक्र', E'पृथ्वी, मङ्गल, बृहस्पति र शनि — बुध र शुक्र', E'A', E'**चट्टानद्वारा निर्मित (Terrestrial) ग्रहहरू बुध, शुक्र, पृथ्वी र मङ्गल हुन्। ग्याँसले बनेका (Gas Giant) ग्रहहरू बृहस्पति र शनि हुन् (अरुण र वरुण भने Ice Giant मानिन्छन्)।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:चट्टानद्वारा निर्मित (Terrestrial) ग्रहहरू कुन-कुन हुन्, र ग्याँसले बनेका (Gas Giant) ग्रहहरू कुन-कुन हुन्?'), v_set_id, v_q_id, 9)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'आकारका आधारमा ग्रहहरूलाई ठूलोबाट सानो क्रममा राख्दा सही क्रम कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 10, E'आकारका आधारमा ग्रहहरूलाई ठूलोबाट सानो क्रममा राख्दा सही क्रम कुन हो?', E'बृहस्पति, पृथ्वी, अरुण, वरुण, शनि, शुक्र, बुध, मङ्गल', E'बृहस्पति, शनि, अरुण, वरुण, पृथ्वी, शुक्र, मङ्गल, बुध', E'शनि, बृहस्पति, वरुण, अरुण, शुक्र, पृथ्वी, बुध, मङ्गल', E'बृहस्पति, अरुण, शनि, वरुण, मङ्गल, पृथ्वी, शुक्र, बुध', E'B', E'**आकारका आधारमा ग्रहहरूको ठूलोबाट सानो क्रम: बृहस्पति, शनि, अरुण, वरुण, पृथ्वी, शुक्र, मङ्गल, बुध हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:आकारका आधारमा ग्रहहरूलाई ठूलोबाट सानो क्रममा राख्दा सही क्रम कुन हो?'), v_set_id, v_q_id, 10)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'मङ्गल र बृहस्पतिको बिचमा पाइने साना ग्रह-जस्ता पिण्डहरूको पेटी (क्षुद्रग्रह पेटी) मा सबैभन्दा ठूलो र वामनग्रह (Dwarf Planet) को रूपमा वर्गीकृत पिण्ड कुन हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 11, E'मङ्गल र बृहस्पतिको बिचमा पाइने साना ग्रह-जस्ता पिण्डहरूको पेटी (क्षुद्रग्रह पेटी) मा सबैभन्दा ठूलो र वामनग्रह (Dwarf Planet) को रूपमा वर्गीकृत पिण्ड कुन हो?', E'सेरेस (Ceres)', E'गेनिमेड', E'प्लुटो', E'टाइटन', E'C', E'**मङ्गल र बृहस्पतिको बिचको क्षुद्रग्रह पेटीमा सबैभन्दा ठूलो र वामनग्रहको रूपमा वर्गीकृत पिण्ड सेरेस (Ceres) हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:मङ्गल र बृहस्पतिको बिचमा पाइने साना ग्रह-जस्ता पिण्डहरूको पेटी (क्षुद्रग्रह पेटी) मा सबैभन्दा ठूलो र वामनग्रह (Dwarf Planet) को रूपमा वर्गीकृत पिण्ड कुन हो?'), v_set_id, v_q_id, 11)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'संसारकै पहिलो मानव निर्मित उपग्रह के हो र कुन देशले कहिले अन्तरिक्षमा पठाएको हो, र अन्तरिक्षमा पठाइएको पहिलो प्राणी (कुकुर) को नाम के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 12, E'संसारकै पहिलो मानव निर्मित उपग्रह के हो र कुन देशले कहिले अन्तरिक्षमा पठाएको हो, र अन्तरिक्षमा पठाइएको पहिलो प्राणी (कुकुर) को नाम के हो?', E'स्पुतनिक १ — सोभियत रुस, सन् १९५७ अक्टोबर ४ — लाइका', E'स्पुतनिक २ — अमेरिका, सन् १९६१ — बेलका', E'स्पुतनिक १ — अमेरिका, सन् १९५७ — लाइका', E'एक्सप्लोरर १ — अमेरिका, सन् १९५८ — फेलिसेट', E'D', E'**संसारकै पहिलो मानव निर्मित उपग्रह स्पुतनिक १ हो, जुन सोभियत रुसले सन् १९५७ अक्टोबर ४ मा अन्तरिक्षमा पठाएको थियो। अन्तरिक्षमा पठाइएको पहिलो प्राणी (कुकुर) लाइका थियो (स्पुतनिक २ मार्फत)।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:संसारकै पहिलो मानव निर्मित उपग्रह के हो र कुन देशले कहिले अन्तरिक्षमा पठाएको हो, र अन्तरिक्षमा पठाइएको पहिलो प्राणी (कुकुर) को नाम के हो?'), v_set_id, v_q_id, 12)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'चन्द्रमामा सर्वप्रथम पाइला टेक्ने दुई अन्तरिक्ष यात्री को हुन्, र सूर्यकेन्द्रित सिद्धान्त (सूर्यलाई केन्द्र बनाई ग्रहहरू परिक्रमा गर्छन् भन्ने तथ्य) का प्रतिपादक को हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 13, E'चन्द्रमामा सर्वप्रथम पाइला टेक्ने दुई अन्तरिक्ष यात्री को हुन्, र सूर्यकेन्द्रित सिद्धान्त (सूर्यलाई केन्द्र बनाई ग्रहहरू परिक्रमा गर्छन् भन्ने तथ्य) का प्रतिपादक को हुन्?', E'निल आर्मस्ट्रङ र एडवीन अल्ड्रिन — निकोलस कोपर्निकस', E'युरी गागरिन र निल आर्मस्ट्रङ — ग्यालिलियो ग्यालिली', E'माइकल कोलिन्स र निल आर्मस्ट्रङ — आइज्याक न्युटन', E'जुनको टावेइ र एडवीन अल्ड्रिन — जोहानेस केप्लर', E'A', E'**चन्द्रमामा सर्वप्रथम पाइला टेक्ने अन्तरिक्ष यात्री निल आर्मस्ट्रङ र एडवीन अल्ड्रिन हुन् (सन् १९६९)। सूर्यकेन्द्रित सिद्धान्तका प्रतिपादक निकोलस कोपर्निकस हुन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:चन्द्रमामा सर्वप्रथम पाइला टेक्ने दुई अन्तरिक्ष यात्री को हुन्, र सूर्यकेन्द्रित सिद्धान्त (सूर्यलाई केन्द्र बनाई ग्रहहरू परिक्रमा गर्छन् भन्ने तथ्य) का प्रतिपादक को हुन्?'), v_set_id, v_q_id, 13)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'दूरबीन प्रयोग गरी ब्रह्माण्डको अध्ययन गर्ने पहिलो वैज्ञानिक को हुन्, र सूर्य हेर्न प्रयोग गरिने यन्त्रलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 14, E'दूरबीन प्रयोग गरी ब्रह्माण्डको अध्ययन गर्ने पहिलो वैज्ञानिक को हुन्, र सूर्य हेर्न प्रयोग गरिने यन्त्रलाई के भनिन्छ?', E'निकोलस कोपर्निकस — टेलिस्कोप', E'ग्यालिलियो ग्यालिली — हेलियस्कोप (Helioscope)', E'आइज्याक न्युटन — माइक्रोस्कोप', E'जोहानेस केप्लर — पेरिस्कोप', E'B', E'**दूरबीन प्रयोग गरी ब्रह्माण्डको अध्ययन गर्ने पहिलो वैज्ञानिक ग्यालिलियो ग्यालिली हुन्। सूर्य हेर्न प्रयोग गरिने यन्त्रलाई हेलियस्कोप (Helioscope) भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:दूरबीन प्रयोग गरी ब्रह्माण्डको अध्ययन गर्ने पहिलो वैज्ञानिक को हुन्, र सूर्य हेर्न प्रयोग गरिने यन्त्रलाई के भनिन्छ?'), v_set_id, v_q_id, 14)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सूर्यबाट निस्कने विकिरण नाप्ने यन्त्रलाई के भनिन्छ, र प्रकाशको तीव्रता (Light Intensity) मापन गर्ने यन्त्रलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 15, E'सूर्यबाट निस्कने विकिरण नाप्ने यन्त्रलाई के भनिन्छ, र प्रकाशको तीव्रता (Light Intensity) मापन गर्ने यन्त्रलाई के भनिन्छ?', E'हेलियस्कोप — बारोमिटर', E'थर्मामिटर — ह्युग्रोमिटर', E'पाराहेलियोमिटर (Pyrheliometer) — फोटोमिटर (Photometer)', E'स्पेक्ट्रोमिटर — म्यानोमिटर', E'C', E'**सूर्यबाट निस्कने विकिरण नाप्ने यन्त्रलाई पाराहेलियोमिटर (Pyrheliometer) भनिन्छ। प्रकाशको तीव्रता मापन गर्ने यन्त्रलाई फोटोमिटर (Photometer) भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सूर्यबाट निस्कने विकिरण नाप्ने यन्त्रलाई के भनिन्छ, र प्रकाशको तीव्रता (Light Intensity) मापन गर्ने यन्त्रलाई के भनिन्छ?'), v_set_id, v_q_id, 15)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'सूर्यको प्रकाश पृथ्वीमा आइपुग्न लगभग कति समय लाग्छ, र हाम्रो सौर्यमण्डल कुन तारापुञ्ज (Galaxy) मा रहेको छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 16, E'सूर्यको प्रकाश पृथ्वीमा आइपुग्न लगभग कति समय लाग्छ, र हाम्रो सौर्यमण्डल कुन तारापुञ्ज (Galaxy) मा रहेको छ?', E'करिब १ मिनेट — Andromeda', E'करिब ८ मिनेट ३० सेकेन्ड — Triangulum', E'करिब ३० सेकेन्ड — Whirlpool Galaxy', E'करिब ८ मिनेट २० सेकेन्ड — आकाशगंगा (Milky Way)', E'D', E'**सूर्यको प्रकाश पृथ्वीमा आइपुग्न लगभग ८ मिनेट २० सेकेन्ड लाग्छ। हाम्रो सौर्यमण्डल आकाशगंगा (Milky Way Galaxy) तारापुञ्जमा रहेको छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:सूर्यको प्रकाश पृथ्वीमा आइपुग्न लगभग कति समय लाग्छ, र हाम्रो सौर्यमण्डल कुन तारापुञ्ज (Galaxy) मा रहेको छ?'), v_set_id, v_q_id, 16)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'प्रकाशले एक सेकेण्डमा करिब कति दूरी पार गर्छ, र ''प्रकाशवर्ष'' भनेको के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 17, E'प्रकाशले एक सेकेण्डमा करिब कति दूरी पार गर्छ, र ''प्रकाशवर्ष'' भनेको के हो?', E'करिब ३ लाख किलोमिटर — प्रकाशले एक वर्षमा पार गर्ने दूरी', E'करिब १ लाख किलोमिटर — प्रकाशको गति नाप्ने एकाइ', E'करिब ५० हजार किलोमिटर — एक वर्षको समय', E'करिब १० लाख किलोमिटर — एक दिनमा पार गर्ने दूरी', E'A', E'**प्रकाशले एक सेकेण्डमा करिब ३ लाख किलोमिटर दूरी पार गर्छ। प्रकाशवर्ष भनेको प्रकाशले एक वर्षमा पार गर्ने दूरी हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:प्रकाशले एक सेकेण्डमा करिब कति दूरी पार गर्छ, र ''प्रकाशवर्ष'' भनेको के हो?'), v_set_id, v_q_id, 17)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'''सप्तऋषि'' तारा समूहलाई अङ्ग्रेजीमा के भनिन्छ, र स्थिर रूपमा उत्तरी ध्रुवको माथि सधैं देखिने तारालाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 18, E'''सप्तऋषि'' तारा समूहलाई अङ्ग्रेजीमा के भनिन्छ, र स्थिर रूपमा उत्तरी ध्रुवको माथि सधैं देखिने तारालाई के भनिन्छ?', E'Milky Way — सिरिअस', E'Great Bear — ध्रुवतारा (Polaris)', E'Great Tiger — पुच्छ्रेतारा', E'Septinal — उल्कापिण्ड', E'B', E'**''सप्तऋषि'' तारा समूहलाई अङ्ग्रेजीमा Great Bear भनिन्छ। उत्तरी ध्रुवको माथि स्थिर रूपमा सधैं देखिने तारालाई ध्रुवतारा (Polaris) भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:''सप्तऋषि'' तारा समूहलाई अङ्ग्रेजीमा के भनिन्छ, र स्थिर रूपमा उत्तरी ध्रुवको माथि सधैं देखिने तारालाई के भनिन्छ?'), v_set_id, v_q_id, 18)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  -- Set: ब्रह्माण्डः पृथ्वी — परिचय, उत्पत्ति र गति (आधारभूत तह) (8 Q)
  v_set_id := extensions.uuid_generate_v5('08e980ed-30ca-4dfe-857c-aed848619fd8'::uuid, E'ब्रह्माण्डः पृथ्वी — परिचय, उत्पत्ति र गति (आधारभूत तह)');
  INSERT INTO public.question_sets (id, topic_id, subtopic_id, title, difficulty_level, set_type, is_verified)
  VALUES (v_set_id, '6b98c2ef-1abe-4155-ad47-a97d3b790425'::uuid, '08e980ed-30ca-4dfe-857c-aed848619fd8'::uuid, E'ब्रह्माण्डः पृथ्वी — परिचय, उत्पत्ति र गति (आधारभूत तह)', 1, 'learning', true)
  ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, difficulty_level = EXCLUDED.difficulty_level, set_type = EXCLUDED.set_type, is_verified = true;
  INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
  VALUES (v_set_id, v_module_id, '08e980ed-30ca-4dfe-857c-aed848619fd8'::uuid)
  ON CONFLICT (question_set_id, module_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'वैज्ञानिकहरूका अनुसार पृथ्वीको उत्पत्ति लगभग कति वर्ष पहिले भएको अनुमान गरिन्छ, र पृथ्वीको एकमात्र प्राकृतिक उपग्रहको नाम के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 1, E'वैज्ञानिकहरूका अनुसार पृथ्वीको उत्पत्ति लगभग कति वर्ष पहिले भएको अनुमान गरिन्छ, र पृथ्वीको एकमात्र प्राकृतिक उपग्रहको नाम के हो?', E'करिब साढे ४ अर्ब वर्ष पहिले — चन्द्रमा', E'करिब १ अर्ब वर्ष पहिले — डेमोस', E'करिब १० करोड वर्ष पहिले — फोबोस', E'करिब १०० करोड वर्ष पहिले — टिटानिय', E'A', E'**पृथ्वीको उत्पत्ति लगभग साढे ४ अर्ब वर्ष पहिले भएको अनुमान गरिन्छ। पृथ्वीको एकमात्र प्राकृतिक उपग्रह चन्द्रमा हो।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:वैज्ञानिकहरूका अनुसार पृथ्वीको उत्पत्ति लगभग कति वर्ष पहिले भएको अनुमान गरिन्छ, र पृथ्वीको एकमात्र प्राकृतिक उपग्रहको नाम के हो?'), v_set_id, v_q_id, 1)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पृथ्वीले सूर्यलाई एक पटक परिक्रमा गर्न कति समय लाग्छ, र यसले सूर्यलाई परिक्रमा गर्दा आफ्नो अक्ष कति डिग्रीको कोणमा झुकेको हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 2, E'पृथ्वीले सूर्यलाई एक पटक परिक्रमा गर्न कति समय लाग्छ, र यसले सूर्यलाई परिक्रमा गर्दा आफ्नो अक्ष कति डिग्रीको कोणमा झुकेको हुन्छ?', E'३६० दिन — २०.५°', E'३६५ दिन ५ घण्टा ४८ मिनेट — २३.५°', E'३६६ दिन — ६६.५°', E'३५४ दिन — ९०.५°', E'B', E'**पृथ्वीले सूर्यलाई एक पटक परिक्रमा गर्न ३६५ दिन ५ घण्टा ४८ मिनेट लाग्छ, र यो परिक्रमा गर्दा पृथ्वीको अक्ष २३.५° को कोणमा झुकेको हुन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पृथ्वीले सूर्यलाई एक पटक परिक्रमा गर्न कति समय लाग्छ, र यसले सूर्यलाई परिक्रमा गर्दा आफ्नो अक्ष कति डिग्रीको कोणमा झुकेको हुन्छ?'), v_set_id, v_q_id, 2)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पृथ्वी आफ्नो अक्षमा कुन दिशामा घुम्छ, र भूमध्यरेखामा यसको परिक्रमण (आफ्नै अक्षको) गति प्रति घण्टा लगभग कति हुन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 3, E'पृथ्वी आफ्नो अक्षमा कुन दिशामा घुम्छ, र भूमध्यरेखामा यसको परिक्रमण (आफ्नै अक्षको) गति प्रति घण्टा लगभग कति हुन्छ?', E'पूर्वबाट पश्चिम — करिब ८०० कि.मि.', E'उत्तरबाट दक्षिण — करिब २००० कि.मि.', E'पश्चिमबाट पूर्व — करिब १६०० कि.मि.', E'दक्षिणबाट उत्तर — करिब ५०० कि.मि.', E'C', E'**पृथ्वी आफ्नो अक्षमा पश्चिमबाट पूर्व दिशामा घुम्छ। भूमध्यरेखामा यसको अक्षीय गति प्रति घण्टा करिब १६०० कि.मि. हुन्छ (ध्रुवमा यो गति शून्य हुन्छ)।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पृथ्वी आफ्नो अक्षमा कुन दिशामा घुम्छ, र भूमध्यरेखामा यसको परिक्रमण (आफ्नै अक्षको) गति प्रति घण्टा लगभग कति हुन्छ?'), v_set_id, v_q_id, 3)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पृथ्वीले सूर्यलाई परिक्रमा गर्ने गति प्रति सेकेण्ड लगभग कति हुन्छ, र यो परिक्रमा गर्ने काल्पनिक बाटोलाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 4, E'पृथ्वीले सूर्यलाई परिक्रमा गर्ने गति प्रति सेकेण्ड लगभग कति हुन्छ, र यो परिक्रमा गर्ने काल्पनिक बाटोलाई के भनिन्छ?', E'करिब १० कि.मि. — अक्ष', E'करिब ५० कि.मि. — परिधि', E'करिब ७० कि.मि. — व्यास', E'करिब ३० कि.मि. — कक्ष', E'D', E'**पृथ्वीले सूर्यलाई परिक्रमा गर्ने गति प्रति सेकेण्ड करिब ३० कि.मि. हुन्छ। यो परिक्रमा गर्ने काल्पनिक बाटोलाई कक्ष भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पृथ्वीले सूर्यलाई परिक्रमा गर्ने गति प्रति सेकेण्ड लगभग कति हुन्छ, र यो परिक्रमा गर्ने काल्पनिक बाटोलाई के भनिन्छ?'), v_set_id, v_q_id, 4)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पृथ्वीमा ऋतु परिवर्तन हुनुका कारणहरूमा निम्नमध्ये कुन पर्दैन?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 5, E'पृथ्वीमा ऋतु परिवर्तन हुनुका कारणहरूमा निम्नमध्ये कुन पर्दैन?', E'पृथ्वी आफ्नो अक्षमा पश्चिमबाट पूर्व घुम्नु', E'पृथ्वीको अक्ष २३.५° मा झुक्नु', E'पृथ्वीको सूर्यको परिक्रमा गर्नु', E'पृथ्वी धेरै हदसम्म गोलाकार हुनु', E'A', E'**पृथ्वीको ऋतु परिवर्तन अक्षको झुकाव (२३.५°), सूर्यको परिक्रमा र गोलाकार आकृतिका कारण हुन्छ — पृथ्वीको आफ्नो अक्षमा घुम्ने दिशा (पश्चिमबाट पूर्व) ऋतु परिवर्तनको कारण होइन।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पृथ्वीमा ऋतु परिवर्तन हुनुका कारणहरूमा निम्नमध्ये कुन पर्दैन?'), v_set_id, v_q_id, 5)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'चन्द्रमामा हाम्रो तौल पृथ्वीको भन्दा कम हुनुको कारण के हो?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 6, E'चन्द्रमामा हाम्रो तौल पृथ्वीको भन्दा कम हुनुको कारण के हो?', E'चन्द्रमामा हावा छैन', E'चन्द्रमाको गुरुत्वाकर्षण पृथ्वीको भन्दा कमजोर छ', E'चन्द्रमा पृथ्वीभन्दा सानो छ', E'चन्द्रमा सूर्यबाट धेरै टाढा छ', E'B', E'**चन्द्रमामा हाम्रो तौल पृथ्वीको भन्दा कम हुन्छ किनभने चन्द्रमाको गुरुत्वाकर्षण पृथ्वीको भन्दा कमजोर छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:चन्द्रमामा हाम्रो तौल पृथ्वीको भन्दा कम हुनुको कारण के हो?'), v_set_id, v_q_id, 6)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'पृथ्वीको सतहसम्म आइपुगेको उल्कालाई के भनिन्छ, र ध्रुवीय क्षेत्रमा उल्काहरू एकैसाथ ठूलो सङ्ख्यामा खस्ने घटनालाई के भनिन्छ?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 7, E'पृथ्वीको सतहसम्म आइपुगेको उल्कालाई के भनिन्छ, र ध्रुवीय क्षेत्रमा उल्काहरू एकैसाथ ठूलो सङ्ख्यामा खस्ने घटनालाई के भनिन्छ?', E'उल्का (Meteor) — पुच्छ्रेतारा', E'क्षुद्रग्रह — धूमकेतु', E'उल्कापिण्ड (Meteorite) — उल्कापात (Meteor Shower)', E'उल्कापात — उल्कापिण्ड', E'C', E'**पृथ्वीको सतहसम्म आइपुगेको उल्कालाई उल्कापिण्ड (Meteorite) भनिन्छ। उल्काहरू एकैसाथ ठूलो सङ्ख्यामा खस्ने घटनालाई उल्कापात (Meteor Shower) भनिन्छ।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:पृथ्वीको सतहसम्म आइपुगेको उल्कालाई के भनिन्छ, र ध्रुवीय क्षेत्रमा उल्काहरू एकैसाथ ठूलो सङ्ख्यामा खस्ने घटनालाई के भनिन्छ?'), v_set_id, v_q_id, 7)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  v_q_id := extensions.uuid_generate_v5(v_set_id, E'ताराहरूको आफ्नै प्रकाश हुन्छ भने ग्रहहरूको प्रकाश कस्तो हुन्छ, र सूर्यमा पाइने प्रमुख तत्त्वहरू कुन-कुन हुन्?');
  INSERT INTO public.questions (id, set_id, order_number, content, option_a, option_b, option_c, option_d, correct_option, explanation, language, is_verified, audio_version, audio_ready)
  VALUES (v_q_id, v_set_id, 8, E'ताराहरूको आफ्नै प्रकाश हुन्छ भने ग्रहहरूको प्रकाश कस्तो हुन्छ, र सूर्यमा पाइने प्रमुख तत्त्वहरू कुन-कुन हुन्?', E'आफ्नै प्रकाश — अक्सिजन र नाइट्रोजन', E'कुनै प्रकाश हुँदैन — कार्बन र हिलियम', E'ताराभन्दा बढी चम्किलो — नाइट्रोजन मात्र', E'प्रतिबिम्बित (Reflected) प्रकाश — हाइड्रोजन र हिलियम', E'D', E'**ताराहरूको आफ्नै प्रकाश हुन्छ भने ग्रहहरूले सूर्यको प्रकाश प्रतिबिम्बित (Reflect) गरेर मात्र देखिन्छन्। सूर्यमा पाइने प्रमुख तत्त्वहरू हाइड्रोजन र हिलियम हुन्।**', 'nepali', true, 1, false)
  ON CONFLICT (id) DO UPDATE SET order_number = EXCLUDED.order_number, content = EXCLUDED.content, option_a = EXCLUDED.option_a, option_b = EXCLUDED.option_b, option_c = EXCLUDED.option_c, option_d = EXCLUDED.option_d, correct_option = EXCLUDED.correct_option, explanation = EXCLUDED.explanation, is_verified = true;
  INSERT INTO public.question_set_questions (id, question_set_id, question_id, position)
  VALUES (extensions.uuid_generate_v5(v_set_id, E'junction:ताराहरूको आफ्नै प्रकाश हुन्छ भने ग्रहहरूको प्रकाश कस्तो हुन्छ, र सूर्यमा पाइने प्रमुख तत्त्वहरू कुन-कुन हुन्?'), v_set_id, v_q_id, 8)
  ON CONFLICT (question_set_id, question_id) DO NOTHING;

  RAISE NOTICE 'क-१ ब्रह्माण्ड upsert complete: 2 sets, 26 questions.';
END $$;
