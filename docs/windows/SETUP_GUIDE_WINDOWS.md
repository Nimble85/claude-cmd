# Claude Code + Microsoft Foundry Setup Guide (Windows)

Complete setup guide for configuring Claude Code to work with Microsoft Azure Foundry on Windows.

---

## 📋 Prerequisites

Before you begin, ensure you have:

- ✅ **Windows 10/11** or Windows Server
- ✅ **PowerShell 5.1+** (included with Windows)
- ✅ **Azure Account** with Microsoft Foundry access
- ✅ **Claude Code** (can be auto-installed by script)
- ✅ **Azure Foundry Deployment** with Claude models
- ✅ **API Key** from Azure Portal
- ✅ **Node.js** (optional, for npm installation of Claude Code)
- ✅ **Python 3.8+** (optional, for testing)

---

## 🚀 Quick Start (3 Steps)

### Step 0: Install Claude Code (If Needed)

If you don't have Claude Code installed, run:

```powershell
.\install-claude.ps1
```

This will:
- Check if Claude Code is installed
- Install via npm if Node.js is available
- Or guide you to download it directly

**Alternatively**, the `start-claude.ps1` script will offer to install it automatically if not found.

### Step 1: Get Your Azure Credentials

From Azure Portal, collect:
1. **Endpoint URL** - Format: `https://YOUR-RESOURCE.services.ai.azure.com/anthropic/`
2. **API Key** - From "Keys and Endpoint" section
3. **Deployment Name** - Your Claude model deployment (e.g., `claude-opus-4-5`)

### Step 2: Configure intro.ps1

1. **Open PowerShell** as Administrator (right-click PowerShell → Run as Administrator)

2. **Navigate to the project folder:**
   ```powershell
   cd C:\path\to\claude-cmd\docs\windows
   ```

3. **Edit intro.ps1** (use Notepad or your preferred editor):
   ```powershell
   notepad intro.ps1
   ```

4. **Replace these values (CRITICAL - all three required):**
   ```powershell
   # REQUIRED: Enable Microsoft Foundry integration
   $env:CLAUDE_CODE_USE_FOUNDRY = "1"
   
   # REQUIRED: Your Azure resource name (just the name, not full URL)
   $env:ANTHROPIC_FOUNDRY_RESOURCE = "YOUR-RESOURCE-NAME"
   
   # REQUIRED: Your API key from Azure Portal
   $env:ANTHROPIC_FOUNDRY_API_KEY = "YOUR-API-KEY-HERE"
   
   # OPTIONAL: Model deployment names
   $env:ANTHROPIC_DEFAULT_OPUS_MODEL = "claude-opus-4-5"
   ```
   
   **Important Notes:**
   - `CLAUDE_CODE_USE_FOUNDRY` must be set to "1" to enable Foundry support
   - `ANTHROPIC_FOUNDRY_RESOURCE` is just the resource name (e.g., "my-resource-eastus2"), NOT the full URL
   - `ANTHROPIC_FOUNDRY_API_KEY` is from Azure Portal, NOT a standard Anthropic API key

5. **Save and close**

### Step 3: Start Claude Code

```powershell
.\start-claude.ps1
```

That's it! Claude Code will now use your Microsoft Foundry deployment.

---

## 📖 Detailed Setup Instructions

### PowerShell Execution Policy

If you get an error about running scripts, you need to allow PowerShell scripts:

**Option 1: For this session only (safest)**
```powershell
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
```

**Option 2: For current user (recommended)**
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

**Option 3: For all users (requires Admin)**
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine
```

### File Locations

```
claude-cmd/
└── docs/
    └── windows/
        ├── intro.ps1           ← Your credentials (edit this)
        ├── start-claude.ps1    ← Start script (run this)
        ├── check-env.ps1       ← Verification script
        └── SETUP_GUIDE_WINDOWS.md  ← This file
