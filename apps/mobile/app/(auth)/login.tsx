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
      style={{ flex: 1, backgroundColor: '#0f172a' }}
    >
      <ScrollView
        contentContainerStyle={{ flexGrow: 1, justifyContent: 'center', padding: 24 }}
        keyboardShouldPersistTaps="handled"
      >
        {/* Header */}
        <View style={{ marginBottom: 40, alignItems: 'center' }}>
          <Text style={{ fontSize: 32, fontWeight: '800', color: '#f8fafc', letterSpacing: -0.5 }}>
            DrishtiPrep
          </Text>
          <Text style={{ fontSize: 15, color: '#94a3b8', marginTop: 8 }}>
            Sign in to continue your preparation
          </Text>
        </View>

        {/* Email */}
        <Text style={{ fontSize: 13, fontWeight: '600', color: '#cbd5e1', marginBottom: 6 }}>
          Email
        </Text>
        <TextInput
          style={{
            backgroundColor: '#1e293b',
            borderRadius: 12,
            padding: 14,
            fontSize: 16,
            color: '#f1f5f9',
            borderWidth: 1,
            borderColor: errors.email ? '#ef4444' : '#334155',
            marginBottom: 4,
          }}
          value={form.email}
          onChangeText={(v) => updateField('email', v)}
          placeholder="email@example.com"
          placeholderTextColor="#475569"
          autoCapitalize="none"
          autoComplete="email"
          keyboardType="email-address"
          textContentType="emailAddress"
        />
        {errors.email && (
          <Text style={{ color: '#ef4444', fontSize: 12, marginBottom: 12 }}>
            {errors.email}
          </Text>
        )}
        {!errors.email && <View style={{ height: 16 }} />}

        {/* Password */}
        <Text style={{ fontSize: 13, fontWeight: '600', color: '#cbd5e1', marginBottom: 6 }}>
          Password
        </Text>
        <TextInput
          style={{
            backgroundColor: '#1e293b',
            borderRadius: 12,
            padding: 14,
            fontSize: 16,
            color: '#f1f5f9',
            borderWidth: 1,
            borderColor: errors.password ? '#ef4444' : '#334155',
            marginBottom: 4,
          }}
          value={form.password}
          onChangeText={(v) => updateField('password', v)}
          placeholder="Enter your password"
          placeholderTextColor="#475569"
          secureTextEntry
          autoCapitalize="none"
          textContentType="password"
        />
        {errors.password && (
          <Text style={{ color: '#ef4444', fontSize: 12, marginBottom: 8 }}>
            {errors.password}
          </Text>
        )}
        {!errors.password && <View style={{ height: 12 }} />}

        {/* Forgot Password */}
        <Pressable
          onPress={() => router.push('/(auth)/forgot-password')}
          style={{ alignSelf: 'flex-end', marginBottom: 24 }}
        >
          <Text style={{ color: '#818cf8', fontSize: 13, fontWeight: '500' }}>
            Forgot password?
          </Text>
        </Pressable>

        {/* Submit */}
        <Pressable
          onPress={handleLogin}
          disabled={loading}
          style={({ pressed }) => ({
            backgroundColor: pressed ? '#4f46e5' : '#6366f1',
            borderRadius: 12,
            padding: 16,
            alignItems: 'center',
            opacity: loading ? 0.7 : 1,
          })}
        >
          {loading ? (
            <ActivityIndicator color="#fff" />
          ) : (
            <Text style={{ color: '#fff', fontSize: 16, fontWeight: '700' }}>
              Sign In
            </Text>
          )}
        </Pressable>

        {/* Sign Up Link */}
        <View style={{ flexDirection: 'row', justifyContent: 'center', marginTop: 24 }}>
          <Text style={{ color: '#94a3b8', fontSize: 14 }}>
            Don't have an account?{' '}
          </Text>
          <Pressable onPress={() => router.push('/(auth)/signup')}>
            <Text style={{ color: '#818cf8', fontSize: 14, fontWeight: '600' }}>
              Sign Up
            </Text>
          </Pressable>
        </View>
      </ScrollView>
    </KeyboardAvoidingView>
  );
}
