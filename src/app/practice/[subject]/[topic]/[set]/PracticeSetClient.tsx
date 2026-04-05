"use client";

import { useEffect, useRef, useMemo, useCallback, memo } from "react";
import Link from "next/link";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { QuestionNavigator } from "@/components/practice/QuestionNavigator";
import { SubmitLoader } from "@/components/practice/SubmitLoader";
import { ConfirmSubmitDialog } from "@/components/practice/ConfirmSubmitDialog";
import { AttemptProvider, useAttemptStore } from "@/features/practice/store/attempt-store";
import type { DecoratedAnswer, PracticeReview, Question, AttemptSummary } from "@/types/practice";

type Props = {
  setInfo: {
    id: string;
    title: string;
    difficulty_level: number;
    version: number;
    topicId: string;
    topicName: string;
    subjectId: string;
    subjectName: string;
    is_verified: boolean;
  };
  questions: Question[];
  existingAttempt: AttemptSummary | null;
  existingAnswers: DecoratedAnswer[];
  initialReview: PracticeReview | null;
  userEmail: string | null;
};

const optionKeys = ["A", "B", "C", "D"] as const;

type QuestionOption = { value: (typeof optionKeys)[number]; text: string };

type QuestionOptionsProps = {
  questionId: string;
  options: QuestionOption[];
  selectedAnswer: { question_id: string; selected_option: string; is_correct?: boolean } | null;
  onSelect: (option: (typeof optionKeys)[number]) => void;
  isSubmitted?: boolean;
};

const QuestionOptions = memo(({ questionId, options, selectedAnswer, onSelect, isSubmitted }: QuestionOptionsProps) => {
  const questionTitleId = `question-${questionId}-title`;
  const optionsContainerRef = useRef<HTMLDivElement | null>(null);

  useEffect(() => {
    const container = optionsContainerRef.current;
    if (!container) return;

    const buttons = Array.from(container.querySelectorAll('[role="radio"]')) as HTMLButtonElement[];
    const selectedButton = buttons.find((btn) => btn.getAttribute("aria-checked") === "true");
    const target = selectedButton ?? buttons[0];

    if (target) {
      requestAnimationFrame(() => target.focus());
    }
  }, [questionId]);

  return (
    <div
      ref={optionsContainerRef}
      className="space-y-3"
      role="radiogroup"
      aria-labelledby={questionTitleId}
      onKeyDown={(e) => {
        const target = e.target as HTMLElement;
        if (target.getAttribute("role") !== "radio") return;

        if (["ArrowDown", "ArrowRight", "ArrowUp", "ArrowLeft"].includes(e.key)) {
          e.preventDefault();

          const buttons = Array.from(
            e.currentTarget.querySelectorAll('[role="radio"]')
          ) as HTMLButtonElement[];
          const currentIdx = buttons.indexOf(target as HTMLButtonElement);
          if (currentIdx === -1) return;

          let nextIndex = currentIdx;
          if (e.key === "ArrowDown" || e.key === "ArrowRight") {
            nextIndex = (currentIdx + 1) % buttons.length;
          } else if (e.key === "ArrowUp" || e.key === "ArrowLeft") {
            nextIndex = (currentIdx - 1 + buttons.length) % buttons.length;
          }

          buttons[nextIndex].focus();
        }
      }}
    >
      {options.map((option, index) => {
        const optionLabelId = `option-${questionId}-${option.value}-label`;
        const isSelected = selectedAnswer?.selected_option === option.value;
        const isAnswered = selectedAnswer != null;
        const tabIndex = isSelected ? 0 : index === 0 ? 0 : -1;

        return (
          <button
            key={option.value}
            type="button"
            role="radio"
            aria-checked={isSelected}
            aria-labelledby={`${optionLabelId} ${questionTitleId}`}
            tabIndex={tabIndex}
            onClick={(e) => {
              e.preventDefault();
              e.stopPropagation();
              if (isSubmitted) return;
              onSelect(option.value);
            }}
            className={`w-full rounded-md border p-3 text-left transition focus:outline-none focus:ring-2 focus:ring-blue-400 ${
              isSelected
                ? "border-blue-400 bg-blue-50"
                : "border-gray-200 hover:border-blue-200 hover:bg-gray-50"
            } ${isSubmitted ? "cursor-not-allowed opacity-90" : "cursor-pointer"}`}
          >
            <div className="flex items-start gap-3">
              <span
                aria-hidden="true"
                className={`mt-1 h-5 w-5 rounded-full border ${
                  isSelected ? "border-blue-500 bg-blue-500" : "border-gray-300"
                }`}
              />
              <div className="space-y-1">
                <p id={optionLabelId} className="text-gray-900">
                  <span className="mr-2 font-semibold">{option.value}.</span>
                  {option.text}
                </p>
                {isSelected && selectedAnswer?.selected_option !== "skipped" && (
                  <p className={`text-xs font-semibold ${selectedAnswer?.is_correct ? 'text-emerald-700' : 'text-orange-700'}`}>
                    <span className="sr-only">{selectedAnswer?.is_correct ? 'correct' : 'incorrect'}</span>
                    Your choice
                  </p>
                )}
              </div>
            </div>
          </button>
        );
      })}
    </div>
  );
});
QuestionOptions.displayName = "QuestionOptions";

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
        <Link href="/practice" className="text-blue-700 hover:text-blue-900">
          Practice
        </Link>
        <span aria-hidden="true">/</span>
        <Link href={`/practice/${setInfo.subjectName}`} className="text-blue-700 hover:text-blue-900">
          {setInfo.subjectName}
        </Link>
        <span aria-hidden="true">/</span>
        <Link
          href={`/practice/${setInfo.subjectName}/${setInfo.topicName}`}
          className="text-blue-700 hover:text-blue-900"
        >
          {setInfo.topicName}
        </Link>
        <span aria-hidden="true">/</span>
        <span className="text-gray-700" aria-current="page">
          {setInfo.title}
        </span>
      </div>

      <header className="space-y-2">
        <h1 className="text-2xl font-semibold text-gray-900">{setInfo.title}</h1>
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
            Question {currentIndex + 1}: {currentQuestion.content}
          </p>

          <QuestionOptions
            questionId={currentQuestion.id}
            options={optionsList}
            selectedAnswer={selectedAnswer}
            onSelect={handleOptionSelect}
            isSubmitted={state.status === "submitted" || (selectedAnswer !== null && selectedAnswer.selected_option !== "skipped")}
          />

          {state.answers[currentQuestion.id] &&
            state.answers[currentQuestion.id]?.selected_option !== "skipped" &&
            state.status !== "submitted" && (
              <p
                className={`text-sm font-medium ${
  state.answers[currentQuestion.id]?.is_correct ? "text-emerald-700" : "text-orange-700"
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
                <p className="text-gray-700">{currentQuestion.explanation || "No explanation available."}</p>
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
                    : "Submit & See Demo Feedback"
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






