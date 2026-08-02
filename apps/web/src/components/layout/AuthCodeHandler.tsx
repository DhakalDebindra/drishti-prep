"use client";

import { useEffect } from "react";
import { useRouter, useSearchParams } from "next/navigation";

/**
 * Supabase can be configured to send password-reset / email-confirmation links
 * back to the site root instead of the callback route. When a `code` lands on
 * the homepage, hand it to the callback handler so the session is exchanged and
 * the user continues to /update-password.
 *
 * Rendered as a client island so the homepage itself can stay a server
 * component. Must be wrapped in <Suspense> — useSearchParams opts the subtree
 * into client-side rendering.
 */
export function AuthCodeHandler() {
  const router = useRouter();
  const searchParams = useSearchParams();

  useEffect(() => {
    const code = searchParams.get("code");
    if (code) {
      router.push(`/auth/callback?code=${code}&next=/update-password`);
    }
  }, [searchParams, router]);

  return null;
}
