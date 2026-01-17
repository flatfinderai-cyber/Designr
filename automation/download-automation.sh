#!/bin/bash
set -e

# Quick Download Script for Designr Automation System
# This script downloads only the automation directory from GitHub

REPO_URL="https://github.com/flatfinderai-cyber/Designr"
BRANCH="${1:-main}"
OUTPUT_DIR="${2:-./designr-automation}"

echo "🚀 Downloading Designr Automation System"
echo "=========================================="
echo ""
echo "📦 Repository: $REPO_URL"
echo "🌿 Branch: $BRANCH"
echo "📁 Output: $OUTPUT_DIR"
echo ""

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "❌ Error: git is not installed"
    echo "Please install git first: https://git-scm.com/downloads"
    exit 1
fi

# Check if output directory already exists
if [ -d "$OUTPUT_DIR" ]; then
    echo "⚠️  Directory $OUTPUT_DIR already exists"
    read -p "Overwrite? (y/n) " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "❌ Cancelled"
        exit 1
    fi
    rm -rf "$OUTPUT_DIR"
fi

# Clone with sparse checkout
echo "📥 Cloning repository (sparse checkout)..."
git clone --filter=blob:none --sparse "$REPO_URL" "$OUTPUT_DIR"

cd "$OUTPUT_DIR"

# Checkout only automation directory
echo "📂 Checking out automation directory..."
git sparse-checkout set automation

# Also get essential root files
git sparse-checkout add ralph-setup-template.md
git sparse-checkout add README.md

# Checkout the specified branch
if [ "$BRANCH" != "main" ]; then
    echo "🌿 Switching to branch: $BRANCH..."
    git checkout "$BRANCH"
fi

# Move automation contents to root of output directory
if [ -d "automation" ]; then
    echo "📦 Reorganizing files..."
    mv automation/* .
    mv automation/.* . 2>/dev/null || true
    rmdir automation
fi

# Make scripts executable
echo "🔐 Setting script permissions..."
chmod +x *.sh 2>/dev/null || true
chmod +x scripts/*.sh 2>/dev/null || true

echo ""
echo "✅ Download complete!"
echo ""
echo "📁 Location: $OUTPUT_DIR"
echo ""
echo "🚀 Quick start:"
echo "   cd $OUTPUT_DIR"
echo "   ./quick-start.sh my-tool"
echo ""
echo "📖 Documentation:"
echo "   cat README.md"
echo "   cat HOW-TO-USE.md"
echo ""
