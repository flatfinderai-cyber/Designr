---
applyTo: automation/**
---

# Automation Folder Instructions

This folder contains the Dev Tool Setup Automation System that uses Ralph Wiggum loops to automatically install and configure development tools.

## Purpose

Transform complex setup instructions into automated workflows that Ralph executes without manual intervention.

## Key Concepts

### Ralph Loop Architecture
- **Workflow Files** (`automation/workflows/*.md`) - Detailed setup instructions
- **Ralph Control** (`.claude/ralph-loop.local.md`) - Loop configuration
- **Scripts** (`automation/scripts/`) - Helper utilities
- **Templates** (`automation/templates/`) - Workflow templates

### Workflow Structure
Every workflow must include:
1. **Tool metadata** (YAML frontmatter with tool_name, purpose, platform)
2. **Step-by-step instructions** with clear commands
3. **Verification steps** for each command
4. **Success criteria** checklist
5. **Completion promise** (e.g., `<promise>SETUP COMPLETE</promise>`)

## Code Style for Automation

### Bash Scripts
```bash
#!/bin/bash
# Description of what script does

set -e  # Exit on error

# Use descriptive prompts
read -p "What are you setting up? (e.g., 'docker'): " WORKFLOW_NAME

# Sanitize inputs
WORKFLOW_NAME=$(echo "$WORKFLOW_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
```

### Workflow Markdown Files
- Start with YAML frontmatter: `tool_name`, `purpose`, `platform`
- Use clear section headers: `## Step 1: Install X`
- Always include verification: `**Verify:** command to check`
- Include expected output: `**Expected:** what success looks like`
- End with success criteria checklist

### Templates
- Keep templates generic and reusable
- Include inline documentation
- Provide clear examples

## Common Patterns

### Creating New Workflows
```bash
./automation/quick-start.sh <tool-name>
# Edit automation/workflows/<tool-name>-setup.md
# Add detailed steps with verification
./automation/start-ralph.sh <tool-name>
```

### Verification Commands
Always add verification after each step:
```markdown
**Verify:** `command --version`
**Expected:** Version 1.2.3 or higher
```

### Completion Promises
Use unique, searchable promises:
```markdown
<promise>DOCKER SETUP COMPLETE</promise>
<promise>NODE.JS ENVIRONMENT READY</promise>
```

## Testing Guidelines

### Before Committing Scripts
```bash
# Check syntax
bash -n automation/scripts/your-script.sh

# Verify it's executable
chmod +x automation/scripts/your-script.sh

# Test with dry run if possible
./automation/scripts/your-script.sh
```

### Workflow Testing
- Test workflows in isolated environments
- Verify each step independently
- Ensure cleanup on failure
- Document troubleshooting steps

## Ralph Best Practices

### DO:
- Be specific with verification commands
- Set realistic max_iterations (15-30 for complex setups)
- Define clear success criteria
- Use completion promises to prevent infinite loops
- Add troubleshooting sections

### DON'T:
- Leave verification steps vague
- Set max_iterations too low (Ralph might not finish)
- Forget the completion promise (Ralph runs forever!)
- Mix multiple unrelated setups in one workflow
- Use placeholder implementations

## File Naming Conventions

- Workflow files: `<tool-name>-setup.md` (e.g., `docker-setup.md`)
- Scripts: `kebab-case.sh` (e.g., `start-ralph.sh`)
- Templates: `descriptive-name-template.md`

## Common Tasks

### Add New Workflow Template
1. Create file in `automation/templates/`
2. Include complete YAML frontmatter
3. Add example steps with verification
4. Document in `automation/HOW-TO-USE.md`

### Update Helper Script
1. Edit script in `automation/scripts/`
2. Test syntax: `bash -n script.sh`
3. Verify functionality
4. Update documentation if behavior changes

### Improve Ralph Instructions
1. Identify repeated failures in workflows
2. Add clarification to workflow markdown
3. Update completion criteria
4. Test with fresh Ralph loop

## Integration Points

- **Quick Start**: `./automation/quick-start.sh` creates new workflows
- **Start Ralph**: `./automation/start-ralph.sh` launches automation
- **Verification**: `./automation/scripts/verify-installation.sh` checks installs
- **Documentation**: All guides in `automation/*.md` files

## Security Considerations

- Scripts run with user permissions
- No secrets in workflow files
- Use environment variables for sensitive data
- Review auto-accept permissions carefully
- Git commits are automatic (use .gitignore properly)

## Performance Notes

- Script execution should be < 5 seconds
- Ralph iterations: 1-3 minutes each typical
- Complex setups: 20-40 iterations expected
- Use parallel subagents for searches only

## Documentation Standards

When updating automation documentation:
- Update HOW-TO-USE.md for user-facing changes
- Update README.md for system architecture changes
- Keep AUTO-ACCEPT-SETUP.md current with permission patterns
- Add examples to templates when introducing new patterns
