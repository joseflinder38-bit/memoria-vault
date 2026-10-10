# Fix "This PC" / "Dieser PC" Hanging Issue
# Removes broken shell extensions for "This PC"
# 2026-07-25

$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
if (-not $isAdmin) {
    Write-Host "ERROR: Requires Administrator rights!" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  FIX 'THIS PC' HANGING ISSUE" -ForegroundColor Cyan
Write-Host "  Removes broken shell extensions" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Stop Explorer first
Write-Host "STEP 1: Stopping Explorer..." -ForegroundColor Yellow
Get-Process Explorer | Stop-Process -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 2

# ============================================================================
# Remove broken NameSpace entries
# ============================================================================

Write-Host ""
Write-Host "STEP 2: Checking NameSpace entries..." -ForegroundColor Yellow

$nsPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\DesktopNameSpace"
if (Test-Path $nsPath) {
    Write-Host "Checking: $nsPath" -ForegroundColor Cyan
    $items = Get-ChildItem -Path $nsPath -ErrorAction SilentlyContinue

    foreach ($item in $items) {
        $itemPath = $item.PSPath
        $value = Get-ItemProperty -Path $itemPath -ErrorAction SilentlyContinue | Select-Object -ExpandProperty '(Default)'

        Write-Host "  Entry: $($item.PSChildName)" -ForegroundColor Gray

        if ($value) {
            # Check if the CLSID exists
            $clsidPath = "HKLM:\SOFTWARE\Classes\CLSID\$($item.PSChildName)"
            $clsidExists = Test-Path -Path $clsidPath -ErrorAction SilentlyContinue

            if (-not $clsidExists) {
                Write-Host "    -> BROKEN! Removing..." -ForegroundColor Yellow
                Remove-Item -Path $itemPath -Force -ErrorAction SilentlyContinue
                Write-Host "    -> Removed" -ForegroundColor Green
            } else {
                Write-Host "    -> OK" -ForegroundColor Green
            }
        }
    }
}

# ============================================================================
# Remove broken MountPoints entries
# ============================================================================

Write-Host ""
Write-Host "STEP 3: Checking MountPoints..." -ForegroundColor Yellow

$mountPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\MountPoints2"
if (Test-Path $mountPath) {
    Write-Host "Checking: $mountPath" -ForegroundColor Cyan

    try {
        $items = Get-ChildItem -Path $mountPath -ErrorAction SilentlyContinue

        foreach ($item in $items) {
            $itemName = $item.PSChildName

            # Check if it's a broken network share
            if ($itemName -match "\\\\") {
                Write-Host "  Checking network share: $itemName" -ForegroundColor Gray

                # Try to access it
                $testPath = $itemName -replace "\\#", "\"

                if (-not (Test-Path -Path $testPath -ErrorAction SilentlyContinue)) {
                    Write-Host "    -> BROKEN! Removing..." -ForegroundColor Yellow
                    Remove-Item -Path $item.PSPath -Force -Recurse -ErrorAction SilentlyContinue
                    Write-Host "    -> Removed" -ForegroundColor Green
                }
            }
        }
    } catch {
        Write-Host "Could not check MountPoints (OK)" -ForegroundColor Yellow
    }
}

# ============================================================================
# Disable problematic Shell Extensions
# ============================================================================

Write-Host ""
Write-Host "STEP 4: Disabling problematic Shell Extensions..." -ForegroundColor Yellow

# These are common culprits that hang "This PC"
$suspiciousExtensions = @(
    "HKLM:\SOFTWARE\Classes\Drive\shellex\PropertySheetHandlers",
    "HKLM:\SOFTWARE\Classes\Folder\shellex\PropertySheetHandlers",
    "HKCU:\Software\Classes\Drive\shellex\PropertySheetHandlers",
    "HKCU:\Software\Classes\Folder\shellex\PropertySheetHandlers"
)

foreach ($path in $suspiciousExtensions) {
    if (Test-Path $path) {
        Write-Host "Checking: $path" -ForegroundColor Cyan

        $items = Get-ChildItem -Path $path -ErrorAction SilentlyContinue

        foreach ($item in $items) {
            $itemPath = $item.PSPath
            $value = Get-ItemProperty -Path $itemPath -ErrorAction SilentlyContinue | Select-Object -ExpandProperty '(Default)'

            if ($value) {
                # Check if CLSID exists
                $clsidPath = "HKLM:\SOFTWARE\Classes\CLSID\$value"
                $clsidExists = Test-Path -Path $clsidPath -ErrorAction SilentlyContinue

                if (-not $clsidExists) {
                    Write-Host "  Removing broken: $($item.PSChildName)" -ForegroundColor Yellow
                    Remove-Item -Path $itemPath -Force -ErrorAction SilentlyContinue
                    Write-Host "    -> Removed" -ForegroundColor Green
                }
            }
        }
    }
}

# ============================================================================
# Clear Explorer View State
# ============================================================================

Write-Host ""
Write-Host "STEP 5: Resetting Explorer View Settings..." -ForegroundColor Yellow

$viewStatePath = "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\BagMRU"
if (Test-Path $viewStatePath) {
    Write-Host "Clearing BagMRU..." -ForegroundColor Cyan
    Remove-Item -Path $viewStatePath -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "BagMRU cleared" -ForegroundColor Green
}

# ============================================================================
# Force Refresh
# ============================================================================

Write-Host ""
Write-Host "STEP 6: Rebuilding Explorer cache..." -ForegroundColor Yellow

$iconCache = "$env:USERPROFILE\AppData\Local\IconCache.db"
if (Test-Path $iconCache) {
    Remove-Item -Path $iconCache -Force -ErrorAction SilentlyContinue
    Write-Host "Icon cache rebuilt" -ForegroundColor Green
}

# ============================================================================
# Restart Explorer
# ============================================================================

Write-Host ""
Write-Host "STEP 7: Restarting Explorer..." -ForegroundColor Yellow

Start-Process Explorer
Start-Sleep -Seconds 3

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "  FIX COMPLETE!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "TEST NOW:" -ForegroundColor Cyan
Write-Host "  1. Open Explorer (should already be open)" -ForegroundColor White
Write-Host "  2. Click 'This PC'" -ForegroundColor White
Write-Host "  3. Should load without hanging!" -ForegroundColor White
Write-Host ""
Write-Host "If still hangs:" -ForegroundColor Yellow
Write-Host "  - RESTART your PC" -ForegroundColor White
Write-Host "  - If problem persists, we need another approach" -ForegroundColor White
Write-Host ""

Read-Host "Press Enter to exit"
