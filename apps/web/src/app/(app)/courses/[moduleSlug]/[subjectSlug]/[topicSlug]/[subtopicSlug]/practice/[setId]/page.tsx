import { notFound } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import PracticeSetClient from "@/components/practice/PracticeSetClient";
import type { DecoratedAnswer } from "@repo/types";

interface PageProps {
  params: Promise<{ 
    moduleSlug: string; 
    subjectSlug: string; 
    topicSlug: string; 
    subtopicSlug: string;
    setId: string;
  }>;
}

export default async function SubtopicPracticeSetPage({ params }: PageProps) {
  const { setId, moduleSlug, subjectSlug, topicSlug, subtopicSlug } = await params;
  const supabase = await createClient();
  const { data: auth } = await supabase.auth.getUser();
  const user = auth?.user ?? null;

  const [{ data: setRow }, { data: qsqResponse }] = await Promise.all([
    supabase
      .from("question_sets")
      .select(`
        id, title, difficulty_level, is_verified, version, topic_id, 
        topics(id, name, slug, subjects(id, name, slug, modules(slug))),
        subtopics(id, name, name_np, slug)
      `)
      .eq("id", setId)
      .maybeSingle(),
    supabase
      .from("question_set_questions")
      .select(`
        position, 
        questions!inner(
          id, content, option_a, option_b, option_c, option_d, 
          correct_option, explanation, order_number, status
        )
      `)
      .eq("question_set_id", setId)
      .or("status.neq.deprecated,status.is.null", { foreignTable: "questions" })
      .order("position", { ascending: true }),
  ]);

  if (!setRow) {
    notFound();
  }

  const questions = qsqResponse?.map((row: any) => row.questions) || [];

  // Normalize joined data
  const rawTopic = setRow.topics;
  const topicRow = Array.isArray(rawTopic) ? rawTopic[0] : rawTopic;

  if (!topicRow) {
    notFound();
  }

  const subjectRow = topicRow.subjects 
    ? (Array.isArray(topicRow.subjects) ? topicRow.subjects[0] : topicRow.subjects)
    : null;
  const moduleRow = subjectRow?.modules 
    ? (Array.isArray(subjectRow.modules) ? subjectRow.modules[0] : subjectRow.modules)
    : null;
  
  const rawSubtopic = setRow.subtopics;
  const subtopicRow = Array.isArray(rawSubtopic) ? rawSubtopic[0] : rawSubtopic;

  // Consistency check
  if (topicRow?.slug !== topicSlug || subjectRow?.slug !== subjectSlug || moduleRow?.slug !== moduleSlug || subtopicRow?.slug !== subtopicSlug) {
    console.warn(`Routing mismatch for setId: ${setId}. URL says ${moduleSlug}/${subjectSlug}/${topicSlug}/${subtopicSlug}, DB says ${moduleRow?.slug}/${subjectRow?.slug}/${topicRow?.slug}/${subtopicRow?.slug}`);
  }

  const { data: recentAttempt } = user
    ? await supabase
        .from("attempts")
        .select("id, status, question_count, score_raw, score_pct, set_version, submitted_at")
        .eq("set_id", setId)
        .eq("user_id", user.id)
        .order("started_at", { ascending: false })
        .limit(1)
        .maybeSingle()
    : { data: null } as { data: any };

  const attempt = recentAttempt?.status === "in_progress" ? recentAttempt : null;

  const { data: existingAnswers } = attempt
    ? await supabase
        .from("attempt_answers")
        .select("question_id, selected_option, is_correct")
        .eq("attempt_id", attempt.id)
    : { data: [] } as { data: { question_id: string; selected_option: string; is_correct: boolean }[] };

  const decorated: DecoratedAnswer[] = (questions ?? []).map((q) => {
    const existing = existingAnswers?.find((a) => a.question_id === q.id);
    return {
      question_id: q.id,
      selected_option: existing?.selected_option ?? null,
      is_correct: existing?.is_correct ?? false,
      correct_option: q.correct_option,
      explanation: q.explanation ?? null,
    };
  });

  return (
    <PracticeSetClient
      setInfo={{
        id: setRow.id,
        title: setRow.title,
        difficulty_level: setRow.difficulty_level,
        version: setRow.version ?? 1,
        topicId: topicRow.id,
        topicName: topicRow.name,
        topicSlug: topicSlug,
        subjectId: subjectRow?.id || "",
        subjectName: subjectRow?.name || "",
        subjectSlug: subjectSlug,
        moduleSlug: moduleSlug,
        is_verified: setRow.is_verified,
        subtopicName: subtopicRow?.name_np || subtopicRow?.name || null,
        subtopicSlug: subtopicSlug,
      } as any}
      questions={questions ?? []}
      existingAttempt={attempt}
      existingAnswers={decorated}
      initialReview={null}
      userEmail={user?.email ?? null}
    />
  );
}
