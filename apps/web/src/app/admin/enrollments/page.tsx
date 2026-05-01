import Link from "next/link";
import { createClient } from "@/lib/supabase/server";
import { buttonVariants } from "@/components/ui/button";

export const dynamic = "force-dynamic";

type Status = "approved" | "pending" | "rejected" | "revoked";

export default async function EnrollmentsAdminPage({
  searchParams,
}: {
  searchParams: Promise<{ status?: string; q?: string }>;
}) {
  const { status, q } = await searchParams;
  const currentStatus: Status =
    status === "pending" || status === "rejected" || status === "revoked"
      ? status
      : "approved";

  const supabase = await createClient();

  let query = (supabase as any)
    .from("enrollments")
    .select(
      `
      id,
      status,
      amount_quoted_paisa,
      payment_reference,
      created_at,
      profiles!user_id ( full_name, email ),
      modules ( name )
    `
    )
    .eq("status", currentStatus)
    .order("created_at", { ascending: false })
    .limit(100);

  // Search filter — by user email or full_name (joined).
  if (q && q.trim().length >= 2) {
    const pattern = `%${q.trim().replace(/[%_]/g, "\\$&")}%`;
    query = query.or(
      `email.ilike.${pattern},full_name.ilike.${pattern}`,
      { foreignTable: "profiles" }
    );
  }

  const { data: enrollments, error } = await query;

  if (error) {
    console.error("[admin/enrollments] Fetch error:", error);
  }

  const tabs: { id: Status; label: string }[] = [
    { id: "approved", label: "Approved" },
    { id: "pending", label: "Pending" },
    { id: "rejected", label: "Rejected" },
    { id: "revoked", label: "Revoked" },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-start justify-between gap-4 flex-wrap">
        <div>
          <h1 className="text-2xl font-bold text-gray-900">Enrollments</h1>
          <p className="mt-1 text-sm text-gray-600">
            Created manually after receiving payment proof out-of-band.
          </p>
        </div>
        <Link href="/admin/enrollments/new" className={buttonVariants()}>
          + New enrollment
        </Link>
      </div>

      <div className="flex gap-4 border-b">
        {tabs.map((tab) => (
          <Link
            key={tab.id}
            href={
              `/admin/enrollments?status=${tab.id}` +
              (q ? `&q=${encodeURIComponent(q)}` : "")
            }
            className={`pb-2 px-1 text-sm font-medium ${
              currentStatus === tab.id
                ? "border-b-2 border-blue-600 text-blue-600"
                : "text-gray-500 hover:text-gray-700"
            }`}
          >
            {tab.label}
          </Link>
        ))}
      </div>

      <form method="get" className="flex gap-2 max-w-md">
        <input type="hidden" name="status" value={currentStatus} />
        <input
          type="search"
          name="q"
          defaultValue={q || ""}
          placeholder="Search by user email or name"
          className="flex-1 border rounded-md px-3 py-2 text-sm"
        />
        <button
          type="submit"
          className="px-3 py-2 text-sm font-medium text-blue-600 hover:bg-blue-50 rounded-md"
        >
          Search
        </button>
        {q && (
          <Link
            href={`/admin/enrollments?status=${currentStatus}`}
            className="px-3 py-2 text-sm text-gray-500 hover:bg-gray-50 rounded-md"
          >
            Clear
          </Link>
        )}
      </form>

      <div className="bg-white rounded-lg shadow overflow-hidden">
        <table className="min-w-full divide-y divide-gray-200">
          <thead className="bg-gray-50">
            <tr>
              <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                User
              </th>
              <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                Email
              </th>
              <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                Course
              </th>
              <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                Amount
              </th>
              <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                Reference
              </th>
              <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                Date
              </th>
              <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                Action
              </th>
            </tr>
          </thead>
          <tbody className="bg-white divide-y divide-gray-200">
            {(!enrollments || enrollments.length === 0) && (
              <tr>
                <td
                  colSpan={7}
                  className="px-6 py-4 text-center text-sm text-gray-500"
                >
                  {q
                    ? `No ${currentStatus} enrollments match "${q}".`
                    : `No ${currentStatus} enrollments.`}
                </td>
              </tr>
            )}
            {enrollments?.map((row: any) => (
              <tr key={row.id}>
                <td className="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                  {row.profiles?.full_name || "—"}
                </td>
                <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-700 font-mono text-xs">
                  {row.profiles?.email || "—"}
                </td>
                <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                  {row.modules?.name || "—"}
                </td>
                <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-700">
                  NPR {(row.amount_quoted_paisa / 100).toLocaleString()}
                </td>
                <td className="px-6 py-4 whitespace-nowrap text-xs text-gray-600 max-w-[200px] truncate">
                  {row.payment_reference || "—"}
                </td>
                <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                  {new Intl.DateTimeFormat("en-US", {
                    month: "short",
                    day: "numeric",
                    year: "numeric",
                  }).format(new Date(row.created_at))}
                </td>
                <td className="px-6 py-4 whitespace-nowrap text-sm font-medium">
                  <Link
                    href={`/admin/enrollments/${row.id}`}
                    className="text-blue-600 hover:text-blue-900"
                  >
                    View
                  </Link>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}
