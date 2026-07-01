import { View } from 'react-native'
import { Skeleton } from '../../../components/ui/Skeleton'

export function PracticeSkeleton() {
  return (
    <View className="flex-1 bg-background px-4 pt-14">
      <Skeleton className="mb-2 h-8 w-48 rounded-lg" />
      <Skeleton className="mb-6 h-4 w-32 rounded-lg" />
      {[1, 2, 3].map((i) => (
        <Skeleton key={i} className="mb-3 h-24 w-full rounded-2xl" />
      ))}
    </View>
  )
}

export function SessionSkeleton() {
  return (
    <View className="flex-1 bg-background pt-14">
      <View className="border-b border-border px-4 pb-4">
        <Skeleton className="mb-2 h-4 w-full rounded-lg" />
        <Skeleton className="h-2 w-full rounded-full" />
      </View>
      <View className="flex-1 px-4 pt-6">
        <Skeleton className="mb-4 h-6 w-32 rounded-lg" />
        <Skeleton className="mb-6 h-20 w-full rounded-lg" />
        {[1, 2, 3, 4].map((i) => (
          <Skeleton key={i} className="mb-3 h-16 w-full rounded-xl" />
        ))}
      </View>
    </View>
  )
}
