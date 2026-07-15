import { createClient } from "@/lib/supabase/server";
import { CourseCard } from "@/components/courses/CourseCard";

export const dynamic = "force-dynamic";

export default async function CoursesIndexPage() {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();

  const { data: modules, error } = await (supabase as any)
    .from("modules")
    .select("id, name, description, slug, price_paisa")
    .eq("is_active", true)
    .order("display_order", { ascending: true });

  if (error) {
    console.error("Error fetching courses:", error);
  }

  let enrolledModuleIds = new Set<string>();
  if (user && modules) {
    const { data: enrollments } = await (supabase as any)
      .from("enrollments")
      .select("module_id")
      .eq("user_id", user.id)
      .eq("status", "approved");

    if (enrollments) {
      enrolledModuleIds = new Set(enrollments.map((e: any) => e.module_id));
    }
  }

  return (
    <section className="space-y-6 max-w-5xl mx-auto px-4 py-8">
      <div>
        <p className="text-sm uppercase tracking-wide text-muted-foreground">Learning Paths</p>
        <h1 id="main-heading" className="text-2xl font-semibold text-foreground">Available Courses</h1>
        <p className="text-muted-foreground">Choose a course module to start your preparation.</p>
        {error && (
          <p className="mt-2 rounded-md bg-destructive/10 px-3 py-2 text-sm text-destructive">
            Unable to load courses right now. Please retry.
          </p>
        )}
      </div>
      {!modules || modules.length === 0 ? (
        <div className="rounded-xl border border-dashed border-border bg-card p-6 text-muted-foreground">
          No courses are available yet.
        </div>
      ) : (
        <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
          {modules.map((module: any) => {
            const isEnrolled = enrolledModuleIds.has(module.id);
            const isFree = !module.price_paisa;
            const canAccess = isEnrolled || isFree;

            return (
              <CourseCard
                key={module.id}
                // Accessible course → straight into the content tree view.
                // Locked course → its detail page (description + payment flow),
                // never the content tree. This is the conditional split; the
                // gated layout still enforces it server-side as a backstop.
                href={
                  canAccess
                    ? `/courses/${module.slug}`
                    : `/courses/${module.slug}/enroll`
                }
                name={module.name}
                description={module.description}
                badgeLabel={isEnrolled ? "Enrolled" : isFree ? "Free" : `NPR ${module.price_paisa / 100}`}
                badgeTone={canAccess ? "success" : "primary"}
                ctaLabel={canAccess ? "Access Course" : "Enroll"}
                ctaVariant={canAccess ? "outline" : "default"}
              />
            );
          })}
        </div>
      )}
    </section>
  );
}
