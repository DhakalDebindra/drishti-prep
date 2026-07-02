-- Add subtopics under निमावि प्रथम पत्र खण्ड घ · टपिक १ नेपालको संविधान (topic id 38021473-9cb4-45f3-8719-3a141424b498).
DO $$
DECLARE
  v_topic_id uuid := '38021473-9cb4-45f3-8719-3a141424b498'::uuid;
BEGIN
  INSERT INTO public.subtopics (topic_id, name, name_np, syllabus_ref, slug, display_order)
  VALUES
    (v_topic_id, E'मौलिक हक', E'मौलिक हक', E'१.१', 'samvidhan-1', 1),
    (v_topic_id, E'राज्यका निर्देशक सिद्धान्त, नीति तथा नागरिकको कर्तव्य', E'राज्यका निर्देशक सिद्धान्त, नीति तथा नागरिकको कर्तव्य', E'१.२', 'samvidhan-2', 2),
    (v_topic_id, E'राज्य संरचना: व्यवस्थापिका, कार्यपालिका र न्यायपालिका', E'राज्य संरचना: व्यवस्थापिका, कार्यपालिका र न्यायपालिका', E'१.३', 'samvidhan-3', 3)
  ON CONFLICT (topic_id, slug) DO UPDATE
    SET name = EXCLUDED.name, name_np = EXCLUDED.name_np, syllabus_ref = EXCLUDED.syllabus_ref, display_order = EXCLUDED.display_order;
END $$;
