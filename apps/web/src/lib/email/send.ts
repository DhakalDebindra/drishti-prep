/**
 * Transactional email via Resend.
 *
 * Fail-soft: if RESEND_API_KEY or EMAIL_FROM is missing, we log a warning and
 * return false. Callers must NOT block their core action on the email result —
 * the app's source of truth is the DB; email is a courtesy notification.
 */
import { Resend } from "resend";

type SendArgs = {
  to: string;
  subject: string;
  /** Plain-text body. Required (screen-reader friendly fallback). */
  text: string;
  /** Optional HTML body. */
  html?: string;
  /** Optional reply-to override. */
  replyTo?: string;
};

let cachedClient: Resend | null = null;

function getClient(): Resend | null {
  const key = process.env.RESEND_API_KEY;
  if (!key) return null;
  if (!cachedClient) cachedClient = new Resend(key);
  return cachedClient;
}

export async function sendEmail(args: SendArgs): Promise<boolean> {
  const from = process.env.EMAIL_FROM;
  const client = getClient();

  if (!client || !from) {
    console.warn(
      "[email] Skipped sending — RESEND_API_KEY or EMAIL_FROM not configured.",
      { to: args.to, subject: args.subject }
    );
    return false;
  }

  try {
    const { error } = await client.emails.send({
      from,
      to: args.to,
      subject: args.subject,
      text: args.text,
      ...(args.html ? { html: args.html } : {}),
      ...(args.replyTo ? { replyTo: args.replyTo } : {}),
    });

    if (error) {
      console.error("[email] Resend rejected the message:", error);
      return false;
    }

    return true;
  } catch (err) {
    console.error("[email] Send threw:", err);
    return false;
  }
}
