# Complete Environment Variables for Claude CLI + Azure Foundry

## Standard Variables (What We're Using)

```bash
ANTHROPIC_BASE_URL      # Your Azure Foundry endpoint
ANTHROPIC_API_KEY       # Your API key
ANTHROPIC_MODEL         # Default model (optional)
```

## Potentially Missing Variables

Based on Claude CLI documentation, you might also need:

### 1. API Version
```bash
ANTHROPIC_API_VERSION="2023-06-01"
```

### 2. Headers (for Azure)
```bash
ANTHROPIC_HEADERS='{"api-key":"YOUR-KEY"}'
```

### 3. Disable Default Authentication
```bash
ANTHROPIC_AUTH_TYPE="api_key"
```

### 4. Timeout Settings
```bash
ANTHROPIC_TIMEOUT="60"
```

---

## Full Configuration Test

Try setting ALL of these:

### Windows PowerShell:
```powershell
# Core variables
$env:ANTHROPIC_BASE_URL = "https://YOUR-RESOURCE-NAME.services.ai.azure.com/anthropic/"
$env:ANTHROPIC_API_KEY = "YOUR-API-KEY-HERE"
$env:ANTHROPIC_MODEL = "claude-opus-4-5"

# Additional variables
$env:ANTHROPIC_API_VERSION = "2023-06-01"

# Verify
Write-Host "ANTHROPIC_BASE_URL: $env:ANTHROPIC_BASE_URL"
Write-Host "ANTHROPIC_API_KEY: $($env:ANTHROPIC_API_KEY.Substring(0,20))..."
Write-Host "ANTHROPIC_MODEL: $env:ANTHROPIC_MODEL"
Write-Host "ANTHROPIC_API_VERSION: $env:ANTHROPIC_API_VERSION"

# Start Claude
claude
```

### Linux/Mac:
```bash
export ANTHROPIC_BASE_URL="https://YOUR-RESOURCE.services.ai.azure.com/anthropic/"
export ANTHROPIC_API_KEY="YOUR-API-KEY-HERE"
export ANTHROPIC_MODEL="claude-opus-4-5"
export ANTHROPIC_API_VERSION="2023-06-01"

# Start Claude
claude
```

---

## Alternative: Use .env File

Claude CLI might read from a `.env` file in your project directory:

**Create `.env` file:**
```bash
ANTHROPIC_BASE_URL=https://YOUR-RESOURCE-NAME.services.ai.azure.com/anthropic/
ANTHROPIC_API_KEY=YOUR-API-KEY-HERE
ANTHROPIC_MODEL=claude-opus-4-5
ANTHROPIC_API_VERSION=2023-06-01
```

Then start Claude from that directory.

---

## Alternative: Claude Config File

Claude CLI might also use a config file. Check if there's a config:

**Windows:**
```powershell
# Check for config file
Get-Content $env:USERPROFILE\.claude\config.json

# Or check in AppData
Get-Content $env:APPDATA\claude\config.json
```

**Linux/Mac:**
```bash
# Check for config file
cat ~/.claude/config.json
cat ~/.config/claude/config.json
```

If found, you might need to add:
```json
{
  "api": {
    "base_url": "https://YOUR-RESOURCE.services.ai.azure.com/anthropic/",
    "api_key": "YOUR-API-KEY-HERE",
    "model": "claude-opus-4-5"
  }
}
```

---

## Diagnostic: Check What Claude CLI Sees

Run Claude with debug mode:

```bash
# Windows
$env:DEBUG = "*"
claude

# Linux/Mac
DEBUG=* claude
```

This will show what environment variables Claude CLI is reading.

---

## Azure-Specific Variables

For Azure Foundry, you might need:

```bash
# Azure authentication type
AZURE_OPENAI_API_KEY="YOUR-KEY"

# Or Azure AD token
AZURE_AD_TOKEN="YOUR-TOKEN"

# Azure deployment name
AZURE_OPENAI_DEPLOYMENT_NAME="claude-opus-4-5"

# Azure endpoint
AZURE_OPENAI_ENDPOINT="https://YOUR-RESOURCE.services.ai.azure.com/"
```

---

## Test: Minimal API Call

Test if your credentials work with a simple API call:

### Windows PowerShell:
```powershell
$headers = @{
    "Content-Type" = "application/json"
    "anthropic-version" = "2023-06-01"
    "x-api-key" = $env:ANTHROPIC_API_KEY
}

$body = @{
    model = "claude-opus-4-5"
    messages = @(
        @{
            role = "user"
            content = "Hello"
        }
    )
    max_tokens = 100
} | ConvertTo-Json

Invoke-RestMethod -Uri "$env:ANTHROPIC_BASE_URL/v1/messages" -Method Post -Headers $headers -Body $body
```

If this works, your credentials are correct but Claude CLI might need different variable names.

---

## Complete Variable List to Try

Add these to `intro.ps1`:

```powershell
# Core
$env:ANTHROPIC_BASE_URL = "https://YOUR-RESOURCE-NAME.services.ai.azure.com/anthropic/"
$env:ANTHROPIC_API_KEY = "YOUR-KEY"
$env:ANTHROPIC_MODEL = "claude-opus-4-5"

# Version
$env:ANTHROPIC_API_VERSION = "2023-06-01"

# Alternative names (some tools use different variable names)
$env:CLAUDE_API_KEY = $env:ANTHROPIC_API_KEY
$env:CLAUDE_BASE_URL = $env:ANTHROPIC_BASE_URL
$env:CLAUDE_MODEL = $env:ANTHROPIC_MODEL

# Disable standard auth
$env:ANTHROPIC_DISABLE_LOGIN = "true"

# Azure-specific
$env:AZURE_OPENAI_ENDPOINT = "https://YOUR-RESOURCE-NAME.services.ai.azure.com/"
$env:AZURE_OPENAI_API_KEY = $env:ANTHROPIC_API_KEY
$env:AZURE_OPENAI_DEPLOYMENT_NAME = "claude-opus-4-5"
```

---

## What to Check Next

1. **Claude CLI Version**: Some versions might not support custom endpoints
   ```bash
   claude --version
   ```

2. **Check if it's actually Claude CLI**: Make sure you have the CLI, not Desktop
   ```bash
   which claude  # Mac/Linux
   where.exe claude  # Windows
   ```

3. **Check for config files**: Claude might be reading from a config file that overrides env vars

4. **API endpoint format**: Try with and without `/v1/messages` suffix:
   - `https://YOUR-RESOURCE.services.ai.azure.com/anthropic/`
   - `https://YOUR-RESOURCE.services.ai.azure.com/anthropic/v1/messages`

---

**Try the complete variable list above and let me know if it works!**

