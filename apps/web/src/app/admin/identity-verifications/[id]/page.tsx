import Link from "next/link";
import { notFound } from "next/navigation";
import { ChevronLeft } from "lucide-react";
import { createClient } from "@/lib/supabase/server";
import ReviewClient from "./ReviewClient";

interface PageProps {
  params: Promise<{ id: string }>;
}

export default async function IdentityVerificationReviewPage({
  params,
}: PageProps) {
  const { id } = await params;
  const supabase = await createClient();

  const { data: verification } = await (supabase as any)
    .from("identity_verifications")
    .select(
      `
      id,
      status,
      card_path,
      rejection_reason,
      created_at,
      reviewed_at,
      profiles!user_id ( id, full_name, email )
    `
    )
    .eq("id", id)
    .single();

  if (!verification) notFound();

  let cardUrl: string | null = null;
  let cardIsPdf = false;
  if (verification.card_path) {
    const path: string = verification.card_path;
    cardIsPdf = path.toLowerCase().endsWith(".pdf");
    const { data } = await (supabase as any).storage
      .from("disability-cards")
      .createSignedUrl(path, 60 * 5);
    cardUrl = data?.signedUrl ?? null;
  }

  // Recent prior submissions from this user, for context.
  const { data: history } = await (supabase as any)
    .from("identity_verifications")
    .select("id, status, created_at, rejection_reason")
    .eq("user_id", verification.profiles?.id)
    .order("created_at", { ascending: false })
    .limit(5);

  return (
    <div className="space-y-6 max-w-4xl">
      <div className="flex items-center gap-3">
        <Link
          href="/admin/identity-verifications"
          className="text-gray-500 hover:text-gray-900"
          aria-label="Back to identity verifications"
        >
          <ChevronLeft className="w-5 h-5" />
        </Link>
        <h1 className="text-2xl font-bold text-gray-900">Review submission</h1>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        <div className="space-y-6">
          <div className="bg-white rounded-lg shadow p-6">
            <h2 className="text-lg font-semibold mb-4 border-b pb-2">User</h2>
            <dl className="space-y-3 text-sm">
              <Row label="Name" value={verification.profiles?.full_name || "—"} />
              <Row
                label="Email"
                value={verification.profiles?.email || "—"}
                mono
              />
              <Row label="Status" value={verification.status} capitalize />
              <Row
                label="Submitted"
                value={
                  verification.created_at
                    ? new Date(verification.created_at).toLocaleString()
                    : "—"
                }
              />
              {verification.reviewed_at && (
                <Row
                  label="Reviewed"
                  value={new Date(verification.reviewed_at).toLocaleString()}
                />
              )}
              {verification.rejection_reason && (
                <Row
                  label="Reason"
                  value={verification.rejection_reason}
                />
              )}
            </dl>
          </div>

          {verification.status === "pending" && (
            <ReviewClient verificationId={verification.id} />
          )}

          {history && history.length > 1 && (
            <div className="bg-white rounded-lg shadow p-6">
              <h2 className="text-base font-semibold mb-3 border-b pb-2">
                Submission history
              </h2>
              <ul className="space-y-2 text-sm">
                {history.map((row: any) => (
                  <li
                    key={row.id}
                    className={`flex items-center justify-between gap-2 ${
                      row.id === verification.id ? "font-semibold" : ""
                    }`}
                  >
                    <span className="capitalize">{row.status}</span>
                    <span className="text-gray-500">
                      {new Date(row.created_at).toLocaleDateString()}
                    </span>
                  </li>
                ))}
              </ul>
            </div>
          )}
        </div>

        <div className="space-y-6">
          <div className="bg-white rounded-lg shadow p-6">
            <h2 className="text-lg font-semibold mb-4 border-b pb-2">
              Disability card
            </h2>
            {cardUrl ? (
              <div>
                <a
                  href={cardUrl}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="text-blue-600 hover:underline text-sm mb-2 inline-block"
                >
                  Open in new tab
                </a>
                <div className="border rounded bg-gray-50 p-2">
                  {cardIsPdf ? (
                    <embed
                      src={cardUrl}
                      type="application/pdf"
                      className="w-full h-[60vh]"
                    />
                  ) : (
                    /* eslint-disable-next-line @next/next/no-img-element */
                    <img
                      src={cardUrl}
                      alt="Submitted disability card"
                      className="max-w-full h-auto"
                    />
                  )}
                </div>
                <p className="mt-2 text-xs text-gray-500">
                  Signed URL expires in 5 minutes; reload to refresh.
                </p>
              </div>
            ) : (
              <p className="text-sm text-gray-500">
                No card attached or access denied.
              </p>
            )}
          </div>
        </div>
      </div>
    </div>
  );
}

function Row({
  label,
  value,
  mono,
  capitalize,
}: {
  label: string;
  value: React.ReactNode;
  mono?: boolean;
  capitalize?: boolean;
}) {
  return (
    <div className="grid grid-cols-3 gap-2">
      <dt className="text-gray-500">{label}</dt>
      <dd
        className={`col-span-2 ${mono ? "font-mono" : ""} ${
          capitalize ? "capitalize" : ""
        }`}
      >
        {value}
      </dd>
    </div>
  );
}
