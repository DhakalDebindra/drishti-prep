import { useState } from "react";
import { useRouter } from "next/navigation";
import type { Question, PracticeReview } from "@/types/practice";

type SubmissionProps = {
  status: string;
  answeredCount: number;
  questionCount: number;
  userEmail: string | null;
  questions: Question[];
  answers: Record<string, string | null>;
  correctness: Record<string, boolean>;
  setInfo: {
    id: string;
    subjectName: string;
    topicName: string;
    [key: string]: any;
  };
  attemptId: string | null;
  ensureAttempt: () => Promise<string | undefined>;
  setError: (error: string | null) => void;
  setStatus: (status: string) => void;
  setAuthRequired: (req: boolean) => void;
};

export function usePracticeSet({
  status,
  answeredCount,
  questionCount,
  userEmail,
  questions,
  answers,
  correctness,
  setInfo,
  attemptId,
  ensureAttempt,
  setError,
  setStatus,
  setAuthRequired,
}: SubmissionProps) {
  const router = useRouter();
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [showConfirmDialog, setShowConfirmDialog] = useState(false);

  const submitPracticeSet = async (skippedFinalQuestionId?: string) => {
    if (status === "submitted") return;

    if (answeredCount === 0 && !skippedFinalQuestionId) {
      setError("You must attempt at least one question to generate a feedback summary.");
      return;
    }

    setIsSubmitting(true);
    setShowConfirmDialog(false); // Close dialog when submitting starts

    // Guest submission flow
    if (!userEmail) {
      setError(null);

      const payloadAnswers = questions.filter(q => answers[q.id] || q.id === skippedFinalQuestionId).map((q) => {
        const isSkippedFinal = q.id === skippedFinalQuestionId;
        return {
          question_id: q.id,
          content: q.content,
          option_a: q.option_a,
          option_b: q.option_b,
          option_c: q.option_c,
          option_d: q.option_d,
          selected_option: isSkippedFinal ? "skipped" : answers[q.id],
          correct_option: q.correct_option,
          is_correct: isSkippedFinal ? false : (correctness[q.id] || false),
          explanation: q.explanation
        };
      });

      try {
        const scoreRaw = Object.values(correctness).filter(Boolean).length;
        const scorePct = questionCount > 0 ? (scoreRaw / questionCount) * 100 : 0;

        const res = await fetch("/api/guest-feedback", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            answers: payloadAnswers,
            scoreRaw,
            totalQuestions: questionCount,
            scorePct,
          }),
        });

        if (!res.ok) {
          throw new Error("Failed to fetch guest feedback");
        }

        const data = await res.json();

        const mockReview: PracticeReview = {
          attempt: {
            id: "guest-attempt",
            question_count: questionCount,
            score_raw: scoreRaw,
            score_pct: scorePct,
          },
          answers: payloadAnswers.map(a => ({
            ...a,
            explanation: data.explanations?.[a.question_id] || null,
            selected_option: a.selected_option || null,
            content: a.content,
            option_a: a.option_a,
            option_b: a.option_b,
            option_c: a.option_c,
            option_d: a.option_d
          })),
          feedback: {
            strengths: data.strengths || null,
            weak_zones: data.weakZones || null,
            explanations: data.explanations || null,
          }
        };

        sessionStorage.setItem('demoReviewData', JSON.stringify(mockReview));
        setStatus("submitted");
        router.push(`/practice/${setInfo.subjectName}/${setInfo.topicName}/${setInfo.id}/review`);
      } catch (err: any) {
        console.warn("DEMO MODE ERROR:", err.message);
        const mockReview: PracticeReview = {
          attempt: {
            id: "guest-attempt-fallback",
            question_count: questionCount,
            score_raw: Object.values(correctness).filter(Boolean).length,
            score_pct: questionCount > 0 ? (Object.values(correctness).filter(Boolean).length / questionCount) * 100 : 0,
          },
          answers: payloadAnswers.map(a => ({
            ...a,
            explanation: null,
            selected_option: a.selected_option || null,
            content: a.content,
            option_a: a.option_a,
            option_b: a.option_b,
            option_c: a.option_c,
            option_d: a.option_d
          })),
          feedback: null
        };
        sessionStorage.setItem('demoReviewData', JSON.stringify(mockReview));
        setStatus("submitted");
        router.push(`/practice/${setInfo.subjectName}/${setInfo.topicName}/${setInfo.id}/review`);
        return;
      }
      return;
    }

    // Authenticated flow
    let idToSubmit = attemptId;
    if (!idToSubmit) {
      try {
        idToSubmit = await ensureAttempt() || null;
      } catch (err: any) {
        setError(err.message || "Unable to start attempt");
        setIsSubmitting(false); // Stop loader if starting attempt fails
        return;
      }
    }

    if (!idToSubmit) {
      setIsSubmitting(false);
      return;
    }

    setError(null);
    try {
      const res = await fetch(`/api/attempts/${idToSubmit}/submit`, { method: "POST" });
      const data = await res.json().catch(() => ({}));
      
      if (res.status === 401) {
        setAuthRequired(true);
        throw new Error("Please log in to submit.");
      }
      if (!res.ok) {
        throw new Error(data.error || "Submit failed");
      }
      setStatus("submitted");
      router.push(`/practice/${setInfo.subjectName}/${setInfo.topicName}/${setInfo.id}/review?attemptId=${idToSubmit}`);
    } catch (err: any) {
      setIsSubmitting(false);
      setError(err.message || "Submit failed");
    }
  };

  return { isSubmitting, setIsSubmitting, showConfirmDialog, setShowConfirmDialog, submitPracticeSet };
}
