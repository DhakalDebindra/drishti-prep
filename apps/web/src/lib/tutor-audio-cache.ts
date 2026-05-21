import type { TutorAudioUrls } from "@repo/types";

/**
 * In-memory blob cache for Shruti tutor-voice segments.
 *
 * The audio pipeline stores six small MP3s per question (stem, four options,
 * explanation). Pointing an <audio> element straight at each remote URL means
 * a cold network fetch for every segment and every question change, which is
 * heard as buffering gaps. This module downloads each segment once, keeps it
 * as an object URL, and returns that instantly on every later play. Combined
 * with prefetching the current and adjacent questions, navigation never waits
 * on the network.
 */

// Resolved remote URL -> object URL. Populated once a blob finishes downloading.
const resolved = new Map<string, string>();
// In-flight downloads, so concurrent callers share a single fetch.
const pending = new Map<string, Promise<string>>();
// Remote URLs whose download failed (e.g. storage CORS). Callers fall back to
// streaming the remote URL directly rather than re-spamming a doomed fetch.
const failed = new Set<string>();

/** Synchronous cache hit, or null if the blob has not been downloaded yet. */
export function peekAudioObjectURL(remoteUrl: string): string | null {
  return resolved.get(remoteUrl) ?? null;
}

/** Download (or reuse) a segment and resolve to a same-origin object URL. */
export function getAudioObjectURL(remoteUrl: string): Promise<string> {
  const hit = resolved.get(remoteUrl);
  if (hit) return Promise.resolve(hit);

  if (failed.has(remoteUrl)) {
    return Promise.reject(new Error(`audio prefetch unavailable: ${remoteUrl}`));
  }

  const inFlight = pending.get(remoteUrl);
  if (inFlight) return inFlight;

  const download = fetch(remoteUrl)
    .then((res) => {
      if (!res.ok) throw new Error(`HTTP ${res.status}`);
      return res.blob();
    })
    .then((blob) => {
      const objectUrl = URL.createObjectURL(blob);
      resolved.set(remoteUrl, objectUrl);
      pending.delete(remoteUrl);
      return objectUrl;
    })
    .catch((err) => {
      pending.delete(remoteUrl);
      failed.add(remoteUrl);
      throw err;
    });

  pending.set(remoteUrl, download);
  return download;
}

/** Fire-and-forget prefetch of every segment of a question. */
export function prefetchSegments(urls: TutorAudioUrls): void {
  for (const url of Object.values(urls)) {
    if (typeof url === "string" && url) {
      void getAudioObjectURL(url).catch(() => {
        /* prefetch failures fall back to direct streaming at play time */
      });
    }
  }
}
