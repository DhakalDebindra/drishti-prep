import { ScrollView, View, Pressable, Switch } from 'react-native'
import { Stack } from 'expo-router'
import { Feather } from '@expo/vector-icons'
import { usePreferences, type FontScale } from '../../src/providers/PreferencesProvider'
import { BackHeader, Card, SettingRow, Text } from '../../src/components/ui'

const FONT_OPTIONS: Array<{ value: FontScale; label: string }> = [
  { value: 'sm', label: 'Small' },
  { value: 'md', label: 'Default' },
  { value: 'lg', label: 'Large' },
  { value: 'xl', label: 'Extra large' },
]

export default function AccessibilityScreen() {
  const { fontScale, contrast, setFontScale, setContrast } = usePreferences()

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
              onValueChange={(v) => setContrast(v ? 'high-contrast' : 'normal')}
              trackColor={{ true: '#2563EB', false: '#94a3b8' }}
              thumbColor="#ffffff"
              accessibilityRole="switch"
              accessibilityLabel="High contrast"
            />
          }
        />
      </ScrollView>
    </View>
  )
}
