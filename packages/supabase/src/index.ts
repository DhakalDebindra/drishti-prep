import {
  createBrowserClient as createSupabaseBrowserClient,
  createServerClient as createSupabaseServerClient,
} from "@supabase/ssr";
import {
  createClient as createSupabaseClient,
  type SupabaseClient,
} from "@supabase/supabase-js";
import type { Database } from "./database.types";

export type RepoSupabaseClient = SupabaseClient<Database>;

export type SupabaseStorageAdapter = {
  getItem: (key: string) => string | Promise<string | null> | null;
  setItem: (key: string, value: string) => void | Promise<void>;
  removeItem: (key: string) => void | Promise<void>;
};

export type SupabaseCookieAdapter = {
  getAll: () => { name: string; value: string }[];
  setAll: (
    cookiesToSet: {
      name: string;
      value: string;
      options?: Record<string, unknown>;
    }[]
  ) => void;
};

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL!;
const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!;

export function createClient(storage: SupabaseStorageAdapter) {
  return createSupabaseClient<Database>(supabaseUrl, supabaseAnonKey, {
    auth: {
      storage,
      persistSession: true,
      autoRefreshToken: true,
      detectSessionInUrl: true,
    },
  });
}

export function createBrowserClient() {
  return createSupabaseBrowserClient<Database>(supabaseUrl, supabaseAnonKey);
}

export function createServerClient(cookieAdapter: SupabaseCookieAdapter) {
  return createSupabaseServerClient<Database>(supabaseUrl, supabaseAnonKey, {
    cookies: cookieAdapter,
  });
}

export function createStaticClient() {
  return createSupabaseClient<Database>(supabaseUrl, supabaseAnonKey);
}

export type { Database, Json, Tables, TablesInsert, TablesUpdate } from "./database.types";
export * from "./rls";
