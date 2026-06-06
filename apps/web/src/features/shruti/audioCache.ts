// IndexedDB-backed cache for Shruti's Nepali TTS audio.
//
// Why IndexedDB and not localStorage?
//   - localStorage is sync, string-only, and capped at ~5MB. A typical
//     Nepali sentence MP3 is 15–40KB; 100 sentences would saturate it.
//   - IndexedDB is async, holds binary blobs, and gives us 100MB+ on most
//     browsers. Survives across sessions until the user clears site data.
//
// Schema: one object store "audio", key = sha-256 hex of "voice:lang:text",
// value = { blob, createdAt, sizeBytes }.
//
// All methods degrade gracefully — if IndexedDB is unavailable (Safari
// private mode, etc.) we just return null / no-op and the caller falls
// back to fetching from the server.

const DB_NAME = "shruti-audio";
const STORE_NAME = "audio";
const DB_VERSION = 1;

export interface WordBoundary {
  text: string;
  startMs: number;
  endMs: number;
}

export interface AudioCacheResult {
  blob: Blob;
  wordBoundaries?: WordBoundary[];
}

interface CacheEntry {
  blob: Blob;
  createdAt: number;
  sizeBytes: number;
  wordBoundaries?: WordBoundary[];
}

let dbPromise: Promise<IDBDatabase | null> | null = null;

function openDb(): Promise<IDBDatabase | null> {
  if (typeof indexedDB === "undefined") return Promise.resolve(null);
  if (dbPromise) return dbPromise;
  dbPromise = new Promise((resolve) => {
    const req = indexedDB.open(DB_NAME, DB_VERSION);
    req.onupgradeneeded = () => {
      const db = req.result;
      if (!db.objectStoreNames.contains(STORE_NAME)) {
        db.createObjectStore(STORE_NAME);
      }
    };
    req.onsuccess = () => resolve(req.result);
    req.onerror = () => resolve(null);
    req.onblocked = () => resolve(null);
  });
  return dbPromise;
}

async function sha256Hex(text: string): Promise<string> {
  // Use Web Crypto when available (all modern browsers). Falls back to a
  // simple non-crypto hash if not — we don't need collision-resistance for
  // a per-user cache.
  if (typeof crypto !== "undefined" && crypto.subtle) {
    const enc = new TextEncoder().encode(text);
    const buf = await crypto.subtle.digest("SHA-256", enc);
    return Array.from(new Uint8Array(buf))
      .map((b) => b.toString(16).padStart(2, "0"))
      .join("");
  }
  // Tiny fallback (FNV-1a 32-bit). Good enough for cache keys.
  let h = 0x811c9dc5;
  for (let i = 0; i < text.length; i++) {
    h ^= text.charCodeAt(i);
    h = Math.imul(h, 0x01000193);
  }
  return (h >>> 0).toString(16);
}

export async function buildCacheKey(text: string, voice: string, lang: string): Promise<string> {
  return sha256Hex(`${voice}:${lang}:${text}`);
}

export async function getCachedAudio(key: string): Promise<AudioCacheResult | null> {
  const db = await openDb();
  if (!db) return null;
  return new Promise((resolve) => {
    try {
      const tx = db.transaction(STORE_NAME, "readonly");
      const store = tx.objectStore(STORE_NAME);
      const req = store.get(key);
      req.onsuccess = () => {
        const entry = req.result as CacheEntry | undefined;
        resolve(entry ? { blob: entry.blob, wordBoundaries: entry.wordBoundaries } : null);
      };
      req.onerror = () => resolve(null);
    } catch {
      resolve(null);
    }
  });
}

export async function putCachedAudio(key: string, result: AudioCacheResult): Promise<void> {
  const db = await openDb();
  if (!db) return;
  return new Promise((resolve) => {
    try {
      const tx = db.transaction(STORE_NAME, "readwrite");
      const store = tx.objectStore(STORE_NAME);
      const entry: CacheEntry = {
        blob: result.blob,
        createdAt: Date.now(),
        sizeBytes: result.blob.size,
        wordBoundaries: result.wordBoundaries,
      };
      const req = store.put(entry, key);
      req.onsuccess = () => resolve();
      req.onerror = () => resolve();
    } catch {
      resolve();
    }
  });
}

// -------------------------------------------------------------------------
// In-flight dedup: ensures two callers requesting the same audio at the
// same time only trigger one network fetch.
// -------------------------------------------------------------------------

const inflight = new Map<string, Promise<AudioCacheResult | null>>();

