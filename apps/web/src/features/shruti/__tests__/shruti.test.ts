// Node-native test runner (node:test) — no extra dependency.
// Run: node --import tsx --test apps/web/src/features/shruti/__tests__/shruti.test.ts

import { strict as assert } from "node:assert";
import { describe, it } from "node:test";

import { normalizeText, hashText, detectLanguage } from "../normalizeText";
import { chunkDocument } from "../chunkDocument";
import { createDictationSession, PACE_PRESETS, SessionEvent } from "../createDictationSession";
import {
  CLEAN_ENGLISH_LOKSEWA,
  MESSY_NEPALI_OCR,
  MIXED_SCRIPT,
} from "./fixtures";

describe("normalizeText", () => {
  it("is idempotent", () => {
    const once = normalizeText(MESSY_NEPALI_OCR);
    const twice = normalizeText(once);
    assert.equal(once, twice);
  });

  it("collapses zero-width joiners", () => {
    const input = "का‍र्य";
    const out = normalizeText(input);
    assert.ok(!/‍/.test(out));
  });

  it("hash is stable", () => {
    assert.equal(hashText("hello"), hashText("hello"));
    assert.notEqual(hashText("hello"), hashText("hellp"));
  });

  it("detects language", () => {
    assert.equal(detectLanguage(CLEAN_ENGLISH_LOKSEWA), "en");
    assert.equal(detectLanguage(MESSY_NEPALI_OCR), "ne");
    assert.equal(detectLanguage(MIXED_SCRIPT), "mixed");
  });
});

describe("chunkDocument", () => {
  it("does not split on Dr. / B.S. abbreviations", () => {
    const { doc } = chunkDocument(CLEAN_ENGLISH_LOKSEWA, {
      id: "t1", title: "Loksewa", sourceType: "library",
    });
    const allText = doc.chunks.paragraphs.flatMap(p => p.sentences).map(s => s.text).join(" ");
    // "Dr." should not be the END of a sentence.
    for (const p of doc.chunks.paragraphs) {
      for (const s of p.sentences) {
        assert.ok(!/\bDr\.\s*$/.test(s.text), `Sentence ends on Dr.: "${s.text}"`);
        assert.ok(!/\bB\.S\.\s*$/.test(s.text), `Sentence ends on B.S.: "${s.text}"`);
      }
    }
    assert.ok(allText.includes("Adhikari"));
  });

  it("produces non-empty sentences with sane word counts", () => {
    const { doc, issues } = chunkDocument(CLEAN_ENGLISH_LOKSEWA, {
      id: "t2", title: "Loksewa", sourceType: "library",
    });
    const sentences = doc.chunks.paragraphs.flatMap(p => p.sentences);
    assert.ok(sentences.length > 0);
    for (const s of sentences) {
      assert.ok(s.text.trim().length > 0);
      assert.ok(s.words.length > 0);
    }
    assert.equal(issues.filter(i => i.code === "empty_sentence").length, 0);
  });

  it("splits Nepali on danda", () => {
    const { doc } = chunkDocument(MESSY_NEPALI_OCR, {
      id: "t3", title: "NP", sourceType: "paste",
    });
    const sentences = doc.chunks.paragraphs.flatMap(p => p.sentences);
    assert.ok(sentences.length >= 4, `expected ≥4 sentences, got ${sentences.length}`);
  });

  it("captures text without any terminator (regression: lost-everything bug)", () => {
    // Previously, "Hello world" with no period emitted ["world"] only.
    // Confirm the trailing fragment is now captured as its own sentence.
    const { doc } = chunkDocument("Hello world", {
      id: "tail1", title: "x", sourceType: "paste",
    });
    const sentences = doc.chunks.paragraphs.flatMap(p => p.sentences);
    assert.equal(sentences.length, 1);
    assert.equal(sentences[0].text, "Hello world");
  });

  it("captures trailing Nepali fragment without final danda", () => {
    // Common in pasted snippets — last sentence missing terminator.
    const { doc } = chunkDocument("नेपालको संविधान २०७२। काठमाडौं राजधानी हो", {
      id: "tail2", title: "x", sourceType: "paste",
    });
    const sentences = doc.chunks.paragraphs.flatMap(p => p.sentences);
    assert.equal(sentences.length, 2,
      `expected 2 sentences, got ${sentences.length}: ${JSON.stringify(sentences.map(s => s.text))}`);
    assert.ok(sentences[1].text.includes("काठमाडौं"));
  });

  it("builds Devanagari syllable spelling tokens", () => {
    const { doc } = chunkDocument("नेपाल", {
      id: "t4", title: "x", sourceType: "paste",
    });
    const tokens = doc.spellingTokens["नेपाल"];
    assert.ok(tokens && tokens.length >= 2);
    // First akshara should include the vowel sign े.
    assert.ok(tokens[0].unit.includes("ने") || tokens[0].unit.startsWith("ने"));
  });

  it("character drift is within tolerance", () => {
    const { issues } = chunkDocument(CLEAN_ENGLISH_LOKSEWA, {
      id: "t5", title: "x", sourceType: "library",
    });
    assert.equal(issues.filter(i => i.code === "char_drift").length, 0);
  });
});

