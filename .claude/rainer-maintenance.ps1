# ============================================================================
# RAINER MAINTENANCE SCRIPT – Täglich 08:00 Uhr (ERWEITERT)
# ============================================================================
# Funktion:
#   1. Vault-Export erzeugen (00 Inbox/Vault-Export-DATUM.md)
#   2. Alte Exports löschen (älter als 7 Tage)
#   3. Umfassendes Error Logging
#
# Berechtigungen: Lesen Vault | Schreiben nur 00 Inbox/ | Löschen nur Export-Muster
# ============================================================================

$ErrorActionPreference = "Stop"
$VaultPath = "C:\Users\josef\iCloudDrive\iCloud~md~obsidian\Memoria"
$LogsDir = "C:\Users\josef\logs"
$LogFile = "$LogsDir\rainer-maintenance.log"
$ExportDate = Get-Date -Format "yyyy-MM-dd"
$TimeStamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$ExportFile = "$VaultPath\00 Inbox\Vault-Export-$ExportDate.md"

# Stelle sicher, dass Logs-Verzeichnis existiert
if (-not (Test-Path $LogsDir)) { New-Item -ItemType Directory -Path $LogsDir -Force | Out-Null }

# Starte Transkript
$TranscriptPath = "$LogsDir\rainer-maintenance_$ExportDate.transcript"
Start-Transcript -Path $TranscriptPath -Append -ErrorAction SilentlyContinue | Out-Null

Set-Location $VaultPath

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Entry = "[$TimeStamp] [$Level] $Message"
    Add-Content -Path $LogFile -Value $Entry -Encoding UTF8
    if ($Level -eq "SUCCESS") { Write-Host "✓ $Message" -ForegroundColor Green }
    elseif ($Level -eq "ERROR") { Write-Host "✗ $Message" -ForegroundColor Red }
    else { Write-Host "• $Message" }
}

# ============================================================================
# 1. VAULT-EXPORT ERZEUGEN
# ============================================================================

