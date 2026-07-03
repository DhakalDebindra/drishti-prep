import { useEffect } from 'react'
import {
  View,
  Pressable,
  ScrollView,
  Alert,
  BackHandler,
  AccessibilityInfo,
  StyleSheet,
  useWindowDimensions,
  type GestureResponderEvent,
} from 'react-native'
import { useRouter, type Router } from 'expo-router'
import { useSafeAreaInsets } from 'react-native-safe-area-context'
import { Feather } from '@expo/vector-icons'
import { Text } from './Text'
import { useDrawer } from '../../providers/DrawerProvider'
import { useSession } from '../../providers/SessionProvider'
import { useActiveCourse } from '../../providers/ActiveCourseProvider'
import { useProfile } from '../../features/profile'
import { useCourses } from '../../features/courses'
import { useAccessibilityFocus } from '../../hooks/useAccessibilityFocus'

type MenuItem = { icon: keyof typeof Feather.glyphMap; label: string; route: string }

const MENU: MenuItem[] = [
  { icon: 'user', label: 'Account', route: '/(app)/account' },
  { icon: 'bar-chart-2', label: 'Statistics', route: '/(app)/statistics' },
  { icon: 'sliders', label: 'Accessibility', route: '/(app)/accessibility' },
  { icon: 'help-circle', label: 'Help and Contact', route: '/(app)/contact' },
]

function MenuRow({ item, onNavigate }: { item: MenuItem; onNavigate: (route: string) => void }) {
  return (
    <Pressable
      onPress={() => onNavigate(item.route)}
      accessibilityRole="button"
      accessibilityLabel={item.label}
      className="mb-2 flex-row items-center rounded-2xl border-2 border-border bg-background px-4 py-4 active:bg-muted focus:border-ring"
    >
      <Feather name={item.icon} size={22} className="text-primary" />
      <Text variant="body" className="ml-3 flex-1 font-semibold">
        {item.label}
      </Text>
      <Feather name="chevron-right" size={20} className="text-muted-foreground" />
    </Pressable>
  )
}

