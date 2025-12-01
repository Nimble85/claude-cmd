# Claude Code + Microsoft Foundry Setup Guide

This guide walks you through setting up Claude Code to work with Microsoft Foundry (Azure AI) on your local PC.

## Table of Contents
1. [Prerequisites](#prerequisites)
2. [Quick Start](#quick-start)
3. [Detailed Setup Instructions](#detailed-setup-instructions)
4. [Configuration Methods](#configuration-methods)
5. [Testing Your Setup](#testing-your-setup)
6. [Troubleshooting](#troubleshooting)
7. [Additional Resources](#additional-resources)

---

## Prerequisites

Before starting, ensure you have:

- ✅ **Azure Account** with an active subscription
- ✅ **Microsoft Foundry Resource** deployed with Claude models
- ✅ **Claude Code** installed on your PC
- ✅ **Python 3.8+** (for testing)
- ✅ **Terminal/Shell** access (bash, zsh, or similar)

### Your Deployment Information

Based on your Azure deployment:

- **Endpoint**: `https://YOUR-RESOURCE.services.ai.azure.com/anthropic/`
- **API Key**: `YOUR-API-KEY-HERE`
- **Deployment Name**: `claude-opus-4-5`
- **Model Version**: `20251101` (Preview)
- **Rate Limits**: 
  - 250,000 tokens per minute
  - 250 requests per minute

---

## Quick Start

The fastest way to get started:

### 1. Activate Environment Variables

```bash
# Navigate to your project directory
cd /Users/sklymo/Documents/git/claude_test/claude-cmd

# Source the configuration script
source intro.sh
```

### 2. Verify Configuration

After running the script, you should see:

```
✓ Claude Code Microsoft Foundry integration enabled
✓ Foundry Resource: https://YOUR-RESOURCE.services.ai.azure.com/anthropic/
✓ API Key configured: YOUR-API-KEY...
✓ Default Opus Model: claude-opus-4-5
✓ Default Sonnet Model: claude-sonnet-4-5
✓ Default Haiku Model: claude-haiku-4-5
```

### 3. Start Claude Code

Open Claude Code in the same terminal session:

```bash
code
```

Claude Code will now use your Microsoft Foundry deployment!

---

## Detailed Setup Instructions

### Step 1: Understanding the Configuration File

The `intro.sh` file contains all necessary environment variables. Here's what each does:

#### Required Variables

```bash
# Enables Microsoft Foundry integration in Claude Code
export CLAUDE_CODE_USE_FOUNDRY=1

# Your Azure Foundry resource base URL (without /v1/messages)
export ANTHROPIC_FOUNDRY_RESOURCE="https://YOUR-RESOURCE.services.ai.azure.com/anthropic/"

# Your API key for authentication
export ANTHROPIC_FOUNDRY_API_KEY="YOUR-API-KEY-HERE"
```

#### Optional Variables

```bash
# Model deployment names (customize based on your deployments)
export ANTHROPIC_DEFAULT_OPUS_MODEL='claude-opus-4-5'
export ANTHROPIC_DEFAULT_SONNET_MODEL='claude-sonnet-4-5'
export ANTHROPIC_DEFAULT_HAIKU_MODEL='claude-haiku-4-5'
```

### Step 2: Making Configuration Permanent

To avoid sourcing `intro.sh` every time, add it to your shell profile:

#### For Zsh (macOS default):

```bash
echo 'source /Users/sklymo/Documents/git/claude_test/claude-cmd/intro.sh' >> ~/.zshrc
```

#### For Bash:

```bash
echo 'source /Users/sklymo/Documents/git/claude_test/claude-cmd/intro.sh' >> ~/.bashrc
```

Then restart your terminal or run:

```bash
source ~/.zshrc  # or source ~/.bashrc
```

---

## Configuration Methods

Claude Code can be configured in two ways. This project uses the **project-local method** for better flexibility and security.

### Project-Local Configuration (Recommended) ⭐

**What we're using in this setup:**
- Configuration in `intro.sh` (project directory)
- Start with `./start-claude.sh`
- Different credentials per project
- Protected by project `.gitignore`

### Global Configuration (Alternative)

**Alternative approach:**
- Configuration in `~/.config/claude-code-azure/azure.env`
- Works system-wide
- One set of credentials for all projects

### Which to Use?

- **Use project-local (this setup)** if you need flexibility, multiple Azure deployments, or better security
- **Use global** if you have only one Azure deployment and want convenience

**📖 See [CONFIG_METHODS.md](CONFIG_METHODS.md) for detailed comparison**

> **Note:** If you already have `~/.config/claude-code-azure/`, that's fine! This project-local config will take precedence when you use `./start-claude.sh`.

---

## Testing Your Setup

### Test 1: Environment Variables Check

```bash
# Check if variables are set
echo $CLAUDE_CODE_USE_FOUNDRY
echo $ANTHROPIC_FOUNDRY_RESOURCE
echo $ANTHROPIC_FOUNDRY_API_KEY | cut -c1-20
```

Expected output:
```
1
https://YOUR-RESOURCE.services.ai.azure.com/anthropic/
YOUR-API-KEY
```

### Test 2: Python API Test

Create a test script `test_foundry.py`:

```python
#!/usr/bin/env python3
"""
Test script for Microsoft Foundry + Claude integration
"""

from anthropic import Anthropic
import os

# Get configuration from environment
api_key = os.getenv('ANTHROPIC_FOUNDRY_API_KEY')
base_url = os.getenv('ANTHROPIC_FOUNDRY_RESOURCE')
model = os.getenv('ANTHROPIC_DEFAULT_OPUS_MODEL', 'claude-opus-4-5')

# Initialize client
client = Anthropic(
    api_key=api_key,
    base_url=base_url
)

# Test message
try:
    message = client.messages.create(
        model=model,
        max_tokens=1024,
        messages=[
            {"role": "user", "content": "What is the capital of France? Answer in one sentence."}
        ]
    )
    
    print("✓ SUCCESS! Connection to Microsoft Foundry established.")
    print(f"✓ Model used: {model}")
    print(f"✓ Response: {message.content[0].text}")
    
except Exception as e:
    print(f"✗ ERROR: {e}")
    print("\nTroubleshooting tips:")
    print("1. Verify your API key is correct")
    print("2. Check your endpoint URL")
    print("3. Ensure your deployment is active in Azure")
```

Run the test:

```bash
# Install dependencies
pip install anthropic

# Run test
source intro.sh
python test_foundry.py
```

Expected output:
```
✓ SUCCESS! Connection to Microsoft Foundry established.
✓ Model used: claude-opus-4-5
✓ Response: The capital of France is Paris.
```

### Test 3: Using with AAD Authentication

If using Azure AD authentication, modify the test script:

```python
from anthropic import AnthropicFoundry
from azure.identity import DefaultAzureCredential, get_bearer_token_provider
import os

endpoint = os.getenv('ANTHROPIC_FOUNDRY_RESOURCE')
model = os.getenv('ANTHROPIC_DEFAULT_OPUS_MODEL', 'claude-opus-4-5')

# Authenticate using Azure AD
token_provider = get_bearer_token_provider(
    DefaultAzureCredential(), 
    "https://cognitiveservices.azure.com/.default"
)

client = AnthropicFoundry(
    azure_ad_token_provider=token_provider,
    base_url=endpoint
)

message = client.messages.create(
    model=model,
    max_tokens=1024,
    messages=[
        {"role": "user", "content": "What is the capital of France?"}
    ]
)

print(message.content[0].text)
```

---

## Troubleshooting

### Issue 1: "Claude Code not connecting to Foundry"

**Symptoms**: Claude Code uses default Anthropic API instead of Foundry

**Solutions**:
1. Verify environment variables are set:
   ```bash
   env | grep ANTHROPIC
   env | grep CLAUDE_CODE
   ```

2. Ensure you sourced the script in the same terminal session where you're running Claude Code:
   ```bash
   source intro.sh
   code
   ```

3. Make the configuration permanent by adding to `~/.zshrc` or `~/.bashrc`

### Issue 2: "Authentication failed" or "401 Unauthorized"

**Symptoms**: API returns authentication errors

**Solutions**:
1. Verify your API key is correct (check Azure portal)
2. Ensure the API key hasn't expired
3. Check that your deployment is in "Succeeded" state in Azure
4. Verify the endpoint URL format is correct (should end with `/anthropic/`)

### Issue 3: "Model not found" or "404 error"

**Symptoms**: API can't find the specified model

**Solutions**:
1. Verify your deployment name matches exactly:
   ```bash
   echo $ANTHROPIC_DEFAULT_OPUS_MODEL
   ```
2. Check deployment status in Azure Portal:
   - Go to your AI Foundry resource
   - Navigate to "Deployments"
   - Verify "claude-opus-4-5" exists and is in "Succeeded" state

### Issue 4: Rate Limiting

**Symptoms**: "429 Too Many Requests" errors

**Your limits**:
- 250,000 tokens per minute
- 250 requests per minute

**Solutions**:
1. Implement exponential backoff in your code
2. Monitor usage in Azure Portal
3. Request limit increases if needed

### Issue 5: Network/Proxy Issues

**Symptoms**: Connection timeouts, SSL errors

**Solutions**:
1. If behind a corporate proxy, configure proxy settings in `intro.sh`:
   ```bash
   export HTTPS_PROXY="https://proxy.example.com:8080"
   export NO_PROXY="localhost,127.0.0.1"
   ```

2. Check firewall settings allow connections to `*.services.ai.azure.com`

3. Verify SSL certificates are up to date

### Issue 6: Environment Variables Not Persisting

**Symptoms**: Variables reset after closing terminal

**Solutions**:
1. Add to shell profile (see Step 2 above)
2. Use a `.env` file with a tool like `direnv`
3. Create a startup script that sources `intro.sh` automatically

---

## Additional Configuration Options

### Network Configuration

For enterprise environments, you may need additional network settings. See [Claude Code Network Configuration](https://code.claude.com/docs/en/network-config).

### Dev Container Support

To use Claude Code with Microsoft Foundry in a Dev Container, add these environment variables to your `.devcontainer/devcontainer.json`:

```json
{
  "containerEnv": {
    "CLAUDE_CODE_USE_FOUNDRY": "1",
    "ANTHROPIC_FOUNDRY_RESOURCE": "https://YOUR-RESOURCE.services.ai.azure.com/anthropic/",
    "ANTHROPIC_FOUNDRY_API_KEY": "${localEnv:ANTHROPIC_FOUNDRY_API_KEY}",
    "ANTHROPIC_DEFAULT_OPUS_MODEL": "claude-opus-4-5",
    "ANTHROPIC_DEFAULT_SONNET_MODEL": "claude-sonnet-4-5",
    "ANTHROPIC_DEFAULT_HAIKU_MODEL": "claude-haiku-4-5"
  }
}
```

For more details, see [Claude Code Dev Container Documentation](https://code.claude.com/docs/en/devcontainer).

### LLM Gateway Configuration

If using an LLM gateway, see [Claude Code LLM Gateway Documentation](https://code.claude.com/docs/en/llm-gateway).

### Sandboxing

For sandboxed environments, see [Claude Code Sandboxing Documentation](https://code.claude.com/docs/en/sandboxing).

---

## Additional Resources

### Official Documentation
- [Claude Code Third-Party Integrations](https://code.claude.com/docs/en/third-party-integrations)
- [Claude Code Network Configuration](https://code.claude.com/docs/en/network-config)
- [Claude Code LLM Gateway](https://code.claude.com/docs/en/llm-gateway)
- [Claude Code Dev Container](https://code.claude.com/docs/en/devcontainer)
- [Claude Code Sandboxing](https://code.claude.com/docs/en/sandboxing)

### Microsoft Azure Documentation
- [Azure AI Foundry Overview](https://learn.microsoft.com/en-us/azure/ai-foundry/)
- [Deploy Claude Models in Foundry](https://learn.microsoft.com/en-us/azure/ai-foundry/foundry-models/how-to/use-foundry-models-claude)

### API Documentation
- [Anthropic API Reference](https://docs.anthropic.com/en/api/)
- [Azure Cognitive Services](https://learn.microsoft.com/en-us/azure/cognitive-services/)

---

## Your Deployment Summary

For quick reference, here are your specific deployment details:

| Property | Value |
|----------|-------|
| **Endpoint** | `https://YOUR-RESOURCE.services.ai.azure.com/anthropic/` |
| **Deployment Name** | `claude-opus-4-5` |
| **Model Version** | `20251101` |
| **Provisioning State** | Succeeded |
| **Rate Limit (TPM)** | 250,000 |
| **Rate Limit (RPM)** | 250 |
| **Created** | 2025-11-28 |
| **Model Status** | Preview |
| **Retirement Date** | 2026-03-20 |

---

## Support

If you encounter issues not covered in this guide:

1. Check Claude Code logs for detailed error messages
2. Verify your Azure deployment status in the Azure Portal
3. Contact Microsoft Azure Support for infrastructure issues
4. Contact Anthropic Support for Claude Code-specific issues

---

## Security Best Practices

⚠️ **Important Security Notes**:

1. **Never commit API keys to version control**
   - Add `intro.sh` to `.gitignore` if it contains secrets
   - Use environment variables or secret management tools

2. **Rotate API keys regularly**
   - Generate new keys periodically in Azure Portal
   - Update `intro.sh` with new keys

3. **Use AAD authentication for production**
   - More secure than API keys
   - Better audit trail
   - Easier to manage at scale

4. **Monitor usage and costs**
   - Set up Azure Cost Management alerts
   - Monitor API usage in Azure Portal
   - Review logs regularly

5. **Restrict access**
   - Use Azure RBAC to limit who can access keys
   - Implement network security rules
   - Use managed identities when possible

---

## License

This setup guide is provided as-is for your personal use. Please refer to the official documentation for licensing terms of Claude Code and Microsoft Azure services.

---

**Last Updated**: November 30, 2025
**Version**: 1.0

