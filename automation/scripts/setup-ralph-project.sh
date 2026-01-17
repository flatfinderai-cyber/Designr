#!/bin/bash
# Setup a new project with AGENTS.md and Ralph infrastructure
# Usage: ./setup-ralph-project.sh <project-name> <language> [project-type] [-y|--yes]

set -e

# ============================================================
# Non-interactive mode detection
# ============================================================
NONINTERACTIVE="${NONINTERACTIVE:-0}"
if [[ "${CI:-false}" == "true" ]]; then
  NONINTERACTIVE=1
fi

echo "🤖 Ralph Project Setup Wizard"
echo ""

# Parse arguments
PROJECT_NAME=""
LANGUAGE=""
PROJECT_TYPE=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    -y|--yes)
      NONINTERACTIVE=1
      shift
      ;;
    *)
      if [[ -z "$PROJECT_NAME" ]]; then
        PROJECT_NAME="$1"
      elif [[ -z "$LANGUAGE" ]]; then
        LANGUAGE="$1"
      elif [[ -z "$PROJECT_TYPE" ]]; then
        PROJECT_TYPE="$1"
      else
        echo "Unknown argument: $1"
        exit 1
      fi
      shift
      ;;
  esac
done

# Set default project type
PROJECT_TYPE="${PROJECT_TYPE:-cli-tool}"

if [ -z "$PROJECT_NAME" ] || [ -z "$LANGUAGE" ]; then
    echo "Usage: $0 <project-name> <language> [project-type] [-y|--yes]"
    echo ""
    echo "Examples:"
    echo "  $0 task-manager python cli-tool"
    echo "  $0 my-api typescript api -y"
    echo "  $0 blog-app javascript web-app --yes"
    echo ""
    echo "Supported languages: python, javascript, typescript, rust, go"
    echo "Supported types: cli-tool, web-app, api, library, automation"
    echo ""
    echo "Options:"
    echo "  -y, --yes    Non-interactive mode (auto-accept prompts)"
    exit 1
fi

PROJECT_DIR="$HOME/ralph-projects/$PROJECT_NAME"

echo "Project: $PROJECT_NAME"
echo "Language: $LANGUAGE"
echo "Type: $PROJECT_TYPE"
echo "Location: $PROJECT_DIR"
echo ""

if [[ "$NONINTERACTIVE" == "1" ]]; then
    echo "Non-interactive mode: proceeding automatically"
    REPLY="y"
else
    read -p "Create this project? (y/n) " -n 1 -r
    echo ""
fi

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Cancelled."
    exit 0
fi

# Create directory structure
echo "📁 Creating directory structure..."
mkdir -p "$PROJECT_DIR"/{src,tests,specs,.claude}

# Create AGENTS.md
echo "📝 Creating AGENTS.md..."
cat > "$PROJECT_DIR/AGENTS.md" << 'AGENTSMD'
# AGENTS.md

## Project Overview
[Your project description here]

## Setup Commands

### Initial Setup
```bash
# TODO: Add your setup commands
# Example: npm install, pip install -r requirements.txt, cargo build
```

### Development
```bash
# TODO: Add your dev commands
# Example: npm run dev, python main.py, cargo run
```

### Testing
```bash
# TODO: Add your test commands
# Example: npm test, pytest, cargo test

# Run specific test
# Example: pytest tests/test_module.py, npm test -- --testNamePattern="test name"
```

### Build
```bash
# TODO: Add your build commands
# Example: npm run build, python setup.py build, cargo build --release
```

### Linting & Formatting
```bash
# TODO: Add your lint/format commands
# Example: eslint src/, black ., cargo fmt
```

## Code Style Guidelines

### Language-Specific Rules
- TODO: Add your language-specific style rules
- TODO: Add your naming conventions
- TODO: Add your architectural patterns

## Testing Requirements

### Test Coverage
- Minimum coverage: 80%
- Required for all new features

### Test Quality
- Each test has clear description
- Tests are isolated and repeatable
- Document WHY tests are important

## Development Workflow

### Before Making Changes
1. Search codebase (don't assume code doesn't exist)
2. Check fix_plan.md for related tasks
3. Read relevant specs in specs/

