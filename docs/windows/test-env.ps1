###############################################################################
# Test Azure Foundry Environment Variables
###############################################################################
# Run this to check if your environment is configured correctly
###############################################################################

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "  Environment Variable Check" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

# Check each variable
Write-Host "Checking ANTHROPIC_BASE_URL..." -ForegroundColor Yellow
if ([string]::IsNullOrEmpty($env:ANTHROPIC_BASE_URL)) {
    Write-Host "[ERROR] NOT SET" -ForegroundColor Red
} else {
    Write-Host "[OK] $env:ANTHROPIC_BASE_URL" -ForegroundColor Green
}

Write-Host ""
Write-Host "Checking ANTHROPIC_API_KEY..." -ForegroundColor Yellow
if ([string]::IsNullOrEmpty($env:ANTHROPIC_API_KEY)) {
    Write-Host "[ERROR] NOT SET" -ForegroundColor Red
} else {
    $preview = $env:ANTHROPIC_API_KEY.Substring(0, [Math]::Min(20, $env:ANTHROPIC_API_KEY.Length)) + "..."
    Write-Host "[OK] $preview" -ForegroundColor Green
}

Write-Host ""
Write-Host "Checking ANTHROPIC_MODEL..." -ForegroundColor Yellow
if ([string]::IsNullOrEmpty($env:ANTHROPIC_MODEL)) {
    Write-Host "[ERROR] NOT SET" -ForegroundColor Red
} else {
    Write-Host "[OK] $env:ANTHROPIC_MODEL" -ForegroundColor Green
}

Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan

# Check if all are set
$allSet = (-not [string]::IsNullOrEmpty($env:ANTHROPIC_BASE_URL)) -and `
          (-not [string]::IsNullOrEmpty($env:ANTHROPIC_API_KEY))

if ($allSet) {
    Write-Host ""
    Write-Host "[SUCCESS] Environment configured correctly!" -ForegroundColor Green
    Write-Host ""
    Write-Host "To start Claude with Azure Foundry:" -ForegroundColor Cyan
    Write-Host "  claude" -ForegroundColor White
    Write-Host ""
} else {
    Write-Host ""
    Write-Host "[ERROR] Environment NOT configured!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Run this first:" -ForegroundColor Yellow
    Write-Host "  .\intro.ps1" -ForegroundColor White
    Write-Host ""
}

