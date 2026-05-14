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
      result.error.errors.forEach((err) => {
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

  const inputStyle = (field: keyof SignupFormValues) => ({
    backgroundColor: '#1e293b' as const,
    borderRadius: 12,
    padding: 14,
    fontSize: 16,
    color: '#f1f5f9' as const,
    borderWidth: 1,
    borderColor: errors[field] ? '#ef4444' : '#334155',
    marginBottom: 4,
  });

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
        <View style={{ marginBottom: 32, alignItems: 'center' }}>
          <Text style={{ fontSize: 32, fontWeight: '800', color: '#f8fafc', letterSpacing: -0.5 }}>
            Create Account
          </Text>
          <Text style={{ fontSize: 15, color: '#94a3b8', marginTop: 8 }}>
            Start your exam preparation journey
          </Text>
        </View>

        {/* Full Name */}
        <Text style={{ fontSize: 13, fontWeight: '600', color: '#cbd5e1', marginBottom: 6 }}>
          Full Name
        </Text>
        <TextInput
          style={inputStyle('fullName')}
          value={form.fullName}
          onChangeText={(v) => updateField('fullName', v)}
          placeholder="Your full name"
          placeholderTextColor="#475569"
          autoCapitalize="words"
          autoComplete="name"
          textContentType="name"
        />
        {errors.fullName ? (
          <Text style={{ color: '#ef4444', fontSize: 12, marginBottom: 12 }}>{errors.fullName}</Text>
        ) : (
          <View style={{ height: 16 }} />
        )}

        {/* Email */}
        <Text style={{ fontSize: 13, fontWeight: '600', color: '#cbd5e1', marginBottom: 6 }}>
          Email
        </Text>
        <TextInput
          style={inputStyle('email')}
          value={form.email}
          onChangeText={(v) => updateField('email', v)}
          placeholder="email@example.com"
          placeholderTextColor="#475569"
          autoCapitalize="none"
          autoComplete="email"
          keyboardType="email-address"
          textContentType="emailAddress"
        />
        {errors.email ? (
          <Text style={{ color: '#ef4444', fontSize: 12, marginBottom: 12 }}>{errors.email}</Text>
        ) : (
          <View style={{ height: 16 }} />
        )}

        {/* Password */}
        <Text style={{ fontSize: 13, fontWeight: '600', color: '#cbd5e1', marginBottom: 6 }}>
          Password
        </Text>
        <TextInput
          style={inputStyle('password')}
          value={form.password}
          onChangeText={(v) => updateField('password', v)}
          placeholder="Minimum 6 characters"
          placeholderTextColor="#475569"
          secureTextEntry
          autoCapitalize="none"
          textContentType="newPassword"
        />
        {errors.password ? (
          <Text style={{ color: '#ef4444', fontSize: 12, marginBottom: 12 }}>{errors.password}</Text>
        ) : (
          <View style={{ height: 16 }} />
        )}

        {/* Confirm Password */}
        <Text style={{ fontSize: 13, fontWeight: '600', color: '#cbd5e1', marginBottom: 6 }}>
          Confirm Password
        </Text>
        <TextInput
          style={inputStyle('confirmPassword')}
          value={form.confirmPassword}
          onChangeText={(v) => updateField('confirmPassword', v)}
          placeholder="Re-enter your password"
          placeholderTextColor="#475569"
          secureTextEntry
          autoCapitalize="none"
          textContentType="newPassword"
        />
        {errors.confirmPassword ? (
          <Text style={{ color: '#ef4444', fontSize: 12, marginBottom: 16 }}>{errors.confirmPassword}</Text>
        ) : (
          <View style={{ height: 20 }} />
        )}

        {/* Submit */}
        <Pressable
          onPress={handleSignUp}
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
              Create Account
            </Text>
          )}
        </Pressable>

        {/* Login Link */}
        <View style={{ flexDirection: 'row', justifyContent: 'center', marginTop: 24 }}>
          <Text style={{ color: '#94a3b8', fontSize: 14 }}>
            Already have an account?{' '}
          </Text>
          <Pressable onPress={() => router.push('/(auth)/login')}>
            <Text style={{ color: '#818cf8', fontSize: 14, fontWeight: '600' }}>
              Sign In
            </Text>
          </Pressable>
        </View>
      </ScrollView>
    </KeyboardAvoidingView>
  );
}
