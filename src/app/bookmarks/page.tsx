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
      <div className="max-w-4xl mx-auto px-4 py-20 text-center">
        <h2 className="text-xl font-bold text-red-600 mb-2">Failed to load bookmarks</h2>
        <p className="text-slate-500">There was an error connecting to the database. Please try again later.</p>
        <Link href="/dashboard" className="inline-block mt-4 text-blue-600 hover:underline">Return to Dashboard</Link>
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
    <div className="min-h-screen bg-slate-50/30 dark:bg-slate-950/30">
      <BookmarkedQuestionList initialQuestions={formattedBookmarks} />
      
      {totalPages > 1 && (
        <div className="max-w-4xl mx-auto px-4 pb-12 flex justify-center items-center gap-4">
          <Link
            href={`/bookmarks?page=${Math.max(1, page - 1)}`}
            aria-label={`Go to previous page (page ${page - 1})`}
            className={`p-2 rounded-lg border border-slate-200 dark:border-slate-800 bg-white dark:bg-slate-900 transition-colors ${
              page <= 1 ? "opacity-30 cursor-not-allowed pointer-events-none" : "hover:bg-slate-50 dark:hover:bg-slate-800"
            }`}
            aria-disabled={page <= 1}
          >
            <ChevronLeft className="w-5 h-5 text-slate-600 dark:text-slate-400" />
            <span className="sr-only">Previous Page</span>
          </Link>
          
          <span className="text-sm font-medium text-slate-600 dark:text-slate-400">
            Page <span className="text-slate-900 dark:text-white">{page}</span> of {totalPages}
          </span>

          <Link
            href={`/bookmarks?page=${Math.min(totalPages, page + 1)}`}
            aria-label={`Go to next page (page ${page + 1})`}
            className={`p-2 rounded-lg border border-slate-200 dark:border-slate-800 bg-white dark:bg-slate-900 transition-colors ${
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
