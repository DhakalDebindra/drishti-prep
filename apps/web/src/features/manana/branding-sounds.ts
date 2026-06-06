import { spawn } from "node:child_process";
import { createHash } from "node:crypto";
import fs from "node:fs/promises";
import os from "node:os";
import path from "node:path";
import type { RepoSupabaseClient } from "@repo/supabase";
import ffmpegPath from "ffmpeg-static";
import { generateElevenLabsSound } from "@/lib/elevenlabs-sfx";
import { generateGeminiInstrumentalClip } from "@/lib/gemini-music";
import { logger } from "@/lib/logger";
import { probeDurationMs } from "./ffmpeg-stitch";

const BRANDING_BUCKET = "manana-static";
const ELEVENLABS_PROVIDER = "elevenlabs";
const ELEVENLABS_MODEL = "eleven_text_to_sound_v2";
const GEMINI_PROVIDER = "gemini-lyria";
const GEMINI_MODEL = "lyria-3-clip-preview";
const LOCAL_PROVIDER = "local-ffmpeg";
const LOCAL_MODEL = "generated-tone-bed-v1";

export const BRANDING_SOUND_SLOTS = [
  "intro_sting",
  "question_transition",
  "section_break",
  "outro_logo",
] as const;

export type BrandingSoundSlot = (typeof BRANDING_SOUND_SLOTS)[number];

export type BrandingCuePack = {
  introStingPath?: string;
  questionTransitionPath?: string;
  sectionBreakPath?: string;
  outroLogoPath?: string;
};

type BrandingSoundSpec = {
  key: BrandingSoundSlot;
  prompt: string;
  geminiPrompt: string;
  durationSeconds: number;
  promptInfluence: number;
  localSpec: {
    toneHz: number;
    accentHz: number;
  };
};

type BrandingSoundRow = {
  key: BrandingSoundSlot;
  storage_path: string;
};

export const DEFAULT_BRANDING_SOUND_SPECS: ReadonlyArray<BrandingSoundSpec> = [
  {
    key: "intro_sting",
    durationSeconds: 1.8,
    promptInfluence: 0.55,
    geminiPrompt:
      "Short instrumental podcast brand stinger for DrishtiPrep, warm educational identity, soft marimba, subtle tabla, airy synth swell, no vocals.",
    localSpec: { toneHz: 392, accentHz: 523 },
    prompt:
      "A warm, confident sonic logo for DrishtiPrep. Short podcast opener, soft Nepali educational brand identity, clean marimba pulse, airy synth swell, gentle tabla texture, hopeful finish, no voice.",
  },
  {
    key: "question_transition",
    durationSeconds: 0.8,
    promptInfluence: 0.5,
    geminiPrompt:
      "Very short instrumental transition cue for a study podcast, light percussion and shimmer, clean reset, no vocals.",
    localSpec: { toneHz: 440, accentHz: 660 },
    prompt:
      "A very short podcast transition cue for DrishtiPrep. Light percussive whoosh, subtle wooden click, friendly academic feel, quick reset between revision questions, no voice.",
  },
  {
    key: "section_break",
    durationSeconds: 1.2,
    promptInfluence: 0.52,
    geminiPrompt:
      "Short instrumental section break for an educational podcast, reflective shimmer, light folk percussion accent, no vocals.",
    localSpec: { toneHz: 349, accentHz: 466 },
    prompt:
      "A short section break sting for DrishtiPrep. Calm turning-page energy, soft shimmer, light Nepali folk percussion accent, reflective and focused, no voice.",
  },
  {
    key: "outro_logo",
    durationSeconds: 2.3,
    promptInfluence: 0.58,
    geminiPrompt:
      "Short instrumental podcast outro logo for DrishtiPrep, uplifting resolve, bright bell motif, warm polished finish, no vocals.",
    localSpec: { toneHz: 330, accentHz: 494 },
    prompt:
      "A memorable closing sonic logo for DrishtiPrep. Gentle uplifting resolve, bright bell motif, subtle cinematic warmth, polished podcast outro, no voice.",
  },
];

function hashSpec(spec: BrandingSoundSpec, provider: string, model: string): string {
  return createHash("sha256")
    .update(
      JSON.stringify({
        provider,
        model,
        key: spec.key,
        prompt: spec.prompt,
        geminiPrompt: spec.geminiPrompt,
        durationSeconds: spec.durationSeconds,
        promptInfluence: spec.promptInfluence,
        localSpec: spec.localSpec,
      }),
    )
    .digest("hex");
}

function storagePathFor(spec: BrandingSoundSpec, provider: string, promptHash: string): string {
  return `branding/${provider}/${spec.key}/${promptHash}.mp3`;
}

function cueFileName(slot: BrandingSoundSlot): string {
  return `${slot}.mp3`;
}

async function downloadFromBucket(
  supabase: RepoSupabaseClient,
  storagePath: string,
): Promise<Buffer | null> {
  const { data, error } = await (supabase as any).storage.from(BRANDING_BUCKET).download(storagePath);
  if (error || !data) return null;
  const ab = await (data as Blob).arrayBuffer();
  return Buffer.from(ab);
}

