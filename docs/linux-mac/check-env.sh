#!/bin/bash
###############################################################################
# Check Claude Code Environment Configuration (Linux/Mac)
###############################################################################
# Verifies all required Microsoft Foundry variables are set
# Based on: https://code.claude.com/docs/en/microsoft-foundry
###############################################################################

echo "=========================================="
echo "Claude Code Environment Check"
echo "Microsoft Foundry Configuration"
echo "=========================================="
echo ""

# Function to check if a variable is set
check_var() {
    local var_name=$1
    local description=$2
    local var_value="${!var_name}"
    
    if [ -z "$var_value" ]; then
        echo "❌ $var_name: NOT SET"
        echo "   $description"
        return 1
    else
        if [ ${#var_value} -gt 50 ]; then
            echo "✅ $var_name: ${var_value:0:30}..."
        else
            echo "✅ $var_name: $var_value"
        fi
        return 0
    fi
}

# Check REQUIRED variables
all_ok=true

echo "REQUIRED Variables:"
echo ""

if ! check_var "CLAUDE_CODE_USE_FOUNDRY" "Must be '1' to enable Foundry"; then
    all_ok=false
elif [ "$CLAUDE_CODE_USE_FOUNDRY" != "1" ]; then
    echo "⚠️  Warning: CLAUDE_CODE_USE_FOUNDRY is set but not to '1'"
    echo "   Current value: $CLAUDE_CODE_USE_FOUNDRY"
    all_ok=false
fi

if ! check_var "ANTHROPIC_FOUNDRY_RESOURCE" "Your Azure resource name"; then
    all_ok=false
fi

if ! check_var "ANTHROPIC_FOUNDRY_API_KEY" "Your Azure API key"; then
    all_ok=false
fi

echo ""
echo "OPTIONAL Variables:"
echo ""

check_var "ANTHROPIC_DEFAULT_OPUS_MODEL" "Opus model deployment name" || true
check_var "ANTHROPIC_DEFAULT_SONNET_MODEL" "Sonnet model deployment name" || true
check_var "ANTHROPIC_DEFAULT_HAIKU_MODEL" "Haiku model deployment name" || true

echo ""
echo "=========================================="

if [ "$all_ok" = true ]; then
    echo ""
    echo "✅ ALL REQUIRED VARIABLES ARE SET!"
    echo ""
    echo "You can now start Claude CLI:"
    echo "  claude"
    echo ""
    echo "Claude will use Microsoft Foundry:"
    echo "  Resource: $ANTHROPIC_FOUNDRY_RESOURCE"
else
    echo ""
    echo "❌ REQUIRED VARIABLES MISSING!"
    echo ""
    echo "Please run:"
    echo "  source intro.sh"
    echo ""
    echo "Or edit intro.sh with your Azure Foundry credentials"
fi

echo "=========================================="
echo ""
echo "Reference: https://code.claude.com/docs/en/microsoft-foundry"
