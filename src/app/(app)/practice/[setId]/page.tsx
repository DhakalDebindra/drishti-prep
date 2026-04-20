import Link from "next/link";
import { notFound } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import PracticeSetClient from "./PracticeSetClient";
import type { DecoratedAnswer, PracticeReview } from "@/types/practice";

interface PageProps {
  params: Promise<{ setId: string }>;
}

export default async function PracticeSetPage({ params }: PageProps) {
  const { setId } = await params;
  const supabase = await createClient();
  const { data: auth } = await supabase.auth.getUser();
  const user = auth?.user ?? null;

  const [{ data: setRow }, { data: qsqResponse }] = await Promise.all([
    supabase
      .from("question_sets")
      .select("id, title, difficulty_level, is_verified, version, topic_id, topics!inner(id, name, slug, subjects!inner(id, name, slug, modules!inner(slug)))")
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

  const questions = qsqResponse?.map((row: any) => row.questions) || [];

  if (!setRow || !setRow.topics || !setRow.topics.subjects) {
    notFound();
  }

  const topicRow = setRow.topics;
  const subjectRow = Array.isArray(topicRow.subjects) ? topicRow.subjects[0] : topicRow.subjects;
  const moduleRow = subjectRow ? (Array.isArray(subjectRow.modules) ? subjectRow.modules[0] : subjectRow.modules) : null;

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
        topicSlug: topicRow.slug,
        subjectId: subjectRow?.id || "",
        subjectName: subjectRow?.name || "",
        subjectSlug: subjectRow?.slug || "",
        moduleSlug: moduleRow?.slug || "",
        is_verified: setRow.is_verified,
      }}
      questions={questions ?? []}
      existingAttempt={attempt}
      existingAnswers={decorated}
      initialReview={null}
      userEmail={user?.email ?? null}
    />
  );
}

