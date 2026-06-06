import type { RepoSupabaseClient } from "@repo/supabase";
import { heat } from "./memory";
import type { ColdTopic } from "@/components/dashboard/MemoryHeatWidget";

const COLD_TOPIC_MIN_QUESTIONS = 2;
const COLD_TOPIC_COUNT = 3;

type Row = {
  stability: number;
  last_reviewed_at: string;
  questions: {
    question_sets: {
      topic_id: string;
      topics: {
        id: string;
        name: string;
        slug: string | null;
        subject: {
          slug: string | null;
          module: { slug: string | null } | null;
        } | null;
      } | null;
    } | null;
  } | null;
};

export async function fetchMemoryHeat(
  supabase: RepoSupabaseClient,
  userId: string,
): Promise<{ overallHeat: number; totalQuestions: number; coldestTopics: ColdTopic[] }> {
  // Cast to any: user_memory_states is in the migration but not yet in
  // packages/supabase/src/database.types.ts. Regenerate types to remove this.
  const { data, error } = await (supabase as any)
    .from("user_memory_states")
    .select(
      `stability, last_reviewed_at,
       questions!inner (
         question_sets!inner (
           topic_id,
           topics!inner (
             id, name, slug,
             subject:subjects!inner (
               slug,
               module:modules!inner ( slug )
             )
           )
         )
       )`,
    )
    .eq("user_id", userId);

  if (error || !data) {
    return { overallHeat: 0, totalQuestions: 0, coldestTopics: [] };
  }

  const rows = data as unknown as Row[];
  const now = new Date();
  let heatSum = 0;

  const byTopic = new Map<
    string,
    {
      name: string;
      slug: string | null;
      subjectSlug: string | null;
      moduleSlug: string | null;
      sum: number;
      count: number;
    }
  >();

  for (const r of rows) {
    const h = heat(r.stability, r.last_reviewed_at, now);
    heatSum += h;
    const topic = r.questions?.question_sets?.topics;
    if (!topic) continue;
    const subjectSlug = topic.subject?.slug ?? null;
    const moduleSlug = topic.subject?.module?.slug ?? null;
    const existing = byTopic.get(topic.id);
    if (existing) {
      existing.sum += h;
      existing.count += 1;
    } else {
      byTopic.set(topic.id, {
        name: topic.name,
        slug: topic.slug,
        subjectSlug,
        moduleSlug,
        sum: h,
        count: 1,
      });
    }
  }

  const totalQuestions = rows.length;
  const overallHeat = totalQuestions > 0 ? Math.round((heatSum / totalQuestions) * 100) : 0;

  const coldestTopics: ColdTopic[] = Array.from(byTopic.entries())
    .filter(([, v]) => v.count >= COLD_TOPIC_MIN_QUESTIONS)
    .map(([topicId, v]) => ({
      topicId,
      name: v.name,
      slug: v.slug,
      subjectSlug: v.subjectSlug,
      moduleSlug: v.moduleSlug,
      avgHeat: v.sum / v.count,
      questionCount: v.count,
    }))
    .sort((a, b) => a.avgHeat - b.avgHeat)
    .slice(0, COLD_TOPIC_COUNT);

  return { overallHeat, totalQuestions, coldestTopics };
}
