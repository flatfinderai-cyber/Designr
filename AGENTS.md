# AGENTS.md

## Project Overview
Designr is an automated invention and development system using Ralph Wiggum iterative loops to build digital inventions 10x faster. This meta-project creates the infrastructure for zero-intervention software development.

## Setup Commands

### Initial Setup
```bash
# No dependencies to install - uses Claude Code CLI
# Ensure permissions are configured
cat .claude/settings.local.json
```

### Development
```bash
# Create new invention
./inventions/scripts/new-invention.sh <invention-name>

# Edit invention specification
vim inventions/active/<invention-name>.md

# Build invention with Ralph
./inventions/scripts/start-invention.sh <invention-name>

# Create automation workflow
./automation/quick-start.sh <tool-name>

# Run automation with Ralph
./automation/start-ralph.sh <tool-name>
```

### Testing
```bash
# Test invention creation
./inventions/scripts/new-invention.sh test-invention

# Test Ralph loop (dry run)
cat .claude/ralph-loop.local.md

# Verify permissions
grep -A 5 "permissions" .claude/settings.local.json
```

### Monitoring Ralph
```bash
# Check current iteration
grep '^iteration:' .claude/ralph-loop.local.md

# View Ralph's current task
tail -50 .claude/ralph-loop.local.md

# Watch git commits (Ralph commits progress)
git log --oneline -10

# Cancel Ralph loop
rm .claude/ralph-loop.local.md
```

## Code Style Guidelines

### Bash Scripts
- Use `set -e` for error handling
- Add descriptions for all prompts
- Make scripts executable: `chmod +x`
- Use absolute paths where possible

### Markdown Documentation
- Clear headings and structure
- Code blocks with language specification
- Examples for all concepts
- Keep concise and actionable

### Naming Conventions
- Invention files: `lowercase-with-dashes.md`
- Scripts: `kebab-case.sh`
- Directories: `lowercase` (no special characters)

## Ralph Loop Architecture

### Core Components
1. **Specifications** (`specs/*.md`) - Detailed requirements
2. **Ralph Control** (`.claude/ralph-loop.local.md`) - Loop configuration
3. **TODO List** (`fix_plan.md`) - Prioritized tasks managed by Ralph
4. **AGENTS.md** - Build/test instructions (this file)
5. **Auto-accept** (`.claude/settings.local.json`) - No permission prompts

### Ralph Loop Principles
- One task per iteration
- Search before assuming code doesn't exist
- Use subagents to extend context window
- Test after every change
- Commit when tests pass
- Update fix_plan.md continuously
- Self-improve AGENTS.md with learnings

## Testing Requirements

### For Inventions
- Specifications must be detailed and specific
- Each feature needs clear success criteria
- Tests specified in invention spec
- Verification commands for each step

### For This Meta-Project
- Scripts must be executable
- All paths must work from project root
- Ralph loops must complete without errors
- Git commits should happen automatically

## Development Workflow

### Creating New Inventions

Before starting:
1. Read `INVENTOR-QUICKSTART.md`
2. Study example: `inventions/active/example-smart-clipboard.md`
3. Understand Ralph loop: `ralph-setup-template.md`

Workflow:
1. Run `./inventions/scripts/new-invention.sh <name>`
2. Edit `inventions/active/<name>.md` with:
   - Clear problem statement
   - Detailed solution
   - Specific build steps (not vague!)
   - Verification for each step
   - Success criteria
3. Run `./inventions/scripts/start-invention.sh <name>`
4. Monitor progress with `tail -f .claude/ralph-loop.local.md`
5. Review completed prototype

### Using Automation System

Workflow:
1. Get complex setup instructions (e.g., from Claude Desktop)
2. Run `./automation/quick-start.sh <tool-name>`
3. Paste instructions into `automation/workflows/<tool-name>-setup.md`
4. Add verification steps
5. Run `./automation/start-ralph.sh <tool-name>`
6. Tool installs automatically

## Project-Specific Notes

### Back Pressure (Quality Gates)
For inventions built by Ralph:
- Tests must pass
- Build must succeed
- Type checking (if applicable)
- Linting (if applicable)
- All specs requirements met

### Important Constraints
- DO NOT use vague specifications ("build the thing")
- DO NOT skip verification steps
- DO NOT set max_iterations too low (< 15)
- DO search codebase before assuming code doesn't exist
- DO capture WHY tests are important, not just WHAT they test
- DO resolve unrelated test failures discovered during work

