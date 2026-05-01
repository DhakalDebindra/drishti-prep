import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import VerifyIdentityClient from "./Client";

export const dynamic = "force-dynamic";

type SearchParams = Promise<{ next?: string }>;

export default async function VerifyIdentityPage({
  searchParams,
}: {
  searchParams: SearchParams;
}) {
  const { next } = await searchParams;
  const supabase = await createClient();

  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (!user) {
    redirect(`/login?next=/profile/verify-identity`);
  }

  const { data: profile } = await (supabase as any)
    .from("profiles")
    .select(
      "full_name, disability_status, disability_rejection_reason, disability_card_uploaded_at, disability_verified_at"
    )
    .eq("id", user.id)
    .single();

  // Most recent verification attempt (audit history detail).
  const { data: latest } = await (supabase as any)
    .from("identity_verifications")
    .select("id, status, rejection_reason, created_at, reviewed_at")
    .eq("user_id", user.id)
    .order("created_at", { ascending: false })
    .limit(1)
    .maybeSingle();

  return (
    <section className="max-w-2xl mx-auto px-4 py-8 space-y-6">
      <div>
        <p className="text-sm uppercase tracking-wide text-gray-500">Profile</p>
        <h1 id="main-heading" className="text-2xl font-semibold text-gray-900">
          Identity verification
        </h1>
        <p className="mt-2 text-gray-600">
          DrishtiPrep is built primarily for visually-impaired aspirants. We ask
          all paid-course enrollees to submit a disability card as a one-time
          identity check. You only need to do this once.
        </p>
      </div>

      <VerifyIdentityClient
        status={profile?.disability_status ?? "not_submitted"}
        rejectionReason={profile?.disability_rejection_reason ?? null}
        latestSubmittedAt={latest?.created_at ?? null}
        latestReviewedAt={latest?.reviewed_at ?? null}
        verifiedAt={profile?.disability_verified_at ?? null}
        nextHref={typeof next === "string" ? next : null}
      />
    </section>
  );
}
