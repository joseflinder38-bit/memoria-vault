# Memoria Git Auto-Backup Script
# Fuehrt automatisch alle 10 Minuten aus via Windows Task Scheduler
#
# Hinweis (2026-10-06): Umlaut-Fix - siehe nina-scout-daily-jobsearch.ps1 fuer Erklaerung.
# $oe wird ueber Zeichencode statt woertlich aufgebaut (BOM/Codepage-sicher).
$oe = [char]0x00F6

$vaultPath = "C:\Users\josef\iCloudDrive\iCloud~md~obsidian\Memoria"
$logFile = "$vaultPath\02 Areas\Pers" + $oe + "nliche Daten\Privat\git-backup.log"

Set-Location $vaultPath

try {
    # Git Pull (um Konflikte zu vermeiden)
    git pull origin master -q 2>$null

    # Git Add
    git add -A 2>$null

    # Git Commit
    $timestamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
    $message = "Auto-backup $timestamp"
    git commit -m $message 2>$null

    # Git Push
    git push origin master -q 2>$null

    # Log eintrag schreiben
    "$timestamp - ✅ Backup erfolgreich" | Add-Content $logFile

} catch {
    $timestamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
    "$timestamp - ❌ Fehler: $_" | Add-Content $logFile
}
