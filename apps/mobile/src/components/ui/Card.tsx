import { View, type ViewProps } from 'react-native'
import { cn } from './cn'

interface CardProps extends ViewProps {
  variant?: 'default' | 'elevated' | 'success' | 'info'
}

export function Card({ variant = 'default', className, children, ...props }: CardProps) {
  return (
    <View
      className={cn(
        'rounded-2xl border p-5',
        variant === 'default' && 'border-border bg-card',
        variant === 'elevated' && 'border-border bg-card shadow-sm',
        variant === 'success' && 'border-primary/50 bg-primary/10',
        variant === 'info' && 'border-cyan-500/50 bg-cyan-500/10',
        className,
      )}
      {...props}
    >
      {children}
    </View>
  )
}
