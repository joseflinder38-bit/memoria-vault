# ============================================================================
# DAILY NOTE CREATION SCRIPT – Täglich 06:00 Uhr
# ============================================================================
# Verbesserte Version mit vollständigem Error Handling & Logging
# ============================================================================

$ErrorActionPreference = 'Stop'
$VaultPath = "C:\Users\josef\iCloudDrive\iCloud~md~obsidian\Memoria"
$LogsDir = "C:\Users\josef\logs"
$LogFile = "$LogsDir\daily-note-creation.log"
$Today = (Get-Date).ToString("yyyy-MM-dd")
$TimeStamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
$NotePath = "$VaultPath\06 Daily Notes\$Today.md"
$TemplatePath = "$VaultPath\05 Templates\Daily-Note-Template.md"

# Stelle sicher, dass Logs-Verzeichnis existiert
if (-not (Test-Path $LogsDir)) { New-Item -ItemType Directory -Path $LogsDir -Force | Out-Null }

# Starte Transkript für vollständiges Error-Logging
$TranscriptPath = "$LogsDir\daily-note-creation_$Today.transcript"
Start-Transcript -Path $TranscriptPath -Append -ErrorAction SilentlyContinue | Out-Null

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Entry = "[$TimeStamp] [$Level] $Message"
    Add-Content -Path $LogFile -Value $Entry -Encoding UTF8
    if ($Level -eq "SUCCESS") { Write-Host "✓ $Message" -ForegroundColor Green }
    elseif ($Level -eq "ERROR") { Write-Host "✗ $Message" -ForegroundColor Red }
    else { Write-Host "• $Message" }
}

try {
    Write-Log "Daily Note Creation gestartet für: $Today" "INFO"

    # Prüfe ob Template existiert
    if (-not (Test-Path $TemplatePath)) {
        throw "Template nicht gefunden: $TemplatePath"
    }

    # Wenn Note bereits existiert, exit 0 (nicht als Fehler)
    if (Test-Path $NotePath) {
        Write-Log "Daily Note für $Today existiert bereits — keine Aktion" "INFO"
        exit 0
    }

    # Lese Template
    Write-Log "Lese Template: $TemplatePath" "INFO"
    $Template = Get-Content $TemplatePath -Raw -Encoding UTF8
    if ([string]::IsNullOrWhiteSpace($Template)) {
        throw "Template ist leer: $TemplatePath"
    }

    # Ersetze Placeholder
    $Content = $Template -replace '\{\{date\}\}', $Today

    # Stelle sicher, dass Verzeichnis existiert
    $DailyNotesDir = Split-Path $NotePath
    if (-not (Test-Path $DailyNotesDir)) {
        Write-Log "Erstelle Verzeichnis: $DailyNotesDir" "INFO"
        New-Item -ItemType Directory -Path $DailyNotesDir -Force | Out-Null
    }

    # Erstelle Daily Note
    Write-Log "Erstelle Daily Note: $NotePath" "INFO"
    Set-Content -Path $NotePath -Value $Content -Encoding UTF8

    # Verifiziere, dass Datei erstellt wurde
    if (-not (Test-Path $NotePath)) {
        throw "Datei konnte nicht erstellt werden: $NotePath"
    }

    $FileSize = (Get-Item $NotePath).Length
    Write-Log "Daily Note erfolgreich erstellt ($('{0:N0}' -f $FileSize) Bytes)" "SUCCESS"
    exit 0
}
catch {
    $ErrorMsg = $_.Exception.Message
    Write-Log "FEHLER: $ErrorMsg" "ERROR"
    Write-Error $ErrorMsg
    exit 1
}
finally {
    Stop-Transcript -ErrorAction SilentlyContinue | Out-Null
}
