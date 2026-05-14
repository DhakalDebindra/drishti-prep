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

export default function ForgotPasswordScreen() {
  const router = useRouter();
  const [email, setEmail] = useState('');
  const [loading, setLoading] = useState(false);
  const [sent, setSent] = useState(false);

  const handleReset = async () => {
    const trimmed = email.trim();
    if (!trimmed) {
      Alert.alert('Error', 'Please enter your email address.');
      return;
    }

    setLoading(true);

    const { error } = await supabaseMobile.auth.resetPasswordForEmail(trimmed, {
      redirectTo: `${process.env.EXPO_PUBLIC_APP_URL}/auth/reset-password`,
    });

    setLoading(false);

    if (error) {
      Alert.alert('Error', error.message);
      return;
    }

    setSent(true);
  };

  if (sent) {
    return (
      <View style={{ flex: 1, backgroundColor: '#0f172a', justifyContent: 'center', padding: 24 }}>
        <View style={{ alignItems: 'center' }}>
          <Text style={{ fontSize: 48, marginBottom: 16 }}>📧</Text>
          <Text style={{ fontSize: 22, fontWeight: '700', color: '#f8fafc', marginBottom: 12, textAlign: 'center' }}>
            Check Your Email
          </Text>
          <Text style={{ fontSize: 15, color: '#94a3b8', textAlign: 'center', lineHeight: 22 }}>
            We sent a password reset link to{'\n'}
            <Text style={{ color: '#818cf8', fontWeight: '600' }}>{email.trim()}</Text>
          </Text>
          <Pressable
            onPress={() => router.replace('/(auth)/login')}
            style={({ pressed }) => ({
              backgroundColor: pressed ? '#4f46e5' : '#6366f1',
              borderRadius: 12,
              paddingVertical: 14,
              paddingHorizontal: 32,
              marginTop: 32,
            })}
          >
            <Text style={{ color: '#fff', fontSize: 15, fontWeight: '600' }}>
              Back to Login
            </Text>
          </Pressable>
        </View>
      </View>
    );
  }

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
          <Text style={{ fontSize: 28, fontWeight: '800', color: '#f8fafc', letterSpacing: -0.5 }}>
            Reset Password
          </Text>
          <Text style={{ fontSize: 15, color: '#94a3b8', marginTop: 8, textAlign: 'center' }}>
            Enter your email and we'll send you a link to reset your password
          </Text>
        </View>

        {/* Email */}
        <Text style={{ fontSize: 13, fontWeight: '600', color: '#cbd5e1', marginBottom: 6 }}>
          Email Address
        </Text>
        <TextInput
          style={{
            backgroundColor: '#1e293b',
            borderRadius: 12,
            padding: 14,
            fontSize: 16,
            color: '#f1f5f9',
            borderWidth: 1,
            borderColor: '#334155',
            marginBottom: 24,
          }}
          value={email}
          onChangeText={setEmail}
          placeholder="email@example.com"
          placeholderTextColor="#475569"
          autoCapitalize="none"
          autoComplete="email"
          keyboardType="email-address"
          textContentType="emailAddress"
        />

        {/* Submit */}
        <Pressable
          onPress={handleReset}
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
              Send Reset Link
            </Text>
          )}
        </Pressable>

        {/* Back to Login */}
        <Pressable
          onPress={() => router.back()}
          style={{ alignItems: 'center', marginTop: 20 }}
        >
          <Text style={{ color: '#818cf8', fontSize: 14, fontWeight: '500' }}>
            ← Back to Login
          </Text>
        </Pressable>
      </ScrollView>
    </KeyboardAvoidingView>
  );
}
