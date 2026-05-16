// v4 — Updated May 2026. Mode A / Mode B format aligned with DrishtiPrep CSV skill output.
// Mode A: distractor-led (distinct real-world entities). Mode B: context-narrative (value variants).
// Both modes: bold the single key fact with **…**, and may close with a "नोट:" critical-context line.
// Update both examples when format changes to keep few-shot guidance aligned.

export const GK_EXPLANATION_EXAMPLE_MODE_A = `
{
  "general_explanation": "सही उत्तर (B) **कस्मोलोजी** हो।\nकस्मोलोजी भौतिकशास्त्रको एक शाखा हो जसले ब्रह्माण्डको उत्पत्ति, विकास र संरचनाको अध्ययन गर्दछ।\n- विकल्प (A): खगोलशास्त्र (Astronomy) ताराहरू, ग्रहहरू र आकाशगंगाहरूको अध्ययन हो।\n- विकल्प (C): भूगर्भशास्त्र (Geology) पृथ्वीको आन्तरिक संरचना र चट्टानहरूको अध्ययन हो।\n- विकल्प (D): मौसमविज्ञान (Meteorology) वायुमण्डल र मौसम परिवर्तनको अध्ययन हो।\nनोट: कस्मोलोजीले सम्पूर्ण ब्रह्माण्डलाई समग्रमा अध्ययन गर्छ भने खगोलशास्त्र ब्रह्माण्डभित्रका छुट्टाछुट्टै पिण्डहरूमा केन्द्रित हुन्छ — परीक्षामा यी दुई प्रायः साटिन्छन्।"
}
`.trim();

export const GK_EXPLANATION_EXAMPLE_MODE_B = `
{
  "general_explanation": "सन् **१९५३ मे २९** मा एडमन्ड हिलारी र तेन्जिङ नोर्गे शेर्पाले पहिलो पटक सगरमाथाको शिखर आरोहण गरे। यही ऐतिहासिक उपलब्धिको सम्मानमा नेपालले मे २९ लाई सगरमाथा दिवसका रूपमा मनाउन थालेको हो।\nनोट: एडमन्ड हिलारीको सन् २००८ मा निधन भएपछि यो दिवस आधिकारिक रूपमा स्थापना गरियो।"
}
`.trim();

export const GK_EXPLANATION_EXAMPLE = GK_EXPLANATION_EXAMPLE_MODE_A;
