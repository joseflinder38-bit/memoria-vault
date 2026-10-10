Write-Host "Setting up Nina Scout Task..."
Write-Host ""

# Hinweis (2026-10-06): Umlaut-Fix - echter Ordnername ist "Persönliche Daten".
$oe = [char]0x00F6
$ScriptPath = "C:\Users\josef\iCloudDrive\iCloud~md~obsidian\Memoria\02 Areas\Pers" + $oe + "nliche Daten\Privat\nina-scout-daily-jobsearch.ps1"
$TaskName = "Memoria-Nina-Scout-Daily"

# Delete if exists
schtasks /delete /tn $TaskName /f 2>$null

# Create task
$Action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-NoProfile -ExecutionPolicy Bypass -File ""$ScriptPath"""
$Trigger = New-ScheduledTaskTrigger -Daily -At 06:15
$Principal = New-ScheduledTaskPrincipal -UserId "$env:USERDOMAIN\$env:USERNAME"
$Task = New-ScheduledTask -Action $Action -Trigger $Trigger -Principal $Principal

Register-ScheduledTask -InputObject $Task -TaskName $TaskName -Force

Write-Host "Task created successfully!" -ForegroundColor Green
Write-Host "Task: $TaskName"
Write-Host "Schedule: Daily at 06:15"
Write-Host ""
Write-Host "Next run: Tomorrow at 06:15"
