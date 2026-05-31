import Link from "next/link";
import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { MacroAnalytics } from "@/components/dashboard/MacroAnalytics";
import { PracticeBanners } from "@/components/dashboard/PracticeBanners";
import { AttemptHistoryList } from "@/components/dashboard/AttemptHistoryList";
import { IdentityStatusBanner } from "@/components/dashboard/IdentityStatusBanner";
import { IdentityVerifyPrompt } from "@/components/dashboard/IdentityVerifyPrompt";

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

  const safeAttempts = attempts as any[] || [];
  const activeCourses = enrollments?.map((e: any) => e.modules).filter(Boolean) || [];
  const disabilityStatus = (profile?.disability_status ?? "not_submitted") as
    | "not_submitted"
    | "pending"
    | "approved"
    | "rejected";

  return (
    <div className="max-w-5xl mx-auto px-4 py-8 space-y-8">
      <div>
        <h1 id="main-heading" className="text-3xl font-bold text-slate-900 dark:text-white mb-2">
          Welcome back
        </h1>
        <p className="text-slate-600 dark:text-slate-400">
          Track your progress, review your mistakes, and continue learning.
        </p>
      </div>

      <IdentityVerifyPrompt shouldShow={disabilityStatus === "not_submitted"} />

      <IdentityStatusBanner
        status={disabilityStatus}
        rejectionReason={profile?.disability_rejection_reason ?? null}
      />

      {activeCourses.length > 0 && (
        <div className="space-y-4">
          <h2 className="text-xl font-bold text-slate-900 dark:text-white">Your Active Courses</h2>
          <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
            {activeCourses.map((course: any) => (
              <Link
                key={course.slug}
                href={`/courses/${course.slug}`}
                className="block p-5 bg-white dark:bg-slate-800 border border-slate-200 dark:border-slate-700 rounded-xl shadow-sm hover:shadow-md transition focus:outline-none focus:ring-2 focus:ring-blue-500"
              >
                <h3 className="font-semibold text-lg text-slate-900 dark:text-white">{course.name}</h3>
                <p className="mt-1 text-sm text-slate-500 dark:text-slate-400 line-clamp-2">
                  {course.description || "Continue your preparation"}
                </p>
                <div className="mt-4 flex items-center text-sm font-medium text-blue-600 dark:text-blue-400">
                  Access Course <span className="ml-1">→</span>
                </div>
              </Link>
            ))}
          </div>
        </div>
      )}

      <div id="analytics">
        <MacroAnalytics attempts={safeAttempts} />
      </div>

      <PracticeBanners attempts={safeAttempts} />

      <AttemptHistoryList attempts={safeAttempts} />
    </div>
  );
}
