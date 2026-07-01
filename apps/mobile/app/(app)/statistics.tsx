import { ScrollView, View } from 'react-native'
import { Stack } from 'expo-router'
import { Feather } from '@expo/vector-icons'
import { useSession } from '../../src/providers/SessionProvider'
import { useDashboardData, MacroAnalytics, DashboardSkeleton } from '../../src/features/dashboard'
import { BackHeader, ErrorState, Card, Text } from '../../src/components/ui'

function StatCell({
  icon,
  value,
  label,
}: {
  icon: keyof typeof Feather.glyphMap
  value: number
  label: string
}) {
  return (
    <View accessible accessibilityLabel={`${value} ${label}`} className="flex-1 items-center">
      <Feather name={icon} size={18} className="text-primary" />
      <Text variant="h3" className="mt-1">
        {value}
      </Text>
      <Text variant="caption" color="muted" className="text-center">
        {label}
      </Text>
    </View>
  )
}

export default function StatisticsScreen() {
  const { user } = useSession()
  const { data, isLoading, isError, error, refetch } = useDashboardData(user?.id ?? '')

  if (!user) return <View className="flex-1 bg-background" />

  const profile = data?.profile
  const attempts = data?.attempts ?? []

  return (
    <View className="flex-1 bg-background">
      <Stack.Screen options={{ headerShown: false }} />
      <BackHeader title="Statistics" />

      {isLoading ? (
        <DashboardSkeleton />
      ) : isError ? (
        <ErrorState
          message={error?.message ?? 'Failed to load your statistics.'}
          onRetry={() => refetch()}
        />
      ) : (
        <ScrollView className="flex-1" contentContainerClassName="px-4 pb-10 pt-4">
          <View className="gap-4">
            <Card>
              <View className="flex-row">
                <StatCell icon="zap" value={profile?.xp_points ?? 0} label="XP" />
                <View className="w-px bg-border" />
                <StatCell icon="trending-up" value={profile?.current_streak ?? 0} label="Current streak" />
                <View className="w-px bg-border" />
                <StatCell icon="award" value={profile?.best_streak ?? 0} label="Best streak" />
              </View>
            </Card>

            <MacroAnalytics attempts={attempts} />
          </View>
        </ScrollView>
      )}
    </View>
  )
}
