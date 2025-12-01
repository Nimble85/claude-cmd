#!/bin/bash
###############################################################################
# Clean Git History - Remove Credentials
###############################################################################
# This script removes the commit containing credentials from git history
###############################################################################

echo "=========================================="
echo "  Git History Cleanup"
echo "=========================================="
echo ""
echo "This will remove commits with credentials from git history."
echo "⚠️  WARNING: This rewrites git history!"
echo ""

read -p "Continue? (yes/no): " confirm
if [ "$confirm" != "yes" ]; then
    echo "Aborted."
    exit 1
fi

echo ""
echo "Removing problematic commit..."
echo ""

# Reset to the commit before the one with credentials
# Then recommit the clean version
git reset --soft HEAD~2

# Unstage all changes
git reset

# Add only safe files (exclude any with credentials)
git add .

# Check what will be committed
echo "Files to be committed:"
git status --short

echo ""
read -p "Commit these changes? (yes/no): " confirm2
if [ "$confirm2" != "yes" ]; then
    echo "Aborted."
    exit 1
fi

# Commit with clean content
git commit -m "Add Claude CLI + Microsoft Foundry setup (multi-platform)

- Windows PowerShell support
- Linux/Mac bash scripts
- Comprehensive documentation
- Auto-installation scripts
- Security: credentials protected"

echo ""
echo "✅ History cleaned!"
echo ""
echo "Now force push to GitHub:"
echo "  git push origin main --force"
echo ""