### Standard Patterns
Location: `inventions/templates/` and `automation/templates/`
- Use `invention-template.md` for new inventions
- Use `setup-template.md` for automation workflows
- Follow `example-smart-clipboard.md` patterns

### Subagent Usage
- Use up to 50 parallel subagents for searches
- Use only 1 subagent for builds/tests (avoid backpressure)
- Subagents extend context window
- Use subagents to update fix_plan.md and AGENTS.md

## File Organization

### Inventions Flow
```
ideas/          → Quick notes for future inventions
   ↓
active/         → Currently building (3-10 at a time)
   ↓
completed/      → Finished and verified prototypes
```

### Key Files for Ralph
- `specs/*.md` - Read every loop for requirements
- `fix_plan.md` - Updated every loop with progress
- `AGENTS.md` - Updated when learning new commands
- `.claude/ralph-loop.local.md` - Loop control file

## Security Considerations
- Auto-accept enabled: review sensitive operations
- Git commits are automatic: use .gitignore properly
- Scripts run with user permissions
- No secrets in specifications or code

## Performance Requirements
- Script execution < 5 seconds
- Ralph iterations: 1-3 minutes each
- Full invention: 15-30 iterations typical
- Complex setups: 20-40 iterations

## Common Ralph Issues & Solutions

### Ralph Repeats Same Error (> 5 times)
**Fix:** Add more specific instruction to ralph-loop.local.md
```markdown
9999999. IMPORTANT: [Specific instruction for the stuck issue]
```

### Ralph Makes Placeholder Implementations
**Fix:** Emphasize in ralph-loop.local.md:
```markdown
9999999999. DO NOT IMPLEMENT PLACEHOLDER OR SIMPLE IMPLEMENTATIONS. WE WANT FULL IMPLEMENTATIONS. DO IT OR I WILL YELL AT YOU
```

### Ralph Can't Find Existing Code
**Fix:** Add search instruction:
```markdown
Before making changes search codebase (don't assume not implemented) using subagents. Think hard.
```

### Context Window Full
**Fix:** Increase subagent usage in ralph-loop.local.md:
```markdown
You may use up to 100 parallel subagents for all operations but only 1 subagent for build/tests.
```

### Broken Codebase After Ralph
**Fix:** Either:
1. `git reset --hard <last-good-commit>` and restart with better instructions
2. Create rescue prompt in ralph-loop.local.md with specific fixes needed

## Commit Guidelines
When Ralph commits (automatic):
- Format: Descriptive message of changes made
- Includes: Changed code + updated fix_plan.md
- Co-authored: `Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>`

Manual commits (when you intervene):
- Format: `[type]: [description]`
- Types: feat, fix, docs, refactor, chore
- Update fix_plan.md if discovering issues

## Documentation Requirements

### For Invention Specs
- Document WHY, not just WHAT
- Include verification commands
- Be specific about success criteria
- Add examples when helpful

### For Code Generated by Ralph
- Capture importance of tests in docstrings
- Explain WHY implementation is important
- Leave "notes" for future Ralph iterations

### Updating This File
- Ralph updates when learning new commands
- Keep sections brief and actionable
- Add to "Common Ralph Issues" when resolving problems
- Remove outdated information

## Quick Reference

### Start New Invention
```bash
./inventions/scripts/new-invention.sh my-invention
vim inventions/active/my-invention.md  # Be specific!
./inventions/scripts/start-invention.sh my-invention
```

### Monitor Ralph
```bash
grep '^iteration:' .claude/ralph-loop.local.md
tail -20 .claude/ralph-loop.local.md
git log --oneline -5
```

### Cancel Ralph
```bash
rm .claude/ralph-loop.local.md
# Or edit and set: active: false
```

### Rescue Broken Build
```bash
git log --oneline -20  # Find last good commit
git reset --hard <commit-hash>
# Adjust ralph-loop.local.md with better instructions
# Restart Ralph
```

## Resources
- Full setup guide: `RALPH-AGENTS-SETUP-GUIDE.md`
- Inventor quickstart: `INVENTOR-QUICKSTART.md`
- Ralph template: `ralph-setup-template.md`
- Example invention: `inventions/active/example-smart-clipboard.md`
- Automation guide: `automation/HOW-TO-USE.md`
