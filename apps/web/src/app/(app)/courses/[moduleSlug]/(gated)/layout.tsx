import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { getModuleAccess } from "@/lib/access";

export const dynamic = "force-dynamic";

interface GatedLayoutProps {
  children: React.ReactNode;
  params: Promise<{ moduleSlug: string }>;
}

export default async function GatedModuleLayout({ children, params }: GatedLayoutProps) {
  const { moduleSlug } = await params;
  const supabase = await createClient();

  const { data: moduleData } = await supabase
    .from("modules")
    .select("id")
    .eq("slug", moduleSlug)
    .single();

  if (!moduleData) {
    return <>{children}</>;
  }

  const { hasAccess, enrollment } = await getModuleAccess(moduleData.id);

  if (!hasAccess) {
    if (enrollment?.status === "pending") {
      redirect(`/courses/${moduleSlug}/enroll?status=pending`);
    } else if (enrollment?.status === "rejected") {
      redirect(`/courses/${moduleSlug}/enroll?status=rejected&reason=${encodeURIComponent(enrollment.rejection_reason || "")}`);
    } else {
      redirect(`/courses/${moduleSlug}/enroll`);
    }
  }

  return <>{children}</>;
}
