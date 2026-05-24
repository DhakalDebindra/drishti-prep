"use client";

import { useState, useEffect } from "react";
import { 
  Dialog, 
  DialogContent, 
  DialogHeader, 
  DialogTitle, 
  DialogDescription,
  DialogFooter,
  DialogClose
} from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Search, Loader2, Plus, CheckCircle2, History, Languages } from "lucide-react";
import { cn } from "@repo/utils";

interface QuestionSearchModalProps {
  isOpen: boolean;
  onClose: () => void;
  onImport: (question: any) => void;
  existingQuestionIds: string[];
}

export function QuestionSearchModal({ 
  isOpen, 
  onClose, 
  onImport,
  existingQuestionIds 
}: QuestionSearchModalProps) {
  const [query, setQuery] = useState("");
  const [results, setResults] = useState<any[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const searchQuestions = async () => {
    setLoading(true);
    setError(null);
    try {
      const res = await fetch(`/api/questions/search?query=${encodeURIComponent(query)}`);
      if (!res.ok) throw new Error("Search failed");
      const data = await res.json();
      setResults(data);
    } catch {
      setError("Failed to load questions. Please try again.");
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    if (!isOpen) return;
    
    const delayDebounceFn = setTimeout(() => {
      searchQuestions();
    }, 400);

    return () => clearTimeout(delayDebounceFn);
  }, [query, isOpen]);

  return (
    <Dialog open={isOpen} onOpenChange={onClose}>
      <DialogContent className="sm:max-w-3xl max-h-[90vh] flex flex-col p-0 overflow-hidden border-none shadow-2xl">
        <DialogHeader className="p-6 bg-slate-900 text-white">
          <DialogTitle className="text-xl flex items-center gap-2">
            <Search className="w-5 h-5" />
            Import Existing Question
          </DialogTitle>
          <DialogDescription className="text-slate-400">
            Search your database to reuse questions. This prevents duplication and maintains consistency.
          </DialogDescription>
        </DialogHeader>

        <div className="p-4 border-b bg-slate-50">
          <div className="relative">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400" />
            <Input 
              placeholder="Search by question content..." 
              className="pl-10 h-11 bg-white border-slate-200 focus:ring-blue-500 rounded-lg"
              value={query}
              onChange={(e) => setQuery(e.target.value)}
              autoFocus
            />
          </div>
        </div>

        <div className="flex-1 overflow-y-auto p-4 space-y-3 min-h-[300px] bg-slate-50/50">
          {error && (
            <div className="p-3 rounded-lg bg-red-50 text-red-600 text-sm border border-red-200 text-center">
              {error}
            </div>
          )}

          {loading && (
            <div className="flex flex-col items-center justify-center py-20 text-slate-500">
              <Loader2 className="w-8 h-8 animate-spin mb-2" />
              <p>Searching database...</p>
            </div>
          )}

          {!loading && results.length === 0 && (
            <div className="text-center py-20 text-slate-500">
              <p>{query ? "No matches found." : "Type something to start searching."}</p>
            </div>
          )}

          {!loading && results.map((q) => {
            const isAlreadyAdded = existingQuestionIds.includes(q.id);
            
            return (
              <div 
                key={q.id} 
                className={cn(
                  "group bg-white border rounded-xl p-4 transition-all hover:border-blue-300 hover:shadow-sm",
                  isAlreadyAdded && "opacity-60 bg-slate-100 cursor-not-allowed"
                )}
              >
                <div className="flex justify-between items-start gap-4">
                  <div className="flex-1 space-y-2">
                    <p className="font-medium text-slate-900 line-clamp-2">{q.content}</p>
                    <div className="flex flex-wrap gap-2">
                        {q.language && (
                           <span className="flex items-center gap-1 text-[10px] font-bold uppercase tracking-wider bg-blue-50 text-blue-600 px-1.5 py-0.5 rounded">
                             <Languages className="w-2.5 h-2.5" /> {q.language}
                           </span>
                        )}
                        {q.exam_year && (
                           <span className="flex items-center gap-1 text-[10px] font-bold uppercase tracking-wider bg-slate-100 text-slate-600 px-1.5 py-0.5 rounded">
                             <History className="w-2.5 h-2.5" /> {q.exam_year}
                           </span>
                        )}
                        <span className="text-[10px] text-slate-400">Correct: {q.correct_option}</span>
                    </div>
                  </div>
                  
                  <Button 
                    size="sm" 
                    variant={isAlreadyAdded ? "ghost" : "default"}
                    disabled={isAlreadyAdded}
                    onClick={() => !isAlreadyAdded && onImport(q)}
                    className={cn(
                      "shrink-0 gap-1.5",
                      !isAlreadyAdded && "bg-blue-600 hover:bg-blue-700 shadow-sm"
                    )}
                  >
                    {isAlreadyAdded ? (
                      <>
                        <CheckCircle2 className="w-4 h-4 text-emerald-500" />
                        Added
                      </>
                    ) : (
                      <>
                        <Plus className="w-4 h-4" />
                        Import
                      </>
                    )}
                  </Button>
                </div>
              </div>
            );
          })}
        </div>

        <DialogFooter className="p-4 border-t bg-white">
          <DialogClose
            render={
              <Button variant="outline" type="button" onClick={onClose}>
                Done
              </Button>
            }
          />
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}
