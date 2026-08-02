import { Suspense } from "react";
import Link from "next/link";
import {
  ArrowRight,
  BarChart3,
  BookOpen,
  Bookmark,
  Contrast,
  GraduationCap,
  Keyboard,
  Languages,
  Layers,
  ListChecks,
  ScreenShare,
  Sparkles,
  Type,
  Zap,
} from "lucide-react";

import { cn } from "@repo/utils";
import { createStaticClient } from "@/lib/supabase/server";
import { buttonVariants } from "@/components/ui/button-variants";
import { Badge } from "@/components/ui/badge";
import { AuthCodeHandler } from "@/components/layout/AuthCodeHandler";
import { PublicHeader } from "@/components/layout/PublicHeader";
import { PublicFooter } from "@/components/layout/PublicFooter";
import { LandingSection } from "@/components/landing/LandingSection";
import { FeatureCard } from "@/components/landing/FeatureCard";

export const revalidate = 3600;

const HEADLINE = "Study independently. Compete equally.";

const SUBHEADLINE =
  "Exam preparation for blind and low-vision candidates in Nepal, covering the Teaching License, TSC, and Public Service papers. General Knowledge carries most of the marks, so it carries most of our material.";

// Exam names only. "GK Mastery" used to sit in this list, but the list is
// labelled "Examinations covered" and GK is a subject inside these papers,
// not an exam a candidate sits.
const EXAMS = ["Teaching License", "TSC (Teacher Service)", "PSC (Public Service)"];

/**
 * The core offering. Deliberately limited to the primary learning surface:
 * notes, flashcards, MCQ practice and progress. Exploratory audio work
 * (voice tutor, dictation, weekly audio review) is intentionally NOT
 * advertised here: it stays unlisted until those features are confirmed to
 * ship, so the landing page never promises something still being decided.
 */
const FEATURES = [
  {
    icon: BookOpen,
    title: "Structured notes",
    description:
      "Topic-wise notes you can read straight through with a screen reader, arranged in the order the syllabus teaches them rather than scattered across files.",
  },
  {
    icon: Zap,
    title: "Flashcards",
    description:
      "Short decks for the facts that keep reappearing in past papers. Built for quick repeat passes rather than long sittings.",
  },
  {
    icon: ListChecks,
    title: "MCQ practice",
    description:
      "Practice sets and model questions that follow the official syllabus. Every question carries a written explanation of the answer.",
  },
  {
    icon: Layers,
    title: "Practice that follows the syllabus",
    description:
      "Courses open into subjects, then topics, then sets. Breadcrumbs on every page let you step back up a level without losing your place.",
  },
  {
    icon: Sparkles,
    title: "AI feedback after every set",
    description:
      "Submit a set and you get a written review of what you missed and which topics are worth going back to.",
  },
  {
    icon: BarChart3,
    title: "Progress tracking",
    description:
      "Your scores and weak areas over time. Past attempts stay available, so you can reopen a set you have already done and read its explanations again.",
  },
  {
    icon: Bookmark,
    title: "Bookmarks",
    description:
      "Save a question mid-set and come back to it later. You do not have to stop and note it down somewhere else.",
  },
  {
    icon: GraduationCap,
    title: "Exam coverage",
    description:
      "Material for the Teaching License, TSC, and Public Service papers, weighted towards the General Knowledge sections that carry the most marks.",
  },
] as const;

const ACCESSIBILITY_POINTS = [
  {
    icon: ScreenShare,
    title: "Built for screen readers",
    description:
      "Proper headings, labelled landmarks, live regions that announce state changes, and a working skip link on every page. Tested with NVDA, JAWS, Narrator, VoiceOver, and TalkBack.",
  },
  {
    icon: Keyboard,
    title: "Everything on the keyboard",
    description:
      "Practice and navigation both run from the keyboard, and you can open the shortcut list at any time. The whole site is usable without a mouse.",
  },
  {
    icon: Type,
    title: "Six display controls",
    description:
      "Font size, contrast, line spacing, motion, layout density, and focus-ring strength. You can change them from any page. They save on your device and follow your profile once you sign in.",
  },
  {
    icon: Contrast,
    title: "High-contrast mode",
    description:
      "A separate palette rather than a filter laid over the light theme, with solid backgrounds, heavy borders, and large touch targets for low residual vision.",
  },
  {
    icon: Languages,
    title: "Nepali that reads correctly",
    description:
      "Nepali text is tagged with its language so screen readers switch pronunciation. Devanagari numerals also carry a spoken equivalent, which Android screen readers otherwise skip over.",
  },
  {
    icon: GraduationCap,
    title: "Built with blind educators",
    description:
      "Blind teachers and candidates help decide what goes into the curriculum and how the interface behaves before it ships.",
  },
] as const;

