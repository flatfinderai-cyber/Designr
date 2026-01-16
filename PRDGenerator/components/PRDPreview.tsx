"use client";

import { CheckCircle } from "lucide-react";

interface PRDPreviewProps {
  answers: Record<string, string | string[]>;
}

export function PRDPreview({ answers }: PRDPreviewProps) {
  const featureGoal = answers.q1 || "Feature enhancement";
  const targetUser = answers.q2 || "Users";
  const primaryFunctionality = answers.q3 || "Core functionality not specified";
  const outOfScope = answers.q4 || "None specified";
  const qualityGates = answers.q5 || "pnpm";
  const browserVerification = answers.q6 === "yes";

  const getQualityGateCommand = (gate: string) => {
    switch (gate) {
      case "pnpm":
        return "pnpm typecheck && pnpm lint";
      case "npm":
        return "npm run typecheck && npm run lint";
      case "bun":
        return "bun run typecheck && bun run lint";
      default:
        return "pnpm typecheck && pnpm lint";
    }
  };

  const featureName = primaryFunctionality
    .split(" ")
    .slice(0, 3)
    .join("-")
    .toLowerCase()
    .replace(/[^a-z-]/g, "");

  return (
    <div className="bg-slate-800 rounded-lg p-8 border border-slate-700 space-y-6">
      <div className="space-y-2">
        <h2 className="text-2xl font-bold text-white">Preview Your PRD</h2>
        <p className="text-slate-400">
          This PRD will be converted to prd.json and executed by Ralph-loop
        </p>
      </div>

      <div className="bg-slate-900 rounded-lg p-6 space-y-4 font-mono text-sm">
        <div>
          <span className="text-blue-400"># PRD: </span>
          <span className="text-white">{primaryFunctionality}</span>
        </div>

        <div className="space-y-2 mt-6">
          <div className="text-yellow-400">## Overview</div>
          <div className="text-slate-300 ml-4">
            <p>
              <span className="text-green-400">Goal:</span> {featureGoal}
            </p>
            <p>
              <span className="text-green-400">Target User:</span> {targetUser}
            </p>
          </div>
        </div>

        <div className="space-y-2 mt-6">
          <div className="text-yellow-400">## Quality Gates</div>
          <div className="text-slate-300 ml-4">
            <p>
              <span className="text-green-400">Commands:</span>{" "}
              {getQualityGateCommand(qualityGates as string)}
            </p>
            {browserVerification && (
              <p>
                <span className="text-green-400">UI Stories:</span> Verify in
                browser using dev-browser skill
              </p>
            )}
          </div>
        </div>

        <div className="space-y-2 mt-6">
          <div className="text-yellow-400">## Scope</div>
          <div className="text-slate-300 ml-4">
            <p>
              <span className="text-green-400">Included:</span>{" "}
              {primaryFunctionality}
            </p>
            <p>
              <span className="text-green-400">Out of Scope:</span>{" "}
              {outOfScope}
            </p>
          </div>
        </div>
      </div>

      <div className="bg-green-900/20 border border-green-700/50 rounded-lg p-4 space-y-2">
        <div className="flex items-start gap-3">
          <CheckCircle className="text-green-400 mt-1 flex-shrink-0" size={20} />
          <div>
            <p className="font-semibold text-green-300">Ready for Ralph-loop</p>
            <p className="text-sm text-green-200/80">
              This PRD will be saved as <code>prd-{featureName}.json</code> and
              ready for autonomous execution
            </p>
          </div>
        </div>
      </div>
    </div>
  );
}
