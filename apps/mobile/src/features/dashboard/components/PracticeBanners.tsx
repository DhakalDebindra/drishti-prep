import { View, Text, Pressable } from 'react-native'
import { Text as AppText, Card } from '../../../components/ui'
import { useRouter } from 'expo-router'

interface SetInfo {
  title: string
  topic: {
    name: string
    subject: { name: string }
  }
}

interface AttemptWithSet {
  id: string
  status: string
  set_id: string
  question_sets: SetInfo | null
}

export function PracticeBanners({ attempts }: { attempts: AttemptWithSet[] }) {
  const router = useRouter()
  const inProgress = attempts.find((a) => a.status === 'in_progress')

  return (
    <View className="flex-row gap-3">
      {inProgress && inProgress.question_sets ? (
        <Card variant="default" className="flex-1">
          <View className="mb-2 self-start rounded-full bg-white/20 dark:bg-white/10 px-3 py-1">
            <Text className="text-xs font-bold text-white uppercase tracking-wider">Resume practice</Text>
          </View>
          <AppText variant="h3" color="default" className="mt-1">
            {inProgress.question_sets.title}
          </AppText>
          <AppText variant="caption" color="muted" className="mt-1">
            {inProgress.question_sets.topic.subject.name}
          </AppText>
          <Pressable
            onPress={() => router.push(`/(app)/practice/${inProgress.set_id}`)}
            className="mt-4 flex-row items-center gap-2 self-start rounded-full bg-white px-4 py-2.5"
          >
            <Text className="text-base text-emerald-950">{'\u25B6'}</Text>
            <Text className="text-sm font-bold text-emerald-950">
              Continue set
            </Text>
          </Pressable>
        </Card>
      ) : (
        <Card variant="default" className="flex-1">
          <View className="mb-3 h-10 w-10 items-center justify-center rounded-2xl bg-emerald-500/10">
            <Text className="text-xl text-emerald-600 dark:text-emerald-400">{'\u2606'}</Text>
          </View>
          <AppText variant="h3" color="secondary">No active practice sets</AppText>
          <AppText variant="caption" color="muted" className="mt-1">
            Start a fresh session when you are ready.
          </AppText>
        </Card>
      )}

      <Card variant="default" className="flex-1">
        <View className="flex-row items-center gap-2">
          <Text className="text-lg text-emerald-600 dark:text-emerald-400">{'\uD83D\uDCCB'}</Text>
          <AppText variant="h3" color="default">My Bookmarks</AppText>
        </View>
        <AppText variant="caption" color="muted" className="mt-2">
          Review questions you found challenging or want to memorize.
        </AppText>
        <Pressable
          onPress={() => router.push('/(app)/(tabs)/bookmarks')}
          className="mt-4 flex-row items-center gap-2 self-start rounded-full bg-muted px-4 py-2.5"
        >
          <AppText variant="bodySmall" color="secondary" className="font-semibold">
            View bookmarks
          </AppText>
          <Text className="text-sm text-muted-foreground">{'\u2192'}</Text>
        </Pressable>
      </Card>
    </View>
  )
}
