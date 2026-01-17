# Dev Tool Setup Automation System

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/flatfinderai-cyber/Designr)

This system uses Ralph Wiggum loops to automatically install and configure development tools based on written instructions.

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
2. Ralph reads the instructions and executes them step-by-step
3. If something fails, Ralph iterates and fixes it
4. Ralph verifies each step completed successfully
5. Outputs completion when everything is set up

## Core Concept

Instead of manually following 20 setup steps, you:
1. Create a setup specification file
2. Start a Ralph loop with it
3. Let Ralph execute, verify, and iterate until complete

## Directory Structure

```
automation/
├── README.md                 # This file
├── STANDALONE.md             # Standalone usage guide
├── HOW-TO-USE.md             # Detailed instructions
├── AUTO-ACCEPT-SETUP.md      # Ralph configuration
├── quick-start.sh            # Quick start script
├── start-ralph.sh            # Start Ralph automation
├── templates/                # Setup templates for common tools
├── workflows/                # Your custom setup workflows
└── scripts/                  # Helper scripts
    ├── extract-standalone.sh # Extract automation only
    └── ...                   # Other helper scripts
```
