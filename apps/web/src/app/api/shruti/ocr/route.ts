import { NextResponse } from "next/server";
import { GoogleGenerativeAI } from "@google/generative-ai";
import { createClient } from "@/lib/supabase/server";
import { logger } from "@/lib/logger";
import { aiRatelimit, extractClientIp } from "@/lib/rate-limit";
import { resolveGeminiApiKey } from "@/lib/env-keys";

// Image OCR via Gemini Vision. Used by Shruti when the user uploads
// photos of handwritten notes or printed pages. Gemini handles Devanagari
// significantly better than Tesseract.js, and we already have the key.

export const runtime = "nodejs";

const geminiApiKey = resolveGeminiApiKey();

const OCR_PROMPT = [
  "You are an OCR assistant for a visually impaired learner. Extract ALL",
  "readable text from this image, preserving:",
  "- paragraph breaks (use double newline)",
  "- punctuation (commas, full stops, question marks, danda)",
  "- both English and Devanagari (Nepali) scripts",
  "",
  "Rules:",
  "- Output ONLY the extracted text, no commentary, no explanation.",
  "- If the image contains no readable text, output an empty string.",
  "- Do not translate. Do not summarize. Do not add headings.",
  "- Fix obvious OCR slips silently (e.g., 'rn' that should be 'm').",
  "- Preserve original capitalization and spelling.",
].join("\n");

export async function POST(req: Request) {
  if (!geminiApiKey) {
    return NextResponse.json({ error: "no_api_key" }, { status: 500 });
  }

  const { success } = await aiRatelimit.limit(extractClientIp(req));
  if (!success) {
    return NextResponse.json({ error: "rate_limited" }, { status: 429 });
  }

  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    return NextResponse.json({ error: "unauthenticated" }, { status: 401 });
  }

  const form = await req.formData();
  const image = form.get("image");
  if (!(image instanceof Blob)) {
    return NextResponse.json({ error: "missing_image" }, { status: 400 });
  }
  // Cap at 8 MB — Gemini accepts up to ~20 MB but anything larger is
  // almost certainly a multi-page scan that should be a PDF.
  if (image.size > 8_000_000) {
    return NextResponse.json({ error: "image_too_large" }, { status: 400 });
  }

  const arrayBuffer = await image.arrayBuffer();
  const base64 = Buffer.from(arrayBuffer).toString("base64");
  const mimeType = image.type || "image/jpeg";

  try {
    const genAI = new GoogleGenerativeAI(geminiApiKey);
    const model = genAI.getGenerativeModel({
      model: "gemini-2.5-flash",
      generationConfig: { temperature: 0, maxOutputTokens: 4096 },
    });
    const result = await model.generateContent([
      { text: OCR_PROMPT },
      { inlineData: { data: base64, mimeType } },
    ]);
    const text = result.response.text().trim();
    logger.info(`[Shruti] ocr: bytes=${image.size} chars=${text.length}`);
    return NextResponse.json({ text });
  } catch (err) {
    const msg = err instanceof Error ? err.message : "ocr_failed";
    logger.error("[Shruti] ocr failed:", msg);
    return NextResponse.json({ error: "ocr_failed", detail: msg }, { status: 502 });
  }
}
