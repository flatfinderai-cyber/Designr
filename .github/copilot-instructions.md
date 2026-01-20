# GitHub Copilot Instructions for Designr

## Project Context

Designr is an automated invention and development system using Rube Goldberg iterative loops to build digital inventions 10x faster. This meta-project creates the infrastructure for zero-intervention software development.

## Repository Structure

```
Designr/
├── automation/          # Dev tool setup automation system (Rube Goldberg-powered)
├── inventions/         # Invention specifications and workflows
├── docs/              # Documentation
└── src/               # Source code
```

## Guidelines

### General Principles
- Make minimal, surgical changes - change as few lines as possible
- Always search the codebase before assuming code doesn't exist
- Test after every change
- Commit when tests pass
- Keep scripts executable with `chmod +x`
- Use absolute paths where possible in scripts

### Code Style
- **Bash Scripts**: Use `set -e` for error handling, add descriptions for all prompts
- **Markdown**: Clear headings, code blocks with language specification, keep concise
- **Naming**: `lowercase-with-dashes.md` for files, `kebab-case.sh` for scripts

### Documentation Requirements
- Document WHY, not just WHAT
- Include verification commands
- Be specific about success criteria
- Add examples when helpful

## How to Build and Test

### For Automation Scripts
```bash
# Test script syntax
bash -n automation/scripts/your-script.sh

# Run script
./automation/scripts/your-script.sh

# Verify executable permissions
ls -l automation/scripts/*.sh
```

### For Workflows
```bash
# Create new automation workflow
./automation/quick-start.sh <workflow-name>

# Start Rube Goldberg loop for automation
./automation/start-rube-goldberg.sh <workflow-name>

# Monitor Rube Goldberg progress
grep '^iteration:' .claude/rube-goldberg-loop.local.md
```

## Important Notes

- Rube Goldberg loops are the core automation mechanism
- All scripts must work from project root
- Git commits happen automatically via `report_progress`
- Specifications must be detailed and specific (not vague)
- Use subagents to extend context window for complex tasks
