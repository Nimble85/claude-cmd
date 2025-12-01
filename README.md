# Claude Code CLI + Microsoft Foundry Setup

Complete setup for configuring **Claude Code CLI** (terminal/command-line tool) to use Microsoft Azure Foundry on your local machine.

> **⚠️ Important:** This is for the **Claude CLI** (terminal version), not Claude Desktop app.

---

## 🖥️ Choose Your Operating System

### Windows
👉 **[Windows Setup Guide](docs/windows/SETUP_GUIDE_WINDOWS.md)**

**Quick Start:**
```powershell
cd docs\windows
notepad intro.ps1           # Edit with your credentials
.\start-claude.ps1          # Start Claude Code
```

---

### Linux / macOS
👉 **[Linux/Mac Setup Guide](docs/SETUP_GUIDE.md)**

**Quick Start:**
```bash
cd docs/linux-mac
nano intro.sh               # Edit with your credentials
./start-claude.sh           # Start Claude Code
```

---

## 📁 Project Structure

```
claude-cmd/
├── README.md                          ← You are here
│
├── docs/                              ← Documentation
│   ├── windows/                       ← Windows-specific
│   │   ├── intro.ps1                  ← Windows config
│   │   ├── start-claude.ps1           ← Windows start script
│   │   ├── check-env.ps1              ← Windows checker
│   │   └── SETUP_GUIDE_WINDOWS.md     ← Windows guide
│   │
│   ├── linux-mac/                     ← Linux/Mac-specific
│   │   ├── intro.sh                   ← Bash config
│   │   ├── intro.sh.template          ← Template
│   │   ├── start-claude.sh            ← Bash start script
│   │   ├── check-env.sh               ← Bash checker
│   │   └── troubleshoot.sh            ← Diagnostics
│   │
│   ├── SETUP_GUIDE.md                 ← Comprehensive guide
│   ├── QUICKSTART.md                  ← Quick reference
│   ├── CONFIG_METHODS.md              ← Configuration options
│   ├── SECURITY.md                    ← Security guide
│   ├── TROUBLESHOOTING.md             ← Common issues
│   ├── PROJECT.md                     ← Project overview
│   └── INDEX.md                       ← Documentation index
│
└── test_foundry.py                    ← API test script (Python)
```

---

## 🎯 What This Setup Does

**Before:**
```
Claude CLI → Anthropic API (requires Anthropic subscription)
```

**After:**
```
Claude CLI (terminal) → Your Azure Foundry → Claude Models
                     (uses your Azure credits & deployments)
```

> **Note:** This configures the **Claude Code CLI** - the terminal/command-line tool you run with `claude` command. This is NOT for Claude Desktop (the GUI app).

---

## 📋 Prerequisites

- ✅ **Azure Account** with Microsoft Foundry access
- ✅ **Claude Code** installed
- ✅ **Azure Foundry Deployment** with Claude models
- ✅ **API Key** from Azure Portal

---

## 🚀 Quick Start by Platform

### Windows Users

1. **Get Azure credentials** from Azure Portal
2. **Edit configuration:**
   ```powershell
   cd docs\windows
   notepad intro.ps1
   ```
3. **Update these values:**
   ```powershell
   $env:ANTHROPIC_BASE_URL = "https://YOUR-RESOURCE.services.ai.azure.com/anthropic/"
   $env:ANTHROPIC_API_KEY = "YOUR-API-KEY-HERE"
   $env:ANTHROPIC_MODEL = "claude-opus-4-5"
   ```
4. **Start Claude:**
   ```powershell
   .\start-claude.ps1
   ```

### Linux/Mac Users

1. **Get Azure credentials** from Azure Portal
2. **Edit configuration:**
   ```bash
   cd docs/linux-mac
   nano intro.sh
   ```
3. **Update these values:**
   ```bash
   export ANTHROPIC_BASE_URL="https://YOUR-RESOURCE.services.ai.azure.com/anthropic/"
   export ANTHROPIC_API_KEY="YOUR-API-KEY-HERE"
   export ANTHROPIC_MODEL="claude-opus-4-5"
   ```
