# ✅ CORRECT CONFIGURATION - Verified Working

Based on [official Claude Code documentation](https://code.claude.com/docs/en/microsoft-foundry) and testing.

---

## 🎯 The Three Critical Variables

These **MUST** be set for Claude CLI to use Microsoft Foundry:

### 1. Enable Foundry Mode
```bash
CLAUDE_CODE_USE_FOUNDRY=1
```
**Without this, Claude Code won't use Foundry at all!**

### 2. Azure Resource Name
```bash
ANTHROPIC_FOUNDRY_RESOURCE="your-resource-name"
```
**Format:** Just the resource name (e.g., "my-resource-eastus2")  
**NOT:** The full URL

### 3. Azure API Key
```bash
ANTHROPIC_FOUNDRY_API_KEY="your-azure-api-key"
```
**From:** Azure Portal → Keys and Endpoint section  
**NOT:** Standard Anthropic API key

---

## 📋 Complete Windows Configuration

### Edit `docs/windows/intro.ps1`:
```powershell
# CRITICAL: Enable Microsoft Foundry
$env:CLAUDE_CODE_USE_FOUNDRY = "1"

# Your Azure resource name (just the name)
$env:ANTHROPIC_FOUNDRY_RESOURCE = "my-resource-eastus2"

# Your API key from Azure Portal
$env:ANTHROPIC_FOUNDRY_API_KEY = "your-key-here"

# Optional: Model names
$env:ANTHROPIC_DEFAULT_OPUS_MODEL = "claude-opus-4-5"
```

### Run:
```powershell
cd docs\windows
.\intro.ps1
claude
```

---

## 📋 Complete Linux/Mac Configuration

### Edit `docs/linux-mac/intro.sh`:
```bash
# CRITICAL: Enable Microsoft Foundry
export CLAUDE_CODE_USE_FOUNDRY=1

# Your Azure resource name (just the name)
export ANTHROPIC_FOUNDRY_RESOURCE="my-resource-eastus2"

# Your API key from Azure Portal
export ANTHROPIC_FOUNDRY_API_KEY="your-key-here"

# Optional: Model names
export ANTHROPIC_DEFAULT_OPUS_MODEL="claude-opus-4-5"
```

### Run:
```bash
cd docs/linux-mac
source intro.sh
claude
```

---

## ✅ Success Indicators

When configured correctly:
- ✅ **No web browser login** page opens
- ✅ **No "Select login method"** prompt
- ✅ **No "Detected custom API key"** warning
- ✅ Claude CLI **starts directly** and is ready to use
- ✅ Using **your Azure Foundry** deployment

---

## ❌ Failure Indicators

If you see these, configuration is wrong:
- ❌ Web browser opens to console.anthropic.com
- ❌ "Select login method" prompt appears
- ❌ "Detected custom API key sk-ant-..." message
- ❌ "Missing API key" error
- ❌ "Connection error" messages

---

## 🔍 Variable Name Matters!

### ❌ WRONG (Standard Anthropic):
```bash
ANTHROPIC_BASE_URL          # Wrong for Foundry
ANTHROPIC_API_KEY           # Wrong for Foundry
```

### ✅ CORRECT (Microsoft Foundry):
```bash
CLAUDE_CODE_USE_FOUNDRY=1              # Enable Foundry mode
ANTHROPIC_FOUNDRY_RESOURCE="name"      # Azure resource name
ANTHROPIC_FOUNDRY_API_KEY="key"        # Azure API key
```

---

## 📖 Files Updated

All configuration files now use the correct variables:

**Windows:**
- ✅ `docs/windows/intro.ps1` - Correct variables
- ✅ `docs/windows/intro.ps1.template` - Correct template
- ✅ `docs/windows/check-env.ps1` - Checks Foundry variables
- ✅ `docs/windows/SETUP_GUIDE_WINDOWS.md` - Updated guide

**Linux/Mac:**
- ✅ `docs/linux-mac/intro.sh` - Correct variables
- ✅ `docs/linux-mac/intro.sh.template` - Correct template
- ✅ `docs/linux-mac/check-env.sh` - Checks Foundry variables

**Documentation:**
- ✅ `docs/COMPLETE_INSTALL_GUIDE.md` - New comprehensive guide
- ✅ `docs/COMPLETE_ENV_VARS.md` - All variable options
- ✅ All references to official documentation added

---

## 🔗 Official References

All configuration based on:
- [Claude Code on Microsoft Foundry](https://code.claude.com/docs/en/microsoft-foundry)

---

## 🎯 Quick Command Reference

### Windows:
```powershell
# Check configuration
.\check-env.ps1

# Load environment
.\intro.ps1

# Start Claude
claude
```

### Linux/Mac:
```bash
# Check configuration
./check-env.sh

# Load environment
source intro.sh

# Start Claude
claude
```

---

**Status:** ✅ Complete and verified with official documentation  
**Last Updated:** November 30, 2025

