import { MsEdgeTTS, OUTPUT_FORMAT } from "msedge-tts";

async function run() {
  const tts = new MsEdgeTTS();
  const voiceShortName = "ne-NP-HemkalaNeural";
  
  await tts.setMetadata(voiceShortName, OUTPUT_FORMAT.AUDIO_24KHZ_48KBITRATE_MONO_MP3, {
    wordBoundaryEnabled: true,
  });

  const text = "काठमाडौं, जेठ १० गते ।";
  const gapMs = 80;
  const words = text.split(/\s+/).filter(Boolean);
  const body = words.join(`<break time="${gapMs}ms"/>`);
  
  const voices = await tts.getVoices();
  const fullVoice = voices.find(v => v.ShortName === voiceShortName);
  const voiceName = fullVoice ? fullVoice.Name : voiceShortName;

  const ssml = `<speak version="1.0" xmlns="http://www.w3.org/2001/10/synthesis" xmlns:mstts="https://www.w3.org/2001/mstts" xml:lang="ne-NP">
    <voice name="${voiceName}">
        <prosody pitch="+0Hz" rate="1" volume="100">
            ${body}
        </prosody> 
    </voice>
  </speak>`;

  console.log("SSML:", ssml);

  const stream = tts.rawToStream(ssml);
  let audioBytes = 0;
  
  if (stream.metadataStream) {
    stream.metadataStream.on("data", (data) => {
      console.log("META DATA:", data.toString());
    });
  }

  stream.audioStream.on("data", (chunk) => {
    audioBytes += chunk.length;
  });

  stream.audioStream.on("end", () => {
    console.log("DONE WITH BREAK TAGS. Audio bytes:", audioBytes);
  });
  
  stream.audioStream.on("error", (err) => {
    console.error("ERROR:", err);
  });
}

run().catch(console.error);
