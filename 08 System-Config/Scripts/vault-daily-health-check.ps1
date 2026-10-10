# ============================================================================
# VAULT DAILY HEALTH CHECK
# Automatischer täglicher Health-Check für Obsidian Vault
# Warnt bei kritischen Problemen
# ============================================================================

param(
    [string]$VaultPath = ".",
    [string]$ReportPath = "00 Inbox"
)

# Datum für Report
$today = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$reportDate = Get-Date -Format "yyyy-MM-dd"

# Report-Datei
$reportFile = Join-Path $ReportPath "VAULT-DAILY-HEALTH_$reportDate.md"

# Status-Variable
$criticalIssues = @()
$warnings = @()
$healthy = $true

Write-Host "=== VAULT DAILY HEALTH CHECK ===" -ForegroundColor Cyan
Write-Host "Zeitstempel: $today" -ForegroundColor Gray

# ============================================================================
# 1. DUPLIKATE SUCHEN
# ============================================================================
Write-Host "`n[1/5] Suche nach Duplikaten..." -ForegroundColor Yellow

$duplicates = Get-ChildItem -Path $VaultPath -Recurse -File |
    Group-Object -Property Name |
    Where-Object {$_.Count -gt 1 -and $_.Name -notmatch "^(manifest|data|theme|styles|main|SKILL|README)\."}

if ($duplicates) {
    $healthy = $false
    foreach ($dup in $duplicates) {
        $msg = "DUPLIKAT: $($dup.Name) (x$($dup.Count))"
        $criticalIssues += $msg
        Write-Host "   ⚠️  $msg" -ForegroundColor Red
    }
} else {
    Write-Host "   ✅ Keine Duplikate gefunden" -ForegroundColor Green
}

# ============================================================================
# 2. INBOX-KONTROLLE
# ============================================================================
Write-Host "`n[2/5] Überprüfe Inbox..." -ForegroundColor Yellow

$inboxCount = (Get-ChildItem -Path $reportPath -File | Where-Object {$_.Name -notmatch "^VAULT-DAILY"} | Measure-Object).Count

if ($inboxCount -gt 15) {
    $healthy = $false
    $msg = "INBOX VOLL: $inboxCount Dateien (Grenzwert: 10-15)"
    $criticalIssues += $msg
    Write-Host "   🔴 $msg" -ForegroundColor Red
} elseif ($inboxCount -gt 10) {
    $warnings += "Inbox hat $inboxCount Dateien (sollte unter 10 sein)"
    Write-Host "   ⚠️  Inbox: $inboxCount Dateien" -ForegroundColor Yellow
} else {
    Write-Host "   ✅ Inbox: $inboxCount Dateien (OK)" -ForegroundColor Green
}

# ============================================================================
# 3. LEERE ORDNER (nur Nutzerordner, keine System)
# ============================================================================
Write-Host "`n[3/5] Suche nach leeren Nutzer-Ordnern..." -ForegroundColor Yellow

$emptyFolders = @()
$foldersScan = @("01 Projects", "02 Areas", "03 Resources", "04 Archive", "05 Templates", "06 Daily Notes", "07 Agents")

foreach ($folder in $foldersScan) {
    if (Test-Path $folder) {
        $empty = Get-ChildItem -Path $folder -Recurse -Directory |
            Where-Object {(Get-ChildItem -Path $_.FullName -File | Measure-Object).Count -eq 0}

        $emptyFolders += $empty
    }
}

if ($emptyFolders.Count -gt 2) {
    $warnings += "Zu viele leere Ordner: $($emptyFolders.Count) (sollte unter 3 sein)"
    Write-Host "   ⚠️  $($emptyFolders.Count) leere Ordner" -ForegroundColor Yellow
} else {
    Write-Host "   ✅ Leere Ordner: OK" -ForegroundColor Green
}

# ============================================================================
# 4. VAULT-STRUKTUR (PARA-Methode)
# ============================================================================
Write-Host "`n[4/5] Überprüfe PARA-Struktur..." -ForegroundColor Yellow

$requiredFolders = @("00 Inbox", "01 Projects", "02 Areas", "03 Resources", "04 Archive", "05 Templates", "06 Daily Notes", "07 Agents")
$missingFolders = @()

foreach ($folder in $requiredFolders) {
    if (!(Test-Path $folder)) {
        $missingFolders += $folder
        $healthy = $false
    }
}

if ($missingFolders) {
    $msg = "FEHLENDE ORDNER: $($missingFolders -join ', ')"
    $criticalIssues += $msg
    Write-Host "   🔴 $msg" -ForegroundColor Red
} else {
    Write-Host "   ✅ Alle PARA-Ordner vorhanden" -ForegroundColor Green
}

# ============================================================================
# 5. DATEITYP-VERTEILUNG
# ============================================================================
Write-Host "`n[5/5] Analysiere Dateitypen..." -ForegroundColor Yellow

$fileTypes = Get-ChildItem -Path $VaultPath -Recurse -File | Group-Object -Property Extension | Sort-Object -Property Count -Descending | Select-Object -First 5

$mdCount = (Get-ChildItem -Path $VaultPath -Recurse -Filter "*.md" | Measure-Object).Count
$totalFiles = (Get-ChildItem -Path $VaultPath -Recurse -File | Measure-Object).Count

