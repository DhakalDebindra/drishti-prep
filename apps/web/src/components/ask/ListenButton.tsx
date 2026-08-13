"use client";

import { Loader2, Square, Volume2 } from "lucide-react";
import { useCallback, useEffect, useRef, useState } from "react";

import { AudioCopy } from "@/config/copy";

/**
 * Play one AI reply in Gemini's Nepali voice.
 *
 * The first version used the browser's speechSynthesis — free and instant, but
 * a generic engine reading Devanagari sounds wrong enough that a learner who
 * relies on audio will not use it. For an audience that is blind or low-vision
 * the voice is the interface, so this calls the server TTS instead and accepts
 * the wait.
 *
 * It sits at the TOP of a reply, not the bottom: someone who wants to listen
 * rather than read should not have to travel past the whole answer to find the
 * control for it.
 *
 * Never autoplays — a second voice starting unbidden talks over the learner's
 * own screen reader.
 */
export function ListenButton({ messageId }: { messageId: string | null }) {
  const [state, setState] = useState<"idle" | "loading" | "playing">("idle");
  const [failed, setFailed] = useState(false);
  const audioRef = useRef<HTMLAudioElement | null>(null);
  const urlRef = useRef<string | null>(null);

  const cleanup = useCallback(() => {
    audioRef.current?.pause();
    audioRef.current = null;
    if (urlRef.current) {
      URL.revokeObjectURL(urlRef.current);
      urlRef.current = null;
    }
  }, []);

  // Never leave audio playing after the reply has gone from the page.
  useEffect(() => cleanup, [cleanup]);

  const toggle = useCallback(async () => {
    if (!messageId) return;

    if (state === "playing") {
      cleanup();
      setState("idle");
      return;
    }
    if (state === "loading") return;

    setFailed(false);
    setState("loading");

    try {
      // Re-use the audio once fetched, so replaying costs nothing.
      if (!urlRef.current) {
        const response = await fetch("/api/ask/speak", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ message_id: messageId }),
        });
        if (!response.ok) throw new Error("speak failed");
        const blob = await response.blob();
        urlRef.current = URL.createObjectURL(blob);
      }

      const audio = new Audio(urlRef.current);
      audio.onended = () => setState("idle");
      audio.onerror = () => {
        setFailed(true);
        setState("idle");
      };
      audioRef.current = audio;
      await audio.play();
      setState("playing");
    } catch {
      setFailed(true);
      setState("idle");
    }
  }, [cleanup, messageId, state]);

  if (!messageId) return null;

  const label =
    state === "playing"
      ? AudioCopy.stop
      : state === "loading"
        ? AudioCopy.loading
        : failed
          ? AudioCopy.retry
          : AudioCopy.listen;

  return (
    <button
      type="button"
      onClick={() => void toggle()}
      disabled={state === "loading"}
      className="inline-flex min-h-11 items-center gap-2 rounded-lg border-2 border-border bg-background px-3 py-2 text-sm font-semibold text-foreground transition hover:bg-muted focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring disabled:opacity-70"
    >
      {state === "loading" ? (
        <Loader2 className="h-4 w-4 animate-spin" aria-hidden="true" />
      ) : state === "playing" ? (
        <Square className="h-4 w-4" aria-hidden="true" />
      ) : (
        <Volume2 className="h-4 w-4" aria-hidden="true" />
      )}
      {label}
    </button>
  );
}
