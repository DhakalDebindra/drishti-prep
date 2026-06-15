import { ElementType, ReactNode } from "react";
import { accessibleNumerals } from "@/components/ui/accessibleNumerals";

type LangProps = {
  children: ReactNode;
  /** BCP 47 language tag. Defaults to "ne" (Nepali). */
  code?: "ne" | "en" | "hi" | "sa";
  /** Element to render. Defaults to span. Use "div" or "p" for block content. */
  as?: ElementType;
  className?: string;
};

/**
 * Annotates a piece of text with a language code so screen readers
 * switch to the correct pronunciation engine.
 *
 * Usage:
 *   <Lang>नेपाली पाठ</Lang>
 *   <Lang as="p" className="...">{question.text}</Lang>
 *   <Lang code="en">English term inside Nepali</Lang>
 */
export function Lang({
  children,
  code = "ne",
  as: Tag = "span",
  className,
}: LangProps) {
  if (children == null || children === "") return null;
  // Plain-string content is run through accessibleNumerals so Android screen
  // readers announce Devanagari digits (they otherwise skip them). Non-string
  // children (already-rendered nodes) pass through untouched.
  return (
    <Tag lang={code} className={className}>
      {typeof children === "string" ? accessibleNumerals(children) : children}
    </Tag>
  );
}
