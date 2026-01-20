#!/bin/bash
# Start a Rube Goldberg loop for automated setup

set -e

WORKFLOW_NAME="${1:-}"

if [ -z "$WORKFLOW_NAME" ]; then
    echo "❌ Error: No workflow name provided"
    echo ""
    echo "Usage: ./automation/start-rube-goldberg.sh <workflow-name>"
    echo ""
    echo "Example: ./automation/start-rube-goldberg.sh nodejs"
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

# Get completion promise from user
read -p "Completion promise (or press Enter for 'SETUP COMPLETE'): " PROMISE
PROMISE="${PROMISE:-SETUP COMPLETE}"

# Get max iterations
read -p "Max iterations (default: 20): " MAX_ITER
MAX_ITER="${MAX_ITER:-20}"

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
