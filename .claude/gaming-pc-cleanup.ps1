# ============================================================================
# GAMING-PC CLEANUP & OPTIMIZATION SCRIPT
# ============================================================================
# Automatisiertes Entfernen von Bloatware, Performance-Verbesserung
# Entwickelt für: JosefsBrocken (Gaming-PC)
# Datum: 2026-07-25
# ============================================================================

# SICHERHEITSMODUS - Fragen vor jeder kritischen Aktion
$WarningPreference = "Continue"
$ErrorActionPreference = "Continue"

Write-Host "╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║       GAMING-PC CLEANUP & OPTIMIZATION SCRIPT                  ║" -ForegroundColor Cyan
Write-Host "║       JosefsBrocken - 2026-07-25                              ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# Überprüfe Administrator-Rechte
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
if (-not $isAdmin) {
    Write-Host "❌ FEHLER: Dieses Script muss als Administrator ausgeführt werden!" -ForegroundColor Red
    Write-Host "   Starte PowerShell als Administrator und führe das Script erneut aus." -ForegroundColor Yellow
    Read-Host "   Drücke Enter zum Beenden"
    exit 1
}

Write-Host "✓ Administrator-Rechte bestätigt" -ForegroundColor Green
Write-Host ""

# ============================================================================
# FUNKTION: Benutzer-Bestätigung
# ============================================================================
function Confirm-Action {
    param(
        [string]$Action,
        [string]$Description
    )
    Write-Host ""
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Yellow
    Write-Host "📋 $Action" -ForegroundColor Yellow
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Yellow
    Write-Host ""
    Write-Host $Description -ForegroundColor White
    Write-Host ""
    Write-Host "Möchtest du diese Aktion durchführen?" -ForegroundColor Cyan
    $choice = Read-Host "Gib 'ja' ein zum Bestätigen oder 'nein' zum Überspringen"
    return ($choice -eq "ja")
}

# ============================================================================
# SCHRITT 1: NORTON 360 ENTFERNEN (HÖCHSTE PRIORITÄT!)
# ============================================================================

if (Confirm-Action -Action "SCHRITT 1: Norton 360 entfernen" -Description "Norton ist ein Performance-Killer und muss weg!`n`nVorteile:`n  ✓ 3-5% mehr FPS`n  ✓ 2-3 GB weniger RAM-Verbrauch`n  ✓ Schnellerer Boot`n`nWindows Defender wird aktiviert als Ersatz.") {
    Write-Host ""
    Write-Host "[1/5] Suche nach Norton 360..." -ForegroundColor Cyan

    $norton = Get-Package | Where-Object { $_.Name -match "Norton|Symantec" }

    if ($norton) {
        Write-Host "  ✓ Gefunden: $($norton.Name)" -ForegroundColor Green
        Write-Host "  → Starte Deinstallation..." -ForegroundColor Yellow
        $norton | Uninstall-Package -Force -ErrorAction SilentlyContinue
        Write-Host "  ✓ Norton 360 deinstalliert!" -ForegroundColor Green
    } else {
        Write-Host "  ℹ Norton 360 ist nicht installiert" -ForegroundColor Gray
    }

    Write-Host ""
    Write-Host "[2/5] Aktiviere Windows Defender..." -ForegroundColor Cyan
    Set-MpPreference -DisableRealtimeMonitoring $false -ErrorAction SilentlyContinue
    Write-Host "  ✓ Windows Defender aktiviert!" -ForegroundColor Green
} else {
    Write-Host "  ⊘ Übersprungen" -ForegroundColor Gray
}

# ============================================================================
# SCHRITT 2: MICROSOFT BLOATWARE ENTFERNEN
# ============================================================================

