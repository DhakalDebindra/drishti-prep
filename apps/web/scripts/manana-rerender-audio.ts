// Re-render the audio for an existing Manana episode whose `script_json` has
// been updated (typically by re-running test:manana-script after a prompt
// change). The worker normally refuses to recompile if `storage_path` is
// already set; this helper clears it first and re-invokes the worker.
//
// Usage:
//   pnpm -C apps/web rerender:manana -- --episode <episode_id>

import { config } from "dotenv";
import { createClient } from "@supabase/supabase-js";
import { compileEpisodeAudio } from "../src/features/manana/worker";

// Idempotent: tsx --env-file already loaded these, but keep dotenv as belt-and-
// braces so this script also runs via `node` if invoked directly.
config({ path: ".env.local" });

function arg(flag: string): string | undefined {
  const idx = process.argv.indexOf(flag);
  return idx >= 0 ? process.argv[idx + 1] : undefined;
}

const episodeId = arg("--episode");
if (!episodeId) {
  console.error("Usage: pnpm rerender:manana -- --episode <episode_id>");
  process.exit(1);
}

const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
if (!url || !serviceKey) {
  console.error("Missing NEXT_PUBLIC_SUPABASE_URL or SUPABASE_SERVICE_ROLE_KEY");
  process.exit(1);
}

const sb = createClient(url, serviceKey, { auth: { persistSession: false } });

async function main() {
  console.log(`Clearing storage_path on episode ${episodeId} to force re-render…`);
  const { error: clearErr } = await (sb as any)
    .from("manana_episodes")
    .update({
      storage_path: null,
      duration_ms: null,
      bytes: null,
      status: "generating",
      error_message: null,
      generated_at: null,
      updated_at: new Date().toISOString(),
    })
    .eq("id", episodeId);
  if (clearErr) throw new Error(`Failed to clear storage_path: ${clearErr.message}`);

  console.log("Compiling episode audio (this fetches TTS for every segment in parallel)…");
  const t0 = performance.now();
  const result = await compileEpisodeAudio(sb as any, episodeId!);
  const ms = Math.round(performance.now() - t0);

  console.log(`\nDone in ${(ms / 1000).toFixed(1)}s.`);
  console.log(`  episode_id:   ${result.episodeId}`);
  console.log(`  storage_path: ${result.storagePath}`);
  console.log(`  duration:     ${(result.durationMs / 1000).toFixed(1)} s`);
  console.log(`  bytes:        ${result.bytes}`);
  console.log(`  cache hits:   ${result.cacheHits}`);
  console.log(`  cache misses: ${result.cacheMisses}`);
  console.log(`\nOpen the Manana player in your app to listen, or fetch from`);
  console.log(`Supabase Storage bucket "manana-episodes" at path: ${result.storagePath}`);
}

main().catch((e) => {
  console.error("\nFAILED:", e instanceof Error ? e.message : e);
  process.exit(1);
});
