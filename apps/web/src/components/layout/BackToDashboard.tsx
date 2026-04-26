"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { LayoutDashboard, ArrowLeft } from "lucide-react";
import { cn } from "@repo/utils";

export function BackToDashboard() {
  const pathname = usePathname();
  
  // Don't show on the dashboard itself
  if (pathname === "/dashboard") return null;

  return (
    <div className="mx-auto max-w-5xl px-4 py-12 border-t border-slate-200 dark:border-slate-800 mt-12">
      <Link
        href="/dashboard"
        className={cn(
          "inline-flex items-center gap-2 px-4 py-2 rounded-lg transition-all",
          "text-slate-600 hover:text-indigo-600 hover:bg-indigo-50",
          "dark:text-slate-400 dark:hover:text-indigo-400 dark:hover:bg-indigo-900/20"
        )}
      >
        <ArrowLeft className="w-4 h-4" />
        <LayoutDashboard className="w-4 h-4" />
        <span className="font-medium">Back to Dashboard</span>
      </Link>
    </div>
  );
}
