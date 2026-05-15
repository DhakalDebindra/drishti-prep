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

    if (!q) return NextResponse.json({ ready: false });

    // List what actually exists in storage at this version. This is the
    // source of truth for which segments can play; `audio_ready` on the row
    // is a derived flag that may lag after partial regenerations.
    const prefix = `q/${id}/v${q.audio_version}`;
    const { data: files } = await (supabase as any).storage
      .from(BUCKET)
      .list(prefix);
    const fileList: Array<{ name: string; updated_at?: string }> = files ?? [];
    const present = new Set<string>(fileList.map((f) => f.name));
    const updatedByName = new Map<string, string>(
      fileList.map((f) => [f.name, f.updated_at ?? ""])
    );
    const segments_present = SEGMENTS.filter((s) => present.has(`${s}.mp3`));

    if (segments_present.length === 0) {
      return NextResponse.json({ ready: false });
    }

    // Storage objects are uploaded with an immutable cache-control header for
    // CDN efficiency, so when a single segment is regenerated the URL alone
    // can't tell the browser/CDN to refetch. Append the file's updated_at as
    // a cache-busting querystring; same content → same buster → still cached.
    const urls = Object.fromEntries(
      SEGMENTS.map((s) => {
        const { data } = (supabase as any).storage
          .from(BUCKET)
          .getPublicUrl(storagePathFor(id, q.audio_version, s));
        const updated = updatedByName.get(`${s}.mp3`);
        const buster = updated ? `?t=${Date.parse(updated) || encodeURIComponent(updated)}` : "";
        return [s, `${data.publicUrl as string}${buster}`];
      })
    );

    return NextResponse.json({
      ready: segments_present.length === SEGMENTS.length,
      voice: q.audio_voice,
      version: q.audio_version,
      urls,
      segments_present,
    });
  } catch (e: any) {
    console.error("[audio] read error:", e);
    return NextResponse.json({ error: e.message ?? "Failed" }, { status: 500 });
  }
}
