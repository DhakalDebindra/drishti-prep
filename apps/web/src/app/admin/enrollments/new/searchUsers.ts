"use server";

import { createClient } from "@/lib/supabase/server";

export type UserHit = {
  id: string;
  email: string | null;
  full_name: string | null;
  disability_status: "not_submitted" | "pending" | "approved" | "rejected";
};

/**
 * Search profiles by email (case-insensitive) or full_name.
 * Admin-only; the admin/layout gate already enforces is_admin before any
 * page in this folder renders.
 */
export async function searchUsers(query: string): Promise<UserHit[]> {
  const q = query.trim();
  if (q.length < 2) return [];

  const supabase = await createClient();
  const pattern = `%${q.replace(/[%_]/g, "\\$&")}%`;

  const { data, error } = await (supabase as any)
    .from("profiles")
    .select("id, email, full_name, disability_status")
    .or(`email.ilike.${pattern},full_name.ilike.${pattern}`)
    .limit(20);

  if (error) {
    console.error("[admin/enrollments/new] searchUsers error:", error);
    return [];
  }

  return (data || []) as UserHit[];
}
