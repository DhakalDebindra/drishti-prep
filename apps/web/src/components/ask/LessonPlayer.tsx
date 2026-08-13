"use client";

import { Loader2, Pause, Play, Square } from "lucide-react";
import { useCallback, useEffect, useRef, useState } from "react";

import { AudioCopy } from "@/config/copy";

export type SpeechPart = { text: string; token: string };

/**
 * Play a lesson aloud in Gemini's Nepali voice.
 *
 * Three decisions, all driven by the fact that for a blind or low-vision
 * learner the voice IS the interface rather than a convenience:
 *
 * 1. SECTION BY SECTION. Synthesising the whole reply first meant ~15 seconds
 *    of silence before a word was heard. Playback now starts on the first
 *    section, in about three, while the next is fetched during it.
 * 2. PAUSE, NOT STOP. The earlier control discarded position, so a learner who
 *    paused to think restarted the lesson. Pause resumes where they were.
 * 3. SPEED. Practised screen-reader users listen far faster than natural pace;
 *    forcing 1x wastes their time.
 *
 * Audio is kept for the life of the reply, so replaying or scrubbing back
 * costs nothing. Nothing is written to the server — the text is signed, and
 * the signature is what allows synthesis without our having stored it.
 */

const SPEEDS = [1, 1.25, 1.5, 0.75] as const;

export function LessonPlayer({ parts }: { parts: SpeechPart[] }) {
  const [index, setIndex] = useState(0);
  const [state, setState] = useState<"idle" | "loading" | "playing" | "paused">("idle");
  const [speed, setSpeed] = useState<number>(1);
  const [failed, setFailed] = useState(false);

  const audioRef = useRef<HTMLAudioElement | null>(null);
  // playFrom chains into itself when a section ends; a ref breaks the cycle
  // without the callback referencing its own binding before it exists.
  const playFromRef = useRef<((index: number) => Promise<void>) | null>(null);
  // Blob URLs by section index. Kept so replays and pauses cost nothing.
  const cacheRef = useRef<Map<number, string>>(new Map());
  const cancelledRef = useRef(false);

  const releaseAll = useCallback(() => {
    audioRef.current?.pause();
    audioRef.current = null;
    for (const url of cacheRef.current.values()) URL.revokeObjectURL(url);
    cacheRef.current.clear();
  }, []);

  // Never leave audio playing, or blob URLs alive, after the reply is gone.
  useEffect(() => {
    return () => {
      cancelledRef.current = true;
      releaseAll();
    };
  }, [releaseAll]);

  const fetchPart = useCallback(
    async (partIndex: number): Promise<string | null> => {
      const cached = cacheRef.current.get(partIndex);
      if (cached) return cached;

      const part = parts[partIndex];
      if (!part?.text || !part.token) return null;

      const response = await fetch("/api/ask/speak", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ text: part.text, token: part.token }),
      });
      if (!response.ok) throw new Error("speak failed");

      const url = URL.createObjectURL(await response.blob());
      cacheRef.current.set(partIndex, url);
      return url;
    },
    [parts]
  );

  const playFrom = useCallback(
    async (startIndex: number) => {
      if (startIndex >= parts.length) {
        setState("idle");
        setIndex(0);
        return;
      }

      setFailed(false);
      setState("loading");

      try {
        const url = await fetchPart(startIndex);
        if (!url || cancelledRef.current) return;

        const audio = new Audio(url);
        audio.playbackRate = speed;
        audio.onended = () => {
          // Chain straight into the next section so the lesson reads as one
          // continuous piece rather than something to keep restarting.
          setIndex(startIndex + 1);
          void playFromRef.current?.(startIndex + 1);
        };
        audio.onerror = () => {
          setFailed(true);
          setState("idle");
        };

        audioRef.current = audio;
        setIndex(startIndex);
        await audio.play();
        setState("playing");

        // Fetch the next section during this one, so the join is seamless.
        if (startIndex + 1 < parts.length) {
          void fetchPart(startIndex + 1).catch(() => {});
        }
      } catch {
        setFailed(true);
        setState("idle");
      }
    },
    [fetchPart, parts.length, speed]
  );

  useEffect(() => {
    playFromRef.current = playFrom;
  }, [playFrom]);

  const onPlayPause = useCallback(() => {
    if (state === "playing") {
      audioRef.current?.pause();
      setState("paused");
      return;
    }
    if (state === "paused" && audioRef.current) {
      void audioRef.current.play();
      setState("playing");
      return;
    }
    if (state !== "loading") void playFrom(index);
  }, [index, playFrom, state]);

  const onStop = useCallback(() => {
    audioRef.current?.pause();
    audioRef.current = null;
    setIndex(0);
    setState("idle");
  }, []);

  const onCycleSpeed = useCallback(() => {
    const next = SPEEDS[(SPEEDS.indexOf(speed as never) + 1) % SPEEDS.length];
    setSpeed(next);
    if (audioRef.current) audioRef.current.playbackRate = next;
  }, [speed]);

  if (parts.length === 0) return null;

  const playing = state === "playing";
  const label =
    state === "loading"
      ? AudioCopy.loading
      : playing
        ? AudioCopy.pause
        : state === "paused"
          ? AudioCopy.resume
          : failed
            ? AudioCopy.retry
            : AudioCopy.listen;

  const control =
    "inline-flex min-h-11 items-center gap-2 rounded-lg border-2 border-border bg-background px-3 py-2 text-sm font-semibold text-foreground transition hover:bg-muted focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring disabled:opacity-70";

  return (
    <div className="flex flex-wrap items-center gap-2">
      <button
        type="button"
        onClick={onPlayPause}
        disabled={state === "loading"}
        className={control}
      >
        {state === "loading" ? (
          <Loader2 className="h-4 w-4 animate-spin" aria-hidden="true" />
        ) : playing ? (
          <Pause className="h-4 w-4" aria-hidden="true" />
        ) : (
          <Play className="h-4 w-4" aria-hidden="true" />
        )}
        {label}
      </button>

      {(playing || state === "paused") && (
        <>
          <button type="button" onClick={onStop} className={control}>
            <Square className="h-4 w-4" aria-hidden="true" />
            {AudioCopy.stop}
          </button>

          {/*
            The accessible name carries the current rate, so a screen-reader
            user knows what they are on without a separate readout.
          */}
          <button
            type="button"
            onClick={onCycleSpeed}
            className={control}
            aria-label={AudioCopy.speedLabel(speed)}
          >
            {speed}×
          </button>

          {parts.length > 1 && (
            <span className="text-sm text-muted-foreground">
              {AudioCopy.progress(index + 1, parts.length)}
            </span>
          )}
        </>
      )}
    </div>
  );
}