/**
 * In-memory rolling window of recently-played Blobs. IndexedDB is the
 * durable store; this LRU is just to skip the disk round-trip during a
 * playback burst (current sentence + prev/next neighbors). Bounded so a
 * 500-sentence session can't blow up RAM even if every sentence is hit.
 */
const HOT_LRU_MAX = 24;
const hotLru = new Map<string, AudioCacheResult>();

function hotLruGet(key: string): AudioCacheResult | null {
  const v = hotLru.get(key);
  if (!v) return null;
  // Re-insert to mark as most recently used.
  hotLru.delete(key);
  hotLru.set(key, v);
  return v;
}

function hotLruPut(key: string, result: AudioCacheResult): void {
  if (hotLru.has(key)) hotLru.delete(key);
  hotLru.set(key, result);
  while (hotLru.size > HOT_LRU_MAX) {
    const oldest = hotLru.keys().next().value;
    if (oldest === undefined) break;
    hotLru.delete(oldest);
  }
}

/**
 * Fetch (or read from cache) the audio for `text`. Three caching tiers:
 *   1. In-memory rolling LRU (24 most recent) — instant, no disk hit
 *   2. IndexedDB blob store — persistent across sessions
 *   3. Network → /api/shruti/tts → Edge TTS
 *
 * Concurrent identical requests coalesce into one fetch.
 *
 * Pass `signal` to cancel an in-flight network call (saves server/network resources
 * if the user edits the source mid-pre-synthesis or switches documents).
 * Cache reads are not cancellable — they're already instant.
 */
export async function fetchOrCacheAudio(opts: {
  text: string;
  voice?: string;
  lang?: string;
  endpoint?: string;
  signal?: AbortSignal;
  /** Silence inserted between words via SSML <break>. 0 = no gap. */
  wordGapMs?: number;
}): Promise<AudioCacheResult | null> {
  const voice = opts.voice ?? "Kore";
  const lang = opts.lang ?? "ne-NP";
  const endpoint = opts.endpoint ?? "/api/shruti/tts";
  const wordGapMs = opts.wordGapMs ?? 0;
  // Include gap in cache key so different paces map to different MP3s.
  const key = await buildCacheKey(`${opts.text}|gap=${wordGapMs}`, voice, lang);

  if (opts.signal?.aborted) return null;

  // Tier 1: hot LRU.
  const hot = hotLruGet(key);
  if (hot) return hot;

  // Tier 2: IndexedDB.
  const cached = await getCachedAudio(key);
  if (cached) {
    hotLruPut(key, cached);
    return cached;
  }

  if (opts.signal?.aborted) return null;

  // Tier 3: network. Coalesce duplicates so two callers don't double-pay,
  // but ALSO honour the most-recent signal — if any caller has aborted,
  // we still let the underlying fetch race to completion for the OTHER
  // pending callers, then resolve them. If the fetch itself has been
  // aborted, all callers get null.
  const existing = inflight.get(key);
  if (existing) {
    if (!opts.signal) return existing;
    // Race the shared fetch against this caller's abort.
    return Promise.race<AudioCacheResult | null>([
      existing,
      new Promise<AudioCacheResult | null>((resolve) => {
        opts.signal!.addEventListener("abort", () => resolve(null), { once: true });
      }),
    ]);
  }

  const fetchAbort = new AbortController();
  // If the FIRST caller cancels, cancel the actual network request.
  // (Second-and-later callers passing different signals don't tear down
  // the shared fetch — that'd be unfair to the original caller.)
  if (opts.signal) {
    if (opts.signal.aborted) fetchAbort.abort();
    else opts.signal.addEventListener("abort", () => fetchAbort.abort(), { once: true });
  }

  const p = (async (): Promise<AudioCacheResult | null> => {
    try {
      const res = await fetch(endpoint, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          text: opts.text,
          voice: opts.voice ?? undefined,
          wordGapMs: wordGapMs > 0 ? wordGapMs : undefined,
        }),
        signal: fetchAbort.signal,
      });
      if (!res.ok) {
        // Quota errors return JSON, not audio — bubble them up so the UI
        // can show a specific message ("daily quota used", retry-after).
        if (res.status === 429) {
          try {
            const errBody = await res.json();
            const err = new Error(
              JSON.stringify({ kind: "quota", ...(errBody as object) }),
            );
            throw err;
          } catch (e) {
            if (e instanceof Error && e.message.startsWith("{")) throw e;
            // Body wasn't JSON; fall through.
          }
        }
        return null;
      }
      const blob = await res.blob();
      let wordBoundaries: WordBoundary[] | undefined;
      const metaBase64 = res.headers.get("X-Word-Boundaries");
      if (metaBase64) {
        try {
          const binString = atob(metaBase64);
          const bytes = new Uint8Array(binString.length);
          for (let i = 0; i < binString.length; i++) {
            bytes[i] = binString.charCodeAt(i);
          }
          const decodedStr = new TextDecoder().decode(bytes);
          wordBoundaries = JSON.parse(decodedStr);
        } catch (err) {
          console.warn("[Shruti] Failed to parse word boundaries from cache", err);
        }
      }
      const result = { blob, wordBoundaries };
      hotLruPut(key, result);
      void putCachedAudio(key, result);
      return result;
    } catch (err) {
      if (err instanceof Error && err.message.startsWith("{")) throw err;
      // AbortError and ordinary network errors → null (silent).
      return null;
    } finally {
      inflight.delete(key);
    }
  })();

  inflight.set(key, p);
  return p;
}

