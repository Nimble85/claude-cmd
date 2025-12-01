#!/bin/bash
###############################################################################
# Install Claude Code for Linux/Mac
###############################################################################
# This script automatically installs Claude Code if not already installed
###############################################################################

echo "=========================================="
echo "  Claude Code Installation Check"
echo "=========================================="
echo ""

# Check if Claude Code is already installed
echo "Checking if Claude Code is installed..."

if command -v claude &> /dev/null; then
    CLAUDE_VERSION=$(claude --version 2>&1)
    echo "✅ Claude Code is already installed: $CLAUDE_VERSION"
else
    echo "❌ Claude Code is not installed"
    echo ""
    echo "Installing Claude Code..."
    echo ""
    
    # Check if Node.js is installed
    if ! command -v node &> /dev/null; then
        echo "❌ Node.js is not installed"
        echo ""
        echo "Claude Code requires Node.js to install via npm."
        echo ""
        echo "Install Node.js:"
        echo "  macOS:  brew install node"
        echo "  Ubuntu: sudo apt-get install nodejs npm"
        echo "  Fedora: sudo dnf install nodejs npm"
        echo ""
        echo "Or download from: https://nodejs.org/"
        echo ""
        exit 1
    fi
    
    NODE_VERSION=$(node --version 2>&1)
    echo "✅ Node.js is installed: $NODE_VERSION"
    
    # Check if npm is available
    if ! command -v npm &> /dev/null; then
        echo "❌ npm is not available"
        echo "Please reinstall Node.js with npm included."
        exit 1
    fi
    
    NPM_VERSION=$(npm --version 2>&1)
    echo "✅ npm is available: $NPM_VERSION"
    echo ""
    
    echo "Installing Claude Code via npm..."
    echo "This may take a few minutes..."
    echo ""
    
    # Install Claude Code globally
    if npm install -g @anthropic-ai/claude-code; then
        echo ""
        echo "✅ Claude Code installed successfully!"
        
        # Verify installation
        if command -v claude &> /dev/null; then
            CLAUDE_VERSION=$(claude --version 2>&1)
            echo "   Version: $CLAUDE_VERSION"
        fi
    else
        echo ""
        echo "❌ Installation failed"
        echo ""
        echo "Try manual installation:"
        echo "  npm install -g @anthropic-ai/claude-code"
        echo ""
        echo "Or download from: https://claude.ai/download"
        exit 1
    fi
fi

echo ""
echo "=========================================="
echo ""
echo "Next steps:"
echo "  1. Configure your Azure credentials in intro.sh"
echo "  2. Run: ./start-claude.sh"
echo ""

