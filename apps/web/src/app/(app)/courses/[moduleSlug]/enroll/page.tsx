import { notFound, redirect } from "next/navigation";
import Link from "next/link";
import { createClient, createStaticClient } from "@/lib/supabase/server";
import { getModuleAccess } from "@/lib/access";
import { Lang } from "@/components/ui/Lang";
import { SeeMoreText } from "@/components/ui/SeeMoreText";
import { Badge } from "@/components/ui/badge";
import { Breadcrumbs } from "@/components/ui/Breadcrumbs";
import { buttonVariants } from "@/components/ui/button-variants";
import { BookOpen, Mail, MessageCircle, ShieldCheck, Clock, XCircle } from "lucide-react";

export const dynamic = "force-dynamic";

type DisabilityStatus = "not_submitted" | "pending" | "approved" | "rejected";

/**
 * Detail + payment page for a LOCKED course. Learners land here from the browse
 * grid when they don't yet have access: it leads with the course description and
 * a curriculum preview (the "detail"), then the enrollment/payment flow. Free or
 * already-enrolled learners are redirected straight into the content tree — for
 * them there is nothing to buy, so the content view is the right destination.
 */
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
    .select("id, name, description, price_paisa, currency")
    .eq("slug", moduleSlug)
    .single();

  if (!moduleData) notFound();

  // Free module → nothing to buy. Send them into the content tree.
  if (moduleData.price_paisa == null) {
    redirect(`/courses/${moduleSlug}`);
  }

  // Already enrolled? Send them into the content tree.
  const { hasAccess } = await getModuleAccess(moduleData.id);
  if (hasAccess) {
    redirect(`/courses/${moduleSlug}`);
  }

  // Catalog reads go through the anon/static client, matching the other course
  // pages — subjects are public curriculum data, readable before enrollment.
  const staticClient = createStaticClient();

  const [{ data: profile }, { data: settings }, { data: subjects }] = await Promise.all([
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
    staticClient
      .from("subjects")
      .select("id, name, syllabus_ref, display_order")
      .eq("module_id", moduleData.id)
      .order("display_order", { ascending: true }),
  ]);

  const status: DisabilityStatus = profile?.disability_status ?? "not_submitted";
  const priceLabel = `${moduleData.currency || "NPR"} ${(
    moduleData.price_paisa / 100
  ).toLocaleString()}`;

  const wa = settings?.whatsapp_number
    ? `https://wa.me/${String(settings.whatsapp_number).replace(/\D/g, "")}`
    : null;

  return (
    <section className="space-y-8">
      <Breadcrumbs
        items={[
          { label: "Courses", href: "/courses" },
          { label: <Lang>{moduleData.name}</Lang> },
        ]}
      />

      <header className="space-y-3">
        <div className="flex flex-wrap items-center gap-3">
          <h1
            id="main-heading"
            className="text-2xl font-bold tracking-tight text-foreground sm:text-3xl"
          >
            <Lang>{moduleData.name}</Lang>
          </h1>
          <Badge tone="primary">{priceLabel}</Badge>
        </div>
        <div className="text-muted-foreground">
          {moduleData.description ? (
            <SeeMoreText text={moduleData.description} maxLength={200} />
          ) : (
            "A paid course. Verify your identity and complete payment to open its subjects and practice sets."
          )}
        </div>
      </header>

      {subjects && subjects.length > 0 && (
        <div className="rounded-2xl border-2 border-border bg-card p-5 sm:p-6">
          <div className="flex items-center gap-2">
            <BookOpen className="h-5 w-5 text-primary" aria-hidden="true" />
            <h2 className="text-base font-semibold text-foreground">
              What&apos;s inside
            </h2>
            <span className="text-sm text-muted-foreground">
              {subjects.length} {subjects.length === 1 ? "subject" : "subjects"}
            </span>
          </div>
          <ul className="mt-4 grid gap-2 sm:grid-cols-2">
            {subjects.map((subject: any) => (
              <li
                key={subject.id}
                className="flex items-start gap-2 rounded-xl border border-border bg-background px-3 py-2.5 text-sm text-foreground"
              >
                {subject.syllabus_ref && (
                  <span className="font-normal text-muted-foreground">
                    {subject.syllabus_ref}
                  </span>
                )}
                <span>
                  <Lang>{subject.name}</Lang>
                </span>
              </li>
            ))}
          </ul>
          <p className="mt-3 text-xs text-muted-foreground">
            Full topics and practice sets unlock once your enrollment is approved.
          </p>
        </div>
      )}

      {status === "not_submitted" && <NotVerifiedYet moduleSlug={moduleSlug} />}

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
    <div className="space-y-4 rounded-2xl border-2 border-border bg-card p-6">
      <div className="flex items-start gap-3">
        <ShieldCheck className="h-6 w-6 flex-shrink-0 text-primary" aria-hidden="true" />
        <div>
          <h2 className="text-base font-semibold text-foreground">
            One quick step first: verify your identity
          </h2>
          <p className="mt-1 text-sm text-muted-foreground">
            DrishtiPrep is built primarily for visually-impaired aspirants. We
            ask all paid-course enrollees to submit a disability card as a
            one-time identity check.
          </p>
          <p className="mt-1 text-sm text-muted-foreground">
            Once approved, we&apos;ll email you with payment instructions for any
            course you&apos;d like to enroll in.
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
      className="flex items-start gap-3 rounded-2xl border-2 border-primary/30 bg-primary/10 p-4 text-foreground"
    >
      <Clock className="mt-0.5 h-5 w-5 flex-shrink-0 text-primary" aria-hidden="true" />
      <div>
        <h2 className="font-semibold">Identity verification pending</h2>
        <p className="mt-1 text-sm text-muted-foreground">
          Your disability card is awaiting review. Once approved, you&apos;ll
          receive an email with payment instructions and can enroll in this
          course.
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
        className="flex items-start gap-3 rounded-2xl border-2 border-destructive/30 bg-destructive/10 p-4 text-foreground"
      >
        <XCircle className="mt-0.5 h-5 w-5 flex-shrink-0 text-destructive" aria-hidden="true" />
        <div>
          <h2 className="font-semibold">Identity verification was not approved</h2>
          <p className="mt-1 text-sm text-muted-foreground">
            <span className="font-medium text-foreground">Reason:</span>{" "}
            {reason || "(no reason provided)"}
          </p>
          <p className="mt-2 text-sm text-muted-foreground">
            You can submit a new image to try again.
          </p>
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
    <div className="space-y-4 rounded-2xl border-2 border-border bg-card p-6">
      <div className="flex items-start gap-3">
        <ShieldCheck className="h-6 w-6 flex-shrink-0 text-green-600 dark:text-green-500" aria-hidden="true" />
        <div>
          <h2 className="text-base font-semibold text-foreground">
            Your identity is verified
          </h2>
          <p className="mt-1 text-sm text-muted-foreground">
            Payment instructions were emailed to you when your identity was
            approved. To enroll in this course, send us your payment proof and
            we&apos;ll activate access, usually within 24 hours.
          </p>
        </div>
      </div>

      <div className="border-t border-border pt-4">
        <h3 className="mb-2 text-sm font-semibold text-foreground">
          Send your payment proof to one of these:
        </h3>
        <ul className="space-y-2 text-sm">
          {whatsappUrl && (
            <li className="flex items-center gap-2">
              <MessageCircle className="h-4 w-4 text-green-600 dark:text-green-500" aria-hidden="true" />
              <a
                href={whatsappUrl}
                target="_blank"
                rel="noopener noreferrer"
                className="text-primary underline hover:no-underline"
              >
                Open WhatsApp
              </a>
              <span className="text-muted-foreground">
                Include your registered email and the course name.
              </span>
            </li>
          )}
          <li className="flex items-center gap-2">
            <Mail className="h-4 w-4 text-primary" aria-hidden="true" />
            <span className="text-muted-foreground">
              Reply to the verification email with your proof and the course name
            </span>
          </li>
        </ul>
      </div>

      <div className="border-t border-border pt-4 text-xs text-muted-foreground">
        <p>
          <span className="font-medium text-foreground">Course:</span>{" "}
          <Lang>{moduleName}</Lang>
        </p>
        {email && (
          <p>
            <span className="font-medium text-foreground">Your registered email:</span>{" "}
            <span className="font-mono">{email}</span>
          </p>
        )}
      </div>
    </div>
  );
}
