-- Add subtopics under निमावि प्रथम पत्र खण्ड ग · टपिक ४ साइबर अपराध र सुरक्षा सम्बन्धी आधारभूत ज्ञान (topic id 53492ac2-434b-4c11-bb7f-bec8f7ebe83b).
DO $$
DECLARE
  v_topic_id uuid := '53492ac2-434b-4c11-bb7f-bec8f7ebe83b'::uuid;
BEGIN
  INSERT INTO public.subtopics (topic_id, name, name_np, syllabus_ref, slug, display_order)
  VALUES
    (v_topic_id, E'साइबर सुरक्षा सामान्य शब्दावली', E'साइबर सुरक्षा सामान्य शब्दावली', E'४.१', 'cyber-1', 1),
    (v_topic_id, E'विद्युतीय कारोबार ऐन, २०६३ र साइबर कसुर-सजाय', E'विद्युतीय कारोबार ऐन, २०६३ र साइबर कसुर-सजाय', E'४.२', 'cyber-2', 2)
  ON CONFLICT (topic_id, slug) DO UPDATE
    SET name = EXCLUDED.name, name_np = EXCLUDED.name_np, syllabus_ref = EXCLUDED.syllabus_ref, display_order = EXCLUDED.display_order;
END $$;
