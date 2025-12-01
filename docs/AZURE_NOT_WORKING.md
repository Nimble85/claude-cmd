# Troubleshooting: Claude CLI Not Using Azure Foundry

## Problem: Claude CLI Shows Desktop Auth Instead of Using Azure

If Claude CLI is trying to authenticate with Claude Desktop instead of using your Azure Foundry credentials, here's how to fix it:

---

## Common Issues and Solutions

### Issue 1: Environment Variables Not Set in Same Session

**Problem:** You set environment variables in one PowerShell window, then opened a new window to run Claude.

**Solution (Windows):**
```powershell
# You MUST run these in the SAME PowerShell window:
cd C:\path\to\claude-cmd\docs\windows

# 1. Set environment (in this window)
.\intro.ps1

# 2. Start Claude (in SAME window - don't close it!)
.\start-claude.ps1
```

**Solution (Linux/Mac):**
```bash
# You MUST run these in the SAME terminal:
cd /path/to/claude-cmd/docs/linux-mac

# 1. Set environment (in this terminal)
source intro.sh

# 2. Start Claude (in SAME terminal)
./start-claude.sh
```

---

### Issue 2: Need to Set Variables Permanently

**Problem:** Environment variables only last for one session.

**Solution (Windows - Permanent):**

Run this ONCE to set permanent user environment variables:

```powershell
# Set permanent environment variables for your user
[System.Environment]::SetEnvironmentVariable("ANTHROPIC_BASE_URL", "https://YOUR-RESOURCE.services.ai.azure.com/anthropic/", "User")
[System.Environment]::SetEnvironmentVariable("ANTHROPIC_API_KEY", "YOUR-API-KEY-HERE", "User")
[System.Environment]::SetEnvironmentVariable("ANTHROPIC_MODEL", "claude-opus-4-5", "User")

# Restart PowerShell after this
```

Then just run:
```powershell
claude
```

**Solution (Linux/Mac - Permanent):**

Add to your shell profile (~/.zshrc or ~/.bashrc):

```bash
export ANTHROPIC_BASE_URL="https://YOUR-RESOURCE.services.ai.azure.com/anthropic/"
export ANTHROPIC_API_KEY="YOUR-API-KEY-HERE"
export ANTHROPIC_MODEL="claude-opus-4-5"
```

Then:
```bash
source ~/.zshrc  # or ~/.bashrc
claude
```

---

### Issue 3: Wrong Claude Tool Installed

**Problem:** You have Claude Desktop instead of Claude CLI.

**Check:**
```bash
claude --version
```

Should show:
```
2.0.55 (Claude Code)
```

If it opens a GUI or shows different output, you have the wrong tool.

**Solution:**
Install Claude CLI:
```bash
npm install -g @anthropic-ai/claude-code
```

---

### Issue 4: Variable Names Wrong

**Problem:** Using wrong environment variable names.

**Correct Variables:**
```bash
ANTHROPIC_BASE_URL    # Not ANTHROPIC_FOUNDRY_RESOURCE
ANTHROPIC_API_KEY     # Not ANTHROPIC_FOUNDRY_API_KEY
ANTHROPIC_MODEL       # Optional
```

---

## Quick Test

To test if your environment is configured:

**Windows:**
```powershell
# Run intro.ps1 first
.\intro.ps1

# Then check variables
Write-Host $env:ANTHROPIC_BASE_URL
Write-Host $env:ANTHROPIC_API_KEY
Write-Host $env:ANTHROPIC_MODEL

# If these show your values, start Claude in SAME window:
claude
```

**Linux/Mac:**
```bash
# Source intro.sh first
source intro.sh

# Then check variables
echo $ANTHROPIC_BASE_URL
echo $ANTHROPIC_API_KEY
echo $ANTHROPIC_MODEL

# If these show your values, start Claude in SAME terminal:
claude
```

---

## Verification Steps

1. **Set environment in terminal/PowerShell**
2. **Verify variables are set** (echo/Write-Host them)
3. **Start Claude in SAME window/terminal**
4. **Claude should use Azure Foundry**

If Claude still asks for desktop auth, it means:
- Variables not set
- Wrong terminal/window
- Wrong variable names
- Wrong tool installed (Desktop instead of CLI)

---

## Working Example (Windows)

```powershell
# Step 1: Open PowerShell
# Step 2: Navigate to project
cd C:\Users\YourUser\claude-cmd\docs\windows

# Step 3: Set environment (output shows confirmation)
.\intro.ps1
# [OK] Claude CLI configured for Microsoft Foundry
#      Endpoint: https://your-resource.services.ai.azure.com/anthropic/
#      Model: claude-opus-4-5
#      API Key: YOUR-KEY-PREVIEW...

# Step 4: Verify variables (should show your values)
Write-Host $env:ANTHROPIC_BASE_URL
# https://your-resource.services.ai.azure.com/anthropic/

# Step 5: Start Claude (in SAME window!)
.\start-claude.ps1
# Claude starts and uses Azure Foundry ✓
```

---

## If Nothing Works

Try the permanent environment variable method above, or run:

```bash
# Set inline with the command
ANTHROPIC_BASE_URL="https://YOUR-RESOURCE.services.ai.azure.com/anthropic/" ANTHROPIC_API_KEY="YOUR-KEY" claude
```

---

**Key Point:** Environment variables MUST be set in the same terminal/PowerShell session where you run Claude!

