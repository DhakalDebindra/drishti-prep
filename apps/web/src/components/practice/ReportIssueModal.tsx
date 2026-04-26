"use client";

import React, { useEffect, useRef, useState, useActionState } from "react";
import { reportIssue } from "@/app/actions/practice-actions";
import { X, Loader2, AlertCircle, CheckCircle2 } from "lucide-react";

interface ReportIssueModalProps {
  isOpen: boolean;
  onClose: () => void;
  questionId: string;
}

const ISSUE_TYPES = [
  "Incorrect Answer Key",
  "Outdated Information/Curriculum",
  "Translation or Clarity Issue",
  "Typo or Formatting Error",
  "Other",
];

export function ReportIssueModal({ isOpen, onClose, questionId }: ReportIssueModalProps) {
  const [state, formAction, isPending] = useActionState(reportIssue, null);
  const modalRef = useRef<HTMLDivElement>(null);
  
  // Close on Escape
  useEffect(() => {
    const handleKeyDown = (e: KeyboardEvent) => {
      if (e.key === "Escape" && isOpen) {
        onClose();
      }
    };
    if (isOpen) {
      document.addEventListener("keydown", handleKeyDown);
    }
    return () => document.removeEventListener("keydown", handleKeyDown);
  }, [isOpen, onClose]);

  // Trap focus roughly
  useEffect(() => {
    if (isOpen && modalRef.current) {
      const focusableElements = modalRef.current.querySelectorAll(
        'button, [href], input, select, textarea, [tabindex]:not([tabindex="-1"])'
      );
      const firstElement = focusableElements[0] as HTMLElement;
      if (firstElement) firstElement.focus();
    }
  }, [isOpen]);

  // Handle successful submit
  useEffect(() => {
    if (state?.success) {
      const timer = setTimeout(() => {
        onClose();
      }, 1500);
      return () => clearTimeout(timer);
    }
  }, [state, onClose]);

  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-slate-900/50 backdrop-blur-sm">
      <div 
        ref={modalRef}
        role="dialog"
        aria-modal="true"
        aria-labelledby="report-modal-title"
        className="w-full max-w-md bg-white dark:bg-slate-900 rounded-2xl shadow-xl border border-slate-200 dark:border-slate-800 overflow-hidden"
      >
        <div className="flex items-center justify-between p-4 border-b border-slate-200 dark:border-slate-800">
          <h2 id="report-modal-title" className="text-lg font-bold text-slate-900 dark:text-white">
            Report Issue
          </h2>
          <button
            onClick={onClose}
            aria-label="Close dialog"
            className="p-1.5 text-slate-400 hover:text-slate-600 dark:hover:text-slate-300 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg transition-colors focus:outline-none focus:ring-2 focus:ring-slate-500"
          >
            <X className="w-5 h-5" />
          </button>
        </div>

        <form action={formAction} className="p-4 sm:p-5 space-y-4">
          {state?.success ? (
            <div className="py-8 flex flex-col items-center justify-center space-y-3 text-green-600 dark:text-green-400">
               <CheckCircle2 className="w-12 h-12" />
               <p className="font-medium text-center">{state.message}</p>
            </div>
          ) : (
            <>
              <input type="hidden" name="questionId" value={questionId} />
              
              {state?.error && (
                <div className="flex items-start gap-2 p-3 text-sm text-red-800 bg-red-50 dark:bg-red-900/20 dark:text-red-300 border border-red-200 dark:border-red-800/50 rounded-lg" role="alert">
                  <AlertCircle className="w-4 h-4 mt-0.5 shrink-0" />
                  <p>{state.error}</p>
                </div>
              )}

              <div className="space-y-1.5">
                <label htmlFor="issueType" className="text-sm font-medium text-slate-700 dark:text-slate-300">
                  Issue Type <span className="text-red-500" aria-hidden="true">*</span>
                </label>
                <select
                  id="issueType"
                  name="issueType"
                  required
                  className="w-full px-3 py-2 text-sm bg-white dark:bg-slate-900 border border-slate-300 dark:border-slate-700 rounded-lg text-slate-900 dark:text-slate-100 focus:outline-none focus:ring-2 focus:ring-blue-500 dark:focus:ring-blue-400"
                >
                  <option value="" disabled selected>Select an issue type...</option>
                  {ISSUE_TYPES.map(type => (
                    <option key={type} value={type}>{type}</option>
                  ))}
                </select>
              </div>

              <div className="space-y-1.5">
                <label htmlFor="description" className="text-sm font-medium text-slate-700 dark:text-slate-300">
                  Additional Details <span className="text-slate-400 font-normal">(Optional)</span>
                </label>
                <textarea
                  id="description"
                  name="description"
                  rows={4}
                  className="w-full px-3 py-2 text-sm bg-white dark:bg-slate-900 border border-slate-300 dark:border-slate-700 rounded-lg text-slate-900 dark:text-slate-100 placeholder:text-slate-400 focus:outline-none focus:ring-2 focus:ring-blue-500 dark:focus:ring-blue-400 resize-none"
                  placeholder="Describe the issue you found with this question..."
                />
              </div>

              <div className="pt-2 flex gap-3">
                <button
                  type="button"
                  onClick={onClose}
                  className="flex-1 py-2 px-4 text-sm font-medium text-slate-700 dark:text-slate-300 bg-white dark:bg-slate-800 border border-slate-300 dark:border-slate-700 rounded-lg hover:bg-slate-50 dark:hover:bg-slate-700 transition-colors focus:outline-none focus:ring-2 focus:ring-slate-500"
                >
                  Cancel
                </button>
                <button
                  type="submit"
                  disabled={isPending}
                  className="flex-1 inline-flex justify-center items-center py-2 px-4 text-sm font-medium text-white bg-blue-600 rounded-lg hover:bg-blue-700 transition-colors focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 dark:focus:ring-offset-slate-900 disabled:opacity-70 disabled:cursor-not-allowed"
                >
                  {isPending ? (
                    <>
                      <Loader2 className="w-4 h-4 mr-2 animate-spin" />
                      Submitting...
                    </>
                  ) : (
                    "Submit Report"
                  )}
                </button>
              </div>
            </>
          )}
        </form>
      </div>
    </div>
  );
}
