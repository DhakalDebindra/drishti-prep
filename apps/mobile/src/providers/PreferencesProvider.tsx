import {
  createContext,
  useContext,
  useEffect,
  useState,
  useCallback,
  useMemo,
  type PropsWithChildren,
} from 'react'
import AsyncStorage from '@react-native-async-storage/async-storage'

/**
 * In-app accessibility preferences (a mobile subset of the web AccessibilityMenu).
 *
 * Two axes the product committed to on mobile:
 *  - fontScale: multiplies the size of every <Text> primitive, on top of the
 *    OS-level font scaling (so it stacks with the system setting).
 *  - contrast: toggles a high-contrast theme by swapping CSS variables via a
 *    root className (see global.css). State/context driven — no remounts.
 *
 * Persisted locally with AsyncStorage. Profile-level sync (writing to the
 * profiles.accessibility_preferences column) is a deferred follow-up.
 */

export type FontScale = 'sm' | 'md' | 'lg' | 'xl'
export type Contrast = 'normal' | 'high-contrast'

export type Preferences = {
  fontScale: FontScale
  contrast: Contrast
}

const FONT_SCALE_MULTIPLIERS: Record<FontScale, number> = {
  sm: 0.9,
  md: 1,
  lg: 1.15,
  xl: 1.3,
}

export function fontScaleMultiplier(scale: FontScale): number {
  return FONT_SCALE_MULTIPLIERS[scale] ?? 1
}

const DEFAULT_PREFERENCES: Preferences = {
  fontScale: 'md',
  contrast: 'normal',
}

const STORAGE_KEY = 'dp.preferences.v1'

type PreferencesContextValue = Preferences & {
  setFontScale: (value: FontScale) => void
  setContrast: (value: Contrast) => void
  /** Convenience multiplier derived from fontScale. */
  fontMultiplier: number
}

// A real default (not a throw) so consumers like <Text> render correctly even
// before the provider mounts — they simply get the default preferences.
const PreferencesContext = createContext<PreferencesContextValue>({
  ...DEFAULT_PREFERENCES,
  setFontScale: () => {},
  setContrast: () => {},
  fontMultiplier: 1,
})

export function usePreferences() {
  return useContext(PreferencesContext)
}

function isFontScale(value: unknown): value is FontScale {
  return value === 'sm' || value === 'md' || value === 'lg' || value === 'xl'
}

function isContrast(value: unknown): value is Contrast {
  return value === 'normal' || value === 'high-contrast'
}

export function PreferencesProvider({ children }: PropsWithChildren) {
  const [preferences, setPreferences] = useState<Preferences>(DEFAULT_PREFERENCES)

  // Hydrate from AsyncStorage on mount. The read is async (not a synchronous
  // setState in the effect body), so it does not trip react-hooks/set-state-in-effect.
  useEffect(() => {
    let cancelled = false
    AsyncStorage.getItem(STORAGE_KEY)
      .then((raw) => {
        if (cancelled || !raw) return
        try {
          const parsed = JSON.parse(raw) as Partial<Preferences>
          setPreferences({
            fontScale: isFontScale(parsed.fontScale) ? parsed.fontScale : DEFAULT_PREFERENCES.fontScale,
            contrast: isContrast(parsed.contrast) ? parsed.contrast : DEFAULT_PREFERENCES.contrast,
          })
        } catch {
          // Corrupt value — keep defaults.
        }
      })
      .catch(() => {
        // Storage unavailable — keep defaults.
      })
    return () => {
      cancelled = true
    }
  }, [])

  const persist = useCallback((next: Preferences) => {
    setPreferences(next)
    AsyncStorage.setItem(STORAGE_KEY, JSON.stringify(next)).catch(() => {
      // Best-effort persistence; in-memory state already updated.
    })
  }, [])

  const setFontScale = useCallback(
    (value: FontScale) => persist({ ...preferences, fontScale: value }),
    [persist, preferences],
  )

  const setContrast = useCallback(
    (value: Contrast) => persist({ ...preferences, contrast: value }),
    [persist, preferences],
  )

  const value = useMemo<PreferencesContextValue>(
    () => ({
      ...preferences,
      setFontScale,
      setContrast,
      fontMultiplier: fontScaleMultiplier(preferences.fontScale),
    }),
    [preferences, setFontScale, setContrast],
  )

  return <PreferencesContext.Provider value={value}>{children}</PreferencesContext.Provider>
}
