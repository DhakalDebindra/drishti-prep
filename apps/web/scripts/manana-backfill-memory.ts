// Backfill user_memory_states from historical attempt_answers.
//
// Runs sequentially in attempt-completion order so that the α/β stability
// update is applied non-commutatively (the same question across multiple
// attempts produces a different end state depending on order).
//
// Usage:
//   pnpm -C apps/web backfill:manana-memory          # appends to existing state
//   pnpm -C apps/web backfill:manana-memory --reset  # truncates first
//
// Requires SUPABASE_SERVICE_ROLE_KEY in apps/web/.env.local (bypasses RLS).

import { config } from "dotenv";
import { createClient } from "@supabase/supabase-js";
import { applyOutcome, INITIAL_STABILITY, type Outcome } from "../src/lib/manana/memory";

config({ path: ".env.local" });

type State = {
  stability: number;
  last_reviewed_at: string;
  review_count: number;
  mistake_count: number;
  last_outcome: Outcome;
};

const reset = process.argv.includes("--reset");

const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
if (!url || !serviceKey) {
  console.error("Missing NEXT_PUBLIC_SUPABASE_URL or SUPABASE_SERVICE_ROLE_KEY");
  process.exit(1);
}

const sb = createClient(url, serviceKey, { auth: { persistSession: false } });

async function main() {
  if (reset) {
    console.log("Truncating user_memory_states…");
    // Service role bypasses RLS; delete-all via always-true filter.
    const { error } = await sb.from("user_memory_states").delete().not("id", "is", null);
    if (error) throw error;
  }

  // Load existing state into memory so the loop can update incrementally and
  // we can write back in one batched upsert per page.
  const cache = new Map<string, State>(); // key: `${user_id}:${question_id}`
  if (!reset) {
    const PAGE = 1000;
    let from = 0;
    while (true) {
      const { data, error } = await sb
        .from("user_memory_states")
        .select("user_id, question_id, stability, last_reviewed_at, review_count, mistake_count, last_outcome")
        .range(from, from + PAGE - 1);
      if (error) throw error;
      if (!data?.length) break;
      for (const r of data) {
        cache.set(`${r.user_id}:${r.question_id}`, {
          stability: r.stability,
          last_reviewed_at: r.last_reviewed_at,
          review_count: r.review_count,
          mistake_count: r.mistake_count,
          last_outcome: (r.last_outcome ?? "correct") as Outcome,
        });
      }
      if (data.length < PAGE) break;
      from += PAGE;
    }
    console.log(`Loaded ${cache.size} existing memory rows.`);
  }

  // Page through submitted attempts in completion order. submitted_at is the
  // canonical "the user finished" timestamp; created_at would order by start
  // time, which can interleave incorrectly when attempts overlap.
  const PAGE = 500;
  let processed = 0;
  let lastSubmittedAt: string | null = null;
  let lastId: string | null = null;

  while (true) {
    let q = sb
      .from("attempts")
      .select("id, user_id, submitted_at")
      .eq("status", "submitted")
      .not("submitted_at", "is", null)
      .order("submitted_at", { ascending: true })
      .order("id", { ascending: true })
      .limit(PAGE);
    if (lastSubmittedAt && lastId) {
      // Keyset pagination: (submitted_at, id) > (last, last)
      q = q.or(`submitted_at.gt.${lastSubmittedAt},and(submitted_at.eq.${lastSubmittedAt},id.gt.${lastId})`);
    }
    const { data: attempts, error } = await q;
    if (error) throw error;
    if (!attempts?.length) break;

    for (const attempt of attempts) {
      const { data: answers, error: ansErr } = await sb
        .from("attempt_answers")
        .select("question_id, is_correct")
        .eq("attempt_id", attempt.id);
      if (ansErr) throw ansErr;
      if (!answers?.length) continue;

      const reviewedAt = attempt.submitted_at as string;
      for (const a of answers) {
        if (!a.question_id || a.is_correct == null) continue;
        const outcome: Outcome = a.is_correct ? "correct" : "wrong";
        const key = `${attempt.user_id}:${a.question_id}`;
        const prev = cache.get(key);
        const nextStability = applyOutcome(prev?.stability ?? INITIAL_STABILITY, outcome);
        cache.set(key, {
          stability: nextStability,
          last_reviewed_at: reviewedAt,
          review_count: (prev?.review_count ?? 0) + 1,
          mistake_count: (prev?.mistake_count ?? 0) + (outcome === "wrong" ? 1 : 0),
          last_outcome: outcome,
        });
      }

      lastSubmittedAt = attempt.submitted_at as string;
      lastId = attempt.id;
      processed += 1;
    }
    console.log(`Processed ${processed} attempts (cache size ${cache.size})…`);
    if (attempts.length < PAGE) break;
  }

  // Bulk upsert the accumulated cache in batches.
  const BATCH = 500;
  const rows = Array.from(cache.entries()).map(([key, s]) => {
    const [user_id, question_id] = key.split(":");
    return {
      user_id,
      question_id,
      stability: s.stability,
      last_reviewed_at: s.last_reviewed_at,
      review_count: s.review_count,
      mistake_count: s.mistake_count,
      last_outcome: s.last_outcome,
      updated_at: new Date().toISOString(),
    };
  });

  console.log(`Upserting ${rows.length} rows…`);
  for (let i = 0; i < rows.length; i += BATCH) {
    const slice = rows.slice(i, i + BATCH);
    const { error } = await sb
      .from("user_memory_states")
      .upsert(slice, { onConflict: "user_id,question_id" });
    if (error) throw error;
    process.stdout.write(`  ${Math.min(i + BATCH, rows.length)}/${rows.length}\r`);
  }
  console.log("\nDone.");
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});