describe("createDictationSession", () => {
  const { doc } = chunkDocument(CLEAN_ENGLISH_LOKSEWA, {
    id: "doc1", title: "Loksewa", sourceType: "library",
  });

  it("starts at sentence 0 and emits SPEAK", () => {
    const s = createDictationSession({ doc });
    const events = s.dispatch({ type: "START" }, 1000);
    assert.equal(events[0].type, "SPEAK");
    assert.equal(s.getState().status, "PLAYING");
  });

  it("NEXT advances sentence index", () => {
    const s = createDictationSession({ doc });
    s.dispatch({ type: "START" }, 1000);
    s.dispatch({ type: "NEXT" }, 2000);
    assert.equal(s.getState().globalSentenceIndex, 1);
  });

  it("BACK at 0 announces 'already at the start'", () => {
    const s = createDictationSession({ doc });
    s.dispatch({ type: "START" }, 1000);
    const events = s.dispatch({ type: "BACK" }, 2000);
    assert.ok(events.some(e => e.type === "ANNOUNCE" && /start/i.test(e.text)));
    assert.equal(s.getState().globalSentenceIndex, 0);
  });

  it("ignores duplicate commands within 750ms", () => {
    const s = createDictationSession({ doc });
    s.dispatch({ type: "START" }, 1000);
    s.dispatch({ type: "NEXT" }, 2000);
    const events = s.dispatch({ type: "NEXT" }, 2300); // 300ms later
    assert.ok(events.some(e => e.type === "IGNORED"));
    assert.equal(s.getState().globalSentenceIndex, 1);
  });

  it("accepts duplicate command after cooldown expires", () => {
    const s = createDictationSession({ doc });
    s.dispatch({ type: "START" }, 1000);
    s.dispatch({ type: "NEXT" }, 2000);
    s.dispatch({ type: "NEXT" }, 3000); // 1000ms later → allowed
    assert.equal(s.getState().globalSentenceIndex, 2);
  });

  it("CHUNK_FINISHED moves to WAITING_FOR_USER", () => {
    const s = createDictationSession({ doc });
    s.dispatch({ type: "START" }, 1000);
    s.dispatch({ type: "CHUNK_FINISHED" }, 2000);
    assert.equal(s.getState().status, "WAITING_FOR_USER");
  });

  it("word mode: NEXT advances one word, then to next sentence", () => {
    const s = createDictationSession({ doc, mode: "word" });
    const startEvents = s.dispatch({ type: "START" }, 1000);
    const firstSpeak = startEvents.find(e => e.type === "SPEAK");
    assert.ok(firstSpeak && firstSpeak.type === "SPEAK");
    // first chunk is a single word (not the whole sentence)
    assert.ok(!(firstSpeak as { text: string }).text.includes(" "));

    const sentence0 = doc.chunks.paragraphs[0].sentences[0];
    const wordCount = sentence0.words.length;

    let now = 2000;
    for (let i = 1; i < wordCount; i++) {
      s.dispatch({ type: "NEXT" }, now);
      now += 1000;
      assert.equal(s.getState().globalSentenceIndex, 0);
      assert.equal(s.getState().wordIndex, i);
    }
    // One more NEXT advances to sentence 1, word 0
    s.dispatch({ type: "NEXT" }, now);
    assert.equal(s.getState().globalSentenceIndex, 1);
    assert.equal(s.getState().wordIndex, 0);
  });

  it("word mode: BACK steps back one word, then across sentence boundary", () => {
    const s = createDictationSession({ doc, mode: "word" });
    s.dispatch({ type: "START" }, 1000);
    s.dispatch({ type: "NEXT" }, 2000);
    s.dispatch({ type: "NEXT" }, 3000);
    assert.equal(s.getState().wordIndex, 2);
    s.dispatch({ type: "BACK" }, 4000);
    assert.equal(s.getState().wordIndex, 1);
    s.dispatch({ type: "BACK" }, 5000);
    assert.equal(s.getState().wordIndex, 0);
    // BACK from word 0 of sentence 0 → "Already at the start"
    const events = s.dispatch({ type: "BACK" }, 6000);
    assert.ok(events.some(e => e.type === "ANNOUNCE" && /start/i.test(e.text)));
  });

  it("SET_MODE resets wordIndex", () => {
    const s = createDictationSession({ doc, mode: "word" });
    s.dispatch({ type: "START" }, 1000);
    s.dispatch({ type: "NEXT" }, 2000);
    s.dispatch({ type: "NEXT" }, 3000);
    assert.equal(s.getState().wordIndex, 2);
    s.dispatch({ type: "SET_MODE", mode: "sentence" }, 4000);
    assert.equal(s.getState().mode, "sentence");
    assert.equal(s.getState().wordIndex, 0);
  });

  it("SPELL in word mode spells the word at the current wordIndex", () => {
    const s = createDictationSession({ doc, mode: "word" });
    s.dispatch({ type: "START" }, 1000);
    s.dispatch({ type: "NEXT" }, 2000); // word 1
    const events = s.dispatch({ type: "SPELL" }, 3000);
    const sentence0 = doc.chunks.paragraphs[0].sentences[0];
    const spell = events.find(e => e.type === "SPELL");
    assert.ok(spell);
    const spellEv = spell as { words: string[] };
    assert.deepEqual(spellEv.words, [sentence0.words[1]]);
  });

  it("SPELL in sentence mode spells every word of the current sentence", () => {
    const s = createDictationSession({ doc, mode: "sentence" });
    s.dispatch({ type: "START" }, 1000);
    const events = s.dispatch({ type: "SPELL" }, 2000);
    const sentence0 = doc.chunks.paragraphs[0].sentences[0];
    const spell = events.find(e => e.type === "SPELL") as { words: string[] } | undefined;
    assert.ok(spell);
    assert.deepEqual(spell!.words, sentence0.words);
    // Status should be PLAYING during spelling so the mic gates off.
    assert.equal(s.getState().status, "PLAYING");
  });

  it("SET_PACE updates pace without announcing", () => {
    const s = createDictationSession({ doc });
    const events = s.dispatch({ type: "SET_PACE", pace: PACE_PRESETS.fast }, 1000);
    assert.equal(s.getState().pace.preset, "fast");
    // SET_PACE/SET_MODE/PAUSE intentionally don't emit ANNOUNCE — the screen
    // reader already speaks the activated control's name.
    assert.ok(!events.some(e => e.type === "ANNOUNCE"));
  });

  it("WHERE produces a paragraph + sentence announcement", () => {
    const s = createDictationSession({ doc });
    s.dispatch({ type: "START" }, 1000);
    const events = s.dispatch({ type: "WHERE" }, 2000);
    const ann = events.find(e => e.type === "ANNOUNCE");
    assert.ok(ann && /paragraph/i.test((ann as { text: string }).text));
  });

  it("NEXT past end stops and announces", () => {
    const tiny = chunkDocument("One sentence only.", {
      id: "tiny", title: "x", sourceType: "paste",
    }).doc;
    const s = createDictationSession({ doc: tiny });
    s.dispatch({ type: "START" }, 1000);
    const events = s.dispatch({ type: "NEXT" }, 2000);
    assert.ok(events.some(e => e.type === "ANNOUNCE" && /end/i.test(e.text)));
    assert.equal(s.getState().status, "IDLE");
  });

  it("never tokenizes standalone punctuation or symbols as words", () => {
    const messy = `Hello ... world! "Quoted" — text. 100% sure? @user #tag $5.`;
    const { doc } = chunkDocument(messy, {
      id: "tok1", title: "x", sourceType: "paste",
    });
    const allWords = doc.chunks.paragraphs.flatMap(p =>
      p.sentences.flatMap(s => s.words),
    );
    for (const w of allWords) {
      assert.ok(/^[\p{L}\p{N}]/u.test(w), `Word starts with non-letter/digit: "${w}"`);
      assert.ok(!/^[^\p{L}\p{N}]+$/u.test(w), `Word is symbols-only: "${w}"`);
    }
  });

  it("computes spokenText with abbreviation expansion and counts words", () => {
    const { doc } = chunkDocument("The reforms in B.S. 2065 worked, etc.", {
      id: "exp1", title: "x", sourceType: "paste",
    });
    const s = doc.chunks.paragraphs[0].sentences[0];
    // Expansion happened.
    assert.ok(s.spokenText.includes("Bikram Sambat 2065"),
      `expected expansion in: ${s.spokenText}`);
    assert.ok(s.spokenText.toLowerCase().includes("etcetera"),
      `expected 'etcetera' in: ${s.spokenText}`);
    // spokenText is structurally different from raw text.
    assert.notEqual(s.spokenText, s.text);
    // spokenWordCount is computed and positive.
    assert.ok(s.spokenWordCount > 0);
  });

  it("captures trailing punctuation per word", () => {
    const { doc } = chunkDocument("Hello, world. How are you?", {
      id: "p1", title: "x", sourceType: "paste",
    });
    const sentences = doc.chunks.paragraphs.flatMap(p => p.sentences);
    const allWords = sentences.flatMap(s => s.words);
    const allPunct = sentences.flatMap(s => s.trailingPunct);
    assert.deepEqual(allWords, ["Hello", "world", "How", "are", "you"]);
    assert.deepEqual(allPunct, [",", ".", "", "", "?"]);
  });

  it("SPEAK in word mode includes punctuation announcement when enabled", () => {
    const { doc } = chunkDocument("Hello, world.", {
      id: "p2", title: "x", sourceType: "paste",
    });
    const sess = createDictationSession({ doc, mode: "word", announcePunctuation: true });
    const events = sess.dispatch({ type: "START" }, 1000);
    const speak = events.find(e => e.type === "SPEAK") as { text: string } | undefined;
    assert.ok(speak);
    assert.equal(speak!.text, "Hello, comma");
  });

  it("SPEAK in word mode omits punctuation when announce flag is off", () => {
    const { doc } = chunkDocument("Hello, world.", {
      id: "p3", title: "x", sourceType: "paste",
    });
    const sess = createDictationSession({ doc, mode: "word", announcePunctuation: false });
    const events = sess.dispatch({ type: "START" }, 1000);
    const speak = events.find(e => e.type === "SPEAK") as { text: string } | undefined;
    assert.ok(speak);
    assert.equal(speak!.text, "Hello");
  });

  it("NEXT_SENTENCE jumps to the next sentence regardless of word cursor", () => {
    const { doc } = chunkDocument(CLEAN_ENGLISH_LOKSEWA, {
      id: "nav1", title: "x", sourceType: "library",
    });
    const sess = createDictationSession({ doc, mode: "word" });
    sess.dispatch({ type: "START" }, 1000);
    sess.dispatch({ type: "NEXT" }, 2000);  // word 1 of sentence 0
    sess.dispatch({ type: "NEXT_SENTENCE" }, 3000);
    assert.equal(sess.getState().globalSentenceIndex, 1);
    assert.equal(sess.getState().wordIndex, 0);
  });

  it("PREV_SENTENCE returns to start of current sentence first, then jumps back", () => {
    const { doc } = chunkDocument(CLEAN_ENGLISH_LOKSEWA, {
      id: "nav2", title: "x", sourceType: "library",
    });
    const sess = createDictationSession({ doc, mode: "word" });
    sess.dispatch({ type: "START" }, 1000);
    sess.dispatch({ type: "NEXT" }, 2000);
    sess.dispatch({ type: "NEXT" }, 3000);
    sess.dispatch({ type: "NEXT_SENTENCE" }, 4000); // now at sentence 1 word 0
    sess.dispatch({ type: "NEXT" }, 5000);          // sentence 1 word 1
    sess.dispatch({ type: "PREV_SENTENCE" }, 6000); // mid-sentence → start of sentence 1
    assert.equal(sess.getState().globalSentenceIndex, 1);
    assert.equal(sess.getState().wordIndex, 0);
    sess.dispatch({ type: "PREV_SENTENCE" }, 7000); // already at start → step back
    assert.equal(sess.getState().globalSentenceIndex, 0);
    assert.equal(sess.getState().wordIndex, 0);
  });

  it("NEXT_PARAGRAPH jumps to the first sentence of the next paragraph", () => {
    const { doc } = chunkDocument(CLEAN_ENGLISH_LOKSEWA, {
      id: "nav3", title: "x", sourceType: "library",
    });
    const sess = createDictationSession({ doc, mode: "sentence" });
    sess.dispatch({ type: "START" }, 1000);
    sess.dispatch({ type: "NEXT_PARAGRAPH" }, 2000);
    const sentence = sess.currentSentence();
    assert.ok(sentence);
    assert.equal(sentence!.paragraphIndex, 1);
    assert.equal(sentence!.localIndex, 0);
  });

  it("GO_TO_START / GO_TO_END reposition correctly", () => {
    const { doc } = chunkDocument(CLEAN_ENGLISH_LOKSEWA, {
      id: "nav4", title: "x", sourceType: "library",
    });
    const sess = createDictationSession({ doc, mode: "sentence" });
    sess.dispatch({ type: "GO_TO_END" }, 1000);
    const total = doc.progressMap.totalSentences;
    assert.equal(sess.getState().globalSentenceIndex, total - 1);
    sess.dispatch({ type: "GO_TO_START" }, 2000);
    assert.equal(sess.getState().globalSentenceIndex, 0);
    assert.equal(sess.getState().wordIndex, 0);
  });

  it("isParagraphStart fires on first word of a non-first paragraph", () => {
    const { doc } = chunkDocument("First para sentence.\n\nSecond para sentence.", {
      id: "p4", title: "x", sourceType: "paste",
    });
    const sess = createDictationSession({ doc, mode: "word" });
    sess.dispatch({ type: "START" }, 1000);
    // Advance until we cross into the second paragraph.
    const sentence0Words = doc.chunks.paragraphs[0].sentences[0].words.length;
    let lastEvents: SessionEvent[] = [];
    let now = 2000;
    for (let i = 0; i < sentence0Words; i++) {
      lastEvents = sess.dispatch({ type: "NEXT" }, now);
      now += 1000;
    }
    const speak = lastEvents.find(e => e.type === "SPEAK") as
      | { isParagraphStart: boolean } | undefined;
    assert.ok(speak);
    assert.equal(speak!.isParagraphStart, true);
  });
});
