-- Add subtopics under निमावि प्रथम पत्र खण्ड ग · टपिक २ विद्यालयमा प्रयोग गरिने साधारण सफ्टवेयर सम्बन्धी आधारभूत ज्ञान (topic id f2406808-49ed-4b71-b2e7-cb2e4d8967a5).
DO $$
DECLARE
  v_topic_id uuid := 'f2406808-49ed-4b71-b2e7-cb2e4d8967a5'::uuid;
BEGIN
  INSERT INTO public.subtopics (topic_id, name, name_np, syllabus_ref, slug, display_order)
  VALUES
    (v_topic_id, E'IEMIS को परिचय, लगइन र विद्यार्थी ट्र्याकिङ', E'IEMIS को परिचय, लगइन र विद्यार्थी ट्र्याकिङ', E'२.१', 'iemis-1', 1),
    (v_topic_id, E'फ्ल्यास रिपोर्ट, शिक्षक व्यवस्थापन र भौतिक पूर्वाधार मोड्युल', E'फ्ल्यास रिपोर्ट, शिक्षक व्यवस्थापन र भौतिक पूर्वाधार मोड्युल', E'२.२', 'iemis-2', 2),
    (v_topic_id, E'तथ्याङ्क सूचकांक, प्राविधिक पक्ष र सरोकारवाला भूमिका', E'तथ्याङ्क सूचकांक, प्राविधिक पक्ष र सरोकारवाला भूमिका', E'२.३', 'iemis-3', 3)
  ON CONFLICT (topic_id, slug) DO UPDATE
    SET name = EXCLUDED.name, name_np = EXCLUDED.name_np, syllabus_ref = EXCLUDED.syllabus_ref, display_order = EXCLUDED.display_order;
END $$;
