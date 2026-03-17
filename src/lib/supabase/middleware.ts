import { createServerClient } from '@supabase/ssr'
import { NextResponse, type NextRequest } from 'next/server'

export async function updateSession(request: NextRequest) {
  let supabaseResponse = NextResponse.next({
    request,
  })

  const supabase = createServerClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!,
    {
      cookies: {
        getAll() {
          return request.cookies.getAll()
        },
        setAll(cookiesToSet) {
          cookiesToSet.forEach(({ name, value, options }) => request.cookies.set(name, value))
          supabaseResponse = NextResponse.next({
            request,
          })
          cookiesToSet.forEach(({ name, value, options }) =>
            supabaseResponse.cookies.set(name, value, options)
          )
        },
      },
    }
  )

  const {
    data: { user },
  } = await supabase.auth.getUser()

  const isAuthRoute = request.nextUrl.pathname.startsWith('/login')
  const isAdminRoute = request.nextUrl.pathname.startsWith('/admin')

  // Prevent logged-in users from seeing the login page
  if (isAuthRoute && user) {
    return NextResponse.redirect(new URL('/admin/question-sets/create', request.url))
  }

  // Protect admin routes
  if (isAdminRoute) {
    if (!user) {
      const redirectUrl = new URL('/login', request.url)
      redirectUrl.searchParams.set('redirect_to', request.nextUrl.pathname)
      return NextResponse.redirect(redirectUrl)
    }

    // // Check if user is actually an admin
    // const { data: profile } = await supabase
    //   .from('profiles')
    //   .select('is_admin')
    //   .eq('id', user.id)
    //   .single()

    // if (!profile?.is_admin) {
    //   // Could redirect to a /dashboard or a 403 unauthorized page. For now, redirect to root
    //   return NextResponse.redirect(new URL('/', request.url))
    // }
  }

  return supabaseResponse
}
