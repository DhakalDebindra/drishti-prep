"use client";

import { useMemo, useCallback } from "react";
import Link from "next/link";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Lang } from "@/components/ui/Lang";
import { QuestionNavigator } from "@/components/practice/QuestionNavigator";
import { SubmitLoader } from "@/components/practice/SubmitLoader";
import { ConfirmSubmitDialog } from "@/components/practice/ConfirmSubmitDialog";
import { AttemptProvider, useAttemptStore } from "@/features/practice/store/attempt-store";
import type {
  AttemptSummary,
  DecoratedAnswer,
  PracticeReview,
  Question,
} from "@repo/types";
import { QuestionOptions, optionKeys } from "@/components/practice/QuestionOptions";

type Props = {
  setInfo: {
    id: string;
    title: string;
    difficulty_level: number;
    version: number;
    topicId: string;
    topicName: string;
    topicSlug: string;
    subjectId: string;
    subjectName: string;
    subjectSlug: string;
    moduleSlug: string;
    is_verified: boolean;
  };
  questions: Question[];
  existingAttempt: AttemptSummary | null;
  existingAnswers: DecoratedAnswer[];
  initialReview: PracticeReview | null;
  userEmail: string | null;
};


export default function PracticeSetClient(props: Props) {
  return (
    <AttemptProvider
      setInfo={props.setInfo}
      questions={props.questions}
      existingAnswers={props.existingAnswers}
      userEmail={props.userEmail}
      existingAttempt={props.existingAttempt}
    >
      <PracticeSetView />
    </AttemptProvider>
  );
}

