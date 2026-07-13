import Link from "next/link";
import { redirect } from "next/navigation";
import { ArrowRight, BarChart3, Clock3, Sparkles, ListChecks } from "lucide-react";
import { createClient } from "@/lib/supabase/server";
import { PracticeAccessibilityMenu } from "@/components/practice/AccessibilityMenu";
import { StatCard } from "@/components/ui/stat-card";
import { WidgetCard } from "@/components/ui/widget-card";

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
      <div className="rounded-3xl border border-border bg-card p-6 shadow-sm md:p-8">
        <div className="flex flex-col gap-6 md:flex-row md:items-end md:justify-between">
          <div className="space-y-3">
            <p className="inline-flex items-center gap-2 rounded-full border border-primary/30 bg-primary/10 px-3 py-1 text-xs font-semibold uppercase tracking-[0.22em] text-primary">
              <Sparkles className="h-3.5 w-3.5" aria-hidden="true" />
              Practice dashboard
            </p>
            <div>
              <p className="text-sm font-medium uppercase tracking-[0.24em] text-muted-foreground">
                Dashboard
              </p>
              <h1 id="main-heading" className="mt-1 text-3xl font-bold tracking-tight text-foreground">
                Your recent practice
              </h1>
              <p className="mt-2 max-w-2xl text-sm leading-relaxed text-muted-foreground">
                A calm snapshot of your latest attempts, progress trends, and the practice work you may want to revisit.
              </p>
            </div>
          </div>

          <div className="flex flex-wrap gap-3">
            <PracticeAccessibilityMenu buttonMode="label" />
            <Link
              href="/dashboard"
              className="inline-flex items-center gap-2 rounded-full border border-border bg-card px-4 py-2 text-sm font-semibold text-foreground transition hover:bg-muted focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring"
            >
              Back to main dashboard
              <ArrowRight className="h-4 w-4" aria-hidden="true" />
            </Link>
          </div>
        </div>

        <div className="mt-6 grid gap-4 md:grid-cols-3">
          <StatCard
            icon={BarChart3}
            label="Average accuracy"
            value={`${avgPct.toFixed(1)}%`}
            tone="primary"
          />
          <StatCard
            icon={ListChecks}
            label="Completed sets"
            value={completedCount}
            tone="success"
          />
          <StatCard
            icon={Clock3}
            label="In progress"
            value={activeCount}
            tone="primary"
          />
        </div>
      </div>

      <WidgetCard
        title="Recent attempts"
        subtitle="Your latest practice sessions in one place."
        contentClassName="p-0"
        actionSlot={
          <span className="rounded-full border border-border bg-muted px-3 py-1.5 text-xs font-medium text-muted-foreground">
            {attempts?.length ?? 0} shown
          </span>
        }
      >
        <div className="divide-y divide-border">
          {(attempts ?? []).length === 0 && (
            <div className="px-5 py-10 text-center sm:px-6">
              <p className="text-base font-medium text-foreground">
                No attempts yet.
              </p>
              <p className="mt-1 text-sm text-muted-foreground">
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
                        ? "bg-success/10 text-success"
                        : "bg-primary/10 text-primary"
                    }`}>
                      {isSubmitted ? "Submitted" : "In progress"}
                    </span>
                    <span className="text-xs text-muted-foreground">
                      {attempt.question_count ?? 0} questions
                    </span>
                  </div>
                  <h3 className="text-base font-semibold tracking-tight text-foreground">
                    {title}
                  </h3>
                  <p className="text-sm text-muted-foreground">
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
                    <p className="text-2xl font-bold tracking-tight text-foreground">
                      {attempt.score_raw ?? 0}/{attempt.question_count ?? 0}
                    </p>
                    <p className="text-xs text-muted-foreground">
                      {scorePct.toFixed(1)}%
                    </p>
                  </div>
                  <div className="h-2 w-24 overflow-hidden rounded-full bg-muted sm:w-32">
                    <div
                      className="h-full rounded-full bg-primary"
                      style={{ width: `${Math.max(5, scorePct)}%` }}
                    />
                  </div>
                </div>
              </div>
            );
          })}
        </div>
      </WidgetCard>
    </section>
  );
}
