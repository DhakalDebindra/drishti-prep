"use client";

import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Textarea } from "@/components/ui/textarea";
import { revokeEnrollment } from "../actions";

export default function RevokeClient({
  enrollmentId,
}: {
  enrollmentId: string;
}) {
  const [reason, setReason] = useState("");
  const [isRevoking, setIsRevoking] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [success, setSuccess] = useState(false);

  const handleRevoke = async () => {
    if (!reason.trim()) {
      setError("Please provide a reason — it's stored for audit.");
      return;
    }
    if (!confirm("Revoke this user's access to the course? This is reversible by creating a new enrollment.")) {
      return;
    }
    setError(null);
    setIsRevoking(true);
    try {
      await revokeEnrollment(enrollmentId, reason);
      setSuccess(true);
    } catch (e: any) {
      setError(e?.message || "Could not revoke.");
      setIsRevoking(false);
    }
  };

  if (success) {
    return (
      <div role="status" className="bg-amber-50 text-amber-900 p-3 rounded-md text-sm">
        Enrollment revoked. Reload the page to refresh status.
      </div>
    );
  }

  return (
    <div className="bg-white rounded-lg shadow p-6 space-y-4">
      <h2 className="text-base font-semibold border-b pb-2">Revoke access</h2>

      {error && (
        <div role="alert" className="bg-red-50 text-red-900 p-3 rounded-md text-sm">
          {error}
        </div>
      )}

      <p className="text-sm text-gray-600">
        Revoking removes the user's access immediately. The enrollment row is
        kept for audit. To restore, create a new enrollment from the list.
      </p>

      <div>
        <label
          htmlFor="revoke-reason"
          className="block text-sm font-medium text-gray-700 mb-1"
        >
          Reason (required, internal)
        </label>
        <Textarea
          id="revoke-reason"
          value={reason}
          onChange={(e) => setReason(e.target.value)}
          placeholder="e.g. Refund issued; payment disputed; admin error"
        />
      </div>

      <Button
        variant="destructive"
        onClick={handleRevoke}
        disabled={isRevoking}
      >
        {isRevoking ? "Revoking..." : "Revoke enrollment"}
      </Button>
    </div>
  );
}
