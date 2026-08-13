-- Stop storing chat history.
--
-- ask_threads / ask_messages / ask_recommendations were added in
-- 20260811020000 to power a history view. That view will not be built: /ask is
-- fast mode — a learner asks, reads, and goes back to studying, and a
-- conversation list is furniture for something used in 30-second bursts.
--
-- With nothing shown back, the tables became data collected and never used,
-- and what they hold is a per-learner record of what that learner does not
-- know. Keeping it would have bought a content roadmap — which topics learners
-- ask about that we cannot answer — but the decision was that it is not ours
-- to keep. So the writes and the tables go.
--
-- Listen still works without them: the reply is signed
-- (apps/web/src/lib/ask/speech-token.ts) and the signature is verified when
-- synthesising, which preserves the guarantee that only text we generated can
-- be read aloud, without retaining the text itself.

drop table if exists public.ask_recommendations;
drop table if exists public.ask_messages;
drop table if exists public.ask_threads;
