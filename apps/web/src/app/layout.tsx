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
    default: "DrishtiPrep: Accessible Exam Prep for Nepal",
    template: "%s | DrishtiPrep",
  },
  description:
    "Exam preparation for blind and low-vision candidates in Nepal. Practise MCQs for the Teaching License, Teacher Service Commission and Public Service Commission papers with a site built for screen readers.",
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
    title: "DrishtiPrep: Accessible Exam Prep for Nepal",
    description:
      "Exam preparation for blind and low-vision candidates in Nepal, built for screen readers.",
    siteName: "DrishtiPrep",
    locale: "en_US",
    type: "website",
  },
  twitter: {
    card: "summary_large_image",
    title: "DrishtiPrep: Accessible Exam Prep for Nepal",
    description:
      "Exam preparation for blind and low-vision candidates in Nepal, built for screen readers.",
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
        const defaults = {
          fontScale: 'md',
          contrast: 'normal',
          lineSpacing: 'normal',
          motion: 'full',
          density: 'comfortable',
          focusMode: 'standard',
        };
        const fontScaleMap = { sm: '15px', md: '16px', lg: '17px', xl: '18px' };
        const densityWidthMap = { comfortable: '76rem', spacious: '84rem' };
        const lineSpacingMap = { normal: '1.65', relaxed: '1.8', spacious: '1.95' };
        const accessibilityRaw = localStorage.getItem('drishtiprep-accessibility');
        const legacyContrast = localStorage.getItem('drishtiprep-contrast');
        const prefersReducedMotion = window.matchMedia && window.matchMedia('(prefers-reduced-motion: reduce)').matches;
        let stored = {};

        if (accessibilityRaw) {
          const parsed = JSON.parse(accessibilityRaw);
          if (parsed && typeof parsed === 'object') {
            stored = parsed;
          }
        }

        const prefs = {
          fontScale: ['sm', 'md', 'lg', 'xl'].includes(stored.fontScale) ? stored.fontScale : defaults.fontScale,
          contrast:
            stored.contrast === 'high-contrast'
              ? 'high-contrast'
              : legacyContrast === 'high-contrast'
                ? 'high-contrast'
                : defaults.contrast,
          lineSpacing:
            stored.lineSpacing === 'relaxed' || stored.lineSpacing === 'spacious'
              ? stored.lineSpacing
              : defaults.lineSpacing,
          motion: stored.motion === 'reduced' ? 'reduced' : (!accessibilityRaw && prefersReducedMotion ? 'reduced' : defaults.motion),
          density: stored.density === 'spacious' ? 'spacious' : defaults.density,
          focusMode: stored.focusMode === 'enhanced' ? 'enhanced' : defaults.focusMode,
        };

        root.dataset.dpFontScale = prefs.fontScale;
        root.dataset.dpLineSpacing = prefs.lineSpacing;
        root.dataset.dpDensity = prefs.density;
        root.dataset.dpMotion = prefs.motion;
        root.dataset.dpFocus = prefs.focusMode;
        root.classList.toggle('hc', prefs.contrast === 'high-contrast');
        root.style.setProperty('--dp-root-font-size', fontScaleMap[prefs.fontScale]);
        root.style.setProperty('--dp-shell-width', densityWidthMap[prefs.density]);
        root.style.setProperty('--dp-body-line-height', lineSpacingMap[prefs.lineSpacing]);
        root.style.setProperty('--dp-focus-outline-width', prefs.focusMode === 'enhanced' ? '3px' : '2px');
        root.style.setProperty('--dp-focus-outline-offset', prefs.focusMode === 'enhanced' ? '4px' : '3px');
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
        <ThemeProvider attribute="class" defaultTheme="light" enableSystem disableTransitionOnChange>
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
