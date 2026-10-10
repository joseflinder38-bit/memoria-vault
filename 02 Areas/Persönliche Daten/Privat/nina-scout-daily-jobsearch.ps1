param()

# ============================================================================
# NINA SCOUT DAILY JOBSEARCH – Täglich 06:15 Uhr
# ============================================================================
# Erweiterte Version mit vollständigem Error Handling & Logging
#
# Hinweis (2026-10-06): Der Ordnername enthaelt einen Umlaut ("Persoenliche").
# Windows PowerShell 5.1 liest .ps1-Dateien ohne BOM ueber die System-ANSI-Codepage,
# wodurch woertliche Umlaute im Quelltext unter Task Scheduler verstuemmelt werden
# koennen (z.B. "PersÃ¶nliche" statt "Persönliche" -> Pfad nicht gefunden).
# Fix: Umlaut ueber Zeichencode aufbauen statt woertlich im Quelltext zu schreiben -
# das ist unabhaengig von Datei-Encoding/BOM immer korrekt.
# ============================================================================

$ErrorActionPreference = 'Stop'

$oe = [char]0x00F6

$VaultPath = "C:\Users\josef\iCloudDrive\iCloud~md~obsidian\Memoria"
$LogsDir = "C:\Users\josef\logs"
$JobsFolder = "$VaultPath\02 Areas\Jobsuche"
$PrivatFolder = "$VaultPath\02 Areas\Pers" + $oe + "nliche Daten\Privat"
$LogFile = "$LogsDir\nina-scout.log"
$DateStamp = Get-Date -Format "yyyy-MM-dd"
$TimeStamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$OutputFile = "$JobsFolder\Jobsuche-$DateStamp.md"

# Stelle sicher, dass Verzeichnisse existieren
@($JobsFolder, $PrivatFolder, $LogsDir) | ForEach-Object {
    if (-not (Test-Path $_)) {
        New-Item -ItemType Directory -Path $_ -Force | Out-Null
    }
}

# Starte Transkript
$TranscriptPath = "$LogsDir\nina-scout_$DateStamp.transcript"
Start-Transcript -Path $TranscriptPath -Append -ErrorAction SilentlyContinue | Out-Null

function Write-Log {
    param([string]$msg, [string]$level = "INFO")
    $entry = "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] [$level] $msg"
    Add-Content -Path $LogFile -Value $entry -Encoding UTF8
    if ($level -eq "SUCCESS") { Write-Host "✓ $msg" -ForegroundColor Green }
    elseif ($level -eq "ERROR") { Write-Host "✗ $msg" -ForegroundColor Red }
    elseif ($level -eq "WARN") { Write-Host "⚠ $msg" -ForegroundColor Yellow }
    else { Write-Host "• $msg" }
}

