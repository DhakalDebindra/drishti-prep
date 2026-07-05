-- ════════════════════════════════════════════════════════════════════
-- DrishtiPrep — Rename Nepal Geography sets
-- Generated: 2026-06-02
--
-- The previous import (20260602080000) titled sets with "आसमान सङ्ग्रह — …"
-- which incorrectly credits Aasman as the source. Aasman content has its
-- own dedicated section (Current Affairs → स्रोत-आधारित अभ्यास →
-- आसमान सर सङ्ग्रह). Sets under the canonical Nepal Geography taxonomy
-- represent DrishtiPrep's own authentic content and should not carry
-- third-party attribution in the title.
--
-- Renaming the 12 sets to the existing live convention: `[subtopic_np] set N`
-- (matches e.g. "नेपालको धर्म र संस्क्रिति set 2").
-- ════════════════════════════════════════════════════════════════════

DO $$
DECLARE
  v_count int;
BEGIN
  WITH renames(old_title, new_title) AS (
    VALUES
      (E'आसमान सङ्ग्रह — अवस्थिति र सीमा',        E'अवस्थिति र सीमा set 1'),
      (E'आसमान सङ्ग्रह — भू-आकृति',               E'भू-आकृति set 1'),
      (E'आसमान सङ्ग्रह — हिमाल',                  E'हिमाल set 1'),
      (E'आसमान सङ्ग्रह — नदी',                    E'नदी set 1'),
      (E'आसमान सङ्ग्रह — ताल',                    E'ताल set 1'),
      (E'आसमान सङ्ग्रह — प्रदेश र जिल्ला',        E'प्रदेश र जिल्ला set 1'),
      (E'आसमान सङ्ग्रह — स्थानीय तह',             E'स्थानीय तह set 1'),
      (E'आसमान सङ्ग्रह — जनगणना',                 E'जनगणना set 1'),
      (E'आसमान सङ्ग्रह — कृषि र वन',              E'कृषि र वन set 1'),
      (E'आसमान सङ्ग्रह — जलविद्युत र खनिज',       E'जलविद्युत र खनिज set 1'),
      (E'आसमान सङ्ग्रह — पर्यटन र यातायात',       E'पर्यटन र यातायात set 1'),
      (E'आसमान सङ्ग्रह — जलवायु र संरक्षित क्षेत्र', E'जलवायु र संरक्षित क्षेत्र set 1')
  )
  UPDATE public.question_sets qs
  SET title = r.new_title
  FROM renames r
  WHERE qs.title = r.old_title;

  GET DIAGNOSTICS v_count = ROW_COUNT;
  RAISE NOTICE 'Renamed % Nepal Geography sets', v_count;
END $$;
