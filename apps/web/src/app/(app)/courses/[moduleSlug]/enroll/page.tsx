import { notFound, redirect } from "next/navigation";
import Link from "next/link";
import { createClient } from "@/lib/supabase/server";
import { getModuleAccess } from "@/lib/access";
import { Lang } from "@/components/ui/Lang";
import { buttonVariants } from "@/components/ui/button-variants";
import { Mail, MessageCircle, ShieldCheck, Clock, XCircle } from "lucide-react";

export const dynamic = "force-dynamic";

type DisabilityStatus = "not_submitted" | "pending" | "approved" | "rejected";

export default async function EnrollPage({
  params,
}: {
  params: Promise<{ moduleSlug: string }>;
}) {
  const { moduleSlug } = await params;
  const supabase = await createClient();

  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) {
    redirect(`/login?next=/courses/${moduleSlug}/enroll`);
  }

  const { data: moduleData } = await (supabase as any)
    .from("modules")
    .select("id, name, price_paisa, currency")
    .eq("slug", moduleSlug)
    .single();

  if (!moduleData) notFound();

  // Free module → nothing to do here. Send them in.
  if (moduleData.price_paisa == null) {
    redirect(`/courses/${moduleSlug}`);
  }

  // Already enrolled? Send them in.
  const { hasAccess } = await getModuleAccess(moduleData.id);
  if (hasAccess) {
    redirect(`/courses/${moduleSlug}`);
  }

  const [{ data: profile }, { data: settings }] = await Promise.all([
    (supabase as any)
      .from("profiles")
      .select("disability_status, disability_rejection_reason")
      .eq("id", user.id)
      .single(),
    (supabase as any)
      .from("site_settings")
      .select("whatsapp_number, payment_instructions")
      .eq("id", 1)
      .single(),
  ]);

  const status: DisabilityStatus = profile?.disability_status ?? "not_submitted";
  const priceLabel = `${moduleData.currency || "NPR"} ${(
    moduleData.price_paisa / 100
  ).toLocaleString()}`;

  const wa = settings?.whatsapp_number
    ? `https://wa.me/${String(settings.whatsapp_number).replace(/\D/g, "")}`
    : null;

  return (
    <section className="max-w-2xl mx-auto px-4 py-8 space-y-6">
      <div>
        <p className="text-sm uppercase tracking-wide text-gray-500">Enroll</p>
        <h1 id="main-heading" className="text-2xl font-semibold text-gray-900">
          <Lang>{moduleData.name}</Lang>
        </h1>
        <p className="mt-2 text-2xl font-bold text-blue-700">{priceLabel}</p>
      </div>

      {status === "not_submitted" && (
        <NotVerifiedYet moduleSlug={moduleSlug} />
      )}

      {status === "pending" && <PendingIdentity />}

      {status === "rejected" && (
        <RejectedIdentity
          reason={profile?.disability_rejection_reason ?? null}
          moduleSlug={moduleSlug}
        />
      )}

      {status === "approved" && (
        <HowToEnroll
          moduleName={moduleData.name}
          whatsappUrl={wa}
          email={user.email ?? null}
        />
      )}
    </section>
  );
}

function NotVerifiedYet({ moduleSlug }: { moduleSlug: string }) {
  return (
    <div className="bg-white border rounded-lg p-6 space-y-4">
      <div className="flex items-start gap-3">
        <ShieldCheck className="w-6 h-6 text-blue-600 flex-shrink-0" />
        <div>
          <h2 className="text-base font-semibold text-gray-900">
            One quick step first: verify your identity
          </h2>
          <p className="mt-1 text-sm text-gray-600">
            DrishtiPrep is built primarily for visually-impaired aspirants. We
            ask all paid-course enrollees to submit a disability card as a
            one-time identity check.
          </p>
          <p className="mt-1 text-sm text-gray-600">
            Once approved, we'll email you with payment instructions for any
            course you'd like to enroll in.
          </p>
        </div>
      </div>
      <Link
        href={`/profile/verify-identity?next=/courses/${moduleSlug}/enroll`}
        className={buttonVariants()}
      >
        Verify my identity
      </Link>
    </div>
  );
}

function PendingIdentity() {
  return (
    <div
      role="status"
      className="bg-blue-50 border border-blue-200 text-blue-900 p-4 rounded-lg flex items-start gap-3"
    >
      <Clock className="w-5 h-5 mt-0.5 flex-shrink-0" />
      <div>
        <h2 className="font-semibold">Identity verification pending</h2>
        <p className="mt-1 text-sm">
          Your disability card is awaiting review. Once approved, you'll receive
          an email with payment instructions and can enroll in this course.
        </p>
      </div>
    </div>
  );
}

function RejectedIdentity({
  reason,
  moduleSlug,
}: {
  reason: string | null;
  moduleSlug: string;
}) {
  return (
    <div className="space-y-4">
      <div
        role="status"
        className="bg-red-50 border border-red-200 text-red-900 p-4 rounded-lg flex items-start gap-3"
      >
        <XCircle className="w-5 h-5 mt-0.5 flex-shrink-0" />
        <div>
          <h2 className="font-semibold">Identity verification was not approved</h2>
          <p className="mt-1 text-sm">
            <span className="font-medium">Reason:</span>{" "}
            {reason || "(no reason provided)"}
          </p>
          <p className="mt-2 text-sm">You can submit a new image to try again.</p>
        </div>
      </div>
      <Link
        href={`/profile/verify-identity?next=/courses/${moduleSlug}/enroll`}
        className={buttonVariants()}
      >
        Re-submit identity
      </Link>
    </div>
  );
}

function HowToEnroll({
  moduleName,
  whatsappUrl,
  email,
}: {
  moduleName: string;
  whatsappUrl: string | null;
  email: string | null;
}) {
  return (
    <div className="bg-white border rounded-lg p-6 space-y-4">
      <div className="flex items-start gap-3">
        <ShieldCheck className="w-6 h-6 text-green-600 flex-shrink-0" />
        <div>
          <h2 className="text-base font-semibold text-gray-900">
            Your identity is verified
          </h2>
          <p className="mt-1 text-sm text-gray-600">
            Payment instructions were emailed to you when your identity was
            approved. To enroll in this course, send us your payment proof and
            we'll activate access — usually within 24 hours.
          </p>
        </div>
      </div>

      <div className="border-t pt-4">
        <h3 className="text-sm font-semibold text-gray-900 mb-2">
          Send your payment proof to one of these:
        </h3>
        <ul className="space-y-2 text-sm">
          {whatsappUrl && (
            <li className="flex items-center gap-2">
              <MessageCircle className="w-4 h-4 text-green-600" />
              <a
                href={whatsappUrl}
                target="_blank"
                rel="noopener noreferrer"
                className="text-blue-700 underline hover:no-underline"
              >
                Open WhatsApp
              </a>
              <span className="text-gray-500">
                — include your registered email and the course name
              </span>
            </li>
          )}
          <li className="flex items-center gap-2">
            <Mail className="w-4 h-4 text-blue-600" />
            <span>
              Reply to the verification email with your proof and the course name
            </span>
          </li>
        </ul>
      </div>

      <div className="border-t pt-4 text-xs text-gray-500">
        <p>
          <span className="font-medium">Course:</span>{" "}
          <Lang>{moduleName}</Lang>
        </p>
        {email && (
          <p>
            <span className="font-medium">Your registered email:</span>{" "}
            <span className="font-mono">{email}</span>
          </p>
        )}
      </div>
    </div>
  );
}
