import * as SecureStore from "expo-secure-store";
import { createClient } from "@supabase/supabase-js";
import "react-native-url-polyfill/auto";
import type { Database } from "./database.types";

const supabaseUrl = process.env.EXPO_PUBLIC_SUPABASE_URL!;
const supabaseAnonKey = process.env.EXPO_PUBLIC_SUPABASE_ANON_KEY!;

/**
 * SecureStore-backed storage adapter for Supabase auth tokens.
 *
 * Why SecureStore instead of AsyncStorage:
 * - Auth tokens (JWT refresh tokens) are sensitive credentials
 * - SecureStore uses the device's secure enclave (Keychain on iOS, Keystore on Android)
 * - AsyncStorage writes plaintext to disk — accessible on rooted/jailbroken devices
 *
 * NOTE: This requires the EAS custom dev client (expo-secure-store has native code).
 *       Never test with Expo Go from the Play Store.
 */
const SecureStoreAdapter = {
  getItem: async (key: string): Promise<string | null> => {
    return await SecureStore.getItemAsync(key);
  },
  setItem: async (key: string, value: string): Promise<void> => {
    await SecureStore.setItemAsync(key, value);
  },
  removeItem: async (key: string): Promise<void> => {
    await SecureStore.deleteItemAsync(key);
  },
};

export const supabaseMobile = createClient<Database>(supabaseUrl, supabaseAnonKey, {
  auth: {
    storage: SecureStoreAdapter,
    autoRefreshToken: true,
    persistSession: true,
    detectSessionInUrl: false,
    flowType: "pkce",
  },
});
