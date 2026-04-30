import { createClient } from "@/lib/supabase/server";

export type EnrollmentStatus = "pending" | "approved" | "rejected" | "revoked";

export type ModuleEnrollment = {
  id: string;
  short_code: string;
  status: EnrollmentStatus;
  amount_quoted_paisa: number;
  payment_reference: string | null;
  rejection_reason: string | null;
  created_at: string;
};

export type ModuleAccess = {
  hasAccess: boolean;
  enrollment: ModuleEnrollment | null;
};

export async function getModuleAccess(moduleId: string): Promise<ModuleAccess> {
  const supabase = await createClient();

  const { data: rpcData } = await (supabase as any).rpc("has_module_access", {
    p_module: moduleId,
  });

  const { data: enrollment } = await (supabase as any)
    .from("enrollments")
    .select(
      "id, short_code, status, amount_quoted_paisa, payment_reference, rejection_reason, created_at"
    )
    .eq("module_id", moduleId)
    .order("created_at", { ascending: false })
    .limit(1)
    .maybeSingle();

  return {
    hasAccess: rpcData === true,
    enrollment: (enrollment as ModuleEnrollment | null) ?? null,
  };
}
