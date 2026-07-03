import { View, Pressable } from 'react-native'
import { useSafeAreaInsets } from 'react-native-safe-area-context'
import { Text } from './Text'
import { useSession } from '../../providers/SessionProvider'
import { useDrawer } from '../../providers/DrawerProvider'
import { useAccessibilityFocus } from '../../hooks/useAccessibilityFocus'

type ScreenHeaderProps = {
  title: string
  /** Optional secondary line under the title. */
  subtitle?: string
}

/**
 * Top app bar for the tab screens. A large avatar button on the LEFT opens the
 * left-side "Profile" drawer (account / statistics / accessibility / contact /
 * sign out). Title sits to its right. Adds the top safe-area inset.
 */
export function ScreenHeader({ title, subtitle }: ScreenHeaderProps) {
  const insets = useSafeAreaInsets()
  const { user } = useSession()
  const { open } = useDrawer()
  const { ref: avatarRef, focus: focusAvatar } = useAccessibilityFocus()
  const initial = (user?.email?.trim()?.[0] ?? '?').toUpperCase()

  return (
    <View
      className="flex-row items-center border-b border-border bg-background px-4 pb-3"
      style={{ paddingTop: insets.top + 8 }}
    >
      <Pressable
        ref={avatarRef}
        onPress={() => open(focusAvatar)}
        accessibilityRole="button"
        accessibilityLabel="Open profile menu"
        hitSlop={8}
        className="mr-3 h-11 w-11 items-center justify-center rounded-full border-2 border-primary/40 bg-primary/15 active:opacity-80 focus:border-ring"
      >
        <Text variant="h3" color="accent">
          {initial}
        </Text>
      </Pressable>

      <View className="flex-1">
        <Text variant="h1" numberOfLines={1}>
          {title}
        </Text>
        {subtitle && (
          <Text variant="bodySmall" color="muted" numberOfLines={1}>
            {subtitle}
          </Text>
        )}
      </View>
    </View>
  )
}
