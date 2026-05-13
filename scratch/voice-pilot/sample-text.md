# Voice Pilot Sample (Nepali)

One full question from the bank, used to evaluate Gemini TTS voices.
The same text is sent to every voice so they can be compared directly.

## Spoken script

```
प्रश्न दुई।

नेपाल सरकार वैधानिक कानुन २००४ को घोषणा कहिले भएको थियो?

विकल्प क। २००४ माघ १३।
विकल्प ख। २००४ फागुन ७।
विकल्प ग। २००५ वैशाख १।
विकल्प घ। २००४ माघ २६।

व्याख्या। सही उत्तर क हो। ख प्रजातन्त्र घोषणाको वर्ष हो। ग यो संविधान लागू हुने भनिएको तर नभएको मिति हो।
```

## Voice mapping

Option labels are read as Nepali letters क / ख / ग / घ (the convention in
Nepali exam papers), not the English A/B/C/D shown in the UI. We can revisit
this mapping after the pilot — the UI can still display A/B/C/D while the
tutor voice says क/ख/ग/घ.

## Voices being tested

| File | Voice | Characteristic (per Google's voice catalog) |
|---|---|---|
| kore.wav | Kore | Firm, neutral female — Google's default |
| puck.wav | Puck | Upbeat, warm male |
| charon.wav | Charon | Informative, deep male |
| aoede.wav | Aoede | Breezy, clear female |
| leda.wav | Leda | Youthful, friendly female |

Listen on headphones. Look for:
1. Pronunciation accuracy of Nepali words (especially "वैधानिक", "व्याख्या", date formats)
2. Natural pacing between segments (do the `।` and paragraph breaks feel right?)
3. Tone — does it sound like a tutor, or like a robot/announcer?
