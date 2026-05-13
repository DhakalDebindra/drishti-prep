import { NextResponse } from "next/server";
import { createClient } from "@/lib/supabase/server";
import { SEGMENTS, storagePathFor } from "@/lib/tts-service";

export const runtime = "nodejs";

const BUCKET = "question-audio";

type Ctx = { params: Promise<{ id: string }> };

/**
 * Returns the public audio URLs for a question if generation is complete.
 *
 * Read-only, no auth required (audio is meant to be played by anyone, just
 * like the question text itself is publicly readable). If audio hasn't been
 * generated yet, returns `{ ready: false }`; the client falls back to the
 * non-tutor screen-reader path.
 */
export async function GET(_req: Request, ctx: Ctx) {
  try {
    const { id } = await ctx.params;
    if (!id || !/^[0-9a-f-]{36}$/i.test(id)) {
      return NextResponse.json({ error: "Invalid question id" }, { status: 400 });
    }

    const supabase = await createClient();
    const { data: q } = await (supabase as any)
      .from("questions")
      .select("audio_version, audio_ready, audio_voice")
      .eq("id", id)
      .single();

    if (!q || !q.audio_ready) {
      return NextResponse.json({ ready: false });
    }

    const urls = Object.fromEntries(
      SEGMENTS.map((s) => {
        const { data } = (supabase as any).storage
          .from(BUCKET)
          .getPublicUrl(storagePathFor(id, q.audio_version, s));
        return [s, data.publicUrl as string];
      })
    );

    return NextResponse.json({
      ready: true,
      voice: q.audio_voice,
      version: q.audio_version,
      urls,
    });
  } catch (e: any) {
    console.error("[audio] read error:", e);
    return NextResponse.json({ error: e.message ?? "Failed" }, { status: 500 });
  }
}
