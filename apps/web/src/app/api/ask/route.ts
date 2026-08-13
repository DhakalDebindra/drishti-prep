import { NextResponse } from "next/server";

import { buildLesson } from "@/lib/ask/lesson";
import { createClient } from "@/lib/supabase/server";
import { aiRatelimit, extractClientIp } from "@/lib/rate-limit";

export const runtime = "nodejs";
// Lesson generation measured 12–22s typical against real content, with a
// worst case past 60s before the prompt was trimmed. The headroom is for the
// tail, not the norm — a learner waiting this long is already a bad outcome.
export const maxDuration = 120;

/** Longest question we will accept. Beyond this it is not a question. */
const MAX_QUERY_LENGTH = 300;

/** Thread titles are the first question, trimmed to something listable. */
const TITLE_LENGTH = 80;

/**
 * Ask DrishtiPrep AI.
 *
 * Runs only when a learner deliberately asks — the search page itself never
 * calls this. That is what keeps the AI off the critical path: search works,
 * and costs nothing, whether or not this route is healthy.
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
    const threadId = typeof body?.thread_id === "string" ? body.thread_id : null;

    if (!query) {
      return NextResponse.json({ error: "Missing query" }, { status: 400 });
    }
    if (query.length > MAX_QUERY_LENGTH) {
      return NextResponse.json({ error: "Question is too long" }, { status: 400 });
    }
    if (threadId && !/^[0-9a-f-]{36}$/i.test(threadId)) {
      return NextResponse.json({ error: "Invalid thread_id" }, { status: 400 });
    }

    const lesson = await buildLesson(query);

    // Persistence is best-effort: a learner who got a good answer must not see
    // an error because we failed to file it. Failures are logged, not surfaced.
    const persisted = await persist({
      supabase,
      userId: user.id,
      threadId,
      query,
      lesson,
    });

    return NextResponse.json({
      route: lesson.route,
      message: lesson.message,
      clarifications: lesson.clarifications,
      sections: lesson.sections,
      sources: lesson.sources,
      recommendations: lesson.recommendations,
      lockedNote: lesson.lockedNote,
      plainText: lesson.plainText,
      thread_id: persisted.threadId,
      message_id: persisted.messageId,
    });
  } catch (error) {
    console.error("[api/ask] unexpected failure:", error);
    return NextResponse.json({ error: "Something went wrong" }, { status: 500 });
  }
}

type PersistArgs = {
  supabase: any;
  userId: string;
  threadId: string | null;
  query: string;
  lesson: Awaited<ReturnType<typeof buildLesson>>;
};

async function persist({ supabase, userId, threadId, query, lesson }: PersistArgs) {
  try {
    let activeThreadId = threadId;

    if (!activeThreadId) {
      const { data, error } = await supabase
        .from("ask_threads")
        .insert({ user_id: userId, title: query.slice(0, TITLE_LENGTH) })
        .select("id")
        .single();
      if (error) throw error;
      activeThreadId = data.id as string;
    } else {
      await supabase
        .from("ask_threads")
        .update({ last_message_at: new Date().toISOString() })
        .eq("id", activeThreadId);
    }

    await supabase.from("ask_messages").insert({
      thread_id: activeThreadId,
      role: "user",
      content: query,
    });

    // Greeting, clarify and outside carry their text in `message`; a lesson
    // carries it in plainText. Store whichever exists so history is readable.
    const assistantContent = lesson.plainText || lesson.message || "";

    const { data: assistantRow, error: assistantError } = await supabase
      .from("ask_messages")
      .insert({
        thread_id: activeThreadId,
        role: "assistant",
        content: assistantContent,
        sections: lesson.sections,
        sources: lesson.sources,
        route: lesson.route,
      })
      .select("id")
      .single();
    if (assistantError) throw assistantError;

    const messageId = assistantRow.id as string;

    if (lesson.recommendations.length > 0) {
      await supabase.from("ask_recommendations").insert(
        lesson.recommendations.map((rec, index) => ({
          message_id: messageId,
          set_id: rec.set_id,
          rank: index + 1,
          is_locked: rec.locked,
        }))
      );
    }

    return { threadId: activeThreadId, messageId };
  } catch (error) {
    console.error("[api/ask] persistence failed:", error);
    return { threadId, messageId: null as string | null };
  }
}
