-- Restructure निमावि टपिक ८ (राष्ट्रिय तथा अन्तर्राष्ट्रिय समसामयिक घटना, id 949d456e-f7e6-41e0-9bf9-a6098032eaa4):
-- 1) add the missing real-curriculum subtopic ८.१ हालसालैका राजनीतिक/सामाजिक/आर्थिक/वैज्ञानिक घटना
-- 2) consolidate the 4 source-named subtopics (आसमान/गोरखापत्र/लोकसेवा/दैनिक-समाचार) into one ८.२ स्रोत आधारित अभ्यास,
--    re-pointing the existing shared question_set_modules links (canonical sets stay owned by Everything GK; only the
--    Nimavi-side display subtopic changes), then remove the 4 now-unused Nimavi-only subtopic rows.
DO $$
DECLARE
  v_topic_id uuid := '949d456e-f7e6-41e0-9bf9-a6098032eaa4'::uuid;
  v_module_id uuid := '6695669a-f40e-421a-a4ec-b09bbeaf56c4'::uuid;
  v_halsalaka_id uuid;
  v_srota_id uuid;
  v_old_ids uuid[] := ARRAY[
    '37a40d08-b4f5-4d67-8f2a-e5c3ea6fa01a'::uuid, -- nimavi-aasman-collection
    '13bf3fa3-98c4-424c-b82c-5528f2b0f7eb'::uuid, -- nimavi-gorkhapatra
    '70bd8962-304f-4ede-88b9-ed1ca0749c7f'::uuid, -- nimavi-psc-publications
    '2aa6567f-a379-44be-bbf3-9cde4c4a2146'::uuid  -- nimavi-daily-news-digest
  ];
BEGIN
  INSERT INTO public.subtopics (topic_id, name, name_np, syllabus_ref, slug, display_order)
  VALUES
    (v_topic_id, E'हालसालैका राजनीतिक, सामाजिक, आर्थिक र वैज्ञानिक घटना', E'हालसालैका राजनीतिक, सामाजिक, आर्थिक र वैज्ञानिक घटना', E'८.१', 'halsalaka-ghatana', 1),
    (v_topic_id, E'स्रोत आधारित अभ्यास', E'स्रोत आधारित अभ्यास', E'८.२', 'srota-aadharit-abhyas', 2)
  ON CONFLICT (topic_id, slug) DO UPDATE
    SET name = EXCLUDED.name, name_np = EXCLUDED.name_np, syllabus_ref = EXCLUDED.syllabus_ref, display_order = EXCLUDED.display_order;

  SELECT id INTO v_halsalaka_id FROM public.subtopics WHERE topic_id = v_topic_id AND slug = 'halsalaka-ghatana';
  SELECT id INTO v_srota_id FROM public.subtopics WHERE topic_id = v_topic_id AND slug = 'srota-aadharit-abhyas';

  -- Re-point the shared source links to the new consolidated subtopic.
  UPDATE public.question_set_modules
  SET subtopic_id = v_srota_id
  WHERE module_id = v_module_id AND subtopic_id = ANY(v_old_ids);

  -- The 4 old Nimavi-only subtopic rows are now unused (never had their own question_sets; only held module-link
  -- pointers, all just moved above) — safe to remove rather than leave as dead empty cards in the course UI.
  DELETE FROM public.subtopics WHERE id = ANY(v_old_ids);

  RAISE NOTICE 'क-8 restructure complete: added 8.1/8.2, re-pointed source links, removed 4 unused subtopics.';
END $$;
