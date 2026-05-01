import Link from "next/link";
import { CheckCircle2, Clock, ShieldCheck, XCircle } from "lucide-react";
import { buttonVariants } from "@/components/ui/button";

type Status = "not_submitted" | "pending" | "approved" | "rejected";

/**
 * Banner shown on the dashboard reflecting the user's identity-verification
 * status. Hidden when approved (no banner clutter for the happy path).
 *
 * Visually-impaired-friendly: each state has a role/aria-live pair so a
 * screen reader announces it on page load.
 */
export function IdentityStatusBanner({
  status,
  rejectionReason,
}: {
  status: Status;
  rejectionReason?: string | null;
}) {
  if (status === "approved") return null;

  if (status === "pending") {
    return (
      <div
        role="status"
        className="bg-blue-50 dark:bg-blue-950 border border-blue-200 dark:border-blue-900 text-blue-900 dark:text-blue-100 p-4 rounded-lg flex items-start gap-3"
      >
        <Clock className="w-5 h-5 mt-0.5 flex-shrink-0" />
        <div className="flex-1">
          <p className="font-semibold">Identity verification pending</p>
          <p className="mt-1 text-sm">
            We're reviewing your disability card. You'll receive an email when
            it's approved (usually within 24 hours).
          </p>
        </div>
      </div>
    );
  }

  if (status === "rejected") {
    return (
      <div
        role="status"
        className="bg-red-50 dark:bg-red-950 border border-red-200 dark:border-red-900 text-red-900 dark:text-red-100 p-4 rounded-lg flex items-start gap-3"
      >
        <XCircle className="w-5 h-5 mt-0.5 flex-shrink-0" />
        <div className="flex-1">
          <p className="font-semibold">Identity verification needs another look</p>
          {rejectionReason && (
            <p className="mt-1 text-sm">
              <span className="font-medium">Reason:</span> {rejectionReason}
            </p>
          )}
          <Link
            href="/profile/verify-identity"
            className={buttonVariants({ size: "sm" }) + " mt-3"}
          >
            Re-submit identity
          </Link>
        </div>
      </div>
    );
  }

  // not_submitted
  return (
    <div
      role="status"
      className="bg-amber-50 dark:bg-amber-950 border border-amber-200 dark:border-amber-900 text-amber-900 dark:text-amber-100 p-4 rounded-lg flex items-start gap-3"
    >
      <ShieldCheck className="w-5 h-5 mt-0.5 flex-shrink-0" />
      <div className="flex-1">
        <p className="font-semibold">Verify your identity to unlock paid courses</p>
        <p className="mt-1 text-sm">
          DrishtiPrep is built for visually-impaired aspirants. Submit your
          disability card once and you'll receive payment instructions for any
          paid course you'd like to enroll in.
        </p>
        <Link
          href="/profile/verify-identity"
          className={buttonVariants({ size: "sm" }) + " mt-3"}
        >
          Verify my identity
        </Link>
      </div>
    </div>
  );
}
