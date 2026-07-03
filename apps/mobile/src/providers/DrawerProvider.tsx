import {
  createContext,
  useContext,
  useState,
  useCallback,
  useMemo,
  useRef,
  type PropsWithChildren,
} from 'react'

type DrawerContextValue = {
  isOpen: boolean
  open: (onCloseFocus?: () => void) => void
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
  const onCloseFocusRef = useRef<(() => void) | null>(null)
  
  const open = useCallback((onCloseFocus?: () => void) => {
    onCloseFocusRef.current = onCloseFocus ?? null
    setIsOpen(true)
  }, [])
  
  const close = useCallback(() => {
    setIsOpen(false)
    if (onCloseFocusRef.current) {
      // Delay focus restoration slightly to allow drawer animation/unmount
      setTimeout(() => {
        onCloseFocusRef.current?.()
        onCloseFocusRef.current = null
      }, 350)
    }
  }, [])
  
  const value = useMemo(() => ({ isOpen, open, close }), [isOpen, open, close])

  return <DrawerContext.Provider value={value}>{children}</DrawerContext.Provider>
}
