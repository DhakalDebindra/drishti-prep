import { notFound, redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { ScoreOverview } from "@/components/practice/ScoreOverview";
import { AIFeedbackPanel } from "@/components/practice/AIFeedbackPanel";
import { QuestionReviewList, ReviewQuestion } from "@/components/practice/QuestionReviewList";
import { Suspense } from "react";
import Link from "next/link";
import { ChevronLeft } from "lucide-react";

type PageProps = {
  params: Promise<{
    setId: string;
  }>;
  searchParams: Promise<{ [key: string]: string | string[] | undefined }>;
};

export default async function ReviewPage({ params, searchParams }: PageProps) {
  const supabase = await createClient();
  const resolvedSearchParams = await searchParams;
  const attemptId = resolvedSearchParams.attemptId as string;

  if (!attemptId) {
    redirect("/dashboard");
  }

  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (!user) {
    redirect("/login");
  }

  // Fetch Attempt
  const { data: attempt, error: attemptError } = await supabase
    .from("attempts")
    .select("*")
    .eq("id", attemptId)
    .single();

  if (attemptError || !attempt || attempt.user_id !== user.id) {
    notFound();
  }

  if (attempt.status !== "submitted") {
    // If somehow they get here without submitting, push them back to the set
    const resolvedParams = await params;
    redirect(`/practice/${resolvedParams.setId}`);
  }

  // Fetch Questions and Answers
  const { data: qsqResponse } = await supabase
    .from("question_set_questions")
    .select("position, questions(id, content, option_a, option_b, option_c, option_d, correct_option, explanation, order_number)")
    .eq("question_set_id", attempt.set_id)
    .order("position", { ascending: true });

  const questions = qsqResponse?.map((row: any) => row.questions) || [];
  const questionIds = questions.map((q: any) => q.id);

  const [{ data: answers }, { data: bookmarks }] = await Promise.all([
    supabase
      .from("attempt_answers")
      .select("question_id, selected_option, is_correct")
      .eq("attempt_id", attemptId),
    questionIds.length > 0
      ? supabase
          .from("bookmarks")
          .select("question_id")
          .eq("user_id", user.id)
          .in("question_id", questionIds)
      : Promise.resolve({ data: [] }),
  ]);

  const bookmarkedQuestionIds = bookmarks?.map((b) => b.question_id) || [];

  const reviewQuestions: ReviewQuestion[] = (questions || []).map((q) => {
    const match = answers?.find((a) => a.question_id === q.id);
    return {
      id: q.id,
      content: q.content,
      option_a: q.option_a,
      option_b: q.option_b,
      option_c: q.option_c,
      option_d: q.option_d,
      correct_option: q.correct_option,
      selected_option: match?.selected_option ?? null,
      is_correct: match?.is_correct ?? false,
      explanation: q.explanation,
    };
  });

  const totalQuestions = attempt.question_count || questions?.length || 0;

  return (
    <div className="max-w-5xl mx-auto px-4 py-8 space-y-8">
      <div className="flex items-center justify-between">
        <h1 id="main-heading" className="text-2xl font-bold text-slate-900 dark:text-white">Performance Review</h1>
      </div>

      <ScoreOverview
        scoreRaw={attempt.score_raw ?? 0}
        scorePct={attempt.score_pct ?? 0}
        totalQuestions={totalQuestions}
        submittedAt={attempt.submitted_at}
      />

      <Suspense fallback={
        <div className="bg-slate-50 dark:bg-slate-900 border border-slate-200 dark:border-slate-800 rounded-2xl p-6 h-48 animate-pulse flex items-center justify-center">
           <p className="text-slate-500">Preparing AI insights...</p>
        </div>
      }>
        <AIFeedbackPanel attemptId={attemptId} />
      </Suspense>

      <QuestionReviewList 
        questions={reviewQuestions} 
        initialBookmarkedIds={bookmarkedQuestionIds} 
      />
    </div>
  );
}
