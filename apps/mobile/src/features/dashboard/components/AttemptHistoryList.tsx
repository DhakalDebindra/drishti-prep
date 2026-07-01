import { View, Text, Pressable } from 'react-native'
import { Text as AppText, Badge } from '../../../components/ui'
import { useRouter } from 'expo-router'

interface SetInfo {
  title: string
  topic: {
    name: string
    slug: string
    subject: {
      name: string
      slug: string
      module: { slug: string }
    }
  }
}

interface AttemptWithSet {
  id: string
  set_id: string
  status: string
  score_raw: number | null
  score_pct: number | null
  submitted_at: string | null
  started_at: string | null
  question_sets: SetInfo | null
}

export function AttemptHistoryList({ attempts }: { attempts: AttemptWithSet[] }) {
  const router = useRouter()
  const completed = attempts.filter((a) => a.status === 'submitted' && a.question_sets)

  if (completed.length === 0) {
    return (
      <View className="rounded-2xl border border-border bg-card p-8">
        <AppText variant="body" color="muted" className="text-center">
          You haven't completed any practice sets yet.
        </AppText>
      </View>
    )
  }

  const grouped = completed.reduce<Record<string, AttemptWithSet[]>>((acc, a) => {
    if (!acc[a.set_id]) acc[a.set_id] = []
    acc[a.set_id].push(a)
    return acc
  }, {})

  const formatDate = (dateStr: string | null) => {
    if (!dateStr) return 'Unknown'
    const d = new Date(dateStr)
    return d.toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' })
  }

  return (
    <View className="overflow-hidden rounded-2xl border border-border bg-card">
      <View className="border-b border-border px-5 py-4">
        <AppText variant="label" color="muted">Active Practice Sets</AppText>
        <AppText variant="caption" color="muted" className="mt-1">
          Your recent practice sessions across all courses.
        </AppText>
      </View>

      <View className="divide-y divide-border">
        {Object.values(grouped).map((group) => {
          const latest = group[0]
          const previous = group.length > 1 ? group[1] : null
          const subject = latest.question_sets?.topic.subject.name ?? ''
          const topic = latest.question_sets?.topic.name ?? ''
          const title = latest.question_sets?.title ?? ''
          const score = Math.round(latest.score_pct ?? 0)

          let diff = null
          if (previous) {
            const prevScore = Math.round(previous.score_pct ?? 0)
            const d = score - prevScore
            if (d > 0) diff = { text: `+${d}% vs last`, up: true }
            else if (d < 0) diff = { text: `${d}% vs last`, up: false }
            else diff = { text: 'No change', up: null }
          } else {
            diff = { text: 'First attempt', up: null }
          }

          return (
            <Pressable
              key={latest.set_id}
              onPress={() => {
                const s = latest.question_sets
                if (s) {
                  router.push(
                    `/(app)/courses/${s.topic.subject.module.slug}/${s.topic.subject.slug}/${s.topic.slug}/practice/${latest.set_id}/review?attemptId=${latest.id}`
                  )
                }
              }}
              className="flex-row items-center justify-between px-5 py-4 active:bg-muted/40"
            >
              <View className="flex-1 pr-4">
                <View className="mb-2 flex-row flex-wrap items-center gap-2">
                  <Badge variant="submitted" label={`${subject} \u00B7 ${topic}`} />
                  <AppText variant="caption" color="muted">
                    {formatDate(latest.submitted_at)}
                  </AppText>
                </View>
                <AppText variant="body" color="default" className="font-semibold">
                  {title}
                </AppText>
              </View>

              <View className="items-end">
                <AppText variant="statistic" color="default">{score}%</AppText>
                <View className="mt-1 flex-row items-center gap-1">
                  {diff.up === true && (
                    <Text className="text-sm text-emerald-600 dark:text-emerald-400">{'\u2191'}</Text>
                  )}
                  {diff.up === false && (
                    <Text className="text-sm text-red-600 dark:text-red-400">{'\u2193'}</Text>
                  )}
                  {diff.up === null && diff.text !== 'First attempt' && (
                    <Text className="text-sm text-muted-foreground">{'\u2014'}</Text>
                  )}
                  <AppText
                    variant="caption"
                    color={
                      diff.up === true ? 'success' : diff.up === false ? 'danger' : 'muted'
                    }
                  >
                    {diff.text}
                  </AppText>
                </View>
              </View>
            </Pressable>
          )
        })}
      </View>
    </View>
  )
}
