/* eslint-disable @next/next/no-page-custom-font */
"use client";

import Link from "next/link";
import { useEffect, useMemo, useState } from "react";

type ContrastMode = "normal" | "high-contrast";

const content = {
  headline: "Study independently. Compete equally.",
  subheadline:
    "The premier accessibility hub for blind and low-vision aspirants in Nepal. Get structured, screen-reader-first preparation for TSC, PSC, and Teaching Licenses, with an intensive focus on the General Knowledge (GK) components that define success.",
  trust: "Content created with blind educators, for blind learners.",
  pricing: "Free demo available — no account needed. NGO partnerships available for sponsored access.",
  impact: "Helping more visually impaired candidates enter government service.",
  why: "Prep Without Barriers. Why should blind candidates have to piece together their education? While mainstream platforms ignore accessibility, Dristiprep is built from the ground up for screen readers. We move beyond passive audio recordings and unstructured study materials to provide a structured, interactive learning experience that respects your time and your goals.",
  features: [
    {
      title: "Structured notes",
      description: "Screen-reader-friendly topic-wise notes and study material.",
    },
    {
      title: "Flashcards",
      description: "Quick revision decks for high-yield facts.",
    },
    {
      title: "MCQ practice",
      description: "Topicwise sets, daily drills, and model questions with AI feedback.",
    },
    {
      title: "Progress tracking",
      description: "Scores, weak areas, and improvement over time.",
    },
    {
      title: "Exam coverage",
      description: "Comprehensive TSC, PSC, and Teaching License prep with a focus on GK.",
    },
  ],
  exams: ["Teaching License", "TSC Preparation", "PSC (Public Service)", "GK Mastery"],
};

const navLinks = [
  { href: "/practice", label: "Practice (topicwise sets)" },
  { href: "/dashboard", label: "Progress" },
  { href: "/bookmarks", label: "Bookmarks" },
  { href: "#about", label: "About" },
];

