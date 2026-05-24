# Shruti Dictation

Hands-free Braille practice with paced audio for visually impaired learners.

## Architecture

```
src/features/shruti/
├── types.ts                 # DictationDocument, Sentence, PreprocessingMeta
├── normalizeText.ts         # NFC, whitespace, language detection, content hash
├── chunkDocument.ts         # paragraph/sentence/word chunker + validation gate
├── createDictationSession.ts# pure FSM (IDLE → PLAYING → WAITING_FOR_USER → PAUSED)
├── hardenedTts.ts           # SpeechSynthesis watchdog + cloud audio playback
├── voiceCapture.ts          # browser SpeechRecognition wrapper for voice commands
├── audioCache.ts            # 3-tier audio cache (hot LRU + IndexedDB + server LRU)
├── audioSegmenter.ts        # (orphaned) silence-based slicing — kept for future use
├── sourceExtractors.ts      # PDF (pdfjs) + image (Gemini Vision) → editable text
├── punctuation.ts           # spoken-name map for ", . ? ; etc.
├── useDictationRuntime.ts   # React hook gluing FSM → TTS → mic → keyboard
├── log.ts                   # debug log shim (dev-only by default)
└── __tests__/shruti.test.ts # 33 unit tests, runnable via `npx tsx --test`

src/app/(app)/shruti/
├── page.tsx                 # main UI
└── error.tsx                # route-scoped error boundary

src/app/api/shruti/
├── tts/route.ts             # Microsoft Edge TTS for Devanagari sentences
├── ocr/route.ts             # Gemini Vision OCR for image uploads
└── transcribe-command/      # (legacy) Gemini audio classifier — superseded by browser
```

## Runtime data flow

1. **Source** — user pastes text, uploads PDF (client-side pdfjs), or uploads
   images (server OCR via Gemini Vision). All paths fill a single editable
   textarea.
2. **Prepare** — `chunkDocument(text)` produces a `DictationDocument`
   (paragraphs → sentences → words + trailing-punctuation + spokenText).
   For Devanagari content, every sentence is pre-synthesized via Edge TTS
   in the background (with cancellation on settings change).
3. **Playback** — `createDictationSession(doc)` is a pure FSM driven by the
   `useDictationRuntime` hook. SPEAK events are routed to:
   - **English**: browser `SpeechSynthesis` with best installed voice
   - **Devanagari**: local Nepali Neural voice if installed, else Edge TTS
     MP3 streamed via `HTMLAudioElement` from a 3-tier cache
4. **Control** — manual buttons, keyboard shortcuts, or voice commands
   (browser `SpeechRecognition` with multi-alternative matching).

## Environment variables

| Variable | Required? | Used for |
|---|---|---|
| `GEMINI_API_KEY` (or `DRISHTI_API_KEY` / `DrishtiApiKey`) | **Yes for image OCR** | Gemini Vision OCR of uploaded images. Without it, the image upload tab returns errors but PDFs and pasted text still work. |
| `NEXT_PUBLIC_SUPABASE_URL` + `NEXT_PUBLIC_SUPABASE_ANON_KEY` | **Yes** | Auth (route is gated by Supabase auth) and future resume-points. |
| `UPSTASH_REDIS_REST_URL` + `UPSTASH_REDIS_REST_TOKEN` | **Yes** | Rate-limit for `/api/shruti/ocr` and `/api/shruti/transcribe-command`. |

**No API keys are needed for the Nepali TTS** — Microsoft Edge TTS is used via
the unofficial endpoint that powers Edge browser's "Read aloud". Free, no key,
no quota observed in production.

## Caching tiers (Nepali audio)

| Tier | Where | Bound | Purpose |
|---|---|---|---|
| Hot LRU | In-memory `Map<key, Blob>` | 24 entries | Skip disk round-trip for current ± neighbors |
| IndexedDB | Browser `audio` object store | Browser-managed (~100MB+) | Persistent across sessions |
| Server LRU | Next.js process memory | 200 × 24h TTL | Shared across users for library content |

Same chunk → 1 Edge TTS call ever. Long Loksewa essays serve from cache after
first pass; memory stays bounded regardless of session length.

## Tests

```bash
npx tsx --test apps/web/src/features/shruti/__tests__/shruti.test.ts
```

33 unit tests covering: chunking, abbreviation handling, FSM transitions,
mode switching, punctuation announcement, paragraph-start detection,
navigation intents, spoken-text expansion.

## Browser support

- **Chrome / Edge**: full support (recommended)
- **Firefox**: TTS works; voice commands not supported (no `SpeechRecognition`)
- **Safari**: TTS works with Apple voices; voice commands work
- **Mobile**: works in Chrome on Android; iOS Safari has TTS quirks

## Deployment notes

- The `pdfjs-dist` worker is shipped from `public/pdf.worker.min.mjs` —
  make sure your deploy includes the `public/` folder (Vercel does by default).
- The Edge TTS path uses WebSockets server-side. Edge/Vercel serverless
  functions support this in Node runtime (already set: `export const runtime = "nodejs"`).
- Static caching of TTS MP3s is private-only (per user) — no shared CDN cache,
  to avoid leaking content across users.

## Debug logging

By default, Shruti only logs warnings and errors. To enable verbose tracing
in the browser console:

```js
localStorage.SHRUTI_DEBUG = "1";
// then reload
```

Or run in `NODE_ENV=development` (auto-enabled).
