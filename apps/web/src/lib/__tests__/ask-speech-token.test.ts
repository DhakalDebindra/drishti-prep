// Node-native test runner (node:test) — no extra dependency.
// Run: node --import tsx --test apps/web/src/lib/__tests__/ask-speech-token.test.ts

import { strict as assert } from "node:assert";
import { describe, it } from "node:test";

import { signWith, verifyWith } from "../ask/speech-signature";

// The pure signing module, not speech-token.ts — that one is `server-only` and
// throws under a plain Node runner. The secret is a parameter here, which is
// what makes the security-relevant logic testable at all.
const SECRET = "test-secret-for-signing";
const signSpeech = (text: string, user: string) => signWith(SECRET, text, user);
const verifySpeech = (text: string, user: string, token: string) =>
  verifyWith(SECRET, text, user, token);

const TEXT = "रामसार सूची अन्तर्राष्ट्रिय महत्त्वका सिमसार क्षेत्रहरूको सूची हो।";
const USER = "11111111-1111-4111-8111-111111111111";

describe("speech signature", () => {
  it("accepts text it just signed for the same learner", () => {
    assert.equal(verifySpeech(TEXT, USER, signSpeech(TEXT, USER)), true);
  });

  it("rejects text that was altered after signing", () => {
    // The whole point: the endpoint synthesises exactly what was signed, so a
    // client cannot append its own text to a legitimate reply.
    const token = signSpeech(TEXT, USER);
    assert.equal(verifySpeech(`${TEXT} थपिएको वाक्य।`, USER, token), false);
  });

  it("rejects a token issued for a different learner", () => {
    const token = signSpeech(TEXT, USER);
    const other = "22222222-2222-4222-8222-222222222222";
    assert.equal(verifySpeech(TEXT, other, token), false);
  });

  it("rejects an empty or malformed token", () => {
    assert.equal(verifySpeech(TEXT, USER, ""), false);
    assert.equal(verifySpeech(TEXT, USER, "not-a-token"), false);
    assert.equal(verifySpeech(TEXT, USER, "abc.def"), false);
  });

  it("rejects a token older than an hour", () => {
    const token = signSpeech(TEXT, USER);
    const [, digest] = token.split(".");
    const stale = `${Date.now() - 61 * 60 * 1000}.${digest}`;
    assert.equal(verifySpeech(TEXT, USER, stale), false);
  });

  it("produces no token for empty text, so nothing is playable", () => {
    assert.equal(signSpeech("", USER), "");
    assert.equal(verifySpeech("", USER, "anything"), false);
  });

  it("produces no token when the server has no secret configured", () => {
    // This was the production failure: a blank secret signed nothing, and the
    // player waited forever on a token that would never verify.
    assert.equal(signWith("", TEXT, USER), "");
    assert.equal(verifyWith("", TEXT, USER, "1.abc"), false);
  });

  it("rejects a token signed with a different secret", () => {
    const token = signWith("other-secret", TEXT, USER);
    assert.equal(verifyWith(SECRET, TEXT, USER, token), false);
  });
});
