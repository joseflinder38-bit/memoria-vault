# Git Daily Push Script für Memoria Vault
# Zweck: Täglich den Vault zu GitHub pushen
# Zeitplan: Täglich 20:00 Uhr (nach Tagesende)

param([string]$VaultPath = "C:\Users\Admin\iCloudDrive\iCloud~md~obsidian\Memoria")

Write-Host "════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "🚀 Git Daily Push - $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" -ForegroundColor Cyan
Write-Host "════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""

# Navigiere zum Vault
Set-Location $VaultPath
Write-Host "📁 Vault-Pfad: $VaultPath"
Write-Host ""

try {
    # Schritt 1: Status überprüfen
    Write-Host "1️⃣ Git-Status überprüfen..." -ForegroundColor Yellow
    $status = git status --short

    if ($status) {
        Write-Host "   ✅ Änderungen gefunden:"
        $status | ForEach-Object { Write-Host "      $_" }
    } else {
        Write-Host "   ℹ️ Keine Änderungen vorhanden"
        exit 0
    }

    Write-Host ""

    # Schritt 2: Alle Änderungen hinzufügen
    Write-Host "2️⃣ Änderungen zu Git hinzufügen..." -ForegroundColor Yellow
    git add .
    Write-Host "   ✅ Fertig"

    Write-Host ""

    # Schritt 3: Commit
    Write-Host "3️⃣ Commit erstellen..." -ForegroundColor Yellow
    $commitMsg = "Auto-Push: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
    git commit -m "$commitMsg"
    Write-Host "   ✅ Fertig: $commitMsg"

    Write-Host ""

    # Schritt 4: Zu GitHub pushen
    Write-Host "4️⃣ Zu GitHub pushen..." -ForegroundColor Yellow
    git push origin main
    Write-Host "   ✅ Erfolgreich zu GitHub gepusht!"

    Write-Host ""
    Write-Host "════════════════════════════════════════" -ForegroundColor Green
    Write-Host "✅ PUSH ERFOLGREICH!" -ForegroundColor Green
    Write-Host "════════════════════════════════════════" -ForegroundColor Green
    Write-Host "Zeitstempel: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" -ForegroundColor Green

} catch {
    Write-Host ""
    Write-Host "════════════════════════════════════════" -ForegroundColor Red
    Write-Host "❌ FEHLER beim Git-Push!" -ForegroundColor Red
    Write-Host "════════════════════════════════════════" -ForegroundColor Red
    Write-Host "Fehler: $_" -ForegroundColor Red
    exit 1
}
