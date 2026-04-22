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

const TEMPLATE_CSV = `Question Content;Option A;Option B;Option C;Option D;Correct Option;Explanation;Exam Year;Paper Reference;Language
Which city is known as the "City of Temples", Kathmandu?;Kathmandu;Pokhara;Lalitpur;Bhaktapur;A;Kathmandu is a historical city, famous for its temples.;2080;S.O. 2080-1;nepali
Which is the highest mountain?;K2;Kangchenjunga;Mount Everest;Lhotse;C;Mount Everest is the highest peak in the world.;;;nepali`;

export default function BulkImportPage() {
  const router = useRouter();
  const [file, setFile] = useState<File | null>(null);
  const [errors, setErrors] = useState<RowError[]>([]);
  const [isProcessing, setIsProcessing] = useState(false);
  const [successMessage, setSuccessMessage] = useState<string | null>(null);

  // Metadata Fields
  const [title, setTitle] = useState("");
  const [subjectLookup, setSubjectLookup] = useState("");
  const [topicLookup, setTopicLookup] = useState("");
  const [difficulty, setDifficulty] = useState("1");
  const [setType, setSetType] = useState("learning");

  // Subject/Topic Lists
  const [subjects, setSubjects] = useState<SubjectOption[]>([]);
  const [topics, setTopics] = useState<TopicOption[]>([]);
  const subjectListId = useId();
  const topicListId = useId();

  useEffect(() => {
    // Load existing subjects/topics for autocomplete
    Promise.all([
      fetch("/api/subjects").then(r => r.json()),
      fetch("/api/topics").then(r => r.json())
    ]).then(([sData, tData]) => {
      setSubjects(sData || []);
      setTopics(tData || []);
    });
  }, []);

  const matchedSubject = useMemo(() => {
    return subjects.find(s => s.name.toLowerCase() === subjectLookup.trim().toLowerCase());
  }, [subjects, subjectLookup]);

  const filteredTopics = useMemo(() => {
    if (!matchedSubject) return topics;
    return topics.filter(t => t.subject_id === matchedSubject.id);
  }, [topics, matchedSubject]);

  const downloadTemplate = () => {
    const blob = new Blob([TEMPLATE_CSV], { type: "text/csv" });
    const url = URL.createObjectURL(blob);
    const a = document.createElement("a");
    a.href = url;
    a.download = "dristiprep_import_template_semicolon.csv";
    a.click();
    URL.revokeObjectURL(url);
  };

  const processCsv = (text: string) => {
    const parsedData: any[] = [];
    const rowErrors: RowError[] = [];

    // Pre-validation: Detect if they are using commas instead of semicolons
    const lines = text.split('\n').filter(l => l.trim()).slice(0, 5);
    const hasSemicolons = lines.some(l => l.includes(';'));
    const hasCommas = lines.some(l => l.includes(','));

    if (!hasSemicolons && hasCommas) {
        rowErrors.push({ 
            row: 0, 
            error: "Delimiter mismatch: This file appears to use commas to separate fields. Dristiprep now requires a semicolon (;) as the separator to allow commas within your question content." 
        });
        return { parsedData, rowErrors };
    }

    const result = Papa.parse(text, {
        header: false,
        skipEmptyLines: true,
        delimiter: ";"
    });

    const rows = result.data as string[][];

    // Check high level papa errors if any
    if (result.errors.length > 0) {
        rowErrors.push({ row: 0, error: `CSV Parsing Error: ${result.errors[0].message}` });
        return { parsedData, rowErrors };
    }

    // Skip header row at index 0
    for (let i = 1; i < rows.length; i++) {
        const columns = rows[i];
        
        if (columns.length < 7) {
            rowErrors.push({ row: i + 1, error: "Missing required columns (needs at least 7 basic columns)" });
            continue;
        }

        const [content, option_a, option_b, option_c, option_d, correct_raw, explanation, exam_year, paper_ref, language] = columns;
        const correct_option = correct_raw?.trim().toUpperCase();

        if (!content || !option_a || !option_b || !option_c || !option_d) {
            rowErrors.push({ row: i + 1, error: "One or more text fields are completely empty" });
            continue;
        }

        if (!["A", "B", "C", "D"].includes(correct_option)) {
            let errorMsg = `Invalid correct option "${correct_option}". Must be A, B, C, or D.`;
            // If we have more than 10 columns (the max expected), it's likely a delimiter leak
            if (columns.length > 10) {
                errorMsg += " Check if your question content or options contain a semicolon (;), as it's used as the field separator.";
            }
            rowErrors.push({ row: i + 1, error: errorMsg });
            continue;
        }

        const rawLanguage = language?.trim().toLowerCase() || "";
        let finalLanguage: "nepali" | "english" | "both" = "nepali";
        
        if (rawLanguage === "english" || rawLanguage === "en" || rawLanguage === "eng") {
            finalLanguage = "english";
        } else if (rawLanguage === "both" || rawLanguage === "all") {
            finalLanguage = "both";
        } else if (rawLanguage === "nepali" || rawLanguage === "np" || rawLanguage === "nep") {
            finalLanguage = "nepali";
        }

        parsedData.push({
            content: content.trim(),
            option_a: option_a.trim(),
            option_b: option_b.trim(),
            option_c: option_c.trim(),
            option_d: option_d.trim(),
            correct_option,
            explanation: explanation?.trim() || "",
            exam_year: exam_year?.trim() ? parseInt(exam_year) : null,
            paper_ref: paper_ref?.trim() || "",
            language: finalLanguage,
            order_number: i // Maintain relative order from file
        });
    }
    return { parsedData, rowErrors };
  };

  const resolveSubjectId = async (name: string) => {
    const existing = subjects.find(s => s.name.toLowerCase() === name.trim().toLowerCase());
    if (existing) return existing.id;
    
    // Create new subject
    const res = await fetch("/api/subjects", {
        method: "POST",
        headers: { "Content-Type" : "application/json" },
        body: JSON.stringify({ name: name.trim() })
    });
    const data = await res.json();
    if (!res.ok) throw new Error(data.error || "Failed to create subject");
    return data.id;
  };

  const resolveTopicId = async (name: string, subject_id: string) => {
    const existing = topics.find(t => t.name.toLowerCase() === name.trim().toLowerCase() && t.subject_id === subject_id);
    if (existing) return existing.id;

    // Create new topic
    const res = await fetch("/api/topics", {
        method: "POST",
        headers: { "Content-Type" : "application/json" },
        body: JSON.stringify({ name: name.trim(), subject_id })
    });
    const data = await res.json();
    if (!res.ok) throw new Error(data.error || "Failed to create topic");
    return data.id;
  };

  const handleUploadAndImport = async () => {
    if (!file || !title || !subjectLookup || !topicLookup) {
        toast.error("Please fill in all metadata fields (Title, Subject, Topic) and select a file.");
        return;
    }

    setIsProcessing(true);
    setErrors([]);
    setSuccessMessage(null);

    try {
        const text = await file.text();
        const { parsedData, rowErrors } = processCsv(text);
        
        if (rowErrors.length > 0) {
            setErrors(rowErrors);
            setIsProcessing(false);
            return;
        }

        if (parsedData.length > 30) {
            toast.error("A question set can contain a maximum of 30 questions.");
            setIsProcessing(false);
            return;
        }

        // Resolving Meta IDs
        const sId = await resolveSubjectId(subjectLookup);
        const tId = await resolveTopicId(topicLookup, sId);

        // Map client field 'explanation' back to API-expected 'general_explanation'
        const questionsPayload = parsedData.map(q => ({
            ...q,
            general_explanation: q.explanation // Map to API schema
        }));

        // 1. Submit the entire set
        const response = await fetch("/api/question-sets", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
                title,
                topic_id: tId, // Send required ID
                difficulty_level: parseInt(difficulty),
                set_type: setType,
                is_verified: true,
                questions: questionsPayload
            })
        });

        const result = await response.json();
        if (!response.ok) throw new Error(result.error || "Failed to import");

        toast.success(`Success! Created practice set with ${parsedData.length} questions.`);
        setSuccessMessage(`Success! Created practice set with ${parsedData.length} questions. Redirecting...`);
        setTimeout(() => router.push("/admin"), 2000);
    } catch (e: any) {
        console.error("Import Batch Error:", e);
        const isReadError = e.name === "NotReadableError" || e.message?.toLowerCase().includes("could not be read");
        
        const finalError = isReadError 
            ? "Error reading file. This happens if you edited the file after selecting it. Please click the upload area and select the file again."
            : (e.message || "Failed to import CSV");

        toast.error(finalError);
        setErrors([{ row: 0, error: finalError }]);
        
        if (isReadError) {
          setFile(null); // Force re-selection
        }
    } finally {
        setIsProcessing(false);
    }
  };

  return (
    <div className="container mx-auto py-8 space-y-6">
      <div className="flex justify-between items-center">
        <div>
          <h1 className="text-3xl font-bold">Bulk Import Engine</h1>
          <p className="text-muted-foreground mt-1">Convert your offline CSV files into interactive practice sets.</p>
        </div>
        <Button variant="outline" onClick={downloadTemplate}>Download Semicolon Template</Button>
      </div>
      
      <div className="grid lg:grid-cols-3 gap-6">
        {/* Metadata Configuration */}
        <Card className="lg:col-span-1">
          <CardHeader>
            <CardTitle>1. Set Configuration</CardTitle>
            <CardDescription>Tell us where these questions belong.</CardDescription>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="space-y-2">
              <Label htmlFor="set-title">Practice Set Title</Label>
              <Input 
                id="set-title" 
                placeholder="e.g. Modern History Mock 01" 
                value={title} 
                onChange={e => setTitle(e.target.value)} 
                autoFocus
              />
            </div>

            <div className="space-y-2">
              <Label htmlFor="set-subject">Subject</Label>
              <Input 
                id="set-subject" 
                list={subjectListId} 
                placeholder="Select or create subject" 
                value={subjectLookup} 
                onChange={e => setSubjectLookup(e.target.value)} 
              />
              <datalist id={subjectListId}>
                {subjects.map(s => <option key={s.id} value={s.name} />)}
              </datalist>
            </div>

            <div className="space-y-2">
              <Label htmlFor="set-topic">Topic</Label>
              <Input 
                id="set-topic" 
                list={topicListId} 
                placeholder="Select or create topic" 
                value={topicLookup} 
                onChange={e => setTopicLookup(e.target.value)} 
              />
              <datalist id={topicListId}>
                {filteredTopics.map(t => <option key={t.id} value={t.name} />)}
              </datalist>
            </div>

            <div className="space-y-2">
              <Label htmlFor="set-difficulty">Difficulty</Label>
              <select 
                id="set-difficulty" 
                className="flex h-10 w-full rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background file:border-0 file:bg-transparent file:text-sm file:font-medium placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50"
                value={difficulty}
                onChange={e => setDifficulty(e.target.value)}
              >
                <option value="1">Beginner</option>
                <option value="2">Intermediate</option>
                <option value="3">Advanced</option>
              </select>
            </div>

            <div className="space-y-2">
              <Label htmlFor="set-type">Set Type</Label>
              <select 
                id="set-type" 
                className="flex h-10 w-full rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background file:border-0 file:bg-transparent file:text-sm file:font-medium placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50"
                value={setType}
                onChange={e => setSetType(e.target.value)}
              >
                <option value="learning">Learning Path (Standard)</option>
                <option value="mock_exam">Mock Exam</option>
                <option value="daily_practice">Daily Practice</option>
                <option value="revision">Revision Set</option>
                <option value="custom">Custom Set</option>
              </select>
            </div>
          </CardContent>
        </Card>

        {/* Upload & Validation */}
        <Card className="lg:col-span-2">
            <CardHeader>
                <CardTitle>2. Question Source File</CardTitle>
                <CardDescription>Upload your completed CSV file for structure validation.</CardDescription>
            </CardHeader>
            <CardContent className="space-y-6">
                <div className="relative border-2 border-dashed rounded-xl p-8 text-center bg-slate-50 transition-colors hover:border-blue-400 focus-within:ring-2 focus-within:ring-blue-500">
                    <Input 
                      type="file" 
                      accept=".csv" 
                      className="absolute inset-0 w-full h-full opacity-0 cursor-pointer z-10" 
                      id="csv-upload"
                      aria-label="Upload CSV file"
                      onChange={(e) => setFile(e.target.files?.[0] || null)} 
                    />
                    <div className="space-y-4 pointer-events-none">
                        <div className="text-4xl">📄</div>
                        <div className="space-y-1 text-center">
                            <p className="font-bold text-blue-700">{file ? file.name : "Click or drag to select Semicolon CSV"}</p>
                            <p className="text-xs text-muted-foreground">Ensure your file uses semicolon (;) as the field separator.</p>
                        </div>
                    </div>
                </div>

                <Button 
                   onClick={handleUploadAndImport} 
                   disabled={!file || isProcessing}
                   className="w-full h-12 text-lg font-bold"
                >
                   {isProcessing ? "Processing Batch Ingestion..." : "Validate & Start Import"}
                </Button>

                {errors.length > 0 && (
                  <Card className="border-red-300 bg-red-50" role="alert" aria-live="assertive">
                    <CardHeader className="py-3 px-4">
                      <CardTitle className="text-sm text-red-700">Schema Errors Found</CardTitle>
                    </CardHeader>
                    <CardContent className="px-4 pb-4">
                      <ul className="text-xs text-red-800 space-y-1">
                        {errors.map((err, idx) => (
                          <li key={idx}><strong>Row {err.row}:</strong> {err.error}</li>
                        ))}
                      </ul>
                    </CardContent>
                  </Card>
                )}

                {successMessage && (
                  <div className="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative animate-pulse">
                    <strong className="font-bold">Ingestion Success! </strong>
                    <span className="block sm:inline">{successMessage} Redirecting to Studio...</span>
                  </div>
                )}
            </CardContent>
        </Card>
      </div>
    </div>
  );
}
