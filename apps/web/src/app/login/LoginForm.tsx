"use client";

import { loginSchema } from "@repo/validation";
import { useRef, useState } from "react";
import { useRouter, useSearchParams } from "next/navigation";
import { createClient } from "@/lib/supabase/client";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Card, CardContent, CardDescription, CardHeader, CardTitle, CardFooter } from "@/components/ui/card";
import { PublicHeader } from "@/components/layout/PublicHeader";
import Link from "next/link";
import { Eye, EyeOff } from "lucide-react";
import { logger } from "@/lib/logger";

const supabase = createClient();

const UNVERIFIED_MESSAGE =
  "Please verify your email address before signing in. Check your inbox for the confirmation link.";

// Codes come from the middleware (?error=unverified) and /auth/callback. Only
// known codes are rendered, so a hand-crafted ?error= cannot put arbitrary text
// in the banner.
const ERROR_MESSAGES: Record<string, string> = {
  unverified: UNVERIFIED_MESSAGE,
  link_expired:
    "That confirmation link is no longer valid. Links expire, and a newer link replaces any older one. Send yourself a fresh one below.",
  rate_limited: "Too many attempts. Please wait a minute and try again.",
};

// Both of these leave the account unusable until a fresh confirmation mail is
// opened, so both get the resend prompt.
const RESENDABLE = new Set(["unverified", "link_expired"]);

