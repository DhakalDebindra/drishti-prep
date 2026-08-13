"use client";

import { CheckCircle2, ChevronDown, ChevronUp } from "lucide-react";
import { useId, useState } from "react";

import { Lang } from "@/components/ui/Lang";
import { RichText } from "@/components/ui/RichText";
import { SearchResultsCopy } from "@/config/copy";
import type { SearchQuestion } from "@/lib/search/types";

const OPTION_KEYS = ["a", "b", "c", "d"] as const;

/**
 * A matched question, with its answer.
 *
 * Search used to list stems only, on the reasoning that showing answers spoils
 * practice. In real use that was backwards: someone searching "नेपालका झरना"
 * wants to know about the waterfalls, and a list of questions with the answers
 * withheld sends them away to find what they just asked for. The answer is the
 * result; the practice sets below are the offer.
 *
 * Presentation follows the review page — same option grid, same correct-answer
 * marking, same explanation block — so a learner meets one consistent way of
 * reading a question across the whole platform.
 */
export function SearchQuestionCard({
  question,
  defaultOpen = false,
}: {
  question: SearchQuestion;
  defaultOpen?: boolean;
}) {
  const [open, setOpen] = useState(defaultOpen);
  const panelId = useId();

  const options = OPTION_KEYS.map((key) => ({
    key,
    letter: key.toUpperCase(),
    text: question[`option_${key}` as const],
  })).filter((option) => Boolean(option.text));

  return (
    <article className="overflow-hidden rounded-xl border-2 border-border bg-card">
      <button
        type="button"
        onClick={() => setOpen((value) => !value)}
        aria-expanded={open}
        aria-controls={panelId}
        className="flex w-full min-h-11 items-start justify-between gap-3 px-4 py-3 text-left transition hover:bg-muted focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-inset focus-visible:ring-ring"
      >
        <span className="min-w-0">
          <Lang as="span" className="block font-medium text-foreground">
            {question.content}
          </Lang>
          <span className="mt-1 block text-xs text-muted-foreground">
            <Lang>{question.set_title}</Lang>
          </span>
        </span>
        {open ? (
          <ChevronUp className="mt-0.5 h-5 w-5 shrink-0 text-muted-foreground" aria-hidden="true" />
        ) : (
          <ChevronDown className="mt-0.5 h-5 w-5 shrink-0 text-muted-foreground" aria-hidden="true" />
        )}
      </button>

      {open && (
        <div
          id={panelId}
          className="space-y-4 border-t-2 border-border bg-muted/40 px-4 py-4"
        >
          <ul className="grid grid-cols-1 gap-2 md:grid-cols-2" aria-label={SearchResultsCopy.optionsLabelNe}>
            {options.map((option) => {
              const isCorrect = question.correct_option?.toUpperCase() === option.letter;
              return (
                <li
                  key={option.key}
                  className={`flex items-center gap-2 rounded-lg border-2 px-3 py-2 text-sm ${
                    isCorrect
                      ? "border-success/40 bg-success/10 text-success"
                      : "border-border bg-background text-foreground"
                  }`}
                >
                  <span className="flex-1">
                    <Lang>{option.text}</Lang>
                  </span>
                  {isCorrect && (
                    <>
                      <CheckCircle2 className="h-4 w-4 shrink-0" aria-hidden="true" />
                      {/* Colour alone must never carry the answer. */}
                      <span className="sr-only">{SearchResultsCopy.correctAnswerNe}</span>
                    </>
                  )}
                </li>
              );
            })}
          </ul>

          {question.explanation && (
            <div className="rounded-lg border-2 border-border bg-background p-3">
              <h4 className="mb-1 text-xs font-bold uppercase tracking-wider text-muted-foreground">
                {SearchResultsCopy.explanationNe}
              </h4>
              <div className="text-sm leading-relaxed text-foreground">
                <RichText>{question.explanation}</RichText>
              </div>
            </div>
          )}
        </div>
      )}
    </article>
  );
}
