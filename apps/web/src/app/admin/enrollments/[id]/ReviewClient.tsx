"use client";

import { useState } from "react";
import { approveEnrollment, rejectEnrollment } from "../actions";
import { Button } from "@/components/ui/button";
import { Textarea } from "@/components/ui/textarea";

export default function ReviewClient({ enrollmentId }: { enrollmentId: string }) {
  const [isApproving, setIsApproving] = useState(false);
  const [isRejecting, setIsRejecting] = useState(false);
  const [reason, setReason] = useState("");
  const [error, setError] = useState<string | null>(null);

  const handleApprove = async () => {
    setError(null);
    setIsApproving(true);
    try {
      await approveEnrollment(enrollmentId);
    } catch (e) {
      console.error(e);
      setError("Could not approve. Please try again.");
      setIsApproving(false);
    }
  };

  const handleReject = async () => {
    if (!reason.trim()) {
      setError("Please provide a rejection reason before rejecting.");
      return;
    }
    setError(null);
    setIsRejecting(true);
    try {
      await rejectEnrollment(enrollmentId, reason);
    } catch (e) {
      console.error(e);
      setError("Could not reject. Please try again.");
      setIsRejecting(false);
    }
  };

  return (
    <div className="bg-white rounded-lg shadow p-6 space-y-4">
      <h2 className="text-lg font-semibold border-b pb-2">Decision</h2>

      {error && (
        <div role="alert" className="bg-red-50 text-red-900 p-3 rounded-md text-sm">
          {error}
        </div>
      )}

      <div className="space-y-4">
        <Button
          className="w-full bg-green-600 hover:bg-green-700 text-white"
          onClick={handleApprove}
          disabled={isApproving || isRejecting}
        >
          {isApproving ? "Approving..." : "Approve Enrollment"}
        </Button>

        <div className="pt-4 border-t">
          <label htmlFor="reject-reason" className="block text-sm font-medium text-gray-700 mb-1">
            Rejection reason
          </label>
          <Textarea
            id="reject-reason"
            placeholder="Required when rejecting. Shown to the user verbatim."
            value={reason}
            onChange={(e) => setReason(e.target.value)}
            className="mb-2"
          />
          <Button
            variant="destructive"
            className="w-full"
            onClick={handleReject}
            disabled={isApproving || isRejecting}
          >
            {isRejecting ? "Rejecting..." : "Reject Enrollment"}
          </Button>
        </div>
      </div>
    </div>
  );
}
