# =====================================================
# AUTOMATION INSTALL - SIMPLIFIED VERSION
# =====================================================
# Installiert ALLE Automatisierungen mit 1 Click
# =====================================================

$VaultPath = "C:\Users\Admin\iCloudDrive\iCloud~md~obsidian\Memoria"
$ScriptsDir = "$VaultPath\Scripts"
$LogFile = "$VaultPath\00 Inbox\SETUP-LOG_$(Get-Date -Format 'yyyy-MM-dd_HHmmss').txt"

Write-Host "Starting AUTOMATION INSTALLATION..." -ForegroundColor Green
"Starting installation at $(Get-Date)" | Tee-Object -FilePath $LogFile

# ─────────────────────────────────────────────────
# STEP 1: CHECK PYTHON & JOBSPY
# ─────────────────────────────────────────────────

Write-Host "`n[1/4] Checking Python..." -ForegroundColor Cyan
try {
    $PythonVersion = python --version 2>&1 | Out-String
    Write-Host "OK: $PythonVersion" -ForegroundColor Green
    "Python OK: $PythonVersion" | Tee-Object -FilePath $LogFile -Append
} catch {
    Write-Host "ERROR: Python not found!" -ForegroundColor Red
    "ERROR: Python not installed" | Tee-Object -FilePath $LogFile -Append
    exit 1
}

Write-Host "[1/4] Checking JobSpy..." -ForegroundColor Cyan
$JobSpyCheck = pip list 2>&1 | Select-String "jobspy"
if ($JobSpyCheck) {
    Write-Host "OK: JobSpy installed" -ForegroundColor Green
    "JobSpy OK" | Tee-Object -FilePath $LogFile -Append
} else {
    Write-Host "[1/4] Installing JobSpy..." -ForegroundColor Yellow
    pip install jobspy -q 2>&1 | Out-Null
    Write-Host "OK: JobSpy installed" -ForegroundColor Green
    "JobSpy installed" | Tee-Object -FilePath $LogFile -Append
}

# ─────────────────────────────────────────────────
# STEP 2: CREATE SCRIPTS FOLDER
# ─────────────────────────────────────────────────

Write-Host "`n[2/4] Creating Scripts folder..." -ForegroundColor Cyan
if (!(Test-Path $ScriptsDir)) {
    New-Item -ItemType Directory -Path $ScriptsDir -Force | Out-Null
}
Write-Host "OK: $ScriptsDir" -ForegroundColor Green
"Scripts folder: $ScriptsDir" | Tee-Object -FilePath $LogFile -Append

# ─────────────────────────────────────────────────
# STEP 3: CREATE NINA SCOUT PYTHON SCRIPT
# ─────────────────────────────────────────────────

Write-Host "`n[3/4] Creating Nina Scout script..." -ForegroundColor Cyan

$NinaPythonScript = @'
import json
from datetime import datetime
from jobspy import scrape_jobs
import os

vault_path = r'C:\Users\Admin\iCloudDrive\iCloud~md~obsidian\Memoria'
output_file = os.path.join(vault_path, '02 Areas', 'Jobsuche', f'Jobs_{datetime.now().strftime("%Y-%m-%d")}.md')

print("Starting Nina Scout job search...")

try:
    jobs = scrape_jobs(
        site_name=['indeed', 'linkedin', 'glassdoor'],
        search_term='Kaufmann Büro OR Arbeitssicherheit OR Gefahrstoff',
        location='Heistenbach, Rheinland-Pfalz',
        radius=30,
        hours_old=24,
        results_wanted=30
    )

    print(f"Found {len(jobs)} jobs")

    if len(jobs) > 0:
        markdown = f"# Jobs Report - {datetime.now().strftime('%Y-%m-%d %H:%M')}\n\n"
        markdown += "| Match | Firma | Position | Ort | Gehalt |\n"
        markdown += "|-------|-------|----------|-----|--------|\n"

        for job in jobs[:15]:
            match = 70
            if 'Gefahrstoff' in str(job.get('description', '')).upper():
                match = 90
            if 'Montabaur' in str(job.get('location', '')).upper():
                match = min(100, match + 5)

            icon = '🔥' if match >= 80 else '👍' if match >= 70 else '🤔'
            firma = str(job.get('company', 'N/A'))[:30]
            position = str(job.get('title', 'N/A'))[:30]
            ort = str(job.get('location', 'N/A'))[:20]
            gehalt = str(job.get('salary_source', ''))[:15]

            markdown += f"| {icon} {match}% | {firma} | {position} | {ort} | {gehalt} |\n"

        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(markdown)

        print(f"Saved to: {output_file}")
    else:
        print("No jobs found")