```

### Configuration Steps

1. **Open PowerShell**
   - Press `Win + X`
   - Select "Windows PowerShell" or "Terminal"

2. **Navigate to project:**
   ```powershell
   cd C:\Users\YourUsername\Documents\claude-cmd\docs\windows
   ```

3. **Edit intro.ps1:**
   ```powershell
   notepad intro.ps1
   ```
   Update the three main variables with your Azure credentials.

4. **Verify (optional):**
   ```powershell
   .\check-env.ps1
   ```

5. **Start Claude Code:**
   ```powershell
   .\start-claude.ps1
   ```

---

## ✅ Verification

### How to Know It's Working

After starting with `.\start-claude.ps1`, you should:
- ✅ **NO** "Missing API key" error
- ✅ **NO** "Connection error"
- ✅ Claude responds to your questions
- ✅ Using your Azure Foundry deployment

### Common Success Indicators

```powershell
# When you run .\start-claude.ps1, you should see:
✅ Claude Code configured for Microsoft Foundry
   Endpoint: https://your-resource.services.ai.azure.com/anthropic/
   Model: claude-opus-4-5
   API Key: YOUR-API-KEY...

🚀 Starting Claude Code...
   Press Ctrl+C to exit
```

---

## 🐛 Troubleshooting

### Issue 1: "Cannot run scripts"

**Error:**
```
.\start-claude.ps1 : File cannot be loaded because running scripts is disabled
```

**Solution:**
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Issue 2: "Invalid API key" or "Missing API key"

**Symptoms:**
- Claude shows "API Usage Billing"
- "Invalid API key" error
- Connection errors

**Solution:**
1. Exit Claude Code (Ctrl+C)
2. Make sure you're in the right directory:
   ```powershell
   cd C:\path\to\claude-cmd\docs\windows
   ```
3. Start with the script:
   ```powershell
   .\start-claude.ps1
   ```

**⚠️ DON'T** just run `claude` - it won't load your configuration!

### Issue 3: "Connection error" or timeout

**Possible Causes:**
1. Wrong endpoint URL
2. Invalid API key
3. Azure deployment is stopped

**Solutions:**
1. Verify endpoint in `intro.ps1` ends with `/anthropic/`
2. Check API key in Azure Portal
3. Verify deployment status in Azure Portal

### Issue 4: Environment variables not persisting

**Problem:** Variables reset when you close PowerShell

**Solution:** Use `.\start-claude.ps1` every time you want to start Claude Code. The script automatically loads your configuration.

**Alternative:** Set permanent environment variables:
```powershell
# Set permanent user environment variables (run as user)
[Environment]::SetEnvironmentVariable("ANTHROPIC_BASE_URL", "https://YOUR-RESOURCE.services.ai.azure.com/anthropic/", "User")
[Environment]::SetEnvironmentVariable("ANTHROPIC_API_KEY", "YOUR-API-KEY", "User")
[Environment]::SetEnvironmentVariable("ANTHROPIC_MODEL", "claude-opus-4-5", "User")
```

---

## 🔧 Advanced Configuration

### Making Scripts Easier to Run

**Option 1: Add to Windows PATH**
1. Open System Properties → Advanced → Environment Variables
2. Edit PATH for your user
3. Add: `C:\path\to\claude-cmd\docs\windows`
4. Now you can run scripts from anywhere

**Option 2: Create Desktop Shortcut**
1. Right-click Desktop → New → Shortcut
2. Location: `powershell.exe -ExecutionPolicy Bypass -File "C:\path\to\claude-cmd\docs\windows\start-claude.ps1"`
3. Name it "Start Claude with Foundry"
4. Double-click to start!

**Option 3: Create Batch File**

Create `start-claude.bat`:
```batch
@echo off
cd /d "%~dp0"
powershell.exe -ExecutionPolicy Bypass -File ".\start-claude.ps1"
pause
```

Then just double-click the .bat file!

---

## 🧪 Testing Your Setup

### Test 1: Check Environment

```powershell
.\check-env.ps1
```

Expected output:
```
==========================================
Claude Code Environment Check (Windows)
==========================================

✅ ANTHROPIC_BASE_URL: https://your-resource...
✅ ANTHROPIC_API_KEY: YOUR-API-KEY...
✅ ANTHROPIC_MODEL: claude-opus-4-5

✅ ALL REQUIRED VARIABLES ARE SET!
```

### Test 2: Python API Test (Optional)

If you have Python installed:

```powershell
# Install Anthropic SDK
pip install anthropic

