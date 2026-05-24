import { MsEdgeTTS, OUTPUT_FORMAT } from "msedge-tts";

async function main() {
  const tts = new MsEdgeTTS();
  await tts.setMetadata("ne-NP-HemkalaNeural", OUTPUT_FORMAT.AUDIO_24KHZ_48KBITRATE_MONO_MP3, {
    wordBoundaryEnabled: true,
  });

  const ssml = `<speak version="1.0" xmlns="http://www.w3.org/2001/10/synthesis" xml:lang="ne-NP"><voice name="ne-NP-HemkalaNeural">नमस्ते संसार</voice></speak>`;
  const result = tts.rawToStream(ssml);

  result.metadataStream?.on("data", (chunk) => {
    console.log("METADATA:", chunk.toString());
  });

  result.audioStream.on("data", () => {}); // Consume audio to let it finish
  result.audioStream.on("end", () => {
    console.log("DONE");
  });
}

main().catch(console.error);
