# NINA SCOUT – Windows Task Scheduler Setup
# Erfordert Administrator-Rechte!

Write-Host "======================================" -ForegroundColor Cyan
Write-Host "NINA SCOUT – Task Scheduler Setup" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan
Write-Host ""

# Pruefen ob als Administrator ausgefuehrt
$IsAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
if (-not $IsAdmin) {
    Write-Host "FEHLER: Dieses Script erfordert Administrator-Rechte!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Bitte PowerShell als Administrator starten und erneut versuchen!"
    Write-Host ""
    exit 1
}

Write-Host "OK: Administrator-Rechte erkannt" -ForegroundColor Green
Write-Host ""

# Hinweis (2026-10-06): Umlaut-Fix. Der Ordner heisst wirklich "Persönliche Daten"
# (mit oe-Umlaut) - NICHT "Persoenliche Daten". Das war der eigentliche Fehler:
# dieser Pfad existierte auf der Platte gar nicht, daher schlug der Task fehl.
$oe = [char]0x00F6
$ScriptDir = "C:\Users\josef\iCloudDrive\iCloud~md~obsidian\Memoria\02 Areas\Pers" + $oe + "nliche Daten\Privat"
$MainScript = Join-Path $ScriptDir "nina-scout-daily-jobsearch.ps1"
$TaskName = "Memoria-Nina-Scout-Daily"

Write-Host "Entferne alte Task-Definition (falls vorhanden)..." -ForegroundColor Cyan
schtasks /delete /tn $TaskName /f 2>$null
Start-Sleep -Seconds 1

Write-Host "Erstelle neuen Task..." -ForegroundColor Cyan
Write-Host "  Task-Name: $TaskName"
Write-Host "  Zeitplan: Taglich 06:15 Uhr"
Write-Host "  Script: $MainScript"
Write-Host ""

# Erstelle Task mit PowerShell Bypass
$Action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-NoProfile -ExecutionPolicy Bypass -File `"$MainScript`""
$Trigger = New-ScheduledTaskTrigger -Daily -At 06:15
$Principal = New-ScheduledTaskPrincipal -UserId "$env:USERDOMAIN\$env:USERNAME" -LogonType ServiceAccount
$Task = New-ScheduledTask -Action $Action -Trigger $Trigger -Principal $Principal -Description "Nina Scout - Tägliche Job-Suche um 06:15 Uhr"

Register-ScheduledTask -InputObject $Task -TaskName $TaskName -Force

if ($?) {
    Write-Host ""
    Write-Host "OK: Task erfolgreich erstellt!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Task-Informationen:" -ForegroundColor Cyan
    Get-ScheduledTask -TaskName $TaskName | Select-Object TaskName, State, @{Name="NextRun";Expression={$_.NextRun}} | Format-List

    Write-Host ""
    Write-Host "Setup abgeschlossen!" -ForegroundColor Green
    Write-Host "Der Task wird ab morgen um 06:15 Uhr taeglich ausgefuehrt."
    Write-Host ""
    Write-Host "Jobsuche-Ergebnisse:" -ForegroundColor Cyan
    Write-Host "  02 Areas/Jobsuche/Jobsuche-YYYY-MM-DD.md"
    Write-Host ""
} else {
    Write-Host "FEHLER: Task-Erstellung fehlgeschlagen!" -ForegroundColor Red
    exit 1
}

Write-Host "======================================" -ForegroundColor Cyan
