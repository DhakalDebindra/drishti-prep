-- ════════════════════════════════════════════════════════════════════
-- DrishtiPrep — Second-pass fix for broken pair questions
-- Generated: 2026-06-02
--
-- Triage across all 1837 imported questions found 2 more legitimately
-- broken match-pair stems (besides the 3 fixed in 20260602110000 +
-- 20260602120000). Both are in Aasman daily GK imports.
--
-- All UPDATEs scoped by explanation LIKE — never content alone — per the
-- lesson learned from 20260602120000.
--
-- Fix 1 — Daily GK 2082/09/08: legislature × constitution pairing
--   Options A=a2,b1,c4,d3 + explanation uniquely determine the mapping.
--   FULL deterministic reconstruction.
--
-- Fix 2 — Daily GK 2082/09/02: "which date pair is wrong" with bare क/ख/ग/घ
--   options. Explanation bolds the CORRECT ई-भिसा date (२०८० माघ २६),
--   signalling option घ (the answer) was the wrong date pair. The 3
--   correct-date facts in the explanation become options क/ख/ग.
--   PARTIAL reconstruction — the WRONG date in option घ is fabricated
--   (using २०८० माघ १६ — plausible-close-but-wrong).
-- ════════════════════════════════════════════════════════════════════

DO $$
DECLARE
  v_temp int;
  v_total int := 0;
BEGIN
  -- Fix 1: legislature ↔ constitution match-pair question
  UPDATE public.questions
  SET content = E'जोडा मिलाउनुहोस् र सही उत्तर छान्नुहोस्:\nव्यवस्थापिका: (a) व्यवस्थापिका संसद, (b) राष्ट्रिय पञ्चायत, (c) राष्ट्रिय सभा, (d) महासभा\nसम्बन्धित संविधान: 1. नेपालको संविधान, २०१९, 2. नेपालको अन्तरिम संविधान, २०६३, 3. नेपाल अधिराज्यको संविधान, २०१५, 4. नेपाल अधिराज्यको संविधान, २०४७'
  WHERE content = E'जोडा मिलाउनुहोस् र सही उत्तर छान्नुहोस्।'
    AND explanation LIKE E'%व्यवस्थापिका संसद नेपालको अन्तरिम संविधान%';
  GET DIAGNOSTICS v_temp = ROW_COUNT;
  v_total := v_total + v_temp;
  RAISE NOTICE 'Fix 1 (legislature × constitution): % row(s)', v_temp;

  -- Fix 2: wrong-date-pair question (बारे क/ख/ग/घ options)
  -- Pairs क, ख, ग derived from the 3 non-bolded explanation facts (all correct dates).
  -- Pair घ shows ई-भिसा paired with a fabricated wrong date (real = २०८० माघ २६).
  UPDATE public.questions
  SET content = E'देहायका जोडा मध्ये कुन मिति गलत रहेको छ?\nक. भूमि समस्या समाधान आयोग खारेज — वि.सं. २०७८ असोज २३\nख. इजरायल-हमास युद्धविराम सम्झौता लागू — सन् २०२२ अक्टोबर ११\nग. कोशी प्रदेश पर्यटन वर्ष २०८२ घोषणा — वि.सं. २०८१ चैत २७\nघ. ई-भिसा सेवा शुभारम्भ — वि.सं. २०८० माघ १६'
  WHERE content = E'देहायका जोडा मध्ये कुन मिति गलत रहेको छ?'
    AND explanation LIKE E'%ई-भिसा सेवाको शुभारम्भ%';
  GET DIAGNOSTICS v_temp = ROW_COUNT;
  v_total := v_total + v_temp;
  RAISE NOTICE 'Fix 2 (wrong-date pair, ई-भिसा): % row(s)', v_temp;

  RAISE NOTICE 'Total questions fixed in second pass: %', v_total;
END $$;
