# Configuration Methods Comparison

Claude Code with Microsoft Foundry can be configured in two ways. This document explains both approaches and helps you choose.

---

## 🔧 Method 1: Project-Local Configuration (Recommended)

**What:** Use `intro.sh` in your project directory  
**Who:** Best for most users, multiple projects, or different Azure deployments

### How It Works

```
Your Project/
├── intro.sh           ← Your credentials here
└── start-claude.sh    ← Loads intro.sh and starts Claude
```

When you run `./start-claude.sh`, it:
1. Sources `intro.sh` to set environment variables
2. Starts Claude Code with those settings

### Pros
✅ Different credentials per project  
✅ Easy to switch between Azure resources  
✅ Portable - travels with your project  
✅ Protected by project `.gitignore`  
✅ No system-wide changes  

### Cons
⚠️ Must use `./start-claude.sh` or `source intro.sh` each time  
⚠️ Environment only valid in that terminal session  

### Setup
```bash
# Edit your project's intro.sh
nano intro.sh

# Start Claude Code
./start-claude.sh
```

---

## 🌐 Method 2: Global Configuration

**What:** Use `~/.config/claude-code-azure/azure.env`  
**Who:** Single Azure deployment, always use same credentials

### How It Works

```
~/.config/
└── claude-code-azure/
    ├── azure.env      ← Your credentials here
    └── claude-azure   ← Wrapper script
```

Claude Code automatically checks this location on startup.

### Pros
✅ Works globally - no need to source anything  
✅ Same config for all projects  
✅ Start Claude directly from anywhere  

### Cons
⚠️ Only one Azure deployment at a time  
⚠️ Harder to switch between different Azure resources  
⚠️ System-wide - affects all Claude Code usage  
⚠️ Need to remember where config lives  

### Setup

Create the directory and files:

```bash
# Create directory
mkdir -p ~/.config/claude-code-azure

# Create configuration file
cat > ~/.config/claude-code-azure/azure.env << 'EOF'
# Claude Code - Azure Foundry Configuration
export ANTHROPIC_BASE_URL="https://YOUR-RESOURCE.services.ai.azure.com/anthropic/"
export ANTHROPIC_API_KEY="YOUR-API-KEY-HERE"
export ANTHROPIC_MODEL="claude-opus-4-5"
EOF

# Start Claude Code from anywhere
claude
```

---

## 🤔 Which Should You Use?

### Use Project-Local (Method 1) if:
- ✅ You work with multiple Azure deployments
- ✅ You want per-project configurations
- ✅ You prefer explicit control
- ✅ You're following this setup guide

### Use Global (Method 2) if:
- ✅ You only have ONE Azure Foundry deployment
- ✅ You want it to "just work" everywhere
- ✅ You don't need to switch credentials
- ✅ You want convenience over flexibility

---

## 🔄 Can You Use Both?

**Yes, but project-local takes precedence:**

```
Priority Order:
1. Environment variables (from intro.sh or source)
2. Global config (~/.config/claude-code-azure/)
3. Default Anthropic API
```

If you run `source intro.sh`, it will override the global config for that terminal session.

---

## 📊 Comparison Table

| Feature | Project-Local | Global |
|---------|--------------|---------|
| **Location** | `./intro.sh` | `~/.config/claude-code-azure/` |
| **Scope** | Per terminal session | System-wide |
| **Flexibility** | High - different per project | Low - one config |
| **Setup** | Edit intro.sh | Create ~/.config files |
| **Start Command** | `./start-claude.sh` | `claude` (anywhere) |
| **Portability** | High | Low |
| **Credential Management** | Project .gitignore | Manual protection |
| **Switching Configs** | Easy - just cd to project | Hard - edit global file |

---

## 🔧 Migrating Between Methods

### From Project-Local to Global

If you want to make your project config global:

```bash
# Copy your working config to global location
mkdir -p ~/.config/claude-code-azure
cp intro.sh ~/.config/claude-code-azure/azure.env

# Now Claude works everywhere
claude
```

### From Global to Project-Local

If you have global config but want project-specific:

```bash
# Create project config from global
cp ~/.config/claude-code-azure/azure.env ./intro.sh

# Start with project config
./start-claude.sh

# (Optional) Remove global config if you don't need it
rm -rf ~/.config/claude-code-azure/
```

---

## 🔍 Checking Your Current Setup

```bash
# Check if global config exists
ls -la ~/.config/claude-code-azure/

# Check what environment variables are set
env | grep ANTHROPIC

# Check which config will be used
./check-env.sh
```

---

## 💡 Recommendation for This Project

**We recommend Method 1 (Project-Local)** because:

1. ✅ More flexible for different scenarios
2. ✅ Better for teams (everyone has their own credentials)
3. ✅ Clearer what's being used (explicit `./start-claude.sh`)
4. ✅ Protected by project `.gitignore`
5. ✅ Easier to document and troubleshoot

But if you discovered you already have `~/.config/claude-code-azure/`, that's fine! It means:
- Claude Code might work globally already
- You can keep it for convenience
- Project-local will override it when you use `./start-claude.sh`

---

## 🧪 Testing Your Setup

### Test Global Config:
```bash
# Start Claude from any directory
cd ~
claude
# If it works, global config is active
```

### Test Project-Local Config:
```bash
# Start from project directory
cd /path/to/project
./start-claude.sh
# Uses project config, ignoring global
```

---

## 🔐 Security Note

**Global config:** Not in version control by default, but anyone with access to your home directory can see it.

**Project-local:** Protected by `.gitignore` in the project.

**Best practice:** Use project-local for better control and security isolation.

---

**Recommendation:** Stick with the project-local setup we just created unless you have a specific reason to use global configuration.

