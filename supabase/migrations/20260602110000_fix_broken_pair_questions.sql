-- ════════════════════════════════════════════════════════════════════
-- DrishtiPrep — Fix two Nepal Geography questions with missing pairs
-- Generated: 2026-06-02
--
-- Two questions in the 20260602080000 import had stems referencing
-- "तल केहि जोडाहुरू दिइएको छ" / "जोडा मिलाउनुहोस्" but the actual pairs
-- table was lost during CSV extraction from Aasman's source material.
-- Without the pairs, the question is unsolvable from text alone.
--
-- Fix 1 (नदी set) — reconstructed from explanation: the answer key D
-- (a3, b4, c1, d2) plus the explanation's river→source pairs uniquely
-- determine both lists.
--
-- Fix 2 (अवस्थिति set) — partial reconstruction. Correct values for pairs
-- 1 & 4 are known from the explanation; for pairs 2 & 3 the original
-- wrong values are lost so plausible close-but-wrong distractors are
-- fabricated (५४,३६२ वर्गमाइल and ६१.६ गुणा).
-- ════════════════════════════════════════════════════════════════════

DO $$
DECLARE
  v_count int := 0;
  v_temp int;
BEGIN
  -- Fix 1: नदी set — bare "जोडा मिलाउनुहोस्।" stem
  UPDATE public.questions
  SET content = E'जोडा मिलाउनुहोस्:\nनदी: (a) दरौंदी, (b) बुढी गण्डकी, (c) मर्स्याङ्दी, (d) बुढी गंगा\nउद्गमस्थल: 1. दामोदर हिमाल, 2. जगदुल्ला ताल, 3. बुद्ध हिमाल, 4. गणेश हिमाल'
  WHERE content = E'जोडा मिलाउनुहोस्।';
  GET DIAGNOSTICS v_temp = ROW_COUNT;
  v_count := v_count + v_temp;
  RAISE NOTICE 'Fix 1 (नदी जोडा): % row(s) updated', v_temp;

  -- Fix 2: अवस्थिति set — area-pairs stem missing the inline table
  UPDATE public.questions
  SET content = E'नेपालको क्षेत्रफलका सम्बन्धमा तल केहि जोडाहुरू दिइएको छ। उक्त जोडाको अध्ययन गरी गलत जोडाहुरू कुन-कुन हुन्? पत्ता लगाउनुहोस्।\n1. क्षेत्रफल — १,४७,१८१ वर्ग कि.मि.\n2. वर्गमाइलमा क्षेत्रफल — ५४,३६२\n3. चीनभन्दा — ६१.६ गुणा सानो\n4. भारतभन्दा — २२.३३ गुणा सानो'
  WHERE content = E'नेपालको क्षेत्रफलका सम्बन्धमा तल केहि जोडाहुहरु दिइएको छ। उक्त जोडाको अध्ययन गरी गलत जोडाहुहरु कुन-कुन हुन? पत्ता लगाउनुहोस्।';
  GET DIAGNOSTICS v_temp = ROW_COUNT;
  v_count := v_count + v_temp;
  RAISE NOTICE 'Fix 2 (अवस्थिति क्षेत्रफल): % row(s) updated', v_temp;

  RAISE NOTICE 'Total questions fixed: %', v_count;
END $$;
