"use client";

import { useState } from "react";
import { Lang } from "./Lang";

interface SeeMoreTextProps {
  text: string;
  maxLength?: number;
}

export function SeeMoreText({ text, maxLength = 100 }: SeeMoreTextProps) {
  const [isExpanded, setIsExpanded] = useState(false);

  if (!text) return null;
  
  if (text.length <= maxLength) {
    return <Lang>{text}</Lang>;
  }

  const displayText = isExpanded ? text : text.slice(0, maxLength) + "...";

  return (
    <span>
      <Lang>{displayText}</Lang>
      <button
        onClick={(e) => {
          e.preventDefault();
          setIsExpanded(!isExpanded);
        }}
        className="ml-1 text-primary font-medium text-sm focus:outline-none focus-visible:ring-2 focus-visible:ring-ring rounded"
      >
        {isExpanded ? "See Less" : "See More"}
      </button>
    </span>
  );
}
