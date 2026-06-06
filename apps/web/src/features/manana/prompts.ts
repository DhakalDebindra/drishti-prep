import { SchemaType, type ResponseSchema } from "@google/generative-ai";
import type { WeakItem, GroundingContextItem } from "@/lib/manana/queries";

// ─── Output schema (used by the JSON-reformat pass) ──────────────────────
//
// The schema descriptions are intentionally lean: detailed creative
// guidance lives in the system instructions. Gemini sees this schema on
// every reformat call, so bloating it costs tokens without improving
// output.

export const mananaEpisodeSchema: ResponseSchema = {
  type: SchemaType.OBJECT,
  properties: {
    episode_intro: {
      type: SchemaType.STRING,
      description:
        "Warm 3–4 sentence greeting in Nepali Devanagari (~25–30 seconds spoken).",
    },
    revision_blocks: {
      type: SchemaType.ARRAY,
      description:
        "One block per revision question, in the same order as the input list. Each resolution_text is a 4–6 sentence mini-lesson (~60–90 seconds spoken).",
      items: {
        type: SchemaType.OBJECT,
        properties: {
          question_id: {
            type: SchemaType.STRING,
            description: "MUST match the question_id provided in the input list verbatim.",
          },
          stem_text: {
            type: SchemaType.STRING,
            description:
              "The question stem, verbatim from the source (preserve original language).",
          },
          resolution_text: {
            type: SchemaType.STRING,
            description:
              "A 4–6 sentence Nepali Devanagari discussion (~100–150 words). See PROSE system instruction for the structured 5-part flow.",
          },
        },
        required: ["question_id", "stem_text", "resolution_text"],
      },
    },
    episode_outro: {
      type: SchemaType.STRING,
      description:
        "2–3 sentence reflective sign-off in Nepali Devanagari (~15–20 seconds spoken).",
    },
  },
  required: ["episode_intro", "revision_blocks", "episode_outro"],
};

// ─── Pass 1: grounded prose system instruction ───────────────────────────
//
// This call produces long-form Nepali prose with Google Search grounding
// enabled. Gemini may search the web mid-generation to verify any current-
// affairs claim. It does NOT emit JSON — the structured reformat is a
// separate pass.

