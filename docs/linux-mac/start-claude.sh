#!/bin/bash
###############################################################################
# Start Claude Code with Microsoft Foundry Configuration
###############################################################################
# This script loads your Azure Foundry settings and starts Claude Code
###############################################################################

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "🔍 Checking Claude Code installation..."

# Check if Claude Code is installed
if ! command -v claude &> /dev/null; then
    echo "❌ Claude Code is not installed"
    echo ""
    echo "Would you like to install it now? (y/n)"
    read -r response
    
    if [[ "$response" =~ ^[Yy]$ ]]; then
        echo ""
        echo "Running installation script..."
        "$SCRIPT_DIR/install-claude.sh"
        
        if [ $? -ne 0 ]; then
            echo ""
            echo "Installation failed. Please install manually."
            exit 1
        fi
    else
        echo ""
        echo "Please install Claude Code first:"
        echo "  ./install-claude.sh"
        echo "Or visit: https://claude.ai/download"
        exit 1
    fi
fi

echo "✅ Claude Code is installed"
echo ""

# Load Azure Foundry configuration
echo "🔧 Loading Microsoft Foundry configuration..."
source "$SCRIPT_DIR/intro.sh"

echo ""
echo "🚀 Starting Claude Code..."
echo "   Press Ctrl+C to exit"
echo ""

# Start Claude Code
claude

