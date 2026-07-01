import { Text as RNText, type TextProps as RNTextProps } from 'react-native'
import { cva, type VariantProps } from 'class-variance-authority'
import { cn } from './cn'
import { usePreferences } from '../../providers/PreferencesProvider'
import { devanagariDigitsToLatin, hasDevanagariDigits } from '../../lib/devanagari'

const textVariants = cva('text-foreground', {
  variants: {
    variant: {
      h1: 'text-[28px] font-extrabold tracking-tight',
      h2: 'text-[22px] font-bold tracking-tight',
      h3: 'text-[18px] font-semibold',
      body: 'text-[16px]',
      bodySmall: 'text-[14px]',
      caption: 'text-[13px] font-medium',
      label: 'text-[12px] font-semibold uppercase tracking-wide',
      statistic: 'text-[28px] font-extrabold tracking-tight',
    },
    color: {
      default: 'text-foreground',
      secondary: 'text-secondary-foreground',
      muted: 'text-muted-foreground',
      accent: 'text-primary',
      success: 'text-emerald-600 dark:text-emerald-400',
      danger: 'text-destructive',
      inverse: 'text-background',
    },
  },
  defaultVariants: {
    variant: 'body',
    color: 'default',
  },
})

// Base font sizes per variant (px), mirroring the cva size classes above. Used
// to apply the in-app font-scale multiplier without relying on className sizing.
const VARIANT_BASE_SIZE: Record<NonNullable<TextVariants['variant']>, number> = {
  h1: 28,
  h2: 22,
  h3: 18,
  body: 16,
  bodySmall: 14,
  caption: 13,
  label: 12,
  statistic: 28,
}

type TextVariants = VariantProps<typeof textVariants>

interface TextProps extends RNTextProps {
  variant?: TextVariants['variant']
  color?: TextVariants['color']
  innerRef?: React.Ref<RNText>
}

export function Text({
  variant,
  color,
  className,
  style,
  innerRef,
  accessibilityLabel,
  children,
  ...props
}: TextProps) {
  const { fontMultiplier } = usePreferences()

  // (A) Devanagari numeral accessibility: Android TTS skips Devanagari digits,
  // so when a plain-string child contains them and the caller hasn't supplied
  // an explicit accessibilityLabel, announce a Latin-digit copy instead. The
  // visible glyphs stay Devanagari. No-op for strings without Devanagari digits.
  const resolvedA11yLabel =
    accessibilityLabel ??
    (typeof children === 'string' && hasDevanagariDigits(children)
      ? devanagariDigitsToLatin(children)
      : undefined)

  // (E) In-app font scaling. Only override the size when the user has actually
  // chosen a non-default scale, so default rendering is identical to before.
  const resolvedVariant = (variant ?? 'body') as NonNullable<TextVariants['variant']>
  const scaledStyle =
    fontMultiplier !== 1
      ? { fontSize: Math.round(VARIANT_BASE_SIZE[resolvedVariant] * fontMultiplier) }
      : undefined

  return (
    <RNText
      ref={innerRef}
      className={cn(textVariants({ variant, color }), className)}
      style={scaledStyle ? [scaledStyle, style] : style}
      accessibilityLabel={resolvedA11yLabel}
      {...props}
    >
      {children}
    </RNText>
  )
}
