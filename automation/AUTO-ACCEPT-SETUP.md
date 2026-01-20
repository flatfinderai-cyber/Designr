# Auto-Accept Configuration for Claude Code

## The Problem
Claude Code asks for permission for every action. You want to auto-approve everything during automation.

## Solution: Configure "Don't Ask" Mode

### Method 1: Global Auto-Accept (All Projects)

Edit `~/.claude/settings.json`:

```json
{
  "permissions": {
    "defaultMode": "dontAsk",
    "allow": [
      "Bash",
      "Read",
      "Write",
      "Edit",
      "Glob",
      "Grep",
      "Skill(*)",
      "Task"
    ]
  }
}
```

**This allows Claude to do anything without asking in ALL projects.**

### Method 2: Project-Specific Auto-Accept

Edit `.claude/settings.local.json` in your project:

```json
{
  "permissions": {
    "defaultMode": "dontAsk",
    "allow": [
      "Bash",
      "Read",
      "Write",
      "Edit",
      "Skill(rube-goldberg-wiggum:*)"
    ]
  }
}
```

**This only affects the current project.**

### Method 3: Bypass Permissions Mode (Ultimate Auto-Accept)

Edit your settings file:

```json
{
  "permissions": {
    "defaultMode": "bypassPermissions"
  }
}
```

**⚠️ WARNING: This bypasses ALL permission checks. Use carefully!**

---

## Quick Setup Script

Run this to enable auto-accept globally:

```bash
#!/bin/bash
# Enable auto-accept mode

mkdir -p ~/.claude

cat > ~/.claude/settings.json << 'EOF'
{
  "permissions": {
    "defaultMode": "dontAsk",
    "allow": [
      "Bash",
      "Read",
      "Write",
      "Edit",
      "Glob",
      "Grep",
      "LSP",
      "Skill(*)",
      "Task",
      "TodoWrite",
      "AskUserQuestion",
      "EnterPlanMode"
    ]
  },
  "model": "claude-sonnet-4-5",
  "respectGitignore": true
}
EOF

echo "✓ Auto-accept enabled globally"
```

---

## For This Project (Designr)

Update `.claude/settings.local.json`:

```bash
cat > .claude/settings.local.json << 'EOF'
{
  "permissions": {
    "defaultMode": "dontAsk",
    "allow": [
      "Bash",
      "Read",
      "Write",
      "Edit",
      "Glob",
      "Grep",
      "Skill(rube-goldberg-wiggum:*)",
      "Skill(*)",
      "Task",
      "TodoWrite"
    ]
  }
}
EOF
```

---

## Permission Modes Explained

### `default`
- Asks for permission every time
- Safest but most annoying

### `dontAsk`
- Auto-approves tools in the `allow` list
- Still asks for tools NOT in the list
- **Recommended for automation**

### `bypassPermissions`
- NEVER asks for permission
- Allows EVERYTHING automatically
- ⚠️ Use only in trusted environments

### `acceptEdits`
- Auto-accepts file edits
- Still asks for other operations

### `plan`
- Forces plan mode before executing
- For careful control

---

## Wildcard Patterns

### Allow all Bash commands:
```json
"allow": ["Bash"]
```

### Allow specific Bash commands:
```json
"allow": [
  "Bash(npm:*)",      // Any npm command
  "Bash(git:*)",      // Any git command
  "Bash(chmod:*)"     // Any chmod command
]
```

### Allow all skills:
```json
"allow": ["Skill(*)"]
```

### Allow specific skills:
```json
"allow": [
  "Skill(rube-goldberg-wiggum:*)",
  "Skill(commit-commands:*)"
]
```

---

## For Rube Goldberg Automation

Rube Goldberg needs these permissions at minimum:

```json
{
  "permissions": {
    "defaultMode": "dontAsk",
    "allow": [
      "Bash",
      "Read",
      "Write",
      "Edit",
      "Skill(rube-goldberg-wiggum:*)"
    ]
  }
}
```

---

## Security Considerations

### ✅ Safe for automation:
```json
"defaultMode": "dontAsk"
```
- Still uses `allow` list
- You control what's permitted

### ⚠️ Use with caution:
```json
"defaultMode": "bypassPermissions"
```
- No safeguards
- Only in trusted projects

### Best Practice:
1. Use `dontAsk` mode
2. Explicitly list allowed tools
3. Don't use `bypassPermissions` unless necessary

---

## Apply Right Now

For Designr project:

```bash
cd /Users/hella.crypto/cloud-projects/Designr

cat > .claude/settings.local.json << 'EOF'
{
  "permissions": {
    "defaultMode": "dontAsk",
    "allow": [
      "Bash",
      "Read",
      "Write",
      "Edit",
      "Glob",
      "Grep",
      "Skill(rube-goldberg-wiggum:*)",
      "Task",
      "TodoWrite"
    ]
  }
}
EOF

echo "✓ Auto-accept enabled for Designr"
```

---

## Testing

After enabling auto-accept, test it:

```bash
cd ~/test-claude-project
claude --message "Create a test file called auto-accept-test.txt"
```

If it creates the file without asking, auto-accept is working! ✓

---

## Troubleshooting

### Still asking for permission?

1. Check settings file exists:
   ```bash
   cat .claude/settings.local.json
   ```

2. Verify valid JSON:
   ```bash
   cat .claude/settings.local.json | jq .
   ```

3. Restart Claude session:
   ```bash
   # Exit and restart claude
   ```

### Want to reset to safe mode?

```bash
cat > .claude/settings.local.json << 'EOF'
{
  "permissions": {
    "defaultMode": "default"
  }
}
EOF
```

---

## Summary

**Quickest solution:**

```bash
# Global (all projects)
echo '{"permissions":{"defaultMode":"dontAsk","allow":["Bash","Read","Write","Edit","Skill(*)"]}}' > ~/.claude/settings.json

# Or just this project
echo '{"permissions":{"defaultMode":"dontAsk","allow":["Bash","Read","Write","Edit","Skill(rube-goldberg-wiggum:*)"]}}' > .claude/settings.local.json
```

**Now Claude won't ask for permission during automation! 🚀**
