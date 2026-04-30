"use client";

import { useState } from "react";
import { uploadDisabilityCard, submitEnrollment } from "./actions";
import { Button, buttonVariants } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { AlertCircle, CheckCircle2, Upload } from "lucide-react";
import type { ModuleEnrollment } from "@/lib/access";
import Image from "next/image";

type EnrollProfile = {
  full_name: string | null;
  has_card: boolean;
  disability_verified: boolean;
};

type Settings = {
  payment_qr_url?: string | null;
  payment_instructions?: string | null;
  whatsapp_number?: string | null;
  whatsapp_message_template?: string | null;
};

type ModuleData = {
  id: string;
  name: string;
  price_paisa: number;
};

export default function EnrollClient({
  moduleData,
  settings,
  profile,
  enrollment,
}: {
  moduleData: ModuleData;
  settings: Settings | null;
  profile: EnrollProfile;
  enrollment: ModuleEnrollment | null;
}) {
  const [isUploading, setIsUploading] = useState(false);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [paymentRef, setPaymentRef] = useState("");
  const [error, setError] = useState("");
  const [uploadJustSucceeded, setUploadJustSucceeded] = useState(false);

  const handleUpload = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    setIsUploading(true);
    setError("");
    const formData = new FormData(e.currentTarget);
    const res = await uploadDisabilityCard(formData);
    if (res?.error) {
      setError(res.error);
    } else {
      setUploadJustSucceeded(true);
    }
    setIsUploading(false);
  };

  const handleEnroll = async () => {
    setIsSubmitting(true);
    setError("");
    const res = await submitEnrollment(moduleData.id, moduleData.price_paisa, paymentRef);
    if (res?.error) setError(res.error);
    setIsSubmitting(false);
  };

  const hasCard = profile.has_card || uploadJustSucceeded;
  const isPending = enrollment?.status === "pending";
  const isRejected = enrollment?.status === "rejected";

  if (isPending) {
    const rawNumber = settings?.whatsapp_number?.replace(/\D/g, "") || "";
    const waUrl = new URL("https://wa.me/" + rawNumber);
    let text =
      settings?.whatsapp_message_template ||
      "Hi, I have paid. Code: {code}";
    text = text.replaceAll("{code}", enrollment.short_code);
    text = text.replaceAll("{name}", profile.full_name || "Student");
    text = text.replaceAll("{module}", moduleData.name);
    text = text.replaceAll("{amount}", (moduleData.price_paisa / 100).toString());
    waUrl.searchParams.set("text", text);

    return (
      <div className="space-y-6">
        <div role="status" className="bg-blue-50 border border-blue-200 text-blue-800 p-4 rounded-lg flex items-start gap-3">
          <CheckCircle2 className="w-5 h-5 mt-0.5 flex-shrink-0" />
          <div>
            <h3 className="font-semibold">Enrollment Pending Review</h3>
            <p className="mt-1">We have received your request. Please send your payment screenshot via WhatsApp.</p>
          </div>
        </div>

        <div className="bg-white border rounded-lg p-6 text-center space-y-4">
          <p className="text-gray-600">Mention this code in WhatsApp:</p>
          <div
            aria-live="polite"
            className="text-4xl font-mono font-bold tracking-widest text-blue-900 bg-blue-50 py-3 px-6 rounded inline-block"
          >
            {enrollment.short_code}
          </div>

          <div className="pt-4">
            <a
              href={waUrl.toString()}
              target="_blank"
              rel="noopener noreferrer"
              className={buttonVariants({ size: "lg" }) + " bg-green-600 text-white hover:bg-green-700 px-6"}
            >
              Open WhatsApp to send screenshot
            </a>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="space-y-8">
      {error && (
        <div role="alert" className="bg-red-50 text-red-900 p-3 rounded-md flex items-center gap-2">
          <AlertCircle className="w-4 h-4" />
          {error}
        </div>
      )}

      {isRejected && (
        <div role="status" className="bg-red-50 border border-red-200 text-red-800 p-4 rounded-lg">
          <h3 className="font-semibold">Previous Request Rejected</h3>
          <p className="mt-1">Reason: {enrollment.rejection_reason}</p>
          <p className="mt-2 text-sm">You can submit a new request below.</p>
        </div>
      )}

      {!hasCard && (
        <div className="bg-white border rounded-lg p-6">
          <h2 className="text-lg font-semibold mb-4">Step 1: Identity Verification</h2>
          <p className="text-gray-600 mb-4">
            DrishtiPrep is built for visually-impaired aspirants. Please upload your disability card as identity proof.
          </p>
          <form onSubmit={handleUpload} className="space-y-4">
            <div>
              <Label htmlFor="card-upload">Disability Card Image/PDF</Label>
              <Input
                id="card-upload"
                name="file"
                type="file"
                accept="image/jpeg,image/png,image/webp,image/heic,application/pdf"
                required
                aria-describedby="upload-hint"
                className="mt-1"
              />
              <p id="upload-hint" className="text-sm text-gray-500 mt-1">
                Max 5 MB. Supported formats: JPG, PNG, WEBP, PDF.
              </p>
            </div>
            <Button type="submit" disabled={isUploading}>
              {isUploading ? "Uploading..." : "Upload Card"}
              {!isUploading && <Upload className="w-4 h-4 ml-2" />}
            </Button>
          </form>
        </div>
      )}

      {hasCard && (
        <div className="bg-white border rounded-lg p-6 space-y-6">
          <div
            role="status"
            aria-live="polite"
            className="flex items-center gap-2 text-green-700 bg-green-50 p-3 rounded border border-green-200"
          >
            <CheckCircle2 className="w-5 h-5" />
            <span>
              {uploadJustSucceeded && !profile.has_card
                ? "Disability card uploaded. Continue to payment below."
                : "Disability card on file."}
            </span>
          </div>

          <div>
            <h2 className="text-lg font-semibold mb-2">Step 2: Payment</h2>
            <div className="bg-gray-50 p-4 rounded-md mb-4">
              <span className="text-gray-500 uppercase text-sm font-semibold tracking-wider">Amount Due</span>
              <div className="text-3xl font-bold text-gray-900 mt-1">NPR {moduleData.price_paisa / 100}</div>
            </div>

            <div className="prose prose-sm max-w-none text-gray-700 mb-6">
              <h3 className="text-base font-semibold text-gray-900">Payment Instructions</h3>
              <p>{settings?.payment_instructions}</p>
            </div>

            {settings?.payment_qr_url && (
              <div className="mb-6">
                <Image
                  src={settings.payment_qr_url}
                  alt="QR code; same instructions are listed in text above"
                  width={200}
                  height={200}
                  className="border rounded-lg"
                />
              </div>
            )}

            <div className="space-y-4 pt-4 border-t">
              <div>
                <Label htmlFor="payment-ref">Transaction Reference / Remark (Optional)</Label>
                <Input
                  id="payment-ref"
                  value={paymentRef}
                  onChange={(e) => setPaymentRef(e.target.value)}
                  placeholder="e.g. eSewa transaction ID"
                  className="mt-1"
                />
              </div>

              <Button size="lg" className="w-full sm:w-auto" onClick={handleEnroll} disabled={isSubmitting}>
                {isSubmitting ? "Processing..." : "I've paid — open WhatsApp"}
              </Button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
