import { NextResponse } from "next/server";
import { createClient as createSbClient } from "@supabase/supabase-js";
import { generateEpisodeScript, isoWeekMonday, MananaSkipError } from "@/lib/manana/generate-script";
import { compileEpisodeAudio } from "@/features/manana/worker";
import { logger } from "@/lib/logger";

// Vercel-only knobs. Node runtime is required (ffmpeg child process); the
// 300s ceiling is the Pro-tier cap and is the documented compile budget for
// a small batch of episodes per invocation. Beyond that, schedule rolls over
// — episodes left in 'generating' are picked up next run.
export const runtime = "nodejs";
export const maxDuration = 300;

// Time we reserve for a clean exit (logging + JSON response) once we abort
// the work loop. Keeps the function from being killed mid-update.
const SAFETY_MARGIN_MS = 15_000;
const DEADLINE_MS = (maxDuration * 1000) - SAFETY_MARGIN_MS;

// Minimum tracked questions before a user is eligible for an episode. Matches
// the MIN_ITEMS_TO_GENERATE check inside generate-script (defensive duplicate
// so we don't make pointless LLM calls).
const MIN_TRACKED = 3;

function unauthorized() {
  return NextResponse.json({ error: "unauthorized" }, { status: 401 });
}

function timeLeft(start: number): number {
  return DEADLINE_MS - (Date.now() - start);
}

async function eligibleUserIds(sb: any): Promise<string[]> {
  // Users who have at least MIN_TRACKED memory rows AND have practised
  // something in the past 14 days. Cheap proxy for "active enough to merit
  // a weekly episode" — keeps us off dormant accounts.
  const since = new Date(Date.now() - 14 * 24 * 60 * 60 * 1000).toISOString();
  const { data, error } = await (sb as any)
    .from("user_memory_states")
    .select("user_id, last_reviewed_at")
    .gte("last_reviewed_at", since);
  if (error || !data) return [];
  const counts = new Map<string, number>();
  for (const r of data as Array<{ user_id: string }>) {
    counts.set(r.user_id, (counts.get(r.user_id) ?? 0) + 1);
  }
  return Array.from(counts.entries())
    .filter(([, n]) => n >= MIN_TRACKED)
    .map(([id]) => id);
}

export async function POST(req: Request) {
  const auth = req.headers.get("authorization") ?? "";
  const secret = process.env.CRON_SECRET;
  if (!secret || auth !== `Bearer ${secret}`) {
    return unauthorized();
  }

  const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
  if (!url || !serviceKey) {
    return NextResponse.json({ error: "missing supabase env" }, { status: 500 });
  }
  const sb = createSbClient(url, serviceKey, { auth: { persistSession: false } });

  const start = Date.now();
  const weekStarting = isoWeekMonday();

  const summary = {
    weekStarting,
    scriptsAttempted: 0,
    scriptsCompiled: 0,
    scriptsSkipped: 0,
    scriptsFailed: 0,
    audioCompiled: 0,
    audioFailed: 0,
    aborted: false,
    failures: [] as Array<{ stage: string; userId?: string; episodeId?: string; reason: string }>,
  };

  // ─── Phase A: script generation ──────────────────────────────────────────
  // For each eligible user without a ready/in-flight episode this week, run
  // the S3 compiler. Errors here don't block Phase B from running for users
  // whose scripts already exist from a prior week.
  try {
    const userIds = await eligibleUserIds(sb);

    // Skip users who already have a script_json row for this week. Cheap
    // single query rather than per-user check.
    const { data: existing } = await (sb as any)
      .from("manana_episodes")
      .select("user_id, script_json")
      .eq("week_starting", weekStarting);
    const haveScript = new Set<string>(
      ((existing as Array<{ user_id: string; script_json: unknown }>) ?? [])
        .filter((r) => r.script_json != null)
        .map((r) => r.user_id),
    );

    for (const userId of userIds) {
      if (haveScript.has(userId)) continue;
      if (timeLeft(start) <= 0) {
        summary.aborted = true;
        break;
      }
      summary.scriptsAttempted++;
      try {
        await generateEpisodeScript(sb as any, userId, { weekStarting });
        summary.scriptsCompiled++;
      } catch (e) {
        if (e instanceof MananaSkipError) {
          summary.scriptsSkipped++;
        } else {
          summary.scriptsFailed++;
          summary.failures.push({
            stage: "script",
            userId,
            reason: e instanceof Error ? e.message : String(e),
          });
        }
      }
    }
  } catch (e) {
    logger.error("[manana cron] phase A crashed", {
      error: e instanceof Error ? e.message : String(e),
    });
  }

  // ─── Phase B: audio compilation ──────────────────────────────────────────
  // Process every episode that has a script but no audio yet — current week
  // first, but also any stragglers from prior weeks that got truncated.
  // Rows can be stranded in `failed` if script generation succeeded but the
  // compile step hit a transient issue (DNS, storage, ffmpeg, etc.), so we
  // intentionally retry both generating and failed statuses here.
  try {
    const { data: pending } = await (sb as any)
      .from("manana_episodes")
      .select("id, status")
      .in("status", ["generating", "failed"])
      .not("script_json", "is", null)
      .is("storage_path", null)
      .order("week_starting", { ascending: false });

    for (const row of (pending as Array<{ id: string; status: string }> | null) ?? []) {
      if (timeLeft(start) <= 0) {
        summary.aborted = true;
        break;
      }
      try {
        await compileEpisodeAudio(sb as any, row.id);
        summary.audioCompiled++;
      } catch (e) {
        summary.audioFailed++;
        summary.failures.push({
          stage: "audio",
          episodeId: row.id,
          reason: e instanceof Error ? e.message : String(e),
        });
      }
    }
  } catch (e) {
    logger.error("[manana cron] phase B crashed", {
      error: e instanceof Error ? e.message : String(e),
    });
  }

  const totalMs = Date.now() - start;
  logger.info("[manana cron] done", { ...summary, totalMs });
  return NextResponse.json({ ...summary, totalMs });
}

// Vercel cron uses GET by default. Mirror to POST handler so the same secret
// path works whether triggered by the scheduler or an external system.
export const GET = POST;
