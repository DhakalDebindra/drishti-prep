"use client";

import { useMemo, useCallback, useEffect, useRef, useState, startTransition } from "react";
import Link from "next/link";
import { usePathname } from "next/navigation";
import { Button } from "@/components/ui/button";
import { Lang } from "@/components/ui/Lang";
import { RichText } from "@/components/ui/RichText";
import { QuestionNavigator } from "@/components/practice/QuestionNavigator";
import { SubmitLoader } from "@/components/practice/SubmitLoader";
import { ConfirmSubmitDialog } from "@/components/practice/ConfirmSubmitDialog";
import { TutorVoicePanel } from "@/components/practice/TutorVoicePanel";
import { TutorHotkeyHelp } from "@/components/practice/TutorHotkeyHelp";
import { PracticeAccessibilityMenu } from "@/components/practice/AccessibilityMenu";
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
import { ChevronLeft, ChevronRight, BookOpen, ChevronDown, ChevronUp, Sparkles, Headphones } from "lucide-react";
import { cn } from "@repo/utils";
import { buttonVariants } from "@/components/ui/button-variants";

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
  const { state, derived, actions, setInfo, userEmail, questions } = useAttemptStore();
  const { goPrev, goNext, handleSelect, handleSkip, setShowConfirmDialog, toggleExplanation } = actions;

  const currentQuestion = derived.currentQuestion;
  const questionCount = derived.questionCount;
  const currentIndex = state.currentIndex;
  const answeredCount = derived.answeredCount;
  const canSubmit = derived.canSubmit;
  const minToSubmit = derived.minToSubmit;
  const questionTitleId = `question-${currentQuestion?.id}-title`;
  const answeredProgress = questionCount > 0 ? Math.round((answeredCount / questionCount) * 100) : 0;

  const currentHandled = currentQuestion ? Boolean(state.answers[currentQuestion.id]) : false;

  // Listening mode: an audio-first, decluttered layout reachable at
  // ?view=listen. It can be opened in its own tab for a focused, accessible
  // session, and shares the same attempt state and Shruti hooks.
  //
  // Read via window.location instead of useSearchParams(): the latter forces
  // a <Suspense> boundary around this whole view, and in production that
  // boundary's streamed content never swaps in from its fallback (stays
  // stuck in a display:none holding div indefinitely -- see git history for
  // the diagnosis). Defaulting to false on first render and correcting after
  // mount means a one-frame flash of the normal view for listen-mode deep
  // links, which is an acceptable trade for the page actually working.
  const pathname = usePathname();
  const [listenMode, setListenMode] = useState(false);
  useEffect(() => {
    startTransition(() => {
      setListenMode(new URLSearchParams(window.location.search).get("view") === "listen");
    });
  }, []);

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

  // Focus management: 
  // On mobile/touch devices, we focus the question text so TalkBack reads it automatically.
  // On desktop, QuestionOptions auto-focuses the options for keyboard efficiency.
  useEffect(() => {
    if (!currentQuestion || tutorActive) return;
    
    const timer = setTimeout(() => {
      if (window.matchMedia("(pointer: coarse)").matches) {
        const el = document.getElementById(questionTitleId);
        if (el) {
          el.focus({ preventScroll: true });
        }
      }
    }, 50);
    
    return () => clearTimeout(timer);
  }, [currentQuestion?.id, questionTitleId, tutorActive]);

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
      <section className="rounded-3xl border border-border bg-card p-6 shadow-sm">
        <p className="text-slate-700 dark:text-slate-300">No questions available for this practice set.</p>
      </section>
    );
  }

  if (listenMode) {
    return (
      <main className="relative min-h-screen overflow-x-clip bg-background px-4 py-4 text-foreground sm:px-6 sm:py-6">
        <section className="relative mx-auto flex max-w-2xl flex-col gap-6">
          <div aria-live="polite" aria-atomic="true" role="status" className="sr-only">
            {state.announcementText}
          </div>

          <header className="rounded-3xl border border-border bg-card p-5 shadow-[0_18px_50px_rgba(15,23,42,0.08)] sm:p-6">
            <p className="text-xs font-semibold uppercase tracking-[0.24em] text-emerald-700 dark:text-emerald-300">
              Shruti · Listening mode
            </p>
            <h1 className="mt-2 text-2xl font-bold tracking-tight text-slate-950 dark:text-white sm:text-3xl">
              <Lang>{setInfo.title}</Lang>
            </h1>
            <Link
              href={pathname}
              className="mt-3 inline-flex text-sm font-medium text-emerald-700 underline underline-offset-4 transition hover:text-emerald-900 dark:text-emerald-300 dark:hover:text-emerald-200"
            >
              Switch to standard view
            </Link>
          </header>

          {!tutorEnabled && (
            <p className="rounded-2xl border border-amber-200 bg-amber-50 px-4 py-3 text-sm text-amber-900 shadow-sm dark:border-amber-900/50 dark:bg-amber-950/30 dark:text-amber-200">
              Listening mode needs Shruti. Enable it in{" "}
              <Link href="/profile/preferences" className="font-semibold underline underline-offset-4">
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
            <p className="rounded-2xl border border-amber-200 bg-amber-50 px-4 py-3 text-sm text-amber-900 shadow-sm dark:border-amber-900/50 dark:bg-amber-950/30 dark:text-amber-200">
              Shruti audio isn&apos;t available for this question yet.
            </p>
          )}

          <div className="rounded-3xl border border-border bg-card p-5 shadow-[0_18px_50px_rgba(15,23,42,0.08)] sm:p-6">
            <div className="flex items-center justify-between gap-3 border-b border-slate-200 pb-4 dark:border-slate-800">
              <div>
                <p className="text-xs font-semibold uppercase tracking-[0.24em] text-slate-500 dark:text-slate-400">
                  Question {currentIndex + 1} of {questionCount}
                </p>
                <p className="mt-1 text-sm text-slate-600 dark:text-slate-300">Audio-first practice with clean visuals.</p>
              </div>
              <span className="rounded-full border border-slate-200 bg-slate-50 px-3 py-1.5 text-sm font-medium text-slate-600 dark:border-slate-700 dark:bg-slate-900 dark:text-slate-300">
                {answeredCount}/{questionCount}
              </span>
            </div>

            <div className="mt-5 space-y-5">
              <QuestionContent
                id={questionTitleId}
                content={currentQuestion.content}
                className="text-xl font-semibold leading-relaxed tracking-tight text-slate-950 dark:text-slate-50 sm:text-2xl"
                tabIndex={-1}
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
          </div>

          <div className="flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
            <Button
              aria-label="Previous question"
              variant="secondary"
              size="lg"
              className="h-14 gap-2 rounded-2xl border border-slate-200 bg-white px-5 text-slate-700 shadow-sm transition hover:bg-slate-50 dark:border-slate-700 dark:bg-slate-950 dark:text-slate-200 dark:hover:bg-slate-900               focus-visible:ring-2 focus-visible:ring-ring"
              onClick={goPrev}
              disabled={currentIndex === 0}
            >
              <ChevronLeft aria-hidden="true" />
              Previous
            </Button>
            <span className="text-sm font-medium text-slate-600 dark:text-slate-300">
              Answered {answeredCount}/{questionCount}
            </span>
            <Button
              aria-label="Next question"
              variant="default"
              size="lg"
              className="h-14 gap-2 rounded-2xl px-5 shadow-md shadow-primary/25 transition hover:bg-primary/90 focus-visible:ring-2 focus-visible:ring-ring"
              onClick={goNext}
              disabled={currentIndex === questionCount - 1}
            >
              Next
              <ChevronRight aria-hidden="true" />
            </Button>
          </div>

          <div className="flex flex-col gap-2">
            <Button
              variant="default"
              size="lg"
              className="h-14 rounded-2xl bg-success text-success-foreground shadow-md shadow-success/25 transition hover:bg-success/90 focus-visible:ring-2 focus-visible:ring-ring"
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
              <p className="text-sm leading-relaxed text-slate-600 dark:text-slate-300">
                Answer at least {minToSubmit} questions to submit ({answeredCount}/{minToSubmit}). Any unanswered questions will be marked as skipped.
              </p>
            )}
          </div>

          <div className="rounded-2xl border border-slate-200 bg-slate-50/80 p-4 text-sm text-slate-600 shadow-sm dark:border-slate-800 dark:bg-slate-900/60 dark:text-slate-300">
            <p className="mb-2 font-semibold text-slate-700 dark:text-slate-200">Keyboard shortcuts</p>
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
      </main>
    );
  }

  return (
    <main className="fixed inset-0 z-[100] overflow-y-auto bg-background text-foreground selection:bg-primary/20 selection:text-foreground">
      <div className="relative mx-auto flex min-h-screen max-w-6xl flex-col gap-6 px-4 py-4 pb-36 sm:px-6 sm:py-6 md:px-8 md:py-8 md:pb-12">
        <div aria-live="polite" aria-atomic="true" role="status" className="sr-only">
          {state.announcementText}
        </div>

        <header className="relative overflow-hidden rounded-3xl border border-border bg-card px-5 py-5 shadow-[0_20px_60px_rgba(15,23,42,0.08)] sm:px-6 sm:py-6">
          <div className="absolute inset-x-0 top-0 h-1 bg-primary" />
          <div className="flex flex-col gap-4 lg:flex-row lg:items-start lg:justify-between">
            <div className="space-y-3">
              <div className="inline-flex items-center gap-2 rounded-full border border-emerald-200/80 bg-emerald-50 px-3 py-1 text-xs font-semibold uppercase tracking-[0.22em] text-emerald-800 dark:border-emerald-900/60 dark:bg-emerald-950/40 dark:text-emerald-200">
                <Sparkles className="h-3.5 w-3.5" aria-hidden="true" />
                Practice Studio
              </div>
              <div className="space-y-1">
                <h1 id="main-heading" className="text-2xl font-bold tracking-tight text-slate-950 dark:text-white sm:text-3xl">
                  {setInfo.title}
                </h1>
                <nav aria-label="Breadcrumb">
                  <ol className="flex flex-wrap items-center gap-2 text-xs font-medium text-slate-500 dark:text-slate-400 sm:text-sm">
                    <li className="rounded-full bg-slate-100 px-3 py-1 text-slate-700 dark:bg-slate-900 dark:text-slate-200">
                      <Lang>{setInfo.subjectName}</Lang>
                    </li>
                    <li aria-hidden="true" className="text-slate-300 dark:text-slate-600">•</li>
                    <li className="rounded-full bg-slate-100 px-3 py-1 text-slate-700 dark:bg-slate-900 dark:text-slate-200">
                      <Lang>{setInfo.topicName}</Lang>
                    </li>
                  </ol>
                </nav>
              </div>
            </div>

            <div className="flex flex-col gap-3 sm:flex-row sm:items-center">
              <PracticeAccessibilityMenu buttonMode="compact" />
              {tutorEnabled && (
                <Link
                  href={`${pathname}?view=listen`}
                  className={cn(buttonVariants({ variant: "outline" }), "rounded-full font-semibold")}
                >
                  <Headphones className="h-4 w-4" aria-hidden="true" />
                  Listen mode
                </Link>
              )}
              <Link
                href={`/courses/${setInfo.moduleSlug}/${setInfo.subjectSlug}/${setInfo.topicSlug}`}
                className={cn(buttonVariants({ variant: "outline" }), "rounded-full font-semibold")}
              >
                Exit set
              </Link>
            </div>
          </div>
        </header>

        {state.message && (
          <p role="status" className="rounded-2xl border border-emerald-200 bg-emerald-50 px-5 py-4 text-sm font-medium text-emerald-900 shadow-sm dark:border-emerald-900/50 dark:bg-emerald-950/30 dark:text-emerald-200">{state.message}</p>
        )}
        {state.error && (
          <p role="alert" className="rounded-2xl border border-rose-200 bg-rose-50 px-5 py-4 text-sm font-medium text-rose-900 shadow-sm dark:border-rose-900/50 dark:bg-rose-950/30 dark:text-rose-200">{state.error}</p>
        )}
        {state.authRequired && (
          <p className="rounded-2xl border border-amber-200 bg-amber-50 px-5 py-4 text-sm font-medium text-amber-900 shadow-sm dark:border-amber-900/50 dark:bg-amber-950/30 dark:text-amber-200">
            Please log in to save your progress.
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
          <p className="rounded-2xl border border-amber-200 bg-amber-50 px-5 py-4 text-sm font-medium text-amber-900 shadow-sm dark:border-amber-900/50 dark:bg-amber-950/30 dark:text-amber-200">
            Shruti isn&apos;t available for this question yet. Using your screen reader instead.
          </p>
        )}

        <div className={`practice-experience-container flex flex-col overflow-hidden rounded-3xl border border-border bg-card shadow-[0_24px_80px_rgba(15,23,42,0.10)] ${state.status === "submitted" ? "opacity-95" : ""}`}>
          <div className="border-b border-slate-200/80 bg-slate-50/80 px-5 py-4 dark:border-slate-800 dark:bg-slate-900/60 sm:px-6">
            <div className="flex flex-col gap-3 md:flex-row md:items-center md:justify-between">
              <div>
                <p className="text-xs font-semibold uppercase tracking-[0.24em] text-slate-500 dark:text-slate-400">
                  Practice Session
                </p>
                <p className="mt-1 text-sm text-slate-600 dark:text-slate-300">
                  Answer at your own pace. The layout stays calm, readable, and responsive.
                </p>
              </div>
              <div className="flex items-center gap-3 text-sm font-medium text-slate-600 dark:text-slate-300">
                <span className="rounded-full border border-slate-200 bg-white px-3 py-1.5 dark:border-slate-700 dark:bg-slate-950">
                  {Math.max(5, answeredProgress)}% answered
                </span>
                <span className="rounded-full border border-slate-200 bg-white px-3 py-1.5 dark:border-slate-700 dark:bg-slate-950">
                  {questionCount - answeredCount} left
                </span>
              </div>
            </div>
          </div>

          <div className="flex flex-1 flex-col gap-8 p-5 sm:p-6 md:p-8">
            <section className="grid gap-4 lg:grid-cols-[minmax(0,1fr)_18rem]">
              <div className="rounded-3xl border border-slate-200 bg-slate-50/80 p-4 shadow-sm dark:border-slate-800 dark:bg-slate-900/60 sm:p-5">
                <div className="flex items-center justify-between gap-3">
                  <div>
                    <p className="text-xs font-semibold uppercase tracking-[0.24em] text-slate-500 dark:text-slate-400">
                      Question {currentIndex + 1} of {questionCount}
                    </p>
                    <p className="mt-1 text-sm font-medium text-slate-600 dark:text-slate-300">
                      Practice session
                    </p>
                  </div>
                  <div className="h-2 w-28 overflow-hidden rounded-full bg-slate-200 dark:bg-slate-800 sm:w-40">
                    <div
                      className="h-full rounded-full bg-primary transition-all duration-500"
                      style={{ width: `${Math.max(5, answeredProgress)}%` }}
                    />
                  </div>
                </div>

                <div className="mt-5">
                  <QuestionContent
                    key={currentQuestion.id}
                    id={questionTitleId}
                    content={currentQuestion.content}
                    className="text-xl font-semibold leading-relaxed tracking-tight text-slate-950 outline-none transition focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-4 focus-visible:outline-ring dark:text-slate-50 sm:text-2xl md:text-3xl motion-safe:animate-in motion-safe:fade-in motion-safe:slide-in-from-bottom-1 motion-safe:duration-300"
                    tabIndex={-1}
                    ariaHidden={tutorActive}
                  />
                </div>
              </div>

              <aside className="rounded-3xl border border-slate-200 bg-white p-4 shadow-sm dark:border-slate-800 dark:bg-slate-950/70 sm:p-5">
                <p className="text-xs font-semibold uppercase tracking-[0.24em] text-slate-500 dark:text-slate-400">
                  Session tips
                </p>
                <ul className="mt-3 space-y-3 text-sm leading-relaxed text-slate-700 dark:text-slate-200">
                  <li className="rounded-2xl border border-slate-200 bg-slate-50 px-4 py-3 dark:border-slate-800 dark:bg-slate-900/60">
                    Use the option cards or{" "}
                    <kbd className="rounded border border-slate-300 bg-white px-1.5 py-0.5 font-mono text-[11px] text-slate-700 dark:border-slate-700 dark:bg-slate-950 dark:text-slate-200">
                      1-4
                    </kbd>{" "}
                    to answer quickly.
                  </li>
                  <li className="rounded-2xl border border-slate-200 bg-slate-50 px-4 py-3 dark:border-slate-800 dark:bg-slate-900/60">
                    The bottom action bar stays within thumb reach on mobile.
                  </li>
                  <li className="rounded-2xl border border-slate-200 bg-slate-50 px-4 py-3 dark:border-slate-800 dark:bg-slate-900/60">
                    Explanations stay collapsed until you need them.
                  </li>
                </ul>
              </aside>
            </section>

            <QuestionOptions
              questionId={currentQuestion.id}
              options={optionsList}
              selectedAnswer={selectedAnswer}
              onSelect={handleOptionSelect}
              isSubmitted={state.status === "submitted" || (selectedAnswer !== null && selectedAnswer.selected_option !== "skipped")}
              correctAnswer={selectedAnswer && selectedAnswer.selected_option !== "skipped" ? currentQuestion.correct_option : null}
            />

            {state.answers[currentQuestion.id] &&
              state.answers[currentQuestion.id]?.selected_option !== "skipped" &&
              state.status !== "submitted" && (
                <p
                  className={`inline-flex self-start rounded-full px-4 py-2 text-sm font-semibold shadow-sm ${
                    state.answers[currentQuestion.id]?.is_correct
                      ? "border border-emerald-200 bg-emerald-50 text-emerald-900 dark:border-emerald-900/50 dark:bg-emerald-950/30 dark:text-emerald-200"
                      : "border border-rose-200 bg-rose-50 text-rose-900 dark:border-rose-900/50 dark:bg-rose-950/30 dark:text-rose-200"
                  }`}
                >
                  {state.answers[currentQuestion.id]?.is_correct ? "Correct!" : "Incorrect"}
                </p>
              )}

            {(state.status === "submitted" || (state.answers[currentQuestion.id] && state.answers[currentQuestion.id].selected_option !== "skipped")) && (
              <div className="rounded-3xl border border-slate-200 bg-slate-50/80 p-4 shadow-sm dark:border-slate-800 dark:bg-slate-900/60 sm:p-5">
                <Button
                  type="button"
                  variant="outline"
                  className="inline-flex min-h-12 w-full items-center justify-between gap-3 rounded-2xl border border-primary/30 bg-white px-5 py-3 text-base font-semibold text-primary shadow-sm transition hover:bg-primary/5 focus-visible:ring-2 focus-visible:ring-ring dark:border-primary/50 dark:bg-slate-950 dark:hover:bg-slate-900 [&_svg]:size-5"
                  aria-expanded={state.showExplanation[currentQuestion.id]}
                  aria-controls={`explanation-${currentQuestion.id}`}
                  onClick={() => toggleExplanation(currentQuestion.id)}
                >
                  <span className="flex items-center gap-3">
                    <BookOpen aria-hidden="true" className="h-5 w-5" />
                    <span>{state.showExplanation[currentQuestion.id] ? "Hide Explanation" : "Show Explanation"}</span>
                  </span>
                  {state.showExplanation[currentQuestion.id] ? (
                    <ChevronUp className="h-5 w-5 text-primary" aria-hidden="true" />
                  ) : (
                    <ChevronDown className="h-5 w-5 text-primary" aria-hidden="true" />
                  )}
                </Button>
                {state.showExplanation[currentQuestion.id] && (
                  <div
                    id={`explanation-${currentQuestion.id}`}
                    className="mt-4 rounded-2xl border border-slate-200 bg-white p-5 text-slate-800 shadow-inner dark:border-slate-800 dark:bg-slate-950/70 dark:text-slate-200 sm:p-6"
                    role="region"
                    aria-live="polite"
                  >
                    <p className="mb-3 text-xl font-bold tracking-tight text-slate-950 dark:text-white">
                      Explanation
                    </p>
                    <div className="text-base leading-relaxed text-slate-700 dark:text-slate-300">
                      {currentQuestion.explanation
                        ? <RichText className="space-y-3">{currentQuestion.explanation}</RichText>
                        : "No explanation available for this question."}
                    </div>
                    <div className="mt-5 flex flex-wrap gap-3 border-t border-slate-200 pt-4 text-sm font-medium dark:border-slate-800">
                      <span className="rounded-full border border-slate-200 bg-slate-50 px-3 py-1.5 text-slate-700 dark:border-slate-700 dark:bg-slate-900 dark:text-slate-300">
                        Your choice: <span className="font-semibold">{state.answers[currentQuestion.id]?.selected_option ?? "—"}</span>
                      </span>
                      <span className="rounded-full border border-success/30 bg-success/10 px-3 py-1.5 text-success">
                        Correct Answer: <span className="font-semibold">{currentQuestion.correct_option}</span>
                      </span>
                    </div>
                  </div>
                )}
              </div>
            )}

            <div className="hidden flex-col gap-4 border-t border-slate-200 pt-6 md:flex dark:border-slate-800">
              <div className="flex items-center justify-between gap-4">
                <Button
                  aria-label="Previous question"
                  variant="secondary"
                  size="lg"
                  className="h-14 gap-3 rounded-2xl border border-slate-200 bg-white px-6 text-slate-700 shadow-sm transition hover:bg-slate-50 dark:border-slate-700 dark:bg-slate-950 dark:text-slate-200 dark:hover:bg-slate-900 focus-visible:ring-2 focus-visible:ring-ring [&_svg]:size-5"
                  onClick={goPrev}
                  disabled={currentIndex === 0}
                >
                  <ChevronLeft aria-hidden="true" strokeWidth={3} />
                  Previous
                </Button>
                {currentIndex === questionCount - 1 ? (
                  <Button
                    variant="default"
                    size="lg"
                    className="h-14 rounded-2xl bg-primary px-7 shadow-md shadow-primary/25 transition hover:bg-primary/90 focus-visible:ring-2 focus-visible:ring-ring"
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
                            : "Submit & Get Feedback"
                          : !currentHandled
                            ? "Skip & Submit"
                            : "Done"}
                  </Button>
                ) : (
                  <Button
                    aria-label="Next question"
                    variant="default"
                    size="lg"
                    className="h-14 gap-3 rounded-2xl px-7 shadow-md shadow-primary/25 transition hover:bg-primary/90 focus-visible:ring-2 focus-visible:ring-ring [&_svg]:size-5"
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
                    <ChevronRight aria-hidden="true" strokeWidth={3} />
                  </Button>
                )}
              </div>

              {currentIndex !== questionCount - 1 && (
                <>
                  <Button
                    variant="default"
                    size="lg"
                    className="w-full rounded-2xl bg-success text-success-foreground shadow-md shadow-success/25 transition hover:bg-success/90 focus-visible:ring-2 focus-visible:ring-ring sm:w-auto"
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
                    <p className="text-sm leading-relaxed text-slate-600 dark:text-slate-300">
                      Answer at least {minToSubmit} questions to submit ({answeredCount}/{minToSubmit}). Any unanswered questions will be marked as skipped.
                    </p>
                  )}
                </>
              )}
            </div>
          </div>
        </div>

        <div
          className="md:hidden fixed inset-x-4 bottom-4 z-[110] rounded-3xl border border-slate-200/80 bg-white/95 p-2 shadow-[0_16px_40px_rgba(15,23,42,0.16)] backdrop-blur-xl transition-transform duration-300 dark:border-slate-700/80 dark:bg-slate-950/95"
          style={{ paddingBottom: "max(8px, env(safe-area-inset-bottom))" }}
        >
          {currentIndex === questionCount - 1 && !canSubmit && state.status !== "submitted" && (
            <p className="px-2 pb-2 text-center text-xs leading-relaxed text-slate-600 dark:text-slate-300">
              Answer at least {minToSubmit} questions to submit ({answeredCount}/{minToSubmit}).
            </p>
          )}
          <div className="flex items-center justify-between gap-2">
            <Button
              aria-label="Previous question"
              variant="ghost"
              className="flex-1 h-14 gap-1 rounded-2xl border border-slate-200 bg-slate-50 text-slate-700 hover:bg-slate-100 dark:border-slate-700 dark:bg-slate-900 dark:text-slate-200 dark:hover:bg-slate-800 focus-visible:ring-2 focus-visible:ring-ring"
              onClick={goPrev}
              disabled={currentIndex === 0}
            >
              <ChevronLeft aria-hidden="true" strokeWidth={3} />
              <span className="hidden sm:inline">Prev</span>
            </Button>

            {currentIndex === questionCount - 1 ? (
              <Button
                variant="default"
                className="flex-1 h-14 rounded-2xl bg-primary shadow-md shadow-primary/25 transition hover:bg-primary/90 focus-visible:ring-2 focus-visible:ring-ring"
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
                {state.isSubmitting ? "Wait" : state.status === "submitted" ? "Done" : "Submit"}
              </Button>
            ) : (
              <Button
                aria-label="Next question"
                variant="default"
                className="flex-1 h-14 gap-1 rounded-2xl shadow-md shadow-primary/25 transition hover:bg-primary/90 focus-visible:ring-2 focus-visible:ring-ring"
                onClick={async () => {
                  if (!currentHandled) {
                    await handleSkip(currentQuestion.id);
                  } else {
                    goNext();
                  }
                }}
              >
                <span className="hidden sm:inline">Next</span>
                <ChevronRight aria-hidden="true" strokeWidth={3} />
              </Button>
            )}
          </div>
        </div>

        <QuestionNavigator />
        <ConfirmSubmitDialog />
        <SubmitLoader />
      </div>
    </main>
  );
}
