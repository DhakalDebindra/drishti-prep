"use client";

import Link from "next/link";
import { useEffect, useState } from "react";
import { usePathname } from "next/navigation";
import { cn } from "@repo/utils";
import { buttonVariants } from "@/components/ui/button-variants";
import { PracticeAccessibilityMenu } from "@/components/practice/AccessibilityMenu";

// Anchors are absolute (`/#id`) rather than bare (`#id`) so the same header
// works on /login and /signup, where those sections do not exist — the link
// navigates home and then scrolls, instead of doing nothing.
const navLinks = [
  { href: "/#features", label: "Features", id: "features" },
  { href: "/#courses", label: "Courses", id: "courses" },
  { href: "/#accessibility", label: "Accessibility", id: "accessibility" },
  { href: "/#about", label: "About", id: "about" },
];

export function PublicHeader() {
  const pathname = usePathname();
  const [currentHash, setCurrentHash] = useState("");

  useEffect(() => {
    const onHashChange = () => setCurrentHash(window.location.hash);
    onHashChange();
    window.addEventListener("hashchange", onHashChange);
    return () => window.removeEventListener("hashchange", onHashChange);
  }, []);

  return (
    <header className="flex flex-wrap items-center justify-between gap-3 rounded-2xl border-2 border-border bg-card px-4 py-3 shadow-sm">
      <Link
        href="/"
        className="flex items-center gap-3 rounded-lg focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring"
      >
        <span
          aria-hidden="true"
          className="flex h-10 w-10 items-center justify-center rounded-xl bg-primary text-sm font-bold text-primary-foreground"
        >
          DP
        </span>
        <span className="flex flex-col">
          <span className="text-sm font-bold uppercase tracking-[0.2em] text-primary">
            DrishtiPrep
          </span>
          <span className="text-xs text-muted-foreground">Accessible exam prep</span>
        </span>
      </Link>

      <nav
        aria-label="Primary"
        className="hidden items-center gap-1 text-sm font-medium md:flex"
      >
        {navLinks.map((link) => {
          const isActive = pathname === "/" && currentHash === `#${link.id}`;
          return (
            <Link
              key={link.href}
              href={link.href}
              aria-current={isActive ? "page" : undefined}
              className={cn(
                "rounded-lg px-3 py-2 transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring",
                isActive
                  ? "bg-primary/10 text-primary"
                  : "text-foreground hover:bg-muted hover:text-primary"
              )}
            >
              {link.label}
            </Link>
          );
        })}
      </nav>

      <div className="flex items-center gap-2">
        {/* The shared menu ships hardcoded white/slate colours for the practice
            screens. Those never adapt to the high-contrast theme (.hc is not
            .dark, so its dark: variants never fire) and the trigger renders as
            a white pill on a black page. Override with semantic tokens —
            twMerge lets these win over the component's defaults. */}
        <PracticeAccessibilityMenu
          buttonMode="compact"
          className="border-border bg-card text-foreground hover:bg-muted dark:border-border dark:bg-card dark:text-foreground dark:hover:bg-muted"
        />
        <Link
          href="/login"
          className={cn(buttonVariants({ variant: "outline" }), "hidden font-semibold sm:inline-flex")}
        >
          Log in
        </Link>
        <Link href="/signup" className={cn(buttonVariants(), "font-semibold")}>
          Get started
        </Link>
      </div>
    </header>
  );
}
