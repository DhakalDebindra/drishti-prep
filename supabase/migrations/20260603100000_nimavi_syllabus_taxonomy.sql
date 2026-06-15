-- ════════════════════════════════════════════════════════════════════
-- DrishtiPrep — निमावि प्रथम पत्र: Phase 2 syllabus taxonomy (official, v2)
-- Generated: 2026-06-14T15:37:54.692Z
-- Generator: scratch/generate_nimavi_syllabus.mjs
-- Source:    शिक्षक सेवा आयोग — आधारभूत (निमावि र प्राथमिक) तह तृतीय श्रेणी, सामान्य परीक्षा, 2076
--
-- Full GK-module-style depth under the free module 'nimavi-pratham-patra':
--   5 खण्ड subjects → 29 topics → 66 subtopics (official numbering in syllabus_ref).
-- Repositions the Phase-1 practice subject 'अभ्यास' to display_order 6 (an
-- additional/final section within the syllabus).
--
-- Marks: क 30·15Q, ख 40·20Q, ग 10·5Q, घ 10·5Q, ङ 10·5Q = 100 marks / 50 Q.
-- Scaffold only — no content. Idempotent (ON CONFLICT DO UPDATE).
-- subtopics get a structured syllabus_ref column (added here, idempotent).
-- ════════════════════════════════════════════════════════════════════

ALTER TABLE public.subtopics ADD COLUMN IF NOT EXISTS syllabus_ref text;

DO $$
DECLARE
  v_module_id  uuid;
  v_subject_id uuid;
  v_topic_id   uuid;
