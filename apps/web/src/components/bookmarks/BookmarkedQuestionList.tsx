"use client";

import React, { useState } from "react";
import {
  Bookmark,
  ChevronDown,
  ChevronUp,
  CheckCircle2,
  BookOpen,
  Sparkles,
} from "lucide-react";
import Link from "next/link";
import { Lang } from "@/components/ui/Lang";
import { RichText } from "@/components/ui/RichText";
import { PracticeAccessibilityMenu } from "@/components/practice/AccessibilityMenu";
import { toggleBookmark } from "@/app/actions/practice-actions";
import { cn } from "@repo/utils";

export type BookmarkedQuestion = {
  bookmark_id: string;
  question_id: string;
  content: string;
  option_a: string;
  option_b: string;
  option_c: string;
  option_d: string;
  correct_option: string;
  explanation: string | null;
  set_title: string;
  created_at: string;
};

interface BookmarkedQuestionListProps {
  initialQuestions: BookmarkedQuestion[];
}

export function BookmarkedQuestionList({ initialQuestions }: BookmarkedQuestionListProps) {
  const [questions, setQuestions] = useState<BookmarkedQuestion[]>(initialQuestions);
  const [expandedId, setExpandedId] = useState<string | null>(null);
  const [announcement, setAnnouncement] = useState("");

  const handleUnbookmark = async (questionId: string, e: React.MouseEvent) => {
    e.stopPropagation();

    const questionToRemove = questions.find((question) => question.question_id === questionId);
    if (!questionToRemove) return;

    setQuestions((prev) => prev.filter((question) => question.question_id !== questionId));
    setAnnouncement("Bookmark removed");

    const result = await toggleBookmark(questionId);

    if (!result.success) {
      setQuestions((prev) => {
        const restored = [...prev, questionToRemove];
        return restored.sort(
          (left, right) => new Date(right.created_at).getTime() - new Date(left.created_at).getTime()
        );
      });
      setAnnouncement("Failed to remove bookmark");
      alert(result.error || "Failed to update bookmark");
    }
  };

  return (
    <div className="mx-auto max-w-[var(--dp-shell-width)] space-y-6 px-4 py-8 sm:px-6 lg:px-8">
      <div aria-live="polite" aria-atomic="true" className="sr-only">
        {announcement}
      </div>

      <div className="rounded-[2rem] border border-white/70 bg-white/85 p-6 shadow-[0_20px_60px_rgba(15,23,42,0.08)] backdrop-blur-xl dark:border-slate-800 dark:bg-slate-950/70 md:p-8">
        <div className="flex flex-col gap-4 lg:flex-row lg:items-end lg:justify-between">
          <div className="space-y-3">
            <div className="inline-flex items-center gap-2 rounded-full border border-emerald-200 bg-emerald-50 px-3 py-1 text-xs font-semibold uppercase tracking-[0.22em] text-emerald-800 dark:border-emerald-900/60 dark:bg-emerald-950/30 dark:text-emerald-200">
              <Sparkles className="h-3.5 w-3.5" aria-hidden="true" />
              Bookmarks
            </div>
            <div>
              <h1 id="main-heading" className="flex items-center gap-2 text-3xl font-bold tracking-tight text-slate-950 dark:text-white">
                <BookOpen className="h-6 w-6 text-emerald-600 dark:text-emerald-300" aria-hidden="true" />
                Saved for review
              </h1>
              <p className="mt-2 max-w-2xl text-sm leading-relaxed text-slate-600 dark:text-slate-300">
                Review your saved questions in a calmer, study-friendly layout that stays comfortable during longer reading sessions.
              </p>
            </div>
          </div>

          <div className="flex flex-wrap items-center gap-3">
            <div className="inline-flex items-center gap-2 rounded-full border border-slate-200 bg-white px-3 py-2 text-sm font-medium text-slate-700 shadow-sm dark:border-slate-700 dark:bg-slate-900 dark:text-slate-200">
              <Bookmark className="h-4 w-4 text-emerald-600 dark:text-emerald-300" aria-hidden="true" />
              <span>{questions.length} saved</span>
            </div>
            <PracticeAccessibilityMenu buttonMode="compact" />
          </div>
        </div>
      </div>

      <ul className="space-y-4">
        {questions.length === 0 ? (
          <li className="rounded-[2rem] border border-dashed border-slate-200 bg-slate-50/80 p-10 text-center shadow-sm dark:border-slate-800 dark:bg-slate-900/60 sm:p-12">
            <div className="mx-auto mb-4 flex h-16 w-16 items-center justify-center rounded-full bg-white shadow-sm dark:bg-slate-800">
              <Bookmark className="h-8 w-8 text-slate-300 dark:text-slate-600" aria-hidden="true" />
            </div>
            <h3 className="text-lg font-semibold text-slate-950 dark:text-white">No bookmarks yet</h3>
            <p className="mx-auto mt-2 max-w-md text-sm leading-relaxed text-slate-600 dark:text-slate-300">
              Questions you save during practice will appear here, ready for a calmer second look.
            </p>
            <Link
              href="/practice"
              className="mt-6 inline-flex items-center justify-center rounded-full bg-gradient-to-r from-emerald-500 to-teal-500 px-5 py-2.5 text-sm font-semibold text-white shadow-lg shadow-emerald-500/25 transition hover:-translate-y-0.5 hover:from-emerald-400 hover:to-teal-400 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-emerald-500"
            >
              Start practicing
            </Link>
          </li>
        ) : (
          questions.map((question) => {
            const isExpanded = expandedId === question.question_id;
            const panelId = `question-panel-${question.question_id}`;
            const headerId = `question-header-${question.question_id}`;

            return (
              <li
                key={question.question_id}
                className="group relative overflow-hidden rounded-[1.75rem] border border-slate-200/80 bg-white/90 shadow-[0_14px_40px_rgba(15,23,42,0.06)] transition hover:-translate-y-0.5 hover:shadow-[0_20px_50px_rgba(15,23,42,0.09)] dark:border-slate-800 dark:bg-slate-950/70"
              >
                <div className="absolute inset-x-0 top-0 h-1 bg-gradient-to-r from-emerald-400 via-teal-400 to-cyan-400" />

                <button
                  id={headerId}
                  type="button"
                  className={cn(
                    "flex w-full items-start gap-4 px-5 py-5 pr-16 text-left transition sm:px-6",
                    isExpanded
                      ? "bg-slate-50/80 dark:bg-slate-900/60"
                      : "hover:bg-slate-50/60 dark:hover:bg-slate-900/40"
                  )}
                  onClick={() => setExpandedId(isExpanded ? null : question.question_id)}
                  aria-expanded={isExpanded}
                  aria-controls={panelId}
                >
                  <div className="mt-0.5 rounded-full bg-emerald-50 p-2 text-emerald-600 dark:bg-emerald-950/40 dark:text-emerald-300" aria-hidden="true">
                    <Bookmark className="h-4 w-4 fill-current" />
                  </div>

                  <div className="flex-1 space-y-2">
                    <div className="flex flex-wrap items-center gap-2">
                      <span className="rounded-full border border-slate-200 bg-slate-50 px-2.5 py-1 text-[10px] font-semibold uppercase tracking-[0.22em] text-slate-500 dark:border-slate-700 dark:bg-slate-900 dark:text-slate-400">
                        <Lang>{question.set_title}</Lang>
                      </span>
                      <span className="text-xs text-slate-500 dark:text-slate-400">
                        Saved on {new Date(question.created_at).toLocaleDateString("en-US", {
                          month: "short",
                          day: "numeric",
                          year: "numeric",
                        })}
                      </span>
                    </div>
                    <div className="text-base font-medium leading-relaxed text-slate-950 dark:text-white">
                      <Lang>{question.content}</Lang>
                    </div>
                  </div>

                  <div className="mt-1 flex items-center gap-2 text-slate-400" aria-hidden="true">
                    {isExpanded ? <ChevronUp className="h-5 w-5" /> : <ChevronDown className="h-5 w-5" />}
                  </div>
                </button>

                <button
                  type="button"
                  onClick={(event) => handleUnbookmark(question.question_id, event)}
                  className="absolute right-4 top-4 inline-flex h-9 w-9 items-center justify-center rounded-full border border-slate-200 bg-white text-slate-400 shadow-sm transition hover:border-rose-200 hover:bg-rose-50 hover:text-rose-500 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-rose-400 dark:border-slate-700 dark:bg-slate-900 dark:hover:border-rose-900 dark:hover:bg-rose-950/30"
                  aria-label={`Remove bookmark for question: ${question.content.substring(0, 50)}...`}
                >
                  <Bookmark className="h-4 w-4 fill-current" aria-hidden="true" />
                </button>

                {isExpanded && (
                  <div
                    id={panelId}
                    role="region"
                    aria-labelledby={headerId}
                    className="border-t border-slate-200/80 bg-slate-50/70 px-5 py-5 dark:border-slate-800 dark:bg-slate-900/50 sm:px-6"
                  >
                    <ul className="grid grid-cols-1 gap-3 md:grid-cols-2" aria-label="Question options">
                      {["a", "b", "c", "d"].map((optionKey) => {
                        const questionOptionKey = `option_${optionKey}` as keyof BookmarkedQuestion;
                        const optionText = question[questionOptionKey] as string;
                        const currentOption = optionKey.toUpperCase();
                        const isCorrectOption = question.correct_option === currentOption;

                        return (
                          <li
                            key={optionKey}
                            className={cn(
                              "rounded-2xl border px-4 py-3 text-sm leading-relaxed transition",
                              isCorrectOption
                                ? "border-emerald-200 bg-emerald-50/80 text-emerald-950 ring-1 ring-emerald-200 dark:border-emerald-900/60 dark:bg-emerald-950/25 dark:text-emerald-100 dark:ring-emerald-900/40"
                                : "border-slate-200 bg-white text-slate-700 dark:border-slate-700 dark:bg-slate-950/80 dark:text-slate-300"
                            )}
                          >
                            <div className="flex items-start gap-3">
                              <span className="mt-0.5 inline-flex h-6 w-6 shrink-0 items-center justify-center rounded-full border border-current/20 bg-current/5 font-semibold text-xs text-inherit">
                                {currentOption}
                              </span>
                              <div className="flex-1">
                                <Lang>{optionText}</Lang>
                              </div>
                              {isCorrectOption && (
                                <CheckCircle2 aria-hidden="true" className="mt-0.5 h-4 w-4 shrink-0 text-emerald-500" />
                              )}
                            </div>
                          </li>
                        );
                      })}
                    </ul>

                    <div className="mt-4 rounded-2xl border border-slate-200 bg-white/90 p-4 shadow-sm dark:border-slate-700 dark:bg-slate-950">
                      <span className="mb-2 block text-xs font-semibold uppercase tracking-[0.18em] text-slate-500 dark:text-slate-400">
                        Explanation
                      </span>
                      <div className="text-sm leading-relaxed text-slate-700 dark:text-slate-300">
                        {question.explanation ? (
                          <RichText>{question.explanation}</RichText>
                        ) : (
                          "No specific database explanation provided."
                        )}
                      </div>
                    </div>
                  </div>
                )}
              </li>
            );
          })
        )}
      </ul>
    </div>
  );
}