### After Making Changes
1. Run tests for modified code
2. Run full test suite
3. Run linter
4. Update fix_plan.md if discovering issues
5. Update AGENTS.md if learning new steps

### Commit Guidelines
- Format: [type]: [description]
- Types: feat, fix, docs, refactor, test, chore
- Always run tests before committing

## Project-Specific Notes

### Back Pressure (Quality Gates)
- Tests must pass
- Build must succeed
- Linter must pass
- Type checker must pass (if applicable)

### Important Constraints
- DO NOT implement placeholder/minimal implementations
- DO NOT skip tests
- DO search before assuming code doesn't exist
- DO add logging when debugging
- DO resolve unrelated test failures discovered

## Security Considerations
- Validate all user input
- Never commit secrets
- Use environment variables for configuration

## Performance Requirements
- TODO: Add your performance requirements
AGENTSMD

# Create initial spec
echo "📋 Creating project specification..."
cat > "$PROJECT_DIR/specs/PROJECT_SPEC.md" << SPECMD
# $PROJECT_NAME Specification

## Purpose
[What problem does this solve?]

## Core Features

### Feature 1: [Name]
- Description: [Detailed description]
- Requirements: [Specific requirements]
- Success criteria: [How to verify it works]

## Technical Specification

### Tech Stack
- Language: $LANGUAGE
- Framework: [Your framework]
- Testing: [Your test framework]

