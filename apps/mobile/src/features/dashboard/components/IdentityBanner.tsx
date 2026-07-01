import { View, Text, Pressable } from 'react-native'
import { Text as AppText } from '../../../components/ui'
import { useRouter } from 'expo-router'

interface IdentityBannerProps {
  disabilityStatus: string
  rejectionReason: string | null
}

export function IdentityBanner({ disabilityStatus, rejectionReason }: IdentityBannerProps) {
  const router = useRouter()

  if (disabilityStatus === 'approved') {
    return (
      <View className="flex-row items-center gap-3 rounded-2xl border border-emerald-500/50 bg-emerald-500/10 px-4 py-3">
        <Text className="text-xl text-emerald-600 dark:text-emerald-400">{'\u2714'}</Text>
        <AppText variant="bodySmall" color="success" className="flex-1">
          Disability verified. All accessibility features are active.
        </AppText>
      </View>
    )
  }

  if (disabilityStatus === 'pending') {
    return (
      <View className="flex-row items-center gap-3 rounded-2xl border border-amber-500/50 bg-amber-500/10 px-4 py-3">
        <Text className="text-xl text-amber-600 dark:text-amber-400">{'\u23F3'}</Text>
        <AppText variant="bodySmall" color="secondary" className="flex-1">
          Verification pending. We'll notify you once reviewed.
        </AppText>
      </View>
    )
  }

  if (disabilityStatus === 'rejected') {
    return (
      <View className="rounded-2xl border border-red-500/50 bg-red-500/10 px-4 py-3">
        <View className="flex-row items-center gap-3">
          <Text className="text-xl text-red-600 dark:text-red-400">{'\u26A0'}</Text>
          <AppText variant="bodySmall" color="danger" className="flex-1">
            Verification rejected. Please re-submit.
          </AppText>
        </View>
        {rejectionReason && (
          <AppText variant="caption" color="muted" className="mt-2 ml-9">
            Reason: {rejectionReason}
          </AppText>
        )}
      </View>
    )
  }

  return (
    <Pressable
      onPress={() => router.push('/(app)/profile/verify-identity')}
      className="flex-row items-center gap-3 rounded-2xl border border-primary/50 bg-primary/10 px-4 py-3 active:bg-primary/20"
    >
      <Text className="text-xl text-primary">{'\uD83D\uDEE1'}</Text>
      <View className="flex-1">
        <AppText variant="bodySmall" color="accent" className="font-semibold">
          Verify your disability status
        </AppText>
        <AppText variant="caption" color="muted">
          Submit your disability card to unlock accessibility features.
        </AppText>
      </View>
      <Text className="text-lg text-muted-foreground">{'\u203A'}</Text>
    </Pressable>
  )
}
