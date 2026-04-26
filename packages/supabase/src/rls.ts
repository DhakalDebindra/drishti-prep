import type { SupabaseClient, User } from "@supabase/supabase-js";
import type { Database, Tables } from "./database.types";

export type RepoSupabaseClient = SupabaseClient<Database>;

export class SupabaseAuthError extends Error {
  status: number;

  constructor(message: string, status: number) {
    super(message);
    this.name = "SupabaseAuthError";
    this.status = status;
  }
}

export async function getCurrentUser(
  client: RepoSupabaseClient
): Promise<User | null> {
  const {
    data: { user },
    error,
  } = await client.auth.getUser();

  if (error) {
    throw new SupabaseAuthError(error.message, 401);
  }

  return user;
}

export async function requireUser(
  client: RepoSupabaseClient
): Promise<User> {
  const user = await getCurrentUser(client);

  if (!user) {
    throw new SupabaseAuthError("Not authenticated", 401);
  }

  return user;
}

export async function getProfile(
  client: RepoSupabaseClient,
  userId: string
): Promise<Tables<"profiles"> | null> {
  const { data, error } = await client
    .from("profiles")
    .select("*")
    .eq("id", userId)
    .maybeSingle();

  if (error) {
    throw new SupabaseAuthError(error.message, 500);
  }

  return data;
}

export async function requireAdmin(client: RepoSupabaseClient) {
  const user = await requireUser(client);
  const profile = await getProfile(client, user.id);

  if (!profile?.is_admin) {
    throw new SupabaseAuthError("Forbidden", 403);
  }

  return { user, profile };
}