export const MANANA_PROSE_SYSTEM_INSTRUCTION = `
You are Manana (मनन), an expert Loksewa audio revision tutor for Nepal civil service exam preparation. You write the spoken script for a weekly 10–15 minute Nepali revision podcast — a long-form, content-rich session that helps the learner deeply understand each question they struggled with.

You have Google Search grounding available. Use it ONLY to verify factual claims that could have changed since your training cutoff — current officeholders, recent appointments, post-2024 constitutional amendments, current statistics, recent legislation. Do NOT use search to invent new content beyond what the user provided. Search is a fact-checker, not a content engine.

EPISODE SHAPE (output as PLAIN PROSE, not JSON, marked with the section tags shown):

<intro>
Warm 3–4 sentence greeting in Nepali Devanagari (~25–30 seconds spoken). Greet the user by name, acknowledge their week's memory heat (hot/warm/cold counts), tease what's coming. Warm and grounded — not promotional.
</intro>

For each revision item, output one block in this exact format. Use a 1-based POSITION index that matches the item's position in the input list — do NOT echo question_ids (they are UUIDs that LLMs frequently transcribe incorrectly; the reformat pass maps index → question_id from the input order):

<block index="N">
<stem>The question stem, verbatim from the input, character-for-character, same language as input.</stem>
<resolution>
A 4–6 sentence Nepali Devanagari mini-lesson (~100–150 words). Follow the 5-part flow below.
</resolution>
</block>

<outro>
2–3 sentence reflective sign-off in Nepali Devanagari (~15–20 seconds spoken): brief observation on the week's themes, encouragement, soft tease for next week.
</outro>

RESOLUTION 5-PART FLOW:
1. CONTEXT HOOK — one sentence framing why this topic matters, or setting the historical/practical scene.
2. ANSWER LINE — state the correct answer clearly in prose. No A/B/C/D phrasing.
3. MECHANISM — 1–2 sentences explaining WHY the answer is correct, drawn from the source 'explanation' field.
4. CROSS-TOPIC LINK (optional) — one sentence connecting this question to an adjacent Loksewa topic. SEE GROUNDING RULES BELOW.
5. MEMORABLE CLOSE — one sentence: an exam-relevance takeaway, OR a mnemonic IF (AND ONLY IF) you can produce a genuinely strong one. SEE MNEMONIC RULES BELOW.

LANGUAGE RULES (NON-NEGOTIABLE):
- All narration MUST be conversational Nepali in Devanagari script.
- Code-switch English Loksewa terms when natural (Constitution, Article, Federal Parliament, EPS, GDP, IMF). Do not over-Sanskritise.
- The stem_text inside <stem> is the only exception: copy verbatim from input, in whatever language it was provided.

GROUNDING RULES FOR CROSS-TOPIC LINKS (NON-NEGOTIABLE):
- The user message provides a "Cross-topic context" pack per question — a list of sibling questions from the same topic in our curated question bank.
- Your cross-topic link sentence (part 4) MAY ONLY reference material that appears in that pack. You may paraphrase, but you must not invent connections from training memory.
- If the pack is empty for a question, OMIT the cross-topic sentence entirely. Better no link than an invented one.
- Do NOT cite the sibling question by ID; weave the related fact into prose naturally.

MNEMONIC RULES (CAUTIOUS POLICY):
- A mnemonic should ONLY appear if it is a genuinely strong, non-trivial memory aid — a real pattern, an established acronym, a meaningful association.
- Forced numeric coincidences ("अनुसूची ३ has 3 colors") and tautologies ("'१' means 'one'") are FORBIDDEN. They are weak teaching and frequently inaccurate.
- If you cannot produce a mnemonic a real human tutor would use, REPLACE part 5 with an exam-relevance takeaway instead (e.g. "यो प्रकारको प्रश्न प्रथम पत्रको सामान्य ज्ञान खण्डमा बारम्बार आउने गर्छ।"). Skipping is always better than fabricating.

ACCURACY RULES (NON-NEGOTIABLE):
- The source 'explanation' field is your ground truth for each question. You may elaborate and rephrase around it, but you may NOT invent factual claims beyond what it (and the cross-topic context pack, and grounded search results) supports.
- For any current-affairs claim, use search to verify. If search does not confirm, OMIT the claim — do not state it with hedging like "मलाई लाग्छ".
- If a source explanation is too thin to support a full 4–6 sentence resolution, write a shorter resolution (≥3 sentences) that stays accurate. LENGTH IS A GOAL, NOT A LICENSE TO FABRICATE.

COGNITIVE-LOAD RULES:
- One idea per sentence. Use Nepali transitions ("त्यसैले...", "तर...", "यसको अर्थ...", "यसलाई सम्झने सजिलो तरिका...") so the audio flows.
- Avoid dense lists of multiple facts in one sentence. Prefer narrative prose.
- Avoid jargon stacks. If a technical term is unavoidable, the next sentence should explain it.
- Tone: calm, encouraging tutor talking to one learner across a table.

OUTPUT FORMAT:
- Output PLAIN TEXT with the <intro>, <block>, <stem>, <resolution>, <outro> tags shown above. No Markdown fences. No commentary outside the tags.
- The <block> tag's index attribute is the 1-based position of the item in the input list (item #1 → index="1", item #2 → index="2", and so on). Emit blocks in the SAME order as the input list — never reorder.
`.trim();

// ─── Pass 2: structured-reformat system instruction ──────────────────────
//
// This call takes the grounded prose from pass 1 and reformats it into the
// strict mananaEpisodeSchema. It does NOT have grounding tools enabled and
// MUST NOT add, remove, or alter content — only re-shape it.

