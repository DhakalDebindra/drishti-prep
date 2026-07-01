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
import { loginSchema, type LoginFormValues } from '@repo/validation';

export default function LoginScreen() {
  const router = useRouter();
  const [form, setForm] = useState<LoginFormValues>({ email: '', password: '' });
  const [errors, setErrors] = useState<Partial<Record<keyof LoginFormValues, string>>>({});
  const [loading, setLoading] = useState(false);

  const updateField = (field: keyof LoginFormValues, value: string) => {
    setForm((prev) => ({ ...prev, [field]: value }));
    // Clear field error on change
    if (errors[field]) {
      setErrors((prev) => ({ ...prev, [field]: undefined }));
    }
  };

  const handleLogin = async () => {
    // Validate with shared Zod schema
    const result = loginSchema.safeParse(form);
    if (!result.success) {
      const fieldErrors: typeof errors = {};
      result.error.issues.forEach((err) => {
        const field = err.path[0] as keyof LoginFormValues;
        if (!fieldErrors[field]) fieldErrors[field] = err.message;
      });
      setErrors(fieldErrors);
      return;
    }

    setLoading(true);
    setErrors({});

    const { error } = await supabaseMobile.auth.signInWithPassword({
      email: result.data.email,
      password: result.data.password,
    });

    setLoading(false);

    if (error) {
      Alert.alert('Login Failed', error.message);
    }
    // On success, onAuthStateChange in SessionProvider updates the session,
    // which triggers the redirect in index.tsx automatically.
  };

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
        <View className="mb-10 items-center">
          <Text className="text-[32px] font-extrabold text-foreground tracking-tight">
            DrishtiPrep
          </Text>
          <Text className="text-[15px] text-muted-foreground mt-2">
            Sign in to continue your preparation
          </Text>
        </View>

        {/* Email */}
        <Text className="text-[13px] font-semibold text-foreground mb-1.5">
          Email
        </Text>
        <TextInput
          className={`bg-card rounded-xl p-3.5 text-base text-foreground border mb-1 ${
            errors.email ? 'border-destructive' : 'border-border'
          }`}
          value={form.email}
          onChangeText={(v) => updateField('email', v)}
          placeholder="email@example.com"
          placeholderTextColor="#94a3b8"
          autoCapitalize="none"
          autoComplete="email"
          keyboardType="email-address"
          textContentType="emailAddress"
        />
        {errors.email && (
          <Text className="text-destructive text-xs mb-3">
            {errors.email}
          </Text>
        )}
        {!errors.email && <View className="h-4" />}

        {/* Password */}
        <Text className="text-[13px] font-semibold text-foreground mb-1.5">
          Password
        </Text>
        <TextInput
          className={`bg-card rounded-xl p-3.5 text-base text-foreground border mb-1 ${
            errors.password ? 'border-destructive' : 'border-border'
          }`}
          value={form.password}
          onChangeText={(v) => updateField('password', v)}
          placeholder="Enter your password"
          placeholderTextColor="#94a3b8"
          secureTextEntry
          autoCapitalize="none"
          textContentType="password"
        />
        {errors.password && (
          <Text className="text-destructive text-xs mb-2">
            {errors.password}
          </Text>
        )}
        {!errors.password && <View className="h-3" />}

        {/* Forgot Password */}
        <Pressable
          onPress={() => router.push('/(auth)/forgot-password')}
          className="self-end mb-6"
        >
          <Text className="text-primary text-[13px] font-medium">
            Forgot password?
          </Text>
        </Pressable>

        {/* Submit */}
        <Pressable
          onPress={handleLogin}
          disabled={loading}
          className={`rounded-xl p-4 items-center bg-primary ${loading ? 'opacity-70' : 'active:opacity-80'}`}
        >
          {loading ? (
            <ActivityIndicator color="#ffffff" />
          ) : (
            <Text className="text-primary-foreground text-base font-bold">
              Sign In
            </Text>
          )}
        </Pressable>

        {/* Sign Up Link */}
        <View className="flex-row justify-center mt-6">
          <Text className="text-muted-foreground text-sm">
            Don't have an account?{' '}
          </Text>
          <Pressable onPress={() => router.push('/(auth)/signup')}>
            <Text className="text-primary text-sm font-semibold">
              Sign Up
            </Text>
          </Pressable>
        </View>
      </ScrollView>
    </KeyboardAvoidingView>
  );
}
