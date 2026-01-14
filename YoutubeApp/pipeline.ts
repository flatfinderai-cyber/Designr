import type { PipelineResult, VideoInput, SketchDescription } from "../types/index.js";
import { getVideoData, extractVideoId } from "./youtube.js";
import {
  analyzeEducationalContent,
  generateStepByStepLesson,
  generateSketches,
  createVideoPlan,
  generateWebpage,
  generatePatentWarning
} from "./ai.js";

export interface PipelineOptions {
  skipPatentWarning?: boolean;
  skipSketches?: boolean;
  skipVideoPlan?: boolean;
  skipWebpage?: boolean;
}

// Main pipeline: processes YouTube URL through all steps
export async function runPipeline(
  videoUrl: string,
  options: PipelineOptions = {}
): Promise<PipelineResult> {
  const startTime = Date.now();
  
  // Step 0: Parse input
  const videoId = extractVideoId(videoUrl);
  const input: VideoInput = { url: videoUrl, videoId };
  
  console.log("\n========================================");
  console.log("GUIDE ME - YouTube Tutorial Converter");
  console.log("========================================\n");
  console.log(`Processing: ${videoUrl}`);
  console.log(`Video ID: ${videoId}\n`);

  // Step 1: Extract video transcript
  console.log("Step 1/7: Extracting video transcript...");
  const transcript = await getVideoData(videoUrl);
  console.log(`  ✓ Got transcript: ${transcript.segments.length} segments`);
  console.log(`  ✓ Title: ${transcript.title}\n`);

  // Step 2: Analyze educational content
  console.log("Step 2/7: Analyzing educational content...");
  const analysis = await analyzeEducationalContent(transcript);
  console.log(`  ✓ Topic: ${analysis.topic}`);
  console.log(`  ✓ Difficulty: ${analysis.difficulty}`);
  console.log(`  ✓ Key concepts: ${analysis.keyConcepts.length}\n`);

  // Step 3: Generate step-by-step lesson
  console.log("Step 3/7: Generating textbook lesson...");
  const lesson = await generateStepByStepLesson(transcript, analysis);
  console.log(`  ✓ Lesson: ${lesson.title}`);
  console.log(`  ✓ Sections: ${lesson.sections.length}`);
  console.log(`  ✓ Comprehension checks: ${lesson.comprehensionChecks.length}\n`);

  // Step 4: Generate patent warning (can run in parallel)
  let patentWarning;
  if (!options.skipPatentWarning) {
    console.log("Step 4/7: Checking for IP concerns...");
    patentWarning = await generatePatentWarning(transcript, lesson);
    console.log(`  ✓ IP concerns: ${patentWarning.hasIPConcerns ? "Yes" : "None"}\n`);
  } else {
    console.log("Step 4/7: Skipping patent warning\n");
    patentWarning = {
      hasIPConcerns: false,
      warnings: [],
      recommendations: [],
      disclaimerText: "Content derived from publicly available educational material."
    };
  }

  // Step 5: Generate handdrawn sketches
  let sketches: SketchDescription[] = [];
  if (!options.skipSketches) {
    console.log("Step 5/7: Generating sketch descriptions...");
    sketches = await generateSketches(lesson, analysis);
    console.log(`  ✓ Sketches: ${sketches.length}\n`);
  } else {
    console.log("Step 5/7: Skipping sketches\n");
    sketches = [];
  }

  // Step 6: Create tutorial video plan
  let videoPlan;
  if (!options.skipVideoPlan) {
    console.log("Step 6/7: Creating video production plan...");
    videoPlan = await createVideoPlan(lesson, analysis);
    console.log(`  ✓ Video: ${videoPlan.title}`);
    console.log(`  ✓ Shots: ${videoPlan.shots.length}`);
    console.log(`  ✓ Duration: ${videoPlan.totalDuration}\n`);
  } else {
    console.log("Step 6/7: Skipping video plan\n");
    videoPlan = {
      title: lesson.title,
      totalDuration: "0:00",
      targetAudience: analysis.targetAudience,
      shots: [],
      bRoll: [],
      musicNotes: ""
    };
  }

  // Step 7: Generate webpage content
  let webpage;
  if (!options.skipWebpage) {
    console.log("Step 7/7: Generating webpage content...");
    webpage = await generateWebpage(lesson, analysis, videoId);
    console.log(`  ✓ Page title: ${webpage.pageTitle}\n`);
  } else {
    console.log("Step 7/7: Skipping webpage\n");
    webpage = {
      pageTitle: lesson.title,
      metaDescription: "",
      heroSection: { headline: "", subheadline: "", ctaText: "" },
      lessonPreview: "",
      videoEmbed: "",
      downloadLinks: { lesson: "", videoPlan: "" },
      relatedTopics: []
    };
  }

  const elapsed = ((Date.now() - startTime) / 1000).toFixed(1);
  console.log("========================================");
  console.log(`✓ Pipeline complete in ${elapsed}s`);
  console.log("========================================\n");

  return {
    input,
    transcript,
    analysis,
    lesson,
    videoPlan,
    sketches,
    webpage,
    patentWarning,
    processedAt: new Date().toISOString()
  };
}

// Export individual steps for granular control
export {
  getVideoData,
  analyzeEducationalContent,
  generateStepByStepLesson,
  generateSketches,
  createVideoPlan,
  generateWebpage,
  generatePatentWarning
};
