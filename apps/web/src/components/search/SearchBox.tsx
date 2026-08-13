"use client";

import { Search } from "lucide-react";
import { SearchBoxCopy } from "@/config/copy";
import { SEARCH_SUBMIT_FLAG } from "@/components/search/ResultsFocus";
import { useId } from "react";

/**
 * The search input.
 *
 * A plain GET form, not a live-updating combobox. Two reasons: results are a
 * page the learner can bookmark, share and go Back to; and a listbox that
 * rewrites itself on every keystroke is genuinely hostile to a screen reader,
 * which re-announces the changing content instead of letting them type.
 */
export function SearchBox({
  defaultValue = "",
  autoFocus = false,
  className = "",
}: {
  defaultValue?: string;
  autoFocus?: boolean;
  className?: string;
}) {
  const inputId = useId();

  return (
    <form
      action="/search"
      method="get"
      role="search"
      className={className}
      // Tells the results page this was a deliberate search, so it may move
      // focus to the heading. Following a link must not do that.
      onSubmit={() => sessionStorage.setItem(SEARCH_SUBMIT_FLAG, "1")}
    >
      <label htmlFor={inputId} className="sr-only">
        {SearchBoxCopy.label}
      </label>
      <div className="flex items-stretch gap-2">
        <div className="relative flex-1">
          <Search
            className="pointer-events-none absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-muted-foreground"
            aria-hidden="true"
          />
          <input
            id={inputId}
            type="search"
            name="q"
            defaultValue={defaultValue}
            autoFocus={autoFocus}
            autoComplete="off"
            enterKeyHint="search"
            placeholder={SearchBoxCopy.placeholder}
            className="min-h-11 w-full rounded-lg border-2 border-border bg-background py-2 pl-9 pr-3 text-foreground placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring"
          />
        </div>
        <button
          type="submit"
          className="min-h-11 shrink-0 rounded-lg border-2 border-primary bg-primary px-4 py-2 text-sm font-semibold text-primary-foreground transition hover:opacity-90 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2"
        >
          {SearchBoxCopy.submit}
        </button>
      </div>
    </form>
  );
}
