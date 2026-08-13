/**
 * Replies to greetings and thanks.
 *
 * SINGLE SOURCE OF TRUTH — lib/ask/intent.ts reads these rather than keeping
 * its own copy. Answering a greeting with "no content found" is the sort of
 * thing that makes a product feel stupid, so these never reach retrieval.
 */
export const SmallTalkCopy = {
  greeting:
    "नमस्ते! लोक सेवा तयारीका लागि कुनै विषय सोध्नुहोस् — जस्तै “नेपालको भूगोल” वा “मौलिक हक”।",
  thanks: "स्वागत छ। अरू केही सोध्न चाहनुहुन्छ भने तल लेख्नुहोस्।",
} as const;
