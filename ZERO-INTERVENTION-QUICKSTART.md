# Zero-Intervention Development - Quick Start

## What You Now Have

A complete system for building applications with **ZERO human intervention** using:
1. **AGENTS.md** - Instructions for AI agents on how to work with your project
2. **Rube Goldberg** - Iterative AI loop that builds, tests, and fixes automatically
3. **Automated setup scripts** - One command to create new Rube Goldberg-powered projects

---

## Three Ways to Start

### Option 1: Use the Automated Setup Script (Fastest)

Create a new Rube Goldberg-powered project in one command:

```bash
# Syntax
./automation/scripts/setup-rube-goldberg-project.sh <name> <language> [type]

# Examples
./automation/scripts/setup-rube-goldberg-project.sh task-manager python cli-tool
./automation/scripts/setup-rube-goldberg-project.sh my-api typescript api
./automation/scripts/setup-rube-goldberg-project.sh blog-app javascript web-app
```

This creates a complete project with:
- ✅ AGENTS.md configured for your language
- ✅ specs/ directory with template
- ✅ fix_plan.md for Rube Goldberg's TODO tracking
- ✅ .claude/rube-goldberg-loop.local.md ready to run
- ✅ Auto-accept permissions enabled
- ✅ Git repository initialized
- ✅ Language-specific .gitignore

**Then:**
1. Edit `specs/PROJECT_SPEC.md` with your requirements (be specific!)
2. Update `AGENTS.md` with exact build/test commands
3. Run `claude-code` to start Rube Goldberg
4. Watch it build automatically

---

### Option 2: Use the Existing Invention System

Use the Designr invention workflow:

```bash
# Create invention
./inventions/scripts/new-invention.sh my-app

# Edit the specification (BE SPECIFIC!)
vim inventions/active/my-app.md

# Start Rube Goldberg
./inventions/scripts/start-invention.sh my-app

# Monitor progress
tail -f .claude/rube-goldberg-loop.local.md
```

---

### Option 3: Manual Setup (Learn the System)

Follow the complete guide: `RUBE_GOLDBERG-AGENTS-SETUP-GUIDE.md`

This teaches you every component and how they work together.

---

## Recommended First Project: Task Manager CLI

**Why?** Simple, self-contained, fast build cycles, clear success criteria.

### Using the Automated Script:

```bash
# 1. Create project
./automation/scripts/setup-rube-goldberg-project.sh task-manager python cli-tool

# 2. Navigate to project
cd ~/rube-goldberg-projects/task-manager

# 3. Edit the spec (THIS IS CRITICAL - BE SPECIFIC!)
vim specs/PROJECT_SPEC.md
```

**Edit the spec to include:**

```markdown
# Task Manager CLI Specification

## Purpose
A command-line task manager that allows users to add, list, complete, and delete tasks.

## Core Features

### 1. Add Task
- Command: `task add "task description"`
- Stores task with unique ID and timestamp
- Marks as incomplete by default
- Success: Task added, ID displayed to user

### 2. List Tasks
- Command: `task list`
- Shows: ID, status (✓ or ✗), description, created date
- Success: All tasks displayed in table format

### 3. Complete Task
- Command: `task complete <id>`
- Marks task as complete with completion timestamp
- Success: Task status updated, confirmation shown

### 4. Delete Task
- Command: `task delete <id>`
- Removes task permanently
- Success: Task removed, confirmation shown

### 5. Persistent Storage
- Tasks saved to JSON file: ~/.tasks.json
- Survives program restarts
- Success: Data persists between runs

## Technical Specification

### Language: Python 3.9+

### Dependencies
- Click (CLI framework)
- pytest (testing)
- pytest-cov (coverage)

### Project Structure
src/
├── cli.py           # Click commands
├── storage.py       # JSON file I/O
├── task.py          # Task data model
└── manager.py       # Business logic

tests/
├── test_cli.py
├── test_storage.py
├── test_task.py
└── test_manager.py

## Implementation Steps

### Phase 1: Foundation (Iterations 1-5)
1. Create Task class with: id, description, completed, created_at, completed_at
2. Write tests for Task class
3. Verify Task model works

### Phase 2: Storage (Iterations 6-10)
1. Create Storage class
2. Implement save_tasks(tasks) method - writes JSON
3. Implement load_tasks() method - reads JSON
4. Write comprehensive storage tests
5. Verify persistence works

### Phase 3: Business Logic (Iterations 11-20)
1. Create TaskManager class
2. Implement add_task(description) -> id
3. Implement list_tasks() -> List[Task]
4. Implement complete_task(id) -> bool
5. Implement delete_task(id) -> bool
6. Write tests for each method
7. Verify all business logic

### Phase 4: CLI (Iterations 21-28)
1. Set up Click framework
2. Implement 'task add <description>' command
3. Implement 'task list' command with table formatting
4. Implement 'task complete <id>' command
5. Implement 'task delete <id>' command
6. Add error handling for invalid IDs
7. Write CLI tests
8. Verify end-to-end

### Phase 5: Polish (Iterations 29-30)
1. Add colored output (green for complete, red for incomplete)
2. Add comprehensive help text
3. Final testing
4. Verify all success criteria

## Success Criteria
- [ ] All commands work as specified
- [ ] Tasks persist between program runs
- [ ] All tests pass with >80% coverage
- [ ] No errors on valid inputs
- [ ] Helpful errors on invalid inputs
- [ ] Help text is clear
- [ ] Code is well-documented

## Testing Requirements

### Unit Tests Required
- Task model: creation, properties, serialization
- Storage: save/load, file creation, JSON format
- Manager: all CRUD operations, edge cases
- CLI: command parsing, error handling

### Integration Tests Required
- Full workflow: add → list → complete → list → delete
- Persistence: restart program, data still there
- Error handling: invalid IDs, missing files

### Example Test Session
```bash
task add "Buy groceries"
# Expected: Task 1 added

