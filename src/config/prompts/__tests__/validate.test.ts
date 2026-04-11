import { parseCoachFeedback, parseGKExplanation } from "../validate";

function assert(condition: boolean, message: string) {
  if (!condition) {
    throw new Error(`Assertion failed: ${message}`);
  }
}

function runTests() {
  console.log("Running Prompts Validation Tests...");

  // --- Coach Feedback Tests ---
  
  // 1. Valid JSON
  const validCoach = '{"strengths": "Great job!", "weakZones": ["Topic A", "Topic B"]}';
  const parsedCoach = parseCoachFeedback(validCoach);
  assert(parsedCoach.strengths === "Great job!", "Should parse strengths");
  assert(parsedCoach.weakZones.length === 2, "Should parse weakZones");

  // 2. Trailing comma in JSON (common Claude error)
  const trailingCommaCoach = '{"strengths": "Good", "weakZones": ["X"],}';
  const parsedTrailing = parseCoachFeedback(trailingCommaCoach);
  assert(parsedTrailing.strengths === "Good", "Should handle trailing commas in objects");
  assert(parsedTrailing.weakZones[0] === "X", "Should handle trailing commas in arrays");

  // 3. Missing fields
  try {
    parseCoachFeedback('{"strengths": "Only strengths"}');
    assert(false, "Should throw on missing weakZones");
  } catch (e: any) {
    assert(e.message.includes("weakZones"), "Should mention missing weakZones");
  }

  // 4. Array slicing
  const longWeakZones = '{"strengths": "Hi", "weakZones": ["1", "2", "3", "4", "5"]}';
  const slicedCoach = parseCoachFeedback(longWeakZones);
  assert(slicedCoach.weakZones.length === 3, "Should slice to max 3 items");

  // --- GK Explanation Tests ---

  // 1. Valid JSON
  const validGK = '{"general_explanation": "Correct answer is A. Fact 1. Fact 2. Fact 3. Trap 1."}';
  const parsedGK = parseGKExplanation(validGK);
  assert(parsedGK.general_explanation.includes("Correct answer"), "Should parse explanation");

  // 2. Fallback key
  const fallbackGK = '{"explanation": "Fallback explanation"}';
  const parsedFallbackGK = parseGKExplanation(fallbackGK);
  assert(parsedFallbackGK.general_explanation === "Fallback explanation", "Should use 'explanation' as fallback key");

  // 3. Markdown fences
  const fencedGK = '```json\n{"general_explanation": "Fenced"}\n```';
  const parsedFencedGK = parseGKExplanation(fencedGK);
  assert(parsedFencedGK.general_explanation === "Fenced", "Should handle markdown fences");

  console.log("✅ All Prompts Validation Tests Passed!");
}

// Run if called directly via ts-node
if (require.main === module) {
  try {
    runTests();
  } catch (error: any) {
    console.error("❌ Tests Failed:", error.message);
    process.exit(1);
  }
}
