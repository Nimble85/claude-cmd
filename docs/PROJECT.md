# 🎯 Project Overview

This project provides a clean, ready-to-use setup for configuring Claude Code with Microsoft Azure Foundry.

---

## 📁 Project Structure

```
claude-cmd/
├── 🔧 Configuration Files
│   ├── intro.sh              # Your credentials (EDIT THIS)
│   └── intro.sh.template     # Template for fresh setups
│
├── 🚀 Launcher Scripts
│   ├── start-claude.sh       # Start Claude with Foundry config
│   └── check-env.sh          # Verify environment setup
│
├── 🧪 Testing
│   └── test_foundry.py       # Test API connection
│
├── 📖 Documentation
│   ├── README.md             # Main setup guide
│   ├── QUICKSTART.md         # Quick reference
│   ├── SETUP_GUIDE.md        # Comprehensive documentation
│   └── PROJECT.md            # This file
│
└── 🔒 Security
    └── .gitignore            # Protects credentials
```

---

## 🎯 Purpose

This setup allows you to use Claude Code (CLI) with your own Microsoft Azure Foundry deployment instead of the standard Anthropic API.

**Benefits:**
- ✅ Use your Azure credits
- ✅ Enterprise compliance
- ✅ Custom rate limits
- ✅ Regional deployments

---

## 🚀 Quick Start for New Users

### First Time Setup:

1. **Edit configuration:**
   ```bash
   nano intro.sh
   ```
   Update:
   - `ANTHROPIC_BASE_URL` → Your Azure endpoint
   - `ANTHROPIC_API_KEY` → Your API key from Azure
   - `ANTHROPIC_MODEL` → Your deployment name

2. **Start Claude:**
   ```bash
   ./start-claude.sh
   ```

3. **Verify it works!**

---

## 📖 Documentation Hierarchy

1. **README.md** - Start here for complete setup instructions
2. **QUICKSTART.md** - Quick reference guide
3. **SETUP_GUIDE.md** - Deep dive with troubleshooting
4. **PROJECT.md** - This overview

---

## 🔄 Workflow

```
┌─────────────────┐
│  Edit intro.sh  │ ← Configure your credentials
└────────┬────────┘
         │
         ↓
┌─────────────────┐
│ ./check-env.sh  │ ← (Optional) Verify setup
└────────┬────────┘
         │
         ↓
┌─────────────────┐
│ test_foundry.py │ ← (Optional) Test API
└────────┬────────┘
         │
         ↓
┌─────────────────┐
│./start-claude.sh│ ← Start Claude Code
└─────────────────┘
```

---

## 🛠️ Key Files Explained

### intro.sh
**Purpose:** Configuration file with your Azure credentials  
**Action:** Edit with your actual Azure Foundry details  
**Security:** Protected by .gitignore, never commit with real credentials

### start-claude.sh
**Purpose:** Launches Claude Code with proper environment  
**Action:** Run this to start Claude Code  
**Benefits:** Automatically loads intro.sh before starting

### check-env.sh
**Purpose:** Verifies environment variables are set correctly  
**Action:** Run before starting if unsure  
**Output:** Shows which variables are set/missing

### test_foundry.py
**Purpose:** Tests API connection to Azure Foundry  
**Action:** Run to verify credentials work  
**Requires:** Python 3.8+ and `anthropic` package

---

## 🔐 Security Model

### Protected Files (in .gitignore):
- `intro.sh` - Contains your real credentials

### Safe to Commit:
- `intro.sh.template` - No real credentials
- All scripts - No credentials
- All documentation - No credentials

### Best Practices:
1. Never commit `intro.sh` with real credentials
2. Use `intro.sh.template` for sharing
3. Rotate API keys regularly
4. Keep Azure Portal access restricted

---

## 🐛 Troubleshooting Quick Reference

| Issue | Quick Fix |
|-------|-----------|
| "Missing API key" | Exit and run `./start-claude.sh` |
| "Connection error" | Check `intro.sh` credentials |
| Variables not set | Run `source intro.sh` |
| Need to verify | Run `./check-env.sh` |

See SETUP_GUIDE.md for detailed troubleshooting.

---

## 🔄 Making Changes

### To Update Credentials:
1. Edit `intro.sh`
2. Restart Claude Code

### To Share Setup:
1. Copy `intro.sh.template`
2. Share the template (safe, no credentials)
3. Recipient edits with their credentials

### To Start Fresh:
1. `cp intro.sh.template intro.sh`
2. Edit with your credentials
3. Run `./start-claude.sh`

---

## 📊 What This Setup Does

**Before:**
```
Claude Code → Anthropic API (requires Anthropic credits)
```

**After:**
```
Claude Code → Your Azure Foundry → Claude Models
           (uses your Azure credits)
```

---

## 🎓 Learning Path

1. **Beginner:** Just edit `intro.sh` and run `./start-claude.sh`
2. **Intermediate:** Understand environment variables, use `check-env.sh`
3. **Advanced:** Read SETUP_GUIDE.md, customize for your workflow

---

## ✅ Validation Checklist

Before considering setup complete:

- [ ] Edited `intro.sh` with real credentials
- [ ] Ran `./check-env.sh` successfully
- [ ] Ran `test_foundry.py` successfully
- [ ] Started Claude Code with `./start-claude.sh`
- [ ] Asked Claude a question and got response
- [ ] No "Missing API key" errors
- [ ] No "Connection error" messages

---

## 🤝 Contributing

This is a personal setup project. To adapt for your team:

1. Fork/copy the entire directory
2. Update `intro.sh.template` with your org's endpoint format
3. Add org-specific instructions to README.md
4. Share the template (not your configured intro.sh!)

---

## 📝 Version History

- **v1.0** (Nov 30, 2025) - Initial clean setup
  - Fixed environment variable names
  - Simplified structure
  - Added comprehensive documentation

---

## 🔗 External Resources

- [Claude Code Documentation](https://code.claude.com/docs/en/third-party-integrations)
- [Azure AI Foundry](https://learn.microsoft.com/en-us/azure/ai-foundry/)
- [Anthropic API Docs](https://docs.anthropic.com/)

---

**Status:** ✅ Production Ready  
**Last Updated:** November 30, 2025  
**Maintained By:** Project Team

