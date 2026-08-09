import { NextResponse } from 'next/server';
import { addQuestionToSetSchema } from "@repo/validation";
import { createClient } from "@/lib/supabase/server";

/**
 * Append a new question to an existing set.
 *
 * The add_question_to_set() function does the whole write in one round trip:
 * it assigns order_number/position and inserts both the question row and its
 * question_set_questions membership row (a question needs both linkages) in a
 * single transaction.
 *
 * The admin check runs concurrently with the write rather than gating it.
 * That is safe because the Supabase server client is bound to the anon key
 * plus the caller's cookies, so RLS — the is_admin() policies on questions and
 * question_set_questions — is what actually authorises the insert. The profile
 * lookup only decides which error we report, and costs no extra latency here.
 */
export async function POST(
  req: Request,
  { params }: { params: Promise<{ id: string }> }
) {
  try {
    const { id: setId } = await params;
    const supabase = await createClient();

    const { data: { user } } = await supabase.auth.getUser();
    if (!user) return NextResponse.json({ error: "Not authenticated" }, { status: 401 });

    const parseResult = addQuestionToSetSchema.safeParse(await req.json());
    if (!parseResult.success) {
      return NextResponse.json(
        { error: parseResult.error.issues[0].message },
        { status: 400 }
      );
    }

    const payload = parseResult.data;

    const [{ data: profile }, { data: inserted, error: insertError }] = await Promise.all([
      supabase
        .from("profiles")
        .select("is_admin")
        .eq("id", user.id)
        .single(),
      supabase
        .rpc("add_question_to_set", {
          p_set_id: setId,
          p_content: payload.content,
          p_option_a: payload.option_a,
          p_option_b: payload.option_b,
          p_option_c: payload.option_c,
          p_option_d: payload.option_d,
          p_correct_option: payload.correct_option,
          p_explanation: payload.explanation || null,
          p_exam_year: payload.exam_year ?? null,
          p_paper_ref: payload.paper_ref ?? null,
          p_language: payload.language ?? "nepali",
        })
        .single(),
    ]);

    // A returned row means RLS accepted both inserts, which is itself proof of
    // admin — no need to second-guess it if the profile read hiccupped.
    if (!insertError && inserted) {
      return NextResponse.json(inserted, { status: 201 });
    }

    if (!profile?.is_admin) return NextResponse.json({ error: "Forbidden" }, { status: 403 });

    console.error("Failed to add question to set", insertError);
    // The function raises no_data_found (P0002) when the set does not exist.
    const notFound = insertError?.code === "P0002" ||
      /not found/i.test(insertError?.message ?? "");
    return NextResponse.json(
      { error: insertError?.message || "Failed to create question" },
      { status: notFound ? 404 : 400 }
    );
  } catch (err: unknown) {
    console.error("POST set question Error:", err);
    return NextResponse.json({ error: "Failed to add question to set" }, { status: 500 });
  }
}
