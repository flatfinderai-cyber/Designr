#!/bin/bash
# Start a Rube Goldberg loop for automated setup

# Source common functions
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/scripts/common.sh"

WORKFLOW_NAME="${1:-}"

# Validate workflow name parameter
if ! validate_param "$WORKFLOW_NAME" "workflow name" "./automation/start-rube-goldberg.sh <workflow-name>"; then
    echo ""
    echo "Example: ./automation/start-rube-goldberg.sh nodejs"
    echo ""
    echo "Available workflows:"
    list_available_files "automation/workflows/*.md"
    exit 1
fi

WORKFLOW_FILE="automation/workflows/${WORKFLOW_NAME}-setup.md"

# Check if workflow file exists
if ! check_file_exists "$WORKFLOW_FILE" "Workflow file not found: $WORKFLOW_FILE" "Create one with: ./automation/quick-start.sh"; then
    echo "Available workflows:"
    list_available_files "automation/workflows/*.md"
    echo ""
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

# Create Rube Goldberg loop state using common function
create_rube_goldberg_loop "$WORKFLOW_FILE" "$MAX_ITER" "$PROMISE" "automation" "$WORKFLOW_NAME"

echo_status "success" "Rube Goldberg loop state created: .claude/rube-goldberg-loop.local.md"
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
