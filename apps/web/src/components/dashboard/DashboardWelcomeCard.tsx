"use client";

import { useCallback, useSyncExternalStore } from "react";
import Link from "next/link";
import { BookOpen, Play, X } from "lucide-react";

import { cn } from "@repo/utils";
import { buttonVariants } from "@/components/ui/button-variants";

const STORAGE_KEY = "dp:welcome-dismissed:v1";

// Read the dismissed flag via useSyncExternalStore so we never call setState in
// an effect at mount (react-hooks/set-state-in-effect is an error in CI). The
// server snapshot reports "dismissed" so the card never renders during SSR —
// this avoids both a hydration mismatch and a first-paint flash before the
// client reads localStorage.
function subscribe(onChange: () => void) {
  window.addEventListener("storage", onChange);
  return () => window.removeEventListener("storage", onChange);
}

function getSnapshot() {
  try {
    return localStorage.getItem(STORAGE_KEY) === "1";
  } catch {
    return true;
  }
}

function getServerSnapshot() {
  return true;
}

export function DashboardWelcomeCard() {
  const dismissed = useSyncExternalStore(subscribe, getSnapshot, getServerSnapshot);

  const dismiss = useCallback(() => {
    try {
      localStorage.setItem(STORAGE_KEY, "1");
    } catch {
      // localStorage unavailable (private mode / disabled) — nothing to persist.
    }
    // storage events do not fire in the tab that made the change, so nudge our
    // own subscriber to re-read the snapshot and unmount the card immediately.
    window.dispatchEvent(new Event("storage"));
  }, []);

  if (dismissed) return null;

  return (
    <section
      aria-labelledby="welcome-card-heading"
      className="relative rounded-3xl border-2 border-primary/30 bg-card p-6 shadow-sm sm:p-8"
    >
      <button
        type="button"
        onClick={dismiss}
        className="absolute right-4 top-4 inline-flex h-9 w-9 items-center justify-center rounded-full border border-border bg-card text-muted-foreground transition hover:bg-muted hover:text-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring"
        aria-label="Dismiss welcome message"
      >
        <X className="h-5 w-5" aria-hidden="true" />
      </button>

      <div className="max-w-2xl space-y-3 pr-10">
        <h2 id="welcome-card-heading" className="text-2xl font-bold tracking-tight text-foreground">
          Welcome to DrishtiPrep
        </h2>
        <p className="text-base leading-relaxed text-muted-foreground">
          This is your practice hub — choose a course, work through practice sets, and track your progress.
        </p>
      </div>

      <div className="mt-5 flex flex-col gap-3 sm:flex-row">
        <Link href="/courses" className={cn(buttonVariants({ size: "lg" }), "font-semibold")}>
          <BookOpen className="h-5 w-5" aria-hidden="true" />
          Browse courses
        </Link>
        <Link
          href="/practice/dashboard"
          className={cn(buttonVariants({ variant: "secondary", size: "lg" }), "font-semibold")}
        >
          <Play className="h-5 w-5" aria-hidden="true" />
          Start practice
        </Link>
      </div>
    </section>
  );
}
