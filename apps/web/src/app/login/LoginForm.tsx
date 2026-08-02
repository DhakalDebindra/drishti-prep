"use client";

import { loginSchema } from "@repo/validation";
import { useState } from "react";
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
import { toast } from "react-hot-toast";

const supabase = createClient();

export default function LoginForm() {
  const router = useRouter();
  const searchParams = useSearchParams();

  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [showPassword, setShowPassword] = useState(false);
  const [error, setError] = useState(() => {
    return searchParams.get("error") === "unverified"
      ? "Please verify your email address before signing in. Check your inbox for the confirmation link."
      : "";
  });
  const [isLoading, setIsLoading] = useState(false);

  const handleLogin = async (e: React.FormEvent) => {
    e.preventDefault();
    setError("");

    const parsed = loginSchema.safeParse({ email, password });
    if (!parsed.success) {
      setError(parsed.error.issues[0]?.message ?? "Please check your input.");
      return;
    }

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

      const { data, error } = (await Promise.race([authPromise, timeoutPromise])) as any;
      clearTimeout(timeoutId);

      if (error) {
        logger.error("Supabase Auth Error Object:", JSON.stringify(error, null, 2));
        if (error.message.includes("Invalid login credentials") || error.message.includes("Invalid credentials")) {
          setError("Incorrect email or password.");
        } else {
          setError("An error occurred during sign in. Please try again.");
        }
      } else if (data?.user && !data.user.email_confirmed_at) {
        // Sign out immediately if email is not confirmed
        await supabase.auth.signOut();
        setError("Please verify your email address before signing in. Check your inbox for the confirmation link.");
      } else {
        logger.info("Login successful! Redirecting...");
        toast.success("Signed in successfully!");
        const next = searchParams.get("next");
        router.push(next && next.startsWith("/") ? next : "/dashboard");
        router.refresh(); // Refresh the router cache to ensure the server component picks up the new session
      }
    } catch (err: any) {
      if (err.message === "AbortError") {
        setError("Connection timed out. Please try again.");
        toast.error("Connection timed out.");
      } else {
        logger.error("Caught Exception during Sign In:", err);
        setError("An unexpected error occurred. Please try again.");
        toast.error("An unexpected error occurred.");
      }
    } finally {
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
                <h1 id="login-heading">DrishtiPrep Login</h1>
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
                  {isLoading ? "Signing In..." : "Sign In"}
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
