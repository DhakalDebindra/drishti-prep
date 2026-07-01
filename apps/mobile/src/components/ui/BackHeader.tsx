import { View, Pressable } from 'react-native'
import { useRouter } from 'expo-router'
import { useSafeAreaInsets } from 'react-native-safe-area-context'
import { Feather } from '@expo/vector-icons'
import { Text } from './Text'

/** Top bar for full-screen sub-pages opened from the drawer: back button + title. */
export function BackHeader({ title }: { title: string }) {
  const router = useRouter()
  const insets = useSafeAreaInsets()
  const goBack = () =>
    router.canGoBack() ? router.back() : router.replace('/(app)/(tabs)/dashboard')

  return (
    <View
      className="flex-row items-center gap-3 border-b border-border bg-background px-4 pb-3"
      style={{ paddingTop: insets.top + 8 }}
    >
      <Pressable
        onPress={goBack}
        accessibilityRole="button"
        accessibilityLabel="Go back"
        hitSlop={8}
        className="h-11 w-11 items-center justify-center rounded-xl border-2 border-foreground/40 bg-card active:bg-muted"
      >
        <Feather name="arrow-left" size={20} className="text-foreground" />
      </Pressable>
      <Text variant="h2">{title}</Text>
    </View>
  )
}
