---
tool_name: "Claude Code + Rube Goldberg Plugin"
purpose: "Complete Claude Code development environment with Rube Goldberg plugin"
platform: "macos"
---

# Claude Code + Rube Goldberg Plugin Setup

Complete automated setup for Claude Code CLI with Rube Goldberg plugin and optimal configuration.

## Prerequisites

- macOS 10.15 or higher (or Linux)
- Admin privileges
- Internet connection

---

## Installation Steps

### Phase 1: System Dependencies

**Step 1: Install Xcode Command Line Tools (macOS only)**
```bash
# Check if already installed
if ! xcode-select -p &>/dev/null; then
  echo "Installing Xcode Command Line Tools..."
  xcode-select --install
  # Wait for installation to complete
  echo "Please complete the popup installation, then re-run this script"
  exit 1
else
  echo "✓ Xcode Command Line Tools already installed"
fi
```
**Verify:** `xcode-select -p` outputs a path
**Expected:** /Library/Developer/CommandLineTools

**Step 2: Install Homebrew (if needed)**
```bash
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Add to PATH
  if [[ -f "$HOME/.zprofile" ]]; then
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
else
  echo "✓ Homebrew already installed"
  brew update
fi
```
**Verify:** `brew --version` outputs version
**Expected:** Homebrew 4.x.x or higher

**Step 3: Install Essential Tools**
```bash
# Tools needed for Claude Code and automation
brew install jq curl git
```
**Verify:** `jq --version && git --version`
**Expected:** All commands output versions

### Phase 2: Claude Code Installation

**Step 4: Install Claude Code CLI**
```bash
# Official installation method
curl -fsSL https://claude.ai/install.sh | bash

# Alternative: Manual download if needed
# Check https://code.claude.com for latest release
```
**Verify:** Installation completes without errors
**Expected:** "Claude Code installed successfully" message

**Step 5: Add Claude to PATH**
```bash
# Determine shell config file
if [[ -n "${ZDOTDIR:-}" ]] && [[ -f "$ZDOTDIR/.zshrc" ]]; then
  SHELL_RC="$ZDOTDIR/.zshrc"
elif [[ -f "$HOME/.zshrc" ]]; then
  SHELL_RC="$HOME/.zshrc"
elif [[ -f "$HOME/.bashrc" ]]; then
  SHELL_RC="$HOME/.bashrc"
else
  SHELL_RC="$HOME/.profile"
fi

# Add Claude to PATH if not already there
if ! grep -q "\.claude/bin" "$SHELL_RC"; then
  echo '' >> "$SHELL_RC"
  echo '# Claude Code CLI' >> "$SHELL_RC"
  echo 'export PATH="$HOME/.claude/bin:$PATH"' >> "$SHELL_RC"
  echo "Added Claude to PATH in $SHELL_RC"
fi

# Load in current shell
export PATH="$HOME/.claude/bin:$PATH"
```
**Verify:** `claude --version`
**Expected:** Claude Code version number

**Step 6: Authenticate Claude Code**
```bash
# Start authentication flow
claude auth login

# Follow the prompts to authenticate
# This will open a browser window
```
**Verify:** `claude auth status`
**Expected:** "Authenticated as [your email]"

### Phase 3: Rube Goldberg Plugin Setup

**Step 7: Verify Rube Goldberg Plugin**
```bash
# Rube Goldberg is built into Claude Code
# Check that it's available
claude --help | grep -i rube-goldberg || echo "Rube Goldberg should be available via /rube-goldberg-loop command"
```
**Verify:** Rube Goldberg commands exist
**Expected:** Plugin is built-in and available

**Step 8: Create Project Structure**
```bash
# Create a test project to verify setup
mkdir -p ~/test-claude-project
cd ~/test-claude-project

# Initialize git (Claude Code works best with git repos)
git init
git config user.name "Your Name"
git config user.email "your.email@example.com"
```
**Verify:** `git status` works
**Expected:** Initialized git repository

