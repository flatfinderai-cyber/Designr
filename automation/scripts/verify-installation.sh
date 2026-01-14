#!/bin/bash
# Generic verification script for checking if tools are installed

set -e

# Usage: ./verify-installation.sh <command> [expected_output]
# Example: ./verify-installation.sh "node --version" "v18"

COMMAND="$1"
EXPECTED="${2:-}"

echo "🔍 Verifying: $COMMAND"

if OUTPUT=$(eval "$COMMAND" 2>&1); then
    echo "✅ Command executed successfully"
    echo "📋 Output: $OUTPUT"

    if [ -n "$EXPECTED" ]; then
        if echo "$OUTPUT" | grep -q "$EXPECTED"; then
            echo "✅ Output contains expected string: $EXPECTED"
            exit 0
        else
            echo "❌ Output does NOT contain expected string: $EXPECTED"
            exit 1
        fi
    fi
    exit 0
else
    echo "❌ Command failed with exit code $?"
    echo "📋 Output: $OUTPUT"
    exit 1
fi
