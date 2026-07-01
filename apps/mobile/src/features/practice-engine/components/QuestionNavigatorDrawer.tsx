import { ScrollView, Pressable, View, Modal, TouchableWithoutFeedback } from 'react-native'
import { Feather } from '@expo/vector-icons'
import { Text } from '../../../components/ui/Text'

type QuestionNavigatorDrawerProps = {
  visible: boolean
  onClose: () => void
  totalQuestions: number
  currentIndex: number
  answeredIndices: Set<number>
  onSelect: (index: number) => void
}

function LegendItem({ swatch, label }: { swatch: string; label: string }) {
  return (
    <View className="flex-row items-center gap-2">
      <View className={`h-5 w-5 rounded-md border-2 ${swatch}`} />
      <Text variant="caption" color="muted">
        {label}
      </Text>
    </View>
  )
}

export function QuestionNavigatorDrawer({
  visible,
  onClose,
  totalQuestions,
  currentIndex,
  answeredIndices,
  onSelect,
}: QuestionNavigatorDrawerProps) {
  return (
    <Modal visible={visible} transparent animationType="slide" onRequestClose={onClose}>
      <TouchableWithoutFeedback onPress={onClose}>
        <View className="flex-1 justify-end bg-black/60">
          <TouchableWithoutFeedback>
            <View className="max-h-[80%] rounded-t-3xl border-t-2 border-border bg-card pb-12 pt-6">
              <View className="mb-4 flex-row items-center justify-between px-6">
                <Text variant="h3">Jump to question</Text>
                <Pressable
                  onPress={onClose}
                  accessibilityRole="button"
                  accessibilityLabel="Close"
                  className="h-11 flex-row items-center rounded-xl border-2 border-foreground/40 bg-background px-4 active:bg-muted"
                >
                  <Feather name="x" size={18} className="text-foreground" />
                  <Text className="ml-1 font-bold text-foreground">Close</Text>
                </Pressable>
              </View>

              {/* Legend so the colour coding is explained, not just implied */}
              <View className="mb-4 flex-row flex-wrap gap-x-5 gap-y-2 px-6">
                <LegendItem swatch="bg-primary border-primary" label="Current" />
                <LegendItem swatch="bg-primary/25 border-primary" label="Answered" />
                <LegendItem swatch="bg-muted border-foreground/40" label="Not answered" />
              </View>

              <ScrollView showsVerticalScrollIndicator={false} contentContainerClassName="px-6 pb-8">
                <View className="flex-row flex-wrap gap-3">
                  {Array.from({ length: totalQuestions }).map((_, i) => {
                    const isCurrent = i === currentIndex
                    const isAnswered = answeredIndices.has(i)

                    let cellClass = 'bg-muted border-foreground/40'
                    let textClass = 'text-foreground'
                    if (isCurrent) {
                      cellClass = 'bg-primary border-primary'
                      textClass = 'text-primary-foreground'
                    } else if (isAnswered) {
                      cellClass = 'bg-primary/25 border-primary'
                      textClass = 'text-foreground'
                    }

                    return (
                      <Pressable
                        key={i}
                        onPress={() => {
                          onSelect(i)
                          onClose()
                        }}
                        accessibilityRole="button"
                        accessibilityLabel={`Question ${i + 1}${isCurrent ? ', current' : ''}. ${
                          isAnswered ? 'Answered' : 'Not answered'
                        }.`}
                        className={`h-14 w-14 items-center justify-center rounded-xl border-2 ${cellClass} active:opacity-80`}
                      >
                        <Text className={`text-[17px] font-bold ${textClass}`}>{i + 1}</Text>
                      </Pressable>
                    )
                  })}
                </View>
              </ScrollView>
            </View>
          </TouchableWithoutFeedback>
        </View>
      </TouchableWithoutFeedback>
    </Modal>
  )
}
