import { View, Pressable } from 'react-native'
import { Text } from '../../../components/ui/Text'
import { Badge } from '../../../components/ui/Badge'

type ModuleCardProps = {
  name: string
  subjectCount: number
  setCount: number
  onPress: () => void
}

export function ModuleCard({ name, subjectCount, setCount, onPress }: ModuleCardProps) {
  return (
    <Pressable
      onPress={onPress}
      accessible={true}
      accessibilityRole="button"
      accessibilityLabel={`${name}, ${setCount} sets, ${subjectCount} subjects`}
      className="group/card mb-3 rounded-2xl border border-border bg-card p-5 active:opacity-80 focus:border-ring focus:bg-ring/5"
    >
      <View className="flex-row items-center justify-between">
        <Text variant="h3" className="flex-1 group-focus/card:text-primary">{name}</Text>
        <Text variant="caption" color="muted">{setCount} sets</Text>
      </View>
      <Text variant="caption" color="muted" className="mt-1">{subjectCount} subjects</Text>
    </Pressable>
  )
}

type SubjectCardProps = {
  name: string
  setCount: number
  onPress: () => void
}

export function SubjectCard({ name, setCount, onPress }: SubjectCardProps) {
  return (
    <Pressable
      onPress={onPress}
      accessible={true}
      accessibilityRole="button"
      accessibilityLabel={`${name}, ${setCount} sets`}
      className="group/card mb-3 rounded-2xl border border-border bg-card p-4 active:opacity-80 focus:border-ring focus:bg-ring/5"
    >
      <View className="flex-row items-center justify-between">
        <Text variant="body" className="flex-1 group-focus/card:text-primary">{name}</Text>
        <Badge variant="free" label={`${setCount}`} />
      </View>
    </Pressable>
  )
}

type SetCardProps = {
  title: string
  setType: string
  difficultyLevel: number
  questionCount: number
  status: 'new' | 'in_progress' | 'submitted'
  scorePct: number | null
  onPress: () => void
}

const statusLabel: Record<string, string> = {
  new: 'Start',
  in_progress: 'Resume',
  submitted: 'Review',
}

export function SetCard({ title, setType, difficultyLevel, questionCount, status, scorePct, onPress }: SetCardProps) {
  const difficulty = difficultyLevel === 1 ? 'Basic' : difficultyLevel === 2 ? 'Intermediate' : 'Advanced'
  const scoreLabel = scorePct != null ? `Score ${scorePct} percent. ` : ''

  return (
    <Pressable
      onPress={onPress}
      accessible={true}
      accessibilityRole="button"
      accessibilityLabel={`${title}. ${setType}. ${difficulty}. ${questionCount} questions. ${scoreLabel}${statusLabel[status]}.`}
      className="group/card mb-3 rounded-2xl border border-border bg-card p-4 active:opacity-80 focus:border-ring focus:bg-ring/5"
    >
      <Text variant="body" className="font-medium group-focus/card:text-primary">{title}</Text>
      <View className="mt-1 flex-row items-center gap-3">
        <Text variant="caption" color="muted">{setType}</Text>
        <Text variant="caption" color="muted">{difficulty}</Text>
        <Text variant="caption" color="muted">{questionCount} Q</Text>
      </View>
      <View className="mt-3 flex-row items-center justify-between">
        {scorePct != null && (
          <Text variant="body" color={scorePct >= 60 ? 'success' : 'danger'}>
            {scorePct}%
          </Text>
        )}
        <Text variant="label" color="accent">{statusLabel[status]}</Text>
      </View>
    </Pressable>
  )
}
