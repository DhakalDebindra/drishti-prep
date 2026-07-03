import { ScrollView, View, Pressable, Switch } from 'react-native'
import { Stack } from 'expo-router'
import { Feather } from '@expo/vector-icons'
import { usePreferences, type FontScale } from '../../src/providers/PreferencesProvider'
import { BackHeader, Card, SettingRow, Text } from '../../src/components/ui'
import { Button } from '../../src/components/ui/Button'
import { getSwitchColors } from '../../src/config/highContrastTheme'
import { announce } from '../../src/lib/accessibility'

const FONT_OPTIONS: Array<{ value: FontScale; label: string }> = [
  { value: 'sm', label: 'Small' },
  { value: 'md', label: 'Default' },
  { value: 'lg', label: 'Large' },
  { value: 'xl', label: 'Extra large' },
]

export default function AccessibilityScreen() {
  const {
    fontScale, contrast, answerSound, reduceMotion, haptics,
    setFontScale, setContrast, setAnswerSound, setReduceMotion, setHaptics
  } = usePreferences()

  const switchColors = getSwitchColors(contrast)

  return (
    <View className="flex-1 bg-background">
      <Stack.Screen options={{ headerShown: false }} />
      <BackHeader title="Accessibility" />

      <ScrollView className="flex-1" contentContainerClassName="px-4 pb-10 pt-4">
        {/* Live preview — scales with text size and recolors with contrast */}
        <Card className="mb-6">
          <Text variant="label" color="muted" className="mb-2">
            Preview
          </Text>
          <Text variant="h2">Aa Bb Cc</Text>
          <Text variant="body" className="mt-1">
            The quick brown fox jumps.
          </Text>
          <Text variant="body" className="mt-1">
            नेपाल · सन् २०८२
          </Text>
          <View className="mt-4 flex-row gap-3">
            <Button variant="primary" title="Primary" className="flex-1" />
            <Button variant="tonal" title="Tonal" className="flex-1" />
          </View>
        </Card>

        {/* Text size */}
        <Text variant="label" color="muted" className="mb-2">
          Text size
        </Text>
        <View
          accessibilityRole="radiogroup"
          accessibilityLabel="Text size"
          className="mb-6"
        >
          {FONT_OPTIONS.map((opt) => {
            const selected = fontScale === opt.value
            return (
              <Pressable
                key={opt.value}
                onPress={() => setFontScale(opt.value)}
                accessibilityRole="radio"
                accessibilityState={{ selected }}
                accessibilityLabel={opt.label}
                className={`mb-2 flex-row items-center justify-between rounded-2xl border-2 px-4 py-4 ${
                  selected ? 'border-primary bg-primary/10' : 'border-border bg-card'
                }`}
              >
                <Text
                  variant="body"
                  className={`font-semibold ${selected ? 'text-primary' : 'text-foreground'}`}
                >
                  {opt.label}
                </Text>
                {selected && <Feather name="check" size={22} className="text-primary" />}
              </Pressable>
            )
          })}
        </View>

        {/* Contrast */}
        <Text variant="label" color="muted" className="mb-2">
          Contrast
        </Text>
        <SettingRow
          label="High contrast"
          description="Stronger colours and solid borders for easier reading."
          right={
            <Switch
              value={contrast === 'high-contrast'}
              onValueChange={(v) => {
                setContrast(v ? 'high-contrast' : 'normal')
                announce(v ? 'High contrast enabled' : 'High contrast disabled')
              }}
              trackColor={switchColors}
              thumbColor="#ffffff"
              accessibilityRole="switch"
              accessibilityLabel="High contrast"
            />
          }
        />

        {/* Reduce motion */}
        <SettingRow
          label="Reduce motion"
          description="Minimize animations and transitions."
          right={
            <Switch
              value={reduceMotion}
              onValueChange={(v) => {
                setReduceMotion(v)
                announce(v ? 'Reduce motion enabled' : 'Reduce motion disabled')
              }}
              trackColor={switchColors}
              thumbColor="#ffffff"
              accessibilityRole="switch"
              accessibilityLabel="Reduce motion"
            />
          }
        />

        {/* Practice Feedback */}
        <Text variant="label" color="muted" className="mb-2 mt-6">
          Practice feedback
        </Text>
        <SettingRow
          label="Answer sound"
          description="Play a chime when you answer a question."
          right={
            <Switch
              value={answerSound}
              onValueChange={(v) => {
                setAnswerSound(v)
                announce(v ? 'Answer sound enabled' : 'Answer sound disabled')
              }}
              trackColor={switchColors}
              thumbColor="#ffffff"
              accessibilityRole="switch"
              accessibilityLabel="Answer sound"
            />
          }
        />
        <SettingRow
          label="Haptic feedback"
          description="Vibrate when you select an answer."
          right={
            <Switch
              value={haptics}
              onValueChange={(v) => {
                setHaptics(v)
                announce(v ? 'Haptic feedback enabled' : 'Haptic feedback disabled')
              }}
              trackColor={switchColors}
              thumbColor="#ffffff"
              accessibilityRole="switch"
              accessibilityLabel="Haptic feedback"
            />
          }
        />
      </ScrollView>
    </View>
  )
}
