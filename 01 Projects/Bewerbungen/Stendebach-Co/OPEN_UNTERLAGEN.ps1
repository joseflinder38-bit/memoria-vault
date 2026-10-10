# ============================================
# STENDEBACH & CO. — BEWERBUNGS-UNTERLAGEN ÖFFNEN
# ============================================
# Verwendung: Doppelklick auf diese Datei ODER
#   powershell -ExecutionPolicy Bypass -File OPEN_UNTERLAGEN.ps1
# ============================================

# Ordner-Pfad (aktuelles Verzeichnis)
$currentDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$anschreiben = Join-Path $currentDir "Anschreiben_Stendebach_v1.html"
$lebenslauf = Join-Path $currentDir "Lebenslauf_v2.0.html"

# Chrome-Pfade (häufige Installationsorte)
$chromePaths = @(
    "C:\Program Files\Google\Chrome\Application\chrome.exe",
    "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe",
    "$env:LOCALAPPDATA\Google\Chrome\Application\chrome.exe"
)

# Chrome finden
$chromePath = $null
foreach ($path in $chromePaths) {
    if (Test-Path $path) {
        $chromePath = $path
        break
    }
}

if ($null -eq $chromePath) {
    Write-Host "❌ Chrome nicht gefunden! Öffne die Dateien manuell:" -ForegroundColor Red
    Write-Host "  - $anschreiben"
    Write-Host "  - $lebenslauf"
    exit 1
}

# Dateien öffnen
Write-Host "🚀 Öffne Bewerbungs-Unterlagen..." -ForegroundColor Green

try {
    # Anschreiben in Chrome öffnen
    & $chromePath $anschreiben
    Start-Sleep -Milliseconds 500

    # Lebenslauf in neuem Tab öffnen
    & $chromePath $lebenslauf

    Write-Host "✅ Anschreiben & Lebenslauf geöffnet!" -ForegroundColor Green
    Write-Host "   Tab 1: Anschreiben_Stendebach_v1.html" -ForegroundColor Cyan
    Write-Host "   Tab 2: Lebenslauf_v2.0.html" -ForegroundColor Cyan
}
catch {
    Write-Host "❌ Fehler beim Öffnen! Öffne manuell:" -ForegroundColor Red
    Write-Host "  - $anschreiben"
    Write-Host "  - $lebenslauf"
    exit 1
}

exit 0
