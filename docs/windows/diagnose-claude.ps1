###############################################################################
# Diagnose Claude CLI Configuration Issues
###############################################################################

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "  Claude CLI Diagnostic" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

# Step 1: Check Claude version
Write-Host "Step 1: Checking Claude CLI version..." -ForegroundColor Yellow
try {
    $version = & claude --version 2>&1
    Write-Host "[OK] Version: $version" -ForegroundColor Green
} catch {
    Write-Host "[ERROR] Could not get version" -ForegroundColor Red
}

Write-Host ""

# Step 2: Check for config files
Write-Host "Step 2: Checking for Claude config files..." -ForegroundColor Yellow

$configLocations = @(
    "$env:USERPROFILE\.claude\config.json",
    "$env:USERPROFILE\.config\claude\config.json",
    "$env:APPDATA\claude\config.json",
    "$env:LOCALAPPDATA\claude\config.json",
    "$env:USERPROFILE\.claude\settings.json"
)

$foundConfigs = @()
foreach ($loc in $configLocations) {
    if (Test-Path $loc) {
        Write-Host "[FOUND] $loc" -ForegroundColor Yellow
        $foundConfigs += $loc
        Write-Host "Content:" -ForegroundColor Gray
        Get-Content $loc | Write-Host -ForegroundColor Gray
        Write-Host ""
    }
}

if ($foundConfigs.Count -eq 0) {
    Write-Host "[OK] No config files found" -ForegroundColor Green
}

Write-Host ""

# Step 3: Check environment variables
Write-Host "Step 3: Checking environment variables..." -ForegroundColor Yellow

$envVars = @(
    "ANTHROPIC_BASE_URL",
    "ANTHROPIC_API_KEY",
    "ANTHROPIC_MODEL",
    "ANTHROPIC_FOUNDRY_API_KEY",
    "ANTHROPIC_FOUNDRY_RESOURCE",
    "CLAUDE_API_KEY",
    "CLAUDE_BASE_URL"
)

foreach ($var in $envVars) {
    $value = [Environment]::GetEnvironmentVariable($var)
    if ($value) {
        if ($var -like "*KEY*") {
            $preview = $value.Substring(0, [Math]::Min(20, $value.Length)) + "..."
            Write-Host "[OK] $var = $preview" -ForegroundColor Green
        } else {
            Write-Host "[OK] $var = $value" -ForegroundColor Green
        }
    } else {
        Write-Host "[MISSING] $var" -ForegroundColor Red
    }
}

Write-Host ""

# Step 4: Check which claude is being run
Write-Host "Step 4: Checking Claude CLI location..." -ForegroundColor Yellow
try {
    $claudePath = (Get-Command claude).Source
    Write-Host "[OK] Claude location: $claudePath" -ForegroundColor Green
} catch {
    Write-Host "[ERROR] Could not find claude command" -ForegroundColor Red
}

Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

# Recommendations
Write-Host "Recommendations:" -ForegroundColor Cyan
Write-Host ""

if ($foundConfigs.Count -gt 0) {
    Write-Host "1. Config files found - they may be overriding env vars" -ForegroundColor Yellow
    Write-Host "   Try renaming them temporarily:" -ForegroundColor White
    foreach ($config in $foundConfigs) {
        Write-Host "   Rename-Item '$config' '$config.backup'" -ForegroundColor Gray
    }
    Write-Host ""
}

Write-Host "2. Your Claude CLI version may not support custom endpoints" -ForegroundColor Yellow
Write-Host "   Consider using the Python SDK directly:" -ForegroundColor White
Write-Host "   pip install anthropic" -ForegroundColor Gray
Write-Host ""

Write-Host "3. Try setting Foundry-specific variables:" -ForegroundColor Yellow
Write-Host "   `$env:ANTHROPIC_FOUNDRY_API_KEY = 'YOUR-KEY'" -ForegroundColor Gray
Write-Host "   `$env:ANTHROPIC_FOUNDRY_RESOURCE = 'YOUR-RESOURCE-NAME'" -ForegroundColor Gray
Write-Host ""

