import "server-only";

import { generateAiContentJSON } from "@/lib/ai-service";
import { createClient } from "@/lib/supabase/server";
import { normaliseQuery } from "@/lib/search/normalize";
import { practiceUrl } from "@/lib/search/links";
import type { SearchResults } from "@/lib/search/types";
import { buildLessonPrompt } from "@/config/prompts";
import { resolveFallback } from "@/lib/ask/fallback";
import { repairQuery } from "@/lib/ask/repair";
import { SMALL_TALK_REPLY, detectSmallTalk } from "@/lib/ask/intent";
import {
  buildRelatedSection,
  filterToPermitted,
  modelSections,
  permittedSections,
  sectionsToPlainText,
  sectionsToSpeechParts,
} from "@/lib/ask/sections";
import {
  SECTION_TITLES,
  type AskMaterial,
  type Lesson,
  type LessonRecommendation,
  type LessonSection,
  type LessonSource,
  type SectionKey,
} from "@/lib/ask/types";

/**
 * Questions handed to the model.
 *
 * Raised from 10. Ten questions with explanations clipped at 400 characters
 * produced fluent but hollow lessons — a paragraph of generalities where the
 * source held exact dates and figures. Depth is the point of this feature, and
 * the latency cost is bounded by the per-explanation trim in the prompt.
 */
const MATERIAL_LIMIT = 14;

/** Practice sets offered at the end of a reply. More is a list, not a choice. */
const MAX_RECOMMENDATIONS = 3;

/**
 * Fewest tokens a question must still contain when the strict pass finds
 * nothing.
 *
 * Measured on "सबैभन्दा ठुलो र सानो": all 3 tokens gives 0 results, 2 gives 99
 * relevant ones, 1 gives 1,572 — mostly junk. So a long query steps down by one
 * and stops well short of OR.
 *
 * A SHORT query is different. "रामसार सूचि के हो?" reduces to रामसार + सूचि,
 * and the learner's spelling (सूचि, where the bank has सूची) means the pair
 * matches nothing — while रामसार alone matches 33 questions. Holding the floor
 * at 2 sent that question to the general-knowledge fallback and produced a
 * paragraph with none of the dates the bank actually holds. With at most two
 * tokens, one of them is usually a generic word and the other is the subject,
 * so dropping to one is the right recovery rather than a collapse.
 */
function minTokenFloor(tokenCount: number): number {
  return tokenCount <= 2 ? 1 : 2;
}

const EMPTY_LESSON: Lesson = {
  route: "insufficient",
  message: "",
  clarifications: [],
  sections: [],
  sources: [],
  recommendations: [],
  lockedNote: null,
  plainText: "",
  speechParts: [],
};

type ModelReply = {
  sections?: { key?: string; body?: string; bullets?: string[] }[];
  used_doc_ids?: number[];
};

/**
 * Build one grounded lesson for a learner's question.
 *
 * The AI is only ever reached when there is material to ground it. When
 * retrieval comes back empty the route is "insufficient" and no model call is
 * made at all — which is both the honest answer and the cheap one.
 */
