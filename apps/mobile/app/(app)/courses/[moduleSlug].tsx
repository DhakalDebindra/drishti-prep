import { View, ScrollView, RefreshControl } from 'react-native'
import { useRouter, useLocalSearchParams, Stack } from 'expo-router'
import { useSafeAreaInsets } from 'react-native-safe-area-context'
import { Text, ErrorState, Button } from '../../../src/components/ui'
import {
  useCourseDetail,
  useCourses,
  SubjectSection,
  CourseHeader,
  CourseDetailSkeleton,
} from '../../../src/features/courses'
import { useSession } from '../../../src/providers/SessionProvider'
import { useActiveCourse } from '../../../src/providers/ActiveCourseProvider'

export default function CourseDetailScreen() {
  const { moduleSlug } = useLocalSearchParams<{ moduleSlug: string }>()
  const { user } = useSession()
  const router = useRouter()
  const insets = useSafeAreaInsets()
  const { data, isLoading, isError, error, refetch, isRefetching } = useCourseDetail(moduleSlug, user?.id ?? '')
  const coursesQ = useCourses(user?.id ?? '')
  const { setActiveSlug } = useActiveCourse()

  if (!user) return <View className="flex-1 bg-background" />
  if (isLoading) return <CourseDetailSkeleton />
  if (isError || !data) return <ErrorState message={error?.message} onRetry={() => refetch()} />

  const meta = [...(coursesQ.data?.enrolled ?? []), ...(coursesQ.data?.available ?? [])].find(
    (c) => c.slug === moduleSlug,
  )
  const isUniversal = data.module.is_universal
  const isEnrolled = meta ? meta.enrollment_status === 'approved' || meta.is_universal : isUniversal
  const isFree = isUniversal || data.module.price_paisa == null
  const priceLabel = `NPR ${((data.module.price_paisa ?? 0) / 100).toLocaleString()}`

  const studyThis = () => {
    setActiveSlug(moduleSlug)
    router.replace('/(app)/(tabs)/practice')
  }

  return (
    <View className="flex-1 bg-background">
      <Stack.Screen options={{ headerShown: false }} />

      <ScrollView
        className="flex-1"
        contentContainerClassName="px-4 pb-8 pt-14"
        refreshControl={<RefreshControl refreshing={isRefetching} onRefresh={() => refetch()} />}
      >
        <CourseHeader
          name={data.module.name}
          description={data.module.description}
          totalSets={data.total_sets}
          completedSets={data.completed_sets}
          onBack={() => router.back()}
        />

        {data.subjects.map((subject, index) => (
          <SubjectSection
            key={subject.id}
            name={subject.name}
            topics={subject.topics}
            defaultExpanded={index === 0}
          />
        ))}
      </ScrollView>

      {/* Bottom CTA — where enroll / study actually happens */}
      <View
        className="border-t-2 border-border bg-card px-4 pt-3"
        style={{ paddingBottom: insets.bottom + 12 }}
      >
        {isEnrolled ? (
          <Button title="Study this course" size="lg" onPress={studyThis} />
        ) : (
          <>
            <Button title={isFree ? 'Get course — Free' : `Get course — ${priceLabel}`} size="lg" disabled />
            <Text variant="caption" color="muted" className="mt-2 text-center">
              {isFree ? 'Enrollment will be available soon.' : 'In-app payment is coming soon.'}
            </Text>
          </>
        )}
      </View>
    </View>
  )
}
