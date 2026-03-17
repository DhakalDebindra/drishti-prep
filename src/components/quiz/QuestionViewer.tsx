"use client";

import { useState } from "react";
import { Button } from "@/components/ui/button";

export interface Question {
  id: string;
  order_number: number;
  content: string;
  option_a: string;
  option_b: string;
  option_c: string;
  option_d: string;
  correct_option: "A" | "B" | "C" | "D";
  explanation?: string | null;
}

interface QuestionViewerProps {
  question: Question;
  onNext?: () => void;
  onPrevious?: () => void;
  isFirst?: boolean;
  isLast?: boolean;
}

export function QuestionViewer({
  question,
  onNext,
  onPrevious,
  isFirst,
  isLast,
}: QuestionViewerProps) {
  const [selectedOption, setSelectedOption] = useState<"A" | "B" | "C" | "D" | null>(null);
  const [hasSubmitted, setHasSubmitted] = useState(false);
  const [isExplanationExpanded, setIsExplanationExpanded] = useState(false);

  const options = [
    { value: "A" as const, text: question.option_a },
    { value: "B" as const, text: question.option_b },
    { value: "C" as const, text: question.option_c },
    { value: "D" as const, text: question.option_d },
  ];

  const showStatus = hasSubmitted && !!selectedOption;
  const isCorrectSelection = showStatus && selectedOption === question.correct_option;
  const statusToneClasses = isCorrectSelection
    ? "border-green-500 bg-green-50 text-green-900"
    : "border-red-500 bg-red-50 text-red-900";
  const statusIcon = isCorrectSelection ? "✔" : "✖";
  const explanationId = `question-${question.id}-explanation`;

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (selectedOption) {
      setHasSubmitted(true);
    }
  };

  return (
    <div className="max-w-3xl mx-auto p-6 bg-white rounded-lg shadow-md">
      <form onSubmit={handleSubmit}>
        {/* 
          Accessibility Focus:
          2. fieldset and legend correctly group the radio buttons and announce the question 
          context when navigating through the form controls.
        */}
        <fieldset className="space-y-6">
          <legend className="text-xl font-semibold text-gray-900 mb-4">
            <span className="sr-only">Question {question.order_number}: </span>
            {question.content}
          </legend>

          <div className="space-y-3">
            {options.map((option) => (
              <label
                key={option.value}
                className={`flex items-start p-4 border rounded-lg cursor-pointer transition-colors ${
                  selectedOption === option.value
                    ? "border-blue-600 bg-blue-50"
                    : "border-gray-200 hover:bg-gray-50"
                } ${
                  hasSubmitted && option.value === question.correct_option
                    ? "border-green-600 bg-green-50 ring-2 ring-green-600"
                    : ""
                }`}
              >
                <div className="flex items-center h-5">
                    <input
                      type="radio"
                      name={`question-${question.id}`}
                      value={option.value}
                      checked={selectedOption === option.value}
                      onChange={() => {
                          setSelectedOption(option.value);
                          setHasSubmitted(false); // Reset feedback on new selection
                          setIsExplanationExpanded(false); // Hide previous explanation until user reopens
                      }}
                      className="w-4 h-4 text-blue-600 border-gray-300 focus:ring-blue-500"
                    />
                </div>
                <div className="ml-3 text-lg text-gray-800">
                  {option.text}
                </div>
              </label>
            ))}
          </div>
        </fieldset>

        <div className="mt-8 space-y-6">
          {showStatus && selectedOption && (
            <div
              role="status"
              aria-live="polite"
              className={`rounded-lg border p-4 ${statusToneClasses}`}
            >
              <div className="flex items-center gap-3">
                <span className="text-2xl" aria-hidden="true">
                  {statusIcon}
                </span>
                <p className="text-xl font-semibold">
                  {isCorrectSelection ? "Correct!" : "Incorrect."}
                </p>
              </div>
              <p className="mt-2 text-sm">
                {isCorrectSelection
                  ? `You selected Option ${selectedOption}.`
                  : `Option ${selectedOption} is not correct. The right answer is Option ${question.correct_option}.`}
              </p>
            </div>
          )}

          <div className="rounded-lg border border-gray-200 bg-gray-50 p-4">
            <button
              type="button"
              className="flex w-full items-center justify-between text-left text-base font-semibold text-gray-900"
              aria-expanded={isExplanationExpanded}
              aria-controls={explanationId}
              onClick={() => setIsExplanationExpanded((prev) => !prev)}
            >
              <span>
                {isExplanationExpanded
                  ? "Hide Detailed Explanation / थप जानकारी बन्द गर्नुहोस्"
                  : "View Detailed Explanation / थप जानकारी हेर्नुहोस्"}
              </span>
              <span className="text-sm text-gray-500">
                {isExplanationExpanded ? "▲" : "▼"}
              </span>
            </button>
            <div
              id={explanationId}
              role="region"
              aria-live="polite"
              className={`mt-3 text-sm text-gray-700 ${isExplanationExpanded ? "block" : "hidden"}`}
            >
              <p>{question.explanation || "Explanation will appear here once provided."}</p>
            </div>
          </div>

          <div className="flex justify-between items-center">
            <Button 
              type="button" 
              variant="outline" 
              onClick={onPrevious} 
              disabled={isFirst}
              aria-label="Previous Question"
            >
              Previous
            </Button>

            {!hasSubmitted ? (
              <Button 
                type="submit" 
                disabled={!selectedOption}
                className="px-8"
                aria-label="Submit Answer"
              >
                Submit Answer
              </Button>
            ) : (
              <Button 
                type="button" 
                onClick={onNext} 
                disabled={isLast}
                className="px-8"
                aria-label={isLast ? "Finish Quiz" : "Next Question"}
              >
                {isLast ? "Finish" : "Next"}  
              </Button>
            )}
          </div>
        </div>
      </form>
    </div>
  );
}
