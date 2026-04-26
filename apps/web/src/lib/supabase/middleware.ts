import { createServerClient } from "@repo/supabase";
import { NextResponse, type NextRequest } from "next/server";

export async function updateSession(request: NextRequest) {
  let supabaseResponse = NextResponse.next({
    request,
  });

  const supabase = createServerClient({
    getAll() {
      return request.cookies.getAll();
    },
    setAll(cookiesToSet) {
      cookiesToSet.forEach(({ name, value }) => request.cookies.set(name, value));
      supabaseResponse = NextResponse.next({
        request,
      });
      cookiesToSet.forEach(({ name, value, options }) =>
        supabaseResponse.cookies.set(name, value, options)
      );
    },
  });

  const {
    data: { user },
  } = await supabase.auth.getUser();

  const path = request.nextUrl.pathname;
  const isAuthRoute = path.startsWith("/login") || path.startsWith("/signup");
  const isAdminRoute = path.startsWith("/admin");
  const isProtectedRoute =
    path.startsWith("/dashboard") ||
    path.startsWith("/courses") ||
    path.startsWith("/bookmarks") ||
    path.startsWith("/practice");

  const isProtectedApiPost =
    request.method === "POST" &&
    (path.startsWith("/api/subjects") ||
      path.startsWith("/api/topics") ||
      path.startsWith("/api/question-sets"));

  // Prevent logged-in AND verified users from seeing the login page
  if (isAuthRoute && user?.email_confirmed_at) {
    return NextResponse.redirect(new URL("/dashboard", request.url));
  }

  const needsAdminCheck = isAdminRoute || isProtectedApiPost;

  if (isProtectedRoute && (!user || !user.email_confirmed_at)) {
    const redirectUrl = new URL("/login", request.url);
    if (user && !user.email_confirmed_at) {
      redirectUrl.searchParams.set("error", "unverified");
    } else {
      redirectUrl.searchParams.set("redirect_to", request.nextUrl.pathname);
    }
    return NextResponse.redirect(redirectUrl);
  }

  if (needsAdminCheck) {
    // Unauthenticated handling differs between UI and API routes
    if (!user) {
      if (isAdminRoute) {
        const redirectUrl = new URL("/login", request.url);
        redirectUrl.searchParams.set("redirect_to", request.nextUrl.pathname);
        return NextResponse.redirect(redirectUrl);
      }
      // API route
      return NextResponse.json({ error: "Not authenticated" }, { status: 401 });
    }

    // Check admin flag
    const { data: profile } = await supabase
      .from("profiles")
      .select("is_admin")
      .eq("id", user.id)
      .single();

    const isAdmin = !!profile?.is_admin;

    if (!isAdmin) {
      if (isAdminRoute) {
        // UI: redirect non-admins home
        const redirectUrl = new URL("/", request.url);
        return NextResponse.redirect(redirectUrl);
      }
      // Protected API POST: return strict 403
      return NextResponse.json({ error: "Forbidden" }, { status: 403 });
    }
  }

  return supabaseResponse;
}
