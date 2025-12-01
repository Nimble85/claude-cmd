# ⚠️ Common Issues & Quick Fixes

## Issue: "Invalid API key" or "Missing API key" Error

### Symptom
Claude Code shows:
- "API Usage Billing" (instead of your Azure deployment)
- "Invalid API key · Please run /login"
- "Connection error"
- "Unable to connect to API"

### Root Cause
Claude Code was started **without** the Microsoft Foundry environment variables.

### ✅ Solution

**Exit Claude Code and restart properly:**

```bash
# 1. Exit Claude Code (press Ctrl+C or type /exit)

# 2. Navigate to project directory
cd /Users/sklymo/Documents/git/claude_test/claude-cmd

# 3. Start Claude Code the RIGHT way
./start-claude.sh
```

### ❌ DON'T Do This
```bash
claude  # ← Wrong! Doesn't load your config
```

### ✅ DO This
```bash
./start-claude.sh  # ← Correct! Loads your Azure config
```

---

## Issue: "Connection error" or "Poor internet connection"

### Symptom
- Retrying connection attempts
- Timeout errors
- "Unable to connect to API"

### Possible Causes

1. **Not using Azure Foundry config** (most common)
   - Fix: Use `./start-claude.sh` to start

2. **Wrong endpoint URL in intro.sh**
   - Check: `ANTHROPIC_BASE_URL` should end with `/anthropic/`
   - Fix: Edit `intro.sh` and correct the URL

3. **Invalid API key**
   - Check: Verify API key in Azure Portal
   - Fix: Update `ANTHROPIC_API_KEY` in `intro.sh`

4. **Azure deployment is stopped/suspended**
   - Check: Azure Portal → Your Foundry Resource → Deployments
   - Fix: Ensure deployment status is "Succeeded"

---

## How to Tell if It's Working

### ✅ Good Signs
- No "Missing API key" error at bottom
- Claude responds to your questions
- No connection errors or retries

### ❌ Bad Signs
- "API Usage Billing" in status bar
- "Missing API key · Run /login"
- "Connection error" messages
- Constant retry attempts

---

## Quick Diagnostic Commands

```bash
# Check if environment is configured
./check-env.sh

# Run full troubleshooter
./troubleshoot.sh

# Test API connection
source intro.sh && python3 test_foundry.py
```

---

## The Golden Rule

**Always start Claude Code with:**
```bash
./start-claude.sh
```

**Never start with:**
```bash
claude  # ← This won't use your Azure config!
```

---

## Why This Happens

Claude Code needs environment variables set **before** it starts:

```
❌ Wrong Order:
1. Start claude
2. Try to load config → Too late!

✅ Correct Order:
1. Load config (source intro.sh)
2. Start claude → Config is active!
```

The `./start-claude.sh` script does this in the correct order automatically.

---

## Still Having Issues?

Run the troubleshooter:
```bash
./troubleshoot.sh
```

This will:
1. ✅ Check configuration exists
2. ✅ Load environment variables
3. ✅ Verify all settings
4. ✅ Test API connection
5. ✅ Give you specific instructions

---

## Quick Reference Card

| Scenario | Command | Why |
|----------|---------|-----|
| **First time** | `./troubleshoot.sh` | Diagnose setup |
| **Every time** | `./start-claude.sh` | Start Claude correctly |
| **Check config** | `./check-env.sh` | Verify environment |
| **Test API** | `python3 test_foundry.py` | Test connection |
| **Having issues** | `./troubleshoot.sh` | Full diagnosis |

---

**Remember:** If you see "API Usage Billing" or "Invalid API key", you forgot to use `./start-claude.sh`! 🎯

