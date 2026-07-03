-- Add a subtopic for the very recent शिक्षा नियमावली दशौं संशोधन, २०८३ under निमावि प्रथम पत्र खण्ड घ · टपिक ३ शिक्षा नियमावली (topic id af1b68f3-8f5e-4735-8f1e-3e5960ba3403).
DO $$
DECLARE
  v_topic_id uuid := 'af1b68f3-8f5e-4735-8f1e-3e5960ba3403'::uuid;
BEGIN
  INSERT INTO public.subtopics (topic_id, name, name_np, syllabus_ref, slug, display_order)
  VALUES
    (v_topic_id, E'दशौं संशोधन, २०८३ का प्रमुख परिवर्तनहरू', E'दशौं संशोधन, २०८३ का प्रमुख परिवर्तनहरू', E'३.५', 'shiksha-niyamavali-5', 5)
  ON CONFLICT (topic_id, slug) DO UPDATE
    SET name = EXCLUDED.name, name_np = EXCLUDED.name_np, syllabus_ref = EXCLUDED.syllabus_ref, display_order = EXCLUDED.display_order;
END $$;
