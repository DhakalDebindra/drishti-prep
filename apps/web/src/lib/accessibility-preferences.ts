export type FontScale = "sm" | "md" | "lg" | "xl";
export type ContrastMode = "normal" | "high-contrast";
export type LineSpacing = "normal" | "relaxed" | "spacious";
export type MotionMode = "full" | "reduced";
export type DensityMode = "comfortable" | "spacious";
export type FocusMode = "standard" | "enhanced";

export type AccessibilityPreferences = {
  fontScale: FontScale;
  contrast: ContrastMode;
  lineSpacing: LineSpacing;
  motion: MotionMode;
  density: DensityMode;
  focusMode: FocusMode;
};

export const ACCESSIBILITY_STORAGE_KEY = "drishtiprep-accessibility";
export const ACCESSIBILITY_STORAGE_EVENT = "drishtiprep-accessibility";
export const ACCESSIBILITY_VERSION = 1;

export const defaultAccessibilityPreferences: AccessibilityPreferences = {
  fontScale: "md",
  contrast: "normal",
  lineSpacing: "normal",
  motion: "full",
  density: "comfortable",
  focusMode: "standard",
};

const fontScaleValues: Record<FontScale, string> = {
  sm: "15px",
  md: "16px",
  lg: "17px",
  xl: "18px",
};

const densityWidthValues: Record<DensityMode, string> = {
  comfortable: "76rem",
  spacious: "84rem",
};

const lineSpacingValues: Record<LineSpacing, string> = {
  normal: "1.65",
  relaxed: "1.8",
  spacious: "1.95",
};

export function normalizeAccessibilityPreferences(
  value: Partial<AccessibilityPreferences> | null | undefined
): AccessibilityPreferences {
  return {
    fontScale:
      value?.fontScale === "sm" || value?.fontScale === "lg" || value?.fontScale === "xl"
        ? value.fontScale
        : "md",
    contrast: value?.contrast === "high-contrast" ? "high-contrast" : "normal",
    lineSpacing:
      value?.lineSpacing === "relaxed" || value?.lineSpacing === "spacious"
        ? value.lineSpacing
        : "normal",
    motion: value?.motion === "reduced" ? "reduced" : "full",
    density: value?.density === "spacious" ? "spacious" : "comfortable",
    focusMode: value?.focusMode === "enhanced" ? "enhanced" : "standard",
  };
}

export function readAccessibilityPreferences(): AccessibilityPreferences {
  if (typeof window === "undefined") return defaultAccessibilityPreferences;

  try {
    const raw = localStorage.getItem(ACCESSIBILITY_STORAGE_KEY);
    if (!raw) return defaultAccessibilityPreferences;

    const parsed = JSON.parse(raw) as Partial<AccessibilityPreferences>;
    return normalizeAccessibilityPreferences(parsed);
  } catch {
    return defaultAccessibilityPreferences;
  }
}

export function writeAccessibilityPreferences(prefs: AccessibilityPreferences) {
  if (typeof window === "undefined") return;

  localStorage.setItem(
    ACCESSIBILITY_STORAGE_KEY,
    JSON.stringify({
      version: ACCESSIBILITY_VERSION,
      ...prefs,
    })
  );
  localStorage.setItem("drishtiprep-contrast", prefs.contrast);
  window.dispatchEvent(new Event("drishtiprep-contrast"));
  window.dispatchEvent(new Event(ACCESSIBILITY_STORAGE_EVENT));
}

export function resolveAccessibilityPreferences(
  stored: Partial<AccessibilityPreferences> | null | undefined,
  fallback?: Partial<AccessibilityPreferences> | null | undefined
): AccessibilityPreferences {
  return normalizeAccessibilityPreferences({
    ...defaultAccessibilityPreferences,
    ...(stored ?? {}),
    ...(fallback ?? {}),
  });
}

export function applyAccessibilityPreferences(prefs: AccessibilityPreferences) {
  if (typeof document === "undefined") return;

  const root = document.documentElement;
  root.dataset.dpFontScale = prefs.fontScale;
  root.dataset.dpLineSpacing = prefs.lineSpacing;
  root.dataset.dpDensity = prefs.density;
  root.dataset.dpMotion = prefs.motion;
  root.dataset.dpFocus = prefs.focusMode;
  root.classList.toggle("hc", prefs.contrast === "high-contrast");

  root.style.setProperty("--dp-root-font-size", fontScaleValues[prefs.fontScale]);
  root.style.setProperty("--dp-shell-width", densityWidthValues[prefs.density]);
  root.style.setProperty("--dp-body-line-height", lineSpacingValues[prefs.lineSpacing]);
  root.style.setProperty("--dp-focus-outline-width", prefs.focusMode === "enhanced" ? "3px" : "2px");
  root.style.setProperty("--dp-focus-outline-offset", prefs.focusMode === "enhanced" ? "4px" : "3px");
}

export function accessibilityPreferencesEqual(
  left: AccessibilityPreferences,
  right: AccessibilityPreferences
) {
  return JSON.stringify(left) === JSON.stringify(right);
}
