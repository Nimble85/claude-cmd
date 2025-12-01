###############################################################################
# Install Claude Code CLI for Windows
###############################################################################
# This script automatically installs Claude Code CLI (terminal version)
# NOT the Claude Desktop app
###############################################################################

Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "  Claude Code CLI Installation" -ForegroundColor Cyan
Write-Host "  (Terminal/Command-Line Version)" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host ""

# Check if Claude Code CLI is already installed
Write-Host "Checking if Claude Code CLI is installed..." -ForegroundColor Yellow

$claudeInstalled = $false
try {
    $claudeVersion = & claude --version 2>&1
    if ($LASTEXITCODE -eq 0) {
        $claudeInstalled = $true
        Write-Host "OK: Claude Code CLI is already installed: $claudeVersion" -ForegroundColor Green
    }
} catch {
    $claudeInstalled = $false
}

if (-not $claudeInstalled) {
    Write-Host "ERROR: Claude Code CLI is not installed" -ForegroundColor Red
    Write-Host ""
    Write-Host "Installing Claude Code CLI..." -ForegroundColor Yellow
    Write-Host ""
    
    # Check if Node.js is installed
    $nodeInstalled = $false
    try {
        $nodeVersion = & node --version 2>&1
        if ($LASTEXITCODE -eq 0) {
            $nodeInstalled = $true
            Write-Host "OK: Node.js is installed: $nodeVersion" -ForegroundColor Green
        }
    } catch {
        $nodeInstalled = $false
    }
    
    if (-not $nodeInstalled) {
        Write-Host "ERROR: Node.js is not installed" -ForegroundColor Red
        Write-Host ""
        Write-Host "Claude Code CLI requires Node.js to install via npm." -ForegroundColor Yellow
        Write-Host ""
        Write-Host "Install Node.js from: https://nodejs.org/" -ForegroundColor White
        Write-Host ""
        
        $response = Read-Host "Open Node.js download page? (Y/N)"
        if ($response -eq "Y" -or $response -eq "y") {
            Start-Process "https://nodejs.org/"
            Write-Host "Opening Node.js download page..." -ForegroundColor Green
            Write-Host "After installing Node.js, run this script again." -ForegroundColor Yellow
        }
        
        Write-Host ""
        Write-Host "Installation aborted. Please install Node.js first." -ForegroundColor Red
        exit 1
    }
    
    # Check if npm is available
    Write-Host "Checking npm..." -ForegroundColor Yellow
    try {
        $npmVersion = & npm --version 2>&1
        Write-Host "OK: npm is available: $npmVersion" -ForegroundColor Green
    } catch {
        Write-Host "ERROR: npm is not available" -ForegroundColor Red
        Write-Host "Please reinstall Node.js with npm included." -ForegroundColor Yellow
        exit 1
    }
    
    Write-Host ""
    Write-Host "Installing Claude Code CLI via npm..." -ForegroundColor Yellow
    Write-Host "Package: @anthropic-ai/claude-code" -ForegroundColor Gray
    Write-Host "This may take a few minutes..." -ForegroundColor Gray
    Write-Host ""
    
    # Install Claude Code CLI globally
    try {
        npm install -g @anthropic-ai/claude-code
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host ""
            Write-Host "SUCCESS: Claude Code CLI installed!" -ForegroundColor Green
            
            # Verify installation
            $claudeVersion = & claude --version 2>&1
            Write-Host "Version: $claudeVersion" -ForegroundColor Green
            Write-Host ""
            Write-Host "You can now use 'claude' command in terminal" -ForegroundColor Cyan
        } else {
            Write-Host ""
            Write-Host "ERROR: Installation failed" -ForegroundColor Red
            Write-Host ""
            Write-Host "Try manual installation:" -ForegroundColor Yellow
            Write-Host "  npm install -g @anthropic-ai/claude-code" -ForegroundColor White
            exit 1
        }
    } catch {
        Write-Host ""
        Write-Host "ERROR: Installation error: $_" -ForegroundColor Red
        Write-Host ""
        Write-Host "Try manual installation:" -ForegroundColor Yellow
        Write-Host "  npm install -g @anthropic-ai/claude-code" -ForegroundColor White
        exit 1
    }
} else {
    Write-Host ""
    Write-Host "Claude Code CLI is ready to use!" -ForegroundColor Green
}

Write-Host ""
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "  1. Configure your Azure credentials in intro.ps1" -ForegroundColor White
Write-Host "  2. Run: .\start-claude.ps1" -ForegroundColor White
Write-Host "  3. Use Claude in your terminal!" -ForegroundColor White
Write-Host ""

