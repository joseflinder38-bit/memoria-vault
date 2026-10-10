# GIT DAILY COMMIT & PUSH SCRIPT
# For: Memoria Vault Backup to GitHub
# Schedule: Daily 21:00 (Windows Task Scheduler)

param(
    [string]$RepoPath = "C:\Users\josef\iCloudDrive\iCloud~md~obsidian\Memoria",
    [string]$LogFile = "$RepoPath\00 Inbox\GIT-BACKUP-LOG.txt"
)

# Ensure log file exists
if (!(Test-Path $LogFile)) {
    New-Item -ItemType File -Path $LogFile -Force | Out-Null
}

# Timestamp
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

# Log function
function Write-Log {
    param([string]$Message)
    $logMessage = "[$timestamp] $Message"
    Add-Content -Path $LogFile -Value $logMessage
    Write-Host $logMessage
}

Write-Log "=========================================="
Write-Log "MEMORIA GIT DAILY BACKUP STARTED"
Write-Log "=========================================="

try {
    # Change to repo directory
    Set-Location $RepoPath
    Write-Log "Working directory: $RepoPath"

    # Check git status
    $status = & git status --porcelain 2>&1

    if ($status) {
        Write-Log "Changes detected: $($status.Count) files"

        # Stage all changes
        & git add . 2>&1 | ForEach-Object { Write-Log "Add: $_" }

        # Create commit
        $commitMessage = "Daily vault backup: $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
        & git commit -m $commitMessage 2>&1 | ForEach-Object { Write-Log "Commit: $_" }

        # Push to GitHub
        Write-Log "Pushing to GitHub..."
        $pushOutput = & git push origin master 2>&1
        $pushOutput | ForEach-Object { Write-Log "Push: $_" }

        if ($LASTEXITCODE -eq 0) {
            Write-Log "[OK] BACKUP SUCCESSFUL - All changes pushed"
        } else {
            Write-Log "[FAIL] PUSH FAILED - Check GitHub credentials or connection"
        }
    } else {
        Write-Log "No changes detected - skipping commit"
    }

    Write-Log "BACKUP COMPLETED SUCCESSFULLY"
    Write-Log "=========================================="
    exit 0

} catch {
    Write-Log "[ERROR] ERROR: $_"
    Write-Log "Stack trace: $($_.ScriptStackTrace)"
    Write-Log "BACKUP FAILED"
    Write-Log "=========================================="
    exit 1
}
