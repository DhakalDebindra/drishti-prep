import { forwardRef } from 'react'
import { Pressable, Text, type PressableProps, type StyleProp, type ViewStyle } from 'react-native'
import { cva, type VariantProps } from 'class-variance-authority'
import { cn } from './cn'

const buttonVariants = cva(
  'flex-row items-center justify-center rounded-xl active:opacity-80 focus:border-ring',
  {
    variants: {
      variant: {
        default: 'bg-foreground border-2 border-foreground active:opacity-80',
        primary: 'bg-primary border-2 border-primary',
        // Solid (not 40%) border so the button reads as a distinct control on
        // the white action dock — important for low-vision users.
        secondary: 'bg-secondary border-2 border-foreground active:bg-secondary/80',
        soft: 'bg-primary/15 border-2 border-primary active:opacity-80',
        ghost: 'bg-transparent active:bg-muted/50',
        destructive: 'bg-destructive border-2 border-destructive active:bg-destructive/80',
        outline: 'border-2 border-foreground/50 bg-card active:bg-muted',
        heavyOutline: 'bg-card border-2 border-foreground active:bg-muted',
        tonal: 'bg-accent border-2 border-primary active:opacity-80',
      },
      size: {
        sm: 'min-h-[40px] px-3 py-2',
        md: 'min-h-[48px] px-4 py-3',
        lg: 'min-h-[56px] px-6 py-4',
        icon: 'h-11 w-11 p-0',
      },
    },
    defaultVariants: {
      variant: 'primary',
      size: 'md',
    },
  }
)

const buttonTextVariants = cva('font-semibold', {
  variants: {
    variant: {
      default: 'text-background',
      primary: 'text-primary-foreground',
      secondary: 'text-secondary-foreground',
      soft: 'text-primary',
      ghost: 'text-foreground',
      destructive: 'text-destructive-foreground',
      outline: 'text-foreground',
      heavyOutline: 'text-foreground',
      tonal: 'text-accent-foreground',
    },
    size: {
      sm: 'text-[13px]',
      md: 'text-[15px]',
      lg: 'text-[16px]',
      icon: 'text-[15px]',
    },
  },
  defaultVariants: {
    variant: 'primary',
    size: 'md',
  },
})

type ButtonVariants = VariantProps<typeof buttonVariants>

interface ButtonProps extends PressableProps {
  variant?: ButtonVariants['variant']
  size?: ButtonVariants['size']
  title?: string
  loading?: boolean
  leftIcon?: React.ReactNode
  rightIcon?: React.ReactNode
  style?: StyleProp<ViewStyle>
}

export const Button = forwardRef<React.ComponentRef<typeof Pressable>, ButtonProps & { children?: React.ReactNode }>(function Button({ variant, size, title, loading, disabled, className, style, leftIcon, rightIcon, children, ...props }, ref) {
  return (
    <Pressable
      ref={ref}
      accessible={true}
      accessibilityRole="button"
      accessibilityState={{ disabled: disabled || loading }}
      className={cn(
        buttonVariants({ variant, size }),
        (disabled || loading) && 'opacity-50',
        className,
      )}
      disabled={disabled || loading}
      style={style}
      {...props}
    >
      {leftIcon}
      {title && (
        <Text className={cn(buttonTextVariants({ variant, size }), leftIcon && 'ml-2', rightIcon && 'mr-2')}>
          {loading ? 'Loading...' : title}
        </Text>
      )}
      {children}
      {rightIcon}
    </Pressable>
  )
})
