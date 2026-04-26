import {
  createServerClient as createRepoServerClient,
  createStaticClient as createRepoStaticClient,
} from "@repo/supabase";
import { cookies } from "next/headers";

export async function createClient() {
  const cookieStore = await cookies();

  return createRepoServerClient({
    getAll() {
      return cookieStore.getAll();
    },
    setAll(cookiesToSet) {
      try {
        cookiesToSet.forEach(({ name, value, options }) =>
          cookieStore.set(name, value, options)
        );
      } catch {
        // The `setAll` method was called from a Server Component.
        // This can be ignored if you have middleware refreshing
        // user sessions.
      }
    },
  });
}

export function createStaticClient() {
  return createRepoStaticClient();
}
