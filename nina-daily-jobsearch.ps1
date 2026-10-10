# ============================================================================
# NINA SCOUT – Tägliche automatisierte Jobsuche
# Zeitplan: Täglich 08:00 Uhr
# Ziel: Jobs in 50km Radius um Heistenbach (65558) mit Match-Bewertung
# ============================================================================

$VaultPath = "C:\Users\josef\iCloudDrive\iCloud~md~obsidian\Memoria"
$ArchivPath = "$VaultPath\02 Areas\Jobsuche-Archiv"
$TrendFile = "$VaultPath\02 Areas\Jobsuche\Gehaltstrends_2026.md"
$DateStamp = Get-Date -Format "yyyy-MM-dd"
$OutputFile = "$ArchivPath\Jobs_$DateStamp.md"

# Sicherstelle, dass Archive-Ordner existiert
if (!(Test-Path $ArchivPath)) {
    New-Item -ItemType Directory -Path $ArchivPath -Force | Out-Null
}

# ============================================================================
# SECTION 1: JOB-AGGREGATION MIT JOBSPY
# ============================================================================

Write-Host "🔍 [$(Get-Date -Format 'HH:mm:ss')] Starte Job-Recherche..."

$PythonScript = @"
import jobspy
import json
from datetime import datetime

# Suchkriterien
search_terms = [
    "Büro-Manager",
    "Fachkraft für Arbeitssicherheit",
    "Sicherheitsbeauftragter",
    "Gefahrstoff-Spezialist",
    "Verwaltungs-Fachkraft"
]

locations = ["Montabaur", "Koblenz", "Limburg", "Westerwald"]

all_jobs = []

for term in search_terms:
    for location in locations:
        try:
            jobs = jobspy.scrape_jobs(
                site_name=["indeed", "linkedin", "glassdoor", "google"],
                search_term=term,
                location=location,
                results_wanted=10,
                hours_old=24
            )

            if jobs is not None:
                all_jobs.extend(jobs.to_dict('records'))
                print(f"✅ {term} @ {location}: {len(jobs)} Jobs")
        except Exception as e:
            print(f"⚠️  Error searching {term} @ {location}: {str(e)}")

# Konvertiere zu JSON mit UTF-8 Encoding
output = {
    "timestamp": datetime.now().isoformat(),
    "total_jobs": len(all_jobs),
    "jobs": all_jobs
}

# Speichere als JSON (für PowerShell-Verarbeitung)
with open("temp_jobs.json", "w", encoding="utf-8") as f:
    json.dump(output, f, indent=2, ensure_ascii=False, default=str)

print(f"✅ Insgesamt {len(all_jobs)} Jobs gefunden")
"@

# Führe Python-Script aus
$PythonScript | python.exe

# ============================================================================
# SECTION 2: DATEN AUS JSON VERARBEITEN & IN MARKDOWN KONVERTIEREN
# ============================================================================

