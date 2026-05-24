// Audio segmentation for Shruti Nepali playback.
//
// Problem: Edge TTS is autoregressive and re-rolls subtle vocal
// characteristics on every call. Synthesizing one word at a time produces
// a jarring "many different speakers" effect across a long passage.
//
// Solution: synthesize a whole SENTENCE in one Edge TTS call (one continuous
// take, perfect internal consistency), then slice it client-side via
// silence detection so word/phrase modes can still play individual chunks.
//
// Why silence detection works: Edge TTS's audio output has reliable inter-
// word gaps (~50–200ms of low-energy frames). The RMS-based detector
// below finds those gaps, gives each word a start/end time, and the
// player uses Web Audio's AudioBufferSourceNode.start(when, offset,
// duration) to play exactly the requested slice.
//
// All operations are pure: same blob in → same segments out. Results are
// safe to cache.

export interface WordSegment {
  startSec: number;
  endSec: number;
}

export interface AnalyzedAudio {
  buffer: AudioBuffer;
  wordSegments: WordSegment[];
  totalDurationSec: number;
}

interface SegmenterConfig {
  /** Frame size for RMS analysis, in seconds. 20ms is standard for VAD. */
  frameSec: number;
  /** RMS below this counts as silence. */
  silenceRmsThreshold: number;
  /** Silences shorter than this are intra-word, not word boundaries. */
  minSilenceMs: number;
  /** Words shorter than this are noise / artifacts and get merged with neighbour. */
  minWordMs: number;
  /** Leading silence to trim from the first segment. */
  leadingTrimMs: number;
}

const DEFAULT_CONFIG: SegmenterConfig = {
  frameSec: 0.02,
  silenceRmsThreshold: 0.012,
  minSilenceMs: 80,
  minWordMs: 100,
  leadingTrimMs: 50,
};

/**
 * Decode an audio Blob and detect word boundaries.
 * `audioCtx` is reused across calls so we don't churn AudioContexts.
 */
export async function analyzeAudio(
  blob: Blob,
  audioCtx: AudioContext,
  config: Partial<SegmenterConfig> = {},
): Promise<AnalyzedAudio> {
  const cfg = { ...DEFAULT_CONFIG, ...config };
  const arrayBuffer = await blob.arrayBuffer();
  // decodeAudioData mutates the buffer in some browsers; clone defensively.
  const ab = arrayBuffer.slice(0);
  const buffer = await audioCtx.decodeAudioData(ab);
  const wordSegments = detectWordSegments(buffer, cfg);
  return {
    buffer,
    wordSegments,
    totalDurationSec: buffer.duration,
  };
}

