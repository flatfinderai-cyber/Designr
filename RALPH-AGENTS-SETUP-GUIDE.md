# Complete Setup Guide: AGENTS.md + Ralph Plugin for Zero-Intervention Development

## Overview

This guide provides the complete requirements and steps to properly set up both AGENTS.md and the Ralph Wiggum plugin system for building applications with zero human intervention.

---

## Part 1: Understanding the System

### What is AGENTS.md?

AGENTS.md is a **README for AI agents** - a standardized file that provides context and instructions for AI coding agents. It contains:
- Build and test commands
- Code style guidelines
- Development environment setup
- Testing instructions
- Security considerations
- Project-specific workflows

**Key Point:** Agents automatically read AGENTS.md to understand how to work with your project.

### What is Ralph Wiggum?

Ralph is an **iterative AI automation technique** that builds software through:
1. Reading task specifications
2. Implementing one thing per loop
3. Testing and validating
4. Debugging and fixing automatically
5. Iterating until complete

**Core Formula:** `while :; do cat PROMPT.md | claude-code ; done`

---

## Part 2: System Requirements

### Directory Structure Required

```
your-project/
├── AGENTS.md                    # Instructions for AI agents
├── .claude/
│   ├── ralph-loop.local.md      # Ralph loop control file
│   └── settings.local.json      # Auto-accept permissions
├── specs/                       # Detailed specifications
│   ├── PROJECT_SPEC.md
│   └── stdlib/                  # Standard library specs (if applicable)
├── fix_plan.md                  # TODO list for Ralph
├── src/                         # Source code
├── tests/                       # Test files
└── README.md                    # Human-readable documentation
```

### File Purpose Summary

