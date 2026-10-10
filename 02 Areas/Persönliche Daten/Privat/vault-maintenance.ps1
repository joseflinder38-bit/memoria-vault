# Vault Maintenance Script
# Läuft automatisch täglich via schtasks

$vaultPath = "C:\Users\josef\iCloudDrive\iCloud~md~obsidian\Memoria"
Set-Location $vaultPath
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

# Broken Links Report
$logFile = "02 Areas\Persönliche Daten\Privat\vault-health-log.txt"
"$timestamp - Vault Health Check gestartet" | Add-Content $logFile

# Zähle Dateien
$mdCount = (Get-ChildItem -Filter "*.md" -Recurse -ErrorAction SilentlyContinue | Measure-Object).Count
"$timestamp - Gesamt MD-Dateien: $mdCount" | Add-Content $logFile

# Update Agent-Config Index
$agentConfigDate = Get-Date -Format "yyyy-MM-dd"
"$agentConfigDate" | Out-File "02 Areas\Agent-Config\LAST-UPDATE.txt" -Force

Write-Host "$timestamp - Vault Health Check abgeschlossen"