### Project Structure
\`\`\`
src/
├── main.$LANGUAGE       # Entry point
├── core/                # Core logic
└── utils/               # Utilities
\`\`\`

## Implementation Steps

### Phase 1: Foundation
- Set up project structure
- Configure build system
- Set up testing framework

### Phase 2: Core Features
- [Break down into specific steps]

### Phase 3: Testing & Validation
- Write comprehensive tests
- Verify all success criteria

## Success Criteria
- [ ] All tests pass
- [ ] Application builds without errors
- [ ] All features work as specified

## Testing Requirements

### Unit Tests
- [What needs unit tests]

### Integration Tests
- [What needs integration tests]

## Completion Promise
Output <promise>PROJECT COMPLETE</promise> when all features implemented and all tests pass.
SPECMD

# Create fix_plan.md
echo "✅ Creating fix_plan.md..."
cat > "$PROJECT_DIR/fix_plan.md" << 'FIXPLAN'
# Fix Plan / TODO List

## Current Priority

### High Priority
- [ ] Set up project structure
- [ ] Configure build system
- [ ] Set up testing framework

### Medium Priority
- [ ] [Will be filled by Ralph]

### Low Priority
- [ ] [Will be filled by Ralph]

## Completed
- [x] Project initialized

## Notes
- This file is managed by Ralph
- Items are sorted by priority
- Completed items moved to bottom section
FIXPLAN

# Create Ralph loop configuration
echo "🔄 Creating Ralph loop configuration..."
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
cat > "$PROJECT_DIR/.claude/ralph-loop.local.md" << RALPHLOOP
---
active: true
iteration: 1
max_iterations: 30
completion_promise: "PROJECT COMPLETE"
started_at: "$TIMESTAMP"
---

## Ralph Loop Task

0a. Study @specs/* to learn about the project specifications
0b. Study @AGENTS.md to learn how to build and test the project
0c. Study @fix_plan.md to understand current TODO list

1. Your task is to implement the project as specified in @specs/* using parallel subagents. Follow @fix_plan.md and choose the most important thing to implement. Before making changes, search codebase (don't assume not implemented) using subagents. You may use up to 50 parallel subagents for all operations but only 1 subagent for build/tests.

2. After implementing functionality or resolving problems, run the tests for that unit of code that was improved. If functionality is missing then it's your job to add it as per the application specifications. Think hard.

3. When you discover bugs or issues, immediately update @fix_plan.md with your findings using a subagent. When resolved, update @fix_plan.md and remove the item using a subagent.

4. When the tests pass, update @fix_plan.md, then add changed code and @fix_plan.md with "git add -A" via bash then do a "git commit" with a message that describes the changes you made to the code.

999. Important: When authoring documentation (code comments, docstrings) capture the WHY tests and implementation is important.

9999. Important: We want single sources of truth. If tests unrelated to your work fail then it's your job to resolve these tests as part of the increment of change.

99999. You may add extra logging if required to debug issues.

999999. ALWAYS KEEP @fix_plan.md up to date with your learnings using a subagent. Especially after wrapping up/finishing your turn.

9999999. When you learn something new about how to run the project make sure you update @AGENTS.md using a subagent but keep it brief.

99999999. IMPORTANT when you discover a bug resolve it using subagents even if unrelated to current work after documenting in @fix_plan.md

999999999. DO NOT IMPLEMENT PLACEHOLDER OR SIMPLE IMPLEMENTATIONS. WE WANT FULL IMPLEMENTATIONS. DO IT OR I WILL YELL AT YOU

9999999999. When @fix_plan.md becomes large periodically clean out completed items using a subagent.

99999999999. Output <promise>PROJECT COMPLETE</promise> when all specs implemented, all tests pass, and project is fully functional.
RALPHLOOP

# Create permissions configuration
echo "🔐 Creating permissions configuration..."
cat > "$PROJECT_DIR/.claude/settings.local.json" << 'SETTINGS'
{
  "permissions": {
    "defaultMode": "bypassPermissions"
  }
}
SETTINGS

# Initialize git
echo "📦 Initializing git repository..."
cd "$PROJECT_DIR"
git init

# Create .gitignore based on language
case "$LANGUAGE" in
    python)
        cat > .gitignore << 'GITIGNORE'
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
*.egg-info/
.installed.cfg
*.egg
venv/
env/
ENV/
.pytest_cache/
.coverage
htmlcov/
GITIGNORE
        ;;
    javascript|typescript)
        cat > .gitignore << 'GITIGNORE'
node_modules/
dist/
build/
*.log
.env
.DS_Store
coverage/
.nyc_output/
GITIGNORE
        ;;
    rust)
        cat > .gitignore << 'GITIGNORE'
target/
Cargo.lock
**/*.rs.bk
*.pdb
GITIGNORE
        ;;
    go)
        cat > .gitignore << 'GITIGNORE'
# Binaries
*.exe
*.exe~
*.dll
*.so
*.dylib

# Test binary
*.test

# Output
*.out

# Go workspace
go.work
GITIGNORE
        ;;
esac

# Create README
cat > README.md << READMEMD
# $PROJECT_NAME

[Project description]

## Setup

See AGENTS.md for complete setup instructions.

## Development

Built with Ralph Wiggum automation system.

See \`specs/PROJECT_SPEC.md\` for detailed specifications.

## License

[Your license]
READMEMD

# Create initial commit
git add .
git commit -m "Initial project setup for $PROJECT_NAME

Project Type: $PROJECT_TYPE
Language: $LANGUAGE

Setup includes:
- AGENTS.md for AI agent instructions
- specs/ directory with project specifications
- fix_plan.md for Ralph TODO tracking
- .claude/ralph-loop.local.md for Ralph automation
- Auto-accept permissions configured

Ready for zero-intervention development with Ralph.

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"

echo ""
echo "✅ Project setup complete!"
echo ""
echo "📍 Location: $PROJECT_DIR"
echo ""
echo "Next steps:"
echo ""
echo "1. Edit the specification:"
echo "   vim $PROJECT_DIR/specs/PROJECT_SPEC.md"
echo ""
echo "2. Update AGENTS.md with your build/test commands:"
echo "   vim $PROJECT_DIR/AGENTS.md"
echo ""
echo "3. Start Ralph to build the project:"
echo "   cd $PROJECT_DIR"
echo "   claude-code"
echo ""
echo "4. Monitor progress:"
echo "   grep '^iteration:' .claude/ralph-loop.local.md"
echo "   tail -f .claude/ralph-loop.local.md"
echo "   git log --oneline"
echo ""
echo "📚 Full guide: $HOME/cloud-projects/Designr/RALPH-AGENTS-SETUP-GUIDE.md"
echo ""
