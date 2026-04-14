import { NextResponse } from 'next/server';
import { createClient } from "../../../../../../lib/supabase/server";

export async function PATCH(
  req: Request,
  { params }: { params: Promise<{ id: string; questionId: string }> }
) {
  try {
    const { id: setId, questionId } = await params;
    const supabase = await createClient();

    // Verify admin
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) return NextResponse.json({ error: "Not authenticated" }, { status: 401 });

    const { data: profile } = await supabase
      .from("profiles")
      .select("is_admin")
      .eq("id", user.id)
      .single();

    if (!profile?.is_admin) return NextResponse.json({ error: "Forbidden" }, { status: 403 });

    const body = await req.json();
    const { position } = body;

    if (position === undefined) {
      return NextResponse.json({ error: "position is required" }, { status: 400 });
    }

    const { data, error } = await supabase
      .from("question_set_questions")
      .update({ position })
      .eq("question_set_id", setId)
      .eq("question_id", questionId)
      .select()
      .single();

    if (error) throw error;

    return NextResponse.json(data);
  } catch (err: unknown) {
    console.error("PATCH QSQ Error:", err);
    return NextResponse.json({ error: "Failed to update question position" }, { status: 500 });
  }
}

export async function DELETE(
  req: Request,
  { params }: { params: Promise<{ id: string; questionId: string }> }
) {
  try {
    const { id: setId, questionId } = await params;
    const supabase = await createClient();

    // Verify admin
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) return NextResponse.json({ error: "Not authenticated" }, { status: 401 });

    const { data: profile } = await supabase
      .from("profiles")
      .select("is_admin")
      .eq("id", user.id)
      .single();

    if (!profile?.is_admin) return NextResponse.json({ error: "Forbidden" }, { status: 403 });

    const { error } = await supabase
      .from("question_set_questions")
      .delete()
      .eq("question_set_id", setId)
      .eq("question_id", questionId);

    if (error) throw error;

    return NextResponse.json({ success: true });
  } catch (err: unknown) {
    console.error("DELETE QSQ Error:", err);
    return NextResponse.json({ error: "Failed to remove question from set" }, { status: 500 });
  }
}
