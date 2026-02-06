# How to Set Up GitHub MCP

This guide answers your question: "how do i set up github mcp"

## Two Options: Manual vs Automated

### Option 1: Quick Manual Setup (5 minutes)

#### Step 1: Install the GitHub MCP Server
```bash
npm install -g @modelcontextprotocol/server-github
```

#### Step 2: Create a GitHub Personal Access Token
1. Visit: https://github.com/settings/tokens
2. Click "Generate new token (classic)"
3. Name it: "Claude MCP"
4. Select these scopes:
   - ✅ `repo` (Full control of private repositories)
   - ✅ `read:org` (Read org and team membership)
   - ✅ `user:email` (Access user email addresses)
   - ✅ `read:project` (Read access to projects)
5. Generate and **copy the token** (you won't see it again!)

#### Step 3: Configure Claude Desktop

**For macOS:**
Edit `~/Library/Application Support/Claude/claude_desktop_config.json`

**For Linux:**
Edit `~/.config/Claude/claude_desktop_config.json`

Add this configuration (create the file if it doesn't exist):
```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-github"
      ],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "YOUR_TOKEN_HERE"
      }
    }
  }
}
```

**Replace `YOUR_TOKEN_HERE` with your actual token from Step 2!**

#### Step 4: Restart Claude Desktop
- Completely quit Claude (Cmd+Q on Mac, not just close)
- Wait 5 seconds
- Reopen Claude Desktop

#### Step 5: Test It!
In Claude Desktop, ask:
```
Can you list my GitHub repositories?
```

If Claude shows your repositories, **you're done!** 🎉

---

### Option 2: Automated Setup with Designr (Recommended)

Let Designr's Rube Goldberg automation system do everything for you!

#### Step 1: Start the Automation
```bash
cd /path/to/Designr
./automation/start-rube-goldberg.sh github-mcp
```

When prompted:
- **Completion promise**: `GITHUB MCP SETUP COMPLETE` (press Enter)
- **Max iterations**: `20` (press Enter)

#### Step 2: Let Rube Goldberg Work
The automation will:
- ✅ Install npm package
- ✅ Guide you through token creation
- ✅ Configure Claude Desktop
- ✅ Restart Claude (may need manual restart)
- ✅ Verify everything works
- ✅ Run test commands

You'll see: `<promise>GITHUB MCP SETUP COMPLETE</promise>` when done!

#### Step 3: Enjoy!
GitHub MCP is ready to use with Claude Desktop.

---

## Verification

### Check if GitHub MCP is Connected

1. Open Claude Desktop
2. Look for 🔌 icon in bottom left corner
3. Click it to see MCP servers
4. "github" should show as "Connected" with green indicator

### Test Commands to Try

Once set up, try asking Claude:

- "List my GitHub repositories"
- "Search for React repositories on GitHub"  
- "Show me issues in [owner/repo]"
- "What are my recent commits in [owner/repo]?"
- "Search for code containing 'async function' in [owner/repo]"

---

## Troubleshooting

### Issue: "Command not found: mcp-server-github"
**Fix:** Use the `npx` method in your config (as shown above)

### Issue: "Authentication failed"
**Fix:** 
1. Verify your token has the correct scopes
2. Make sure you copied the token correctly (no extra spaces)
3. Try regenerating the token

### Issue: Claude doesn't show GitHub data
**Fix:**
1. Verify config file JSON syntax: `python3 -m json.tool < config.json`
2. Make sure Claude Desktop was completely quit and restarted
3. Check the 🔌 icon to see if server is "Connected"

### Issue: Config file doesn't exist
**Fix:** Create the directory and file:

```bash
# macOS
mkdir -p ~/Library/Application\ Support/Claude/
echo '{"mcpServers":{}}' > ~/Library/Application\ Support/Claude/claude_desktop_config.json

# Linux
mkdir -p ~/.config/Claude/
echo '{"mcpServers":{}}' > ~/.config/Claude/claude_desktop_config.json
```

Then add the GitHub MCP configuration as shown in Step 3 above.

---

## Complete Documentation

For more detailed instructions and advanced configuration:

- **Full Workflow**: `automation/workflows/github-mcp-setup.md`
- **Quick Reference**: `docs/github-mcp-quickstart.md`
- **Automation Guide**: `automation/HOW-TO-USE.md`

---

## What You Can Do with GitHub MCP

Once set up, Claude can help you with GitHub through natural conversation:

### Code Exploration
- "Explain how the authentication system works in my-repo"
- "Find all TypeScript files in this repository"
- "Search for 'API endpoint' in the codebase"

### Repository Management
- "List all my repositories"
- "Show me my starred repositories"
- "Search for Python machine learning projects on GitHub"

### Issue Management
- "Create an issue in my-repo about adding dark mode"
- "List open issues in owner/repo"
- "Show me high-priority bugs"

### Pull Request Review
- "Review pull request #42 in owner/repo"
- "Show me the diff for PR #15"
- "List all open pull requests"

### Code Analysis
- "Show me the last 10 commits in main branch"
- "What changed between v1.0 and v2.0?"
- "Analyze the commit history of src/auth.ts"

---

## Security Best Practices

⚠️ **Important:**

1. **Never commit tokens to git** - Add config file to `.gitignore`
2. **Use minimal scopes** - Only enable what you need
3. **Rotate regularly** - Regenerate tokens every few months
4. **Secure the file** - Set permissions: `chmod 600 claude_desktop_config.json`
5. **Use environment variables** - For production setups

---

## Summary

**To set up GitHub MCP:**

1. Install: `npm install -g @modelcontextprotocol/server-github`
2. Create token at: https://github.com/settings/tokens
3. Configure Claude Desktop config file
4. Restart Claude Desktop
5. Test with: "List my GitHub repositories"

**Or use automation:**
```bash
./automation/start-rube-goldberg.sh github-mcp
```

That's it! You now have GitHub fully integrated with Claude Desktop. 🚀
