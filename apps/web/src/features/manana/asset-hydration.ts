import fs from "node:fs/promises";
import path from "node:path";
import type { RepoSupabaseClient } from "@repo/supabase";
import {
  synthesizeNepali,
  storagePathFor,
  voiceFor,
  DEFAULT_VOICE,
} from "@/lib/tts-service";
import { logger } from "@/lib/logger";

const QUESTION_AUDIO_BUCKET = "question-audio";

async function downloadFromBucket(
  supabase: RepoSupabaseClient,
  bucket: string,
  path: string,
): Promise<Buffer | null> {
  const { data, error } = await (supabase as any).storage.from(bucket).download(path);
  if (error || !data) return null;
  const ab = await (data as Blob).arrayBuffer();
  return Buffer.from(ab);
}

async function uploadToBucket(
  supabase: RepoSupabaseClient,
  bucket: string,
  path: string,
  mp3: Buffer,
): Promise<void> {
  const { error } = await (supabase as any).storage.from(bucket).upload(path, mp3, {
    contentType: "audio/mpeg",
    upsert: true,
    cacheControl: "31536000, immutable",
  });
  if (error) throw new Error(`Upload failed (${bucket}/${path}): ${error.message}`);
}

// Fetch (or synthesise) the stem MP3 for a question and write it to /tmp.
// Stem is the only Manana segment that benefits from Shruti's shared cache
// because the source text is deterministic per question. Resolution/intro/
// outro are LLM-generated per episode and have no cache key — see
// synthEphemeralTo.
//
// CRITICAL: this function may upload to the shared question-audio bucket on
// cache miss, but MUST NOT flip questions.audio_ready=true. That flag means
// "all 6 Shruti segments present" — partial hydration would lie about it.
export async function hydrateStemTo(
  supabase: RepoSupabaseClient,
  questionId: string,
  questionText: string,
  outPath: string,
): Promise<{ source: "cache" | "synth"; bytes: number }> {
  // Read audio_version. Default to 1 if the row hasn't been audio-versioned
  // yet (older questions pre-Shruti) — matches Shruti's own behaviour.
  const { data: qRow } = await (supabase as any)
    .from("questions")
    .select("audio_version, audio_voice")
    .eq("id", questionId)
    .single();
  const audioVersion: number = qRow?.audio_version ?? 1;
  const storagePath = storagePathFor(questionId, audioVersion, "stem");

  const cached = await downloadFromBucket(supabase, QUESTION_AUDIO_BUCKET, storagePath);
  if (cached) {
    await fs.writeFile(outPath, cached);
    return { source: "cache", bytes: cached.length };
  }

  // Cache miss — synth + upload. Use the same voice convention as Shruti so
  // future cache hits agree with whatever Shruti expects for this question.
  const voice = (qRow?.audio_voice as string | null) ?? voiceFor(questionId) ?? DEFAULT_VOICE;
  const { mp3 } = await synthesizeNepali(questionText, voice as typeof DEFAULT_VOICE);
  await fs.writeFile(outPath, mp3);
  try {
    await uploadToBucket(supabase, QUESTION_AUDIO_BUCKET, storagePath, mp3);
  } catch (e) {
    // Upload failure does not fail the episode — the stem is already on /tmp.
    // Log so we notice cache-miss rates climbing.
    logger.warn("[manana] stem upload failed (continuing)", {
      questionId,
      error: e instanceof Error ? e.message : String(e),
    });
  }
  return { source: "synth", bytes: mp3.length };
}

// Synthesise text that has no cache key (intro/outro/resolution — per-episode
// LLM output) directly to /tmp. Never persisted anywhere except the final
// stitched episode in manana-episodes.
export async function synthEphemeralTo(text: string, outPath: string): Promise<number> {
  const { mp3 } = await synthesizeNepali(text, DEFAULT_VOICE);
  await fs.writeFile(outPath, mp3);
  return mp3.length;
}

export function tmpEpisodeDir(episodeId: string): string {
  return path.join("/tmp", `manana-${episodeId}`);
}
