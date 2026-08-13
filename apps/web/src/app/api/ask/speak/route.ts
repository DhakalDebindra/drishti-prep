import { NextResponse } from "next/server";

import { createClient } from "@/lib/supabase/server";
import { aiRatelimit, extractClientIp } from "@/lib/rate-limit";
import { DEFAULT_VOICE, synthesizeNepali } from "@/lib/tts-service";

export const runtime = "nodejs";
export const maxDuration = 300;

/**
 * Read one AI reply aloud in Gemini's Nepali voice.
 *
 * Deliberately not the browser's speechSynthesis. That was the first
 * implementation — free and instant — but a generic engine reading Devanagari
 * is unpleasant enough that a learner who depends on audio will not use it.
 * For an audience that is blind or low-vision, the voice IS the interface, so
 * a natural one is worth the call.
 *
 * The text comes from the stored message rather than the request body: a
 * client that could post arbitrary text would turn this into an open TTS
 * endpoint billed to us. RLS on ask_messages also means a learner can only
 * ever synthesise their own replies.
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
    const messageId = typeof body?.message_id === "string" ? body.message_id : "";
    if (!/^[0-9a-f-]{36}$/i.test(messageId)) {
      return NextResponse.json({ error: "Invalid message_id" }, { status: 400 });
    }

    // RLS restricts this to threads the caller owns.
    const { data: message, error } = await (supabase as any)
      .from("ask_messages")
      .select("content, role")
      .eq("id", messageId)
      .maybeSingle();

    if (error || !message) {
      return NextResponse.json({ error: "Not found" }, { status: 404 });
    }
    if (message.role !== "assistant" || !message.content?.trim()) {
      return NextResponse.json({ error: "Nothing to read" }, { status: 400 });
    }

    // Flash tier: substantially higher daily and per-minute quotas than Pro,
    // which matters because this is on-demand rather than pre-generated.
    const { mp3 } = await synthesizeNepali(message.content, DEFAULT_VOICE, {
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
