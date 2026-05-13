import { NextResponse } from "next/server";
import { createClient } from "@/lib/supabase/server";

export const runtime = "nodejs";

/**
 * Lists question IDs in a set that still need audio generation.
 * Admin-only. Used by the audio-batch UI to drive the per-question loop.
 */
export async function GET(req: Request) {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });

  const { data: profile } = await supabase
    .from("profiles")
    .select("is_admin")
    .eq("id", user.id)
    .single();
  if (!profile?.is_admin) {
    return NextResponse.json({ error: "Forbidden" }, { status: 403 });
  }

  const url = new URL(req.url);
  const setId = url.searchParams.get("set_id");
  if (!setId || !/^[0-9a-f-]{36}$/i.test(setId)) {
    return NextResponse.json({ error: "Invalid set_id" }, { status: 400 });
  }

  const { data, error } = await (supabase as any)
    .from("questions")
    .select("id")
    .eq("set_id", setId)
    .eq("audio_ready", false)
    .order("order_number", { ascending: true });

  if (error) {
    return NextResponse.json({ error: error.message }, { status: 500 });
  }

  return NextResponse.json({
    ids: (data ?? []).map((q: { id: string }) => q.id),
  });
}
