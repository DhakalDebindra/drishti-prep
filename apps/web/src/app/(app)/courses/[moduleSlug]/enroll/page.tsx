import { notFound, redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { getModuleAccess } from "@/lib/access";
import EnrollClient from "./EnrollClient";

interface EnrollPageProps {
  params: Promise<{ moduleSlug: string }>;
}

export default async function EnrollPage({ params }: EnrollPageProps) {
  const { moduleSlug } = await params;
  const supabase = await createClient();

  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    redirect(`/login?next=/courses/${moduleSlug}/enroll`);
  }

  const { data: moduleData } = await (supabase as any)
    .from("modules")
    .select("id, name, price_paisa")
    .eq("slug", moduleSlug)
    .single();

  if (!moduleData) {
    notFound();
  }

  // If already approved or free, redirect to content
  const { hasAccess, enrollment } = await getModuleAccess(moduleData.id);
  if (hasAccess) {
    redirect(`/courses/${moduleSlug}`);
  }

  const { data: settings } = await (supabase as any)
    .from("site_settings")
    .select("*")
    .eq("id", 1)
    .single();

  const { data: profile } = await (supabase as any)
    .from("profiles")
    .select("full_name, disability_card_path, disability_verified")
    .eq("id", user.id)
    .single();

  // Don't leak the storage path to the client — only whether a card exists.
  const profileForClient = {
    full_name: profile?.full_name ?? null,
    has_card: !!profile?.disability_card_path,
    disability_verified: !!profile?.disability_verified,
  };

  return (
    <div className="max-w-3xl mx-auto px-4 py-8">
      <h1 className="text-2xl font-bold mb-6">Enroll in {moduleData.name}</h1>
      <EnrollClient
        moduleData={moduleData}
        settings={settings}
        profile={profileForClient}
        enrollment={enrollment}
      />
    </div>
  );
}
