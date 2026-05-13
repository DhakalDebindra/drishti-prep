#!/usr/bin/env node
// Voice pilot for DrishtiPrep tutor-voice feature.
// Calls Gemini 2.5 Flash TTS REST endpoint directly (legacy SDK doesn't support audio modality).
// Outputs one WAV per voice in this directory.

import { readFileSync, writeFileSync, existsSync } from "node:fs";
import { resolve, dirname } from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = dirname(fileURLToPath(import.meta.url));

function loadEnv() {
  const envPath = resolve(__dirname, "../../apps/web/.env.local");
  if (!existsSync(envPath)) {
    throw new Error(`Missing ${envPath}. Copy from main checkout first.`);
  }
  const raw = readFileSync(envPath, "utf8");
  for (const line of raw.split(/\r?\n/)) {
    const m = line.match(/^([A-Z_][A-Z0-9_]*)\s*=\s*(.*)$/);
    if (!m) continue;
    let v = m[2].trim();
    if ((v.startsWith('"') && v.endsWith('"')) || (v.startsWith("'") && v.endsWith("'"))) {
      v = v.slice(1, -1);
    }
    process.env[m[1]] = v;
  }
}

loadEnv();

const KEY = process.env.GEMINI_API_KEY || process.env.DRISHTI_API_KEY || process.env.DrishtiApiKey;
if (!KEY) throw new Error("GEMINI_API_KEY not set in apps/web/.env.local");

const MODEL = "gemini-2.5-flash-preview-tts";
const ENDPOINT = `https://generativelanguage.googleapis.com/v1beta/models/${MODEL}:generateContent?key=${KEY}`;

const SCRIPT = `प्रश्न दुई।

नेपाल सरकार वैधानिक कानुन २००४ को घोषणा कहिले भएको थियो?

विकल्प क। २००४ माघ १३।
विकल्प ख। २००४ फागुन ७।
विकल्प ग। २००५ वैशाख १।
विकल्प घ। २००४ माघ २६।

व्याख्या। सही उत्तर क हो। ख प्रजातन्त्र घोषणाको वर्ष हो। ग यो संविधान लागू हुने भनिएको तर नभएको मिति हो।`;

const VOICES = (process.env.PILOT_VOICES || "Kore,Puck,Charon,Aoede,Leda").split(",");

const SAMPLE_RATE = 24000;
const NUM_CHANNELS = 1;
const BITS_PER_SAMPLE = 16;

function wavHeader(dataLen) {
  const byteRate = (SAMPLE_RATE * NUM_CHANNELS * BITS_PER_SAMPLE) / 8;
  const blockAlign = (NUM_CHANNELS * BITS_PER_SAMPLE) / 8;
  const b = Buffer.alloc(44);
  b.write("RIFF", 0);
  b.writeUInt32LE(36 + dataLen, 4);
  b.write("WAVE", 8);
  b.write("fmt ", 12);
  b.writeUInt32LE(16, 16);
  b.writeUInt16LE(1, 20);
  b.writeUInt16LE(NUM_CHANNELS, 22);
  b.writeUInt32LE(SAMPLE_RATE, 24);
  b.writeUInt32LE(byteRate, 28);
  b.writeUInt16LE(blockAlign, 32);
  b.writeUInt16LE(BITS_PER_SAMPLE, 34);
  b.write("data", 36);
  b.writeUInt32LE(dataLen, 40);
  return b;
}

async function synth(voice) {
  const body = {
    contents: [{ parts: [{ text: SCRIPT }] }],
    generationConfig: {
      responseModalities: ["AUDIO"],
      speechConfig: {
        voiceConfig: { prebuiltVoiceConfig: { voiceName: voice } },
      },
    },
  };
  const t0 = Date.now();
  const res = await fetch(ENDPOINT, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(body),
  });
  const dt = Date.now() - t0;
  if (!res.ok) {
    const txt = await res.text();
    throw new Error(`${voice}: HTTP ${res.status} — ${txt.slice(0, 500)}`);
  }
  const json = await res.json();
  const part = json.candidates?.[0]?.content?.parts?.[0];
  const b64 = part?.inlineData?.data;
  if (!b64) {
    throw new Error(`${voice}: no inlineData in response — ${JSON.stringify(json).slice(0, 500)}`);
  }
  const pcm = Buffer.from(b64, "base64");
  return { pcm, latencyMs: dt, mimeType: part?.inlineData?.mimeType };
}

async function main() {
  console.log(`Pilot script length: ${SCRIPT.length} chars`);
  console.log(`Testing ${VOICES.length} voices against model ${MODEL}\n`);
  const results = [];
  for (const voice of VOICES) {
    process.stdout.write(`  ${voice.padEnd(8)} ... `);
    try {
      const { pcm, latencyMs, mimeType } = await synth(voice);
      const out = resolve(__dirname, `${voice.toLowerCase()}.wav`);
      writeFileSync(out, Buffer.concat([wavHeader(pcm.length), pcm]));
      const secs = (pcm.length / (SAMPLE_RATE * NUM_CHANNELS * (BITS_PER_SAMPLE / 8))).toFixed(1);
      console.log(`ok (${secs}s audio, ${latencyMs}ms gen, mime=${mimeType})`);
      results.push({ voice, ok: true, secs: Number(secs), latencyMs });
    } catch (err) {
      console.log(`FAIL — ${err.message}`);
      results.push({ voice, ok: false, error: err.message });
    }
  }
  console.log("\nDone.");
  console.log("Files written:");
  for (const r of results.filter((r) => r.ok)) {
    console.log(`  scratch/voice-pilot/${r.voice.toLowerCase()}.wav   ${r.secs}s`);
  }
  const totalSecs = results.filter((r) => r.ok).reduce((a, b) => a + b.secs, 0);
  const tokensEst = Math.round(totalSecs * 32);
  const usdEst = (tokensEst * 10) / 1_000_000;
  console.log(`\nApprox cost: ${tokensEst} tokens ≈ $${usdEst.toFixed(4)} USD`);
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});
