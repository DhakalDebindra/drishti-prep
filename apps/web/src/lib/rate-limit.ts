import { Ratelimit } from "@upstash/ratelimit";
import { Redis } from "@upstash/redis";

const redis =
  process.env.UPSTASH_REDIS_REST_URL && process.env.UPSTASH_REDIS_REST_TOKEN
    ? new Redis({
        url: process.env.UPSTASH_REDIS_REST_URL,
        token: process.env.UPSTASH_REDIS_REST_TOKEN,
      })
    : null;

if (!redis) {
  console.warn(
    "[rate-limit] Upstash env vars not set — rate limiting disabled. " +
      "Set UPSTASH_REDIS_REST_URL and UPSTASH_REDIS_REST_TOKEN for production."
  );
}

function createLimiter(requests: number, window: string, prefix: string) {
  if (!redis) {
    return {
      limit: async (_id: string) => ({
        success: true,
        limit: requests,
        remaining: requests,
        reset: Date.now(),
        pending: Promise.resolve(),
      }),
    };
  }
  return new Ratelimit({
    redis,
    limiter: Ratelimit.slidingWindow(requests, window as Parameters<typeof Ratelimit.slidingWindow>[1]),
    analytics: true,
    prefix: `drishtiprep:${prefix}`,
  });
}

/** Auth endpoints (login, signup, password reset): 5 requests per 15 minutes */
export const authRatelimit = createLimiter(5, "15 m", "auth");

/** AI feedback endpoint: 20 requests per minute per user */
export const aiRatelimit = createLimiter(20, "1 m", "ai");

/** General API endpoints: 60 requests per minute */
export const apiRatelimit = createLimiter(60, "1 m", "api");

const IP_V4_OCTET = /^(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)$/;
const IP_V6_CHUNK = /^[0-9a-fA-F]{1,4}$/;

function isValidIp(value: string): boolean {
  const v4 = value.split(".");
  if (v4.length === 4) return v4.every((o) => IP_V4_OCTET.test(o));
  if (value.startsWith("[")) return false;
  const v6 = value.split(":");
  if (v6.length >= 2 && v6.length <= 8) return v6.every((c) => !c || IP_V6_CHUNK.test(c));
  return false;
}

/**
 * Extracts the client IP from a Request, hardening against header spoofing
 * by validating the extracted value is a real IP address before passing it
 * to the rate limiter. Falls back to `"anonymous"` for invalid or missing IPs.
 *
 * On Vercel the `x-forwarded-for` header is set by the platform proxy and is
 * trustworthy; this validation is defense-in-depth for self-hosted deploys.
 */
export function extractClientIp(req: Request): string {
  const raw =
    req.headers.get("x-forwarded-for")?.split(",")[0].trim() ??
    req.headers.get("x-real-ip") ??
    "";
  return raw && isValidIp(raw) ? raw : "anonymous";
}
