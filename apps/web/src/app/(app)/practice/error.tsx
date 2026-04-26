"use client";

export default function Error({ error, reset }: { error: Error; reset: () => void }) {
  return (
    <div className="flex min-h-[50vh] flex-col items-center justify-center bg-red-50 px-6 text-center text-red-800">
      <div className="mb-4 rounded-lg bg-white px-5 py-4 shadow-sm">
        <p className="text-sm font-semibold">Something went wrong while loading practice content.</p>
        <p className="mt-2 text-xs text-red-600">{error.message || "Unexpected error"}</p>
      </div>
      <button
        type="button"
        className="rounded-full bg-red-600 px-4 py-2 text-sm font-semibold text-white shadow hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-red-400"
        onClick={() => reset()}
      >
        Try Again
      </button>
    </div>
  );
}
