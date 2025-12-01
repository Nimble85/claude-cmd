# Claude CLI Not Using Azure Foundry - Alternative Solutions

## Problem: Claude CLI Ignores Environment Variables

If Claude CLI keeps redirecting you to the web login (console.anthropic.com), it means:
- Environment variables are being ignored
- Claude CLI may not support custom endpoints in your version
- A config file is overriding your settings

---

## Solution 1: Use Python SDK Directly (RECOMMENDED)

Instead of using Claude CLI, use the Python SDK with a simple script:

### Install:
```powershell
pip install anthropic
```

### Create `chat.py`:
```python
#!/usr/bin/env python3
import os
from anthropic import Anthropic

# Set your Azure Foundry credentials
os.environ['ANTHROPIC_BASE_URL'] = 'https://YOUR-RESOURCE-NAME.services.ai.azure.com/anthropic/'
os.environ['ANTHROPIC_API_KEY'] = 'YOUR-API-KEY-HERE'

# Initialize client
client = Anthropic(
    base_url=os.getenv('ANTHROPIC_BASE_URL'),
    api_key=os.getenv('ANTHROPIC_API_KEY')
)

# Interactive chat loop
print("Azure Foundry Chat (Ctrl+C to exit)")
print("=" * 50)

conversation = []

while True:
    try:
        user_input = input("\nYou: ")
        if not user_input.strip():
            continue
            
        conversation.append({
            "role": "user",
            "content": user_input
        })
        
        # Get response
        message = client.messages.create(
            model="claude-opus-4-5",
            max_tokens=2048,
            messages=conversation
        )
        
        assistant_message = message.content[0].text
        conversation.append({
            "role": "assistant",
            "content": assistant_message
        })
        
        print(f"\nClaude: {assistant_message}")
        
    except KeyboardInterrupt:
        print("\n\nGoodbye!")
        break
    except Exception as e:
        print(f"\nError: {e}")
```

### Use it:
```powershell
python chat.py
```

**This WILL work with Azure Foundry!**

---

## Solution 2: Check Claude CLI Config Files

Claude CLI might have a config file forcing standard authentication:

### Check for configs:
```powershell
# Run diagnostic
.\diagnose-claude.ps1

# Check these locations:
Get-Content $env:USERPROFILE\.claude\config.json
Get-Content $env:USERPROFILE\.claude\settings.json
Get-Content $env:APPDATA\claude\config.json
```

### If found, back them up:
```powershell
Rename-Item "$env:USERPROFILE\.claude\config.json" "$env:USERPROFILE\.claude\config.json.backup"
```

Then try `claude` again.

---

## Solution 3: Create Custom Config File

Create `~/.claude/config.json`:

```json
{
  "api": {
    "key": "YOUR-API-KEY-HERE",
    "base_url": "https://YOUR-RESOURCE-NAME.services.ai.azure.com/anthropic/"
  },
  "model": "claude-opus-4-5"
}
```

---

## Solution 4: Use Settings.json (Claude Code Extension)

If using VS Code extension, create `.vscode/settings.json`:

```json
{
  "claude.anthropicFoundry": {
    "apiKey": "YOUR-API-KEY-HERE",
    "resourceName": "YOUR-RESOURCE-NAME"
  }
}
```

---

## Solution 5: Try Different Variable Names

Some versions use different variable names:

```powershell
# Try all variations:
$env:ANTHROPIC_BASE_URL = "https://YOUR-RESOURCE-NAME.services.ai.azure.com/anthropic/"
$env:ANTHROPIC_API_KEY = "YOUR-KEY"
$env:ANTHROPIC_FOUNDRY_API_KEY = "YOUR-KEY"
$env:ANTHROPIC_FOUNDRY_RESOURCE = "YOUR-RESOURCE-NAME"
$env:CLAUDE_API_KEY = "YOUR-KEY"
$env:CLAUDE_BASE_URL = "https://YOUR-RESOURCE-NAME.services.ai.azure.com/anthropic/"

# Try starting Claude
claude
```

---

## Solution 6: Use Anthropic Client with Custom Endpoint

Create `azure-chat.py`:

```python
from anthropic import Anthropic

client = Anthropic(
    api_key="YOUR-API-KEY-HERE",
    base_url="https://YOUR-RESOURCE-NAME.services.ai.azure.com/anthropic/"
)

message = client.messages.create(
    model="claude-opus-4-5",
    max_tokens=1024,
    messages=[{"role": "user", "content": "Hello!"}]
)

print(message.content[0].text)
```

Run:
```powershell
python azure-chat.py
```

---

## Why This Happens

Claude CLI versions vary in their support for custom endpoints:
- **Older versions**: May not support custom base URLs at all
- **Newer versions**: Should read `ANTHROPIC_BASE_URL`
- **VS Code Extension**: Uses different config (`settings.json`)

---

## Recommended Approach

**Use the Python SDK** (Solution 1) - it's the most reliable way to use Azure Foundry with Claude:

1. Install: `pip install anthropic`
2. Create the `chat.py` script above
3. Run: `python chat.py`

This gives you full control and definitely works with Azure Foundry!

---

## Next Steps

1. Run `.\diagnose-claude.ps1` to see what's configured
2. Try the Python SDK approach (most reliable)
3. Check for config files that might be overriding env vars

**The Python SDK is your best bet for Azure Foundry!** 🎯