BEGIN
  SELECT id INTO v_module_id FROM public.modules WHERE slug = 'nimavi-pratham-patra' LIMIT 1;
  IF v_module_id IS NULL THEN
    RAISE EXCEPTION 'Module % not found — run the Phase-1 import (20260603000000) first', 'nimavi-pratham-patra';
  END IF;

  -- ═══ खण्ड क · सामान्य ज्ञान र समसामयिक विषय  (30 अंक · 15 प्रश्न) ═══
  INSERT INTO public.subjects (module_id, name, name_np, slug, syllabus_ref, display_order, description)
  VALUES (v_module_id, E'सामान्य ज्ञान र समसामयिक विषय', E'सामान्य ज्ञान र समसामयिक विषय', 'khanda-ka-gk', E'क', 1, E'30 अंक · 15 प्रश्न')
  ON CONFLICT (module_id, slug) DO UPDATE
    SET name=EXCLUDED.name, name_np=EXCLUDED.name_np, syllabus_ref=EXCLUDED.syllabus_ref,
        display_order=EXCLUDED.display_order, description=EXCLUDED.description
  RETURNING id INTO v_subject_id;

  INSERT INTO public.topics (subject_id, name, slug, syllabus_ref, display_order)
  VALUES (v_subject_id, E'ब्रह्माण्ड सम्बन्धी जानकारी', 'brahmanda', E'१', 1)
  ON CONFLICT (subject_id, slug) DO UPDATE
    SET name=EXCLUDED.name, syllabus_ref=EXCLUDED.syllabus_ref, display_order=EXCLUDED.display_order
  RETURNING id INTO v_topic_id;
  INSERT INTO public.subtopics (topic_id, name, name_np, syllabus_ref, slug, display_order)
  VALUES
    (v_topic_id, E'सौर्यमण्डल: सूर्य, ग्रह, उपग्रह, तारा', E'सौर्यमण्डल: सूर्य, ग्रह, उपग्रह, तारा', E'१.१', 'brahmanda-1', 1),
    (v_topic_id, E'पृथ्वी: परिचय, उत्पत्ति र गति', E'पृथ्वी: परिचय, उत्पत्ति र गति', E'१.२', 'brahmanda-2', 2)
  ON CONFLICT (topic_id, slug) DO UPDATE
    SET name=EXCLUDED.name, name_np=EXCLUDED.name_np, syllabus_ref=EXCLUDED.syllabus_ref, display_order=EXCLUDED.display_order;

  INSERT INTO public.topics (subject_id, name, slug, syllabus_ref, display_order)
  VALUES (v_subject_id, E'विश्वको भूगोल', 'vishwa-bhugol', E'२', 2)
  ON CONFLICT (subject_id, slug) DO UPDATE
    SET name=EXCLUDED.name, syllabus_ref=EXCLUDED.syllabus_ref, display_order=EXCLUDED.display_order
  RETURNING id INTO v_topic_id;
  INSERT INTO public.subtopics (topic_id, name, name_np, syllabus_ref, slug, display_order)
  VALUES
    (v_topic_id, E'महासागर, महादेश, भौगोलिक क्षेत्र र विशेषता', E'महासागर, महादेश, भौगोलिक क्षेत्र र विशेषता', E'२.१', 'vishwa-bhugol-1', 1),
    (v_topic_id, E'अवस्थिति, अक्षांश, देशान्तर, अन्तर्राष्ट्रिय तिथि रेखा, समय र दूरी', E'अवस्थिति, अक्षांश, देशान्तर, अन्तर्राष्ट्रिय तिथि रेखा, समय र दूरी', E'२.२', 'vishwa-bhugol-2', 2),
    (v_topic_id, E'जलवायु, पर्वत श्रृंखला, मरुभूमि, भूकम्प, ज्वालामुखी, नदी र हिमनदी', E'जलवायु, पर्वत श्रृंखला, मरुभूमि, भूकम्प, ज्वालामुखी, नदी र हिमनदी', E'२.३', 'vishwa-bhugol-3', 3)
  ON CONFLICT (topic_id, slug) DO UPDATE
    SET name=EXCLUDED.name, name_np=EXCLUDED.name_np, syllabus_ref=EXCLUDED.syllabus_ref, display_order=EXCLUDED.display_order;

  INSERT INTO public.topics (subject_id, name, slug, syllabus_ref, display_order)
  VALUES (v_subject_id, E'नेपालको भूगोल', 'nepal-bhugol', E'३', 3)
  ON CONFLICT (subject_id, slug) DO UPDATE
    SET name=EXCLUDED.name, syllabus_ref=EXCLUDED.syllabus_ref, display_order=EXCLUDED.display_order
  RETURNING id INTO v_topic_id;
  INSERT INTO public.subtopics (topic_id, name, name_np, syllabus_ref, slug, display_order)
  VALUES
    (v_topic_id, E'भौगोलिक अवस्था, धरातलीय स्वरूप, किसिम र विशेषता', E'भौगोलिक अवस्था, धरातलीय स्वरूप, किसिम र विशेषता', E'३.१', 'nepal-bhugol-1', 1),
    (v_topic_id, E'प्राकृतिक स्रोतहरू: किसिम, उपलब्धता र उपयोग', E'प्राकृतिक स्रोतहरू: किसिम, उपलब्धता र उपयोग', E'३.२', 'nepal-bhugol-2', 2),
    (v_topic_id, E'भौगोलिक विविधता र जनजीवन', E'भौगोलिक विविधता र जनजीवन', E'३.३', 'nepal-bhugol-3', 3),
    (v_topic_id, E'हावापानीको किसिम, विशेषता र त्यसको प्रभाव', E'हावापानीको किसिम, विशेषता र त्यसको प्रभाव', E'३.४', 'nepal-bhugol-4', 4)
  ON CONFLICT (topic_id, slug) DO UPDATE
    SET name=EXCLUDED.name, name_np=EXCLUDED.name_np, syllabus_ref=EXCLUDED.syllabus_ref, display_order=EXCLUDED.display_order;

  INSERT INTO public.topics (subject_id, name, slug, syllabus_ref, display_order)
  VALUES (v_subject_id, E'नेपालको इतिहास, संस्कृति र सामाजिक व्यवस्था', 'itihas-sanskriti', E'४', 4)
  ON CONFLICT (subject_id, slug) DO UPDATE
    SET name=EXCLUDED.name, syllabus_ref=EXCLUDED.syllabus_ref, display_order=EXCLUDED.display_order
  RETURNING id INTO v_topic_id;
  INSERT INTO public.subtopics (topic_id, name, name_np, syllabus_ref, slug, display_order)
  VALUES
    (v_topic_id, E'आधुनिक इतिहास: महत्त्वपूर्ण राजनीतिक घटनाक्रम', E'आधुनिक इतिहास: महत्त्वपूर्ण राजनीतिक घटनाक्रम', E'४.१', 'itihas-sanskriti-1', 1),
    (v_topic_id, E'नेपाली समाज: बनोट, सामाजिक प्रथा, परम्परा, मूल्य र मान्यता', E'नेपाली समाज: बनोट, सामाजिक प्रथा, परम्परा, मूल्य र मान्यता', E'४.२', 'itihas-sanskriti-2', 2),
    (v_topic_id, E'सांस्कृतिक सम्पदा: किसिम, स्थिति, विशेषता, महत्त्व र संरक्षण', E'सांस्कृतिक सम्पदा: किसिम, स्थिति, विशेषता, महत्त्व र संरक्षण', E'४.३', 'itihas-sanskriti-3', 3)
  ON CONFLICT (topic_id, slug) DO UPDATE
    SET name=EXCLUDED.name, name_np=EXCLUDED.name_np, syllabus_ref=EXCLUDED.syllabus_ref, display_order=EXCLUDED.display_order;

  INSERT INTO public.topics (subject_id, name, slug, syllabus_ref, display_order)
  VALUES (v_subject_id, E'नेपालको आर्थिक विकास', 'arthik-vikas', E'५', 5)
  ON CONFLICT (subject_id, slug) DO UPDATE
    SET name=EXCLUDED.name, syllabus_ref=EXCLUDED.syllabus_ref, display_order=EXCLUDED.display_order
  RETURNING id INTO v_topic_id;
  INSERT INTO public.subtopics (topic_id, name, name_np, syllabus_ref, slug, display_order)
  VALUES
    (v_topic_id, E'नेपालको अर्थतन्त्रको स्वरूप', E'नेपालको अर्थतन्त्रको स्वरूप', E'५.१', 'arthik-vikas-1', 1),
    (v_topic_id, E'विकासका पूर्वाधारहरू: शिक्षा, स्वास्थ्य, कृषि, उद्योग, यातायात, विद्युत र पर्यटन', E'विकासका पूर्वाधारहरू: शिक्षा, स्वास्थ्य, कृषि, उद्योग, यातायात, विद्युत र पर्यटन', E'५.२', 'arthik-vikas-2', 2),
    (v_topic_id, E'चालु आवधिक योजना र बजेट', E'चालु आवधिक योजना र बजेट', E'५.३', 'arthik-vikas-3', 3)
  ON CONFLICT (topic_id, slug) DO UPDATE
    SET name=EXCLUDED.name, name_np=EXCLUDED.name_np, syllabus_ref=EXCLUDED.syllabus_ref, display_order=EXCLUDED.display_order;

  INSERT INTO public.topics (subject_id, name, slug, syllabus_ref, display_order)
  VALUES (v_subject_id, E'वातावरण, विज्ञान र प्रविधि', 'vatavaran-vigyan', E'६', 6)
  ON CONFLICT (subject_id, slug) DO UPDATE
    SET name=EXCLUDED.name, syllabus_ref=EXCLUDED.syllabus_ref, display_order=EXCLUDED.display_order
  RETURNING id INTO v_topic_id;
  INSERT INTO public.subtopics (topic_id, name, name_np, syllabus_ref, slug, display_order)
  VALUES
    (v_topic_id, E'दीगो विकास, नेपालको जलवायुको अवस्था, हरितगृह प्रभाव, वातावरण प्रदूषण', E'दीगो विकास, नेपालको जलवायुको अवस्था, हरितगृह प्रभाव, वातावरण प्रदूषण', E'६.१', 'vatavaran-vigyan-1', 1),
    (v_topic_id, E'पारिस्थितिक पद्दति (Ecosystem): परिचय र प्रकार', E'पारिस्थितिक पद्दति (Ecosystem): परिचय र प्रकार', E'६.२', 'vatavaran-vigyan-2', 2),
    (v_topic_id, E'जनसांख्यिकीय, शहरीकरण र बसाईं सराई र असर', E'जनसांख्यिकीय, शहरीकरण र बसाईं सराई र असर', E'६.३', 'vatavaran-vigyan-3', 3),
    (v_topic_id, E'जैविक प्रविधि र वैकल्पिक उर्जा', E'जैविक प्रविधि र वैकल्पिक उर्जा', E'६.४', 'vatavaran-vigyan-4', 4),
    (v_topic_id, E'विज्ञान र प्रविधिको विकास', E'विज्ञान र प्रविधिको विकास', E'६.५', 'vatavaran-vigyan-5', 5)
  ON CONFLICT (topic_id, slug) DO UPDATE
    SET name=EXCLUDED.name, name_np=EXCLUDED.name_np, syllabus_ref=EXCLUDED.syllabus_ref, display_order=EXCLUDED.display_order;

  INSERT INTO public.topics (subject_id, name, slug, syllabus_ref, display_order)
  VALUES (v_subject_id, E'अन्तर्राष्ट्रिय सम्बन्ध तथा संघ/संस्था', 'antarrastriya-sambandha', E'७', 7)
  ON CONFLICT (subject_id, slug) DO UPDATE
    SET name=EXCLUDED.name, syllabus_ref=EXCLUDED.syllabus_ref, display_order=EXCLUDED.display_order
  RETURNING id INTO v_topic_id;
  INSERT INTO public.subtopics (topic_id, name, name_np, syllabus_ref, slug, display_order)
  VALUES
    (v_topic_id, E'संयुक्त राष्ट्रसंघ: यसका अंगहरू, विशिष्टीकृत संस्था र तिनका गतिविधिहरू', E'संयुक्त राष्ट्रसंघ: यसका अंगहरू, विशिष्टीकृत संस्था र तिनका गतिविधिहरू', E'७.१', 'antarrastriya-sambandha-1', 1),
    (v_topic_id, E'क्षेत्रीय संगठन: सार्क र विमस्टेक', E'क्षेत्रीय संगठन: सार्क र विमस्टेक', E'७.२', 'antarrastriya-sambandha-2', 2)
  ON CONFLICT (topic_id, slug) DO UPDATE
    SET name=EXCLUDED.name, name_np=EXCLUDED.name_np, syllabus_ref=EXCLUDED.syllabus_ref, display_order=EXCLUDED.display_order;

  INSERT INTO public.topics (subject_id, name, slug, syllabus_ref, display_order)
  VALUES (v_subject_id, E'राष्ट्रिय तथा अन्तर्राष्ट्रिय समसामयिक घटना', 'samsamayik', E'८', 8)
  ON CONFLICT (subject_id, slug) DO UPDATE
    SET name=EXCLUDED.name, syllabus_ref=EXCLUDED.syllabus_ref, display_order=EXCLUDED.display_order
  RETURNING id INTO v_topic_id;

  -- ═══ खण्ड ख · शिक्षासम्बन्धी आधारभूत ज्ञान  (40 अंक · 20 प्रश्न) ═══
  INSERT INTO public.subjects (module_id, name, name_np, slug, syllabus_ref, display_order, description)
  VALUES (v_module_id, E'शिक्षासम्बन्धी आधारभूत ज्ञान', E'शिक्षासम्बन्धी आधारभूत ज्ञान', 'khanda-kha-education', E'ख', 2, E'40 अंक · 20 प्रश्न')
  ON CONFLICT (module_id, slug) DO UPDATE
    SET name=EXCLUDED.name, name_np=EXCLUDED.name_np, syllabus_ref=EXCLUDED.syllabus_ref,
        display_order=EXCLUDED.display_order, description=EXCLUDED.description
  RETURNING id INTO v_subject_id;

  INSERT INTO public.topics (subject_id, name, slug, syllabus_ref, display_order)
  VALUES (v_subject_id, E'शिक्षाको परिचय र नेपालको शैक्षिक विकास', 'shiksha-parichaya', E'१', 1)
  ON CONFLICT (subject_id, slug) DO UPDATE
    SET name=EXCLUDED.name, syllabus_ref=EXCLUDED.syllabus_ref, display_order=EXCLUDED.display_order
  RETURNING id INTO v_topic_id;
  INSERT INTO public.subtopics (topic_id, name, name_np, syllabus_ref, slug, display_order)
  VALUES
    (v_topic_id, E'शिक्षाको अर्थ, परिभाषा, स्वरुप, उद्देश्यहरू र कार्यहरू', E'शिक्षाको अर्थ, परिभाषा, स्वरुप, उद्देश्यहरू र कार्यहरू', E'१.१', 'shiksha-parichaya-1', 1),
    (v_topic_id, E'नेपालको आधुनिक शैक्षिक इतिहास', E'नेपालको आधुनिक शैक्षिक इतिहास', E'१.२', 'shiksha-parichaya-2', 2),
    (v_topic_id, E'शैक्षिक संगठन र संरचना', E'शैक्षिक संगठन र संरचना', E'१.३', 'shiksha-parichaya-3', 3)
  ON CONFLICT (topic_id, slug) DO UPDATE
    SET name=EXCLUDED.name, name_np=EXCLUDED.name_np, syllabus_ref=EXCLUDED.syllabus_ref, display_order=EXCLUDED.display_order;

  INSERT INTO public.topics (subject_id, name, slug, syllabus_ref, display_order)
  VALUES (v_subject_id, E'शिक्षा मनोविज्ञान', 'shiksha-manovigyan', E'२', 2)
  ON CONFLICT (subject_id, slug) DO UPDATE
    SET name=EXCLUDED.name, syllabus_ref=EXCLUDED.syllabus_ref, display_order=EXCLUDED.display_order
  RETURNING id INTO v_topic_id;
  INSERT INTO public.subtopics (topic_id, name, name_np, syllabus_ref, slug, display_order)
  VALUES
    (v_topic_id, E'शिक्षा मनोविज्ञान: अर्थ, अवधारणा, आवश्यकता र महत्त्व', E'शिक्षा मनोविज्ञान: अर्थ, अवधारणा, आवश्यकता र महत्त्व', E'२.१', 'shiksha-manovigyan-1', 1),
    (v_topic_id, E'मानव विकास: वृद्धि र विकासको अवधारणा, चरण र विशेषता', E'मानव विकास: वृद्धि र विकासको अवधारणा, चरण र विशेषता', E'२.२', 'shiksha-manovigyan-2', 2),
    (v_topic_id, E'उत्तर बाल्यावस्था: विशेषता र देखापर्ने परिवर्तनहरू (शारीरिक, मानसिक, संवेगात्मक, सामाजिक), रुचिहरू', E'उत्तर बाल्यावस्था: विशेषता र देखापर्ने परिवर्तनहरू (शारीरिक, मानसिक, संवेगात्मक, सामाजिक), रुचिहरू', E'२.३', 'shiksha-manovigyan-3', 3),
    (v_topic_id, E'उत्तर बाल्यावस्थाका विद्यार्थीको सामाजिकीकरणमा शिक्षक र अभिभावकको भूमिका', E'उत्तर बाल्यावस्थाका विद्यार्थीको सामाजिकीकरणमा शिक्षक र अभिभावकको भूमिका', E'२.४', 'shiksha-manovigyan-4', 4)
  ON CONFLICT (topic_id, slug) DO UPDATE
    SET name=EXCLUDED.name, name_np=EXCLUDED.name_np, syllabus_ref=EXCLUDED.syllabus_ref, display_order=EXCLUDED.display_order;

  INSERT INTO public.topics (subject_id, name, slug, syllabus_ref, display_order)
  VALUES (v_subject_id, E'सिकाइ र प्रभाव पार्ने तत्वहरू', 'sikai-tatva', E'३', 3)
  ON CONFLICT (subject_id, slug) DO UPDATE
    SET name=EXCLUDED.name, syllabus_ref=EXCLUDED.syllabus_ref, display_order=EXCLUDED.display_order
  RETURNING id INTO v_topic_id;
  INSERT INTO public.subtopics (topic_id, name, name_np, syllabus_ref, slug, display_order)
  VALUES
    (v_topic_id, E'सिकाइ: परिचय, अर्थ, स्वरुप र प्रभाव पार्ने तत्वहरू', E'सिकाइ: परिचय, अर्थ, स्वरुप र प्रभाव पार्ने तत्वहरू', E'३.१', 'sikai-tatva-1', 1),
    (v_topic_id, E'सिकाइको स्थानान्तरण: अवधारणा, प्रकार, सिद्धान्त र प्रभाव पार्ने तत्वहरू', E'सिकाइको स्थानान्तरण: अवधारणा, प्रकार, सिद्धान्त र प्रभाव पार्ने तत्वहरू', E'३.२', 'sikai-tatva-2', 2),
    (v_topic_id, E'उत्प्रेरणा: अवधारणा, आवश्यकता र विद्यार्थीहरूमा उत्प्रेरणा जगाउने उपायहरू', E'उत्प्रेरणा: अवधारणा, आवश्यकता र विद्यार्थीहरूमा उत्प्रेरणा जगाउने उपायहरू', E'३.३', 'sikai-tatva-3', 3),
    (v_topic_id, E'पुनर्बल (Reinforcement): अवधारणा, प्रकार र प्रयोग', E'पुनर्बल (Reinforcement): अवधारणा, प्रकार र प्रयोग', E'३.४', 'sikai-tatva-4', 4)
  ON CONFLICT (topic_id, slug) DO UPDATE
    SET name=EXCLUDED.name, name_np=EXCLUDED.name_np, syllabus_ref=EXCLUDED.syllabus_ref, display_order=EXCLUDED.display_order;

  INSERT INTO public.topics (subject_id, name, slug, syllabus_ref, display_order)
  VALUES (v_subject_id, E'सिकाइ प्रकृया र सिकाइका सिद्धान्तहरू', 'sikai-siddhanta', E'४', 4)
  ON CONFLICT (subject_id, slug) DO UPDATE
    SET name=EXCLUDED.name, syllabus_ref=EXCLUDED.syllabus_ref, display_order=EXCLUDED.display_order
  RETURNING id INTO v_topic_id;
  INSERT INTO public.subtopics (topic_id, name, name_np, syllabus_ref, slug, display_order)
  VALUES
    (v_topic_id, E'सिकाइका सिद्धान्त: परिचय, विशेषता र शैक्षिक उपयोगिता', E'सिकाइका सिद्धान्त: परिचय, विशेषता र शैक्षिक उपयोगिता', E'४.१', 'sikai-siddhanta-1', 1),
    (v_topic_id, E'शास्त्रीय सम्बन्धन सिद्धान्त (Classical Conditioning Theory)', E'शास्त्रीय सम्बन्धन सिद्धान्त (Classical Conditioning Theory)', E'४.२', 'sikai-siddhanta-2', 2),
    (v_topic_id, E'कार्यपरक सम्बन्धन सिद्धान्त (Operant Conditioning Theory)', E'कार्यपरक सम्बन्धन सिद्धान्त (Operant Conditioning Theory)', E'४.३', 'sikai-siddhanta-3', 3)
  ON CONFLICT (topic_id, slug) DO UPDATE
    SET name=EXCLUDED.name, name_np=EXCLUDED.name_np, syllabus_ref=EXCLUDED.syllabus_ref, display_order=EXCLUDED.display_order;

  INSERT INTO public.topics (subject_id, name, slug, syllabus_ref, display_order)
  VALUES (v_subject_id, E'पाठ्यक्रम तथा पाठ्यपुस्तक', 'pathyakram', E'५', 5)
  ON CONFLICT (subject_id, slug) DO UPDATE
    SET name=EXCLUDED.name, syllabus_ref=EXCLUDED.syllabus_ref, display_order=EXCLUDED.display_order
  RETURNING id INTO v_topic_id;
  INSERT INTO public.subtopics (topic_id, name, name_np, syllabus_ref, slug, display_order)
  VALUES
    (v_topic_id, E'पाठ्यक्रमको परिचय, अवधारणा, उद्देश्य, क्षेत्र र क्रम', E'पाठ्यक्रमको परिचय, अवधारणा, उद्देश्य, क्षेत्र र क्रम', E'५.१', 'pathyakram-1', 1),
    (v_topic_id, E'राष्ट्रिय पाठ्यक्रम प्रारुप, २०७६', E'राष्ट्रिय पाठ्यक्रम प्रारुप, २०७६', E'५.२', 'pathyakram-2', 2),
    (v_topic_id, E'पाठ्यक्रममा विविधता व्यवस्थापन, स्थानीय पाठ्यक्रम, एकीकृत पाठ्यक्रम', E'पाठ्यक्रममा विविधता व्यवस्थापन, स्थानीय पाठ्यक्रम, एकीकृत पाठ्यक्रम', E'५.३', 'pathyakram-3', 3),
    (v_topic_id, E'पाठ्यक्रम, पाठ्यपुस्तक र शिक्षक निर्देशिका र सम्बन्ध', E'पाठ्यक्रम, पाठ्यपुस्तक र शिक्षक निर्देशिका र सम्बन्ध', E'५.४', 'pathyakram-4', 4)
  ON CONFLICT (topic_id, slug) DO UPDATE
    SET name=EXCLUDED.name, name_np=EXCLUDED.name_np, syllabus_ref=EXCLUDED.syllabus_ref, display_order=EXCLUDED.display_order;

  INSERT INTO public.topics (subject_id, name, slug, syllabus_ref, display_order)
  VALUES (v_subject_id, E'शिक्षण सिकाइको योजना, विधि र शिक्षण सामग्री', 'shikshan-yojana', E'६', 6)
  ON CONFLICT (subject_id, slug) DO UPDATE
    SET name=EXCLUDED.name, syllabus_ref=EXCLUDED.syllabus_ref, display_order=EXCLUDED.display_order
  RETURNING id INTO v_topic_id;
  INSERT INTO public.subtopics (topic_id, name, name_np, syllabus_ref, slug, display_order)
  VALUES
    (v_topic_id, E'शैक्षणिक योजना: अर्थ र आवश्यकता, वार्षिक कार्ययोजना, वार्षिक शैक्षणिक योजना, एकाइ योजना र दैनिक पाठयोजना', E'शैक्षणिक योजना: अर्थ र आवश्यकता, वार्षिक कार्ययोजना, वार्षिक शैक्षणिक योजना, एकाइ योजना र दैनिक पाठयोजना', E'६.१', 'shikshan-yojana-1', 1),
    (v_topic_id, E'शिक्षण सिकाइ विधि: शिक्षक केन्द्रीत, अन्तरक्रियात्मक र विद्यार्थी केन्द्रीत शिक्षण विधि', E'शिक्षण सिकाइ विधि: शिक्षक केन्द्रीत, अन्तरक्रियात्मक र विद्यार्थी केन्द्रीत शिक्षण विधि', E'६.२', 'shikshan-yojana-2', 2),
    (v_topic_id, E'शिक्षण सामग्री: अर्थ, वर्गीकरण, निर्माण, प्रयोग र भण्डारण', E'शिक्षण सामग्री: अर्थ, वर्गीकरण, निर्माण, प्रयोग र भण्डारण', E'६.३', 'shikshan-yojana-3', 3)
  ON CONFLICT (topic_id, slug) DO UPDATE
    SET name=EXCLUDED.name, name_np=EXCLUDED.name_np, syllabus_ref=EXCLUDED.syllabus_ref, display_order=EXCLUDED.display_order;

  INSERT INTO public.topics (subject_id, name, slug, syllabus_ref, display_order)
  VALUES (v_subject_id, E'मूल्याङ्कन र परीक्षा', 'mulyankan', E'७', 7)
  ON CONFLICT (subject_id, slug) DO UPDATE
    SET name=EXCLUDED.name, syllabus_ref=EXCLUDED.syllabus_ref, display_order=EXCLUDED.display_order
  RETURNING id INTO v_topic_id;
  INSERT INTO public.subtopics (topic_id, name, name_np, syllabus_ref, slug, display_order)
  VALUES
    (v_topic_id, E'मापन र मूल्याङ्कन बीच भिन्नता, मूल्याङ्कनका प्रकार, साधन र विशेषता', E'मापन र मूल्याङ्कन बीच भिन्नता, मूल्याङ्कनका प्रकार, साधन र विशेषता', E'७.१', 'mulyankan-1', 1),
    (v_topic_id, E'परीक्षाको अर्थ र प्रकार (विषयगत, वस्तुगत, स्तरीकृत र शिक्षक निर्मित)', E'परीक्षाको अर्थ र प्रकार (विषयगत, वस्तुगत, स्तरीकृत र शिक्षक निर्मित)', E'७.२', 'mulyankan-2', 2),
    (v_topic_id, E'प्रश्नपत्र निर्माण, विशिष्टिकरण तालिका, प्रश्नहरूको विश्लेषण, वैधता र विश्वसनीयता', E'प्रश्नपत्र निर्माण, विशिष्टिकरण तालिका, प्रश्नहरूको विश्लेषण, वैधता र विश्वसनीयता', E'७.३', 'mulyankan-3', 3),
    (v_topic_id, E'निरन्तर मूल्याङ्कन प्रणाली, अक्षराङ्कन पद्धति र नेपालको सन्दर्भमा यसको अवस्था', E'निरन्तर मूल्याङ्कन प्रणाली, अक्षराङ्कन पद्धति र नेपालको सन्दर्भमा यसको अवस्था', E'७.४', 'mulyankan-4', 4)
  ON CONFLICT (topic_id, slug) DO UPDATE
    SET name=EXCLUDED.name, name_np=EXCLUDED.name_np, syllabus_ref=EXCLUDED.syllabus_ref, display_order=EXCLUDED.display_order;

  INSERT INTO public.topics (subject_id, name, slug, syllabus_ref, display_order)
  VALUES (v_subject_id, E'शैक्षिक व्यवस्थापन र शैक्षणिक संगठन', 'shaikshik-byavasthapan', E'८', 8)
  ON CONFLICT (subject_id, slug) DO UPDATE
    SET name=EXCLUDED.name, syllabus_ref=EXCLUDED.syllabus_ref, display_order=EXCLUDED.display_order
  RETURNING id INTO v_topic_id;
  INSERT INTO public.subtopics (topic_id, name, name_np, syllabus_ref, slug, display_order)
  VALUES
    (v_topic_id, E'कक्षाकोठा व्यवस्थापन: अवधारणा, आवश्यकता र महत्त्व', E'कक्षाकोठा व्यवस्थापन: अवधारणा, आवश्यकता र महत्त्व', E'८.१', 'shaikshik-byavasthapan-1', 1),
    (v_topic_id, E'कक्षाकोठामा विविधता व्यवस्थापन: भाषिक, लैङ्गिक, अपाङ्गता, आर्थिक, सामाजिक र साँस्कृतिक', E'कक्षाकोठामा विविधता व्यवस्थापन: भाषिक, लैङ्गिक, अपाङ्गता, आर्थिक, सामाजिक र साँस्कृतिक', E'८.२', 'shaikshik-byavasthapan-2', 2),
    (v_topic_id, E'शैक्षणिक संगठन: कक्षा शिक्षण, बहुकक्षा शिक्षण, विषय शिक्षण, मिश्रित शिक्षण', E'शैक्षणिक संगठन: कक्षा शिक्षण, बहुकक्षा शिक्षण, विषय शिक्षण, मिश्रित शिक्षण', E'८.३', 'shaikshik-byavasthapan-3', 3),
    (v_topic_id, E'विद्यालयमा द्वन्द्व व्यवस्थापन, विपद् व्यवस्थापन, सङ्कट व्यवस्थापन', E'विद्यालयमा द्वन्द्व व्यवस्थापन, विपद् व्यवस्थापन, सङ्कट व्यवस्थापन', E'८.४', 'shaikshik-byavasthapan-4', 4)
  ON CONFLICT (topic_id, slug) DO UPDATE
    SET name=EXCLUDED.name, name_np=EXCLUDED.name_np, syllabus_ref=EXCLUDED.syllabus_ref, display_order=EXCLUDED.display_order;

  INSERT INTO public.topics (subject_id, name, slug, syllabus_ref, display_order)
  VALUES (v_subject_id, E'शिक्षक पेशागत विकास र शैक्षिक अनुसन्धान', 'shikshak-peshagat-vikas', E'९', 9)
  ON CONFLICT (subject_id, slug) DO UPDATE
    SET name=EXCLUDED.name, syllabus_ref=EXCLUDED.syllabus_ref, display_order=EXCLUDED.display_order
  RETURNING id INTO v_topic_id;
  INSERT INTO public.subtopics (topic_id, name, name_np, syllabus_ref, slug, display_order)
  VALUES
    (v_topic_id, E'शिक्षक तालिम र क्षमता विकास', E'शिक्षक तालिम र क्षमता विकास', E'९.१', 'shikshak-peshagat-vikas-1', 1),
    (v_topic_id, E'शैक्षिक अनुसन्धान: अर्थ, आवश्यकता र महत्त्व', E'शैक्षिक अनुसन्धान: अर्थ, आवश्यकता र महत्त्व', E'९.२', 'shikshak-peshagat-vikas-2', 2),
    (v_topic_id, E'घटना अध्ययन र कार्यमूलक अनुसन्धान: उद्देश्य र प्रयोग', E'घटना अध्ययन र कार्यमूलक अनुसन्धान: उद्देश्य र प्रयोग', E'९.३', 'shikshak-peshagat-vikas-3', 3)
  ON CONFLICT (topic_id, slug) DO UPDATE
    SET name=EXCLUDED.name, name_np=EXCLUDED.name_np, syllabus_ref=EXCLUDED.syllabus_ref, display_order=EXCLUDED.display_order;

  -- ═══ खण्ड ग · सूचना तथा सञ्चार प्रविधि  (10 अंक · 5 प्रश्न) ═══
  INSERT INTO public.subjects (module_id, name, name_np, slug, syllabus_ref, display_order, description)
  VALUES (v_module_id, E'सूचना तथा सञ्चार प्रविधि', E'सूचना तथा सञ्चार प्रविधि', 'khanda-ga-ict', E'ग', 3, E'10 अंक · 5 प्रश्न')
  ON CONFLICT (module_id, slug) DO UPDATE
    SET name=EXCLUDED.name, name_np=EXCLUDED.name_np, syllabus_ref=EXCLUDED.syllabus_ref,
        display_order=EXCLUDED.display_order, description=EXCLUDED.description
  RETURNING id INTO v_subject_id;

  INSERT INTO public.topics (subject_id, name, slug, syllabus_ref, display_order)
  VALUES (v_subject_id, E'कम्प्युटर: परिचय, प्रकार, हार्डवेयर, सफ्टवेयर र अफिस प्याकेज, इमेल, इन्टरनेट', 'computer', E'१', 1)
  ON CONFLICT (subject_id, slug) DO UPDATE
    SET name=EXCLUDED.name, syllabus_ref=EXCLUDED.syllabus_ref, display_order=EXCLUDED.display_order
  RETURNING id INTO v_topic_id;

  INSERT INTO public.topics (subject_id, name, slug, syllabus_ref, display_order)
  VALUES (v_subject_id, E'विद्यालयमा प्रयोग गरिने साधारण सफ्टवेयर सम्बन्धी आधारभूत ज्ञान', 'school-software', E'२', 2)
  ON CONFLICT (subject_id, slug) DO UPDATE
    SET name=EXCLUDED.name, syllabus_ref=EXCLUDED.syllabus_ref, display_order=EXCLUDED.display_order
  RETURNING id INTO v_topic_id;

  INSERT INTO public.topics (subject_id, name, slug, syllabus_ref, display_order)
  VALUES (v_subject_id, E'शिक्षण सिकाइमा ICT को प्रयोग (श्रव्य-दृश्य र अन्तरक्रियात्मक डिजिटल सामग्री, ई-पुस्तकालय), विकास र व्यवस्थापन', 'ict-teaching', E'३', 3)
  ON CONFLICT (subject_id, slug) DO UPDATE
    SET name=EXCLUDED.name, syllabus_ref=EXCLUDED.syllabus_ref, display_order=EXCLUDED.display_order
  RETURNING id INTO v_topic_id;

  INSERT INTO public.topics (subject_id, name, slug, syllabus_ref, display_order)
  VALUES (v_subject_id, E'साइबर अपराध र सुरक्षा सम्बन्धी आधारभूत ज्ञान', 'cyber-security', E'४', 4)
  ON CONFLICT (subject_id, slug) DO UPDATE
    SET name=EXCLUDED.name, syllabus_ref=EXCLUDED.syllabus_ref, display_order=EXCLUDED.display_order
  RETURNING id INTO v_topic_id;

  -- ═══ खण्ड घ · संविधान, शिक्षा सम्बन्धी ऐन तथा नियमहरू  (10 अंक · 5 प्रश्न) ═══
  INSERT INTO public.subjects (module_id, name, name_np, slug, syllabus_ref, display_order, description)
  VALUES (v_module_id, E'संविधान, शिक्षा सम्बन्धी ऐन तथा नियमहरू', E'संविधान, शिक्षा सम्बन्धी ऐन तथा नियमहरू', 'khanda-gha-law', E'घ', 4, E'10 अंक · 5 प्रश्न')
  ON CONFLICT (module_id, slug) DO UPDATE
    SET name=EXCLUDED.name, name_np=EXCLUDED.name_np, syllabus_ref=EXCLUDED.syllabus_ref,
        display_order=EXCLUDED.display_order, description=EXCLUDED.description
  RETURNING id INTO v_subject_id;

  INSERT INTO public.topics (subject_id, name, slug, syllabus_ref, display_order)
  VALUES (v_subject_id, E'नेपालको संविधान (मौलिक हक र राज्यका निर्देशक सिद्धान्तहरू)', 'samvidhan', E'१', 1)
  ON CONFLICT (subject_id, slug) DO UPDATE
    SET name=EXCLUDED.name, syllabus_ref=EXCLUDED.syllabus_ref, display_order=EXCLUDED.display_order
  RETURNING id INTO v_topic_id;

  INSERT INTO public.topics (subject_id, name, slug, syllabus_ref, display_order)
  VALUES (v_subject_id, E'शिक्षा ऐन, २०२८', 'shiksha-ain-2028', E'२', 2)
  ON CONFLICT (subject_id, slug) DO UPDATE
    SET name=EXCLUDED.name, syllabus_ref=EXCLUDED.syllabus_ref, display_order=EXCLUDED.display_order
  RETURNING id INTO v_topic_id;

  INSERT INTO public.topics (subject_id, name, slug, syllabus_ref, display_order)
  VALUES (v_subject_id, E'शिक्षा नियमावली, २०५९', 'shiksha-niyamavali-2059', E'३', 3)
  ON CONFLICT (subject_id, slug) DO UPDATE
    SET name=EXCLUDED.name, syllabus_ref=EXCLUDED.syllabus_ref, display_order=EXCLUDED.display_order
  RETURNING id INTO v_topic_id;

  INSERT INTO public.topics (subject_id, name, slug, syllabus_ref, display_order)
  VALUES (v_subject_id, E'शिक्षक सेवा आयोग नियमावली, २०५७', 'tsc-niyamavali-2057', E'४', 4)
  ON CONFLICT (subject_id, slug) DO UPDATE
    SET name=EXCLUDED.name, syllabus_ref=EXCLUDED.syllabus_ref, display_order=EXCLUDED.display_order
  RETURNING id INTO v_topic_id;

  INSERT INTO public.topics (subject_id, name, slug, syllabus_ref, display_order)
  VALUES (v_subject_id, E'स्थानीय सरकार सञ्चालन ऐन, २०७४ (शिक्षा सम्बन्धी)', 'sthaniya-sarkar-2074', E'५', 5)
  ON CONFLICT (subject_id, slug) DO UPDATE
    SET name=EXCLUDED.name, syllabus_ref=EXCLUDED.syllabus_ref, display_order=EXCLUDED.display_order
  RETURNING id INTO v_topic_id;

  -- ═══ खण्ड ङ · सामान्य बौद्धिक परीक्षण  (10 अंक · 5 प्रश्न) ═══
  INSERT INTO public.subjects (module_id, name, name_np, slug, syllabus_ref, display_order, description)
  VALUES (v_module_id, E'सामान्य बौद्धिक परीक्षण', E'सामान्य बौद्धिक परीक्षण', 'khanda-nga-iq', E'ङ', 5, E'10 अंक · 5 प्रश्न')
  ON CONFLICT (module_id, slug) DO UPDATE
    SET name=EXCLUDED.name, name_np=EXCLUDED.name_np, syllabus_ref=EXCLUDED.syllabus_ref,
        display_order=EXCLUDED.display_order, description=EXCLUDED.description
  RETURNING id INTO v_subject_id;

  INSERT INTO public.topics (subject_id, name, slug, syllabus_ref, display_order)
  VALUES (v_subject_id, E'शाब्दिक बौद्धिक परीक्षण (Verbal Intelligence Test)', 'verbal', E'१', 1)
  ON CONFLICT (subject_id, slug) DO UPDATE
    SET name=EXCLUDED.name, syllabus_ref=EXCLUDED.syllabus_ref, display_order=EXCLUDED.display_order
  RETURNING id INTO v_topic_id;
  INSERT INTO public.subtopics (topic_id, name, name_np, syllabus_ref, slug, display_order)
  VALUES
    (v_topic_id, E'शब्द ज्ञान परीक्षण (Word knowledge tests)', E'शब्द ज्ञान परीक्षण (Word knowledge tests)', E'१.१', 'verbal-1', 1),
    (v_topic_id, E'समरूपता (Analogies)', E'समरूपता (Analogies)', E'१.२', 'verbal-2', 2),
    (v_topic_id, E'शाब्दिक वर्गीकरण (Verbal Classification)', E'शाब्दिक वर्गीकरण (Verbal Classification)', E'१.३', 'verbal-3', 3),
    (v_topic_id, E'विपरीतार्थक, समानार्थी (Antonyms, Synonyms)', E'विपरीतार्थक, समानार्थी (Antonyms, Synonyms)', E'१.४', 'verbal-4', 4),
    (v_topic_id, E'शाब्दिक पजलहरू, अमिल्दा शब्दहरू (Verbal Puzzles, Jumbled Words)', E'शाब्दिक पजलहरू, अमिल्दा शब्दहरू (Verbal Puzzles, Jumbled Words)', E'१.५', 'verbal-5', 5)
  ON CONFLICT (topic_id, slug) DO UPDATE
    SET name=EXCLUDED.name, name_np=EXCLUDED.name_np, syllabus_ref=EXCLUDED.syllabus_ref, display_order=EXCLUDED.display_order;

  INSERT INTO public.topics (subject_id, name, slug, syllabus_ref, display_order)
  VALUES (v_subject_id, E'गणितीय क्षमता (Mathematical Ability)', 'mathematical', E'२', 2)
  ON CONFLICT (subject_id, slug) DO UPDATE
    SET name=EXCLUDED.name, syllabus_ref=EXCLUDED.syllabus_ref, display_order=EXCLUDED.display_order
  RETURNING id INTO v_topic_id;
  INSERT INTO public.subtopics (topic_id, name, name_np, syllabus_ref, slug, display_order)
  VALUES
    (v_topic_id, E'श्रेणीक्रम समस्याहरू (Series Problems)', E'श्रेणीक्रम समस्याहरू (Series Problems)', E'२.१', 'mathematical-1', 1),
    (v_topic_id, E'छुटेका सङ्ख्याहरू पुरा गर्ने (Fill in the Missing Numbers)', E'छुटेका सङ्ख्याहरू पुरा गर्ने (Fill in the Missing Numbers)', E'२.२', 'mathematical-2', 2),
    (v_topic_id, E'गणितीय पजलहरू (Mathematical Puzzles)', E'गणितीय पजलहरू (Mathematical Puzzles)', E'२.३', 'mathematical-3', 3)
  ON CONFLICT (topic_id, slug) DO UPDATE
    SET name=EXCLUDED.name, name_np=EXCLUDED.name_np, syllabus_ref=EXCLUDED.syllabus_ref, display_order=EXCLUDED.display_order;

  INSERT INTO public.topics (subject_id, name, slug, syllabus_ref, display_order)
  VALUES (v_subject_id, E'स्थानिक तथा प्रत्यक्षात्मक क्षमता (Spatial and Perceptual Ability)', 'spatial', E'३', 3)
  ON CONFLICT (subject_id, slug) DO UPDATE
    SET name=EXCLUDED.name, syllabus_ref=EXCLUDED.syllabus_ref, display_order=EXCLUDED.display_order
  RETURNING id INTO v_topic_id;
  INSERT INTO public.subtopics (topic_id, name, name_np, syllabus_ref, slug, display_order)
  VALUES
    (v_topic_id, E'Coding-Decoding', E'Coding-Decoding', E'३.१', 'spatial-1', 1),
    (v_topic_id, E'Matrix Reasoning', E'Matrix Reasoning', E'३.२', 'spatial-2', 2),
    (v_topic_id, E'Picture Completion', E'Picture Completion', E'३.३', 'spatial-3', 3),
    (v_topic_id, E'Odd One Out', E'Odd One Out', E'३.४', 'spatial-4', 4)
  ON CONFLICT (topic_id, slug) DO UPDATE
    SET name=EXCLUDED.name, name_np=EXCLUDED.name_np, syllabus_ref=EXCLUDED.syllabus_ref, display_order=EXCLUDED.display_order;

  -- Reposition the Phase-1 practice section after the 5 खण्ड
  UPDATE public.subjects SET display_order = 6
  WHERE module_id = v_module_id AND slug = 'abhyas';

  RAISE NOTICE 'Nimavi syllabus: % subjects, % topics, % subtopics', 5, 29, 66;
END $$;
