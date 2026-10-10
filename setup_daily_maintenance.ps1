#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Setup Script für tägliche Vault Maintenance

.DESCRIPTION
    Erstellt einen Windows Task Scheduler Job, der täglich die Vault-Wartung durchführt
#>

param(
    [string]$Time = "08:00",
    [string]$VaultPath = "C:\Users\Admin\iCloudDrive\iCloud~md~obsidian\Memoria"
)

Write-Host "`n========================================`n"
Write-Host "VAULT MAINTENANCE - DAILY SETUP`n"

# 1. Python Check
Write-Host "[1/5] Checking Python..."
try {
    $pythonVersion = python --version 2>&1
    Write-Host "[OK] Python: $pythonVersion"
} catch {
    Write-Host "[ERROR] Python not found!"
    exit 1
}

# 2. Vault Path Check
Write-Host "`n[2/5] Checking vault path..."
if (Test-Path $VaultPath) {
    Write-Host "[OK] Vault: $VaultPath"
} else {
    Write-Host "[ERROR] Vault path not found"
    exit 1
}

# 3. Check maintenance.py
Write-Host "`n[3/5] Checking maintenance script..."
$MaintenanceScript = Join-Path $VaultPath "vault_maintenance.py"
if (Test-Path $MaintenanceScript) {
    Write-Host "[OK] vault_maintenance.py exists"
} else {
    Write-Host "[ERROR] Script not found"
    exit 1
}

# 4. Create batch wrapper
Write-Host "`n[4/5] Creating batch wrapper..."
$BatchFile = Join-Path $VaultPath "run_daily_maintenance.bat"
$BatchContent = @"
@echo off
cd /d "$VaultPath"
python vault_maintenance.py >> "$VaultPath\00 Inbox\maintenance_log.txt" 2>&1
"@

$BatchContent | Out-File -FilePath $BatchFile -Encoding ASCII -Force
Write-Host "[OK] Batch wrapper: $BatchFile"

# 5. Register scheduled task
Write-Host "`n[5/5] Registering scheduled task..."

$TaskName = "Memoria-Vault-Maintenance"

# Remove old task if exists
try {
    Unregister-ScheduledTask -TaskName $TaskName -Confirm:$false -ErrorAction SilentlyContinue
    Write-Host "[OK] Old task removed"
}
catch { }

# Create new task
try {
    $Action = New-ScheduledTaskAction -Execute $BatchFile -WorkingDirectory $VaultPath
    $Trigger = New-ScheduledTaskTrigger -Daily -At $Time
    $Settings = New-ScheduledTaskSettingsSet -StartWhenAvailable -RunOnlyIfNetworkAvailable
    $Principal = New-ScheduledTaskPrincipal -UserId $env:USERNAME -RunLevel Highest

    Register-ScheduledTask `
        -TaskName $TaskName `
        -Action $Action `
        -Trigger $Trigger `
        -Settings $Settings `
        -Principal $Principal `
        -Description "Daily vault maintenance" | Out-Null

    Write-Host "[OK] Task registered: $TaskName"
    Write-Host "[OK] Schedule: Daily at $Time"
}
catch {
    Write-Host "[ERROR] Failed to create task: $_"
    exit 1
}

# Verify
Write-Host "`n[VERIFY] Checking task status..."
$Task = Get-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue
if ($Task) {
    Write-Host "[OK] Task status: $($Task.State)"
    Write-Host "[OK] Next run: $($Task.Triggers[0].StartBoundary)"
}

Write-Host "`n========================================`n"
Write-Host "SETUP COMPLETE`n"
Write-Host "Task: $TaskName"
Write-Host "Time: Daily at $Time"
Write-Host "Log: $VaultPath\00 Inbox\maintenance_log.txt`n"
Write-Host "View task: tasklist /m $TaskName"
Write-Host "Manual run: & '$BatchFile'`n"
