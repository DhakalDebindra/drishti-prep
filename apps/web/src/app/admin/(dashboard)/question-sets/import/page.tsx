"use client";

import { useState, useEffect, useId, useMemo } from "react";
import { useRouter } from "next/navigation";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import Papa from "papaparse";
import toast from "react-hot-toast";

type RowError = { row: number; error: string };
type SubjectOption = { id: string; name: string };
type TopicOption = { id: string; name: string; subject_id: string | null; subject_name: string | null };
type SubtopicOption = { id: string; name: string; name_np: string | null; topic_id: string };

// Explanation cells may use the literal sequence \n for line breaks (converted on import)
// and **double asterisks** to bold the key fact.
const TEMPLATE_CSV = `Question Content;Option A;Option B;Option C;Option D;Correct Option;Explanation;Exam Year;Paper Reference;Language
Which city is known as the "City of Temples", Kathmandu?;Kathmandu;Pokhara;Lalitpur;Bhaktapur;A;सही उत्तर (A) **Kathmandu** हो।\n- विकल्प (B): Pokhara is Nepal's lake city.\n- विकल्प (C): Lalitpur is known for traditional crafts.\n- विकल्प (D): Bhaktapur preserves Newar heritage.;2080;S.O. 2080-1;nepali
Which is the highest mountain?;K2;Kangchenjunga;Mount Everest;Lhotse;C;सन् **१९५३** मा पहिलो पटक आरोहण भएको Mount Everest विश्वकै अग्लो शिखर हो।\nनोट: यसको उचाइ ८,८४८.८६ मिटर हो।;;;nepali`;

