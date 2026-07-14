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
import { CourseCard } from "@/components/courses/CourseCard";
import { DashboardWelcomeCard } from "@/components/dashboard/DashboardWelcomeCard";

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
    <div className="min-h-screen bg-background text-foreground">
      <div className="mx-auto flex max-w-[var(--dp-shell-width)] flex-col gap-10 px-4 py-8 sm:px-6 lg:px-8">
        <div className="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
          <div>
            <h1 id="main-heading" className="text-3xl font-bold tracking-tight text-foreground">
              Welcome back
            </h1>
            <p className="mt-2 text-muted-foreground">
              Track your progress, review your mistakes, and continue learning.
            </p>
          </div>
          <PracticeAccessibilityMenu buttonMode="label" />
        </div>

        <DashboardWelcomeCard />

        <IdentityVerifyPrompt shouldShow={disabilityStatus === "not_submitted"} />

        <IdentityStatusBanner
          status={disabilityStatus}
          rejectionReason={profile?.disability_rejection_reason ?? null}
        />

        {activeCourses.length > 0 && (
          <section aria-labelledby="dash-courses-heading" className="space-y-4">
            <h2 id="dash-courses-heading" className="text-xl font-bold tracking-tight text-foreground">
              Active Courses
            </h2>
            <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
              {activeCourses.map((course: any) => (
                <CourseCard
                  key={course.slug}
                  href={`/courses/${course.slug}`}
                  name={course.name}
                  description={course.description || "Continue your preparation"}
                  badgeLabel="Enrolled"
                  badgeTone="success"
                  ctaLabel="Access Course"
                  ctaVariant="outline"
                />
              ))}
            </div>
          </section>
        )}

        <section aria-labelledby="dash-progress-heading" className="space-y-6">
          <h2 id="dash-progress-heading" className="text-xl font-bold tracking-tight text-foreground">
            Progress
          </h2>
          <div id="analytics">
            <MacroAnalytics attempts={safeAttempts} />
          </div>
          <MemoryHeatWidget
            overallHeat={memoryHeat.overallHeat}
            totalQuestions={memoryHeat.totalQuestions}
            coldestTopics={memoryHeat.coldestTopics}
          />
        </section>

        <section aria-labelledby="dash-practice-heading" className="space-y-6">
          <h2 id="dash-practice-heading" className="text-xl font-bold tracking-tight text-foreground">
            Practice
          </h2>
          {episode && mananaSignedUrl && (
            <MananaPlayerCard
              episodeId={episode.id}
              audioUrl={mananaSignedUrl}
            />
          )}
          <PracticeBanners attempts={safeAttempts} />
        </section>

        <section aria-labelledby="dash-history-heading" className="space-y-6">
          <h2 id="dash-history-heading" className="text-xl font-bold tracking-tight text-foreground">
            History
          </h2>
          <AttemptHistoryList attempts={safeAttempts} />
        </section>
      </div>
    </div>
  );
}
