export const colors = {
  background: '#0f172a',
  surface: '#1e293b',
  surfaceElevated: '#334155',
  border: '#334155',
  borderLight: '#1e293b',
  primary: '#6366f1',
  primaryActive: '#4f46e5',
  primaryMuted: '#818cf8',
  success: '#22c55e',
  successMuted: '#16a34a',
  danger: '#ef4444',
  dangerActive: '#dc2626',
  warning: '#f59e0b',
  text: {
    primary: '#f8fafc',
    secondary: '#cbd5e1',
    muted: '#94a3b8',
    accent: '#818cf8',
    inverse: '#0f172a',
  },
  badge: {
    submitted: { bg: '#065f46', text: '#d1fae5' },
    inProgress: { bg: '#155e75', text: '#cffafe' },
    free: { bg: '#065f46', text: '#d1fae5' },
    paid: { bg: '#1e3a5f', text: '#bfdbfe' },
    enrolled: { bg: '#064e3b', text: '#a7f3d0' },
  },
}

export const typography = {
  h1: { fontSize: 28, fontWeight: '800' as const, lineHeight: 36 },
  h2: { fontSize: 22, fontWeight: '700' as const, lineHeight: 28 },
  h3: { fontSize: 18, fontWeight: '600' as const, lineHeight: 24 },
  body: { fontSize: 16, fontWeight: '400' as const, lineHeight: 24 },
  bodySmall: { fontSize: 14, fontWeight: '400' as const, lineHeight: 20 },
  caption: { fontSize: 13, fontWeight: '500' as const, lineHeight: 18 },
  label: { fontSize: 12, fontWeight: '600' as const, lineHeight: 16 },
  statistic: { fontSize: 28, fontWeight: '800' as const, lineHeight: 36 },
}

export const spacing = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
  xxl: 32,
  xxxl: 40,
}

export const borderRadius = {
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
  full: 9999,
}
