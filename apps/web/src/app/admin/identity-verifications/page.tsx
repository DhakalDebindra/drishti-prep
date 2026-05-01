import Link from "next/link";
import { createClient } from "@/lib/supabase/server";

type Status = "pending" | "approved" | "rejected";

export default async function IdentityVerificationsAdminPage({
  searchParams,
}: {
  searchParams: Promise<{ status?: string }>;
}) {
  const { status } = await searchParams;
  const currentStatus: Status =
    status === "approved" || status === "rejected" ? status : "pending";

  const supabase = await createClient();

  const { data: rows, error } = await (supabase as any)
    .from("identity_verifications")
    .select(
      `
      id,
      status,
      created_at,
      reviewed_at,
      profiles!user_id ( full_name, email )
    `
    )
    .eq("status", currentStatus)
    .order("created_at", { ascending: false });

  if (error) {
    console.error("[admin/identity-verifications] Fetch error:", error);
  }

  const tabs: { id: Status; label: string }[] = [
    { id: "pending", label: "Pending" },
    { id: "approved", label: "Approved" },
    { id: "rejected", label: "Rejected" },
  ];

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold text-gray-900">Identity verifications</h1>
        <p className="mt-1 text-sm text-gray-600">
          One-time disability card review per user. Approving sends an email with
          payment instructions; rejecting sends an email with the reason.
        </p>
      </div>

      <div className="flex gap-4 border-b">
        {tabs.map((tab) => (
          <Link
            key={tab.id}
            href={`/admin/identity-verifications?status=${tab.id}`}
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
                Submitted
              </th>
              <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                {currentStatus === "pending" ? "Action" : "Reviewed"}
              </th>
            </tr>
          </thead>
          <tbody className="bg-white divide-y divide-gray-200">
            {(!rows || rows.length === 0) && (
              <tr>
                <td
                  colSpan={4}
                  className="px-6 py-4 text-center text-sm text-gray-500"
                >
                  No {currentStatus} submissions.
                </td>
              </tr>
            )}
            {rows?.map((row: any) => (
              <tr key={row.id}>
                <td className="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                  {row.profiles?.full_name || "—"}
                </td>
                <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-700 font-mono">
                  {row.profiles?.email || "—"}
                </td>
                <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                  {formatDate(row.created_at)}
                </td>
                <td className="px-6 py-4 whitespace-nowrap text-sm">
                  {currentStatus === "pending" ? (
                    <Link
                      href={`/admin/identity-verifications/${row.id}`}
                      className="text-blue-600 hover:text-blue-900 font-medium"
                    >
                      Review
                    </Link>
                  ) : (
                    <span className="text-gray-500">
                      {row.reviewed_at ? formatDate(row.reviewed_at) : "—"}
                    </span>
                  )}
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}

function formatDate(iso: string): string {
  try {
    return new Intl.DateTimeFormat("en-US", {
      month: "short",
      day: "numeric",
      year: "numeric",
    }).format(new Date(iso));
  } catch {
    return iso;
  }
}
