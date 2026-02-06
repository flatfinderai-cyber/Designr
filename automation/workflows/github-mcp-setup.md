---
tool_name: "GitHub MCP Server"
purpose: "Model Context Protocol server for GitHub integration with Claude"
platform: "macos/linux"
---

# GitHub MCP Server Setup

Set up the GitHub Model Context Protocol (MCP) server to enable Claude to interact with GitHub repositories, issues, pull requests, and more.

## Prerequisites

- Node.js 18.x or higher
- npm or pnpm package manager
- GitHub account
- GitHub Personal Access Token (classic) with appropriate permissions

## Step 1: Install GitHub MCP Server

Install the GitHub MCP server globally using npm:

```bash
npm install -g @modelcontextprotocol/server-github
```

**Verify:** Check installation
```bash
npm list -g @modelcontextprotocol/server-github
```

**Expected:** Should show the installed version without errors

## Step 2: Create GitHub Personal Access Token

1. Go to GitHub Settings → Developer settings → Personal access tokens → Tokens (classic)
   - URL: https://github.com/settings/tokens

2. Click "Generate new token (classic)"

3. Set token name: "Claude MCP Server" or similar

4. Select scopes (permissions):
   - ✅ `repo` (Full control of private repositories)
   - ✅ `read:org` (Read org and team membership, read org projects)
   - ✅ `user:email` (Access user email addresses)
   - ✅ `read:project` (Read access to projects)

5. Click "Generate token"

