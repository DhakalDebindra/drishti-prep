import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { getCurrentUser } from "@/lib/supabase/user";
import { AppNavbar } from "@/components/layout/AppNavbar";
import { BackToDashboard } from "@/components/layout/BackToDashboard";

export const dynamic = "force-dynamic";
export const revalidate = 0;
export const fetchCache = "force-no-store";

export default async function AppLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const supabase = await createClient();

  // Note: Middleware already protects these routes, but we fetch user
  // here to pass the email/avatar to the Navbar. Shared with the page
  // inside this layout, so it costs one auth round trip, not two.
  const user = await getCurrentUser();

  if (!user) {
    redirect("/login");
  }

  // Courses the learner can open — enrolled (approved) OR free — power the
  // navbar's "My Courses" quick-nav, a direct jump into each course's subjects
  // instead of drilling in from the catalog. The two reads are independent, so
  // they go out together rather than one after the other.
  const [{ data: moduleRows }, { data: enrollmentRows }] = await Promise.all([
    (supabase as any)
      .from("modules")
      .select("id, name, slug, price_paisa")
      .eq("is_active", true)
      .order("display_order", { ascending: true }),
    (supabase as any)
      .from("enrollments")
      .select("module_id")
      .eq("user_id", user.id)
      .eq("status", "approved"),
  ]);

  const enrolledModuleIds = new Set<string>(
    ((enrollmentRows ?? []) as { module_id: string }[]).map((e) => e.module_id)
  );
  const myCourses = (
    (moduleRows ?? []) as { id: string; name: string; slug: string; price_paisa: number | null }[]
  )
    .filter((m) => !m.price_paisa || enrolledModuleIds.has(m.id))
    .map((m) => ({ name: m.name, slug: m.slug }));

  return (
    <div className="min-h-screen bg-slate-50 dark:bg-slate-950 transition-colors">
      <AppNavbar userEmail={user.email} courses={myCourses} />
      <main id="main" aria-labelledby="main-heading">
        {children}
        <BackToDashboard />
      </main>
    </div>
  );
}
