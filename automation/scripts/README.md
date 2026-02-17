# Automation Scripts

This directory contains shared utilities and helper scripts for the Designr automation system.

## Common Library (`common.sh`)

The `common.sh` file provides reusable shell functions to reduce code duplication across automation scripts.

### Usage

Source the common library in your script:

```bash
#!/bin/bash
# Source common functions
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"
```

### Available Functions

#### Parameter Validation

**`validate_param()`**
- Validates that a required parameter is not empty
- Usage: `validate_param "PARAM_VALUE" "param_name" "usage_example"`
- Returns: 0 if valid, 1 if empty (exits with error message)

Example:
```bash
if ! validate_param "$PROJECT_NAME" "project name" "./script.sh <project-name>"; then
    exit 1
fi
```

#### File Operations

**`check_file_exists()`**
- Checks if a file exists and shows helpful error message if not
- Usage: `check_file_exists "FILE_PATH" "error_message" "suggestion"`
- Returns: 0 if file exists, 1 if not

Example:
```bash
if ! check_file_exists "$CONFIG_FILE" "Config not found" "Run ./setup.sh first"; then
    exit 1
fi
```

**`list_available_files()`**
- Lists files matching a pattern in a directory
- Usage: `list_available_files "directory/*.md" "prefix"`
- Default prefix: `  - `

Example:
```bash
echo "Available workflows:"
list_available_files "automation/workflows/*.md"
```

#### User Interaction

**`prompt_confirm()`**
- Prompts user for yes/no confirmation
- Usage: `prompt_confirm "Question text?"`
- Returns: 0 if yes, 1 if no

Example:
```bash
if ! prompt_confirm "Continue with installation?"; then
    exit 0
fi
```

#### Rube Goldberg Loop Management

**`create_rube_goldberg_loop()`**
- Creates a Rube Goldberg loop configuration file
- Usage: `create_rube_goldberg_loop "FILE_TO_EXECUTE" "MAX_ITER" "PROMISE" "LOOP_TYPE" ["OPTIONAL_NAME"]`
- Loop types: `"automation"` or `"invention"`

Example:
```bash
create_rube_goldberg_loop "$WORKFLOW_FILE" "20" "SETUP COMPLETE" "automation" "docker"
```

#### Output Functions

**`echo_status()`**
- Prints a message with appropriate status icon
- Usage: `echo_status "success|error|info|warning" "message"`
- Status types:
  - `success`: ✅ prefix
  - `error`: ❌ prefix
  - `info`: ℹ️ prefix
  - `warning`: ⚠️ prefix

Example:
```bash
echo_status "success" "Installation complete!"
echo_status "error" "Failed to connect to server"
```

#### String Utilities

**`sanitize_name()`**
- Converts a string to lowercase and replaces spaces with dashes
- Usage: `sanitized=$(sanitize_name "My Project Name")`
- Returns: sanitized string

Example:
```bash
PROJECT_NAME=$(sanitize_name "$USER_INPUT")
# "My Cool Project" becomes "my-cool-project"
```

#### YAML Parsing

**`extract_yaml_value()`**
- Extracts a value from YAML frontmatter
- Usage: `value=$(extract_yaml_value "filename.md" "key_name" "default_value")`
- Returns: extracted value or default if not found

Example:
```bash
MAX_ITER=$(extract_yaml_value "$SPEC_FILE" "estimated_iterations" "20")
```

## Scripts

### `setup-rube-goldberg-project.sh`
Creates a new project with AGENTS.md and Rube Goldberg infrastructure.

**Usage:**
```bash
./setup-rube-goldberg-project.sh <project-name> <language> [project-type]
```

**Examples:**
```bash
./setup-rube-goldberg-project.sh task-manager python cli-tool
./setup-rube-goldberg-project.sh my-api typescript api
```

### `verify-installation.sh`
Verifies that automation system components are properly installed.

### `extract-standalone.sh`
Extracts the automation system for use in standalone projects.

### `test-structure.sh`
Tests the automation directory structure and file organization.

### `setup-claude-code.sh`
Sets up Claude Code CLI integration for Rube Goldberg automation.

## Security Considerations

All scripts have been checked with `shellcheck` to ensure:
- Proper quoting to prevent injection attacks
- Use of `-r` flag with `read` to handle backslashes safely
- Proper error handling with `set -e`
- No unsafe variable expansions

## Contributing

When adding new functions to `common.sh`:
1. Add clear documentation comments
2. Include usage examples
3. Follow the existing naming conventions
4. Test with `shellcheck` before committing
5. Update this README with the new function

## Testing

Run shellcheck on all scripts:
```bash
find automation/scripts -name "*.sh" -exec shellcheck {} \;
```

Test syntax of all scripts:
```bash
find automation/scripts -name "*.sh" -exec bash -n {} \;
```
