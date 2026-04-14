"use client";

import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { LucideTrash2, Sparkles, Languages, Calendar, History } from "lucide-react";

interface QuestionFormCardProps {
  index: number;
  register: any;
  setValue: any;
  getValues: any;
  watch: any;
  remove: (index: number) => void;
  isGenerating: number | null;
  generateFeedback: (index: number) => Promise<void>;
  feedbackError: string | null;
  isQuestionComplete: (q: any) => boolean;
}

export function QuestionFormCard({
  index,
  register,
  setValue,
  getValues,
  watch,
  remove,
  isGenerating,
  generateFeedback,
  feedbackError,
  isQuestionComplete
}: QuestionFormCardProps) {
  const currentQuestion = watch(`questions.${index}`);

  return (
    <Card className="border-l-4 border-l-blue-500 shadow-sm hover:shadow-md transition-shadow duration-200 overflow-hidden">
      <CardHeader className="flex flex-row items-center justify-between pb-3 bg-slate-50/50">
        <CardTitle className="text-lg font-bold flex items-center gap-2">
          <span className="bg-blue-600 text-white w-6 h-6 rounded-full flex items-center justify-center text-xs">
            {index + 1}
          </span>
          Question Details
        </CardTitle>
        <Button 
          variant="ghost" 
          size="sm" 
          type="button" 
          className="text-red-500 hover:text-red-700 hover:bg-red-50 transition-colors"
          onClick={() => remove(index)}
          aria-label={`Remove question ${index + 1}`}
        >
          <LucideTrash2 className="w-4 h-4 mr-1.5" />
          Remove
        </Button>
      </CardHeader>
      
      <CardContent className="space-y-6 pt-6 bg-white">
        {/* Hidden Order Number */}
        <input type="hidden" {...register(`questions.${index}.order_number` as const)} value={index + 1} />

        {/* Content Section */}
        <div className="space-y-3">
          <div className="flex items-center justify-between">
            <Label htmlFor={`content-${index}`} className="text-sm font-semibold uppercase tracking-wider text-slate-500">
              Question Content
            </Label>
          </div>
          <Textarea 
            id={`content-${index}`}
            {...register(`questions.${index}.content` as const)} 
            placeholder="E.g., What is the capital of Nepal?" 
            className="min-h-[100px] text-lg resize-y focus:ring-2 focus:ring-blue-500 transition-all border-slate-200" 
          />
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-2 gap-8 pt-4">
          {/* Options Section */}
          <div className="space-y-4">
            <h3 className="font-bold text-sm uppercase tracking-wider text-slate-500 flex items-center gap-2">
               MCQ Options
            </h3>
            
            <div className="space-y-4 rounded-xl border border-slate-100 p-4 bg-slate-50/30">
              {['a', 'b', 'c', 'd'].map((opt) => (
                <div key={opt} className="relative group">
                  <div className="flex items-center gap-3">
                    <div className="flex items-center justify-center h-full pt-1">
                      <input 
                        type="radio" 
                        id={`opt-${opt}-${index}`}
                        value={opt.toUpperCase()} 
                        {...register(`questions.${index}.correct_option` as const)} 
                        className="w-5 h-5 cursor-pointer accent-blue-600 focus:ring-blue-500" 
                        title={`Mark Option ${opt.toUpperCase()} as Correct`}
                        aria-label={`Mark Option ${opt.toUpperCase()} as correct answer`}
                      />
                    </div>
                    <div className="flex-1 space-y-1.5">
                      <Label htmlFor={`questions.${index}.option_${opt}`} className="flex justify-between items-center text-xs font-medium text-slate-400">
                        Option {opt.toUpperCase()}
                      </Label>
                      <Input 
                        id={`questions.${index}.option_${opt}`}
                        {...register(`questions.${index}.option_${opt}` as const)} 
                        placeholder={`Option ${opt.toUpperCase()} text...`} 
                        className="border-slate-200 focus:border-blue-400 bg-white"
                      />
                    </div>
                  </div>
                </div>
              ))}
            </div>
          </div>

          {/* Explanation & Metadata Section */}
          <div className="space-y-6">
            <div className="space-y-4">
               <div className="flex justify-between items-center">
                <h3 className="font-bold text-sm uppercase tracking-wider text-slate-500 flex items-center gap-2">
                    Master Explanation
                </h3>
                <Button
                    type="button"
                    variant="outline"
                    size="sm"
                    className="h-8 gap-1.5 border-blue-200 text-blue-700 hover:bg-blue-50"
                    disabled={isGenerating === index || !isQuestionComplete(currentQuestion)}
                    onClick={() => generateFeedback(index)}
                >
                    <Sparkles className={`w-3.5 h-3.5 ${isGenerating === index ? 'animate-pulse' : ''}`} />
                    {isGenerating === index ? "Generating..." : "Generate with AI"}
                </Button>
               </div>

               <div className="space-y-2">
                <Textarea 
                    {...register(`questions.${index}.general_explanation` as const)} 
                    placeholder="Wait for AI or type manually..." 
                    className="bg-slate-50/50 border-slate-200 focus:bg-white transition-colors" 
                    rows={6}
                />
                {feedbackError && (
                    <p className="text-xs font-medium text-red-500 mt-1 flex items-center gap-1.5 bg-red-50 p-2 rounded">
                      <span>⚠️</span> {feedbackError}
                    </p>
                )}
               </div>
            </div>

            {/* Optional Provenance Metadata */}
            <div className="space-y-4 pt-2 border-t border-slate-100">
               <h3 className="font-bold text-sm uppercase tracking-wider text-slate-500 flex items-center gap-2">
                   Optional Metadata
               </h3>
               
               <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                  <div className="space-y-1.5">
                    <Label className="text-xs flex items-center gap-1.5 text-slate-500">
                      <Calendar className="w-3 h-3" /> Exam Year
                    </Label>
                    <Input 
                      type="number"
                      {...register(`questions.${index}.exam_year` as const)} 
                      placeholder="E.g. 2080"
                      className="h-8 text-sm"
                    />
                  </div>

                  <div className="space-y-1.5">
                    <Label className="text-xs flex items-center gap-1.5 text-slate-500">
                      <Languages className="w-3 h-3" /> Language
                    </Label>
                    <select 
                      {...register(`questions.${index}.language` as const)}
                      className="flex h-8 w-full rounded-md border border-slate-200 bg-white px-3 py-0 text-sm ring-offset-white focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-slate-950 focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50"
                      defaultValue="nepali"
                    >
                      <option value="nepali">Nepali (Default)</option>
                      <option value="english">English</option>
                      <option value="both">Bilingual (Both)</option>
                    </select>
                  </div>
               </div>

               <div className="space-y-1.5">
                  <Label className="text-xs flex items-center gap-1.5 text-slate-500">
                    <History className="w-3 h-3" /> Paper Reference / Source
                  </Label>
                  <Input 
                    {...register(`questions.${index}.paper_ref` as const)} 
                    placeholder="E.g. Section Officer 2080 - Paper 1"
                    className="h-8 text-sm"
                  />
               </div>
            </div>
          </div>
        </div>
      </CardContent>
    </Card>
  );
}
