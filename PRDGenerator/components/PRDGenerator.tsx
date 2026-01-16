"use client";

import React, { useState } from "react";
import { QuestionSet } from "./QuestionSet";
import { PRDPreview } from "./PRDPreview";
import { usePRDStore } from "@/lib/store";
import { ChevronRight, Download } from "lucide-react";

const QUESTION_SETS = [
  {
    id: 1,
    title: "Feature Overview",
    questions: [
      {
        id: "q1",
        text: "What is the primary goal of this feature?",
        options: [
          { label: "Improve user onboarding experience", value: "onboarding" },
          { label: "Increase user retention", value: "retention" },
          { label: "Reduce support burden", value: "support" },
          { label: "Other - specify below", value: "other" },
        ],
      },
      {
        id: "q2",
        text: "Who is the target user?",
        options: [
          { label: "New users only", value: "new" },
          { label: "Existing users only", value: "existing" },
          { label: "All users", value: "all" },
          { label: "Admin users only", value: "admin" },
        ],
      },
    ],
  },
  {
    id: 2,
    title: "Scope & Requirements",
    questions: [
      {
        id: "q3",
        text: "What is the primary functionality needed?",
        isOpen: true,
        placeholder: "Describe the main action users will take...",
      },
      {
        id: "q4",
        text: "What should this feature NOT do?",
        isOpen: true,
        placeholder: "List out-of-scope items to keep the feature focused...",
      },
    ],
  },
  {
    id: 3,
    title: "Quality Gates (CRITICAL)",
    questions: [
      {
        id: "q5",
        text: "What quality commands must pass for every story?",
        options: [
          { label: "pnpm typecheck && pnpm lint", value: "pnpm" },
          { label: "npm run typecheck && npm run lint", value: "npm" },
          { label: "bun run typecheck && bun run lint", value: "bun" },
          { label: "Other - specify below", value: "other" },
        ],
      },
      {
        id: "q6",
        text: "For UI stories, include browser verification?",
        options: [
          { label: "Yes, use dev-browser skill to verify visually", value: "yes" },
          { label: "No, automated tests are sufficient", value: "no" },
        ],
      },
    ],
  },
];

export function PRDGenerator() {
  const [currentSet, setCurrentSet] = useState(0);
  const [answers, setAnswers] = useState<Record<string, string | string[]>>({});
  const [showPreview, setShowPreview] = useState(false);
  const { prd, setPRD } = usePRDStore();

  const handleAnswer = (questionId: string, value: string | string[]) => {
    setAnswers((prev) => ({
      ...prev,
      [questionId]: value,
    }));
  };

  const handleNext = () => {
    if (currentSet < QUESTION_SETS.length - 1) {
      setCurrentSet(currentSet + 1);
    } else {
      setShowPreview(true);
    }
  };

  const handleBack = () => {
    if (currentSet > 0) {
      setCurrentSet(currentSet - 1);
    }
  };

  const handleDownload = () => {
    if (prd) {
      const dataStr = JSON.stringify(prd, null, 2);
      const dataBlob = new Blob([dataStr], { type: "application/json" });
      const url = URL.createObjectURL(dataBlob);
      const link = document.createElement("a");
      link.href = url;
      link.download = `prd-${prd.branchName}.json`;
      link.click();
    }
  };

  if (showPreview) {
    return (
      <div className="space-y-6">
        <PRDPreview answers={answers} />
        <div className="flex gap-3 justify-center">
          <button
            onClick={() => setShowPreview(false)}
            className="px-6 py-3 bg-slate-700 hover:bg-slate-600 text-white rounded-lg transition"
          >
            Edit Answers
          </button>
          <button
            onClick={handleDownload}
            className="px-6 py-3 bg-blue-600 hover:bg-blue-500 text-white rounded-lg flex items-center gap-2 transition"
          >
            <Download size={20} />
            Download PRD.json
          </button>
        </div>
      </div>
    );
  }

  const currentQuestionSet = QUESTION_SETS[currentSet];

  return (
    <div className="space-y-8">
      <div className="bg-slate-800 rounded-lg p-8 border border-slate-700">
        <div className="space-y-3 mb-8">
          <h2 className="text-2xl font-bold text-white">
            {currentQuestionSet.title}
          </h2>
          <div className="flex gap-2">
            {QUESTION_SETS.map((set, idx) => (
              <div
                key={set.id}
                className={`h-2 flex-1 rounded-full transition ${
                  idx <= currentSet ? "bg-blue-500" : "bg-slate-700"
                }`}
              />
            ))}
          </div>
          <p className="text-sm text-slate-400">
            Step {currentSet + 1} of {QUESTION_SETS.length}
          </p>
        </div>

        <div className="space-y-6">
          {currentQuestionSet.questions.map((question) => (
            <QuestionSet
              key={question.id}
              question={question}
              value={answers[question.id]}
              onChange={(value) => handleAnswer(question.id, value)}
            />
          ))}
        </div>

        <div className="flex gap-3 mt-8 justify-between">
          <button
            onClick={handleBack}
            disabled={currentSet === 0}
            className="px-6 py-3 bg-slate-700 hover:bg-slate-600 text-white rounded-lg transition disabled:opacity-50 disabled:cursor-not-allowed"
          >
            Back
          </button>
          <button
            onClick={handleNext}
            className="px-6 py-3 bg-blue-600 hover:bg-blue-500 text-white rounded-lg flex items-center gap-2 transition"
          >
            {currentSet === QUESTION_SETS.length - 1 ? "Generate PRD" : "Next"}
            <ChevronRight size={20} />
          </button>
        </div>
      </div>
    </div>
  );
}
