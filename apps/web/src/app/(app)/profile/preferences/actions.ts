"use server";

import { createClient } from "@/lib/supabase/server";
import { revalidatePath } from "next/cache";

export async function setTutorVoiceEnabled(enabled: boolean) {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) return { error: "Not authenticated." };

  const { error } = await (supabase as any)
    .from("profiles")
    .update({ tutor_voice_enabled: enabled })
    .eq("id", user.id);

  if (error) {
    console.error("[preferences] setTutorVoiceEnabled failed:", error);
    return { error: "Could not save your preference." };
  }

  revalidatePath("/profile/preferences");
  return { success: true };
}
