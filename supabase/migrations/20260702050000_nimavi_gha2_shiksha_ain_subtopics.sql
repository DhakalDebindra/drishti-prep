-- Add subtopics under निमावि प्रथम पत्र खण्ड घ · टपिक २ शिक्षा ऐन, २०२८ (topic id 4e931234-3a51-422d-b861-caf5849aafc8).
DO $$
DECLARE
  v_topic_id uuid := '4e931234-3a51-422d-b861-caf5849aafc8'::uuid;
BEGIN
  INSERT INTO public.subtopics (topic_id, name, name_np, syllabus_ref, slug, display_order)
  VALUES
    (v_topic_id, E'ऐनको परिचय, शिक्षाको माध्यम र विद्यालय वर्गीकरण', E'ऐनको परिचय, शिक्षाको माध्यम र विद्यालय वर्गीकरण', E'२.१', 'shiksha-ain-1', 1),
    (v_topic_id, E'शिक्षक व्यवस्था, समिति संरचना र विद्यालय प्रशासन', E'शिक्षक व्यवस्था, समिति संरचना र विद्यालय प्रशासन', E'२.२', 'shiksha-ain-2', 2)
  ON CONFLICT (topic_id, slug) DO UPDATE
    SET name = EXCLUDED.name, name_np = EXCLUDED.name_np, syllabus_ref = EXCLUDED.syllabus_ref, display_order = EXCLUDED.display_order;
END $$;
