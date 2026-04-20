export default function Loading() {
  return (
    <div className="flex min-h-[50vh] items-center justify-center bg-gray-50 text-gray-700">
      <div className="flex items-center gap-3 rounded-lg border border-gray-200 bg-white px-6 py-4 shadow-sm">
        <div className="h-5 w-5 animate-spin rounded-full border-2 border-blue-500 border-t-transparent" aria-hidden="true" />
        <p className="text-sm font-medium">Loading practice content…</p>
      </div>
    </div>
  );
}
