"use client";

import { useSyncExternalStore } from "react";

function subscribe(callback: () => void) {
  const mql = window.matchMedia("(prefers-reduced-motion: reduce)");
  mql.addEventListener("change", callback);
  return () => mql.removeEventListener("change", callback);
}

function getSnapshot() {
  return window.matchMedia("(prefers-reduced-motion: reduce)").matches;
}

function getServerSnapshot() {
  // On the server, assume motion is allowed (safe default)
  return false;
}

/**
 * Returns true if the user has requested reduced motion in their OS settings.
 * Re-renders automatically if the user changes the setting while on the page.
 *
 * Usage:
 *   const reducedMotion = useReducedMotion();
 *   if (reducedMotion) { skip animation }
 */
export function useReducedMotion(): boolean {
  return useSyncExternalStore(subscribe, getSnapshot, getServerSnapshot);
}