export default function LoginForm() {
  const router = useRouter();
  const searchParams = useSearchParams();

  const initialErrorCode = searchParams.get("error") ?? "";

  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [showPassword, setShowPassword] = useState(false);
  const [error, setError] = useState(() => ERROR_MESSAGES[initialErrorCode] ?? "");
  const [needsVerification, setNeedsVerification] = useState(() =>
    RESENDABLE.has(initialErrorCode)
  );
  const [resendMessage, setResendMessage] = useState("");
  const [isResending, setIsResending] = useState(false);
  const [isLoading, setIsLoading] = useState(false);

  // Refs, not state: state-driven disabled={} only takes effect on the next
  // render, so a double-tap fires two requests. A second confirmation mail
  // invalidates the link in the first one, which is exactly the trap we are
  // trying to get users out of here.
  const submittingRef = useRef(false);
  const resendingRef = useRef(false);

  const handleResendConfirmation = async () => {
    if (resendingRef.current) return;
    if (!email) {
      setError("Please enter your email address above, then tap resend.");
      return;
    }
    resendingRef.current = true;
    setIsResending(true);
    setResendMessage("");
    setError("");

    try {
      const { error: err } = await supabase.auth.resend({
        type: "signup",
        email,
        options: { emailRedirectTo: `${window.location.origin}/auth/callback` },
      });
      if (err) throw err;
      setResendMessage(
        "Confirmation email sent. Open the newest one — older links stop working."
      );
    } catch (err: any) {
      logger.error("Resend confirmation failed:", err);
      if (err?.code === "over_email_send_rate_limit" || err?.status === 429) {
        setError("Too many emails have been sent for now. Please wait an hour and try again.");
      } else {
        setError("We could not send the confirmation email. Please try again in a minute.");
      }
    } finally {
      resendingRef.current = false;
      setIsResending(false);
    }
  };

  const handleLogin = async (e: React.FormEvent) => {
    e.preventDefault();
    if (submittingRef.current) return;
    setError("");
    setResendMessage("");
    setNeedsVerification(false);

    const parsed = loginSchema.safeParse({ email, password });
    if (!parsed.success) {
      setError(parsed.error.issues[0]?.message ?? "Please check your input.");
      return;
    }

    submittingRef.current = true;
    setIsLoading(true);

    try {
      const controller = new AbortController();
      const timeoutId = setTimeout(() => controller.abort(), 15000);

      const authPromise = supabase.auth.signInWithPassword({
        email: parsed.data.email,
        password: parsed.data.password,
      });

      const timeoutPromise = new Promise<{ data: any, error: any }>((_, reject) => {
        controller.signal.addEventListener("abort", () => reject(new Error("AbortError")));
      });

      const { error } = (await Promise.race([authPromise, timeoutPromise])) as any;
      clearTimeout(timeoutId);

      if (error) {
        logger.error("Supabase Auth Error Object:", JSON.stringify(error, null, 2));
        const message = error.message ?? "";
        // An unconfirmed account fails here, at signInWithPassword — there is
        // no session and no user object to inspect afterwards. This case used
        // to fall through to the generic "could not sign you in", which told
        // people nothing and had them retrying a login that could never work.
        if (error.code === "email_not_confirmed" || message.includes("Email not confirmed")) {
          setError(UNVERIFIED_MESSAGE);
          setNeedsVerification(true);
        } else if (message.includes("Invalid login credentials") || message.includes("Invalid credentials")) {
          setError("Incorrect email or password.");
        } else if (error.code === "over_request_rate_limit" || error.status === 429) {
          setError("Too many attempts. Please wait a minute and try again.");
        } else {
          setError("We could not sign you in. Please try again.");
        }
      } else {
        logger.info("Login successful! Redirecting...");
        // The middleware bounces unauthenticated users here with ?redirect_to=
        // (see lib/supabase/middleware.ts); ?next= is the older spelling. Read
        // both, or an admin sent to /login from /admin/… lands on the dashboard
        // and has to navigate back by hand.
        const dest = searchParams.get("redirect_to") ?? searchParams.get("next");
        // Invalidate the stale router cache *before* navigating: doing it after
        // the push re-renders the destination a second time, and the dashboard
        // is an expensive render.
        router.refresh();
        router.push(dest && dest.startsWith("/") ? dest : "/dashboard");
      }
    } catch (err: any) {
      if (err.message === "AbortError") {
        setError("Connection timed out. Please try again.");
      } else {
        logger.error("Caught Exception during Sign In:", err);
        setError("Something went wrong signing you in. Please try again.");
      }
    } finally {
      submittingRef.current = false;
      setIsLoading(false);
    }
  };

  return (
    <div className="min-h-screen bg-background">
      <div className="mx-auto max-w-6xl px-6 pt-10 lg:px-10">
        <PublicHeader />
        {/* <main id="main"> so the root layout's "Skip to main content" link
            has a target here. Without it the skip link silently does nothing
            on this page, and the form sits outside any landmark. */}
        <main id="main" className="flex justify-center pt-14">
          <Card className="w-full max-w-md">
            <CardHeader>
              <CardTitle className="text-2xl text-center">
                <h1 id="login-heading">Log in</h1>
              </CardTitle>
              <CardDescription className="text-center">Sign in to your learner account</CardDescription>
            </CardHeader>
            <form onSubmit={handleLogin} aria-labelledby="login-heading">
              <CardContent className="space-y-4">
                {error && (
                  <div role="alert" aria-live="assertive" aria-atomic="true" className="bg-destructive/10 text-destructive p-3 rounded-md text-sm">
                    {error}
                  </div>
                )}
                {resendMessage && (
                  <div role="alert" aria-live="polite" aria-atomic="true" className="bg-success/10 text-success p-3 rounded-md text-sm">
                    {resendMessage}
                  </div>
                )}
                {needsVerification && (
                  // type="button" matters: inside the form, a bare <button>
                  // submits it, which would fire the login attempt we already
                  // know will fail.
                  <Button
                    type="button"
                    variant="outline"
                    className="w-full"
                    onClick={handleResendConfirmation}
                    disabled={isResending}
                  >
                    {isResending ? "Sending..." : "Resend confirmation email"}
                  </Button>
                )}
                <div className="space-y-2">
                  <Label htmlFor="email">Email</Label>
                  <Input
                    id="email"
                    type="email"
                    placeholder="learner@example.com"
                    value={email}
                    onChange={(e) => setEmail(e.target.value)}
                    required
                    autoComplete="email"
                    autoFocus
                  />
                </div>
                <div className="space-y-2">
                  <div className="flex items-center justify-between">
                    <Label htmlFor="password">Password</Label>
                    <Link
                      href="/forgot-password"
                      className="text-sm font-medium text-primary underline underline-offset-2"
                    >
                      Forgot password?
                    </Link>
                  </div>
                  <div className="relative">
                    <Input
                      id="password"
                      type={showPassword ? "text" : "password"}
                      value={password}
                      onChange={(e) => setPassword(e.target.value)}
                      required
                      autoComplete="current-password"
                    />
                    <button
                      type="button"
                      className="absolute right-3 top-1/2 -translate-y-1/2 text-muted-foreground hover:text-foreground"
                      onClick={() => setShowPassword(!showPassword)}
                      aria-label={showPassword ? "Hide password" : "Show password"}
                    >
                      {showPassword ? <EyeOff size={18} /> : <Eye size={18} />}
                    </button>
                  </div>
                </div>
              </CardContent>
              <CardFooter className="flex flex-col space-y-4">
                <Button type="submit" className="w-full" disabled={isLoading}>
                  {isLoading ? "Logging in..." : "Log in"}
                </Button>
                {/* Inline links carry an underline, not colour alone: axe's
                    link-in-text-block rule (and users who cannot distinguish
                    the accent from body text) need a non-colour cue. */}
                <div className="text-sm text-center text-muted-foreground">
                  Need an account?{" "}
                  <Link
                    href="/signup"
                    className="font-medium text-primary underline underline-offset-2"
                  >
                    Sign up
                  </Link>
                </div>
              </CardFooter>
            </form>
          </Card>
        </main>
      </div>
    </div>
  );
}
