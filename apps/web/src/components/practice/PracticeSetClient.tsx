"use client";

import { Suspense, useMemo, useCallback, useEffect, useRef, useState } from "react";
import Link from "next/link";
import { usePathname, useSearchParams } from "next/navigation";
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
import { useTutorAudio, prefetchQuestionAudio } from "@/hooks/useTutorAudio";
import { useTutorPlayer } from "@/hooks/useTutorPlayer";
import { useTutorHotkeys } from "@/hooks/useTutorHotkeys";
import { useAnswerHotkeys } from "@/hooks/useAnswerHotkeys";
import type {
  AttemptSummary,
  DecoratedAnswer,
  PracticeReview,
  Question,
} from "@repo/types";
import { QuestionOptions, optionKeys } from "@/components/practice/QuestionOptions";
import { QuestionContent } from "@/components/practice/QuestionContent";

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
      {/* Suspense boundary required because PracticeSetView reads useSearchParams. */}
      <Suspense fallback={null}>
        <PracticeSetView />
      </Suspense>
    </AttemptProvider>
  );
}

function PracticeSetView() {
  const { state, derived, actions, setInfo, userEmail, questions } = useAttemptStore();
  const { goPrev, goNext, handleSelect, handleSkip, setShowConfirmDialog, toggleExplanation } = actions;

  const currentQuestion = derived.currentQuestion;
  const questionCount = derived.questionCount;
  const currentIndex = state.currentIndex;
  const answeredCount = derived.answeredCount;
  const skippedCount = derived.skippedCount;
  const canSubmit = derived.canSubmit;
  const minToSubmit = derived.minToSubmit;
  const questionTitleId = `question-${currentQuestion?.id}-title`;

  const currentHandled = currentQuestion ? Boolean(state.answers[currentQuestion.id]) : false;

  // Listening mode: an audio-first, decluttered layout reachable at
  // ?view=listen. It can be opened in its own tab for a focused, accessible
  // session, and shares the same attempt state and Shruti hooks.
  const searchParams = useSearchParams();
  const pathname = usePathname();
  const listenMode = searchParams.get("view") === "listen";

  // ── Tutor voice (Shruti) integration ───────────────────────────────────
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
  // `tutorReady` — audio is fetched and playable. Hotkeys bind at this point
  // (not only once playing) so Alt+S can serve as the first start gesture.
  const tutorReady = tutorEnabled && audio.status === "ready";
  const tutorActive = tutorReady && !awaitingGesture;

  // Auto-play stem + options on each new question, but only after the user
  // has explicitly started tutor mode (browser autoplay policy + sanity).
  // `lastAutoPlayedRef` is shared with `handleStartTutor`: the click handler
  // plays directly (preserving the user-gesture context) and marks the
  // current question as already-played so this effect doesn't double-fire.
  const lastAutoPlayedRef = useRef<string | null>(null);
  useEffect(() => {
    if (!tutorActive) return;
    if (!currentQuestion) return;
    if (lastAutoPlayedRef.current === currentQuestion.id) return;
    lastAutoPlayedRef.current = currentQuestion.id;
    player.playFullSequence();
  }, [tutorActive, currentQuestion, player]);

  // Warm the next and previous questions' audio while the learner is on the
  // current one, so pressing Next/Prev starts playback with no network wait.
  useEffect(() => {
    if (!tutorEnabled) return;
    prefetchQuestionAudio(questions[currentIndex + 1]?.id ?? null);
    prefetchQuestionAudio(questions[currentIndex - 1]?.id ?? null);
  }, [tutorEnabled, questions, currentIndex]);

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

  // Kick off the first play() INSIDE the gesture handler so the browser sees
  // it as user-initiated. Deferring to a useEffect after `setAwaitingGesture`
  // commits loses that gesture context in Safari and (intermittently) Chrome,
  // and audio.play() rejects with "Playback blocked". Reused as the Alt+S
  // hotkey handler so the keypress doubles as the start gesture.
  const handleStartTutor = useCallback(() => {
    setAwaitingGesture(false);
    if (currentQuestion) lastAutoPlayedRef.current = currentQuestion.id;
    player.playFullSequence();
  }, [player, currentQuestion]);

  // Player-control hotkeys bind as soon as audio is ready so Alt+S can start
  // Shruti. Option-selection (Alt+1-4) is always-on via useAnswerHotkeys so
  // keyboard users can answer regardless of tutor mode.
  useTutorHotkeys(player, tutorReady, {
    onNext: goNext,
    onPrev: goPrev,
    onShowHelp: () => setShowHotkeyHelp(true),
    onStart: handleStartTutor,
    explanationUnlocked:
      selectedAnswer != null && selectedAnswer.selected_option !== "skipped",
  });
  useAnswerHotkeys(Boolean(currentQuestion), (letter) => {
    if (!currentQuestion) return;
    if (tutorActive) player.mute();
    handleOptionSelect(letter);
  });

  if (!currentQuestion) {
    return (
      <section className="space-y-4">
        <p className="text-gray-700">No questions available for this practice set.</p>
      </section>
    );
  }

  // ── Listening mode ─────────────────────────────────────────────────────
  // An audio-first layout: minimal visuals, large controls, keyboard-driven.
  if (listenMode) {
    return (
      <section className="max-w-2xl mx-auto space-y-6">
        <div
          aria-live="polite"
          aria-atomic="true"
          role="status"
          className="sr-only"
        >
          {state.announcementText}
        </div>

        <header className="space-y-1">
          <p className="text-xs font-semibold uppercase tracking-wider text-blue-700">
            Shruti · Listening mode
          </p>
          <h1 className="text-2xl font-bold text-slate-900">
            <Lang>{setInfo.title}</Lang>
          </h1>
          <Link
            href={pathname}
            className="inline-block text-sm text-blue-700 hover:text-blue-900 underline underline-offset-4"
          >
            Switch to standard view
          </Link>
        </header>

        {!tutorEnabled && (
          <p className="rounded-md bg-amber-50 border border-amber-200 px-4 py-3 text-sm text-amber-800">
            Listening mode needs Shruti. Enable it in{" "}
            <Link href="/profile/preferences" className="underline font-medium">
              your preferences
            </Link>
            , then return here.
          </p>
        )}

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
            Shruti audio isn&apos;t available for this question yet.
          </p>
        )}

        <div className="rounded-xl border border-slate-200 bg-white p-6 space-y-5">
          <p className="text-sm font-semibold text-slate-700">
            Question {currentIndex + 1} of {questionCount}
          </p>
          <QuestionContent
            content={currentQuestion.content}
            className="text-lg sm:text-xl font-medium text-slate-900 leading-relaxed"
            ariaHidden={tutorActive}
          />
          <QuestionOptions
            questionId={currentQuestion.id}
            options={optionsList}
            selectedAnswer={selectedAnswer}
            onSelect={handleOptionSelect}
            isSubmitted={state.status === "submitted" || (selectedAnswer !== null && selectedAnswer.selected_option !== "skipped")}
            correctAnswer={selectedAnswer && selectedAnswer.selected_option !== "skipped" ? currentQuestion.correct_option : null}
          />
        </div>

        <div className="flex items-center justify-between gap-3">
          <Button
            aria-label="Previous question"
            variant="outline"
            size="lg"
            onClick={goPrev}
            disabled={currentIndex === 0}
          >
            Previous
          </Button>
          <span className="text-sm text-slate-700">
            Answered {answeredCount}/{questionCount}
          </span>
          <Button
            aria-label="Next question"
            size="lg"
            className="bg-blue-600 hover:bg-blue-700 text-white"
            onClick={goNext}
            disabled={currentIndex === questionCount - 1}
          >
            Next
          </Button>
        </div>

        <div className="flex flex-col gap-2">
          <Button
            size="lg"
            className="bg-emerald-600 hover:bg-emerald-700 text-white font-medium"
            onClick={() => setShowConfirmDialog(true)}
            disabled={state.status === "submitted" || state.isSubmitting || !canSubmit}
          >
            {state.isSubmitting
              ? "Submitting..."
              : state.status === "submitted"
                ? "Submitted"
                : "Submit"}
          </Button>
          {!canSubmit && state.status !== "submitted" && (
            <p className="text-sm text-slate-700">
              Answer at least {minToSubmit} questions to submit ({answeredCount}/{minToSubmit}).
              Any unanswered questions will be marked as skipped.
            </p>
          )}
        </div>

        <div className="rounded-lg bg-slate-50 border border-slate-200 p-4 text-xs text-slate-700">
          <p className="font-semibold mb-1 text-slate-700">Keyboard shortcuts</p>
          <p className="leading-relaxed">
            <kbd className="font-mono">Alt+S</kbd> start ·{" "}
            <kbd className="font-mono">Alt+Q</kbd> question ·{" "}
            <kbd className="font-mono">Alt+O</kbd> options ·{" "}
            <kbd className="font-mono">Alt+E</kbd> explanation ·{" "}
            <kbd className="font-mono">1-4</kbd> answer ·{" "}
            <kbd className="font-mono">Alt+P</kbd> pause ·{" "}
            <kbd className="font-mono">Alt+R</kbd> replay ·{" "}
            <kbd className="font-mono">Alt+/</kbd> all shortcuts
          </p>
        </div>

        <ConfirmSubmitDialog />
        <SubmitLoader />
      </section>
    );
  }

  return (
    <section className="space-y-6">
      {/*
        Screen-reader announcement region for selection feedback. Stays polite
        even in tutor mode — without it, blind users who select an answer get
        no correctness verdict before the explanation audio begins.
      */}
      <div
        aria-live="polite"
        aria-atomic="true"
        role="status"
        className="sr-only"
      >
        {state.announcementText}
      </div>
      <nav aria-label="Breadcrumb">
        <ol className="flex flex-wrap items-center gap-2 text-sm text-slate-700">
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
        <p className="text-slate-700">Difficulty {setInfo.difficulty_level}</p>
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
          Shruti isn&apos;t available for this question yet. Using your screen
          reader instead.
        </p>
      )}
      {tutorEnabled && (
        <Link
          href={`${pathname}?view=listen`}
          className="inline-flex items-center gap-1.5 text-sm font-medium text-blue-700 hover:text-blue-900 underline underline-offset-4"
        >
          🎧 Open Listening mode — an audio-first, distraction-free view
        </Link>
      )}

      <Card className={`flex flex-col ${state.status === "submitted" ? "opacity-90" : ""}`}>
        <CardHeader>
          <CardTitle className="text-lg">
            Question {currentIndex + 1} of {questionCount}
          </CardTitle>
        </CardHeader>
        <CardContent className="flex flex-col gap-4 flex-1">
          {/*
            When tutor mode is actively reading aloud, the stem is hidden
            from screen readers to prevent simultaneous English-SR + Nepali-TTS
            narration. The visible text is unchanged so sighted users and
            anyone with tutor muted keep their full UX.
          */}
          <QuestionContent
            key={currentQuestion.id}
            id={questionTitleId}
            content={currentQuestion.content}
            className="text-lg sm:text-xl font-medium text-slate-900 outline-none focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-blue-600 forced-colors:focus-visible:outline-[Highlight] leading-relaxed mb-2 motion-safe:animate-in motion-safe:fade-in motion-safe:slide-in-from-bottom-1 motion-safe:duration-300"
            tabIndex={-1}
            ariaHidden={tutorActive}
            header={
              <span className="text-slate-700 text-sm font-semibold uppercase tracking-wider block mb-1">
                Question {currentIndex + 1}
              </span>
            }
          />

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
                className="inline-flex min-h-12 sm:min-h-0 items-center text-base sm:text-sm font-bold text-blue-700 hover:text-blue-900 underline underline-offset-4 py-2 sm:py-0"
                aria-expanded={state.showExplanation[currentQuestion.id]}
                aria-controls={`explanation-${currentQuestion.id}`}
                onClick={() => toggleExplanation(currentQuestion.id)}
              >
                {state.showExplanation[currentQuestion.id] ? "Hide explanation" : "Show explanation"}
              </button>
              {state.showExplanation[currentQuestion.id] && (
                <div
                  id={`explanation-${currentQuestion.id}`}
                  className="mt-3 rounded-lg bg-slate-50 border-l-4 border-slate-700 p-4 text-slate-800 shadow-sm motion-safe:animate-in motion-safe:fade-in motion-safe:slide-in-from-top-1 motion-safe:duration-200"
                  role="region"
                  aria-live="polite"
                >
                  <p className="font-bold text-slate-900 mb-2">Explanation</p>
                  <div className="text-slate-700 text-base leading-relaxed">
                    {currentQuestion.explanation
                      ? <RichText className="space-y-1">{currentQuestion.explanation}</RichText>
                      : "No explanation available."}
                  </div>
                  <p className="mt-4 pt-3 border-t border-slate-200 text-sm font-medium text-slate-700">
                    Your choice: <span className="text-slate-900">{state.answers[currentQuestion.id]?.selected_option ?? "—"}</span> | Correct: <span className="text-emerald-700 font-bold">{currentQuestion.correct_option}</span>
                  </p>
                </div>
              )}
            </div>
          )}

          {/*
            Desktop action row. On mobile, the sticky MobileActionBar below
            replaces this so the primary actions stay within thumb reach
            without scrolling past long questions and option lists.
          */}
          <div className="mt-auto border-t pt-4 hidden md:flex md:flex-row md:items-center justify-between gap-4">
            <div className="flex items-center justify-start gap-4">
              <Button aria-label="Previous question" variant="outline" size="lg" className="border-2 border-slate-500 text-slate-800 hover:border-slate-700 hover:bg-slate-100 font-medium" onClick={goPrev} disabled={currentIndex === 0}>
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
                    !canSubmit
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
            <div className="flex items-center justify-center gap-2 text-sm text-slate-700">
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

      {/* Early-submit shortcut — kept on desktop only. On mobile users
          navigate to the last question and use the sticky-bar Submit. */}
      <div className="hidden md:flex flex-col gap-2 w-full">
        {currentIndex !== questionCount - 1 && (
          <>
            <Button
              size="lg"
              className="w-full sm:w-auto bg-emerald-600 hover:bg-emerald-700 text-white font-medium shadow-sm"
              onClick={() => setShowConfirmDialog(true)}
              disabled={state.status === "submitted" || state.isSubmitting || state.saving || !canSubmit}
            >
              {state.isSubmitting
                ? "Submitting..."
                : state.status === "submitted"
                  ? "Submitted"
                  : !userEmail
                    ? "Submit & See Demo Feedback"
                    : "Done"}
            </Button>
            {!canSubmit && state.status !== "submitted" && (
              <p className="text-sm text-slate-700">
                Answer at least {minToSubmit} questions to submit ({answeredCount}/{minToSubmit}).
                Any unanswered questions will be marked as skipped.
              </p>
            )}
          </>
        )}
      </div>

      {/* Spacer so the last content isn't hidden behind the mobile sticky bar. */}
      <div className="md:hidden h-24" aria-hidden="true" />

      {/* Mobile sticky bottom action bar — primary actions within thumb reach. */}
      <div
        className="md:hidden fixed inset-x-0 bottom-0 z-40 border-t border-slate-200 bg-white/95 backdrop-blur shadow-[0_-4px_12px_rgba(15,23,42,0.06)]"
        style={{ paddingBottom: "env(safe-area-inset-bottom)" }}
      >
        <div className="flex items-stretch gap-2 px-4 py-3">
          <Button
            aria-label="Previous question"
            variant="outline"
            className="flex-1 min-h-12 border-2 border-slate-500 text-slate-800 hover:border-slate-700 hover:bg-slate-100 font-medium"
            onClick={goPrev}
            disabled={currentIndex === 0}
          >
            Previous
          </Button>
          <div className="flex flex-col items-center justify-center text-[11px] leading-tight text-slate-700 min-w-[56px]">
            <span className="font-semibold text-slate-900">
              {currentIndex + 1}/{questionCount}
            </span>
            <span className="text-slate-500">{answeredCount} done</span>
          </div>
          {currentIndex === questionCount - 1 ? (
            <Button
              className="flex-1 min-h-12 bg-emerald-600 hover:bg-emerald-700 text-white font-medium shadow-sm"
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
                !canSubmit
              }
            >
              {state.isSubmitting
                ? "Submitting..."
                : state.status === "submitted"
                  ? "Submitted"
                  : !currentHandled
                    ? "Skip & Submit"
                    : "Submit"}
            </Button>
          ) : (
            <Button
              aria-label="Next question"
              className="flex-1 min-h-12 bg-blue-600 hover:bg-blue-700 text-white font-medium shadow-sm"
              onClick={async () => {
                if (!currentHandled) {
                  await handleSkip(currentQuestion.id);
                } else {
                  goNext();
                }
              }}
            >
              Next
            </Button>
          )}
        </div>
      </div>

      <ConfirmSubmitDialog />
      <SubmitLoader />
    </section>
  );
}
