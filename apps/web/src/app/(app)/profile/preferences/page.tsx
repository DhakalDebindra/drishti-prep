import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { TutorVoiceToggle } from "./TutorVoiceToggle";

export const dynamic = "force-dynamic";

export default async function PreferencesPage() {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) {
    redirect("/login?next=/profile/preferences");
  }

  const { data: profile } = await (supabase as any)
    .from("profiles")
    .select("tutor_voice_enabled")
    .eq("id", user.id)
    .single();

  return (
    <section className="max-w-2xl mx-auto px-4 py-8 space-y-6">
      <div>
        <p className="text-sm uppercase tracking-wide text-gray-500">Profile</p>
        <h1 id="main-heading" className="text-2xl font-semibold text-gray-900">
          Preferences
        </h1>
        <p className="mt-2 text-gray-600">
          Choose how you want to experience practice sessions.
        </p>
      </div>

      <TutorVoiceToggle
        initialEnabled={Boolean(profile?.tutor_voice_enabled)}
      />
    </section>
  );
}
