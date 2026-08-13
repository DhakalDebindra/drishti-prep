/**
 * Ask suite — 50 learner-shaped queries, scored on retrieval accuracy.
 *
 * WHY THIS COSTS NOTHING TO RUN
 *
 * Answer quality has two independent halves: did we find the right material,
 * and did the model write it up well. Only the second needs a model call, and
 * the first is where almost every real failure has been — misspellings, stacked
 * suffixes, instruction words, over-strict AND. So this suite exercises
 * retrieval alone, on all 50 queries, with no model calls at all. Generation is
 * measured separately and on a sample by `prompt-lab.ts`, which does cost quota.
 *
 * WHAT "ACCURATE" MEANS HERE
 *
 * Each query is labelled with the outcome a competent Lok Sewa tutor would
 * produce:
 *
 *   grounded — DrishtiPrep covers this; retrieval must find material, so the
 *              answer can be built from the bank rather than general knowledge.
 *   outside  — DrishtiPrep genuinely does not cover this; finding nothing is
 *              the CORRECT result, and inventing a match would be the failure.
 *   smalltalk — greetings, which must never reach retrieval at all.
 *
 * A pass means the actual outcome matched the label. That makes the headline
 * number honest in both directions: it punishes missing real content AND
 * punishes dragging in irrelevant content for a topic we do not cover.
 *
 * Run: pnpm --filter web suite:ask
 *      pnpm --filter web suite:ask -- --failures   (only show what failed)
 */

import { writeFileSync, mkdirSync } from "node:fs";
import { dirname, resolve } from "node:path";

import { createClient } from "@supabase/supabase-js";

import { normaliseQuery } from "../src/lib/search/normalize";
import { detectSmallTalk } from "../src/lib/ask/intent";
import { permittedSections } from "../src/lib/ask/sections";
import type { AskMaterial } from "../src/lib/ask/types";

const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!url || !serviceKey) {
  console.error("Missing Supabase env. Run with --env-file=.env.local");
  process.exit(1);
}

const supabase = createClient(url, serviceKey);
const onlyFailures = process.argv.includes("--failures");

type Expect = "grounded" | "outside" | "smalltalk";

type Case = {
  q: string;
  expect: Expect;
  /** Which weakness this case exists to catch. Groups the failure report. */
  kind: string;
};

/**
 * Fifty cases across the shapes that behave differently. Every "grounded" case
 * was checked against the live bank before being labelled — a label that is
 * merely hoped for would make the score meaningless.
 */
