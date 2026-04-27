"use client";

import Link from "next/link";
import { useMemo } from "react";
import { cn } from "@repo/utils";
import { useTheme } from "next-themes";
import { useContrast } from "@/hooks/use-theme";

export function PublicHeader() {
  const [contrast, setContrast] = useContrast();
  const { resolvedTheme } = useTheme();
  
  const isDark = resolvedTheme === "dark";

  const toggleContrast = () => {
    const next = contrast === "high-contrast" ? "normal" : "high-contrast";
    setContrast(next);
  };

  const navLinks = [
    { href: "#about", label: "About" },
    { href: "#features", label: "Features" },
  ];

  const palette = useMemo(() => {
    if (contrast === "high-contrast") {
      return {
        panel: "border-white bg-black",
        labelTone: "text-yellow-200",
        subText: "text-white",
        navText: "text-white",
        buttonBorder: "border-white/80 text-white",
      };
    }
    if (isDark) {
      return {
        panel: "border-white/10 bg-white/5",
        labelTone: "text-emerald-200",
        subText: "text-slate-200",
        navText: "text-slate-100",
        buttonBorder: "border-white/25 text-slate-50",
      };
    }
    return {
      panel: "border-slate-200 bg-white",
      labelTone: "text-emerald-700",
      subText: "text-slate-700",
      navText: "text-slate-900",
      buttonBorder: "border-slate-300 text-slate-900",
    };
  }, [contrast, isDark]);

  return (
    <header className={cn("flex items-center justify-between rounded-2xl px-4 py-3 backdrop-blur", palette.panel)}>
      <div className="flex items-center gap-3">
        <Link href="/" className="flex items-center gap-3">
          <div className="flex h-10 w-10 items-center justify-center rounded-xl bg-gradient-to-br from-emerald-400 to-cyan-300 text-slate-950 font-semibold shadow-lg shadow-emerald-500/30">
            DP
          </div>
          <div>
            <p className={cn("text-sm uppercase font-bold tracking-[0.2em]", palette.labelTone)}>DrishtiPrep</p>
            <p className={cn("text-xs", palette.subText)}>Accessible exam prep</p>
          </div>
        </Link>
      </div>

      <nav aria-label="Main navigation" className={cn("hidden items-center gap-6 text-sm font-medium sm:flex", palette.navText)}>
        {navLinks.map((link) => (
          <Link
            key={link.href}
            href={link.href}
            className="rounded-md px-2 py-1 transition hover:text-emerald-400 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-4 focus-visible:outline-emerald-300"
          >
            {link.label}
          </Link>
        ))}
      </nav>

      <div className="flex items-center gap-3">
        <button
          type="button"
          aria-pressed={contrast === "high-contrast"}
          className={cn("rounded-full border px-4 py-2 text-xs font-semibold transition hover:border-emerald-200 hover:text-emerald-200", palette.buttonBorder)}
          onClick={toggleContrast}
        >
          {contrast === "high-contrast" ? "Contrast: High" : "Contrast: Normal"}
        </button>
        <Link
          href="/login"
          className={cn("hidden rounded-full border px-4 py-2 text-xs font-semibold sm:inline-flex transition hover:border-emerald-200 hover:text-emerald-200", palette.buttonBorder)}
        >
          Login
        </Link>
        <Link
          href="/signup"
          className="rounded-full bg-emerald-400 px-5 py-2 text-xs font-semibold text-slate-950 shadow-lg shadow-emerald-500/40 transition hover:-translate-y-0.5 hover:bg-emerald-300"
        >
          Get Started
        </Link>
      </div>
    </header>
  );
}
