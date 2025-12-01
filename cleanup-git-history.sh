#!/bin/bash
###############################################################################
# Git History Cleanup Script
###############################################################################
# This script removes sensitive data from git history
# 
# WARNING: This rewrites git history. Only run if you haven't shared the repo.
###############################################################################

echo "🚨 Git History Cleanup for Sensitive Data"
echo "=========================================="
echo ""
echo "This will remove sensitive files from ALL git history."
echo "⚠️  This rewrites history - use with caution!"
echo ""

# Files to remove from history
FILES_TO_REMOVE=(
    "FIX-NOTES.md"
    "SETUP_GUIDE.md"
    "intro.sh"
    "test_foundry_aad.py"
)

echo "Files to be removed from history:"
for file in "${FILES_TO_REMOVE[@]}"; do
    echo "  - $file"
done
echo ""

read -p "Continue? (yes/no): " confirm
if [ "$confirm" != "yes" ]; then
    echo "Aborted."
    exit 1
fi

echo ""
echo "🔧 Removing sensitive files from git history..."
echo ""

# Use git filter-repo (recommended) or filter-branch
if command -v git-filter-repo &> /dev/null; then
    echo "Using git-filter-repo (recommended)..."
    for file in "${FILES_TO_REMOVE[@]}"; do
        git filter-repo --path "$file" --invert-paths --force
    done
else
    echo "Using git filter-branch (slower)..."
    git filter-branch --force --index-filter \
        "git rm --cached --ignore-unmatch FIX-NOTES.md SETUP_GUIDE.md intro.sh test_foundry_aad.py" \
        --prune-empty --tag-name-filter cat -- --all
    
    # Clean up
    rm -rf .git/refs/original/
    git reflog expire --expire=now --all
    git gc --prune=now --aggressive
fi

echo ""
echo "✅ History cleaned!"
echo ""
echo "⚠️  IMPORTANT: You MUST force push to overwrite remote history:"
echo "    git push origin main --force"
echo ""
echo "⚠️  Make sure you rotated your API key in Azure Portal first!"
echo ""

