# ✨ Auto-Installation Feature Added!

Claude Code can now be automatically installed when running the start scripts.

---

## 🎯 What's New

### Windows (PowerShell)
- ✅ **`install-claude.ps1`** - Standalone installation script
- ✅ **Updated `start-claude.ps1`** - Offers to install if not found
- ✅ Auto-detects Node.js and npm
- ✅ Provides download links if npm not available

### Linux/Mac (Bash)
- ✅ **`install-claude.sh`** - Standalone installation script  
- ✅ **Updated `start-claude.sh`** - Offers to install if not found
- ✅ Auto-detects Node.js and npm
- ✅ Platform-specific installation instructions

---

## 🚀 How It Works

### Automatic Installation (Recommended)

Just run the start script - it will check and install if needed:

**Windows:**
```powershell
.\start-claude.ps1
```

**Linux/Mac:**
```bash
./start-claude.sh
```

If Claude Code is not installed, you'll see:
```
❌ Claude Code is not installed

Would you like to install it now? (Y/N)
```

Type `Y` and it will install automatically!

---

### Manual Installation

You can also install Claude Code separately:

**Windows:**
```powershell
.\install-claude.ps1
```

**Linux/Mac:**
```bash
./install-claude.sh
```

---

## 📋 Installation Methods

### Method 1: Via npm (Automatic)

If you have Node.js installed:
- Script detects Node.js and npm
- Runs: `npm install -g @anthropic-ai/claude-code`
- Verifies installation
- Ready to use!

**Pros:**
- ✅ Fully automatic
- ✅ Always latest version
- ✅ Easy to update (`npm update -g`)

**Requires:**
- Node.js 16+ and npm

### Method 2: Direct Download (Manual)

If npm is not available:
- Script opens: https://claude.ai/download
- Download installer for your platform
- Run installer
- Ready to use!

**Pros:**
- ✅ No Node.js required
- ✅ Official installer
- ✅ Includes all dependencies

---

## 🔍 Installation Flow

```
Start script runs
       ↓
Is Claude installed? ──Yes──→ Continue with setup
       ↓ No
       ↓
Ask user: Install now?
       ↓ Yes
       ↓
Check Node.js/npm
       ↓
┌──────┴──────┐
│             │
npm found   npm not found
│             │
Install     Open download page
via npm     & exit
│
Verify installation
│
Continue with setup
```

---

## 📖 Updated Files

### Windows
- `docs/windows/install-claude.ps1` ← NEW
- `docs/windows/start-claude.ps1` ← Updated (added auto-install)
- `docs/windows/SETUP_GUIDE_WINDOWS.md` ← Updated docs

### Linux/Mac
- `docs/linux-mac/install-claude.sh` ← NEW
- `docs/linux-mac/start-claude.sh` ← Updated (added auto-install)

---

## 💡 Usage Examples

### First-Time Setup (No Claude Code installed)

**Windows:**
```powershell
cd docs\windows
.\start-claude.ps1

# Output:
🔍 Checking Claude Code installation...
❌ Claude Code is not installed

Would you like to install it now? (Y/N): Y

Running installation script...
Installing Claude Code via npm...
✅ Claude Code installed successfully!
   Version: 2.0.55

🔧 Loading Microsoft Foundry configuration...
✅ Claude Code configured for Microsoft Foundry
🚀 Starting Claude Code...
```

### Just Install Claude Code

**Windows:**
```powershell
.\install-claude.ps1
```

**Linux/Mac:**
```bash
./install-claude.sh
```

---

## 🎯 Benefits

1. **Easier Onboarding**
   - New users don't need to install Claude Code separately
   - One command does everything

2. **Smart Detection**
   - Checks if already installed (no duplicate installations)
   - Verifies installation before proceeding

3. **Flexible Options**
   - npm installation (automatic)
   - Direct download (manual)
   - User can skip and install later

4. **Cross-Platform**
   - Works on Windows, Linux, and macOS
   - Platform-specific instructions

---

## 🔧 Technical Details

### Windows PowerShell Script

```powershell
# Check if Claude is installed
try {
    $null = & claude --version 2>&1
    if ($LASTEXITCODE -eq 0) {
        $claudeInstalled = $true
    }
} catch {
    $claudeInstalled = $false
}

# Install if not found
if (-not $claudeInstalled) {
    # Check Node.js
    # Install via npm
    # Or guide to download page
}
```

### Linux/Mac Bash Script

```bash
# Check if Claude is installed
if ! command -v claude &> /dev/null; then
    echo "Not installed"
    
    # Check Node.js
    # Install via npm
    # Or provide instructions
fi
```

---

## ✅ Installation Checklist

The script checks:
- [ ] Is Claude Code already installed?
- [ ] Is Node.js available?
- [ ] Is npm available?
- [ ] Can install via npm?
- [ ] If not, guide to download page

---

## 🆘 Troubleshooting

### Issue: npm not found

**Solution:** Install Node.js first
- Windows: Download from https://nodejs.org/
- macOS: `brew install node`
- Linux: Use your package manager

### Issue: Permission denied (Linux/Mac)

**Solution:** Install with sudo
```bash
sudo npm install -g @anthropic-ai/claude-code
```

### Issue: Installation fails

**Solution:** Download directly
- Visit: https://claude.ai/download
- Choose your platform
- Run installer

---

## 📊 Summary

| Feature | Windows | Linux/Mac |
|---------|---------|-----------|
| **Auto-install in start script** | ✅ | ✅ |
| **Standalone install script** | ✅ | ✅ |
| **npm detection** | ✅ | ✅ |
| **Node.js detection** | ✅ | ✅ |
| **Download page fallback** | ✅ | ✅ |
| **Version verification** | ✅ | ✅ |

---

**Status:** ✅ Complete  
**Platforms:** Windows, Linux, macOS  
**Added:** November 30, 2025

