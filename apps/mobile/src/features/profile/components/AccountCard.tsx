import { View } from 'react-native'
import { Feather } from '@expo/vector-icons'
import { Text } from '../../../components/ui/Text'
import { Card } from '../../../components/ui/Card'

type AccountCardProps = {
  email: string | null
  xpPoints: number
  currentStreak: number
  bestStreak: number
}

function Stat({ icon, value, label }: { icon: keyof typeof Feather.glyphMap; value: number; label: string }) {
  return (
    <View
      accessible
      accessibilityLabel={`${value} ${label}`}
      className="flex-1 items-center"
    >
      <Feather name={icon} size={18} color="#2563EB" />
      <Text variant="h3" className="mt-1">
        {value}
      </Text>
      <Text variant="caption" color="muted">
        {label}
      </Text>
    </View>
  )
}

export function AccountCard({ email, xpPoints, currentStreak, bestStreak }: AccountCardProps) {
  const initial = (email?.trim()?.[0] ?? '?').toUpperCase()

  return (
    <Card>
      <View className="flex-row items-center gap-4">
        <View
          className="h-14 w-14 items-center justify-center rounded-full bg-primary/15"
          accessibilityElementsHidden
          importantForAccessibility="no-hide-descendants"
        >
          <Text variant="h2" color="accent">
            {initial}
          </Text>
        </View>
        <View className="flex-1">
          <Text variant="caption" color="muted">
            Signed in as
          </Text>
          <Text variant="body" className="font-semibold" numberOfLines={1}>
            {email ?? 'Unknown account'}
          </Text>
        </View>
      </View>

      <View className="mt-5 flex-row border-t border-border pt-4">
        <Stat icon="zap" value={xpPoints} label="XP" />
        <View className="w-px bg-border" />
        <Stat icon="trending-up" value={currentStreak} label="Streak" />
        <View className="w-px bg-border" />
        <Stat icon="award" value={bestStreak} label="Best" />
      </View>
    </Card>
  )
}
