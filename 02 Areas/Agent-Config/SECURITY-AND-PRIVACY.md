---
type: security-guide
version: "1.0"
last-updated: 2026-10-10
---

# 🔒 SECURITY & PRIVACY GUIDE

**Protecting sensitive data in your automation system**

---

## ⚠️ CRITICAL RULES

### Rule 1: Never commit sensitive data

```
DO NOT commit:
✗ Passwords
✗ API keys
✗ GitHub Personal Access Tokens
✗ Email passwords
✗ Scan copies of IDs
✗ Bank account numbers
✗ Salary information (unless anonymized)
```

**Why:** Once in Git history, it's permanent. Even if you delete it, anyone with access to the repo can find it.

### Rule 2: Use environment variables for secrets

```powershell
# WRONG - never do this:
$Password = "MyPassword123"

# RIGHT - use environment variables:
$Password = $env:MY_SECRET_PASSWORD
```

### Rule 3: Use .gitignore to exclude sensitive folders

```
# Current .gitignore (verify it exists):
Ausweise/
Sensible Dokumente*/
*.key
*.pem
.env
```

If these don't exist, add them NOW:

```bash
echo "Ausweise/" >> .gitignore
echo "Sensible Dokumente*/" >> .gitignore
echo ".env" >> .gitignore
git add .gitignore
git commit -m "Improve security: expand .gitignore"
```

---

## 🔑 SECRETS MANAGEMENT

### Where to Store Secrets Safely

**Local system (for local scripts):**
```powershell
# Windows Credential Manager
$Credential = Get-Credential
$Cred = [System.Runtime.InteropServices.Marshal]::SecureStringToGlobalAllocAnsi($Credential.Password)
```

**For Cloud Routines (Karl, Nina, etc.):**
```
Use Claude Code's built-in "Secrets" storage
(Tools › Settings › Secrets)

Never paste into prompts!
```

**For Git:**
```
GitHub: Use Personal Access Tokens (not passwords)
Rotate tokens annually
Use "workflow" or "automation" tokens with limited scope
```

---

## 📋 DATA CLASSIFICATION

### Tier 1: Public Data
✅ Can be in Git, emails, shared
- Job titles and company names
- General market data
- Public learning resources
- Automation documentation

### Tier 2: Internal Data
⚠️ Can be in Git but not shared externally
- Job application records (anonymized)
- Personal notes and reflections
- Vault structure and organization
- Automation logs (with sensitive data removed)

### Tier 3: Sensitive Data
🔒 NEVER in Git, only local
- Full resumes with phone numbers
- Interview feedback
- Salary expectations
- Personal financial details
- Relationship information

### Tier 4: Top Secret
🛡️ Encrypted, offline backup only
- Government ID scans
- Bank account numbers
- Social security/insurance numbers
- Healthcare information

---

## 🛡️ VAULT SECURITY CHECKLIST

- [ ] `.gitignore` includes all sensitive folders
- [ ] No passwords in any files
- [ ] No API keys visible in git history
- [ ] GitHub PAT token is valid and scoped correctly
- [ ] iCloud sync is working (not creating conflicts)
- [ ] Local backup exists (external drive?)
- [ ] No "version" or "conflict" files in vault
- [ ] Audit log shows only expected commits

**Check your vault:**
```powershell
# 1. Find all sensitive patterns
Select-String -Path "**/*.md" -Pattern "password|secret|key|token|api" -Recurse

# 2. Check what's been committed
git log --name-status | head -50

# 3. Verify .gitignore
cat .gitignore

# 4. Check for untracked sensitive files
git status --ignored
```

---

## 🔐 SPECIFIC SECURITY MEASURES

### GitHub Personal Access Token

**Current Setup:**
- ✅ Token stored in Git Credential Manager
- ✅ `credential.helper=store` configured
- ✅ Token has limited scope

**To refresh:**
1. Go to: https://github.com/settings/tokens
2. Find token "Memoria Auto-Backup"
3. Click "Regenerate"
4. Update locally: `git config credential.oauth_refresh_token [new-token]`

**Annual Rotation Schedule:**
- [ ] January (refresh PAT yearly)
- [ ] Backup code if you lose token access

### iCloud Sync Security

**Risk:** Files uploaded to iCloud are encrypted but:
- Apple can theoretically access them
- Sync conflicts can expose data
- Race conditions during backup