async function uploadToBucket(
  supabase: RepoSupabaseClient,
  storagePath: string,
  audio: Buffer,
): Promise<void> {
  const { error } = await (supabase as any).storage.from(BRANDING_BUCKET).upload(storagePath, audio, {
    contentType: "audio/mpeg",
    upsert: true,
    cacheControl: "31536000, immutable",
  });
  if (error) throw new Error(`Upload failed (${BRANDING_BUCKET}/${storagePath}): ${error.message}`);
}

function cuePackKey(slot: BrandingSoundSlot): keyof BrandingCuePack {
  switch (slot) {
    case "intro_sting":
      return "introStingPath";
    case "question_transition":
      return "questionTransitionPath";
    case "section_break":
      return "sectionBreakPath";
    case "outro_logo":
      return "outroLogoPath";
  }
}

function assertFfmpeg(): string {
  if (!ffmpegPath) {
    throw new Error("ffmpeg-static did not provide a binary path");
  }
  return ffmpegPath as string;
}

async function runFfmpeg(args: string[]): Promise<void> {
  const ffmpegBin = assertFfmpeg();
  await new Promise<void>((resolve, reject) => {
    const proc = spawn(ffmpegBin, args, { stdio: ["ignore", "pipe", "pipe"] });
    const stderrChunks: Buffer[] = [];
    proc.stderr.on("data", (c) => stderrChunks.push(Buffer.from(c)));
    proc.on("error", reject);
    proc.on("close", (code) => {
      if (code === 0) {
        resolve();
      } else {
        reject(new Error(`ffmpeg exited ${code}: ${Buffer.concat(stderrChunks).toString("utf8").slice(-1500)}`));
      }
    });
  });
}

async function trimMp3ToDuration(input: Buffer, durationSeconds: number): Promise<Buffer> {
  const tmpRoot = path.join(os.tmpdir(), `manana-branding-${Date.now()}-${Math.random().toString(36).slice(2)}`);
  await fs.mkdir(tmpRoot, { recursive: true });
  const inputPath = path.join(tmpRoot, "input.mp3");
  const outputPath = path.join(tmpRoot, "output.mp3");
  await fs.writeFile(inputPath, input);

  try {
    const fadeOutStart = Math.max(0.08, durationSeconds - 0.12).toFixed(2);
    await runFfmpeg([
      "-y",
      "-i",
      inputPath,
      "-t",
      String(durationSeconds),
      "-af",
      `afade=t=in:st=0:d=0.04,afade=t=out:st=${fadeOutStart}:d=0.12`,
      "-c:a",
      "libmp3lame",
      "-b:a",
      "128k",
      "-ac",
      "1",
      outputPath,
    ]);
    return await fs.readFile(outputPath);
  } finally {
    await fs.rm(tmpRoot, { recursive: true, force: true });
  }
}

async function synthesizeLocalCue(spec: BrandingSoundSpec): Promise<Buffer> {
  const tmpRoot = path.join(os.tmpdir(), `manana-local-branding-${Date.now()}-${Math.random().toString(36).slice(2)}`);
  await fs.mkdir(tmpRoot, { recursive: true });
  const outputPath = path.join(tmpRoot, "cue.mp3");
  const fadeOutStart = Math.max(0.08, spec.durationSeconds - 0.18).toFixed(2);
  const filter = [
    `sine=f=${spec.localSpec.toneHz}:sample_rate=24000:duration=${spec.durationSeconds},volume=0.08[a0]`,
    `sine=f=${spec.localSpec.accentHz}:sample_rate=24000:duration=${spec.durationSeconds},volume=0.05[a1]`,
    `anoisesrc=color=pink:sample_rate=24000:duration=${spec.durationSeconds},volume=0.008[a2]`,
    `[a0][a1][a2]amix=inputs=3:normalize=0,afade=t=in:st=0:d=0.03,afade=t=out:st=${fadeOutStart}:d=0.18[a3]`,
    `[a3]aecho=0.8:0.4:18:0.12,volume=1.3[out]`,
  ].join(";");

  try {
    await runFfmpeg([
      "-y",
      "-f",
      "lavfi",
      "-i",
      "anullsrc=r=24000:cl=mono",
      "-filter_complex",
      filter,
      "-map",
      "[out]",
      "-t",
      String(spec.durationSeconds),
      "-c:a",
      "libmp3lame",
      "-b:a",
      "128k",
      outputPath,
    ]);
    return await fs.readFile(outputPath);
  } finally {
    await fs.rm(tmpRoot, { recursive: true, force: true });
  }
}

