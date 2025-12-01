# SOLUTION: Claude CLI Not Using Azure Foundry

## The Problem

You're seeing the Claude login prompt instead of it using your Azure Foundry credentials automatically.

This happens because **environment variables are not set** when Claude CLI starts.

---

## ✅ SOLUTION: Set Variables BEFORE Starting Claude

### Step 1: Open PowerShell

### Step 2: Navigate to project folder
```powershell
cd C:\Users\azmdmadmin\Downloads\claude-cmd-main\docs\windows
```

### Step 3: Set your Azure credentials in intro.ps1

Edit `intro.ps1` and replace:
```powershell
$env:ANTHROPIC_BASE_URL = "https://YOUR-RESOURCE.services.ai.azure.com/anthropic/"
$env:ANTHROPIC_API_KEY = "YOUR-API-KEY-HERE"
```

With your actual values.

### Step 4: Load environment variables
```powershell
.\intro.ps1
```

You should see:
```
[OK] Claude CLI configured for Microsoft Foundry
     Endpoint: https://your-resource.services.ai.azure.com/anthropic/
     Model: claude-opus-4-5
     API Key: YOUR-KEY...
```

### Step 5: Test environment is set
```powershell
.\test-env.ps1
```

Should show:
```
[OK] Environment configured correctly!
```

### Step 6: Start Claude (in SAME window!)
```powershell
claude
```

**IMPORTANT:** Do NOT close PowerShell between steps 4 and 6!

---

## What To Do When You See Login Prompt

If you see:
```
Select login method:
 > 1. Claude account with subscription
   2. Anthropic Console account
```

This means **environment variables were NOT set**.

**DO THIS:**
1. Press `Ctrl+C` to exit Claude
2. Run: `.\intro.ps1`
3. Run: `.\test-env.ps1` (verify it's set)
4. Run: `claude` again

---

## Alternative: Manual Environment Setup

Instead of using the script, set manually:

```powershell
$env:ANTHROPIC_BASE_URL = "https://YOUR-RESOURCE.services.ai.azure.com/anthropic/"
$env:ANTHROPIC_API_KEY = "YOUR-API-KEY-HERE"
$env:ANTHROPIC_MODEL = "claude-opus-4-5"

# Then immediately run:
claude
```

---

## Permanent Solution

To avoid setting variables every time, set them permanently:

```powershell
# Run ONCE (replace with your actual values):
[System.Environment]::SetEnvironmentVariable("ANTHROPIC_BASE_URL", "https://YOUR-RESOURCE.services.ai.azure.com/anthropic/", "User")
[System.Environment]::SetEnvironmentVariable("ANTHROPIC_API_KEY", "YOUR-API-KEY-HERE", "User")
[System.Environment]::SetEnvironmentVariable("ANTHROPIC_MODEL", "claude-opus-4-5", "User")

# Close and reopen PowerShell
# Then just run:
claude
```

---

## Verification Checklist

Before starting Claude, verify:

```powershell
# Check each variable:
Write-Host $env:ANTHROPIC_BASE_URL
# Should show: https://YOUR-RESOURCE.services.ai.azure.com/anthropic/

Write-Host $env:ANTHROPIC_API_KEY  
# Should show: YOUR-API-KEY...

Write-Host $env:ANTHROPIC_MODEL
# Should show: claude-opus-4-5
```

If ANY of these are empty, run `.\intro.ps1` again.

---

## TL;DR - Quick Fix Right Now

In your PowerShell window:

```powershell
# Exit Claude if running (Ctrl+C)

# Set variables manually (use your real values):
$env:ANTHROPIC_BASE_URL = "https://YOUR-RESOURCE.services.ai.azure.com/anthropic/"
$env:ANTHROPIC_API_KEY = "YOUR-ACTUAL-KEY-HERE"

# Start Claude:
claude
```

If variables are set correctly, Claude will use Azure Foundry and **won't show the login prompt**.

---

**Key Point:** Claude CLI checks for `ANTHROPIC_BASE_URL` and `ANTHROPIC_API_KEY` environment variables. If they're not set, it shows the login prompt. You MUST set them before starting Claude!