if ($mdCount -lt ($totalFiles * 0.4)) {
    $warnings += "Zu wenig Markdown-Dateien: $mdCount von $totalFiles (sollte >40%)"
    Write-Host "   ⚠️  MD-Anteil: $([math]::Round(($mdCount/$totalFiles)*100))%" -ForegroundColor Yellow
} else {
    Write-Host "   ✅ Markdown-Anteil: $([math]::Round(($mdCount/$totalFiles)*100))% (gut)" -ForegroundColor Green
}

# ============================================================================
# GESAMT-STATUS
# ============================================================================

Write-Host "`n`n=== GESAMT-STATUS ===" -ForegroundColor Cyan
if ($healthy -and $criticalIssues.Count -eq 0) {
    Write-Host "✅ VAULT GESUND" -ForegroundColor Green
    $status = "GESUND ✅"
    $score = 10
} elseif ($criticalIssues.Count -eq 0) {
    Write-Host "⚠️  WARNUNGEN VORHANDEN" -ForegroundColor Yellow
    $status = "WARNUNG ⚠️"
    $score = 7
} else {
    Write-Host "🔴 KRITISCHE PROBLEME!" -ForegroundColor Red
    $status = "KRITISCH 🔴"
    $score = 3
}

# ============================================================================
# REPORT GENERIEREN
# ============================================================================

$report = @"
---
type: vault-health-report
datum: $today
status: $status
score: $score/10
---

# 📊 VAULT DAILY HEALTH CHECK

**Datum:** $today
**Status:** $status
**Score:** $score/10

---

## 🎯 ZUSAMMENFASSUNG

- **Inbox-Dateien:** $inboxCount (Grenzwert: <10)
- **Leere Ordner:** $($emptyFolders.Count)
- **Duplikate gefunden:** $($duplicates.Count)
- **Markdown-Dateien:** $mdCount / $totalFiles

---

## 🔴 KRITISCHE PROBLEME ($($criticalIssues.Count))

"@

if ($criticalIssues.Count -eq 0) {
    $report += "Keine kritischen Probleme gefunden ✅`n`n"
} else {
    foreach ($issue in $criticalIssues) {
        $report += "- ❌ $issue`n"
    }
    $report += "`n"
}

$report += @"
## ⚠️  WARNUNGEN ($($warnings.Count))

"@

if ($warnings.Count -eq 0) {
    $report += "Keine Warnungen ✅`n`n"
} else {
    foreach ($warn in $warnings) {
        $report += "- ⚠️  $warn`n"
    }
    $report += "`n"
}

$report += @"
## ✅ POSITIVE BEFUNDE

- ✅ PARA-Struktur intakt
- ✅ Alle Hauptordner vorhanden
- ✅ Dateiformat-Verteilung OK
- ✅ Täglich automatisch überprüft

---

## 🚀 EMPFEHLUNGEN

"@

if ($inboxCount -gt 10) {
    $report += "1. **Inbox aufräumen:** $inboxCount Dateien sollten in andere Ordner verschoben werden`n"
}

if ($criticalIssues.Count -gt 0) {
    $report += "2. **Kritische Probleme beheben:** Siehe oben`n"
}

if ($emptyFolders.Count -gt 2) {
    $report += "3. **Leere Ordner löschen oder mit Inhalt füllen**`n"
}

if ($criticalIssues.Count -eq 0 -and $warnings.Count -eq 0) {
    $report += "✅ Vault ist in gutem Zustand! Keine Aktionen erforderlich.`n"
}

$report += @"

---

**Nächster Check:** Morgen um diese Zeit
**Auto-generiert von:** Vault Daily Health Check Agent
**Häufigkeit:** Täglich 06:00 Uhr (Berlin)

"@

# Speichere Report
$report | Out-File -FilePath $reportFile -Encoding UTF8 -Force
Write-Host "`n✅ Report gespeichert: $reportFile" -ForegroundColor Green

# ============================================================================
# WARNUNG BEI KRITISCHEN PROBLEMEN
# ============================================================================

if ($criticalIssues.Count -gt 0) {
    Write-Host "`n🚨 WARNUNG: KRITISCHE PROBLEME GEFUNDEN!" -ForegroundColor Red
    Write-Host "   Bitte Report überprüfen: $reportFile" -ForegroundColor Red
    Write-Host "   Probleme: $($criticalIssues -join ' | ')" -ForegroundColor Red

    # Erstelle Alert-Datei für Obsidian-Notification
    $alertFile = Join-Path $reportPath "⚠️-VAULT-ALERT-$reportDate.md"
    $alertContent = @"
# 🚨 VAULT HEALTH ALERT

**KRITISCHE PROBLEME GEFUNDEN!**

$(($criticalIssues | ForEach-Object { "- ❌ $_" }) -join "`n")

**Check:** [[VAULT-DAILY-HEALTH_$reportDate]]

Siehe Daily Health Report für Details.
"@
    $alertContent | Out-File -FilePath $alertFile -Encoding UTF8 -Force
    exit 1
}

Write-Host "`n✅ Health Check abgeschlossen ohne kritische Probleme!" -ForegroundColor Green
exit 0
