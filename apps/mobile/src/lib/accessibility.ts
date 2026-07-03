import { AccessibilityInfo } from 'react-native'

/**
 * Convenience utility to announce messages to screen readers.
 * Use for transient feedback (like toggling a switch) rather than static labels.
 */
export function announce(message: string) {
  AccessibilityInfo.announceForAccessibility(message)
}