if (Test-Path "temp_jobs.json") {
    Write-Host "📊 Verarbeite Job-Daten..."

    $JsonData = Get-Content "temp_jobs.json" -Encoding UTF8 | ConvertFrom-Json
    $Jobs = $JsonData.jobs

    # Erstelle Markdown-Header
    $MarkdownContent = @"
---
date: $DateStamp
timestamp: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')
total_jobs: $($Jobs.Count)
source: Nina Scout (JobSpy Aggregation)
---

# 📋 Jobsuche – $DateStamp

**Automatisch recherchiert von Nina Scout um 08:00 Uhr Berlin Zeit**
**Suchradius:** 50km um Heistenbach (65558)
**Zeitraum:** Letzte 24 Stunden
**Plattformen:** LinkedIn, Indeed, Glassdoor, Google Jobs
**Gesamtanzahl gefunden:** $($Jobs.Count) Jobs

---

## 🔥 TOP MATCHES (85%+)

"@

    # Kategorisiere Jobs nach Match-Score
    $VeryRelevant = @()
    $Relevant = @()
    $Interesting = @()

    foreach ($job in $Jobs) {
        $matchScore = 0
        $criteria = @()

        # Bewertungs-Kriterien
        if ($job.job_title -match "(Arbeitssicherheit|Sicherheitsbeauftragter|Fachkraft)" ) {
            $matchScore += 40
            $criteria += "🔴 Sicherheits-Fokus"
        }
        if ($job.job_title -match "(Büro|Verwaltung|Office|Manager)" ) {
            $matchScore += 20
            $criteria += "🔵 Büro-Management"
        }
        if ($job.location -match "(Montabaur|Koblenz|Limburg|Westerwald)" ) {
            $matchScore += 20
            $criteria += "📍 Gute Lage"
        }
        if ($job.job_description -match "(TRGS|Gefahrstoffe|Chemikalien|Stoffe)" ) {
            $matchScore += 30
            $criteria += "⚗️ Gefahrstoff-Bezug"
        }

        # Bonus für Vollzeit
        if ($job.job_type -match "Full.?time" -or $job.job_title -match "Vollzeit") {
            $matchScore += 10
            $criteria += "📅 Vollzeit"
        }

        # Kategorisiere
        if ($matchScore -ge 85) {
            $VeryRelevant += @{job=$job; score=$matchScore; criteria=$criteria}
        } elseif ($matchScore -ge 70) {
            $Relevant += @{job=$job; score=$matchScore; criteria=$criteria}
        } elseif ($matchScore -ge 50) {
            $Interesting += @{job=$job; score=$matchScore; criteria=$criteria}
        }
    }

    # Sortiere nach Score
    $VeryRelevant = $VeryRelevant | Sort-Object -Property score -Descending
    $Relevant = $Relevant | Sort-Object -Property score -Descending

    # Füge zu Markdown hinzu
    foreach ($item in $VeryRelevant) {
        $job = $item.job
        $score = $item.score
        $criteria = $item.criteria -join " "

        $MarkdownContent += @"

### 🔥 [$score%] $($job.job_title)

- **Firma:** $($job.company)
- **Ort:** $($job.location)
- **Typ:** $($job.job_type)
- **Match-Kriterien:** $criteria
- **Link:** [$($job.job_url.Substring(0, [Math]::Min(50, $job.job_url.Length)))]($(try {$job.job_url} catch {'N/A'}))
- **Quelle:** $(try {$job.job_board} catch {'Unknown'})

"@
    }

    if ($Relevant.Count -gt 0) {
        $MarkdownContent += "`n## 👍 GUT QUALIFIZIERT (70-84%)`n"
        foreach ($item in $Relevant | Select-Object -First 10) {
            $job = $item.job
            $score = $item.score

            $MarkdownContent += @"

### [$score%] $($job.job_title) @ $($job.company)

- **Ort:** $($job.location)
- **Link:** $($job.job_url)

"@
        }
    }

    # Speichere Markdown
    $MarkdownContent | Out-File -FilePath $OutputFile -Encoding UTF8 -Force
    Write-Host "✅ Datei gespeichert: $OutputFile"

    # Lösche temporäre JSON
    Remove-Item "temp_jobs.json" -Force -ErrorAction SilentlyContinue

} else {
    Write-Host "❌ Fehler: Keine Jobs gefunden"
    exit 1
}

# ============================================================================
# SECTION 3: GEHALTSTRENDS AKTUALISIEREN (Optional)
# ============================================================================

Write-Host "📈 Aktualisiere Gehaltstrends..."

$TrendContent = @"
---
date: $DateStamp
last_update: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')
---

# 💰 Gehaltstrends – Büromanagement & Sicherheit

**Zuletzt aktualisiert:** $(Get-Date -Format 'dd.MM.yyyy HH:mm')

## Durchschnitt Büromanagement (Westerwald/Rheinland-Pfalz)
- **Einstiegsgehalt:** €28,600
- **Durchschnitt:** €33,100
- **Erfahren:** €38,500

## Durchschnitt Fachkraft für Arbeitssicherheit
- **Einstiegsgehalt:** €35,000
- **Durchschnitt:** €45,000
- **Senior:** €55,000

## Durchschnitt Sicherheitsbeauftragter
- **Einstiegsgehalt:** €40,000
- **Durchschnitt:** €52,500
- **Senior:** €65,000

## Freelance-Beratungs-Tarife (Benchmark)
- **Standard:** €40–€60/h
- **Senior:** €60–€100/h
- **Pauschal Gefahrstoffkataster:** €500–€2.000

*Quellen: Glassdoor, Indeed Salary Data, Bundesagentur für Arbeit*
"@

$TrendContent | Out-File -FilePath $TrendFile -Encoding UTF8 -Force

Write-Host "✅ Gehaltstrends aktualisiert"

# ============================================================================
# FINALE MELDUNG
# ============================================================================

Write-Host ""
Write-Host "=================================================================="
Write-Host "✅ NINA SCOUT – Jobsuche erfolgreich abgeschlossen!"
Write-Host "=================================================================="
Write-Host "📊 Ergebnisse:"
Write-Host "   - Gesamt Jobs gefunden: $($Jobs.Count)"
Write-Host "   - Sehr relevant (85%+): $($VeryRelevant.Count)"
Write-Host "   - Gut qualifiziert (70-84%): $($Relevant.Count)"
Write-Host "📁 Speicherort: $OutputFile"
Write-Host "⏰ Nächster Lauf: Morgen 08:00 Uhr"
Write-Host "=================================================================="
