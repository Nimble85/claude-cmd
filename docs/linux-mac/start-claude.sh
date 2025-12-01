#!/bin/bash
###############################################################################
# Start Claude Code with Microsoft Foundry Configuration
###############################################################################
# This script loads your Azure Foundry settings and starts Claude Code
###############################################################################

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Load Azure Foundry configuration
echo "🔧 Loading Microsoft Foundry configuration..."
source "$SCRIPT_DIR/intro.sh"

echo ""
echo "🚀 Starting Claude Code..."
echo "   Press Ctrl+C to exit"
echo ""

# Start Claude Code
claude

