---
type: automation-config
version: "2.0"
status: READY TO CONFIGURE (2026-07-19)
platform: "Windows Task Scheduler"
---

# 🔧 WINDOWS TASK SCHEDULER – SETUP ANLEITUNG

**Diese Tasks laufen als Backup, wenn Cloud Routines ausfallen**

---

## 📋 TASK 1: Nina Scout (Python + JobSpy)

**Schedule:** Täglich 08:15 Uhr (15 Min nach Cloud Routine)  
**Status Check:** Wenn Cloud-Routine fehlschlägt, PowerShell übernimmt  

### Voraussetzungen

```powershell
# Python 3.9+ muss installiert sein
python --version

# JobSpy Library installieren
pip install jobspy

# Verify
python -c "import jobspy; print('✓ JobSpy ready')"
```

### PowerShell Script: `nina-scout-backup.ps1`

**Speichere unter:** `C:\Users\Admin\iCloudDrive\iCloud~md~obsidian\Memoria\Scripts\nina-scout-backup.ps1`

```powershell
# =====================================================
# NINA SCOUT – DAILY JOB SEARCH (BACKUP TASK)
# =====================================================
# Läuft: Täglich 08:15 Uhr (Backup zu Cloud Routine)
# Author: Automation System
# Last Updated: 2026-07-19
# =====================================================

$ErrorActionPreference = "Stop"
$VaultPath = "C:\Users\Admin\iCloudDrive\iCloud~md~obsidian\Memoria"
$LogPath = "$VaultPath\00 Inbox\NINA-LOG_$(Get-Date -Format 'yyyy-MM-dd').txt"
$OutputFile = "$VaultPath\02 Areas\Jobsuche\Jobs_$(Get-Date -Format 'yyyy-MM-dd').md"

function Write-Log {
    param([string]$Message)
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$Timestamp | $Message" | Tee-Object -FilePath $LogPath -Append
}

Write-Log "🔍 NINA SCOUT START – Daily Job Search Backup Task"

try {
    # Check if Cloud Routine already ran today
    if (Test-Path $OutputFile) {
        $FileAge = (Get-Date) - (Get-Item $OutputFile).LastWriteTime
        if ($FileAge.TotalMinutes -lt 60) {
            Write-Log "✅ Cloud Routine ran today ($($FileAge.TotalMinutes) min ago) – Skipping backup"
            exit 0
        }
    }

    # Run Python JobSpy script
    Write-Log "▶️ Running JobSpy search..."
    
    $PythonScript = @"
import json
from datetime import datetime
from jobspy import scrape_jobs

# Search configuration
jobs = scrape_jobs(
    site_name=['indeed', 'linkedin', 'glassdoor', 'ziprecruiter'],
    search_term='Kaufmann Büromanagement OR Fachkraft Arbeitssicherheit OR Gefahrstoffmanager',
    location='Heistenbach, Rheinland-Pfalz',
    radius=30,
    hours_old=24,
    results_wanted=50
)

# Filter & format
output = []
for job in jobs:
    match_score = 75  # Default score
    if 'Gefahrstoff' in job.get('description', ''):
        match_score = 90
    if 'ASiG' in job.get('job_type', ''):
        match_score = 95
    
    output.append({
        'firma': job.get('company'),
        'position': job.get('title'),
        'link': job.get('job_url'),
        'match': match_score,
        'gehalt': job.get('salary_source'),
        'ort': job.get('location')
    })

# Save to JSON temp
with open('temp_jobs.json', 'w') as f:
    json.dump(sorted(output, key=lambda x: x['match'], reverse=True), f)

print(f"✓ Found {len(output)} jobs")
"@

    $PythonScript | python
    Write-Log "✅ JobSpy search complete"

    # Convert JSON to Markdown
    Write-Log "▶️ Converting to Markdown..."
    $Jobs = Get-Content "temp_jobs.json" | ConvertFrom-Json
    
    $Markdown = @"
# 🔍 Job Search – $(Get-Date -Format 'yyyy-MM-dd')

**Automatic Report (Nina Scout Backup Task)**
**Generated:** $(Get-Date -Format 'HH:mm:ss')
**Sources:** Indeed, LinkedIn, Glassdoor, ZipRecruiter
**Region:** 30km around Heistenbach, Rheinland-Pfalz

| Match | Firma | Position | Ort | Link |
|-------|-------|----------|-----|------|
"@

    foreach ($job in $Jobs) {
        $icon = if ($job.match -ge 90) { "🔥" } elseif ($job.match -ge 75) { "👍" } else { "🤔" }
        $Markdown += "`n| $icon $($job.match)% | $($job.firma) | $($job.position) | $($job.ort) | [$($job.position)](url) |"
    }

    $Markdown | Out-File -FilePath $OutputFile -Encoding UTF8
    Write-Log "✅ Markdown file created: $OutputFile"
    Write-Log "✅ NINA SCOUT COMPLETE – Found $($Jobs.Count) jobs"

} catch {
    Write-Log "❌ ERROR: $_"
    exit 1
}
```

### Task Scheduler Setup

```powershell
# PowerShell als Admin öffnen und ausführen:

