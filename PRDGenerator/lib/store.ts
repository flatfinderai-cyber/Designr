import { create } from "zustand";

interface PRDData {
  project: string;
  branchName: string;
  description: string;
  qualityGates: string[];
  userStories: Array<{
    id: string;
    title: string;
    description: string;
    acceptanceCriteria: string[];
    priority: number;
    passes: boolean;
    dependsOn: string[];
  }>;
}

interface PRDStore {
  prd: PRDData | null;
  setPRD: (prd: PRDData) => void;
  clearPRD: () => void;
}

export const usePRDStore = create<PRDStore>((set) => ({
  prd: null,
  setPRD: (prd) => set({ prd }),
  clearPRD: () => set({ prd: null }),
}));
