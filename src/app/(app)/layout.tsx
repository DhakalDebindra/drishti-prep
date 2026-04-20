import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { AppNavbar } from "@/components/layout/AppNavbar";
import { BackToDashboard } from "@/components/layout/BackToDashboard";

export default async function AppLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const supabase = await createClient();

  const {
    data: { user },
  } = await supabase.auth.getUser();

  // Note: Middleware already protects these routes, but we fetch user
  // here to pass the email/avatar to the Navbar.
  if (!user) {
    redirect("/login");
  }

  return (
    <div className="min-h-screen bg-slate-50 dark:bg-slate-950 transition-colors">
      <AppNavbar userEmail={user.email} />
      <main id="main" aria-labelledby="main-heading">
        {children}
        <BackToDashboard />
      </main>
    </div>
  );
}