**Step 9: Configure Claude Code Settings**
```bash
# Create Claude settings directory
mkdir -p ~/.claude

# Create global settings with optimal configuration
cat > ~/.claude/settings.json << 'EOF'
{
  "permissions": {
    "defaultMode": "default"
  },
  "model": "claude-sonnet-4-5",
  "respectGitignore": true
}
EOF
```
**Verify:** `cat ~/.claude/settings.json`
**Expected:** Valid JSON configuration file

**Step 10: Create Project-Level Settings**
```bash
cd ~/test-claude-project
mkdir -p .claude

# Project settings with Rube Goldberg permissions
cat > .claude/settings.local.json << 'EOF'
{
  "permissions": {
    "allow": [
      "Bash",
      "Read",
      "Write",
      "Edit",
      "Skill(rube-goldberg-wiggum:*)"
    ]
  }
}
EOF
```
**Verify:** `cat .claude/settings.local.json`
**Expected:** Valid project settings

### Phase 4: Test Rube Goldberg Plugin

**Step 11: Create Test File**
```bash
cd ~/test-claude-project

# Create a simple test file
cat > test.txt << 'EOF'
This is a test file for Rube Goldberg.
EOF

git add test.txt
git commit -m "Initial test file"
```
**Verify:** `git log`
**Expected:** Commit created

**Step 12: Test Basic Claude Code**
```bash
# Test Claude Code works
cd ~/test-claude-project
echo "Testing Claude Code..." > test-output.txt

# Claude should be able to read and write files
claude --message "Read test.txt and confirm you can see it"
```
**Verify:** Claude responds successfully
**Expected:** Claude reads the file and responds

**Step 13: Create Rube Goldberg Loop Test**
```bash
cd ~/test-claude-project

# Create a simple Rube Goldberg loop state file manually
mkdir -p .claude
cat > .claude/rube-goldberg-loop.local.md << 'EOF'
---
active: true
iteration: 1
max_iterations: 3
completion_promise: "TEST COMPLETE"
started_at: "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
---

Add the text "Rube Goldberg was here!" to test.txt

When done, output: <promise>TEST COMPLETE</promise>
EOF
```
**Verify:** File created
**Expected:** Rube Goldberg loop state file exists

### Phase 5: Install Optional Tools

**Step 14: Install Node.js (for web development)**
```bash
if ! command -v node &>/dev/null; then
  echo "Installing Node.js LTS..."
  brew install node
else
  echo "✓ Node.js already installed"
fi
```
**Verify:** `node --version && npm --version`
**Expected:** v20.x.x or higher

**Step 15: Install Python (for Python projects)**
```bash
if ! command -v python3 &>/dev/null; then
  echo "Installing Python..."
  brew install python@3.11
else
  echo "✓ Python already installed"
fi
```
**Verify:** `python3 --version`
**Expected:** Python 3.11 or higher

**Step 16: Install Additional Utilities**
```bash
# Useful tools for development
brew install \
  gh \
  tree \
  ripgrep \
  fd

# GitHub CLI for PR creation (used by Claude Code)
gh auth login
```
**Verify:** `gh --version && tree --version`
**Expected:** All tools installed

### Phase 6: Verification & Testing

**Step 17: Verify Complete Installation**
```bash
echo "=== Claude Code Setup Verification ==="
echo ""

# Check Claude Code
if command -v claude &>/dev/null; then
  echo "✓ Claude Code: $(claude --version)"
else
  echo "✗ Claude Code: NOT FOUND"
  exit 1
fi

# Check authentication
if claude auth status &>/dev/null; then
  echo "✓ Authentication: OK"
else
  echo "✗ Authentication: FAILED"
  exit 1
fi

# Check settings
if [[ -f "$HOME/.claude/settings.json" ]]; then
  echo "✓ Global settings: EXISTS"
else
  echo "✗ Global settings: MISSING"
fi

# Check essential tools
for tool in jq git node npm python3; do
  if command -v $tool &>/dev/null; then
    echo "✓ $tool: INSTALLED"
  else
    echo "⚠ $tool: NOT FOUND (optional)"
  fi
done

echo ""
echo "=== Setup verification complete ==="
```
**Verify:** All checks pass
**Expected:** Green checkmarks for all critical items

