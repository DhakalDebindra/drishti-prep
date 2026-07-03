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
  answerSound: boolean
  reduceMotion: boolean
  haptics: boolean
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
  answerSound: true,
  reduceMotion: false,
  haptics: true,
}

const STORAGE_KEY = 'dp.preferences.v3'
const LEGACY_STORAGE_KEY_V2 = 'dp.preferences.v2'

type PreferencesContextValue = Preferences & {
  setFontScale: (value: FontScale) => void
  setContrast: (value: Contrast) => void
  setAnswerSound: (value: boolean) => void
  setReduceMotion: (value: boolean) => void
  setHaptics: (value: boolean) => void
  /** Convenience multiplier derived from fontScale. */
  fontMultiplier: number
}

// A real default (not a throw) so consumers like <Text> render correctly even
// before the provider mounts — they simply get the default preferences.
const PreferencesContext = createContext<PreferencesContextValue>({
  ...DEFAULT_PREFERENCES,
  setFontScale: () => {},
  setContrast: () => {},
  setAnswerSound: () => {},
  setReduceMotion: () => {},
  setHaptics: () => {},
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

function isBoolean(value: unknown): value is boolean {
  return typeof value === 'boolean'
}

export function PreferencesProvider({ children }: PropsWithChildren) {
  const [preferences, setPreferences] = useState<Preferences>(DEFAULT_PREFERENCES)

  useEffect(() => {
    let cancelled = false
    
    // Future profile sync mapping note:
    // reduceMotion ↔ web profile "motion: 'reduced'"

    const loadPrefs = async () => {
      try {
        const rawV3 = await AsyncStorage.getItem(STORAGE_KEY)
        if (rawV3) {
          const parsed = JSON.parse(rawV3) as Partial<Preferences>
          if (!cancelled) {
            setPreferences({
              fontScale: isFontScale(parsed.fontScale) ? parsed.fontScale : DEFAULT_PREFERENCES.fontScale,
              contrast: isContrast(parsed.contrast) ? parsed.contrast : DEFAULT_PREFERENCES.contrast,
              answerSound: isBoolean(parsed.answerSound) ? parsed.answerSound : DEFAULT_PREFERENCES.answerSound,
              reduceMotion: isBoolean(parsed.reduceMotion) ? parsed.reduceMotion : DEFAULT_PREFERENCES.reduceMotion,
              haptics: isBoolean(parsed.haptics) ? parsed.haptics : DEFAULT_PREFERENCES.haptics,
            })
          }
          return
        }

        // Migration from v2
        const rawV2 = await AsyncStorage.getItem(LEGACY_STORAGE_KEY_V2)
        if (rawV2) {
          const parsedV2 = JSON.parse(rawV2) as Partial<Preferences>
          const migrated: Preferences = {
            fontScale: isFontScale(parsedV2.fontScale) ? parsedV2.fontScale : DEFAULT_PREFERENCES.fontScale,
            contrast: isContrast(parsedV2.contrast) ? parsedV2.contrast : DEFAULT_PREFERENCES.contrast,
            answerSound: isBoolean(parsedV2.answerSound) ? parsedV2.answerSound : DEFAULT_PREFERENCES.answerSound,
            reduceMotion: DEFAULT_PREFERENCES.reduceMotion,
            haptics: DEFAULT_PREFERENCES.haptics,
          }
          if (!cancelled) {
            setPreferences(migrated)
            await AsyncStorage.setItem(STORAGE_KEY, JSON.stringify(migrated))
          }
        }
      } catch {
        // Storage unavailable or corrupt — keep defaults.
      }
    }
    
    loadPrefs()

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

  const setAnswerSound = useCallback(
    (value: boolean) => persist({ ...preferences, answerSound: value }),
    [persist, preferences],
  )

  const setReduceMotion = useCallback(
    (value: boolean) => persist({ ...preferences, reduceMotion: value }),
    [persist, preferences],
  )

  const setHaptics = useCallback(
    (value: boolean) => persist({ ...preferences, haptics: value }),
    [persist, preferences],
  )

  const value = useMemo<PreferencesContextValue>(
    () => ({
      ...preferences,
      setFontScale,
      setContrast,
      setAnswerSound,
      setReduceMotion,
      setHaptics,
      fontMultiplier: fontScaleMultiplier(preferences.fontScale),
    }),
    [preferences, setFontScale, setContrast, setAnswerSound, setReduceMotion, setHaptics],
  )

  return <PreferencesContext.Provider value={value}>{children}</PreferencesContext.Provider>
}
