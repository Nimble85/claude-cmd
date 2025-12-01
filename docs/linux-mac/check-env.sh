#!/bin/bash
###############################################################################
# Check Claude Code Environment Configuration
###############################################################################
# This script verifies that all required environment variables are set
###############################################################################

echo "=========================================="
echo "Claude Code Environment Check"
echo "=========================================="
echo ""

# Function to check if a variable is set
check_var() {
    local var_name=$1
    local var_value="${!var_name}"
    
    if [ -z "$var_value" ]; then
        echo "❌ $var_name: NOT SET"
        return 1
    else
        # Truncate long values for display
        if [ ${#var_value} -gt 50 ]; then
            echo "✅ $var_name: ${var_value:0:30}..."
        else
            echo "✅ $var_name: $var_value"
        fi
        return 0
    fi
}

# Check all required variables
all_ok=true

if ! check_var "ANTHROPIC_BASE_URL"; then
    all_ok=false
fi

if ! check_var "ANTHROPIC_API_KEY"; then
    all_ok=false
fi

if ! check_var "ANTHROPIC_MODEL"; then
    all_ok=false
fi

echo ""
if [ "$all_ok" = true ]; then
    echo "✅ ALL REQUIRED VARIABLES ARE SET!"
    echo ""
    echo "You can now start Claude Code:"
    echo "  ./start-claude.sh"
else
    echo "❌ SOME VARIABLES ARE MISSING!"
    echo ""
    echo "Please run:"
    echo "  source intro.sh"
    echo ""
    echo "Or edit intro.sh with your Azure Foundry credentials"
fi

echo "=========================================="

