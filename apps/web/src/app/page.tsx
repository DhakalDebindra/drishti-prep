/* eslint-disable @next/next/no-page-custom-font */
"use client";

import Link from "next/link";
import { Suspense, useEffect, useMemo, useState } from "react";
import { useRouter, useSearchParams } from "next/navigation";
import { PublicHeader } from "@/components/layout/PublicHeader";
import { cn } from "@repo/utils";
import { buttonVariants } from "@/components/ui/button-variants";

type ContrastMode = "normal" | "high-contrast";

const content = {
  headline: "Study independently. Compete equally.",
  subheadline:
    "The premier accessibility hub for blind and low-vision aspirants in Nepal. Get structured, screen-reader-first preparation for TSC, PSC, and Teaching Licenses, with an intensive focus on the General Knowledge (GK) components that define success.",
  trust: "Content created with blind educators, for blind learners.",
  pricing: "Free demo available — no account needed. NGO partnerships available for sponsored access.",
  impact: "Helping more visually impaired candidates enter government service.",
  why: "Prep Without Barriers. Why should blind candidates have to piece together their education? While mainstream platforms ignore accessibility, DrishtiPrep is built from the ground up for screen readers. We move beyond passive audio recordings and unstructured study materials to provide a structured, interactive learning experience that respects your time and your goals.",
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
      description: "Curriculum-aligned modules, daily drills, and model questions with AI feedback.",
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

const impact = "Helping more visually impaired candidates enter government service.";
const pricing = "NGO partnerships available for sponsored access.";

import { useTheme } from "next-themes";

function HomeContent() {
  const { resolvedTheme } = useTheme();
  const isDark = resolvedTheme === "dark";
  const router = useRouter();
  const searchParams = useSearchParams();

  useEffect(() => {
    const code = searchParams.get("code");
    if (code) {
      // If we have a code on the homepage, it's likely a password reset or email confirmation
      // that was redirected here due to Supabase config. Send it to the callback handler.
      router.push(`/auth/callback?code=${code}&next=/update-password`);
    }
  }, [searchParams, router]);

  const themeClass = isDark ? "dark" : "";

  const containerClass = useMemo(
    () =>
      `min-h-screen bg-background text-foreground ${themeClass}`,
    [isDark]
  );

  const palette = useMemo(() => {
    return {
      panel: "border-border bg-card shadow-sm",
      panelStrong: "border-border bg-muted shadow-inner",
      labelTone: "text-primary",
      subText: "text-muted-foreground",
      mutedText: "text-muted-foreground",
      headingText: "text-foreground",
      buttonBorder: "border-border text-foreground",
    };
  }, [isDark]);

  return (
    <div className={containerClass}>
      <div className="mx-auto flex max-w-[var(--dp-shell-width)] flex-col px-6 pb-20 pt-10 lg:px-10">
        <PublicHeader />

        <main id="main" className="mt-14 space-y-16">
          <section className={`grid gap-10 rounded-3xl p-8 shadow-2xl shadow-primary/10 backdrop-blur lg:grid-cols-[1.1fr_0.9fr] lg:p-12 ${palette.panel}`}>
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
                    className="rounded-full border border-primary/30 bg-primary/10 px-3 py-1 text-sm font-medium text-foreground"
                  >
                    {exam}
                  </span>
                ))}
              </div>
              <p className="text-sm font-semibold text-foreground">{content.trust}</p>
              <div className="flex flex-col gap-3 sm:flex-row">
                <Link
                  href="/signup"
                  className={cn(
                    buttonVariants({ size: "lg" }),
                    "rounded-full px-6 text-base font-semibold shadow-lg"
                  )}
                >
                  Join DrishtiPrep
                </Link>
                <Link
                  href="/login"
                  className={cn(
                    buttonVariants({ variant: "outline", size: "lg" }),
                    "rounded-full px-6 text-base font-semibold"
                  )}
                >
                  Login
                </Link>
              </div>
              <p className={`text-sm ${palette.subText}`}>{content.pricing}</p>
            </div>

            <div className={`flex flex-col gap-4 rounded-2xl p-6 shadow-inner shadow-black/10 ${palette.panelStrong}`}>
              <h2 className="text-lg font-semibold text-foreground">Everything in one accessible workspace</h2>
              <div className="grid grid-cols-1 gap-3 sm:grid-cols-2">
                {content.features.slice(0, 4).map((feature) => (
                  <div
                    key={feature.title}
                    className={`rounded-xl border p-4 text-left transition hover:border-primary/40 ${palette.panel}`}
                  >
                    <p className={`text-sm font-semibold ${palette.headingText}`}>{feature.title}</p>
                    <p className={`mt-1 text-sm ${palette.subText}`}>{feature.description}</p>
                  </div>
                ))}
              </div>
              <div className="rounded-xl border border-dashed border-primary/30 bg-primary/5 p-4 text-sm text-foreground">
                AI feedback after every set. Built to work with screen readers—no extra setup required.
              </div>
            </div>
          </section>

          <section id="features" className={`space-y-6 rounded-3xl p-8 shadow-xl shadow-primary/10 backdrop-blur lg:p-12 ${palette.panel}`}>
            <div className="flex items-center justify-between gap-4">
              <h2 className={`text-2xl font-semibold ${palette.headingText}`}>What you get</h2>
              <span className={`text-xs uppercase tracking-[0.3em] ${palette.labelTone}`}>Features</span>
            </div>
            <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
              {content.features.map((feature) => (
                <article
                  key={feature.title}
                  className={`h-full rounded-2xl border p-5 transition hover:border-primary/40 focus-within:border-primary/40 ${palette.panelStrong}`}
                >
                  <h3 className={`text-lg font-semibold ${palette.headingText}`}>{feature.title}</h3>
                  <p className={`mt-2 text-sm leading-relaxed ${palette.subText}`}>{feature.description}</p>
                </article>
              ))}
            </div>
          </section>

          <section id="about" className={`grid gap-8 rounded-3xl p-8 shadow-xl shadow-primary/10 backdrop-blur lg:grid-cols-[1.2fr_0.8fr] lg:p-12 ${palette.panel}`}>
            <div className="space-y-3">
              <h2 className={`text-2xl font-semibold ${palette.headingText}`}>Why we exist</h2>
              <p className={`text-base leading-relaxed ${palette.subText}`}>{content.why}</p>
            </div>
            <div className="rounded-2xl border border-dashed border-primary/30 bg-primary/5 p-6">
              <p className="text-sm font-semibold uppercase tracking-[0.2em] text-primary">Built with the community</p>
              <p className="mt-2 text-sm leading-relaxed text-foreground">
                Curriculum and feedback are co-created with blind educators so every flow is keyboard-first, screen-reader-ready, and exam-aligned.
              </p>
            </div>
          </section>

          <section className="flex flex-col gap-4 rounded-3xl border-2 border-primary/30 bg-primary/10 p-8 shadow-xl shadow-primary/10 backdrop-blur lg:flex-row lg:items-center lg:justify-between lg:p-12">
            <div className="space-y-2">
              <h2 className="text-xl font-semibold text-foreground">Access for individuals and partners</h2>
              <p className={`text-base ${palette.subText}`}>{content.pricing}</p>
            </div>
            <div className="flex flex-col gap-3 sm:flex-row">
              <Link
                href="/signup"
                className={cn(
                  buttonVariants({ size: "lg" }),
                  "rounded-full px-6 text-base font-semibold shadow-md"
                )}
              >
                Join Now
              </Link>
              <Link
                href="/signup"
                className={cn(
                  buttonVariants({ variant: "outline", size: "lg" }),
                  "rounded-full px-6 text-base font-semibold"
                )}
              >
                See partnership options
              </Link>
            </div>
          </section>

          <section className={`rounded-3xl border p-8 text-center shadow-xl shadow-primary/10 backdrop-blur lg:p-12 ${palette.panelStrong}`}>
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

export default function Home() {
  return (
    <Suspense fallback={null}>
      <HomeContent />
    </Suspense>
  );
}
