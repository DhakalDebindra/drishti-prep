// Manana script-compiler smoke test.
//
// Compiles a single Manana episode script for one user and prints the JSON
// to stdout. Use this to eyeball Nepali/English code-switching quality and
// verify the LLM is honouring the schema before S4 (TTS + ffmpeg) lands.
//
// Usage:
//   pnpm -C apps/web test:manana-script -- --user <uuid>
//   pnpm -C apps/web test:manana-script -- --user <uuid> --week 2026-05-25
//
// Requires SUPABASE_SERVICE_ROLE_KEY + GEMINI_API_KEY in apps/web/.env.local.

import { config } from "dotenv";
import { createClient } from "@supabase/supabase-js";
import { generateEpisodeScript } from "../src/lib/manana/generate-script";

config({ path: ".env.local" });

function arg(flag: string): string | undefined {
  const idx = process.argv.indexOf(flag);
  return idx >= 0 ? process.argv[idx + 1] : undefined;
}

const userId = arg("--user");
const weekStarting = arg("--week");

if (!userId) {
  console.error("Missing --user <uuid>");
  process.exit(1);
}

const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
if (!url || !serviceKey) {
  console.error("Missing NEXT_PUBLIC_SUPABASE_URL or SUPABASE_SERVICE_ROLE_KEY");
  process.exit(1);
}
if (!process.env.GEMINI_API_KEY) {
  console.error("Missing GEMINI_API_KEY");
  process.exit(1);
}

const sb = createClient(url, serviceKey, { auth: { persistSession: false } });

async function main() {
  console.log(`Compiling Manana episode for user ${userId}${weekStarting ? ` (week ${weekStarting})` : ""}…`);
  const t0 = performance.now();
  const result = await generateEpisodeScript(sb as any, userId!, { weekStarting });
  const ms = Math.round(performance.now() - t0);
  console.log(`\nDone in ${ms}ms. episode_id=${result.episodeId} week=${result.weekStarting}\n`);
  console.log(JSON.stringify(result.script, null, 2));
}

main().catch((e) => {
  console.error("\nFAILED:", e instanceof Error ? e.message : e);
  process.exit(1);
});
