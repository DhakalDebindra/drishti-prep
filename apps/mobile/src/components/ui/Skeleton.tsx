import { View } from 'react-native'

interface SkeletonProps {
  className?: string
}

export function Skeleton({ className }: SkeletonProps) {
  // NOTE: no `animate-pulse` here. react-native-css-interop@0.2.3 processes
  // animation classes by calling `makeMutable` from "react-native-reanimated",
  // but reanimated 4 moved that API to "react-native-worklets" — so any
  // animation class crashes with "Cannot read property 'makeMutable' of
  // undefined". A static placeholder avoids css-interop's animation path.
  return (
    <View
      className={`rounded-xl bg-muted ${className ?? ''}`}
    />
  )
}
