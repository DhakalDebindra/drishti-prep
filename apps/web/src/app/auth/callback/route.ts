import { NextResponse } from 'next/server'
import { createClient } from '@/lib/supabase/server'
import { authRatelimit, extractClientIp } from '@/lib/rate-limit'

export async function GET(request: Request) {
  const { success } = await authRatelimit.limit(extractClientIp(request));

  if (!success) {
    return NextResponse.redirect(`${new URL(request.url).origin}/login?error=rate_limited`)
  }

  const { searchParams, origin } = new URL(request.url)
  const code = searchParams.get('code')
  // if "next" is in param, use it as the redirect URL
  const next = searchParams.get('next') ?? '/dashboard'

  if (code) {
    const supabase = await createClient()
    const { error } = await supabase.auth.exchangeCodeForSession(code)
    if (!error) {
      return NextResponse.redirect(`${origin}${next}`)
    }
  }

  // Send back a stable code, not prose: the login form renders these, and
  // echoing a free-text query param onto the page lets anyone put arbitrary
  // words in our error banner. This is the branch a dead confirmation link
  // lands in — the form turns it into a resend prompt.
  return NextResponse.redirect(`${origin}/login?error=link_expired`)
}
