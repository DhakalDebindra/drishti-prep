import { NextResponse } from "next/server";
import { createClient } from "@/lib/supabase/server";
import { synthesizeWithEdge, DEFAULT_EDGE_VOICE } from "@/lib/edge-tts-service";

// Server-side Nepali TTS for Shruti. Single engine: Microsoft Edge TTS.
//   - Neural voices (Hemkala / Sagar)
//   - Free, no API key
//   - No observed quota in production
//
// On the rare occasion Edge fails, the CLIENT falls back to browser-
// native SpeechSynthesis with whatever Nepali voice the OS has (or just
// any voice attempting to read Devanagari). Gemini is no longer in this
// chain at all.
//
// Cost strategy unchanged:
//   1. Client-side IndexedDB cache means the same chunk only hits this
//      route once per user.
//   2. THIS in-memory LRU shares synthesized audio ACROSS users — when
//      library content is dictated by ten different students, we only
//      synthesize once for the whole platform.
//   3. In-flight dedup: concurrent identical requests share one call.

export const runtime = "nodejs";

const LRU_MAX_ENTRIES = 200;
const LRU_TTL_MS = 24 * 60 * 60 * 1000; // 24 hours

interface CachedClip {
  bytes: Uint8Array;
  metadataBase64?: string;
  createdAt: number;
}

const clipCache = new Map<string, CachedClip>();
const inflight = new Map<string, Promise<{bytes: Uint8Array, metadataBase64?: string} | null>>();

function cacheKey(text: string, voice: string): string {
  return `${voice}:${text}`;
}

function getFromLru(key: string): CachedClip | null {
  const entry = clipCache.get(key);
  if (!entry) return null;
  if (Date.now() - entry.createdAt > LRU_TTL_MS) {
    clipCache.delete(key);
    return null;
  }
  // LRU touch: re-insert to move to the end of insertion order.
  clipCache.delete(key);
  clipCache.set(key, entry);
  return entry;
}

function putInLru(key: string, bytes: Uint8Array, metadataBase64?: string): void {
  if (clipCache.size >= LRU_MAX_ENTRIES) {
    // Evict the oldest entry (Maps preserve insertion order in JS).
    const firstKey = clipCache.keys().next().value;
    if (firstKey) clipCache.delete(firstKey);
  }
  clipCache.set(key, { bytes, metadataBase64, createdAt: Date.now() });
}

export async function POST(req: Request) {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    return NextResponse.json({ error: "unauthenticated" }, { status: 401 });
  }

  let body: { text?: string; voice?: string; wordGapMs?: number } = {};
  try {
    body = await req.json();
  } catch {
    return NextResponse.json({ error: "invalid_json" }, { status: 400 });
  }

  const text = (body.text ?? "").trim();
  if (!text) {
    return NextResponse.json({ error: "missing_text" }, { status: 400 });
  }
  if (text.length > 2000) {
    return NextResponse.json({ error: "text_too_long" }, { status: 400 });
  }

  const ALLOWED_VOICES = new Set<string>([
    "ne-NP-HemkalaNeural",
    "ne-NP-SagarNeural",
  ]);
  const voice = body.voice && ALLOWED_VOICES.has(body.voice)
    ? (body.voice as typeof DEFAULT_EDGE_VOICE)
    : DEFAULT_EDGE_VOICE;

  // Clamp wordGapMs so a bad client value can't waste synthesis time
  // (very long gaps produce huge audio files).
  const wordGapMs = Math.max(0, Math.min(Number(body.wordGapMs ?? 0) || 0, 3000));

  // Cache key includes gap so different paces don't collide.
  const key = cacheKey(`${text}|gap=${wordGapMs}`, voice);

  // LRU hit — no Edge TTS call, no charge.
  const cached = getFromLru(key);
  if (cached) {
    const ab = new ArrayBuffer(cached.bytes.byteLength);
    new Uint8Array(ab).set(cached.bytes);
    const headers: Record<string, string> = {
      "Content-Type": "audio/mpeg",
      "Cache-Control": "private, max-age=86400",
      "X-Shruti-Cache": "lru-hit",
    };
    if (cached.metadataBase64) headers["X-Word-Boundaries"] = cached.metadataBase64;
    return new Response(ab, { status: 200, headers });
  }

  // In-flight coalescing — two concurrent identical requests share one call.
  let pending = inflight.get(key);
  if (!pending) {
    pending = (async () => {
      try {
        const result = await synthesizeWithEdge(text, voice, { wordGapMs });
        const bytes = new Uint8Array(result.mp3.byteLength);
        bytes.set(result.mp3);
        const metadataBase64 = result.wordBoundaries?.length 
          ? Buffer.from(JSON.stringify(result.wordBoundaries)).toString('base64') 
          : undefined;
        putInLru(key, bytes, metadataBase64);
        console.log(`[Shruti] tts ok via edge (${result.latencyMs}ms, ${bytes.length}B)`);
        return { bytes, metadataBase64 };
      } catch (edgeErr) {
        const msg = edgeErr instanceof Error ? edgeErr.message : String(edgeErr);
        console.error("[Shruti] edge tts failed:", msg);
        return null;
      } finally {
        inflight.delete(key);
      }
    })();
    inflight.set(key, pending);
  }

  let result: { bytes: Uint8Array, metadataBase64?: string } | null;
  try {
    result = await pending;
  } catch (err) {
    const msg = err instanceof Error ? err.message : String(err);
    if (msg.startsWith("QUOTA:")) {
      // Try to surface the retry window so the UI can tell the user.
      const retryMatch = msg.match(/retry in ([0-9hms\\.]+)/i);
      const dailyMatch = /per_day|requests_per_model_per_day/i.test(msg);
      return NextResponse.json(
        {
          error: "quota_exceeded",
          scope: dailyMatch ? "daily" : "burst",
          retryAfter: retryMatch?.[1] ?? null,
          detail: msg.replace(/^QUOTA:/, ""),
        },
        { status: 429 },
      );
    }
    return NextResponse.json({ error: "tts_failed", detail: msg }, { status: 502 });
  }
  if (!result) {
    return NextResponse.json({ error: "tts_failed" }, { status: 502 });
  }
  const ab = new ArrayBuffer(result.bytes.byteLength);
  new Uint8Array(ab).set(result.bytes);
  const headers: Record<string, string> = {
    "Content-Type": "audio/mpeg",
    "Cache-Control": "private, max-age=86400",
    "X-Shruti-Cache": "miss",
  };
  if (result.metadataBase64) headers["X-Word-Boundaries"] = result.metadataBase64;
  return new Response(ab, { status: 200, headers });
}
