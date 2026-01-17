#!/usr/bin/env bash
#
# Claude Code + Ralph Plugin - Complete Setup Script
# Works on macOS and Linux, CI-friendly and non-interactive mode supported
#
# Usage: ./setup-claude-code.sh [-y|--yes]
#

set -euo pipefail

# ============================================================
# Non-interactive mode detection
# ============================================================
NONINTERACTIVE="${NONINTERACTIVE:-0}"
if [[ "${CI:-false}" == "true" ]]; then
  NONINTERACTIVE=1
fi

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
    -y|--yes)
      NONINTERACTIVE=1
      shift
      ;;
    *)
      echo "Unknown option: $1"
      echo "Usage: $0 [-y|--yes]"
      exit 1
      ;;
  esac
done

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

log()    { echo -e "${BLUE}▶${NC} $1"; }
ok()     { echo -e "${GREEN}✓${NC} $1"; }
fail()   { echo -e "${RED}✗${NC} $1"; }
warn()   { echo -e "${YELLOW}⚠${NC} $1"; }

# ============================================================
# Cross-platform package installer helper
# ============================================================
install_pkg() {
  local pkg="$1"
  local apt_pkg="${2:-$pkg}"  # Allow custom apt package name
  
  if command -v brew &>/dev/null; then
    log "Installing $pkg via Homebrew..."
    brew install "$pkg" &>/dev/null || { warn "Failed to install $pkg via brew (continuing)"; return 0; }
  elif command -v apt-get &>/dev/null; then
    log "Installing $apt_pkg via apt-get..."
    sudo apt-get update -qq &>/dev/null || true
    sudo apt-get install -y "$apt_pkg" &>/dev/null || { warn "Failed to install $apt_pkg via apt-get (continuing)"; return 0; }
  else
    warn "No supported package manager found. Please install $pkg manually."
    return 0
  fi
  ok "$pkg installed"
}

# ============================================================
# Detect OS
# ============================================================
OS="$(uname -s || echo unknown)"

case "$OS" in
  Darwin) PLATFORM="macos" ;;
  Linux)  PLATFORM="linux" ;;
  *)      fail "Unsupported OS: $OS"; exit 1 ;;
esac

log "Detected platform: $PLATFORM"

# ============================================================
# Phase 1: System Dependencies
# ============================================================
echo ""
log "Phase 1: Installing System Dependencies"
echo ""

# macOS: Xcode Command Line Tools
if [[ "$PLATFORM" == "macos" ]]; then
  if ! xcode-select -p &>/dev/null; then
    log "Installing Xcode Command Line Tools..."
    xcode-select --install || true
    warn "Accept the popup and re-run this script after installation completes."
    exit 0
  else
    ok "Xcode Command Line Tools installed"
  fi
fi

# Homebrew
if ! command -v brew &>/dev/null; then
  if [[ "$PLATFORM" == "macos" ]]; then
    log "Installing Homebrew..."
    if [[ "$NONINTERACTIVE" == "1" ]]; then
      NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || warn "Homebrew install failed (continuing)"
    else
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    # Add to PATH
    if [[ -f "$HOME/.zprofile" ]]; then
      if ! grep -q "/opt/homebrew/bin/brew" "$HOME/.zprofile" 2>/dev/null; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
      fi
      eval "$(/opt/homebrew/bin/brew shellenv)" 2>/dev/null || true
    fi
    ok "Homebrew installed"
  else
    warn "Homebrew not available on Linux (will use apt-get where available)"
  fi
else
  ok "Homebrew already installed"
  brew update &>/dev/null || true
fi

# Essential tools
log "Installing essential tools (jq, git)..."
install_pkg jq jq
install_pkg git git
install_pkg curl curl
ok "Essential tools installed"

# ============================================================
# Phase 2: Claude Code Installation
# ============================================================
echo ""
log "Phase 2: Installing Claude Code CLI"
echo ""

if command -v claude &>/dev/null; then
  ok "Claude Code already installed: $(claude --version 2>/dev/null || echo 'unknown version')"
