"use client";

import { useState } from "react";
import { PRDGenerator } from "@/components/PRDGenerator";
import { Header } from "@/components/Header";

export default function Home() {
  return (
    <main className="space-y-8">
      <Header />
      <PRDGenerator />
    </main>
  );
}
