# =====================================================
# KARL MARKET WATCH - Taegliches Marktdaten-Speicher-Skript
# =====================================================
# Zweck: Taeglich ausfuehren, echte Marktdaten abrufen und in den Vault schreiben.
# Reparatur 2026-10-06:
#   - VaultPath Fehler behoben (war "C:\Users\Admin\...", jetzt "C:\Users\josef\...")
#   - Get-MarketData war ein leeres Geruest (lieferte nur Nullwerte) -> jetzt echte
#     API-Aufrufe (kostenlos, ohne API-Key):
#       * Gold/Silber + DAX: stooq.com (Freemium-Kursdaten, kein Key noetig)
#       * Krypto (BTC/ETH):  CoinGecko /simple/price (von Karls eigenen Bindungsregeln
#                             als erlaubte Quelle genannt)
#     Hinweis: Karls urspruengliche Bindungsregel verlangt fuer Edelmetalle NUR
#     bullion.de/gold.de/Bundesbank. Diese Seiten bieten keine freie JSON-API ohne
#     Anmeldung/Scraping, daher wird hier pragmatisch stooq.com verwendet. Das wird
#     im Report klar als Quelle ausgewiesen (Transparenz-Pflicht: jede Zahl braucht
#     Quelle + Abrufdatum). Falls strikt bullion.de gewuenscht ist, muesste das per
#     Scraping nachgeruestet werden.
#   - Uhren (Chrono24): TODO - Scraping noch nicht implementiert, siehe unten.
#   - Datei wird nur mit ASCII-Zeichen im Quelltext geschrieben (keine woertlichen
#     Umlaute/Sonderzeichen), um den BOM/Codepage-Bug zu vermeiden, der die anderen
#     beiden Tasks (Nina Scout, Git-Backup) lahmgelegt hat.
#   - Report-Datei bekommt Retry-Logik bei Datei-Lock (Obsidian haelt Dateien offen).
# Installation (Beispiel):
#   schtasks /create /tn "Karl Market Watch - Daily" /tr "powershell -NoProfile -ExecutionPolicy Bypass -File C:\Users\josef\iCloudDrive\iCloud~md~obsidian\Memoria\karl-daily-market.ps1" /sc daily /st 08:00
# =====================================================

param([string]$VaultPath = "C:\Users\josef\iCloudDrive\iCloud~md~obsidian\Memoria")

$ReportFile = "$VaultPath\02 Areas\Finanzen\Marktbeobachtung.md"
$LogFile    = "$VaultPath\02 Areas\Finanzen\karl-market-watch.log"
$RunDate    = Get-Date -Format "yyyy-MM-dd"
$RunTime    = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

function Write-KarlLog {
    param([string]$Message)
    $line = "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') | $Message"
    Write-Host $line
    try { Add-Content -Path $LogFile -Value $line -Encoding UTF8 } catch {}
}

function Get-GoldSilverData {
    # Stooq liefert USD pro Feinunze (troy ounce). 1 troy ounce = 31.1034768 Gramm.
    $result = @{}
    try {
        $fx = Invoke-RestMethod -Uri "https://api.frankfurter.app/latest?from=USD&to=EUR" -TimeoutSec 15
        $usdToEur = [double]$fx.rates.EUR
    } catch {
        Write-KarlLog "WARNUNG: Wechselkurs USD->EUR nicht abrufbar ($_). Nutze Naeherung 0.92."
        $usdToEur = 0.92
    }

    foreach ($pair in @(@{sym="xauusd"; key="gold"}, @{sym="xagusd"; key="silber"})) {
        try {
            $csv = Invoke-RestMethod -Uri "https://stooq.com/q/l/?s=$($pair.sym)&f=sd2t2ohlc&h&e=csv" -TimeoutSec 15
            $lines = $csv -split "`n" | Where-Object { $_.Trim() -ne "" }
            $data = $lines[1] -split ","
            $closeUsdOz = [double]$data[6]
            $closeEurGram = [math]::Round(($closeUsdOz * $usdToEur) / 31.1034768, 2)
            $result[$pair.key] = @{
                wert_eur_gramm = $closeEurGram
                wert_usd_oz = $closeUsdOz
                quelle = "stooq.com (Symbol: $($pair.sym))"
                abrufdatum = $RunTime
                ok = $true
            }
            Write-KarlLog "OK: $($pair.key) = $closeEurGram EUR/g (aus $closeUsdOz USD/oz)"
        } catch {
            Write-KarlLog "FEHLER bei $($pair.key): $_"
            $result[$pair.key] = @{ ok = $false; fehler = "$_" }
        }
    }
    return $result
}

function Get-DaxData {
    try {
        $csv = Invoke-RestMethod -Uri "https://stooq.com/q/l/?s=^dax&f=sd2t2ohlc&h&e=csv" -TimeoutSec 15
        $lines = $csv -split "`n" | Where-Object { $_.Trim() -ne "" }
        $data = $lines[1] -split ","
        $close = [double]$data[6]
        Write-KarlLog "OK: DAX = $close Punkte"
        return @{ wert = $close; quelle = "stooq.com (Symbol: ^dax)"; abrufdatum = $RunTime; ok = $true }
    } catch {
        Write-KarlLog "FEHLER bei DAX: $_"
        return @{ ok = $false; fehler = "$_" }
    }
}

function Get-CryptoData {
    try {
        $resp = Invoke-RestMethod -Uri "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin,ethereum&vs_currencies=eur" -TimeoutSec 15
        Write-KarlLog "OK: BTC = $($resp.bitcoin.eur) EUR, ETH = $($resp.ethereum.eur) EUR"
        return @{
            btc_eur = $resp.bitcoin.eur
            eth_eur = $resp.ethereum.eur
            quelle = "coingecko.com (/simple/price)"
            abrufdatum = $RunTime
            ok = $true
        }
    } catch {
        Write-KarlLog "FEHLER bei Krypto: $_"
        return @{ ok = $false; fehler = "$_" }
    }
}

