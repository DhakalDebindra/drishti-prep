// Auto-generated Preeti to Unicode converter
// Ported from npttf2utf python package for native Next.js use

const characterMap: Record<string, string> = {
  "0": "ण्",
  "1": "ज्ञ",
  "2": "द्द",
  "3": "घ",
  "4": "द्ध",
  "5": "छ",
  "6": "ट",
  "7": "ठ",
  "8": "ड",
  "9": "ढ",
  "~": "ञ्",
  "!": "१",
  "@": "२",
  "#": "३",
  "$": "४",
  "%": "५",
  "^": "६",
  "&": "७",
  "*": "८",
  "(": "९",
  ")": "०",
  "_": ")",
  "+": "ं",
  " ": " ",
  "`": "ञ",
  "-": "(",
  "=": ".",
  "Q": "त्त",
  "W": "ध्",
  "E": "भ्",
  "R": "च्",
  "T": "त्",
  "Y": "थ्",
  "U": "ग्",
  "I": "क्ष्",
  "O": "इ",
  "P": "ए",
  "}": "ै",
  "|": "्र",
  "q": "त्र",
  "w": "ध",
  "e": "भ",
  "r": "च",
  "t": "त",
  "y": "थ",
  "u": "ग",
  "i": "ष्",
  "o": "य",
  "p": "उ",
  "[": "ृ",
  "]": "े",
  "\\": "्",
  "A": "ब्",
  "S": "क्",
  "D": "म्",
  "F": "ँ",
  "G": "न्",
  "H": "ज्",
  "J": "व्",
  "K": "प्",
  "L": "ी",
  ":": "स्",
  "\"": "ू",
  "a": "ब",
  "s": "क",
  "d": "म",
  "f": "ा",
  "g": "न",
  "h": "ज",
  "j": "व",
  "k": "प",
  "l": "ि",
  ";": "स",
  "'": "ु",
  "Z": "श्",
  "X": "ह्",
  "C": "ऋ",
  "V": "ख्",
  "B": "द्य",
  "N": "ल्",
  "M": "ः",
  "<": "?",
  ">": "श्र",
  "?": "रु",
  "z": "श",
  "x": "ह",
  "c": "अ",
  "v": "ख",
  "b": "द",
  "n": "ल",
  ",": ",",
  ".": "।",
  "/": "र",
  "„": "ध्र",
  "…": "‘",
  "ˆ": "फ्",
  "‰": "झ्",
  "‹": "ङ्घ",
  "‘": "ॅ",
  "•": "ड्ड",
  "˜": "ऽ",
  "›": "द्र",
  "¡": "ज्ञ्",
  "¢": "द्घ",
  "£": "घ्",
  "¤": "झ्",
  "¥": "्र",
  "§": "ट्ट",
  "©": "र",
  "ª": "ङ",
  "«": "्र",
  "°": "ङ्ढ",
  "±": "+",
  "´": "झ",
  "¶": "ठ्ठ",
  "¿": "रू",
  "Å": "हृ",
  "Æ": "”",
  "Ë": "ङ्ग",
  "Ì": "न्न",
  "Í": "ङ्क",
  "Î": "ङ्ख",
  "Ò": "¨",
  "Ö": "=",
  "×": "×",
  "Ø": "्य",
  "Ù": ";",
  "Ú": "’",
  "Û": "!",
  "Ü": "%",
  "Ý": "ट्ठ",
  "ß": "द्म",
  "å": "द्व",
  "æ": "“",
  "ç": "ॐ",
  "÷": "/"
};

const preRules: [RegExp, string][] = [
];

const postRules: [RegExp, string][] = [
  [new RegExp('्ा', 'g'), ``],
  [new RegExp('(त्र|त्त)([^उभप]+?)m', 'g'), `$1m$2`],
  [new RegExp('त्रm', 'g'), `क्र`],
  [new RegExp('त्तm', 'g'), `क्त`],
  [new RegExp('([^उभप]+?)m', 'g'), `m$1`],
  [new RegExp('उm', 'g'), `ऊ`],
  [new RegExp('भm', 'g'), `झ`],
  [new RegExp('पm', 'g'), `फ`],
  [new RegExp('इ{', 'g'), `ई`],
  [new RegExp('ि((.्)*[^्])', 'g'), `$1ि`],
  [new RegExp('(.[ािीुूृेैोौंःँ]*?){', 'g'), `{$1`],
  [new RegExp('((.्)*){', 'g'), `{$1`],
  [new RegExp('{', 'g'), `र्`],
  [new RegExp('([ाीुूृेैोौंःँ]+?)(्(.्)*[^्])', 'g'), `$2$1`],
  [new RegExp('्([ाीुूृेैोौंःँ]+?)((.्)*[^्])', 'g'), `्$2$1`],
  [new RegExp('([ंँ])([ािीुूृेैोौः]*)', 'g'), `$2$1`],
  [new RegExp('ँँ', 'g'), `ँ`],
  [new RegExp('ंं', 'g'), `ं`],
  [new RegExp('ेे', 'g'), `े`],
  [new RegExp('ैै', 'g'), `ै`],
  [new RegExp('ुु', 'g'), `ु`],
  [new RegExp('ूू', 'g'), `ू`],
  [new RegExp('^ः', 'g'), `:`],
  [new RegExp('टृ', 'g'), `ट्ट`],
  [new RegExp('ेा', 'g'), `ाे`],
  [new RegExp('ैा', 'g'), `ाै`],
  [new RegExp('अाे', 'g'), `ओ`],
  [new RegExp('अाै', 'g'), `औ`],
  [new RegExp('अा', 'g'), `आ`],
  [new RegExp('एे', 'g'), `ऐ`],
  [new RegExp('ाे', 'g'), `ो`],
  [new RegExp('ाै', 'g'), `ौ`],
];

export function convertPreetiToUnicode(text: string): string {
  if (!text) return text;
  
  // Split by whitespace but keep the whitespace tokens
  const parts = text.split(/(\s+)/);
  let result = '';

  for (let word of parts) {
    // If it's just whitespace, pass it through
    if (word.trim() === '') {
      result += word;
      continue;
    }

    // 1. Apply pre-rules
    for (const [pattern, replacement] of preRules) {
      word = word.replace(pattern, replacement);
    }

    // 2. Apply character map
    let mappedWord = '';
    for (const char of word) {
      mappedWord += characterMap[char] ?? char;
    }

    // 3. Apply post-rules
    for (const [pattern, replacement] of postRules) {
      mappedWord = mappedWord.replace(pattern, replacement);
    }

    result += mappedWord;
  }

  return result;
}
