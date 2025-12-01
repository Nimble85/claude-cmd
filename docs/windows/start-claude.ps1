###############################################################################
# Start Claude Code with Microsoft Foundry Configuration (Windows)
###############################################################################
# This script loads your Azure Foundry settings and starts Claude Code
###############################################################################

# Get the directory where this script is located
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host "Checking Claude Code installation..." -ForegroundColor Cyan

# Check if Claude Code is installed
$claudeInstalled = $false
try {
    $null = & claude --version 2>&1
    if ($LASTEXITCODE -eq 0) {
        $claudeInstalled = $true
    }
} catch {
    $claudeInstalled = $false
}

if (-not $claudeInstalled) {
    Write-Host "[ERROR] Claude Code is not installed" -ForegroundColor Red
    Write-Host ""
    Write-Host "Would you like to install it now?" -ForegroundColor Yellow
    $response = Read-Host "Install Claude Code? (Y/N)"
    
    if ($response -eq "Y" -or $response -eq "y") {
        Write-Host ""
        Write-Host "Running installation script..." -ForegroundColor Cyan
        & "$ScriptDir\install-claude.ps1"
        
        if ($LASTEXITCODE -ne 0) {
            Write-Host ""
            Write-Host "Installation failed. Please install manually." -ForegroundColor Red
            exit 1
        }
    } else {
        Write-Host ""
        Write-Host "Please install Claude Code first:" -ForegroundColor Yellow
        Write-Host "  .\install-claude.ps1" -ForegroundColor White
        Write-Host "Or visit: https://claude.ai/download" -ForegroundColor White
        exit 1
    }
}

Write-Host "[OK] Claude Code is installed" -ForegroundColor Green
Write-Host ""

# Load Azure Foundry configuration
Write-Host "Loading Microsoft Foundry configuration..." -ForegroundColor Cyan

if (Test-Path "$ScriptDir\intro.ps1") {
    & "$ScriptDir\intro.ps1"
} else {
    Write-Host "[ERROR] intro.ps1 not found in $ScriptDir" -ForegroundColor Red
    Write-Host "        Please create intro.ps1 with your Azure credentials" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "You can copy from template:" -ForegroundColor Yellow
    Write-Host "  Copy-Item intro.ps1.template intro.ps1" -ForegroundColor White
    exit 1
}

Write-Host ""
Write-Host "Starting Claude Code..." -ForegroundColor Cyan
Write-Host "Press Ctrl+C to exit" -ForegroundColor Yellow
Write-Host ""

# Start Claude Code
claude
