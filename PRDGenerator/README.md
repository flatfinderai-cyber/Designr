# PRD Generator

**Interactive Q&A to create PRD.json for Ralph-loop automation**

## What This Is

A micro SaaS application that guides you through creating Product Requirements Documents (PRDs) optimized for AI agent execution. Instead of writing PRDs from scratch, answer guided questions and get a structured prd.json file ready for Ralph-loop.

## Features

✅ **Interactive Q&A Workflow** - Step-by-step questions with lettered options  
✅ **Quality Gates** - Mandatory specification of test/lint commands  
✅ **Adaptive Questions** - Follow-up questions based on your answers  
✅ **PRD Preview** - See your PRD before generating JSON  
✅ **JSON Export** - Download as prd.json ready for ralph-tui  

## Quick Start

```bash
# Install dependencies
pnpm install

# Run development server
pnpm dev

# Open http://localhost:3000
```

## The Process

1. **Answer Overview Questions** - Feature goal, target user
2. **Define Scope** - What's included, what's not
3. **Set Quality Gates** - What tests must pass (CRITICAL)
4. **Preview PRD** - Review generated structure
5. **Download JSON** - Get prd.json ready for Ralph-loop

## Quality Gates (The Most Important Part)

Quality gates are commands that must pass for every user story in your PRD. Examples:

- `pnpm typecheck && pnpm lint`
- `npm run typecheck && npm run lint`
- Browser verification for UI stories

Ralph-loop appends these to every story's acceptance criteria automatically.

## Output: prd.json

```json
{
  "project": "my-project",
  "branchName": "ralph/feature-name",
  "description": "Feature description",
  "userStories": [
    {
      "id": "US-001",
      "title": "Feature title",
      "description": "As a user, I want...",
      "acceptanceCriteria": [
        "Specific criterion",
        "pnpm typecheck passes",
        "pnpm lint passes"
      ],
      "priority": 1,
      "passes": false,
      "notes": "",
      "dependsOn": []
    }
  ]
}
```

## Run with Ralph-tui

After downloading prd.json:

```bash
ralph-tui run --prd ./prd.json
```

Ralph-loop will:
1. Load stories from your JSON
2. Execute one story per iteration
3. Run quality gates automatically
4. Mark stories complete when passing
5. Continue until all stories done

## Architecture

- **Next.js 14** - Server + client components
- **React 18** - Interactive UI
- **TypeScript** - Type safety
- **Tailwind CSS** - Styling
- **Zustand** - State management

## Files

- `app/page.tsx` - Main flow
- `components/PRDGenerator.tsx` - Q&A workflow
- `components/QuestionSet.tsx` - Individual questions
- `components/PRDPreview.tsx` - JSON preview
- `lib/store.ts` - State management
