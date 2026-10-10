# ============================================================================
# URGO BEWERBUNGS-UNTERLAGEN — AUTO-OPEN IN CHROME
# ============================================================================
# Dieses Script öffnet Lebenslauf + Anschreiben automatisch in Chrome
# Nutzung: Doppelklick auf diese Datei oder: powershell -ExecutionPolicy Bypass -File OPEN_UNDERLAGEN.ps1
# ============================================================================

# Chrome-Pfad
$chromePath = "C:\Program Files\Google\Chrome\Application\chrome.exe"

# Vault-Pfad
$vaultPath = "C:\Users\Admin\iCloudDrive\iCloud~md~obsidian\Memoria\01 Projects\Bewerbungen\Urgo"

# Dateien
$lebenslauf = "$vaultPath\Lebenslauf_v2.0.html"
$anschreiben = "$vaultPath\Anschreiben_Urgo_v1.html"

# Prüfe, ob Dateien existieren
if (!(Test-Path $lebenslauf)) {
    Write-Host "❌ FEHLER: Lebenslauf nicht gefunden: $lebenslauf" -ForegroundColor Red
    exit 1
}

if (!(Test-Path $anschreiben)) {
    Write-Host "❌ FEHLER: Anschreiben nicht gefunden: $anschreiben" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║  🚀 URGO BEWERBUNGS-UNTERLAGEN - ÖFFNE IN CHROME             ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# Öffne Lebenslauf in Chrome
Write-Host "📄 Öffne Lebenslauf v2.0..." -ForegroundColor Green
$lebenslaufUrl = "file:///$($lebenslauf.Replace('\', '/'))"
& $chromePath $lebenslaufUrl

# Warte 2 Sekunden
Start-Sleep -Seconds 2

# Öffne Anschreiben in Chrome
Write-Host "📝 Öffne Anschreiben (Vertriebsmitarbeiter Neuwied)..." -ForegroundColor Green
$anschreibenUrl = "file:///$($anschreiben.Replace('\', '/'))"
& $chromePath $anschreibenUrl

Write-Host ""
Write-Host "✅ UNTERLAGEN GEÖFFNET!" -ForegroundColor Green
Write-Host ""
Write-Host "📋 DEINE UNTERLAGEN:" -ForegroundColor Cyan
Write-Host "  Tab 1: Lebenslauf v2.0 (Optimiert - Projektleiter Profil)" -ForegroundColor White
Write-Host "  Tab 2: Anschreiben (Vertriebsmitarbeiter - Neuwied Region)" -ForegroundColor White
Write-Host ""
Write-Host "💾 ZUM SPEICHERN ALS PDF:" -ForegroundColor Yellow
Write-Host "  1. In Chrome: Ctrl + P drücken" -ForegroundColor White
Write-Host "  2. 'Als PDF speichern' wählen" -ForegroundColor White
Write-Host "  3. Speichern unter: Urgo/PDFs/" -ForegroundColor White
Write-Host ""
Write-Host "📊 INFO:" -ForegroundColor Cyan
Write-Host "  Firma: Urgo GmbH" -ForegroundColor White
Write-Host "  Position: Vertriebsmitarbeiter (m/w/d)" -ForegroundColor White
Write-Host "  Region: Neuwied (20km von dir entfernt!)" -ForegroundColor White
Write-Host "  Match-Score: 78%" -ForegroundColor White
Write-Host "  Erstellt: 2026-07-10" -ForegroundColor White
Write-Host ""
Write-Host "🚀 Viel Erfolg bei der Bewerbung!" -ForegroundColor Cyan
Write-Host ""
