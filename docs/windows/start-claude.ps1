###############################################################################
# Start Claude CLI with Microsoft Foundry Configuration (Windows)
###############################################################################
# IMPORTANT: This must be run in the SAME PowerShell window where you ran intro.ps1
###############################################################################

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "  Claude CLI + Microsoft Foundry" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

# Check if Claude CLI is installed
Write-Host "Step 1: Checking Claude CLI installation..." -ForegroundColor Yellow
$claudeInstalled = $false
try {
    $version = & claude --version 2>&1
    if ($LASTEXITCODE -eq 0) {
        $claudeInstalled = $true
        Write-Host "[OK] Claude CLI installed: $version" -ForegroundColor Green
    }
} catch {
    $claudeInstalled = $false
}

if (-not $claudeInstalled) {
    Write-Host "[ERROR] Claude CLI is not installed" -ForegroundColor Red
    Write-Host ""
    Write-Host "Install with: npm install -g @anthropic-ai/claude-code" -ForegroundColor Yellow
    Write-Host "Or run: .\install-claude.ps1" -ForegroundColor Yellow
    exit 1
}

Write-Host ""
Write-Host "Step 2: Loading Azure Foundry configuration..." -ForegroundColor Yellow

# Check if config file exists
if (-not (Test-Path "$ScriptDir\intro.ps1")) {
    Write-Host "[ERROR] intro.ps1 not found" -ForegroundColor Red
    Write-Host "Please create intro.ps1 with your Azure credentials" -ForegroundColor Yellow
    Write-Host "Copy from: intro.ps1.template" -ForegroundColor White
    exit 1
}

# Source the configuration
& "$ScriptDir\intro.ps1"

Write-Host ""
Write-Host "Step 3: Verifying environment variables..." -ForegroundColor Yellow

# Verify variables are set
$allSet = $true
if ([string]::IsNullOrEmpty($env:ANTHROPIC_BASE_URL)) {
    Write-Host "[ERROR] ANTHROPIC_BASE_URL not set" -ForegroundColor Red
    $allSet = $false
} else {
    Write-Host "[OK] ANTHROPIC_BASE_URL = $env:ANTHROPIC_BASE_URL" -ForegroundColor Green
}

if ([string]::IsNullOrEmpty($env:ANTHROPIC_API_KEY)) {
    Write-Host "[ERROR] ANTHROPIC_API_KEY not set" -ForegroundColor Red
    $allSet = $false
} else {
    $keyPreview = $env:ANTHROPIC_API_KEY.Substring(0, [Math]::Min(20, $env:ANTHROPIC_API_KEY.Length)) + "..."
    Write-Host "[OK] ANTHROPIC_API_KEY = $keyPreview" -ForegroundColor Green
}

if ([string]::IsNullOrEmpty($env:ANTHROPIC_MODEL)) {
    Write-Host "[ERROR] ANTHROPIC_MODEL not set" -ForegroundColor Red
    $allSet = $false
} else {
    Write-Host "[OK] ANTHROPIC_MODEL = $env:ANTHROPIC_MODEL" -ForegroundColor Green
}

if (-not $allSet) {
    Write-Host ""
    Write-Host "[ERROR] Configuration incomplete!" -ForegroundColor Red
    Write-Host "Please check intro.ps1 and ensure all values are set" -ForegroundColor Yellow
    exit 1
}

Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "  Starting Claude CLI" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Environment configured for Azure Foundry" -ForegroundColor Green
Write-Host "Claude will use: $env:ANTHROPIC_BASE_URL" -ForegroundColor Cyan
Write-Host ""
Write-Host "Press Ctrl+C to exit Claude CLI" -ForegroundColor Yellow
Write-Host ""

# Start Claude CLI with environment
claude