**Mitigation:**
- Git repository is stored OUTSIDE iCloud (`C:\Users\josef\.git-data\`)
- Only `.git` reference file is in vault (tiny, no sensitive data)
- Sensitive folders explicitly excluded

---

## 📧 EMAIL SECURITY

### When sending alerts/emails:

```
DO:
✓ Use Gmail app passwords (not real password)
✓ Enable 2FA on Gmail
✓ Review email content before sending
✓ Remove PII from error messages

DON'T:
✗ Send full logs with stack traces
✗ Include file paths that reveal usernames
✗ Embed credentials in email body
```

### Current Setup:
```
Email Service: Gmail
Authentication: App Password (limited scope)
Sensitive Data: None in templates (yet)
```

**To configure Gmail safely:**
1. Enable 2FA: https://myaccount.google.com/
2. Create app password: https://myaccount.google.com/apppasswords
3. Copy password to `.env` (never in script!)
4. Use in PowerShell: `$Env:GMAIL_APP_PASSWORD`

---

## 🔍 AUDIT & MONITORING

### Weekly Security Check

```powershell
# 1. Check recent commits for sensitive data
git log --patch --oneline -10 | Select-String -Pattern "password|secret|key"

# 2. Check .gitignore is up to date
cat .gitignore | Select-String "Ausweise|Sensible"

# 3. Verify no new sensitive files added
git status --short | Select-String "?? "

# 4. Check last modified time on sensitive folders
Get-ChildItem "Ausweise" | Select-Object Name, LastWriteTime
```

### Monthly Audit

- [ ] Review git log for unexpected commits
- [ ] Verify GitHub PAT is still valid
- [ ] Check for any "conflict" files
- [ ] Confirm sensitive folders are still excluded
- [ ] Verify iCloud sync is healthy

---

## 🆘 INCIDENT RESPONSE

### If you accidentally commit sensitive data:

**IMMEDIATELY:**
1. Stop! Don't push to GitHub
2. Use BFG Repo-Cleaner or git-filter-branch to remove
3. Force-push to GitHub (this rewrites history)
4. Notify anyone who pulled the code
5. Rotate any exposed credentials

**Command (if local only):**
```powershell
# Remove file from all git history
git filter-branch --tree-filter 'rm -f [sensitive-file]' HEAD
git push --force-with-lease
```

### If GitHub PAT is compromised:

**IMMEDIATELY:**
1. Regenerate token at https://github.com/settings/tokens
2. Update local git config
3. Update any automation that uses it
4. Check GitHub logs for suspicious activity

---

## 📚 ENCRYPTION GUIDELINES

### For sensitive documents locally:

```powershell
# Encrypt a folder with Windows BitLocker
Enable-BitLocker -MountPoint "D:" -EncryptionMethod Aes256

# Or use 7-Zip with password:
7z a -tzip -p[password] "backup.zip" "sensitive_folder"
```

### For backups:

```
✓ External drive: Encrypted (BitLocker/FileVault)
✓ Cloud backup: Use Zero-Knowledge service (Proton, Tresorit)
✓ Git backups: Public GitHub OK (no sensitive data)
```

---

## 🎓 SECURITY BEST PRACTICES (2026 Standard)

| Practice | Status | Action |
|----------|--------|--------|
| No secrets in git | ✅ Compliant | - |
| Credentials in env vars | ✅ Ready | Implement when needed |
| .gitignore configured | ✅ Done | Review monthly |
| GitHub PAT rotated | ⏳ Due Jan 2027 | Set calendar reminder |
| Backups encrypted | ⏳ Pending | Use external drive |
| 2FA on GitHub | ⏳ Pending | Enable now |
| 2FA on Gmail | ⏳ Pending | Enable now |

---

## 📋 COMPLIANCE CHECKLIST

For privacy compliance (GDPR-adjacent):

- [ ] Personal data is not shared externally
- [ ] Automation doesn't leak data in logs
- [ ] Vault backups are encrypted
- [ ] Old data can be deleted (right to be forgotten)
- [ ] Audit trail exists (git log)
- [ ] Sensitive access is controlled

---

## 🔗 USEFUL LINKS

**Security Tools:**
- [BFG Repo-Cleaner](https://rtyley.github.io/bfg-repo-cleaner/) - Remove secrets from git
- [git-secrets](https://github.com/awslabs/git-secrets) - Prevent commits of secrets
- [OWASP Secrets Management](https://cheatsheetseries.owasp.org/cheatsheets/Secrets_Management_Cheat_Sheet.html)

**GitHub Security:**
- [GitHub Security Best Practices](https://docs.github.com/en/code-security)
- [Creating Personal Access Tokens](https://docs.github.com/en/github/authenticating-to-github/managing-your-personal-access-tokens)

---

**Last Reviewed:** 2026-10-10  
**Next Review:** 2026-10-17  
**Risk Level:** LOW (currently compliant)  
**Maintenance:** Monthly audit required
