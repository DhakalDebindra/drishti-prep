import { notFound } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import ReviewClient from "./ReviewClient";
import Link from "next/link";
import { ChevronLeft } from "lucide-react";

interface ReviewPageProps {
  params: Promise<{ id: string }>;
}

export default async function EnrollmentReviewPage({ params }: ReviewPageProps) {
  const { id } = await params;
  const supabase = await createClient();

  const { data: enrollment, error } = await (supabase as any)
    .from("enrollments")
    .select(`
      id,
      short_code,
      status,
      amount_quoted_paisa,
      payment_reference,
      rejection_reason,
      created_at,
      user_id,
      profiles!user_id ( full_name, disability_card_path ),
      modules ( name, price_paisa )
    `)
    .eq("id", id)
    .single();

  if (error || !enrollment) {
    notFound();
  }

  let cardUrl: string | null = null;
  let cardIsPdf = false;
  if (enrollment.profiles?.disability_card_path) {
    const path: string = enrollment.profiles.disability_card_path;
    cardIsPdf = path.toLowerCase().endsWith(".pdf");
    const { data } = await (supabase as any).storage
      .from("disability-cards")
      .createSignedUrl(path, 60 * 5); // 5 mins
    cardUrl = data?.signedUrl ?? null;
  }

  return (
    <div className="space-y-6 max-w-4xl">
      <div className="flex items-center gap-4">
        <Link href="/admin/enrollments" className="text-gray-500 hover:text-gray-900">
          <ChevronLeft className="w-5 h-5" />
        </Link>
        <h1 className="text-2xl font-bold text-gray-900">Review Enrollment</h1>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        <div className="space-y-6">
          <div className="bg-white rounded-lg shadow p-6">
            <h2 className="text-lg font-semibold mb-4 border-b pb-2">Details</h2>
            <dl className="space-y-3 text-sm">
              <div className="grid grid-cols-3 gap-2">
                <dt className="text-gray-500">Short Code</dt>
                <dd className="col-span-2 font-mono font-bold text-blue-900 text-lg">{enrollment.short_code}</dd>
              </div>
              <div className="grid grid-cols-3 gap-2">
                <dt className="text-gray-500">Status</dt>
                <dd className="col-span-2 capitalize font-medium">{enrollment.status}</dd>
              </div>
              <div className="grid grid-cols-3 gap-2">
                <dt className="text-gray-500">User</dt>
                <dd className="col-span-2">{enrollment.profiles?.full_name}</dd>
              </div>
              <div className="grid grid-cols-3 gap-2">
                <dt className="text-gray-500">Module</dt>
                <dd className="col-span-2">{enrollment.modules?.name}</dd>
              </div>
              <div className="grid grid-cols-3 gap-2">
                <dt className="text-gray-500">Amount</dt>
                <dd className="col-span-2">NPR {enrollment.amount_quoted_paisa / 100}</dd>
              </div>
              <div className="grid grid-cols-3 gap-2">
                <dt className="text-gray-500">Reference</dt>
                <dd className="col-span-2">{enrollment.payment_reference || "N/A"}</dd>
              </div>
              <div className="grid grid-cols-3 gap-2">
                <dt className="text-gray-500">Date</dt>
                <dd className="col-span-2">{new Intl.DateTimeFormat("en-US", { dateStyle: "medium", timeStyle: "short" }).format(new Date(enrollment.created_at))}</dd>
              </div>
            </dl>
          </div>

          {enrollment.status === "pending" && (
            <ReviewClient enrollmentId={enrollment.id} />
          )}
        </div>

        <div className="space-y-6">
          <div className="bg-white rounded-lg shadow p-6">
            <h2 className="text-lg font-semibold mb-4 border-b pb-2">Disability Card</h2>
            {cardUrl ? (
              <div className="mt-2">
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
                    <img src={cardUrl} alt="Disability Card" className="max-w-full h-auto" />
                  )}
                </div>
                <p className="mt-2 text-xs text-gray-500">
                  Signed URL expires in 5 minutes; reload the page to refresh.
                </p>
              </div>
            ) : (
              <p className="text-sm text-gray-500">No card uploaded or access denied.</p>
            )}
          </div>
        </div>
      </div>
    </div>
  );
}