task add "Walk the dog"
# Expected: Task 2 added

task list
# Expected: Table with 2 incomplete tasks

task complete 1
# Expected: Task 1 marked complete

task list
# Expected: Task 1 complete (✓), Task 2 incomplete (✗)

task delete 2
# Expected: Task 2 deleted

task list
# Expected: Only Task 1 shown
```

## Completion Promise
Output <promise>TASK MANAGER COMPLETE</promise> when:
- All features implemented
- All tests pass
- Coverage >80%
- Manual test session works
```

**4. Update AGENTS.md with Python commands:**

```bash
vim AGENTS.md
```

Update the TODO sections with:

```markdown
### Initial Setup
```bash
python3 -m venv venv
source venv/bin/activate
pip install click pytest pytest-cov
pip install -e .
```

### Development
```bash
# Activate venv
source venv/bin/activate

# Run the CLI
task --help
task add "test task"
task list
```

### Testing
```bash
# Run all tests
pytest

# Run specific test
pytest tests/test_cli.py::test_add_task

# Run with coverage
pytest --cov=src --cov-report=html
open htmlcov/index.html
```

### Build
```bash
pip install -e .
```

### Linting & Formatting
```bash
# Install dev tools
pip install black flake8 mypy

# Format
black src/ tests/

# Lint
flake8 src/ tests/

# Type check
mypy src/
```
```

**5. Start Rube Goldberg:**

```bash
# Make sure you're in the project directory
cd ~/rube-goldberg-projects/task-manager

# Start Claude Code - Rube Goldberg will read .claude/rube-goldberg-loop.local.md automatically
claude-code
```

**6. Monitor Progress:**

Open another terminal and watch:

```bash
# Watch iteration count
watch -n 5 'grep "^iteration:" ~/rube-goldberg-projects/task-manager/.claude/rube-goldberg-loop.local.md'

# Watch git commits
watch -n 10 'cd ~/rube-goldberg-projects/task-manager && git log --oneline -10'

# See what Rube Goldberg is working on
tail -f ~/rube-goldberg-projects/task-manager/.claude/rube-goldberg-loop.local.md
```

**7. When Complete:**

Rube Goldberg will output: `<promise>TASK MANAGER COMPLETE</promise>`

Then test it yourself:

```bash
cd ~/rube-goldberg-projects/task-manager
source venv/bin/activate
task add "Test Rube Goldberg's work"
task list
task complete 1
task list
```

---

## Key Success Factors

### 1. Specifications Must Be Specific

❌ **Bad (Vague):**
```markdown
## Feature 1: Task Management
- Users can manage tasks
- Should be easy to use
```

✅ **Good (Specific):**
```markdown
## Feature 1: Add Task
- Command: `task add "description"`
- Implementation:
  * Generate unique ID (timestamp-based)
  * Store in ~/.tasks.json
  * Return ID to user
- Success: Running `task add "Buy milk"` returns "Task 1 added"
- Verification: `cat ~/.tasks.json` shows the task
```

### 2. Build/Test Commands Must Be Exact

Rube Goldberg will run these commands literally. They must work.

❌ **Bad:**
```markdown
# Run tests
pytest or something
```

✅ **Good:**
```markdown
# Run all tests
pytest

# Run specific test
pytest tests/test_cli.py::test_add_task

# Run with coverage
pytest --cov=src --cov-report=term-missing
```

### 3. Set Realistic max_iterations

- Simple CLI tool: 20-30 iterations
- Web app: 40-60 iterations
- Complex API: 60-100 iterations
- Compiler/complex system: 100+ iterations

### 4. Define Clear Success Criteria

Rube Goldberg needs to know when to stop. Be explicit:

```markdown
## Success Criteria
- [ ] All tests pass (pytest shows 100% passing)
- [ ] Coverage >80% (pytest --cov shows >80%)
- [ ] Manual test: `task add "test"` → `task list` shows task
- [ ] Persistence: Restart program, task still there
- [ ] No errors in normal operation
```

