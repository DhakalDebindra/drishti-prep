// Tiny logging shim for Shruti modules.
//
// All Shruti console output goes through here so production builds stay
// quiet (no debug noise in the browser console for end users). Enable
// verbose logging in dev by setting `localStorage.SHRUTI_DEBUG = "1"`
// in the browser, or by running in `NODE_ENV=development`.

const DEV =
  typeof process !== "undefined" && process.env?.NODE_ENV !== "production";

function userOptedIn(): boolean {
  if (typeof window === "undefined") return false;
  try {
    return window.localStorage?.getItem("SHRUTI_DEBUG") === "1";
  } catch {
    return false;
  }
}

function enabled(): boolean {
  return DEV || userOptedIn();
}

/** Verbose trace — info that's only useful while debugging. */
export function logDebug(...args: unknown[]): void {
  if (!enabled()) return;
  console.debug("[Shruti]", ...args);
}

/** Notable events worth seeing even in production (rare, low-volume). */
export function logInfo(...args: unknown[]): void {
  if (!enabled()) return;
  console.info("[Shruti]", ...args);
}

/** Recoverable problems — always surfaced. */
export function logWarn(...args: unknown[]): void {
  console.warn("[Shruti]", ...args);
}

/** Hard failures — always surfaced. */
export function logError(...args: unknown[]): void {
  console.error("[Shruti]", ...args);
}
