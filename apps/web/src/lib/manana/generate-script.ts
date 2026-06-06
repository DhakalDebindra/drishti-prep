import type { RepoSupabaseClient } from "@repo/supabase";
import { generateGroundedProse, generateStructuredContent } from "@/lib/ai-service";
import { logger } from "@/lib/logger";
import {
  getWeakestMemoryItems,
  getMemoryHeatSummary,
  getSiblingQuestionsForGrounding,
} from "./queries";
import {
  MANANA_PROSE_SYSTEM_INSTRUCTION,
  MANANA_REFORMAT_SYSTEM_INSTRUCTION,
  buildMananaProseUserMessage,
  buildMananaReformatUserMessage,
  mananaEpisodeSchema,
  type MananaEpisodeScript,
} from "@/features/manana/prompts";

export const MIN_ITEMS_TO_GENERATE = 3;
// Target 8 items per episode to land at ~10–15 minutes of spoken audio when
// each resolution is a 4–6 sentence mini-lesson (~60–90s spoken). See
// prompts.ts MANANA_SYSTEM_INSTRUCTION for the resolution shape contract.
export const TARGET_ITEMS = 8;

// Length floors used by validateScript. Calibrated to the new long-form
// shape: anything shorter than these is almost certainly the LLM falling back
// to a one-liner and should be retried.
//
// Nepali Devanagari averages ~5 chars/word. A 4-sentence resolution at ~15
// words/sentence is ~300 chars — the 200 floor catches one-liners without
// false-positive on thin-explanation cases (which the prompt allows to come
// in shorter but still ≥3 sentences).
const MIN_INTRO_CHARS = 100; // ~3 short sentences
const MIN_OUTRO_CHARS = 60; // ~2 short sentences
const MIN_RESOLUTION_CHARS = 200; // ~3–4 sentences of actual discussion

export class MananaSkipError extends Error {
  constructor(public readonly reason: string) {
    super(reason);
    this.name = "MananaSkipError";
  }
}

// Monday (UTC) of the given date's ISO week, formatted as YYYY-MM-DD.
export function isoWeekMonday(d: Date = new Date()): string {
  const date = new Date(Date.UTC(d.getUTCFullYear(), d.getUTCMonth(), d.getUTCDate()));
  const day = date.getUTCDay(); // 0=Sun..6=Sat
  const diff = day === 0 ? -6 : 1 - day;
  date.setUTCDate(date.getUTCDate() + diff);
  return date.toISOString().slice(0, 10);
}

function validateScript(
  script: MananaEpisodeScript,
  expectedIds: string[],
): { ok: true } | { ok: false; reason: string } {
  const intro = script.episode_intro?.trim() ?? "";
  if (!intro) return { ok: false, reason: "missing episode_intro" };
  if (intro.length < MIN_INTRO_CHARS) {
    return {
      ok: false,
      reason: `episode_intro too short (${intro.length} chars; want ≥${MIN_INTRO_CHARS})`,
    };
  }

  const outro = script.episode_outro?.trim() ?? "";
  if (!outro) return { ok: false, reason: "missing episode_outro" };
  if (outro.length < MIN_OUTRO_CHARS) {
    return {
      ok: false,
      reason: `episode_outro too short (${outro.length} chars; want ≥${MIN_OUTRO_CHARS})`,
    };
  }

  if (!Array.isArray(script.revision_blocks) || script.revision_blocks.length === 0) {
    return { ok: false, reason: "revision_blocks empty" };
  }
  if (script.revision_blocks.length !== expectedIds.length) {
    return {
      ok: false,
      reason: `expected ${expectedIds.length} blocks, got ${script.revision_blocks.length}`,
    };
  }
  const allowed = new Set(expectedIds);
  for (const b of script.revision_blocks) {
    if (!allowed.has(b.question_id)) {
      return { ok: false, reason: `hallucinated question_id: ${b.question_id}` };
    }
    const stem = b.stem_text?.trim() ?? "";
    const resolution = b.resolution_text?.trim() ?? "";
    if (!stem || !resolution) {
      return { ok: false, reason: `empty stem/resolution in block ${b.question_id}` };
    }
    if (resolution.length < MIN_RESOLUTION_CHARS) {
      return {
        ok: false,
        reason: `resolution_text too short for ${b.question_id} (${resolution.length} chars; want ≥${MIN_RESOLUTION_CHARS}) — LLM likely fell back to one-liner`,
      };
    }
  }
  return { ok: true };
}

async function resolveUserName(
  supabase: RepoSupabaseClient,
  userId: string,
): Promise<string> {
  const { data } = await (supabase as any)
    .from("profiles")
    .select("full_name, display_name")
    .eq("id", userId)
    .maybeSingle();
  const name = (data?.display_name || data?.full_name || "").trim();
  if (!name) return "साथी"; // "friend" — graceful default in Nepali
  return name.split(/\s+/)[0]; // first name only
}

export type GenerateResult = {
  episodeId: string;
  weekStarting: string;
  script: MananaEpisodeScript;
};

