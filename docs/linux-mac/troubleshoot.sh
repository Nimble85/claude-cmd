#!/bin/bash
###############################################################################
# Claude Code Startup Troubleshooter
###############################################################################
# This script helps diagnose and fix common startup issues
###############################################################################

echo "════════════════════════════════════════════════════════════"
echo "  Claude Code + Microsoft Foundry Troubleshooter"
echo "════════════════════════════════════════════════════════════"
echo ""

# Get script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Step 1: Check if intro.sh exists
echo "Step 1: Checking configuration file..."
if [ ! -f "$SCRIPT_DIR/intro.sh" ]; then
    echo "❌ intro.sh not found!"
    echo "   Please create intro.sh with your Azure credentials"
    exit 1
fi
echo "✅ intro.sh exists"
echo ""

# Step 2: Load configuration
echo "Step 2: Loading configuration..."
source "$SCRIPT_DIR/intro.sh"
echo ""

# Step 3: Verify environment variables
echo "Step 3: Checking environment variables..."
all_ok=true

if [ -z "$ANTHROPIC_BASE_URL" ]; then
    echo "❌ ANTHROPIC_BASE_URL is not set"
    all_ok=false
else
    echo "✅ ANTHROPIC_BASE_URL: ${ANTHROPIC_BASE_URL:0:50}..."
fi

if [ -z "$ANTHROPIC_API_KEY" ]; then
    echo "❌ ANTHROPIC_API_KEY is not set"
    all_ok=false
else
    echo "✅ ANTHROPIC_API_KEY: ${ANTHROPIC_API_KEY:0:20}..."
fi

if [ -z "$ANTHROPIC_MODEL" ]; then
    echo "❌ ANTHROPIC_MODEL is not set"
    all_ok=false
else
    echo "✅ ANTHROPIC_MODEL: $ANTHROPIC_MODEL"
fi

echo ""

if [ "$all_ok" = false ]; then
    echo "❌ Configuration is incomplete!"
    echo "   Please edit intro.sh and add your Azure credentials"
    exit 1
fi

# Step 4: Test API connection
echo "Step 4: Testing Azure Foundry API connection..."
if command -v python3 &> /dev/null && command -v pip3 &> /dev/null; then
    # Check if anthropic is installed
    if python3 -c "import anthropic" 2>/dev/null; then
        echo "   Running API test..."
        python3 "$SCRIPT_DIR/test_foundry.py" 2>&1 | tail -5
    else
        echo "⚠️  Anthropic SDK not installed (optional test skipped)"
        echo "   Install with: pip3 install anthropic"
    fi
else
    echo "⚠️  Python not found (optional test skipped)"
fi

echo ""
echo "════════════════════════════════════════════════════════════"
echo "  Diagnosis Complete"
echo "════════════════════════════════════════════════════════════"
echo ""

if [ "$all_ok" = true ]; then
    echo "✅ Configuration looks good!"
    echo ""
    echo "To start Claude Code with Microsoft Foundry:"
    echo ""
    echo "  1. Make sure you're in this directory:"
    echo "     cd $SCRIPT_DIR"
    echo ""
    echo "  2. Run the start script:"
    echo "     ./start-claude.sh"
    echo ""
    echo "  3. Claude Code will start with your Azure Foundry config"
    echo ""
    echo "⚠️  IMPORTANT: Always use ./start-claude.sh to start Claude!"
    echo "    Don't run 'claude' directly or it won't use your config."
    echo ""
else
    echo "❌ Configuration has issues - please fix them above"
fi

echo "════════════════════════════════════════════════════════════"