export function AppDrawer() {
  const { isOpen, close } = useDrawer()
  const { ref: closeBtnRef, focus: focusCloseBtn } = useAccessibilityFocus()

  useEffect(() => {
    if (isOpen) {
      AccessibilityInfo.announceForAccessibility('Navigation menu opened')
      requestAnimationFrame(() => focusCloseBtn())
    }
  }, [isOpen, focusCloseBtn])
  const router = useRouter()
  const insets = useSafeAreaInsets()
  const { width } = useWindowDimensions()
  const { user, signOut } = useSession()
  const { data: profile } = useProfile(user?.id ?? '')
  const coursesQ = useCourses(user?.id ?? '')
  const { activeSlug, setActiveSlug } = useActiveCourse()

  const enrolled = coursesQ.data?.enrolled ?? []
  const resolvedActiveSlug = enrolled.find((c) => c.slug === activeSlug)?.slug ?? enrolled[0]?.slug ?? null

  const switchCourse = (slug: string) => {
    setActiveSlug(slug)
    close()
    router.push('/(app)/(tabs)/practice')
  }

  const PANEL_WIDTH = Math.min(330, width * 0.84)

  // Close on Android hardware back while the drawer is open.
  useEffect(() => {
    if (!isOpen) return
    const sub = BackHandler.addEventListener('hardwareBackPress', () => {
      close()
      return true
    })
    return () => sub.remove()
  }, [isOpen, close])

  const navigate = (route: string) => {
    close()
    router.push(route as Parameters<Router['push']>[0])
  }

  const onSignOut = (e: GestureResponderEvent) => {
    e.preventDefault()
    Alert.alert('Sign out', 'Are you sure you want to sign out?', [
      { text: 'Cancel', style: 'cancel' },
      {
        text: 'Sign out',
        style: 'destructive',
        onPress: async () => {
          close()
          await signOut()
        },
      },
    ])
  }

  if (!isOpen) return null

  const email = user?.email ?? 'Signed in'
  const initial = (user?.email?.trim()?.[0] ?? '?').toUpperCase()

  // Rendered as an in-tree absolute overlay (NOT a Modal): a Modal portals out
  // of the NativeWind theme scope, so its `bg-card`/`bg-background` would lose
  // the app's (light) theme. An overlay inside ThemedRoot inherits it correctly.
  return (
    <View accessibilityViewIsModal style={[StyleSheet.absoluteFill, { zIndex: 50, elevation: 50 }]}>
      {/* Scrim — bg via concrete style (className bg utilities don't apply on a
          View that also has an inline style prop). */}
      <Pressable
        style={[StyleSheet.absoluteFill, { backgroundColor: 'rgba(0,0,0,0.55)' }]}
        onPress={close}
        accessibilityRole="button"
        accessibilityLabel="Close menu"
      />

      {/* Left panel — concrete light-theme background/border via style. */}
      <View
        className="bg-card border-r-2 border-border"
        style={{
          position: 'absolute',
          left: 0,
          top: 0,
          bottom: 0,
          width: PANEL_WIDTH,
          paddingTop: insets.top + 12,
          paddingBottom: insets.bottom + 12,
        }}
      >
        {/* Profile header */}
        <View className="border-b-2 border-border px-5 pb-5">
          <View className="flex-row items-center justify-between">
            <Text variant="h2">Profile</Text>
            <Pressable
              ref={closeBtnRef}
              onPress={close}
              accessibilityRole="button"
              accessibilityLabel="Close menu"
              hitSlop={8}
              className="h-10 w-10 items-center justify-center rounded-full border-2 border-foreground/30 bg-background active:bg-muted focus:border-ring"
            >
              <Feather name="x" size={20} className="text-foreground" />
            </Pressable>
          </View>

          <View className="mt-4 flex-row items-center gap-3">
            <View
              className="h-14 w-14 items-center justify-center rounded-full bg-primary/15"
              importantForAccessibility="no-hide-descendants"
            >
              <Text variant="h2" color="accent">
                {initial}
              </Text>
            </View>
            <View className="flex-1">
              <Text variant="bodySmall" className="font-semibold" numberOfLines={1}>
                {email}
              </Text>
              <Text variant="caption" color="muted" className="mt-0.5">
                {profile?.xp_points ?? 0} XP · {profile?.current_streak ?? 0} day streak
              </Text>
            </View>
          </View>
        </View>

        {/* My courses + menu */}
        <ScrollView className="flex-1" contentContainerClassName="px-4 pt-4 pb-2">
          {enrolled.length > 0 && (
            <View className="mb-4">
              <Text variant="label" color="muted" className="mb-2">
                My courses
              </Text>
              {enrolled.map((course) => {
                const active = course.slug === resolvedActiveSlug
                return (
                  <Pressable
                    key={course.id}
                    onPress={() => switchCourse(course.slug)}
                    accessibilityRole="button"
                    accessibilityState={{ selected: active }}
                    accessibilityLabel={`${course.name}${active ? ', current course' : ''}`}
                    className={`mb-2 flex-row items-center rounded-2xl border-2 px-4 py-3.5 focus:border-ring ${
                      active ? 'border-primary bg-primary/10' : 'border-border bg-background'
                    }`}
                  >
                    <Feather name="book-open" size={20} className={active ? 'text-primary' : 'text-muted-foreground'} />
                    <Text
                      variant="bodySmall"
                      numberOfLines={1}
                      className={`ml-3 flex-1 font-semibold ${active ? 'text-primary' : 'text-foreground'}`}
                    >
                      {course.name}
                    </Text>
                    {active && <Feather name="check" size={20} className="text-primary" />}
                  </Pressable>
                )
              })}
            </View>
          )}

          {MENU.map((item) => (
            <MenuRow key={item.route} item={item} onNavigate={navigate} />
          ))}
        </ScrollView>

        {/* Sign out */}
        <View className="px-4 pt-2">
          <Pressable
            onPress={onSignOut}
            accessibilityRole="button"
            accessibilityLabel="Sign out of your account"
            className="flex-row items-center justify-center rounded-2xl border-2 border-destructive bg-destructive/10 py-4 active:opacity-80"
          >
            <Feather name="log-out" size={20} className="text-destructive" />
            <Text variant="body" className="ml-2 font-bold text-destructive">
              Sign out
            </Text>
          </Pressable>
        </View>
      </View>
    </View>
  )
}
