# Automation System - Standalone Usage

This guide explains how to use **only** the Designr Automation System without the rest of the repository.

---

## Option 1: GitHub Codespaces (Recommended)

**Instant cloud development environment** - No local setup required!

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/flatfinderai-cyber/Designr)

1. Click the badge above (or use the "Code" → "Codespaces" button on GitHub)
2. Wait 2-3 minutes for the environment to build
3. Navigate to the `automation/` directory
4. Start using the automation system!

**Benefits:**
- ✅ Pre-configured environment
- ✅ Node.js, Python, and all tools installed
- ✅ No local setup required
- ✅ Works from any device with a browser

---

## Option 2: Download Automation Only

If you only want the automation system files:

### Quick Download (Recommended)

Use our helper script to download only the automation system:

```bash
# Download and run the script
curl -fsSL https://raw.githubusercontent.com/flatfinderai-cyber/Designr/main/automation/download-automation.sh | bash

# Or download the script first and run it
curl -O https://raw.githubusercontent.com/flatfinderai-cyber/Designr/main/automation/download-automation.sh
chmod +x download-automation.sh
./download-automation.sh main ./my-automation
```

### Using Git (Sparse Checkout)

```bash
# Clone with sparse checkout
git clone --filter=blob:none --sparse https://github.com/flatfinderai-cyber/Designr.git
cd Designr

# Checkout only the automation directory
git sparse-checkout set automation

# You now have only the automation system
cd automation
```

### Using GitHub CLI

```bash
# Download just the automation directory
gh repo clone flatfinderai-cyber/Designr -- --filter=blob:none --sparse
cd Designr
git sparse-checkout set automation
cd automation
```

### Manual Download

1. Go to: https://github.com/flatfinderai-cyber/Designr
2. Click on the `automation` folder
3. Download individual files or use the archive method:

```bash
# Download automation directory only from archive
curl -L https://github.com/flatfinderai-cyber/Designr/archive/main.tar.gz | \
  tar xz --strip=2 Designr-main/automation
cd automation
```

---

## Option 3: Extract from Full Clone

If you already cloned the full repository:

```bash
# Create a standalone automation copy
cd /path/to/Designr
./automation/scripts/extract-standalone.sh /path/to/output
```

This creates a clean copy with only automation files.

---

## What You Get

The `automation/` directory is **fully self-contained**:

```
automation/
├── README.md                 # Overview
├── HOW-TO-USE.md             # Detailed usage guide
├── AUTO-ACCEPT-SETUP.md      # Rube Goldberg auto-accept configuration
├── quick-start.sh            # Quick start script
├── start-rube-goldberg.sh            # Start Rube Goldberg automation
├── scripts/                  # Helper scripts
│   ├── setup-rube-goldberg-project.sh
│   ├── setup-claude-code.sh
│   └── verify-installation.sh
├── templates/                # Setup templates
│   └── setup-template.md
└── workflows/                # Example workflows
    ├── example-nodejs-setup.md
    └── claude-code-setup.md
```

---

## Quick Start (After Download)

```bash
cd automation

# Create a new automation workflow
./quick-start.sh my-tool-name

# Edit the workflow file
vim workflows/my-tool-name-setup.md

# Start Rube Goldberg to execute it
./start-rube-goldberg.sh my-tool-name
```

---

## Requirements

### Minimal Requirements
- Bash shell (Linux, macOS, or WSL on Windows)
- Git (for cloning)

### For Full Functionality
- **Node.js 18+** (if automating Node.js tools)
- **Python 3.11+** (if automating Python tools)
- **Claude Code CLI** or **Claude Desktop** (for Rube Goldberg loops)

---

## Documentation

Once you have the automation directory:

1. **Start here:** `README.md` - System overview
2. **Usage guide:** `HOW-TO-USE.md` - Step-by-step instructions
3. **Examples:** `workflows/example-nodejs-setup.md` - Real-world example

---

## Why Standalone?

The automation system is designed to be **independent** and **portable**:

- ✅ No dependencies on other parts of the repository
- ✅ Works in any directory structure
- ✅ Can be copied to other projects
- ✅ Self-contained documentation

---

## Updating

If you want to get the latest version:

```bash
# If using sparse checkout
cd Designr
git pull origin main

# If using manual download, re-download
# Or use the extract script again
```

---

## Support

- **Issues:** File on the main repository
- **Questions:** Check `HOW-TO-USE.md` first
- **Examples:** See `workflows/` directory

---

## Related Systems

This repository also contains:
- **inventions/** - Rube Goldberg Loop invention system
- **DesignrLabs/** - Separate app (see separate repo)
- **YoutubeApp/** - YouTube to lesson converter

If you need those systems, clone the full repository.

---

**Ready to automate?** Start with `./quick-start.sh your-tool-name`! 🚀
