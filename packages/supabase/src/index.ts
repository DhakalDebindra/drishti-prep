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

function getSupabaseConfig() {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const anonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

  if (!url || !anonKey) {
    throw new Error(
      "Supabase URL and Anon Key are required. Please check your environment variables."
    );
  }

  return { url, anonKey };
}

export function createClient(storage: SupabaseStorageAdapter) {
  const { url, anonKey } = getSupabaseConfig();
  return createSupabaseClient<Database>(url, anonKey, {
    auth: {
      storage,
      persistSession: true,
      autoRefreshToken: true,
      detectSessionInUrl: true,
    },
  });
}

export function createBrowserClient() {
  const { url, anonKey } = getSupabaseConfig();
  return createSupabaseBrowserClient<Database>(url, anonKey);
}

export function createServerClient(cookieAdapter: SupabaseCookieAdapter) {
  const { url, anonKey } = getSupabaseConfig();
  return createSupabaseServerClient<Database>(url, anonKey, {
    cookies: cookieAdapter,
  });
}

export function createStaticClient() {
  const { url, anonKey } = getSupabaseConfig();
  return createSupabaseClient<Database>(url, anonKey);
}

export type { Database, Json, Tables, TablesInsert, TablesUpdate } from "./database.types";
export * from "./rls";
