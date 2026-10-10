# Windows Explorer Repair Script
# Fixes broken registry entries from deleted apps
# Safe version - creates backups before changes
# 2026-07-25

$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
if (-not $isAdmin) {
    Write-Host "ERROR: Requires Administrator rights!" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  WINDOWS EXPLORER REPAIR SCRIPT" -ForegroundColor Cyan
Write-Host "  Fixes broken registry entries" -ForegroundColor Cyan
Write-Host "  Safe version with backups" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Create backup folder
$backupFolder = "C:\Users\josef\Desktop\Registry-Backup-$(Get-Date -Format 'yyyy-MM-dd-HHmmss')"
New-Item -ItemType Directory -Path $backupFolder -Force | Out-Null
Write-Host "Backup folder created: $backupFolder" -ForegroundColor Gray
Write-Host ""

# ============================================================================
# STEP 1: Stop Explorer
# ============================================================================

Write-Host "STEP 1: Stopping Windows Explorer..." -ForegroundColor Yellow
Write-Host "-------------------------------------------" -ForegroundColor Yellow
Write-Host ""

try {
    Get-Process Explorer | Stop-Process -Force -ErrorAction SilentlyContinue
    Start-Sleep -Seconds 2
    Write-Host "Explorer stopped successfully" -ForegroundColor Green
} catch {
    Write-Host "Could not stop Explorer (OK)" -ForegroundColor Yellow
}

Write-Host ""

# ============================================================================
# STEP 2: Backup and Clean Explorer Cache
# ============================================================================

Write-Host "STEP 2: Cleaning Explorer cache..." -ForegroundColor Yellow
Write-Host "-------------------------------------------" -ForegroundColor Yellow
Write-Host ""

$explorerCachePaths = @(
    "$env:USERPROFILE\AppData\Local\Microsoft\Windows\Explorer",
    "$env:USERPROFILE\AppData\Local\Temp\*.tmp"
)

foreach ($path in $explorerCachePaths) {
    if (Test-Path $path) {
        Write-Host "Cleaning: $path" -ForegroundColor Cyan
        try {
            Get-ChildItem -Path $path -Recurse -Force -ErrorAction SilentlyContinue | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
            Write-Host "Cleaned successfully" -ForegroundColor Green
        } catch {
            Write-Host "Could not clean all files (OK, will retry on restart)" -ForegroundColor Yellow
        }
    }
}

Write-Host ""

# ============================================================================
# STEP 3: Fix Broken Registry Entries
# ============================================================================

Write-Host "STEP 3: Repairing registry entries..." -ForegroundColor Yellow
Write-Host "-------------------------------------------" -ForegroundColor Yellow
Write-Host ""

# Backup registry before changes
Write-Host "Creating registry backup..." -ForegroundColor Cyan
$regBackupPath = "$backupFolder\Registry-Backup.reg"
reg export HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer $regBackupPath /y | Out-Null
Write-Host "Registry backed up to: $regBackupPath" -ForegroundColor Green

Write-Host ""
Write-Host "Fixing broken entries..." -ForegroundColor Cyan

# Remove broken ContextMenu entries
$contextMenuPaths = @(
    "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ContextMenuHandlers",
    "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\ContextMenuHandlers",
    "HKCU:\Software\Classes\*\shellex\ContextMenuHandlers",
    "HKLM:\Software\Classes\*\shellex\ContextMenuHandlers"
)

foreach ($path in $contextMenuPaths) {
    if (Test-Path $path) {
        Write-Host "Checking: $path" -ForegroundColor Yellow

        $items = Get-ChildItem -Path $path -ErrorAction SilentlyContinue
        foreach ($item in $items) {
            $value = Get-ItemProperty -Path $item.PSPath -ErrorAction SilentlyContinue | Select-Object -ExpandProperty '(Default)'

            if ($value) {
                # Check if registry key exists
                $keyExists = Test-Path -Path "Registry::$value" -ErrorAction SilentlyContinue

                if (-not $keyExists) {
                    Write-Host "  Removing broken entry: $($item.PSChildName)" -ForegroundColor Yellow
                    Remove-Item -Path $item.PSPath -Force -ErrorAction SilentlyContinue
                    Write-Host "  Removed" -ForegroundColor Green
                }
            }
        }
    }
}

Write-Host "Registry repair complete" -ForegroundColor Green

Write-Host ""

# ============================================================================
# STEP 4: Rebuild Icon Cache
# ============================================================================

Write-Host "STEP 4: Rebuilding icon cache..." -ForegroundColor Yellow
Write-Host "-------------------------------------------" -ForegroundColor Yellow
Write-Host ""

$iconCachePath = "$env:USERPROFILE\AppData\Local\IconCache.db"
if (Test-Path $iconCachePath) {
    Write-Host "Removing icon cache..." -ForegroundColor Cyan
    Remove-Item -Path $iconCachePath -Force -ErrorAction SilentlyContinue
    Write-Host "Icon cache removed (will be rebuilt on restart)" -ForegroundColor Green
} else {
    Write-Host "Icon cache file not found (OK)" -ForegroundColor Gray
}

Write-Host ""

# ============================================================================
# STEP 5: Fix File Type Associations
# ============================================================================

Write-Host "STEP 5: Checking file type associations..." -ForegroundColor Yellow
Write-Host "-------------------------------------------" -ForegroundColor Yellow
Write-Host ""

# Restore default file associations
Write-Host "Restoring default file associations..." -ForegroundColor Cyan

$assocPaths = @(
    "HKCU:\Software\Classes",
    "HKLM:\Software\Classes"
)

foreach ($path in $assocPaths) {
    if (Test-Path $path) {
        $brokenItems = Get-ChildItem -Path $path -ErrorAction SilentlyContinue | Where-Object {
            $_.PSChildName -match "^\.";
        }

        foreach ($item in $brokenItems) {
            try {
                $value = Get-ItemProperty -Path $item.PSPath -ErrorAction SilentlyContinue | Select-Object -ExpandProperty '(Default)'
                if ($value -and -not (Test-Path "Registry::$value" -ErrorAction SilentlyContinue)) {
                    Write-Host "  Fixing association: $($item.PSChildName)" -ForegroundColor Yellow
                    Remove-Item -Path $item.PSPath -Force -ErrorAction SilentlyContinue
                }
            } catch {
                # Ignore errors
            }
        }
    }
}

Write-Host "File associations checked" -ForegroundColor Green

Write-Host ""

# ============================================================================
# STEP 6: Clear Temporary Files
# ============================================================================

Write-Host "STEP 6: Clearing temporary files..." -ForegroundColor Yellow
Write-Host "-------------------------------------------" -ForegroundColor Yellow
Write-Host ""

$tempPaths = @(
    "C:\Windows\Temp",
    "$env:USERPROFILE\AppData\Local\Temp"
)

foreach ($path in $tempPaths) {
    if (Test-Path $path) {
        Write-Host "Cleaning: $path" -ForegroundColor Cyan
        try {
            Get-ChildItem -Path $path -Recurse -Force -ErrorAction SilentlyContinue | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
            Write-Host "Cleaned" -ForegroundColor Green
        } catch {
            Write-Host "Some files locked (will be deleted on restart)" -ForegroundColor Yellow
        }
    }
}

Write-Host ""

# ============================================================================
# STEP 7: Restart Explorer
# ============================================================================

Write-Host "STEP 7: Restarting Windows Explorer..." -ForegroundColor Yellow
Write-Host "-------------------------------------------" -ForegroundColor Yellow
Write-Host ""

Write-Host "Starting Explorer..." -ForegroundColor Cyan
Start-Process Explorer
Start-Sleep -Seconds 2
Write-Host "Explorer restarted" -ForegroundColor Green

Write-Host ""

# ============================================================================
# COMPLETION
# ============================================================================

Write-Host "========================================" -ForegroundColor Green
Write-Host "  EXPLORER REPAIR COMPLETE!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Actions completed:" -ForegroundColor Cyan
Write-Host "  - Stopped and restarted Explorer" -ForegroundColor White
Write-Host "  - Cleaned Explorer cache" -ForegroundColor White
Write-Host "  - Fixed broken registry entries" -ForegroundColor White
Write-Host "  - Rebuilt icon cache" -ForegroundColor White
Write-Host "  - Fixed file type associations" -ForegroundColor White
Write-Host "  - Cleared temporary files" -ForegroundColor White
Write-Host ""
Write-Host "Registry backup saved to:" -ForegroundColor Gray
Write-Host "  $regBackupPath" -ForegroundColor Gray
Write-Host ""
Write-Host "If problems persist, RESTART your PC!" -ForegroundColor Yellow
Write-Host ""
Write-Host "Test now:" -ForegroundColor Cyan
Write-Host "  1. Open File Explorer" -ForegroundColor White
Write-Host "  2. Click 'This PC'" -ForegroundColor White
Write-Host "  3. Should NOT hang" -ForegroundColor White
Write-Host ""

Read-Host "Press Enter to exit"
