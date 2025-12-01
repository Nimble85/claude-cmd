###############################################################################
# Start Claude Code with Microsoft Foundry Configuration (Windows)
###############################################################################
# This script loads your Azure Foundry settings and starts Claude Code
###############################################################################

# Get the directory where this script is located
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# Load Azure Foundry configuration
Write-Host "🔧 Loading Microsoft Foundry configuration..." -ForegroundColor Cyan

if (Test-Path "$ScriptDir\intro.ps1") {
    & "$ScriptDir\intro.ps1"
} else {
    Write-Host "❌ Error: intro.ps1 not found in $ScriptDir" -ForegroundColor Red
    Write-Host "   Please create intro.ps1 with your Azure credentials"
    exit 1
}

Write-Host ""
Write-Host "🚀 Starting Claude Code..." -ForegroundColor Cyan
Write-Host "   Press Ctrl+C to exit" -ForegroundColor Yellow
Write-Host ""

# Start Claude Code
claude