function PracticeSetView() {
  const { state, derived, actions, setInfo, userEmail } = useAttemptStore();
  const { goPrev, goNext, handleSelect, handleSkip, setShowConfirmDialog, toggleExplanation } = actions;

  const currentQuestion = derived.currentQuestion;
  const questionCount = derived.questionCount;
  const currentIndex = state.currentIndex;
  const answeredCount = derived.answeredCount;
  const skippedCount = derived.skippedCount;
  const allHandled = derived.allHandled;
  const questionTitleId = `question-${currentQuestion?.id}-title`;

  const currentHandled = currentQuestion ? Boolean(state.answers[currentQuestion.id]) : false;

  const optionsList = useMemo(
    () =>
      currentQuestion
        ? optionKeys.map((key) => ({
          value: key,
          text: currentQuestion[`option_${key.toLowerCase() as "a" | "b" | "c" | "d"}`],
        }))
        : [],
    [currentQuestion]
  );

  const selectedAnswer = currentQuestion ? state.answers[currentQuestion.id] ?? null : null;

  const handleOptionSelect = useCallback(
    (option: (typeof optionKeys)[number]) => {
      if (currentQuestion) {
        handleSelect(currentQuestion.id, option);
      }
    },
    [currentQuestion, handleSelect]
  );

  if (!currentQuestion) {
    return (
      <section className="space-y-4">
        <p className="text-gray-700">No questions available for this practice set.</p>
      </section>
    );
  }

  return (
    <section className="space-y-6">
      <div aria-live="polite" aria-atomic="true" role="status" className="sr-only">
        {state.announcementText}
      </div>
      <div className="flex items-center gap-2 text-sm text-gray-500" aria-label="Breadcrumb">
        <Link href="/courses" className="text-blue-700 hover:text-blue-900">
          Courses
        </Link>
        <span aria-hidden="true">/</span>
        <Link href={`/courses/${setInfo.moduleSlug}/${setInfo.subjectSlug}`} className="text-blue-700 hover:text-blue-900">
          <Lang>{setInfo.subjectName}</Lang>
        </Link>
        <span aria-hidden="true">/</span>
        <Link
          href={`/courses/${setInfo.moduleSlug}/${setInfo.subjectSlug}/${setInfo.topicSlug}`}
          className="text-blue-700 hover:text-blue-900"
        >
          <Lang>{setInfo.topicName}</Lang>
        </Link>
        <span aria-hidden="true">/</span>
        <span className="text-gray-700" aria-current="page">
          {setInfo.title}
        </span>
      </div>

      <header className="space-y-2">
        <h1 id="main-heading" className="text-2xl font-semibold text-gray-900">{setInfo.title}</h1>
        <p className="text-gray-600">Difficulty {setInfo.difficulty_level}</p>
        {state.message && (
          <p className="rounded-md bg-emerald-50 px-3 py-2 text-sm text-emerald-700">{state.message}</p>
        )}
        {state.error && (
          <p className="rounded-md bg-red-50 px-3 py-2 text-sm text-red-700">{state.error}</p>
        )}
        {state.authRequired && (
          <p className="rounded-md bg-yellow-50 px-3 py-2 text-sm text-yellow-800">
            Please log in to save your progress.
          </p>
        )}
        {!userEmail && !state.authRequired && <p className="text-sm text-gray-600"></p>}
      </header>

      <Card className={`flex flex-col ${state.status === "submitted" ? "opacity-90" : ""}`}>
        <CardHeader>
          <CardTitle className="text-lg">
            Question {currentIndex + 1} of {questionCount}
          </CardTitle>
        </CardHeader>
        <CardContent className="flex flex-col gap-4 flex-1">
          <p
            id={questionTitleId}
            className="text-base text-gray-900 outline-none focus:ring-2 focus:ring-blue-500"
          >
            Question {currentIndex + 1}: <Lang>{currentQuestion.content}</Lang>
          </p>

          <QuestionOptions
            questionId={currentQuestion.id}
            options={optionsList}
            selectedAnswer={selectedAnswer}
            onSelect={handleOptionSelect}
            isSubmitted={state.status === "submitted" || (selectedAnswer !== null && selectedAnswer.selected_option !== "skipped")}
            correctAnswer={selectedAnswer && selectedAnswer.selected_option !== 'skipped' ? currentQuestion.correct_option : null}
          />

          {state.answers[currentQuestion.id] &&
            state.answers[currentQuestion.id]?.selected_option !== "skipped" &&
            state.status !== "submitted" && (
              <p
                className={`text-sm font-medium ${state.answers[currentQuestion.id]?.is_correct ? "text-emerald-700" : "text-orange-700"
                  }`}
              >
                {state.answers[currentQuestion.id]?.is_correct ? "Right!" : "Wrong..."}
              </p>
            )}

          <div className="border-t pt-3">
            <button
              type="button"
              className="text-sm font-semibold text-blue-700 hover:text-blue-900"
              onClick={() => toggleExplanation(currentQuestion.id)}
            >
              {state.showExplanation[currentQuestion.id] ? "Hide explanation" : "Show explanation"}
            </button>
            {state.showExplanation[currentQuestion.id] && (
              <div className="mt-2 rounded-md bg-gray-50 p-3 text-sm text-gray-800">
                <p className="font-semibold text-gray-900">Explanation</p>
                <p className="text-gray-700">{currentQuestion.explanation ? <Lang>{currentQuestion.explanation}</Lang> : "No explanation available."}</p>
                <p className="mt-2 text-xs text-gray-600">
                  Your choice: {state.answers[currentQuestion.id]?.selected_option ?? "—"} | Correct: {currentQuestion.correct_option}
                </p>
              </div>
            )}
          </div>

          <div className="mt-auto border-t pt-4 flex items-center justify-between">
            <Button aria-label="Previous question" variant="outline" onClick={goPrev} disabled={currentIndex === 0}>
              Previous
            </Button>
            <div className="flex items-center gap-2 text-sm text-gray-600">
              <span>Q {currentIndex + 1}</span>
              <span>•</span>
              <span>
                Answered {answeredCount}, Skipped {skippedCount}/{questionCount}
              </span>
            </div>
            {currentIndex === questionCount - 1 ? (
              <Button
                variant="outline"
                onClick={async () => {
                  if (!currentHandled) {
                    await handleSkip(currentQuestion.id);
                  }
                  setShowConfirmDialog(true);
                }}
                disabled={
                  state.status === "submitted" ||
                  state.isSubmitting ||
                  state.saving ||
                  (answeredCount === 0 && !currentHandled)
                }
              >
                {state.isSubmitting
                  ? "Submitting..."
                  : state.status === "submitted"
                    ? "Submitted"
                    : !userEmail
                      ? !currentHandled
                        ? "Skip & See Demo Feedback"
                        : "Submit & Get   Feedback"
                      : !currentHandled
                        ? "Skip & Submit"
                        : "Done"}
              </Button>
            ) : (
              <Button
                aria-label="Next question"
                variant="outline"
                onClick={async () => {
                  if (!currentHandled) {
                    await handleSkip(currentQuestion.id);
                  } else {
                    goNext();
                  }
                }}
                disabled={currentIndex === questionCount - 1}
              >
                Next
              </Button>
            )}
          </div>
        </CardContent>
      </Card>

      <QuestionNavigator />

      <div className="flex flex-wrap gap-3">
        {currentIndex !== questionCount - 1 && (
          <Button
            onClick={() => setShowConfirmDialog(true)}
            disabled={state.status === "submitted" || state.isSubmitting || state.saving || !allHandled}
          >
            {state.isSubmitting
              ? "Submitting..."
              : state.status === "submitted"
                ? "Submitted"
                : !userEmail
                  ? "Submit & See Demo Feedback"
                  : "Done"}
          </Button>
        )}
      </div>

      <ConfirmSubmitDialog />
      <SubmitLoader />
    </section>
  );
}





