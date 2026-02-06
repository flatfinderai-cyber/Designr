# GitHub MCP Quick Start Guide

Get GitHub integrated with Claude Desktop in 5 minutes!

## What is GitHub MCP?

GitHub MCP (Model Context Protocol) allows Claude to directly interact with GitHub:
- List and search repositories
- Read code and files
- Create and manage issues
- Review pull requests
- Analyze commits and diffs
- And much more!

## Quick Setup (Manual)

### 1. Install the MCP Server
```bash
npm install -g @modelcontextprotocol/server-github
```

### 2. Create GitHub Token
1. Go to: https://github.com/settings/tokens
2. Click "Generate new token (classic)"
3. Select scopes: `repo`, `read:org`, `user:email`, `read:project`
4. Copy the token

### 3. Configure Claude Desktop

**macOS:**
```bash
cat >> ~/Library/Application\ Support/Claude/claude_desktop_config.json << 'EOF'
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "YOUR_TOKEN_HERE"
      }
    }
  }
}
EOF
```

**Linux:**
```bash
cat >> ~/.config/Claude/claude_desktop_config.json << 'EOF'
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "YOUR_TOKEN_HERE"
      }
    }
  }
}
EOF
```

Replace `YOUR_TOKEN_HERE` with your actual token!

### 4. Restart Claude Desktop

Quit completely (Cmd+Q on Mac) and reopen.

### 5. Test It!

In Claude, try:
```
Can you list my GitHub repositories?
```

If you see your repos, you're done! 🎉

---

## Automated Setup (Recommended)

Use Designr's automation system to do all of this automatically:

### Step 1: Create the workflow
```bash
cd /path/to/Designr
./automation/quick-start.sh
# Enter: github-mcp
```

### Step 2: Start Rube Goldberg
```bash
./automation/start-rube-goldberg.sh github-mcp
# Completion promise: GITHUB MCP SETUP COMPLETE
# Max iterations: 20
```

### Step 3: Let it run!

Rube Goldberg will:
✅ Install the package
✅ Guide you through token creation
✅ Configure Claude Desktop
✅ Verify everything works

You'll get a notification when complete: `<promise>GITHUB MCP SETUP COMPLETE</promise>`

---

## Verification

Check if GitHub MCP is connected:
1. Open Claude Desktop
2. Click 🔌 icon (bottom left)
3. Look for "github" with green "Connected" status

---

## Troubleshooting

### Problem: "Command not found"
**Fix:** Make sure to use the `npx` method in config (not `mcp-server-github` directly)

### Problem: "Authentication failed"
**Fix:** 
1. Check token scopes include: `repo`, `read:org`, `user:email`
2. Regenerate token if needed

### Problem: Claude doesn't see GitHub
**Fix:**
1. Verify config file with: `python3 -m json.tool < config.json`
2. Completely quit and restart Claude (not just close window)
3. Check Claude Desktop logs

---

## What Can You Do?

With GitHub MCP, ask Claude to:

- **Explore code**: "Explain how authentication works in [owner/repo]"
- **Create issues**: "Create an issue in my-repo about adding dark mode"
- **Review PRs**: "Review pull request #42 in owner/repo"
- **Search code**: "Find all React components that use useState in owner/repo"
- **Analyze commits**: "Show me what changed in the last 5 commits"
- **Manage repos**: "List all my public repositories"

---

## Full Documentation

For complete setup instructions, troubleshooting, and advanced configuration:
- **Workflow**: `automation/workflows/github-mcp-setup.md`
- **Automation Guide**: `automation/HOW-TO-USE.md`

---

## Security Tips

⚠️ Important:
1. Never commit your token to git
2. Use minimal required token scopes
3. Rotate tokens regularly
4. Set file permissions: `chmod 600 claude_desktop_config.json`

---

## Need Help?

1. Check the full workflow: `automation/workflows/github-mcp-setup.md`
2. Read automation docs: `automation/HOW-TO-USE.md`
3. Use Rube Goldberg for automated setup: `./automation/start-rube-goldberg.sh github-mcp`

Happy automating! 🚀
