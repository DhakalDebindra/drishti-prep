import Link from "next/link";

const columns = [
  {
    heading: "Prepare",
    links: [
      { href: "/#courses", label: "Courses" },
      { href: "/#features", label: "What you get" },
      { href: "/#how-it-works", label: "How it works" },
    ],
  },
  {
    heading: "Accessibility",
    links: [
      { href: "/#accessibility", label: "Accessibility" },
      { href: "/#partnerships", label: "Sponsored access" },
    ],
  },
  {
    heading: "Account",
    links: [
      // "Reset password" deliberately omitted: password recovery belongs on the
      // login page, where someone actually discovers they need it, not in
      // sitewide navigation.
      { href: "/signup", label: "Create an account" },
      { href: "/login", label: "Log in" },
    ],
  },
];

export function PublicFooter() {
  return (
    <footer className="mt-16 rounded-2xl border-2 border-border bg-card px-6 py-8 lg:px-10">
      <div className="grid gap-8 md:grid-cols-[1.2fr_2fr]">
        <div className="space-y-2">
          <div className="flex items-center gap-3">
            <span
              aria-hidden="true"
              className="flex h-10 w-10 items-center justify-center rounded-xl bg-primary text-sm font-bold text-primary-foreground"
            >
              DP
            </span>
            <span className="text-sm font-bold uppercase tracking-[0.2em] text-primary">
              DrishtiPrep
            </span>
          </div>
          <p className="max-w-sm text-sm leading-relaxed text-muted-foreground">
            Exam preparation for Nepal&apos;s Teaching License, TSC, and Public Service papers,
            built with blind educators for blind learners.
          </p>
        </div>

        <div className="grid gap-8 sm:grid-cols-3">
          {columns.map((column) => (
            <nav key={column.heading} aria-label={column.heading} className="space-y-3">
              <h2 className="text-xs font-semibold uppercase tracking-[0.24em] text-muted-foreground">
                {column.heading}
              </h2>
              {/* min-h-11 keeps every link at a 44px touch target, the same
                  large-target rule the rest of the app follows for low-vision
                  and motor-impaired users. */}
              <ul className="text-sm">
                {column.links.map((link) => (
                  <li key={link.href + link.label}>
                    <Link
                      href={link.href}
                      className="inline-flex min-h-11 items-center rounded-lg py-2 font-medium text-foreground transition-colors hover:text-primary focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring"
                    >
                      {link.label}
                    </Link>
                  </li>
                ))}
              </ul>
            </nav>
          ))}
        </div>
      </div>

      {/* Standard footer close: a copyright line is what people look for here.
          Privacy, Terms and Contact belong beside it, but those pages do not
          exist yet, so nothing links to them rather than shipping dead links. */}
      <p className="mt-8 border-t border-border pt-6 text-sm text-muted-foreground">
        &copy; {new Date().getFullYear()} DrishtiPrep. Accessible exam preparation in Nepal.
      </p>
    </footer>
  );
}
