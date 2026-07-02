-- Add subtopics under निमावि प्रथम पत्र खण्ड घ · टपिक ५ स्थानीय सरकार सञ्चालन ऐन, २०७४ (topic id 5990f855-fa68-49f4-8585-afe97511b950).
DO $$
DECLARE
  v_topic_id uuid := '5990f855-fa68-49f4-8585-afe97511b950'::uuid;
BEGIN
  INSERT INTO public.subtopics (topic_id, name, name_np, syllabus_ref, slug, display_order)
  VALUES
    (v_topic_id, E'गाउँपालिका र नगरपालिकाको शिक्षा सम्बन्धी अधिकार', E'गाउँपालिका र नगरपालिकाको शिक्षा सम्बन्धी अधिकार', E'५.१', 'sthaniya-sarkar-1', 1),
    (v_topic_id, E'वडा समितिको शिक्षा सम्बन्धी कार्य र ऐनको सामान्य परिचय', E'वडा समितिको शिक्षा सम्बन्धी कार्य र ऐनको सामान्य परिचय', E'५.२', 'sthaniya-sarkar-2', 2)
  ON CONFLICT (topic_id, slug) DO UPDATE
    SET name = EXCLUDED.name, name_np = EXCLUDED.name_np, syllabus_ref = EXCLUDED.syllabus_ref, display_order = EXCLUDED.display_order;
END $$;
