import Link from "next/link";
import { notFound } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import PracticeSetClient, { DecoratedAnswer, PracticeReview } from "./PracticeSetClient";

interface PageProps {
  params: Promise<{ subject: string; topic: string; set: string }>;
}

export default async function PracticeSetPage({ params }: PageProps) {
  const { subject, topic, set } = await params;
  const supabase = await createClient();
  const { data: auth } = await supabase.auth.getUser();
  const user = auth?.user ?? null;

  const subjectName = decodeURIComponent(subject);
  const topicName = decodeURIComponent(topic);
  const setId = decodeURIComponent(set);

  const [{ data: subjectRow }, { data: topicRow }, { data: setRow }, { data: questions }] = await Promise.all([
    supabase.from("subjects").select("id, name").eq("name", subjectName).maybeSingle(),
    supabase.from("topics").select("id, name, subject_id").eq("name", topicName).maybeSingle(),
    supabase
      .from("question_sets")
      .select("id, title, difficulty_level, is_verified, version, topic_id")
      .eq("id", setId)
      .maybeSingle(),
    supabase
      .from("questions")
      .select("id, content, option_a, option_b, option_c, option_d, correct_option, explanation, order_number")
      .eq("set_id", setId)
      .order("order_number", { ascending: true }),
  ]);

  if (!subjectRow || !topicRow || !setRow) {
    notFound();
  }

  if (topicRow.subject_id !== subjectRow.id || setRow.topic_id !== topicRow.id) {
    notFound();
  }

  const { data: activeAttempt } = user
    ? await supabase
        .from("attempts")
        .select("id, status, question_count, score_raw, score_pct, set_version, submitted_at")
        .eq("set_id", setId)
        .eq("user_id", user.id)
        .eq("status", "in_progress")
        .order("started_at", { ascending: false })
        .limit(1)
        .maybeSingle()
    : { data: null } as { data: any };

  const attempt = activeAttempt ?? null;

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
        subjectId: subjectRow.id,
        subjectName: subjectRow.name,
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
