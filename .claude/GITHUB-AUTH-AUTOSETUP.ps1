# GITHUB AUTHENTICATION AUTO-SETUP
# Ein-Klick Solution für Git SSH + GitHub Integration
# Ausführen mit: powershell -ExecutionPolicy Bypass -File "GITHUB-AUTH-AUTOSETUP.ps1"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "MEMORIA VAULT - GITHUB AUTH AUTO-SETUP" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# Colors
$success = "Green"
$error = "Red"
$warning = "Yellow"
$info = "Cyan"

# Paths
$sshDir = "C:\Users\josef\.ssh"
$privateKey = "$sshDir\id_rsa"
$publicKey = "$sshDir\id_rsa.pub"
$logFile = "C:\Users\josef\iCloudDrive\iCloud~md~obsidian\Memoria\00 Inbox\GITHUB-SETUP-LOG.txt"

# Initialize log
"[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] GitHub Auth Auto-Setup STARTED" | Add-Content $logFile

function Log {
    param([string]$message)
    "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] $message" | Add-Content $logFile
    Write-Host $message
}

try {
    # STEP 1: Create SSH directory
    Write-Host "`n[STEP 1/4] Creating SSH directory..." -ForegroundColor $info
    if (!(Test-Path $sshDir)) {
        New-Item -ItemType Directory -Path $sshDir -Force | Out-Null
        Log "SSH directory created: $sshDir"
        Write-Host "✓ SSH directory created" -ForegroundColor $success
    } else {
        Log "SSH directory already exists: $sshDir"
        Write-Host "✓ SSH directory exists" -ForegroundColor $success
    }

    # STEP 2: Generate SSH key (if not exists)
    Write-Host "`n[STEP 2/4] Generating SSH key..." -ForegroundColor $info
    if (Test-Path $privateKey) {
        Log "SSH key already exists, skipping generation"
        Write-Host "✓ SSH key already exists (skipping generation)" -ForegroundColor $warning
    } else {
        Write-Host "Generating new SSH key (no passphrase for automation)..."
        # Use cmd instead of powershell for ssh-keygen compatibility
        cmd /c "ssh-keygen.exe -t rsa -b 4096 -f `"$privateKey`" -N `"`" -C `"memoria-vault-backup`""

        if (Test-Path $privateKey) {
            Log "SSH key generated successfully"
            Write-Host "✓ SSH key generated" -ForegroundColor $success
        } else {
            throw "SSH key generation failed"
        }
    }

    # STEP 3: Display public key
    Write-Host "`n[STEP 3/4] Retrieving public key..." -ForegroundColor $info
    if (Test-Path $publicKey) {
        $pubKeyContent = Get-Content $publicKey
        Log "Public key retrieved successfully"
        Write-Host "✓ Public key retrieved" -ForegroundColor $success

        Write-Host "`n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor $info
        Write-Host "COPY THIS PUBLIC KEY TO GITHUB:" -ForegroundColor $warning
        Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor $info
        Write-Host $pubKeyContent -ForegroundColor $warning
        Write-Host "`n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor $info

        # Copy to clipboard
        $pubKeyContent | Set-Clipboard
        Write-Host "✓ Public key copied to clipboard!" -ForegroundColor $success
        Log "Public key copied to clipboard"
    } else {
        throw "Public key file not found"
    }

    # STEP 4: Configure Git to use SSH
    Write-Host "`n[STEP 4/4] Configuring Git to use SSH..." -ForegroundColor $info

    # Change to repo directory
    cd "C:\Users\josef\iCloudDrive\iCloud~md~obsidian\Memoria"

    # Update Git remote to SSH
    git remote set-url origin "git@github.com:joseflinder38-bit/memoria-vault.git"

    # Verify
    $remoteCheck = git remote -v
    Log "Git remote updated to SSH: $remoteCheck"
    Write-Host "✓ Git remote updated to SSH" -ForegroundColor $success
    Write-Host "`nCurrent Git remote:" -ForegroundColor $info
    Write-Host $remoteCheck

    # FINAL: Instructions
    Write-Host "`n========================================" -ForegroundColor $success
    Write-Host "NEXT STEPS - COMPLETE THESE ON GitHub:" -ForegroundColor $warning
    Write-Host "========================================`n" -ForegroundColor $success

    Write-Host "1. Open GitHub: https://github.com/settings/keys" -ForegroundColor $info
    Write-Host "2. Click 'New SSH key'" -ForegroundColor $info
    Write-Host "3. Title: 'Memoria Vault - Josef'" -ForegroundColor $info
    Write-Host "4. Paste the PUBLIC KEY (already in clipboard!)" -ForegroundColor $warning
    Write-Host "5. Click 'Add SSH key'" -ForegroundColor $info
    Write-Host "`n6. Then test with: git push origin master" -ForegroundColor $info
    Write-Host "   (This should work WITHOUT asking for password!)" -ForegroundColor $success

    Write-Host "`n========================================" -ForegroundColor $success
    Write-Host "SSH KEY DETAILS:" -ForegroundColor $success
    Write-Host "========================================`n" -ForegroundColor $success
    Write-Host "Private Key: $privateKey" -ForegroundColor $info
    Write-Host "Public Key:  $publicKey" -ForegroundColor $info
    Write-Host "Repository:  git@github.com:joseflinder38-bit/memoria-vault.git" -ForegroundColor $info

    Log "GitHub Auth Auto-Setup COMPLETED SUCCESSFULLY"
    Write-Host "`n✓ Setup complete! Check GitHub to add the SSH key." -ForegroundColor $success

    # Pause
    Read-Host "`nPress Enter to finish"

} catch {
    $errorMsg = "ERROR: $($_.Exception.Message)"
    Log $errorMsg
    Write-Host "`n$errorMsg" -ForegroundColor $error
    Write-Host "Log file: $logFile" -ForegroundColor $warning
    Read-Host "Press Enter to exit"
    exit 1
}