export async function buildLesson(query: string): Promise<Lesson> {
  // Small talk never reaches retrieval or the model. Answering "नमस्ते" with
  // "we have no content on this" is the sort of thing that makes a product feel
  // stupid, and it costs a model call to do it.
  const smallTalk = detectSmallTalk(query);
  if (smallTalk) {
    return {
      ...EMPTY_LESSON,
      route: "greeting",
      message: SMALL_TALK_REPLY[smallTalk],
    };
  }

  const { tokens } = normaliseQuery(query);
  if (tokens.length === 0) return EMPTY_LESSON;

  const supabase = await createClient();

  const [initialMaterial, searchResult] = await Promise.all([
    fetchMaterial(supabase, tokens),
    (supabase as any).rpc("search_content", {
      p_tokens: tokens,
      p_subject_id: null,
      p_topic_id: null,
      p_set_limit: MAX_RECOMMENDATIONS,
      p_set_offset: 0,
      p_q_limit: 0,
      p_require_all: true,
    }),
  ]);

  if (initialMaterial.error) {
    console.error("[ask] ask_material failed:", initialMaterial.error.message);
    return { ...EMPTY_LESSON, route: "error" };
  }

  let material = initialMaterial.data as AskMaterial;

  // Retrieval is SQL, so a spelling the bank does not share simply finds
  // nothing and the model never sees the question. On a miss, let the model
  // rewrite the query into standard exam terminology and search once more —
  // paid for only when we have already failed.
  if (!material?.questions?.length) {
    const repaired = await repairQuery(query);
    if (repaired) {
      const { tokens: repairedTokens } = normaliseQuery(repaired);
      if (repairedTokens.length > 0) {
        const retry = await fetchMaterial(supabase, repairedTokens);
        if (!retry.error && (retry.data as AskMaterial)?.questions?.length) {
          material = retry.data as AskMaterial;
        }
      }
    }
  }
  // Normalise once, here, so every path below can treat material as present.
  // The RPC can in principle return a null payload with no error, and the
  // optional chaining above made that survivable only until the first plain
  // dereference — which would have thrown a 500 instead of falling back.
  const resolved: AskMaterial = material ?? {
    total_matched: 0,
    locked_count: 0,
    questions: [],
    locked_sets: [],
    topics: [],
    has_paper_ref: false,
  };

  const search = (searchResult.data as SearchResults | null) ?? null;

  const recommendations = buildRecommendations(search);
  const lockedNote =
    resolved.locked_count > 0
      ? {
          count: resolved.locked_count,
          sets: resolved.locked_sets.map((set) => ({
            title: set.title,
            module_name: set.module_name,
          })),
        }
      : null;

  // Nothing readable to teach from. Rather than refuse — which real learners
  // found the most frustrating part of this feature — ask back if the question
  // was vague, or answer from general knowledge with a clear label.
  if (resolved.questions.length === 0) {
    return withFallback(query, recommendations, lockedNote);
  }

  const permitted = permittedSections(resolved);
  const toWrite = modelSections(permitted);

  if (toWrite.length === 0) {
    return withFallback(query, recommendations, lockedNote);
  }

  const prompt = buildLessonPrompt(query, resolved.questions, toWrite);

  let reply: ModelReply;
  try {
    const result = await generateAiContentJSON(prompt, true, "flash");
    reply = JSON.parse(result.data) as ModelReply;
  } catch (error) {
    console.error("[ask] lesson generation failed:", error);
    return {
      ...EMPTY_LESSON,
      route: isQuotaError(error) ? "rate_limited" : "error",
      recommendations,
      lockedNote,
    };
  }

  const sections = groundSections(reply, permitted);

  // A reply that cites nothing we supplied is not grounded in DrishtiPrep
  // content, whatever it says. For exam candidates that is worse than silence.
  if (sections.length === 0 || !isGrounded(reply, resolved.questions.length)) {
    return withFallback(query, recommendations, lockedNote);
  }

  const related = buildRelatedSection(resolved);
  const allSections = related ? [...sections, related] : sections;

  return {
    route: "lesson",
    message: "",
    clarifications: [],
    sections: allSections,
    sources: buildSources(reply, resolved),
    recommendations: mergeSourcesIntoRecommendations(
      buildSources(reply, resolved),
      recommendations,
      resolved
    ),
    lockedNote,
    plainText: sectionsToPlainText(allSections),
    speechParts: sectionsToSpeechParts(allSections),
  };
}

/**
 * Retrieve material, stepping the token requirement down when a strict match
 * finds nothing. Stops at MIN_TOKENS_FLOOR — below that the results stop being
 * about the question.
 */
async function fetchMaterial(supabase: any, tokens: string[][]) {
  const strictest = tokens.length;
  const floor = minTokenFloor(strictest);

  let last: { data: unknown; error: { message: string } | null } = {
    data: null,
    error: null,
  };

  for (let needed = strictest; needed >= floor; needed -= 1) {
    last = await supabase.rpc("ask_material", {
      p_tokens: tokens,
      p_limit: MATERIAL_LIMIT,
      p_min_tokens: needed,
    });
    if (last.error) return last;
    const material = last.data as AskMaterial | null;
    if (material?.questions?.length) return last;
  }

  return last;
}

/**
 * The no-material path: ask back, or answer from outside knowledge with a
 * label. Recommendations still ride along, so even here the learner leaves with
 * real sets to open.
 */
async function withFallback(
  query: string,
  recommendations: LessonRecommendation[],
  lockedNote: Lesson["lockedNote"]
): Promise<Lesson> {
  try {
    const fallback = await resolveFallback(query);

    if (fallback.kind === "clarify") {
      return {
        ...EMPTY_LESSON,
        route: "clarify",
        message: fallback.message,
        clarifications: fallback.options,
        recommendations,
        lockedNote,
      };
    }

    if (fallback.kind === "outside") {
      return {
        ...EMPTY_LESSON,
        route: "outside",
        message: fallback.answer,
        recommendations,
        lockedNote,
        plainText: fallback.answer,
        speechParts: [fallback.answer],
      };
    }
  } catch (error) {
    console.error("[ask] fallback failed:", error);
    if (isQuotaError(error)) {
      return { ...EMPTY_LESSON, route: "rate_limited", recommendations, lockedNote };
    }
  }

  return { ...EMPTY_LESSON, route: "insufficient", recommendations, lockedNote };
}

/**
 * Is this the provider refusing us, rather than the content failing us?
 *
 * The Gemini SDK surfaces quota exhaustion as a 429 with "quota" in the message
 * — the free tier caps generate_content at 20 requests per day per model, which
 * is reached quickly during development. The distinction matters to the learner,
 * not just the log: it is the difference between "come back shortly" and
 * "we have not built this yet".
 */
