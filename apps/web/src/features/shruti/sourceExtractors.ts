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
  const ocrPagesCount = Math.min(total, MAX_IMAGES);
  const pages: ExtractedPage[] = [];
  let totalChars = 0;

  const canvas = document.createElement("canvas");
  const ctx = canvas.getContext("2d");
  
  if (!ctx) {
    throw new Error("Could not initialize canvas context for PDF OCR.");
  }

  for (let i = 1; i <= ocrPagesCount; i++) {
    let text = "";
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
          text = ocrText;
          totalChars += ocrText.length;
        }
      }
    } catch (err) {
      if (typeof console !== "undefined" && process.env.NODE_ENV !== "production") {
        console.warn(`[Shruti] PDF page ${i} OCR failed:`, err);
      }
    }

    pages.push({
      index: i - 1,
      label: `Page ${i}${total > MAX_IMAGES ? ` of ${total}` : ""} (OCR)`,
      text,
    });
  }

  if (totalChars === 0) {
    throw new Error(
      "Could not extract any text from this PDF via OCR. " +
      "Please ensure the document contains readable text."
    );
  }

  return {
    pages,
    source: "pdf",
    filename: file.name,
    truncated: total > MAX_IMAGES,
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
