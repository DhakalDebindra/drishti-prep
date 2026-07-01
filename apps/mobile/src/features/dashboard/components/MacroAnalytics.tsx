import { View, Text } from 'react-native'
import { Card, Text as AppText } from '../../../components/ui'

interface AttemptRow {
  id: string
  set_id: string
  question_count: number | null
  score_raw: number | null
  status: string
}

export function MacroAnalytics({ attempts }: { attempts: AttemptRow[] }) {
  const completed = attempts.filter((a) => a.status === 'submitted')

  const bestPerSet = completed.reduce<Record<string, AttemptRow>>((acc, cur) => {
    const existing = acc[cur.set_id]
    if (!existing || (cur.score_raw ?? 0) > (existing.score_raw ?? 0)) {
      acc[cur.set_id] = cur
    }
    return acc
  }, {})

  const unique = Object.values(bestPerSet)
  const totalQuestions = unique.reduce((sum, a) => sum + (a.question_count ?? 0), 0)
  const totalCorrect = unique.reduce((sum, a) => sum + (a.score_raw ?? 0), 0)
  const accuracy = totalQuestions > 0 ? Math.round((totalCorrect / totalQuestions) * 100) : 0

  return (
    <View className="flex-row gap-3">
      <Card variant="default" className="flex-1">
        <View className="mb-3 h-10 w-10 items-center justify-center rounded-xl bg-blue-500/10">
          <Text className="text-xl text-blue-600 dark:text-blue-400">{'\u2B22'}</Text>
        </View>
        <AppText variant="label" color="muted">Questions Practiced</AppText>
        <AppText variant="statistic" color="default" className="mt-1">{totalQuestions}</AppText>
      </Card>

      <Card variant="success" className="flex-1">
        <View className="mb-3 h-10 w-10 items-center justify-center rounded-xl bg-emerald-500/10">
          <Text className="text-xl text-emerald-600 dark:text-emerald-400">{'\u2713'}</Text>
        </View>
        <AppText variant="label" color="success">Overall Accuracy</AppText>
        <AppText variant="statistic" color="success" className="mt-1">{accuracy}%</AppText>
      </Card>

      <Card variant="info" className="flex-1">
        <View className="mb-3 h-10 w-10 items-center justify-center rounded-xl bg-cyan-500/10">
          <Text className="text-xl text-cyan-600 dark:text-cyan-400">{'\u2197'}</Text>
        </View>
        <AppText variant="label" color="muted">Active Study Days</AppText>
        <AppText variant="statistic" color="default" className="mt-1">7</AppText>
      </Card>
    </View>
  )
}
