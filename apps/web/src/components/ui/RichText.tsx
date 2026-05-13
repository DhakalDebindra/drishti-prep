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
  | { type: "ol"; items: string[] };

const BULLET_RE = /^[-•]\s+(.+)/;
const ORDERED_RE = /^(?:\d+[.)]\s+|[१२३४५६७८९०]+[.)]\s+)(.+)/;
// Matches "नोट: ..." or "Note: ..."
const NOTE_RE = /^(?:नोट|Note):\s*(.+)/i;

function parseBlocks(text: string): Block[] {
  const lines = text.split(/\r?\n/).map((l) => l.trim()).filter(Boolean);
  const blocks: Block[] = [];

  for (const line of lines) {
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
                <li key={j}>{item}</li>
              ))}
            </ul>
          );
        }
        if (block.type === "ol") {
          return (
            <ol key={i} className="list-decimal list-inside space-y-1 my-1 pl-1">
              {block.items.map((item, j) => (
                <li key={j}>{item}</li>
              ))}
            </ol>
          );
        }
        if (block.type === "note") {
          return (
            <p key={i} className="mt-2 text-xs italic opacity-75 border-l-2 border-current pl-2">
              <span className="not-italic font-semibold">नोट:</span> {block.text}
            </p>
          );
        }
        return (
          <p key={i} className={i > 0 ? "mt-2" : undefined}>
            {block.text}
          </p>
        );
      })}
    </div>
  );
}
