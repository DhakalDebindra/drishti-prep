import { NextResponse } from 'next/server';
import { createClient } from "../../../../../lib/supabase/server";

export async function POST(req: Request, { params }: { params: Promise<{ questionId: string }> }) {
  try {
    const { questionId } = await params;
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

    // Mark all pending reports for this question as resolved
    const { data, error } = await supabase
      .from("reports")
      .update({ status: 'resolved' })
      .eq("question_id", questionId)
      .eq("status", "pending")
      .select();

    if (error) throw error;

    return NextResponse.json({ message: `Resolved ${data.length} reports for question` });
  } catch (err: unknown) {
    console.error("Resolve Dispute Error:", err);
    return NextResponse.json({ error: "Failed to resolve dispute" }, { status: 500 });
  }
}