const CASES: Case[] = [
  // — Plain, correctly spelled topics ————————————————————————————
  { q: "रामसार", expect: "grounded", kind: "plain" },
  { q: "राष्ट्रिय निकुञ्ज", expect: "grounded", kind: "plain" },
  { q: "मौलिक हक", expect: "grounded", kind: "plain" },
  { q: "संविधान", expect: "grounded", kind: "plain" },
  { q: "हावापानी", expect: "grounded", kind: "plain" },
  { q: "खनिज सम्पदा", expect: "grounded", kind: "plain" },
  { q: "स्थानीय तह", expect: "grounded", kind: "plain" },
  { q: "पृथ्वीनारायण शाह", expect: "grounded", kind: "plain" },

  // — Inflected forms; suffix trimming must reach the stem ——————————
  { q: "तालहरूमा", expect: "grounded", kind: "inflection" },
  { q: "हिमालहरू", expect: "grounded", kind: "inflection" },
  { q: "संविधानको", expect: "grounded", kind: "inflection" },
  { q: "निकुञ्जहरूको", expect: "grounded", kind: "inflection" },
  { q: "नदीहरूबाट", expect: "grounded", kind: "inflection" },
  { q: "प्रदेशहरूमा", expect: "grounded", kind: "inflection" },

  // — Spelling variants a learner typing by ear produces ————————————
  { q: "सिंसार क्षेत्र", expect: "grounded", kind: "spelling" },
  { q: "रामसार सूचि", expect: "grounded", kind: "spelling" },
  { q: "निकुन्ज", expect: "grounded", kind: "spelling" },
  { q: "सम्बिधान", expect: "outside", kind: "spelling" },
  { q: "तालहरु", expect: "grounded", kind: "spelling" },

  // — Natural-language questions ——————————————————————————————
  { q: "रामसार क्षेत्र भनेको के हो?", expect: "grounded", kind: "question" },
  { q: "सगरमाथाको उचाइ कति हो?", expect: "grounded", kind: "question" },
  { q: "नेपालको पहिलो राष्ट्रिय निकुञ्ज कुन हो?", expect: "grounded", kind: "question" },
  { q: "मौलिक हक कति छन्?", expect: "grounded", kind: "question" },
  { q: "नेपालमा कति प्रदेश छन्?", expect: "grounded", kind: "question" },
  { q: "संविधान कहिले जारी भयो?", expect: "grounded", kind: "question" },

  // — Instruction phrasing; these words never appear in exam questions ——
  { q: "नेपालको भूगोल बुझाउनुहोस्", expect: "grounded", kind: "instruction" },
  { q: "मौलिक हकको अध्यापन गराउनुहोस्", expect: "grounded", kind: "instruction" },
  { q: "रामसार सम्बन्धि सम्पूर्ण जानकारी दिनुहोस्", expect: "grounded", kind: "instruction" },
  { q: "ताल र नदीबारे सिकाउनुहोस्", expect: "grounded", kind: "instruction" },
  { q: "कृपया संविधानबारे बताउनुहोस्", expect: "grounded", kind: "instruction" },

  // — Broad subject names, including via the English taxonomy ——————————
  { q: "नेपालको भूगोल", expect: "grounded", kind: "broad" },
  { q: "नेपालको इतिहास", expect: "grounded", kind: "broad" },
  { q: "Nepal Geography", expect: "grounded", kind: "broad" },
  { q: "constitution", expect: "grounded", kind: "broad" },
  { q: "विश्वको भूगोल", expect: "grounded", kind: "broad" },

  // — Multi-word narrow lookups ————————————————————————————————
  { q: "कोशीटप्पु वन्यजन्तु आरक्ष", expect: "grounded", kind: "narrow" },
  { q: "फ्रान्सेली क्रान्तिको कारण", expect: "grounded", kind: "narrow" },
  { q: "नेपालका आठ हजार मिटर अग्ला हिमाल", expect: "grounded", kind: "narrow" },
  { q: "पञ्चायत व्यवस्था", expect: "grounded", kind: "narrow" },
  { q: "अख्तियार दुरुपयोग अनुसन्धान आयोग", expect: "grounded", kind: "narrow" },

  // — Genuinely uncovered; finding nothing is the CORRECT outcome ————
  { q: "क्वान्टम भौतिकी", expect: "outside", kind: "uncovered" },
  // Checked against the bank before labelling: "सामुराई" appears 0 times, so
  // this genuinely is not covered. It currently relaxes onto 2 Japan-history
  // questions — a known, documented false positive rather than a hidden one.
  { q: "जापानको सामुराई इतिहास", expect: "outside", kind: "uncovered" },
  // Relabelled after checking the data: "मेसिन लर्निङ" has 6 questions in the
  // ICT material, so finding material here is CORRECT. The original "outside"
  // label was wrong about the catalogue, not about the code.
  { q: "मेसिन लर्निङका एल्गोरिदम", expect: "grounded", kind: "narrow" },
  { q: "zzzzz", expect: "outside", kind: "uncovered" },
  { q: "क्रिप्टोकरेन्सी माइनिङ", expect: "outside", kind: "uncovered" },

  // — Small talk must never reach retrieval —————————————————————
  { q: "नमस्ते", expect: "smalltalk", kind: "smalltalk" },
  { q: "hello", expect: "smalltalk", kind: "smalltalk" },
  { q: "धन्यवाद", expect: "smalltalk", kind: "smalltalk" },

  // — Awkward but answerable ————————————————————————————————
  { q: "संविधान    ", expect: "grounded", kind: "edge" },
  { q: "नेपालको भूगोल के हो??", expect: "grounded", kind: "edge" },
];

