import Link from "next/link";
import type { ReactNode } from "react";
import { ChevronRight } from "lucide-react";

export type Crumb = { label: ReactNode; href?: string };

/**
 * Consistent breadcrumb trail for course-content pages. The last item is the
 * current page (not a link, marked aria-current). Every ancestor is a link, so
 * a learner can step back up the hierarchy from anywhere in the content tree.
 * Labels are ReactNodes so callers wrap Nepali names in <Lang> and leave
 * English chrome ("Courses") plain.
 */
export function Breadcrumbs({ items }: { items: Crumb[] }) {
  return (
    <nav aria-label="Breadcrumb">
      <ol className="flex flex-wrap items-center gap-y-1 text-sm">
        {items.map((item, index) => {
          const isLast = index === items.length - 1;
          return (
            <li key={index} className="flex items-center">
              {index > 0 && (
                <ChevronRight
                  className="mx-0.5 h-4 w-4 shrink-0 text-muted-foreground/60"
                  aria-hidden="true"
                />
              )}
              {item.href && !isLast ? (
                <Link
                  href={item.href}
                  className="rounded px-1.5 py-0.5 font-medium text-muted-foreground transition-colors hover:text-primary focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring"
                >
                  {item.label}
                </Link>
              ) : (
                <span
                  className={
                    isLast
                      ? "px-1.5 py-0.5 font-semibold text-foreground"
                      : "px-1.5 py-0.5 text-muted-foreground"
                  }
                  aria-current={isLast ? "page" : undefined}
                >
                  {item.label}
                </span>
              )}
            </li>
          );
        })}
      </ol>
    </nav>
  );
}
