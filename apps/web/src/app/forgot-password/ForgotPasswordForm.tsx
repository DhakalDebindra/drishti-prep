"use client";

import { useState, useMemo } from "react";
import { createClient } from "@/lib/supabase/client";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Card, CardContent, CardDescription, CardHeader, CardTitle, CardFooter } from "@/components/ui/card";
import Link from "next/link";
import { logger } from "@/lib/logger";

const supabase = createClient();

export default function ForgotPasswordForm() {
  const [email, setEmail] = useState("");
  const [error, setError] = useState("");
  const [isSuccess, setIsSuccess] = useState(false);
  const [isLoading, setIsLoading] = useState(false);

  const handleResetPassword = async (e: React.FormEvent) => {
    e.preventDefault();
    setError("");
    setIsLoading(true);

    try {
      const { error: err } = await supabase.auth.resetPasswordForEmail(email, {
        redirectTo: `${window.location.origin}/auth/callback?next=/update-password`,
      });

      if (err) {
        if (err.message.includes("User not found")) {
          setError("We couldn't find an account with that email address.");
        } else {
          setError("An error occurred while sending the reset link. Please try again.");
        }
      } else {
        setIsSuccess(true);
      }
    } catch (err: any) {
      logger.error("Caught Exception during Forgot Password:", err);
      setError("An unexpected error occurred. Please try again.");
    } finally {
      setIsLoading(false);
    }
  };

  if (isSuccess) {
    return (
      <main id="main" className="min-h-screen flex items-center justify-center bg-background p-4">
        <Card className="w-full max-w-md">
          <CardHeader>
            <CardTitle className="text-2xl text-center"><h1>Check your email</h1></CardTitle>
            <CardDescription className="text-center">
              We've sent password reset instructions to <span className="font-semibold">{email}</span>.
            </CardDescription>
          </CardHeader>
          <CardContent className="space-y-4">
            <p className="text-sm text-center text-muted-foreground">
              Please check your inbox and follow the link to create a new password.
            </p>
          </CardContent>
          <CardFooter>
            <Link href="/login" className="block w-full text-center text-sm font-medium text-primary underline underline-offset-2">
              Return to login
            </Link>
          </CardFooter>
        </Card>
      </main>
    );
  }

  return (
    <main id="main" className="min-h-screen flex items-center justify-center bg-background p-4">
      <Card className="w-full max-w-md">
        <CardHeader>
          <CardTitle className="text-2xl text-center"><h1 id="forgot-password-heading">Reset password</h1></CardTitle>
          <CardDescription className="text-center">Enter your email to receive a reset link</CardDescription>
        </CardHeader>
        <form onSubmit={handleResetPassword} aria-labelledby="forgot-password-heading">
          <CardContent className="space-y-4">
            {error && (
              <div role="alert" aria-live="assertive" aria-atomic="true" className="bg-destructive/10 text-destructive p-3 rounded-md text-sm">
                {error}
              </div>
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
          </CardContent>
          <CardFooter className="flex flex-col space-y-4">
            <Button type="submit" className="w-full" disabled={isLoading}>
              {isLoading ? "Sending Link..." : "Send Reset Link"}
            </Button>
            <div className="text-sm text-center text-muted-foreground">
              Remember your password? <Link href="/login" className="font-medium text-primary underline underline-offset-2">Log in</Link>
            </div>
          </CardFooter>
        </form>
      </Card>
    </main>
  );
}