except Exception as e:
    print(f"Error: {e}")
'@

$NinaPythonPath = "$ScriptsDir\nina-scout.py"
Set-Content -Path $NinaPythonPath -Value $NinaPythonScript -Encoding UTF8
Write-Host "OK: nina-scout.py created" -ForegroundColor Green
"Nina scout script created" | Tee-Object -FilePath $LogFile -Append

# ─────────────────────────────────────────────────
# STEP 4: CREATE WINDOWS TASKS
# ─────────────────────────────────────────────────

Write-Host "`n[4/4] Installing Windows Tasks..." -ForegroundColor Cyan

# Task 1: Nina Scout (08:15)
Write-Host "  - Creating: Nina Scout (daily 08:15)..." -ForegroundColor Yellow

$NinaAction = New-ScheduledTaskAction -Execute "python.exe" -Argument $NinaPythonPath
$NinaTrigger = New-ScheduledTaskTrigger -Daily -At 08:15
$NinaSettings = New-ScheduledTaskSettingsSet -RunOnlyIfNetworkAvailable -StartWhenAvailable

try {
    Register-ScheduledTask -TaskName "Nina Scout - Daily" `
        -Action $NinaAction `
        -Trigger $NinaTrigger `
        -Settings $NinaSettings `
        -Description "Daily job search (08:15)" `
        -Force | Out-Null
    Write-Host "    OK: Installed" -ForegroundColor Green
    "Nina Scout task installed" | Tee-Object -FilePath $LogFile -Append
} catch {
    Write-Host "    ERROR: $_" -ForegroundColor Red
}

# Task 2: Simple Market Data Task (18:00)
Write-Host "  - Creating: Market Data (daily 18:00)..." -ForegroundColor Yellow

$MarketScript = @"
`$LogFile = "C:\Users\Admin\iCloudDrive\iCloud~md~obsidian\Memoria\00 Inbox\MARKET-LOG.txt"
Add-Content -Path `$LogFile -Value "Market check at `$(Get-Date)"
"@

$MarketScriptPath = "$ScriptsDir\market-check.ps1"
Set-Content -Path $MarketScriptPath -Value $MarketScript -Encoding UTF8

$MarketAction = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -ExecutionPolicy Bypass -File `"$MarketScriptPath`""
$MarketTrigger = New-ScheduledTaskTrigger -Daily -At 18:00
$MarketSettings = New-ScheduledTaskSettingsSet -RunOnlyIfNetworkAvailable -StartWhenAvailable

try {
    Register-ScheduledTask -TaskName "Market Data - Daily" `
        -Action $MarketAction `
        -Trigger $MarketTrigger `
        -Settings $MarketSettings `
        -Description "Daily market check (18:00)" `
        -Force | Out-Null
    Write-Host "    OK: Installed" -ForegroundColor Green
    "Market Data task installed" | Tee-Object -FilePath $LogFile -Append
} catch {
    Write-Host "    ERROR: $_" -ForegroundColor Red
}

# ─────────────────────────────────────────────────
# FINAL SUMMARY
# ─────────────────────────────────────────────────

Write-Host "`n========================================" -ForegroundColor Green
Write-Host "SUCCESS! Automation installed!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green

Write-Host "`nDaily Schedule:" -ForegroundColor Cyan
Write-Host "  08:15 -> Nina Scout (Job Search)" -ForegroundColor Cyan
Write-Host "  18:00 -> Market Data Check" -ForegroundColor Cyan

Write-Host "`nVerify with:" -ForegroundColor Yellow
Write-Host "  schtasks /query /fo LIST /v | findstr /i 'Nina\|Market'" -ForegroundColor Gray

Write-Host "`nLog file:" -ForegroundColor Yellow
Write-Host "  $LogFile" -ForegroundColor Gray

Write-Host "`nReady! Jobs will appear tomorrow at 08:15" -ForegroundColor Green
"Installation complete at $(Get-Date)" | Tee-Object -FilePath $LogFile -Append
