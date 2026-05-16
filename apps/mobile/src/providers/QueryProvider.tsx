import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import type { PropsWithChildren } from 'react';

const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      // Stale after 5 minutes — good balance for mobile data usage
      staleTime: 5 * 60 * 1000,
      // Keep unused cache for 30 minutes before garbage collection
      gcTime: 30 * 60 * 1000,
      // Don't refetch on window focus for mobile — AppState changes
      // are handled explicitly in the IAP return flow (Phase 4)
      refetchOnWindowFocus: false,
      // Retry once on failure (network flakiness on mobile)
      retry: 1,
    },
  },
});

export function QueryProvider({ children }: PropsWithChildren) {
  return (
    <QueryClientProvider client={queryClient}>
      {children}
    </QueryClientProvider>
  );
}

// Export the client for use in the IAP return flow (Phase 4)
export { queryClient };
