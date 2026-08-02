"use client";

import { useState } from "react";
import Link from "next/link";
import { Button } from "@/components/ui/button";
import { buttonVariants } from "@/components/ui/button-variants";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { AlertCircle, CheckCircle2, Clock, Upload, XCircle } from "lucide-react";
import { submitIdentityVerification } from "./actions";

type Status = "not_submitted" | "pending" | "approved" | "rejected";

const MAX_BYTES = 500 * 1024;
const ALLOWED_MIME = [
  "image/jpeg",
  "image/png",
  "image/webp",
  "image/heic",
  "application/pdf",
];

export default function VerifyIdentityClient({
  status,
  rejectionReason,
  latestSubmittedAt,
  latestReviewedAt,
  verifiedAt,
  nextHref,
}: {
  status: Status;
  rejectionReason: string | null;
  latestSubmittedAt: string | null;
  latestReviewedAt: string | null;
  verifiedAt: string | null;
  nextHref: string | null;
}) {
  const [isUploading, setIsUploading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [selectedName, setSelectedName] = useState<string | null>(null);
  const [hasInvalidFile, setHasInvalidFile] = useState(false);

  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    setError(null);
    const formData = new FormData(e.currentTarget);
    const file = formData.get("file");
    if (file instanceof File) {
      const validation = validateFile(file);
      if (validation) {
        setError(validation);
        return;
      }
    }
    setIsUploading(true);
    const res = await submitIdentityVerification(formData);
    if (res?.error) {
      setError(res.error);
      setIsUploading(false);
    }
    // On success the server revalidates the page and the status banner re-renders.
  };

  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const f = e.target.files?.[0] ?? null;
    setSelectedName(f ? `${f.name} (${formatBytes(f.size)})` : null);
    if (!f) {
      setError(null);
      setHasInvalidFile(false);
      return;
    }
    const validation = validateFile(f);
    setError(validation);
    setHasInvalidFile(validation !== null);
  };

  if (status === "approved") {
    return (
      <div className="space-y-6">
        <div
          role="status"
          className="bg-green-50 border border-green-200 text-green-900 p-4 rounded-lg flex items-start gap-3"
        >
          <CheckCircle2 className="w-5 h-5 mt-0.5 flex-shrink-0" />
          <div>
            <h2 className="font-semibold">Identity verified</h2>
            <p className="mt-1 text-sm">
              Your identity was approved
              {verifiedAt ? ` on ${formatDate(verifiedAt)}` : ""}. You can now
              request enrollment in any paid course.
            </p>
          </div>
        </div>

        <div className="bg-white border rounded-lg p-6">
          <h2 className="text-base font-semibold text-gray-900">Next step</h2>
          <p className="mt-1 text-sm text-gray-600">
            Payment details have been emailed to your registered address. Browse
            courses and follow the instructions in that email to enroll.
          </p>
          <div className="mt-4 flex gap-2">
            <Link href={nextHref || "/courses"} className={buttonVariants()}>
              {nextHref ? "Continue" : "Browse courses"}
            </Link>
          </div>
        </div>
      </div>
    );
  }

  if (status === "pending") {
    return (
      <div
        role="status"
        className="bg-blue-50 border border-blue-200 text-blue-900 p-4 rounded-lg space-y-2"
      >
        <div className="flex items-start gap-3">
          <Clock className="w-5 h-5 mt-0.5 flex-shrink-0" />
          <div>
            <h2 className="font-semibold">Awaiting review</h2>
            <p className="mt-1 text-sm">
              Your disability card was submitted
              {latestSubmittedAt ? ` on ${formatDate(latestSubmittedAt)}` : ""}.
              We will review it and email you when there is an update, usually
              within 24 hours.
            </p>
          </div>
        </div>
      </div>
    );
  }

  // rejected OR not_submitted both render the upload form.
  return (
    <div className="space-y-6">
      {status === "rejected" && (
        <div
          role="status"
          className="bg-red-50 border border-red-200 text-red-900 p-4 rounded-lg flex items-start gap-3"
        >
          <XCircle className="w-5 h-5 mt-0.5 flex-shrink-0" />
          <div>
            <h2 className="font-semibold">Previous submission was not approved</h2>
            <p className="mt-1 text-sm">
              <span className="font-medium">Reason:</span>{" "}
              {rejectionReason || "No reason was given. Contact us if you need details."}
            </p>
            {latestReviewedAt && (
              <p className="mt-1 text-xs opacity-80">
                Reviewed on {formatDate(latestReviewedAt)}
              </p>
            )}
            <p className="mt-2 text-sm">You can submit a new image below.</p>
          </div>
        </div>
      )}

      <div className="bg-white border rounded-lg p-6">
        <h2 className="text-base font-semibold text-gray-900">
          Upload your disability card
        </h2>
        <p className="mt-1 text-sm text-gray-600">
          Upload a clear photograph or scan of your disability card. Make sure
          the name and ID are readable.
        </p>

        {error && (
          <div
            role="alert"
            className="mt-4 bg-red-50 text-red-900 p-3 rounded-md flex items-center gap-2 text-sm"
          >
            <AlertCircle className="w-4 h-4 flex-shrink-0" />
            {error}
          </div>
        )}

        <form onSubmit={handleSubmit} className="mt-4 space-y-4">
          <div>
            <Label htmlFor="card-upload">Disability card (image or PDF)</Label>
            <Input
              id="card-upload"
              name="file"
              type="file"
              accept="image/jpeg,image/png,image/webp,image/heic,application/pdf"
              required
              aria-describedby="upload-hint upload-selected"
              className="mt-1"
              onChange={handleFileChange}
            />
            <p id="upload-hint" className="text-sm text-gray-500 mt-1">
              Maximum 500 KB. Supported formats: JPG, PNG, WEBP, HEIC, PDF. If
              your file is larger, please compress or take a lower-resolution
              photo before uploading.
            </p>
            <p
              id="upload-selected"
              aria-live="polite"
              className="text-sm text-gray-700 mt-1 min-h-[1.25rem]"
            >
              {selectedName ? `Selected: ${selectedName}` : ""}
            </p>
          </div>

          <Button type="submit" disabled={isUploading || hasInvalidFile}>
            {isUploading ? (
              "Uploading..."
            ) : (
              <>
                Submit for review <Upload className="w-4 h-4 ml-2" />
              </>
            )}
          </Button>
        </form>
      </div>
    </div>
  );
}

function validateFile(file: File): string | null {
  if (file.size === 0) return "The selected file is empty.";
  if (file.size > MAX_BYTES) {
    return `File is too large (${formatBytes(file.size)}). Maximum size is 500 KB. Please compress the image or take a lower-resolution photo.`;
  }
  if (!ALLOWED_MIME.includes(file.type)) {
    return "Unsupported format. Please upload JPG, PNG, WEBP, HEIC, or PDF.";
  }
  return null;
}

function formatBytes(bytes: number): string {
  if (bytes < 1024) return `${bytes} B`;
  if (bytes < 1024 * 1024) return `${(bytes / 1024).toFixed(0)} KB`;
  return `${(bytes / (1024 * 1024)).toFixed(1)} MB`;
}

function formatDate(iso: string): string {
  try {
    return new Date(iso).toLocaleDateString(undefined, {
      year: "numeric",
      month: "short",
      day: "numeric",
    });
  } catch {
    return iso;
  }
}
