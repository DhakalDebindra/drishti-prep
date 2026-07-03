import { View } from 'react-native'

interface ProgressBarProps {
  value: number
  className?: string
  accessibilityLabel?: string
}

export function ProgressBar({ value, className, accessibilityLabel }: ProgressBarProps) {
  const clamped = Math.max(2, Math.min(100, value))
  // Solid fill — React Native / NativeWind does not render CSS linear-gradients,
  // so the previous `bg-gradient-to-r` produced an invisible (transparent) bar.
  return (
    <View 
      className={`h-2 overflow-hidden rounded-full bg-muted ${className ?? ''}`}
      accessible={true}
      accessibilityRole="progressbar"
      accessibilityLabel={accessibilityLabel}
      accessibilityValue={{ min: 0, max: 100, now: Math.round(Math.max(0, Math.min(100, value))) }}
    >
      <View className="h-full rounded-full bg-primary" style={{ width: `${clamped}%` }} />
    </View>
  )
}
