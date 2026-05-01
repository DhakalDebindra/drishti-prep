"use server";

import { createClient } from "@/lib/supabase/server";
import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";
import { sendEmail } from "@/lib/email/send";
import {
  identityApprovedEmail,
  identityRejectedEmail,
} from "@/lib/email/templates";

/**
 * Approve a pending identity verification.
 *
 * The DB trigger sync_disability_status() will:
 *   - flip profiles.disability_status to 'approved'
 *   - set disability_verified=true, verified_at, verified_by
 *
 * After the DB update succeeds, we email the user with payment instructions
 * pulled from site_settings. Email is fail-soft — the approval stands even
 * if email delivery fails.
 */
export async function approveIdentityVerification(verificationId: string) {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) throw new Error("Not authenticated");

  // Look up the user this verification belongs to (need email + name for notification).
  const { data: verification } = await (supabase as any)
    .from("identity_verifications")
    .select("user_id, status")
    .eq("id", verificationId)
    .single();

  if (!verification) throw new Error("Verification not found");
  if (verification.status !== "pending") {
    throw new Error("Only pending verifications can be approved");
  }

  const { error: updateError } = await (supabase as any)
    .from("identity_verifications")
    .update({
      status: "approved",
      reviewed_by: user.id,
      reviewed_at: new Date().toISOString(),
    })
    .eq("id", verificationId);

  if (updateError) {
    console.error("[admin/identity-verifications] Approve failed:", updateError);
    throw new Error("Could not approve");
  }

  // Email the user. Don't fail the action if this errors.
  try {
    const [{ data: profile }, { data: settings }] = await Promise.all([
      (supabase as any)
        .from("profiles")
        .select("full_name, email")
        .eq("id", verification.user_id)
        .single(),
      (supabase as any)
        .from("site_settings")
        .select("payment_qr_url, payment_instructions, whatsapp_number")
        .eq("id", 1)
        .single(),
    ]);

    if (profile?.email) {
      const { subject, text } = identityApprovedEmail({
        fullName: profile.full_name ?? null,
        settings: settings ?? null,
      });
      await sendEmail({ to: profile.email, subject, text });
    } else {
      console.warn(
        "[admin/identity-verifications] No email on profile; skipped notification.",
        { user_id: verification.user_id }
      );
    }
  } catch (err) {
    console.error("[admin/identity-verifications] Email send threw:", err);
  }

  revalidatePath("/admin/identity-verifications");
  redirect("/admin/identity-verifications");
}

/**
 * Reject a pending identity verification with a required reason.
 *
 * Trigger updates profile to 'rejected' state and stores the reason; we then
 * email the user so they can re-submit.
 */
export async function rejectIdentityVerification(
  verificationId: string,
  reason: string
) {
  if (!reason.trim()) throw new Error("Rejection reason is required");

  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) throw new Error("Not authenticated");

  const { data: verification } = await (supabase as any)
    .from("identity_verifications")
    .select("user_id, status")
    .eq("id", verificationId)
    .single();

  if (!verification) throw new Error("Verification not found");
  if (verification.status !== "pending") {
    throw new Error("Only pending verifications can be rejected");
  }

  const { error: updateError } = await (supabase as any)
    .from("identity_verifications")
    .update({
      status: "rejected",
      rejection_reason: reason.trim(),
      reviewed_by: user.id,
      reviewed_at: new Date().toISOString(),
    })
    .eq("id", verificationId);

  if (updateError) {
    console.error("[admin/identity-verifications] Reject failed:", updateError);
    throw new Error("Could not reject");
  }

  try {
    const { data: profile } = await (supabase as any)
      .from("profiles")
      .select("full_name, email")
      .eq("id", verification.user_id)
      .single();

    if (profile?.email) {
      const { subject, text } = identityRejectedEmail({
        fullName: profile.full_name ?? null,
        reason: reason.trim(),
      });
      await sendEmail({ to: profile.email, subject, text });
    }
  } catch (err) {
    console.error("[admin/identity-verifications] Email send threw:", err);
  }

  revalidatePath("/admin/identity-verifications");
  redirect("/admin/identity-verifications");
}
