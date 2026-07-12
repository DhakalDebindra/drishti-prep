import Link from "next/link";
import { ArrowRight, GraduationCap } from "lucide-react";

import { cn } from "@repo/utils";
import { Badge } from "@/components/ui/badge";
import { buttonVariants } from "@/components/ui/button-variants";
import { Lang } from "@/components/ui/Lang";
import { SeeMoreText } from "@/components/ui/SeeMoreText";

interface CourseCardProps {
  href: string;
  name: string;
  description?: string | null;
  badgeLabel: string;
  badgeTone?: "primary" | "success" | "muted" | "destructive";
  ctaLabel: string;
  /** "default" = accent-filled (the action that needs a decision, e.g. Enroll);
   *  "outline" = de-emphasized (access you already have, e.g. Access Course). */
  ctaVariant?: "default" | "outline";
  className?: string;
}

export function CourseCard({
  href,
  name,
  description,
  badgeLabel,
  badgeTone = "muted",
  ctaLabel,
  ctaVariant = "outline",
  className,
}: CourseCardProps) {
  return (
    <Link
      href={href}
      className={cn(
        "group flex flex-col rounded-2xl border-2 border-border bg-card p-5 transition hover:-translate-y-0.5 hover:border-primary/40 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring",
        className
      )}
    >
      <div className="flex items-start justify-between gap-3">
        <div className="flex h-12 w-12 shrink-0 items-center justify-center rounded-xl bg-primary/15 text-primary">
          <GraduationCap className="h-6 w-6" aria-hidden="true" />
        </div>
        <Badge tone={badgeTone}>{badgeLabel}</Badge>
      </div>

      <h3 className="mt-3 text-lg font-semibold text-foreground line-clamp-2 transition-colors group-hover:text-primary">
        <Lang>{name}</Lang>
      </h3>

      <p className="mt-2 flex-grow text-sm leading-relaxed text-muted-foreground">
        {description ? (
          <SeeMoreText text={description} maxLength={120} />
        ) : (
          "Explore subjects and topics within this module."
        )}
      </p>

      <div
        className={cn(
          buttonVariants({ variant: ctaVariant, size: "default" }),
          "mt-4 w-full"
        )}
      >
        {ctaLabel}
        <ArrowRight className="h-4 w-4 transition-transform group-hover:translate-x-1" aria-hidden="true" />
      </div>
    </Link>
  );
}
