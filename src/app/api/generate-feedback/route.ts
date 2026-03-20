import OpenAI, { OpenAIError } from "openai";
import { NextResponse } from "next/server";

const REQUEST_TIMEOUT_MS = 25_000;

const withTimeout = <T>(promise: Promise<T>, ms: number) => {
  return new Promise<T>((resolve, reject) => {
    const timer = setTimeout(() => reject(new Error("TIMEOUT")), ms);
    promise
      .then((res) => {
        clearTimeout(timer);
        resolve(res);
      })
      .catch((err) => {
        clearTimeout(timer);
        reject(err);
      });
  });
};

const getOpenAIClient = () => {
  const apiKey =
    process.env.OPENAI_API_KEY ??
    process.env.DRISTI_API_KEY ??
    process.env.DristiApiKey ??
    process.env.DristiprepOpenAIKey;
  if (!apiKey) return null;
  return new OpenAI({ apiKey });
};

export async function POST(req: Request) {
  try {
    const { content, option_a, option_b, option_c, option_d, correct_option } = await req.json();

    if (!content || !option_a || !option_b || !option_c || !option_d || !correct_option) {
      return NextResponse.json(
        { error: "Missing required fields for generation" },
        { status: 400 }
      );
    }

    const prompt = `
**Role:**
You are an expert Loksewa (Public Service Commission of Nepal) General Knowledge (GK) facilitator and instructor. Your primary goal is to prepare competitive exam aspirants by providing deeply informative, context-rich explanations for given Multiple Choice Questions (MCQs).

**Task:**
You will be provided with a Question, its Options, and the Correct Option. You must provide a comprehensive explanation in formal, grammatically correct Nepali.
IMPORTANT: Return ONLY a valid JSON object (no markdown fences, no extra prose). Schema:
{
  "general_explanation": "string"
}

**Instructions for the "general_explanation" Section:**
- Do not just state the right answer. Provide a rich context just like a real Loksewa facilitator would in a classroom.
- Always include related supplementary facts (e.g., exact dates of the event, themes, key participants, previous iterations, or historical significance) because Loksewa exams frequently test candidates on these peripheral details.
- Keep the tone educational, highly factual, accurate, and precise.

**CONTENT:**
- Question: ${content}
- Option A: ${option_a}
- Option B: ${option_b}
- Option C: ${option_c}
- Option D: ${option_d}
- Correct Option: ${correct_option}

**Reference Example of desired explanation style:**
If Question: International AI Impact Summit २०२६ कहाँ आयोजना भएको थियो?
And Options: A. Tokyo, B. New Delhi, C. London, D. Paris
And Correct Option: B
Your general_explanation string should be: "यो सम्मेलन भारतको नयाँ दिल्लीमा सन् २०२६ फेब्रुअरी १६ देखि २१ सम्म आयोजना गरिएको थियो। यसमा १०० भन्दा बढी देशका प्रतिनिधिहरु सहभागी भएका थिए। यस सम्मेलनको मुख्य उद्देश्य कृत्रिम बुद्धिमत्ता (AI) को सुरक्षित र जिम्मेवार प्रयोगका लागि विश्वव्यापी मापदण्ड तय गर्नु र यसले मानव जीवनमा पार्ने प्रभावको बारेमा छलफल गर्नु थियो।"

Return only the JSON object; it must parse with JSON.parse without trimming.`;

    const openAIClient = getOpenAIClient();
    if (!openAIClient) {
      return NextResponse.json(
        {
          error:
            "OPENAI_API_KEY or DRISTI_API_KEY environment variable is not configured",
        },
        { status: 500 }
      );
    }

    const started = performance.now();
    const completionPromise = openAIClient.chat.completions.create({
      model: "gpt-4o-mini",
      messages: [
        {
          role: "system",
          content:
            "You are an expert educator writing accessible, detailed feedback for multiple choice questions.",
        },
        { role: "user", content: prompt },
      ],
      temperature: 0.2,
    });

    const completion = await withTimeout(completionPromise, REQUEST_TIMEOUT_MS);
    const latencyMs = Math.round(performance.now() - started);
    const responseText = completion.choices?.[0]?.message?.content?.trim() ?? "";
    const cleaned = normalizeJson(responseText);

    let explanation = "";
    try {
      const parsed = JSON.parse(cleaned);
      explanation = (parsed.general_explanation || parsed.explanation || "").trim();
    } catch {
      explanation = cleaned.trim();
    }

    if (!explanation) {
      explanation = "AI response was empty.";
    }

    return NextResponse.json(
      {
        general_explanation: explanation,
        provider: "openai",
        model: completion.model ?? "gpt-4o-mini",
        latency_ms: latencyMs,
      },
      { status: 200 }
    );
  } catch (error: unknown) {
    if (error instanceof Error && error.message === "TIMEOUT") {
      return NextResponse.json(
        { error: "Generation timed out after 25s" },
        { status: 504 }
      );
    }

    const message = error instanceof Error ? error.message : "Something went wrong";
    return NextResponse.json({ error: message }, { status: 500 });
  }
}

/**
 * Attempts to coerce common AI outputs into valid JSON:
 * - strips ```json fences
 * - extracts first {...} block if extra text is present
 */
function normalizeJson(text: string): string {
  if (!text) return text;
  let cleaned = text.trim();

  // Remove fenced code blocks
  if (cleaned.startsWith("```")) {
    cleaned = cleaned.replace(/^```json\s*/i, "").replace(/^```\s*/i, "");
    cleaned = cleaned.replace(/```$/, "").trim();
  }

  // If there is surrounding prose, grab the first JSON object
  const firstBrace = cleaned.indexOf("{");
  const lastBrace = cleaned.lastIndexOf("}");
  if (firstBrace !== -1 && lastBrace !== -1 && lastBrace > firstBrace) {
    cleaned = cleaned.slice(firstBrace, lastBrace + 1);
  }

  return cleaned;
}
