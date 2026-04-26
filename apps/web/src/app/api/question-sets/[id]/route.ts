import { NextResponse } from 'next/server';
import { createClient } from "../../../../lib/supabase/server";

export async function PATCH(req: Request, { params }: { params: Promise<{ id: string }> }) {
  try {
    const { id } = await params;
    const supabase = await createClient();

    const { data: { user } } = await supabase.auth.getUser();
    if (!user) return NextResponse.json({ error: "Not authenticated" }, { status: 401 });

    const { data: profile } = await supabase
      .from("profiles")
      .select("is_admin")
      .eq("id", user.id)
      .single();

    if (!profile?.is_admin) return NextResponse.json({ error: "Forbidden" }, { status: 403 });

    const body = await req.json();
    
    // allow updating specific fields like is_verified (status)
    const { data, error } = await supabase
      .from("question_sets")
      .update(body)
      .eq("id", id)
      .select()
      .single();

    if (error) throw error;

    return NextResponse.json(data);
  } catch (err: unknown) {
    console.error("PATCH Question Set Error:", err);
    return NextResponse.json({ error: "Failed to update question set" }, { status: 500 });
  }
}

export async function DELETE(req: Request, { params }: { params: Promise<{ id: string }> }) {
  try {
    const { id } = await params;
    const supabase = await createClient();

    const { data: { user } } = await supabase.auth.getUser();
    if (!user) return NextResponse.json({ error: "Not authenticated" }, { status: 401 });

    const { data: profile } = await supabase
      .from("profiles")
      .select("is_admin")
      .eq("id", user.id)
      .single();

    if (!profile?.is_admin) return NextResponse.json({ error: "Forbidden" }, { status: 403 });

    // 1. Get all question IDs in this set
    const { data: junctionData, error: fetchError } = await supabase
      .from("question_set_questions")
      .select("question_id")
      .eq("question_set_id", id);

    if (fetchError) {
      console.error("Fetch Junction Error:", fetchError);
      throw new Error(`Failed to fetch questions in set: ${fetchError.message}`);
    }
    const questionIds = junctionData?.map(j => j.question_id) || [];

    // 2. Sequential Cleanup
    
    if (questionIds.length > 0) {
      // a. Delete reports linked to these questions
      const { error: reportsErr } = await supabase.from("reports").delete().in("question_id", questionIds);
      if (reportsErr) console.warn("Reports Cleanup Error:", reportsErr);
      
      // b. Delete bookmarks linked to these questions
      const { error: bookmarkErr } = await supabase.from("bookmarks").delete().in("question_id", questionIds);
      if (bookmarkErr) console.warn("Bookmarks Cleanup Error:", bookmarkErr);

      // c. Delete attempt answers linked to these questions
      const { error: answersErr } = await supabase.from("attempt_answers").delete().in("question_id", questionIds);
      if (answersErr) console.warn("Answers Cleanup Error:", answersErr);
    }

    // d. Clear attempts and their feedback
    const { data: attemptData } = await supabase.from("attempts").select("id").eq("set_id", id);
    const attemptIds = attemptData?.map(a => a.id) || [];
    
    if (attemptIds.length > 0) {
      // Delete AI feedback for these attempts first
      await supabase.from("ai_feedback").delete().in("attempt_id", attemptIds);
      // Delete the attempts themselves
      const { error: attDelErr } = await supabase.from("attempts").delete().in("id", attemptIds);
      if (attDelErr) console.warn("Attempts Deletion Warning:", attDelErr.message);
    }

    // e. Delete learning path associations (Topic/Module/Subject)
    await supabase.from("topic_learning_paths").delete().eq("question_set_id", id);

    // f. Delete records from junction table
    const { error: juncDelErr } = await supabase.from("question_set_questions").delete().eq("question_set_id", id);
    if (juncDelErr) console.warn("Junction Table Clear Warning:", juncDelErr.message);

    // g. Delete the physical questions (if not linked elsewhere)
    if (questionIds.length > 0) {
      await supabase.from("questions").delete().in("id", questionIds);
    }

    // h. Finally delete the question set itself
    const { error: setDeleteError } = await supabase
      .from("question_sets")
      .delete()
      .eq("id", id);

    if (setDeleteError) {
      console.error("Set Delete Error:", setDeleteError);
      return NextResponse.json({ 
        error: `Database constraint prevented deletion of set: ${setDeleteError.message}. Questions have been cleared, but the set metadata remains. Please contact support if this persists.`
      }, { status: 409 });
    }

    return NextResponse.json({ success: true });
  } catch (err: any) {
    console.error("DELETE Question Set Error:", err);
    return NextResponse.json({ error: err.message || "Failed to delete question set" }, { status: 500 });
  }
}
