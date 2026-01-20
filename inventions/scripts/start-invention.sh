#!/bin/bash
# Start Rube Goldberg loop to build an invention

set -e

INVENTION_NAME="${1:-}"

if [ -z "$INVENTION_NAME" ]; then
    echo "❌ Error: No invention name provided"
    echo ""
    echo "Usage: ./inventions/scripts/start-invention.sh <invention-name>"
    echo ""
    echo "Active inventions:"
    ls inventions/active/*.md 2>/dev/null | sed 's/.*\//  - /' | sed 's/\.md//' || echo "  (none yet)"
    echo ""
    echo "Create one with: ./inventions/scripts/new-invention.sh"
    exit 1
fi

INVENTION_FILE="inventions/active/${INVENTION_NAME}.md"

if [ ! -f "$INVENTION_FILE" ]; then
    echo "❌ Error: Invention file not found: $INVENTION_FILE"
    echo ""
    echo "Active inventions:"
    ls inventions/active/*.md 2>/dev/null | sed 's/.*\//  - /' | sed 's/\.md//' || echo "  (none yet)"
    echo ""
    echo "Create one with: ./inventions/scripts/new-invention.sh"
    exit 1
fi

# Extract metadata from file
PROMISE=$(grep "completion_promise:" "$INVENTION_FILE" | head -1 | cut -d'"' -f2 || echo "INVENTION COMPLETE: ${INVENTION_NAME}")
MAX_ITER=$(grep "estimated_iterations:" "$INVENTION_FILE" | head -1 | awk '{print $2}' || echo "20")

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

read -p "Ready to start building this invention? (y/n): " CONFIRM
if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
    echo "Cancelled."
    exit 0
fi

# Create Rube Goldberg loop state
mkdir -p .claude

cat > .claude/rube-goldberg-loop.local.md << EOF
---
active: true
iteration: 1
max_iterations: $MAX_ITER
completion_promise: "$PROMISE"
started_at: "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
invention: "$INVENTION_NAME"
---

BUILD DIGITAL INVENTION: ${INVENTION_NAME}

Read the complete specification in: ${INVENTION_FILE}

IMPORTANT INSTRUCTIONS:

1. **Read the entire specification carefully**
   - Understand the problem being solved
   - Understand the proposed solution
   - Review all build steps

2. **Execute each phase sequentially**
   - Follow the build plan step-by-step
   - Complete each step fully before moving to next
   - Verify each step succeeded before continuing

3. **Test thoroughly**
   - Run all test cases defined in the spec
   - Test edge cases
   - Verify error handling

4. **Document as you go**
   - Add notes to "Rube Goldberg Iteration Log" in the spec file
   - Document what worked and what failed
   - Explain fixes applied

5. **Verify success criteria**
   - Check ALL success criteria boxes
   - Don't output the completion promise until EVERYTHING works

6. **When truly complete**
   Output ONLY when the invention demonstrably works:
   <promise>$PROMISE</promise>

CRITICAL: Do NOT output the promise unless the invention ACTUALLY WORKS end-to-end!

If you get stuck after multiple iterations:
- Document the issue in the spec file
- Explain what's blocking progress
- Suggest solutions for the inventor to review

BEGIN building the invention now.
EOF

echo ""
echo "✅ Rube Goldberg loop activated!"
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
