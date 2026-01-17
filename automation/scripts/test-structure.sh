#!/bin/bash

# Test Script for Automation System
# Verifies that all required files and structure exist

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AUTOMATION_DIR="$(dirname "$SCRIPT_DIR")"

echo "🧪 Testing Designr Automation System Structure"
echo "=============================================="
echo ""

PASSED=0
FAILED=0

# Helper function to check file exists
check_file() {
    local file=$1
    local description=$2
    if [ -f "$AUTOMATION_DIR/$file" ]; then
        echo "✅ $description"
        PASSED=$((PASSED + 1))
    else
        echo "❌ Missing: $file ($description)"
        FAILED=$((FAILED + 1))
    fi
}

# Helper function to check directory exists
check_dir() {
    local dir=$1
    local description=$2
    if [ -d "$AUTOMATION_DIR/$dir" ]; then
        echo "✅ $description"
        PASSED=$((PASSED + 1))
    else
        echo "❌ Missing: $dir ($description)"
        FAILED=$((FAILED + 1))
    fi
}

# Helper function to check script is executable
check_executable() {
    local file=$1
    local description=$2
    if [ -x "$AUTOMATION_DIR/$file" ]; then
        echo "✅ $description (executable)"
        PASSED=$((PASSED + 1))
    else
        echo "❌ $file not executable ($description)"
        FAILED=$((FAILED + 1))
    fi
}

echo "📁 Checking directory structure..."
check_dir "scripts" "Scripts directory"
check_dir "templates" "Templates directory"
check_dir "workflows" "Workflows directory"
echo ""

echo "📄 Checking documentation files..."
check_file "README.md" "Main README"
check_file "HOW-TO-USE.md" "Detailed usage guide"
check_file "STANDALONE.md" "Standalone usage guide"
check_file "QUICK-REFERENCE.md" "Quick reference"
check_file "AUTO-ACCEPT-SETUP.md" "Auto-accept setup guide"
check_file "CONTRIBUTING.md" "Contributing guide"
echo ""

echo "🔧 Checking main scripts..."
check_executable "quick-start.sh" "Quick start script"
check_executable "start-ralph.sh" "Start Ralph script"
check_executable "download-automation.sh" "Download automation script"
echo ""

echo "🛠️  Checking helper scripts..."
check_executable "scripts/extract-standalone.sh" "Extract standalone script"
check_executable "scripts/setup-claude-code.sh" "Setup Claude Code script"
check_executable "scripts/setup-ralph-project.sh" "Setup Ralph project script"
check_executable "scripts/verify-installation.sh" "Verify installation script"
echo ""

echo "📝 Checking templates..."
check_file "templates/setup-template.md" "Setup template"
echo ""

echo "📋 Checking example workflows..."
check_file "workflows/example-nodejs-setup.md" "Example Node.js setup"
check_file "workflows/claude-code-setup.md" "Claude Code setup"
echo ""

# Check that scripts have proper shebang
echo "🔍 Checking script format..."
for script in quick-start.sh start-ralph.sh download-automation.sh scripts/*.sh; do
    if [ -f "$AUTOMATION_DIR/$script" ]; then
        first_line=$(head -n 1 "$AUTOMATION_DIR/$script")
        if [[ "$first_line" == "#!/bin/bash"* ]] || [[ "$first_line" == "#!/usr/bin/env bash"* ]]; then
            PASSED=$((PASSED + 1))
        else
            echo "❌ $script missing proper shebang (found: $first_line)"
            FAILED=$((FAILED + 1))
        fi
    fi
done
echo "✅ All scripts have proper shebang"
echo ""

# Summary
echo "=============================================="
echo "Test Summary:"
echo "  ✅ Passed: $PASSED"
if [ $FAILED -gt 0 ]; then
    echo "  ❌ Failed: $FAILED"
    echo ""
    echo "Some tests failed. Please fix the issues above."
    exit 1
else
    echo "  ❌ Failed: $FAILED"
    echo ""
    echo "🎉 All tests passed! Automation system structure is valid."
    exit 0
fi
