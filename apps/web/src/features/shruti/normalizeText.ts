// normalizeText: deterministic Unicode + whitespace cleanup.
// Runs before any chunking. Idempotent; safe to call multiple times.
//
// Does NOT do semantic repair — that belongs to the Gemini cleanup pass.

const ZERO_WIDTH = /[​-‍﻿]/g;
const DEVANAGARI_DUP_VOWEL_SIGNS = /([ा-ौॎॏ])\1+/g;

export interface NormalizeOptions {
  collapseWhitespace?: boolean; // default true
  trimLines?: boolean;          // default true
}

export function normalizeText(input: string, opts: NormalizeOptions = {}): string {
  const { collapseWhitespace = true, trimLines = true } = opts;

  let s = input.normalize("NFC");

  s = s.replace(ZERO_WIDTH, "");

  // Collapse accidental double vowel signs in Devanagari (common OCR artifact).
  s = s.replace(DEVANAGARI_DUP_VOWEL_SIGNS, "$1");

  // Normalize Devanagari danda spacing: "वाक्य ।" -> "वाक्य।"; "।वाक्य" -> "। वाक्य".
  s = s.replace(/\s+([।॥])/g, "$1");
  s = s.replace(/([।॥])(?=\S)/g, "$1 ");

  // Normalize quotes/dashes that confuse sentence splitting.
  s = s
    .replace(/[‘’]/g, "'")
    .replace(/[“”]/g, '"')
    .replace(/—/g, "—");

  // Line-by-line trim, then optional whitespace collapse.
  if (trimLines) {
    s = s
      .split(/\r?\n/)
      .map((line) => line.replace(/[ \t]+/g, " ").trim())
      .join("\n");
  }

  if (collapseWhitespace) {
    // Collapse 3+ consecutive newlines into a paragraph break (2 newlines).
    s = s.replace(/\n{3,}/g, "\n\n");
  }

  return s.trim();
}

// Stable, dependency-free hash for caching/versioning.
export function hashText(input: string): string {
  let h1 = 0xdeadbeef ^ 0;
  let h2 = 0x41c6ce57 ^ 0;
  for (let i = 0; i < input.length; i++) {
    const ch = input.charCodeAt(i);
    h1 = Math.imul(h1 ^ ch, 2654435761);
    h2 = Math.imul(h2 ^ ch, 1597334677);
  }
  h1 = Math.imul(h1 ^ (h1 >>> 16), 2246822507);
  h1 ^= Math.imul(h2 ^ (h2 >>> 13), 3266489909);
  h2 = Math.imul(h2 ^ (h2 >>> 16), 2246822507);
  h2 ^= Math.imul(h1 ^ (h1 >>> 13), 3266489909);
  return (4294967296 * (2097151 & h2) + (h1 >>> 0)).toString(16);
}

export function detectLanguage(text: string): "en" | "ne" | "mixed" {
  const devanagari = (text.match(/[ऀ-ॿ]/g) ?? []).length;
  const latin = (text.match(/[A-Za-z]/g) ?? []).length;
  if (devanagari === 0 && latin > 0) return "en";
  if (latin === 0 && devanagari > 0) return "ne";
  if (devanagari > 0 && latin > 0) {
    // If both scripts have a non-trivial presence, it's mixed.
    if (devanagari >= 3 && latin >= 3) return "mixed";
    const ratio = devanagari / (devanagari + latin);
    if (ratio > 0.5) return "ne";
    return "en";
  }
  return "en";
}
