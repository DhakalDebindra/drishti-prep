import { config } from "dotenv";
import { createClient } from "@supabase/supabase-js";
import { ensureBrandingSoundCatalog } from "@/features/manana/branding-sounds";

config({ path: ".env.local" });

const sb = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!,
  { auth: { persistSession: false } },
);

async function main() {
  const force = process.argv.includes("--force");
  const results = await ensureBrandingSoundCatalog(sb as any, { force });
  console.log("Branding cue providers:", results.map((r) => `${r.key}:${r.provider}`).join(", "));
  console.log(JSON.stringify(results, null, 2));
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});
