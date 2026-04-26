import { NextResponse } from "next/server";
import { createClient } from "@/lib/supabase/server";

export async function GET(
  req: Request,
  { params }: { params: Promise<{ id: string }> }
) {
  const { id } = await params;
  try {
    const supabase = await createClient();
    const { data, error } = await supabase
      .from("topics")
      .select("*")
      .eq("id", id)
      .single();

    if (error) throw error;
    if (!data) return NextResponse.json({ error: "Topic not found" }, { status: 404 });

    return NextResponse.json(data);
  } catch (error) {
    console.error("Error fetching topic:", error);
    return NextResponse.json({ error: "Failed to fetch topic" }, { status: 500 });
  }
}

export async function PUT(
  req: Request,
  { params }: { params: Promise<{ id: string }> }
) {
  const { id } = await params;
  try {
    const supabase = await createClient();
    const body = await req.json();
    const { name, description, subject_id, syllabus_ref, display_order } = body;

    const { data, error } = await supabase
      .from("topics")
      .update({
        name,
        description,
        subject_id,
        syllabus_ref,
        display_order,
      })
      .eq("id", id)
      .select()
      .single();

    if (error) throw error;

    return NextResponse.json(data);
  } catch (error: any) {
    console.error("Error updating topic:", error);
    return NextResponse.json({ error: error.message || "Failed to update topic" }, { status: 500 });
  }
}

export async function DELETE(
  req: Request,
  { params }: { params: Promise<{ id: string }> }
) {
  const { id } = await params;
  try {
    const supabase = await createClient();

    // Safe delete check: Check for dependent question sets
    const { count, error: countError } = await supabase
      .from("question_sets")
      .select("*", { count: 'exact', head: true })
      .eq("topic_id", id);

    if (countError) throw countError;

    if (count && count > 0) {
      return NextResponse.json(
        { error: `Cannot delete topic: It contains ${count} question sets. Delete or move them first.` },
        { status: 400 }
      );
    }

    const { error } = await supabase
      .from("topics")
      .delete()
      .eq("id", id);

    if (error) throw error;

    return NextResponse.json({ message: "Topic deleted successfully" });
  } catch (error: any) {
    console.error("Error deleting topic:", error);
    return NextResponse.json({ error: error.message || "Failed to delete topic" }, { status: 500 });
  }
}
