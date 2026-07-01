import {
  createContext,
  useContext,
  useState,
  useCallback,
  useMemo,
  useEffect,
  type PropsWithChildren,
} from 'react'
import AsyncStorage from '@react-native-async-storage/async-storage'

/**
 * The course the Study tab is currently showing. Set from the course detail
 * "Study this course" CTA and from the drawer's course switcher — never by the
 * mere act of enrolling. Persisted so it survives restarts.
 */
type ActiveCourseContextValue = {
  activeSlug: string | null
  setActiveSlug: (slug: string) => void
}

const ActiveCourseContext = createContext<ActiveCourseContextValue>({
  activeSlug: null,
  setActiveSlug: () => {},
})

export function useActiveCourse() {
  return useContext(ActiveCourseContext)
}

const STORAGE_KEY = 'dp.activeCourse.v1'

export function ActiveCourseProvider({ children }: PropsWithChildren) {
  const [activeSlug, setActiveSlugState] = useState<string | null>(null)

  useEffect(() => {
    let cancelled = false
    AsyncStorage.getItem(STORAGE_KEY)
      .then((raw) => {
        if (!cancelled && raw) setActiveSlugState(raw)
      })
      .catch(() => {})
    return () => {
      cancelled = true
    }
  }, [])

  const setActiveSlug = useCallback((slug: string) => {
    setActiveSlugState(slug)
    AsyncStorage.setItem(STORAGE_KEY, slug).catch(() => {})
  }, [])

  const value = useMemo(() => ({ activeSlug, setActiveSlug }), [activeSlug, setActiveSlug])

  return <ActiveCourseContext.Provider value={value}>{children}</ActiveCourseContext.Provider>
}
