# DrishtiPrep

An accessibility-first exam preparation platform for blind and low-vision aspirants in Nepal. Practice MCQs, receive AI-powered feedback, and prepare for civil service exams with a screen-reader-first experience.

**Live:** [drishtiprep.vercel.app](https://drishtiprep.vercel.app)

---

## What is DrishtiPrep?

DrishtiPrep is built specifically for blind and low-vision users preparing for Nepal's Loksewa (civil service) exams. Every interaction is designed to work with screen readers (NVDA, JAWS, VoiceOver) as the primary interface, not an afterthought.

Key capabilities:
- Interactive MCQ practice with keyboard-only navigation
- AI-powered answer feedback via Gemini 2.5 Flash
- Guest demo mode — try without creating an account
- High-contrast mode with OKLCH color science
- Full Nepali language annotation (`lang="ne"`) for correct screen reader pronunciation
- Admin content studio with CSV bulk import

---

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | Next.js 16 (App Router) |
| Monorepo | Turborepo |
| Database | Supabase (PostgreSQL + RLS) |
| Auth | Supabase Auth |
| AI | Google Gemini 2.5 Flash |
| Styling | Tailwind CSS + OKLCH |
| Deployment | Vercel |
| Testing | Playwright (E2E) |
| CI | GitHub Actions |

---

## Monorepo Structure

```text
drishti-prep/
├── apps/
│   └── web/                  # Main Next.js application
│       ├── src/app/          # App Router pages and layouts
│       ├── src/components/   # Shared UI components
│       ├── src/features/     # Feature-scoped modules (practice, etc.)
│       └── src/hooks/        # Custom React hooks
├── packages/
│   ├── supabase/             # Typed Supabase clients (browser, server, static)
│   ├── types/                # Shared TypeScript types
│   ├── utils/                # Shared utility functions
│   └── validation/           # Shared Zod schemas
└── .github/workflows/ci.yml  # CI pipeline
```

---

## Getting Started

### Prerequisites

- Node.js 20+
- pnpm 10.33.2+ (`npm install -g pnpm`)
- A Supabase project ([supabase.com](https://supabase.com))
- A Google Gemini API key ([aistudio.google.com](https://aistudio.google.com))

### 1. Clone and install

```bash
git clone https://github.com/DhakalDebindra/drishti-prep.git
cd drishti-prep
pnpm install
```

### 2. Set up environment variables

```bash
cp .env.example apps/web/.env.local
```

Open `apps/web/.env.local` and fill in your values. See [Environment Variables](#environment-variables) below.

### 3. Set up the database

Run migrations against your Supabase project:

```bash
# Install Supabase CLI if needed
npm install -g supabase

# Link to your project
supabase link --project-ref YOUR_PROJECT_REF

# Run all migrations
supabase db push
```

Migrations live in `supabase/migrations/`.

### 4. Run the development server

```bash
pnpm dev
```

Open [http://localhost:3000](http://localhost:3000).

---

## Environment Variables

Copy `.env.example` to `apps/web/.env.local` and fill in:

| Variable | Required | Description |
|---|---|---|
| `NEXT_PUBLIC_SUPABASE_URL` | ✅ | Your Supabase project URL |
| `NEXT_PUBLIC_SUPABASE_ANON_KEY` | ✅ | Supabase anon/public key |
| `GEMINI_API_KEY` | ✅ | Google Gemini API key for AI feedback |

---

## Granting Admin Access

Admin users can manage curriculum, questions, and content via `/admin`.

To grant admin access, update the Supabase `profiles` table directly:

```sql
UPDATE profiles SET is_admin = true WHERE email = 'user@example.com';
```

---

## CI Pipeline

Every pull request runs:

1. **Typecheck** — `tsc --noEmit` across all packages
2. **Lint** — ESLint across all packages  
3. **E2E Tests** — Playwright against a built app (only if 1 & 2 pass)
4. **Lighthouse CI** — Performance and accessibility audits with a 95% accessibility budget (only if 1 & 2 pass)

All four checks must pass before a PR can merge into `main`.

---

## Accessibility

DrishtiPrep is built accessibility-first. Key patterns in use:

- `lang="ne"` annotations on all Nepali content for correct screen reader pronunciation
- Radiogroup keyboard navigation with roving tabindex
- `aria-live` regions for state change announcements
- Proper landmark structure (`<nav aria-label="...">`, `<main>`, breadcrumb as `<nav>` + `<ol>`)
- High-contrast mode toggled via `.hc` class with OKLCH color overrides
- `prefers-reduced-motion` honored via CSS global override
- `prefers-contrast: more` auto-detected and applied on first visit
- Skip-to-content link as first focusable element
- All interactive elements have visible focus rings

When contributing, run Lighthouse CI locally and verify with a screen reader before opening a PR.

---

## Content Management

Admins can manage content at `/admin`:

- **Curriculum:** Modules → Subjects → Topics → Question Sets → Questions
- **Bulk import:** Upload questions via CSV
- **Inline editing:** Edit questions and metadata directly in the table

CSV format for bulk import uses **semicolons (`;`)** as delimiters. The expected columns are:
```csv
Question Content;Option A;Option B;Option C;Option D;Correct Option;Explanation;Exam Year;Paper Reference;Language
```

---

## Contributing

1. Fork the repo and create a branch: `git checkout -b feat/your-feature`
2. Make changes, following the accessibility patterns above
3. Run `pnpm typecheck && pnpm lint` locally before pushing
4. Open a PR — CI runs automatically
5. All four CI checks must be green before merge

---

## License

MIT
