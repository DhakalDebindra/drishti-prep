// Empirically determine which Gemini API rate-limit tier the configured
// GEMINI_API_KEY is on. There's no Google-provided endpoint that returns
// "your tier", so we probe by firing a small burst at gemini-2.5-flash
// (text) and observing where 429s start.
//
// Known limits per Google docs (May 2026):
//
//          gemini-2.5-flash (text)         gemini-2.5-flash-preview-tts
//   Free   10 RPM, 250 RPD                 3 RPM, 15 RPD
//   T1     1,000 RPM, 10,000 RPD           10 RPM, 100 RPD
//   T2+    much higher                     higher
//
// Probe uses gemini-2.5-flash text (cheap, separable from TTS), 15
// sequential calls, very short prompts. Cost: ~15 × ~20 tokens ≈ trivial.
//
// Interpretation:
//   • 0 successes      → key is invalid or hard-blocked
//   • 1–10 successes   → FREE tier (10 RPM cap)
//   • 11–15 successes  → at least TIER 1
//
// Tier 1 vs Tier 2 can't be distinguished here (both > 15 RPM); the
// console at https://console.cloud.google.com/iam-admin/quotas is the
// authoritative source for that.
//
// Usage:  pnpm -C apps/web diag:gemini-tier
//
// Re-run any time you suspect billing or shared-key quota issues — e.g.
// after a colleague reports rate-limit errors, or before kicking off a
// heavy batch render. Costs ~15 cheap text-only calls.

import { config } from "dotenv";
config({ path: ".env.local" });

const KEY = process.env.GEMINI_API_KEY;
if (!KEY) {
  console.error("Missing GEMINI_API_KEY in apps/web/.env.local");
  process.exit(1);
}

const ENDPOINT = `https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=${KEY}`;
const N_PROBES = 15;
// Keep this tiny — we only care about the request rate, not the output.
const PROMPT = "Reply with the single character: x";

type ProbeResult =
  | { ok: true; status: number; latencyMs: number }
  | { ok: false; status: number; latencyMs: number; body: string };

async function probe(i: number): Promise<ProbeResult> {
  const t0 = Date.now();
  try {
    const res = await fetch(ENDPOINT, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        contents: [{ role: "user", parts: [{ text: PROMPT }] }],
        generationConfig: { temperature: 0, maxOutputTokens: 4 },
      }),
    });
    const latencyMs = Date.now() - t0;
    if (res.ok) return { ok: true, status: res.status, latencyMs };
    const body = await res.text().catch(() => "");
    return { ok: false, status: res.status, latencyMs, body: body.slice(0, 300) };
  } catch (e) {
    return {
      ok: false,
      status: 0,
      latencyMs: Date.now() - t0,
      body: e instanceof Error ? e.message : String(e),
    };
  }
}

async function main() {
  console.log(
    `Probing gemini-2.5-flash text endpoint with ${N_PROBES} sequential requests…\n`,
  );

  const results: ProbeResult[] = [];
  const tStart = Date.now();
  for (let i = 1; i <= N_PROBES; i++) {
    const r = await probe(i);
    results.push(r);
    const marker = r.ok ? "✓" : r.status === 429 ? "⏸" : "✗";
    const status = r.ok ? `200 OK` : `${r.status} ${r.body.slice(0, 80)}`;
    console.log(
      `  ${marker} probe ${i.toString().padStart(2)}/${N_PROBES}  ${r.latencyMs.toString().padStart(4)}ms  ${status}`,
    );
  }
  const elapsed = ((Date.now() - tStart) / 1000).toFixed(1);

  const successes = results.filter((r) => r.ok).length;
  const rateLimited = results.filter((r) => !r.ok && r.status === 429).length;
  const other = results.filter((r) => !r.ok && r.status !== 429).length;

  console.log("\n─── Result ───────────────────────────────");
  console.log(`  Sent:           ${N_PROBES} requests in ${elapsed}s`);
  console.log(`  Succeeded:      ${successes}`);
  console.log(`  Rate-limited:   ${rateLimited}`);
  console.log(`  Other errors:   ${other}`);

  let tier: string;
  if (successes === 0) {
    tier =
      other > 0
        ? "❌ Key invalid or auth error — see body above. Not a tier issue."
        : "❌ All requests failed without 429s — likely network / endpoint issue.";
  } else if (successes <= 10 && rateLimited > 0) {
    tier =
      "🟡 FREE TIER. Billing is NOT effectively enabled for this API key's project.\n" +
      "       Verify: https://console.cloud.google.com/billing/projects\n" +
      "       The key in .env.local may be on a different project than the one billed.";
  } else if (successes >= 11) {
    tier =
      "🟢 At least TIER 1 (paid billing active for this key's project).\n" +
      "       To distinguish Tier 1 vs Tier 2, check the dashboard:\n" +
      "       https://console.cloud.google.com/iam-admin/quotas?metric=generativelanguage.googleapis.com%2Fgenerate_requests_per_model\n" +
      "       Tier 1: ~1,000 RPM cap. Tier 2: ~2,000 RPM. Tier 3: ~10,000 RPM.";
  } else {
    tier = "🟡 INCONCLUSIVE — try re-running in a few minutes.";
  }

  console.log(`\n  Verdict:        ${tier}`);
  console.log("\n  NOTE ON TTS QUOTA:");
  console.log(
    "  This probe checks gemini-2.5-flash (text). The TTS model used by",
  );
  console.log(
    "  Manana (gemini-2.5-flash-preview-tts) is a PREVIEW model with its",
  );
  console.log(
    "  own, much smaller quota bucket — Tier 1 gives only 10 RPM / 100 RPD",
  );
  console.log(
    "  on the preview-TTS model even when this probe shows Tier 1 here.",
  );
}

main().catch((e) => {
  console.error("FAILED:", e);
  process.exit(1);
});