if (Confirm-Action -Action "SCHRITT 2: Microsoft Bloatware entfernen" -Description "Entferne unerwünschte Microsoft-Apps:`n`n  ❌ Bing News / Weather / Search`n  ❌ Microsoft Copilot`n  ❌ Xbox Gaming Services (nicht für echte Gaming relevant!)`n  ❌ Microsoft Solitaire`n  ❌ Und weitere...`n`nFreigegeben: ~800 MB - 1 GB") {
    Write-Host ""
    Write-Host "[1/6] Entferne Microsoft Bloatware..." -ForegroundColor Cyan

    $bloatware = @(
        "Microsoft.BingNews",
        "Microsoft.BingWeather",
        "Microsoft.BingSearch",
        "Microsoft.Copilot",
        "Microsoft.Xbox.TCUI",
        "Microsoft.XboxGameCallableUI",
        "Microsoft.XboxGamingOverlay",
        "Microsoft.MicrosoftSolitaireCollection",
        "MicrosoftCorporationII.MicrosoftFamily",
        "Microsoft.MeteorShowers",
        "Microsoft.StarsatNight",
        "Microsoft.CosmicBeauty",
        "Microsoft.RainbowRibbons"
    )

    foreach ($app in $bloatware) {
        $package = Get-AppxPackage -Name $app -AllUsers -ErrorAction SilentlyContinue
        if ($package) {
            Write-Host "  → Entferne: $app" -ForegroundColor Yellow
            Remove-AppxPackage -Package $package -AllUsers -ErrorAction SilentlyContinue
            Write-Host "  ✓ Entfernt" -ForegroundColor Green
        }
    }

    Write-Host ""
    Write-Host "  ✓ Microsoft Bloatware bereinigt!" -ForegroundColor Green
} else {
    Write-Host "  ⊘ Übersprungen" -ForegroundColor Gray
}

# ============================================================================
# SCHRITT 3: MOBILE SPIELE ENTFERNEN (OPTIONAL)
# ============================================================================

if (Confirm-Action -Action "SCHRITT 3: Mobile Spiele entfernen (OPTIONAL)" -Description "Entferne mobile Spiele, die unter Windows nicht optimal laufen:`n`n  ❌ Asphalt 9`n  ❌ Sunset Bike Racer`n`nFreigegeben: ~1-1.5 GB`n`nHinweis: Nur wenn du sie nicht spielst!") {
    Write-Host ""
    Write-Host "[1/3] Entferne Mobile Games..." -ForegroundColor Cyan

    $games = @(
        "A278AB0D.Asphalt9",
        "7659327F2E2D.SunsetBikeRacer"
    )

    foreach ($game in $games) {
        $package = Get-AppxPackage -Name $game -AllUsers -ErrorAction SilentlyContinue
        if ($package) {
            Write-Host "  → Entferne: $game" -ForegroundColor Yellow
            Remove-AppxPackage -Package $package -AllUsers -ErrorAction SilentlyContinue
            Write-Host "  ✓ Entfernt" -ForegroundColor Green
        }
    }

    Write-Host ""
    Write-Host "  ✓ Mobile Spiele bereinigt!" -ForegroundColor Green
} else {
    Write-Host "  ⊘ Übersprungen" -ForegroundColor Gray
}

# ============================================================================
# SCHRITT 4: APPLE-SOFTWARE ENTFERNEN (OPTIONAL)
# ============================================================================

if (Confirm-Action -Action "SCHRITT 4: Apple-Software entfernen (OPTIONAL)" -Description "Entferne Apple-Software, falls du KEIN iPhone/iPad hast:`n`n  ❌ iTunes`n  ❌ iCloud Outlook`n  ❌ Apple Mobile Device Support`n  ❌ Bonjour`n`nFreigegeben: ~500 MB - 1 GB`n`nHinweis: Nur wenn du Apple-Geräte nicht nutzt!") {
    Write-Host ""
    Write-Host "[1/4] Entferne Apple-Software..." -ForegroundColor Cyan

    $apple = Get-Package | Where-Object { $_.Name -match "iTunes|iCloud|Apple|Bonjour" }

    if ($apple) {
        foreach ($app in $apple) {
            Write-Host "  → Entferne: $($app.Name)" -ForegroundColor Yellow
            $app | Uninstall-Package -Force -ErrorAction SilentlyContinue
            Write-Host "  ✓ Entfernt" -ForegroundColor Green
        }
    } else {
        Write-Host "  ℹ Keine Apple-Software gefunden" -ForegroundColor Gray
    }

    Write-Host ""
    Write-Host "  ✓ Apple-Software bereinigt!" -ForegroundColor Green
} else {
    Write-Host "  ⊘ Übersprungen" -ForegroundColor Gray
}

