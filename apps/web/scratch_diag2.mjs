import { MsEdgeTTS, OUTPUT_FORMAT } from "msedge-tts";

async function run() {
  const tts = new MsEdgeTTS();
  await tts.setMetadata("ne-NP-HemkalaNeural", OUTPUT_FORMAT.AUDIO_24KHZ_48KBITRATE_MONO_MP3, {
    // wordBoundaryEnabled: true, // commented out
  });

  const text = "काठमाडौं, जेठ १० गते ।";
  const gapMs = 80;
  
  const words = text.split(/\s+/).filter(Boolean);
  const body = words.join(`<break time="${gapMs}ms"/>`);
  const ssml = `<speak version="1.0" xmlns="http://www.w3.org/2001/10/synthesis" xml:lang="ne-NP">
    <voice name="ne-NP-HemkalaNeural">
      ${body}
    </voice>
  </speak>`;

  const stream = tts.rawToStream(ssml);
  let audioBytes = 0;
  
  stream.audioStream.on("data", (chunk) => {
    audioBytes += chunk.length;
  });

  stream.audioStream.on("end", () => {
    console.log("DONE WITHOUT METADATA. Audio bytes:", audioBytes);
  });
}

run().catch(console.error);