/**
 * Pre-warm the cache by triggering background fetches for chunks the user
 * is likely to hear soon. Fire-and-forget; in-flight dedup ensures we
 * never double-fetch.
 */
export function prewarmAudio(opts: {
  texts: string[];
  voice?: string;
  lang?: string;
  wordGapMs?: number;
}): void {
  for (const text of opts.texts) {
    if (!text.trim()) continue;
    void fetchOrCacheAudio({
      text,
      voice: opts.voice,
      lang: opts.lang,
      wordGapMs: opts.wordGapMs,
    });
  }
}

/**
 * Pre-synthesize the ENTIRE list of sentences with a concurrency limit
 * and progress callback. Used at Prepare time so by the time the user
 * clicks Start, every sentence is cached locally — no network during
 * actual dictation. This is what makes Nepali playback feel like a live
 * conversation rather than streaming.
 *
 * Returns a promise that resolves when all syntheses are done (cached
 * or freshly fetched). Errors on individual sentences don't reject the
 * whole batch — they just stay un-cached and fall back to live fetch
 * during playback.
 */
export interface QuotaError {
  kind: "quota";
  scope?: "daily" | "burst";
  retryAfter?: string | null;
  detail?: string;
}

export async function presynthesizeAll(
  texts: string[],
  opts: {
    /**
     * Concurrent calls. Default 1 to avoid rate limits. Bumping this risks
     * 429s on back-to-back pre-synth runs.
     */
    concurrency?: number;
    voice?: string;
    lang?: string;
    wordGapMs?: number;
    onProgress?: (done: number, total: number) => void;
    /** Called once if synthesis was halted by a quota error. */
    onQuotaError?: (err: QuotaError) => void;
    signal?: AbortSignal;
  } = {},
): Promise<void> {
  const concurrency = opts.concurrency ?? 1;
  const total = texts.length;
  let done = 0;
  let cursor = 0;
  let quotaHit: QuotaError | null = null;

  const worker = async () => {
    while (cursor < texts.length) {
      if (opts.signal?.aborted) return;
      if (quotaHit) return; // bail entire batch on first quota error
      const myIdx = cursor++;
      const text = texts[myIdx];
      if (text.trim()) {
        try {
          await fetchOrCacheAudio({
            text,
            voice: opts.voice,
            lang: opts.lang,
            wordGapMs: opts.wordGapMs,
            signal: opts.signal,
          });
        } catch (err) {
          // Quota errors are JSON-encoded; everything else stays silent.
          if (err instanceof Error && err.message.startsWith("{")) {
            try {
              const parsed = JSON.parse(err.message) as QuotaError;
              quotaHit = parsed;
            } catch { /* not parseable */ }
          }
        }
      }
      done++;
      opts.onProgress?.(done, total);
    }
  };

  const workers: Promise<void>[] = [];
  for (let i = 0; i < Math.min(concurrency, total); i++) {
    workers.push(worker());
  }
  await Promise.all(workers);
  if (quotaHit) opts.onQuotaError?.(quotaHit);
}

// Analyzed-sentence cache has been removed. Earlier versions decoded each
// sentence into an AudioBuffer (~500KB of PCM per 5-second sentence) and
// held the lot in memory for client-side slicing. We now stream the
// underlying MP3 Blob directly via HTMLAudioElement (~80KB resident), and
// the heavy AudioBuffer path is gone. IndexedDB still holds the blobs
// across sessions, but in-memory footprint stays flat regardless of
// session length.