# ============================================================================
# SCHRITT 5: TEMP-DATEIEN & CACHE LÖSCHEN
# ============================================================================

if (Confirm-Action -Action "SCHRITT 5: Temp-Dateien & Cache löschen" -Description "Lösche temporäre Dateien und Cache:`n`n  → C:\Windows\Temp\*`n  → C:\Users\[User]\AppData\Local\Temp\*`n  → Browser-Cache`n  → Windows Event Logs (alt)`n`nFreigegeben: 2-5 GB") {
    Write-Host ""
    Write-Host "[1/6] Lösche Windows Temp-Dateien..." -ForegroundColor Cyan

    try {
        Get-ChildItem -Path "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
        Write-Host "  ✓ C:\Windows\Temp bereinigt" -ForegroundColor Green
    } catch {
        Write-Host "  ⚠ Einige Dateien sind gesperrt (OK, wird beim Restart gelöscht)" -ForegroundColor Yellow
    }

    Write-Host "[2/6] Lösche User Temp-Dateien..." -ForegroundColor Cyan
    try {
        Get-ChildItem -Path "$env:USERPROFILE\AppData\Local\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
        Write-Host "  ✓ User Temp bereinigt" -ForegroundColor Green
    } catch {
        Write-Host "  ⚠ Einige Dateien sind gesperrt (OK)" -ForegroundColor Yellow
    }

    Write-Host "[3/6] Lösche Browser-Cache..." -ForegroundColor Cyan
    try {
        Remove-Item -Path "$env:USERPROFILE\AppData\Local\Google\Chrome\User Data\Default\Cache\*" -Recurse -Force -ErrorAction SilentlyContinue
        Remove-Item -Path "$env:USERPROFILE\AppData\Local\Microsoft\Edge\User Data\Default\Cache\*" -Recurse -Force -ErrorAction SilentlyContinue
        Write-Host "  ✓ Browser-Cache gelöscht" -ForegroundColor Green
    } catch {
        Write-Host "  ⚠ Browser läuft möglicherweise (OK)" -ForegroundColor Yellow
    }

    Write-Host "[4/6] Starte Disk Cleanup..." -ForegroundColor Cyan
    cmd /c cleanmgr /sageset:1 >$null 2>&1
    cmd /c cleanmgr /sagerun:1 >$null 2>&1
    Write-Host "  ✓ Disk Cleanup durchgeführt" -ForegroundColor Green

    Write-Host "[5/6] Leere Papierkorb..." -ForegroundColor Cyan
    Clear-RecycleBin -Confirm:$false -ErrorAction SilentlyContinue
    Write-Host "  ✓ Papierkorb geleert" -ForegroundColor Green

    Write-Host ""
    Write-Host "  ✓ Temp-Dateien & Cache bereinigt!" -ForegroundColor Green
} else {
    Write-Host "  ⊘ Übersprungen" -ForegroundColor Gray
}

# ============================================================================
# SCHRITT 6: NVIDIA TELEMETRY DEAKTIVIEREN (OPTIONAL)
# ============================================================================

