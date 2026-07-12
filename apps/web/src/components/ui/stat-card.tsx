import * as React from "react"
import { cva, type VariantProps } from "class-variance-authority"
import type { LucideIcon } from "lucide-react"

import { cn } from "@repo/utils"

const statCardVariants = cva(
  "flex items-center gap-4 rounded-2xl border p-5 transition hover:-translate-y-0.5 hover:shadow-sm",
  {
    variants: {
      tone: {
        primary: "border-border bg-card",
        success: "border-success/30 bg-success/5",
        destructive: "border-destructive/30 bg-destructive/5",
        muted: "border-border bg-muted/40",
      },
    },
    defaultVariants: { tone: "primary" },
  }
)

const iconChipVariants = cva("flex items-center justify-center rounded-xl p-3", {
  variants: {
    tone: {
      primary: "bg-primary/10 text-primary",
      success: "bg-success/10 text-success",
      destructive: "bg-destructive/10 text-destructive",
      muted: "bg-muted text-muted-foreground",
    },
  },
  defaultVariants: { tone: "primary" },
})

interface StatCardProps extends VariantProps<typeof statCardVariants> {
  icon: LucideIcon
  label: string
  value: React.ReactNode
  className?: string
}

export function StatCard({ icon: Icon, label, value, tone, className }: StatCardProps) {
  return (
    <div className={cn(statCardVariants({ tone }), className)}>
      <div className={iconChipVariants({ tone })}>
        <Icon className="h-6 w-6" />
      </div>
      <div>
        <div className="text-sm font-medium text-muted-foreground">{label}</div>
        <div className="text-2xl font-bold tracking-tight text-foreground">{value}</div>
      </div>
    </div>
  )
}
