import { createClient } from "@/lib/supabase/server";
import Link from "next/link";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";

export default async function DisputeInboxPage() {
  const supabase = await createClient();

  // Fetch from the newly created view
  const { data: disputes, error } = await supabase
    .from("active_disputes_view")
    .select("*")
    // Order by priority ('High' string vs 'Normal' string - High comes first alphabetically! But let's sort by report_count descending for accuracy)
    .order("report_count", { ascending: false });

  return (
    <div className="container mx-auto py-8 space-y-6">
      <div>
        <h1 className="text-3xl font-bold text-red-800">Dispute Inbox</h1>
        <p className="text-muted-foreground mt-2">
          Questions flagged by learners. High priority items have 3 or more pending reports.
        </p>
      </div>

      <Card>
        <CardHeader>
          <CardTitle>Active Disputes</CardTitle>
          <CardDescription>Resolve these issues to improve exam quality.</CardDescription>
        </CardHeader>
        <CardContent>
          {error ? (
            <p className="text-destructive">Failed to load disputes: {error.message}</p>
          ) : !disputes || disputes.length === 0 ? (
            <div className="text-center py-12 text-muted-foreground">
              <p>Inbox zero! 🎉</p>
              <p className="text-sm mt-2">No active disputes reported by candidates.</p>
            </div>
          ) : (
            <div className="overflow-x-auto">
              <table className="w-full text-sm text-left border-collapse">
                <thead className="bg-slate-50 text-slate-500 uppercase text-xs font-semibold">
                  <tr>
                    <th className="px-4 py-3 border-b">Priority</th>
                    <th className="px-4 py-3 border-b">Practice Set</th>
                    <th className="px-4 py-3 border-b">Question Snippet</th>
                    <th className="px-4 py-3 border-b text-center">Reports</th>
                    <th className="px-4 py-3 border-b">Oldest Report</th>
                    <th className="px-4 py-3 border-b text-right">Action</th>
                  </tr>
                </thead>
                <tbody className="divide-y">
                  {disputes.map((d) => (
                    <tr key={d.question_id} className="hover:bg-slate-50 transition-colors">
                      <td className="px-4 py-4">
                        {d.priority === 'High' ? (
                          <span className="px-2 py-1 rounded-full text-xs font-bold bg-red-100 text-red-800">High Priority</span>
                        ) : (
                          <span className="px-2 py-1 rounded-full text-xs font-medium bg-blue-100 text-blue-800">Normal</span>
                        )}
                      </td>
                      <td className="px-4 py-4 font-medium text-slate-900">{d.set_title || "Untitled Set"}</td>
                      <td className="px-4 py-4 truncate max-w-[200px]" title={d.question_content || undefined}>
                        {d.question_content || "Deleted question"}
                      </td>
                      <td className="px-4 py-4 text-center font-bold text-lg">
                        {d.report_count ?? 0}
                      </td>
                      <td className="px-4 py-4 text-slate-500">
                        {d.oldest_report_date
                          ? new Date(d.oldest_report_date).toLocaleDateString()
                          : "Unknown"}
                      </td>
                      <td className="px-4 py-4 text-right">
                        <Link href={`/admin/disputes/${d.question_id || ""}`}>
                          <Button variant="default" size="sm">Review & Resolve</Button>
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
