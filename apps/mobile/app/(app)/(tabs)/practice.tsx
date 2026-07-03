import { useState, useRef } from 'react'
import { View, ScrollView, RefreshControl, Pressable, ActivityIndicator } from 'react-native'
import { useRouter, type Router } from 'expo-router'
import { Feather } from '@expo/vector-icons'
import { Text } from '../../../src/components/ui/Text'
import { Badge } from '../../../src/components/ui/Badge'
import { ErrorState } from '../../../src/components/ui/ErrorState'
import { ScreenHeader } from '../../../src/components/ui'
import { useCourses, useCourseDetail, SubjectSection } from '../../../src/features/courses'
import { useRecentAttempts, PracticeSkeleton, type RecentAttempt } from '../../../src/features/practice-engine'
import { BookmarkedQuestionList } from '../../../src/features/bookmarks'
import { useSession } from '../../../src/providers/SessionProvider'
import { useActiveCourse } from '../../../src/providers/ActiveCourseProvider'
import { toLatinNumerals } from '../../../src/lib/devanagari'

type SubTab = 'syllabus' | 'recent' | 'bookmarks'

const MONTHS = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
function formatDate(iso: string | null): string {
  if (!iso) return ''
  const d = new Date(iso)
  if (Number.isNaN(d.getTime())) return ''
  return `${MONTHS[d.getMonth()]} ${d.getDate()}`
}

function SubTabs({ value, onChange }: { value: SubTab; onChange: (v: SubTab) => void }) {
  const tabs: Array<{ key: SubTab; label: string }> = [
    { key: 'syllabus', label: 'Syllabus' },
    { key: 'recent', label: 'Recent' },
    { key: 'bookmarks', label: 'Bookmarks' },
  ]
  return (
    <View className="flex-row gap-2 border-b border-border bg-background px-4 pb-3 pt-2">
      {tabs.map((t) => {
        const active = value === t.key
        return (
          <Pressable
            key={t.key}
            onPress={() => onChange(t.key)}
            accessibilityRole="tab"
            accessibilityState={{ selected: active }}
            className={`flex-1 items-center rounded-xl border-2 py-2.5 ${
              active ? 'border-primary bg-primary' : 'border-foreground/30 bg-card'
            }`}
          >
            <Text
              variant="bodySmall"
              className={`font-bold ${active ? 'text-primary-foreground' : 'text-foreground'}`}
            >
              {t.label}
            </Text>
          </Pressable>
        )
      })}
    </View>
  )
}

function AttemptRow({ attempt, onPress }: { attempt: RecentAttempt; onPress: () => void }) {
  const isSubmitted = attempt.status === 'submitted'
  const title = attempt.question_sets?.title ?? 'Practice set'
  const meta = isSubmitted
    ? `${attempt.question_count ?? 0} questions${attempt.submitted_at ? ` · ${formatDate(attempt.submitted_at)}` : ''}`
    : 'In progress'

  const navigatingRef = useRef(false)
  const handlePress = () => {
    if (navigatingRef.current) return
    navigatingRef.current = true
    setTimeout(() => {
      navigatingRef.current = false
    }, 1000)
    onPress()
  }

  return (
    <Pressable
      onPress={handlePress}
      accessibilityRole="button"
      accessibilityLabel={toLatinNumerals(
        `${title}. ${isSubmitted ? `Completed, score ${attempt.score_pct ?? 0} percent. Tap to review.` : 'In progress. Tap to resume.'}`,
      )}
      className="mb-2 flex-row items-center rounded-2xl border-2 border-border bg-card px-4 py-3.5 active:bg-muted"
    >
      <View
        className="mr-3 h-10 w-10 items-center justify-center rounded-full bg-primary/15"
        importantForAccessibility="no-hide-descendants"
      >
        <Feather name={isSubmitted ? 'check-circle' : 'play'} size={18} className="text-primary" />
      </View>
      <View className="mr-3 flex-1">
        <Text variant="bodySmall" className="font-semibold" numberOfLines={2}>
          {title}
        </Text>
        <Text variant="caption" color="muted" className="mt-0.5">
          {meta}
        </Text>
      </View>
      <Badge
        variant={isSubmitted ? 'submitted' : 'inProgress'}
        label={isSubmitted ? `${attempt.score_pct ?? 0}%` : 'Resume'}
      />
      <Feather name="chevron-right" size={20} className="ml-2 text-muted-foreground" />
    </Pressable>
  )
}

function BrowseCoursesCTA({ router, label, subtitle }: { router: Router; label: string; subtitle?: string }) {
  return (
    <Pressable
      onPress={() => router.push('/(app)/(tabs)/dashboard')}
      accessibilityRole="button"
      accessibilityLabel="Browse all courses"
      className="flex-row items-center rounded-2xl border-2 border-primary bg-primary/10 p-5 active:opacity-80"
    >
      <Feather name="compass" size={24} className="text-primary" />
      <View className="ml-3 flex-1">
        <Text variant="h3" className="text-primary">
          {label}
        </Text>
        {subtitle && (
          <Text variant="caption" color="muted" className="mt-0.5">
            {subtitle}
          </Text>
        )}
      </View>
      <Feather name="chevron-right" size={22} className="text-primary" />
    </Pressable>
  )
}

