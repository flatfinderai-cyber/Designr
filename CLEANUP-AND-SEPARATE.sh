#!/bin/bash
# Designr Repository Cleanup - Separate Apps into Individual Repos

set -e

echo "🧹 Designr Repository Cleanup Script"
echo "======================================"
echo ""

# Step 1: DesignrLabs
echo "Step 1: DesignrLabs Separation"
echo "-------------------------------"
echo ""
echo "Run these commands:"
echo ""
echo "  cd /workspaces/Designr/DesignrLabs"
echo "  git remote remove origin"
echo "  gh repo create flatfinderai-cyber/DesignrLabs --public --source=. --remote=origin"
echo "  git add -A"
echo "  git commit -m 'Initial DesignrLabs repository'"
echo "  git push -u origin main"
echo ""

# Step 2: YoutubeApp
echo "Step 2: YoutubeApp Separation"
echo "------------------------------"
echo ""
echo "  cd /workspaces/Designr/YoutubeApp"
echo "  gh repo create flatfinderai-cyber/YoutubeApp --public --source=. --remote=origin"
echo "  echo '# YoutubeApp' > README.md"
echo "  git init"
echo "  git add ."
echo "  git commit -m 'Initial YoutubeApp repository'"
echo "  git push -u origin main"
echo ""

# Step 3: Clean main repo
echo "Step 3: Remove from Main Repo"
echo "------------------------------"
echo ""
echo "  cd /workspaces/Designr"
echo "  git rm -rf DesignrLabs YoutubeApp"
echo "  git commit -m 'Remove app dirs (now separate repos)'"
echo "  git push origin main"
echo ""
echo "✅ Done! Apps separated, main repo clean."
