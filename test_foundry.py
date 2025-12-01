#!/usr/bin/env python3
"""
Test script for Microsoft Foundry + Claude integration
This script verifies your Claude Code setup with Microsoft Foundry
"""

from anthropic import Anthropic
import os
import sys

def test_connection():
    """Test basic connection to Microsoft Foundry"""
    
    print("=" * 70)
    print("Claude Code + Microsoft Foundry Connection Test")
    print("=" * 70)
    print()
    
    # Get configuration from environment
    api_key = os.getenv('ANTHROPIC_API_KEY')
    base_url = os.getenv('ANTHROPIC_BASE_URL')
    model = os.getenv('ANTHROPIC_MODEL', 'claude-opus-4-5')
    
    # Verify environment variables
    print("Step 1: Checking environment variables...")
    if not api_key:
        print("✗ ANTHROPIC_API_KEY is not set")
        print("  Run: source intro.sh")
        sys.exit(1)
    print(f"  ✓ ANTHROPIC_API_KEY = {api_key[:20]}...")
    
    if not base_url:
        print("✗ ANTHROPIC_BASE_URL is not set")
        print("  Run: source intro.sh")
        sys.exit(1)
    print(f"  ✓ ANTHROPIC_BASE_URL = {base_url}")
    print(f"  ✓ Model = {model}")
    print()
    
    # Initialize client
    print("Step 2: Initializing Anthropic client...")
    try:
        client = Anthropic(
            api_key=api_key,
            base_url=base_url
        )
        print("  ✓ Client initialized successfully")
    except Exception as e:
        print(f"  ✗ Failed to initialize client: {e}")
        sys.exit(1)
    print()
    
    # Test message
    print("Step 3: Sending test message to Claude...")
    try:
        message = client.messages.create(
            model=model,
            max_tokens=1024,
            messages=[
                {"role": "user", "content": "What is the capital of France? Answer in one sentence."}
            ]
        )
        
        print("  ✓ Message sent successfully!")
        print()
        print("=" * 70)
        print("SUCCESS! Your Microsoft Foundry connection is working!")
        print("=" * 70)
        print()
        print(f"Model used: {model}")
        print(f"Response: {message.content[0].text}")
        print()
        print("Claude Code is now configured to use Microsoft Foundry!")
        print()
        
    except Exception as e:
        print(f"  ✗ Failed to send message: {e}")
        print()
        print("Troubleshooting tips:")
        print("1. Verify your API key is correct in intro.sh")
        print("2. Check your endpoint URL format")
        print("3. Ensure your deployment 'claude-opus-4-5' is active in Azure")
        print("4. Check Azure Portal for deployment status")
        print("5. Verify network connectivity to Azure")
        sys.exit(1)

if __name__ == "__main__":
    # Check if anthropic package is installed
    try:
        import anthropic
    except ImportError:
        print("Error: anthropic package not installed")
        print("Please run: pip install anthropic")
        sys.exit(1)
    
    test_connection()