| File | Purpose | Updated By |
|------|---------|------------|
| AGENTS.md | Instructions for how to build, test, run | Ralph (self-improving) |
| .claude/ralph-loop.local.md | Loop control and current task | You (to start), Ralph (iteration counter) |
| specs/*.md | Detailed requirements and specifications | You (initial), Ralph (refinements) |
| fix_plan.md | Prioritized TODO list | Ralph (continuously) |
| src/ | Implementation code | Ralph |
| tests/ | Test suite | Ralph |

---

## Part 3: AGENTS.md Setup

### Step 1: Create AGENTS.md Structure

```markdown
# AGENTS.md

## Project Overview
[Brief description of what this project does]

## Setup Commands

### Initial Setup
- Install dependencies: `[your-package-manager] install`
- Initialize database: `[command if applicable]`
- Set up environment: `cp .env.example .env`

### Development
- Start dev server: `[your-dev-command]`
- Watch mode: `[your-watch-command]`
- Hot reload: `[if applicable]`

### Testing
- Run all tests: `[your-test-command]`
- Run specific test: `[command for single test]`
- Run with coverage: `[coverage command]`
- Test watch mode: `[if applicable]`

### Build
- Build for production: `[build command]`
- Build for development: `[dev build command]`
- Check build output: `[verification command]`

### Linting & Formatting
- Lint code: `[lint command]`
- Format code: `[format command]`
- Type check: `[type-check command]`

## Code Style Guidelines

### Language-Specific Rules
- [e.g., TypeScript strict mode enabled]
- [e.g., Use functional patterns where possible]
- [e.g., Single quotes, no semicolons]

### Naming Conventions
- Files: `[convention]`
- Functions: `[convention]`
- Variables: `[convention]`
- Constants: `[convention]`

### Architecture Patterns
- [e.g., Use dependency injection]
- [e.g., Prefer composition over inheritance]
- [e.g., Keep functions pure when possible]

## Testing Requirements

### Test Coverage
- Minimum coverage: [e.g., 80%]
- Required for: [e.g., all new features, bug fixes]

### Test Patterns
- Unit tests: `tests/unit/[module].test.[ext]`
- Integration tests: `tests/integration/[feature].test.[ext]`
- E2E tests: `tests/e2e/[scenario].test.[ext]`

### Test Quality
- Each test should have clear description
- Tests should be isolated and repeatable
- Mock external dependencies
- Document why tests are important (not just what they test)

## Development Workflow

### Before Making Changes
1. Search codebase to verify code doesn't already exist
2. Check fix_plan.md for related tasks
3. Read relevant specs in specs/ directory

### After Making Changes
1. Run tests for modified code
2. Run full test suite
3. Run linter and fix any issues
4. Update fix_plan.md if discovering new issues
5. Update AGENTS.md if learning new workflow steps

### Commit Guidelines
- Format: `[type]: [description]`
- Types: feat, fix, docs, refactor, test, chore
- Run all tests before committing
- Update fix_plan.md before committing

## Project-Specific Notes

### Back Pressure (Quality Gates)
- Tests must pass
- [e.g., Type checker must pass]
- [e.g., Linter must pass]
- [e.g., Security scanner must pass]
- [e.g., Build must succeed]

### Important Constraints
- DO NOT implement placeholder/minimal implementations
- DO NOT skip tests
- DO NOT assume code isn't implemented - search first
- DO add logging when needed for debugging
- DO resolve unrelated test failures you discover

### Standard Library / Patterns
[Location of your standard patterns, e.g., src/stdlib/ or docs/patterns/]
- Use patterns from [location] for consistency
- Follow examples in [location]

## Security Considerations
- [List any security-specific requirements]
- [e.g., Never commit API keys]
- [e.g., Sanitize all user input]
- [e.g., Use prepared statements for database]

## Performance Requirements
- [Any performance benchmarks or requirements]
- [e.g., API responses < 200ms]
- [e.g., Page load < 2s]

## Documentation Requirements
- Document WHY, not just WHAT
- Capture importance of tests when writing them
- Update specs/ when discovering requirements issues
- Keep AGENTS.md updated with learnings
```

### Step 2: Customize for Your Project

Replace all `[placeholders]` with your actual commands and requirements.

**Critical Sections to Complete:**
1. **Setup Commands** - Must be exact commands that work
2. **Testing** - Must include how to run single tests
3. **Code Style** - Must match your language/framework
4. **Back Pressure** - Must include all quality gates

---

## Part 4: Ralph Loop Setup

### Step 1: Create Specifications

Create `specs/` directory and write detailed specifications:

```bash
mkdir -p specs/stdlib
```

**Example: specs/PROJECT_SPEC.md**

```markdown
# Project Specification: [Your Project Name]

## Purpose
[What problem does this solve?]

## Core Features
1. [Feature 1]
   - Description: [detailed description]
   - Requirements: [specific requirements]
   - Success criteria: [how to verify it works]

2. [Feature 2]
   - Description: [detailed description]
   - Requirements: [specific requirements]
   - Success criteria: [how to verify it works]

## Technical Architecture

### Tech Stack
- Language: [e.g., TypeScript, Python, Rust]
- Framework: [e.g., React, FastAPI, Actix]
- Database: [if applicable]
- Testing: [test framework]

### Project Structure
```
src/
├── core/          # Core business logic
├── api/           # API layer (if applicable)
├── utils/         # Utility functions
└── types/         # Type definitions
```

### Data Models
[Define your data structures]

### API Endpoints (if applicable)
[Define your API]

## Implementation Guidelines

### Phase 1: Foundation
- Set up project structure
- Configure build system
- Set up testing framework
- Implement basic utilities

### Phase 2: Core Features
[Break down into specific, verifiable steps]

### Phase 3: Testing & Validation
- Write comprehensive tests
- Add integration tests
- Verify all success criteria

## Success Criteria
- [ ] All tests pass
- [ ] [Specific criterion 1]
- [ ] [Specific criterion 2]
- [ ] Application builds without errors
- [ ] [Performance requirements met]

## Known Constraints
[Any limitations or constraints]
```

### Step 2: Create fix_plan.md Template

```bash
cat > fix_plan.md << 'EOF'
# Fix Plan / TODO List

This file is continuously updated by Ralph with items to implement.

## Current Priority

### High Priority
- [ ] [Will be filled by Ralph]

### Medium Priority
- [ ] [Will be filled by Ralph]

### Low Priority
- [ ] [Will be filled by Ralph]

## Completed
- [x] [Completed items moved here by Ralph]

## Notes
- This file is managed by Ralph
- Items are sorted by priority
- Completed items are moved to bottom
- File is cleaned periodically when it grows large
EOF
```

### Step 3: Create Ralph Loop Control File

```bash
mkdir -p .claude
cat > .claude/ralph-loop.local.md << 'EOF'
---
active: true
iteration: 1
max_iterations: 30
completion_promise: "PROJECT COMPLETE"
started_at: "2026-01-13T00:00:00Z"
---

## Ralph Loop Task

0a. Study @specs/* to learn about the project specifications
0b. Study @AGENTS.md to learn how to build and test the project
0c. Study @fix_plan.md to understand current TODO list

1. Your task is to implement the project as specified in @specs/* using parallel subagents. Follow @fix_plan.md and choose the most important thing to implement. Before making changes, search codebase (don't assume not implemented) using subagents. You may use up to 50 parallel subagents for all operations but only 1 subagent for build/tests.

2. After implementing functionality or resolving problems, run the tests for that unit of code that was improved. If functionality is missing then it's your job to add it as per the application specifications. Think hard.

3. When you discover bugs or issues, immediately update @fix_plan.md with your findings using a subagent. When the issue is resolved, update @fix_plan.md and remove the item using a subagent.

4. When the tests pass, update @fix_plan.md, then add changed code and @fix_plan.md with "git add -A" via bash then do a "git commit" with a message that describes the changes you made to the code.

999. Important: When authoring documentation (code comments, docstrings) capture the WHY tests and the backing implementation is important.

9999. Important: We want single sources of truth. If tests unrelated to your work fail then it's your job to resolve these tests as part of the increment of change.

99999. You may add extra logging if required to be able to debug the issues.

999999. ALWAYS KEEP @fix_plan.md up to date with your learnings using a subagent. Especially after wrapping up/finishing your turn.

9999999. When you learn something new about how to run the project make sure you update @AGENTS.md using a subagent but keep it brief.

99999999. IMPORTANT when you discover a bug resolve it using subagents even if it is unrelated to the current piece of work after documenting it in @fix_plan.md

999999999. DO NOT IMPLEMENT PLACEHOLDER OR SIMPLE IMPLEMENTATIONS. WE WANT FULL IMPLEMENTATIONS. DO IT OR I WILL YELL AT YOU

9999999999. When @fix_plan.md becomes large periodically clean out the items that are completed from the file using a subagent.

99999999999. Output <promise>PROJECT COMPLETE</promise> when all specs are implemented, all tests pass, and the project is fully functional.
EOF
```

### Step 4: Verify Permissions

Ensure `.claude/settings.local.json` has auto-accept enabled:

```json
{
  "permissions": {
    "defaultMode": "bypassPermissions"
  }
}
```

---

## Part 5: Creating Your First Zero-Intervention App

### Recommended First Project: Simple CLI Tool

**Why?** CLI tools are:
- Self-contained
- Easy to test
- Fast build cycles (good for Ralph loops)
- Clear success criteria

### Example: Task Manager CLI

**Step 1: Write the Specification**

Create `specs/TASK_MANAGER_SPEC.md`:

```markdown
# Task Manager CLI Specification

## Purpose
A command-line task manager that allows users to add, list, complete, and delete tasks.

## Core Features

### 1. Add Task
- Command: `task add "task description"`
- Stores task with unique ID
- Marks as incomplete by default
- Success: Task added and ID returned

### 2. List Tasks
- Command: `task list`
- Shows all tasks with ID, status, description
- Success: All tasks displayed correctly

### 3. Complete Task
- Command: `task complete <id>`
- Marks task as complete
- Success: Task status updated

### 4. Delete Task
- Command: `task delete <id>`
- Removes task from storage
- Success: Task removed

### 5. Persistent Storage
- Tasks saved to local file (JSON or SQLite)
- Survives program restarts
- Success: Data persists between runs

## Technical Specification

### Language
Python 3.9+ (or your choice: Node.js, Rust, Go)

### Dependencies
- Click (CLI framework) or argparse
- JSON or SQLite for storage
- pytest for testing

### Project Structure
```
task-manager/
├── src/
│   ├── cli.py           # CLI interface
│   ├── storage.py       # Data persistence
│   ├── task.py          # Task model
│   └── manager.py       # Business logic
├── tests/
│   ├── test_cli.py
│   ├── test_storage.py
│   ├── test_task.py
│   └── test_manager.py
├── AGENTS.md
├── specs/
│   └── TASK_MANAGER_SPEC.md
├── fix_plan.md
├── requirements.txt
└── setup.py
```

## Implementation Steps

### Phase 1: Foundation (Iterations 1-5)
1. Set up Python project structure
2. Create virtual environment
3. Install dependencies (click, pytest)
4. Create Task model class
5. Write tests for Task model

### Phase 2: Storage (Iterations 6-10)
1. Implement JSON storage class
2. Add save method
3. Add load method
4. Write storage tests
5. Verify persistence works

### Phase 3: Business Logic (Iterations 11-20)
1. Implement TaskManager class
2. Add add_task method
3. Add list_tasks method
4. Add complete_task method
5. Add delete_task method
6. Write comprehensive tests for each method
7. Verify all business logic

### Phase 4: CLI Interface (Iterations 21-28)
1. Set up Click CLI framework
2. Implement 'add' command
3. Implement 'list' command
4. Implement 'complete' command
5. Implement 'delete' command
6. Add error handling
7. Write CLI tests
8. Verify end-to-end functionality

### Phase 5: Polish (Iterations 29-30)
1. Add color output
2. Add help text
3. Final testing
4. Create README

## Success Criteria
- [ ] All commands work as specified
- [ ] Tasks persist between runs
- [ ] All tests pass (>80% coverage)
- [ ] No errors on standard operations
- [ ] Handles edge cases (invalid IDs, empty lists)
- [ ] Help text is clear
- [ ] Code is documented

## Testing Requirements

### Unit Tests
- Task model creation and properties
- Storage save/load operations
- Manager business logic methods
- Each CLI command

### Integration Tests
- Full workflow: add → list → complete → delete
- Persistence across program restarts
- Error handling for invalid inputs

### Acceptance Tests
```bash
# Should work:
task add "Buy groceries"
task add "Walk the dog"
task list
task complete 1
task list
task delete 2
task list
```

## Completion Promise
Output <promise>TASK MANAGER COMPLETE</promise> when all features implemented and all tests pass.
```

**Step 2: Create AGENTS.md for the Project**

Create project-specific `AGENTS.md`:

```markdown
# AGENTS.md - Task Manager CLI

## Project Overview
A Python CLI tool for managing tasks with persistent storage.

## Setup Commands

### Initial Setup
```bash
python3 -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
pip install -r requirements.txt
pip install -e .
```

### Development
```bash
# Run the CLI
task --help
task add "test task"
task list

# Watch mode for development
pytest-watch
```

### Testing
```bash
# Run all tests
pytest

# Run specific test file
pytest tests/test_cli.py

# Run specific test
pytest tests/test_cli.py::test_add_task

# Run with coverage
pytest --cov=src --cov-report=html
```

### Build
```bash
# Install in development mode
pip install -e .

# Build distribution
python setup.py sdist bdist_wheel
```

### Linting & Formatting
```bash
# Format code
black src/ tests/

# Lint code
flake8 src/ tests/

# Type check
mypy src/
```

## Code Style Guidelines

### Python Style
- Follow PEP 8
- Use type hints (Python 3.9+)
- Black formatter (line length 88)
- Use descriptive variable names
- Docstrings for all public methods

### Architecture Patterns
- Separate CLI, business logic, and storage
- Dependency injection for testability
- Pure functions where possible
- Clear error messages

## Testing Requirements

### Test Coverage
- Minimum coverage: 80%
- Required for all new features

### Test Structure
- Unit tests for each module
- Integration tests for workflows
- Test both success and error cases

### Test Quality
- Each test has clear, descriptive name
- Tests are isolated (don't depend on each other)
- Mock file I/O in unit tests
- Document WHY tests are important in docstrings

## Development Workflow

### Before Making Changes
1. Search codebase to verify code doesn't exist
2. Check fix_plan.md for related work
3. Read specs/TASK_MANAGER_SPEC.md

### After Making Changes
1. Run tests for modified module: `pytest tests/test_[module].py`
2. Run full test suite: `pytest`
3. Run linter: `flake8 src/ tests/`
4. Run type checker: `mypy src/`
5. Update fix_plan.md with any discovered issues
6. Update AGENTS.md if learning new commands

### Commit Guidelines
- Format: `[type]: [description]`
- Types: feat, fix, docs, refactor, test
- Always run pytest before committing
- Update fix_plan.md in same commit

## Project-Specific Notes

### Back Pressure (Must Pass)
1. pytest (all tests pass)
2. flake8 (no linting errors)
3. mypy (type checking passes)
4. Black formatting check

### Important Constraints
- DO NOT use placeholder implementations
- DO NOT skip writing tests
- DO search before assuming code doesn't exist
- DO handle errors gracefully
- DO persist data correctly

### File Organization
- src/cli.py - Click commands only
- src/manager.py - Business logic only
- src/storage.py - File I/O only
- src/task.py - Data model only
- tests/ - Mirrors src/ structure

## Security Considerations
- Validate all user input
- Sanitize file paths
- Handle file permissions errors
- No arbitrary code execution

## Performance Requirements
- Commands respond in < 100ms for < 1000 tasks
- Startup time < 500ms
```

**Step 3: Initialize the Project**

```bash
# Create project directory
mkdir -p task-manager/{src,tests,specs}
cd task-manager

# Create initial files
touch src/__init__.py
touch tests/__init__.py

# Copy the AGENTS.md and spec files created above
# Copy the fix_plan.md template
# Copy the .claude/ralph-loop.local.md file

# Initialize git
git init
git add .
git commit -m "Initial project setup for Task Manager CLI"
```

**Step 4: Start Ralph**

You have two options:

**Option A: Manual Loop (Recommended for Learning)**
```bash
while :; do
    echo "=== Ralph Loop Iteration ==="
    claude-code
    sleep 2
done
```

**Option B: Using the Invention System**
```bash
# If using the Designr invention system
./inventions/scripts/start-invention.sh task-manager
```

---

## Part 6: Monitoring and Troubleshooting

### Monitoring Ralph's Progress

```bash
# Check current iteration
grep '^iteration:' .claude/ralph-loop.local.md

# See what Ralph is working on
tail -50 .claude/ralph-loop.local.md

# Watch the TODO list evolve
watch -n 5 cat fix_plan.md

# Check git commits (Ralph commits after each successful iteration)
git log --oneline
```

### Common Issues and Solutions

#### Ralph Gets Stuck in a Loop
**Symptom:** Same error repeated multiple times
**Solution:**
1. Check if max_iterations is too low
2. Add more specific instructions to ralph-loop.local.md
3. Update specs/ if requirements are unclear
4. Reset: `git reset --hard HEAD~5` and adjust approach

#### Ralph Makes Placeholder Implementations
**Symptom:** Comments like `# TODO: implement` or minimal functions
**Solution:**
1. Add to ralph-loop.local.md: `DO NOT IMPLEMENT PLACEHOLDER OR SIMPLE IMPLEMENTATIONS. WE WANT FULL IMPLEMENTATIONS.`
2. Increase urgency numbers: `9999999999. DO NOT USE PLACEHOLDERS`

#### Ralph Can't Find Existing Code
**Symptom:** Re-implementing things that exist
**Solution:**
1. Add to ralph-loop.local.md: `Before making changes search codebase (don't assume not implemented) using subagents`
2. Run a planning loop first to map existing code

#### Tests Keep Failing
**Symptom:** Same tests fail repeatedly
**Solution:**
1. Manually check if test expectations are correct
2. Add specific debugging instruction to ralph-loop.local.md
3. Tell Ralph to add logging: `Add detailed logging to debug test failures`

#### Context Window Full
**Symptom:** Ralph starts making unrelated changes
**Solution:**
1. Reduce to one item per loop
2. Use more subagents: `You may use up to 100 parallel subagents`
3. Clean up fix_plan.md: `Periodically clean completed items from @fix_plan.md`

---

## Part 7: Checklist for Zero-Intervention Success

### Before Starting Ralph

- [ ] AGENTS.md exists with exact build/test commands
- [ ] Specs are detailed and specific (not vague)
- [ ] Each feature has clear success criteria
- [ ] fix_plan.md template exists
- [ ] .claude/ralph-loop.local.md configured
- [ ] .claude/settings.local.json has auto-accept enabled
- [ ] Git repository initialized
- [ ] Initial project structure created
- [ ] Testing framework specified in AGENTS.md
- [ ] Back pressure (quality gates) defined

### During Ralph Execution

- [ ] Monitor iterations periodically
- [ ] Check git commits for progress
- [ ] Watch for repeated errors (indicates tuning needed)
- [ ] Verify tests are being written
- [ ] Check that fix_plan.md is being updated

### Signs of Success

- [ ] Git commits happening regularly
- [ ] Tests being added with each feature
- [ ] fix_plan.md shrinking over time
- [ ] No placeholder implementations
- [ ] AGENTS.md being updated with learnings
- [ ] All quality gates passing

### Red Flags

- [ ] Same error > 5 iterations
- [ ] No commits for > 10 iterations
- [ ] Placeholder implementations appearing
- [ ] Tests not being written
- [ ] fix_plan.md not updating

---

## Part 8: Advanced Ralph Techniques

### Using Planning Loops

Before building, run a planning loop:

```markdown
---
active: true
iteration: 1
max_iterations: 5
completion_promise: "PLANNING COMPLETE"
started_at: "2026-01-13T00:00:00Z"
---

Study @specs/* to learn about the project specifications.

Use up to 100 subagents to:
1. Analyze the specifications
2. Research similar projects for patterns
3. Create detailed @fix_plan.md with prioritized tasks
4. Update @AGENTS.md with build requirements

Output <promise>PLANNING COMPLETE</promise> when fix_plan.md is comprehensive.
```

### Tuning Ralph for Your Project

Add project-specific constraints to ralph-loop.local.md:

```markdown
# For web apps
999999. IMPORTANT: All API endpoints must have error handling
999999. IMPORTANT: All user input must be validated
999999. IMPORTANT: Use prepared statements for all database queries

# For CLI tools
999999. IMPORTANT: All commands must have --help text
999999. IMPORTANT: Exit codes must be correct (0 for success, 1 for error)

# For libraries
999999. IMPORTANT: All public functions must have docstrings
999999. IMPORTANT: All exports must be in __init__.py
999999. IMPORTANT: Breaking changes require major version bump
```

### Parallel Building

Run multiple Ralph loops for different modules:

```bash
# Terminal 1: Core features
cd project && cat .claude/ralph-loop-core.local.md | claude-code

# Terminal 2: CLI interface
cd project && cat .claude/ralph-loop-cli.local.md | claude-code

# Terminal 3: Tests
cd project && cat .claude/ralph-loop-tests.local.md | claude-code
```

---

## Summary: The Complete Flow

1. **Setup Phase** (One Time)
   - Create AGENTS.md with exact commands
   - Write detailed specs in specs/
   - Create fix_plan.md template
   - Configure .claude/ralph-loop.local.md
   - Enable auto-accept permissions

2. **Planning Phase** (Optional but Recommended)
   - Run planning Ralph loop
   - Generate comprehensive fix_plan.md
   - Verify specs completeness

3. **Building Phase** (Hands-Off)
   - Start Ralph loop
   - Ralph reads specs
   - Ralph implements one thing per loop
   - Ralph tests after each change
   - Ralph commits when tests pass
   - Ralph updates fix_plan.md
   - Ralph self-improves AGENTS.md

4. **Completion** (Automatic)
   - All specs implemented
   - All tests passing
   - Ralph outputs completion promise
   - Project ready to use

**Time Investment:**
- Setup: 30-60 minutes (one time)
- Per project: 15-30 minutes (mostly writing specs)
- Ralph building: 0 minutes of your time

**Result:** Working application with comprehensive tests, built with zero intervention.
