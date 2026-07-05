-- ════════════════════════════════════════════════════════════════════
-- DrishtiPrep — Apply descriptive titles to Nepal Geography sets
-- Generated: 2026-06-02
--
-- The previous rename (20260602090000) used the generic `[subtopic] set 1`
-- pattern. Switching to descriptive learner-facing titles that follow the
-- house style established by `अवस्थिति र सीमासम्बन्धि आधारभूत जानकारि`.
--
-- The Location/Borders set was hand-curated previously and is left alone.
-- Only the 11 sets still on the `set 1` pattern are updated here.
-- ════════════════════════════════════════════════════════════════════

DO $$
DECLARE
  v_count int;
BEGIN
  WITH renames(old_title, new_title) AS (
    VALUES
      (E'भू-आकृति set 1',               E'भू-आकृति र भौतिक विभाजनसम्बन्धि जानकारि'),
      (E'हिमाल set 1',                  E'हिमालय शृङ्खला र अग्ला चुलीहरू'),
      (E'नदी set 1',                    E'नदी प्रणाली र जलाधार क्षेत्रहरू'),
      (E'ताल set 1',                    E'ताल, दह र कुण्डहरूको परिचय'),
      (E'प्रदेश र जिल्ला set 1',        E'प्रदेश र जिल्लाहरूको प्रशासनिक संरचना'),
      (E'स्थानीय तह set 1',             E'स्थानीय तहहरूको वर्गीकरण र संरचना'),
      (E'जनगणना set 1',                 E'राष्ट्रिय जनगणना २०७८ का प्रमुख तथ्यहरू'),
      (E'कृषि र वन set 1',              E'कृषि, माटो र वन सम्पदा'),
      (E'जलविद्युत र खनिज set 1',       E'जलविद्युत आयोजना र खनिज स्रोतहरू'),
      (E'पर्यटन र यातायात set 1',       E'पर्यटकीय स्थल, यातायात र पूर्वाधार'),
      (E'जलवायु र संरक्षित क्षेत्र set 1', E'हावापानी, ऋतु र संरक्षित क्षेत्रहरू')
  )
  UPDATE public.question_sets qs
  SET title = r.new_title
  FROM renames r
  WHERE qs.title = r.old_title;

  GET DIAGNOSTICS v_count = ROW_COUNT;
  RAISE NOTICE 'Renamed % Nepal Geography sets to descriptive titles', v_count;
END $$;
