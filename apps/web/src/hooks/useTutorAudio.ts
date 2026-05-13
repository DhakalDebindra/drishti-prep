"use client";

import { useEffect, useState } from "react";
import type { TutorAudioUrls } from "@repo/types";

type State =
  | { status: "loading" }
  | { status: "ready"; urls: TutorAudioUrls; voice: string }
  | { status: "not_generated" }
  | { status: "error"; message: string };

/**
 * Fetches the public audio URLs for a question. Returns `not_generated` when
 * the admin hasn't pre-warmed audio for this question yet — the practice page
 * should fall back to its existing screen-reader-only behavior in that case.
 */
export function useTutorAudio(questionId: string | null): State {
  const [state, setState] = useState<State>({ status: "loading" });

  useEffect(() => {
    if (!questionId) {
      // eslint-disable-next-line react-hooks/set-state-in-effect
      setState({ status: "not_generated" });
      return;
    }

    let cancelled = false;
    setState({ status: "loading" });

    fetch(`/api/questions/${questionId}/audio`)
      .then((res) => {
        if (!res.ok) throw new Error(`HTTP ${res.status}`);
        return res.json();
      })
      .then((json) => {
        if (cancelled) return;
        if (!json.ready) {
          setState({ status: "not_generated" });
          return;
        }
        setState({
          status: "ready",
          urls: json.urls as TutorAudioUrls,
          voice: json.voice as string,
        });
      })
      .catch((err) => {
        if (cancelled) return;
        setState({ status: "error", message: err.message ?? "Failed" });
      });

    return () => {
      cancelled = true;
    };
  }, [questionId]);

  return state;
}