function detectWordSegments(buffer: AudioBuffer, cfg: SegmenterConfig): WordSegment[] {
  const sampleRate = buffer.sampleRate;
  const samples = buffer.getChannelData(0);
  const frameSize = Math.max(1, Math.floor(sampleRate * cfg.frameSec));
  const minSilenceFrames = Math.max(1, Math.ceil(cfg.minSilenceMs / 1000 / cfg.frameSec));
  const minWordFrames = Math.max(1, Math.ceil(cfg.minWordMs / 1000 / cfg.frameSec));

  // Compute per-frame RMS.
  const frameCount = Math.floor(samples.length / frameSize);
  const rms = new Float32Array(frameCount);
  for (let f = 0; f < frameCount; f++) {
    let sumSq = 0;
    const start = f * frameSize;
    const end = start + frameSize;
    for (let i = start; i < end; i++) {
      const v = samples[i];
      sumSq += v * v;
    }
    rms[f] = Math.sqrt(sumSq / frameSize);
  }

  // Auto-tune threshold: noise floor estimate + headroom. This makes the
  // detector robust to recordings of different loudness.
  const sortedRms = Array.from(rms).sort((a, b) => a - b);
  const noiseFloor = sortedRms[Math.floor(sortedRms.length * 0.1)] || 0;
  const adaptiveThreshold = Math.max(cfg.silenceRmsThreshold, noiseFloor * 2.5);

  // Walk frames, mark speech vs silence.
  const isSpeech: boolean[] = new Array(frameCount);
  for (let f = 0; f < frameCount; f++) {
    isSpeech[f] = rms[f] > adaptiveThreshold;
  }

  // Find speech runs separated by silences >= minSilenceFrames.
  const segments: WordSegment[] = [];
  let runStart: number | null = null;
  let silenceLen = 0;

  for (let f = 0; f < frameCount; f++) {
    if (isSpeech[f]) {
      if (runStart === null) runStart = f;
      silenceLen = 0;
    } else {
      silenceLen++;
      if (runStart !== null && silenceLen >= minSilenceFrames) {
        const runEnd = f - silenceLen + 1;
        const runFrames = runEnd - runStart;
        if (runFrames >= minWordFrames) {
          segments.push({
            startSec: runStart * cfg.frameSec,
            endSec: runEnd * cfg.frameSec,
          });
        }
        runStart = null;
      }
    }
  }
  // Close the final run if speech continued to the end.
  if (runStart !== null) {
    const runEnd = frameCount;
    if (runEnd - runStart >= minWordFrames) {
      segments.push({
        startSec: runStart * cfg.frameSec,
        endSec: runEnd * cfg.frameSec,
      });
    }
  }

  // Trim leading silence on the first segment so word mode doesn't start
  // with an awkward gap.
  if (segments.length > 0) {
    segments[0].startSec = Math.max(
      0,
      segments[0].startSec - cfg.leadingTrimMs / 1000,
    );
  }

  // Reconcile: if the segmenter found WAY more or fewer "words" than we
  // expect (caller passes expected count via reconcileToExpected), we
  // bail to "single segment of whole audio" so playback isn't garbled.
  return segments;
}

/**
 * Reconcile detected segments against the expected word count. If the
 * detector found significantly more or fewer segments than there are
 * actual words, fall back to splitting evenly across the audio (still
 * works for sentence/phrase playback even when detection failed).
 */
export function reconcileSegments(
  detected: WordSegment[],
  expectedWordCount: number,
  totalDurationSec: number,
): WordSegment[] {
  if (expectedWordCount <= 0) return detected;
  // Tolerance: within ±25% of expected is "close enough".
  const ratio = detected.length / expectedWordCount;
  if (ratio >= 0.75 && ratio <= 1.4 && detected.length > 0) {
    // Detector found a sensible count. If slightly off, merge adjacent
    // short segments to match expected count.
    if (detected.length > expectedWordCount) {
      return mergeShortest(detected, expectedWordCount);
    }
    return detected;
  }
  // Detector failed or audio has unusual pacing — fall back to even split.
  return evenSplit(totalDurationSec, expectedWordCount);
}

function mergeShortest(segs: WordSegment[], target: number): WordSegment[] {
  const arr = segs.slice();
  while (arr.length > target) {
    // Find adjacent pair with smallest combined gap; merge them.
    let bestIdx = 0;
    let bestGap = Infinity;
    for (let i = 0; i < arr.length - 1; i++) {
      const gap = arr[i + 1].startSec - arr[i].endSec;
      if (gap < bestGap) {
        bestGap = gap;
        bestIdx = i;
      }
    }
    arr[bestIdx] = {
      startSec: arr[bestIdx].startSec,
      endSec: arr[bestIdx + 1].endSec,
    };
    arr.splice(bestIdx + 1, 1);
  }
  return arr;
}

function evenSplit(totalSec: number, count: number): WordSegment[] {
  const segs: WordSegment[] = [];
  const per = totalSec / count;
  for (let i = 0; i < count; i++) {
    segs.push({
      startSec: i * per,
      endSec: (i + 1) * per,
    });
  }
  return segs;
}
