import { Fragment } from "react";

type RichTextProps = {
  children: string | null | undefined;
  /** BCP 47 language tag for the content. Defaults to "ne" (Nepali). */
  lang?: string;
  className?: string;
};

type Block =
  | { type: "p"; text: string }
  | { type: "note"; text: string }
  | { type: "ul"; items: string[] }
  | { type: "ol"; items: string[] }
  | { type: "table"; head: string[]; rows: string[][] };

const BULLET_RE = /^[-•]\s+(.+)/;
const ORDERED_RE = /^(?:\d+[.)]\s+|[१२३४५६७८९०]+[.)]\s+)(.+)/;
// Matches "नोट: ..." or "Note: ..."
const NOTE_RE = /^(?:नोट|Note):\s*(.+)/i;
// GFM-style table detection. A table is a row line starting and ending with
// `|`, immediately followed by a separator row whose cells are made of
// dashes (with optional leading/trailing colons for column alignment).
// Without the separator row a stray pipe-line stays a normal paragraph, so
// content that legitimately uses `|` (e.g. "ctrl|shift|delete") is unaffected.
const TABLE_ROW_RE = /^\|.*\|$/;
const TABLE_SEPARATOR_RE = /^\|(?:\s*:?-+:?\s*\|)+$/;

/** Strip the framing pipes and split a row into trimmed cells. */
function splitTableRow(line: string): string[] {
  return line
    .slice(1, -1)
    .split("|")
    .map((cell) => cell.trim());
}

/**
 * Renders inline `**bold**` spans as <strong>. Everything else stays plain text.
 */
function renderInline(text: string) {
  const parts = text.split(/(\*\*[^*]+\*\*)/g);
  return parts.map((part, i) => {
    const match = part.match(/^\*\*([^*]+)\*\*$/);
    return match ? <strong key={i}>{match[1]}</strong> : <Fragment key={i}>{part}</Fragment>;
  });
}

function parseBlocks(text: string): Block[] {
  const lines = text.split(/\r?\n/).map((l) => l.trim()).filter(Boolean);
  const blocks: Block[] = [];

  // Index-based loop so we can lookahead at lines[i+1] for the table-separator
  // row. The rest of the matchers work on a single line and just increment i
  // by one — only the table branch consumes multiple lines per iteration.
  let i = 0;
  while (i < lines.length) {
    const line = lines[i];
    const nextLine = lines[i + 1];

    // GFM table: header row + separator row + 0..N data rows. Both the header
    // row AND the separator row must match for the block to be a table; this
    // keeps a lone "|cmd|out|" line in prose from being misclassified.
    if (
      TABLE_ROW_RE.test(line) &&
      nextLine !== undefined &&
      TABLE_SEPARATOR_RE.test(nextLine)
    ) {
      const head = splitTableRow(line);
      const rows: string[][] = [];
      let j = i + 2;
      while (j < lines.length && TABLE_ROW_RE.test(lines[j])) {
        rows.push(splitTableRow(lines[j]));
        j++;
      }
      blocks.push({ type: "table", head, rows });
      i = j;
      continue;
    }

    const bulletMatch = line.match(BULLET_RE);
    const orderedMatch = line.match(ORDERED_RE);
    const noteMatch = line.match(NOTE_RE);

    if (bulletMatch) {
      const last = blocks[blocks.length - 1];
      if (last?.type === "ul") {
        last.items.push(bulletMatch[1]);
      } else {
        blocks.push({ type: "ul", items: [bulletMatch[1]] });
      }
    } else if (orderedMatch) {
      const last = blocks[blocks.length - 1];
      if (last?.type === "ol") {
        last.items.push(orderedMatch[1]);
      } else {
        blocks.push({ type: "ol", items: [orderedMatch[1]] });
      }
    } else if (noteMatch) {
      blocks.push({ type: "note", text: noteMatch[1] });
    } else {
      blocks.push({ type: "p", text: line });
    }
    i++;
  }

  return blocks;
}

/**
 * Renders Nepali (or other) text that may contain bullet lists (`- item`)
 * or numbered lists (`1. item`) as proper semantic HTML elements so screen
 * readers announce them correctly instead of reading everything as one paragraph.
 *
 * Plain lines become <p>. Consecutive `- ` lines become <ul><li>. Consecutive
 * `1. ` lines become <ol><li>. Devanagari numerals (१, २ …) are also recognised.
 */
export function RichText({ children, lang = "ne", className }: RichTextProps) {
  if (!children) return null;

  const blocks = parseBlocks(children);

  if (blocks.length === 0) return null;

  return (
    <div lang={lang} className={className}>
      {blocks.map((block, i) => {
        if (block.type === "ul") {
          return (
            <ul key={i} className="list-disc list-inside space-y-1 my-1 pl-1">
              {block.items.map((item, j) => (
                <li key={j}>{renderInline(item)}</li>
              ))}
            </ul>
          );
        }
        if (block.type === "ol") {
          return (
            <ol key={i} className="list-decimal list-inside space-y-1 my-1 pl-1">
              {block.items.map((item, j) => (
                <li key={j}>{renderInline(item)}</li>
              ))}
            </ol>
          );
        }
        if (block.type === "note") {
          return (
            <p key={i} className="mt-2 text-xs italic opacity-75 border-l-2 border-current pl-2">
              <span className="not-italic font-semibold">नोट:</span> {renderInline(block.text)}
            </p>
          );
        }
        if (block.type === "table") {
          // Semantic <table> with <th scope="col"> so assistive tech announces
          // column relationships. Outer scroll wrapper prevents wide tables
          // (medal tallies with many columns) from breaking mobile layouts.
          return (
            <div key={i} className="my-2 overflow-x-auto">
              <table className="w-full text-sm border-collapse border border-current/30">
                <thead>
                  <tr>
                    {block.head.map((cell, ci) => (
                      <th
                        key={ci}
                        scope="col"
                        className="border border-current/30 px-2 py-1 text-left font-semibold bg-current/5"
                      >
                        {renderInline(cell)}
                      </th>
                    ))}
                  </tr>
                </thead>
                <tbody>
                  {block.rows.map((row, ri) => (
                    <tr key={ri}>
                      {row.map((cell, ci) => (
                        <td
                          key={ci}
                          className="border border-current/30 px-2 py-1 align-top"
                        >
                          {renderInline(cell)}
                        </td>
                      ))}
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          );
        }
        return (
          <p key={i} className={i > 0 ? "mt-2" : undefined}>
            {renderInline(block.text)}
          </p>
        );
      })}
    </div>
  );
}
