import Link from "next/link";
import { redirect } from "next/navigation";
import { ArrowRight, BarChart3, Clock3, Sparkles, ListChecks } from "lucide-react";
import { createClient } from "@/lib/supabase/server";
import { PracticeAccessibilityMenu } from "@/components/practice/AccessibilityMenu";

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
  const completedCount = attempts?.filter((attempt) => attempt.status === "submitted").length ?? 0;
  const activeCount = attempts?.filter((attempt) => attempt.status === "in_progress").length ?? 0;

  return (
    <section className="space-y-6">
      <div className="rounded-[2rem] border border-white/70 bg-white/85 p-6 shadow-[0_20px_60px_rgba(15,23,42,0.08)] backdrop-blur-xl dark:border-slate-800 dark:bg-slate-950/70 md:p-8">
        <div className="flex flex-col gap-6 md:flex-row md:items-end md:justify-between">
          <div className="space-y-3">
            <p className="inline-flex items-center gap-2 rounded-full border border-emerald-200 bg-emerald-50 px-3 py-1 text-xs font-semibold uppercase tracking-[0.22em] text-emerald-800 dark:border-emerald-900/60 dark:bg-emerald-950/30 dark:text-emerald-200">
              <Sparkles className="h-3.5 w-3.5" aria-hidden="true" />
              Practice dashboard
            </p>
            <div>
              <p className="text-sm font-medium uppercase tracking-[0.24em] text-slate-500 dark:text-slate-400">
                Dashboard
              </p>
              <h1 className="mt-1 text-3xl font-bold tracking-tight text-slate-950 dark:text-white">
                Your recent practice
              </h1>
              <p className="mt-2 max-w-2xl text-sm leading-relaxed text-slate-600 dark:text-slate-300">
                A calm snapshot of your latest attempts, progress trends, and the practice work you may want to revisit.
              </p>
            </div>
          </div>

          <div className="flex flex-wrap gap-3">
            <PracticeAccessibilityMenu buttonMode="label" />
            <Link
              href="/dashboard"
              className="inline-flex items-center gap-2 rounded-full border border-slate-200 bg-white px-4 py-2 text-sm font-semibold text-slate-700 transition hover:bg-slate-50 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-emerald-500 dark:border-slate-700 dark:bg-slate-900 dark:text-slate-200 dark:hover:bg-slate-800"
            >
              Back to main dashboard
              <ArrowRight className="h-4 w-4" aria-hidden="true" />
            </Link>
          </div>
        </div>

        <div className="mt-6 grid gap-4 md:grid-cols-3">
          <div className="rounded-[1.5rem] border border-slate-200 bg-slate-50/80 p-5 dark:border-slate-800 dark:bg-slate-900/60">
            <div className="flex items-center gap-2 text-sm font-medium text-slate-500 dark:text-slate-400">
              <BarChart3 className="h-4 w-4" />
              Average accuracy
            </div>
            <p className="mt-2 text-3xl font-bold tracking-tight text-slate-950 dark:text-white">
              {avgPct.toFixed(1)}%
            </p>
            <p className="mt-1 text-xs text-slate-500 dark:text-slate-400">
              Across the last {attempts?.length ?? 0} attempts
            </p>
          </div>

          <div className="rounded-[1.5rem] border border-emerald-200 bg-emerald-50/80 p-5 dark:border-emerald-900/50 dark:bg-emerald-950/30">
            <div className="flex items-center gap-2 text-sm font-medium text-emerald-800 dark:text-emerald-300">
              <ListChecks className="h-4 w-4" />
              Completed sets
            </div>
            <p className="mt-2 text-3xl font-bold tracking-tight text-emerald-900 dark:text-emerald-200">
              {completedCount}
            </p>
            <p className="mt-1 text-xs text-emerald-700/80 dark:text-emerald-300/80">
              Finished practice sessions
            </p>
          </div>

          <div className="rounded-[1.5rem] border border-cyan-200 bg-cyan-50/80 p-5 dark:border-cyan-900/50 dark:bg-cyan-950/30">
            <div className="flex items-center gap-2 text-sm font-medium text-cyan-800 dark:text-cyan-300">
              <Clock3 className="h-4 w-4" />
              In progress
            </div>
            <p className="mt-2 text-3xl font-bold tracking-tight text-cyan-900 dark:text-cyan-200">
              {activeCount}
            </p>
            <p className="mt-1 text-xs text-cyan-700/80 dark:text-cyan-300/80">
              Sessions ready to continue
            </p>
          </div>
        </div>
      </div>

      <div className="rounded-[2rem] border border-white/70 bg-white/85 shadow-[0_18px_50px_rgba(15,23,42,0.08)] backdrop-blur-xl dark:border-slate-800 dark:bg-slate-950/70">
        <div className="flex items-center justify-between border-b border-slate-200 px-5 py-4 dark:border-slate-800 sm:px-6">
          <div>
            <p className="text-xs font-semibold uppercase tracking-[0.24em] text-slate-500 dark:text-slate-400">
              Recent attempts
            </p>
            <p className="mt-1 text-sm text-slate-600 dark:text-slate-300">
              Your latest practice sessions in one place.
            </p>
          </div>
          <span className="rounded-full border border-slate-200 bg-slate-50 px-3 py-1.5 text-xs font-medium text-slate-600 dark:border-slate-700 dark:bg-slate-900 dark:text-slate-300">
            {attempts?.length ?? 0} shown
          </span>
        </div>

        <div className="divide-y divide-slate-200 dark:divide-slate-800">
          {(attempts ?? []).length === 0 && (
            <div className="px-5 py-10 text-center sm:px-6">
              <p className="text-base font-medium text-slate-900 dark:text-white">
                No attempts yet.
              </p>
              <p className="mt-1 text-sm text-slate-600 dark:text-slate-300">
                Start a practice set to see your progress here.
              </p>
            </div>
          )}

          {(attempts ?? []).map((attempt) => {
            const isSubmitted = attempt.status === "submitted";
            const title = titleMap[attempt.set_id] || "Unknown set";
            const scorePct = attempt.score_pct ?? 0;

            return (
              <div key={attempt.id} className="flex flex-col gap-4 px-5 py-5 sm:px-6 md:flex-row md:items-center md:justify-between">
                <div className="space-y-2">
                  <div className="flex items-center gap-2">
                    <span className={`rounded-full px-3 py-1 text-xs font-semibold ${
                      isSubmitted
                        ? "bg-emerald-100 text-emerald-800 dark:bg-emerald-950/40 dark:text-emerald-200"
                        : "bg-cyan-100 text-cyan-800 dark:bg-cyan-950/40 dark:text-cyan-200"
                    }`}>
                      {isSubmitted ? "Submitted" : "In progress"}
                    </span>
                    <span className="text-xs text-slate-500 dark:text-slate-400">
                      {attempt.question_count ?? 0} questions
                    </span>
                  </div>
                  <h3 className="text-base font-semibold tracking-tight text-slate-950 dark:text-white">
                    {title}
                  </h3>
                  <p className="text-sm text-slate-600 dark:text-slate-300">
                    {attempt.submitted_at
                      ? new Date(attempt.submitted_at).toLocaleDateString("en-US", {
                          month: "short",
                          day: "numeric",
                          year: "numeric",
                        })
                      : "Not submitted yet"}
                  </p>
                </div>

                <div className="flex items-center gap-4">
                  <div className="text-right">
                    <p className="text-2xl font-bold tracking-tight text-slate-950 dark:text-white">
                      {attempt.score_raw ?? 0}/{attempt.question_count ?? 0}
                    </p>
                    <p className="text-xs text-slate-500 dark:text-slate-400">
                      {scorePct.toFixed(1)}%
                    </p>
                  </div>
                  <div className="h-2 w-24 overflow-hidden rounded-full bg-slate-200 dark:bg-slate-800 sm:w-32">
                    <div
                      className="h-full rounded-full bg-gradient-to-r from-emerald-400 via-teal-400 to-cyan-400"
                      style={{ width: `${Math.max(5, scorePct)}%` }}
                    />
                  </div>
                </div>
              </div>
            );
          })}
        </div>
      </div>
    </section>
  );
}
