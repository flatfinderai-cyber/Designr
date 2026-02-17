#!/bin/bash
# Start Rube Goldberg loop to build an invention

# Source common functions
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../automation/scripts/common.sh"

INVENTION_NAME="${1:-}"

# Validate invention name parameter
if ! validate_param "$INVENTION_NAME" "invention name" "./inventions/scripts/start-invention.sh <invention-name>"; then
    echo ""
    echo "Active inventions:"
    list_available_files "inventions/active/*.md"
    echo ""
    echo "Create one with: ./inventions/scripts/new-invention.sh"
    exit 1
fi

INVENTION_FILE="inventions/active/${INVENTION_NAME}.md"

# Check if invention file exists
if ! check_file_exists "$INVENTION_FILE" "Invention file not found: $INVENTION_FILE" "Create one with: ./inventions/scripts/new-invention.sh"; then
    echo "Active inventions:"
    list_available_files "inventions/active/*.md"
    echo ""
    exit 1
fi

# Extract metadata from file using common function
PROMISE=$(extract_yaml_value "$INVENTION_FILE" "completion_promise" "INVENTION COMPLETE: ${INVENTION_NAME}")
MAX_ITER=$(extract_yaml_value "$INVENTION_FILE" "estimated_iterations" "20")

echo ""
echo "🔬 Starting Rube Goldberg loop for invention: $INVENTION_NAME"
echo "   Specification: $INVENTION_FILE"
echo "   Max iterations: $MAX_ITER"
echo "   Completion promise: $PROMISE"
echo ""

# Read a bit of the invention file to show what we're building
echo "📋 Invention Overview:"
grep -A 5 "## The Problem" "$INVENTION_FILE" | head -6 || echo "   (see $INVENTION_FILE for details)"
echo ""

# Confirm with user
if ! prompt_confirm "Ready to start building this invention?"; then
    exit 0
fi

# Create Rube Goldberg loop state using common function
create_rube_goldberg_loop "$INVENTION_FILE" "$MAX_ITER" "$PROMISE" "invention" "$INVENTION_NAME"

echo ""
echo_status "success" "Rube Goldberg loop activated!"
echo ""
echo "🤖 Rube Goldberg will now:"
echo "   1. Read your invention specification"
echo "   2. Build it step-by-step"
echo "   3. Test each component"
echo "   4. Debug and fix issues"
echo "   5. Iterate until it works"
echo "   6. Document the process"
echo ""
echo "📊 Monitor progress:"
echo "   grep '^iteration:' .claude/rube-goldberg-loop.local.md"
echo ""
echo "📝 View detailed logs:"
echo "   tail -100 .claude/rube-goldberg-loop.local.md"
echo ""
echo "🛑 Cancel if needed:"
echo "   /cancel-rube-goldberg (or rm .claude/rube-goldberg-loop.local.md)"
echo ""
echo "🚀 Rube Goldberg is starting! Check back periodically or let it run to completion."
echo ""
