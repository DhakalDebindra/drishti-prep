import { useEffect, useRef } from 'react'
import { findNodeHandle, AccessibilityInfo } from 'react-native'

export function useModalFocusReturn(
  visible: boolean,
  triggerRef: React.RefObject<any>,
  delayMs = 350
) {
  const previousVisible = useRef(visible)

  useEffect(() => {
    if (previousVisible.current && !visible) {
      // Modal just closed
      setTimeout(() => {
        const tag = findNodeHandle(triggerRef.current)
        if (tag) {
          AccessibilityInfo.setAccessibilityFocus(tag)
        }
        triggerRef.current?.focus?.()
      }, delayMs)
    }
    previousVisible.current = visible
  }, [visible, triggerRef, delayMs])
}
