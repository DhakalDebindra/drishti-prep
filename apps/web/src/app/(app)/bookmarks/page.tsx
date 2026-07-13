import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { BookmarkedQuestionList, BookmarkedQuestion } from "@/components/bookmarks/BookmarkedQuestionList";
import { ChevronLeft, ChevronRight } from "lucide-react";
import Link from "next/link";

type PageProps = {
  searchParams: Promise<{ [key: string]: string | string[] | undefined }>;
};

const ITEMS_PER_PAGE = 20;

export default async function BookmarksPage({ searchParams }: PageProps) {
  const supabase = await createClient();
  const resolvedSearchParams = await searchParams;
  const page = parseInt(resolvedSearchParams.page as string) || 1;
  const offset = (page - 1) * ITEMS_PER_PAGE;

  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (!user) {
    redirect("/login");
  }

  // Fetch bookmarks with joined data
  const { data: bookmarks, error, count } = await supabase
    .from("bookmarks")
    .select(`
      id,
      created_at,
      question_id,
      questions (
        id,
        content,
        option_a,
        option_b,
        option_c,
        option_d,
        correct_option,
        explanation,
        question_sets (
          title
        )
      )
    `, { count: "exact" })
    .eq("user_id", user.id)
    .order("created_at", { ascending: false })
    .range(offset, offset + ITEMS_PER_PAGE - 1);

  if (error) {
    console.error("Error fetching bookmarks:", JSON.stringify(error, null, 2));
    // Return empty state or error UI
    return (
      <div className="min-h-screen bg-gradient-to-b from-slate-50 via-white to-teal-50/40 text-slate-900 dark:from-slate-950 dark:via-slate-950 dark:to-slate-900 dark:text-slate-50">
        <div className="relative mx-auto flex max-w-[var(--dp-shell-width)] flex-col gap-6 px-4 py-8 sm:px-6 lg:px-8">
          <div className="rounded-3xl border border-rose-200/60 bg-rose-50/80 p-8 shadow-sm dark:border-rose-900/40 dark:bg-rose-950/20">
            <h2 className="text-xl font-bold text-rose-900 dark:text-rose-100">Failed to load bookmarks</h2>
            <p className="mt-2 text-sm leading-relaxed text-rose-800/80 dark:text-rose-200/80">
              There was an error connecting to the database. Please try again later.
            </p>
            <Link
              href="/dashboard"
              className="mt-5 inline-flex items-center gap-2 rounded-full border border-rose-200 bg-white px-4 py-2 text-sm font-semibold text-rose-700 transition hover:bg-rose-50 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-rose-400 dark:border-rose-900/40 dark:bg-slate-950 dark:text-rose-200 dark:hover:bg-rose-950/30"
            >
              Return to dashboard
            </Link>
          </div>
        </div>
      </div>
    );
  }

  const formattedBookmarks: BookmarkedQuestion[] = (bookmarks || []).map((b: any) => ({
    bookmark_id: b.id,
    question_id: b.question_id,
    content: b.questions?.content || "Deleted Question",
    option_a: b.questions?.option_a || "",
    option_b: b.questions?.option_b || "",
    option_c: b.questions?.option_c || "",
    option_d: b.questions?.option_d || "",
    correct_option: b.questions?.correct_option || "",
    explanation: b.questions?.explanation || "",
    set_title: b.questions?.question_sets?.title || "Unknown Set",
    created_at: b.created_at,
  }));

  const totalCount = count || 0;
  const totalPages = Math.ceil(totalCount / ITEMS_PER_PAGE);

  return (
    <div className="min-h-screen bg-gradient-to-b from-slate-50 via-white to-teal-50/40 text-slate-900 dark:from-slate-950 dark:via-slate-950 dark:to-slate-900 dark:text-slate-50">
      <div className="pointer-events-none fixed inset-0 overflow-hidden">
        <div className="absolute left-[-5rem] top-[-5rem] h-72 w-72 rounded-full bg-emerald-200/20 blur-3xl dark:bg-emerald-500/10" />
        <div className="absolute right-[-5rem] top-24 h-72 w-72 rounded-full bg-cyan-200/15 blur-3xl dark:bg-cyan-500/10" />
      </div>

      <BookmarkedQuestionList initialQuestions={formattedBookmarks} />

      {totalPages > 1 && (
        <div className="mx-auto flex max-w-[var(--dp-shell-width)] items-center justify-center gap-4 px-4 pb-12 sm:px-6 lg:px-8">
          <Link
            href={`/bookmarks?page=${Math.max(1, page - 1)}`}
            aria-label={`Go to previous page (page ${page - 1})`}
            className={`inline-flex items-center justify-center rounded-full border border-slate-200 bg-white p-2.5 text-slate-600 shadow-sm transition hover:bg-slate-50 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring dark:border-slate-700 dark:bg-slate-950 dark:text-slate-300 dark:hover:bg-slate-900 ${
              page <= 1 ? "opacity-30 cursor-not-allowed pointer-events-none" : "hover:bg-slate-50 dark:hover:bg-slate-800"
            }`}
            aria-disabled={page <= 1}
          >
            <ChevronLeft className="w-5 h-5 text-slate-600 dark:text-slate-400" />
            <span className="sr-only">Previous Page</span>
          </Link>
          
          <span className="rounded-full border border-slate-200 bg-white px-4 py-2 text-sm font-medium text-slate-600 shadow-sm dark:border-slate-700 dark:bg-slate-950 dark:text-slate-300">
            Page <span className="text-slate-900 dark:text-white">{page}</span> of {totalPages}
          </span>

          <Link
            href={`/bookmarks?page=${Math.min(totalPages, page + 1)}`}
            aria-label={`Go to next page (page ${page + 1})`}
            className={`inline-flex items-center justify-center rounded-full border border-slate-200 bg-white p-2.5 text-slate-600 shadow-sm transition hover:bg-slate-50 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring dark:border-slate-700 dark:bg-slate-950 dark:text-slate-300 dark:hover:bg-slate-900 ${
              page >= totalPages ? "opacity-30 cursor-not-allowed pointer-events-none" : "hover:bg-slate-50 dark:hover:bg-slate-800"
            }`}
            aria-disabled={page >= totalPages}
          >
            <ChevronRight className="w-5 h-5 text-slate-600 dark:text-slate-400" />
            <span className="sr-only">Next Page</span>
          </Link>
        </div>
      )}
    </div>
  );
}
