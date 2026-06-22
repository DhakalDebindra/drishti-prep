import Link from "next/link";
import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { MacroAnalytics } from "@/components/dashboard/MacroAnalytics";
import { PracticeBanners } from "@/components/dashboard/PracticeBanners";
import { AttemptHistoryList } from "@/components/dashboard/AttemptHistoryList";
import { IdentityStatusBanner } from "@/components/dashboard/IdentityStatusBanner";
import { IdentityVerifyPrompt } from "@/components/dashboard/IdentityVerifyPrompt";
import { MemoryHeatWidget } from "@/components/dashboard/MemoryHeatWidget";
import { fetchMemoryHeat } from "@/lib/manana/heat-aggregate";
import { MananaPlayerCard } from "@/features/manana/components/MananaPlayerCard";
import { PracticeAccessibilityMenu } from "@/components/practice/AccessibilityMenu";

export default async function DashboardPage() {
  const supabase = await createClient();

  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (!user) {
    redirect("/login");
  }

  // Fetch user attempts with nested question set details
  const { data: attempts, error } = await supabase
    .from("attempts")
    .select(`
      id, 
      set_id,
      status, 
      score_raw, 
      score_pct, 
      question_count, 
      submitted_at,
      question_sets (
        title,
        topic:topics (
          name,
          slug,
          subject:subjects (
            name,
            slug,
            module:modules (
              slug
            )
          )
        )
      )
    `)
    .eq("user_id", user.id)
    .order("started_at", { ascending: false });

  if (error) {
    console.error("Error fetching dashboard attempts: ", error);
  }

  // Fetch active enrollments
  const { data: enrollments } = await (supabase as any)
    .from("enrollments")
    .select("module_id, modules(name, slug, description)")
    .eq("user_id", user.id)
    .eq("status", "approved");

  // Fetch profile for identity status banner
  const { data: profile } = await (supabase as any)
    .from("profiles")
    .select("disability_status, disability_rejection_reason")
    .eq("id", user.id)
    .single();

  const memoryHeat = await fetchMemoryHeat(supabase, user.id);

  const safeAttempts = attempts as any[] || [];
  const activeCourses = enrollments?.map((e: any) => e.modules).filter(Boolean) || [];
  const disabilityStatus = (profile?.disability_status ?? "not_submitted") as
    | "not_submitted"
    | "pending"
    | "approved"
    | "rejected";

  const { data: episode } = await (supabase as any)
    .from("manana_episodes")
    .select("id, storage_path")
    .eq("user_id", user.id)
    .eq("status", "ready")
    .order("week_starting", { ascending: false })
    .limit(1)
    .maybeSingle();

  let mananaSignedUrl = null;
  if (episode?.storage_path) {
    const { data } = await supabase.storage
      .from("manana-episodes")
      .createSignedUrl(episode.storage_path, 3600);
    mananaSignedUrl = data?.signedUrl || null;
  }

  return (
    <div className="min-h-screen bg-gradient-to-b from-slate-50 via-white to-teal-50/40 text-slate-900 dark:from-slate-950 dark:via-slate-950 dark:to-slate-900 dark:text-slate-50">
      <div className="pointer-events-none fixed inset-0 overflow-hidden">
        <div className="absolute left-[-5rem] top-[-5rem] h-72 w-72 rounded-full bg-teal-200/25 blur-3xl dark:bg-teal-500/10" />
        <div className="absolute right-[-5rem] top-24 h-72 w-72 rounded-full bg-cyan-200/20 blur-3xl dark:bg-cyan-500/10" />
      </div>

      <div className="relative mx-auto flex max-w-[var(--dp-shell-width)] flex-col gap-8 px-4 py-8 sm:px-6 lg:px-8">
        <div className="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
          <div>
            <h1 id="main-heading" className="text-3xl font-bold tracking-tight text-slate-950 dark:text-white">
              Welcome back
            </h1>
            <p className="mt-2 text-slate-600 dark:text-slate-400">
              Track your progress, review your mistakes, and continue learning.
            </p>
          </div>
          <PracticeAccessibilityMenu buttonMode="label" />
        </div>

        <IdentityVerifyPrompt shouldShow={disabilityStatus === "not_submitted"} />

        <IdentityStatusBanner
          status={disabilityStatus}
          rejectionReason={profile?.disability_rejection_reason ?? null}
        />

        {activeCourses.length > 0 && (
          <div className="space-y-4">
            <h2 className="text-xl font-bold tracking-tight text-slate-950 dark:text-white">Your Active Courses</h2>
            <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
              {activeCourses.map((course: any) => (
                <Link
                  key={course.slug}
                  href={`/courses/${course.slug}`}
                  className="group block rounded-[1.75rem] border border-slate-200/80 bg-white/90 p-6 shadow-[0_14px_40px_rgba(15,23,42,0.06)] transition hover:-translate-y-0.5 hover:shadow-[0_20px_50px_rgba(15,23,42,0.09)] focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-blue-500 dark:border-slate-800 dark:bg-slate-950/70"
                >
                  <h3 className="text-lg font-semibold text-slate-950 dark:text-white group-hover:text-blue-600 dark:group-hover:text-blue-400">{course.name}</h3>
                  <p className="mt-2 text-sm leading-relaxed text-slate-600 dark:text-slate-400 line-clamp-2">
                    {course.description || "Continue your preparation"}
                  </p>
                  <div className="mt-5 flex items-center text-sm font-medium text-blue-600 dark:text-blue-400">
                    Access Course <span className="ml-1 transition-transform group-hover:translate-x-1">→</span>
                  </div>
                </Link>
              ))}
            </div>
          </div>
        )}

        <div id="analytics">
          <MacroAnalytics attempts={safeAttempts} />
        </div>

        {episode && mananaSignedUrl && (
          <MananaPlayerCard
            episodeId={episode.id}
            audioUrl={mananaSignedUrl}
          />
        )}

        <MemoryHeatWidget
          overallHeat={memoryHeat.overallHeat}
          totalQuestions={memoryHeat.totalQuestions}
          coldestTopics={memoryHeat.coldestTopics}
        />

        <PracticeBanners attempts={safeAttempts} />

        <AttemptHistoryList attempts={safeAttempts} />
      </div>
    </div>
  );
}
