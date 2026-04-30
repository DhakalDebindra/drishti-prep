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
