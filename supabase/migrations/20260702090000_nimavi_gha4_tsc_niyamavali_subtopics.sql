-- Add subtopics under निमावि प्रथम पत्र खण्ड घ · टपिक ४ शिक्षक सेवा आयोग नियमावली, २०५७ (topic id ced477be-47df-4849-af09-6f1d593cd180).
DO $$
DECLARE
  v_topic_id uuid := 'ced477be-47df-4849-af09-6f1d593cd180'::uuid;
BEGIN
  INSERT INTO public.subtopics (topic_id, name, name_np, syllabus_ref, slug, display_order)
  VALUES
    (v_topic_id, E'आयोगको गठन, अधिकार र समावेशीकरण', E'आयोगको गठन, अधिकार र समावेशीकरण', E'४.१', 'tsc-niyamavali-1', 1),
    (v_topic_id, E'खुला प्रतियोगितात्मक परीक्षा र बढुवा प्रक्रिया', E'खुला प्रतियोगितात्मक परीक्षा र बढुवा प्रक्रिया', E'४.२', 'tsc-niyamavali-2', 2)
  ON CONFLICT (topic_id, slug) DO UPDATE
    SET name = EXCLUDED.name, name_np = EXCLUDED.name_np, syllabus_ref = EXCLUDED.syllabus_ref, display_order = EXCLUDED.display_order;
END $$;
