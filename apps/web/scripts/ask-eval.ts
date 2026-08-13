/**
 * Lesson evaluation for "Chat with DrishtiPrep AI".
 *
 * Runs the real pipeline — normaliseQuery → ask_material → section gates →
 * the real prompt → the real model → the grounding check — and reports what
 * came back. This is where the hallucination defence is actually proven: a
 * section gate that works in unit tests but lets the model wander in practice
 * is worth nothing.
 *
 * Run: pnpm --filter web eval:ask
 */

import { GoogleGenerativeAI } from "@google/generative-ai";
import { createClient } from "@supabase/supabase-js";

import { normaliseQuery } from "../src/lib/search/normalize";
import { buildLessonPrompt } from "../src/lib/ask/prompt";
import { modelSections, permittedSections } from "../src/lib/ask/sections";
import type { AskMaterial } from "../src/lib/ask/types";

const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
const geminiKey = process.env.GEMINI_API_KEY;

if (!url || !serviceKey || !geminiKey) {
  console.error(
    "Missing NEXT_PUBLIC_SUPABASE_URL / SUPABASE_SERVICE_ROLE_KEY / GEMINI_API_KEY. " +
      "Run with --env-file=.env.local"
  );
  process.exit(1);
}

const supabase = createClient(url, serviceKey);
const genAI = new GoogleGenerativeAI(geminiKey);
const model = genAI.getGenerativeModel({
  model: process.env.GEMINI_MODEL_FLASH || "gemini-2.5-flash",
  generationConfig: { responseMimeType: "application/json", temperature: 0.2 },
});

type Case = {
  query: string;
  /** True when DrishtiPrep genuinely has nothing and no lesson should be built. */
  expectInsufficient?: boolean;
};

const CASES: Case[] = [
  { query: "रामसार क्षेत्र भनेको के हो?" },
  { query: "नेपालका प्रमुख ताल" },
  { query: "सगरमाथाको उचाइ" },
  { query: "मौलिक हक" },
  { query: "राष्ट्रिय निकुञ्ज" },
  { query: "क्वान्टम भौतिकी", expectInsufficient: true },
];

/** Devanagari presence, as a crude but effective "answered in Nepali" check. */
function isNepali(text: string): boolean {
  const devanagari = (text.match(/[ऀ-ॿ]/g) ?? []).length;
  return devanagari > text.replace(/\s/g, "").length * 0.5;
}

async function runCase(entry: Case) {
  const { tokens } = normaliseQuery(entry.query);
  const failures: string[] = [];

  const { data, error } = await supabase.rpc("ask_material", {
    p_tokens: tokens,
    // Must match MATERIAL_LIMIT in lib/ask/lesson.ts, or this measures a
    // pipeline the learner never runs.
    p_limit: 10,
  });
  if (error) throw new Error(`${entry.query}: ${error.message}`);

  const material = data as unknown as AskMaterial;
  const permitted = permittedSections(material);
  const toWrite = modelSections(permitted);

  if (entry.expectInsufficient) {
    if (material.questions.length > 0) {
      failures.push(`expected no material, got ${material.questions.length} questions`);
    }
    return { entry, material, permitted, failures, lesson: null as any };
  }

  if (toWrite.length === 0) {
    failures.push("no sections permitted — expected a lesson");
    return { entry, material, permitted, failures, lesson: null as any };
  }

  const prompt = buildLessonPrompt(entry.query, material.questions, toWrite);
  const result = await model.generateContent(prompt);
  const raw = result.response.text();

  let lesson: any;
  try {
    lesson = JSON.parse(raw);
  } catch {
    failures.push("model returned unparseable JSON");
    return { entry, material, permitted, failures, lesson: null };
  }

  const returnedKeys: string[] = (lesson.sections ?? []).map((s: any) => s.key);

  // The defence: no section the gates withheld may appear in the output.
  const smuggled = returnedKeys.filter((key) => !toWrite.includes(key as any));
  if (smuggled.length > 0) {
    failures.push(`model wrote unpermitted section(s): ${smuggled.join(", ")}`);
  }

  const ids: number[] = lesson.used_doc_ids ?? [];
  if (ids.length === 0) {
    failures.push("no sources cited");
  }
  const outOfRange = ids.filter(
    (id) => !Number.isInteger(id) || id < 1 || id > material.questions.length
  );
  if (outOfRange.length > 0) {
    failures.push(`cited material we never supplied: ${outOfRange.join(", ")}`);
  }

  const prose = (lesson.sections ?? [])
    .map((s: any) => [s.body, ...(s.bullets ?? [])].filter(Boolean).join(" "))
    .join(" ");
  if (prose && !isNepali(prose)) {
    failures.push("answer is not in Nepali");
  }

  return { entry, material, permitted, failures, lesson };
}

async function main() {
  let passed = 0;
  let failed = 0;

  console.log("\nDrishtiPrep Ask — lesson evaluation\n");

  for (const entry of CASES) {
    const started = Date.now();
    const { material, permitted, failures, lesson } = await runCase(entry);
    const ms = Date.now() - started;

    const ok = failures.length === 0;
    if (ok) passed += 1;
    else failed += 1;

    console.log(`${ok ? "PASS" : "FAIL"}  ${entry.query}`);
    console.log(
      `      material: ${material.questions.length} readable, ` +
        `${material.locked_count} locked, paper_ref=${material.has_paper_ref}`
    );
    console.log(`      gates permitted: [${permitted.join(", ") || "none"}]`);
    if (lesson?.sections) {
      console.log(
        `      model wrote: [${lesson.sections.map((s: any) => s.key).join(", ")}] ` +
          `citing ${(lesson.used_doc_ids ?? []).length} sources · ${ms}ms`
      );
      const intro = lesson.sections.find((s: any) => s.key === "intro");
      if (intro?.body) console.log(`      "${intro.body.slice(0, 150)}"`);
    } else {
      console.log(`      no lesson built · ${ms}ms`);
    }
    for (const failure of failures) console.log(`      -> ${failure}`);
    console.log("");
  }

  console.log(`${passed} passed, ${failed} failed, ${CASES.length} total\n`);
  process.exit(failed > 0 ? 1 : 0);
}

main().catch((error) => {
  console.error(error);
  process.exit(1);
});
