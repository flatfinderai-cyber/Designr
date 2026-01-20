#!/bin/bash
# Quick Start: Create a new automation workflow

set -e

echo "🚀 Dev Tool Setup Automation - Quick Start"
echo ""

# Get workflow name
read -p "What are you setting up? (e.g., 'docker', 'python-env'): " WORKFLOW_NAME

# Sanitize name
WORKFLOW_NAME=$(echo "$WORKFLOW_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
WORKFLOW_FILE="workflows/${WORKFLOW_NAME}-setup.md"

echo ""
echo "📝 Creating workflow file: $WORKFLOW_FILE"

# Create workflow from template
cat > "$WORKFLOW_FILE" << 'EOF'
---
tool_name: "YOUR TOOL NAME"
purpose: "What this tool does"
platform: "macos"
---

# SETUP INSTRUCTIONS

Paste your setup instructions below:

## Step 1: First Step
- Command or action
- Verify: How to check it worked

## Step 2: Next Step
- Command or action
- Verify: How to check it worked

## Success Criteria

The setup is complete when:
- [ ] First criterion
- [ ] Second criterion

Output <promise>SETUP COMPLETE</promise> when all criteria are met.
EOF

echo "✅ Created: $WORKFLOW_FILE"
echo ""
echo "📋 Next steps:"
echo "   1. Edit $WORKFLOW_FILE"
echo "   2. Paste your setup instructions"
echo "   3. Add verification steps"
echo "   4. Run: ./automation/start-rube-goldberg.sh $WORKFLOW_NAME"
echo ""
echo "📖 For detailed help: cat automation/HOW-TO-USE.md"
