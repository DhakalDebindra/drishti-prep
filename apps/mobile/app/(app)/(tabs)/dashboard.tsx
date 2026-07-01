import { View, ScrollView, RefreshControl, ActivityIndicator } from 'react-native'
import { useRouter } from 'expo-router'
import { useSession } from '../../../src/providers/SessionProvider'
import { useProfile } from '../../../src/features/profile'
import { useCourses, CourseCard } from '../../../src/features/courses'
import { IdentityBanner } from '../../../src/features/dashboard'
import { Text, ErrorState, ScreenHeader, Card } from '../../../src/components/ui'

export default function HomeScreen() {
  const { user } = useSession()
  const router = useRouter()
  const profileQ = useProfile(user?.id ?? '')
  const coursesQ = useCourses(user?.id ?? '')

  if (!user) return <View className="flex-1 bg-background" />

  const status = (profileQ.data?.disability_status ?? 'not_submitted') as
    | 'not_submitted'
    | 'pending'
    | 'approved'
    | 'rejected'
  // enrolled + available are disjoint; together they are the full catalog.
  const allCourses = [...(coursesQ.data?.enrolled ?? []), ...(coursesQ.data?.available ?? [])]

  return (
    <View className="flex-1 bg-background">
      <ScreenHeader title="Home" />
      <ScrollView
        className="flex-1"
        contentContainerClassName="px-4 pb-8 pt-4"
        refreshControl={
          <RefreshControl refreshing={coursesQ.isRefetching} onRefresh={() => coursesQ.refetch()} tintColor="#2563EB" />
        }
      >
        {status !== 'approved' && (
          <View className="mb-4">
            <IdentityBanner
              disabilityStatus={status}
              rejectionReason={profileQ.data?.disability_rejection_reason ?? null}
            />
          </View>
        )}

        <Text variant="h2" className="mb-1">
          Courses
        </Text>
        <Text variant="bodySmall" color="muted" className="mb-4">
          Tap a course to see details and get started.
        </Text>

        {coursesQ.isLoading ? (
          <View className="items-center py-10">
            <ActivityIndicator size="large" color="#2563EB" />
          </View>
        ) : coursesQ.isError ? (
          <ErrorState
            message={coursesQ.error instanceof Error ? coursesQ.error.message : 'Failed to load courses.'}
            onRetry={() => coursesQ.refetch()}
          />
        ) : allCourses.length === 0 ? (
          <Card>
            <Text variant="bodySmall" color="muted">
              No courses available yet.
            </Text>
          </Card>
        ) : (
          allCourses.map((course) => (
            <CourseCard
              key={course.id}
              name={course.name}
              isUniversal={course.is_universal}
              pricePaisa={course.price_paisa}
              enrollmentStatus={course.enrollment_status}
              onPress={() => router.push(`/(app)/courses/${course.slug}`)}
            />
          ))
        )}
      </ScrollView>
    </View>
  )
}
