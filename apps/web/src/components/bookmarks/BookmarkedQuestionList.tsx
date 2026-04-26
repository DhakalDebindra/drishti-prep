"use client";

import React, { useState } from "react";
import { 
  Bookmark, 
  ChevronDown, 
  ChevronUp, 
  CheckCircle2, 
  ArrowLeft,
  BookOpen
} from "lucide-react";
import Link from "next/link";
import { Lang } from "@/components/ui/Lang";
import { toggleBookmark } from "@/app/actions/practice-actions";

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
    
    // Optimistic UI: Immediately remove from list
    const questionToRemove = questions.find(q => q.question_id === questionId);
    if (!questionToRemove) return;

    setQuestions(prev => prev.filter(q => q.question_id !== questionId));
    setAnnouncement("Bookmark removed");

    const result = await toggleBookmark(questionId);
    
    if (!result.success) {
      // Revert if failed
      setQuestions(prev => {
        // Try to keep original order if possible, though chronological is sorting by created_at anyway
        const newList = [...prev, questionToRemove];
        return newList.sort((a, b) => new Date(b.created_at).getTime() - new Date(a.created_at).getTime());
      });
      setAnnouncement("Failed to remove bookmark");
      alert(result.error || "Failed to update bookmark");
    }
  };

  return (
    <div className="max-w-4xl mx-auto px-4 py-8 space-y-6">
      <div aria-live="polite" aria-atomic="true" className="sr-only">
        {announcement}
      </div>

      <div className="flex flex-col gap-4 md:flex-row md:items-center md:justify-between border-b border-slate-200 dark:border-slate-800 pb-6">
        <div>
          <h1 id="main-heading" className="text-2xl font-bold text-slate-900 dark:text-white flex items-center gap-2">
            <Bookmark className="w-6 h-6 text-blue-500" />
            My Bookmarks
          </h1>
          <p className="text-slate-500 dark:text-slate-400 text-sm mt-1">
            Review and master your saved questions.
          </p>
        </div>
        
        <div className="flex items-center gap-2 px-3 py-1.5 bg-blue-50 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 rounded-lg text-sm font-medium">
          <BookOpen className="w-4 h-4" />
          <span>{questions.length} Saved Questions</span>
        </div>
      </div>

      <ul className="space-y-4">
        {questions.length === 0 ? (
          <div className="text-center py-20 bg-slate-50 dark:bg-slate-900/50 rounded-2xl border-2 border-dashed border-slate-200 dark:border-slate-800">
            <div className="bg-white dark:bg-slate-800 w-16 h-16 rounded-full flex items-center justify-center mx-auto mb-4 shadow-sm">
              <Bookmark className="w-8 h-8 text-slate-300 dark:text-slate-600" />
            </div>
            <h3 className="text-lg font-medium text-slate-900 dark:text-white">No bookmarks yet</h3>
            <p className="text-slate-500 dark:text-slate-400 max-w-xs mx-auto mt-2 text-sm">
              Questions you bookmark during practice sessions will appear here for review.
            </p>
            <Link 
              href="/practice"
              className="mt-6 inline-flex items-center px-4 py-2 bg-blue-600 hover:bg-blue-700 text-white text-sm font-medium rounded-lg transition-colors"
            >
              Start Practicing
            </Link>
          </div>
        ) : (
          questions.map((q, index) => {
            const isExpanded = expandedId === q.question_id;
            const panelId = `question-panel-${q.question_id}`;
            const headerId = `question-header-${q.question_id}`;
            
            return (
              <li
                key={q.question_id}
                className="bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 rounded-xl overflow-hidden transition-all duration-200 shadow-sm hover:shadow-md"
              >
                <button
                  id={headerId}
                  className="w-full p-5 flex items-start gap-4 text-left hover:bg-slate-50 dark:hover:bg-slate-800/50 focus:outline-none focus:ring-2 focus:ring-inset focus:ring-blue-500"
                  onClick={() => setExpandedId(isExpanded ? null : q.question_id)}
                  aria-expanded={isExpanded}
                  aria-controls={panelId}
                >
                  <div className="mt-0.5 text-blue-500" aria-hidden="true">
                    <Bookmark className="w-5 h-5 fill-current" />
                  </div>
                  
                  <div className="flex-1 text-left">
                    <div className="flex justify-between items-start gap-2 mb-1">
                      <span className="text-[10px] font-bold uppercase tracking-wider text-slate-400 dark:text-slate-500 bg-slate-100 dark:bg-slate-800 px-2 py-0.5 rounded">
                        <Lang>{q.set_title}</Lang>
                      </span>
                    </div>
                    <div className="font-medium text-slate-900 dark:text-white pr-8">
                       <Lang>{q.content}</Lang>
                    </div>
                  </div>

                  <div className="mt-1 flex items-center gap-2" aria-hidden="true">
                    <button
                        onClick={(e) => {
                          e.stopPropagation();
                          handleUnbookmark(q.question_id, e);
                        }}
                        className="p-1.5 text-slate-400 hover:text-red-500 transition-colors rounded-md hover:bg-red-50 dark:hover:bg-red-900/10"
                        aria-label={`Remove bookmark for question: ${q.content.substring(0, 50)}...`}
                    >
                       <Bookmark aria-hidden="true" className="w-4 h-4 fill-current text-blue-500 hover:text-red-500" />
                    </button>
                    <div className="p-1 text-slate-400">
                      {isExpanded ? (
                        <ChevronUp className="w-5 h-5" />
                      ) : (
                        <ChevronDown className="w-5 h-5" />
                      )}
                    </div>
                  </div>
                </button>

                {isExpanded && (
                  <div 
                    id={panelId}
                    role="region"
                    aria-labelledby={headerId}
                    className="border-t border-slate-100 dark:border-slate-800 p-5 bg-slate-50/50 dark:bg-slate-900/50 space-y-4"
                  >
                    <ul className="grid grid-cols-1 md:grid-cols-2 gap-3" aria-label="Question options">
                      {["a", "b", "c", "d"].map((opt) => {
                        const optKey = `option_${opt}` as keyof BookmarkedQuestion;
                        const optText = q[optKey] as string;
                        
                        const currentOptId = opt.toUpperCase(); // 'A', 'B', 'C', 'D'
                        const isCorrectOpt = q.correct_option === currentOptId;

                        let optClass = "border-slate-200 dark:border-slate-700 bg-white dark:bg-slate-800 text-slate-700 dark:text-slate-300";
                        
                        if (isCorrectOpt) {
                           optClass = "border-green-500 bg-green-50 dark:bg-green-900/20 text-green-800 dark:text-green-300 ring-1 ring-green-500";
                        }

                        return (
                          <li 
                            key={opt} 
                            className={`p-3 rounded-lg border text-sm flex items-center gap-3 ${optClass}`}
                          >
                             <div className="flex-1"><Lang>{optText}</Lang></div>
                             {isCorrectOpt && (
                               <>
                                 <CheckCircle2 aria-hidden="true" className="w-4 h-4 text-green-500" />
                                 <span className="sr-only">(Correct Answer)</span>
                               </>
                             )}
                          </li>
                        );
                      })}
                    </ul>

                    <div className="mt-4 p-4 bg-white dark:bg-slate-800 rounded-lg border border-slate-200 dark:border-slate-700">
                      <span className="text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider mb-2 block">Explanation</span>
                      <p className="text-sm text-slate-700 dark:text-slate-300 leading-relaxed">
                        {q.explanation ? <Lang>{q.explanation}</Lang> : "No specific database explanation provided."}
                      </p>
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
