import { ScrollView, View } from 'react-native'
import { Text } from '../src/components/ui'

const NEPALI_SAMPLE = `
नेपाल एक सुन्दर देश हो।
परीक्षा तयारी गर्नुहोस्।
विज्ञान • गणित • इतिहास • भूगोल
संयुक्त व्यञ्जन: क्ष त्र ज्ञ श्र
`

export default function SmokeTest() {
  return (
    <ScrollView className="flex-1 bg-background px-6 pt-12">
      <Text variant="label" color="muted" className="mb-2">
        Regular (400)
      </Text>
      <Text
        className="text-[18px] leading-8"
        style={{ fontFamily: 'NotoSansDevanagari_400Regular' }}
      >
        {NEPALI_SAMPLE}
      </Text>

      <Text variant="label" color="muted" className="mb-2 mt-6">
        Bold (700)
      </Text>
      <Text
        className="text-[18px] leading-8"
        style={{ fontFamily: 'NotoSansDevanagari_700Bold' }}
      >
        {NEPALI_SAMPLE}
      </Text>

      <Text variant="label" color="muted" className="mb-2 mt-6">
        Dark mode simulation
      </Text>
      <View className="bg-card rounded-xl p-4 border border-border">
        <Text
          className="text-[18px] leading-8 text-foreground"
          style={{ fontFamily: 'NotoSansDevanagari_400Regular' }}
        >
          {NEPALI_SAMPLE}
        </Text>
      </View>
    </ScrollView>
  )
}
