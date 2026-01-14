# Keep It Simple Stupid (KISS)

YouTube Tutorial → Textbook Lesson Converter

## Overview

Converts YouTube tutorial videos into:
1. **Textbook-style written lessons** with diagrams, exercises, and comprehension checks
2. **Video production plans** with shot-by-shot scripts and timing

Built for high-school students and adult beginners.

---

# Guide Me App

Convert YouTube tutorial videos into textbook-style lessons and video production plans.

## What It Does

Takes a YouTube URL → Outputs:
1. **Textbook Lesson** - High-school level written content with diagrams, exercises, comprehension checks
2. **Video Plan** - Shot-by-shot production guide with narration scripts
3. **Sketch Descriptions** - Hand-drawn diagram specifications for visual learners
4. **Webpage Content** - Landing page copy for the lesson
5. **Patent Warning** - IP concern analysis

## Pipeline Flow

```
Video URL
    ↓
Extract Transcript (YouTube API + scraping)
    ↓
Analyze Educational Content (Claude AI)
    ↓
Generate Step-by-step Lesson (Claude AI)
    ↓
┌───────────────────┬───────────────────┐
│                   │                   │
Generate Sketches   Create Video Plan   Generate Patent Warning
│                   │                   │
└───────────────────┴───────────────────┘
    ↓
Generate Webpage
    ↓
Output Files
```

## Setup

### 1. Install Dependencies

```bash
npm install
```

### 2. Set Environment Variables

```bash
export YOUTUBE_API_KEY="your-youtube-api-key"
export ANTHROPIC_API_KEY="your-anthropic-api-key"
```

Get YouTube API key: https://console.cloud.google.com/apis/credentials
Get Anthropic API key: https://console.anthropic.com/

### 3. Build

```bash
npm run build
```

## Usage

### CLI

```bash
# Process a video
npm run process "https://youtube.com/watch?v=VIDEO_ID"

# With options
npm run process "VIDEO_ID" --output-dir ./my-lesson --skip-sketches
```

### Programmatic

```typescript
import { runPipeline } from "guide-me-app";

const result = await runPipeline("https://youtube.com/watch?v=dQw4w9WgXcQ");

console.log(result.lesson.title);
console.log(result.videoPlan.shots.length);
```

## Output Files

After processing, you'll find in the output directory:

| File | Contents |
|------|----------|
| `*-full.json` | Complete pipeline result |
| `*-lesson.md` | Formatted lesson in Markdown |
| `*-video-plan.md` | Shot list and production notes |
| `*-sketches.json` | Diagram specifications |

## Options

| Flag | Description |
|------|-------------|
| `--output-dir <dir>` | Output directory (default: ./output) |
| `--skip-sketches` | Skip sketch generation |
| `--skip-video` | Skip video plan generation |
| `--skip-webpage` | Skip webpage generation |
| `--skip-patent` | Skip IP concern check |

## Project Structure

```
guide-me-app/
├── src/
│   ├── index.ts          # Main exports
│   ├── cli.ts            # Command-line interface
│   ├── types/            # TypeScript interfaces
│   ├── prompts/          # AI system prompts
│   └── services/
│       ├── youtube.ts    # YouTube data extraction
│       ├── ai.ts         # Claude API calls
│       └── pipeline.ts   # Orchestration
├── package.json
└── tsconfig.json
```

## Requirements

- Node.js 18+
- YouTube API key (for video metadata)
- Anthropic API key (for AI processing)

## License

MIT - © 2024-2025 Lila Inglis Abegunrin

Trademarks and Patents pending.
