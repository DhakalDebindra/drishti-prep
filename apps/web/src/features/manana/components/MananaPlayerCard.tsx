"use client";

import React, { useEffect, useRef, useState } from "react";

interface UseMananaTelemetryProps {
  episodeId: string;
  audioRef: React.RefObject<HTMLAudioElement | null>;
}

export function useMananaTelemetry({ episodeId, audioRef }: UseMananaTelemetryProps) {
  // Use a ref to keep track of the latest time without triggering re-renders
  // or causing stale closures in the event listeners.
  const currentTimeRef = useRef(0);

  useEffect(() => {
    const audio = audioRef.current;
    if (!audio) return;

    // 1. Core Sync Function
    const syncTelemetry = (isCompleted = false, useBeacon = false) => {
      const payload = JSON.stringify({
        episode_id: episodeId,
        listen_duration_seconds: Math.floor(currentTimeRef.current),
        completed: isCompleted,
      });

      if (useBeacon && navigator.sendBeacon) {
        // sendBeacon requires a Blob to set the application/json content type correctly
        const blob = new Blob([payload], { type: 'application/json' });
        navigator.sendBeacon('/api/manana/telemetry', blob);
      } else {
        // Standard fetch for the 10-second interval
        fetch('/api/manana/telemetry', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: payload,
          // keepalive ensures the fetch isn't killed immediately if the component unmounts
          keepalive: true, 
        }).catch((err) => console.error('Telemetry sync failed', err));
      }
    };

    // 2. Track time updates
    const handleTimeUpdate = () => {
      currentTimeRef.current = audio.currentTime;
    };

    // 3. Handle Completion
    const handleEnded = () => syncTelemetry(true, false);

    // 4. Handle Tab Close / Unload / Backgrounding
    const handleVisibilityChange = () => {
      if (document.visibilityState === 'hidden') {
        syncTelemetry(false, true); // Fire beacon when tab is hidden/closed
      }
    };

    // 5. 10-Second Heartbeat Interval
    const heartbeat = setInterval(() => {
      if (!audio.paused) syncTelemetry(false, false);
    }, 10000);

    // Attach Listeners
    audio.addEventListener('timeupdate', handleTimeUpdate);
    audio.addEventListener('ended', handleEnded);
    document.addEventListener('visibilitychange', handleVisibilityChange);
    window.addEventListener('beforeunload', () => syncTelemetry(false, true));

    // Cleanup
    return () => {
      clearInterval(heartbeat);
      audio.removeEventListener('timeupdate', handleTimeUpdate);
      audio.removeEventListener('ended', handleEnded);
      document.removeEventListener('visibilitychange', handleVisibilityChange);
      window.removeEventListener('beforeunload', () => syncTelemetry(false, true));
      
      // Flush final state on component unmount
      syncTelemetry(false, true); 
    };
  }, [episodeId, audioRef]);
}

interface MananaPlayerCardProps {
  episodeId: string;
  audioUrl: string;
}