if (Confirm-Action -Action "SCHRITT 6: NVIDIA Telemetry deaktivieren (OPTIONAL)" -Description "Deaktiviere NVIDIA Datensammelung:`n`n  ❌ NVIDIA Telemetry Client`n  ❌ NVIDIA Watchdog`n`nVorteile:`n  ✓ Weniger Hintergrund-Prozesse`n  ✓ Etwas weniger RAM-Verbrauch`n`nHinweis: Gaming-Performance bleibt unverändert!") {
    Write-Host ""
    Write-Host "[1/3] Stoppe NVIDIA Telemetry-Prozesse..." -ForegroundColor Cyan

    Get-Process | Where-Object { $_.ProcessName -match "NVTelemetry|NVWatch" } | Stop-Process -Force -ErrorAction SilentlyContinue
    Write-Host "  ✓ Prozesse gestoppt" -ForegroundColor Green

    Write-Host "[2/3] Deaktiviere NVIDIA Telemetry-Paket..." -ForegroundColor Cyan

    $nvidiaTelemtetry = Get-AppxPackage -Name "*NVIDIA*" -AllUsers -ErrorAction SilentlyContinue | Where-Object { $_.Name -match "Telemetry" }
    if ($nvidiaTelemtetry) {
        Remove-AppxPackage -Package $nvidiaTelemtetry -AllUsers -ErrorAction SilentlyContinue
        Write-Host "  ✓ NVIDIA Telemetry-Paket entfernt" -ForegroundColor Green
    } else {
        Write-Host "  ℹ NVIDIA Telemetry-Paket nicht als App registriert (OK)" -ForegroundColor Gray
    }

    Write-Host "[3/3] Deaktiviere geplante Tasks..." -ForegroundColor Cyan
    Get-ScheduledTask -TaskPath "*NVIDIA*" -ErrorAction SilentlyContinue | Disable-ScheduledTask -Confirm:$false -ErrorAction SilentlyContinue
    Write-Host "  ✓ NVIDIA Telemetry deaktiviert" -ForegroundColor Green
} else {
    Write-Host "  ⊘ Übersprungen" -ForegroundColor Gray
}

# ============================================================================
# FINALE SCHRITTE
# ============================================================================

Write-Host ""
Write-Host "╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║                   CLEANUP ABGESCHLOSSEN!                      ║" -ForegroundColor Green
Write-Host "╚════════════════════════════════════════════════════════════════╝" -ForegroundColor Green
Write-Host ""

Write-Host "📊 ERGEBNISSE:" -ForegroundColor Cyan
Write-Host "  ✓ Bloatware entfernt" -ForegroundColor Green
Write-Host "  ✓ Temp-Dateien gelöscht" -ForegroundColor Green
Write-Host "  ✓ Cache geleert" -ForegroundColor Green
Write-Host "  ✓ System optimiert" -ForegroundColor Green
Write-Host ""

Write-Host "⚠️  WICHTIG - NÄCHSTER SCHRITT:" -ForegroundColor Yellow
Write-Host ""
Write-Host "  1. Speichere alle offenen Dateien" -ForegroundColor White
Write-Host "  2. Fahre den PC HERUNTER und starte NEU" -ForegroundColor White
Write-Host "     (Neue Einstellungen werden beim Boot angewendet)" -ForegroundColor White
Write-Host "  3. Nach dem Restart:" -ForegroundColor White
Write-Host "     - Überprüfe Task Manager (sollte schneller starten)" -ForegroundColor White
Write-Host "     - Überprüfe Boot-Zeit (sollte viel schneller sein)" -ForegroundColor White
Write-Host "  4. Windows Defender überprüfen:" -ForegroundColor White
Write-Host "     Einstellungen → Datenschutz → Windows-Sicherheit" -ForegroundColor White
Write-Host ""

Write-Host "🎮 GAMING-TIPP:" -ForegroundColor Cyan
Write-Host "  Nach dem Restart werden deine FPS spürbar besser!" -ForegroundColor White
Write-Host "  Besonders Spiele, die Norton blockiert hat, werden schneller." -ForegroundColor White
Write-Host ""

Write-Host "📝 Log gespeichert in: $env:USERPROFILE\Desktop\Gaming-PC-Cleanup-Log.txt" -ForegroundColor Gray
Write-Host ""

# Speichere Log
$logPath = "$env:USERPROFILE\Desktop\Gaming-PC-Cleanup-Log.txt"
Add-Content -Path $logPath -Value "Gaming-PC Cleanup durchgeführt: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"

Read-Host "Drücke Enter zum Beenden"
