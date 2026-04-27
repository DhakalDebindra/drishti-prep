import type { Metadata } from "next";
import { Space_Grotesk, Work_Sans, Geist_Mono } from "next/font/google";
import "./globals.css";

const displayFont = Space_Grotesk({
  variable: "--font-display",
  subsets: ["latin"],
  weight: ["400", "500", "600", "700"],
});

const bodyFont = Work_Sans({
  variable: "--font-body",
  subsets: ["latin"],
  weight: ["400", "500", "600", "700"],
});

const monoFont = Geist_Mono({
  variable: "--font-geist-mono",
  subsets: ["latin"],
});

export const metadata: Metadata = {
  title: {
    default: "DrishtiPrep — Accessible Exam Prep for Nepal",
    template: "%s | DrishtiPrep",
  },
  description:
    "An accessibility-first exam preparation platform for blind and low-vision aspirants in Nepal. Practice MCQs, get AI-powered feedback, and prepare with a screen-reader-first experience.",
  applicationName: "DrishtiPrep",
  keywords: [
    "DrishtiPrep",
    "Nepal",
    "exam preparation",
    "accessibility",
    "screen reader",
    "MCQ practice",
    "blind",
    "low vision",
  ],
  authors: [{ name: "DrishtiPrep" }],
  openGraph: {
    title: "DrishtiPrep — Accessible Exam Prep for Nepal",
    description:
      "Accessibility-first exam preparation for blind and low-vision aspirants in Nepal.",
    siteName: "DrishtiPrep",
    locale: "en_US",
    type: "website",
  },
  twitter: {
    card: "summary_large_image",
    title: "DrishtiPrep — Accessible Exam Prep for Nepal",
    description:
      "Accessibility-first exam preparation for blind and low-vision aspirants in Nepal.",
  },
  robots: { index: true, follow: true },
};

import { Toaster } from "react-hot-toast";
import { ThemeProvider } from "@/components/theme-provider";

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  const themeInitializer = `
    (function() {
      try {
        const root = document.documentElement;
        const storedContrast = localStorage.getItem('drishtiprep-contrast');
        const prefersMoreContrast = window.matchMedia && window.matchMedia('(prefers-contrast: more)').matches;
        if (storedContrast === 'high-contrast' || (!storedContrast && prefersMoreContrast)) root.classList.add('hc');
      } catch (e) {
        // noop
      }
    })();
  `;
  return (
    <html lang="en" suppressHydrationWarning>
      <head>
        <meta name="theme-color" content="#000000" media="(prefers-color-scheme: light)" />
        <meta name="theme-color" content="#ffffff" media="(prefers-color-scheme: dark)" />
        <script dangerouslySetInnerHTML={{ __html: themeInitializer }} />
      </head>
      <body
        className={`${displayFont.variable} ${bodyFont.variable} ${monoFont.variable} antialiased`}
      >
        <ThemeProvider attribute="class" defaultTheme="system" enableSystem disableTransitionOnChange>
          <a
            href="#main"
            className="sr-only focus:not-sr-only focus:fixed focus:left-4 focus:top-4 focus:z-50 focus:rounded-lg focus:bg-slate-100 focus:px-3 focus:py-2 focus:text-slate-900"
          >
            Skip to main content
          </a>
          {children}
          <Toaster />
        </ThemeProvider>
      </body>
    </html>
  );
}
