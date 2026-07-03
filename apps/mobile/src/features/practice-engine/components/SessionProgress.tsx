import { View, Pressable } from 'react-native'
import { Feather } from '@expo/vector-icons'
import { Text } from '../../../components/ui/Text'
import { ProgressBar } from '../../../components/ui/ProgressBar'

type SessionProgressProps = {
  title?: string
  answeredCount: number
  totalCount: number
  /** 1-based index of the question on screen — shown as "Question X of Y". */
  currentNumber?: number
  onBack: () => void
}

export function SessionProgress({
  title = 'Practice Session',
  answeredCount,
  totalCount,
  currentNumber,
  onBack,
}: SessionProgressProps) {
  const progress = totalCount > 0 ? (answeredCount / totalCount) * 100 : 0

  return (
    <View className="border-b-2 border-border bg-card px-4 pb-4 pt-12">
      <View className="mb-3 flex-row items-center">
        <Pressable
          onPress={onBack}
          accessibilityRole="button"
          accessibilityLabel="Go back"
          hitSlop={8}
          className="mr-3 h-11 flex-row items-center rounded-xl border-2 border-foreground/40 bg-background px-3 active:bg-muted focus:border-ring"
        >
          <Feather name="arrow-left" size={20} className="text-foreground" />
          <Text className="ml-1 font-bold text-foreground">Back</Text>
        </Pressable>
        <View className="flex-1">
          <Text variant="body" className="font-bold text-foreground" numberOfLines={1}>
            {title}
          </Text>
          <Text variant="caption" color="muted">
            {currentNumber ? `Question ${currentNumber} of ${totalCount}` : `${answeredCount}/${totalCount} answered`}
          </Text>
        </View>
      </View>
      <ProgressBar value={progress} className="h-4" accessibilityLabel={`${answeredCount} of ${totalCount} answered`} />
    </View>
  )
}
