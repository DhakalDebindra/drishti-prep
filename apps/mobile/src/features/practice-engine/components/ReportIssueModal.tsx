import { useEffect, useState } from 'react'
import {
  Modal,
  View,
  Pressable,
  TextInput,
  AccessibilityInfo,
  KeyboardAvoidingView,
  Platform,
} from 'react-native'
import { Feather } from '@expo/vector-icons'
import { Text } from '../../../components/ui/Text'
import { Button } from '../../../components/ui/Button'
import { useReportIssue } from '../hooks/useReportIssue'
import { useAccessibilityFocus } from '../../../hooks/useAccessibilityFocus'
import { usePreferences } from '../../../providers/PreferencesProvider'

const ISSUE_TYPES = [
  'Incorrect Answer Key',
  'Outdated Information/Curriculum',
  'Translation or Clarity Issue',
  'Typo or Formatting Error',
  'Other',
]

type ReportIssueModalProps = {
  visible: boolean
  questionId: string | null
  onClose: () => void
}

export function ReportIssueModal({ visible, questionId, onClose }: ReportIssueModalProps) {
  const reportIssue = useReportIssue()
  const { ref: closeRef, focus: focusClose } = useAccessibilityFocus()
  const [issueType, setIssueType] = useState<string | null>(null)
  const [description, setDescription] = useState('')
  const [submitted, setSubmitted] = useState(false)
  const [errorMessage, setErrorMessage] = useState<string | null>(null)
  const { reduceMotion } = usePreferences()

  // Reset transient state each time the modal opens for a (possibly different) question.
  useEffect(() => {
    if (visible) {
      setIssueType(null)
      setDescription('')
      setSubmitted(false)
      setErrorMessage(null)
      requestAnimationFrame(() => focusClose())
    }
  }, [visible, questionId, focusClose])

  // Auto-close shortly after a successful submission.
  useEffect(() => {
    if (!submitted) return
    const timer = setTimeout(onClose, 1500)
    return () => clearTimeout(timer)
  }, [submitted, onClose])

  const handleSubmit = () => {
    if (!questionId || !issueType) return
    setErrorMessage(null)
    reportIssue.mutate(
      { questionId, issueType, description: description.trim() },
      {
        onSuccess: () => {
          setSubmitted(true)
          AccessibilityInfo.announceForAccessibility('Report submitted. Thank you.')
        },
        onError: (err) => {
          const message = err instanceof Error ? err.message : 'Failed to submit report.'
          setErrorMessage(message)
          AccessibilityInfo.announceForAccessibility(message)
        },
      },
    )
  }

  return (
    <Modal visible={visible} transparent animationType={reduceMotion ? 'none' : 'fade'} onRequestClose={onClose}>
      <KeyboardAvoidingView
        behavior={Platform.OS === 'ios' ? 'padding' : undefined}
        className="flex-1 items-center justify-center bg-black/50 px-4"
      >
        <View
          accessibilityViewIsModal
          className="w-full max-w-md overflow-hidden rounded-2xl border border-border bg-card"
        >
          {/* Header */}
          <View className="flex-row items-center justify-between border-b border-border px-5 py-4">
            <Text variant="h3" accessibilityRole="header">
              Report Issue
            </Text>
            <Pressable
              ref={closeRef}
              onPress={onClose}
              accessibilityRole="button"
              accessibilityLabel="Close dialog"
              hitSlop={8}
              className="h-9 w-9 items-center justify-center rounded-full active:bg-muted"
            >
              <Feather name="x" size={20} color="#64748b" />
            </Pressable>
          </View>

          {submitted ? (
            <View className="items-center gap-3 px-5 py-10">
              <Feather name="check-circle" size={44} color="#2563EB" />
              <Text variant="body" color="success" className="text-center font-medium">
                Report submitted. Thank you for helping improve the questions.
              </Text>
            </View>
          ) : (
            <View className="gap-4 px-5 py-5">
              {errorMessage && (
                <View
                  accessibilityRole="alert"
                  className="flex-row items-start gap-2 rounded-lg border border-destructive/30 bg-destructive/10 p-3"
                >
                  <Feather name="alert-circle" size={16} color="#ef4444" style={{ marginTop: 2 }} />
                  <Text variant="bodySmall" color="danger" className="flex-1">
                    {errorMessage}
                  </Text>
                </View>
              )}

              <View>
                <Text variant="caption" className="mb-2 font-semibold text-foreground">
                  Issue type
                </Text>
                <View className="gap-2">
                  {ISSUE_TYPES.map((type) => {
                    const selected = issueType === type
                    return (
                      <Pressable
                        key={type}
                        onPress={() => setIssueType(type)}
                        accessibilityRole="radio"
                        accessibilityState={{ selected }}
                        accessibilityLabel={type}
                        className={`flex-row items-center rounded-xl border px-4 py-3 ${
                          selected ? 'border-primary bg-primary/10' : 'border-border bg-background'
                        }`}
                      >
                        <View
                          className={`mr-3 h-5 w-5 items-center justify-center rounded-full border-2 ${
                            selected ? 'border-primary' : 'border-muted-foreground'
                          }`}
                        >
                          {selected && <View className="h-2.5 w-2.5 rounded-full bg-primary" />}
                        </View>
                        <Text variant="bodySmall" className="flex-1 text-foreground">
                          {type}
                        </Text>
                      </Pressable>
                    )
                  })}
                </View>
              </View>

              <View>
                <Text variant="caption" className="mb-2 font-semibold text-foreground">
                  Additional details <Text variant="caption" color="muted">(optional)</Text>
                </Text>
                <TextInput
                  value={description}
                  onChangeText={setDescription}
                  placeholder="Describe the issue you found with this question..."
                  placeholderTextColor="#94a3b8"
                  multiline
                  numberOfLines={4}
                  accessibilityLabel="Additional details"
                  className="min-h-[88px] rounded-xl border border-border bg-background px-3 py-3 text-foreground"
                  style={{ textAlignVertical: 'top' }}
                />
              </View>

              <View className="flex-row gap-3 pt-1">
                <Button title="Cancel" variant="outline" onPress={onClose} className="flex-1" accessibilityLabel="Cancel, return to results" />
                <Button
                  title="Submit Report"
                  onPress={handleSubmit}
                  loading={reportIssue.isPending}
                  disabled={!issueType || reportIssue.isPending}
                  className="flex-1"
                  accessibilityLabel="Submit report now"
                />
              </View>
            </View>
          )}
        </View>
      </KeyboardAvoidingView>
    </Modal>
  )
}
