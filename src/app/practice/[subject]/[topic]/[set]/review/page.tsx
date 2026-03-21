"use client";

import { use, useEffect, useState, Suspense } from "react";
import { useRouter, useSearchParams } from "next/navigation";
import Link from "next/link";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { createClient } from "@/lib/supabase/client";
import type { PracticeReview } from "../PracticeSetClient";

function LoadingSpinner() {
  return (
    <div className="flex w-full items-center justify-center p-12">
      <div className="h-8 w-8 animate-spin rounded-full border-b-2 border-t-2 border-blue-600"></div>
    </div>
  );
}

function ReviewContent({ subject, topic, set }: { subject: string; topic: string; set: string }) {
  const router = useRouter();
  const searchParams = useSearchParams();
  const attemptId = searchParams.get("attemptId");

  const [review, setReview] = useState<PracticeReview | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    async function loadData() {
      try {
        if (attemptId) {
          const supabase = createClient();
          const { data: attempt, error: attemptErr } = await supabase
            .from("attempts")
            .select("id, question_count, score_raw, score_pct, submitted_at, set_id")
            .eq("id", attemptId)
            .maybeSingle();

          if (attemptErr || !attempt) throw new Error("Attempt not found");

          const { data: answers, error: answersErr } = await supabase
            .from("attempt_answers")
            .select("question_id, selected_option, is_correct")
            .eq("attempt_id", attemptId);

          if (answersErr) throw new Error("Failed to load answers");

          const { data: feedback } = await supabase
            .from("ai_feedback")
            .select("strengths, weak_zones, explanations, model, latency_ms, cost_cents")
            .eq("attempt_id", attemptId)
            .maybeSingle();

          const { data: questions, error: qErr } = await supabase
            .from("questions")
            .select("id, content, option_a, option_b, option_c, option_d, correct_option, explanation")
            .eq("set_id", attempt.set_id);

          if (qErr) throw new Error("Failed to load questions");

          const decoratedAnswers = (questions ?? []).map((q) => {
            const match = answers?.find((a) => a.question_id === q.id);
            return {
              question_id: q.id,
              content: q.content,
              option_a: q.option_a,
              option_b: q.option_b,
              option_c: q.option_c,
              option_d: q.option_d,
              selected_option: match?.selected_option ?? null,
              is_correct: match?.is_correct ?? false,
              correct_option: q.correct_option,
              explanation: q.explanation ?? null,
            };
          });

          setReview({
            attempt: attempt as any,
            answers: decoratedAnswers,
            feedback: feedback ?? null,
          });
        } else {
          // Guest data
          const stored = sessionStorage.getItem("demoReviewData");
          if (stored) {
            setReview(JSON.parse(stored));
          } else {
            // Redirect back if no data
            router.replace(`/practice/${subject}/${topic}/${set}`);
            return;
          }
        }
      } catch (err: any) {
        setError(err.message || "An error occurred");
      } finally {
        setLoading(false);
      }
    }
    loadData();
  }, [attemptId, router, subject, topic, set]);

  if (loading) return <LoadingSpinner />;

  if (error) {
    return (
      <div className="p-6 flex flex-col items-center justify-center text-red-600">
        <p className="mb-4">{error}</p>
        <Button onClick={() => router.push(`/practice/${subject}/${topic}/${set}`)} variant="outline">
          Go Back
        </Button>
      </div>
    );
  }

  if (!review) return null;

  const isQuotaError = review.feedback?.strengths?.toLowerCase().includes("quota") || review.feedback?.strengths?.includes("429");
  const hasStrengths = review.feedback?.strengths && review.feedback.strengths.trim().length > 0 && !isQuotaError;
  const hasWeakZones = review.feedback?.weak_zones && Object.keys(review.feedback.weak_zones).length > 0 && !isQuotaError;

  return (
    <section className="space-y-6">
      <div className="flex items-center gap-2 text-sm text-gray-500" aria-label="Breadcrumb">
        <Link href="/practice" className="text-blue-700 hover:text-blue-900">
          Practice
        </Link>
        <span aria-hidden="true">/</span>
        <Link href={`/practice/${decodeURIComponent(subject)}`} className="text-blue-700 hover:text-blue-900">
          {decodeURIComponent(subject)}
        </Link>
        <span aria-hidden="true">/</span>
        <Link
          href={`/practice/${decodeURIComponent(subject)}/${decodeURIComponent(topic)}`}
          className="text-blue-700 hover:text-blue-900"
        >
          {decodeURIComponent(topic)}
        </Link>
        <span aria-hidden="true">/</span>
        <Link
          href={`/practice/${decodeURIComponent(subject)}/${decodeURIComponent(topic)}/${decodeURIComponent(set)}`}
          className="text-blue-700 hover:text-blue-900"
        >
          Quiz
        </Link>
        <span aria-hidden="true">/</span>
        <span className="text-gray-700" aria-current="page">
          Review
        </span>
      </div>

      <header className="space-y-2">
        <h1 className="text-2xl font-semibold text-gray-900">Quiz Review</h1>
        <p className="text-gray-600">Review your performance and read AI-generated feedback.</p>
      </header>

      <Card className="border-emerald-200">
        <CardHeader>
          <CardTitle className="text-xl">Performance Summary</CardTitle>
        </CardHeader>
        <CardContent className="space-y-6">
          <div className="flex items-center gap-4">
            <div className="flex h-16 w-16 items-center justify-center rounded-full bg-emerald-100 text-xl font-bold text-emerald-800">
              {review.attempt.score_pct.toFixed(0)}%
            </div>
            <div>
              <p className="text-lg font-medium text-gray-900">
                Score: {review.attempt.score_raw} / {review.attempt.question_count}
              </p>
              {review.attempt.submitted_at && (
                <p className="text-sm text-gray-500">
                  Submitted on {new Date(review.attempt.submitted_at).toLocaleDateString()}
                </p>
              )}
            </div>
          </div>

          {isQuotaError && (
            <div className="rounded-lg bg-yellow-50 p-4">
              <h3 className="mb-2 font-semibold text-yellow-900">AI Analysis Unavailable</h3>
              <p className="text-yellow-800">Detailed feedback cannot be generated at this time due to system API limits. Please try again later.</p>
            </div>
          )}

          {hasStrengths && (
            <div className="rounded-lg bg-blue-50 p-4">
              <h3 className="mb-2 font-semibold text-blue-900">Strengths</h3>
              <p className="text-blue-800">{review.feedback!.strengths}</p>
            </div>
          )}

          {hasWeakZones && (
            <div className="rounded-lg bg-orange-50 p-4">
              <h3 className="mb-2 font-semibold text-orange-900">Areas for Improvement</h3>
              <ul className="list-inside list-disc text-orange-800">
                {Array.isArray(review.feedback!.weak_zones)
                  ? review.feedback!.weak_zones.map((zone: any, i: number) => <li key={i}>{zone}</li>)
                  : typeof review.feedback!.weak_zones === "object" && review.feedback!.weak_zones !== null
                  ? Object.entries(review.feedback!.weak_zones).map(([k, v]) => (
                      <li key={k}>
                        <strong>{k}</strong>: {String(v)}
                      </li>
                    ))
                  : (
                    <li className="whitespace-pre-wrap">{JSON.stringify(review.feedback!.weak_zones, null, 2)}</li>
                  )}
              </ul>
            </div>
          )}
        </CardContent>
      </Card>

      <div className="space-y-4">
        <h2 className="text-xl font-semibold text-gray-900">Detailed Review</h2>
        {review.answers.map((answer, index) => {
          const isCorrect = answer.is_correct;
          const userVal = answer.selected_option ? answer[("option_" + answer.selected_option.toLowerCase()) as keyof typeof answer] : "Not answered";
          const correctVal = answer[("option_" + answer.correct_option.toLowerCase()) as keyof typeof answer];

          return (
            <Card key={answer.question_id} className={isCorrect ? "border-emerald-100" : "border-red-100"}>
              <CardContent className="pt-6">
                <div className="mb-4 flex items-center gap-2">
                  <span
                    className={`inline-flex items-center rounded-full px-2.5 py-0.5 text-xs font-semibold ${
                      isCorrect ? "bg-emerald-100 text-emerald-800" : "bg-red-100 text-red-800"
                    }`}
                  >
                    Q{index + 1}
                  </span>
                  <span className={`text-sm font-medium ${isCorrect ? "text-emerald-600" : "text-red-600"}`}>
                    {isCorrect ? "Correct" : "Incorrect"}
                  </span>
                </div>

                <p className="mb-4 text-base font-medium text-gray-900">{answer.content}</p>

                <div className="grid gap-4 md:grid-cols-2">
                  <div>
                    <p className="text-sm font-medium text-gray-500">Your Answer</p>
                    <p className={`mt-1 font-semibold ${isCorrect ? "text-emerald-700" : "text-red-700"}`}>
                      {answer.selected_option ? `Option ${answer.selected_option}: ${userVal}` : "Not answered"}
                    </p>
                  </div>
                  <div>
                    <p className="text-sm font-medium text-gray-500">Correct Answer</p>
                    <p className="mt-1 font-semibold text-gray-900">Option {answer.correct_option}: {correctVal}</p>
                  </div>
                </div>
              </CardContent>
            </Card>
          );
        })}
      </div>

      <div className="flex justify-center pt-6">
        <Button
          onClick={() => {
            window.location.href = `/practice/${subject}/${topic}/${set}`;
          }}
          variant="outline"
          className="w-full sm:w-auto"
        >
          Practice Again
        </Button>
      </div>
    </section>
  );
}

export default function ReviewPage({ params }: { params: Promise<{ subject: string; topic: string; set: string }> }) {
  const { subject, topic, set } = use(params);

  return (
    <Suspense fallback={<LoadingSpinner />}>
      <ReviewContent subject={subject} topic={topic} set={set} />
    </Suspense>
  );
}
