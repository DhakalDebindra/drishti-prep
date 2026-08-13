import { NextResponse } from "next/server";

import { createClient } from "@/lib/supabase/server";
import { verifySpeech } from "@/lib/ask/speech-token";
import { aiRatelimit, extractClientIp } from "@/lib/rate-limit";
import { DEFAULT_VOICE, synthesizeNepali } from "@/lib/tts-service";

export const runtime = "nodejs";
export const maxDuration = 300;

/** Longest reply we will read aloud. A lesson is far shorter than this. */
const MAX_TEXT_LENGTH = 6000;

/**
 * Read one AI reply aloud in Gemini's Nepali voice.
 *
 * Deliberately not the browser's speechSynthesis. That was the first
 * implementation — free and instant — but a generic engine reading Devanagari
 * is unpleasant enough that a learner who depends on audio will not use it.
 * For an audience that is blind or low-vision, the voice IS the interface.
 *
 * The text arrives in the request, but only with a signature this server issued
 * for this learner within the hour. Without that check a client could post any
 * text and turn this into an open text-to-speech service billed to us; with it,
 * we can synthesise a reply we never stored.
 */
export async function POST(req: Request) {
  try {
    const { success } = await aiRatelimit.limit(extractClientIp(req));
    if (!success) {
      return NextResponse.json(
        { error: "Too many requests. Please wait a moment." },
        { status: 429, headers: { "Retry-After": "60" } }
      );
    }

    const supabase = await createClient();
    const {
      data: { user },
    } = await supabase.auth.getUser();
    if (!user) {
      return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    }

    const body = await req.json().catch(() => null);
    const text = typeof body?.text === "string" ? body.text : "";
    const token = typeof body?.token === "string" ? body.token : "";

    if (!text.trim() || text.length > MAX_TEXT_LENGTH) {
      return NextResponse.json({ error: "Nothing to read" }, { status: 400 });
    }

    if (!verifySpeech(text, user.id, token)) {
      // Either not our text, not this learner's, or older than an hour.
      return NextResponse.json({ error: "Invalid request" }, { status: 403 });
    }

    // Flash tier: substantially higher daily and per-minute quotas than Pro,
    // which matters because this is on-demand rather than pre-generated.
    const { mp3 } = await synthesizeNepali(text, DEFAULT_VOICE, {
      modelTier: "flash",
    });

    return new NextResponse(new Uint8Array(mp3), {
      headers: {
        "Content-Type": "audio/mpeg",
        "Content-Length": String(mp3.length),
        // Private: this is one learner's own reply, not shared content.
        "Cache-Control": "private, max-age=3600",
      },
    });
  } catch (caught) {
    console.error("[api/ask/speak] failed:", caught);
    return NextResponse.json({ error: "Could not generate audio" }, { status: 500 });
  }
}
