/**
 * Retrieval evaluation for learner search.
 *
 * Runs real learner-shaped queries through the actual path — normaliseQuery()
 * then the search_content() RPC — against the live database, and prints what
 * comes back. This is the check that matters: search quality is decided here,
 * not in the interface, and a page built on bad retrieval cannot be rescued by
 * design.
 *
 * Run: pnpm --filter web eval:search
 */

import { createClient } from "@supabase/supabase-js";

import { normaliseQuery } from "../src/lib/search/normalize";

const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
const key = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

if (!url || !key) {
  console.error(
    "Missing NEXT_PUBLIC_SUPABASE_URL / NEXT_PUBLIC_SUPABASE_ANON_KEY. " +
      "Run with --env-file=.env.local"
  );
  process.exit(1);
}

const supabase = createClient(url, key);

type Expectation = {
  query: string;
  /** A set title fragment that must appear in the top 3, when we know one. */
  expectTop?: string;
  /** True when the right answer is "we have nothing on this". */
  expectEmpty?: boolean;
};

/**
 * Queries chosen to cover the shapes learners actually type: bare subjects,
 * inflected forms, multi-word phrases, English, and things we genuinely do not
 * cover. The expectations come from reading the live catalogue, not from what
 * the code happens to do.
 */
const CASES: Expectation[] = [
  { query: "नेपालको भूगोल", expectTop: "" },
  { query: "नेपाल भूगोल", expectTop: "" },
  { query: "भूगोल", expectTop: "" },
  { query: "सगरमाथा", expectTop: "हिमाल" },
  { query: "सगरमाथाको उचाइ", expectTop: "हिमाल" },
  { query: "हिमालहरू", expectTop: "हिमाल" },
  { query: "नेपालका ताल", expectTop: "ताल" },
  { query: "तालहरूमा", expectTop: "ताल" },
  { query: "नदी प्रणाली", expectTop: "नदी" },
  { query: "रामसार", expectTop: "रामसार" },
  { query: "राष्ट्रिय निकुञ्ज", expectTop: "निकुञ्ज" },
  { query: "राष्ट्रिय निकुञ्जहरू", expectTop: "निकुञ्ज" },
  { query: "खनिज सम्पदा", expectTop: "खनिज" },
  { query: "हावापानी", expectTop: "हावापानी" },
  { query: "वनस्पति", expectTop: "वन" },
  { query: "प्रदेश र जिल्ला", expectTop: "प्रदेश" },
  { query: "स्थानीय तह", expectTop: "स्थानीय तह" },
  { query: "संविधान", expectTop: "संविधान" },
  // No set is titled प्रस्तावना, so the right answer is the constitutional sets
  // whose questions cover it — there is nothing better to rank first.
  { query: "संविधानको प्रस्तावना", expectTop: "" },
  { query: "मौलिक हक", expectTop: "मौलिक हक" },
  { query: "नेपालको इतिहास", expectTop: "" },
  { query: "पृथ्वीनारायण शाह", expectTop: "" },
  { query: "राणाकाल", expectTop: "राणा" },
  { query: "Nepal Geography", expectTop: "" },
  { query: "constitution", expectTop: "" },
  { query: "नेपालको भूगोल के हो", expectTop: "" },
  { query: "सगरमाथाको उचाइ कति हो?", expectTop: "हिमाल" },
  // Genuinely uncovered subjects must come back empty rather than plausible.
  { query: "क्वान्टम भौतिकी", expectEmpty: true },
  // World History covers this; an inflected multi-word query must still find it.
  { query: "फ्रान्सेली क्रान्तिको कारण", expectTop: "फ्रान्सेली" },
  { query: "zzzzz", expectEmpty: true },
  // Covered, though only just: exactly one question mentions ब्लकचेन. A search
  // that returns it is correct; an earlier expectation of "empty" here was
  // wrong about the catalogue, not about the code.
  { query: "ब्लकचेन", expectTop: "ICT" },
];

type Row = {
  counts: { subjects: number; topics: number; sets: number; questions: number };
  sets: { title: string; q_count: number; match_count: number }[];
  topics: { name: string }[];
};

async function runOne(entry: Expectation) {
  const { tokens } = normaliseQuery(entry.query);

  if (tokens.length === 0) {
    return { entry, tokens, data: null as Row | null, relaxed: false };
  }

  const { data, error } = await supabase.rpc("search_content", {
    p_tokens: tokens,
    p_subject_id: null,
    p_topic_id: null,
    p_set_limit: 3,
    p_set_offset: 0,
    p_q_limit: 3,
    p_require_all: true,
  });

  if (error) throw new Error(`${entry.query}: ${error.message}`);

  return { entry, tokens, data: data as unknown as Row };
}

async function main() {
  let passed = 0;
  let failed = 0;

  console.log("\nDrishtiPrep search — retrieval evaluation\n");

  for (const entry of CASES) {
    const started = Date.now();
    const { tokens, data } = await runOne(entry);
    const ms = Date.now() - started;

    const counts = data?.counts ?? { subjects: 0, topics: 0, sets: 0, questions: 0 };
    const titles = (data?.sets ?? []).map((s) => s.title);
    const isEmpty = counts.sets === 0 && counts.questions === 0 && counts.topics === 0;

    let verdict = "ok";
    if (entry.expectEmpty && !isEmpty) {
      verdict = "FAIL expected no results";
    } else if (!entry.expectEmpty && isEmpty) {
      verdict = "FAIL expected results";
    } else if (
      entry.expectTop &&
      !titles.some((t) => t.includes(entry.expectTop as string))
    ) {
      verdict = `FAIL top3 missing "${entry.expectTop}"`;
    }

    if (verdict === "ok") passed += 1;
    else failed += 1;

    const tokenSummary = tokens.map((t) => t.join("/")).join(" + ") || "(none)";

    console.log(
      `${verdict === "ok" ? "PASS" : "FAIL"}  ${entry.query}\n` +
        `      tokens: ${tokenSummary}\n` +
        `      ${counts.sets} sets · ${counts.questions} questions · ` +
        `${counts.topics} topics · ${ms}ms\n` +
        (titles.length
          ? titles.map((t, i) => `      ${i + 1}. ${t}`).join("\n") + "\n"
          : "") +
        (verdict === "ok" ? "" : `      -> ${verdict}\n`)
    );
  }

  console.log(`\n${passed} passed, ${failed} failed, ${CASES.length} total\n`);
  process.exit(failed > 0 ? 1 : 0);
}

main().catch((error) => {
  console.error(error);
  process.exit(1);
});