6. **IMPORTANT:** Copy the token immediately (you won't see it again!)

**Verify:** Token is copied and saved securely

## Step 3: Configure Claude Desktop

1. Locate your Claude Desktop config file:
   - **macOS**: `~/Library/Application Support/Claude/claude_desktop_config.json`
   - **Linux**: `~/.config/Claude/claude_desktop_config.json`

2. If the file doesn't exist, create it with this initial structure:
   ```bash
   # macOS
   mkdir -p ~/Library/Application\ Support/Claude/
   cat > ~/Library/Application\ Support/Claude/claude_desktop_config.json << 'EOF'
   {
     "mcpServers": {}
   }
   EOF
   ```

   ```bash
   # Linux
   mkdir -p ~/.config/Claude/
   cat > ~/.config/Claude/claude_desktop_config.json << 'EOF'
   {
     "mcpServers": {}
   }
   EOF
   ```

**Verify:** Config file exists
```bash
# macOS
cat ~/Library/Application\ Support/Claude/claude_desktop_config.json

# Linux
cat ~/.config/Claude/claude_desktop_config.json
```

## Step 4: Add GitHub MCP Server to Config

Edit the config file and add the GitHub MCP server:

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

**IMPORTANT:** Replace `YOUR_TOKEN_HERE` with your actual GitHub Personal Access Token

Alternative using installed package:
```json
{
  "mcpServers": {
    "github": {
      "command": "mcp-server-github",
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "YOUR_TOKEN_HERE"
      }
    }
  }
}
```

**Verify:** Config file has valid JSON syntax
```bash
# macOS
cat ~/Library/Application\ Support/Claude/claude_desktop_config.json | python3 -m json.tool

# Linux  
cat ~/.config/Claude/claude_desktop_config.json | python3 -m json.tool
```

## Step 5: Restart Claude Desktop

1. Quit Claude Desktop completely (Command+Q on macOS, or close all windows)
2. Wait 5 seconds
3. Launch Claude Desktop again

**Verify:** Claude Desktop starts without errors

## Step 6: Test GitHub MCP Integration

In Claude Desktop, try these test queries:

1. Test basic GitHub functionality:
   ```
   Can you list my GitHub repositories?
   ```

2. Test repository search:
   ```
   Search for repositories about "model context protocol"
   ```

3. Test issue listing (if you have repos with issues):
   ```
   List issues in [owner/repo]
   ```

**Expected:** Claude should respond with GitHub data, not say "I don't have access"

## Step 7: Verify MCP Server Status

Check if the MCP server is running:

1. Open Claude Desktop
2. Click the 🔌 icon (MCP servers icon) in the bottom left
3. Look for "github" in the list of connected servers
4. Status should be "Connected" with a green indicator

**Verify:** GitHub MCP server shows as connected

## Troubleshooting

### Issue: "Command not found: mcp-server-github"

**Solution:** Use npx method in config instead:
```json
{
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-github"]
}
```

### Issue: "Authentication failed" or "Invalid token"

**Solution:** 
1. Check token has correct scopes (repo, read:org, user:email)
2. Regenerate token if needed
3. Make sure token is copied correctly (no extra spaces)

### Issue: Claude doesn't see GitHub tools

**Solution:**
1. Verify config file syntax with `python3 -m json.tool`
2. Check file location is correct for your OS
3. Completely restart Claude Desktop (quit, not just close)
4. Check Claude Desktop logs for errors

### Issue: "Rate limit exceeded"

**Solution:**
- GitHub API has rate limits
- Wait a few minutes and try again
- Consider using a token with higher rate limits

## Advanced Configuration

### Multiple GitHub Accounts

You can configure multiple GitHub MCP servers for different accounts:

```json
{
  "mcpServers": {
    "github-personal": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "personal_token_here"
      }
    },
    "github-work": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "work_token_here"
      }
    }
  }
}
```

### Using Environment Variables

Store token in environment variable for better security:

1. Add to your shell profile (~/.zshrc or ~/.bashrc):
   ```bash
   export GITHUB_PERSONAL_ACCESS_TOKEN="your_token_here"
   ```

2. In Claude config, reference it:
   ```json
   {
     "mcpServers": {
       "github": {
         "command": "npx",
         "args": ["-y", "@modelcontextprotocol/server-github"],
         "env": {
           "GITHUB_PERSONAL_ACCESS_TOKEN": "${GITHUB_PERSONAL_ACCESS_TOKEN}"
         }
       }
     }
   }
   ```

## Available GitHub MCP Tools

Once configured, Claude can use these GitHub operations:

### Repository Operations
- List repositories
- Search repositories  
- Get repository details
- Get file contents
- Search code

### Issues & Pull Requests
- List issues
- Create issues
- Update issues
- List pull requests
- Get PR details
- Review PRs

### Code Analysis
- List commits
- Get commit details
- Compare branches
- View diffs

### Organization
- List organization repos
- Get team information
- Manage collaborators

## Success Criteria

The GitHub MCP setup is complete when:

- [x] npm package `@modelcontextprotocol/server-github` is installed
- [x] GitHub Personal Access Token is created with correct scopes
- [x] Claude Desktop config file exists and has valid JSON
- [x] GitHub MCP server is added to config with token
- [x] Claude Desktop restarted successfully
- [x] Claude Desktop shows GitHub server as "Connected" (🔌 icon)
- [x] Claude can successfully list your GitHub repositories
- [x] Claude can search GitHub repositories
- [x] Test queries return GitHub data (not "I don't have access")

When ALL criteria are met, output:
<promise>GITHUB MCP SETUP COMPLETE</promise>

## Resources

- **GitHub MCP Server**: https://github.com/modelcontextprotocol/servers/tree/main/src/github
- **MCP Documentation**: https://modelcontextprotocol.io
- **Claude Desktop**: https://claude.ai/download
- **GitHub Tokens**: https://github.com/settings/tokens

## Security Notes

⚠️ **IMPORTANT SECURITY CONSIDERATIONS:**

1. **Never commit your token to git** - Add config files to .gitignore
2. **Use minimal required scopes** - Don't give more permissions than needed
3. **Rotate tokens regularly** - Regenerate tokens every few months
4. **Use environment variables** - Don't hardcode tokens in config files when possible
5. **Secure your config file** - Set proper file permissions (chmod 600)

## Next Steps After Setup

Once GitHub MCP is working, you can:

1. **Automate repository management**: Ask Claude to create issues, manage PRs
2. **Code exploration**: Have Claude analyze codebases and explain code
3. **Development workflows**: Automate common GitHub tasks through conversation
4. **Code review assistance**: Get help reviewing PRs and understanding changes
5. **Issue triage**: Automate issue labeling and management

Enjoy your GitHub-powered Claude experience! 🚀
