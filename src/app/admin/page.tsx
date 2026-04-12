import { createClient } from "@/lib/supabase/server";
import Link from "next/link";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";

export default async function AdminIndexPage() {
  const supabase = await createClient();

  // Fetch question sets with basic topic/subject information
  // Note: Using standard supabase join syntax. If relationship names differ, this might need fallback.
  const { data: rawSets, error } = await supabase
    .from("question_sets")
    .select(`
      id,
      title,
      difficulty_level,
      is_verified,
      created_at,
      topic_id
    `)
    .order("created_at", { ascending: false });

  // For safety, not fully nesting topics/subjects until relation names are verified, 
  // but we can at least show the core data.
  const questionSets = rawSets || [];

  return (
    <div className="container mx-auto py-8 space-y-6">
      <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
        <div>
          <h1 className="text-3xl font-bold">Content Studio</h1>
          <p className="text-muted-foreground">Manage and organize your question sets</p>
        </div>
        <div className="flex gap-2">
          <Link href="/admin/question-sets/import">
            <Button variant="outline">Bulk Import</Button>
          </Link>
          <Link href="/admin/question-sets/create">
            <Button>+ Create Question Set</Button>
          </Link>
        </div>
      </div>

      <Card>
        <CardHeader>
          <CardTitle>All Question Sets</CardTitle>
        </CardHeader>
        <CardContent>
          {error ? (
            <p className="text-destructive">Failed to load question sets: {error.message}</p>
          ) : questionSets.length === 0 ? (
            <div className="text-center py-12 text-muted-foreground">
              <p>No question sets found.</p>
              <p className="text-sm mt-2">Get started by creating your first exam set!</p>
            </div>
          ) : (
            <div className="overflow-x-auto">
              <table className="w-full text-sm text-left border-collapse">
                <thead className="bg-slate-50 text-slate-500 uppercase text-xs font-semibold">
                  <tr>
                    <th className="px-4 py-3 border-b">Title</th>
                    <th className="px-4 py-3 border-b">Status</th>
                    <th className="px-4 py-3 border-b">Difficulty</th>
                    <th className="px-4 py-3 border-b text-right">Actions</th>
                  </tr>
                </thead>
                <tbody className="divide-y">
                  {questionSets.map((set) => (
                    <tr key={set.id} className="hover:bg-slate-50/50 transition-colors">
                      <td className="px-4 py-4 font-medium text-slate-900">{set.title}</td>
                      <td className="px-4 py-4">
                        <span className={`px-2 py-1 rounded-full text-xs font-medium ${set.is_verified ? 'bg-emerald-100 text-emerald-800' : 'bg-amber-100 text-amber-800'}`}>
                          {set.is_verified ? "Published" : "Draft"}
                        </span>
                      </td>
                      <td className="px-4 py-4">
                        Level {set.difficulty_level}
                      </td>
                      <td className="px-4 py-4 text-right space-x-2">
                        {/* We will build this edit page shortly */}
                        <Link href={`/admin/question-sets/${set.id}`}>
                          <Button variant="outline" size="sm">Editor</Button>
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
    </div>
  );
}
