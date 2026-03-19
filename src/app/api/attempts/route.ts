import { NextResponse } from "next/server";
import { createClient } from "@/lib/supabase/server";

export async function POST(req: Request) {
  const supabase = await createClient();
  const {
    data: { user },
    error: authError,
  } = await supabase.auth.getUser();

  if (authError || !user) {
    return NextResponse.json({ error: "Not authenticated" }, { status: 401 });
  }

  const payload = await req.json().catch(() => ({}));
  const setId = payload?.set_id as string | undefined;

  if (!setId) {
    return NextResponse.json({ error: "set_id is required" }, { status: 400 });
  }

  // Reuse existing in-progress attempt if present.
  const { data: existing } = await supabase
    .from("attempts")
    .select("id, status, question_count, score_raw, score_pct, set_version")
    .eq("user_id", user.id)
    .eq("set_id", setId)
    .eq("status", "in_progress")
    .order("started_at", { ascending: false })
    .limit(1)
    .maybeSingle();

  if (existing) {
    return NextResponse.json(existing, { status: 200 });
  }

  const { data: set, error: setError } = await supabase
    .from("question_sets")
    .select("id, version")
    .eq("id", setId)
    .maybeSingle();

  if (setError || !set) {
    return NextResponse.json({ error: "Set not found" }, { status: 404 });
  }

  const { count } = await supabase
    .from("questions")
    .select("id", { count: "exact", head: true })
    .eq("set_id", setId);

  const questionCount = count ?? 0;

  const { data: attempt, error: insertError } = await supabase
    .from("attempts")
    .insert({
      user_id: user.id,
      set_id: setId,
      set_version: set.version ?? 1,
      status: "in_progress",
      question_count: questionCount,
    })
    .select("id, status, question_count, score_raw, score_pct, set_version")
    .single();

  if (insertError || !attempt) {
    return NextResponse.json({ error: insertError?.message || "Could not create attempt" }, { status: 500 });
  }

  return NextResponse.json(attempt, { status: 201 });
}
