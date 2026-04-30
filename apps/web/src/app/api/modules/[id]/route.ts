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
      .from("modules")
      .select("*")
      .eq("id", id)
      .single();

    if (error) throw error;
    if (!data) return NextResponse.json({ error: "Module not found" }, { status: 404 });

    return NextResponse.json(data);
  } catch (error) {
    console.error("Error fetching module:", error);
    return NextResponse.json({ error: "Failed to fetch module" }, { status: 500 });
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
    const { name, slug, name_np, description, is_active, display_order, price_paisa } = body;

    // (supabase as any): generated types don't yet include price_paisa.
    const { data, error } = await (supabase as any)
      .from("modules")
      .update({
        name,
        slug,
        name_np,
        description,
        is_active,
        display_order,
        price_paisa,
      })
      .eq("id", id)
      .select()
      .single();

    if (error) throw error;

    return NextResponse.json(data);
  } catch (error: any) {
    console.error("Error updating module:", error);
    return NextResponse.json({ error: error.message || "Failed to update module" }, { status: 500 });
  }
}

export async function DELETE(
  req: Request,
  { params }: { params: Promise<{ id: string }> }
) {
  const { id } = await params;
  try {
    const supabase = await createClient();

    // Safe delete check: Check for dependent subjects
    const { count, error: countError } = await supabase
      .from("subjects")
      .select("*", { count: 'exact', head: true })
      .eq("module_id", id);

    if (countError) throw countError;

    if (count && count > 0) {
      return NextResponse.json(
        { error: `Cannot delete module: It contains ${count} subjects. Delete or reassign them first.` },
        { status: 400 }
      );
    }

    const { error } = await supabase
      .from("modules")
      .delete()
      .eq("id", id);

    if (error) throw error;

    return NextResponse.json({ message: "Module deleted successfully" });
  } catch (error: any) {
    console.error("Error deleting module:", error);
    return NextResponse.json({ error: error.message || "Failed to delete module" }, { status: 500 });
  }
}
