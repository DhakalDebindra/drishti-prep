/**
 * Prompt lab — compare prompt variants on the same queries, with numbers.
 *
 * Prompt wording is the biggest lever on answer quality and the easiest thing
 * to change on a hunch. This runs each variant over the same retrieved material
 * and scores the results, so "this wording is better" becomes a measurement
 * rather than an impression formed from one screenshot.
 *
 * The material is fetched ONCE per query and reused across variants. That is
 * the whole point of the design: with retrieval held fixed, any difference in
 * the output is attributable to the prompt and nothing else.
 *
 * WHAT IT MEASURES, and why it is not just "fact density":
 *   density   — concrete figures per 100 words. The "is it detailed" signal.
 *   grounded  — share of those figures that appear in the material. A model
 *               told to add detail can simply invent it, which would score
 *               beautifully while getting worse, so density is always reported
 *               against grounding and the composite MULTIPLIES the two.
 *   vague     — hedging phrases per 100 words. What "flat" sounds like.
 *   cited     — share of supplied documents the answer actually used.
 *   nepali    — Devanagari share, to catch drift into English.
 *
 * Run: pnpm --filter web lab:prompt
 *      pnpm --filter web lab:prompt -- --variants detailed,terse --queries 2
 *      pnpm --filter web lab:prompt -- --dry     (prints prompts, calls nothing)
 *
 * COST: one model call per query per variant. The default Gemini key is on the
 * free tier at 20 calls/day, so the defaults here are deliberately small and
 * the run prints its call count before starting.
 */

import { writeFileSync, mkdirSync } from "node:fs";
import { dirname, resolve } from "node:path";

import { GoogleGenerativeAI } from "@google/generative-ai";
import { createClient } from "@supabase/supabase-js";

import { normaliseQuery } from "../src/lib/search/normalize";
import { modelSections, permittedSections } from "../src/lib/ask/sections";
import { scoreLesson, type LessonMetrics } from "../src/lib/ask/metrics";
import { PROMPT_VARIANTS, buildLessonPrompt, type PromptVariant } from "../src/config/prompts/ask";
import type { AskMaterial } from "../src/lib/ask/types";

const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
const geminiKey = process.env.GEMINI_API_KEY;

if (!url || !serviceKey || !geminiKey) {
  console.error("Missing Supabase or Gemini env. Run with --env-file=.env.local");
  process.exit(1);
}

const supabase = createClient(url, serviceKey);
const genAI = new GoogleGenerativeAI(geminiKey);
const model = genAI.getGenerativeModel({
  model: process.env.GEMINI_MODEL_FLASH || "gemini-2.5-flash",
  generationConfig: { responseMimeType: "application/json", temperature: 0.2 },
});

/**
 * Queries chosen to span the shapes that behave differently: a broad subject,
 * a narrow factual lookup, one rich in dates, and one where the learner's
 * spelling misses the bank. Keep this list stable — changing it invalidates
 * comparison with previous runs.
 */
const QUERIES = [
  "रामसार सूचि के हो?",
  "नेपालका राष्ट्रिय निकुञ्ज",
  "संविधानका मौलिक हक",
  "नेपालका प्रमुख ताल",
];

const MATERIAL_LIMIT = 14;

function arg(name: string): string | null {
  const index = process.argv.indexOf(`--${name}`);
  return index >= 0 ? (process.argv[index + 1] ?? null) : null;
}

const dryRun = process.argv.includes("--dry");
const queryLimit = Number.parseInt(arg("queries") ?? "2", 10);
const variantIds = (arg("variants") ?? "detailed,terse").split(",").map((s) => s.trim());

const variants = PROMPT_VARIANTS.filter((v) => variantIds.includes(v.id));
const queries = QUERIES.slice(0, Math.max(1, queryLimit));

if (variants.length === 0) {
  console.error(
    `No variants matched "${variantIds.join(",")}". Available: ` +
      PROMPT_VARIANTS.map((v) => v.id).join(", ")
  );
  process.exit(1);
}

/** Retrieval, relaxed exactly as production does, so the lab sees real input. */
async function fetchMaterial(tokens: string[][]): Promise<AskMaterial | null> {
  const floor = tokens.length <= 2 ? 1 : 2;
  for (let needed = tokens.length; needed >= floor; needed -= 1) {
    const { data, error } = await supabase.rpc("ask_material", {
      p_tokens: tokens,
      p_limit: MATERIAL_LIMIT,
      p_min_tokens: needed,
    });
    if (error) throw new Error(error.message);
    const material = data as unknown as AskMaterial;
    if (material?.questions?.length) return material;
  }
  return null;
}

