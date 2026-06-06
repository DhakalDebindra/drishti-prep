import fs from "node:fs/promises";
import path from "node:path";
import type { RepoSupabaseClient } from "@repo/supabase";
import { hydrateBrandingCuePackTo } from "./branding-sounds";
import { logger } from "@/lib/logger";
import { hydrateStemTo, synthEphemeralTo, tmpEpisodeDir } from "./asset-hydration";
import { stitchEpisode, probeDurationMs, type StitchBlock } from "./ffmpeg-stitch";
import type { MananaEpisodeScript } from "./prompts";

const EPISODE_BUCKET = "manana-episodes";

type EpisodeRow = {
  id: string;
  user_id: string;
  week_starting: string;
  script_json: MananaEpisodeScript | null;
  storage_path: string | null;
  status: string;
};

export type CompileResult = {
  episodeId: string;
  storagePath: string;
  durationMs: number;
  bytes: number;
  cacheHits: number;
  cacheMisses: number;
};

async function rmTmp(dir: string): Promise<void> {
  try {
    await fs.rm(dir, { recursive: true, force: true });
  } catch (e) {
    logger.warn("[manana] tmp cleanup failed", {
      dir,
      error: e instanceof Error ? e.message : String(e),
    });
  }
}

export async function compileEpisodeAudio(
  supabase: RepoSupabaseClient,
  episodeId: string,
): Promise<CompileResult> {
  const { data: epData, error: epErr } = await (supabase as any)
    .from("manana_episodes")
    .select("id, user_id, week_starting, script_json, storage_path, status")
    .eq("id", episodeId)
    .single();
  if (epErr || !epData) {
    throw new Error(`Episode ${episodeId} not found: ${epErr?.message ?? "unknown"}`);
  }
  const ep = epData as EpisodeRow;
  if (!ep.script_json) {
    throw new Error(`Episode ${episodeId} has no script_json`);
  }
  if (ep.storage_path) {
    throw new Error(`Episode ${episodeId} already has storage_path (${ep.storage_path})`);
  }

  const script = ep.script_json;
  const tmpDir = tmpEpisodeDir(episodeId);
  await fs.mkdir(tmpDir, { recursive: true });

  try {
    const blockCount = script.revision_blocks.length;
    const brandingPromise = hydrateBrandingCuePackTo(supabase, tmpDir);
    const introPath = path.join(tmpDir, "intro.mp3");
    const outroPath = path.join(tmpDir, "outro.mp3");
    const blockPaths: StitchBlock[] = script.revision_blocks.map((_, i) => ({
      stemPath: path.join(tmpDir, `stem_${i}.mp3`),
      resolutionPath: path.join(tmpDir, `res_${i}.mp3`),
    }));

    // Fetch all audio in parallel. TTS calls serialize internally via the
    // shared throttle in tts-service, so this is concurrency-safe.
    let cacheHits = 0;
    let cacheMisses = 0;

    const hydrationTasks: Promise<unknown>[] = [
      synthEphemeralTo(script.episode_intro, introPath),
      synthEphemeralTo(script.episode_outro, outroPath),
    ];
    script.revision_blocks.forEach((b, i) => {
      hydrationTasks.push(
        hydrateStemTo(supabase, b.question_id, b.stem_text, blockPaths[i].stemPath).then(
          (r) => {
            if (r.source === "cache") cacheHits++;
            else cacheMisses++;
          },
        ),
      );
      hydrationTasks.push(synthEphemeralTo(b.resolution_text, blockPaths[i].resolutionPath));
    });
    const [branding] = await Promise.all([
      brandingPromise,
      ...hydrationTasks,
    ]);

    const finalPath = path.join(tmpDir, "episode.mp3");
    const { bytes } = await stitchEpisode({
      introPath,
      blocks: blockPaths,
      branding,
      outroPath,
      outPath: finalPath,
    });
    const durationMs = await probeDurationMs(finalPath);

    // Upload final MP3 to private manana-episodes bucket. Path matches the
    // convention locked in the migration: {user_id}/{week_starting}.mp3.
    const storagePath = `${ep.user_id}/${ep.week_starting}.mp3`;
    const fileBuffer = await fs.readFile(finalPath);
    const { error: upErr } = await (supabase as any).storage
      .from(EPISODE_BUCKET)
      .upload(storagePath, fileBuffer, {
        contentType: "audio/mpeg",
        upsert: true,
        cacheControl: "private, max-age=0, must-revalidate",
      });
    if (upErr) throw new Error(`Episode upload failed: ${upErr.message}`);

    const { error: updErr } = await (supabase as any)
      .from("manana_episodes")
      .update({
        status: "ready",
        storage_path: storagePath,
        duration_ms: durationMs,
        bytes,
        generated_at: new Date().toISOString(),
        updated_at: new Date().toISOString(),
        error_message: null,
      })
      .eq("id", episodeId);
    if (updErr) throw new Error(`Episode row update failed: ${updErr.message}`);

    logger.info("[manana] episode ready", {
      episodeId,
      blockCount,
      bytes,
      durationMs,
      cacheHits,
      cacheMisses,
    });

    return { episodeId, storagePath, durationMs, bytes, cacheHits, cacheMisses };
  } catch (e) {
    const reason = e instanceof Error ? e.message : String(e);
    await (supabase as any)
      .from("manana_episodes")
      .update({
        status: "failed",
        error_message: reason.slice(0, 2000),
        updated_at: new Date().toISOString(),
      })
      .eq("id", episodeId);
    throw e;
  } finally {
    await rmTmp(tmpDir);
  }
}