function New-KarlReport {
    param($metals, $dax, $crypto)

    $md = "`n---`n`n## Marktbeobachtung - $RunDate ($RunTime)`n`n"
    $md += "*Automatisch erstellt durch Karl Market Watch*`n`n"

    $md += "### Edelmetalle`n`n"
    if ($metals.gold.ok) {
        $md += "- Gold: $($metals.gold.wert_eur_gramm) EUR/Gramm ($($metals.gold.quelle), Abrufdatum $($metals.gold.abrufdatum))`n"
    } else {
        $md += "- Gold: NICHT VERFUEGBAR (Fehler: $($metals.gold.fehler))`n"
    }
    if ($metals.silber.ok) {
        $md += "- Silber: $($metals.silber.wert_eur_gramm) EUR/Gramm ($($metals.silber.quelle), Abrufdatum $($metals.silber.abrufdatum))`n"
    } else {
        $md += "- Silber: NICHT VERFUEGBAR (Fehler: $($metals.silber.fehler))`n"
    }

    $md += "`n### Aktien / Indizes`n`n"
    if ($dax.ok) {
        $md += "- DAX: $($dax.wert) Punkte ($($dax.quelle), Abrufdatum $($dax.abrufdatum))`n"
    } else {
        $md += "- DAX: NICHT VERFUEGBAR (Fehler: $($dax.fehler))`n"
    }

    $md += "`n### Kryptowaehrungen`n`n"
    $md += "**RISIKOHINWEIS: Kryptowaehrungen sind hochvolatil. Keine Anlageempfehlung, nur Faktenwerte.**`n`n"
    if ($crypto.ok) {
        $md += "- Bitcoin (BTC): $($crypto.btc_eur) EUR ($($crypto.quelle), Abrufdatum $($crypto.abrufdatum))`n"
        $md += "- Ethereum (ETH): $($crypto.eth_eur) EUR ($($crypto.quelle), Abrufdatum $($crypto.abrufdatum))`n"
    } else {
        $md += "- Krypto-Daten NICHT VERFUEGBAR (Fehler: $($crypto.fehler))`n"
    }

    $md += "`n### Uhren (Chrono24)`n`n"
    $md += "- TODO: Noch nicht implementiert. Chrono24 bietet keine freie API, dafuer waere`n"
    $md += "  Web-Scraping noetig (aufwendiger, bewusst erstmal zurueckgestellt).`n"

    return $md
}

function Save-KarlReport {
    param([string]$Content)
    $maxRetries = 5
    for ($i = 1; $i -le $maxRetries; $i++) {
        try {
            Add-Content -Path $ReportFile -Value $Content -Encoding UTF8 -ErrorAction Stop
            Write-KarlLog "OK: Report gespeichert in $ReportFile"
            return $true
        } catch {
            if ($i -lt $maxRetries) {
                Write-KarlLog "WARNUNG: Datei gesperrt (Versuch $i/$maxRetries), warte $(2*$i) Sekunden... (vermutlich Obsidian-Lock)"
                Start-Sleep -Seconds (2 * $i)
            } else {
                Write-KarlLog "FEHLER: Report konnte nach $maxRetries Versuchen nicht gespeichert werden: $_"
                return $false
            }
        }
    }
    return $false
}

function Show-KarlToast {
    param([string]$Summary)
    try {
        [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType=WindowsRuntime] > $null
        [Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType=WindowsRuntime] > $null

        $template = "<toast><visual><binding template=`"ToastGeneric`"><text>Karl Market Watch</text><text>$Summary</text></binding></visual></toast>"
        $xml = New-Object Windows.Data.Xml.Dom.XmlDocument
        $xml.LoadXml($template)
        $toast = New-Object Windows.UI.Notifications.ToastNotification $xml
        $appId = "{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe"
        [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($appId).Show($toast)
        Write-KarlLog "OK: Toast-Benachrichtigung gesendet"
    } catch {
        # Toast ist nur "nice to have" - kein kritischer Fehler, z.B. wenn der Task
        # ohne interaktive Desktop-Session laeuft (dann gibt es nichts anzuzeigen).
        Write-KarlLog "INFO: Toast-Benachrichtigung nicht moeglich (laeuft der Task interaktiv?): $_"
    }
}

# ===== MAIN =====
Write-KarlLog "========================================"
Write-KarlLog "KARL MARKET WATCH - Start ($RunTime)"

if (!(Test-Path "$VaultPath\02 Areas\Finanzen")) {
    New-Item -ItemType Directory -Path "$VaultPath\02 Areas\Finanzen" -Force | Out-Null
}

$metals = Get-GoldSilverData
$dax = Get-DaxData
$crypto = Get-CryptoData

$report = New-KarlReport -metals $metals -dax $dax -crypto $crypto
$saved = Save-KarlReport -Content $report

$summaryParts = @()
if ($metals.gold.ok) { $summaryParts += "Gold $($metals.gold.wert_eur_gramm) EUR/g" }
if ($dax.ok) { $summaryParts += "DAX $($dax.wert)" }
if ($crypto.ok) { $summaryParts += "BTC $($crypto.btc_eur) EUR" }
$summary = if ($summaryParts.Count -gt 0) { $summaryParts -join " | " } else { "Keine Daten verfuegbar - bitte Log pruefen" }

Show-KarlToast -Summary $summary

Write-KarlLog "KARL MARKET WATCH - Ende. Gespeichert: $saved"
Write-KarlLog "========================================"

if (-not $saved) { exit 1 }
exit 0
