# Claude Code + Microsoft Foundry Setup

Quick setup guide for connecting Claude Code to Microsoft Azure Foundry.

---

## ⚡ Quick Start

### For First-Time Setup:

1. **Configure credentials:**
   ```bash
   # Edit intro.sh with your Azure Foundry details
   nano intro.sh  # or use your preferred editor
   ```

2. **Start Claude Code:**
   ```bash
   ./start-claude.sh
   ```

3. **Done!** Ask Claude a question to verify it's working.

---

## 📦 Files Overview

```
claude-cmd/
├── intro.sh              # Your configuration (edit this with your credentials)
├── intro.sh.template     # Template for new setups
├── start-claude.sh       # Start script (run this)
├── check-env.sh          # Verification tool
├── test_foundry.py       # API connection test
├── README.md             # This file
├── SETUP_GUIDE.md        # Detailed documentation
└── .gitignore            # Protects your credentials
```

---

## 🔧 Setup From Scratch

### Step 1: Get Azure Foundry Credentials

From Azure Portal, you need:
- **Endpoint URL:** `https://YOUR-RESOURCE.services.ai.azure.com/anthropic/`
- **API Key:** From "Keys and Endpoint" section
- **Deployment Name:** Your Claude model deployment name

### Step 2: Configure intro.sh

Edit `intro.sh` and update these three variables:

```bash
export ANTHROPIC_BASE_URL="https://YOUR-RESOURCE.services.ai.azure.com/anthropic/"
export ANTHROPIC_API_KEY="YOUR-API-KEY-HERE"
export ANTHROPIC_MODEL="YOUR-DEPLOYMENT-NAME"
```

### Step 3: Verify (Optional)

```bash
./check-env.sh
```

### Step 4: Test (Optional)

```bash
pip3 install anthropic
source intro.sh
python3 test_foundry.py
```

### Step 5: Start Claude Code

```bash
./start-claude.sh
```

---

## ✅ Success Indicators

After starting, Claude Code should:
- ✅ Start without "Missing API key" error
- ✅ Respond to your questions
- ✅ Use your Microsoft Foundry deployment

---

## 🐛 Common Issues

### "Missing API key" error
**Fix:** Exit Claude and restart with `./start-claude.sh`

### "Connection error"
**Fix:** 
1. Check your API key in `intro.sh`
2. Verify endpoint URL format
3. Ensure deployment is active in Azure Portal

### Variables not persisting
**Fix:** Add to your shell profile:
```bash
echo 'source /path/to/intro.sh' >> ~/.zshrc
```

---

## 📚 Documentation

- **README.md** - This quick start guide
- **SETUP_GUIDE.md** - Comprehensive documentation with troubleshooting
- **intro.sh.template** - Clean template for new setups

---

## 🔒 Security

- `intro.sh` is in `.gitignore` to protect your credentials
- Never commit API keys to version control
- Rotate keys regularly in Azure Portal

---

## 💡 Quick Commands

```bash
# Check environment
./check-env.sh

# Start Claude (recommended)
./start-claude.sh

# Test API connection
source intro.sh && python3 test_foundry.py
```

---

**Need Help?** See [SETUP_GUIDE.md](SETUP_GUIDE.md) for detailed documentation.

