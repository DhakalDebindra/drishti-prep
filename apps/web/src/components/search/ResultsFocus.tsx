"use client";

import { useEffect, useRef } from "react";

/**
 * Move keyboard focus to the results heading after a search.
 *
 * Submitting the form navigates, and by default focus lands back at the top of
 * the document — so a keyboard or screen-reader user has to tab through the
 * whole navbar again to reach what they just asked for. Sighted users get the
 * results handed to them; without this, nobody else does.
 *
 * Only after an ACTUAL submit. SearchBox sets a one-shot flag as the form
 * navigates; without it this also fired when someone opened a shared or
 * bookmarked results link, moving focus mid-way through the screen reader's
 * page-load announcement and cutting it off for no gain.
 *
 * `tabIndex={-1}` makes the heading focusable without adding it to the tab
 * order, and the heading text is the query itself, so the first thing announced
 * is what was searched.
 */
export const SEARCH_SUBMIT_FLAG = "drishtiprep:search-submitted";

export function ResultsFocus({ query }: { query: string }) {
  const lastQuery = useRef<string | null>(null);

  useEffect(() => {
    if (!query || lastQuery.current === query) return;
    lastQuery.current = query;

    // One-shot: consumed here so a later reload does not re-steal focus.
    if (sessionStorage.getItem(SEARCH_SUBMIT_FLAG) !== "1") return;
    sessionStorage.removeItem(SEARCH_SUBMIT_FLAG);

    const heading = document.getElementById("main-heading");
    if (!heading) return;

    // Focus without scrolling: the heading is already at the top, and an
    // abrupt jump is disorienting for low-vision users tracking the page.
    heading.focus({ preventScroll: true });
  }, [query]);

  return null;
}
