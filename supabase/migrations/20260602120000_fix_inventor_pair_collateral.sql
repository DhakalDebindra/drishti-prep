-- ════════════════════════════════════════════════════════════════════
-- DrishtiPrep — Correct collateral damage from 20260602110000
-- Generated: 2026-06-02
--
-- The previous fix (20260602110000) used a content-based UPDATE
-- that matched any question with the bare 'जोडा मिलाउनुहोस्।' stem.
-- That hit THREE rows: the intended नदी question (rewrite was correct)
-- and TWO daily GK rows. One of those (daily_gk_2082_09_02) is actually
-- an INVENTORS question — its explanation lists Gutenberg, Cooper, Nobel,
-- Baird — not rivers. My river-content rewrite was wrong for it.
--
-- The other daily GK row (2082_09_08) IS a river-source question with
-- the same broken stem — that rewrite IS correct, so it stays.
--
-- Reconstruction for the inventors question, using:
--   correct_option = B = '१ग, २क, ३घ, ४ख'
--   explanation pairs Gutenberg-press, Cooper-mobile, Nobel-dynamite, Baird-TV
-- → 1=छापाखाना(ग=गुटेनबर्ग), 2=मोबाइल(क=कुपर), 3=डाइनामाइट(घ=नोबेल), 4=टेलिभिजन(ख=वियर्ड)
-- ════════════════════════════════════════════════════════════════════

DO $$
DECLARE
  v_count int;
BEGIN
  -- Target: the daily_gk_2082_09_02 inventor-pair question, currently
  -- holding the wrong river-content rewrite. Re-identify it by its
  -- (correct) inventor-focused explanation, which 20260602110000 did NOT touch.
  UPDATE public.questions
  SET content = E'जोडा मिलाउनुहोस्:\nआविष्कार: 1. छापाखाना, 2. मोबाइल फोन, 3. डाइनामाइट, 4. टेलिभिजन\nआविष्कारक: क. मार्टिन कुपर, ख. जोन वियर्ड, ग. जोहानेस गुटेनबर्ग, घ. अल्फ्रेड नोबेल'
  WHERE explanation LIKE E'**छापाखानाको आविष्कारक जोहानेस गुटेनबर्ग%'
    AND correct_option = 'B';
  GET DIAGNOSTICS v_count = ROW_COUNT;
  RAISE NOTICE 'Inventor-pair reconstruction: % row(s) corrected', v_count;
END $$;
