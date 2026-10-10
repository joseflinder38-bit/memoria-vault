# ============================================================================
# MEMORIA GIT AUTO-BACKUP SCRIPT – Alle 10 Minuten
# ============================================================================
# Füehrt automatisch alle 10 Minuten aus via Windows Task Scheduler
# Erweiterte Version mit vollständigem Error Handling & Monitoring
# ============================================================================

$ErrorActionPreference = 'Continue'
# Hinweis: NICHT 'Stop' verwenden - native Befehle wie git schreiben normale
# Infomeldungen auf stderr, die PowerShell mit ErrorActionPreference='Stop'
# faelschlich als fatalen Fehler behandelt. Fehlerpruefung erfolgt bewusst
# ueber $LASTEXITCODE weiter unten.

# Umlaut-Fix: $oe wird über Zeichencode statt wörtlich aufgebaut (BOM/Codepage-sicher)
$oe = [char]0x00F6

$VaultPath = "C:\Users\josef\iCloudDrive\iCloud~md~obsidian\Memoria"
$LogsDir = "C:\Users\josef\logs"
$LogFile = "$LogsDir\git-backup.log"
$PrivatFolder = "$VaultPath\02 Areas\Pers" + $oe + "nliche Daten\Privat"
$TimeStamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
$DateStamp = Get-Date -Format 'yyyy-MM-dd'

# Stelle sicher, dass Logs-Verzeichnis existiert
if (-not (Test-Path $LogsDir)) { New-Item -ItemType Directory -Path $LogsDir -Force | Out-Null }

# Starte Transkript
$TranscriptPath = "$LogsDir\git-backup_$DateStamp.transcript"
Start-Transcript -Path $TranscriptPath -Append -ErrorAction SilentlyContinue | Out-Null

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Entry = "[$TimeStamp] [$Level] $Message"
    Add-Content -Path $LogFile -Value $Entry -Encoding UTF8
    if ($Level -eq "SUCCESS") { Write-Host "✓ $Message" -ForegroundColor Green }
    elseif ($Level -eq "ERROR") { Write-Host "✗ $Message" -ForegroundColor Red }
    elseif ($Level -eq "WARN") { Write-Host "⚠ $Message" -ForegroundColor Yellow }
    else { Write-Host "• $Message" }
}

try {
    Write-Log "Git Auto-Backup gestartet" "INFO"

    # Prüfe, ob Vault-Pfad existiert
    if (-not (Test-Path $VaultPath)) {
        throw "Vault-Pfad nicht gefunden: $VaultPath"
    }

    Set-Location $VaultPath
    Write-Log "Arbeitsverzeichnis: $VaultPath" "INFO"

    # Prüfe, ob .git existiert
    if (-not (Test-Path ".git")) {
        throw "Git-Repository nicht initialisiert (keine .git)"
    }

    # Git Status vor Pull prüfen
    Write-Log "Prüfe Git-Status..." "INFO"
    $StatusOutput = git status --porcelain 2>&1
    $UnstagedChanges = ($StatusOutput | Measure-Object).Count
    Write-Log "Unstaged-Änderungen: $UnstagedChanges" "INFO"

    # Git Pull (um Konflikte zu vermeiden) - ebenfalls mit Retry
    Write-Log "Git Pull wird versucht..." "INFO"
    for ($Attempt = 1; $Attempt -le 3; $Attempt++) {
        git pull origin master 2>&1 | Out-Null
        if ($LASTEXITCODE -eq 0) { break }
        Write-Log "Git Pull fehlgeschlagen, Versuch $Attempt/3 (Exit Code: $LASTEXITCODE)" "WARN"
        if ($Attempt -lt 3) { Start-Sleep -Seconds 5 }
    }

    # Git Add
    Write-Log "Staging: git add -A" "INFO"
    git add -A
    if ($LASTEXITCODE -ne 0) {
        throw "Git Add fehlgeschlagen (Exit Code: $LASTEXITCODE)"
    }

    # Prüfe, ob es Änderungen zu committen gibt
    $StatusOutput = git status --porcelain
    if ([string]::IsNullOrWhiteSpace($StatusOutput)) {
        Write-Log "Keine Änderungen zum Committen — Exit" "INFO"
        exit 0
    }

    # Git Commit
    Write-Log "Git Commit durchgeführt" "INFO"
    $Message = "Auto-backup $TimeStamp"
    git commit -m $Message 2>&1 | Out-Null
    if ($LASTEXITCODE -ne 0) {
        Write-Log "Git Commit fehlgeschlagen (Exit Code: $LASTEXITCODE)" "WARN"
    }

    # Git Push mit Retry-Logik (Norton SSL-Inspektion verursacht gelegentliche
    # "Connection reset" Fehler bei langlebigen HTTPS-Verbindungen - ein
    # erneuter Versuch nach kurzer Pause behebt das meist, ohne dass Norton
    # umkonfiguriert werden muss)
    Write-Log "Git Push wird versucht..." "INFO"
    $PushSuccess = $false
    $MaxRetries = 5
    for ($Attempt = 1; $Attempt -le $MaxRetries; $Attempt++) {
        git push origin master 2>&1 | Out-Null
        if ($LASTEXITCODE -eq 0) {
            $PushSuccess = $true
            Write-Log "Git Push erfolgreich (Versuch $Attempt/$MaxRetries)" "INFO"
            break
        } else {
            Write-Log "Git Push fehlgeschlagen, Versuch $Attempt/$MaxRetries (Exit Code: $LASTEXITCODE)" "WARN"
            if ($Attempt -lt $MaxRetries) { Start-Sleep -Seconds 8 }
        }
    }
    if (-not $PushSuccess) {
        throw "Git Push fehlgeschlagen nach $MaxRetries Versuchen"
    }

    Write-Log "Backup erfolgreich abgeschlossen" "SUCCESS"
    exit 0

} catch {
    $ErrorMsg = $_.Exception.Message
    Write-Log "FEHLER: $ErrorMsg" "ERROR"
    Write-Error $ErrorMsg
    exit 1

} finally {
    Stop-Transcript -ErrorAction SilentlyContinue | Out-Null
}