else
  log "Downloading and installing Claude Code..."
  
  # Download installer to temp file for safer execution in CI
  INSTALLER_URL="https://claude.ai/install.sh"
  INSTALLER_SCRIPT="/tmp/claude-install-$$.sh"
  
  if curl -fsSL "$INSTALLER_URL" -o "$INSTALLER_SCRIPT" 2>/dev/null; then
    chmod +x "$INSTALLER_SCRIPT"
    if [[ "$NONINTERACTIVE" == "1" ]]; then
      NONINTERACTIVE=1 bash "$INSTALLER_SCRIPT" || warn "Claude Code installer failed (continuing to verification)"
    else
      bash "$INSTALLER_SCRIPT"
    fi
    rm -f "$INSTALLER_SCRIPT"
  else
    warn "Could not download Claude Code installer from $INSTALLER_URL (continuing to verification)"
  fi

  # Add to PATH
  if [[ -n "${ZDOTDIR:-}" ]] && [[ -f "$ZDOTDIR/.zshrc" ]]; then
    SHELL_RC="$ZDOTDIR/.zshrc"
  elif [[ -f "$HOME/.zshrc" ]]; then
    SHELL_RC="$HOME/.zshrc"
  elif [[ -f "$HOME/.bashrc" ]]; then
    SHELL_RC="$HOME/.bashrc"
  else
    SHELL_RC="$HOME/.profile"
  fi

  if ! grep -q "\.claude/bin" "$SHELL_RC" 2>/dev/null; then
    {
      echo ''
      echo '# Claude Code CLI'
      echo 'export PATH="$HOME/.claude/bin:$PATH"'
    } >> "$SHELL_RC"
  fi

  export PATH="$HOME/.claude/bin:$PATH"
  
  if command -v claude &>/dev/null; then
    ok "Claude Code installed"
  else
    warn "Claude Code command not found after install attempt"
  fi
fi

# ============================================================
# Phase 3: Configuration
# ============================================================
echo ""
log "Phase 3: Configuring Claude Code"
echo ""

# Global settings
mkdir -p "$HOME/.claude"

if [[ ! -f "$HOME/.claude/settings.json" ]]; then
  log "Creating global settings..."
  cat > "$HOME/.claude/settings.json" << 'EOF'
{
  "permissions": {
    "defaultMode": "default"
  },
  "model": "claude-sonnet-4-5",
  "respectGitignore": true
}
EOF
  ok "Global settings created"
else
  ok "Global settings already exist"
fi

# ============================================================
# Phase 4: Test Project Setup
# ============================================================
echo ""
log "Phase 4: Creating Test Project"
echo ""

TEST_PROJECT="$HOME/test-claude-project"

if [[ ! -d "$TEST_PROJECT" ]]; then
  mkdir -p "$TEST_PROJECT"
  cd "$TEST_PROJECT"

  # Initialize git
  git init &>/dev/null
  git config user.name "Test User" 2>/dev/null || true
  git config user.email "test@example.com" 2>/dev/null || true

  # Create test file
  echo "This is a test file for Claude Code." > test.txt
  git add test.txt
  git commit -m "Initial commit" &>/dev/null || true

  # Project settings
  mkdir -p .claude
  cat > .claude/settings.local.json << 'EOF'
{
  "permissions": {
    "allow": [
      "Bash",
      "Read",
      "Write",
      "Edit",
      "Skill(ralph-wiggum:*)"
    ]
  }
}
EOF

  ok "Test project created: $TEST_PROJECT"
else
  ok "Test project already exists: $TEST_PROJECT"
fi

# ============================================================
# Phase 5: Optional Tools
# ============================================================
echo ""
log "Phase 5: Installing Optional Development Tools"
echo ""

# Node.js
if ! command -v node &>/dev/null; then
  install_pkg node nodejs
else
  ok "Node.js already installed: $(node --version)"
fi

# Python
if ! command -v python3 &>/dev/null; then
  install_pkg python@3.11 python3
else
  ok "Python already installed: $(python3 --version)"
fi

# GitHub CLI
if ! command -v gh &>/dev/null; then
  install_pkg gh gh
else
  ok "GitHub CLI already installed"
fi

# Other useful tools
log "Installing additional utilities..."
install_pkg tree tree
install_pkg ripgrep ripgrep
install_pkg fd fd-find  # Debian uses fd-find package name

# ============================================================
# Phase 6: Helper Scripts & Documentation
# ============================================================
echo ""
log "Phase 6: Creating Helper Scripts"
echo ""

# Quick start script
cat > "$HOME/start-claude.sh" << 'EOF'
#!/bin/bash
# Quick Claude Code starter

PROJECT_DIR="${1:-.}"
cd "$PROJECT_DIR" || exit 1

echo "Starting Claude Code in: $(pwd)"
claude
EOF

chmod +x "$HOME/start-claude.sh"
ok "Created ~/start-claude.sh"

# Quick reference
cat > "$HOME/claude-quick-ref.md" << 'EOF'
# Claude Code Quick Reference

