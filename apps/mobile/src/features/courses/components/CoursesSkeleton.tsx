import { View, ScrollView } from 'react-native'
import { Skeleton } from '../../../components/ui/Skeleton'

export function CoursesSkeleton() {
  return (
    <ScrollView className="flex-1 bg-background" contentContainerClassName="px-4 pb-8 pt-14">
      <Skeleton className="mb-1 h-8 w-40 rounded-lg" />
      <Skeleton className="mb-6 h-4 w-56 rounded-lg" />
      {[1, 2].map((i) => (
        <Skeleton key={i} className="mb-3 h-28 w-full rounded-2xl" />
      ))}
      <Skeleton className="mb-3 mt-6 h-6 w-32 rounded-lg" />
      {[1, 2, 3].map((i) => (
        <Skeleton key={i} className="mb-3 h-24 w-full rounded-2xl" />
      ))}
    </ScrollView>
  )
}

export function CourseDetailSkeleton() {
  return (
    <ScrollView className="flex-1 bg-background" contentContainerClassName="px-4 pb-8 pt-14">
      <Skeleton className="mb-4 h-4 w-20 rounded-lg" />
      <Skeleton className="mb-1 h-8 w-48 rounded-lg" />
      <Skeleton className="mb-3 h-4 w-64 rounded-lg" />
      <Skeleton className="mb-6 h-2 w-full rounded-full" />
      {[1, 2].map((i) => (
        <View key={i} className="mb-6">
          <Skeleton className="mb-3 h-6 w-32 rounded-lg" />
          {[1, 2].map((j) => (
            <Skeleton key={j} className="mb-3 h-32 w-full rounded-2xl" />
          ))}
        </View>
      ))}
    </ScrollView>
  )
}
