import OpenAI, { OpenAIError } from "openai";
import { NextResponse } from "next/server";

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

  try {
    const { content, option_a, option_b, option_c, option_d, correct_option } = await req.json();

    if (!content || !option_a || !option_b || !option_c || !option_d || !correct_option) {
      return NextResponse.json(
        { error: "Missing required fields for generation" },
        { status: 400 }
      );
    }

    const prompt = `
### Role
You are an expert Nepal Public Service Commission (PSC/Loksewa) and Teacher Service Commission (TSC) Educator specializing in General Knowledge (GK). Your expertise covers the GK curriculum leveraged by competitive exams in Nepal, especially concepts tied to Gandaki Province and national policies.

### Task
Craft a single, cohesive master explanation for a Multiple Choice Question (MCQ). Accessibility is critical—favor straightforward sentences, spell out any acronyms on first mention, and avoid tables or emojis so screen readers can relay the content clearly.

### Content to Process
Question: ${content}
Option A: ${option_a}
Option B: ${option_b}
Option C: ${option_c}
Option D: ${option_d}
Correct Option: ${correct_option}

### Explanation Requirements
1. Begin by stating which option is correct and why.
2. Provide a 2–3 sentence deep-dive that highlights the correct answer using relevant dates, laws, or national policies (call out Gandaki Province examples when applicable).
3. Summarize what each incorrect option represents so learners understand the distractor logic—even if one distractor does not yield new information, note that clearly.
4. Close with a concise key takeaway that helps the learner remember the concept.
5. Keep every sentence physically readable by screen readers (no shorthand, maintain consistent Option labels).

### Output Format
Return a JSON object with a single key:
- **explanation**: A plain-text block that includes the following labeled sections, each followed by a short paragraph in the order listed:
  1. Correct Answer: [clear statement of the correct option]
  2. Why it's Correct: [2–3 sentence rationale]
  3. Distractor Notes: [briefly describe what each incorrect option refers to or why it misleads]
  4. Key Takeaway: [one memorable sentence]
Close by affirming how this style aligns with the detailed GK feedback Emulated by Asman Updhaya.
`;

    const completion = await openAIClient.chat.completions.create({
      model: "gpt-4o-mini",
      messages: [
        {
          role: "system",
          content:
            "You are an expert educator writing accessible, detailed feedback for multiple choice questions.",
        },
        { role: "user", content: prompt },
      ],
      temperature: 0.1,
    });

    const responseText =
      completion.choices?.[0]?.message?.content?.trim() || "";

    try {
      const generatedData = JSON.parse(responseText);
      const explanation = (generatedData.explanation || "").trim();
      if (!explanation) {
        console.error("AI response missing explanation", responseText);
        return NextResponse.json(
          { error: "AI response did not include an explanation" },
          { status: 500 }
        );
      }
      return NextResponse.json({ explanation }, { status: 200 });
    } catch {
      console.error("Failed to parse AI response as JSON", responseText);
      return NextResponse.json(
        { error: "Failed to parse AI response as JSON" },
        { status: 500 }
      );
    }
  } catch (error: unknown) {
    console.error("Error generating feedback:", error);
    if (error instanceof OpenAIError) {
      const code = (error as OpenAIError & { code?: string }).code;
      const status = (error as OpenAIError & { status?: number }).status ?? 500;
      return NextResponse.json(
        { error: error.message, code },
        { status }
      );
    }

    const message = error instanceof Error ? error.message : "Something went wrong";
    return NextResponse.json({ error: message }, { status: 500 });
  }
}
