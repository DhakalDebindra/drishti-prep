"use server";

import { createClient } from "@/lib/supabase/server";
import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";

export async function approveEnrollment(enrollmentId: string) {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) throw new Error("Not authenticated");

  const { data: enrollment } = await (supabase as any)
    .from("enrollments")
    .select("user_id")
    .eq("id", enrollmentId)
    .single();

  if (!enrollment) throw new Error("Enrollment not found");

  // Flip the profile flag BEFORE granting access. If this fails, we'd rather
  // leave the user un-enrolled than enrolled-but-not-verified.
  const { error: profileError } = await (supabase as any)
    .from("profiles")
    .update({
      disability_verified: true,
      disability_verified_by: user.id,
      disability_verified_at: new Date().toISOString(),
    })
    .eq("id", enrollment.user_id);

  if (profileError) throw new Error("Failed to mark disability verified");

  const { error: enrollError } = await (supabase as any)
    .from("enrollments")
    .update({
      status: "approved",
      reviewed_by: user.id,
      reviewed_at: new Date().toISOString(),
    })
    .eq("id", enrollmentId);

  if (enrollError) throw new Error("Failed to approve enrollment");

  revalidatePath("/admin/enrollments");
  redirect("/admin/enrollments");
}

export async function rejectEnrollment(enrollmentId: string, reason: string) {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) throw new Error("Not authenticated");

  const { error } = await (supabase as any)
    .from("enrollments")
    .update({
      status: "rejected",
      rejection_reason: reason,
      reviewed_by: user.id,
      reviewed_at: new Date().toISOString()
    })
    .eq("id", enrollmentId);

  if (error) throw new Error("Failed to reject enrollment");

  revalidatePath("/admin/enrollments");
  redirect("/admin/enrollments");
}
