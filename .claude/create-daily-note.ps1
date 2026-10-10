# Script: Erstelle tägliche Daily Note
# Wird täglich um 06:00 Uhr vom Windows Task Scheduler aufgerufen

$vaultPath = "C:\Users\josef\iCloudDrive\iCloud~md~obsidian\Memoria"
$today = (Get-Date).ToString("yyyy-MM-dd")
$notePath = "$vaultPath\06 Daily Notes\$today.md"
$templatePath = "$vaultPath\05 Templates\Daily-Note-Template.md"

# Prüfe, ob Daily Note für heute bereits existiert
if (-not (Test-Path $notePath)) {
    try {
        # Lese Template
        $template = Get-Content $templatePath -Raw -Encoding UTF8

        # Ersetze {{date}} Placeholder
        $content = $template -replace '\{\{date\}\}', $today

        # Erstelle neue Daily Note
        Set-Content -Path $notePath -Value $content -Encoding UTF8

        # Log-Eintrag (optional)
        $logPath = "$vaultPath\.claude\daily-note-creation.log"
        "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - Daily Note erstellt: $today" | Add-Content $logPath

        Write-Host "[OK] Daily Note für $today erstellt"
        exit 0
    }
    catch {
        Write-Error "Fehler beim Erstellen der Daily Note: $_"
        exit 1
    }
}
else {
    Write-Host "[OK] Daily Note für $today existiert bereits"
    exit 0
}
