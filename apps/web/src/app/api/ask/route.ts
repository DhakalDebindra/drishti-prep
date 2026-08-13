import { NextResponse } from "next/server";

import { buildLesson } from "@/lib/ask/lesson";
import { signSpeech } from "@/lib/ask/speech-token";
import { createClient } from "@/lib/supabase/server";
import { aiRatelimit, extractClientIp } from "@/lib/rate-limit";

export const runtime = "nodejs";
// Lesson generation measured 12–22s typical against real content, with a
// worst case past 60s before the prompt was trimmed. The headroom is for the
// tail, not the norm — a learner waiting this long is already a bad outcome.
export const maxDuration = 120;

/** Longest question we will accept. Beyond this it is not a question. */
const MAX_QUERY_LENGTH = 300;

/**
 * Ask DrishtiPrep AI.
 *
 * Runs only when a learner deliberately asks — the search page itself never
 * calls this. That is what keeps the AI off the critical path: search works,
 * and costs nothing, whether or not this route is healthy.
 *
 * NOTHING IS STORED. Questions and answers are not written anywhere: the
 * conversation lives in the page for as long as the learner is on it and is
 * gone when they leave. A list of what someone asked is a record of what they
 * do not know, and this platform has decided not to keep one.
 *
 * The reply carries a signed token instead, so Listen can synthesise this exact
 * text later without us having stored it.
 */
export async function POST(req: Request) {
  try {
    const { success } = await aiRatelimit.limit(extractClientIp(req));
    if (!success) {
      return NextResponse.json(
        { error: "Too many requests. Please wait a moment." },
        { status: 429, headers: { "Retry-After": "60" } }
      );
    }

    const supabase = await createClient();
    const {
      data: { user },
    } = await supabase.auth.getUser();
    if (!user) {
      return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    }

    const body = await req.json().catch(() => null);
    const query = typeof body?.query === "string" ? body.query.trim() : "";

    if (!query) {
      return NextResponse.json({ error: "Missing query" }, { status: 400 });
    }
    if (query.length > MAX_QUERY_LENGTH) {
      return NextResponse.json({ error: "Question is too long" }, { status: 400 });
    }

    const lesson = await buildLesson(query);

    return NextResponse.json({
      route: lesson.route,
      message: lesson.message,
      clarifications: lesson.clarifications,
      sections: lesson.sections,
      sources: lesson.sources,
      recommendations: lesson.recommendations,
      lockedNote: lesson.lockedNote,
      plainText: lesson.plainText,
      // Lets the learner play this reply without us retaining it.
      speechToken: signSpeech(lesson.plainText, user.id),
    });
  } catch (error) {
    console.error("[api/ask] unexpected failure:", error);
    return NextResponse.json({ error: "Something went wrong" }, { status: 500 });
  }
}
