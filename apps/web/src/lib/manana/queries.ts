import type { RepoSupabaseClient } from "@repo/supabase";
import { heat } from "./memory";

export type WeakItem = {
  question_id: string;
  stem: string;
  correct_answer: string;
  explanation: string | null;
  stability: number;
  heat: number;
  last_reviewed_at: string;
};

type QuestionRow = {
  id: string;
  content: string;
  option_a: string;
  option_b: string;
  option_c: string;
  option_d: string;
  correct_option: "A" | "B" | "C" | "D";
  explanation: string | null;
};

function pickCorrectAnswer(q: QuestionRow): string {
  switch (q.correct_option) {
    case "A": return q.option_a;
    case "B": return q.option_b;
    case "C": return q.option_c;
    case "D": return q.option_d;
  }
}

// Fetch the N weakest (lowest stability) memory items for a user, joined with
// the source question. Distractor options (A/B/C/D) are dropped before this
// function returns — they MUST NOT enter the LLM context. If the user has
// fewer than N tracked questions, returns whatever exists.
export async function getWeakestMemoryItems(
  supabase: RepoSupabaseClient,
  userId: string,
  limit = 5,
): Promise<WeakItem[]> {
  // Cast: user_memory_states not yet in database.types.ts.
  const { data, error } = await (supabase as any)
    .from("user_memory_states")
    .select(
      `stability, last_reviewed_at,
       questions!inner (
         id, content, option_a, option_b, option_c, option_d,
         correct_option, explanation
       )`,
    )
    .eq("user_id", userId)
    .order("stability", { ascending: true })
    .order("last_reviewed_at", { ascending: true })
    .limit(limit);

  if (error || !data) return [];

  const now = new Date();
  return (data as Array<{ stability: number; last_reviewed_at: string; questions: QuestionRow }>).map((row) => ({
    question_id: row.questions.id,
    stem: row.questions.content,
    correct_answer: pickCorrectAnswer(row.questions),
    explanation: row.questions.explanation,
    stability: row.stability,
    heat: heat(row.stability, row.last_reviewed_at, now),
    last_reviewed_at: row.last_reviewed_at,
  }));
}

// A single curated sibling question used as DB-RAG context for a weak item.
// Same shape as WeakItem minus the memory metadata — the script generator
// only needs the educational substance.
export type SiblingQuestion = {
  id: string;
  stem: string;
  correct_answer: string;
  explanation: string | null;
};

// Grounding pack for one weak question: the related questions from its
// topic that the LLM is allowed to cite for cross-topic links. Anything
// outside this pack must NOT be invented from training memory.
export type GroundingContextItem = {
  question_id: string;
  siblings: SiblingQuestion[];
};

// For each weak question, fetch up to `perQuestion` sibling questions from
// the same topic (excluding the weak question itself and unverified items).
// Used as DB-RAG context for cross-topic link generation: the script prompt
// constrains the LLM to only cite connections present in this pack.
//
// Queries one weak question at a time in parallel — at typical batch size
// (≤8 weak items), this is faster and simpler than a single batched join,
// and keeps the topic-id resolution and sibling fetch logically separated.
export async function getSiblingQuestionsForGrounding(
  supabase: RepoSupabaseClient,
  questionIds: string[],
  perQuestion = 4,
): Promise<GroundingContextItem[]> {
  if (questionIds.length === 0) return [];

  const fetchOne = async (qid: string): Promise<GroundingContextItem> => {
    // Resolve this question's topic via the question_sets join.
    const { data: q } = await (supabase as any)
      .from("questions")
      .select(`question_sets!inner(topic_id)`)
      .eq("id", qid)
      .maybeSingle();
    const topicId: string | undefined = q?.question_sets?.topic_id;
    if (!topicId) return { question_id: qid, siblings: [] };

    // Fetch siblings on the same topic. Prefer verified questions for
    // grounding quality, but fall back to ALL questions on the topic if no
    // verified content exists yet — better to ground on unverified curated
    // material than to skip the cross-topic link entirely. The grounding
    // gate only narrows what the LLM may cite; it doesn't validate truth.
    // Pull 3× perQuestion so we have room to shuffle for episode variety.
    const baseQuery = () =>
      (supabase as any)
        .from("questions")
        .select(
          `id, content, option_a, option_b, option_c, option_d, correct_option,
           explanation, question_sets!inner(topic_id)`,
        )
        .eq("question_sets.topic_id", topicId)
        .neq("id", qid)
        .limit(perQuestion * 3);

    const { data: verifiedRows } = await baseQuery().eq("is_verified", true);
    let rows: Array<QuestionRow> | null = (verifiedRows as Array<QuestionRow>) ?? null;
    let source: "verified" | "unverified-fallback" = "verified";
    if (!rows || rows.length === 0) {
      const { data: anyRows } = await baseQuery();
      rows = (anyRows as Array<QuestionRow>) ?? null;
      source = "unverified-fallback";
    }
    if (!rows || rows.length === 0) return { question_id: qid, siblings: [] };

    const pool: SiblingQuestion[] = rows.map((r) => ({
      id: r.id,
      stem: r.content,
      correct_answer: pickCorrectAnswer(r),
      explanation: r.explanation,
    }));
    // Shuffle so the same weak question doesn't always pull the same
    // siblings across weeks. Stable across one episode.
    const shuffled = pool.slice().sort(() => Math.random() - 0.5);
    if (source === "unverified-fallback") {
      // Quiet info, not warning — common in pre-verification environments.
      // In production with curated verified content the verified pool is
      // primary and this branch never fires.
      // eslint-disable-next-line no-console
      console.info(
        `[manana grounding] used unverified-fallback for ${qid} (no verified siblings on topic ${topicId})`,
      );
    }
    return { question_id: qid, siblings: shuffled.slice(0, perQuestion) };
  };

  return Promise.all(questionIds.map(fetchOne));
}

export type MemoryHeatBucket = "hot" | "warm" | "cold";

export function bucketHeat(h: number): MemoryHeatBucket {
  if (h >= 0.7) return "hot";
  if (h >= 0.4) return "warm";
  return "cold";
}

// Short factual summary the LLM uses to colour the intro/outro. Counts come
// from the full memory state, not just the weakest 5 — so the model can talk
// about overall standing, not just this week's revision items.
export async function getMemoryHeatSummary(
  supabase: RepoSupabaseClient,
  userId: string,
): Promise<{ total: number; hot: number; warm: number; cold: number; text: string }> {
  const { data, error } = await (supabase as any)
    .from("user_memory_states")
    .select("stability, last_reviewed_at")
    .eq("user_id", userId);

  if (error || !data) {
    return { total: 0, hot: 0, warm: 0, cold: 0, text: "no tracked memory yet" };
  }

  const now = new Date();
  let hot = 0, warm = 0, cold = 0;
  for (const r of data as Array<{ stability: number; last_reviewed_at: string }>) {
    const b = bucketHeat(heat(r.stability, r.last_reviewed_at, now));
    if (b === "hot") hot++;
    else if (b === "warm") warm++;
    else cold++;
  }
  const total = data.length;
  return {
    total,
    hot,
    warm,
    cold,
    text: `${total} questions tracked: ${hot} hot, ${warm} warm, ${cold} cold`,
  };
}
