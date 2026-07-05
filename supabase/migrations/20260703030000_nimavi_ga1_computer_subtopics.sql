-- Add subtopics under निमावि प्रथम पत्र खण्ड ग · टपिक १ कम्प्युटर: परिचय, प्रकार, हार्डवेयर, सफ्टवेयर र अफिस प्याकेज, इमेल, इन्टरनेट (topic id 3550276d-035c-4369-8511-78c34093d306).
DO $$
DECLARE
  v_topic_id uuid := '3550276d-035c-4369-8511-78c34093d306'::uuid;
BEGIN
  INSERT INTO public.subtopics (topic_id, name, name_np, syllabus_ref, slug, display_order)
  VALUES
    (v_topic_id, E'कम्प्युटरको इतिहास, पुस्ता र प्रकार', E'कम्प्युटरको इतिहास, पुस्ता र प्रकार', E'१.१', 'computer-1', 1),
    (v_topic_id, E'हार्डवेयर: इनपुट, आउटपुट, CPU र मेमोरी', E'हार्डवेयर: इनपुट, आउटपुट, CPU र मेमोरी', E'१.२', 'computer-2', 2),
    (v_topic_id, E'सफ्टवेयर, अपरेटिङ सिस्टम र अफिस प्याकेज', E'सफ्टवेयर, अपरेटिङ सिस्टम र अफिस प्याकेज', E'१.३', 'computer-3', 3),
    (v_topic_id, E'इन्टरनेट, नेटवर्क र सामान्य शब्दावली', E'इन्टरनेट, नेटवर्क र सामान्य शब्दावली', E'१.४', 'computer-4', 4)
  ON CONFLICT (topic_id, slug) DO UPDATE
    SET name = EXCLUDED.name, name_np = EXCLUDED.name_np, syllabus_ref = EXCLUDED.syllabus_ref, display_order = EXCLUDED.display_order;
END $$;
