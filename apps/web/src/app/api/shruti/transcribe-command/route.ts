import { NextResponse } from "next/server";
import { GoogleGenerativeAI } from "@google/generative-ai";
import { createClient } from "@/lib/supabase/server";
import { logger } from "@/lib/logger";
import { aiRatelimit, extractClientIp } from "@/lib/rate-limit";
import { resolveGeminiApiKey } from "@/lib/env-keys";

// Shruti voice-command classification. Accepts a short audio blob, asks
// Gemini to pick a single command word, returns it. Plain text output
// (JSON schema mode is unreliable for audio inputs — Gemini wraps the
// answer in preambles like "Here is the JSON requested").

const geminiApiKey = resolveGeminiApiKey();

const COMMAND_PROMPT = [
  "Listen to the audio. The speaker is using a dictation app and said ONE",
  "short command. Identify it and output EXACTLY one word from this list:",
  "",
  "  spell   — heard as: spell, spell it, spell that",
  "  repeat  — heard as: repeat, again, say again, one more time",
  "  back    — heard as: back, previous, go back",
  "  where   — heard as: where, where am i, what sentence, position",
  "  pause   — heard as: pause, stop, wait, hold on",
  "  resume  — heard as: resume, start again, continue reading",
  "  next    — heard as: next, continue, go on, go ahead, move on",
  "  none    — silence, unintelligible noise, or no clear command",
  "",
  "RULES:",
  "- Output ONLY the single word answer. No explanation, no preamble, no",
  "  punctuation, no quotes, no 'Here is...', no JSON.",
  "- If you are uncertain, output 'none'. Do not guess.",
  "- 'next' should ONLY be picked when you clearly heard 'next' or one of",
  "  its variants. Do not default to 'next' for uncertain audio.",
].join("\n");

const VALID_COMMANDS = new Set([
  "spell", "repeat", "back", "where", "pause", "resume", "next", "none",
]);

export async function POST(req: Request) {
  if (!geminiApiKey) {
    return NextResponse.json({ error: "no_api_key" }, { status: 500 });
  }

  const { success } = await aiRatelimit.limit(extractClientIp(req));
  if (!success) {
    return NextResponse.json(
      { error: "rate_limited" },
      { status: 429, headers: { "Retry-After": "30" } },
    );
  }

  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    return NextResponse.json({ error: "unauthenticated" }, { status: 401 });
  }

  const form = await req.formData();
  const audio = form.get("audio");
  if (!(audio instanceof Blob)) {
    return NextResponse.json({ error: "missing_audio" }, { status: 400 });
  }
  if (audio.size > 300_000) {
    return NextResponse.json({ error: "audio_too_large" }, { status: 400 });
  }

  const arrayBuffer = await audio.arrayBuffer();
  const base64 = Buffer.from(arrayBuffer).toString("base64");
  const mimeType = audio.type || "audio/webm";

  try {
    const genAI = new GoogleGenerativeAI(geminiApiKey);
    const model = genAI.getGenerativeModel({
      model: "gemini-2.5-flash",
      generationConfig: { temperature: 0, maxOutputTokens: 16 },
    });

    const raw = await callGeminiWithRetry(async () => {
      const result = await model.generateContent([
        { text: COMMAND_PROMPT },
        { inlineData: { data: base64, mimeType } },
      ]);
      return result.response.text();
    }, 2);

    // Defensive parse: lowercase, strip everything that isn't a-z or space,
    // then take the first word that's in our valid set. Handles "Here is
    // the answer: spell.", "**spell**", JSON-wrapped responses, etc.
    const cleaned = raw.toLowerCase().replace(/[^a-z\s]/g, " ");
    const words = cleaned.split(/\s+/).filter(Boolean);
    let command = "";
    for (const w of words) {
      if (VALID_COMMANDS.has(w)) { command = w; break; }
    }
    const text = command && command !== "none" ? command : "";

    logger.info(
      `[Shruti] classify: bytes=${audio.size} raw=${JSON.stringify(raw.slice(0, 120))} command=${JSON.stringify(command)} → ${JSON.stringify(text)}`,
    );

    return NextResponse.json({ transcript: text });
  } catch (err) {
    const msg = err instanceof Error ? err.message : "unknown";
    logger.error("[Shruti] classify failed:", msg);
    return NextResponse.json({ transcript: "", error: msg });
  }
}

async function callGeminiWithRetry(
  fn: () => Promise<string>,
  retries: number,
): Promise<string> {
  let lastErr: unknown = null;
  for (let attempt = 0; attempt <= retries; attempt++) {
    try {
      return await fn();
    } catch (err) {
      lastErr = err;
      const msg = err instanceof Error ? err.message : String(err);
      const isOverload = /503|overload|unavailable|high demand/i.test(msg);
      if (attempt < retries && isOverload) {
        await new Promise((r) => setTimeout(r, 400 * (attempt + 1)));
        continue;
      }
      throw err;
    }
  }
  throw lastErr;
}
