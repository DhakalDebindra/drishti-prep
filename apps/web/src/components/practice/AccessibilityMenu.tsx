"use client";

import { ComponentType, useEffect, useMemo, useRef, useState } from "react";
import { Settings2, Sparkles, Type, Contrast, Waves, Gauge, Focus, Keyboard, RotateCcw } from "lucide-react";
import { Button } from "@/components/ui/button";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import {
  ACCESSIBILITY_STORAGE_EVENT,
  AccessibilityPreferences,
  applyAccessibilityPreferences,
  defaultAccessibilityPreferences,
  normalizeAccessibilityPreferences,
  readAccessibilityPreferences,
  resolveAccessibilityPreferences,
  writeAccessibilityPreferences,
  accessibilityPreferencesEqual,
} from "@/lib/accessibility-preferences";
import { cn } from "@repo/utils";

type ButtonMode = "compact" | "label";

type Props = {
  buttonMode?: ButtonMode;
  className?: string;
};

const FONT_SCALE_OPTIONS: Array<{ value: AccessibilityPreferences["fontScale"]; label: string; description: string }> = [
  { value: "sm", label: "Small", description: "Tighter text for dense screens." },
  { value: "md", label: "Default", description: "Balanced reading size." },
  { value: "lg", label: "Large", description: "Improves scanning comfort." },
  { value: "xl", label: "XL", description: "Best for extended sessions." },
];

const CONTRAST_OPTIONS: Array<{ value: AccessibilityPreferences["contrast"]; label: string; description: string }> = [
  { value: "normal", label: "Normal", description: "Soft contrast for low fatigue." },
  { value: "high-contrast", label: "High", description: "Stronger separation and emphasis." },
];

const LINE_SPACING_OPTIONS: Array<{ value: AccessibilityPreferences["lineSpacing"]; label: string; description: string }> = [
  { value: "normal", label: "Normal", description: "Standard reading rhythm." },
  { value: "relaxed", label: "Relaxed", description: "Extra air between lines." },
  { value: "spacious", label: "Spacious", description: "Maximum reading comfort." },
];

const MOTION_OPTIONS: Array<{ value: AccessibilityPreferences["motion"]; label: string; description: string }> = [
  { value: "full", label: "Full motion", description: "Keep subtle transitions." },
  { value: "reduced", label: "Reduced", description: "Minimize motion and animation." },
];

const DENSITY_OPTIONS: Array<{ value: AccessibilityPreferences["density"]; label: string; description: string }> = [
  { value: "comfortable", label: "Comfortable", description: "Readable width and spacing." },
  { value: "spacious", label: "Spacious", description: "More room for careful study." },
];

const FOCUS_OPTIONS: Array<{ value: AccessibilityPreferences["focusMode"]; label: string; description: string }> = [
  { value: "standard", label: "Standard", description: "Keep normal focus rings." },
  { value: "enhanced", label: "Enhanced", description: "Stronger, clearer focus rings." },
];

function OptionGroup<T extends string>({
  title,
  icon: Icon,
  value,
  options,
  onChange,
}: {
  title: string;
  icon: ComponentType<{ className?: string }>;
  value: T;
  options: Array<{ value: T; label: string; description: string }>;
  onChange: (next: T) => void;
}) {
  return (
    <section className="rounded-[1.5rem] border border-slate-200 bg-slate-50/80 p-4 dark:border-slate-800 dark:bg-slate-900/60">
      <div className="mb-3 flex items-center gap-2">
        <Icon className="h-4 w-4 text-emerald-600 dark:text-emerald-300" />
        <h4 className="text-sm font-semibold text-slate-900 dark:text-white">{title}</h4>
      </div>
      <div className="grid gap-2 sm:grid-cols-2">
        {options.map((option) => {
          const active = option.value === value;
          return (
            <button
              key={option.value}
              type="button"
              onClick={() => onChange(option.value)}
              aria-pressed={active}
              className={cn(
                "rounded-2xl border px-4 py-3 text-left transition focus:outline-none focus:ring-2 focus:ring-ring focus:ring-offset-2 focus:ring-offset-white dark:focus:ring-offset-slate-950",
                active
                  ? "border-primary/30 bg-primary/10 text-primary shadow-sm"
                  : "border-slate-200 bg-white/70 text-slate-700 hover:bg-white dark:border-slate-700 dark:bg-slate-950/70 dark:text-slate-300 dark:hover:bg-slate-950"
              )}
            >
              <div className="font-medium">{option.label}</div>
              <div className="mt-1 text-xs leading-relaxed text-slate-500 dark:text-slate-400">
                {option.description}
              </div>
            </button>
          );
        })}
      </div>
    </section>
  );
}

