"use client";

import Link from "next/link";
import { Info, Loader2, Lock, MessageCircle, Send, Sparkles } from "lucide-react";
import { useCallback, useEffect, useId, useRef, useState } from "react";

import { Lang } from "@/components/ui/Lang";
import { ListenButton } from "@/components/ask/ListenButton";
import { AskChatCopy, AskRouteCopy } from "@/config/copy";
import type { LessonRecommendation, LessonSection, LessonSource } from "@/lib/ask/types";

type AssistantTurn = {
  kind: "assistant";
  route:
    | "lesson"
    | "greeting"
    | "clarify"
    | "outside"
    | "insufficient"
    | "rate_limited"
    | "error";
  message: string;
  clarifications: string[];
  sections: LessonSection[];
  sources: LessonSource[];
  recommendations: LessonRecommendation[];
  lockedNote: { count: number; sets: { title: string; module_name: string }[] } | null;
  plainText: string;
  /** Signature that lets this exact reply be read aloud without storing it. */
  speechToken: string;
};

type Turn = { kind: "user"; text: string } | AssistantTurn;

/**
 * The chat surface. All wording lives in `@/config/copy` so an editor can
 * rewrite it without reading this file.
 */
export function AskChat({ initialQuery }: { initialQuery: string }) {
  const inputId = useId();
  const [turns, setTurns] = useState<Turn[]>(
    initialQuery ? [{ kind: "user", text: initialQuery }] : []
  );
  // Seeded from the initial query so the effect below never has to call
  // setState synchronously on mount.
  const [pending, setPending] = useState(Boolean(initialQuery));
  const [error, setError] = useState<string | null>(null);
  const [announcement, setAnnouncement] = useState("");
  const [draft, setDraft] = useState("");
  const startedRef = useRef(false);

  const send = useCallback(
    async (question: string, alreadyShown = false) => {
      const trimmed = question.trim();
      if (!trimmed) return;

      setError(null);
      setAnnouncement("");
      if (!alreadyShown) {
        setTurns((prev) => [...prev, { kind: "user", text: trimmed }]);
        setPending(true);
      }

      try {
        const response = await fetch("/api/ask", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ query: trimmed }),
        });

        if (!response.ok) {
          const payload = await response.json().catch(() => null);
          throw new Error(payload?.error || "Request failed");
        }

        const data = await response.json();

        setTurns((prev) => [
          ...prev,
          {
            kind: "assistant",
            route: data.route,
            message: data.message ?? "",
            clarifications: data.clarifications ?? [],
            sections: data.sections ?? [],
            sources: data.sources ?? [],
            recommendations: data.recommendations ?? [],
            lockedNote: data.lockedNote ?? null,
            plainText: data.plainText ?? "",
            speechToken: data.speechToken ?? "",
          },
        ]);
        // Announced once, on completion. Streaming into a live region makes a
        // screen reader re-read the changing text as a stutter.
        setAnnouncement(AskChatCopy.readyAnnouncementNe);
      } catch (caught) {
        setError(
          caught instanceof Error ? caught.message : "Something went wrong"
        );
        setAnnouncement(AskChatCopy.failedAnnouncementNe);
      } finally {
        setPending(false);
      }
    },
    []
  );

  useEffect(() => {
    if (!initialQuery || startedRef.current) return;
    startedRef.current = true;
    // The learner already chose this question by clicking it, so it runs
    // without a second confirmation.
    void send(initialQuery, true);
  }, [initialQuery, send]);

  function onSubmit(event: React.FormEvent<HTMLFormElement>) {
    event.preventDefault();
    const question = draft;
    setDraft("");
    void send(question);
  }

  return (
    <div className="space-y-8">
      <p aria-live="polite" className="sr-only">
        {announcement}
      </p>

      {turns.length === 0 && (
        <section
          aria-labelledby="ask-suggestions-heading"
          className="rounded-2xl border-2 border-border bg-card p-5 sm:p-6"
        >
          <h2
            id="ask-suggestions-heading"
            className="flex items-center gap-2 text-lg font-bold text-foreground"
          >
            <Sparkles className="h-5 w-5 text-primary" aria-hidden="true" />
            {AskChatCopy.openingHeadingNe}
          </h2>
          <ul className="mt-4 space-y-2">
            {AskChatCopy.openingSuggestionsNe.map((suggestion) => (
              <li key={suggestion}>
                <button
                  type="button"
                  onClick={() => void send(suggestion)}
                  className="flex min-h-11 w-full items-center gap-2 rounded-xl border-2 border-border bg-background px-4 py-3 text-left text-foreground transition hover:bg-muted focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring"
                >
                  <MessageCircle
                    className="h-4 w-4 shrink-0 text-muted-foreground"
                    aria-hidden="true"
                  />
                  <Lang>{suggestion}</Lang>
                </button>
              </li>
            ))}
          </ul>
        </section>
      )}

      <ol className="space-y-8">
        {turns.map((turn, index) =>
          turn.kind === "user" ? (
            <li key={index}>
              <h2 className="text-lg font-bold text-foreground">
                <span className="sr-only">{AskChatCopy.yourQuestionSrNe}</span>
                <Lang>{turn.text}</Lang>
              </h2>
            </li>
          ) : (
            <li key={index}>
              <AssistantReply turn={turn} onAsk={(q) => void send(q)} />
            </li>
          )
        )}
      </ol>

      {/*
        A quiet indicator rather than narration. "सोच्दै" claims the machine is
        thinking, which is both untrue and, on a screen reader, one more line to
        sit through before the answer arrives.
      */}
      {pending && (
        <p className="flex items-center gap-2 px-1 text-muted-foreground">
          <Loader2 className="h-4 w-4 animate-spin" aria-hidden="true" />
          <span className="sr-only">{AskChatCopy.pendingSrNe}</span>
          <span aria-hidden="true">•••</span>
        </p>
      )}

      {error && (
        <p
          role="alert"
          className="rounded-xl border-2 border-destructive/40 bg-destructive/10 px-4 py-3 text-foreground"
        >
          {error}
        </p>
      )}

      <form onSubmit={onSubmit} className="flex items-stretch gap-2">
        <label htmlFor={inputId} className="sr-only">
          {AskChatCopy.inputLabelNe}
        </label>
        <input
          id={inputId}
          value={draft}
          onChange={(event) => setDraft(event.target.value)}
          placeholder={AskChatCopy.inputPlaceholderNe}
          autoComplete="off"
          disabled={pending}
          className="min-h-11 flex-1 rounded-lg border-2 border-border bg-background px-3 py-2 text-foreground placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring disabled:opacity-60"
        />
        <button
          type="submit"
          disabled={pending || !draft.trim()}
          className="inline-flex min-h-11 shrink-0 items-center gap-2 rounded-lg border-2 border-primary bg-primary px-4 py-2 text-sm font-semibold text-primary-foreground transition hover:opacity-90 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:opacity-50"
        >
          <Send className="h-4 w-4" aria-hidden="true" />
          {AskChatCopy.sendNe}
        </button>
      </form>
    </div>
  );
}

