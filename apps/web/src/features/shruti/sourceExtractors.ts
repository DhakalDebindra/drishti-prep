// Source-text extractors for Shruti: PDF (client-side via pdfjs) and image
// (server-side OCR via Gemini Vision). Both produce per-page / per-image
// text the user can pick from before sending to the chunker.
//
// PDF extraction is client-side because:
//   - Users may upload personal study notes — keep them off the server
//   - pdfjs runs entirely in the browser and supports Devanagari text layers
//   - No upload bandwidth on what could be large files
//
// Image OCR is server-side because:
//   - Gemini Vision handles Devanagari handwriting much better than Tesseract.js
//   - We already have the Gemini API key
//   - Images are small (compared to PDFs) so upload is cheap

const MAX_PDF_PAGES = 10;
const MAX_IMAGES = 5;

export interface ExtractedPage {
  index: number;        // 0-based page number
  label: string;        // human label ("Page 1", "Image 2")
  text: string;
  confidence?: number;  // for OCR results
}

export interface ExtractionResult {
  pages: ExtractedPage[];
  source: "pdf" | "image";
  filename: string;
  truncated: boolean;
}

// -------------------------------------------------------------------------
// PDF
// -------------------------------------------------------------------------

interface PdfJsLib {
  getDocument: (src: { data: ArrayBuffer }) => { promise: Promise<PdfJsDocument> };
  GlobalWorkerOptions: { workerSrc: string };
  version: string;
}

interface PdfJsDocument {
  numPages: number;
  getPage: (n: number) => Promise<PdfJsPage>;
}

interface PdfJsPage {
  getTextContent: () => Promise<{ items: Array<{ str: string; transform?: number[] }> }>;
  getViewport: (params: { scale: number }) => any;
  render: (params: { canvasContext: CanvasRenderingContext2D; viewport: any }) => { promise: Promise<void> };
}

let pdfjsPromise: Promise<PdfJsLib> | null = null;

async function loadPdfJs(): Promise<PdfJsLib> {
  if (pdfjsPromise) return pdfjsPromise;
  pdfjsPromise = (async () => {
    // Dynamic import so the large pdfjs bundle doesn't ship in the initial chunk.
    const mod = (await import("pdfjs-dist")) as unknown as PdfJsLib & { default?: PdfJsLib };
    const lib = (mod.default ?? mod) as PdfJsLib;

    // Worker setup. Try public-folder path first (deterministic, same-origin,
    // works in any bundler). Fall back to jsdelivr CDN with the exact installed
    // version. We never use the cdnjs URL — it has been unreliable for newer
    // pdfjs versions.
    const publicPath = "/pdf.worker.min.mjs";
    let workerOk = false;
    try {
      const head = await fetch(publicPath, { method: "HEAD" });
      if (head.ok) {
        lib.GlobalWorkerOptions.workerSrc = publicPath;
        workerOk = true;
      }
    } catch {
      // ignored — fall through to CDN
    }
    if (!workerOk) {
      lib.GlobalWorkerOptions.workerSrc =
        `https://cdn.jsdelivr.net/npm/pdfjs-dist@${lib.version}/build/pdf.worker.min.mjs`;
    }
    return lib;
  })();
  return pdfjsPromise;
}

function isPreetiOrLegacyGibberish(text: string): boolean {
  if (!text) return false;
  
  // If it already contains Devanagari characters, it's actual Nepali Unicode.
  const hasDevanagari = /[ऀ-ॿ]/.test(text);
  if (hasDevanagari) return false;

  // If there are no Devanagari characters, it's either English or legacy Nepali (Preeti, etc.)
  // Check if it's English by looking for common English stop words.
  const commonEnglishWords = /\b(the|and|of|to|in|is|that|it|he|was|for|on|are|as|with|his|they|i|at|be|this|have|from|or|one|had|by|word|but|not|what|all|were|we|when|your|can|said|there|use|an|each|which|she|do|how|their|if|will|up|other|about|out|many|then|them|these|so|some|her|would|make|like|him|into|time|has|look|two|more|write|go|see|no|way|could|my|than|first|water|been|call|who|oil|its|now|find|long|down|day|did|get|come|made|may|part)\b/i;
  
  const isEnglish = commonEnglishWords.test(text);
  if (isEnglish) {
    // If it has a high density of Preeti characters, it's still likely Preeti
    const curlyBraces = (text.match(/[{}]/g) ?? []).length;
    const squareBrackets = (text.match(/[\[\]]/g) ?? []).length;
    const preetiMarkers = curlyBraces + squareBrackets;
    const ratio = preetiMarkers / text.length;
    if (ratio > 0.02) {
      return true; // Still Preeti
    }
    return false; // Valid English text, don't run OCR
  }

  // If it's not English and has no Devanagari, it's gibberish/legacy font.
  return true;
}