export function MananaPlayerCard({ episodeId, audioUrl }: MananaPlayerCardProps) {
  const audioRef = useRef<HTMLAudioElement | null>(null);
  const [isPlaying, setIsPlaying] = useState(false);
  const [currentTime, setCurrentTime] = useState(0);
  const [duration, setDuration] = useState(0);
  const [announcement, setAnnouncement] = useState("");
  const announcedMilestones = useRef(new Set<number>());

  useMananaTelemetry({ episodeId, audioRef });

  useEffect(() => {
    if ('mediaSession' in navigator) {
      navigator.mediaSession.metadata = new MediaMetadata({
        title: 'Weekly Revision',
        artist: 'Manana Audio Engine',
        album: 'DrishtiPrep Weekly Revision',
      });
      navigator.mediaSession.setActionHandler('play', () => {
        audioRef.current?.play();
      });
      navigator.mediaSession.setActionHandler('pause', () => {
        audioRef.current?.pause();
      });
    }
  }, []);

  useEffect(() => {
    if (duration > 0) {
      const percent = (currentTime / duration) * 100;
      const milestones = [25, 50, 75, 100];
      for (const m of milestones) {
        if (percent >= m && !announcedMilestones.current.has(m)) {
          announcedMilestones.current.add(m);
          setAnnouncement(`${m} percent complete`);
        }
      }
      if (percent < 5) {
        announcedMilestones.current.clear();
      }
    }
  }, [currentTime, duration]);

  const togglePlay = () => {
    if (audioRef.current) {
      if (isPlaying) {
        audioRef.current.pause();
      } else {
        audioRef.current.play();
      }
    }
  };

  const handleTimeUpdate = () => {
    if (audioRef.current) {
      setCurrentTime(audioRef.current.currentTime);
    }
  };

  const handleLoadedMetadata = () => {
    if (audioRef.current) {
      setDuration(audioRef.current.duration);
    }
  };

  const handleScrub = (e: React.ChangeEvent<HTMLInputElement>) => {
    const newTime = Number(e.target.value);
    setCurrentTime(newTime);
    if (audioRef.current) {
      audioRef.current.currentTime = newTime;
    }
  };

  const formatTime = (time: number) => {
    const minutes = Math.floor(time / 60);
    const seconds = Math.floor(time % 60);
    return `${minutes}:${seconds < 10 ? '0' : ''}${seconds}`;
  };

  return (
    <div className="bg-primary rounded-xl p-6 shadow-lg text-primary-foreground flex flex-col items-center gap-6">
      <div className="text-center">
        <h3 className="text-xl font-bold">Weekly Revision</h3>
        <p className="text-sm text-primary-foreground/80 mt-1">
          A guided audio review of the questions you should revisit this week.
        </p>
      </div>

      <button
        onClick={togglePlay}
        className="w-16 h-16 bg-primary-foreground text-primary rounded-full flex items-center justify-center hover:scale-105 transition-transform shadow-md focus:outline-none focus-visible:ring-4 focus-visible:ring-primary-foreground focus-visible:ring-offset-2 focus-visible:ring-offset-primary"
        aria-label={isPlaying ? "Pause Weekly Revision" : "Play Weekly Revision"}
        aria-pressed={isPlaying}
      >
        {isPlaying ? (
          <svg className="w-8 h-8" fill="currentColor" viewBox="0 0 24 24"><path d="M6 19h4V5H6v14zm8-14v14h4V5h-4z" /></svg>
        ) : (
          <svg className="w-8 h-8 ml-1" fill="currentColor" viewBox="0 0 24 24"><path d="M8 5v14l11-7z" /></svg>
        )}
      </button>

      <div className="w-full flex items-center gap-4 text-sm font-medium">
        <span className="w-10 text-right" aria-hidden="true">{formatTime(currentTime)}</span>
        <input
          type="range"
          min={0}
          max={duration || 100}
          value={currentTime}
          onChange={handleScrub}
          aria-label="Audio progress"
          className="flex-1 h-2 bg-primary-foreground/30 rounded-lg appearance-none cursor-pointer accent-primary-foreground focus:outline-none focus-visible:ring-4 focus-visible:ring-primary-foreground focus-visible:ring-offset-2 focus-visible:ring-offset-primary"
        />
        <span className="w-10" aria-hidden="true">{formatTime(duration)}</span>
      </div>

      <div className="sr-only" aria-live="polite">
        {announcement}
      </div>

      <audio
        ref={audioRef}
        src={audioUrl}
        onTimeUpdate={handleTimeUpdate}
        onLoadedMetadata={handleLoadedMetadata}
        onPlay={() => setIsPlaying(true)}
        onPause={() => setIsPlaying(false)}
        onEnded={() => setIsPlaying(false)}
        className="hidden"
      />
    </div>
  );
}