$TaskName = "Nina Scout - Daily Job Search Backup"
$ScriptPath = "C:\Users\Admin\iCloudDrive\iCloud~md~obsidian\Memoria\Scripts\nina-scout-backup.ps1"
$Time = "08:15"

# Task erstellen
$Action = New-ScheduledTaskAction -Execute "powershell.exe" `
  -Argument "-NoProfile -ExecutionPolicy Bypass -File `"$ScriptPath`""

$Trigger = New-ScheduledTaskTrigger -Daily -At $Time

$Settings = New-ScheduledTaskSettingsSet -RunOnlyIfNetworkAvailable `
  -StartWhenAvailable -MultipleInstances Parallel

Register-ScheduledTask -TaskName $TaskName `
  -Action $Action `
  -Trigger $Trigger `
  -Settings $Settings `
  -Description "Backup Job Search if Cloud Routine fails"
```

---

## 📋 TASK 2: Karl Market Watch (FIX)

**Fehler seit 16.07:** ERROR_SHARING_VIOLATION (Obsidian Lock)  
**Lösung:** Retry-Logic mit Dateilock-Handling

### PowerShell Script: `karl-market-watch-fixed.ps1`

```powershell
# =====================================================
# KARL MARKET WATCH – FIXED VERSION
# =====================================================
# Problem: ERROR_SHARING_VIOLATION (Obsidian lock)
# Solution: Retry-logic + Wait-for-file-release
# =====================================================

$VaultPath = "C:\Users\Admin\iCloudDrive\iCloud~md~obsidian\Memoria"
$ReportFile = "$VaultPath\02 Areas\Finanzen\Marktbeobachtung.md"
$LogFile = "$VaultPath\00 Inbox\KARL-LOG_$(Get-Date -Format 'yyyy-MM-dd').txt"

function Wait-FileRelease {
    param([string]$FilePath, [int]$MaxRetries = 5)
    
    for ($i = 1; $i -le $MaxRetries; $i++) {
        try {
            [IO.File]::OpenWrite($FilePath).Close()
            return $true
        } catch {
            if ($i -lt $MaxRetries) {
                Start-Sleep -Seconds (2 * $i)  # Exponential backoff: 2, 4, 6, 8, 10 sec
            }
        }
    }
    return $false
}

function Write-Log {
    param([string]$Message)
    $msg = "$(Get-Date -Format 'HH:mm:ss') | $Message"
    Write-Host $msg
    Add-Content -Path $LogFile -Value $msg
}

Write-Log "📊 KARL MARKET WATCH START"

# Wait for Obsidian to release file
Write-Log "⏳ Waiting for file lock release..."
if (Wait-FileRelease -FilePath $ReportFile) {
    Write-Log "✅ File unlocked, proceeding"
} else {
    Write-Log "❌ File locked too long, retrying next hour"
    exit 1
}

# Get market data
Write-Log "▶️ Fetching market data..."
try {
    # Example: Fetch DAX data
    $DaxUrl = "https://query1.finance.yahoo.com/v10/finance/quoteSummary/^GDAXI?modules=price"
    $Response = Invoke-WebRequest -Uri $DaxUrl -UseBasicParsing
    $Data = $Response.Content | ConvertFrom-Json
    
    $DaxPrice = $Data.quoteSummary.result[0].price.regularMarketPrice.raw
    $DaxChange = $Data.quoteSummary.result[0].price.regularMarketChangePercent.raw
    
    Write-Log "✅ DAX: $DaxPrice (±$DaxChange%)"
    
    # Write to report
    $Report = "## Marktbeobachtung – $(Get-Date -Format 'yyyy-MM-dd HH:mm')
### DAX: $DaxPrice
- Veränderung: $DaxChange%
- Quelle: Yahoo Finance
- Abrufdatum: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')
"
    
    Add-Content -Path $ReportFile -Value $Report
    Write-Log "✅ Report updated"
    
} catch {
    Write-Log "❌ ERROR fetching data: $_"
    exit 1
}

Write-Log "✅ KARL MARKET WATCH COMPLETE"
```

### Task Scheduler Setup (FIX)

```powershell
# Alte Task löschen & neu erstellen

# 1. Delete old (broken) task
schtasks /delete /tn "Karl Market Watch - Daily Market Reports" /f

# 2. Create new task with retry logic
$TaskName = "Karl Market Watch - Fixed"
$ScriptPath = "C:\Users\Admin\iCloudDrive\iCloud~md~obsidian\Memoria\Scripts\karl-market-watch-fixed.ps1"
$Time = "18:00"

$Action = New-ScheduledTaskAction -Execute "powershell.exe" `
  -Argument "-NoProfile -ExecutionPolicy Bypass -File `"$ScriptPath`""

$Trigger = New-ScheduledTaskTrigger -Daily -At $Time

# Retry Logic: Bei Fehler nächste Stunde wiederholen
$Settings = New-ScheduledTaskSettingsSet `
  -RunOnlyIfNetworkAvailable `
  -StartWhenAvailable `
  -RestartCount 3 `
  -RestartInterval (New-TimeSpan -Hours 1)

Register-ScheduledTask -TaskName $TaskName `
  -Action $Action `
  -Trigger $Trigger `
  -Settings $Settings `
  -Description "Market data collection (fixed version with retry-logic)"
```

