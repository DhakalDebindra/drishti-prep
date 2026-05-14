import { NextResponse } from "next/server";
import { createClient } from "@/lib/supabase/server";
import { aiRatelimit } from "@/lib/rate-limit";
import {
  SEGMENTS,
  scriptFor,
  storagePathFor,
  synthesizeNepali,
  tokensToMicroUsd,
  voiceFor,
  type TutorVoice,
} from "@/lib/tts-service";

export const runtime = "nodejs";
export const maxDuration = 300; // 5 min — generating 6 segments takes ~90s

const BUCKET = "question-audio";
const MODEL = "gemini-2.5-pro-preview-tts";

type Ctx = { params: Promise<{ id: string }> };

export async function POST(req: Request, ctx: Ctx) {
  try {
    const { id } = await ctx.params;
    if (!id || !/^[0-9a-f-]{36}$/i.test(id)) {
      return NextResponse.json({ error: "Invalid question id" }, { status: 400 });
    }

    const ip =
      req.headers.get("x-forwarded-for")?.split(",")[0].trim() ??
      req.headers.get("x-real-ip") ??
      "anonymous";
    const { success } = await aiRatelimit.limit(`audio-gen:${ip}`);
    if (!success) {
      return NextResponse.json(
        { error: "Too many requests. Please wait before trying again." },
        { status: 429, headers: { "Retry-After": "60" } }
      );
    }

    const supabase = await createClient();
    const {
      data: { user },
    } = await supabase.auth.getUser();
    if (!user) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });

    const { data: profile } = await supabase
      .from("profiles")
      .select("is_admin")
      .eq("id", user.id)
      .single();
    if (!profile?.is_admin) {
      return NextResponse.json({ error: "Forbidden" }, { status: 403 });
    }

    const { data: q, error: qErr } = await (supabase as any)
      .from("questions")
      .select(
        "id, content, option_a, option_b, option_c, option_d, explanation, correct_option, audio_version, audio_ready, audio_voice"
      )
      .eq("id", id)
      .single();
    if (qErr || !q) {
      return NextResponse.json({ error: "Question not found" }, { status: 404 });
    }

    const voice: TutorVoice = (q.audio_voice as TutorVoice | null) ?? voiceFor(id);
    const version = q.audio_version as number;

    // Find which segments already exist at the current version.
    const prefix = `q/${id}/v${version}`;
    const { data: existing } = await (supabase as any).storage.from(BUCKET).list(prefix);
    const existingNames = new Set<string>((existing ?? []).map((f: any) => f.name));

    const generated: Array<{
      segment: string;
      bytes: number;
      durationMs: number;
      latencyMs: number;
      tokens: number;
    }> = [];

    for (const segment of SEGMENTS) {
      const filename = `${segment}.mp3`;
      if (existingNames.has(filename)) continue;

      const text = scriptFor(segment, q);
      const { mp3, durationMs, latencyMs, approxTokens } = await synthesizeNepali(text, voice);

      const path = storagePathFor(id, version, segment);
      const { error: upErr } = await (supabase as any).storage
        .from(BUCKET)
        .upload(path, mp3, {
          contentType: "audio/mpeg",
          upsert: true,
          cacheControl: "public, max-age=31536000, immutable",
        });
      if (upErr) {
        console.error(`[audio] Upload failed for ${path}:`, upErr);
        return NextResponse.json(
          { error: `Upload failed for segment ${segment}` },
          { status: 500 }
        );
      }

      generated.push({
        segment,
        bytes: mp3.length,
        durationMs,
        latencyMs,
        tokens: approxTokens,
      });
    }

    if (generated.length > 0) {
      const logRows = generated.map((g) => ({
        question_id: id,
        audio_version: version,
        segment: g.segment,
        voice,
        model: MODEL,
        bytes: g.bytes,
        duration_ms: g.durationMs,
        latency_ms: g.latencyMs,
        cost_micro_usd: tokensToMicroUsd(g.tokens),
        requested_by: user.id,
      }));
      const { error: logErr } = await (supabase as any)
        .from("audio_generation_log")
        .insert(logRows);
      if (logErr) console.error("[audio] Log insert failed (non-fatal):", logErr);
    }

    const { error: updErr } = await (supabase as any)
      .from("questions")
      .update({ audio_ready: true, audio_voice: voice })
      .eq("id", id);
    if (updErr) {
      console.error("[audio] Failed to mark audio_ready:", updErr);
      return NextResponse.json({ error: "Failed to finalize" }, { status: 500 });
    }

    const urls = Object.fromEntries(
      SEGMENTS.map((s) => {
        const { data } = (supabase as any).storage
          .from(BUCKET)
          .getPublicUrl(storagePathFor(id, version, s));
        return [s, data.publicUrl as string];
      })
    );

    return NextResponse.json({
      ready: true,
      voice,
      version,
      urls,
      generated_count: generated.length,
      skipped_count: SEGMENTS.length - generated.length,
    });
  } catch (e: any) {
    console.error("[audio] generation error:", e);
    return NextResponse.json({ error: e.message ?? "Generation failed" }, { status: 500 });
  }
}
