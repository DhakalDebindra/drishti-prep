import { View, Pressable } from 'react-native'
import { Feather } from '@expo/vector-icons'
import { Text } from '../../../components/ui/Text'
import { Badge } from '../../../components/ui/Badge'

type CourseCardProps = {
  name: string
  isUniversal: boolean
  pricePaisa: number | null
  enrollmentStatus: string | null
  /** Opens the course detail page (where enroll/study actually happens). */
  onPress: () => void
}

/**
 * Catalog card for Home: course title + price/status, and a state-labelled
 * button. Tapping anywhere (card or button) opens the detail page — no enroll
 * or activation happens here. The left tile is a placeholder for a future
 * course logo/cover image.
 */
export function CourseCard({ name, isUniversal, pricePaisa, enrollmentStatus, onPress }: CourseCardProps) {
  const isEnrolled = enrollmentStatus === 'approved' || isUniversal
  const isFree = isUniversal || pricePaisa == null
  const priceLabel = isFree ? 'Free' : `NPR ${((pricePaisa ?? 0) / 100).toLocaleString()}`
  const buttonLabel = isEnrolled ? 'Study' : 'Enroll'

  return (
    <Pressable
      onPress={onPress}
      accessibilityRole="button"
      accessibilityLabel={`${name}. ${isEnrolled ? 'Enrolled' : priceLabel}. ${buttonLabel}.`}
      className="mb-3 rounded-2xl border-2 border-border bg-card p-5 active:opacity-80"
    >
      <View className="flex-row items-center gap-3">
        {/* Logo / cover slot (future course image) */}
        <View
          className="h-12 w-12 items-center justify-center rounded-xl bg-primary/15"
          importantForAccessibility="no-hide-descendants"
        >
          <Feather name="book" size={22} className="text-primary" />
        </View>
        <View className="flex-1">
          <Text variant="h3" numberOfLines={2}>
            {name}
          </Text>
          <View className="mt-1.5 self-start">
            <Badge
              variant={isEnrolled ? 'enrolled' : isFree ? 'free' : 'paid'}
              label={isEnrolled ? 'Enrolled' : priceLabel}
            />
          </View>
        </View>
      </View>

      {/* Button-styled affordance — whole card navigates, so this is visual only */}
      <View
        importantForAccessibility="no-hide-descendants"
        className={`mt-4 flex-row items-center justify-center rounded-xl border-2 py-3 ${
          isEnrolled ? 'border-foreground/40 bg-card' : 'border-primary bg-primary'
        }`}
      >
        <Text className={`text-[15px] font-bold ${isEnrolled ? 'text-foreground' : 'text-primary-foreground'}`}>
          {buttonLabel}
        </Text>
        <Feather
          name="chevron-right"
          size={18}
          className={isEnrolled ? 'text-foreground' : 'text-primary-foreground'}
        />
      </View>
    </Pressable>
  )
}
