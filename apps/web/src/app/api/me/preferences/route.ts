import { NextResponse } from "next/server";
import { createClient } from "@/lib/supabase/server";
import {
  AccessibilityPreferences,
  defaultAccessibilityPreferences,
  normalizeAccessibilityPreferences,
  resolveAccessibilityPreferences,
} from "@/lib/accessibility-preferences";

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
    return NextResponse.json({
      authenticated: false,
      tutor_voice_enabled: false,
      accessibility_preferences: defaultAccessibilityPreferences,
    });
  }

  const { data: profile } = await (supabase as any)
    .from("profiles")
    .select("tutor_voice_enabled, accessibility_preferences")
    .eq("id", user.id)
    .single();

  return NextResponse.json({
    authenticated: true,
    tutor_voice_enabled: Boolean(profile?.tutor_voice_enabled),
    accessibility_preferences: resolveAccessibilityPreferences(
      profile?.accessibility_preferences as Partial<AccessibilityPreferences> | null | undefined
    ),
  });
}

type UpdatePreferencesBody = {
  accessibility_preferences?: Partial<AccessibilityPreferences>;
};

export async function PATCH(request: Request) {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (!user) {
    return NextResponse.json({ error: "Not authenticated." }, { status: 401 });
  }

  const body = (await request.json().catch(() => ({}))) as UpdatePreferencesBody;
  const nextAccessibilityPreferences = normalizeAccessibilityPreferences(body.accessibility_preferences);

  const { error } = await (supabase as any)
    .from("profiles")
    .update({
      accessibility_preferences: nextAccessibilityPreferences,
    })
    .eq("id", user.id);

  if (error) {
    console.error("[preferences] patch failed:", error);
    return NextResponse.json({ error: "Could not save your preferences." }, { status: 500 });
  }

  return NextResponse.json({
    success: true,
    authenticated: true,
    accessibility_preferences: nextAccessibilityPreferences,
  });
}