# Load configuration
.\intro.ps1

# Run test (from parent directory)
python test_foundry.py
```

---

## 🔒 Security on Windows

### Protecting Your Credentials

1. **File Permissions:**
   ```powershell
   # Make intro.ps1 readable only by you
   icacls intro.ps1 /inheritance:r
   icacls intro.ps1 /grant:r "$env:USERNAME:(R)"
   ```

2. **Never commit to Git:**
   - `intro.ps1` should be in `.gitignore`
   - Only commit `intro.ps1.template`

3. **Windows Credential Manager (Optional):**
   - Store API key in Windows Credential Manager
   - Retrieve in script:
   ```powershell
   $credential = Get-StoredCredential -Target "AzureFoundryKey"
   $env:ANTHROPIC_API_KEY = $credential.GetNetworkCredential().Password
   ```

---

## 📊 Configuration Methods

### Method 1: Per-Session (Recommended)

What we just set up - use `.\start-claude.ps1` each time.

**Pros:**
- ✅ Different configs per project
- ✅ Explicit control
- ✅ Easy to switch

### Method 2: User Environment Variables

Set once, works everywhere:

```powershell
[Environment]::SetEnvironmentVariable("ANTHROPIC_BASE_URL", "https://YOUR-RESOURCE.services.ai.azure.com/anthropic/", "User")
[Environment]::SetEnvironmentVariable("ANTHROPIC_API_KEY", "YOUR-API-KEY", "User")
[Environment]::SetEnvironmentVariable("ANTHROPIC_MODEL", "claude-opus-4-5", "User")
```

**Pros:**
- ✅ Set once, use everywhere
- ✅ No need to run script

**Cons:**
- ⚠️ Only one configuration
- ⚠️ Harder to change

### Method 3: System Environment Variables

Same as Method 2, but use `"Machine"` instead of `"User"` (requires Admin).

---

## 💡 Windows-Specific Tips

### Using Windows Terminal

Windows Terminal is recommended for better experience:

1. Install from Microsoft Store: "Windows Terminal"
2. Set as default terminal
3. Supports tabs, themes, and better rendering

### PowerShell Profile

Add to your PowerShell profile for quick access:

```powershell
# Edit profile
notepad $PROFILE

# Add this line:
function Start-ClaudeFoundry {
    cd C:\path\to\claude-cmd\docs\windows
    .\start-claude.ps1
}

# Now you can type: Start-ClaudeFoundry
```

### Command Aliases

```powershell
# Add to $PROFILE
Set-Alias -Name claude-foundry -Value "C:\path\to\claude-cmd\docs\windows\start-claude.ps1"
```

---

## 🎯 Quick Reference Card (Windows)

| Task | Command |
|------|---------|
| **Edit config** | `notepad intro.ps1` |
| **Check setup** | `.\check-env.ps1` |
| **Start Claude** | `.\start-claude.ps1` |
| **Allow scripts** | `Set-ExecutionPolicy RemoteSigned -Scope CurrentUser` |

### Essential Commands

```powershell
# Navigate to project
cd C:\path\to\claude-cmd\docs\windows

# Check configuration
.\check-env.ps1

# Start Claude Code
.\start-claude.ps1

# If you get script execution error
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

---

## 📚 Additional Resources

- [Main README](../../README.md)
- [Linux/Mac Setup Guide](../linux-mac/SETUP_GUIDE.md)
- [Configuration Methods](../CONFIG_METHODS.md)
- [Security Guide](../SECURITY.md)
- [Claude Code Documentation](https://code.claude.com/docs/)
- [Azure AI Foundry](https://learn.microsoft.com/en-us/azure/ai-foundry/)

---

## 🆘 Getting Help

If you're stuck:

1. Run `.\check-env.ps1` to verify configuration
2. Check [TROUBLESHOOTING.md](../TROUBLESHOOTING.md)
3. Verify your Azure deployment in Azure Portal
4. Make sure you're using `.\start-claude.ps1` to start Claude

---

**Last Updated:** November 30, 2025  
**Platform:** Windows 10/11, PowerShell 5.1+

