// Render an existing Manana episode script via ElevenLabs voices for A/B
// quality comparison against the platform's Gemini-TTS output. Writes a
// stitched MP3 (no branding sounds) to apps/web/tmp/.
//
// Prerequisites:
//   - apps/web/.env.local with SUPABASE_SERVICE_ROLE_KEY, ELEVENLABS_API_KEY
//   - An existing manana_episodes row with script_json populated. If you
//     don't have one yet, run `pnpm -C apps/web test:manana-script -- --user <uuid>`
//     first and note the episode_id it prints.
//
// Usage:
//   pnpm -C apps/web test:manana-elevenlabs -- --episode <episode_id>
//   pnpm -C apps/web test:manana-elevenlabs -- --user <user_id>
//   pnpm -C apps/web test:manana-elevenlabs -- --user <user_id> --week 2026-05-25
//
// Optional env overrides:
//   ELEVENLABS_VOICE_ID   — voice ID from elevenlabs.io/voices (default: Sarah)
//   ELEVENLABS_VOICE_MODEL — model id (default: eleven_multilingual_v2)

import fs from "node:fs/promises";
import path from "node:path";
import { config } from "dotenv";
import { createClient } from "@supabase/supabase-js";
import { synthesizeNepaliElevenLabs } from "../src/lib/elevenlabs-tts";
import {
  stitchEpisode,
  probeDurationMs,
  type StitchBlock,
} from "../src/features/manana/ffmpeg-stitch";
import type { MananaEpisodeScript } from "../src/features/manana/prompts";

config({ path: ".env.local" });

function arg(flag: string): string | undefined {
  const idx = process.argv.indexOf(flag);
  return idx >= 0 ? process.argv[idx + 1] : undefined;
}

const episodeIdArg = arg("--episode");
const userIdArg = arg("--user");
const weekStartingArg = arg("--week");

if (!episodeIdArg && !userIdArg) {
  console.error(
    "Usage: pnpm test:manana-elevenlabs -- --episode <id>  OR  --user <uuid> [--week YYYY-MM-DD]",
  );
  process.exit(1);
}

const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
if (!url || !serviceKey) {
  console.error("Missing NEXT_PUBLIC_SUPABASE_URL or SUPABASE_SERVICE_ROLE_KEY");
  process.exit(1);
}
if (!process.env.ELEVENLABS_API_KEY) {
  console.error("Missing ELEVENLABS_API_KEY");
  process.exit(1);
}

const sb = createClient(url, serviceKey, { auth: { persistSession: false } });

type EpisodeRow = {
  id: string;
  user_id: string;
  week_starting: string;
  script_json: MananaEpisodeScript | null;
};

async function loadEpisode(): Promise<EpisodeRow> {
  if (episodeIdArg) {
    const { data, error } = await (sb as any)
      .from("manana_episodes")
      .select("id, user_id, week_starting, script_json")
      .eq("id", episodeIdArg)
      .single();
    if (error || !data) throw new Error(`Episode ${episodeIdArg} not found: ${error?.message ?? "unknown"}`);
    return data as EpisodeRow;
  }

  let q = (sb as any)
    .from("manana_episodes")
    .select("id, user_id, week_starting, script_json")
    .eq("user_id", userIdArg as string);
  if (weekStartingArg) q = q.eq("week_starting", weekStartingArg);
  const { data, error } = await q.order("created_at", { ascending: false }).limit(1);
  if (error) throw error;
  if (!data || data.length === 0) {
    throw new Error(
      `No episode found for user ${userIdArg}${weekStartingArg ? ` (week ${weekStartingArg})` : ""}`,
    );
  }
  return data[0] as EpisodeRow;
}

async function main() {
  const ep = await loadEpisode();
  if (!ep.script_json) {
    throw new Error(
      `Episode ${ep.id} has no script_json — run test:manana-script first to populate it`,
    );
  }
  const script = ep.script_json;
  console.log(
    `Loaded episode ${ep.id} (week ${ep.week_starting}, ${script.revision_blocks.length} blocks)`,
  );

  const outDir = path.join(process.cwd(), "tmp", `manana-${ep.id}-elevenlabs`);
  await fs.mkdir(outDir, { recursive: true });

  const introPath = path.join(outDir, "intro.mp3");
  const outroPath = path.join(outDir, "outro.mp3");
  const blockPaths: StitchBlock[] = script.revision_blocks.map((_, i) => ({
    stemPath: path.join(outDir, `stem_${i}.mp3`),
    resolutionPath: path.join(outDir, `res_${i}.mp3`),
  }));

  type Task = { name: string; text: string; out: string };
  const tasks: Task[] = [
    { name: "intro", text: script.episode_intro, out: introPath },
  ];
  script.revision_blocks.forEach((b, i) => {
    tasks.push({ name: `stem_${i}`, text: b.stem_text, out: blockPaths[i].stemPath });
    tasks.push({ name: `res_${i}`, text: b.resolution_text, out: blockPaths[i].resolutionPath });
  });
  tasks.push({ name: "outro", text: script.episode_outro, out: outroPath });

  console.log(`Synthesizing ${tasks.length} segments via ElevenLabs…`);
  const t0 = performance.now();
  // Issue in parallel — the module's internal throttle serialises requests.
  await Promise.all(
    tasks.map(async (t) => {
      const { mp3, latencyMs, bytes } = await synthesizeNepaliElevenLabs(t.text);
      await fs.writeFile(t.out, mp3);
      console.log(
        `  ✓ ${t.name.padEnd(10)} ${bytes.toString().padStart(7)} B  ${latencyMs} ms`,
      );
    }),
  );
  const synthMs = Math.round(performance.now() - t0);

  const finalPath = path.join(outDir, "episode.mp3");
  console.log(`Stitching → ${finalPath}`);
  const { bytes } = await stitchEpisode({
    introPath,
    blocks: blockPaths,
    branding: undefined, // intentional: no SFX for this comparison
    outroPath,
    outPath: finalPath,
  });
  const durationMs = await probeDurationMs(finalPath);

  console.log("\nDone.");
  console.log(`  file:        ${finalPath}`);
  console.log(`  bytes:       ${bytes}`);
  console.log(`  duration:    ${(durationMs / 1000).toFixed(1)} s`);
  console.log(`  synth time:  ${(synthMs / 1000).toFixed(1)} s`);
  console.log(
    `  voice:       ${process.env.ELEVENLABS_VOICE_ID ?? "EXAVITQu4vr4xnSDxMaL (Sarah)"}`,
  );
  console.log(
    `  model:       ${process.env.ELEVENLABS_VOICE_MODEL ?? "eleven_multilingual_v2"}`,
  );
}

main().catch((e) => {
  console.error("\nFAILED:", e instanceof Error ? e.message : e);
  process.exit(1);
});
