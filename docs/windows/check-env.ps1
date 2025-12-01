###############################################################################
# Check Claude Code Environment Configuration (Windows)
###############################################################################
# Verifies all required Microsoft Foundry variables are set
# Based on: https://code.claude.com/docs/en/microsoft-foundry
###############################################################################

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "Claude Code Environment Check (Windows)" -ForegroundColor Cyan
Write-Host "Microsoft Foundry Configuration" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

# Function to check if a variable is set
function Check-EnvVar {
    param (
        [string]$VarName,
        [string]$Description
    )
    
    $VarValue = [Environment]::GetEnvironmentVariable($VarName)
    
    if ([string]::IsNullOrEmpty($VarValue)) {
        Write-Host "[FAIL] $VarName : NOT SET" -ForegroundColor Red
        Write-Host "       $Description" -ForegroundColor Gray
        return $false
    } else {
        # Truncate long values
        if ($VarValue.Length -gt 50) {
            $DisplayValue = $VarValue.Substring(0, 30) + "..."
        } else {
            $DisplayValue = $VarValue
        }
        Write-Host "[OK] $VarName = $DisplayValue" -ForegroundColor Green
        return $true
    }
}

# Check REQUIRED variables
$AllOk = $true

Write-Host "REQUIRED Variables:" -ForegroundColor Yellow
Write-Host ""

if (-not (Check-EnvVar "CLAUDE_CODE_USE_FOUNDRY" "Must be '1' to enable Foundry")) {
    $AllOk = $false
} elseif ($env:CLAUDE_CODE_USE_FOUNDRY -ne "1") {
    Write-Host "[WARN] CLAUDE_CODE_USE_FOUNDRY is set but not to '1'" -ForegroundColor Yellow
    Write-Host "       Current value: $env:CLAUDE_CODE_USE_FOUNDRY" -ForegroundColor Gray
    $AllOk = $false
}

if (-not (Check-EnvVar "ANTHROPIC_FOUNDRY_RESOURCE" "Your Azure resource name")) {
    $AllOk = $false
}

if (-not (Check-EnvVar "ANTHROPIC_FOUNDRY_API_KEY" "Your Azure API key")) {
    $AllOk = $false
}

Write-Host ""
Write-Host "OPTIONAL Variables:" -ForegroundColor Yellow
Write-Host ""

Check-EnvVar "ANTHROPIC_DEFAULT_OPUS_MODEL" "Opus model deployment name" | Out-Null
Check-EnvVar "ANTHROPIC_DEFAULT_SONNET_MODEL" "Sonnet model deployment name" | Out-Null
Check-EnvVar "ANTHROPIC_DEFAULT_HAIKU_MODEL" "Haiku model deployment name" | Out-Null

Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan

if ($AllOk) {
    Write-Host "[SUCCESS] ALL REQUIRED VARIABLES ARE SET!" -ForegroundColor Green
    Write-Host ""
    Write-Host "You can now start Claude CLI:" -ForegroundColor Cyan
    Write-Host "  claude" -ForegroundColor White
    Write-Host ""
    Write-Host "Claude will use Microsoft Foundry:" -ForegroundColor Cyan
    Write-Host "  Resource: $env:ANTHROPIC_FOUNDRY_RESOURCE" -ForegroundColor White
} else {
    Write-Host "[ERROR] REQUIRED VARIABLES MISSING!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please run:" -ForegroundColor Yellow
    Write-Host "  .\intro.ps1" -ForegroundColor White
    Write-Host ""
    Write-Host "Or edit intro.ps1 with your Azure Foundry credentials" -ForegroundColor Yellow
}

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Reference: https://code.claude.com/docs/en/microsoft-foundry" -ForegroundColor Gray
