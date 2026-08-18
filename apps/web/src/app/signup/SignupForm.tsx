"use client";

import { signupSchema } from "@repo/validation";
import { useRef, useState } from "react";
import { useRouter } from "next/navigation";
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

export default function SignupForm() {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [fullName, setFullName] = useState("");
  const [showPassword, setShowPassword] = useState(false);
  const [showConfirmPassword, setShowConfirmPassword] = useState(false);
  const [error, setError] = useState("");
  const [isSuccess, setIsSuccess] = useState(false);
  const [isLoading, setIsLoading] = useState(false);
  const [isResending, setIsResending] = useState(false);
  const [resendMessage, setResendMessage] = useState("");

  // The submit buttons carry disabled={isLoading}, but that is React state: a
  // fast double-tap fires both submits before the re-render lands. Two signups
  // for the same address regenerate the confirmation token, which silently
  // kills the link in the first email — the user then opens the older mail and
  // gets "Email link is invalid or has expired". A ref flips synchronously, so
  // the second submit never reaches Supabase.
  const submittingRef = useRef(false);
  const resendingRef = useRef(false);

  const router = useRouter();

  const getPasswordStrength = (pwd: string) => {
    let score = 0;
    if (pwd.length > 5) score += 1;
    if (pwd.length > 8) score += 1;
    if (/[A-Z]/.test(pwd)) score += 1;
    if (/[0-9]/.test(pwd)) score += 1;
    if (/[^A-Za-z0-9]/.test(pwd)) score += 1;
    return score; // 0 to 5
  };

  const strengthScore = getPasswordStrength(password);
  const passwordMismatch = confirmPassword.length > 0 && password !== confirmPassword;
  const visibleError = error || (passwordMismatch ? "Passwords do not match." : "");
  let strengthText = "";
  let strengthColor = "bg-muted";
  if (password.length > 0) {
    if (strengthScore <= 1) { strengthText = "Weak"; strengthColor = "bg-red-500"; }
    else if (strengthScore <= 3) { strengthText = "Fair"; strengthColor = "bg-yellow-500"; }
    else { strengthText = "Strong"; strengthColor = "bg-green-500"; }
  }

  const handleSignup = async (e: React.FormEvent) => {
    e.preventDefault();
    if (submittingRef.current) return;
    setError("");

    const parsed = signupSchema.safeParse({
      fullName,
      email,
      password,
      confirmPassword,
    });

    if (!parsed.success) {
      setError(parsed.error.issues[0]?.message ?? "Please check your input.");
      return;
    }

    submittingRef.current = true;
    setIsLoading(true);

    try {
      const { data, error: err } = await supabase.auth.signUp({
        email: parsed.data.email,
        password: parsed.data.password,
        options: {
          data: {
            full_name: parsed.data.fullName,
          },
          emailRedirectTo: `${window.location.origin}/auth/callback`,
        }
      });

      if (err) {
        if (err.message.includes("User already registered")) {
          setError("An account with this email already exists. Try logging in instead.");
        } else {
          // Was "Incorrect email or password", copied from the login form. There
          // is no password to get wrong when creating an account, so it told
          // people to fix something that was not the problem.
          setError("We could not create your account. Check your details and try again.");
        }
      } else {
        if (data.session) {
           router.push("/dashboard");
           router.refresh();
        } else {
           setIsSuccess(true);
        }
      }
    } catch (err: any) {
      logger.error("Caught Exception during Sign Up:", err);
      setError("Something went wrong creating your account. Please try again.");
    } finally {
      submittingRef.current = false;
      setIsLoading(false);
    }
  };

  const handleResend = async () => {
    // Same guard as handleSignup: a second resend invalidates the token in the
    // mail the first one just sent, and burns the hourly email allowance.
    if (resendingRef.current) return;
    resendingRef.current = true;
    setIsResending(true);
    setResendMessage("");
    setError("");
    try {
      const { error: err } = await supabase.auth.resend({
        type: 'signup',
        email: email,
        options: {
          emailRedirectTo: `${window.location.origin}/auth/callback`,
        }
      });
      if (err) throw err;
      setResendMessage("Confirmation email sent again. Open the newest one — older links stop working.");
    } catch (err: any) {
      if (err?.code === "over_email_send_rate_limit" || err?.status === 429) {
        setError("Too many emails have been sent for now. Please wait an hour and try again.");
      } else {
        setError("We could not resend the confirmation email. Please try again in a minute.");
      }
    } finally {
      resendingRef.current = false;
      setIsResending(false);
    }
  };

  if (isSuccess) {
    return (
      <div className="min-h-screen bg-background">
        <div className="mx-auto max-w-6xl px-6 pt-10 lg:px-10">
          <PublicHeader />
          {/* Same <main id="main"> landmark / skip-link target as the form
              branch below. Only one branch renders at a time, so the id stays
              unique in the document. */}
          <main id="main" className="flex justify-center pt-14">
            <Card className="w-full max-w-md">
              <CardHeader>
                <CardTitle className="text-2xl text-center">Check your email</CardTitle>
                <CardDescription className="text-center">
                  We've sent a confirmation link to <span className="font-semibold">{email}</span>.
                </CardDescription>
              </CardHeader>
              <CardContent className="space-y-4">
                {visibleError && (
                  <div role="alert" aria-live="assertive" aria-atomic="true" className="bg-destructive/10 text-destructive p-3 rounded-md text-sm">
                    {visibleError}
                  </div>
                )}
                {resendMessage && (
                  <div role="alert" aria-live="polite" className="bg-success/10 text-success p-3 rounded-md text-sm">
                    {resendMessage}
                  </div>
                )}
                <p className="text-sm text-center text-muted-foreground">
                  Please click the link in that email to activate your account. If
                  you receive more than one, open the newest — each new link
                  replaces the one before it.
                </p>
              </CardContent>
              <CardFooter className="flex flex-col space-y-4">
                <Button onClick={handleResend} variant="outline" className="w-full" disabled={isResending}>
                  {isResending ? "Resending..." : "Resend confirmation email"}
                </Button>
                <Link
                  href="/login"
                  className="block w-full text-center text-sm font-medium text-primary underline underline-offset-2"
                >
                  Return to login
                </Link>
              </CardFooter>
            </Card>
          </main>
        </div>
      </div>
    );
  }

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
                <h1 id="signup-heading">Create account</h1>
              </CardTitle>
              <CardDescription className="text-center">Create an account to track your progress.</CardDescription>
            </CardHeader>
            <form onSubmit={handleSignup} aria-labelledby="signup-heading">
              <CardContent className="space-y-4">
                {visibleError && (
                  <div role="alert" aria-live="assertive" aria-atomic="true" className="bg-destructive/10 text-destructive p-3 rounded-md text-sm">
                    {visibleError}
                  </div>
                )}
                <div className="space-y-2">
                  <Label htmlFor="fullName">Full name</Label>
                  <Input
                    id="fullName"
                    type="text"
                    placeholder="John Doe"
                    value={fullName}
                    onChange={(e) => setFullName(e.target.value)}
                    required
                    autoComplete="name"
                  />
                </div>
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
                  <Label htmlFor="password">Password</Label>
                  <div className="relative">
                    <Input
                      id="password"
                      type={showPassword ? "text" : "password"}
                      value={password}
                      onChange={(e) => setPassword(e.target.value)}
                      required
                      minLength={6}
                      autoComplete="new-password"
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
                  {password && (
                    <div className="flex items-center space-x-2 mt-2">
                      <div className="flex-1 h-2 bg-muted rounded-full overflow-hidden">
                        <div
                          className={`h-full ${strengthColor} transition-all duration-300`}
                          style={{ width: `${(strengthScore / 5) * 100}%` }}
                          aria-hidden="true"
                        />
                      </div>
                      {/* The bar is decorative; strength is conveyed in text so
                          it never depends on colour perception alone. */}
                      <span className="text-xs text-muted-foreground w-12">{strengthText}</span>
                    </div>
                  )}
                </div>
                <div className="space-y-2">
                  <Label htmlFor="confirmPassword">Confirm password</Label>
                  <div className="relative">
                    <Input
                      id="confirmPassword"
                      type={showConfirmPassword ? "text" : "password"}
                      value={confirmPassword}
                      onChange={(e) => setConfirmPassword(e.target.value)}
                      required
                      minLength={6}
                      autoComplete="new-password"
                    />
                    <button
                      type="button"
                      className="absolute right-3 top-1/2 -translate-y-1/2 text-muted-foreground hover:text-foreground"
                      onClick={() => setShowConfirmPassword(!showConfirmPassword)}
                      aria-label={showConfirmPassword ? "Hide confirm password" : "Show confirm password"}
                    >
                      {showConfirmPassword ? <EyeOff size={18} /> : <Eye size={18} />}
                    </button>
                  </div>
                </div>
              </CardContent>
              <CardFooter className="flex flex-col space-y-4">
                <Button type="submit" className="w-full" disabled={isLoading}>
                  {isLoading ? "Creating account..." : "Create account"}
                </Button>
                {/* Inline links carry an underline, not colour alone: axe's
                    link-in-text-block rule (and users who cannot distinguish
                    the accent from body text) need a non-colour cue. */}
                <div className="text-sm text-center text-muted-foreground">
                  Already have an account?{" "}
                  <Link
                    href="/login"
                    className="font-medium text-primary underline underline-offset-2"
                  >
                    Log in
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
