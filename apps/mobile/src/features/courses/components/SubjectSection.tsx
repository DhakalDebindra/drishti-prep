import { useState, useRef } from 'react'
import { View, Pressable } from 'react-native'
import { useRouter } from 'expo-router'
import { Feather } from '@expo/vector-icons'
import { Text } from '../../../components/ui/Text'
import { Badge } from '../../../components/ui/Badge'
import { ProgressBar } from '../../../components/ui/ProgressBar'
import { ExpandableText } from '../../../components/ui/ExpandableText'
import { toLatinNumerals } from '../../../lib/devanagari'
import type { TopicWithSets, SetWithAttempt } from '../hooks/useCourseDetail'

type SubjectSectionProps = {
  name: string
  topics: TopicWithSets[]
  /** Expand on first render (e.g. the first subject of a course). */
  defaultExpanded?: boolean
}

function SetRow({ set }: { set: SetWithAttempt }) {
  const router = useRouter()
  const isSubmitted = set.attempt_status === 'submitted'
  const isInProgress = set.attempt_status === 'in_progress'

  const badge = isSubmitted
    ? { label: `${set.score_pct ?? 0}%`, variant: 'submitted' as const }
    : isInProgress
      ? { label: 'Resume', variant: 'inProgress' as const }
      : { label: 'Practice', variant: 'default' as const }

  const statusSpoken = isSubmitted
    ? `Completed, score ${set.score_pct ?? 0} percent`
    : isInProgress
      ? 'In progress, tap to resume'
      : 'Tap to start practice'

  const navigatingRef = useRef(false)
  const onPress = () => {
    if (navigatingRef.current) return
    navigatingRef.current = true
    setTimeout(() => {
      navigatingRef.current = false
    }, 1000)

    if (isSubmitted && set.attempt_id) {
      router.push(`/(app)/practice/${set.id}/review?attemptId=${set.attempt_id}`)
    } else {
      router.push(`/(app)/practice/${set.id}`)
    }
  }

  return (
    <Pressable
      onPress={onPress}
      accessibilityRole="button"
      accessibilityLabel={toLatinNumerals(`${set.title}. ${statusSpoken}.`)}
      className="mb-2 flex-row items-center rounded-xl border-2 border-border bg-background px-4 py-3.5 active:bg-muted"
    >
      <View className="mr-3 flex-1">
        <Text variant="bodySmall" className="font-semibold" numberOfLines={2}>
          {set.title}
        </Text>
        {set.set_type === 'mock_exam' && (
          <Text variant="caption" color="muted" className="mt-0.5">
            Mock exam
          </Text>
        )}
      </View>
      <Badge variant={badge.variant} label={badge.label} />
      <Feather name="chevron-right" size={20} className="ml-2 text-muted-foreground" />
    </Pressable>
  )
}

export function SubjectSection({ name, topics, defaultExpanded = false }: SubjectSectionProps) {
  const topicsWithSets = topics.filter((t) => (t.question_sets?.length ?? 0) > 0)
  const [expanded, setExpanded] = useState(defaultExpanded)

  if (topicsWithSets.length === 0) return null

  const allSets = topicsWithSets.flatMap((t) => t.question_sets ?? [])
  const completed = allSets.filter((s) => s.attempt_status === 'submitted').length
  const total = allSets.length

  return (
    <View className="mb-3 overflow-hidden rounded-2xl border-2 border-border bg-card">
      <Pressable
        onPress={() => setExpanded((v) => !v)}
        accessibilityRole="button"
        accessibilityState={{ expanded }}
        accessibilityLabel={toLatinNumerals(
          `${name}. ${completed} of ${total} sets completed. ${expanded ? 'Expanded' : 'Collapsed'}. Double tap to ${expanded ? 'collapse' : 'expand'}.`,
        )}
        className="flex-row items-center p-4 active:bg-muted"
      >
        <View className="flex-1 pr-3">
          <Text variant="h3">{name}</Text>
          <View className="mt-2 flex-row items-center gap-3">
            <ProgressBar value={total > 0 ? (completed / total) * 100 : 0} className="h-2 flex-1" />
            <Text variant="caption" color="muted">
              {completed}/{total}
            </Text>
          </View>
        </View>
        <Feather name={expanded ? 'chevron-up' : 'chevron-down'} size={24} className="text-foreground" />
      </Pressable>

      {expanded && (
        <View className="border-t-2 border-border px-3 pb-3 pt-1">
          {topicsWithSets.map((topic) => {
            const sets = topic.question_sets ?? []
            const topicCompleted = sets.filter((s) => s.attempt_status === 'submitted').length

            return (
              <View key={topic.id} className="mt-3">
                <View className="mb-2 flex-row items-center justify-between">
                  <Text variant="bodySmall" className="flex-1 pr-2 font-bold">
                    {topic.name}
                  </Text>
                  <Badge variant="default" label={`${topicCompleted}/${sets.length}`} />
                </View>
                {sets.map((set) => (
                  <SetRow key={set.id} set={set} />
                ))}
              </View>
            )
          })}
        </View>
      )}
    </View>
  )
}

type CourseHeaderProps = {
  name: string
  description: string | null
  totalSets: number
  completedSets: number
  onBack: () => void
}

export function CourseHeader({ name, description, totalSets, completedSets, onBack }: CourseHeaderProps) {
  return (
    <View className="mb-6">
      <Pressable
        onPress={onBack}
        accessibilityRole="button"
        accessibilityLabel="Back to courses"
        className="mb-3 flex-row items-center self-start rounded-xl border-2 border-foreground/40 bg-card px-3 py-2 active:bg-muted"
      >
        <Feather name="arrow-left" size={18} className="text-foreground" />
        <Text variant="bodySmall" className="ml-1 font-bold text-foreground">
          Courses
        </Text>
      </Pressable>
      <Text variant="h2">{name}</Text>
      {description && (
        <ExpandableText variant="body" color="muted" className="mt-1" numberOfLines={3}>
          {description}
        </ExpandableText>
      )}
      <View className="mt-3 flex-row items-center gap-4">
        <View className="flex-row items-center gap-1">
          <Text variant="caption" color="muted">
            Progress
          </Text>
          <Text variant="body">
            {completedSets}/{totalSets}
          </Text>
        </View>
        <ProgressBar
          value={totalSets > 0 ? (completedSets / totalSets) * 100 : 0}
          className="h-2 flex-1"
        />
      </View>
    </View>
  )
}
