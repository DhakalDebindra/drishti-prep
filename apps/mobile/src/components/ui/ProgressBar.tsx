import { View } from 'react-native'

interface ProgressBarProps {
  value: number
  className?: string
}

export function ProgressBar({ value, className }: ProgressBarProps) {
  const clamped = Math.max(2, Math.min(100, value))
  // Solid fill — React Native / NativeWind does not render CSS linear-gradients,
  // so the previous `bg-gradient-to-r` produced an invisible (transparent) bar.
  return (
    <View className={`h-2 overflow-hidden rounded-full bg-muted ${className ?? ''}`}>
      <View className="h-full rounded-full bg-primary" style={{ width: `${clamped}%` }} />
    </View>
  )
}
