/**
 * Plain-text email templates for identity verification outcomes.
 *
 * We render plain text only (no HTML) for now — it's the most accessible
 * format for screen readers and works in every client without surprises.
 */

type SiteSettings = {
  payment_qr_url?: string | null;
  payment_instructions?: string | null;
  whatsapp_number?: string | null;
};

const APP_URL =
  process.env.NEXT_PUBLIC_APP_URL?.replace(/\/$/, "") ||
  "https://drishti-prep.vercel.app";

function whatsappLink(rawNumber: string | null | undefined): string | null {
  if (!rawNumber) return null;
  const digits = rawNumber.replace(/\D/g, "");
  return digits ? `https://wa.me/${digits}` : null;
}

export function identityApprovedEmail(args: {
  fullName: string | null;
  settings: SiteSettings | null;
}): { subject: string; text: string } {
  const name = args.fullName?.trim() || "there";
  const s = args.settings ?? {};

  const lines: string[] = [
    `Hi ${name},`,
    "",
    "Your identity verification has been approved. You can now request enrollment in any paid course on DrishtiPrep.",
    "",
    `Browse courses: ${APP_URL}/courses`,
    "",
    "How to enroll in a course:",
    "",
    "1. Choose a course from the catalog above and note its name.",
    "2. Pay the course fee using one of the methods below.",
    "3. Send us proof of payment along with your registered email and the course name.",
    "",
  ];

  lines.push("Payment methods:");
  if (s.payment_instructions) {
    lines.push(s.payment_instructions);
  } else {
    lines.push("(Payment details will be provided by the operator. Please reply to this email to request them.)");
  }
  if (s.payment_qr_url) {
    lines.push("");
    lines.push(`QR code (open in browser): ${s.payment_qr_url}`);
  }
  lines.push("");

  lines.push("Submit your payment proof — pick whichever is easiest for you:");
  const wa = whatsappLink(s.whatsapp_number);
  if (wa) {
    lines.push(`- WhatsApp: ${wa}`);
  }
  lines.push("- Reply to this email with a screenshot, transaction reference, or receipt photo");
  lines.push("- In person, if that works better for you");
  lines.push("");

  lines.push(
    "Once we verify your payment we will activate the course on your account, usually within 24 hours. You'll see the course unlocked the next time you log in at " +
      APP_URL +
      "."
  );
  lines.push("");
  lines.push("If you need help at any step, reply to this email or message us on WhatsApp.");
  lines.push("");
  lines.push("— DrishtiPrep");

  return {
    subject: "DrishtiPrep — your identity is verified",
    text: lines.join("\n"),
  };
}

export function identityRejectedEmail(args: {
  fullName: string | null;
  reason: string | null;
}): { subject: string; text: string } {
  const name = args.fullName?.trim() || "there";
  const reason = args.reason?.trim() || "No reason was provided.";

  const text = [
    `Hi ${name},`,
    "",
    "We were unable to approve your identity verification. Reason:",
    "",
    reason,
    "",
    "You can submit a new disability card image at:",
    `${APP_URL}/profile/verify-identity`,
    "",
    "If you have questions about what's needed, reply to this email.",
    "",
    "— DrishtiPrep",
  ].join("\n");

  return {
    subject: "DrishtiPrep — identity verification needs another look",
    text,
  };
}
