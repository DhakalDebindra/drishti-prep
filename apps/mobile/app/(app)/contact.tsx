import { ScrollView, View, Pressable, Linking } from 'react-native'
import { Stack } from 'expo-router'
import { Feather } from '@expo/vector-icons'
import { BackHeader, Card, Text } from '../../src/components/ui'

const SUPPORT_EMAIL = 'support@drishtiprep.app'

export default function ContactScreen() {
  return (
    <View className="flex-1 bg-background">
      <Stack.Screen options={{ headerShown: false }} />
      <BackHeader title="Help and Contact" />

      <ScrollView className="flex-1" contentContainerClassName="px-4 pb-10 pt-4">
        <View className="gap-4">
          <Card>
            <Text variant="h3" className="mb-1">
              Need help?
            </Text>
            <Text variant="bodySmall" color="muted" className="leading-5">
              Questions, feedback, or trouble with your account? We are happy to help.
            </Text>
            <Pressable
              onPress={() => Linking.openURL(`mailto:${SUPPORT_EMAIL}`)}
              accessibilityRole="button"
              accessibilityLabel={`Email support at ${SUPPORT_EMAIL}`}
              className="mt-4 flex-row items-center rounded-2xl border-2 border-primary bg-primary/10 px-4 py-3.5 active:opacity-80"
            >
              <Feather name="mail" size={20} className="text-primary" />
              <Text variant="bodySmall" className="ml-3 flex-1 font-semibold text-primary">
                {SUPPORT_EMAIL}
              </Text>
              <Feather name="external-link" size={18} className="text-primary" />
            </Pressable>
          </Card>

          <Card>
            <View className="mb-1 flex-row items-center gap-2">
              <Feather name="flag" size={18} className="text-foreground" />
              <Text variant="h3">Report a question</Text>
            </View>
            <Text variant="bodySmall" color="muted" className="leading-5">
              Found a mistake in a question? Open it from a completed practice review and tap Report to
              flag it for our team.
            </Text>
          </Card>
        </View>
      </ScrollView>
    </View>
  )
}
