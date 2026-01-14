# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Designr is an automated invention and development system that uses Ralph Wiggum iterative loops to build digital inventions and automate complex dev tool setups 10x faster than manual development.

**Core Concept:** You specify what to build, Ralph builds/tests/fixes/iterates automatically, you review the completed prototype.

## Project Structure

```
Designr/
├── inventions/          # Digital invention automation system
│   ├── scripts/         # Creation and build scripts
│   ├── active/          # Inventions currently being built
│   ├── ideas/           # Future invention ideas
│   ├── completed/       # Finished prototypes
│   └── templates/       # Reusable invention specs
│
├── automation/          # Dev tool setup automation
│   ├── scripts/         # Utility scripts (Claude Code setup, etc.)
│   ├── workflows/       # Setup workflow specifications
│   └── templates/       # Workflow templates
│
├── src/                 # Project source code
└── .claude/             # Claude configuration and Ralph loop state
```

## Common Commands

### Building Inventions

```bash
# Create a new invention specification
./inventions/scripts/new-invention.sh <name>

# Build an invention with Ralph
./inventions/scripts/start-invention.sh <name>

# Try the example invention
./inventions/scripts/start-invention.sh example-smart-clipboard
```

### Automating Dev Tool Setups

```bash
# Create a setup workflow
./automation/quick-start.sh <tool-name>

# Execute a setup workflow with Ralph
./automation/start-ralph.sh <tool-name>

# Install Claude Code
./automation/scripts/setup-claude-code.sh
```

### Monitoring Ralph Loops

```bash
# Check current iteration
grep '^iteration:' .claude/ralph-loop.local.md

# View Ralph's current task
tail -50 .claude/ralph-loop.local.md

# Cancel the loop
rm .claude/ralph-loop.local.md  # or use /cancel-ralph command
```

## Ralph Wiggum Loop System

### How It Works

Ralph is an iterative AI automation system controlled by `.claude/ralph-loop.local.md`:

```markdown
---
active: true
iteration: 1
max_iterations: 20
completion_promise: "TASK COMPLETE"
started_at: "2026-01-11T22:00:00Z"
---

Task description that Ralph will execute iteratively.
Output <promise>TASK COMPLETE</promise> when done.
```

Ralph will:
1. Read the task specification
2. Execute build/setup steps
3. Test and verify each step
4. Debug and fix failures automatically
5. Iterate until complete or max_iterations reached
6. Output the completion promise when done

### Creating Ralph Loops

**For Inventions:** Use `./inventions/scripts/start-invention.sh <name>` - this creates the Ralph loop automatically from your invention spec.

**For Setups:** Use `./automation/start-ralph.sh <tool-name>` - creates loop from your setup workflow.

**Manual:** Create `.claude/ralph-loop.local.md` using `ralph-setup-template.md` as reference.

## Architecture Patterns

### Invention System Architecture

1. **Specification Files** (`inventions/active/*.md`): YAML frontmatter + detailed problem/solution/build steps
2. **Creation Scripts** (`inventions/scripts/new-invention.sh`): Interactive script to generate specs
3. **Build Scripts** (`inventions/scripts/start-invention.sh`): Converts specs into Ralph loops
4. **Ralph Loop Execution**: Reads spec, builds iteratively, handles errors, completes when done

### Automation System Architecture

1. **Workflow Files** (`automation/workflows/*.md`): Step-by-step installation instructions
2. **Quick-start Script** (`automation/quick-start.sh`): Creates workflow templates
3. **Ralph Executor** (`automation/start-ralph.sh`): Converts workflows into Ralph loops
4. **Verification**: Each step includes verification commands to ensure success

### File Organization Pattern

```
ideas/          → Capture quick notes for future work
active/         → Currently building (3-10 items)
completed/      → Finished and verified
templates/      → Reusable patterns for common types
```

This progression supports building multiple inventions/setups in parallel.

## Important Development Notes

### Permissions Configuration

Auto-accept permissions are enabled in `.claude/settings.local.json`:
- `defaultMode: "bypassPermissions"` - no permission prompts
- Allows all essential tools and Ralph plugin operations
- Both global (~/.claude/settings.json) and project settings configured

### Invention Specification Format

Invention specs (`inventions/active/*.md`) must include:
- YAML frontmatter: name, type, category, language
- Problem statement
- Solution description
- Specific build steps with verification
- Success criteria
- Completion promise phrase

**Critical:** Build steps must be specific and verifiable. Vague instructions ("build the thing") won't work.

### Automation Workflow Format

Setup workflows (`automation/workflows/*.md`) must include:
- YAML frontmatter: tool_name, purpose, platform
- Step-by-step installation commands
- Verification after each step
- Success criteria checklist
- Completion promise

### Success Criteria

**For Inventions:**
- Set realistic max_iterations (15-30 for complex projects)
- Include verification after each build step
- Define clear completion promise
- Be specific about what "working" means

**For Automation:**
- Paste exact installation commands from docs
- Add verification commands (version checks, etc.)
- Test with simple setups first, then complex ones

### Common Pitfalls to Avoid

1. **Vague specifications** - Ralph needs specific, actionable steps
2. **Missing verification** - How does Ralph know if a step succeeded?
3. **Low max_iterations** - Complex tasks need 20-30+ iterations
4. **No completion promise** - Ralph will loop forever
5. **Mixing concerns** - One invention/setup per specification file

## Technology Stack

- **Languages:** TypeScript (planned project code), Python (examples), Bash (automation)
- **Automation:** Ralph Wiggum loop system (Claude Code plugin)
- **Tools:** Serena (code intelligence), Claude Code CLI
- **Package Manager:** npm (package.json configured but minimal setup)

## Parallel Development

The system supports building multiple inventions simultaneously:
- Each invention/setup runs in its own Ralph loop
- Open multiple terminals and start multiple inventions
- Ralph handles each independently
- No shared state between parallel builds

## Performance Expectations

Traditional manual development: 2-3 prototypes/week, 3-5 hours each
With Ralph automation: 10-20 prototypes/week, 30 minutes each
**Result: 10x productivity increase**

The bottleneck shifts from "building" to "choosing what to build."
