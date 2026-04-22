import { createClient } from "@/lib/supabase/server";
import Link from "next/link";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { QuestionSetFilter } from "./components/QuestionSetFilter";
import { PaginationControls } from "./components/PaginationControls";
import { cn } from "@/lib/utils";

export default async function AdminIndexPage({
  searchParams,
}: {
  searchParams: Promise<{ [key: string]: string | string[] | undefined }>;
}) {
  const supabase = await createClient();
  const params = await searchParams;

  // Pagination & Filter params
  const page = Number(params.page) || 1;
  const perPage = Number(params.perPage) || 10;
  const subjectId = params.subjectId as string | undefined;
  const topicId = params.topicId as string | undefined;

  // Calculate Supabase range
  const from = (page - 1) * perPage;
  const to = from + perPage - 1;

  // Fetch meta-data for filters
  const [
    { data: subjects },
    { data: topics },
  ] = await Promise.all([
    supabase.from("subjects").select("id, name").order("name"),
    supabase.from("topics").select("id, name, subject_id").order("name"),
  ]);

  // Main query with joins for filtering and display
  // Note: !inner forces an inner join which is required for filtering on joined tables
  let query = supabase
    .from("question_sets")
    .select(`
      id,
      title,
      difficulty_level,
      is_verified,
      created_at,
      topic_id,
      topics!inner (
        id,
        name,
        subject_id,
        subjects!inner (
          id,
          name
        )
      )
    `, { count: "exact" });

  // Apply filters
  if (topicId) {
    query = query.eq("topic_id", topicId);
  } else if (subjectId) {
    query = query.eq("topics.subject_id", subjectId);
  }

  // Execute query with pagination and ordering
  const { data: rawSets, error, count } = await query
    .order("created_at", { ascending: false })
    .range(from, to);

  const questionSets = rawSets || [];
  const totalCount = count || 0;
  const totalPages = Math.ceil(totalCount / perPage);

  return (
    <div className="container mx-auto py-8 space-y-8 animate-in fade-in duration-500">
      <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
        <div>
          <h1 className="text-3xl font-bold tracking-tight text-slate-900">Content Studio</h1>
          <p className="text-slate-500 mt-1">Manage and organize your question sets with ease</p>
        </div>
        <div className="flex gap-3">
          <Link href="/admin/question-sets/import">
            <Button variant="outline" className="border-slate-200 hover:bg-slate-100 transition-colors">
              Bulk Import
            </Button>
          </Link>
          <Link href="/admin/question-sets/create">
            <Button className="bg-blue-600 hover:bg-blue-700 shadow-sm transition-all active:scale-95">
              + Create Question Set
            </Button>
          </Link>
        </div>
      </div>

      <QuestionSetFilter 
        subjects={subjects || []} 
        topics={topics || []} 
      />

      <Card className="border-slate-200 shadow-sm overflow-hidden border-none ring-1 ring-slate-200 text-slate-900">
        <CardHeader className="bg-slate-50/50 border-b border-slate-200">
          <div className="flex justify-between items-center text-slate-900">
            <CardTitle className="text-lg font-bold text-slate-800 tracking-tight">All Question Sets</CardTitle>
            <div className="px-3 py-1 bg-white border border-slate-200 rounded-full text-xs font-semibold text-slate-500 shadow-sm">
              {totalCount} total datasets
            </div>
          </div>
        </CardHeader>
        <CardContent className="p-0">
          {error ? (
            <div className="p-12 text-center text-slate-900">
              <p className="text-destructive font-semibold">Failed to load question sets</p>
              <p className="text-sm text-slate-500 mt-1">{error.message}</p>
            </div>
          ) : questionSets.length === 0 ? (
            <div className="text-center py-24 px-6 text-slate-900">
              <div className="mb-6 inline-flex items-center justify-center w-16 h-16 rounded-2xl bg-slate-50 text-slate-300">
                 <svg className="w-8 h-8" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                 </svg>
              </div>
              <h3 className="text-lg font-bold text-slate-900">No question sets found</h3>
              <p className="text-slate-500 mt-2 max-w-sm mx-auto">
                No sets match your current filters. Try adjusting your search criteria or create a fresh question set.
              </p>
              <Link href="/admin">
                <Button 
                  variant="outline" 
                  className="mt-6 border-slate-200 hover:bg-slate-50"
                >
                  Clear all filters
                </Button>
              </Link>
            </div>
          ) : (
            <div className="overflow-x-auto text-slate-900">
              <table className="w-full text-sm text-left">
                <thead className="bg-slate-50/80 text-slate-500 uppercase text-[11px] font-bold tracking-widest border-b border-slate-200">
                  <tr>
                    <th className="px-6 py-4">Set Overview</th>
                    <th className="px-6 py-4">Status</th>
                    <th className="px-6 py-4">Curriculum Path</th>
                    <th className="px-6 py-4 text-right">Actions</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-slate-100">
                  {questionSets.map((set: any) => (
                    <tr key={set.id} className="hover:bg-blue-50/30 transition-colors group">
                      <td className="px-6 py-5">
                        <div className="font-bold text-slate-900 group-hover:text-blue-600 transition-colors">{set.title}</div>
                        <div className="flex items-center gap-2 mt-1.5">
                           <span className={cn(
                             "w-1.5 h-1.5 rounded-full",
                             set.difficulty_level === 1 ? "bg-emerald-500" : 
                             set.difficulty_level === 2 ? "bg-amber-500" : "bg-rose-500"
                           )} />
                           <span className="text-[11px] font-bold uppercase tracking-tighter text-slate-400">
                             Level {set.difficulty_level}
                           </span>
                           <span className="text-slate-300">•</span>
                           <span className="text-[11px] text-slate-400">
                             Added {new Date(set.created_at).toLocaleDateString()}
                           </span>
                        </div>
                      </td>
                      <td className="px-6 py-5">
                        <span className={cn(
                          "inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-[11px] font-bold uppercase tracking-tight shadow-sm border",
                          set.is_verified 
                            ? "bg-emerald-50 text-emerald-700 border-emerald-100 ring-4 ring-emerald-50/50" 
                            : "bg-amber-50 text-amber-700 border-amber-100 ring-4 ring-amber-50/50"
                        )}>
                          {set.is_verified ? "Published" : "Draft Mode"}
                        </span>
                      </td>
                      <td className="px-6 py-5">
                        <div className="flex flex-col gap-0.5">
                          <span className="text-xs font-semibold text-slate-600">
                            {set.topics?.subjects?.name || "Uncategorized"}
                          </span>
                          <span className="text-[11px] text-slate-400">
                            {set.topics?.name || "General Topic"}
                          </span>
                        </div>
                      </td>
                      <td className="px-6 py-5 text-right">
                        <Link href={`/admin/question-sets/${set.id}`}>
                          <Button 
                            variant="outline" 
                            size="sm" 
                            className="h-9 px-4 border-slate-200 hover:border-blue-400 hover:bg-blue-50 hover:text-blue-600 font-bold transition-all shadow-sm active:scale-95"
                          >
                            Edit Dataset
                          </Button>
                        </Link>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          )}
        </CardContent>
      </Card>

      <PaginationControls 
        currentPage={page} 
        totalPages={totalPages} 
      />
    </div>
  );
}
