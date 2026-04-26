"use server";

import { createClient } from "@/lib/supabase/server";

export async function toggleBookmark(questionId: string) {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();

  if (!user) {
    return { success: false, error: "Not authenticated" };
  }

  // Check if bookmark exists
  const { data: existing, error: fetchError } = await supabase
    .from("bookmarks")
    .select("id")
    .eq("user_id", user.id)
    .eq("question_id", questionId)
    .single();

  if (fetchError && fetchError.code !== "PGRST116") {
    // PGRST116 means no rows found, which is expected if not bookmarked
    return { success: false, error: "Failed to check bookmark status." };
  }

  if (existing) {
    // Remove bookmark
    const { error: deleteError } = await supabase
      .from("bookmarks")
      .delete()
      .eq("id", existing.id);

    if (deleteError) {
      return { success: false, error: "Failed to remove bookmark." };
    }
    return { success: true, action: "removed" };
  } else {
    // Add bookmark
    const { error: insertError } = await supabase
      .from("bookmarks")
      .insert({ user_id: user.id, question_id: questionId });

    if (insertError) {
      return { success: false, error: "Failed to add bookmark." };
    }
    return { success: true, action: "added" };
  }
}

export type ReportIssueState = {
  success: boolean;
  error?: string;
  message?: string;
};

export async function reportIssue(
  prevState: ReportIssueState | null,
  formData: FormData
): Promise<ReportIssueState> {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();

  if (!user) {
    return { success: false, error: "Not authenticated" };
  }

  const questionId = formData.get("questionId") as string;
  const issueType = formData.get("issueType") as string;
  const description = formData.get("description") as string;

  if (!questionId || !issueType) {
    return { success: false, error: "Missing required fields." };
  }

  // Spam prevention: Check if user already reported this question recently or pending
  const { data: existingReports, error: checkError } = await supabase
    .from("reports")
    .select("status, created_at")
    .eq("user_id", user.id)
    .eq("question_id", questionId)
    .order("created_at", { ascending: false })
    .limit(1);

  if (checkError) {
    return { success: false, error: "Failed to submit report. Try again." };
  }

  if (existingReports && existingReports.length > 0) {
    const lastReport = existingReports[0];
    if (lastReport.status === 'pending') {
       return { success: false, error: "You already have a pending report for this question." };
    }
    
    // Check if it was less than 24 hours ago
    const hoursSinceLastReport = (new Date().getTime() - new Date(lastReport.created_at).getTime()) / (1000 * 60 * 60);
    if (hoursSinceLastReport < 24) {
       return { success: false, error: "Please wait before reporting the same question again." };
    }
  }

  const { error: insertError } = await supabase
    .from("reports")
    .insert({
      user_id: user.id,
      question_id: questionId,
      issue_type: issueType,
      description: description || null,
    });

  if (insertError) {
    return { success: false, error: "Failed to submit report." };
  }

  return { success: true, message: "Report submitted successfully." };
}