async function createBrandingAudio(spec: BrandingSoundSpec): Promise<{
  audio: Buffer;
  provider: string;
  model: string;
}> {
  if (process.env.ELEVENLABS_API_KEY) {
    try {
      const audio = await generateElevenLabsSound({
        text: spec.prompt,
        durationSeconds: spec.durationSeconds,
        promptInfluence: spec.promptInfluence,
        modelId: ELEVENLABS_MODEL,
      });
      return { audio, provider: ELEVENLABS_PROVIDER, model: ELEVENLABS_MODEL };
    } catch (error) {
      logger.warn("[manana] ElevenLabs branding sound failed; falling back", {
        key: spec.key,
        error: error instanceof Error ? error.message : String(error),
      });
    }
  }

  try {
    const fullClip = await generateGeminiInstrumentalClip({
      prompt: spec.geminiPrompt,
      model: GEMINI_MODEL,
    });
    const trimmed = await trimMp3ToDuration(fullClip, spec.durationSeconds);
    return { audio: trimmed, provider: GEMINI_PROVIDER, model: GEMINI_MODEL };
  } catch (error) {
    logger.warn("[manana] Gemini music branding sound failed; falling back to local cue", {
      key: spec.key,
      error: error instanceof Error ? error.message : String(error),
    });
  }

  const localAudio = await synthesizeLocalCue(spec);
  return { audio: localAudio, provider: LOCAL_PROVIDER, model: LOCAL_MODEL };
}

export async function hydrateBrandingCuePackTo(
  supabase: RepoSupabaseClient,
  outDir: string,
): Promise<BrandingCuePack> {
  const { data, error } = await (supabase as any)
    .from("manana_branding_sounds")
    .select("key, storage_path")
    .in("key", [...BRANDING_SOUND_SLOTS]);

  if (error) {
    logger.warn("[manana] branding cue lookup failed", { error: error.message });
    return {};
  }

  const rows = new Map<BrandingSoundSlot, BrandingSoundRow>();
  for (const row of (data as BrandingSoundRow[] | null) ?? []) {
    rows.set(row.key, row);
  }

  const pack: BrandingCuePack = {};

  await Promise.all(
    BRANDING_SOUND_SLOTS.map(async (slot) => {
      const row = rows.get(slot);
      if (!row) return;

      const audio = await downloadFromBucket(supabase, row.storage_path);
      if (!audio) {
        logger.warn("[manana] branding cue missing in storage", {
          key: slot,
          storagePath: row.storage_path,
        });
        return;
      }

      const localPath = path.join(outDir, cueFileName(slot));
      await fs.writeFile(localPath, audio);
      pack[cuePackKey(slot)] = localPath;
    }),
  );

  return pack;
}

export type SeedBrandingResult = {
  action: "created" | "reused";
  bytes: number;
  durationMs: number;
  key: BrandingSoundSlot;
  provider: string;
  storagePath: string;
};

export async function ensureBrandingSoundCatalog(
  supabase: RepoSupabaseClient,
  opts: { force?: boolean } = {},
): Promise<SeedBrandingResult[]> {
  const results: SeedBrandingResult[] = [];

  for (const spec of DEFAULT_BRANDING_SOUND_SPECS) {
    if (!opts.force) {
      const { data: existing } = await (supabase as any)
        .from("manana_branding_sounds")
        .select("key, provider, storage_path, bytes, duration_ms")
        .eq("key", spec.key)
        .maybeSingle();

      if (existing?.storage_path) {
        results.push({
          action: "reused",
          key: spec.key,
          provider: existing.provider ?? "unknown",
          storagePath: existing.storage_path,
          bytes: existing.bytes ?? 0,
          durationMs: existing.duration_ms ?? Math.round(spec.durationSeconds * 1000),
        });
        continue;
      }
    }

    const generated = await createBrandingAudio(spec);
    const promptHash = hashSpec(spec, generated.provider, generated.model);
    const storagePath = storagePathFor(spec, generated.provider, promptHash);
    const audio = generated.audio;

    const tmpPath = path.join(os.tmpdir(), `manana-${spec.key}-${Date.now()}.mp3`);
    await fs.writeFile(tmpPath, audio);
    let durationMs = 0;
    try {
      durationMs = await probeDurationMs(tmpPath);
    } finally {
      await fs.rm(tmpPath, { force: true });
    }

    await uploadToBucket(supabase, storagePath, audio);

    const { error } = await (supabase as any)
      .from("manana_branding_sounds")
      .upsert(
        {
          key: spec.key,
          provider: generated.provider,
          model: generated.model,
          prompt: spec.prompt,
          storage_path: storagePath,
          duration_ms: durationMs,
          bytes: audio.length,
          prompt_hash: promptHash,
          generation_params: {
            duration_seconds: spec.durationSeconds,
            prompt_influence: spec.promptInfluence,
            gemini_prompt: spec.geminiPrompt,
            local_spec: spec.localSpec,
          },
          updated_at: new Date().toISOString(),
        },
        { onConflict: "key" },
      );
    if (error) {
      throw new Error(`Failed to upsert branding sound ${spec.key}: ${error.message}`);
    }

    results.push({
      action: "created",
      key: spec.key,
      provider: generated.provider,
      storagePath,
      bytes: audio.length,
      durationMs,
    });
  }

  return results;
}