export async function extractPdfPages(file: File, ocrEndpoint = "/api/shruti/ocr"): Promise<ExtractionResult> {
  const buf = await file.arrayBuffer();
  let pdfjs: PdfJsLib;
  try {
    pdfjs = await loadPdfJs();
  } catch (err) {
    throw new Error(
      `Could not load PDF library: ${err instanceof Error ? err.message : String(err)}`,
    );
  }

  let doc: PdfJsDocument;
  try {
    doc = await pdfjs.getDocument({ data: buf }).promise;
  } catch (err) {
    throw new Error(
      `Could not open PDF: ${err instanceof Error ? err.message : String(err)}`,
    );
  }

  const total = doc.numPages;
  const pageCount = Math.min(total, MAX_PDF_PAGES);
  const pages: ExtractedPage[] = [];
  let totalChars = 0;

  for (let i = 1; i <= pageCount; i++) {
    let text = "";
    try {
      const page = await doc.getPage(i);
      const content = await page.getTextContent();
      text = content.items
        .map((it) => it.str)
        .join(" ")
        .replace(/\s+/g, " ")
        .trim();
    } catch (err) {
      // Per-page error — keep going. Logged via console for dev debugging only.
      if (typeof console !== "undefined" && process.env.NODE_ENV !== "production") {
        console.warn(`[Shruti] PDF page ${i} extract failed:`, err);
      }
    }
    totalChars += text.length;
    pages.push({
      index: i - 1,
      label: `Page ${i}${total > MAX_PDF_PAGES ? ` of ${total}` : ""}${text ? "" : " (empty)"}`,
      text,
    });
  }

  // If every page came back empty or contains legacy Preeti/gibberish, fallback to OCR.
  const isAllGibberishOrEmpty = pages.every((p) => !p.text || isPreetiOrLegacyGibberish(p.text));
  if (totalChars === 0 || isAllGibberishOrEmpty) {
    totalChars = 0; // Reset count to measure clean OCR text
    const ocrPagesCount = Math.min(total, MAX_IMAGES);
    const canvas = document.createElement("canvas");
    const ctx = canvas.getContext("2d");
    
    if (ctx) {
      for (let i = 1; i <= ocrPagesCount; i++) {
        try {
          const page = await doc.getPage(i);
          // Scale 2.0 for higher DPI, improving OCR accuracy
          const viewport = page.getViewport({ scale: 2.0 });
          canvas.width = viewport.width;
          canvas.height = viewport.height;
          await page.render({ canvasContext: ctx, viewport }).promise;

          const blob = await new Promise<Blob | null>((resolve) =>
            canvas.toBlob(resolve, "image/jpeg", 0.9)
          );
          if (blob) {
            const imgFile = new File([blob], `page_${i}.jpg`, { type: "image/jpeg" });
            const ocrText = await ocrImage(imgFile, ocrEndpoint);
            if (ocrText) {
              totalChars += ocrText.length;
              pages[i - 1].text = ocrText;
              const cleanLabel = pages[i - 1].label.replace(" (empty)", "");
              pages[i - 1].label = cleanLabel.endsWith(" (OCR)") ? cleanLabel : `${cleanLabel} (OCR)`;
            } else {
              // If OCR returned nothing, make sure we clear the legacy/gibberish text
              pages[i - 1].text = "";
            }
          }
        } catch (err) {
          if (typeof console !== "undefined" && process.env.NODE_ENV !== "production") {
            console.warn(`[Shruti] PDF page ${i} OCR fallback failed:`, err);
          }
          // Clear text on failure so we don't return gibberish Preeti
          pages[i - 1].text = "";
        }
      }
    }

    if (totalChars === 0) {
      throw new Error(
        "Could not extract any text from this PDF, even after attempting OCR. " +
        "Please ensure the document contains readable text."
      );
    }

    // Since we only OCR up to MAX_IMAGES pages to avoid rate limits, we truncate
    // the document earlier than a standard text-layer PDF.
    return {
      pages: pages.slice(0, ocrPagesCount),
      source: "pdf",
      filename: file.name,
      truncated: total > MAX_IMAGES,
    };
  }

  return {
    pages,
    source: "pdf",
    filename: file.name,
    truncated: total > MAX_PDF_PAGES,
  };
}

// -------------------------------------------------------------------------
// Images
// -------------------------------------------------------------------------

export async function extractImagesText(
  files: File[],
  endpoint = "/api/shruti/ocr",
): Promise<ExtractionResult> {
  const accepted = files.slice(0, MAX_IMAGES);
  const pages: ExtractedPage[] = [];
  for (let i = 0; i < accepted.length; i++) {
    const file = accepted[i];
    const text = await ocrImage(file, endpoint);
    pages.push({
      index: i,
      label: `Image ${i + 1} (${file.name})`,
      text: text ?? "",
    });
  }
  return {
    pages,
    source: "image",
    filename: accepted.map((f) => f.name).join(", ") || "(images)",
    truncated: files.length > MAX_IMAGES,
  };
}

async function ocrImage(file: File, endpoint: string): Promise<string | null> {
  const form = new FormData();
  form.append("image", file, file.name);
  try {
    const res = await fetch(endpoint, { method: "POST", body: form });
    if (!res.ok) return null;
    const data = (await res.json()) as { text?: string };
    return (data.text ?? "").trim();
  } catch {
    return null;
  }
}

export const LIMITS = { MAX_PDF_PAGES, MAX_IMAGES };