function AssistantReply({
  turn,
  onAsk,
}: {
  turn: AssistantTurn;
  onAsk: (question: string) => void;
}) {
  return (
    <article className="rounded-2xl border-2 border-border bg-card p-5 sm:p-6">
      {/*
        Listen sits at the top, beside the name. Someone who wants to hear the
        answer rather than read it should not have to travel past the whole
        answer to reach the control for it.
      */}
      <div className="flex flex-wrap items-center justify-between gap-3">
        <p className="flex items-center gap-2 text-sm font-semibold text-primary">
          <Sparkles className="h-4 w-4" aria-hidden="true" />
          {AskChatCopy.assistantName}
        </p>
        {turn.plainText && (
          <ListenButton text={turn.plainText} token={turn.speechToken} />
        )}
      </div>

      {/* The model's own words for greeting / clarify / outside; a short fixed
          line for the failure routes. */}
      {(turn.message || AskRouteCopy[turn.route]) && (
        <Lang as="p" className="mt-3 leading-relaxed text-foreground">
          {turn.message || AskRouteCopy[turn.route]}
        </Lang>
      )}

      {/*
        A compact marker, not a notice. An answer from outside DrishtiPrep still
        has to be distinguishable from verified exam content — that is what the
        platform is trusted for — but two sentences of disclaimer on every such
        reply reads as a warning label rather than a chat.
      */}
      {turn.route === "outside" && (
        <p className="mt-2 inline-flex items-center gap-1.5 rounded-md border border-amber-500/50 bg-amber-500/10 px-2 py-1 text-xs font-medium text-foreground">
          <Info className="h-3.5 w-3.5" aria-hidden="true" />
          <Lang>{AskChatCopy.outsideBadgeNe}</Lang>
        </p>
      )}

      {turn.clarifications.length > 0 && (
        <ul className="mt-4 space-y-2">
          {turn.clarifications.map((option) => (
            <li key={option}>
              <button
                type="button"
                onClick={() => onAsk(option)}
                className="flex min-h-11 w-full items-center gap-2 rounded-xl border-2 border-border bg-background px-4 py-3 text-left text-foreground transition hover:bg-muted focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring"
              >
                <MessageCircle
                  className="h-4 w-4 shrink-0 text-muted-foreground"
                  aria-hidden="true"
                />
                <Lang>{option}</Lang>
              </button>
            </li>
          ))}
        </ul>
      )}

      {/*
        Real headings, always in the same order. This is what makes a longer
        lesson usable by ear: a screen-reader user jumps heading to heading
        instead of listening straight through.
      */}
      {turn.sections.map((section) => (
        <section key={section.key} className="mt-5">
          <h3 className="text-base font-semibold text-foreground">
            <Lang>{section.title}</Lang>
          </h3>
          {section.body && (
            <Lang as="p" className="mt-1 leading-relaxed text-foreground">
              {section.body}
            </Lang>
          )}
          {section.bullets && section.bullets.length > 0 && (
            <ul className="mt-2 list-disc space-y-1 pl-5">
              {section.bullets.map((bullet, index) => (
                <li key={index} className="text-foreground">
                  <Lang>{bullet}</Lang>
                </li>
              ))}
            </ul>
          )}
        </section>
      ))}

      {turn.sources.length > 0 && (
        <section className="mt-5">
          <h3 className="text-base font-semibold text-foreground">
            <Lang>{AskChatCopy.sourcesNe}</Lang>
          </h3>
          <ul className="mt-1 space-y-1">
            {turn.sources.map((source) => (
              <li key={source.set_id} className="text-sm text-muted-foreground">
                <Lang>{source.set_title}</Lang> — {source.question_count}{" "}
                {AskChatCopy.questionsSuffixNe}
              </li>
            ))}
          </ul>
        </section>
      )}

      {turn.lockedNote && (
        <p className="mt-4 flex items-start gap-2 rounded-xl border-2 border-border bg-muted px-3 py-2 text-sm text-foreground">
          <Lock className="mt-0.5 h-4 w-4 shrink-0" aria-hidden="true" />
          <span>
            <Lang>
              {AskChatCopy.lockedNoteNe(
                turn.lockedNote.count,
                turn.lockedNote.sets[0]?.module_name ?? ""
              )}
            </Lang>
          </span>
        </p>
      )}

      {turn.recommendations.length > 0 && (
        <section className="mt-6">
          <h3 className="text-base font-semibold text-foreground">
            <Lang>{AskChatCopy.practiceSetsNe}</Lang>
          </h3>
          <ul className="mt-2 space-y-2">
            {turn.recommendations.map((rec) => {
              const label = (
                <>
                  <span className="min-w-0">
                    <Lang>{rec.title}</Lang>
                    <span className="block text-xs text-muted-foreground">
                      <Lang>{rec.topic_name}</Lang>
                      {rec.subtopic_name && (
                        <>
                          {" › "}
                          <Lang>{rec.subtopic_name}</Lang>
                        </>
                      )}
                    </span>
                  </span>
                  <span className="shrink-0 text-sm text-muted-foreground">
                    {rec.q_count} {AskChatCopy.questionsSuffixNe}
                  </span>
                </>
              );
              const shell =
                "flex min-h-11 flex-wrap items-center justify-between gap-3 rounded-xl border-2 border-border bg-background px-4 py-3";
              return (
                <li key={rec.set_id}>
                  {rec.href ? (
                    <Link
                      href={rec.href}
                      className={`${shell} transition hover:bg-muted focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring`}
                    >
                      {label}
                    </Link>
                  ) : (
                    <div className={shell}>{label}</div>
                  )}
                </li>
              );
            })}
          </ul>
        </section>
      )}

    </article>
  );
}
