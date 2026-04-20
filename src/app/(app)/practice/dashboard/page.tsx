import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";

export default async function PracticeDashboardPage() {
  const supabase = await createClient();
  const { data: auth } = await supabase.auth.getUser();
  const user = auth?.user;

  if (!user) {
    redirect("/login?redirect_to=/practice/dashboard");
  }

  const { data: attempts } = await supabase
    .from("attempts")
    .select("id, set_id, status, score_raw, score_pct, question_count, submitted_at")
    .eq("user_id", user.id)
    .order("submitted_at", { ascending: false })
    .limit(10);

  const setIds = attempts?.map((a) => a.set_id) ?? [];
  const { data: sets } = setIds.length
    ? await supabase.from("question_sets").select("id, title").in("id", setIds)
    : { data: [] } as { data: { id: string; title: string }[] };

  const titleMap = Object.fromEntries((sets ?? []).map((s) => [s.id, s.title]));
  const avgPct = attempts && attempts.length > 0
    ? attempts.reduce((sum, a) => sum + (a.score_pct ?? 0), 0) / attempts.length
    : 0;

  return (
    <section className="space-y-6">
      <div>
        <p className="text-sm uppercase tracking-wide text-gray-500">Dashboard</p>
        <h1 className="text-2xl font-semibold text-gray-900">Your recent practice</h1>
        <p className="text-gray-600">A quick snapshot of your latest attempts.</p>
      </div>

      <div className="rounded-xl border border-gray-200 bg-gradient-to-r from-blue-50 to-emerald-50 p-5 shadow-sm">
        <p className="text-sm text-gray-600">Average accuracy</p>
        <p className="text-3xl font-semibold text-gray-900">{avgPct.toFixed(1)}%</p>
        <p className="text-xs text-gray-500">Across last {attempts?.length ?? 0} attempts</p>
      </div>

      <div className="rounded-xl border border-gray-200 bg-white shadow-sm">
        <div className="border-b border-gray-100 px-4 py-3">
          <p className="text-sm font-semibold text-gray-900">Recent attempts</p>
        </div>
        <div className="divide-y divide-gray-100">
          {(attempts ?? []).length === 0 && (
            <p className="px-4 py-4 text-sm text-gray-600">No attempts yet. Start practicing to see your progress.</p>
          )}
          {(attempts ?? []).map((a) => (
            <div key={a.id} className="flex items-center justify-between px-4 py-3 text-sm">
              <div className="flex flex-col">
                <span className="font-semibold text-gray-900">{titleMap[a.set_id] || "Unknown set"}</span>
                <span className="text-gray-600">{a.status === "submitted" ? "Submitted" : "In progress"}</span>
              </div>
              <div className="text-right text-gray-800">
                <p className="font-semibold">{a.score_raw ?? 0}/{a.question_count ?? 0}</p>
                <p className="text-xs text-gray-500">{(a.score_pct ?? 0).toFixed(1)}%</p>
              </div>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
}
