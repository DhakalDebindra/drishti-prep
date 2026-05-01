"use server";

import { createClient } from "@/lib/supabase/server";
import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";

/**
 * Admin-only enrollment creation.
 *
 * The user has paid out-of-band (eSewa/Khalti/cash) and sent proof via
 * WhatsApp/email/in-person. Admin looks up the user by email, picks the
 * module, fills in the proof reference, and submits. The row is created
 * with status='approved' so the user gets immediate access on next visit.
 */
export async function createEnrollment(args: {
  user_id: string;
  module_id: string;
  amount_paid_paisa: number;
  payment_reference: string | null;
  admin_notes: string | null;
}) {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) throw new Error("Not authenticated");

  if (!args.user_id || !args.module_id) {
    throw new Error("User and module are required");
  }
  if (args.amount_paid_paisa < 0) {
    throw new Error("Amount cannot be negative");
  }

  const { data: created, error } = await (supabase as any)
    .from("enrollments")
    .insert({
      user_id: args.user_id,
      module_id: args.module_id,
      amount_quoted_paisa: args.amount_paid_paisa,
      payment_reference: args.payment_reference?.trim() || null,
      admin_notes: args.admin_notes?.trim() || null,
      status: "approved",
      reviewed_by: user.id,
      reviewed_at: new Date().toISOString(),
    })
    .select("id")
    .single();

  if (error) {
    if (error.code === "23505") {
      throw new Error(
        "This user is already enrolled in this course (or has a pending enrollment)."
      );
    }
    console.error("[admin/enrollments] Create failed:", error);
    throw new Error("Could not create enrollment.");
  }

  revalidatePath("/admin/enrollments");
  redirect(`/admin/enrollments/${created.id}`);
}

/**
 * Revoke an existing enrollment. The user loses access immediately.
 * Use case: refund issued, admin error, user disputed charge.
 */
export async function revokeEnrollment(
  enrollmentId: string,
  reason: string
) {
  if (!reason.trim()) throw new Error("A revocation reason is required");

  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) throw new Error("Not authenticated");

  const { error } = await (supabase as any)
    .from("enrollments")
    .update({
      status: "revoked",
      rejection_reason: reason.trim(),
      reviewed_by: user.id,
      reviewed_at: new Date().toISOString(),
    })
    .eq("id", enrollmentId);

  if (error) {
    console.error("[admin/enrollments] Revoke failed:", error);
    throw new Error("Could not revoke enrollment.");
  }

  revalidatePath("/admin/enrollments");
  revalidatePath(`/admin/enrollments/${enrollmentId}`);
}
