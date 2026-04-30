import { NextResponse, type NextRequest } from "next/server";
import { createClient } from "@/lib/supabase/server";

export async function GET() {
  try {
    const supabase = await createClient();
    const { data, error } = await supabase
      .from("modules")
      .select("*")
      .eq("is_active", true)
      .order("display_order", { ascending: true });

    if (error) throw error;
    return NextResponse.json(data || []);
  } catch (error) {
    console.error("Error fetching modules:", error);
    return NextResponse.json({ error: "Failed to fetch modules" }, { status: 500 });
  }
}

export async function POST(req: NextRequest) {
  try {
    const supabase = await createClient();
    const body = await req.json();
    const { name, slug, name_np, description, display_order, price_paisa } = body;

    // (supabase as any): generated types don't yet include price_paisa.
    const { data, error } = await (supabase as any)
      .from("modules")
      .insert({
        name,
        slug,
        name_np,
        description,
        is_active: true,
        display_order,
        price_paisa,
      })
      .select()
      .single();

    if (error) throw error;
    return NextResponse.json(data);
  } catch (error: any) {
    console.error("Error creating module:", error);
    return NextResponse.json({ error: error.message || "Failed to create module" }, { status: 500 });
  }
}
