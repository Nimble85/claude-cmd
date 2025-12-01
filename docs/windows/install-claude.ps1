###############################################################################
# Install Claude Code for Windows
###############################################################################
# This script automatically installs Claude Code if not already installed
###############################################################################

Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "  Claude Code Installation Check" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host ""

# Check if Claude Code is already installed
Write-Host "Checking if Claude Code is installed..." -ForegroundColor Yellow

$claudeInstalled = $false
try {
    $claudeVersion = & claude --version 2>&1
    if ($LASTEXITCODE -eq 0) {
        $claudeInstalled = $true
        Write-Host "✅ Claude Code is already installed: $claudeVersion" -ForegroundColor Green
    }
} catch {
    $claudeInstalled = $false
}

if (-not $claudeInstalled) {
    Write-Host "❌ Claude Code is not installed" -ForegroundColor Red
    Write-Host ""
    Write-Host "Installing Claude Code..." -ForegroundColor Yellow
    Write-Host ""
    
    # Check if Node.js is installed
    $nodeInstalled = $false
    try {
        $nodeVersion = & node --version 2>&1
        if ($LASTEXITCODE -eq 0) {
            $nodeInstalled = $true
            Write-Host "✅ Node.js is installed: $nodeVersion" -ForegroundColor Green
        }
    } catch {
        $nodeInstalled = $false
    }
    
    if (-not $nodeInstalled) {
        Write-Host "❌ Node.js is not installed" -ForegroundColor Red
        Write-Host ""
        Write-Host "Claude Code requires Node.js to install via npm." -ForegroundColor Yellow
        Write-Host ""
        Write-Host "Options:" -ForegroundColor Cyan
        Write-Host "  1. Install Node.js from: https://nodejs.org/" -ForegroundColor White
        Write-Host "  2. Or install Claude Code directly from: https://claude.ai/download" -ForegroundColor White
        Write-Host ""
        
        $response = Read-Host "Do you want to open the Node.js download page? (Y/N)"
        if ($response -eq "Y" -or $response -eq "y") {
            Start-Process "https://nodejs.org/"
            Write-Host "Opening Node.js download page in browser..." -ForegroundColor Green
            Write-Host "After installing Node.js, run this script again." -ForegroundColor Yellow
        } else {
            Write-Host "Opening Claude Code download page..." -ForegroundColor Green
            Start-Process "https://claude.ai/download"
        }
        
        Write-Host ""
        Write-Host "Installation aborted. Please install Node.js or Claude Code first." -ForegroundColor Red
        exit 1
    }
    
    # Check if npm is available
    Write-Host "Checking npm..." -ForegroundColor Yellow
    try {
        $npmVersion = & npm --version 2>&1
        Write-Host "✅ npm is available: $npmVersion" -ForegroundColor Green
    } catch {
        Write-Host "❌ npm is not available" -ForegroundColor Red
        Write-Host "Please reinstall Node.js with npm included." -ForegroundColor Yellow
        exit 1
    }
    
    Write-Host ""
    Write-Host "Installing Claude Code via npm..." -ForegroundColor Yellow
    Write-Host "This may take a few minutes..." -ForegroundColor Gray
    Write-Host ""
    
    # Install Claude Code globally
    try {
        npm install -g @anthropic-ai/claude-code
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host ""
            Write-Host "✅ Claude Code installed successfully!" -ForegroundColor Green
            
            # Verify installation
            $claudeVersion = & claude --version 2>&1
            Write-Host "   Version: $claudeVersion" -ForegroundColor Green
        } else {
            Write-Host ""
            Write-Host "❌ Installation failed" -ForegroundColor Red
            Write-Host ""
            Write-Host "Try manual installation:" -ForegroundColor Yellow
            Write-Host "  npm install -g @anthropic-ai/claude-code" -ForegroundColor White
            Write-Host ""
            Write-Host "Or download from: https://claude.ai/download" -ForegroundColor Yellow
            exit 1
        }
    } catch {
        Write-Host ""
        Write-Host "❌ Installation error: $_" -ForegroundColor Red
        Write-Host ""
        Write-Host "Try manual installation:" -ForegroundColor Yellow
        Write-Host "  npm install -g @anthropic-ai/claude-code" -ForegroundColor White
        exit 1
    }
} else {
    Write-Host ""
    Write-Host "Claude Code is ready to use!" -ForegroundColor Green
}

Write-Host ""
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "  1. Configure your Azure credentials in intro.ps1" -ForegroundColor White
Write-Host "  2. Run: .\start-claude.ps1" -ForegroundColor White
Write-Host ""

