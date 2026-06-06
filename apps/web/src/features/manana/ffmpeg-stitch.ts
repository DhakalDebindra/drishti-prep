import { spawn } from "node:child_process";
import fs from "node:fs/promises";
// ffmpeg-static exports the absolute path to the bundled binary. Typed as
// `string | null` because on some platforms the postinstall step doesn't
// produce a binary (extremely rare in our deploy targets).
import ffmpegPath from "ffmpeg-static";

const STEM_PAUSE_SEC = 4.0;
const RESOLUTION_PAUSE_SEC = 1.5;
const OUTPUT_SAMPLE_RATE = 24_000;

export type StitchBlock = {
  stemPath: string;
  resolutionPath: string;
};

export type BrandingCuePack = {
  introStingPath?: string;
  questionTransitionPath?: string;
  sectionBreakPath?: string;
  outroLogoPath?: string;
};

export type StitchInputs = {
  introPath: string;
  blocks: StitchBlock[];
  branding?: BrandingCuePack;
  outroPath: string;
  outPath: string;
};

type EpisodeSegment = {
  path: string;
  padDurSec?: number;
};

function buildEpisodeSegments(inputs: StitchInputs): EpisodeSegment[] {
  const segments: EpisodeSegment[] = [];
  if (inputs.branding?.introStingPath) {
    segments.push({ path: inputs.branding.introStingPath });
  }
  segments.push({ path: inputs.introPath });
  if (inputs.blocks.length > 0 && inputs.branding?.sectionBreakPath) {
    segments.push({ path: inputs.branding.sectionBreakPath });
  }
  inputs.blocks.forEach((block, index) => {
    segments.push({ path: block.stemPath, padDurSec: STEM_PAUSE_SEC });
    segments.push({ path: block.resolutionPath, padDurSec: RESOLUTION_PAUSE_SEC });
    if (index < inputs.blocks.length - 1 && inputs.branding?.questionTransitionPath) {
      segments.push({ path: inputs.branding.questionTransitionPath });
    }
  });
  if (inputs.blocks.length > 0 && inputs.branding?.sectionBreakPath) {
    segments.push({ path: inputs.branding.sectionBreakPath });
  }
  segments.push({ path: inputs.outroPath });
  if (inputs.branding?.outroLogoPath) {
    segments.push({ path: inputs.branding.outroLogoPath });
  }
  return segments;
}

// Build the -filter_complex string for an episode made of arbitrary segments.
// Every input is normalized to mono/24k before concat so Gemini speech and
// ElevenLabs stingers can be stitched in one re-encode pass.
function buildFilterComplex(segments: EpisodeSegment[]): string {
  const lines: string[] = [];
  const concatParts: string[] = [];
  segments.forEach((segment, index) => {
    const outLabel = `seg${index}`;
    const normalize = `[${index}:a]aformat=sample_rates=${OUTPUT_SAMPLE_RATE}:channel_layouts=mono`;
    if (segment.padDurSec && segment.padDurSec > 0) {
      lines.push(`${normalize},apad=pad_dur=${segment.padDurSec}[${outLabel}]`);
    } else {
      lines.push(`${normalize}[${outLabel}]`);
    }
    concatParts.push(`[${outLabel}]`);
  });
  lines.push(`${concatParts.join("")}concat=n=${segments.length}:v=0:a=1[out]`);
  return lines.join("; ");
}

export type StitchResult = {
  outPath: string;
  bytes: number;
};

export async function stitchEpisode(inputs: StitchInputs): Promise<StitchResult> {
  if (!ffmpegPath) {
    throw new Error("ffmpeg-static did not provide a binary path");
  }

  const segments = buildEpisodeSegments(inputs);
  const inputArgs: string[] = ["-y"];
  for (const segment of segments) {
    inputArgs.push("-i", segment.path);
  }

  const filter = buildFilterComplex(segments);

  const args = [
    ...inputArgs,
    "-filter_complex", filter,
    "-map", "[out]",
    "-c:a", "libmp3lame",
    // 96kbps mono CBR — matches the source TTS bitrate. Higher would be
    // wasted on speech that was already 96k mono going in.
    "-b:a", "96k",
    "-ac", "1",
    inputs.outPath,
  ];

  await new Promise<void>((resolve, reject) => {
    const proc = spawn(ffmpegPath as string, args, { stdio: ["ignore", "pipe", "pipe"] });
    const stderrChunks: Buffer[] = [];
    proc.stderr.on("data", (c) => stderrChunks.push(Buffer.from(c)));
    proc.on("error", (err) => reject(err));
    proc.on("close", (code) => {
      if (code === 0) {
        resolve();
      } else {
        const tail = Buffer.concat(stderrChunks).toString("utf8").slice(-2000);
        reject(new Error(`ffmpeg exited ${code}: ${tail}`));
      }
    });
  });

  const stat = await fs.stat(inputs.outPath);
  return { outPath: inputs.outPath, bytes: stat.size };
}

// Probe the final MP3 duration so we can persist duration_ms. Uses ffmpeg
// itself (no separate ffprobe binary). Parses stderr for "Duration: HH:MM:SS.cs".
export async function probeDurationMs(filePath: string): Promise<number> {
  if (!ffmpegPath) throw new Error("ffmpeg-static did not provide a binary path");
  return await new Promise<number>((resolve, reject) => {
    const proc = spawn(ffmpegPath as string, ["-i", filePath, "-f", "null", "-"], {
      stdio: ["ignore", "ignore", "pipe"],
    });
    const chunks: Buffer[] = [];
    proc.stderr.on("data", (c) => chunks.push(Buffer.from(c)));
    proc.on("error", reject);
    proc.on("close", () => {
      const stderr = Buffer.concat(chunks).toString("utf8");
      const m = stderr.match(/Duration:\s*(\d+):(\d+):(\d+(?:\.\d+)?)/);
      if (!m) {
        resolve(0);
        return;
      }
      const h = Number(m[1]);
      const min = Number(m[2]);
      const sec = Number(m[3]);
      resolve(Math.round((h * 3600 + min * 60 + sec) * 1000));
    });
  });
}
