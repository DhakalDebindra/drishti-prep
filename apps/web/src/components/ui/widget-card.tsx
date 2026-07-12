import * as React from "react"
import Link from "next/link"

import { cn } from "@repo/utils"

interface WidgetCardAction {
  label: string
  href: string
}

interface WidgetCardProps {
  title: string
  subtitle?: string
  action?: WidgetCardAction
  actionSlot?: React.ReactNode
  className?: string
  contentClassName?: string
  children: React.ReactNode
}

export function WidgetCard({
  title,
  subtitle,
  action,
  actionSlot,
  className,
  contentClassName,
  children,
}: WidgetCardProps) {
  const headingId = React.useId()

  return (
    <section
      aria-labelledby={headingId}
      className={cn("overflow-hidden rounded-3xl border border-border bg-card shadow-sm", className)}
    >
      <div className="flex items-start justify-between gap-4 border-b border-border px-5 py-4 sm:px-6">
        <div>
          <h2 id={headingId} className="text-xs font-semibold uppercase tracking-[0.24em] text-muted-foreground">
            {title}
          </h2>
          {subtitle && <p className="mt-1 text-sm text-muted-foreground">{subtitle}</p>}
        </div>
        {action ? (
          <Link
            href={action.href}
            className="shrink-0 text-sm font-medium text-primary hover:underline"
          >
            {action.label}
          </Link>
        ) : (
          actionSlot
        )}
      </div>
      <div className={cn("px-5 py-4 sm:px-6", contentClassName)}>{children}</div>
    </section>
  )
}