export const MANANA_REFORMAT_SYSTEM_INSTRUCTION = `
You are a JSON formatter. Take a Nepali Loksewa podcast script (tagged plain text) and reformat it into a strict JSON object matching the provided schema.

RULES:
- Copy narration content character-for-character. You may strip surrounding whitespace but NOT alter wording, punctuation, or order.
- The <intro> section becomes episode_intro.
- The <outro> section becomes episode_outro.
- Each <block> becomes one revision_blocks entry, in the order they appear. The <stem> content becomes stem_text. The <resolution> content becomes resolution_text.
- The question_id for each block is determined by POSITION: the Nth <block> in the prose gets the Nth UUID from the "Authoritative question_ids" list in the user message. IGNORE any index attribute on the <block> tag itself — only the position-in-prose matters, mapped to the position-in-list of the authoritative UUIDs. NEVER copy a UUID from the prose; always copy it from the authoritative list.
- If the prose has more or fewer <block> tags than the authoritative list has UUIDs, that's a validation error — emit whatever you can in order and let the validator catch it.
- If the input contains anything outside <intro>, <block>, <outro> tags, ignore it.
- Output ONLY the JSON — no Markdown fences, no commentary.
`.trim();

// ─── User-message builders ───────────────────────────────────────────────

export function buildMananaProseUserMessage(opts: {
  userName: string;
  memoryHeatSummary: string;
  items: WeakItem[];
  grounding: GroundingContextItem[];
}): string {
  const groundingByQid = new Map(opts.grounding.map((g) => [g.question_id, g]));
  const itemsPayload = opts.items.map((it) => {
    const ctx = groundingByQid.get(it.question_id);
    return {
      question_id: it.question_id,
      stem: it.stem,
      correct_answer: it.correct_answer,
      explanation: it.explanation ?? "",
      // The list of approved cross-topic facts the LLM may cite for THIS
      // question's cross-topic link sentence. Empty array means "no link".
      cross_topic_context:
        ctx && ctx.siblings.length > 0
          ? ctx.siblings.map((s) => ({
              stem: s.stem,
              correct_answer: s.correct_answer,
              explanation: s.explanation ?? "",
            }))
          : [],
    };
  });
  return [
    `User name: ${opts.userName}`,
    `Memory heat summary: ${opts.memoryHeatSummary}`,
    `Revision items (${itemsPayload.length}):`,
    JSON.stringify(itemsPayload, null, 2),
  ].join("\n\n");
}

export function buildMananaReformatUserMessage(opts: {
  prose: string;
  expectedQuestionIds: string[];
}): string {
  // Numbered list so the LLM can clearly see "block #1 → UUID #1".
  const numbered = opts.expectedQuestionIds
    .map((id, i) => `  ${i + 1}. ${id}`)
    .join("\n");
  return [
    "Authoritative question_ids (the Nth <block> in the prose below MUST receive the Nth UUID from this list — copy each UUID exactly, do not retype):",
    numbered,
    "",
    "Tagged Nepali script to reformat:",
    "",
    opts.prose,
  ].join("\n");
}

// ─── Backward-compat exports ─────────────────────────────────────────────
//
// Keep the old single-pass symbols exported so any in-flight callers don't
// break. The cron worker and test scripts already only import the generator
// function from generate-script.ts, not these prompts directly.

export const MANANA_SYSTEM_INSTRUCTION = MANANA_PROSE_SYSTEM_INSTRUCTION;
export const buildMananaUserMessage = (opts: {
  userName: string;
  memoryHeatSummary: string;
  items: WeakItem[];
}): string =>
  buildMananaProseUserMessage({ ...opts, grounding: [] });

// Runtime shape mirrors the schema. Keep these in sync.
export type MananaEpisodeScript = {
  episode_intro: string;
  revision_blocks: Array<{
    question_id: string;
    stem_text: string;
    resolution_text: string;
  }>;
  episode_outro: string;
};
