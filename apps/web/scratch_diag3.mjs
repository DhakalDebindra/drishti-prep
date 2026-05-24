import { MsEdgeTTS } from "msedge-tts";

async function run() {
  const tts = new MsEdgeTTS();
  tts._voice = {
    Name: "Microsoft Server Speech Text to Speech Voice (ne-NP, HemkalaNeural)",
    ShortName: "ne-NP-HemkalaNeural",
    Gender: "Female",
    Locale: "ne-NP"
  };
  const ssml = tts._SSMLTemplate("hello world");
  console.log("INTERNAL SSML:", ssml);
}

run().catch(console.error);
