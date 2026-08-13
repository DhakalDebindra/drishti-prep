import { Search as SearchIcon } from "lucide-react";

import { Lang } from "@/components/ui/Lang";
import { ChatEntryPoint } from "@/components/search/ChatEntryPoint";
import { SearchHeader } from "@/components/search/SearchHeader";
import { SearchPagination, SearchResults } from "@/components/search/SearchResults";
import { SearchPageCopy } from "@/config/copy";
import { SearchBox } from "@/components/search/SearchBox";
import { ResultsFocus } from "@/components/search/ResultsFocus";
import { SETS_PER_PAGE, searchContent } from "@/lib/search/search";

export const dynamic = "force-dynamic";

type PageProps = {
  searchParams: Promise<{ [key: string]: string | string[] | undefined }>;
};

function firstParam(value: string | string[] | undefined): string | null {
  if (Array.isArray(value)) return value[0] ?? null;
  return value ?? null;
}

export default async function SearchPage({ searchParams }: PageProps) {
  const params = await searchParams;
  const query = firstParam(params.q) ?? "";
  const subjectId = firstParam(params.subjectId);
  const topicId = firstParam(params.topicId);
  const page = Math.max(1, Number.parseInt(firstParam(params.page) ?? "1", 10) || 1);

  const payload = await searchContent(query, { subjectId, topicId, page });

  return (
    <div className="mx-auto flex max-w-[var(--dp-shell-width)] flex-col gap-8 px-4 py-8 sm:px-6 lg:px-8">
      <ResultsFocus query={payload.query} />
      <header className="space-y-4">
        {/*
          The h1 is the learner's own query, so a screen-reader user landing
          here immediately hears what was searched rather than a generic title.
        */}
        <h1
          id="main-heading"
          tabIndex={-1}
          className="text-2xl font-bold text-foreground outline-none sm:text-3xl"
        >
          {payload.query ? (
            <>
              <span className="sr-only">{SearchPageCopy.resultsForPrefix}</span>
              <Lang>{payload.query}</Lang>
            </>
          ) : (
            SearchPageCopy.titleFallback
          )}
        </h1>
        {/*
          Focus the field only when there is nothing to read yet. With results
          on screen, stealing focus would talk over the heading a screen-reader
          user just landed on.
        */}
        <SearchBox defaultValue={payload.query} autoFocus={!payload.query} />
      </header>

      {payload.blank ? (
        <section className="rounded-2xl border-2 border-border bg-card px-4 py-10 text-center">
          <SearchIcon
            className="mx-auto h-8 w-8 text-muted-foreground"
            aria-hidden="true"
          />
          <p className="mt-3 font-medium text-foreground">
            {SearchPageCopy.emptyPrompt}
          </p>
          <Lang as="p" className="mt-1 text-sm text-muted-foreground">
            {SearchPageCopy.emptyHintNe}
          </Lang>
        </section>
      ) : (
        <>
          {payload.header && <SearchHeader header={payload.header} />}
          <SearchResults payload={payload} />
          <SearchPagination
            payload={payload}
            page={page}
            subjectId={subjectId}
            topicId={topicId}
            perPage={SETS_PER_PAGE}
          />
          <ChatEntryPoint payload={payload} />
        </>
      )}
    </div>
  );
}
