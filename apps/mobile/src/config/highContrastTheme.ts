import { vars } from 'nativewind'

/**
 * High-contrast palettes applied at runtime via NativeWind's `vars()` helper.
 *
 * The app themes everything through CSS variables in global.css (e.g.
 * `text-foreground` → `var(--color-foreground)` → `var(--foreground)`).
 * Wrapping the tree in a View whose style is one of these `vars()` objects
 * overrides those variables for the whole subtree — no remount, just a
 * re-render with new inherited variable values.
 *
 * Each semantic token is written to BOTH `--name` and `--color-name` so it
 * works regardless of whether Tailwind's `@theme inline` kept a var() reference
 * or inlined the base value.
 */

const LIGHT: Record<string, string> = {
  background: '#ffffff',
  foreground: '#0a0a0a',
  card: '#ffffff',
  'card-foreground': '#0a0a0a',
  popover: '#ffffff',
  'popover-foreground': '#0a0a0a',
  primary: '#047857',
  'primary-foreground': '#ffffff',
  secondary: '#e5e7eb',
  'secondary-foreground': '#0a0a0a',
  muted: '#ececec',
  'muted-foreground': '#1f2937',
  accent: '#cffafe',
  'accent-foreground': '#0a0a0a',
  destructive: '#b91c1c',
  border: '#4b5563',
  input: '#4b5563',
  ring: '#047857',
}

const DARK: Record<string, string> = {
  background: '#000000',
  foreground: '#ffffff',
  card: '#0a0a0a',
  'card-foreground': '#ffffff',
  popover: '#0a0a0a',
  'popover-foreground': '#ffffff',
  primary: '#34d399',
  'primary-foreground': '#000000',
  secondary: '#1f2937',
  'secondary-foreground': '#ffffff',
  muted: '#111827',
  'muted-foreground': '#e5e7eb',
  accent: '#155e75',
  'accent-foreground': '#ffffff',
  destructive: '#f87171',
  border: '#d1d5db',
  input: '#d1d5db',
  ring: '#34d399',
}

function toVars(map: Record<string, string>) {
  const out: Record<string, string> = {}
  for (const [name, value] of Object.entries(map)) {
    out[`--${name}`] = value
    out[`--color-${name}`] = value
  }
  return vars(out)
}

export const highContrastLightVars = toVars(LIGHT)
export const highContrastDarkVars = toVars(DARK)
