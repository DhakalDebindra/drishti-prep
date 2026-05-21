"use client";

import { useEffect, useState } from "react";
import type { TutorAudioUrls } from "@repo/types";
import { prefetchSegments } from "@/lib/tutor-audio-cache";

type State =
  | { status: "loading" }
  | { status: "ready"; urls: TutorAudioUrls; voice: string }
  | { status: "not_generated" }
  | { status: "error"; message: string };

// Per-question audio metadata resolved from the API, cached for the page
// session so revisited — and pre-navigated — questions skip the round trip.
// Transient errors are intentionally NOT cached so they can retry later.
const metaCache = new Map<string, State>();

async function fetchQuestionAudio(questionId: string): Promise<State> {
  try {
    const res = await fetch(`/api/questions/${questionId}/audio`);
    if (!res.ok) throw new Error(`HTTP ${res.status}`);
    const json = await res.json();
    if (!json.ready) return { status: "not_generated" };
    return {
      status: "ready",
      urls: json.urls as TutorAudioUrls,
      voice: json.voice as string,
    };
  } catch (err) {
    return { status: "error", message: (err as Error)?.message ?? "Failed" };
  }
}

function resolveQuestionAudio(questionId: string): Promise<State> {
  const cached = metaCache.get(questionId);
  if (cached) return Promise.resolve(cached);
  return fetchQuestionAudio(questionId).then((state) => {
    if (state.status !== "error") metaCache.set(questionId, state);
    if (state.status === "ready") prefetchSegments(state.urls);
    return state;
  });
}

function deriveState(questionId: string | null): State {
  if (!questionId) return { status: "not_generated" };
  return metaCache.get(questionId) ?? { status: "loading" };
}

/**
 * Warm a question's audio without rendering it: resolves its URLs and starts
 * downloading every segment blob. Used to pre-fetch the next/previous
 * questions so navigation is instant.
 */
export function prefetchQuestionAudio(questionId: string | null): void {
  if (!questionId || metaCache.has(questionId)) return;
  void resolveQuestionAudio(questionId);
}

/**
 * Fetches the public audio URLs for a question. Returns `not_generated` when
 * the admin hasn't pre-warmed audio for this question yet — the practice page
 * should fall back to its existing screen-reader-only behavior in that case.
 */
export function useTutorAudio(questionId: string | null): State {
  const [entry, setEntry] = useState<{ id: string | null; state: State }>(
    () => ({ id: questionId, state: deriveState(questionId) })
  );

  // Never hand the player the previous question's URLs after `questionId`
  // changes: derive the new question's state (cached, or "loading") during
  // render so there is no stale frame. `setEntry` only commits async results.
  const current =
    entry.id === questionId
      ? entry.state
      : deriveState(questionId);

  useEffect(() => {
    if (!questionId) return;

    const cached = metaCache.get(questionId);
    if (cached) {
      if (cached.status === "ready") prefetchSegments(cached.urls);
      return;
    }

    let cancelled = false;
    resolveQuestionAudio(questionId).then((state) => {
      if (!cancelled) setEntry({ id: questionId, state });
    });

    return () => {
      cancelled = true;
    };
  }, [questionId]);

  return current;
}