---

## Monitoring Rube Goldberg

### Watch Iteration Count
```bash
watch -n 5 'grep "^iteration:" .claude/rube-goldberg-loop.local.md'
```

### Watch Git Commits (Rube Goldberg commits after each success)
```bash
watch -n 10 'git log --oneline -10'
```

### Check TODO List
```bash
watch -n 10 'cat fix_plan.md'
```

### See Current Work
```bash
tail -50 .claude/rube-goldberg-loop.local.md
```

---

## Troubleshooting

### Rube Goldberg Stuck on Same Error (>5 iterations)

**Fix:** Add specific instruction to .claude/rube-goldberg-loop.local.md

```bash
vim .claude/rube-goldberg-loop.local.md
```

Add after existing numbered items:

```markdown
99999999999999. IMPORTANT: [Your specific instruction to fix the issue]
```

For example, if Rube Goldberg keeps forgetting to install a dependency:

```markdown
99999999999999. CRITICAL: Before running tests, ALWAYS run `pip install -r requirements.txt` first
```

### Rube Goldberg Makes Placeholder Implementations

**Symptom:** Code has `# TODO: implement` or minimal functions

**Fix:** Already in the template, but emphasize:

```markdown
9999999999999999999. DO NOT IMPLEMENT PLACEHOLDER OR SIMPLE IMPLEMENTATIONS. WE WANT FULL IMPLEMENTATIONS. DO IT OR I WILL YELL AT YOU. NO PLACEHOLDERS. NO TODOS. FULL COMPLETE IMPLEMENTATIONS ONLY.
```

### Rube Goldberg Can't Find Existing Code

**Symptom:** Re-implementing things

**Fix:** Already in template, but add:

```markdown
999999999999999. CRITICAL: Before implementing ANYTHING, use subagents to search the entire codebase thoroughly. DO NOT ASSUME CODE DOESN'T EXIST. SEARCH FIRST. ALWAYS.
```

### Context Window Full (Rube Goldberg makes unrelated changes)

**Fix:** Increase subagent usage:

```markdown
1. ... You may use up to 200 parallel subagents for all operations but only 1 subagent for build/tests.
```

### Complete Failure (Nothing Works)

**Nuclear option:**

```bash
# Find last good commit
git log --oneline

# Reset to it
git reset --hard <good-commit-hash>

# Fix the spec or AGENTS.md
vim specs/PROJECT_SPEC.md

# Restart Rube Goldberg
claude-code
```

---

## What You've Built

After completing this quickstart, you have:

1. ✅ **AGENTS.md** - A standardized way for AI agents to understand your project
2. ✅ **Rube Goldberg infrastructure** - Complete automation system
3. ✅ **Setup script** - One-command project creation
4. ✅ **Working example** - Task Manager CLI built with zero intervention
5. ✅ **Complete documentation** - Full guides for future projects

---

## Next Steps

### Build More Apps

```bash
# Todo app with web interface
./automation/scripts/setup-rube-goldberg-project.sh todo-web javascript web-app

# REST API for blog
./automation/scripts/setup-rube-goldberg-project.sh blog-api typescript api

# Data processing tool
./automation/scripts/setup-rube-goldberg-project.sh data-processor python cli-tool

# URL shortener service
./automation/scripts/setup-rube-goldberg-project.sh url-shortener go api
```

### Integrate with Existing Designr System

Your existing invention system now has AGENTS.md support:

```bash
# Create invention
./inventions/scripts/new-invention.sh smart-email-filter

# Add AGENTS.md to that invention
# Edit spec with specific requirements
# Start Rube Goldberg
./inventions/scripts/start-invention.sh smart-email-filter
```

### Scale Up

- Build 3-5 projects this week
- Build 10-20 projects this month
- **10x your output**

---

## Resources

- **Complete Setup Guide:** `RUBE_GOLDBERG-AGENTS-SETUP-GUIDE.md` (comprehensive, read for deep understanding)
- **This File:** `ZERO-INTERVENTION-QUICKSTART.md` (quick reference)
- **AGENTS.md Standard:** `agentsmd-2026-01-13.md` (format specification)
- **Rube Goldberg Deep Dive:** `rube-goldberg-wiggum-as-a-software-engineer-2026-01-13.md` (theory and advanced techniques)
- **Existing Invention System:** `INVENTOR-QUICKSTART.md` (original Designr workflow)

---

## The Bottom Line

**Old way:** 3-5 hours to build a prototype, manually coding and debugging

**New way:** 30 minutes to write specs, Rube Goldberg builds it in 20-30 iterations (1-2 hours of computer time, 0 minutes of your time)

**Result:** 10x productivity increase

**You write specifications. Rube Goldberg writes code.**

Go build. 🚀
