import { cache } from "react";
import { createClient } from "./server";

/**
 * The current user, memoised for the lifetime of one server render.
 *
 * supabase.auth.getUser() validates the JWT against the Supabase auth server,
 * so every call is a network round trip (~200ms from Nepal). A layout and the
 * page inside it both need the user, which meant paying for it twice on every
 * navigation. React's cache() collapses that to one call per request.
 *
 * Server Components only — cache() does not span requests, and route handlers
 * should keep calling supabase.auth.getUser() directly.
 */
export const getCurrentUser = cache(async () => {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  return user;
});