function isQuotaError(error: unknown): boolean {
  const status = (error as { status?: number })?.status;
  if (status === 429) return true;
  const message = error instanceof Error ? error.message : String(error ?? "");
  return /\b429\b|too many requests|quota|rate limit/i.test(message);
}

/** Keep only permitted sections, with clean titles and no empty bodies. */
function groundSections(reply: ModelReply, permitted: SectionKey[]): LessonSection[] {
  const raw = (reply.sections ?? [])
    .map((section): LessonSection | null => {
      const key = section.key as SectionKey;
      if (!key || !(key in SECTION_TITLES)) return null;

      const body = section.body?.trim();
      const bullets = (section.bullets ?? [])
        .map((bullet) => bullet?.trim())
        .filter((bullet): bullet is string => Boolean(bullet));

      if (!body && bullets.length === 0) return null;

      return { key, title: SECTION_TITLES[key], body, bullets };
    })
    .filter((section): section is LessonSection => section !== null);

  return filterToPermitted(raw, permitted);
}

/**
 * The citations must point at material we actually supplied. Indices are
 * 1-based in the prompt, so anything outside 1..count is invented.
 */
function isGrounded(reply: ModelReply, materialCount: number): boolean {
  const ids = reply.used_doc_ids ?? [];
  if (ids.length === 0) return false;
  return ids.every((id) => Number.isInteger(id) && id >= 1 && id <= materialCount);
}

/** Sources, grouped by set, from the material the model actually cited. */
function buildSources(reply: ModelReply, material: AskMaterial): LessonSource[] {
  const used = (reply.used_doc_ids ?? [])
    .filter((id) => Number.isInteger(id) && id >= 1 && id <= material.questions.length)
    .map((id) => material.questions[id - 1]);

  const bySet = new Map<string, LessonSource>();
  for (const question of used) {
    const existing = bySet.get(question.set_id);
    if (existing) {
      existing.question_count += 1;
    } else {
      bySet.set(question.set_id, {
        set_id: question.set_id,
        set_title: question.set_title,
        question_count: 1,
      });
    }
  }

  return [...bySet.values()].sort((a, b) => b.question_count - a.question_count);
}

/** Practice sets to offer at the end of the reply, ranked by search_content. */
function buildRecommendations(search: SearchResults | null): LessonRecommendation[] {
  if (!search?.sets?.length) return [];

  return search.sets.slice(0, MAX_RECOMMENDATIONS).map((set) => ({
    set_id: set.id,
    title: set.title,
    topic_name: set.topic_name,
    subtopic_name: set.subtopic_name_np || set.subtopic_name,
    q_count: set.q_count,
    locked: set.locked,
    module_name: set.module_name,
    href: set.locked ? null : practiceUrl(set),
    isSource: false,
    citedCount: 0,
  }));
}

/**
 * One list instead of two.
 *
 * The reply used to be followed by a plain-text "स्रोत" block and then a
 * separate list of practice sets — largely the same sets, named twice, with
 * only the second one openable. The sets the answer was actually built from
 * now lead the practice list and are marked, so the citation is still there to
 * check and every entry is something a learner can act on.
 */
function mergeSourcesIntoRecommendations(
  sources: LessonSource[],
  ranked: LessonRecommendation[],
  material: AskMaterial
): LessonRecommendation[] {
  const bySet = new Map<string, LessonRecommendation>();

  for (const source of sources) {
    // Metadata comes from the material the answer was built on, which is the
    // only place a cited set's slugs are known.
    const question = material.questions.find((q) => q.set_id === source.set_id);
    const existing = ranked.find((r) => r.set_id === source.set_id);

    bySet.set(source.set_id, {
      set_id: source.set_id,
      title: source.set_title,
      topic_name: existing?.topic_name ?? question?.topic_name ?? "",
      subtopic_name: existing?.subtopic_name ?? question?.subtopic_name ?? null,
      q_count: existing?.q_count ?? question?.set_q_count ?? 0,
      locked: false, // only readable material reaches a citation
      module_name: existing?.module_name ?? question?.module_name ?? "",
      href:
        existing?.href ??
        (question
          ? practiceUrl({
              id: source.set_id,
              module_slug: question.module_slug,
              subject_slug: question.subject_slug,
              topic_slug: question.topic_slug,
              subtopic_slug: question.subtopic_slug,
            })
          : null),
      isSource: true,
      citedCount: source.question_count,
    });
  }

  for (const recommendation of ranked) {
    if (!bySet.has(recommendation.set_id)) bySet.set(recommendation.set_id, recommendation);
  }

  return [...bySet.values()]
    .sort((a, b) => Number(b.isSource) - Number(a.isSource) || b.citedCount - a.citedCount)
    .slice(0, MAX_RECOMMENDATIONS + 1);
}
