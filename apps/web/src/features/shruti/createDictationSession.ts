// createDictationSession: pure state machine for Shruti Dictation.
// No TTS. No voice. No DOM. Manual transitions only.
// The runtime (HardenedTTS + Web Speech) drives this via the same intents
// the keyboard and on-screen buttons drive.

import { DictationDocument, Sentence } from "./types";
import { punctuationToSpoken, speakableWord } from "./punctuation";

export type PlaybackStatus = "IDLE" | "PLAYING" | "PAUSED" | "WAITING_FOR_USER";

export type PacePreset = "slow" | "medium" | "fast" | "sprint" | "custom";

export type DictationMode = "sentence" | "word" | "phrase";

export interface PaceConfig {
  preset: PacePreset;
  wpm: number;             // effective words per minute
  interSentencePauseMs: number;
  interWordPauseMs: number;
  /**
   * Silence INSIDE the audio between each spoken word. Implemented via
   * SSML <break> tags sent to Edge TTS. Used in sentence/phrase mode so
   * even when Hemkala reads a whole sentence, she pauses between words
   * the way a careful human assistant would. Pronunciation rate stays
   * natural; only the gap changes.
   */
  intraSentenceWordGapMs: number;
}

// Pace presets are designed to feel like distinct reader personas, not
// just numeric tweaks. A Braille writer should immediately notice the
// difference between Slow and Sprint.
//
// `wpm` drives the audio playback rate (preservesPitch=true keeps the
// voice natural — no chipmunk effect). The inter-chunk pauses dominate
// in auto-advance mode and ARE the writing window.
//
// Rough mapping at the audio level (160 wpm = natural human reading):
//   Slow   ≈ 0.85× — careful, patient assistant
//   Medium ≈ 1.0×  — natural conversational pace
//   Fast   ≈ 1.15× — brisk
//   Sprint ≈ 1.3×  — speed drill
export const PACE_PRESETS: Record<Exclude<PacePreset, "custom">, PaceConfig> = {
  slow: {
    preset: "slow", wpm: 160,
    interSentencePauseMs: 9000,
    interWordPauseMs: 2500,
    intraSentenceWordGapMs: 800,  // big breath between words inside a sentence
  },
  medium: {
    preset: "medium", wpm: 160,
    interSentencePauseMs: 5500,
    interWordPauseMs: 1500,
    intraSentenceWordGapMs: 450,  // careful but flowing
  },
  fast: {
    preset: "fast", wpm: 160,
    interSentencePauseMs: 2500,
    interWordPauseMs: 800,
    intraSentenceWordGapMs: 200,  // light pause
  },
  sprint: {
    preset: "sprint", wpm: 160,
    interSentencePauseMs: 1200,
    interWordPauseMs: 400,
    intraSentenceWordGapMs: 80,   // nearly continuous
  },
};

// In phrase mode, group this many words per chunk. Three is the sweet
// spot for Braille writers: short enough to hold in working memory while
// punching the cells, long enough to carry meaning. Two was too choppy
// in user testing, four was too much to retain.
const PHRASE_WORD_COUNT = 3;

export type Intent =
  | { type: "START" }
  | { type: "NEXT" }
  | { type: "REPEAT" }
  | { type: "BACK" }
  | { type: "PAUSE" }
  | { type: "RESUME" }
  | { type: "SPELL" }
  | { type: "WHERE" }
  // Structural navigation — power-user jumps that ignore word cursor.
  | { type: "NEXT_SENTENCE" }
  | { type: "PREV_SENTENCE" }
  | { type: "NEXT_PARAGRAPH" }
  | { type: "PREV_PARAGRAPH" }
  | { type: "GO_TO_START" }
  | { type: "GO_TO_END" }
  | { type: "CHUNK_FINISHED" }
  | { type: "SET_PACE"; pace: PaceConfig }
  | { type: "SET_MODE"; mode: DictationMode }
  | { type: "SET_ANNOUNCE_PUNCT"; on: boolean };

export interface SessionState {
  documentId: string;
  globalSentenceIndex: number;
  wordIndex: number;                        // word cursor within current sentence
  mode: DictationMode;
  status: PlaybackStatus;
  pace: PaceConfig;
  announcePunctuation: boolean;             // verbal "comma", "full stop", etc.
  lastCommand?: { intent: Intent["type"]; at: number };
}

