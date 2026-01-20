# Automation System - Quick Reference

## One-Command Setup

```bash
# Download automation system only
curl -fsSL https://raw.githubusercontent.com/flatfinderai-cyber/Designr/main/automation/download-automation.sh | bash

# Or open in Codespaces
# Click: https://codespaces.new/flatfinderai-cyber/Designr
```

---

## Create New Automation

```bash
./quick-start.sh <tool-name>
```

Creates:
- `workflows/<tool-name>-setup.md` - Your setup instructions
- `.claude/rube-goldberg-loop.local.md` - Rube Goldberg control file (if doesn't exist)

---

## Start Rube Goldberg Automation

```bash
./start-rube-goldberg.sh <tool-name>
```

Rube Goldberg will:
1. Read `workflows/<tool-name>-setup.md`
2. Execute each step
3. Verify success
4. Fix failures automatically
5. Iterate until complete

---

## Monitor Rube Goldberg Progress

```bash
# Check current iteration
grep '^iteration:' .claude/rube-goldberg-loop.local.md

# View Rube Goldberg's work
tail -20 .claude/rube-goldberg-loop.local.md

# View git commits (Rube Goldberg commits progress)
git log --oneline -5
```

---

## Cancel Rube Goldberg

```bash
# Stop the loop
rm .claude/rube-goldberg-loop.local.md

# Or edit and set: active: false
vim .claude/rube-goldberg-loop.local.md
```

---

## Directory Structure

```
automation/
├── workflows/              # Your automation workflows
│   ├── <tool>-setup.md     # Setup instructions
│   └── ...
├── scripts/                # Helper scripts
│   ├── extract-standalone.sh
│   ├── setup-claude-code.sh
│   └── ...
└── templates/              # Templates for new workflows
    └── setup-template.md
```

---

## Common Workflows

### Setup New Tool
```bash
./quick-start.sh postgres
vim workflows/postgres-setup.md  # Add setup steps
./start-rube-goldberg.sh postgres         # Let Rube Goldberg execute
```

### Convert Claude Instructions
1. Ask Claude Desktop for setup instructions
2. Copy the instructions
3. `./quick-start.sh <tool-name>`
4. Paste into `workflows/<tool-name>-setup.md`
5. Add verification steps
6. `./start-rube-goldberg.sh <tool-name>`

### Extract Standalone Copy
```bash
./scripts/extract-standalone.sh ~/my-automation
```

---

## Example Workflow File

```markdown
---
tool_name: "Docker"
purpose: "Container platform"
platform: "macos"
---

# Docker Setup

## Step 1: Install Docker Desktop
Download from docker.com and install.
Verify: `docker --version`

## Step 2: Start Docker
Launch Docker Desktop
Verify: `docker ps`

## Success
Output <promise>DOCKER READY</promise> when:
- [ ] Docker Desktop running
- [ ] `docker ps` works
```

---

## Rube Goldberg Loop Structure

```markdown
---
active: true
iteration: 1
max_iterations: 20
completion_promise: "SETUP COMPLETE"
started_at: "2026-01-17T00:00:00Z"
---

Execute automation/workflows/<tool>-setup.md

Complete ALL steps and verify each one.
Fix any errors that occur.
Output <promise>SETUP COMPLETE</promise> when done.
```

---

## Tips

✅ **DO:**
- Be specific in verification steps
- Set realistic max_iterations (15-30)
- Define clear success criteria
- Use completion promises

❌ **DON'T:**
- Leave verification vague
- Set max_iterations too low
- Skip the completion promise
- Mix multiple setups in one workflow

---

## Documentation

- **README.md** - System overview
- **HOW-TO-USE.md** - Detailed usage guide
- **STANDALONE.md** - Standalone installation
- **AUTO-ACCEPT-SETUP.md** - Rube Goldberg configuration
- **QUICK-REFERENCE.md** - This file

---

## Need Help?

1. Read `HOW-TO-USE.md` for detailed instructions
2. Check `workflows/example-nodejs-setup.md` for a real example
3. Review `templates/setup-template.md` for the template

---

**Ready to automate?** Run `./quick-start.sh my-tool` now! 🚀
