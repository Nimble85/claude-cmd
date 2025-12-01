# ⚠️ Important: CLI vs Desktop

## This Setup is for Claude CLI (Terminal), NOT Claude Desktop

This project configures the **Claude Code CLI** - the command-line/terminal tool.

---

## What's the Difference?

### Claude CLI (What this sets up) ✅
- **What:** Terminal/command-line tool
- **How to run:** Type `claude` in terminal
- **Installation:** `npm install -g @anthropic-ai/claude-code`
- **Use case:** Terminal-based interaction, scripting, automation
- **This setup:** Configures it to use Azure Foundry

### Claude Desktop (NOT this) ❌
- **What:** GUI desktop application
- **How to run:** Click icon to open window
- **Installation:** Download .exe/.dmg installer
- **Use case:** Visual interface, file browsing
- **This setup:** Does NOT configure desktop app

---

## How to Install Claude CLI

### Windows:
```powershell
# Via npm (recommended)
npm install -g @anthropic-ai/claude-code

# Or use our script
cd docs\windows
.\install-claude.ps1
```

### Linux/Mac:
```bash
# Via npm (recommended)
npm install -g @anthropic-ai/claude-code

# Or use our script
cd docs/linux-mac
./install-claude.sh
```

---

## Verify You Have the Right Tool

After installation, run:
```bash
claude --version
```

You should see something like:
```
2.0.55 (Claude Code)
```

If this works, you have the **CLI version** (correct!).

---

## If You Want Claude Desktop Instead

This repository is **not** for Claude Desktop. Claude Desktop has its own configuration system and doesn't use environment variables the same way.

For Claude Desktop, visit: https://claude.ai/download

---

## Summary

| Feature | Claude CLI (This Setup) | Claude Desktop |
|---------|------------------------|----------------|
| **Type** | Terminal/Command-line | GUI Application |
| **Command** | `claude` | Click icon |
| **Config** | Environment variables | App settings |
| **This repo configures** | ✅ YES | ❌ NO |

---

**This repository is specifically for the Claude CLI tool that runs in your terminal!**

