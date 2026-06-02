import { ReactNode } from "react";
import { Lang } from "@/components/ui/Lang";

type QuestionContentProps = {
  content: string;
  className?: string;
  /**
   * Hidden from screen reader when tutor voice is reading aloud, to avoid
   * simultaneous SR + TTS narration. Matches the pattern used in
   * PracticeSetClient.
   */
  ariaHidden?: boolean;
  /**
   * Optional element id for focus management (e.g., questionTitleId).
   */
  id?: string;
  tabIndex?: number;
  /**
   * Header to render above the content (e.g., "Question 5"). Passed through
   * verbatim so the wrapper layout stays identical.
   */
  header?: ReactNode;
};

/**
 * Renders question content with accessible formatting for three shapes:
 *
 * 1. **Match-pair** — e.g. `नदी: (a) X, (b) Y, (c) Z, (d) W\nउद्गमस्थल: 1. P,
 *    2. Q, 3. R, 4. S` → rendered as a two-column `<table>` with column
 *    headers so screen-reader users can navigate each column independently.
 * 2. **Numbered / lettered list** — stem followed by lines like `1. …`,
 *    `क. …`, `i. …` → rendered as `<ol>` with custom markers preserved.
 * 3. **Plain text** — anything else, including stems with embedded `\n`
 *    line breaks → rendered with `whitespace-pre-line` so the line breaks
 *    show, no list semantics imposed.
 *
 * Detection is purely content-shape based; no database changes required.
 * If a future question doesn't fit one of these shapes, it falls through
 * to plain rendering — never breaks.
 */
export function QuestionContent({
  content,
  className,
  ariaHidden,
  id,
  tabIndex,
  header,
}: QuestionContentProps) {
  const parsed = parseQuestionContent(content);

  const ariaProps = {
    ...(ariaHidden ? { "aria-hidden": true as const } : {}),
    ...(id ? { id } : {}),
    ...(tabIndex !== undefined ? { tabIndex } : {}),
  };

  if (parsed.kind === "match-pair") {
    return (
      <div className={className} {...ariaProps}>
        {header}
        {parsed.stem ? (
          <div className="whitespace-pre-line">
            <Lang>{parsed.stem}</Lang>
          </div>
        ) : null}
        <table className="mt-3 w-full max-w-2xl border-separate border-spacing-x-4 border-spacing-y-1 text-base">
          <caption className="sr-only">
            <Lang>मिलान तालिका</Lang>
          </caption>
          <thead>
            <tr>
              <th scope="col" className="text-left font-semibold text-slate-700 pb-1">
                <Lang>{parsed.leftLabel}</Lang>
              </th>
              <th scope="col" className="text-left font-semibold text-slate-700 pb-1">
                <Lang>{parsed.rightLabel}</Lang>
              </th>
            </tr>
          </thead>
          <tbody>
            {Array.from(
              { length: Math.max(parsed.leftItems.length, parsed.rightItems.length) },
              (_, i) => (
                <tr key={i}>
                  <td className="align-top py-0.5">
                    <Lang>{parsed.leftItems[i] ?? ""}</Lang>
                  </td>
                  <td className="align-top py-0.5">
                    <Lang>{parsed.rightItems[i] ?? ""}</Lang>
                  </td>
                </tr>
              )
            )}
          </tbody>
        </table>
      </div>
    );
  }

  if (parsed.kind === "list") {
    return (
      <div className={className} {...ariaProps}>
        {header}
        {parsed.stem ? (
          <div className="whitespace-pre-line">
            <Lang>{parsed.stem}</Lang>
          </div>
        ) : null}
        <ol className="mt-3 space-y-1 list-none ml-1">
          {parsed.items.map((item, i) => (
            <li key={i} className="flex gap-2">
              <span className="font-medium text-slate-700 shrink-0">
                <Lang>{`${item.marker}.`}</Lang>
              </span>
              <span>
                <Lang>{item.text}</Lang>
              </span>
            </li>
          ))}
        </ol>
      </div>
    );
  }

  return (
    <div className={`${className ?? ""} whitespace-pre-line`} {...ariaProps}>
      {header}
      <Lang>{content}</Lang>
    </div>
  );
}

// ───────────────────────────────────────────────────────────────────────
// Parser
// ───────────────────────────────────────────────────────────────────────

type ParsedContent =
  | { kind: "plain" }
  | {
      kind: "match-pair";
      stem: string;
      leftLabel: string;
      leftItems: string[];
      rightLabel: string;
      rightItems: string[];
    }
  | {
      kind: "list";
      stem: string;
      items: { marker: string; text: string }[];
    };

/**
 * List-item marker prefixes. Order matters — multi-char roman numerals first
 * so `iii.` doesn't match as `i.` followed by `ii.`.
 */
const LIST_MARKER_RE =
  /^\s*(viii|vii|vi|iv|ix|iii|ii|i|v|x|[1-9][0-9]?|[a-d]|[क-घ]|[१-९][०-९]?)[\.\)]\s+/;