const STEPS = [
  {
    title: "Create your account",
    description:
      "Sign up with an email address. If you are applying for sponsored access, upload your disability documentation from the Identity page once you are signed in.",
  },
  {
    title: "Pick a course",
    description:
      "Open a course and work down to a subject, a topic, and a set. Your dashboard also takes you straight back to wherever you stopped last time.",
  },
  {
    title: "Practise and review",
    description:
      "Answer from the keyboard, then read the feedback on what you missed. Your scores and weak areas build up across attempts.",
  },
] as const;

/** Shown if the course query fails, so the section is never empty or wrong. */
const COURSE_FALLBACK = [
  {
    id: "fallback-gk",
    name: "Everything GK",
    description:
      "General Knowledge for Nepal's competitive examinations, from Nepali history and geography to governance, science, and current affairs.",
    price_paisa: 0,
  },
  {
    id: "fallback-nimavi",
    name: "TSC Nimavi First Paper",
    description:
      "Topic-wise preparation for the Teacher Service Commission's lower-secondary first paper, following the official syllabus.",
    price_paisa: 0,
  },
];

type CourseRow = {
  id: string;
  name: string;
  description: string | null;
  price_paisa: number | null;
};

/**
 * Course descriptions in the database run to full catalogue copy, several
 * hundred words for some courses. Rendered raw they blow the card out to many
 * times the height of its neighbour. Trim to a sentence-length summary at a
 * word boundary; the full text still lives on the course page itself.
 */
function summarise(text: string | null, max = 180): string {
  if (!text) return "Explore the subjects and topics inside this course.";
  const clean = text.replace(/\s+/g, " ").trim();
  if (clean.length <= max) return clean;
  const cut = clean.slice(0, max);
  const lastSpace = cut.lastIndexOf(" ");
  return `${cut.slice(0, lastSpace > 0 ? lastSpace : max).replace(/[,;:.\-–—]$/, "")}…`;
}

async function getCourses(): Promise<CourseRow[]> {
  try {
    // Cookie-free anon client on purpose: the course list is public data
    // (modules has a "Public read" RLS policy), and reading cookies here would
    // opt the whole landing page out of static rendering.
    const supabase = createStaticClient();
    const { data, error } = await (supabase as any)
      .from("modules")
      .select("id, name, description, price_paisa")
      .eq("is_active", true)
      .order("display_order", { ascending: true });

    if (error || !data || data.length === 0) return COURSE_FALLBACK;
    return data as CourseRow[];
  } catch {
    // The marketing page must render even if the database is unreachable.
    return COURSE_FALLBACK;
  }
}