// Compile the Manana episode script for one user. Caller must hold a Supabase
// client with permission to read/write manana_episodes for this user (cron job
// uses service-role; in-app testing uses an authed user session under RLS).
export async function generateEpisodeScript(
  supabase: RepoSupabaseClient,
  userId: string,
  opts: { weekStarting?: string; targetItems?: number } = {},
): Promise<GenerateResult> {
  const weekStarting = opts.weekStarting ?? isoWeekMonday();
  const targetItems = opts.targetItems ?? TARGET_ITEMS;

  // Idempotent upsert: marks the row as generating. UNIQUE(user_id, week_starting)
  // means re-runs hit the same row.
  const { data: epRow, error: upErr } = await (supabase as any)
    .from("manana_episodes")
    .upsert(
      {
        user_id: userId,
        week_starting: weekStarting,
        status: "generating",
        error_message: null,
        updated_at: new Date().toISOString(),
      },
      { onConflict: "user_id,week_starting" },
    )
    .select("id")
    .single();
  if (upErr || !epRow) {
    throw new Error(`Failed to upsert episode row: ${upErr?.message ?? "unknown"}`);
  }
  const episodeId = epRow.id as string;

  try {
    const [items, summary, userName] = await Promise.all([
      getWeakestMemoryItems(supabase, userId, targetItems),
      getMemoryHeatSummary(supabase, userId),
      resolveUserName(supabase, userId),
    ]);

    if (items.length < MIN_ITEMS_TO_GENERATE) {
      throw new MananaSkipError(
        `user has only ${items.length} tracked questions; minimum is ${MIN_ITEMS_TO_GENERATE}`,
      );
    }

    const expectedIds = items.map((i) => i.question_id);

    // DB-RAG: fetch sibling questions from the same topic as each weak item.
    // This is the ONLY material the LLM is allowed to cite for cross-topic
    // links — invented connections from training memory are disallowed by
    // the prose system instruction. Cheap query (parallel, ≤8 weak items).
    const grounding = await getSiblingQuestionsForGrounding(
      supabase,
      expectedIds,
      4,
    );
    const groundingSiblingCount = grounding.reduce(
      (n, g) => n + g.siblings.length,
      0,
    );

    let script: MananaEpisodeScript | null = null;
    let llmCostMicroUsd = 0;
    let lastErr: string | null = null;

    for (let attempt = 1; attempt <= 2; attempt++) {
      try {
        // PASS 1: Grounded prose generation with Google Search.
        // Gemini may search the web mid-generation to verify current-affairs
        // claims. Output is plain-text Nepali tagged with <intro>, <block>,
        // <stem>, <resolution>, <outro> — NOT JSON yet.
        const proseRes = await generateGroundedProse({
          systemInstruction: MANANA_PROSE_SYSTEM_INSTRUCTION,
          userMessage: buildMananaProseUserMessage({
            userName,
            memoryHeatSummary: summary.text,
            items,
            grounding,
          }),
          timeoutMs: 120_000, // grounded calls are slower than vanilla
        });
        logger.info("[manana] grounded prose generated", {
          attempt,
          proseChars: proseRes.text.length,
          groundingChunks: proseRes.groundingChunks.length,
          latencyMs: proseRes.latencyMs,
        });

        // PASS 2: Structured reformat — no grounding, no creative liberty,
        // just shape the tagged prose into the JSON schema.
        const formatRes = await generateStructuredContent<MananaEpisodeScript>({
          systemInstruction: MANANA_REFORMAT_SYSTEM_INSTRUCTION,
          userMessage: buildMananaReformatUserMessage({
            prose: proseRes.text,
            expectedQuestionIds: expectedIds,
          }),
          responseSchema: mananaEpisodeSchema,
          temperature: 0, // deterministic reformat
          timeoutMs: 60_000,
        });

        // Defence in depth: even though the reformat prompt tells the LLM to
        // copy question_ids from the authoritative list, UUIDs in token
        // streams occasionally drop a character (we observed it twice in
        // testing). The reformat pass cares about ORDER, not IDs — so we
        // overwrite the per-block question_id from `expectedIds` by position.
        // Wrong-count cases still fail validation below.
        if (
          Array.isArray(formatRes.data?.revision_blocks) &&
          formatRes.data.revision_blocks.length === expectedIds.length
        ) {
          formatRes.data.revision_blocks = formatRes.data.revision_blocks.map(
            (b, i) => ({ ...b, question_id: expectedIds[i] }),
          );
        }

        const v = validateScript(formatRes.data, expectedIds);
        if (!v.ok) {
          lastErr = v.reason;
          logger.warn("[manana] script validation failed", { attempt, reason: v.reason });
          continue;
        }
        script = formatRes.data;
        // Rough Flash pricing snapshot ~ $0.30/M input tokens, $2.50/M output.
        // We don't have token counts from these SDK calls without an extra
        // round-trip; leave at 0 for now and revisit when billing telemetry
        // lands. Note: two-pass costs ~2× the single-pass approach.
        llmCostMicroUsd = 0;
        break;
      } catch (e) {
        lastErr = e instanceof Error ? e.message : String(e);
        logger.warn("[manana] script call threw", { attempt, error: lastErr });
      }
    }

    if (!script) {
      throw new Error(`Gemini script generation failed: ${lastErr ?? "unknown"}`);
    }

    logger.info("[manana] script ready", {
      episodeId,
      blocks: script.revision_blocks.length,
      groundingSiblingCount,
    });

    const memoryHeatJson = {
      summary,
      items: items.map((i) => ({
        question_id: i.question_id,
        stability: i.stability,
        heat: i.heat,
        last_reviewed_at: i.last_reviewed_at,
      })),
    };

    const { error: persistErr } = await (supabase as any)
      .from("manana_episodes")
      .update({
        script_json: script,
        memory_heat_json: memoryHeatJson,
        llm_cost_micro_usd: llmCostMicroUsd,
        updated_at: new Date().toISOString(),
      })
      .eq("id", episodeId);
    if (persistErr) {
      throw new Error(`Failed to persist script_json: ${persistErr.message}`);
    }

    return { episodeId, weekStarting, script };
  } catch (e) {
    const reason = e instanceof Error ? e.message : String(e);
    await (supabase as any)
      .from("manana_episodes")
      .update({
        status: "failed",
        error_message: reason,
        updated_at: new Date().toISOString(),
      })
      .eq("id", episodeId);
    throw e;
  }
}
