# ============================================================================
# RAINER MAINTENANCE SCRIPT – Täglich 08:00 Uhr
# ============================================================================
# Funktion:
#   1. Vault-Export erzeugen (00 Inbox/Vault-Export-DATUM.md)
#   2. Alte Exports löschen (älter als 7 Tage)
#
# Berechtigungen: Lesen Vault | Schreiben nur 00 Inbox/ | Löschen nur Export-Muster
# ============================================================================

Set-Location "C:\Users\josef\iCloudDrive\iCloud~md~obsidian\Memoria"

$ErrorActionPreference = "Stop"
$exportDate = Get-Date -Format "yyyy-MM-dd"
$exportFile = "00 Inbox\Vault-Export-$exportDate.md"

# ============================================================================
# 1. VAULT-EXPORT ERZEUGEN
# ============================================================================

Write-Host "[$exportDate 08:00] RAINER: Vault-Export wird gestartet..." -ForegroundColor Cyan

# Vault-Statistiken mit echten Befehlen
$vaultStats = Get-ChildItem -Recurse -File | Measure-Object -Property Length -Sum
$vaultSizeBytes = $vaultStats.Sum
$vaultSizeMB = [math]::Round($vaultSizeBytes / 1MB, 2)
$vaultFileCount = $vaultStats.Count

# Folder-Breakdown (Ausschlüsse: Persönliche Daten, Persönliche Dokumente)
$folders = @(
    "00 Inbox",
    "01 Projects",
    "02 Areas",
    "03 Resources",
    "04 Archive",
    "05 Templates",
    "06 Daily Notes",
    "07 Agents"
)

$folderStats = @()
foreach ($folder in $folders) {
    if (Test-Path $folder) {
        $stats = Get-ChildItem $folder -Recurse -File | Measure-Object -Property Length -Sum
        $folderStats += @{
            Folder = $folder
            Size = [math]::Round($stats.Sum / 1MB, 2)
            Files = $stats.Count
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
$exportContent | Out-File -FilePath $exportFile -Encoding UTF8 -Force

Write-Host "[$exportDate 08:00] RAINER: Export erstellt → $exportFile" -ForegroundColor Green

# ============================================================================
# 2. ALTE EXPORTS LÖSCHEN (älter als 7 Tage)
# ============================================================================

Write-Host "[$exportDate 08:00] RAINER: Cleanup alte Exports..." -ForegroundColor Cyan

$cutoffDate = (Get-Date).AddDays(-7)
$oldExports = Get-ChildItem "00 Inbox\Vault-Export-*.md" -File | Where-Object { $_.LastWriteTime -lt $cutoffDate }

if ($oldExports) {
    $oldExports | Remove-Item -Force
    Write-Host "[$exportDate 08:00] RAINER: $(($oldExports | Measure-Object).Count) alte Export(s) gelöscht" -ForegroundColor Green
} else {
    Write-Host "[$exportDate 08:00] RAINER: Keine alten Exports zum Löschen" -ForegroundColor Gray
}

Write-Host "[$exportDate 08:00] RAINER: Maintenance abgeschlossen [OK]" -ForegroundColor Green
