#!/bin/bash
# Common shell functions for Designr automation scripts
# Source this file in your scripts: source "$(dirname "$0")/../scripts/common.sh"

# Exit on error
set -e

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Validate required parameter
# Usage: validate_param "PARAM_VALUE" "param_name" "usage_example"
validate_param() {
    local param_value="$1"
    local param_name="$2"
    local usage_example="$3"
    
    if [ -z "$param_value" ]; then
        echo "❌ Error: No $param_name provided"
        echo ""
        echo "Usage: $usage_example"
        echo ""
        return 1
    fi
    return 0
}

# Check if file exists
# Usage: check_file_exists "FILE_PATH" "error_message" "suggestion"
check_file_exists() {
    local file_path="$1"
    local error_message="$2"
    local suggestion="$3"
    
    if [ ! -f "$file_path" ]; then
        echo "❌ Error: $error_message"
        echo ""
        if [ -n "$suggestion" ]; then
            echo "$suggestion"
            echo ""
        fi
        return 1
    fi
    return 0
}

# Prompt for confirmation (y/n)
# Usage: prompt_confirm "Question text?"
# Returns: 0 if yes, 1 if no
prompt_confirm() {
    local prompt_text="$1"
    local reply
    
    read -r -p "$prompt_text (y/n): " reply
    if [[ ! "$reply" =~ ^[Yy]$ ]]; then
        echo "Cancelled."
        return 1
    fi
    return 0
}

# List available files in directory
# Usage: list_available_files "directory/*.md" "prefix"
# Note: Intentionally uses unquoted glob pattern for expansion
list_available_files() {
    local pattern="$1"
    local prefix="${2:-  - }"
    
    # Use find for safer file listing, fallback to ls for simple patterns
    if [[ "$pattern" == */* ]]; then
        local dir="${pattern%/*}"
        local glob="${pattern##*/}"
        find "$dir" -maxdepth 1 -name "$glob" 2>/dev/null | sed "s|.*/|$prefix|" | sed 's/\.md$//' || echo "  (none yet)"
    else
        # shellcheck disable=SC2012,SC2086
        ls $pattern 2>/dev/null | sed "s/.*\//$prefix/" | sed 's/\.md$//' || echo "  (none yet)"
    fi
}

# Create Rube Goldberg loop configuration
# Usage: create_rube_goldberg_loop "FILE_TO_EXECUTE" "MAX_ITER" "PROMISE" "LOOP_TYPE" ["OPTIONAL_NAME"]
create_rube_goldberg_loop() {
    local file_to_execute="$1"
    local max_iter="$2"
    local promise="$3"
    local loop_type="$4"  # "automation" or "invention"
    local optional_name="${5:-}"
    local started_at
    
    mkdir -p .claude
    
    started_at=$(date -u +%Y-%m-%dT%H:%M:%SZ)
    
    cat > .claude/rube-goldberg-loop.local.md << EOF
---
active: true
iteration: 1
max_iterations: $max_iter
completion_promise: "$promise"
started_at: "$started_at"
EOF
    
    if [ -n "$optional_name" ]; then
        echo "$loop_type: \"$optional_name\"" >> .claude/rube-goldberg-loop.local.md
    fi
    
    cat >> .claude/rube-goldberg-loop.local.md << EOF
---

EOF
    
    if [ "$loop_type" = "invention" ]; then
        cat >> .claude/rube-goldberg-loop.local.md << EOF
BUILD DIGITAL INVENTION: ${optional_name}

Read the complete specification in: ${file_to_execute}

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
   <promise>$promise</promise>

CRITICAL: Do NOT output the promise unless the invention ACTUALLY WORKS end-to-end!

If you get stuck after multiple iterations:
- Document the issue in the spec file
- Explain what's blocking progress
- Suggest solutions for the inventor to review

BEGIN building the invention now.
EOF
    else
        # Automation workflow
        cat >> .claude/rube-goldberg-loop.local.md << EOF
Execute ALL steps in $file_to_execute

Read the file carefully and execute each step in order.

For each step:
1. Execute the commands
2. Verify success using the verification steps
3. If it fails, debug and fix before proceeding
4. Document what you did

When ALL steps are complete and all success criteria are met, output:
<promise>$promise</promise>

IMPORTANT: Only output the promise when EVERYTHING is truly complete and verified.
EOF
    fi
    
    return 0
}

# Echo with status icon
# Usage: echo_status "success|error|info|warning" "message"
echo_status() {
    local status="$1"
    local message="$2"
    
    case "$status" in
        success)
            echo "✅ $message"
            ;;
        error)
            echo "❌ Error: $message"
            ;;
        info)
            echo "ℹ️  $message"
            ;;
        warning)
            echo "⚠️  $message"
            ;;
        *)
            echo "$message"
            ;;
    esac
}

# Sanitize input string (lowercase, replace spaces with dashes)
# Usage: sanitized=$(sanitize_name "My Project Name")
sanitize_name() {
    local input="$1"
    echo "$input" | tr '[:upper:]' '[:lower:]' | tr ' ' '-'
}

# Extract value from YAML frontmatter
# Usage: value=$(extract_yaml_value "filename.md" "key_name" "default_value")
# Limitation: Assumes simple YAML values without colons inside quoted strings
# For complex YAML parsing, consider using yq or a proper YAML parser
extract_yaml_value() {
    local file="$1"
    local key="$2"
    local default="${3:-}"
    local value
    
    # Try to extract quoted value first
    value=$(grep "^${key}:" "$file" | head -1 | sed -n 's/^[^:]*: *"\([^"]*\)".*/\1/p')
    
    # If no quoted value, try unquoted value
    if [ -z "$value" ]; then
        value=$(grep "^${key}:" "$file" | head -1 | sed -n 's/^[^:]*: *\([^ ]*\).*/\1/p')
    fi
    
    if [ -z "$value" ]; then
        echo "$default"
    else
        echo "$value"
    fi
}
