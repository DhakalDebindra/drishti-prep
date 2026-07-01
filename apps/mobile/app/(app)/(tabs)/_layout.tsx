import { Tabs } from 'expo-router'
import { Feather } from '@expo/vector-icons'
import { useColorScheme } from 'nativewind'
import { useSafeAreaInsets } from 'react-native-safe-area-context'

type FeatherName = keyof typeof Feather.glyphMap

const ICONS: Record<string, FeatherName> = {
  dashboard: 'home',
  practice: 'book-open',
}

function tabIcon(name: string) {
  return ({ color, size }: { color: string; size: number }) => (
    <Feather name={ICONS[name] ?? 'circle'} size={size ?? 22} color={color} />
  )
}

export default function TabLayout() {
  const { colorScheme } = useColorScheme()
  const isDark = colorScheme === 'dark'
  const insets = useSafeAreaInsets()

  return (
    <Tabs
      screenOptions={{
        headerShown: false,
        tabBarStyle: {
          backgroundColor: isDark ? '#020617' : '#ffffff',
          borderTopColor: isDark ? '#1e293b' : '#e2e8f0',
          borderTopWidth: 1,
          // Reserve the Android system-nav inset so the bar isn't squeezed/covered.
          height: 60 + insets.bottom,
          paddingBottom: 8 + insets.bottom,
          paddingTop: 6,
        },
        tabBarActiveTintColor: '#2563EB',
        tabBarInactiveTintColor: isDark ? '#64748b' : '#94a3b8',
        tabBarLabelStyle: {
          fontSize: 11,
          fontWeight: '600' as const,
        },
      }}
    >
      <Tabs.Screen name="dashboard" options={{ title: 'Home', tabBarIcon: tabIcon('dashboard') }} />
      <Tabs.Screen name="practice" options={{ title: 'Study', tabBarIcon: tabIcon('practice') }} />
    </Tabs>
  )
}
