# Mega Cleanup Plan - Separate All Apps

## Current Problem
Main Designr repo has 5+ apps/projects mixed in with automation system. Need clean separation.

## Apps/Projects Identified

### 1. **DesignrLabs** (Sketch-to-code app)
- Status: Empty directory (broken submodule)
- Files to move: 
  - `The app is called Designr Labs™ See in the image t*.md` (2 files)
  - `designr-labs-export.tar.gz`
  - Related docs from APP-STORE files
- Action: Create fresh repo when you have actual code

### 2. **YoutubeApp** (YouTube MCP server)
- Status: Git repo initialized, ready to push
- Location: `YoutubeApp/`
- Action: Push to GitHub (already in PUSH-TO-GITHUB.sh)

### 3. **App Store** (Marketplace system)
- Files:
  - `APP-STORE-COMPLETE.md`
  - `APPS-REGISTRY.md`
  - `DESIGNR-APP-STORE.md`
  - `README-APP-STORE.md`
- Action: Create separate "Designr-App-Store" repo

### 4. **Rube Goldberg TUI** (Terminal UI tool)
- Files:
  - `ralph-tui-0.1.6.tar.gz` (original archive name)
  - Related docs (already renamed to Rube Goldberg)
- Action: Extract and create separate repo

## Files to Keep in Main Designr Repo

**Core automation:**
- `AGENTS.md`
- `GETTING-STARTED.md`
- `INVENTOR-QUICKSTART.md`
- `ZERO-INTERVENTION-QUICKSTART.md`
- `STANDARDS.md`
- `SKILL.md`
- `START-HERE.md`
- `WHEN-YOU-COME-BACK.md`
- `README.md`
- `REPO-STRUCTURE.md`
- `rube-goldberg-setup-template.md`
- `rube-goldberg-machine-as-a-software-engineer-2026-01-13.md`
- `RUBE-GOLDBERG-AGENTS-SETUP-GUIDE.md`
- `automation/` directory
- `inventions/` directory
- `docs/` directory
- `src/` directory

## Files to Delete (Duplicates/Temp)

- `agentsmd-2026-01-13 (1).md` - duplicate
- `agentsmd-2026-01-13.md` - duplicate
- `bayramannakovclaude-reflect-a-self-learning-system-2026-01-13.md` - dated
- `gitignore.txt` - duplicate (we have .gitignore)
- `PERMISSIONS-DISABLED.txt` - old/irrelevant
- `CLAUDE.md` - merge into AGENTS.md if needed
- `DESIGNR-DELIVERY-SUMMARY.md` - dated summary
- `how about an ipad app that connects to the web app.md` - idea note
- `CLEANUP-*.md` - temporary docs (this session)
- `SEPARATION-COMPLETE.md` - temporary
- `AUTOMATION-COMPLETE.md` - temporary

## Action Plan

### Phase 1: Clean up temp files (2 min)
```bash
cd /workspaces/Designr
git rm "agentsmd-2026-01-13*.md"
git rm "bayramannakovclaude-reflect-a-self-learning-system-2026-01-13.md"
git rm "gitignore.txt"
git rm "PERMISSIONS-DISABLED.txt"
git rm "CLAUDE.md"
git rm "DESIGNR-DELIVERY-SUMMARY.md"
git rm "how about an ipad app that connects to the web app.md"
git rm "CLEANUP-*.md"
git rm "SEPARATION-COMPLETE.md"
git rm "AUTOMATION-COMPLETE.md"
git commit -m "Remove duplicate and temporary documentation files"
```

### Phase 2: Move App Store to separate repo (5 min)
```bash
mkdir -p /tmp/designr-app-store
cd /tmp/designr-app-store
git init
cp /workspaces/Designr/APP-STORE-COMPLETE.md ./README.md
cp /workspaces/Designr/APPS-REGISTRY.md .
cp /workspaces/Designr/DESIGNR-APP-STORE.md .
cp /workspaces/Designr/README-APP-STORE.md .
git add .
git commit -m "Initial commit: Designr App Store"
# Then create GitHub repo and push
```

### Phase 3: Move DesignrLabs docs to separate location (3 min)
```bash
mkdir -p /tmp/designr-labs-docs
cd /tmp/designr-labs-docs
git init
cp "/workspaces/Designr/The app is called Designr Labs™ See in the image t (1).md" ./CONCEPT-1.md
cp "/workspaces/Designr/The app is called Designr Labs™ See in the image t.md" ./CONCEPT-2.md
cp /workspaces/Designr/designr-labs-export.tar.gz .
git add .
git commit -m "Initial commit: DesignrLabs documentation"
# Create GitHub repo later when you have actual app code
```

### Phase 4: Extract and organize Rube Goldberg TUI (5 min)
```bash
mkdir -p /tmp/rube-goldberg-tui
cd /tmp/rube-goldberg-tui
tar -xzf /workspaces/Designr/ralph-tui-0.1.6.tar.gz  # Original archive name
git init
git add .
git commit -m "Initial commit: Rube Goldberg TUI extracted from archive"
# Create GitHub repo
```

### Phase 5: Clean main repo (2 min)
```bash
cd /workspaces/Designr
git rm APP-STORE-COMPLETE.md
git rm DESIGNR-APP-STORE.md
git rm README-APP-STORE.md
git rm "The app is called Designr Labs™ See in the image t*.md"
git rm *.tar.gz
git commit -m "Move app-specific files to separate repositories"
```

### Phase 6: Update .gitignore (1 min)
Keep DesignrLabs/ and YoutubeApp/ in .gitignore since they're now separate repos

### Phase 7: Push everything (3 min)
1. Push main Designr repo
2. Create and push App Store repo
3. Create and push DesignrLabs docs repo
4. Create and push Rube Goldberg TUI repo
5. Push YoutubeApp repo

## Final Repository Structure

After cleanup:

1. **Designr** (main hub) - Automation system only
2. **Designr-App-Store** - Marketplace for apps
3. **DesignrLabs** - Sketch-to-code app (when you build it)
4. **DesignrLabs-Docs** - Initial concepts and exports
5. **YoutubeApp** - YouTube MCP integration
6. **Rube-Goldberg-TUI** - Terminal UI tool

## Total Time: ~20 minutes

## Benefits
- ✅ Each project in its own repo
- ✅ Clean version control
- ✅ Independent CI/CD
- ✅ Clear ownership
- ✅ No more confusion
- ✅ Easy to find things
