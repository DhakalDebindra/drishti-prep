import { notFound, redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { ScoreOverview } from "@/components/practice/ScoreOverview";
import { AIFeedbackPanel } from "@/components/practice/AIFeedbackPanel";
import { QuestionReviewList, ReviewQuestion } from "@/components/practice/QuestionReviewList";
import { PracticeAccessibilityMenu } from "@/components/practice/AccessibilityMenu";
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
  const skippedCount = reviewQuestions.filter(
    (q) => q.selected_option === null || q.selected_option === "skipped"
  ).length;

  return (
    <div className="mx-auto flex max-w-[var(--dp-shell-width)] flex-col gap-8 px-4 py-6 sm:px-6 sm:py-8 lg:px-8">
      <div className="rounded-3xl border border-white/70 bg-white/85 p-6 shadow-[0_20px_60px_rgba(15,23,42,0.08)] backdrop-blur-xl dark:border-slate-800 dark:bg-slate-950/70 md:p-8">
        <div className="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
          <div>
            <p className="text-xs font-semibold uppercase tracking-[0.24em] text-slate-500 dark:text-slate-400">
              Practice review
            </p>
            <h1 id="main-heading" className="mt-1 text-3xl font-bold tracking-tight text-slate-950 dark:text-white">
              Performance Review
            </h1>
            <p className="mt-2 max-w-2xl text-sm leading-relaxed text-slate-600 dark:text-slate-300">
              A clearer look at how this session went — score, AI insights, and a question-by-question breakdown.
            </p>
          </div>
          <div className="flex flex-wrap gap-3">
            <PracticeAccessibilityMenu buttonMode="label" />
            <Link
              href="/practice/dashboard"
              className="inline-flex items-center gap-2 rounded-full border border-slate-200 bg-white px-4 py-2 text-sm font-semibold text-slate-700 transition hover:bg-slate-50 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring dark:border-slate-700 dark:bg-slate-900 dark:text-slate-200 dark:hover:bg-slate-800"
            >
              <ChevronLeft className="h-4 w-4" aria-hidden="true" />
              Back to practice
            </Link>
          </div>
        </div>
      </div>

      <ScoreOverview
        scoreRaw={attempt.score_raw ?? 0}
        scorePct={attempt.score_pct ?? 0}
        totalQuestions={totalQuestions}
        skippedCount={skippedCount}
        submittedAt={attempt.submitted_at}
      />

      <AIFeedbackPanel attemptId={attemptId} />

      <QuestionReviewList 
        questions={reviewQuestions} 
        initialBookmarkedIds={bookmarkedQuestionIds} 
      />
    </div>
  );
}
