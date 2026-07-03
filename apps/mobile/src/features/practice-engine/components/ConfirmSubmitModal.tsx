import { useEffect } from 'react'
import { View, Modal, AccessibilityInfo } from 'react-native'
import { Text } from '../../../components/ui/Text'
import { Button } from '../../../components/ui/Button'
import { useAccessibilityFocus } from '../../../hooks/useAccessibilityFocus'
import { usePreferences } from '../../../providers/PreferencesProvider'

type ConfirmSubmitModalProps = {
  visible: boolean
  answeredCount: number
  totalCount: number
  onConfirm: () => void
  onCancel: () => void
  submitting?: boolean
}

export function ConfirmSubmitModal({
  visible,
  answeredCount,
  totalCount,
  onConfirm,
  onCancel,
  submitting,
}: ConfirmSubmitModalProps) {
  const unansweredCount = totalCount - answeredCount
  const { ref: cancelRef, focus: focusCancel } = useAccessibilityFocus()
  const { reduceMotion } = usePreferences()

  useEffect(() => {
    if (visible) {
      AccessibilityInfo.announceForAccessibility(`Submit practice. You have answered ${answeredCount} out of ${totalCount} questions.`)
      requestAnimationFrame(() => focusCancel())
    }
  }, [visible, focusCancel, answeredCount, totalCount])

  return (
    <Modal visible={visible} transparent animationType={reduceMotion ? 'none' : 'fade'} onRequestClose={onCancel}>
      <View accessibilityViewIsModal className="flex-1 justify-center items-center bg-black/50 px-6">
        <View className="w-full max-w-sm rounded-3xl bg-card p-6 shadow-lg">
          <Text variant="h3" className="mb-2">Submit Practice?</Text>
          <Text variant="body" color="muted" className="mb-6">
            You have answered {answeredCount} out of {totalCount} questions.
            {unansweredCount > 0 && ` The remaining ${unansweredCount} question${unansweredCount > 1 ? 's' : ''} will be marked as skipped.`}
          </Text>

          <View className="flex-row gap-3">
            <Button
              ref={cancelRef}
              title="Cancel"
              variant="outline"
              className="flex-1"
              onPress={onCancel}
              disabled={submitting}
              accessibilityLabel="Cancel, return to practice"
            />
            <Button
              title={submitting ? "Submitting..." : "Submit"}
              className="flex-1"
              onPress={onConfirm}
              loading={submitting}
              accessibilityLabel="Submit test now"
            />
          </View>
        </View>
      </View>
    </Modal>
  )
}
