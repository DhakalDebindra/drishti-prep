import { vars } from 'nativewind'

/**
 * Theme palettes applied at runtime via NativeWind's `vars()` helper.
 *
 * Every colour token is an RGB TRIPLET string ("37 99 235"), because
 * tailwind.config.js defines colours as `rgb(var(--token) / <alpha-value>)`
 * so that opacity modifiers (bg-primary/15 etc.) keep working.
 *
 * ⚠️ ThemedRoot must ALWAYS apply one of these vars() objects — never
 * `undefined`. Toggling a View's style between a plain object and a vars()
 * object changes the css-interop wrapper structure and REMOUNTS the whole
 * subtree; since that View wraps the <Stack> navigator, the remount rips the
 * navigation context out from under mounted screens and crashes with
 * "Couldn't find a navigation context". Always passing a vars() object means
 * a contrast toggle only changes variable VALUES (re-render, no remount).
 */

// Normal palettes — must mirror the hex values in global.css :root/.dark.
const NORMAL_LIGHT: Record<string, string> = {
  background: '248 250 252', // #F8FAFC
  foreground: '15 23 42', // #0F172A
  card: '255 255 255',
  'card-foreground': '15 23 42',
  popover: '255 255 255',
  'popover-foreground': '15 23 42',
  primary: '37 99 235', // #2563EB
  'primary-foreground': '255 255 255',
  secondary: '226 232 240', // #E2E8F0
  'secondary-foreground': '15 23 42',
  muted: '241 245 249', // #F1F5F9
  'muted-foreground': '100 116 139', // #64748B
  accent: '219 234 254', // #DBEAFE
  'accent-foreground': '30 58 138', // #1E3A8A
  destructive: '239 68 68', // #EF4444
  'destructive-foreground': '255 255 255',
  border: '203 213 225', // #CBD5E1
  input: '203 213 225',
  ring: '59 130 246', // #3B82F6
}

const NORMAL_DARK: Record<string, string> = {
  background: '15 23 42', // #0F172A
  foreground: '248 250 252', // #F8FAFC
  card: '30 41 59', // #1E293B
  'card-foreground': '248 250 252',
  popover: '30 41 59',
  'popover-foreground': '248 250 252',
  primary: '59 130 246', // #3B82F6
  'primary-foreground': '255 255 255',
  secondary: '51 65 85', // #334155
  'secondary-foreground': '248 250 252',
  muted: '51 65 85',
  'muted-foreground': '148 163 184', // #94A3B8
  accent: '30 58 138', // #1E3A8A
  'accent-foreground': '219 234 254', // #DBEAFE
  destructive: '248 113 113', // #F87171
  'destructive-foreground': '15 23 42',
  border: '51 65 85',
  input: '51 65 85',
  ring: '59 130 246',
}

const HIGH_CONTRAST: Record<string, string> = {
  background: '0 0 0',
  foreground: '245 245 245',
  card: '10 10 10',
  'card-foreground': '248 248 248',
  popover: '10 10 10',
  'popover-foreground': '248 248 248',
  primary: '83 160 255',
  'primary-foreground': '0 0 0',
  secondary: '12 18 26',
  'secondary-foreground': '245 245 245',
  muted: '5 9 17',
  'muted-foreground': '228 228 228',
  accent: '255 211 128',
  'accent-foreground': '2 2 2',
  destructive: '255 125 118',
  'destructive-foreground': '0 0 0',
  border: '143 143 143',
  input: '143 143 143',
  ring: '254 228 132',
}

function toVars(map: Record<string, string>) {
  const out: Record<string, string> = {}
  for (const [name, value] of Object.entries(map)) {
    out[`--${name}`] = value
  }
  return vars(out)
}

export const normalLightVars = toVars(NORMAL_LIGHT)
export const normalDarkVars = toVars(NORMAL_DARK)
export const highContrastLightVars = toVars(HIGH_CONTRAST)
export const highContrastDarkVars = toVars(HIGH_CONTRAST)

export function getSwitchColors(contrast: 'normal' | 'high' | string) {
  const isHc = contrast === 'high-contrast' || contrast === 'high'
  return {
    false: isHc ? '#8f8f8f' : '#e2e8f0', // border or muted
    true: isHc ? '#ffd380' : '#2563EB', // accent for HC, primary for normal
  }
}