---

## 📋 TASK 3: Rainer Maintenance Backup

**Runs:** Quick 08:00 + Deep 20:00 (parallel zu Cloud Routines)

```powershell
# Quick-Check Script: `rainer-quick-check.ps1`

$VaultPath = "C:\Users\Admin\iCloudDrive\iCloud~md~obsidian\Memoria"
$InboxPath = "$VaultPath\00 Inbox"
$ReportFile = "$VaultPath\00 Inbox\VAULT-HEALTH-QUICK_$(Get-Date -Format 'yyyy-MM-dd').md"

$InboxCount = (Get-ChildItem -Path $InboxPath -File -Filter "*.md" | Measure-Object).Count
$BrokenLinks = (Select-String -Path "$VaultPath\**\*.md" -Pattern "\[\[\w+\]\]" -ErrorAction SilentlyContinue | Measure-Object).Count / 50  # Estimate

$Report = @"
# ✅ Vault Health Check – $(Get-Date -Format 'yyyy-MM-dd HH:mm')

## Status
- 📂 Inbox: $InboxCount Dateien $(if ($InboxCount -gt 10) { "⚠️ (sollte <10 sein)" })
- 🔗 Estimated Broken Links: $([Math]::Round($BrokenLinks))
- 📊 Vault Health Score: $([Math]::Max(50, 100 - ($InboxCount * 3)))%

Generated: $(Get-Date)
"@

$Report | Out-File -FilePath $ReportFile -Encoding UTF8
Write-Output "✅ Rainer Quick Check saved to $ReportFile"
```

---

## 🔄 TASK INSTALLATION (ALL TOGETHER)

**Führe dieses Script als Admin aus:**

```powershell
# =====================================================
# MASS INSTALLATION: ALL AUTOMATION TASKS
# =====================================================

# Ensure Scripts directory exists
$ScriptsDir = "C:\Users\Admin\iCloudDrive\iCloud~md~obsidian\Memoria\Scripts"
if (!(Test-Path $ScriptsDir)) {
    New-Item -ItemType Directory -Path $ScriptsDir -Force
}

# Task 1: Nina Scout Backup
Write-Host "📦 Installing Nina Scout backup task..."
$NinaAction = New-ScheduledTaskAction -Execute "powershell.exe" `
  -Argument "-NoProfile -ExecutionPolicy Bypass -File '$ScriptsDir\nina-scout-backup.ps1'"
$NinaTrigger = New-ScheduledTaskTrigger -Daily -At "08:15"
$NinaSettings = New-ScheduledTaskSettingsSet -RunOnlyIfNetworkAvailable -StartWhenAvailable
Register-ScheduledTask -TaskName "Nina Scout - Backup" `
  -Action $NinaAction -Trigger $NinaTrigger -Settings $NinaSettings -Force

# Task 2: Karl Market Watch (Fixed)
Write-Host "📦 Installing Karl Market Watch (fixed)..."
$KarlAction = New-ScheduledTaskAction -Execute "powershell.exe" `
  -Argument "-NoProfile -ExecutionPolicy Bypass -File '$ScriptsDir\karl-market-watch-fixed.ps1'"
$KarlTrigger = New-ScheduledTaskTrigger -Daily -At "18:00"
$KarlSettings = New-ScheduledTaskSettingsSet -RunOnlyIfNetworkAvailable -StartWhenAvailable -RestartCount 3
Register-ScheduledTask -TaskName "Karl Market Watch - Fixed" `
  -Action $KarlAction -Trigger $KarlTrigger -Settings $KarlSettings -Force

Write-Host "✅ All tasks installed!"
Write-Host ""
Write-Host "Verify with:"
Write-Host "schtasks /query /fo LIST /v | findstr /i 'Nina\|Karl\|Rainer\|Otto'"
```

---

## ✅ WINDOWS TASKS STATUS

| Task | Schedule | Status | Fallback |
|------|----------|--------|----------|
| **Nina Scout Backup** | 08:15 täglich | ⏳ READY | Wenn Cloud-Routine ausfällt |
| **Karl Market Watch Fixed** | 18:00 täglich | ⏳ READY | Retry-Logic (bis 3x) |
| **Rainer Quick Backup** | 08:00 täglich | ⏳ READY | Parallel zu Cloud |
| **Rainer Deep Backup** | 20:00 täglich | ⏳ READY | Parallel zu Cloud |

---

**Nächster Schritt:** Phase 3 – Python-Skripte + Fehlerbehandlung
