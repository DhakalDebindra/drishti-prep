"use client";

import React, { useState } from "react";
import { CheckCircle2, XCircle, MinusCircle, Bookmark, Flag, ChevronDown, ChevronUp } from "lucide-react";
import { toggleBookmark } from "@/app/actions/practice-actions";
import { ReportIssueModal } from "./ReportIssueModal";

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

  const filteredQuestions = questions.filter((q) => {
    const isSkipped = q.selected_option === null || q.selected_option === "skipped";
    if (filter === "all") return true;
    if (filter === "correct") return q.is_correct;
    if (filter === "incorrect") return !q.is_correct && !isSkipped;
    if (filter === "skipped") return isSkipped;
    return true;
  });

  const handleBookmark = async (id: string, e: React.MouseEvent) => {
    e.stopPropagation();
    
    const isCurrentlyBookmarked = bookmarkedIds.has(id);
    
    // Optimistic toggle
    if (isCurrentlyBookmarked) {
      setBookmarkedIds(prev => {
        const newSet = new Set(prev);
        newSet.delete(id);
        return newSet;
      });
      setAnnouncement("Bookmark removed");
    } else {
      setBookmarkedIds(prev => {
        const newSet = new Set(prev);
        newSet.add(id);
        return newSet;
      });
      setAnnouncement("Question bookmarked");
    }

    const result = await toggleBookmark(id);
    if (!result.success) {
      // Revert on failure
      if (isCurrentlyBookmarked) {
         setBookmarkedIds(prev => {
            const newSet = new Set(prev);
            newSet.add(id);
            return newSet;
         });
         setAnnouncement("Failed to remove bookmark");
      } else {
         setBookmarkedIds(prev => {
            const newSet = new Set(prev);
            newSet.delete(id);
            return newSet;
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
    <div className="space-y-6">
      <div aria-live="polite" aria-atomic="true" className="sr-only">
        {announcement}
      </div>
      <div className="flex items-center justify-between border-b border-slate-200 dark:border-slate-800 pb-4">
        <h3 className="text-lg font-bold text-slate-900 dark:text-white">Question Review</h3>
        <div className="flex bg-slate-100 dark:bg-slate-800 p-1 rounded-lg">
          {(["all", "correct", "incorrect", "skipped"] as const).map((f) => (
            <button
              key={f}
              onClick={() => setFilter(f)}
              aria-pressed={filter === f}
              className={`px-3 py-1.5 text-sm font-medium rounded-md transition-colors focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-1 dark:focus:ring-offset-slate-900 ${
                filter === f
                  ? "bg-white dark:bg-slate-700 text-blue-600 dark:text-blue-400 shadow-sm"
                  : "text-slate-600 dark:text-slate-400 hover:text-slate-900 dark:hover:text-slate-200"
              }`}
            >
              {f.charAt(0).toUpperCase() + f.slice(1)}
            </button>
          ))}
        </div>
      </div>

      <div className="space-y-4">
        {filteredQuestions.length === 0 ? (
          <div className="text-center py-8 text-slate-500">No questions match this filter.</div>
        ) : (
          filteredQuestions.map((q, index) => {
            const isSkipped = q.selected_option === null || q.selected_option === "skipped";
            const isExpanded = expandedId === q.id;
            const statusColor = q.is_correct
              ? "text-green-600 dark:text-green-400"
              : isSkipped
              ? "text-slate-400 dark:text-slate-500"
              : "text-red-600 dark:text-red-400";

            return (
              <div
                key={q.id}
                className="bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 rounded-xl overflow-hidden transition-all duration-200"
              >
                <div
                  className="p-5 flex items-start gap-4 hover:bg-slate-50 dark:hover:bg-slate-800/50"
                >
                  <div className={`mt-0.5 ${statusColor}`} aria-hidden="true">
                    {q.is_correct ? (
                      <CheckCircle2 className="w-5 h-5" />
                    ) : isSkipped ? (
                      <MinusCircle className="w-5 h-5" />
                    ) : (
                      <XCircle className="w-5 h-5" />
                    )}
                  </div>
                  
                  <div className="flex-1 text-left">
                     <div className="flex justify-between items-start">
                        <span className="text-sm font-medium text-slate-500 dark:text-slate-400 mb-1 block">
                          Question {index + 1}
                        </span>
                     </div>
                     <button
                        onClick={() => setExpandedId(isExpanded ? null : q.id)}
                        aria-expanded={isExpanded}
                        aria-controls={`question-panel-${q.id}`}
                        className="w-full text-left font-medium pr-8 focus:outline-none focus:underline"
                     >
                        <p className="text-slate-900 dark:text-white inline">{q.content}</p>
                     </button>
                  </div>

                  <div className="mt-1" aria-hidden="true">
                    <button
                        onClick={() => setExpandedId(isExpanded ? null : q.id)}
                        tabIndex={-1}
                        className="focus:outline-none"
                    >
                      {isExpanded ? (
                        <ChevronUp className="w-5 h-5 text-slate-400" />
                      ) : (
                        <ChevronDown className="w-5 h-5 text-slate-400" />
                      )}
                    </button>
                  </div>
                </div>

                {isExpanded && (
                  <div id={`question-panel-${q.id}`} className="border-t border-slate-100 dark:border-slate-800 p-5 bg-slate-50/50 dark:bg-slate-900/50 space-y-4">
                    <ul className="grid grid-cols-1 md:grid-cols-2 gap-3" aria-label="Question options">
                      {["a", "b", "c", "d"].map((opt) => {
                        const optKey = `option_${opt}` as keyof ReviewQuestion;
                        const optText = q[optKey] as string;
                        
                        const currentOptId = opt.toUpperCase(); // 'A', 'B', 'C', 'D'
                        const isSelected = q.selected_option === currentOptId;
                        const isCorrectOpt = q.correct_option === currentOptId;

                        let optClass = "border-slate-200 dark:border-slate-700 bg-white dark:bg-slate-800 text-slate-700 dark:text-slate-300";
                        let statusAriaLabel = "";
                        
                        if (isCorrectOpt) {
                           optClass = "border-green-500 bg-green-50 dark:bg-green-900/20 text-green-800 dark:text-green-300 ring-1 ring-green-500";
                           statusAriaLabel = isSelected ? "Correct option, selected" : "Correct option";
                        } else if (isSelected && !isCorrectOpt) {
                           optClass = "border-red-500 bg-red-50 dark:bg-red-900/20 text-red-800 dark:text-red-300";
                           statusAriaLabel = "Incorrect option, selected";
                        } else {
                           statusAriaLabel = "Unselected option";
                        }

                        return (
                          <li key={opt} aria-label={statusAriaLabel} className={`p-3 rounded-lg border text-sm flex items-center gap-3 ${optClass}`}>
                             <div className="flex-1">{optText}</div>
                             {isCorrectOpt && <CheckCircle2 aria-hidden="true" className="w-4 h-4 text-green-500" />}
                             {isSelected && !isCorrectOpt && <XCircle aria-hidden="true" className="w-4 h-4 text-red-500" />}
                          </li>
                        );
                      })}
                    </ul>

                    <div className="mt-4 p-4 bg-white dark:bg-slate-800 rounded-lg border border-slate-200 dark:border-slate-700">
                      <span className="text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider mb-2 block">Explanation</span>
                      <p className="text-sm text-slate-700 dark:text-slate-300 leading-relaxed">
                        {q.explanation || "No specific database explanation provided. Check the AI feedback for insights."}
                      </p>
                    </div>

                    <div className="flex justify-end items-center gap-3 pt-4 border-t border-slate-100 dark:border-slate-800 mt-2">
                       <button 
                         onClick={(e) => handleBookmark(q.id, e)} 
                         aria-label={`${bookmarkedIds.has(q.id) ? "Remove bookmark for" : "Bookmark"} question ${index + 1}`}
                         aria-pressed={bookmarkedIds.has(q.id)}
                         className="flex items-center gap-2 px-3 py-1.5 text-xs font-medium text-slate-600 dark:text-slate-400 hover:text-blue-600 dark:hover:text-blue-400 transition-colors rounded-md hover:bg-blue-50 dark:hover:bg-blue-900/10 focus:outline-none focus:ring-2 focus:ring-blue-500"
                       >
                         <Bookmark aria-hidden="true" className={`w-3.5 h-3.5 ${bookmarkedIds.has(q.id) ? "fill-current text-blue-500" : ""}`} />
                         <span>{bookmarkedIds.has(q.id) ? "Bookmarked" : "Bookmark"}</span>
                       </button>
                       <button 
                         onClick={(e) => handleReport(q.id, e)} 
                         aria-label={`Report issue with question ${index + 1}`}
                         className="flex items-center gap-2 px-3 py-1.5 text-xs font-medium text-slate-600 dark:text-slate-400 hover:text-orange-600 dark:hover:text-orange-400 transition-colors rounded-md hover:bg-orange-50 dark:hover:bg-orange-900/10 focus:outline-none focus:ring-2 focus:ring-orange-500"
                       >
                         <Flag className="w-3.5 h-3.5" />
                         <span>Report Issue</span>
                       </button>
                    </div>
                  </div>
                )}
              </div>
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
    </div>
  );
}
