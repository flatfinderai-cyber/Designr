#!/bin/bash
# Push All Separated Repositories to GitHub
set -e

echo "╔════════════════════════════════════════════════╗"
echo "║  Push All Separated Repos to GitHub           ║"
echo "╚════════════════════════════════════════════════╝"
echo
echo "This will push 5 repositories to GitHub:"
echo "  1. Designr (main automation hub)"
echo "  2. Designr-App-Store (marketplace)"
echo "  3. DesignrLabs-Docs (concept docs)"
echo "  4. Rube-Goldberg-TUI (terminal UI tool)"
echo "  5. YoutubeApp (YouTube MCP integration)"
echo
echo "You need to create these GitHub repos first:"
echo "  https://github.com/flatfinderai-cyber/new"
echo
read -p "Press Enter when all 5 repos are created on GitHub..."

echo
echo "════════════════════════════════════════════════"
echo "1/5: Pushing Designr (main hub)..."
echo "════════════════════════════════════════════════"
cd /workspaces/Designr
git remote get-url origin 2>/dev/null || git remote add origin https://github.com/flatfinderai-cyber/Designr.git
git push -u origin main
echo "✅ Designr pushed!"

echo
echo "════════════════════════════════════════════════"
echo "2/5: Pushing Designr-App-Store..."
echo "════════════════════════════════════════════════"
cd /tmp/designr-app-store
git remote add origin https://github.com/flatfinderai-cyber/Designr-App-Store.git 2>/dev/null || true
git push -u origin main
echo "✅ Designr-App-Store pushed!"

echo
echo "════════════════════════════════════════════════"
echo "3/5: Pushing DesignrLabs-Docs..."
echo "════════════════════════════════════════════════"
cd /tmp/designr-labs-docs
git remote add origin https://github.com/flatfinderai-cyber/DesignrLabs-Docs.git 2>/dev/null || true
git push -u origin main
echo "✅ DesignrLabs-Docs pushed!"

echo
echo "════════════════════════════════════════════════"
echo "4/5: Pushing Rube-Goldberg-TUI..."
echo "════════════════════════════════════════════════"
cd /tmp/rube-goldberg-tui
git remote add origin https://github.com/flatfinderai-cyber/Rube-Goldberg-TUI.git 2>/dev/null || true
git push -u origin main
echo "✅ Rube-Goldberg-TUI pushed!"

echo
echo "════════════════════════════════════════════════"
echo "5/5: Pushing YoutubeApp..."
echo "════════════════════════════════════════════════"
cd /workspaces/Designr/YoutubeApp
git remote add origin https://github.com/flatfinderai-cyber/YoutubeApp.git 2>/dev/null || true
git push -u origin main
echo "✅ YoutubeApp pushed!"

echo
echo "╔════════════════════════════════════════════════╗"
echo "║  ✨ ALL REPOS PUSHED SUCCESSFULLY! ✨         ║"
echo "╚════════════════════════════════════════════════╝"
echo
echo "Your Repositories:"
echo "  • https://github.com/flatfinderai-cyber/Designr"
echo "  • https://github.com/flatfinderai-cyber/Designr-App-Store"
echo "  • https://github.com/flatfinderai-cyber/DesignrLabs-Docs"
echo "  • https://github.com/flatfinderai-cyber/Rube-Goldberg-TUI"
echo "  • https://github.com/flatfinderai-cyber/YoutubeApp"
echo
echo "✅ Clean separation complete!"
echo "✅ Each app now has its own repository"
echo "✅ Main Designr repo contains only automation system"
echo
