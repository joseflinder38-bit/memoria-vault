# Deep Norton 360 Removal Script
# Removes ALL traces of Norton from system
# 2026-07-25

$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
if (-not $isAdmin) {
    Write-Host "ERROR: Requires Administrator rights!" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  NORTON DEEP CLEANUP SCRIPT" -ForegroundColor Cyan
Write-Host "  Removes ALL Norton traces" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# STEP 1: Stop Norton Processes
Write-Host "STEP 1: Stopping Norton processes..." -ForegroundColor Yellow
Get-Process | Where-Object {$_.ProcessName -match "Norton|NortonLifeLock|Symantec|ccSvcHst|NSBU"} | Stop-Process -Force -ErrorAction SilentlyContinue
Write-Host "Processes stopped" -ForegroundColor Green

# STEP 2: Uninstall Norton Package
Write-Host ""
Write-Host "STEP 2: Uninstalling Norton package..." -ForegroundColor Yellow
$norton = Get-Package | Where-Object {$_.Name -match "Norton|Symantec"}
if ($norton) {
    foreach ($app in $norton) {
        Write-Host "Removing: $($app.Name)" -ForegroundColor Yellow
        $app | Uninstall-Package -Force -ErrorAction SilentlyContinue
    }
    Write-Host "Norton uninstalled" -ForegroundColor Green
} else {
    Write-Host "No Norton package found" -ForegroundColor Gray
}

# STEP 3: Remove Registry Entries
Write-Host ""
Write-Host "STEP 3: Cleaning Registry..." -ForegroundColor Yellow

$regPaths = @(
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*Norton*",
    "HKLM:\SOFTWARE\Symantec",
    "HKCU:\SOFTWARE\Symantec",
    "HKLM:\SOFTWARE\Norton*",
    "HKCU:\SOFTWARE\Norton*"
)

foreach ($path in $regPaths) {
    try {
        Get-Item -Path $path -ErrorAction SilentlyContinue | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
        Write-Host "Removed registry: $path" -ForegroundColor Green
    } catch {
        # Ignored
    }
}

Write-Host "Registry cleaned" -ForegroundColor Green

# STEP 4: Remove Norton Folders
Write-Host ""
Write-Host "STEP 4: Removing Norton folders..." -ForegroundColor Yellow

$folders = @(
    "C:\Program Files\Norton*",
    "C:\Program Files (x86)\Norton*",
    "C:\Program Files\NortonLifeLock*",
    "C:\Program Files (x86)\NortonLifeLock*",
    "C:\ProgramData\Norton*",
    "C:\ProgramData\Symantec*",
    "C:\Users\*\AppData\Local\Norton*",
    "C:\Users\*\AppData\Local\Symantec*",
    "C:\Users\*\AppData\Roaming\Norton*",
    "C:\Users\*\AppData\Roaming\Symantec*"
)

foreach ($folder in $folders) {
    $items = Get-Item -Path $folder -ErrorAction SilentlyContinue
    if ($items) {
        foreach ($item in $items) {
            Write-Host "Removing folder: $($item.FullName)" -ForegroundColor Yellow
            Remove-Item -Path $item.FullName -Recurse -Force -ErrorAction SilentlyContinue
        }
    }
}

Write-Host "Folders removed" -ForegroundColor Green

# STEP 5: Disable Norton Services
Write-Host ""
Write-Host "STEP 5: Disabling Norton services..." -ForegroundColor Yellow

$services = Get-Service | Where-Object {$_.Name -match "Norton|Symantec|ccSvcHst"}
foreach ($service in $services) {
    Write-Host "Disabling: $($service.Name)" -ForegroundColor Yellow
    Stop-Service -Name $service.Name -Force -ErrorAction SilentlyContinue
    Set-Service -Name $service.Name -StartupType Disabled -ErrorAction SilentlyContinue
}

Write-Host "Services disabled" -ForegroundColor Green

# STEP 6: Remove Scheduled Tasks
Write-Host ""
Write-Host "STEP 6: Removing Norton scheduled tasks..." -ForegroundColor Yellow

Get-ScheduledTask | Where-Object {$_.TaskName -match "Norton|Symantec"} | Unregister-ScheduledTask -Confirm:$false -ErrorAction SilentlyContinue

Write-Host "Scheduled tasks removed" -ForegroundColor Green

# COMPLETION
Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "  NORTON DEEP CLEANUP COMPLETE!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Actions completed:" -ForegroundColor Cyan
Write-Host "  - Stopped all Norton processes" -ForegroundColor White
Write-Host "  - Uninstalled Norton package" -ForegroundColor White
Write-Host "  - Cleaned registry entries" -ForegroundColor White
Write-Host "  - Removed Norton folders" -ForegroundColor White
Write-Host "  - Disabled Norton services" -ForegroundColor White
Write-Host "  - Removed scheduled tasks" -ForegroundColor White
Write-Host ""
Write-Host "RESTART your PC for complete removal!" -ForegroundColor Yellow
Write-Host ""

Read-Host "Press Enter to exit"
