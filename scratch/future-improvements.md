## Server Actions for Auth

**When to implement:** Next time auth flow is touched (new auth method, 
CAPTCHA, "remember me", provider migration).

**Why:** Moves credential check to server, enabling rate limiting at 
the actual brute-force target rather than just session finalization.
Also enables progressive enhancement (works without JS) which matters
for screen reader users on slow connections in Nepal.

**What to build:**
- `apps/web/src/actions/auth.ts` — loginAction, signupAction, 
  forgotPasswordAction, all with authRatelimit
- Update LoginForm.tsx, SignupForm.tsx to use useActionState + form action
- Move redirect logic server-side

**Reference:** Claude conversation — "Server Actions for Auth" explanation
**Effort:** ~2–3 hours
**Risk:** Medium — touches core auth flow, needs careful testing
We will touch it when it really needed not now.
