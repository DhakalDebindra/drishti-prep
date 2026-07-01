import { View, Modal } from 'react-native'
import { Text } from '../../../components/ui/Text'
import { Button } from '../../../components/ui/Button'

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

  return (
    <Modal visible={visible} transparent animationType="fade">
      <View className="flex-1 justify-center items-center bg-black/50 px-6">
        <View className="w-full max-w-sm rounded-3xl bg-card p-6 shadow-lg">
          <Text variant="h3" className="mb-2">Submit Practice?</Text>
          <Text variant="body" color="muted" className="mb-6">
            You have answered {answeredCount} out of {totalCount} questions.
            {unansweredCount > 0 && ` The remaining ${unansweredCount} question${unansweredCount > 1 ? 's' : ''} will be marked as skipped.`}
          </Text>

          <View className="flex-row gap-3">
            <Button
              title="Cancel"
              variant="outline"
              className="flex-1"
              onPress={onCancel}
              disabled={submitting}
            />
            <Button
              title={submitting ? "Submitting..." : "Submit"}
              className="flex-1"
              onPress={onConfirm}
              loading={submitting}
            />
          </View>
        </View>
      </View>
    </Modal>
  )
}
