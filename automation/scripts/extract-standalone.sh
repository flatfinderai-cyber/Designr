#!/bin/bash
set -e

# Extract Automation System as Standalone
# Usage: ./extract-standalone.sh [output-directory]

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AUTOMATION_DIR="$(dirname "$SCRIPT_DIR")"
REPO_ROOT="$(dirname "$AUTOMATION_DIR")"

OUTPUT_DIR="${1:-$HOME/automation-standalone}"

echo "🔧 Designr Automation System - Standalone Extraction"
echo "=================================================="
echo ""
echo "📂 Source: $AUTOMATION_DIR"
echo "📁 Output: $OUTPUT_DIR"
echo ""

# Confirm action
read -p "Extract automation system to $OUTPUT_DIR? (y/n) " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Cancelled"
    exit 1
fi

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Copy automation directory
echo "📦 Copying automation files..."
rsync -av --progress \
    "$AUTOMATION_DIR/" \
    "$OUTPUT_DIR/" \
    --exclude='.git' \
    --exclude='node_modules' \
    --exclude='*.log' \
    --exclude='.DS_Store'

# Copy essential root files if they exist
echo "📄 Copying essential documentation..."
if [ -f "$REPO_ROOT/ralph-setup-template.md" ]; then
    cp "$REPO_ROOT/ralph-setup-template.md" "$OUTPUT_DIR/"
fi

if [ -f "$REPO_ROOT/.gitignore" ]; then
    cp "$REPO_ROOT/.gitignore" "$OUTPUT_DIR/"
fi

# Create a new README at the root of standalone
cat > "$OUTPUT_DIR/README-STANDALONE.md" << 'EOF'
# Designr Automation System (Standalone)

This is a standalone copy of the Designr Automation System.

## What This Is

A system that uses Ralph Wiggum loops to automatically install and configure development tools based on written instructions.

## Quick Start

```bash
# Create a new automation workflow
./quick-start.sh my-tool-name

# Edit the workflow file
vim workflows/my-tool-name-setup.md

# Start Ralph to execute it
./start-ralph.sh my-tool-name
```

## Documentation

- **README.md** - System overview
- **HOW-TO-USE.md** - Detailed usage guide
- **STANDALONE.md** - Standalone usage instructions
- **AUTO-ACCEPT-SETUP.md** - Ralph configuration

## Directory Structure

```
automation/
├── scripts/          # Helper scripts
├── templates/        # Setup templates
└── workflows/        # Your automation workflows
```

## Requirements

- Bash shell
- Git (optional)
- Node.js 18+ (for Node.js automations)
- Python 3.11+ (for Python automations)
- Claude Code CLI or Claude Desktop (for Ralph loops)

## Source

Extracted from: https://github.com/flatfinderai-cyber/Designr

For updates, see: `automation/STANDALONE.md`
EOF

# Make scripts executable
echo "🔐 Making scripts executable..."
chmod +x "$OUTPUT_DIR"/*.sh
chmod +x "$OUTPUT_DIR"/scripts/*.sh 2>/dev/null || true

# Initialize git if requested
read -p "Initialize git repository? (y/n) " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    cd "$OUTPUT_DIR"
    git init
    git add .
    git commit -m "Initial commit: Standalone automation system"
    echo "✅ Git repository initialized"
fi

echo ""
echo "✅ Extraction complete!"
echo ""
echo "📁 Standalone automation system at: $OUTPUT_DIR"
echo ""
echo "🚀 Quick start:"
echo "   cd $OUTPUT_DIR"
echo "   ./quick-start.sh my-tool"
echo ""
