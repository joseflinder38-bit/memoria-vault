# ============================================
# KLINIKUM KOBLENZ-MONTABAUR — BEWERBUNGS-UNTERLAGEN ÖFFNEN
# ============================================
# Verwendung: Doppelklick auf diese Datei ODER
#   powershell -ExecutionPolicy Bypass -File OPEN_UNTERLAGEN.ps1
# ============================================

$currentDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$anschreiben = Join-Path $currentDir "Anschreiben_Klinikum_v1.html"
$lebenslauf = Join-Path $currentDir "Lebenslauf_v2.0.html"

$chromePaths = @(
    "C:\Program Files\Google\Chrome\Application\chrome.exe",
    "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe",
    "$env:LOCALAPPDATA\Google\Chrome\Application\chrome.exe"
)

$chromePath = $null
foreach ($path in $chromePaths) {
    if (Test-Path $path) {
        $chromePath = $path
        break
    }
}

if ($null -eq $chromePath) {
    Write-Host "❌ Chrome nicht gefunden!" -ForegroundColor Red
    exit 1
}

Write-Host "🏥 Klinikum Bewerbungs-Unterlagen öffnen..." -ForegroundColor Green

try {
    & $chromePath $anschreiben
    Start-Sleep -Milliseconds 500
    & $chromePath $lebenslauf

    Write-Host "✅ Anschreiben & Lebenslauf geöffnet!" -ForegroundColor Green
    Write-Host "   Tab 1: Anschreiben_Klinikum_v1.html" -ForegroundColor Cyan
    Write-Host "   Tab 2: Lebenslauf_v2.0.html" -ForegroundColor Cyan
}
catch {
    Write-Host "❌ Fehler!" -ForegroundColor Red
    exit 1
}

exit 0
