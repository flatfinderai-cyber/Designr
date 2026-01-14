# Setup Template

Copy this template to `automation/workflows/` and customize for your needs.

## Setup Specification

```markdown
---
tool_name: "Your Tool Name"
purpose: "What this tool does"
platform: "macos/linux/windows"
---

# SETUP INSTRUCTIONS

## Prerequisites
- List any prerequisites here
- e.g., Node.js 18+, Python 3.9+

## Installation Steps

1. **Step 1 Name**
   - What to do
   - Expected outcome
   - How to verify

2. **Step 2 Name**
   - What to do
   - Expected outcome
   - How to verify

## Verification

How to verify the entire setup is complete:
- Command to run
- Expected output

## Success Criteria

The setup is complete when:
- [ ] Tool is installed
- [ ] Configuration is correct
- [ ] Test command runs successfully
```

## Example: Docker Setup

```markdown
---
tool_name: "Docker"
purpose: "Container platform"
platform: "macos"
---

# SETUP INSTRUCTIONS

## Prerequisites
- macOS 10.15 or higher
- Admin privileges

## Installation Steps

1. **Download Docker Desktop**
   - Visit docker.com/products/docker-desktop
   - Download for Mac
   - Verify download completed

2. **Install Docker Desktop**
   - Open the .dmg file
   - Drag to Applications
   - Launch Docker Desktop
   - Complete initial setup wizard

3. **Verify Installation**
   - Run: `docker --version`
   - Run: `docker run hello-world`
   - Both should succeed

## Success Criteria

- [ ] `docker --version` outputs version info
- [ ] `docker run hello-world` runs successfully
- [ ] Docker Desktop appears in Applications
```
