"use client";

import { useSyncExternalStore } from "react";

type ContrastMode = "normal" | "high-contrast";

const subscribeContrast = (callback: () => void) => {
  window.addEventListener("storage", callback);
  window.addEventListener("drishtiprep-contrast", callback);
  return () => {
    window.removeEventListener("storage", callback);
    window.removeEventListener("drishtiprep-contrast", callback);
  };
};

const getContrastSnapshot = () => {
  if (typeof window === "undefined") return "normal";
  return (localStorage.getItem("drishtiprep-contrast") as ContrastMode) || "normal";
};

const getServerContrastSnapshot = () => "normal" as ContrastMode;

export function useContrast() {
  const contrast = useSyncExternalStore(subscribeContrast, getContrastSnapshot, getServerContrastSnapshot);
  
  const setContrast = (next: ContrastMode) => {
    localStorage.setItem("drishtiprep-contrast", next);
    document.documentElement.classList.toggle("hc", next === "high-contrast");
    window.dispatchEvent(new Event("drishtiprep-contrast"));
  };
  
  return [contrast, setContrast] as const;
}

const subscribeDark = (callback: () => void) => {
  const mq = window.matchMedia("(prefers-color-scheme: dark)");
  mq.addEventListener("change", callback);
  const observer = new MutationObserver((mutations) => {
    for (const mutation of mutations) {
      if (mutation.attributeName === "class") callback();
    }
  });
  observer.observe(document.documentElement, { attributes: true });
  return () => {
    mq.removeEventListener("change", callback);
    observer.disconnect();
  };
};

const getDarkSnapshot = () => {
  if (typeof window === "undefined") return false;
  return window.matchMedia("(prefers-color-scheme: dark)").matches || document.documentElement.classList.contains("dark");
};

const getServerDarkSnapshot = () => false;

export function useIsDark() {
  return useSyncExternalStore(subscribeDark, getDarkSnapshot, getServerDarkSnapshot);
}
