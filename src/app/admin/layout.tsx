import { createClient } from "@/lib/supabase/server";
import { redirect } from "next/navigation";
import Link from "next/link";
import { Button } from "@/components/ui/button";

export default async function AdminLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const supabase = await createClient();

  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (!user) {
    redirect("/login");
  }

  // const { data: profile } = await supabase
  //   .from("profiles")
  //   .select("is_admin, full_name")
  //   .eq("id", user.id)
  //   .single();

  // if (!profile?.is_admin) {
  //   redirect("/");
  // }

  return (
    <div className="min-h-screen bg-gray-50 flex flex-col md:flex-row">
      {/* Sidebar Navigation */}
      <aside className="w-full md:w-64 bg-white border-r border-gray-200 flex flex-col">
        <div className="p-6 border-b border-gray-200">
          <h2 className="text-xl font-bold text-blue-800">DristiPrep Admin</h2>
          <p className="text-sm text-gray-500 mt-1">Facilitator Dashboard</p>
        </div>
        
        <nav className="flex-1 p-4 space-y-2">
          <Link href="/admin">
            <Button variant="ghost" className="w-full justify-start">
              Dashboard Home
            </Button>
          </Link>
          <Link href="/admin/question-sets/create">
            <Button variant="secondary" className="w-full justify-start font-medium bg-blue-50 text-blue-700 hover:bg-blue-100">
              + Create Question Set
            </Button>
          </Link>
          <Button variant="ghost" className="w-full justify-start text-gray-500 hover:text-gray-900 cursor-not-allowed">
            Manage Users (Coming Soon)
          </Button>
          <Button variant="ghost" className="w-full justify-start text-gray-500 hover:text-gray-900 cursor-not-allowed">
            View Analytics (Coming Soon)
          </Button>
        </nav>

        <div className="p-4 border-t border-gray-200">
          <div className="flex items-center gap-3 mb-4">
            <div className="w-8 h-8 rounded-full bg-blue-100 flex items-center justify-center text-blue-800 font-bold">
              {/* profile.full_name?.charAt(0) ||  */}
              {user.email?.charAt(0)}
            </div>
            <div className="text-sm overflow-hidden text-ellipsis whitespace-nowrap">
              <p className="font-medium text-gray-900">{/* profile.full_name || */ "Admin User"}</p>
              <p className="text-gray-500">{user.email}</p>
            </div>
          </div>
          
          <form action="/auth/signout" method="post">
             <Button variant="outline" className="w-full" type="submit">
               Sign Out
             </Button>
          </form>
        </div>
      </aside>

      {/* Main Content Area */}
      <main className="flex-1 overflow-y-auto">
        <div className="p-4 md:p-8">
          {children}
        </div>
      </main>
    </div>
  );
}
