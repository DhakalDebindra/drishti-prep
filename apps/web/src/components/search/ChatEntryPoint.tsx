import Link from "next/link";
import { MessageCircle, Sparkles } from "lucide-react";

import { ChatEntryCopy } from "@/config/copy";
import { Lang } from "@/components/ui/Lang";
import { suggestedQuestions } from "@/lib/search/suggestions";
import type { SearchPayload } from "@/lib/search/types";

/**
 * The doorway from the results page into the AI chat.
 *
 * It sits below the results deliberately: the catalogue answers first, costs
 * nothing, and never waits on a model. The AI runs only when a learner asks it
 * to — which is what keeps this feature cheap and keeps search working even
 * when the model does not.
 *
 * When the search found nothing, this stops being a footnote and becomes the
 * main thing on the page.
 */
export function ChatEntryPoint({ payload }: { payload: SearchPayload }) {
  const suggestions = suggestedQuestions(payload);
  // Locked matches are still matches: the page is not empty, so the chat entry
  // should not take over as if it were the last resort.
  const foundNothing =
    payload.results.counts.sets === 0 &&
    payload.results.counts.questions === 0 &&
    payload.results.counts.topics === 0 &&
    payload.results.locked_courses.length === 0;

  return (
    <section
      aria-labelledby="chat-entry-heading"
      className={`rounded-2xl border-2 p-5 shadow-sm sm:p-6 ${
        foundNothing
          ? "border-primary bg-primary/5"
          : "border-border bg-card"
      }`}
    >
      <h2
        id="chat-entry-heading"
        className="flex items-center gap-2 text-lg font-bold text-foreground"
      >
        <Sparkles className="h-5 w-5 text-primary" aria-hidden="true" />
        {ChatEntryCopy.heading}
      </h2>

      {suggestions.length > 0 && (
        <ul className="mt-4 space-y-2">
          {suggestions.map((suggestion) => (
            <li key={suggestion.text}>
              <Link
                href={`/ask?q=${encodeURIComponent(suggestion.text)}`}
                className="flex min-h-11 items-center gap-2 rounded-xl border-2 border-border bg-background px-4 py-3 text-left text-foreground transition hover:bg-muted focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring"
              >
                <MessageCircle
                  className="h-4 w-4 shrink-0 text-muted-foreground"
                  aria-hidden="true"
                />
                <Lang>{suggestion.text}</Lang>
              </Link>
            </li>
          ))}
        </ul>
      )}

      <Link
        href={`/ask${payload.query ? `?q=${encodeURIComponent(payload.query)}` : ""}`}
        className="mt-4 inline-flex min-h-11 items-center gap-2 rounded-lg border-2 border-primary bg-primary px-4 py-2 text-sm font-semibold text-primary-foreground transition hover:opacity-90 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2"
      >
        {ChatEntryCopy.askSomethingElse}
      </Link>
    </section>
  );
}
