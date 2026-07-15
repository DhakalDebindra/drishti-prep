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
  X,
  ShieldCheck,
  Settings,
  ChevronDown,
} from "lucide-react";
import { useEffect, useRef, useState, type ComponentProps } from "react";
import { useFormStatus } from "react-dom";
import { cn } from "@repo/utils";
import { Button } from "@/components/ui/button";
import { Lang } from "@/components/ui/Lang";
import { signOutAction } from "@/app/actions/auth";

type NavCourse = { name: string; slug: string };

interface AppNavbarProps {
  userEmail?: string | null;
  courses?: NavCourse[];
}

// Wraps the submit button so it can read the parent <form>'s pending state
// via useFormStatus. Without this, a tap on a slow mobile connection shows
// no feedback at all until the redirect lands, which reads as "didn't do
// anything" and invites a confused second tap.
function SignOutButton({ children, ...props }: ComponentProps<typeof Button>) {
  const { pending } = useFormStatus();
  return (
    <Button type="submit" disabled={pending} {...props}>
      {pending ? "Signing out…" : children}
    </Button>
  );
}

export function AppNavbar({ userEmail, courses = [] }: AppNavbarProps) {
  const pathname = usePathname();
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);
  const [coursesOpen, setCoursesOpen] = useState(false);
  const coursesRef = useRef<HTMLDivElement>(null);

  // Close the "My Courses" dropdown on outside-click or Escape. Listeners are
  // only attached while it is open, and setState happens in the handlers (never
  // synchronously in the effect body), so this stays clear of the CI
  // react-hooks/set-state-in-effect rule.
  useEffect(() => {
    if (!coursesOpen) return;
    function onPointerDown(event: MouseEvent) {
      if (coursesRef.current && !coursesRef.current.contains(event.target as Node)) {
        setCoursesOpen(false);
      }
    }
    function onKeyDown(event: KeyboardEvent) {
      if (event.key === "Escape") setCoursesOpen(false);
    }
    document.addEventListener("mousedown", onPointerDown);
    document.addEventListener("keydown", onKeyDown);
    return () => {
      document.removeEventListener("mousedown", onPointerDown);
      document.removeEventListener("keydown", onKeyDown);
    };
  }, [coursesOpen]);

  const navLinks = [
    { href: "/dashboard", label: "Dashboard", icon: LayoutDashboard },
    { href: "/courses", label: "Browse Courses", icon: GraduationCap },
    { href: "/bookmarks", label: "Bookmarks", icon: Bookmark },
    { href: "/profile/verify-identity", label: "Identity", icon: ShieldCheck },
    { href: "/profile/preferences", label: "Preferences", icon: Settings },
  ];

  return (
    <nav aria-label="Main" className="sticky top-0 z-50 w-full border-b border-slate-200 bg-white/80 backdrop-blur-md dark:border-slate-800 dark:bg-slate-950/80">
      <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
        <div className="flex h-16 justify-between">
          <div className="flex items-center">
            <Link href="/dashboard" className="flex items-center gap-2">
              <div className="flex h-8 w-8 items-center justify-center rounded-lg bg-primary text-primary-foreground font-bold text-xs shadow-lg shadow-primary/20">
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
                    aria-current={isActive ? "page" : undefined}
                    className={cn(
                      "flex items-center gap-2 rounded-md px-3 py-2 text-sm font-medium transition-colors",
                      isActive
                        ? "bg-primary/10 text-primary dark:bg-primary/20 dark:text-primary"
                        : "text-slate-600 hover:bg-slate-50 hover:text-slate-900 dark:text-slate-400 dark:hover:bg-slate-900 dark:hover:text-slate-200"
                    )}
                  >
                    <link.icon className="w-4 h-4" />
                    {link.label}
                  </Link>
                );
              })}

              {courses.length > 0 && (
                <div className="relative" ref={coursesRef}>
                  <button
                    type="button"
                    onClick={() => setCoursesOpen((open) => !open)}
                    aria-expanded={coursesOpen}
                    aria-haspopup="true"
                    aria-controls="my-courses-menu"
                    className={cn(
                      "flex items-center gap-2 rounded-md px-3 py-2 text-sm font-medium transition-colors",
                      coursesOpen
                        ? "bg-primary/10 text-primary dark:bg-primary/20 dark:text-primary"
                        : "text-slate-600 hover:bg-slate-50 hover:text-slate-900 dark:text-slate-400 dark:hover:bg-slate-900 dark:hover:text-slate-200"
                    )}
                  >
                    <GraduationCap className="w-4 h-4" aria-hidden="true" />
                    My Courses
                    <ChevronDown
                      className={cn("w-4 h-4 transition-transform", coursesOpen && "rotate-180")}
                      aria-hidden="true"
                    />
                  </button>
                  {coursesOpen && (
                    <div
                      id="my-courses-menu"
                      className="absolute left-0 top-full z-50 mt-1 w-64 rounded-xl border border-border bg-card p-2 shadow-lg"
                    >
                      <ul className="max-h-80 overflow-y-auto" aria-label="My courses">
                        {courses.map((course) => (
                          <li key={course.slug}>
                            <Link
                              href={`/courses/${course.slug}`}
                              onClick={() => setCoursesOpen(false)}
                              className="block rounded-lg px-3 py-2 text-sm font-medium text-foreground transition-colors hover:bg-muted focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring"
                            >
                              <Lang>{course.name}</Lang>
                            </Link>
                          </li>
                        ))}
                      </ul>
                    </div>
                  )}
                </div>
              )}
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
              <SignOutButton
                variant="ghost"
                size="sm"
                className="text-slate-600 hover:text-red-600 dark:text-slate-400 dark:hover:text-red-400"
              >
                <LogOut className="w-4 h-4 mr-2" />
                Sign Out
              </SignOutButton>
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
                  aria-current={isActive ? "page" : undefined}
                  onClick={() => setIsMobileMenuOpen(false)}
                  className={cn(
                    "flex items-center gap-3 rounded-md px-3 py-3 text-base font-medium transition-colors",
                    isActive
                      ? "bg-primary/10 text-primary dark:bg-primary/20 dark:text-primary"
                      : "text-slate-600 hover:bg-slate-50 hover:text-slate-900 dark:text-slate-400 dark:hover:bg-slate-900 dark:hover:text-slate-200"
                  )}
                >
                  <link.icon className="w-5 h-5" />
                  {link.label}
                </Link>
              );
            })}

            {courses.length > 0 && (
              <div className="mt-2 border-t border-slate-200 pt-2 dark:border-slate-800">
                <p className="px-3 py-1 text-xs font-semibold uppercase tracking-wide text-slate-500 dark:text-slate-400">
                  My Courses
                </p>
                {courses.map((course) => (
                  <Link
                    key={course.slug}
                    href={`/courses/${course.slug}`}
                    onClick={() => setIsMobileMenuOpen(false)}
                    className="flex items-center gap-3 rounded-md px-3 py-3 text-base font-medium text-slate-600 transition-colors hover:bg-slate-50 hover:text-slate-900 dark:text-slate-400 dark:hover:bg-slate-900 dark:hover:text-slate-200"
                  >
                    <GraduationCap className="w-5 h-5" aria-hidden="true" />
                    <Lang>{course.name}</Lang>
                  </Link>
                ))}
              </div>
            )}
            <div className="mt-4 border-t border-slate-200 pt-4 dark:border-slate-800">
                <div className="flex items-center gap-3 px-3 mb-4">
                     <User className="w-5 h-5 text-slate-500" />
                     <span className="text-sm font-medium text-slate-700 dark:text-slate-300">{userEmail}</span>
                </div>
                <form action={signOutAction} className="px-2">
                    <SignOutButton variant="destructive" className="w-full justify-start">
                        <LogOut className="w-5 h-5 mr-3" />
                        Sign Out
                    </SignOutButton>
                </form>
            </div>
          </div>
        </div>
      )}
    </nav>
  );
}
