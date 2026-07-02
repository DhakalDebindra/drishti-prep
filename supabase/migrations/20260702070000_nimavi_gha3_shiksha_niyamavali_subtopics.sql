-- Add subtopics under निमावि प्रथम पत्र खण्ड घ · टपिक ३ शिक्षा नियमावली, २०५९ (topic id af1b68f3-8f5e-4735-8f1e-3e5960ba3403).
DO $$
DECLARE
  v_topic_id uuid := 'af1b68f3-8f5e-4735-8f1e-3e5960ba3403'::uuid;
BEGIN
  INSERT INTO public.subtopics (topic_id, name, name_np, syllabus_ref, slug, display_order)
  VALUES
    (v_topic_id, E'विद्यालय व्यवस्थापन समिति, प्रधानाध्यापक र जिल्ला शिक्षा समिति', E'विद्यालय व्यवस्थापन समिति, प्रधानाध्यापक र जिल्ला शिक्षा समिति', E'३.१', 'shiksha-niyamavali-1', 1),
    (v_topic_id, E'शिक्षक सेवा-शर्त: विदा, आचारसंहिता र सजाय', E'शिक्षक सेवा-शर्त: विदा, आचारसंहिता र सजाय', E'३.२', 'shiksha-niyamavali-2', 2),
    (v_topic_id, E'विद्यालय दर्ता, वर्गीकरण, कोष र सम्पत्ति व्यवस्थापन', E'विद्यालय दर्ता, वर्गीकरण, कोष र सम्पत्ति व्यवस्थापन', E'३.३', 'shiksha-niyamavali-3', 3),
    (v_topic_id, E'राष्ट्रिय परीक्षा बोर्ड, भर्ना र शैक्षिक सत्र व्यवस्था', E'राष्ट्रिय परीक्षा बोर्ड, भर्ना र शैक्षिक सत्र व्यवस्था', E'३.४', 'shiksha-niyamavali-4', 4)
  ON CONFLICT (topic_id, slug) DO UPDATE
    SET name = EXCLUDED.name, name_np = EXCLUDED.name_np, syllabus_ref = EXCLUDED.syllabus_ref, display_order = EXCLUDED.display_order;
END $$;
