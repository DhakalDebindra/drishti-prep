/**
 * Build a review list for questions whose explanation was split by a CSV import.
 *
 * A batch of questions was imported from a CSV whose explanation column
 * contained unquoted commas. The parser split one sentence across several
 * columns: `explanation` kept the first fragment, `exam_year` swallowed a middle
 * fragment (and, being an integer column, dropped it), and `paper_ref` kept a
 * later one. Learners currently see an explanation that stops mid-sentence.
 *
 * This writes a CSV for human review. It proposes a reconstruction but marks
 * every inferred gap with ⟨?⟩ rather than guessing the missing words — the
 * facts belong to the curriculum author, not to this script.
 *
 * Run: pnpm --filter web repair:paper-ref
 */

import { writeFileSync, mkdirSync } from "node:fs";
import { dirname, resolve } from "node:path";

import { createClient } from "@supabase/supabase-js";

const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
const key = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!url || !key) {
  console.error("Missing Supabase env. Run with --env-file=.env.local");
  process.exit(1);
}

const supabase = createClient(url, key);

const OUT = resolve(
  process.cwd(),
  "../../scratch/paper-ref-repair-review.csv"
);

type Row = {
  id: string;
  content: string;
  option_a: string;
  option_b: string;
  option_c: string;
  option_d: string;
  correct_option: string;
  explanation: string | null;
  paper_ref: string | null;
};

/** RFC4180 quoting — the very failure that caused this mess. */
function csvCell(value: string): string {
  return `"${(value ?? "").replace(/"/g, '""')}"`;
}

async function main() {
  const { data, error } = await supabase
    .from("questions")
    .select(
      "id, content, option_a, option_b, option_c, option_d, correct_option, explanation, paper_ref, exam_year, question_set_questions(question_set_id, question_sets(title))"
    )
    .not("paper_ref", "is", null)
    .neq("paper_ref", "")
    .is("exam_year", null);

  if (error) throw new Error(error.message);

  const rows = (data ?? []) as unknown as (Row & {
    question_set_questions?: { question_sets?: { title?: string } }[];
  })[];

  const header = [
    "question_id",
    "set_title",
    "question",
    "options",
    "correct_option",
    "explanation_current",
    "stray_fragment",
    "action",
    "proposed_explanation",
    "final_explanation_WRITE_HERE",
  ];

  const lines = [header.join(",")];
  let needsGap = 0;
  let clearOnly = 0;

  for (const row of rows) {
    const explanation = (row.explanation ?? "").trim();
    const stray = (row.paper_ref ?? "").trim();
    const setTitle = row.question_set_questions?.[0]?.question_sets?.title ?? "";

    // Special case: some rows kept a complete explanation and the stray column
    // merely duplicates its tail. Those need no rewriting at all.
    const alreadyComplete = explanation.includes(stray);

    const action = alreadyComplete
      ? "clear paper_ref only"
      : "rewrite explanation + clear paper_ref";

    // ⟨?⟩ marks where the import dropped a fragment. Never filled in by guessing.
    const proposed = alreadyComplete
      ? explanation
      : `${explanation}, ⟨?⟩, ${stray}`;

    if (alreadyComplete) clearOnly += 1;
    else needsGap += 1;

    lines.push(
      [
        csvCell(row.id),
        csvCell(setTitle),
        csvCell(row.content),
        csvCell(
          `A) ${row.option_a} | B) ${row.option_b} | C) ${row.option_c} | D) ${row.option_d}`
        ),
        csvCell(row.correct_option),
        csvCell(explanation),
        csvCell(stray),
        csvCell(action),
        csvCell(proposed),
        csvCell(""),
      ].join(",")
    );
  }

  mkdirSync(dirname(OUT), { recursive: true });
  // BOM so Excel opens Devanagari as UTF-8 rather than mojibake.
  writeFileSync(OUT, "﻿" + lines.join("\n"), "utf8");

  console.log(`\n${rows.length} questions written to:\n  ${OUT}\n`);
  console.log(`  ${needsGap} need a gap filled (marked ⟨?⟩)`);
  console.log(`  ${clearOnly} only need paper_ref cleared — explanation is intact\n`);
  console.log(
    "Fill the final_explanation_WRITE_HERE column for the rows you want changed,\n" +
      "leave it blank to skip a row, and hand the file back to apply it.\n"
  );
}

main().catch((error) => {
  console.error(error);
  process.exit(1);
});
