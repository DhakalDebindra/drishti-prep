"use server";

import { createClient } from "@/lib/supabase/server";
import { revalidatePath } from "next/cache";

const MAX_BYTES = 5 * 1024 * 1024;
const ALLOWED_MIME = new Set([
  "image/jpeg",
  "image/png",
  "image/webp",
  "image/heic",
  "application/pdf",
]);

/**
 * Submit (or re-submit) a disability card for review.
 *
 * Inserts a row in identity_verifications with status='pending'. The DB
 * trigger sync_disability_status() updates profiles.disability_status to
 * 'pending' and records the new card_path.
 *
 * Re-submission after rejection: the partial unique index allows a new
 * pending row only when no other pending row exists for this user. After
 * a rejection the user has no pending row, so this insert succeeds.
 */
export async function submitIdentityVerification(formData: FormData) {
  const file = formData.get("file");
  if (!(file instanceof File) || file.size === 0) {
    return { error: "No file provided." };
  }
  if (file.size > MAX_BYTES) {
    return { error: "File is too large. Maximum size is 5 MB." };
  }
  if (!ALLOWED_MIME.has(file.type)) {
    return {
      error: "Unsupported format. Please upload JPG, PNG, WEBP, HEIC, or PDF.",
    };
  }

  const supabase = await createClient();
  const {
    data: { user },
    error: authError,
  } = await supabase.auth.getUser();
  if (authError || !user) {
    return { error: "Not authenticated." };
  }

  const ext = (file.name.split(".").pop() || "bin").toLowerCase();
  const cardPath = `${user.id}/${crypto.randomUUID()}.${ext}`;

  const { error: uploadError } = await (supabase as any).storage
    .from("disability-cards")
    .upload(cardPath, file, { upsert: false });

  if (uploadError) {
    console.error("[verify-identity] Upload failed:", uploadError);
    return { error: "Could not upload the file. Please try again." };
  }

  const { error: insertError } = await (supabase as any)
    .from("identity_verifications")
    .insert({
      user_id: user.id,
      card_path: cardPath,
      status: "pending",
    });

  if (insertError) {
    // 23505 = unique violation: a pending row already exists.
    if (insertError.code === "23505") {
      return {
        error: "You already have a verification under review. Please wait for it to be reviewed before submitting another.",
      };
    }
    console.error("[verify-identity] Insert failed:", insertError);
    return { error: "Could not submit for review. Please try again." };
  }

  revalidatePath("/profile/verify-identity");
  revalidatePath("/dashboard");
  return { success: true };
}
