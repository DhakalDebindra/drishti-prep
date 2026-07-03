import { useRef, useCallback } from 'react'
import { AccessibilityInfo, findNodeHandle } from 'react-native'

export function useAccessibilityFocus() {
  const ref = useRef<any>(null)

  const focus = useCallback(() => {
    const reactTag = findNodeHandle(ref.current)
    if (reactTag) {
      AccessibilityInfo.setAccessibilityFocus(reactTag)
    }
  }, [])

  return { ref, focus }
}
