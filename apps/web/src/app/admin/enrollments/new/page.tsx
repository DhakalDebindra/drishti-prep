import Link from "next/link";
import { ChevronLeft } from "lucide-react";
import { createClient } from "@/lib/supabase/server";
import NewEnrollmentClient from "./Client";

export const dynamic = "force-dynamic";

export default async function NewEnrollmentPage() {
  const supabase = await createClient();

  // Active modules with prices, so admin can pick one and pre-fill amount.
  const { data: modules } = await (supabase as any)
    .from("modules")
    .select("id, name, slug, price_paisa, currency")
    .eq("is_active", true)
    .order("display_order", { ascending: true });

  return (
    <div className="space-y-6 max-w-2xl">
      <div className="flex items-center gap-3">
        <Link
          href="/admin/enrollments"
          className="text-gray-500 hover:text-gray-900"
          aria-label="Back to enrollments"
        >
          <ChevronLeft className="w-5 h-5" />
        </Link>
        <h1 className="text-2xl font-bold text-gray-900">New enrollment</h1>
      </div>

      <p className="text-sm text-gray-600">
        Use this form after you've received payment proof from a verified user.
        Search by their registered email — only verified users appear.
      </p>

      <NewEnrollmentClient
        modules={
          (modules || []).map((m: any) => ({
            id: m.id,
            name: m.name,
            slug: m.slug,
            price_paisa: m.price_paisa,
            currency: m.currency || "NPR",
          }))
        }
      />
    </div>
  );
}
