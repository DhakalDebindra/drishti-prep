"use client";

import React, { useState } from "react";
import { CheckCircle2, XCircle, MinusCircle, Bookmark, Flag, ChevronDown, ChevronUp, Filter } from "lucide-react";
import { Lang } from "@/components/ui/Lang";
import { RichText } from "@/components/ui/RichText";
import { toggleBookmark } from "@/app/actions/practice-actions";
import { ReportIssueModal } from "./ReportIssueModal";
import { QuestionContent } from "./QuestionContent";

export type ReviewQuestion = {
  id: string;
  content: string;
  option_a: string;
  option_b: string;
  option_c: string;
  option_d: string;
  correct_option: string;
  selected_option: string | null;
  is_correct: boolean;
  explanation: string | null;
};

interface QuestionReviewListProps {
  questions: ReviewQuestion[];
  initialBookmarkedIds?: string[];
}

export function QuestionReviewList({ questions, initialBookmarkedIds = [] }: QuestionReviewListProps) {
  const [filter, setFilter] = useState<"all" | "correct" | "incorrect" | "skipped">("all");
  const [expandedId, setExpandedId] = useState<string | null>(questions[0]?.id || null);
  const [bookmarkedIds, setBookmarkedIds] = useState<Set<string>>(new Set(initialBookmarkedIds));
  const [reportingQuestionId, setReportingQuestionId] = useState<string | null>(null);
  const [announcement, setAnnouncement] = useState("");

  const filteredQuestions = questions.filter((question) => {
    const isSkipped = question.selected_option === null || question.selected_option === "skipped";
    if (filter === "all") return true;
    if (filter === "correct") return question.is_correct;
    if (filter === "incorrect") return !question.is_correct && !isSkipped;
    if (filter === "skipped") return isSkipped;
    return true;
  });

  const handleBookmark = async (id: string, e: React.MouseEvent) => {
    e.stopPropagation();

    const isCurrentlyBookmarked = bookmarkedIds.has(id);

    if (isCurrentlyBookmarked) {
      setBookmarkedIds((prev) => {
        const next = new Set(prev);
        next.delete(id);
        return next;
      });
      setAnnouncement("Bookmark removed");
    } else {
      setBookmarkedIds((prev) => {
        const next = new Set(prev);
        next.add(id);
        return next;
      });
      setAnnouncement("Question bookmarked");
    }

    const result = await toggleBookmark(id);
    if (!result.success) {
      if (isCurrentlyBookmarked) {
        setBookmarkedIds((prev) => {
          const next = new Set(prev);
          next.add(id);
          return next;
        });
        setAnnouncement("Failed to remove bookmark");
      } else {
        setBookmarkedIds((prev) => {
          const next = new Set(prev);
          next.delete(id);
          return next;
        });
        setAnnouncement("Failed to bookmark question");
      }
      alert(result.error || "Failed to update bookmark status");
    }
  };

  const handleReport = (id: string, e: React.MouseEvent) => {
    e.stopPropagation();
    setReportingQuestionId(id);
  };

  return (
    <section className="space-y-6">
      <div aria-live="polite" aria-atomic="true" className="sr-only">
        {announcement}
      </div>

      <div className="flex flex-col gap-4 rounded-[2rem] border border-white/70 bg-white/85 p-5 shadow-[0_18px_50px_rgba(15,23,42,0.08)] backdrop-blur-xl dark:border-slate-800 dark:bg-slate-950/70 sm:flex-row sm:items-center sm:justify-between sm:p-6">
        <div>
          <p className="text-xs font-semibold uppercase tracking-[0.24em] text-slate-500 dark:text-slate-400">
            Review
          </p>
          <h3 className="mt-1 text-xl font-bold tracking-tight text-slate-950 dark:text-white">
            Question Review
          </h3>
          <p className="mt-1 text-sm text-slate-600 dark:text-slate-300">
            Review what you answered, what you skipped, and where to focus next.
          </p>
        </div>

        <div className="flex flex-wrap gap-2 rounded-full border border-slate-200 bg-slate-50 p-1.5 dark:border-slate-800 dark:bg-slate-900/60">
          {(["all", "correct", "incorrect", "skipped"] as const).map((item) => (
            <button
              key={item}
              onClick={() => setFilter(item)}
              aria-pressed={filter === item}
              className={`inline-flex items-center gap-2 rounded-full px-4 py-2 text-sm font-medium transition focus:outline-none focus:ring-2 focus:ring-ring focus:ring-offset-2 focus:ring-offset-white dark:focus:ring-offset-slate-950 ${
                filter === item
                  ? "bg-primary/10 text-primary shadow-sm"
                  : "text-slate-600 hover:text-slate-900 dark:text-slate-300 dark:hover:text-white"
              }`}
            >
              {item === "all" && <Filter className="h-4 w-4" />}
              {item.charAt(0).toUpperCase() + item.slice(1)}
            </button>
          ))}
        </div>
      </div>

      <div className="space-y-4">
        {filteredQuestions.length === 0 ? (
          <div className="rounded-[1.75rem] border border-slate-200 bg-white/85 px-6 py-10 text-center text-slate-600 shadow-sm backdrop-blur-xl dark:border-slate-800 dark:bg-slate-950/70 dark:text-slate-300">
            No questions match this filter.
          </div>
        ) : (
          filteredQuestions.map((question, index) => {
            const isSkipped = question.selected_option === null || question.selected_option === "skipped";
            const isExpanded = expandedId === question.id;
            const statusColor = question.is_correct
              ? "text-success"
              : isSkipped
              ? "text-slate-400 dark:text-slate-500"
              : "text-destructive";

            return (
              <article
                key={question.id}
                className="overflow-hidden rounded-[1.75rem] border border-slate-200 bg-white/85 shadow-sm backdrop-blur-xl transition dark:border-slate-800 dark:bg-slate-950/70"
              >
                <div className="flex items-start gap-4 p-5 transition hover:bg-slate-50/80 dark:hover:bg-slate-900/50">
                  <div className={`mt-0.5 ${statusColor}`} aria-hidden="true">
                    {question.is_correct ? (
                      <CheckCircle2 className="h-5 w-5" />
                    ) : isSkipped ? (
                      <MinusCircle className="h-5 w-5" />
                    ) : (
                      <XCircle className="h-5 w-5" />
                    )}
                  </div>

                  <div className="min-w-0 flex-1 text-left">
                    <span className="mb-2 block text-sm font-medium text-slate-500 dark:text-slate-400">
                      Question {index + 1}
                    </span>
                    <button
                      onClick={() => setExpandedId(isExpanded ? null : question.id)}
                      aria-expanded={isExpanded}
                      aria-controls={`question-panel-${question.id}`}
                      className="w-full text-left focus:outline-none"
                    >
                      <p className="inline text-base font-semibold leading-relaxed text-slate-950 dark:text-white">
                        <Lang>{question.content.split(/\r?\n/, 1)[0]}</Lang>
                      </p>
                    </button>
                  </div>

                  <button
                    onClick={() => setExpandedId(isExpanded ? null : question.id)}
                    aria-label={isExpanded ? "Collapse question" : "Expand question"}
                    className="mt-1 rounded-full p-1.5 text-slate-400 transition hover:bg-slate-100 hover:text-slate-700 focus:outline-none focus:ring-2 focus:ring-ring dark:hover:bg-slate-900 dark:hover:text-slate-200"
                  >
                    {isExpanded ? (
                      <ChevronUp className="h-5 w-5" />
                    ) : (
                      <ChevronDown className="h-5 w-5" />
                    )}
                  </button>
                </div>

                {isExpanded && (
                  <div
                    id={`question-panel-${question.id}`}
                    className="space-y-4 border-t border-slate-200 bg-slate-50/70 p-5 dark:border-slate-800 dark:bg-slate-900/50"
                  >
                    {question.content.includes("\n") ? (
                      <QuestionContent
                        content={question.content}
                        className="text-base leading-relaxed text-slate-900 dark:text-white"
                      />
                    ) : null}

                    <ul className="grid grid-cols-1 gap-3 md:grid-cols-2" aria-label="Question options">
                      {["a", "b", "c", "d"].map((opt) => {
                        const optKey = `option_${opt}` as keyof ReviewQuestion;
                        const optText = question[optKey] as string;
                        const currentOptId = opt.toUpperCase();
                        const isSelected = question.selected_option === currentOptId;
                        const isCorrectOpt = question.correct_option === currentOptId;

                        const optionClass = isCorrectOpt
                          ? "border-success/30 bg-success/10 text-success-foreground"
                          : isSelected
                          ? "border-destructive/30 bg-destructive/10 text-destructive-foreground"
                          : "border-slate-200 bg-white text-slate-700 dark:border-slate-700 dark:bg-slate-950 dark:text-slate-300";

                        return (
                          <li
                            key={opt}
                            className={`flex items-center gap-3 rounded-[1.25rem] border p-3 text-sm ${optionClass}`}
                            aria-label={
                              isCorrectOpt
                                ? isSelected
                                  ? "Correct option, selected"
                                  : "Correct option"
                                : isSelected
                                ? "Incorrect option, selected"
                                : "Unselected option"
                            }
                          >
                            <div className="flex-1">
                              <Lang>{optText}</Lang>
                            </div>
                            {isCorrectOpt && <CheckCircle2 aria-hidden="true" className="h-4 w-4 text-success" />}
                            {isSelected && !isCorrectOpt && <XCircle aria-hidden="true" className="h-4 w-4 text-destructive" />}
                          </li>
                        );
                      })}
                    </ul>

                    <div className="rounded-[1.4rem] border border-slate-200 bg-white p-4 shadow-sm dark:border-slate-800 dark:bg-slate-950/70">
                      <span className="mb-2 block text-xs font-bold uppercase tracking-[0.24em] text-slate-500 dark:text-slate-400">
                        Explanation
                      </span>
                      <div className="text-sm leading-relaxed text-slate-700 dark:text-slate-300">
                        {question.explanation
                          ? <RichText>{question.explanation}</RichText>
                          : "No specific database explanation provided. Check the AI feedback for insights."}
                      </div>
                    </div>

                    <div className="flex flex-wrap items-center justify-end gap-3 pt-2">
                      <button
                        onClick={(e) => handleBookmark(question.id, e)}
                        aria-label={`${bookmarkedIds.has(question.id) ? "Remove bookmark for" : "Bookmark"} question ${index + 1}`}
                        aria-pressed={bookmarkedIds.has(question.id)}
                        className="inline-flex items-center gap-2 rounded-full border border-slate-200 bg-white px-3 py-1.5 text-xs font-medium text-slate-600 transition hover:bg-primary/10 hover:text-primary focus:outline-none focus:ring-2 focus:ring-ring dark:border-slate-700 dark:bg-slate-950 dark:text-slate-300 dark:hover:bg-primary/10 dark:hover:text-primary"
                      >
                        <Bookmark aria-hidden="true" className={`h-3.5 w-3.5 ${bookmarkedIds.has(question.id) ? "fill-current text-primary" : ""}`} />
                        <span>{bookmarkedIds.has(question.id) ? "Bookmarked" : "Bookmark"}</span>
                      </button>
                      <button
                        onClick={(e) => handleReport(question.id, e)}
                        aria-label={`Report issue with question ${index + 1}`}
                        className="inline-flex items-center gap-2 rounded-full border border-slate-200 bg-white px-3 py-1.5 text-xs font-medium text-slate-600 transition hover:bg-amber-50 hover:text-amber-700 focus:outline-none focus:ring-2 focus:ring-ring dark:border-slate-700 dark:bg-slate-950 dark:text-slate-300 dark:hover:bg-slate-900 dark:hover:text-amber-300"
                      >
                        <Flag className="h-3.5 w-3.5" />
                        <span>Report issue</span>
                      </button>
                    </div>
                  </div>
                )}
              </article>
            );
          })
        )}
      </div>

      {reportingQuestionId && (
        <ReportIssueModal
          isOpen={true}
          onClose={() => setReportingQuestionId(null)}
          questionId={reportingQuestionId}
        />
      )}
    </section>
  );
}
