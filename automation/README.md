# Dev Tool Setup Automation System

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/flatfinderai-cyber/Designr)

This system uses Rube Goldberg loops to automatically install and configure development tools based on written instructions.

---

## 🚀 Quick Start Options

### Option 1: GitHub Codespaces (Recommended)
Click the badge above to open in a pre-configured cloud environment. No local setup required!

### Option 2: Download Automation Only
See **[STANDALONE.md](STANDALONE.md)** for instructions on using just the automation system.

### Option 3: Use Full Repository
Clone the entire repository to access all Designr systems.

---

## How It Works

1. You paste setup instructions (from Claude Desktop, docs, tutorials, etc.)
2. Rube Goldberg reads the instructions and executes them step-by-step
3. If something fails, Rube Goldberg iterates and fixes it
4. Rube Goldberg verifies each step completed successfully
5. Outputs completion when everything is set up

## Core Concept

Instead of manually following 20 setup steps, you:
1. Create a setup specification file
2. Start a Rube Goldberg loop with it
3. Let Rube Goldberg execute, verify, and iterate until complete

## Directory Structure

```
automation/
├── README.md                  # This file - Overview
├── STANDALONE.md              # Standalone usage guide
├── HOW-TO-USE.md              # Detailed step-by-step instructions
├── QUICK-REFERENCE.md         # Quick reference cheat sheet
├── AUTO-ACCEPT-SETUP.md       # Rube Goldberg auto-accept configuration
├── quick-start.sh             # Create new automation workflow
├── start-rube-goldberg.sh             # Start Rube Goldberg automation loop
├── download-automation.sh     # One-command download script
├── templates/                 # Setup templates
│   └── setup-template.md      # Template for new workflows
├── workflows/                 # Your automation workflows
│   ├── example-nodejs-setup.md
│   └── claude-code-setup.md
└── scripts/                   # Helper scripts
    ├── extract-standalone.sh  # Extract automation as standalone
    ├── setup-claude-code.sh   # Setup Claude Code CLI
    ├── setup-rube-goldberg-project.sh # Setup Rube Goldberg project
    └── verify-installation.sh # Verify tool installation
```

## Quick Start

```bash
# Create a new automation workflow
./quick-start.sh my-tool

# Edit the workflow file with your setup steps
vim workflows/my-tool-setup.md

# Start Rube Goldberg to execute the automation
./start-rube-goldberg.sh my-tool
```

## Documentation

- **[QUICK-REFERENCE.md](QUICK-REFERENCE.md)** - Quick reference cheat sheet
- **[HOW-TO-USE.md](HOW-TO-USE.md)** - Detailed usage guide with examples
- **[STANDALONE.md](STANDALONE.md)** - Standalone installation options
- **[AUTO-ACCEPT-SETUP.md](AUTO-ACCEPT-SETUP.md)** - Rube Goldberg configuration

## Features

✅ **Automated Setup** - Let Rube Goldberg execute setup instructions automatically  
✅ **Error Recovery** - Rube Goldberg debugs and fixes failures automatically  
✅ **Verification** - Each step is verified before moving forward  
✅ **Iterative** - Rube Goldberg keeps trying until everything works  
✅ **Portable** - Fully standalone, works anywhere  
✅ **Cloud-Ready** - Pre-configured for GitHub Codespaces

## Examples

See [`workflows/example-nodejs-setup.md`](workflows/example-nodejs-setup.md) for a complete example of automating a Node.js environment setup.

## Support

- **Quick Questions?** Check [QUICK-REFERENCE.md](QUICK-REFERENCE.md)
- **Detailed Help?** Read [HOW-TO-USE.md](HOW-TO-USE.md)
- **Examples?** Browse [`workflows/`](workflows/) directory
