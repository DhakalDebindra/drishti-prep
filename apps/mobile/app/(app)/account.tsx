import { ScrollView, View } from 'react-native'
import { Stack } from 'expo-router'
import { useSession } from '../../src/providers/SessionProvider'
import { useProfile, AccountCard, IdentityStatusCard } from '../../src/features/profile'
import { BackHeader, ErrorState } from '../../src/components/ui'
import { DashboardSkeleton } from '../../src/features/dashboard'

export default function AccountScreen() {
  const { user } = useSession()
  const { data, isLoading, isError, error, refetch } = useProfile(user?.id ?? '')

  if (!user) return <View className="flex-1 bg-background" />

  const status = (data?.disability_status ?? 'not_submitted') as string

  return (
    <View className="flex-1 bg-background">
      <Stack.Screen options={{ headerShown: false }} />
      <BackHeader title="Account" />

      {isLoading ? (
        <DashboardSkeleton />
      ) : isError ? (
        <ErrorState
          message={error instanceof Error ? error.message : 'Failed to load your account.'}
          onRetry={() => refetch()}
        />
      ) : (
        <ScrollView className="flex-1" contentContainerClassName="px-4 pb-10 pt-4">
          <View className="gap-4">
            <AccountCard
              email={user.email ?? null}
              xpPoints={data?.xp_points ?? 0}
              currentStreak={data?.current_streak ?? 0}
              bestStreak={data?.best_streak ?? 0}
            />
            <IdentityStatusCard
              status={status}
              rejectionReason={data?.disability_rejection_reason ?? null}
            />
          </View>
        </ScrollView>
      )}
    </View>
  )
}
