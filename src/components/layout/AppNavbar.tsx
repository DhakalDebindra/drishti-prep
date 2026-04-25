"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { 
  LayoutDashboard, 
  GraduationCap, 
  Bookmark, 
  LogOut,
  User,
  Menu,
  X
} from "lucide-react";
import { useState } from "react";
import { cn } from "@/lib/utils";
import { Button } from "@/components/ui/button";
import { signOutAction } from "@/app/actions/auth";

interface AppNavbarProps {
  userEmail?: string | null;
}

export function AppNavbar({ userEmail }: AppNavbarProps) {
  const pathname = usePathname();
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);

  const navLinks = [
    { href: "/dashboard", label: "Dashboard", icon: LayoutDashboard },
    { href: "/courses", label: "Courses", icon: GraduationCap },
    { href: "/bookmarks", label: "Bookmarks", icon: Bookmark },
  ];

  return (
    <nav className="sticky top-0 z-50 w-full border-b border-slate-200 bg-white/80 backdrop-blur-md dark:border-slate-800 dark:bg-slate-950/80">
      <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
        <div className="flex h-16 justify-between">
          <div className="flex items-center">
            <Link href="/dashboard" className="flex items-center gap-2">
              <div className="flex h-8 w-8 items-center justify-center rounded-lg bg-gradient-to-br from-indigo-500 to-purple-500 text-white font-bold text-xs shadow-lg shadow-indigo-500/20">
                DP
              </div>
              <span className="text-xl font-bold tracking-tight text-slate-900 dark:text-white">
                DrishtiPrep
              </span>
            </Link>

            {/* Desktop Nav */}
            <div className="hidden md:ml-10 md:flex md:items-center md:gap-1">
              {navLinks.map((link) => {
                const isActive = pathname === link.href || pathname.startsWith(link.href + "/");
                return (
                  <Link
                    key={link.href}
                    href={link.href}
                    className={cn(
                      "flex items-center gap-2 rounded-md px-3 py-2 text-sm font-medium transition-colors",
                      isActive
                        ? "bg-indigo-50 text-indigo-600 dark:bg-indigo-900/30 dark:text-indigo-400"
                        : "text-slate-600 hover:bg-slate-50 hover:text-slate-900 dark:text-slate-400 dark:hover:bg-slate-900 dark:hover:text-slate-200"
                    )}
                  >
                    <link.icon className="w-4 h-4" />
                    {link.label}
                  </Link>
                );
              })}
            </div>
          </div>

          <div className="hidden md:flex md:items-center md:gap-4">
            <div className="flex items-center gap-3 pr-4 border-r border-slate-200 dark:border-slate-800">
              <div className="flex flex-col items-end">
                <span className="text-xs font-medium text-slate-900 dark:text-slate-100">
                  {userEmail?.split("@")[0] || "Learner"}
                </span>
                <span className="text-[10px] text-slate-500 dark:text-slate-500 truncate max-w-[150px]">
                  {userEmail}
                </span>
              </div>
              <div className="h-8 w-8 rounded-full bg-slate-100 dark:bg-slate-800 flex items-center justify-center border border-slate-200 dark:border-slate-700">
                <User className="w-4 h-4 text-slate-600 dark:text-slate-400" />
              </div>
            </div>

            <form action={signOutAction}>
              <Button 
                variant="ghost" 
                size="sm" 
                type="submit"
                className="text-slate-600 hover:text-red-600 dark:text-slate-400 dark:hover:text-red-400"
              >
                <LogOut className="w-4 h-4 mr-2" />
                Sign Out
              </Button>
            </form>
          </div>

          {/* Mobile menu button */}
          <div className="flex items-center md:hidden">
            <Button
              variant="ghost"
              size="icon"
              onClick={() => setIsMobileMenuOpen(!isMobileMenuOpen)}
              aria-label="Toggle menu"
            >
              {isMobileMenuOpen ? <X className="h-6 w-6" /> : <Menu className="h-6 w-6" />}
            </Button>
          </div>
        </div>
      </div>

      {/* Mobile menu */}
      {isMobileMenuOpen && (
        <div className="border-b border-slate-200 bg-white md:hidden dark:border-slate-800 dark:bg-slate-950">
          <div className="space-y-1 px-2 pb-3 pt-2">
            {navLinks.map((link) => {
              const isActive = pathname === link.href || pathname.startsWith(link.href + "/");
              return (
                <Link
                  key={link.href}
                  href={link.href}
                  onClick={() => setIsMobileMenuOpen(false)}
                  className={cn(
                    "flex items-center gap-3 rounded-md px-3 py-3 text-base font-medium transition-colors",
                    isActive
                      ? "bg-indigo-50 text-indigo-600 dark:bg-indigo-900/30 dark:text-indigo-400"
                      : "text-slate-600 hover:bg-slate-50 hover:text-slate-900 dark:text-slate-400 dark:hover:bg-slate-900 dark:hover:text-slate-200"
                  )}
                >
                  <link.icon className="w-5 h-5" />
                  {link.label}
                </Link>
              );
            })}
            <div className="mt-4 border-t border-slate-200 pt-4 dark:border-slate-800">
                <div className="flex items-center gap-3 px-3 mb-4">
                     <User className="w-5 h-5 text-slate-500" />
                     <span className="text-sm font-medium text-slate-700 dark:text-slate-300">{userEmail}</span>
                </div>
                <form action={signOutAction} className="px-2">
                    <Button variant="destructive" className="w-full justify-start" type="submit">
                        <LogOut className="w-5 h-5 mr-3" />
                        Sign Out
                    </Button>
                </form>
            </div>
          </div>
        </div>
      )}
    </nav>
  );
}
