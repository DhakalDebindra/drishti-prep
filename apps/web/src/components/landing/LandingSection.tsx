import type { ReactNode } from "react";

import { cn } from "@repo/utils";

interface LandingSectionProps {
  id: string;
  /** Small uppercase label above the heading. */
  eyebrow: string;
  heading: string;
  description?: string;
  children: ReactNode;
  className?: string;
}

/**
 * A titled landing-page section. Every section is a labelled <section> with a
 * real <h2>, so a screen-reader user can jump between them with the heading
 * shortcut and always land on a meaningful title.
 */
export function LandingSection({
  id,
  eyebrow,
  heading,
  description,
  children,
  className,
}: LandingSectionProps) {
  const headingId = `${id}-heading`;

  return (
    <section
      id={id}
      aria-labelledby={headingId}
      className={cn(
        "scroll-mt-6 rounded-3xl border-2 border-border bg-card p-6 shadow-sm sm:p-8 lg:p-12",
        className
      )}
    >
      <div className="max-w-3xl space-y-3">
        <p className="text-xs font-semibold uppercase tracking-[0.24em] text-primary">{eyebrow}</p>
        <h2 id={headingId} className="text-2xl font-bold tracking-tight text-foreground sm:text-3xl">
          {heading}
        </h2>
        {description && (
          <p className="text-base leading-relaxed text-muted-foreground">{description}</p>
        )}
      </div>
      <div className="mt-8">{children}</div>
    </section>
  );
}
