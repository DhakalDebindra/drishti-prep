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
      .from("subjects")
      .select("*")
      .eq("id", id)
      .single();

    if (error) throw error;
    if (!data) return NextResponse.json({ error: "Subject not found" }, { status: 404 });

    return NextResponse.json(data);
  } catch (error) {
    console.error("Error fetching subject:", error);
    return NextResponse.json({ error: "Failed to fetch subject" }, { status: 500 });
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
    const { name, name_np, description, module_id, syllabus_ref, display_order } = body;

    const { data, error } = await supabase
      .from("subjects")
      .update({
        name,
        name_np,
        description,
        module_id,
        syllabus_ref,
        display_order,
      })
      .eq("id", id)
      .select()
      .single();

    if (error) throw error;

    return NextResponse.json(data);
  } catch (error: any) {
    console.error("Error updating subject:", error);
    return NextResponse.json({ error: error.message || "Failed to update subject" }, { status: 500 });
  }
}

export async function DELETE(
  req: Request,
  { params }: { params: Promise<{ id: string }> }
) {
  const { id } = await params;
  try {
    const supabase = await createClient();

    // Safe delete check: Check for dependent topics
    const { count, error: countError } = await supabase
      .from("topics")
      .select("*", { count: 'exact', head: true })
      .eq("subject_id", id);

    if (countError) throw countError;

    if (count && count > 0) {
      return NextResponse.json(
        { error: `Cannot delete subject: It contains ${count} topics. Delete or move them first.` },
        { status: 400 }
      );
    }

    const { error } = await supabase
      .from("subjects")
      .delete()
      .eq("id", id);

    if (error) throw error;

    return NextResponse.json({ message: "Subject deleted successfully" });
  } catch (error: any) {
    console.error("Error deleting subject:", error);
    return NextResponse.json({ error: error.message || "Failed to delete subject" }, { status: 500 });
  }
}
