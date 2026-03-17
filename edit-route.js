const fs = require( fs);
const path = src/app/api/question-sets/route.ts;
let text = fs.readFileSync(path, utf8);
const before =     if (questionInsertError) {
      console.error(Failed to insert questions, questionInsertError);
      await supabase.from(question_sets).delete().eq(id, insertedSet.id);
      return errorResponse(Failed to save questions for the set);
    };
const after =     if (questionInsertError) {
      console.error(Failed to insert questions, questionInsertError);
      await supabase.from(question_sets).delete().eq(id, insertedSet.id);
      return errorResponse(
        questionInsertError.message ?? Failed to save questions for the set,
        400
      );
    };
if (!text.includes(before)) {
  throw new Error(needle not found);
}
text = text.replace(before, after);
fs.writeFileSync(path, text, utf8);