export function parseQuestionContent(content: string): ParsedContent {
  // Normalize: split on real newlines, drop empties.
  const rawLines = content.split(/\r?\n/);
  const lines = rawLines.map((l) => l.trimEnd()).filter((l) => l.trim().length > 0);

  if (lines.length < 2) return { kind: "plain" };

  // Try match-pair: stem (≥0 lines) + 2 parallel labeled lists.
  const matchPair = tryParseMatchPair(lines);
  if (matchPair) return matchPair;

  // Try numbered / lettered list: stem (≥1 lines) + ≥2 marker lines.
  const list = tryParseList(lines);
  if (list) return list;

  return { kind: "plain" };
}

function tryParseMatchPair(lines: string[]): ParsedContent | null {
  // The two parallel labeled lists are the LAST two non-empty lines.
  if (lines.length < 2) return null;
  const left = parseLabeledList(lines[lines.length - 2]);
  const right = parseLabeledList(lines[lines.length - 1]);
  if (!left || !right) return null;
  if (left.items.length < 2 || right.items.length < 2) return null;
  if (left.items.length !== right.items.length) return null;

  const stem = lines.slice(0, lines.length - 2).join("\n").trim();
  return {
    kind: "match-pair",
    stem,
    leftLabel: left.label,
    leftItems: left.items,
    rightLabel: right.label,
    rightItems: right.items,
  };
}

/**
 * Parse a line like:
 *   "नदी: (a) दरौंदी, (b) बुढी गण्डकी, (c) मर्स्याङ्दी, (d) बुढी गंगा"
 *   "उद्गमस्थल: 1. दामोदर हिमाल, 2. जगदुल्ला ताल, 3. बुद्ध हिमाल, 4. गणेश हिमाल"
 *   "आविष्कारक: क. मार्टिन कुपर, ख. जोन वियर्ड, ग. जोहानेस गुटेनबर्ग, घ. अल्फ्रेड नोबेल"
 *
 * Returns { label, items[] } where each item is `"<marker>. <text>"` so the
 * marker renders verbatim alongside the value in the table.
 *
 * Implementation note: splits on commas first, then validates each chunk
 * against the marker format. Avoids `\b` (JS word boundary), which doesn't
 * fire before Devanagari letters in non-Unicode regex mode and would silently
 * drop the क/ख/ग/घ side of a match-pair question.
 */
function parseLabeledList(line: string): { label: string; items: string[] } | null {
  const colonIdx = line.indexOf(":");
  if (colonIdx === -1) return null;

  const label = line.slice(0, colonIdx).trim();
  if (!label) return null;
  const rest = line.slice(colonIdx + 1).trim();
  if (!rest) return null;

  // Split only on commas that PRECEDE a marker (so "नेपालको संविधान, २०१९"
  // stays as one chunk — values are allowed to contain commas internally).
  const chunks = rest
    .split(/,\s+(?=\([a-d]\)|\([1-4]\)|\([क-घ]\)|[1-9]\.\s|[a-d]\.\s|[क-घ]\.\s)/)
    .map((c) => c.trim())
    .filter(Boolean);
  if (chunks.length < 2) return null;

  // Try paren-letter format: "(a) X" / "(1) X" / "(क) X"
  const parenItems: string[] = [];
  for (const c of chunks) {
    const m = c.match(/^\(([a-d]|[क-घ]|[1-4])\)\s*(.+)$/);
    if (!m) {
      parenItems.length = 0;
      break;
    }
    parenItems.push(`${m[1]}. ${m[2].trim()}`);
  }
  if (parenItems.length === chunks.length) return { label, items: parenItems };

  // Try dot-marker format: "1. X" / "a. X" / "क. X"
  const dotItems: string[] = [];
  for (const c of chunks) {
    const m = c.match(/^([1-9]|[a-d]|[क-घ])\.\s+(.+)$/);
    if (!m) {
      dotItems.length = 0;
      break;
    }
    dotItems.push(`${m[1]}. ${m[2].trim()}`);
  }
  if (dotItems.length === chunks.length) return { label, items: dotItems };

  return null;
}

function tryParseList(lines: string[]): ParsedContent | null {
  // First line(s) without a marker = stem; remaining lines must all start
  // with a marker, and there must be ≥2 of them.
  const firstMarkedIdx = lines.findIndex((l) => LIST_MARKER_RE.test(l));
  if (firstMarkedIdx <= 0) return null; // need at least one stem line above the list

  const stem = lines.slice(0, firstMarkedIdx).join("\n").trim();
  const tail = lines.slice(firstMarkedIdx);
  if (tail.length < 2) return null;
  if (!tail.every((l) => LIST_MARKER_RE.test(l))) return null;

  const items = tail.map((line) => {
    const m = line.match(LIST_MARKER_RE)!;
    return { marker: m[1], text: line.slice(m[0].length).trim() };
  });

  return { kind: "list", stem, items };
}