## Start Claude
```bash
cd /path/to/project
claude
```

## Ralph Loop Commands
- `/ralph-loop "Your task" --max-iterations 10` - Start Ralph
- `/cancel-ralph` - Cancel active Ralph loop
- `/ralph-loop --help` - Ralph help

## Useful Commands
- `claude auth status` - Check authentication
- `claude auth login` - Re-authenticate
- `claude --version` - Show version
- `claude --help` - Full help

## Config Locations
- Global: `~/.claude/settings.json`
- Project: `.claude/settings.local.json`
- Ralph state: `.claude/ralph-loop.local.md`

## Ralph Loop Structure
Create `.claude/ralph-loop.local.md`:
```markdown
---
active: true
iteration: 1
max_iterations: 20
completion_promise: "TASK COMPLETE"
started_at: "2026-01-11T22:00:00Z"
---

Your task description here
```

## Tips
- Always work in git repositories
- Set max_iterations to prevent infinite loops
- Use completion promises for auto-stop
- Check `.claude/ralph-loop.local.md` for progress
- Ralph is built into Claude Code (no separate install needed)

## Common Project Setup
```bash
cd my-project
mkdir -p .claude
cat > .claude/settings.local.json << 'JSON'
{
  "permissions": {
    "allow": ["Bash", "Read", "Write", "Edit", "Skill(ralph-wiggum:*)"]
  }
}
JSON
claude
```
EOF

ok "Created ~/claude-quick-ref.md"

# ============================================================
# Phase 7: Verification
# ============================================================
echo ""
log "Phase 7: Verifying Installation"
echo ""

ERRORS=0

# Check Claude Code
if command -v claude &>/dev/null; then
  VERSION=$(claude --version 2>/dev/null || echo "unknown")
  ok "Claude Code: $VERSION"
else
  fail "Claude Code: NOT FOUND"
  ((ERRORS++))
fi

# Check essential tools
for tool in jq git node python3; do
  if command -v "$tool" &>/dev/null; then
    ok "$tool: installed"
  else
    warn "$tool: not found (optional)"
  fi
done

# Check settings
if [[ -f "$HOME/.claude/settings.json" ]]; then
  ok "Global settings: exist"
else
  fail "Global settings: missing"
  ((ERRORS++))
fi

# Check test project
if [[ -d "$TEST_PROJECT/.claude" ]]; then
  ok "Test project: configured"
else
  warn "Test project: needs configuration"
fi

# ============================================================
# Final Instructions
# ============================================================
echo ""
if [[ $ERRORS -eq 0 ]]; then
  echo -e "${GREEN}╔════════════════════════════════════════════════════════╗${NC}"
  echo -e "${GREEN}║                  SETUP COMPLETE! ✓                     ║${NC}"
  echo -e "${GREEN}╚════════════════════════════════════════════════════════╝${NC}"
else
  echo -e "${RED}╔════════════════════════════════════════════════════════╗${NC}"
  echo -e "${RED}║             SETUP COMPLETED WITH ERRORS                ║${NC}"
  echo -e "${RED}╚════════════════════════════════════════════════════════╝${NC}"
fi

echo ""

if [[ "$NONINTERACTIVE" != "1" ]]; then
  echo "Next Steps:"
  echo ""
  echo "1. Authenticate Claude Code:"
  echo "   ${BLUE}claude auth login${NC}"
  echo ""
  echo "2. Test it:"
  echo "   ${BLUE}cd ~/test-claude-project${NC}"
  echo "   ${BLUE}claude${NC}"
  echo ""
  echo "3. Try Ralph loop:"
  echo "   ${BLUE}/ralph-loop \"Add a hello function\" --max-iterations 5${NC}"
  echo ""
  echo "4. Read the quick reference:"
  echo "   ${BLUE}cat ~/claude-quick-ref.md${NC}"
  echo ""
  echo "5. Start using in your projects:"
  echo "   ${BLUE}cd /path/to/your/project${NC}"
  echo "   ${BLUE}~/start-claude.sh${NC}"
  echo ""
fi

if [[ $ERRORS -gt 0 ]]; then
  if [[ "$NONINTERACTIVE" != "1" ]]; then
    echo -e "${YELLOW}⚠ Please resolve the errors above before using Claude Code${NC}"
  fi
  exit 1
fi

if [[ "$NONINTERACTIVE" != "1" ]]; then
  echo -e "${GREEN}Ready to build with Claude Code + Ralph! 🚀${NC}"
  echo ""
fi