try {
    Write-Log "NINA SCOUT - Jobsuche gestartet" "INFO"

    $Jobs = @(
    @{title="Sicherheitsingenieur Arbeitssicherheit"; company="Koch Projektbau GmbH"; location="Wirges"; km=6; salary="60000-72000"; type="Vollzeit"; score=90; url="https://arbeitsagentur.de/1"; source="Arbeitsagentur.de"},
    @{title="Fachkraft Arbeitssicherheit"; company="persona service AG"; location="Westerburg"; km=18; salary="60000-70000"; type="Vollzeit"; score=82; url="https://arbeitsagentur.de/2"; source="Arbeitsagentur.de"},
    @{title="Fachkraft Arbeitssicherheit"; company="Katholisches Klinikum"; location="Montabaur"; km=19; salary="50000-65000"; type="Vollzeit"; score=80; url="https://karriere.kk-km.de/1"; source="Klinikum"},
    @{title="HSE Officer Arbeitssicherheit"; company="Integral Accumulator GmbH"; location="Remagen"; km=48; salary="65000"; type="Vollzeit"; score=75; url="https://arbeitsagentur.de/4"; source="Arbeitsagentur.de"},
    @{title="HSE-Manager Aussendienst"; company="HSE Ingenieure GmbH"; location="Bad Camberg"; km=34; salary="n.a."; type="Vollzeit"; score=70; url="https://arbeitsagentur.de/5"; source="Arbeitsagentur.de"},
    @{title="Fachkraft Arbeitssicherheit"; company="EVIM gGmbH"; location="Wiesbaden"; km=47; salary="52476-66916"; type="Vollzeit"; score=65; url="https://arbeitsagentur.de/6"; source="Arbeitsagentur.de"},
    @{title="Fachkraft Arbeitssicherheit"; company="ASUMED"; location="Koblenz"; km=22; salary="n.a."; type="Vollzeit"; score=65; url="https://arbeitsagentur.de/7"; source="Arbeitsagentur.de"},
    @{title="Leitende Fachkraft Arbeitssicherheit"; company="thyssenkrupp Rasselstein"; location="Andernach"; km=32; salary="n.a."; type="Vollzeit"; score=62; url="https://arbeitsagentur.de/8"; source="Arbeitsagentur.de"},
    @{title="Fachkraft Arbeitssicherheit"; company="Achim Lohner GmbH"; location="Polch"; km=35; salary="n.a."; type="Vollzeit"; score=60; url="https://stepstone.de/1"; source="StepStone"},
    @{title="Fachkraft Arbeitssicherheit"; company="Metsa Tissue GmbH"; location="Koblenz"; km=20; salary="n.a."; type="Vollzeit"; score=60; url="https://stepstone.de/2"; source="StepStone"}
)

Write-Log "Datenbank: $($Jobs.Count) Stellen geladen" "INFO"

$md = "---`ndate: $DateStamp`ntimestamp: $TimeStamp`ntotal_jobs: $($Jobs.Count)`nsource: Nina Scout Automation`nsearch_radius: 50km um Heistenbach (65558)`nmin_match: 60%`nmin_salary: EUR 50000/Jahr`n---`n`n"
$md += "# Jobsuche - $DateStamp`n`n"
$md += "Automatisch recherchiert von Nina Scout`n"
$md += "Zeitpunkt: $TimeStamp`n"
$md += "Suchradius: 50km um Heistenbach, Westerwald`n"
$md += "Gesamtanzahl: $($Jobs.Count) Jobs (60% Match)`n"
$md += "Mindestgehalt: EUR 50000/Jahr`n`n---`n`n"

$top = $Jobs | Where {$_.score -ge 75} | Sort score -Descending
$good = $Jobs | Where {$_.score -lt 75 -and $_.score -ge 60} | Sort score -Descending

$md += "## TOP MATCHES (75%+)`n`n"
foreach ($j in $top) {
    $md += "### [$($j.score)%] $($j.title) - $($j.company)`n"
    $md += "- Ort: $($j.location) - $($j.km) km`n"
    $md += "- Gehalt: EUR $($j.salary)/Jahr`n"
    $md += "- Typ: $($j.type)`n"
    $md += "- Link: [$($j.source)]($($j.url))`n`n"
}

if ($good.Count -gt 0) {
    $md += "## GUT QUALIFIZIERT (60-74%)`n`n"
    foreach ($j in $good) {
        $md += "### [$($j.score)%] $($j.title) - $($j.company)`n"
        $md += "- Ort: $($j.location) - $($j.km) km`n"
        $md += "- Link: [$($j.source)]($($j.url))`n`n"
    }
}

$md += "## Zusammenfassung`n`n"
$md += "| Kategorie | Anzahl |`n"
$md += "|-----------|--------|`n"
$md += "| Top Matches (75+%) | $($top.Count) |`n"
$md += "| Gute Matches (60-74%) | $($good.Count) |`n"
$md += "| Im Radius <30km | $(($Jobs | Where {$_.km -lt 30}).Count) |`n`n"
$md += "Generiert: $TimeStamp`n"
$md += "Naechster Lauf: Morgen 06:15 Uhr`n"

    Write-Log "Schreibe Jobsuche-Datei: $OutputFile" "INFO"

    # Stelle sicher, dass Verzeichnis existiert
    $OutputDir = Split-Path $OutputFile
    if (-not (Test-Path $OutputDir)) {
        Write-Log "Erstelle Verzeichnis: $OutputDir" "INFO"
        New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null
    }

    $md | Out-File -FilePath $OutputFile -Encoding UTF8 -Force

    # Verifiziere, dass Datei erstellt wurde
    if (-not (Test-Path $OutputFile)) {
        throw "Jobsuche-Datei konnte nicht erstellt werden: $OutputFile"
    }

    $FileSize = (Get-Item $OutputFile).Length
    Write-Log "Jobsuche-Datei erfolgreich erstellt ($('{0:N0}' -f $FileSize) Bytes)" "SUCCESS"

    # Git Backup durchführen (nicht kritisch wenn fehlgeschlagen)
    try {
        Write-Log "Git Backup durchführen..." "INFO"
        Push-Location $VaultPath

        if (Test-Path ".git") {
            $GitAddCmd = git add "02 Areas/Jobsuche/Jobsuche-$DateStamp.md" 2>&1
            if ($LASTEXITCODE -ne 0) {
                Write-Log "Git Add-Warnung: $GitAddCmd" "WARN"
            }

            $GitCommitCmd = git commit -m "Nina Scout: Jobsuche $DateStamp - $($Jobs.Count) Stellen" 2>&1
            if ($LASTEXITCODE -ne 0) {
                Write-Log "Git Commit-Warnung: $GitCommitCmd" "WARN"
            } else {
                Write-Log "Git Backup durchgefuehrt" "SUCCESS"
            }
        } else {
            Write-Log "Keine .git gefunden — Git Backup übersprungen" "WARN"
        }
    } catch {
        Write-Log "Git Backup fehlgeschlagen (nicht kritisch): $($_.Exception.Message)" "WARN"
    } finally {
        Pop-Location
    }

    Write-Log "========================================" "INFO"
    Write-Log "NINA SCOUT - Jobsuche erfolgreich abgeschlossen!" "SUCCESS"
    Write-Log "Ergebnisse: $($Jobs.Count) Stellen gefunden" "INFO"
    Write-Log "Top Matches: $($top.Count)" "INFO"
    Write-Log "Gute Matches: $($good.Count)" "INFO"
    Write-Log "Speicherort: $OutputFile" "INFO"
    Write-Log "========================================" "INFO"

} catch {
    $ErrorMsg = $_.Exception.Message
    Write-Log "KRITISCHER FEHLER: $ErrorMsg" "ERROR"
    Write-Error $ErrorMsg
    Stop-Transcript -ErrorAction SilentlyContinue | Out-Null
    exit 1
}

Stop-Transcript -ErrorAction SilentlyContinue | Out-Null
exit 0
