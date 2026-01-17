#!/bin/bash
# Start a Ralph loop for automated setup
# Usage: ./start-ralph.sh <workflow-name> [--promise PROMISE] [--max-iterations N] [-y|--yes]

set -e

# ============================================================
# Non-interactive mode detection and defaults
# ============================================================
NONINTERACTIVE="${NONINTERACTIVE:-0}"
if [[ "${CI:-false}" == "true" ]]; then
  NONINTERACTIVE=1
fi

# Default values
PROMISE=""
MAX_ITER=""
WORKFLOW_NAME=""

# Parse arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
    --promise)
      PROMISE="$2"
      shift 2
      ;;
    --max-iterations)
      MAX_ITER="$2"
      shift 2
      ;;
    -y|--yes)
      NONINTERACTIVE=1
      shift
      ;;
    -*)
      echo "Unknown option: $1"
      echo "Usage: $0 <workflow-name> [--promise PROMISE] [--max-iterations N] [-y|--yes]"
      exit 1
      ;;
    *)
      if [[ -z "$WORKFLOW_NAME" ]]; then
        WORKFLOW_NAME="$1"
      else
        echo "Error: Multiple workflow names provided"
        exit 1
      fi
      shift
      ;;
  esac
done

if [ -z "$WORKFLOW_NAME" ]; then
    echo "❌ Error: No workflow name provided"
    echo ""
    echo "Usage: ./automation/start-ralph.sh <workflow-name> [--promise PROMISE] [--max-iterations N] [-y|--yes]"
    echo ""
    echo "Example: ./automation/start-ralph.sh nodejs --promise 'NODE.JS ENVIRONMENT READY' --max-iterations 20"
    echo ""
    echo "Options:"
    echo "  --promise PROMISE         Completion promise (default: 'SETUP COMPLETE')"
    echo "  --max-iterations N        Maximum iterations (default: 20)"
    echo "  -y, --yes                 Non-interactive mode (skip prompts)"
    echo ""
    echo "Available workflows:"
    ls automation/workflows/*.md 2>/dev/null | sed 's/.*\//  - /' | sed 's/-setup\.md$//' || echo "  (none yet)"
    exit 1
fi

WORKFLOW_FILE="automation/workflows/${WORKFLOW_NAME}-setup.md"

if [ ! -f "$WORKFLOW_FILE" ]; then
    echo "❌ Error: Workflow file not found: $WORKFLOW_FILE"
    echo ""
    echo "Available workflows:"
    ls automation/workflows/*.md 2>/dev/null | sed 's/.*\//  - /' | sed 's/-setup\.md$//' || echo "  (none yet)"
    echo ""
    echo "Create one with: ./automation/quick-start.sh"
    exit 1
fi

# Set defaults if not provided
if [[ -z "$PROMISE" ]]; then
  if [[ "$NONINTERACTIVE" == "1" ]]; then
    PROMISE="SETUP COMPLETE"
  else
    read -p "Completion promise (or press Enter for 'SETUP COMPLETE'): " PROMISE
    PROMISE="${PROMISE:-SETUP COMPLETE}"
  fi
fi

if [[ -z "$MAX_ITER" ]]; then
  if [[ "$NONINTERACTIVE" == "1" ]]; then
    MAX_ITER="20"
  else
    read -p "Max iterations (default: 20): " MAX_ITER
    MAX_ITER="${MAX_ITER:-20}"
  fi
fi

echo ""
echo "🔄 Starting Ralph loop for: $WORKFLOW_NAME"
echo "   Workflow: $WORKFLOW_FILE"
echo "   Max iterations: $MAX_ITER"
echo "   Completion promise: $PROMISE"
if [[ "$NONINTERACTIVE" == "1" ]]; then
  echo "   Mode: Non-interactive"
fi
echo ""

# Create Ralph loop state
mkdir -p .claude

cat > .claude/ralph-loop.local.md << EOF
---
active: true
iteration: 1
max_iterations: $MAX_ITER
completion_promise: "$PROMISE"
started_at: "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
---

Execute ALL steps in $WORKFLOW_FILE

Read the file carefully and execute each step in order.

For each step:
1. Execute the commands
2. Verify success using the verification steps
3. If it fails, debug and fix before proceeding
4. Document what you did

When ALL steps are complete and all success criteria are met, output:
<promise>$PROMISE</promise>

IMPORTANT: Only output the promise when EVERYTHING is truly complete and verified.
EOF

echo "✅ Ralph loop state created: .claude/ralph-loop.local.md"
echo ""
echo "📖 Ralph will now:"
echo "   1. Read your setup instructions"
echo "   2. Execute each step"
echo "   3. Verify success"
echo "   4. Fix any failures"
echo "   5. Iterate until complete"
echo ""
echo "🎯 Monitor progress:"
echo "   grep '^iteration:' .claude/ralph-loop.local.md"
echo ""
echo "🚀 Ready! Start your chat and Ralph will begin automatically."