**Step 18: Create Helper Scripts**
```bash
# Create a helper script for starting Claude sessions
cat > ~/start-claude.sh << 'EOF'
#!/bin/bash
# Quick Claude Code starter

PROJECT_DIR="${1:-.}"
cd "$PROJECT_DIR" || exit 1

echo "Starting Claude Code in: $(pwd)"
claude
EOF

chmod +x ~/start-claude.sh
```
**Verify:** `ls -la ~/start-claude.sh`
**Expected:** Executable script created

**Step 19: Documentation**
```bash
# Create quick reference
cat > ~/claude-quick-ref.md << 'EOF'
# Claude Code Quick Reference

## Start Claude
```bash
cd /path/to/project
claude
```

## Rube Goldberg Loop Commands
- `/rube-goldberg-loop "Your task" --max-iterations 10` - Start Rube Goldberg
- `/cancel-rube-goldberg` - Cancel active Rube Goldberg loop
- `/rube-goldberg-loop --help` - Rube Goldberg help

## Useful Commands
- `claude auth status` - Check authentication
- `claude auth login` - Re-authenticate
- `claude --help` - Full help

## Config Locations
- Global: `~/.claude/settings.json`
- Project: `.claude/settings.local.json`
- Rube Goldberg state: `.claude/rube-goldberg-loop.local.md`

## Tips
- Always work in git repositories
- Set max_iterations to prevent infinite loops
- Use completion promises for auto-stop
- Check `.claude/rube-goldberg-loop.local.md` for progress
EOF
```
**Verify:** `cat ~/claude-quick-ref.md`
**Expected:** Reference guide created

---

## Success Criteria

The setup is complete when ALL of these are true:

- [ ] `claude --version` outputs version number
- [ ] `claude auth status` shows authenticated
- [ ] Rube Goldberg plugin is accessible (built-in)
- [ ] Test project created in ~/test-claude-project
- [ ] Project settings configured
- [ ] Essential tools installed (jq, git)
- [ ] Optional tools installed (node, python)
- [ ] Helper scripts created
- [ ] Documentation created
- [ ] Test file operations work

**When ALL criteria met, output:**
```
<promise>CLAUDE CODE SETUP COMPLETE</promise>
```

---

## Post-Setup Next Steps

1. **Test Rube Goldberg:**
   ```bash
   cd ~/test-claude-project
   claude
   # Then: /rube-goldberg-loop "Add hello world function" --max-iterations 5
   ```

2. **Set up your first real project:**
   ```bash
   cd ~/your-project
   mkdir -p .claude
   claude
   ```

3. **Install the Designr invention system:**
   ```bash
   git clone <your-designr-repo>
   cd Designr
   ./inventions/scripts/new-invention.sh my-idea
   ```

4. **Read the documentation:**
   - `~/claude-quick-ref.md` - Quick reference
   - https://code.claude.com/docs - Official docs
   - Designr/INVENTOR-QUICKSTART.md - Invention system

---

## Troubleshooting

### Claude command not found
```bash
export PATH="$HOME/.claude/bin:$PATH"
source ~/.zshrc  # or ~/.bashrc
```

### Authentication issues
```bash
claude auth logout
claude auth login
```

### Rube Goldberg not working
- Ensure `.claude/settings.local.json` allows Rube Goldberg skills
- Check `Skill(rube-goldberg-wiggum:*)` is in permissions.allow

### Permission errors
Add to `.claude/settings.local.json`:
```json
{
  "permissions": {
    "defaultMode": "dontAsk",
    "allow": ["Bash", "Read", "Write", "Edit", "Skill(rube-goldberg-wiggum:*)"]
  }
}
```

---

## Notes

- This setup is optimized for macOS
- For Linux, skip Xcode step and adjust Homebrew path
- Rube Goldberg is built into Claude Code (no separate installation needed)
- The invention automation system (Designr) is separate and can be added after

---

## Iteration Log

*Rube Goldberg will document setup attempts here:*

### Iteration 1
- Attempted:
- Succeeded:
- Failed:
- Next:
