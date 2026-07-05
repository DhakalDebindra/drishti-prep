-- Add subtopics under निमावि प्रथम पत्र खण्ड ग · टपिक ३ शिक्षण सिकाइमा ICT को प्रयोग (topic id d3a2cc9d-8360-4348-8f7c-07b7c0544f2e).
DO $$
DECLARE
  v_topic_id uuid := 'd3a2cc9d-8360-4348-8f7c-07b7c0544f2e'::uuid;
BEGIN
  INSERT INTO public.subtopics (topic_id, name, name_np, syllabus_ref, slug, display_order)
  VALUES
    (v_topic_id, E'ICT को अवधारणा, महत्व र इ-लर्निङ', E'ICT को अवधारणा, महत्व र इ-लर्निङ', E'३.१', 'ict-teaching-1', 1),
    (v_topic_id, E'शिक्षण सामग्री, अफिस प्याकेज र सञ्चार उपकरण', E'शिक्षण सामग्री, अफिस प्याकेज र सञ्चार उपकरण', E'३.२', 'ict-teaching-2', 2),
    (v_topic_id, E'सिकाइ सिद्धान्त, मूल्याङ्कन र अनलाइन सुरक्षा', E'सिकाइ सिद्धान्त, मूल्याङ्कन र अनलाइन सुरक्षा', E'३.३', 'ict-teaching-3', 3)
  ON CONFLICT (topic_id, slug) DO UPDATE
    SET name = EXCLUDED.name, name_np = EXCLUDED.name_np, syllabus_ref = EXCLUDED.syllabus_ref, display_order = EXCLUDED.display_order;
END $$;
