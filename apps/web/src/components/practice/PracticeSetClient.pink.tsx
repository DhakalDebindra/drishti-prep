"use client";

import { Suspense, useMemo, useCallback, useEffect, useRef, useState } from "react";
import Link from "next/link";
import { usePathname, useSearchParams } from "next/navigation";
import { Button } from "@/components/ui/button";
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
import { ChevronLeft, ChevronRight, BookOpen, ChevronDown, ChevronUp } from "lucide-react";

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
            variant="secondary"
            size="lg"
            className="border border-slate-300 dark:border-slate-700 text-slate-700 dark:text-slate-300 hover:bg-slate-200/80 dark:hover:bg-slate-800/80 shadow-sm font-semibold focus-visible:ring-2 focus-visible:ring-blue-600 dark:focus-visible:ring-blue-400 gap-2 [&_svg]:size-4"
            onClick={goPrev}
            disabled={currentIndex === 0}
          >
            <ChevronLeft aria-hidden="true" />
            Previous
          </Button>
          <span className="text-sm text-slate-700 dark:text-slate-300">
            Answered {answeredCount}/{questionCount}
          </span>
          <Button
            aria-label="Next question"
            size="lg"
            className="bg-blue-600 hover:bg-blue-700 focus-visible:ring-2 focus-visible:ring-blue-600 dark:focus-visible:ring-blue-400 text-white font-semibold shadow-sm gap-2 [&_svg]:size-4"
            onClick={goNext}
            disabled={currentIndex === questionCount - 1}
          >
            Next
            <ChevronRight aria-hidden="true" />
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
    <main className="fixed inset-0 z-[100] overflow-y-auto bg-[#fbcfe8] font-sans text-[#0b1b3d] selection:bg-[#0b1b3d] selection:text-white">
      <div className="max-w-4xl mx-auto min-h-screen flex flex-col p-4 sm:p-6 md:p-8 gap-6 pb-40 md:pb-12">
        
        {/* Screen-reader announcement region */}
        <div aria-live="polite" aria-atomic="true" role="status" className="sr-only">
          {state.announcementText}
        </div>

        {/* Immersive Top Navigation Bar */}
        <header className="flex flex-col sm:flex-row sm:items-center justify-between bg-white px-6 py-5 rounded-2xl shadow-xl border-4 border-[#0b1b3d] gap-4">
          <div className="space-y-1.5">
            <h1 id="main-heading" className="text-xl sm:text-2xl font-black text-[#0b1b3d] tracking-tight">
              {setInfo.title}
            </h1>
            <nav aria-label="Breadcrumb">
              <ol className="flex flex-wrap items-center gap-2 text-xs sm:text-sm font-bold text-[#0b1b3d]/70">
                <li className="uppercase tracking-widest"><Lang>{setInfo.subjectName}</Lang></li>
                <li aria-hidden="true" className="text-[#0b1b3d]/30">•</li>
                <li className="uppercase tracking-widest font-black text-[#0b1b3d]"><Lang>{setInfo.topicName}</Lang></li>
              </ol>
            </nav>
          </div>
          
          <div className="flex items-center gap-3">
            {tutorEnabled && (
              <Link
                href={`${pathname}?view=listen`}
                className="inline-flex items-center gap-2 px-5 py-2.5 bg-indigo-100 dark:bg-indigo-900/40 text-indigo-800 dark:text-indigo-300 rounded-xl text-sm font-bold hover:bg-indigo-200 dark:hover:bg-indigo-900/60 transition-all active:scale-95"
              >
                🎧 Listen Mode
              </Link>
            )}
            <Link 
              href={`/courses/${setInfo.moduleSlug}/${setInfo.subjectSlug}/${setInfo.topicSlug}`}
              className="px-5 py-2.5 text-sm font-bold text-slate-600 dark:text-slate-300 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-xl transition-all border-2 border-transparent hover:border-slate-200 dark:hover:border-slate-700 active:scale-95"
            >
              Exit
            </Link>
          </div>
        </header>

        {state.message && (
          <p className="rounded-2xl bg-emerald-100 dark:bg-emerald-900/40 border-2 border-emerald-200 dark:border-emerald-800 px-5 py-4 text-sm font-bold text-emerald-800 dark:text-emerald-300 shadow-sm">{state.message}</p>
        )}
        {state.error && (
          <p className="rounded-2xl bg-red-100 dark:bg-red-900/40 border-2 border-red-200 dark:border-red-800 px-5 py-4 text-sm font-bold text-red-800 dark:text-red-300 shadow-sm">{state.error}</p>
        )}
        {state.authRequired && (
          <p className="rounded-2xl bg-amber-100 dark:bg-amber-900/40 border-2 border-amber-200 dark:border-amber-800 px-5 py-4 text-sm font-bold text-amber-800 dark:text-amber-300 shadow-sm">
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
          <p className="rounded-2xl bg-amber-50 dark:bg-amber-900/20 border-2 border-amber-200 dark:border-amber-800 px-5 py-4 text-sm font-bold text-amber-800 dark:text-amber-300 shadow-sm">
            Shruti isn&apos;t available for this question yet. Using your screen reader instead.
          </p>
        )}

      <div className={`practice-experience-container flex flex-col bg-white rounded-3xl shadow-2xl border-4 border-[#0b1b3d] overflow-hidden ${state.status === "submitted" ? "opacity-90" : ""}`}>
        {/* Prominent Progress Ribbon */}
        <div className="bg-[#fbcfe8]/20 border-b-4 border-[#0b1b3d] px-6 sm:px-10 py-5 sm:py-6 flex items-center justify-between">
          <div className="flex items-center gap-4">
            <div className="flex flex-col">
              <span className="text-[11px] font-black tracking-widest uppercase text-[#0b1b3d]/70 mb-1">
                Question {currentIndex + 1} of {questionCount}
              </span>
              <span className="text-base sm:text-lg font-black text-[#0b1b3d]">
                Practice Session
              </span>
            </div>
          </div>
          <div className="flex items-center gap-4 text-sm font-black text-[#0b1b3d]">
            <div className="w-24 sm:w-40 h-3 bg-pink-50 rounded-full overflow-hidden border-2 border-[#0b1b3d]">
              <div 
                className="h-full bg-[#0b1b3d] transition-all duration-500 ease-out"
                style={{ width: `${Math.max(5, (answeredCount / questionCount) * 100)}%` }}
              />
            </div>
            <span className="min-w-[3rem] text-right text-[#0b1b3d]">{Math.round((answeredCount / questionCount) * 100)}%</span>
          </div>
        </div>

        <div className="flex flex-col gap-10 flex-1 p-6 sm:p-10 md:p-12">
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
            className="text-2xl md:text-3xl lg:text-4xl font-bold text-slate-900 dark:text-slate-50 leading-snug md:leading-relaxed tracking-tight outline-none focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-blue-600 forced-colors:focus-visible:outline-[Highlight] motion-safe:animate-in motion-safe:fade-in motion-safe:slide-in-from-bottom-1 motion-safe:duration-300"
            tabIndex={-1}
            ariaHidden={tutorActive}
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
                className={`text-lg font-bold px-4 py-2 rounded-lg inline-block self-start ${state.answers[currentQuestion.id]?.is_correct ? "bg-emerald-100 text-emerald-800 dark:bg-emerald-900/40 dark:text-emerald-300" : "bg-red-100 text-red-800 dark:bg-red-900/40 dark:text-red-300"
                  }`}
              >
                {state.answers[currentQuestion.id]?.is_correct ? "Correct!" : "Incorrect"}
              </p>
            )}

          {(state.status === "submitted" || (state.answers[currentQuestion.id] && state.answers[currentQuestion.id].selected_option !== "skipped")) && (
            <div className="border-t border-slate-200 dark:border-slate-800 pt-8 mt-2">
              <Button
                type="button"
                variant="outline"
                className="inline-flex min-h-12 sm:min-h-14 items-center justify-between gap-3 px-6 py-3 text-base font-bold text-indigo-700 dark:text-indigo-300 border-2 border-indigo-200 dark:border-indigo-900/50 bg-indigo-50/50 dark:bg-indigo-950/20 hover:bg-indigo-100/70 dark:hover:bg-indigo-950/40 rounded-xl shadow-sm focus-visible:ring-2 focus-visible:ring-indigo-500 dark:focus-visible:ring-indigo-400 focus-visible:ring-offset-2 dark:focus-visible:ring-offset-slate-900 transition-all [&_svg]:size-5"
                aria-expanded={state.showExplanation[currentQuestion.id]}
                aria-controls={`explanation-${currentQuestion.id}`}
                onClick={() => toggleExplanation(currentQuestion.id)}
              >
                <span className="flex items-center gap-3">
                  <BookOpen aria-hidden="true" className="w-5 h-5" />
                  <span>
                    {state.showExplanation[currentQuestion.id] ? "Hide Explanation" : "Show Explanation"}
                  </span>
                </span>
                {state.showExplanation[currentQuestion.id] ? (
                  <ChevronUp className="text-indigo-500 dark:text-indigo-400 w-5 h-5" aria-hidden="true" />
                ) : (
                  <ChevronDown className="text-indigo-500 dark:text-indigo-400 w-5 h-5" aria-hidden="true" />
                )}
              </Button>
              {state.showExplanation[currentQuestion.id] && (
                <div
                  id={`explanation-${currentQuestion.id}`}
                  className="mt-6 rounded-xl bg-slate-50 dark:bg-slate-900/50 border border-slate-200 dark:border-slate-800 border-l-8 border-l-indigo-500 p-6 md:p-8 text-slate-800 dark:text-slate-200 shadow-inner motion-safe:animate-in motion-safe:fade-in motion-safe:slide-in-from-top-2 motion-safe:duration-300"
                  role="region"
                  aria-live="polite"
                >
                  <p className="font-black text-xl text-slate-900 dark:text-slate-100 mb-4 tracking-tight">Explanation</p>
                  <div className="text-slate-700 dark:text-slate-300 text-lg leading-relaxed">
                    {currentQuestion.explanation
                      ? <RichText className="space-y-3">{currentQuestion.explanation}</RichText>
                      : "No explanation available for this question."}
                  </div>
                  <div className="mt-6 pt-5 border-t border-slate-200 dark:border-slate-800 flex flex-wrap gap-4 text-base font-medium">
                    <span className="px-3 py-1 rounded-md bg-slate-200 dark:bg-slate-800 text-slate-800 dark:text-slate-200">
                      Your choice: <span className="font-bold">{state.answers[currentQuestion.id]?.selected_option ?? "—"}</span>
                    </span>
                    <span className="px-3 py-1 rounded-md bg-emerald-100 dark:bg-emerald-900/40 text-emerald-800 dark:text-emerald-300">
                      Correct Answer: <span className="font-bold">{currentQuestion.correct_option}</span>
                    </span>
                  </div>
                </div>
              )}
            </div>
          )}

          {/*
            Desktop action row. On mobile, the sticky MobileActionBar below
            replaces this so the primary actions stay within thumb reach
            without scrolling past long questions and option lists.
          */}
          {/*
            Desktop action row. 
          */}
          <div className="mt-8 pt-8 border-t-2 border-slate-100 dark:border-slate-800 hidden md:flex md:flex-row md:items-center justify-between gap-6">
            <div className="flex items-center justify-start gap-4">
              <Button
                aria-label="Previous question"
                variant="secondary"
                size="lg"
                className="h-16 px-8 border-b-4 active:border-b-0 active:translate-y-1 border-slate-300 dark:border-slate-700 text-slate-700 dark:text-slate-300 hover:bg-slate-100 dark:hover:bg-slate-800 font-black text-lg focus-visible:ring-4 focus-visible:ring-indigo-600/50 dark:focus-visible:ring-indigo-400/50 gap-3 [&_svg]:size-6 rounded-2xl transition-all"
                onClick={goPrev}
                disabled={currentIndex === 0}
              >
                <ChevronLeft aria-hidden="true" strokeWidth={3} />
                Previous
              </Button>
              {currentIndex === questionCount - 1 ? (
                <Button
                  size="lg"
                  className="h-16 px-10 bg-emerald-500 hover:bg-emerald-400 focus-visible:ring-4 focus-visible:ring-emerald-500/50 text-white font-black text-lg shadow-lg border-b-4 border-emerald-700 active:border-b-0 active:translate-y-1 rounded-2xl transition-all"
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
                  size="lg"
                  className="h-16 px-10 bg-indigo-500 hover:bg-indigo-400 focus-visible:ring-4 focus-visible:ring-indigo-500/50 text-white font-black text-lg shadow-lg border-b-4 border-indigo-700 active:border-b-0 active:translate-y-1 gap-3 [&_svg]:size-6 rounded-2xl transition-all"
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
            
            {/* The right-side stats block (Answered/Skipped) was removed to declutter the UI. */}
          </div>
        </div>
      </div>
      
      {/* Modern Floating Mobile Pill */}
      <div
        className="md:hidden fixed inset-x-4 bottom-6 z-[110] bg-white/95 backdrop-blur-xl shadow-2xl rounded-3xl border-4 border-[#0b1b3d] p-2 transition-transform duration-300"
        style={{ paddingBottom: "max(8px, env(safe-area-inset-bottom))" }}
      >
        <div className="flex items-center justify-between gap-2">
          <Button
            aria-label="Previous question"
            variant="ghost"
            className="flex-1 h-14 bg-white text-[#0b1b3d] hover:bg-[#fbcfe8]/50 font-black border-2 border-[#0b1b3d] focus-visible:ring-4 focus-visible:ring-pink-300 gap-1 rounded-2xl transition-colors"
            onClick={goPrev}
            disabled={currentIndex === 0}
          >
            <ChevronLeft aria-hidden="true" strokeWidth={3} />
            <span className="hidden sm:inline">Prev</span>
          </Button>

          {currentIndex === questionCount - 1 ? (
            <Button
              className="flex-1 h-14 bg-emerald-500 hover:bg-emerald-400 text-white font-black shadow-md rounded-2xl border-b-[3px] border-emerald-700 active:border-b-0 active:translate-y-[3px]"
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
              className="flex-1 h-14 bg-indigo-500 hover:bg-indigo-400 text-white font-black shadow-md gap-1 rounded-2xl border-b-[3px] border-indigo-700 active:border-b-0 active:translate-y-[3px]"
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

      {/* Early-submit shortcut — kept on desktop only. On mobile users
          navigate to the last question and use the sticky-bar Submit. */}
      <div className="hidden md:flex flex-col gap-2 w-full">
        {currentIndex !== questionCount - 1 && (
          <>
            <Button
              size="lg"
              className="w-full sm:w-auto bg-emerald-600 hover:bg-emerald-700 focus-visible:ring-2 focus-visible:ring-emerald-600 dark:focus-visible:ring-emerald-400 text-white font-semibold shadow-sm"
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
              <p className="text-sm text-slate-700 dark:text-slate-300">
                Answer at least {minToSubmit} questions to submit ({answeredCount}/{minToSubmit}).
                Any unanswered questions will be marked as skipped.
              </p>
            )}
          </>
        )}
      </div>

      </div>
      
      <ConfirmSubmitDialog />
      <SubmitLoader />
    </main>
  );
}