try {
    Write-Log "RAINER: Vault-Export wird gestartet..." "INFO"

    # Vault-Statistiken mit echten Befehlen
    Write-Log "Berechne Vault-Statistiken..." "INFO"
    $VaultStats = Get-ChildItem -Recurse -File -ErrorAction Stop | Measure-Object -Property Length -Sum
    $VaultSizeBytes = $VaultStats.Sum
    $VaultSizeMB = [math]::Round($VaultSizeBytes / 1MB, 2)
    $VaultFileCount = $VaultStats.Count

    Write-Log "Vault-Größe: $VaultSizeMB MB, Dateien: $VaultFileCount" "INFO"

    # Folder-Breakdown (Ausschlüsse: Persönliche Daten, Persönliche Dokumente)
    $Folders = @(
        "00 Inbox",
        "01 Projects",
        "02 Areas",
        "03 Resources",
        "04 Archive",
        "05 Templates",
        "06 Daily Notes",
        "07 Agents"
    )

    $FolderStats = @()
    foreach ($Folder in $Folders) {
        if (Test-Path $Folder) {
            try {
                $Stats = Get-ChildItem $Folder -Recurse -File -ErrorAction Stop | Measure-Object -Property Length -Sum
                $FolderStats += @{
                    Folder = $Folder
                    Size = if ($Stats.Sum) { [math]::Round($Stats.Sum / 1MB, 2) } else { 0 }
                    Files = $Stats.Count
                }
            } catch {
                Write-Log "Warnung: Fehler beim Lesen von Ordner $Folder" "WARN"
            }
        }
    }

# Ausschlusslisten-Ordner (nur Namen, KEINE Dateilisten)
$exclusions = @(
    "02 Areas/Persönliche Daten",
    "03 Resources/Persönliche Dokumente"
)

# Export-Inhalt zusammenstellen
$exportContent = @"
# 📦 VAULT-EXPORT – $exportDate

**Status:** Automatischer Maintenance-Run (Stufe 3)
**Scan-Zeit:** $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")
**Größe:** $vaultSizeMB MB
**Dateien:** $vaultFileCount
**Export-Methode:** PowerShell Get-ChildItem + Measure-Object

---

## 📊 VAULT-STATISTIKEN

| Ordner | Größe | Dateien |
|--------|-------|---------|
$(($folderStats | ForEach-Object { "| **$($_.Folder)** | $($_.Size) MB | $($_.Files) |" }) -join "`n")
| **GESAMT** | **$vaultSizeMB MB** | **$vaultFileCount** |

---

## 🔐 SICHERHEIT & AUSSCHLUSSLISTEN

Folgende sensible Ordner sind AUSGESCHLOSSEN:
$($exclusions | ForEach-Object { "- ✅ $_ (Grund: Sensible Daten, keine Listung)" }) -join "`n"

**Dargeboten:** Nur Ordnernamen & Größen, KEINE Dateilisten oder Inhalte

---

## ⏰ SCAN-METADATEN

| Feld | Wert |
|------|------|
| **Scan-Datum** | $exportDate |
| **Scan-Zeit** | $(Get-Date -Format "yyyy-MM-dd HH:mm:ss") |
| **Scan-Methode** | Get-ChildItem (Echte Messung) |
| **Größen-Quelle** | Measure-Object -Sum (Echt) |
| **Dateienzählung** | Measure-Object (Echt) |

---

## ✅ IMPLEMENTIERUNG (Stufe 3 – Task Scheduler)

- ✅ Tägliche Ausführung: 08:00 Uhr
- ✅ Größen aus echten Befehlen
- ✅ Ausschlussliste für sensible Ordner
- ✅ Datum/Zeit aus realem Scan
- ✅ Markdown-Format (Copy-Paste-ready)
- ✅ Cleanup-Regel für alte Exports

---

**Export-Status:** ✅ AUTOMATISCH ERSTELLT via Task Scheduler (Stufe 3)

"@

    # Export-Datei schreiben (NUR in 00 Inbox/)
    Write-Log "Schreibe Export-Datei: $ExportFile" "INFO"
    $ExportContent | Out-File -FilePath $ExportFile -Encoding UTF8 -Force

    # Verifiziere, dass Datei erstellt wurde
    if (-not (Test-Path $ExportFile)) {
        throw "Export-Datei konnte nicht erstellt werden: $ExportFile"
    }

    $FileSize = (Get-Item $ExportFile).Length
    Write-Log "Export-Datei erfolgreich erstellt ($('{0:N0}' -f $FileSize) Bytes)" "SUCCESS"

} catch {
    Write-Log "Fehler beim Export: $($_.Exception.Message)" "ERROR"
    throw $_
}

# ============================================================================
# 2. ALTE EXPORTS LÖSCHEN (älter als 7 Tage)
# ============================================================================

try {
    Write-Log "Cleanup alte Exports (älter als 7 Tage)..." "INFO"

    $CutoffDate = (Get-Date).AddDays(-7)
    $OldExports = Get-ChildItem "$VaultPath\00 Inbox\Vault-Export-*.md" -File -ErrorAction Stop |
                  Where-Object { $_.LastWriteTime -lt $CutoffDate }

    if ($OldExports) {
        $OldCount = ($OldExports | Measure-Object).Count
        Write-Log "Lösche $OldCount alte Export(s)..." "INFO"
        $OldExports | Remove-Item -Force -ErrorAction Stop
        Write-Log "$OldCount alte Export(s) gelöscht" "SUCCESS"
    } else {
        Write-Log "Keine alten Exports zum Löschen" "INFO"
    }
} catch {
    Write-Log "Fehler beim Cleanup: $($_.Exception.Message)" "ERROR"
    # Cleanup-Fehler sind nicht kritisch — fahre fort
}

Write-Log "========================================" "INFO"
Write-Log "RAINER: Maintenance erfolgreich abgeschlossen" "SUCCESS"
Write-Log "========================================" "INFO"

Stop-Transcript -ErrorAction SilentlyContinue | Out-Null
exit 0