export default function Home() {
  const [contrast, setContrast] = useState<ContrastMode>(() => {
    if (typeof document !== "undefined") {
      return document.documentElement.classList.contains("hc") ? "high-contrast" : "normal";
    }
    return "normal";
  });
  const [isDark, setIsDark] = useState<boolean>(false);

  useEffect(() => {
    if (typeof window === "undefined") return;
    const storedContrast = localStorage.getItem("dristiprep-contrast");
    if (storedContrast === "high-contrast" || storedContrast === "normal") {
      setContrast(storedContrast);
    } else {
      const prefersMore = window.matchMedia?.("(prefers-contrast: more)")?.matches;
      if (prefersMore) setContrast("high-contrast");
    }
    const mq = window.matchMedia?.("(prefers-color-scheme: dark)");
    const updateDark = () => setIsDark(Boolean(mq?.matches || document.documentElement.classList.contains("dark")));
    updateDark();
    mq?.addEventListener("change", updateDark);
    const contrastMq = window.matchMedia?.("(prefers-contrast: more)");
    const handleContrast = () => {
      if (!localStorage.getItem("dristiprep-contrast") && contrastMq?.matches) {
        setContrast("high-contrast");
      }
    };
    contrastMq?.addEventListener("change", handleContrast);
    return () => {
      mq?.removeEventListener("change", updateDark);
      contrastMq?.removeEventListener("change", handleContrast);
    };
  }, []);

  useEffect(() => {
    if (typeof document === "undefined") return;
    const root = document.documentElement;
    root.classList.toggle("hc", contrast === "high-contrast");
    localStorage.setItem("dristiprep-contrast", contrast);
  }, [contrast]);

  const containerClass = useMemo(
    () =>
      contrast === "high-contrast"
        ? "min-h-screen bg-black text-white"
        : isDark
          ? "min-h-screen bg-gradient-to-br from-slate-950 via-slate-900 to-slate-950 text-slate-50"
          : "min-h-screen bg-gradient-to-br from-slate-50 via-white to-slate-100 text-slate-900",
    [contrast, isDark],
  );

  const palette = useMemo(() => {
    if (contrast === "high-contrast") {
      return {
        panel: "border-white bg-black",
        panelStrong: "border-white bg-black",
        labelTone: "text-yellow-200",
        subText: "text-white",
        mutedText: "text-gray-200",
        headingText: "text-white",
        navText: "text-white",
        buttonBorder: "border-white/80 text-white",
      };
    }
    if (isDark) {
      return {
        panel: "border-white/10 bg-white/5",
        panelStrong: "border-white/10 bg-slate-900/60",
        labelTone: "text-emerald-200",
        subText: "text-slate-200",
        mutedText: "text-slate-300",
        headingText: "text-white",
        navText: "text-slate-100",
        buttonBorder: "border-white/25 text-slate-50",
      };
    }
    return {
      panel: "border-slate-200 bg-white",
      panelStrong: "border-slate-200 bg-white",
      labelTone: "text-emerald-700",
      subText: "text-slate-700",
      mutedText: "text-slate-600",
      headingText: "text-slate-900",
      navText: "text-slate-900",
      buttonBorder: "border-slate-300 text-slate-900",
    };
  }, [contrast, isDark]);

  return (
    <div className={containerClass}>
      <a
        href="#main"
        className="sr-only focus:not-sr-only focus:fixed focus:left-4 focus:top-4 focus:z-50 focus:rounded-lg focus:bg-slate-100 focus:px-3 focus:py-2 focus:text-slate-900"
      >
        Skip to main content
      </a>

      <div className="mx-auto flex max-w-6xl flex-col px-6 pb-20 pt-10 lg:px-10">
        <header className={`flex items-center justify-between rounded-2xl px-4 py-3 backdrop-blur ${palette.panel}`}>
            <div className="flex items-center gap-3">
              <div className="flex h-10 w-10 items-center justify-center rounded-xl bg-gradient-to-br from-emerald-400 to-cyan-300 text-slate-950 font-semibold shadow-lg shadow-emerald-500/30">
                DP
              </div>
              <div>
                <p className={`text-sm uppercase tracking-[0.2em] ${palette.labelTone}`}>Drishtiprep</p>
                <p className={`text-sm ${palette.subText}`}>Accessible exam prep</p>
              </div>
            </div>
          <nav aria-label="Main navigation" className={`hidden items-center gap-6 text-sm font-medium sm:flex ${palette.navText}`}>
            {navLinks.map((link) => (
              <Link
                key={link.href}
                href={link.href}
                className="rounded-md px-2 py-1 transition hover:text-emerald-200 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-4 focus-visible:outline-emerald-300"
              >
                {link.label}
              </Link>
            ))}
          </nav>
          <div className="flex items-center gap-3">
            <button
              type="button"
              aria-pressed={contrast === "high-contrast"}
              className={`rounded-full border px-4 py-2 text-sm font-semibold transition hover:border-emerald-200 hover:text-emerald-200 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-emerald-300 ${palette.buttonBorder}`}
              onClick={() =>
                setContrast((mode) => (mode === "high-contrast" ? "normal" : "high-contrast"))
              }
            >
              {contrast === "high-contrast" ? "High contrast on" : "High contrast off"}
            </button>
            <Link
              href="/login"
              className={`hidden rounded-full px-4 py-2 text-sm font-semibold transition hover:border-emerald-200 hover:text-emerald-200 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-emerald-300 sm:inline-flex ${palette.buttonBorder}`}
            >
              Login
            </Link>
            <Link
              href="/practice"
              className="rounded-full bg-emerald-400 px-4 py-2 text-sm font-semibold text-slate-950 shadow-lg shadow-emerald-500/40 transition hover:-translate-y-0.5 hover:bg-emerald-300 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-slate-900"
            >
              Try a Free Practice Set
            </Link>
          </div>
        </header>

        <main id="main" className="mt-14 space-y-16">
          <section className={`grid gap-10 rounded-3xl p-8 shadow-2xl shadow-emerald-600/15 backdrop-blur lg:grid-cols-[1.1fr_0.9fr] lg:p-12 ${palette.panel}`}>
            <div className="space-y-6">
              <p className={`text-xs uppercase tracking-[0.3em] ${palette.labelTone}`}>Hero</p>
              <h1 className={`text-4xl font-semibold leading-tight tracking-tight sm:text-5xl ${palette.headingText}`}>
                {content.headline}
              </h1>
              <p className={`text-lg leading-relaxed ${palette.subText}`}>{content.subheadline}</p>
              <div id="exams" className="flex flex-wrap gap-2">
                {content.exams.map((exam) => (
                  <span
                    key={exam}
                    className="rounded-full border border-emerald-200/50 bg-emerald-200/10 px-3 py-1 text-sm font-medium text-emerald-900 dark:text-emerald-100"
                    aria-label={`Exam: ${exam}`}
                  >
                    {exam}
                  </span>
                ))}
              </div>
              <p className="text-sm font-semibold text-emerald-800 dark:text-emerald-100">{content.trust}</p>
              <div className="flex flex-col gap-3 sm:flex-row">
                <Link
                  href="/practice"
                  className="flex h-12 items-center justify-center rounded-full bg-emerald-400 px-6 text-base font-semibold text-slate-950 shadow-lg shadow-emerald-500/40 transition hover:-translate-y-0.5 hover:bg-emerald-300 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-slate-900"
                >
                  Try a Free Practice Set
                </Link>
                <Link
                  href="/login"
                  className="flex h-12 items-center justify-center rounded-full border border-white/20 px-6 text-base font-semibold text-slate-50 transition hover:border-emerald-200 hover:text-emerald-200 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-emerald-300"
                >
                  Login
                </Link>
              </div>
              <p className={`text-sm ${palette.subText}`}>{content.pricing}</p>
            </div>

            <div className={`flex flex-col gap-4 rounded-2xl p-6 shadow-inner shadow-black/10 ${palette.panelStrong}`}>
              <h2 className="text-lg font-semibold text-emerald-800 dark:text-emerald-100">Everything in one accessible workspace</h2>
              <div className="grid grid-cols-1 gap-3 sm:grid-cols-2">
                {content.features.slice(0, 4).map((feature) => (
                  <div
                    key={feature.title}
                    className={`rounded-xl border p-4 text-left transition hover:border-emerald-200/60 ${palette.panel}`}
                  >
                    <p className={`text-sm font-semibold ${palette.headingText}`}>{feature.title}</p>
                    <p className={`mt-1 text-sm ${palette.subText}`}>{feature.description}</p>
                  </div>
                ))}
              </div>
              <div className="rounded-xl border border-dashed border-emerald-200/60 bg-emerald-200/5 p-4 text-sm text-emerald-900 dark:text-emerald-100">
                AI feedback after every set. Built to work with screen readers—no extra setup required.
              </div>
            </div>
          </section>

          <section id="features" className={`space-y-6 rounded-3xl p-8 shadow-xl shadow-emerald-600/15 backdrop-blur lg:p-12 ${palette.panel}`}>
            <div className="flex items-center justify-between gap-4">
              <h2 className={`text-2xl font-semibold ${palette.headingText}`}>What you get</h2>
              <span className={`text-xs uppercase tracking-[0.3em] ${palette.labelTone}`}>Features</span>
            </div>
            <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
              {content.features.map((feature) => (
                <article
                  key={feature.title}
                  className={`h-full rounded-2xl border p-5 transition hover:border-emerald-200/60 focus-within:border-emerald-200/60 ${palette.panelStrong}`}
                >
                  <h3 className={`text-lg font-semibold ${palette.headingText}`}>{feature.title}</h3>
                  <p className={`mt-2 text-sm leading-relaxed ${palette.subText}`}>{feature.description}</p>
                </article>
              ))}
            </div>
          </section>

          <section id="about" className={`grid gap-8 rounded-3xl p-8 shadow-xl shadow-emerald-600/15 backdrop-blur lg:grid-cols-[1.2fr_0.8fr] lg:p-12 ${palette.panel}`}>
            <div className="space-y-3">
              <h2 className={`text-2xl font-semibold ${palette.headingText}`}>Why we exist</h2>
              <p className={`text-base leading-relaxed ${palette.subText}`}>{content.why}</p>
            </div>
            <div className="rounded-2xl border border-dashed border-emerald-200/60 bg-emerald-200/5 p-6 text-emerald-100">
              <p className="text-sm font-semibold uppercase tracking-[0.2em]">Built with the community</p>
              <p className="mt-2 text-sm leading-relaxed text-emerald-900 dark:text-emerald-50">
                Curriculum and feedback are co-created with blind educators so every flow is keyboard-first, screen-reader-ready, and exam-aligned.
              </p>
            </div>
          </section>

          <section className={`flex flex-col gap-4 rounded-3xl border p-8 shadow-xl shadow-emerald-600/15 backdrop-blur lg:flex-row lg:items-center lg:justify-between lg:p-10 ${isDark ? "border-white/10 bg-gradient-to-r from-emerald-400/15 via-emerald-300/15 to-cyan-300/10 text-slate-50" : "border-emerald-100 bg-gradient-to-r from-emerald-100 via-emerald-50 to-cyan-50 text-slate-900"}`}>
            <div className="space-y-2">
              <h2 className="text-xl font-semibold">Access for individuals and partners</h2>
              <p className={`text-base ${palette.subText}`}>{content.pricing}</p>
            </div>
            <div className="flex gap-3">
              <Link
                href="/practice"
                className={`rounded-full px-5 py-3 text-sm font-semibold shadow-md transition hover:-translate-y-0.5 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 ${isDark ? "bg-slate-50 text-slate-950 hover:bg-white focus-visible:outline-slate-900" : "bg-slate-900 text-white hover:bg-slate-800 focus-visible:outline-slate-700"}`}
              >
                Start free demo
              </Link>
              <Link
                href="/signup"
                className={`rounded-full px-5 py-3 text-sm font-semibold transition focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 ${
                  isDark
                    ? "border border-white/60 text-white hover:border-white hover:text-white focus-visible:outline-white"
                    : "border border-slate-900 text-slate-900 hover:border-slate-700 hover:text-slate-700 focus-visible:outline-slate-800"
                }`}
              >
                See partnership options
              </Link>
            </div>
          </section>

          <section className={`rounded-3xl border p-8 text-center shadow-xl shadow-emerald-600/15 backdrop-blur ${palette.panelStrong}`}>
            <h2 className={`text-2xl font-semibold ${palette.headingText}`}>{content.impact}</h2>
            <p className={`mt-3 text-sm ${palette.mutedText}`}>
              Our goal: more blind candidates succeeding in Teaching License, TSC, and PSC exams through focused General Knowledge preparation—opening doors to government service across Nepal.
            </p>
          </section>
        </main>
      </div>
    </div>
  );
}
