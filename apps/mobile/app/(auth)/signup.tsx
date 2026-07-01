import { useState } from 'react';
import {
  View,
  Text,
  TextInput,
  Pressable,
  Alert,
  KeyboardAvoidingView,
  Platform,
  ScrollView,
  ActivityIndicator,
} from 'react-native';
import { useRouter } from 'expo-router';
import { supabaseMobile } from '@repo/supabase/mobile';
import { signupSchema, type SignupFormValues } from '@repo/validation';

export default function SignUpScreen() {
  const router = useRouter();
  const [form, setForm] = useState<SignupFormValues>({
    fullName: '',
    email: '',
    password: '',
    confirmPassword: '',
  });
  const [errors, setErrors] = useState<Partial<Record<keyof SignupFormValues, string>>>({});
  const [loading, setLoading] = useState(false);

  const updateField = (field: keyof SignupFormValues, value: string) => {
    setForm((prev) => ({ ...prev, [field]: value }));
    if (errors[field]) {
      setErrors((prev) => ({ ...prev, [field]: undefined }));
    }
  };

  const handleSignUp = async () => {
    const result = signupSchema.safeParse(form);
    if (!result.success) {
      const fieldErrors: typeof errors = {};
      result.error.issues.forEach((err) => {
        const field = err.path[0] as keyof SignupFormValues;
        if (!fieldErrors[field]) fieldErrors[field] = err.message;
      });
      setErrors(fieldErrors);
      return;
    }

    setLoading(true);
    setErrors({});

    const { data, error } = await supabaseMobile.auth.signUp({
      email: result.data.email,
      password: result.data.password,
      options: {
        data: {
          full_name: result.data.fullName,
        },
      },
    });

    setLoading(false);

    if (error) {
      Alert.alert('Sign Up Failed', error.message);
      return;
    }

    if (data.session) {
      // Auto-confirmed — SessionProvider handles redirect
    } else {
      Alert.alert(
        'Check Your Email',
        'We sent a verification link to your email. Please verify to continue.',
        [{ text: 'OK', onPress: () => router.replace('/(auth)/login') }]
      );
    }
  };

  const inputClassName = (field: keyof SignupFormValues) =>
    `bg-card rounded-xl p-3.5 text-base text-foreground border mb-1 ${
      errors[field] ? 'border-destructive' : 'border-border'
    }`;

  return (
    <KeyboardAvoidingView
      behavior={Platform.OS === 'ios' ? 'padding' : 'height'}
      className="flex-1 bg-background"
    >
      <ScrollView
        contentContainerStyle={{ flexGrow: 1, justifyContent: 'center', padding: 24 }}
        keyboardShouldPersistTaps="handled"
      >
        {/* Header */}
        <View className="mb-8 items-center">
          <Text className="text-[32px] font-extrabold text-foreground tracking-tight">
            Create Account
          </Text>
          <Text className="text-[15px] text-muted-foreground mt-2">
            Start your exam preparation journey
          </Text>
        </View>

        {/* Full Name */}
        <Text className="text-[13px] font-semibold text-foreground mb-1.5">
          Full Name
        </Text>
        <TextInput
          className={inputClassName('fullName')}
          value={form.fullName}
          onChangeText={(v) => updateField('fullName', v)}
          placeholder="Your full name"
          placeholderTextColor="#94a3b8"
          autoCapitalize="words"
          autoComplete="name"
          textContentType="name"
        />
        {errors.fullName ? (
          <Text className="text-destructive text-xs mb-3">{errors.fullName}</Text>
        ) : (
          <View className="h-4" />
        )}

        {/* Email */}
        <Text className="text-[13px] font-semibold text-foreground mb-1.5">
          Email
        </Text>
        <TextInput
          className={inputClassName('email')}
          value={form.email}
          onChangeText={(v) => updateField('email', v)}
          placeholder="email@example.com"
          placeholderTextColor="#94a3b8"
          autoCapitalize="none"
          autoComplete="email"
          keyboardType="email-address"
          textContentType="emailAddress"
        />
        {errors.email ? (
          <Text className="text-destructive text-xs mb-3">{errors.email}</Text>
        ) : (
          <View className="h-4" />
        )}

        {/* Password */}
        <Text className="text-[13px] font-semibold text-foreground mb-1.5">
          Password
        </Text>
        <TextInput
          className={inputClassName('password')}
          value={form.password}
          onChangeText={(v) => updateField('password', v)}
          placeholder="Minimum 6 characters"
          placeholderTextColor="#94a3b8"
          secureTextEntry
          autoCapitalize="none"
          textContentType="newPassword"
        />
        {errors.password ? (
          <Text className="text-destructive text-xs mb-3">{errors.password}</Text>
        ) : (
          <View className="h-4" />
        )}

        {/* Confirm Password */}
        <Text className="text-[13px] font-semibold text-foreground mb-1.5">
          Confirm Password
        </Text>
        <TextInput
          className={inputClassName('confirmPassword')}
          value={form.confirmPassword}
          onChangeText={(v) => updateField('confirmPassword', v)}
          placeholder="Re-enter your password"
          placeholderTextColor="#94a3b8"
          secureTextEntry
          autoCapitalize="none"
          textContentType="newPassword"
        />
        {errors.confirmPassword ? (
          <Text className="text-destructive text-xs mb-4">{errors.confirmPassword}</Text>
        ) : (
          <View className="h-5" />
        )}

        {/* Submit */}
        <Pressable
          onPress={handleSignUp}
          disabled={loading}
          className={`rounded-xl p-4 items-center bg-primary ${loading ? 'opacity-70' : 'active:opacity-80'}`}
        >
          {loading ? (
            <ActivityIndicator color="#ffffff" />
          ) : (
            <Text className="text-primary-foreground text-base font-bold">
              Create Account
            </Text>
          )}
        </Pressable>

        {/* Login Link */}
        <View className="flex-row justify-center mt-6">
          <Text className="text-muted-foreground text-sm">
            Already have an account?{' '}
          </Text>
          <Pressable onPress={() => router.push('/(auth)/login')}>
            <Text className="text-primary text-sm font-semibold">
              Sign In
            </Text>
          </Pressable>
        </View>
      </ScrollView>
    </KeyboardAvoidingView>
  );
}
