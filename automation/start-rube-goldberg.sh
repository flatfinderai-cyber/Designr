#!/bin/bash
# Start a Rube Goldberg loop for automated setup
# Usage: ./automation/start-rube-goldberg.sh <workflow-name> [--promise "PROMISE"] [--max-iterations N] [-y|--yes]
#        NONINTERACTIVE=1 ./automation/start-rube-goldberg.sh <workflow-name>
#        CI=true ./automation/start-rube-goldberg.sh <workflow-name> -y

set -e

# ============================================================
# Non-interactive mode detection
# ============================================================
NONINTERACTIVE="${NONINTERACTIVE:-}"
if [[ "${CI:-false}" == "true" ]] || [[ "$NONINTERACTIVE" == "1" ]]; then
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
            echo "Usage: $0 <workflow-name> [--promise \"PROMISE\"] [--max-iterations N] [-y|--yes]"
            exit 1
            ;;
        *)
            if [ -z "$WORKFLOW_NAME" ]; then
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
    echo "Usage: ./automation/start-rube-goldberg.sh <workflow-name> [options]"
    echo ""
    echo "Options:"
    echo "  --promise \"TEXT\"       Completion promise (default: 'SETUP COMPLETE')"
    echo "  --max-iterations N     Maximum iterations (default: 20)"
    echo "  -y, --yes              Non-interactive mode (skip prompts)"
    echo ""
    echo "Example:"
    echo "  ./automation/start-rube-goldberg.sh nodejs --promise \"NODE.JS ENVIRONMENT READY\" --max-iterations 10 -y"
    echo ""
    echo "Available workflows:"
    ls automation/workflows/*.md 2>/dev/null | sed 's/.*\//  - /' || echo "  (none yet)"
    exit 1
fi

WORKFLOW_FILE="automation/workflows/${WORKFLOW_NAME}-setup.md"

if [ ! -f "$WORKFLOW_FILE" ]; then
    echo "❌ Error: Workflow file not found: $WORKFLOW_FILE"
    echo ""
    echo "Available workflows:"
    ls automation/workflows/*.md 2>/dev/null | sed 's/.*\//  - /' || echo "  (none yet)"
    echo ""
    echo "Create one with: ./automation/quick-start.sh"
    exit 1
fi

# Get completion promise from user or use default
if [ -z "$PROMISE" ]; then
    if [[ "$NONINTERACTIVE" == "1" ]]; then
        PROMISE="SETUP COMPLETE"
        echo "ℹ️  Using default promise: $PROMISE"
    else
        read -p "Completion promise (or press Enter for 'SETUP COMPLETE'): " PROMISE
        PROMISE="${PROMISE:-SETUP COMPLETE}"
    fi
fi

# Get max iterations from user or use default
if [ -z "$MAX_ITER" ]; then
    if [[ "$NONINTERACTIVE" == "1" ]]; then
        MAX_ITER=20
        echo "ℹ️  Using default max iterations: $MAX_ITER"
    else
        read -p "Max iterations (default: 20): " MAX_ITER
        MAX_ITER="${MAX_ITER:-20}"
    fi
fi

echo ""
echo "🔄 Starting Rube Goldberg loop for: $WORKFLOW_NAME"
echo "   Workflow: $WORKFLOW_FILE"
echo "   Max iterations: $MAX_ITER"
echo "   Completion promise: $PROMISE"
echo ""

# Create Rube Goldberg loop state
mkdir -p .claude

cat > .claude/rube-goldberg-loop.local.md << EOF
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

echo "✅ Rube Goldberg loop state created: .claude/rube-goldberg-loop.local.md"
echo ""
echo "📖 Rube Goldberg will now:"
echo "   1. Read your setup instructions"
echo "   2. Execute each step"
echo "   3. Verify success"
echo "   4. Fix any failures"
echo "   5. Iterate until complete"
echo ""
echo "🎯 Monitor progress:"
echo "   grep '^iteration:' .claude/rube-goldberg-loop.local.md"
echo ""
echo "🚀 Ready! Start your chat and Rube Goldberg will begin automatically."
