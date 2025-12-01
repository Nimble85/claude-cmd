###############################################################################
# Check Claude Code Environment Configuration (Windows)
###############################################################################
# This script verifies that all required environment variables are set
###############################################################################

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "Claude Code Environment Check (Windows)" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

# Function to check if a variable is set
function Check-EnvVar {
    param (
        [string]$VarName
    )
    
    $VarValue = [Environment]::GetEnvironmentVariable($VarName)
    
    if ([string]::IsNullOrEmpty($VarValue)) {
        Write-Host "[FAIL] $VarName : NOT SET" -ForegroundColor Red
        return $false
    } else {
        # Truncate long values
        if ($VarValue.Length -gt 50) {
            $DisplayValue = $VarValue.Substring(0, 30) + "..."
        } else {
            $DisplayValue = $VarValue
        }
        Write-Host "[OK] $VarName : $DisplayValue" -ForegroundColor Green
        return $true
    }
}

# Check all required variables
$AllOk = $true

if (-not (Check-EnvVar "ANTHROPIC_BASE_URL")) {
    $AllOk = $false
}

if (-not (Check-EnvVar "ANTHROPIC_API_KEY")) {
    $AllOk = $false
}

if (-not (Check-EnvVar "ANTHROPIC_MODEL")) {
    $AllOk = $false
}

Write-Host ""
if ($AllOk) {
    Write-Host "[SUCCESS] ALL REQUIRED VARIABLES ARE SET!" -ForegroundColor Green
    Write-Host ""
    Write-Host "You can now start Claude Code:" -ForegroundColor Cyan
    Write-Host "  .\start-claude.ps1"
} else {
    Write-Host "[ERROR] SOME VARIABLES ARE MISSING!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please run:" -ForegroundColor Yellow
    Write-Host "  .\intro.ps1"
    Write-Host ""
    Write-Host "Or edit intro.ps1 with your Azure Foundry credentials"
}

Write-Host "==========================================" -ForegroundColor Cyan