export default function StudyScreen() {
  const { user } = useSession()
  const router = useRouter()
  const [subTab, setSubTab] = useState<SubTab>('syllabus')
  const { activeSlug: ctxSlug } = useActiveCourse()

  // Enrolled = approved OR universal/free. The active course is chosen in the
  // drawer / course detail (ActiveCourseProvider); fall back to the first enrolled.
  const coursesQ = useCourses(user?.id ?? '')
  const attemptsQ = useRecentAttempts(user?.id ?? '')

  const enrolled = coursesQ.data?.enrolled ?? []
  const activeSlug = enrolled.find((c) => c.slug === ctxSlug)?.slug ?? enrolled[0]?.slug ?? ''
  const courseQ = useCourseDetail(activeSlug, user?.id ?? '')

  if (!user) return null

  const attempts = (attemptsQ.data ?? []) as RecentAttempt[]
  const inProgress = attempts.filter((a) => a.status === 'in_progress')
  const completed = attempts.filter((a) => a.status === 'submitted')

  return (
    <View className="flex-1 bg-background">
      <ScreenHeader title="Study" />
      <SubTabs value={subTab} onChange={setSubTab} />

      {subTab === 'syllabus' && (
        <ScrollView
          className="flex-1"
          contentContainerClassName="px-4 pb-10 pt-4"
          refreshControl={
            <RefreshControl
              refreshing={coursesQ.isRefetching || courseQ.isRefetching}
              onRefresh={() => {
                coursesQ.refetch()
                courseQ.refetch()
              }}
              tintColor="#2563EB"
            />
          }
        >
          {coursesQ.isLoading ? (
            <View className="items-center py-10">
              <ActivityIndicator size="large" color="#2563EB" />
            </View>
          ) : enrolled.length === 0 ? (
            <View className="gap-4">
              <Text variant="body" color="muted">
                You are not enrolled in a course yet. Browse the catalog to start studying.
              </Text>
              <BrowseCoursesCTA router={router} label="Browse courses" subtitle="Find a course to study" />
            </View>
          ) : (
            <>
              {/* Active course syllabus (switch courses from the Profile drawer) */}
              <View className="mb-3">
                <Text variant="h2">{courseQ.data?.module.name ?? 'Syllabus'}</Text>
                {courseQ.data && (
                  <Text variant="caption" color="muted" className="mt-1">
                    {courseQ.data.completed_sets}/{courseQ.data.total_sets} sets completed
                  </Text>
                )}
              </View>

              {courseQ.isLoading ? (
                <View className="items-center py-10">
                  <ActivityIndicator size="large" color="#2563EB" />
                </View>
              ) : courseQ.isError ? (
                <ErrorState
                  message={courseQ.error instanceof Error ? courseQ.error.message : 'Failed to load the syllabus.'}
                  onRetry={() => courseQ.refetch()}
                />
              ) : (
                (courseQ.data?.subjects ?? []).map((subject, index) => (
                  <SubjectSection
                    key={subject.id}
                    name={subject.name}
                    topics={subject.topics}
                    defaultExpanded={index === 0}
                  />
                ))
              )}
            </>
          )}
        </ScrollView>
      )}

      {subTab === 'recent' && (
        <ScrollView
          className="flex-1"
          contentContainerClassName="px-4 pb-10 pt-4"
          refreshControl={
            <RefreshControl refreshing={attemptsQ.isRefetching} onRefresh={() => attemptsQ.refetch()} tintColor="#2563EB" />
          }
        >
          {attemptsQ.isLoading ? (
            <View className="items-center py-10">
              <ActivityIndicator size="large" color="#2563EB" />
            </View>
          ) : attempts.length === 0 ? (
            <View className="items-center py-12">
              <Feather name="clock" size={32} className="text-muted-foreground" />
              <Text variant="h3" color="secondary" className="mt-3">
                No practice yet
              </Text>
              <Text variant="bodySmall" color="muted" className="mt-1 text-center">
                Open the Syllabus tab and pick a set to start practicing.
              </Text>
            </View>
          ) : (
            <>
              {inProgress.length > 0 && (
                <View className="mb-5">
                  <Text variant="h3" className="mb-3">
                    Continue
                  </Text>
                  {inProgress.map((a) => (
                    <AttemptRow key={a.id} attempt={a} onPress={() => router.push(`/(app)/practice/${a.set_id}`)} />
                  ))}
                </View>
              )}
              {completed.length > 0 && (
                <View>
                  <Text variant="h3" className="mb-3">
                    Results
                  </Text>
                  {completed.map((a) => (
                    <AttemptRow
                      key={a.id}
                      attempt={a}
                      onPress={() => router.push(`/(app)/practice/${a.set_id}/review?attemptId=${a.id}`)}
                    />
                  ))}
                </View>
              )}
            </>
          )}
        </ScrollView>
      )}

      {subTab === 'bookmarks' && <BookmarkedQuestionList userId={user.id} />}
    </View>
  )
}