/** Everything the model was shown, for the grounding check. */
function materialText(material: AskMaterial): string {
  return material.questions
    .map((q) => `${q.content} ${q.explanation ?? ""}`)
    .join(" ");
}

function flatten(sections: { body?: string; bullets?: string[] }[]): string {
  return sections
    .map((s) => [s.body, ...(s.bullets ?? [])].filter(Boolean).join(" "))
    .join(" ");
}

type Row = {
  query: string;
  variant: string;
  sections: string;
  latencyMs: number;
  promptChars: number;
} & LessonMetrics;

async function main() {
  const calls = dryRun ? 0 : queries.length * variants.length;
  console.log(`\nPrompt lab — ${queries.length} queries × ${variants.length} variants`);
  console.log(`Variants: ${variants.map((v) => v.label).join(" | ")}`);
  console.log(
    dryRun
      ? "Dry run: prompts printed, no model calls.\n"
      : `${calls} model calls (free tier allows 20/day).\n`
  );

  const rows: Row[] = [];

  for (const query of queries) {
    const { tokens } = normaliseQuery(query);
    const material = await fetchMaterial(tokens);

    if (!material) {
      console.log(`— ${query}\n   no material retrieved; skipped\n`);
      continue;
    }

    const permitted = permittedSections(material);
    const toWrite = modelSections(permitted);
    const source = materialText(material);

    console.log(`— ${query}`);
    console.log(
      `   ${material.questions.length} questions · gates [${permitted.join(", ")}]`
    );

    for (const variant of variants) {
      const prompt = buildLessonPrompt(query, material.questions, toWrite, variant);

      if (dryRun) {
        console.log(`\n===== ${variant.label} =====\n${prompt}\n`);
        continue;
      }

      const started = Date.now();
      let parsed: { sections?: any[]; used_doc_ids?: number[] };
      try {
        const result = await model.generateContent(prompt);
        parsed = JSON.parse(result.response.text());
      } catch (error) {
        console.log(`   ${variant.id.padEnd(10)} FAILED: ${(error as Error).message}`);
        continue;
      }
      const latencyMs = Date.now() - started;

      const sections = parsed.sections ?? [];
      const answer = flatten(sections);
      const metrics = scoreLesson({
        answer,
        material: source,
        usedDocIds: parsed.used_doc_ids ?? [],
        materialCount: material.questions.length,
      });

      rows.push({
        query,
        variant: variant.id,
        sections: sections.map((s: any) => s.key).join("+"),
        latencyMs,
        promptChars: prompt.length,
        ...metrics,
      });

      console.log(
        `   ${variant.id.padEnd(10)} ` +
          `score ${metrics.score.toFixed(1).padStart(5)} · ` +
          `density ${metrics.factDensity.toFixed(1).padStart(4)} · ` +
          `grounded ${(metrics.groundedRate * 100).toFixed(0).padStart(3)}% · ` +
          `vague ${metrics.vagueRate.toFixed(1)} · ` +
          `cited ${(metrics.citationRate * 100).toFixed(0)}% · ` +
          `${metrics.words}w · ${(latencyMs / 1000).toFixed(1)}s`
      );
    }
    console.log("");
  }

  if (rows.length === 0) return;

  // Per-variant averages: the number that actually decides which wording wins.
  console.log("Averages by variant");
  for (const variant of variants) {
    const mine = rows.filter((r) => r.variant === variant.id);
    if (mine.length === 0) continue;
    const avg = (pick: (r: Row) => number) =>
      mine.reduce((sum, r) => sum + pick(r), 0) / mine.length;

    console.log(
      `  ${variant.label.padEnd(28)} ` +
        `score ${avg((r) => r.score).toFixed(1).padStart(5)} · ` +
        `density ${avg((r) => r.factDensity).toFixed(1)} · ` +
        `grounded ${(avg((r) => r.groundedRate) * 100).toFixed(0)}% · ` +
        `vague ${avg((r) => r.vagueRate).toFixed(2)} · ` +
        `${avg((r) => r.words).toFixed(0)}w · ` +
        `${(avg((r) => r.latencyMs) / 1000).toFixed(1)}s`
    );
  }

  const out = resolve(process.cwd(), "../../scratch/prompt-lab-results.csv");
  const header = Object.keys(rows[0]).join(",");
  const body = rows
    .map((r) =>
      Object.values(r)
        .map((v) => `"${String(v).replace(/"/g, '""')}"`)
        .join(",")
    )
    .join("\n");
  mkdirSync(dirname(out), { recursive: true });
  writeFileSync(out, `﻿${header}\n${body}`, "utf8");
  console.log(`\nPer-run detail: ${out}\n`);
}

main().catch((error) => {
  console.error(error);
  process.exit(1);
});
