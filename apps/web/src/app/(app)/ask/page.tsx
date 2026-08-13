import Link from "next/link";
import { Search } from "lucide-react";

import { AskPageCopy } from "@/config/copy";
import { AskChat } from "@/components/ask/AskChat";

export const dynamic = "force-dynamic";

type PageProps = {
  searchParams: Promise<{ [key: string]: string | string[] | undefined }>;
};

function firstParam(value: string | string[] | undefined): string | null {
  if (Array.isArray(value)) return value[0] ?? null;
  return value ?? null;
}

export default async function AskPage({ searchParams }: PageProps) {
  const params = await searchParams;
  const query = (firstParam(params.q) ?? "").slice(0, 300);

  return (
    <div className="mx-auto flex max-w-[var(--dp-shell-width)] flex-col gap-8 px-4 py-8 sm:px-6 lg:px-8">
      <header className="space-y-3">
        <h1 id="main-heading" className="text-2xl font-bold text-foreground sm:text-3xl">
          {AskPageCopy.heading}
        </h1>
        <Link
          href={query ? `/search?q=${encodeURIComponent(query)}` : "/search"}
          className="inline-flex min-h-11 items-center gap-2 rounded-lg border-2 border-border bg-card px-4 py-2 text-sm font-semibold text-foreground transition hover:bg-muted focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring"
        >
          <Search className="h-4 w-4" aria-hidden="true" />
          {AskPageCopy.backToSearch}
        </Link>
      </header>

      <AskChat initialQuery={query} />
    </div>
  );
}
