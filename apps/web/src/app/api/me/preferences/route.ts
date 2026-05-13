import { NextResponse } from "next/server";
import { createClient } from "@/lib/supabase/server";

export const runtime = "nodejs";

/**
 * Returns the current user's practice preferences. Guests get defaults.
 * Used by the practice page to decide whether to activate tutor-voice mode.
 */
export async function GET() {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (!user) {
    return NextResponse.json({ tutor_voice_enabled: false });
  }

  const { data: profile } = await (supabase as any)
    .from("profiles")
    .select("tutor_voice_enabled")
    .eq("id", user.id)
    .single();

  return NextResponse.json({
    tutor_voice_enabled: Boolean(profile?.tutor_voice_enabled),
  });
}
