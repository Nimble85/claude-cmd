# 🚨 SECURITY INCIDENT: API Key Exposed in Git History

## What Happened

GitHub's secret scanning detected your Azure API key in git commit history. Even though we removed credentials from current files, they remain in old commits.

**Detected in commit:** `1f525c64e5f8e6233ca1994752b249ec5147edb1`  
**Files:** FIX-NOTES.md, SETUP_GUIDE.md (old versions)

---

## ⚠️ CRITICAL: Action Required IMMEDIATELY

### Step 1: Rotate API Key in Azure (DO THIS FIRST!) 🔴

Your API key is **compromised**. Rotate it NOW:

1. **Go to Azure Portal:** https://portal.azure.com
2. **Navigate to:** Your Foundry Resource
3. **Click:** "Keys and Endpoint"
4. **Click:** "Regenerate Key 1" or "Regenerate Key 2"
5. **Copy:** The new API key
6. **Update local files:**
   - `docs/windows/intro.ps1` 
   - `docs/linux-mac/intro.sh`

**⚠️ Do NOT proceed to Step 2 until you've rotated the key!**

---

## Step 2: Clean Git History

### Option A: Start Fresh (Easiest)

If you haven't shared the repo yet, the easiest solution is to start with a clean repo:

```bash
cd /Users/sklymo/Documents/git/claude_test/claude-cmd

# 1. Remove git history
rm -rf .git

# 2. Initialize new repo
git init
git add .
git commit -m "Initial commit - Claude Code + Microsoft Foundry setup

Multi-platform support for Windows, Linux, and macOS"

# 3. Push to GitHub (if repo exists, use force push)
git remote add origin https://github.com/Nimble85/claude-cmd.git
git branch -M main
git push -u origin main --force
```

### Option B: Clean History (Advanced)

If you need to preserve history, use BFG Repo-Cleaner or git filter-branch:

#### Using BFG Repo-Cleaner (Recommended)

```bash
# 1. Install BFG
brew install bfg  # macOS
# or download from https://rtyley.github.io/bfg-repo-cleaner/

# 2. Create a fresh clone
cd /Users/sklymo/Documents/git/claude_test
git clone --mirror https://github.com/Nimble85/claude-cmd.git
cd claude-cmd.git

# 3. Remove files with secrets
bfg --delete-files "FIX-NOTES.md"
bfg --delete-files "SETUP_GUIDE.md"
bfg --delete-files "intro.sh"

# 4. Clean up
git reflog expire --expire=now --all
git gc --prune=now --aggressive

# 5. Force push
git push --force
```

#### Using Git Filter-Branch (Built-in)

```bash
cd /Users/sklymo/Documents/git/claude_test/claude-cmd

# Remove sensitive files from history
git filter-branch --force --index-filter \
  "git rm --cached --ignore-unmatch FIX-NOTES.md SETUP_GUIDE.md intro.sh test_foundry_aad.py" \
  --prune-empty --tag-name-filter cat -- --all

# Clean up
rm -rf .git/refs/original/
git reflog expire --expire=now --all
git gc --prune=now --aggressive

# Force push
git push origin main --force
```

---

## Step 3: Verify Clean History

After cleaning:

```bash
# Check no secrets remain
git log --all --full-history -- FIX-NOTES.md
git log --all --full-history -- SETUP_GUIDE.md

# Should return no results
```

---

## Step 4: Re-push to GitHub

```bash
# Verify current state is clean
git status

# Force push clean history
git push origin main --force
```

---

## ✅ Recovery Checklist

- [ ] **CRITICAL:** API key rotated in Azure Portal
- [ ] New API key updated in local config files
- [ ] Old API key revoked/deleted in Azure
- [ ] Git history cleaned (Option A or B)
- [ ] Verified no secrets in git log
- [ ] Successfully pushed to GitHub
- [ ] Tested new API key works

---

## 🛡️ Prevention for Future

1. **Always check before commit:**
   ```bash
   git diff --cached | grep -i "api.*key"
   ```

2. **Use git pre-commit hooks:**
   ```bash
   # Install pre-commit
   pip install pre-commit
   
   # Create .pre-commit-config.yaml
   cat > .pre-commit-config.yaml << 'EOF'
   repos:
     - repo: https://github.com/Yelp/detect-secrets
       rev: v1.4.0
       hooks:
         - id: detect-secrets
   EOF
   
   # Install hooks
   pre-commit install
   ```

3. **Verify .gitignore is working:**
   ```bash
   git check-ignore -v docs/windows/intro.ps1
   git check-ignore -v docs/linux-mac/intro.sh
   ```

---

## 📞 If You Need Help

1. **Azure Support:** Contact if you see unauthorized usage
2. **GitHub Support:** They can help remove sensitive data
3. **Check Azure Activity Logs:** Monitor for unauthorized access

---

## 🔍 Why This Happened

The issue occurred because:
1. Initial commits contained files with real credentials
2. Even after deleting files, they remained in git history
3. GitHub scans all commits, not just current files
4. `.gitignore` only prevents NEW files from being tracked

**Lesson:** Always use templates from the start, never commit real credentials!

---

## ⚡ Quick Recovery (Recommended)

**Fastest and cleanest solution:**

```bash
# 1. ROTATE API KEY IN AZURE PORTAL FIRST!

# 2. Start fresh
cd /Users/sklymo/Documents/git/claude_test/claude-cmd
rm -rf .git
git init
git add .
git commit -m "Initial commit - Multi-platform Claude Code + Microsoft Foundry setup"

# 3. Force push
git remote add origin https://github.com/Nimble85/claude-cmd.git
git branch -M main
git push -u origin main --force

# Done! ✅
```

---

**Status:** 🔴 SECURITY INCIDENT IN PROGRESS  
**Priority:** CRITICAL  
**Action:** Rotate API key immediately, then clean git history