export function PracticeAccessibilityMenu({ buttonMode = "label", className }: Props) {
  const [open, setOpen] = useState(false);
  const [prefs, setPrefs] = useState<AccessibilityPreferences>(defaultAccessibilityPreferences);
  const [isAuthenticated, setIsAuthenticated] = useState(false);
  const [status, setStatus] = useState<"idle" | "loading" | "saving" | "saved" | "error">("idle");
  const [statusMessage, setStatusMessage] = useState<string | null>(null);
  const fetchOnceRef = useRef(false);

  const shortcutSummary = useMemo(
    () => [
      ["Alt+A", "Open accessibility menu"],
      ["Esc", "Close the menu"],
      ["Alt+Q", "Jump to question"],
      ["Alt+O", "Jump to options"],
      ["1-4", "Choose an answer"],
    ],
    []
  );

  useEffect(() => {
    const onKeyDown = (event: KeyboardEvent) => {
      const target = event.target as HTMLElement | null;
      const isEditable =
        Boolean(target) &&
        (target?.tagName === "INPUT" ||
          target?.tagName === "TEXTAREA" ||
          target?.tagName === "SELECT" ||
          target?.isContentEditable);

      if (!isEditable && event.altKey && event.key.toLowerCase() === "a") {
        event.preventDefault();
        setOpen(true);
      }
    };

    window.addEventListener("keydown", onKeyDown);
    return () => window.removeEventListener("keydown", onKeyDown);
  }, []);

  useEffect(() => {
    const hydrateFromServer = async () => {
      // Apply local preferences first (deferred inside the async function to avoid synchronous setState)
      const localPrefs = readAccessibilityPreferences();
      setPrefs(localPrefs);
      applyAccessibilityPreferences(localPrefs);
      writeAccessibilityPreferences(localPrefs);

      if (fetchOnceRef.current) return;
      fetchOnceRef.current = true;

      try {
        setStatus("loading");

        const response = await fetch("/api/me/preferences");
        const payload = await response.json();
        const authenticated = Boolean(payload?.authenticated);
        setIsAuthenticated(authenticated);

        if (!authenticated) {
          setStatus("idle");
          return;
        }

        const serverPrefs = normalizeAccessibilityPreferences(payload?.accessibility_preferences);
        const merged = resolveAccessibilityPreferences(serverPrefs, localPrefs);
        setPrefs(merged);
        applyAccessibilityPreferences(merged);
        writeAccessibilityPreferences(merged);

        if (!accessibilityPreferencesEqual(merged, serverPrefs)) {
          setStatus("saving");
          const saveResponse = await fetch("/api/me/preferences", {
            method: "PATCH",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ accessibility_preferences: merged }),
          });
          if (!saveResponse.ok) {
            throw new Error("Could not sync accessibility settings.");
          }
        }

        setStatus("saved");
        setStatusMessage("Accessibility settings synced.");

        window.setTimeout(() => {
          setStatus((current) => (current === "error" ? current : "idle"));
        }, 1500);
      } catch (error) {
        setStatus("error");
        setStatusMessage(error instanceof Error ? error.message : "Could not load accessibility settings.");
        window.setTimeout(() => {
          setStatus((current) => (current === "error" ? current : "idle"));
        }, 1500);
      }
    };

    hydrateFromServer();
  }, []);

  useEffect(() => {
    const onStorage = () => {
      const stored = readAccessibilityPreferences();
      setPrefs(stored);
      applyAccessibilityPreferences(stored);
    };

    window.addEventListener("storage", onStorage);
    window.addEventListener(ACCESSIBILITY_STORAGE_EVENT, onStorage);
    return () => {
      window.removeEventListener("storage", onStorage);
      window.removeEventListener(ACCESSIBILITY_STORAGE_EVENT, onStorage);
    };
  }, []);

  const persistPreferences = async (next: AccessibilityPreferences) => {
    setPrefs(next);
    applyAccessibilityPreferences(next);
    writeAccessibilityPreferences(next);

    if (!isAuthenticated) return;

    setStatus("saving");
    try {
      const response = await fetch("/api/me/preferences", {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ accessibility_preferences: next }),
      });
      if (!response.ok) {
        throw new Error("Could not save accessibility settings.");
      }
      setStatus("saved");
      setStatusMessage("Saved to your profile.");
      window.setTimeout(() => setStatus("idle"), 1200);
    } catch (error) {
      setStatus("error");
      setStatusMessage(error instanceof Error ? error.message : "Could not save accessibility settings.");
    }
  };

  const updatePreference = <K extends keyof AccessibilityPreferences>(key: K, value: AccessibilityPreferences[K]) => {
    const next = normalizeAccessibilityPreferences({ ...prefs, [key]: value });
    void persistPreferences(next);
  };

  const resetPreferences = () => {
    void persistPreferences(defaultAccessibilityPreferences);
  };

  const triggerLabel = buttonMode === "compact" ? "A11y" : "Accessibility";

  return (
    <>
      <Button
        type="button"
        variant="outline"
        className={cn(
          "inline-flex items-center gap-2 rounded-full border-slate-200 bg-white text-slate-700 shadow-sm transition hover:bg-slate-50 focus-visible:ring-2 focus-visible:ring-ring dark:border-slate-700 dark:bg-slate-900 dark:text-slate-200 dark:hover:bg-slate-800",
          buttonMode === "compact" ? "h-10 px-3 text-sm" : "h-11 px-4 text-sm font-semibold",
          className
        )}
        aria-label="Open accessibility settings"
        aria-haspopup="dialog"
        aria-expanded={open}
        onClick={() => setOpen(true)}
      >
        <Settings2 className="h-4 w-4" aria-hidden="true" />
        <span>{triggerLabel}</span>
      </Button>

      {/* Mounted only while open, not open={open} on an always-mounted Dialog:
          when rendered inside the practice page's high-churn tree, Base UI's
          CSS-animation-completion-based unmount kept getting interrupted by
          re-renders and never closed (see ConfirmSubmitDialog for the same
          fix and full diagnosis). Mounting conditionally makes close a plain
          React unmount instead. */}
      {open && (
      <Dialog open onOpenChange={setOpen}>
        <DialogContent className="max-h-[calc(100vh-1.5rem)] w-[min(48rem,calc(100vw-1rem))] overflow-y-auto rounded-[2rem] border border-slate-200 bg-white p-0 shadow-[0_20px_80px_rgba(15,23,42,0.18)] dark:border-slate-800 dark:bg-slate-950">
          <div className="border-b border-slate-200 px-5 py-4 dark:border-slate-800 sm:px-6">
            <DialogHeader>
              <div className="flex items-start justify-between gap-4">
                <div className="space-y-2">
                  <div className="inline-flex items-center gap-2 rounded-full border border-emerald-200 bg-emerald-50 px-3 py-1 text-xs font-semibold uppercase tracking-[0.22em] text-emerald-800 dark:border-emerald-900/60 dark:bg-emerald-950/30 dark:text-emerald-200">
                    <Sparkles className="h-3.5 w-3.5" aria-hidden="true" />
                    Practice accessibility
                  </div>
                  <DialogTitle className="text-2xl font-bold tracking-tight text-slate-950 dark:text-white">
                    Make reading more comfortable
                  </DialogTitle>
                  <DialogDescription className="max-w-2xl text-sm leading-relaxed text-slate-600 dark:text-slate-300">
                    Adjust how practice content feels without leaving the session. Your settings are saved locally first, then synced to your profile when you&apos;re signed in.
                  </DialogDescription>
                </div>
              </div>
            </DialogHeader>
          </div>

          <div className="space-y-4 px-5 py-5 sm:px-6">
            <OptionGroup
              title="Font size"
              icon={Type}
              value={prefs.fontScale}
              options={FONT_SCALE_OPTIONS}
              onChange={(value) => updatePreference("fontScale", value)}
            />

            <OptionGroup
              title="Contrast"
              icon={Contrast}
              value={prefs.contrast}
              options={CONTRAST_OPTIONS}
              onChange={(value) => updatePreference("contrast", value)}
            />

            <OptionGroup
              title="Line spacing"
              icon={Waves}
              value={prefs.lineSpacing}
              options={LINE_SPACING_OPTIONS}
              onChange={(value) => updatePreference("lineSpacing", value)}
            />

            <OptionGroup
              title="Reduced motion"
              icon={Gauge}
              value={prefs.motion}
              options={MOTION_OPTIONS}
              onChange={(value) => updatePreference("motion", value)}
            />

            <OptionGroup
              title="Reading width"
              icon={Focus}
              value={prefs.density}
              options={DENSITY_OPTIONS}
              onChange={(value) => updatePreference("density", value)}
            />

            <OptionGroup
              title="Focus emphasis"
              icon={Focus}
              value={prefs.focusMode}
              options={FOCUS_OPTIONS}
              onChange={(value) => updatePreference("focusMode", value)}
            />

            <section className="rounded-[1.5rem] border border-slate-200 bg-slate-50/80 p-4 dark:border-slate-800 dark:bg-slate-900/60">
              <div className="mb-3 flex items-center gap-2">
                <Keyboard className="h-4 w-4 text-emerald-600 dark:text-emerald-300" />
                <h4 className="text-sm font-semibold text-slate-900 dark:text-white">Shortcut summary</h4>
              </div>
              <dl className="grid gap-2 sm:grid-cols-2">
                {shortcutSummary.map(([shortcut, description]) => (
                  <div
                    key={shortcut}
                    className="rounded-2xl border border-slate-200 bg-white px-4 py-3 text-sm dark:border-slate-700 dark:bg-slate-950"
                  >
                    <dt className="font-mono text-xs font-semibold uppercase tracking-[0.18em] text-emerald-700 dark:text-emerald-300">
                      {shortcut}
                    </dt>
                    <dd className="mt-1 text-slate-600 dark:text-slate-300">{description}</dd>
                  </div>
                ))}
              </dl>
            </section>

            <div className="flex flex-col gap-3 rounded-[1.5rem] border border-slate-200 bg-white p-4 dark:border-slate-800 dark:bg-slate-950 sm:flex-row sm:items-center sm:justify-between">
              <div className="text-sm text-slate-600 dark:text-slate-300">
                {status === "saving" && "Saving your preferences…"}
                {status === "saved" && statusMessage}
                {status === "error" && statusMessage}
                {status === "idle" && "Your settings apply immediately while you study."}
              </div>
              <button
                type="button"
                onClick={resetPreferences}
                className="inline-flex items-center justify-center gap-2 rounded-full border border-slate-200 bg-slate-50 px-4 py-2 text-sm font-semibold text-slate-700 transition hover:bg-slate-100 focus:outline-none focus:ring-2 focus:ring-ring dark:border-slate-700 dark:bg-slate-900 dark:text-slate-200 dark:hover:bg-slate-800"
              >
                <RotateCcw className="h-4 w-4" aria-hidden="true" />
                Reset
              </button>
            </div>
          </div>
        </DialogContent>
      </Dialog>
      )}
    </>
  );
}
