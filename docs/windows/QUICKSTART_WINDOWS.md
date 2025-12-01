# Windows Quick Start Guide

## ⚡ 3-Step Setup

### Step 1: Edit Configuration

Open PowerShell and navigate to the project:
```powershell
cd C:\path\to\claude-cmd\docs\windows
```

Edit `intro.ps1` with your Azure credentials:
```powershell
notepad intro.ps1
```

Update these three lines:
```powershell
$env:ANTHROPIC_BASE_URL = "https://YOUR-RESOURCE.services.ai.azure.com/anthropic/"
$env:ANTHROPIC_API_KEY = "YOUR-API-KEY-HERE"
$env:ANTHROPIC_MODEL = "claude-opus-4-5"
```

Save and close.

### Step 2: Allow PowerShell Scripts (First Time Only)

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Step 3: Start Claude Code

```powershell
.\start-claude.ps1
```

Done! 🎉

---

## ❌ Common Mistakes

### DON'T:
```powershell
claude  # ← Wrong! Won't load your config
```

### DO:
```powershell
.\start-claude.ps1  # ← Correct! Loads your Azure config
```

---

## 🔧 Quick Commands

```powershell
# Check if configured correctly
.\check-env.ps1

# Start Claude Code
.\start-claude.ps1

# Edit configuration
notepad intro.ps1
```

---

## 🐛 Troubleshooting

**Error: "Cannot run scripts"**
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

**Error: "Invalid API key"**
- Make sure you used `.\start-claude.ps1` to start
- Verify your API key in `intro.ps1` is correct

**Error: "Connection error"**
- Check your endpoint URL in `intro.ps1`
- Verify deployment is active in Azure Portal

---

## 📖 Full Documentation

See [SETUP_GUIDE_WINDOWS.md](SETUP_GUIDE_WINDOWS.md) for complete guide.

---

**Platform:** Windows 10/11  
**Tool:** PowerShell 5.1+

