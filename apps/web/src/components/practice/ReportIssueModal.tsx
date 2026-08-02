"use client";

import React, { useEffect, useActionState } from "react";
import { reportIssue } from "@/app/actions/practice-actions";
import { Loader2, AlertCircle, CheckCircle2 } from "lucide-react";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";

interface ReportIssueModalProps {
  isOpen: boolean;
  onClose: () => void;
  questionId: string;
}

// Sentence case, and worded the way a learner would describe the problem
// rather than the way an editor would file it.
const ISSUE_TYPES = [
  "The marked answer looks wrong",
  "The information is out of date",
  "The wording is confusing or mistranslated",
  "There is a typo or formatting problem",
  "Something else",
];

export function ReportIssueModal({ isOpen, onClose, questionId }: ReportIssueModalProps) {
  const [state, formAction, isPending] = useActionState(reportIssue, null);

  // Handle successful submit
  useEffect(() => {
    if (state?.success) {
      const timer = setTimeout(() => {
        onClose();
      }, 1500);
      return () => clearTimeout(timer);
    }
  }, [state, onClose]);

  return (
    <Dialog open={isOpen} onOpenChange={(open) => !open && onClose()}>
      <DialogContent className="sm:max-w-md rounded-2xl border border-border bg-card">
        <DialogHeader>
          <DialogTitle className="text-lg font-bold text-foreground">
            Report Issue
          </DialogTitle>
        </DialogHeader>

        <form action={formAction} className="space-y-4">
          {state?.success ? (
            <div className="py-8 flex flex-col items-center justify-center space-y-3 text-success">
               <CheckCircle2 className="w-12 h-12" />
               <p className="font-medium text-center">{state.message}</p>
            </div>
          ) : (
            <>
              <input type="hidden" name="questionId" value={questionId} />

              {state?.error && (
                <div className="flex items-start gap-2 p-3 text-sm text-destructive bg-destructive/10 border border-destructive/30 rounded-lg" role="alert">
                  <AlertCircle className="w-4 h-4 mt-0.5 shrink-0" />
                  <p>{state.error}</p>
                </div>
              )}

              <div className="space-y-1.5">
                <label htmlFor="issueType" className="text-sm font-medium text-foreground">
                  Issue Type <span className="text-destructive" aria-hidden="true">*</span>
                </label>
                <select
                  id="issueType"
                  name="issueType"
                  required
                  defaultValue=""
                  className="w-full px-3 py-2 text-sm bg-background border border-border rounded-lg text-foreground focus:outline-none focus:ring-2 focus:ring-ring"
                >
                  <option value="" disabled>Select an issue type...</option>
                  {ISSUE_TYPES.map(type => (
                    <option key={type} value={type}>{type}</option>
                  ))}
                </select>
              </div>

              <div className="space-y-1.5">
                <label htmlFor="description" className="text-sm font-medium text-foreground">
                  Additional Details <span className="text-muted-foreground font-normal">(Optional)</span>
                </label>
                <textarea
                  id="description"
                  name="description"
                  rows={4}
                  className="w-full px-3 py-2 text-sm bg-background border border-border rounded-lg text-foreground placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-ring resize-none"
                  placeholder="Describe the issue you found with this question..."
                />
              </div>

              <div className="pt-2 flex gap-3">
                <Button
                  type="button"
                  variant="outline"
                  className="flex-1"
                  onClick={onClose}
                >
                  Cancel
                </Button>
                <Button
                  type="submit"
                  variant="default"
                  className="flex-1"
                  disabled={isPending}
                >
                  {isPending ? (
                    <>
                      <Loader2 className="w-4 h-4 mr-2 animate-spin" />
                      Submitting...
                    </>
                  ) : (
                    "Submit Report"
                  )}
                </Button>
              </div>
            </>
          )}
        </form>
      </DialogContent>
    </Dialog>
  );
}
