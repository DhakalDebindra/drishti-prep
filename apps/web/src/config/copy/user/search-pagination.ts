/** Prev/next paging over the practice-set list. Never infinite scroll. */
export const SearchPaginationCopy = {
  label: "Practice set pages",
  previous: "Previous",
  next: "Next",
  position: (page: number, total: number) => `Page ${page} of ${total}`,
} as const;