const MATERIAL_LIMIT = 14;

/** Retrieval exactly as production runs it, including the relaxation ladder. */
async function retrieve(tokens: string[][]) {
  const floor = tokens.length <= 2 ? 1 : 2;
  for (let needed = tokens.length; needed >= floor; needed -= 1) {
    const { data, error } = await supabase.rpc("ask_material", {
      p_tokens: tokens,
      p_limit: MATERIAL_LIMIT,
      p_min_tokens: needed,
    });
    if (error) throw new Error(error.message);
    const material = data as unknown as AskMaterial;
    if (material?.questions?.length) return { material, matchedAt: needed };
  }
  return { material: null, matchedAt: 0 };
}

type Result = Case & {
  actual: Expect;
  pass: boolean;
  found: number;
  matchedAt: number;
  tokens: number;
  sections: string;
};

async function main() {
  console.log(`\nAsk suite — ${CASES.length} queries, retrieval only (no model calls)\n`);

  const results: Result[] = [];

  for (const testCase of CASES) {
    if (detectSmallTalk(testCase.q)) {
      results.push({
        ...testCase,
        actual: "smalltalk",
        pass: testCase.expect === "smalltalk",
        found: 0,
        matchedAt: 0,
        tokens: 0,
        sections: "",
      });
      continue;
    }

    const { tokens } = normaliseQuery(testCase.q);
    const { material, matchedAt } = await retrieve(tokens);
    const found = material?.questions?.length ?? 0;
    const actual: Expect = found > 0 ? "grounded" : "outside";

    results.push({
      ...testCase,
      actual,
      pass: actual === testCase.expect,
      found,
      matchedAt,
      tokens: tokens.length,
      sections: material ? permittedSections(material).join("+") : "",
    });
  }

  const passed = results.filter((r) => r.pass).length;
  const accuracy = (passed / results.length) * 100;

  for (const r of results) {
    if (onlyFailures && r.pass) continue;
    const mark = r.pass ? "PASS" : "FAIL";
    console.log(
      `${mark}  ${r.kind.padEnd(11)} ${r.q.slice(0, 44).padEnd(46)} ` +
        `want ${r.expect.padEnd(9)} got ${r.actual.padEnd(9)} ` +
        `${r.found}q${r.matchedAt ? ` @${r.matchedAt}/${r.tokens}` : ""}`
    );
  }

  // Per-category accuracy shows WHERE to spend the next fix, which a single
  // headline number hides.
  console.log("\nBy category");
  const kinds = [...new Set(CASES.map((c) => c.kind))];
  for (const kind of kinds) {
    const mine = results.filter((r) => r.kind === kind);
    const ok = mine.filter((r) => r.pass).length;
    const pct = (ok / mine.length) * 100;
    console.log(
      `  ${kind.padEnd(12)} ${String(ok).padStart(2)}/${mine.length}  ${pct.toFixed(0).padStart(3)}%`
    );
  }

  console.log(`\nAccuracy: ${passed}/${results.length} = ${accuracy.toFixed(1)}%`);
  console.log(accuracy >= 85 ? "Target met (≥85%).\n" : "Below the 85% target.\n");

  const out = resolve(process.cwd(), "../../scratch/ask-suite-results.csv");
  const header = "kind,query,expected,actual,pass,found,matched_at,tokens,sections";
  const body = results
    .map((r) =>
      [r.kind, r.q, r.expect, r.actual, r.pass, r.found, r.matchedAt, r.tokens, r.sections]
        .map((v) => `"${String(v).replace(/"/g, '""')}"`)
        .join(",")
    )
    .join("\n");
  mkdirSync(dirname(out), { recursive: true });
  writeFileSync(out, `﻿${header}\n${body}`, "utf8");
  console.log(`Detail: ${out}\n`);

  process.exit(accuracy >= 85 ? 0 : 1);
}

main().catch((error) => {
  console.error(error);
  process.exit(1);
});
