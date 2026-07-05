-- Add ग-३ शिक्षण सिकाइमा ICT को प्रयोग part-2 subtopics (topic id d3a2cc9d-8360-4348-8f7c-07b7c0544f2e).
DO $$
DECLARE
  v_topic_id uuid := 'd3a2cc9d-8360-4348-8f7c-07b7c0544f2e'::uuid;
BEGIN
  INSERT INTO public.subtopics (topic_id, name, name_np, syllabus_ref, slug, display_order)
  VALUES
    (v_topic_id, E'LMS, मूल्याङ्कन टुल र कृत्रिम बौद्धिकता', E'LMS, मूल्याङ्कन टुल र कृत्रिम बौद्धिकता', E'३.४', 'ict-teaching-4', 4),
    (v_topic_id, E'नेपालको ICT नीति, शिक्षक पेसागत विकास र उन्नत डिजिटल सुरक्षा', E'नेपालको ICT नीति, शिक्षक पेसागत विकास र उन्नत डिजिटल सुरक्षा', E'३.५', 'ict-teaching-5', 5),
    (v_topic_id, E'फाइल फर्म्याट, व्यावहारिक ज्ञान र किबोर्ड सर्टकट', E'फाइल फर्म्याट, व्यावहारिक ज्ञान र किबोर्ड सर्टकट', E'३.६', 'ict-teaching-6', 6)
  ON CONFLICT (topic_id, slug) DO UPDATE
    SET name = EXCLUDED.name, name_np = EXCLUDED.name_np, syllabus_ref = EXCLUDED.syllabus_ref, display_order = EXCLUDED.display_order;
END $$;
