"use client";

import { useMemo, useCallback, useEffect, useState } from "react";
import Link from "next/link";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Lang } from "@/components/ui/Lang";
import { RichText } from "@/components/ui/RichText";
import { QuestionNavigator } from "@/components/practice/QuestionNavigator";
import { SubmitLoader } from "@/components/practice/SubmitLoader";
import { ConfirmSubmitDialog } from "@/components/practice/ConfirmSubmitDialog";
import { TutorVoicePanel } from "@/components/practice/TutorVoicePanel";
import { TutorHotkeyHelp } from "@/components/practice/TutorHotkeyHelp";
import { AttemptProvider, useAttemptStore } from "@/features/practice/store/attempt-store";
import { useTutorAudio } from "@/hooks/useTutorAudio";
import { useTutorPlayer } from "@/hooks/useTutorPlayer";
import { useTutorHotkeys } from "@/hooks/useTutorHotkeys";
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
    subtopicName?: string | null;
    subtopicSlug?: string | null;
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
      setInfo={props.setInfo as any}
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

  // ── Tutor voice integration ────────────────────────────────────────────
  // The preference is loaded once on mount. If guest or off, all tutor paths
  // are short-circuited and the original SR-driven experience runs unchanged.
  const [tutorEnabled, setTutorEnabled] = useState(false);
  const [awaitingGesture, setAwaitingGesture] = useState(true);
  const [showHotkeyHelp, setShowHotkeyHelp] = useState(false);

  useEffect(() => {
    let cancelled = false;
    fetch("/api/me/preferences")
      .then((r) => r.json())
      .then((j) => {
        if (cancelled) return;
        setTutorEnabled(Boolean(j.tutor_voice_enabled));
      })
      .catch(() => {});
    return () => {
      cancelled = true;
    };
  }, []);

  const audio = useTutorAudio(
    tutorEnabled ? currentQuestion?.id ?? null : null
  );
  const audioUrls = audio.status === "ready" ? audio.urls : null;
  const player = useTutorPlayer(audioUrls);
  const tutorActive =
    tutorEnabled && audio.status === "ready" && !awaitingGesture;

  // Auto-play stem + options on each new question, but only after the user
  // has explicitly started tutor mode (browser autoplay policy + sanity).
  useEffect(() => {
    if (!tutorActive) return;
    if (!currentQuestion) return;
    player.playFullSequence();
  }, [tutorActive, currentQuestion, player]);

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
      if (!currentQuestion) return;
      handleSelect(currentQuestion.id, option);
      // After answering, play the explanation aloud.
      if (tutorActive) {
        // Small delay so state updates settle (correctness display, etc.)
        window.setTimeout(() => player.playExplanation(), 250);
      }
    },
    [currentQuestion, handleSelect, tutorActive, player]
  );

  // Hotkey bindings: only active when tutor mode is genuinely playing audio.
  useTutorHotkeys(player, tutorActive, {
    onSelectOption: (letter) => {
      if (currentQuestion) {
        handleSelect(currentQuestion.id, letter);
        window.setTimeout(() => player.playExplanation(), 250);
      }
    },
    onNext: goNext,
    onPrev: goPrev,
    onShowHelp: () => setShowHotkeyHelp(true),
  });

  const handleStartTutor = useCallback(() => {
    setAwaitingGesture(false);
  }, []);

  if (!currentQuestion) {
    return (
      <section className="space-y-4">
        <p className="text-gray-700">No questions available for this practice set.</p>
      </section>
    );
  }

  return (
    <section className="space-y-6">
      {/*
        Screen-reader announcement region for selection feedback. Suppressed
        when tutor mode is active because the spoken explanation already
        covers correctness — keeping it would cause double narration.
      */}
      <div
        aria-live={tutorActive ? "off" : "polite"}
        aria-atomic="true"
        role="status"
        className="sr-only"
      >
        {tutorActive ? "" : state.announcementText}
      </div>
      <nav aria-label="Breadcrumb">
        <ol className="flex flex-wrap items-center gap-2 text-sm text-gray-500">
          <li><Link href="/courses" className="text-blue-700 hover:text-blue-900">Courses</Link></li>
          <li aria-hidden="true">/</li>
          <li><Link href={`/courses/${setInfo.moduleSlug}/${setInfo.subjectSlug}`} className="text-blue-700 hover:text-blue-900"><Lang>{setInfo.subjectName}</Lang></Link></li>
          <li aria-hidden="true">/</li>
          <li><Link href={`/courses/${setInfo.moduleSlug}/${setInfo.subjectSlug}/${setInfo.topicSlug}`} className="text-blue-700 hover:text-blue-900"><Lang>{setInfo.topicName}</Lang></Link></li>
          
          {(setInfo as any).subtopicSlug && (
            <>
              <li aria-hidden="true">/</li>
              <li><Link href={`/courses/${setInfo.moduleSlug}/${setInfo.subjectSlug}/${setInfo.topicSlug}/${(setInfo as any).subtopicSlug}`} className="text-blue-700 hover:text-blue-900"><Lang>{(setInfo as any).subtopicName}</Lang></Link></li>
            </>
          )}

          <li aria-hidden="true">/</li>
          <li aria-current="page" className="text-gray-700"><Lang>{setInfo.title}</Lang></li>
        </ol>
      </nav>

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

      {tutorEnabled && audio.status === "ready" && (
        <TutorVoicePanel
          player={player}
          voice={audio.voice}
          awaitingFirstGesture={awaitingGesture}
          onStart={handleStartTutor}
          onShowHelp={() => setShowHotkeyHelp(true)}
        />
      )}
      <TutorHotkeyHelp open={showHotkeyHelp} onClose={() => setShowHotkeyHelp(false)} />
      {tutorEnabled && audio.status === "not_generated" && (
        <p className="rounded-md bg-amber-50 border border-amber-200 px-4 py-3 text-sm text-amber-800">
          Tutor voice isn&apos;t available for this question yet. Using your screen
          reader instead.
        </p>
      )}

      <Card className={`flex flex-col ${state.status === "submitted" ? "opacity-90" : ""}`}>
        <CardHeader>
          <CardTitle className="text-lg">
            Question {currentIndex + 1} of {questionCount}
          </CardTitle>
        </CardHeader>
        <CardContent className="flex flex-col gap-4 flex-1">
          <div
            id={questionTitleId}
            className="text-base sm:text-lg font-medium text-slate-900 outline-none focus:ring-2 focus:ring-blue-500 leading-relaxed mb-2"
            tabIndex={-1}
            // When tutor mode is actively reading aloud, hide the stem from
            // screen readers to prevent simultaneous English-SR + Nepali-TTS
            // narration. The visible text is unchanged so sighted users and
            // anyone with tutor muted keep their full UX.
            aria-hidden={tutorActive ? "true" : undefined}
          >
            <span className="text-slate-500 text-sm font-semibold uppercase tracking-wider block mb-1">Question {currentIndex + 1}</span>
            <Lang>{currentQuestion.content}</Lang>
          </div>

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

          {(state.status === "submitted" || (state.answers[currentQuestion.id] && state.answers[currentQuestion.id].selected_option !== "skipped")) && (
            <div className="border-t pt-3">
              <button
                type="button"
                className="text-sm font-bold text-blue-700 hover:text-blue-900 underline underline-offset-4"
                aria-expanded={state.showExplanation[currentQuestion.id]}
                aria-controls={`explanation-${currentQuestion.id}`}
                onClick={() => toggleExplanation(currentQuestion.id)}
              >
                {state.showExplanation[currentQuestion.id] ? "Hide explanation" : "Show explanation"}
              </button>
              {state.showExplanation[currentQuestion.id] && (
                <div 
                  id={`explanation-${currentQuestion.id}`}
                  className="mt-3 rounded-lg bg-slate-50 border-l-4 border-slate-700 p-4 text-slate-800 shadow-sm"
                  role="region"
                  aria-live="polite"
                >
                  <p className="font-bold text-slate-900 mb-2">Explanation</p>
                  <div className="text-slate-700 text-base leading-relaxed">
                    {currentQuestion.explanation
                      ? <RichText className="space-y-1">{currentQuestion.explanation}</RichText>
                      : "No explanation available."}
                  </div>
                  <p className="mt-4 pt-3 border-t border-slate-200 text-sm font-medium text-slate-600">
                    Your choice: <span className="text-slate-900">{state.answers[currentQuestion.id]?.selected_option ?? "—"}</span> | Correct: <span className="text-emerald-700 font-bold">{currentQuestion.correct_option}</span>
                  </p>
                </div>
              )}
            </div>
          )}

          <div className="mt-auto border-t pt-4 flex flex-col sm:flex-row sm:items-center justify-between gap-4">
            <div className="flex items-center justify-between sm:justify-start w-full sm:w-auto gap-4 order-2 sm:order-1">
              <Button aria-label="Previous question" variant="outline" size="lg" className="border-2 border-slate-300 text-slate-800 hover:border-slate-400 hover:bg-slate-100 font-medium" onClick={goPrev} disabled={currentIndex === 0}>
                Previous
              </Button>
              {currentIndex === questionCount - 1 ? (
                <Button
                  size="lg"
                  className="bg-emerald-600 hover:bg-emerald-700 text-white font-medium shadow-sm"
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
                  size="lg"
                  className="bg-blue-600 hover:bg-blue-700 text-white font-medium shadow-sm"
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
            <div className="flex items-center justify-center gap-2 text-sm text-slate-600 order-1 sm:order-2">
              <span className="font-medium">Q {currentIndex + 1}</span>
              <span>•</span>
              <span>
                Answered {answeredCount}, Skipped {skippedCount}/{questionCount}
              </span>
            </div>
          </div>
        </CardContent>
      </Card>

      <QuestionNavigator />

      <div className="flex flex-wrap gap-3 w-full">
        {currentIndex !== questionCount - 1 && (
          <Button
            size="lg"
            className="w-full sm:w-auto bg-emerald-600 hover:bg-emerald-700 text-white font-medium shadow-sm"
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
