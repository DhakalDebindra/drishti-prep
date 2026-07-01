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
      <View className="flex-1 bg-background justify-center p-6">
        <View className="items-center">
          <Text className="text-5xl mb-4">📧</Text>
          <Text className="text-[22px] font-bold text-foreground mb-3 text-center">
            Check Your Email
          </Text>
          <Text className="text-[15px] text-muted-foreground text-center leading-6">
            We sent a password reset link to{'\n'}
            <Text className="text-primary font-semibold">{email.trim()}</Text>
          </Text>
          <Pressable
            onPress={() => router.replace('/(auth)/login')}
            className="rounded-xl px-8 py-3.5 mt-8 items-center bg-primary active:opacity-80"
          >
            <Text className="text-primary-foreground text-[15px] font-semibold">
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
      className="flex-1 bg-background"
    >
      <ScrollView
        contentContainerStyle={{ flexGrow: 1, justifyContent: 'center', padding: 24 }}
        keyboardShouldPersistTaps="handled"
      >
        {/* Header */}
        <View className="mb-8 items-center">
          <Text className="text-[28px] font-extrabold text-foreground tracking-tight">
            Reset Password
          </Text>
          <Text className="text-[15px] text-muted-foreground mt-2 text-center">
            Enter your email and we'll send you a link to reset your password
          </Text>
        </View>

        {/* Email */}
        <Text className="text-[13px] font-semibold text-foreground mb-1.5">
          Email Address
        </Text>
        <TextInput
          className="bg-card rounded-xl p-3.5 text-base text-foreground border border-border mb-6"
          value={email}
          onChangeText={setEmail}
          placeholder="email@example.com"
          placeholderTextColor="#94a3b8"
          autoCapitalize="none"
          autoComplete="email"
          keyboardType="email-address"
          textContentType="emailAddress"
        />

        {/* Submit */}
        <Pressable
          onPress={handleReset}
          disabled={loading}
          className={`rounded-xl p-4 items-center bg-primary ${loading ? 'opacity-70' : 'active:opacity-80'}`}
        >
          {loading ? (
            <ActivityIndicator color="#ffffff" />
          ) : (
            <Text className="text-primary-foreground text-base font-bold">
              Send Reset Link
            </Text>
          )}
        </Pressable>

        {/* Back to Login */}
        <Pressable
          onPress={() => router.back()}
          className="items-center mt-5"
        >
          <Text className="text-primary text-sm font-medium">
            ← Back to Login
          </Text>
        </Pressable>
      </ScrollView>
    </KeyboardAvoidingView>
  );
}
