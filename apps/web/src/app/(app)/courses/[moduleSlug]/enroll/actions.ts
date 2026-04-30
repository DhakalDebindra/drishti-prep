"use server";

import { createClient } from "@/lib/supabase/server";
import { revalidatePath } from "next/cache";

export async function uploadDisabilityCard(formData: FormData) {
  const file = formData.get("file") as File;
  if (!file) {
    return { error: "No file provided" };
  }

  const supabase = await createClient();
  const { data: { user }, error: authError } = await supabase.auth.getUser();
  
  if (authError || !user) {
    return { error: "Not authenticated" };
  }

  const ext = file.name.split('.').pop();
  const filePath = `${user.id}/${crypto.randomUUID()}.${ext}`;

  const { error: uploadError } = await (supabase as any).storage
    .from("disability-cards")
    .upload(filePath, file);

  if (uploadError) {
    console.error("Upload error:", uploadError);
    return { error: "Failed to upload file" };
  }

  const { error: updateError } = await (supabase as any)
    .from("profiles")
    .update({
      disability_card_path: filePath,
      disability_card_uploaded_at: new Date().toISOString(),
    })
    .eq("id", user.id);

  if (updateError) {
    console.error("Profile update error:", updateError);
    return { error: "Failed to save card path" };
  }

  revalidatePath("/courses/[moduleSlug]/enroll", "page");
  return { success: true };
}

export async function submitEnrollment(moduleId: string, amountQuotedPaisa: number, paymentReference?: string) {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  
  if (!user) {
    return { error: "Not authenticated" };
  }

  const { data: profile } = await (supabase as any)
    .from("profiles")
    .select("disability_card_path")
    .eq("id", user.id)
    .single();

  if (!profile?.disability_card_path) {
    return { error: "Disability card upload is required" };
  }

  const { error } = await (supabase as any)
    .from("enrollments")
    .insert({
      user_id: user.id,
      module_id: moduleId,
      amount_quoted_paisa: amountQuotedPaisa,
      payment_reference: paymentReference || null,
      status: "pending"
    });

  if (error) {
    if (error.code === '23505') { // unique violation
      return { error: "You already have a pending submission." };
    }
    console.error("Enrollment error:", error);
    return { error: "Failed to submit enrollment" };
  }

  revalidatePath("/courses/[moduleSlug]/enroll", "page");
  return { success: true };
}
