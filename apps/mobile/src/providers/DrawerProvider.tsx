import {
  createContext,
  useContext,
  useState,
  useCallback,
  useMemo,
  type PropsWithChildren,
} from 'react'

type DrawerContextValue = {
  isOpen: boolean
  open: () => void
  close: () => void
}

const DrawerContext = createContext<DrawerContextValue>({
  isOpen: false,
  open: () => {},
  close: () => {},
})

export function useDrawer() {
  return useContext(DrawerContext)
}

/** Controls the left-side "Profile" navigation drawer (see AppDrawer). */
export function DrawerProvider({ children }: PropsWithChildren) {
  const [isOpen, setIsOpen] = useState(false)
  const open = useCallback(() => setIsOpen(true), [])
  const close = useCallback(() => setIsOpen(false), [])
  const value = useMemo(() => ({ isOpen, open, close }), [isOpen, open, close])

  return <DrawerContext.Provider value={value}>{children}</DrawerContext.Provider>
}
