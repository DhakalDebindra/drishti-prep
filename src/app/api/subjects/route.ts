import { NextResponse } from "next/server";
import { createClient } from "@/lib/supabase/server";

type SubjectPayload = {
  id: string;
  name: string;
};

const errorResponse = (message: string, status = 500) =>
  NextResponse.json({ error: message }, { status });

export async function GET() {
  try {
    const supabase = await createClient();
    const { data, error } = await supabase
      .from("subjects")
      .select("id,name")
      .order("name", { ascending: true });

    if (error) {
      throw error;
    }

    return NextResponse.json(data ?? []);
  } catch (error) {
    console.error("Error fetching subjects:", error);
    const message = error instanceof Error ? error.message : "Unable to fetch subjects";
    return errorResponse(message);
  }
}

export async function POST(req: Request) {
  try {
    const supabase = await createClient();
    const body = await req.json().catch(() => ({}));
    const name = typeof body?.name === "string" ? body.name.trim() : "";

    if (!name) {
      return NextResponse.json({ error: "Subject name is required" }, { status: 400 });
    }

    const { data: existingSubjects, error: searchError } = await supabase
      .from("subjects")
      .select("id,name")
      .ilike("name", name)
      .limit(1);

    if (searchError) {
      throw searchError;
    }

    if (existingSubjects && existingSubjects.length > 0) {
      return NextResponse.json(existingSubjects[0]);
    }

    const { data: insertedSubject, error: insertError } = await supabase
      .from("subjects")
      .insert({ name })
      .select("id,name")
      .single();

    if (insertError) {
      throw insertError;
    }

    return NextResponse.json(insertedSubject as SubjectPayload);
  } catch (error) {
    console.error("Error creating subject:", error);
    const message = error instanceof Error ? error.message : "Unable to create subject";
    return errorResponse(message);
  }
}