export default async function Home() {
  const courses = await getCourses();

  return (
    <div className="min-h-screen bg-background text-foreground">
      <Suspense fallback={null}>
        <AuthCodeHandler />
      </Suspense>

      <div className="mx-auto flex max-w-[var(--dp-shell-width)] flex-col px-4 pb-16 pt-6 sm:px-6 lg:px-10">
        <PublicHeader />

        <main id="main" className="mt-10 space-y-10 sm:mt-14 sm:space-y-14">
          {/* ── Hero ─────────────────────────────────────────────────── */}
          <section
            aria-labelledby="hero-heading"
            className="grid gap-10 rounded-3xl border-2 border-primary/30 bg-card p-6 shadow-sm sm:p-8 lg:grid-cols-[1.1fr_0.9fr] lg:p-12"
          >
            <div className="space-y-6">
              <p className="text-xs font-semibold uppercase tracking-[0.24em] text-primary">
                Accessibility-first exam prep · Nepal
              </p>
              <h1
                id="hero-heading"
                className="text-4xl font-bold leading-tight tracking-tight text-foreground sm:text-5xl"
              >
                {HEADLINE}
              </h1>
              <p className="text-lg leading-relaxed text-muted-foreground">{SUBHEADLINE}</p>

              <ul id="exams" aria-label="Examinations covered" className="flex flex-wrap gap-2">
                {EXAMS.map((exam) => (
                  <li
                    key={exam}
                    className="rounded-full border-2 border-primary/30 bg-primary/10 px-3 py-1 text-sm font-semibold text-foreground"
                  >
                    {exam}
                  </li>
                ))}
              </ul>

              <p className="text-base font-semibold text-foreground">
                Content created with blind educators, for blind learners.
              </p>

              <div className="flex flex-col gap-3 sm:flex-row">
                <Link
                  href="/signup"
                  className={cn(buttonVariants({ size: "lg" }), "text-base font-semibold")}
                >
                  Create free account
                  <ArrowRight className="h-5 w-5" aria-hidden="true" />
                </Link>
                <Link
                  href="/login"
                  className={cn(
                    buttonVariants({ variant: "outline", size: "lg" }),
                    "text-base font-semibold"
                  )}
                >
                  Log in
                </Link>
              </div>
            </div>

            <div className="flex flex-col gap-4 rounded-2xl border-2 border-border bg-muted p-5 sm:p-6">
              <h2 className="text-lg font-bold text-foreground">What you get</h2>
              <ul className="space-y-3">
                {[
                  {
                    icon: Layers,
                    text: "Practice sets that follow the syllabus, each with written explanations",
                  },
                  {
                    icon: BookOpen,
                    text: "Topic-wise notes and flashcards for revision",
                  },
                  {
                    icon: Sparkles,
                    text: "Feedback on what you missed as soon as you submit",
                  },
                  {
                    icon: BarChart3,
                    text: "Progress tracking that shows where you are still weak",
                  },
                ].map((item) => (
                  <li
                    key={item.text}
                    className="flex items-start gap-3 rounded-xl border-2 border-border bg-card p-4"
                  >
                    <span
                      aria-hidden="true"
                      className="flex h-9 w-9 shrink-0 items-center justify-center rounded-lg bg-primary/15 text-primary"
                    >
                      <item.icon className="h-5 w-5" />
                    </span>
                    <span className="text-sm font-medium leading-relaxed text-foreground">
                      {item.text}
                    </span>
                  </li>
                ))}
              </ul>
              <p className="rounded-xl border-2 border-dashed border-primary/40 bg-primary/5 p-4 text-sm font-medium text-foreground">
                Works with the screen reader you already use. There is no plugin to install and no
                separate accessible version to switch to.
              </p>
            </div>
          </section>

          {/* ── Courses ──────────────────────────────────────────────── */}
          <LandingSection
            id="courses"
            eyebrow="Courses"
            heading="What you can study today"
            description="Each course opens into its own syllabus tree of subjects, topics, and practice sets. New courses and sets are added regularly."
          >
            <div className="grid gap-4 md:grid-cols-2">
              {courses.map((course) => (
                <article
                  key={course.id}
                  className="flex h-full flex-col rounded-2xl border-2 border-border bg-background p-5"
                >
                  <div className="flex items-start justify-between gap-3">
                    <span
                      aria-hidden="true"
                      className="flex h-12 w-12 shrink-0 items-center justify-center rounded-xl bg-primary/15 text-primary"
                    >
                      <GraduationCap className="h-6 w-6" />
                    </span>
                    <Badge tone={course.price_paisa ? "primary" : "success"}>
                      {course.price_paisa ? "Enrolment required" : "Open access"}
                    </Badge>
                  </div>
                  <h3 className="mt-4 text-lg font-semibold text-foreground">{course.name}</h3>
                  <p className="mt-2 flex-grow text-sm leading-relaxed text-muted-foreground">
                    {summarise(course.description)}
                  </p>
                  {/* Course content sits behind auth, so a public visitor is sent
                      to signup rather than bounced through /login. The aria-label
                      keeps each otherwise-identical CTA distinguishable in a
                      screen reader's link list. */}
                  <Link
                    href="/signup"
                    aria-label={`Sign up to open ${course.name}`}
                    className={cn(buttonVariants({ variant: "outline" }), "mt-4 w-full font-semibold")}
                  >
                    Sign up to open
                    <ArrowRight className="h-4 w-4" aria-hidden="true" />
                  </Link>
                </article>
              ))}
            </div>
          </LandingSection>

          {/* ── Features ─────────────────────────────────────────────── */}
          <LandingSection
            id="features"
            eyebrow="Features"
            heading="What you get"
            description="Most platforms leave blind candidates stitching preparation together from scattered recordings and PDFs a screen reader cannot read. These are the tools that replace that."
          >
            <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
              {FEATURES.map((feature) => (
                <FeatureCard
                  key={feature.title}
                  icon={feature.icon}
                  title={feature.title}
                  description={feature.description}
                />
              ))}
            </div>
          </LandingSection>

          {/* ── How it works ─────────────────────────────────────────── */}
          <LandingSection
            id="how-it-works"
            eyebrow="Getting started"
            heading="How it works"
            description="Three steps from signing up to your first reviewed practice set."
          >
            <ol className="grid gap-4 md:grid-cols-3">
              {STEPS.map((step, index) => (
                <li
                  key={step.title}
                  className="flex h-full flex-col rounded-2xl border-2 border-border bg-background p-5"
                >
                  <span className="flex h-10 w-10 items-center justify-center rounded-xl bg-primary text-base font-bold text-primary-foreground">
                    <span aria-hidden="true">{index + 1}</span>
                    <span className="sr-only">Step {index + 1}</span>
                  </span>
                  <h3 className="mt-4 text-lg font-semibold text-foreground">{step.title}</h3>
                  <p className="mt-2 text-sm leading-relaxed text-muted-foreground">
                    {step.description}
                  </p>
                </li>
              ))}
            </ol>
          </LandingSection>

          {/* ── Accessibility ────────────────────────────────────────── */}
          <LandingSection
            id="accessibility"
            eyebrow="Accessibility"
            heading="Prep without barriers"
            description="All of this is in the product today. You can try it before making an account: the Accessibility button in the header opens the same controls a signed-in learner gets."
          >
            <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
              {ACCESSIBILITY_POINTS.map((point) => (
                <FeatureCard
                  key={point.title}
                  icon={point.icon}
                  title={point.title}
                  description={point.description}
                />
              ))}
            </div>
          </LandingSection>

          {/* ── About ────────────────────────────────────────────────── */}
          <LandingSection
            id="about"
            eyebrow="About"
            heading="Why we exist"
            description="Blind candidates in Nepal usually prepare from whatever they can get hold of: borrowed recordings, scanned notes, a friend reading questions aloud. It works, but it is slow, and it leaves people sitting the same exam with less preparation than everyone else. DrishtiPrep exists so the same syllabus is available in a form a screen reader can actually work through."
          >
            <div className="grid gap-4 md:grid-cols-2">
              <div className="rounded-2xl border-2 border-dashed border-primary/40 bg-primary/5 p-6">
                <h3 className="text-base font-bold text-foreground">Built with the community</h3>
                <p className="mt-2 text-sm leading-relaxed text-foreground">
                  Blind educators write and review the material, and test the interface before it
                  ships. That is why it works with a keyboard and a screen reader from the start
                  instead of being retrofitted afterwards.
                </p>
              </div>
              <div className="rounded-2xl border-2 border-border bg-background p-6">
                <h3 className="text-base font-bold text-foreground">Our goal</h3>
                <p className="mt-2 text-sm leading-relaxed text-muted-foreground">
                  More visually impaired candidates passing the Teaching License, TSC, and PSC
                  examinations through focused General Knowledge preparation, and going on into
                  government service across Nepal.
                </p>
              </div>
            </div>
          </LandingSection>

          {/* ── Access & partnerships ────────────────────────────────── */}
          <section
            id="partnerships"
            aria-labelledby="partnerships-heading"
            className="scroll-mt-6 rounded-3xl border-2 border-primary/30 bg-primary/10 p-6 shadow-sm sm:p-8 lg:p-12"
          >
            <div className="flex flex-col gap-6 lg:flex-row lg:items-center lg:justify-between">
              <div className="max-w-2xl space-y-3">
                {/* text-foreground, not text-primary like the other section
                    eyebrows: this band sits on a bg-primary/10 tint, where the
                    primary accent only reaches 4.29:1. The other eyebrows sit
                    on bg-card and pass at 5.09:1. */}
                <p className="text-xs font-semibold uppercase tracking-[0.24em] text-foreground">
                  Access
                </p>
                <h2
                  id="partnerships-heading"
                  className="text-2xl font-bold tracking-tight text-foreground sm:text-3xl"
                >
                  Access for individuals and partners
                </h2>
                <p className="text-base leading-relaxed text-foreground">
                  Anyone can create an account and start straight away. For candidates who cannot
                  pay for the premium modules, we work with NGOs, disability organisations, and
                  training institutes to sponsor access. Once you have an account, upload your
                  documentation from the Identity page and we will verify it.
                </p>
              </div>
              {/* One button, not two. This section previously offered a second
                  "Partnership options" button that also pointed at /signup,
                  which promised a page that does not exist. Sponsorship starts
                  from the profile, so signup is the only real next step. */}
              <div className="shrink-0">
                <Link
                  href="/signup"
                  className={cn(buttonVariants({ size: "lg" }), "text-base font-semibold")}
                >
                  Create free account
                </Link>
              </div>
            </div>
          </section>
        </main>

        <PublicFooter />
      </div>
    </div>
  );
}
