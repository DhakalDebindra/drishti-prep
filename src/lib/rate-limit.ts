type RateLimitOptions = {
  windowMs: number
  max: number
}

// Very small in-memory token bucket keyed by IP for quick mitigation.
// Not production-grade but stops immediate abuse.
const buckets = new Map<string, { tokens: number; resetAt: number }>()

export async function rateLimitByIp(req: Request, opts: RateLimitOptions) {
  const ip = req.headers.get('x-forwarded-for')?.split(',')[0]?.trim() || 'unknown'
  const now = Date.now()

  const bucket = buckets.get(ip)
  if (!bucket || now > bucket.resetAt) {
    buckets.set(ip, { tokens: opts.max - 1, resetAt: now + opts.windowMs })
    return { ok: true, remaining: opts.max - 1 }
  }

  if (bucket.tokens <= 0) {
    return { ok: false, remaining: 0 }
  }

  bucket.tokens -= 1
  return { ok: true, remaining: bucket.tokens }
}