export default function BulkImportPage() {
  const router = useRouter();
  const [file, setFile] = useState<File | null>(null);
  const [errors, setErrors] = useState<RowError[]>([]);
  const [isProcessing, setIsProcessing] = useState(false);
  const [successMessage, setSuccessMessage] = useState<string | null>(null);

  // Metadata Fields
  const [title, setTitle] = useState("");
  const [subjectId, setSubjectId] = useState("");
  const [topicId, setTopicId] = useState("");
  const [subtopicId, setSubtopicId] = useState("");
  const [difficulty, setDifficulty] = useState("1");
  const [setType, setSetType] = useState("learning");

  // Hierarchy Lists
  const [subjects, setSubjects] = useState<SubjectOption[]>([]);
  const [topics, setTopics] = useState<TopicOption[]>([]);
  const [subtopics, setSubtopics] = useState<SubtopicOption[]>([]);

  useEffect(() => {
    // Load existing hierarchy for selection
    Promise.all([
      fetch("/api/subjects").then(r => r.json()),
      fetch("/api/topics").then(r => r.json()),
      fetch("/api/subtopics").then(r => r.json())
    ]).then(([sData, tData, stData]) => {
      setSubjects(sData || []);
      setTopics(tData || []);
      setSubtopics(stData || []);
    });
  }, []);

  const filteredTopics = useMemo(() => {
    if (!subjectId) return [];
    return topics.filter(t => t.subject_id === subjectId);
  }, [topics, subjectId]);

  const filteredSubtopics = useMemo(() => {
    if (!topicId) return [];
    return subtopics.filter(st => st.topic_id === topicId);
  }, [subtopics, topicId]);

  const downloadTemplate = () => {
    const blob = new Blob([TEMPLATE_CSV], { type: "text/csv" });
    const url = URL.createObjectURL(blob);
    const a = document.createElement("a");
    a.href = url;
    a.download = "drishtiprep_import_template_semicolon.csv";
    a.click();
    URL.revokeObjectURL(url);
  };

  const processCsv = (text: string) => {
    const parsedData: any[] = [];
    const rowErrors: RowError[] = [];

    const lines = text.split('\n').filter(l => l.trim()).slice(0, 5);
    const hasSemicolons = lines.some(l => l.includes(';'));
    const hasCommas = lines.some(l => l.includes(','));

    if (!hasSemicolons && hasCommas) {
        rowErrors.push({ row: 0, error: "Delimiter mismatch: Please use semicolons (;) as the separator." });
        return { parsedData, rowErrors };
    }

    const result = Papa.parse(text, { header: false, skipEmptyLines: true, delimiter: ";" });
    const rows = result.data as string[][];

    if (result.errors.length > 0) {
        rowErrors.push({ row: 0, error: `CSV Parsing Error: ${result.errors[0].message}` });
        return { parsedData, rowErrors };
    }

    for (let i = 1; i < rows.length; i++) {
        const columns = rows[i];
        if (columns.length < 6) {
            rowErrors.push({ row: i + 1, error: "Missing required columns" });
            continue;
        }

        const [content, option_a, option_b, option_c, option_d, correct_raw, explanation, exam_year, paper_ref, language] = columns;
        const correct_option = correct_raw?.trim().toUpperCase();

        if (!content || !option_a || !option_b || !option_c || !option_d || !correct_option) {
            rowErrors.push({ row: i + 1, error: "Required fields are empty" });
            continue;
        }

        if (!["A", "B", "C", "D"].includes(correct_option)) {
            rowErrors.push({ row: i + 1, error: `Invalid correct option "${correct_option}"` });
            continue;
        }

        const rawLanguage = language?.trim().toLowerCase() || "";
        let finalLanguage: "nepali" | "english" | "both" = "nepali";
        if (rawLanguage === "english" || rawLanguage === "en") finalLanguage = "english";
        else if (rawLanguage === "both") finalLanguage = "both";

        parsedData.push({
            content: content.trim(),
            option_a: option_a.trim(),
            option_b: option_b.trim(),
            option_c: option_c.trim(),
            option_d: option_d.trim(),
            correct_option,
            general_explanation: explanation?.trim().replace(/\\n/g, "\n") || "",
            exam_year: exam_year?.trim() ? parseInt(exam_year) : null,
            paper_ref: paper_ref?.trim() || "",
            language: finalLanguage,
            order_number: i
        });
    }
    return { parsedData, rowErrors };
  };

  const handleUploadAndImport = async () => {
    if (!file || !title || !subjectId || !topicId) {
        toast.error("Please fill in all metadata fields.");
        return;
    }

    setIsProcessing(true);
    setErrors([]);

    try {
        const text = await file.text();
        const { parsedData, rowErrors } = processCsv(text);
        if (rowErrors.length > 0) { setErrors(rowErrors); setIsProcessing(false); return; }
        if (parsedData.length > 30) { toast.error("Maximum 30 questions allowed."); setIsProcessing(false); return; }

        const response = await fetch("/api/question-sets", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
                title,
                topic_id: topicId,
                subtopic_id: subtopicId || undefined,
                difficulty_level: parseInt(difficulty),
                set_type: setType,
                is_verified: true,
                questions: parsedData
            })
        });

        const result = await response.json();
        if (!response.ok) throw new Error(result.error || "Failed to import");

        toast.success(`Success! Created set with ${parsedData.length} questions.`);
        setSuccessMessage(`Import successful. Redirecting...`);
        setTimeout(() => router.push("/admin"), 2000);
    } catch (e: any) {
        toast.error(e.message || "Failed to import CSV");
    } finally {
        setIsProcessing(false);
    }
  };

  return (
    <div className="container mx-auto py-8 space-y-6">
      <div className="flex justify-between items-center">
        <div>
          <h1 className="text-3xl font-bold text-slate-900">Bulk Import Engine</h1>
          <p className="text-slate-500 mt-1">Convert your offline CSV files into interactive practice sets (5-level hierarchy supported).</p>
        </div>
        <Button variant="outline" onClick={downloadTemplate}>Download Template</Button>
      </div>
      
      <div className="grid lg:grid-cols-3 gap-6">
        <Card className="lg:col-span-1 shadow-sm border-slate-200">
          <CardHeader>
            <CardTitle>1. Set Configuration</CardTitle>
            <CardDescription>Tell us where these questions belong.</CardDescription>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="space-y-2">
              <Label htmlFor="set-title">Set Title</Label>
              <Input id="set-title" placeholder="e.g. Current Affairs - Q2 2024" value={title} onChange={e => setTitle(e.target.value)} />
            </div>

            <div className="space-y-2">
              <Label htmlFor="set-subject">Subject</Label>
              <select 
                id="set-subject" 
                className="flex h-10 w-full rounded-md border border-input bg-background px-3 py-2 text-sm focus:ring-2 focus:ring-blue-500"
                value={subjectId}
                onChange={e => { setSubjectId(e.target.value); setTopicId(""); setSubtopicId(""); }}
              >
                <option value="" disabled>Select a subject</option>
                {subjects.map(s => <option key={s.id} value={s.id}>{s.name}</option>)}
              </select>
            </div>

            <div className="space-y-2">
              <Label htmlFor="set-topic">Topic</Label>
              <select 
                id="set-topic" 
                className="flex h-10 w-full rounded-md border border-input bg-background px-3 py-2 text-sm focus:ring-2 focus:ring-blue-500"
                value={topicId}
                onChange={e => { setTopicId(e.target.value); setSubtopicId(""); }}
                disabled={!subjectId || filteredTopics.length === 0}
              >
                <option value="" disabled>Select a topic</option>
                {filteredTopics.map(t => <option key={t.id} value={t.id}>{t.name}</option>)}
              </select>
            </div>

            <div className="space-y-2">
              <Label htmlFor="set-subtopic">Sub-topic (Optional)</Label>
              <select 
                id="set-subtopic" 
                className="flex h-10 w-full rounded-md border border-input bg-background px-3 py-2 text-sm focus:ring-2 focus:ring-blue-500"
                value={subtopicId}
                onChange={e => setSubtopicId(e.target.value)}
                disabled={!topicId || filteredSubtopics.length === 0}
              >
                <option value="">No Sub-topic</option>
                {filteredSubtopics.map(st => <option key={st.id} value={st.id}>{st.name_np || st.name}</option>)}
              </select>
            </div>

            <div className="space-y-2">
              <Label htmlFor="set-difficulty">Difficulty</Label>
              <select id="set-difficulty" className="flex h-10 w-full rounded-md border border-input bg-background px-3 py-2 text-sm focus:ring-2 focus:ring-blue-500" value={difficulty} onChange={e => setDifficulty(e.target.value)}>
                <option value="1">Level 1</option>
                <option value="2">Level 2</option>
                <option value="3">Level 3</option>
              </select>
            </div>
          </CardContent>
        </Card>

        <Card className="lg:col-span-2 shadow-sm border-slate-200">
            <CardHeader>
                <CardTitle>2. Source File</CardTitle>
                <CardDescription>Upload your Semicolon-delimited CSV.</CardDescription>
            </CardHeader>
            <CardContent className="space-y-6">
                <div className="relative border-2 border-dashed rounded-xl p-12 text-center bg-slate-50 hover:border-blue-400 transition-all">
                    <Input type="file" accept=".csv" className="absolute inset-0 w-full h-full opacity-0 cursor-pointer z-10" onChange={(e) => setFile(e.target.files?.[0] || null)} />
                    <div className="space-y-2">
                        <p className="text-4xl">📁</p>
                        <p className="font-bold text-slate-900">{file ? file.name : "Drop CSV here"}</p>
                    </div>
                </div>

                <Button onClick={handleUploadAndImport} disabled={!file || isProcessing} className="w-full h-12 text-lg bg-blue-600 hover:bg-blue-700 text-white">
                   {isProcessing ? "Ingesting..." : "Import Set"}
                </Button>

                {errors.length > 0 && (
                  <div className="bg-red-50 border border-red-200 p-4 rounded-lg">
                    <p className="text-sm font-bold text-red-700 mb-2">Errors detected:</p>
                    <ul className="text-xs text-red-600 space-y-1">
                      {errors.map((err, idx) => <li key={idx}>Row {err.row}: {err.error}</li>)}
                    </ul>
                  </div>
                )}
            </CardContent>
        </Card>
      </div>
    </div>
  );
}
