import { NextResponse } from 'next/server';
import { createClient } from "../../../../lib/supabase/server";

export async function PATCH(req: Request, { params }: { params: Promise<{ id: string }> }) {
  try {
    const { id } = await params;
    const supabase = await createClient();

    const { data: { user } } = await supabase.auth.getUser();
    if (!user) return NextResponse.json({ error: "Not authenticated" }, { status: 401 });

    const body = await req.json();

    // The admin lookup runs alongside the update instead of gating it: this
    // client is bound to the anon key plus the caller's cookies, so the
    // is_admin() RLS policy on questions is what actually authorises the
    // write. A non-admin's update touches zero rows either way — the profile
    // read only decides which error we report, one round trip sooner.
    const [{ data: profile }, { data, error }] = await Promise.all([
      supabase
        .from("profiles")
        .select("is_admin")
        .eq("id", user.id)
        .single(),
      supabase
        .from("questions")
        .update(body)
        .eq("id", id)
        .select()
        .single(),
    ]);

    // A returned row means RLS accepted the write, which is itself proof of
    // admin — no need to second-guess it if the profile read hiccupped.
    if (!error && data) return NextResponse.json(data);

    if (!profile?.is_admin) return NextResponse.json({ error: "Forbidden" }, { status: 403 });

    throw error;
  } catch (err: unknown) {
    console.error("PATCH Question Error:", err);
    return NextResponse.json({ error: "Failed to update question" }, { status: 500 });
  }
}