export interface DictationSession {
  getState(): SessionState;
  currentSentence(): Sentence | null;
  currentWord(): string | null;
  currentChunkText(): string | null;
  currentSpeakableText(): string | null;
  dispatch(intent: Intent, now?: number): SessionEvent[];
  positionAnnouncement(): string;
}

export type SessionEvent =
  | {
      type: "SPEAK";
      text: string;
      isSentenceEnd: boolean;
      isParagraphStart: boolean;
      isDevanagari: boolean;
    }
  | { type: "SPELL"; words: string[] }       // one or more words to spell in sequence
  | { type: "ANNOUNCE"; text: string }       // ARIA-live status text
  | { type: "STOP_TTS" }
  | { type: "PERSIST"; state: SessionState }
  | { type: "IGNORED"; reason: string };

const COMMAND_COOLDOWN_MS = 750;

export interface CreateOptions {
  doc: DictationDocument;
  initialSentenceIndex?: number;
  initialWordIndex?: number;
  pace?: PaceConfig;
  mode?: DictationMode;
  announcePunctuation?: boolean;
}

export function createDictationSession(opts: CreateOptions): DictationSession {
  const sentences: Sentence[] = opts.doc.chunks.paragraphs.flatMap((p) => p.sentences);
  const totalSentences = sentences.length;

  const state: SessionState = {
    documentId: opts.doc.metadata.id,
    globalSentenceIndex: clamp(opts.initialSentenceIndex ?? 0, 0, Math.max(0, totalSentences - 1)),
    wordIndex: opts.initialWordIndex ?? 0,
    mode: opts.mode ?? "sentence",
    status: "IDLE",
    pace: opts.pace ?? PACE_PRESETS.medium,
    announcePunctuation: opts.announcePunctuation ?? true,
  };

  function currentSentence(): Sentence | null {
    if (totalSentences === 0) return null;
    return sentences[state.globalSentenceIndex] ?? null;
  }

  function currentWord(): string | null {
    const s = currentSentence();
    if (!s) return null;
    return s.words[state.wordIndex] ?? null;
  }

  function currentChunkText(): string | null {
    const s = currentSentence();
    if (!s) return null;
    if (state.mode === "sentence") return s.text;
    if (state.mode === "word") return s.words[state.wordIndex] ?? null;
    const start = state.wordIndex;
    const end = Math.min(start + PHRASE_WORD_COUNT, s.words.length);
    return s.words.slice(start, end).join(" ");
  }

  /**
   * Build the string that should actually be spoken for the current chunk,
   * with punctuation announcements inserted when enabled. This is what we
   * send to TTS — the visible `currentChunkText()` stays clean.
   */
  function currentSpeakableText(): string | null {
    const s = currentSentence();
    if (!s) return null;
    const announce = state.announcePunctuation;

    if (state.mode === "word") {
      const w = s.words[state.wordIndex];
      if (!w) return null;
      const trail = s.trailingPunct[state.wordIndex] ?? "";
      return announce ? speakableWord(w, trail) : w;
    }

    if (state.mode === "phrase") {
      const start = state.wordIndex;
      const end = Math.min(start + PHRASE_WORD_COUNT, s.words.length);
      const parts: string[] = [];
      for (let i = start; i < end; i++) {
        const w = s.words[i];
        if (!w) continue;
        const trail = s.trailingPunct[i] ?? "";
        parts.push(announce ? speakableWord(w, trail) : w);
      }
      return parts.join(" ");
    }

    // sentence mode — use the pre-expanded `spokenText` so abbreviations
    // and B.S./A.D. dates get spoken in their full form.
    if (!announce) return s.spokenText;
    // Rebuild from words + trailingPunct so we can intersperse spoken
    // punctuation names. Note we still apply expansion via spokenText for
    // the words themselves by re-tokenizing the expanded text would be
    // more accurate, but keeping the original word/punct pairing is good
    // enough for nearly all cases.
    const parts: string[] = [];
    for (let i = 0; i < s.words.length; i++) {
      const w = s.words[i];
      const trail = s.trailingPunct[i] ?? "";
      const spokenPunct = punctuationToSpoken(trail);
      parts.push(spokenPunct ? `${w}${trail} ${spokenPunct}` : w);
    }
    return parts.join(" ");
  }

  function isDevanagariText(t: string): boolean {
    return /\p{Script=Devanagari}/u.test(t);
  }

  function chunksRemainingInSentence(s: Sentence): boolean {
    if (state.mode === "sentence") return false;
    const step = state.mode === "word" ? 1 : PHRASE_WORD_COUNT;
    return state.wordIndex + step < s.words.length;
  }

  function speakCurrent(events: SessionEvent[]) {
    const s = currentSentence();
    if (!s) return;
    const text = currentSpeakableText();
    if (!text) return;
    const isSentenceEnd =
      state.mode === "sentence" ||
      (state.mode === "word" && state.wordIndex >= s.words.length - 1) ||
      (state.mode === "phrase" && state.wordIndex + PHRASE_WORD_COUNT >= s.words.length);
    // Paragraph start = first sentence of a non-first paragraph, AND we're
    // at the first chunk of that sentence (word 0 in word/phrase modes).
    const isParagraphStart =
      s.paragraphIndex > 0 &&
      s.localIndex === 0 &&
      state.wordIndex === 0;
    events.push({
      type: "SPEAK",
      text,
      isSentenceEnd,
      isParagraphStart,
      isDevanagari: isDevanagariText(text),
    });
  }

  function advanceChunk(): "continued" | "next-sentence" | "end" {
    const s = currentSentence();
    if (!s) return "end";
    if (state.mode === "sentence" || !chunksRemainingInSentence(s)) {
      if (state.globalSentenceIndex >= totalSentences - 1) return "end";
      state.globalSentenceIndex += 1;
      state.wordIndex = 0;
      return "next-sentence";
    }
    const step = state.mode === "word" ? 1 : PHRASE_WORD_COUNT;
    state.wordIndex += step;
    return "continued";
  }

  function retreatChunk(): "moved" | "at-start" {
    if (state.wordIndex > 0 && state.mode !== "sentence") {
      const step = state.mode === "word" ? 1 : PHRASE_WORD_COUNT;
      state.wordIndex = Math.max(0, state.wordIndex - step);
      return "moved";
    }
    if (state.globalSentenceIndex === 0) return "at-start";
    state.globalSentenceIndex -= 1;
    const prev = sentences[state.globalSentenceIndex];
    if (state.mode === "sentence" || !prev) {
      state.wordIndex = 0;
    } else if (state.mode === "word") {
      state.wordIndex = Math.max(0, prev.words.length - 1);
    } else {
      // phrase: land on the last phrase boundary
      const lastPhraseStart = Math.max(
        0,
        Math.floor((prev.words.length - 1) / PHRASE_WORD_COUNT) * PHRASE_WORD_COUNT,
      );
      state.wordIndex = lastPhraseStart;
    }
    return "moved";
  }

  function isDuplicate(intent: Intent, now: number): boolean {
    if (!state.lastCommand) return false;
    if (state.lastCommand.intent !== intent.type) return false;
    return now - state.lastCommand.at < COMMAND_COOLDOWN_MS;
  }

  function recordCommand(intent: Intent, now: number) {
    state.lastCommand = { intent: intent.type, at: now };
  }

  function dispatch(intent: Intent, now: number = Date.now()): SessionEvent[] {
    if (
      intent.type !== "CHUNK_FINISHED" &&
      intent.type !== "SET_PACE" &&
      intent.type !== "SET_MODE"
    ) {
      if (isDuplicate(intent, now)) {
        return [{ type: "IGNORED", reason: "cooldown" }];
      }
    }

    const events: SessionEvent[] = [];

    switch (intent.type) {
      case "START": {
        if (totalSentences === 0) {
          events.push({ type: "ANNOUNCE", text: "No content to read." });
          break;
        }
        state.status = "PLAYING";
        speakCurrent(events);
        events.push({ type: "PERSIST", state: { ...state } });
        break;
      }
      case "NEXT": {
        const result = advanceChunk();
        if (result === "end") {
          state.status = "IDLE";
          events.push({ type: "STOP_TTS" });
          events.push({ type: "ANNOUNCE", text: "End of document." });
          events.push({ type: "PERSIST", state: { ...state } });
          break;
        }
        state.status = "PLAYING";
        events.push({ type: "STOP_TTS" });
        speakCurrent(events);
        events.push({ type: "PERSIST", state: { ...state } });
        break;
      }
      case "REPEAT": {
        if (!currentSentence()) break;
        state.status = "PLAYING";
        events.push({ type: "STOP_TTS" });
        speakCurrent(events);
        break;
      }
      case "BACK": {
        const result = retreatChunk();
        if (result === "at-start") {
          events.push({ type: "ANNOUNCE", text: "Already at the start." });
          break;
        }
        state.status = "PLAYING";
        events.push({ type: "STOP_TTS" });
        speakCurrent(events);
        events.push({ type: "PERSIST", state: { ...state } });
        break;
      }
      case "PAUSE": {
        state.status = "PAUSED";
        events.push({ type: "STOP_TTS" });
        // No ANNOUNCE: the screen reader already speaks the Pause button
        // name when the user activates it. Re-announcing duplicates that
        // and interrupts whatever the reader was saying.
        events.push({ type: "PERSIST", state: { ...state } });
        break;
      }
      case "RESUME": {
        if (!currentSentence()) break;
        state.status = "PLAYING";
        speakCurrent(events);
        events.push({ type: "PERSIST", state: { ...state } });
        break;
      }
      case "SPELL": {
        const s = currentSentence();
        if (!s || s.words.length === 0) break;
        // Decide what to spell based on the user's current mode:
        //   word   → the single word at the cursor
        //   phrase → the current 4-word phrase
        //   sentence → the entire current sentence, word by word
        let words: string[];
        if (state.mode === "word") {
          const w = s.words[state.wordIndex];
          words = w ? [w] : [];
        } else if (state.mode === "phrase") {
          words = s.words.slice(state.wordIndex, state.wordIndex + PHRASE_WORD_COUNT);
        } else {
          words = s.words.slice();
        }
        if (words.length === 0) break;
        // Enter PLAYING so the mic gating effect turns the recognizer off
        // while Shruti spells (otherwise the mic picks up its own letters).
        state.status = "PLAYING";
        events.push({ type: "STOP_TTS" });
        events.push({ type: "SPELL", words });
        break;
      }
      case "WHERE": {
        events.push({ type: "ANNOUNCE", text: positionAnnouncement() });
        break;
      }
      case "NEXT_SENTENCE": {
        if (state.globalSentenceIndex >= totalSentences - 1) {
          state.status = "IDLE";
          events.push({ type: "STOP_TTS" });
          events.push({ type: "ANNOUNCE", text: "End of document." });
          events.push({ type: "PERSIST", state: { ...state } });
          break;
        }
        state.globalSentenceIndex += 1;
        state.wordIndex = 0;
        state.status = "PLAYING";
        events.push({ type: "STOP_TTS" });
        speakCurrent(events);
        events.push({ type: "PERSIST", state: { ...state } });
        break;
      }
      case "PREV_SENTENCE": {
        // If we're mid-sentence (wordIndex > 0), step back to the start of
        // the current sentence first; otherwise step into the previous one.
        if (state.wordIndex > 0) {
          state.wordIndex = 0;
        } else if (state.globalSentenceIndex > 0) {
          state.globalSentenceIndex -= 1;
          state.wordIndex = 0;
        } else {
          events.push({ type: "ANNOUNCE", text: "Already at the start." });
          break;
        }
        state.status = "PLAYING";
        events.push({ type: "STOP_TTS" });
        speakCurrent(events);
        events.push({ type: "PERSIST", state: { ...state } });
        break;
      }
      case "NEXT_PARAGRAPH": {
        const s = currentSentence();
        if (!s) break;
        // Find first sentence of the next paragraph.
        const targetParagraph = s.paragraphIndex + 1;
        const nextPara = opts.doc.chunks.paragraphs[targetParagraph];
        if (!nextPara || nextPara.sentences.length === 0) {
          state.status = "IDLE";
          events.push({ type: "STOP_TTS" });
          events.push({ type: "ANNOUNCE", text: "End of document." });
          events.push({ type: "PERSIST", state: { ...state } });
          break;
        }
        state.globalSentenceIndex = nextPara.sentences[0].globalIndex;
        state.wordIndex = 0;
        state.status = "PLAYING";
        events.push({ type: "STOP_TTS" });
        speakCurrent(events);
        events.push({ type: "PERSIST", state: { ...state } });
        break;
      }
      case "PREV_PARAGRAPH": {
        const s = currentSentence();
        if (!s) break;
        // If we're not at the first sentence of the current paragraph, jump
        // there; otherwise step into the previous paragraph.
        let targetParagraph = s.paragraphIndex;
        if (s.localIndex === 0 && state.wordIndex === 0) {
          targetParagraph = s.paragraphIndex - 1;
        }
        if (targetParagraph < 0) {
          events.push({ type: "ANNOUNCE", text: "Already at the start." });
          break;
        }
        const para = opts.doc.chunks.paragraphs[targetParagraph];
        if (!para || para.sentences.length === 0) {
          events.push({ type: "ANNOUNCE", text: "Already at the start." });
          break;
        }
        state.globalSentenceIndex = para.sentences[0].globalIndex;
        state.wordIndex = 0;
        state.status = "PLAYING";
        events.push({ type: "STOP_TTS" });
        speakCurrent(events);
        events.push({ type: "PERSIST", state: { ...state } });
        break;
      }
      case "GO_TO_START": {
        state.globalSentenceIndex = 0;
        state.wordIndex = 0;
        state.status = "PLAYING";
        events.push({ type: "STOP_TTS" });
        speakCurrent(events);
        events.push({ type: "PERSIST", state: { ...state } });
        break;
      }
      case "GO_TO_END": {
        if (totalSentences === 0) break;
        state.globalSentenceIndex = totalSentences - 1;
        const last = sentences[state.globalSentenceIndex];
        state.wordIndex = 0;
        if (state.mode !== "sentence" && last) {
          // Position at the last word/phrase boundary of the last sentence.
          if (state.mode === "word") {
            state.wordIndex = Math.max(0, last.words.length - 1);
          } else {
            const lastPhraseStart = Math.max(
              0,
              Math.floor((last.words.length - 1) / PHRASE_WORD_COUNT) * PHRASE_WORD_COUNT,
            );
            state.wordIndex = lastPhraseStart;
          }
        }
        state.status = "PLAYING";
        events.push({ type: "STOP_TTS" });
        speakCurrent(events);
        events.push({ type: "PERSIST", state: { ...state } });
        break;
      }
      case "CHUNK_FINISHED": {
        state.status = "WAITING_FOR_USER";
        events.push({ type: "PERSIST", state: { ...state } });
        break;
      }
      case "SET_PACE": {
        state.pace = intent.pace;
        // No ANNOUNCE: radio-button activation already speaks the choice.
        events.push({ type: "PERSIST", state: { ...state } });
        break;
      }
      case "SET_MODE": {
        state.mode = intent.mode;
        state.wordIndex = 0;
        // No ANNOUNCE: radio-button activation already speaks the choice.
        events.push({ type: "PERSIST", state: { ...state } });
        break;
      }
      case "SET_ANNOUNCE_PUNCT": {
        state.announcePunctuation = intent.on;
        events.push({ type: "PERSIST", state: { ...state } });
        break;
      }
    }

    if (
      intent.type !== "CHUNK_FINISHED" &&
      intent.type !== "SET_PACE" &&
      intent.type !== "SET_MODE" &&
      intent.type !== "SET_ANNOUNCE_PUNCT"
    ) {
      recordCommand(intent, now);
    }
    return events;
  }

  function positionAnnouncement(): string {
    const s = currentSentence();
    if (!s) return "No content.";
    const paragraph = opts.doc.chunks.paragraphs[s.paragraphIndex];
    const localTotal = paragraph ? paragraph.sentences.length : 0;
    const base = `Paragraph ${s.paragraphIndex + 1}, sentence ${s.localIndex + 1} of ${localTotal}.`;
    if (state.mode === "sentence") return base;
    return `${base} Word ${state.wordIndex + 1} of ${s.words.length}.`;
  }

  return {
    getState: () => ({ ...state }),
    currentSentence,
    currentWord,
    currentChunkText,
    currentSpeakableText,
    dispatch,
    positionAnnouncement,
  };
}

function clamp(n: number, lo: number, hi: number): number {
  return Math.max(lo, Math.min(hi, n));
}
