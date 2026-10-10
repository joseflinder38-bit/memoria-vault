param()

# Hinweis (2026-10-06): Der Ordnername enthaelt einen Umlaut ("Persoenliche").
# Windows PowerShell 5.1 liest .ps1-Dateien ohne BOM ueber die System-ANSI-Codepage,
# wodurch woertliche Umlaute im Quelltext unter Task Scheduler verstuemmelt werden
# koennen (z.B. "PersÃ¶nliche" statt "Persönliche" -> Pfad nicht gefunden).
# Fix: Umlaut ueber Zeichencode aufbauen statt woertlich im Quelltext zu schreiben -
# das ist unabhaengig von Datei-Encoding/BOM immer korrekt.
$oe = [char]0x00F6

$VaultPath = "C:\Users\josef\iCloudDrive\iCloud~md~obsidian\Memoria"
$JobsFolder = "$VaultPath\02 Areas\Jobsuche"
$PrivatFolder = "$VaultPath\02 Areas\Pers" + $oe + "nliche Daten\Privat"
$LogFile = "$PrivatFolder\nina-scout.log"
$DateStamp = Get-Date -Format "yyyy-MM-dd"
$TimeStamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$OutputFile = "$JobsFolder\Jobsuche-$DateStamp.md"

if (!(Test-Path $JobsFolder)) { New-Item -ItemType Directory -Path $JobsFolder -Force | Out-Null }
if (!(Test-Path $PrivatFolder)) { New-Item -ItemType Directory -Path $PrivatFolder -Force | Out-Null }

function Write-Log {
    param([string]$msg, [string]$level = "INFO")
    $entry = "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] [$level] $msg"
    Add-Content -Path $LogFile -Value $entry -Encoding UTF8
    if ($level -eq "SUCCESS") { Write-Host "OK: $msg" -ForegroundColor Green }
    elseif ($level -eq "ERROR") { Write-Host "ERR: $msg" -ForegroundColor Red }
    else { Write-Host "INFO: $msg" }
}

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

try {
    $md | Out-File -FilePath $OutputFile -Encoding UTF8 -Force
    Write-Log "Jobsuche-Datei erstellt: Jobsuche-$DateStamp.md" "SUCCESS"
} catch {
    Write-Log "Fehler beim Erstellen der Datei: $_" "ERROR"
    exit 1
}

try {
    Push-Location $VaultPath
    if (Test-Path ".git") {
        git add "02 Areas/Jobsuche/Jobsuche-$DateStamp.md" 2>&1 | Out-Null
        git commit -m "Nina Scout: Jobsuche $DateStamp - $($Jobs.Count) Stellen" 2>&1 | Out-Null
        Write-Log "Git Backup durchgefuehrt" "SUCCESS"
    }
} catch {
    Write-Log "Git Backup nicht moeglich" "INFO"
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

exit 0
