# Interface copy

Every editable string in Search and Ask. Nothing here is logic — an editor
should be able to change wording without reading React.

## Where do I find...?

| I want to change... | File |
|---|---|
| Search box label, placeholder, button | `user/search-box.ts` |
| `/search` page title, empty state | `user/search-page.ts` |
| Result headings, "no match", locked-course block, question card labels | `user/search-results.ts` |
| Counts, progress, "Continue", exam weighting line | `user/search-header.ts` |
| Previous / Next / "Page 1 of 3" | `user/search-pagination.ts` |
| The "Chat with DrishtiPrep AI" block under the results | `user/chat-entry.ts` |
| `/ask` page heading and back link | `user/ask-page.ts` |
| Chat input, announcements, source/practice labels, opening suggestions | `user/ask-chat.ts` |
| Lesson section headings; messages for replies with no lesson | `user/ask-lesson.ts` |
| Replies to greetings and thanks | `user/ask-small-talk.ts` |
| Fallback chat suggestions | `user/ask-suggestions.ts` |
| Listen / Stop button | `user/audio.ts` |
| CSV import error messages | `admin/import.ts` |

**Prompts are not copy.** Instructions sent to the AI live in
`src/config/prompts/ask.ts`.

## Conventions

- Interface chrome is English; learner content and AI replies are Nepali.
- "DrishtiPrep" stays in Latin script inside Nepali sentences.
- A `Ne` suffix on a key marks Nepali text, so a mixed object stays readable.
- Functions only where a value must be interpolated. Everything else is a plain
  string, so it can be edited without touching syntax.
- `user/ask-lesson.ts` and `user/ask-small-talk.ts` are the single source of
  truth for section headings and small-talk replies; `lib/ask/` reads them from
  here rather than keeping copies.
