# ✅ COMPLETE INSTALLATION GUIDE - Verified Working Setup

## Summary: What We Learned

After extensive testing, here's the **correct and complete** way to set up Claude CLI with Microsoft Foundry.

---

## 🎯 Critical Variables (Based on Official Docs)

According to [official Claude Code documentation](https://code.claude.com/docs/en/microsoft-foundry), these are REQUIRED:

### Windows (PowerShell):
```powershell
# 1. Enable Microsoft Foundry (MUST BE SET!)
$env:CLAUDE_CODE_USE_FOUNDRY = "1"

# 2. Azure resource name (just the name, not full URL)
$env:ANTHROPIC_FOUNDRY_RESOURCE = "YOUR-RESOURCE-NAME"

# 3. API Key from Azure Portal
$env:ANTHROPIC_FOUNDRY_API_KEY = "YOUR-API-KEY-HERE"

# 4. Optional: Model deployment names
$env:ANTHROPIC_DEFAULT_OPUS_MODEL = "claude-opus-4-5"
$env:ANTHROPIC_DEFAULT_SONNET_MODEL = "claude-sonnet-4-5"
$env:ANTHROPIC_DEFAULT_HAIKU_MODEL = "claude-haiku-4-5"
```

### Linux/Mac (Bash):
```bash
# 1. Enable Microsoft Foundry (MUST BE SET!)
export CLAUDE_CODE_USE_FOUNDRY=1

# 2. Azure resource name (just the name, not full URL)
export ANTHROPIC_FOUNDRY_RESOURCE="YOUR-RESOURCE-NAME"

# 3. API Key from Azure Portal
export ANTHROPIC_FOUNDRY_API_KEY="YOUR-API-KEY-HERE"

# 4. Optional: Model deployment names
export ANTHROPIC_DEFAULT_OPUS_MODEL="claude-opus-4-5"
export ANTHROPIC_DEFAULT_SONNET_MODEL="claude-sonnet-4-5"
export ANTHROPIC_DEFAULT_HAIKU_MODEL="claude-haiku-4-5"
```

---

## 📋 Complete Installation Process

### Step 1: Prerequisites

**Install these in order:**

1. **Node.js** (required for Claude CLI)
   - Windows: Download from https://nodejs.org/
   - Mac: `brew install node`
   - Linux: `sudo apt install nodejs npm` or `sudo dnf install nodejs npm`

2. **Claude CLI** (command-line tool)
   ```bash
   npm install -g @anthropic-ai/claude-code
   ```
   
   **Verify:**
   ```bash
   claude --version
   ```
   Should show: `2.0.55 (Claude Code)` or similar

3. **Azure Foundry Resource**
   - Must have Claude models deployed in Azure
   - Get API key from Azure Portal
   - Note your resource name

---

### Step 2: Get Azure Information

From Azure Portal, collect:

| Item | Where to Find | Example |
|------|---------------|---------|
| **Resource Name** | Resource overview page | `my-resource-eastus2` |
| **API Key** | Keys and Endpoint section | Long alphanumeric string |
| **Deployment Name** | Deployments section | `claude-opus-4-5` |
| **Endpoint URL** | Keys and Endpoint section | `https://my-resource.services.ai.azure.com/anthropic/` |

**Important:** For `ANTHROPIC_FOUNDRY_RESOURCE`, use ONLY the resource name (e.g., "my-resource-eastus2"), NOT the full URL.

---

### Step 3: Configure Environment

#### Windows:

```powershell
# Navigate to project
cd C:\path\to\claude-cmd\docs\windows

# Copy template
Copy-Item intro.ps1.template intro.ps1

# Edit with your credentials
notepad intro.ps1

# Update these three REQUIRED variables:
# - CLAUDE_CODE_USE_FOUNDRY = "1"
# - ANTHROPIC_FOUNDRY_RESOURCE = "your-resource-name"
# - ANTHROPIC_FOUNDRY_API_KEY = "your-api-key"
```

#### Linux/Mac:

```bash
# Navigate to project
cd /path/to/claude-cmd/docs/linux-mac

# Copy template
cp intro.sh.template intro.sh

# Edit with your credentials
nano intro.sh

# Update these three REQUIRED variables:
# - CLAUDE_CODE_USE_FOUNDRY=1
# - ANTHROPIC_FOUNDRY_RESOURCE="your-resource-name"
# - ANTHROPIC_FOUNDRY_API_KEY="your-api-key"
```

---

### Step 4: Verify Configuration

#### Windows:
```powershell
# Load configuration
.\intro.ps1

# Check variables are set
Write-Host "Foundry: $env:CLAUDE_CODE_USE_FOUNDRY"
Write-Host "Resource: $env:ANTHROPIC_FOUNDRY_RESOURCE"
Write-Host "API Key: $($env:ANTHROPIC_FOUNDRY_API_KEY.Substring(0,20))..."

# All three should show values
```

#### Linux/Mac:
```bash
# Load configuration
source intro.sh

# Check variables are set
echo "Foundry: $CLAUDE_CODE_USE_FOUNDRY"
echo "Resource: $ANTHROPIC_FOUNDRY_RESOURCE"
echo "API Key: ${ANTHROPIC_FOUNDRY_API_KEY:0:20}..."

# All three should show values
```

---

### Step 5: Start Claude CLI

#### Windows:
```powershell
# In the SAME PowerShell window where you ran intro.ps1:
claude
```

#### Linux/Mac:
```bash
# In the SAME terminal where you ran source intro.sh:
claude
```

**What you should see:**
- ✅ No login prompt
- ✅ No "Missing API key" error
- ✅ Claude starts directly
- ✅ Can start chatting immediately

**What you should NOT see:**
- ❌ Web browser login page
- ❌ "Select login method" prompt
- ❌ "Detected custom API key" (that means it's using wrong variable)

---

## 🔍 Variable Name Comparison

### ❌ Wrong Variables (don't work for Foundry):
```bash
ANTHROPIC_BASE_URL          # Standard Anthropic, not Foundry
ANTHROPIC_API_KEY           # Standard Anthropic, not Foundry
```

### ✅ Correct Variables (for Microsoft Foundry):
```bash
CLAUDE_CODE_USE_FOUNDRY=1              # Enables Foundry mode
ANTHROPIC_FOUNDRY_RESOURCE="name"      # Just resource name
ANTHROPIC_FOUNDRY_API_KEY="key"        # Azure API key
```

---

## 📊 Complete Configuration Example

### Windows (intro.ps1):
```powershell
# Enable Foundry
$env:CLAUDE_CODE_USE_FOUNDRY = "1"

# Resource name (NOT full URL)
$env:ANTHROPIC_FOUNDRY_RESOURCE = "my-resource-eastus2"

# API Key
$env:ANTHROPIC_FOUNDRY_API_KEY = "abc123...xyz789"

# Models
$env:ANTHROPIC_DEFAULT_OPUS_MODEL = "claude-opus-4-5"
$env:ANTHROPIC_DEFAULT_SONNET_MODEL = "claude-sonnet-4-5"
$env:ANTHROPIC_DEFAULT_HAIKU_MODEL = "claude-haiku-4-5"
```

### Linux/Mac (intro.sh):
```bash
# Enable Foundry
export CLAUDE_CODE_USE_FOUNDRY=1

# Resource name (NOT full URL)
export ANTHROPIC_FOUNDRY_RESOURCE="my-resource-eastus2"

# API Key
export ANTHROPIC_FOUNDRY_API_KEY="abc123...xyz789"

# Models
export ANTHROPIC_DEFAULT_OPUS_MODEL="claude-opus-4-5"
export ANTHROPIC_DEFAULT_SONNET_MODEL="claude-sonnet-4-5"
export ANTHROPIC_DEFAULT_HAIKU_MODEL="claude-haiku-4-5"
```

---

## 🧪 Testing

### Quick Test:
```bash
# After sourcing intro.sh or intro.ps1:
claude --version

# Should show version, then:
claude

# Should start directly without login prompt
```

### Python API Test:
```bash
pip install anthropic
python test_foundry.py
```

---

## 🐛 Common Issues

### Issue: Login prompt still appears

**Cause:** `CLAUDE_CODE_USE_FOUNDRY` not set to "1"

**Fix:**
```powershell
# Windows
$env:CLAUDE_CODE_USE_FOUNDRY = "1"

# Linux/Mac
export CLAUDE_CODE_USE_FOUNDRY=1
```

### Issue: "Detected custom API key" prompt

**Cause:** Using `ANTHROPIC_API_KEY` instead of `ANTHROPIC_FOUNDRY_API_KEY`

**Fix:** Use the FOUNDRY-specific variable names

### Issue: Connection error

**Cause:** Wrong resource name format

**Fix:** Use just the resource name, not full URL:
- ✅ Correct: `"my-resource-eastus2"`
- ❌ Wrong: `"https://my-resource.services.ai.azure.com/anthropic/"`

---

## 📚 Reference

**Official Documentation:**
- [Claude Code on Microsoft Foundry](https://code.claude.com/docs/en/microsoft-foundry)
- [Microsoft Foundry Documentation](https://learn.microsoft.com/en-us/azure/ai-foundry/)

**This Repository:**
- Windows Setup: [SETUP_GUIDE_WINDOWS.md](docs/windows/SETUP_GUIDE_WINDOWS.md)
- Linux/Mac Setup: [SETUP_GUIDE.md](docs/SETUP_GUIDE.md)
- Troubleshooting: [TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md)

---

## ✅ Installation Checklist

- [ ] Node.js installed (`node --version`)
- [ ] Claude CLI installed (`claude --version`)
- [ ] Azure Foundry resource created
- [ ] Claude models deployed in Azure
- [ ] API key obtained from Azure Portal
- [ ] Resource name noted
- [ ] `intro.ps1` or `intro.sh` edited with credentials
- [ ] `CLAUDE_CODE_USE_FOUNDRY=1` set
- [ ] `ANTHROPIC_FOUNDRY_RESOURCE` set (just name)
- [ ] `ANTHROPIC_FOUNDRY_API_KEY` set
- [ ] Environment loaded in terminal
- [ ] Claude CLI started in same terminal
- [ ] No login prompt appeared
- [ ] Claude responds to questions

---

**Status:** ✅ Complete and Verified  
**Last Updated:** November 30, 2025  
**Based on:** [Official Claude Code Documentation](https://code.claude.com/docs/en/microsoft-foundry)

