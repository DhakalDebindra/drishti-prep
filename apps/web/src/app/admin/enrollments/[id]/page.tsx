import Link from "next/link";
import { notFound } from "next/navigation";
import { ChevronLeft } from "lucide-react";
import { createClient } from "@/lib/supabase/server";
import RevokeClient from "./RevokeClient";

interface PageProps {
  params: Promise<{ id: string }>;
}

export default async function EnrollmentDetailPage({ params }: PageProps) {
  const { id } = await params;
  const supabase = await createClient();

  const { data: enrollment } = await (supabase as any)
    .from("enrollments")
    .select(
      `
      id,
      status,
      amount_quoted_paisa,
      payment_reference,
      admin_notes,
      rejection_reason,
      created_at,
      reviewed_at,
      profiles!user_id ( id, full_name, email, disability_status ),
      modules ( name, slug )
    `
    )
    .eq("id", id)
    .single();

  if (!enrollment) notFound();

  return (
    <div className="space-y-6 max-w-4xl">
      <div className="flex items-center gap-3">
        <Link
          href="/admin/enrollments"
          className="text-gray-500 hover:text-gray-900"
          aria-label="Back to enrollments"
        >
          <ChevronLeft className="w-5 h-5" />
        </Link>
        <h1 className="text-2xl font-bold text-gray-900">Enrollment</h1>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        <div className="bg-white rounded-lg shadow p-6 space-y-4">
          <h2 className="text-lg font-semibold border-b pb-2">Details</h2>
          <dl className="space-y-3 text-sm">
            <Row label="User" value={enrollment.profiles?.full_name || "—"} />
            <Row
              label="Email"
              value={enrollment.profiles?.email || "—"}
              mono
            />
            <Row
              label="Identity"
              value={
                <span
                  className={
                    enrollment.profiles?.disability_status === "approved"
                      ? "text-green-700"
                      : "text-amber-700"
                  }
                >
                  {enrollment.profiles?.disability_status || "—"}
                </span>
              }
            />
            <Row label="Course" value={enrollment.modules?.name || "—"} />
            <Row
              label="Status"
              value={
                <span
                  className={`capitalize font-medium ${
                    enrollment.status === "approved"
                      ? "text-green-700"
                      : enrollment.status === "revoked"
                        ? "text-amber-700"
                        : "text-gray-700"
                  }`}
                >
                  {enrollment.status}
                </span>
              }
            />
            <Row
              label="Amount"
              value={`NPR ${(enrollment.amount_quoted_paisa / 100).toLocaleString()}`}
            />
            <Row
              label="Reference"
              value={enrollment.payment_reference || "—"}
            />
            {enrollment.admin_notes && (
              <Row label="Notes" value={enrollment.admin_notes} />
            )}
            {enrollment.rejection_reason && (
              <Row
                label="Revoke reason"
                value={enrollment.rejection_reason}
              />
            )}
            <Row
              label="Created"
              value={new Date(enrollment.created_at).toLocaleString()}
            />
            {enrollment.reviewed_at && (
              <Row
                label="Reviewed"
                value={new Date(enrollment.reviewed_at).toLocaleString()}
              />
            )}
          </dl>

          {enrollment.profiles?.id && (
            <div className="pt-3 border-t text-xs text-gray-500">
              <Link
                href={`/admin/identity-verifications?status=approved`}
                className="text-blue-600 hover:underline"
              >
                View this user's identity history →
              </Link>
            </div>
          )}
        </div>

        {enrollment.status === "approved" && (
          <RevokeClient enrollmentId={enrollment.id} />
        )}
      </div>
    </div>
  );
}

function Row({
  label,
  value,
  mono,
}: {
  label: string;
  value: React.ReactNode;
  mono?: boolean;
}) {
  return (
    <div className="grid grid-cols-3 gap-2">
      <dt className="text-gray-500">{label}</dt>
      <dd className={`col-span-2 ${mono ? "font-mono text-xs" : ""}`}>
        {value}
      </dd>
    </div>
  );
}
