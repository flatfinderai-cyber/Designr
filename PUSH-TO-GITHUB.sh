#!/bin/bash
# Quick Reference: Complete the GitHub Push
# Run this after creating the GitHub repos manually

set -e

echo "╔════════════════════════════════════════════╗"
echo "║  Designr Separation - Final Push Steps    ║"
echo "╚════════════════════════════════════════════╝"
echo

echo "📋 STEP 1: Create GitHub Repo"
echo "   Go to: https://github.com/flatfinderai-cyber/new"
echo "   Name: YoutubeApp"
echo "   Description: YouTube MCP Server integration"
echo "   Do NOT initialize with README"
echo
read -p "Press Enter when repo is created..."

echo
echo "🚀 STEP 2: Push YoutubeApp"
cd /workspaces/Designr/YoutubeApp
git remote add origin https://github.com/flatfinderai-cyber/YoutubeApp.git 2>/dev/null || echo "Remote already exists"
git push -u origin main
echo "   ✅ YoutubeApp pushed!"

echo
echo "🚀 STEP 3: Push Main Designr Repo"
cd /workspaces/Designr
git push origin main
echo "   ✅ Main repo pushed!"

echo
echo "🎉 DONE! All repos are now separated and pushed to GitHub."
echo
echo "📊 Your Repos:"
echo "   • Designr (hub): https://github.com/flatfinderai-cyber/Designr"
echo "   • YoutubeApp:    https://github.com/flatfinderai-cyber/YoutubeApp"
echo
echo "🧹 Optional Cleanup (remove local app directories):"
echo "   cd /workspaces/Designr"
echo "   rm -rf YoutubeApp/ DesignrLabs/"
echo