4. **Start Claude:**
   ```bash
   ./start-claude.sh
   ```

---

## 📖 Documentation

### Essential Guides

| Document | Description | Platform |
|----------|-------------|----------|
| [Windows Setup](docs/windows/SETUP_GUIDE_WINDOWS.md) | Complete Windows guide | Windows |
| [Linux/Mac Setup](docs/SETUP_GUIDE.md) | Complete Linux/Mac guide | Linux/Mac |
| [Quick Start](docs/QUICKSTART.md) | Quick reference | All |
| [Troubleshooting](docs/TROUBLESHOOTING.md) | Common issues & fixes | All |

### Additional Documentation

| Document | Purpose |
|----------|---------|
| [CONFIG_METHODS.md](docs/CONFIG_METHODS.md) | Compare configuration approaches |
| [SECURITY.md](docs/SECURITY.md) | Security best practices |
| [PROJECT.md](docs/PROJECT.md) | Project structure overview |
| [INDEX.md](docs/INDEX.md) | Complete documentation index |

---

## ✅ Verification

### How to Know It's Working

After starting Claude Code properly, you should:
- ✅ **NO** "Missing API key" error
- ✅ **NO** "API Usage Billing" (that means it's using standard Anthropic, not your Foundry)
- ✅ **NO** "Connection error"
- ✅ Claude responds to your questions

---

## 🐛 Common Issues

### Issue: "Invalid API key" or "Missing API key"

**Cause:** Claude Code started without loading your configuration.

**Fix:**
- **Windows:** Use `.\start-claude.ps1` (not just `claude`)
- **Linux/Mac:** Use `./start-claude.sh` (not just `claude`)

### Issue: "Connection error"

**Possible causes:**
1. Wrong endpoint URL
2. Invalid API key
3. Azure deployment is stopped

**Fix:** Verify credentials in Azure Portal and update config file.

---

## 🔒 Security

- ✅ Configuration files with credentials are protected by `.gitignore`
- ✅ Only template files (without real credentials) are tracked by git
- ✅ Each platform has its own isolated configuration
- ✅ Never commit files with real API keys

**Protected files:**
- `docs/windows/intro.ps1` (Windows credentials)
- `docs/linux-mac/intro.sh` (Linux/Mac credentials)

---

## 🆘 Getting Help

1. **Check your platform's setup guide:**
   - [Windows](docs/windows/SETUP_GUIDE_WINDOWS.md)
   - [Linux/Mac](docs/SETUP_GUIDE.md)

2. **Run diagnostic tools:**
   - **Windows:** `.\check-env.ps1`
   - **Linux/Mac:** `./check-env.sh` or `./troubleshoot.sh`

3. **Review troubleshooting guide:**
   - [TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md)

---

## 🎓 Learning Path

1. **Beginner:** Choose your OS → Follow Quick Start → Done!
2. **Intermediate:** Read platform-specific setup guide
3. **Advanced:** Explore CONFIG_METHODS.md and customize

---

## 📊 Features

- ✅ **Multi-platform support:** Windows, Linux, macOS
- ✅ **Multiple configuration methods:** Per-project or global
- ✅ **Comprehensive documentation:** 1,500+ lines
- ✅ **Security-focused:** Credentials protected
- ✅ **Diagnostic tools:** Built-in troubleshooting
- ✅ **Testing utilities:** Verify API connection

---

## 📝 Contributing

This is a setup template. To adapt for your organization:

1. Fork/copy this repository
2. Update templates with your organization's defaults
3. Customize documentation for your environment
4. Share templates (not configured files with real credentials!)

---

## 📚 External Resources

- [Claude Code Documentation](https://code.claude.com/docs/)
- [Azure AI Foundry](https://learn.microsoft.com/en-us/azure/ai-foundry/)
- [Anthropic API Docs](https://docs.anthropic.com/)

---

**Last Updated:** November 30, 2025  
**Version:** 2.0  
**Platforms:** Windows 10/11, Linux, macOS
