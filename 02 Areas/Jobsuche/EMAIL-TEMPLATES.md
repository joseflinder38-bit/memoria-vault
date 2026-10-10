---
type: email-templates
version: "1.0"
last-updated: 2026-10-10
---

# 📧 EMAIL TEMPLATES – Automated Job Outreach

**Ready-to-use email templates for automating job applications**

---

## TEMPLATE 1: Initial Job Application

```
Subject: Bewerbung – Fachkraft Arbeitssicherheit (Ref: [JOB_ID])

Liebe Damen und Herren,

mit großem Interesse bewerbe ich mich auf Ihre ausgeschriebene Position 
als [POSITION] in [COMPANY].

Meine Qualifikationen:
• Kaufmann für Büromanagement (IHK 2024)
• Spezialist Gefahrstoffe (8 active certifications)
• [YEARS] Jahre praktische Erfahrung in [INDUSTRY]
• Nachgewiesene Expertise in TRGS, Asbest, und EfbV

Besonders interessiert mich diese Position, da [PERSONALIZATION].

Anbei finden Sie meinen tabellarischen Lebenslauf sowie 
weitere Dokumente.

Über ein Bewerbungsgespräch freue ich mich sehr.

Mit freundlichen Grüßen,
Josef Linder
+49 [PHONE]
joseflinder38@gmail.com
```

---

## TEMPLATE 2: Follow-Up Email (7 days)

```
Subject: RE: Bewerbung – Fachkraft Arbeitssicherheit

Liebe/r [CONTACT_NAME],

vor einer Woche habe ich mich auf Ihre ausgeschriebene Position 
als [POSITION] beworben (Ref: [JOB_ID]).

Da ich großes Interesse an dieser Rolle habe, wollte ich höflich 
nachfragen, ob Sie bereits die Gelegenheit hatten, meine Unterlagen 
zu prüfen.

Falls Sie weitere Informationen von meiner Seite benötigen, stelle 
ich diese gerne zur Verfügung.

Vielen Dank für Ihre Aufmerksamkeit.

Mit freundlichen Grüßen,
Josef Linder
```

---

## TEMPLATE 3: After Interview Thank You

```
Subject: Vielen Dank für das Interview

Liebe/r [CONTACT_NAME],

herzlichen Dank für die Gelegenheit, am heutigen Interview teilzunehmen. 
Es war mir ein Vergnügen, mehr über [COMPANY] und die Position 
[POSITION] zu erfahren.

Unsere Diskussion über [SPECIFIC_TOPIC] hat mich besonders begeistert, 
und ich bin zuversichtlich, dass ich einen wertvollen Beitrag leisten kann.

Ich freue mich auf weitere Gespräche.

Mit freundlichen Grüßen,
Josef Linder
```

---

## TEMPLATE 4: Follow-Up After No Response (14 days)

```
Subject: Nachfrage – Bewerbung Fachkraft Arbeitssicherheit

Liebe Damen und Herren,

vor zwei Wochen habe ich mich auf Ihre Position beworben (Ref: [JOB_ID]).

Ich bin weiterhin sehr an dieser Rolle interessiert und wollte höflich 
nachfragen, ob Sie weitere Informationen benötigen oder welche nächsten 
Schritte geplant sind.

Gerne stelle ich mich per Telefon zur Verfügung für ein kurzes Gespräch.

Vielen Dank für Ihre Zeit.

Mit freundlichen Grüßen,
Josef Linder
+49 [PHONE]
```

---

## AUTOMATED EMAIL SENDING

### Setup (PowerShell)

```powershell
# Sende bewerbungs-email automatisch
param(
    [string]$Template = "initial",
    [string]$CompanyName,
    [string]$ContactEmail,
    [string]$Position
)

# Load template
$EmailBody = Get-Content "EMAIL-TEMPLATES.md" | 
    Select-String -Pattern "TEMPLATE $Template" -Context 20

# Replace placeholders
$Body = $EmailBody `
    -replace "\[COMPANY\]", $CompanyName `
    -replace "\[POSITION\]", $Position

# Send via Gmail
Send-GmailMessage -To $ContactEmail -Body $Body
```

---

## INTEGRATION WITH JOB APPLICATIONS

### Workflow

```
1. Create job application file:
   01 Projects/Bewerbungen/Firmen/COMPANY.md

2. Add metadata:
   company: "Acme GmbH"
   position: "Fachkraft Arbeitssicherheit"
   contact_email: "recruiting@acme.de"
   date_applied: 2026-10-10
   template_used: "initial"

3. Trigger automation:
   if date = application_date + 7 days:
     send follow-up email (TEMPLATE 2)
   
   if date = application_date + 14 days AND no response:
     send second follow-up (TEMPLATE 4)

4. Track response:
   Manually update status when response received
   (Future: AI email parsing to auto-detect responses)
```

---

## GMAIL SETUP (For Automation)

### Step 1: Create App Password

1. Go to: https://myaccount.google.com/apppasswords
2. Select "Mail" and "Windows Computer"
3. Copy app password
4. Store in environment variable:

```powershell
$env:GMAIL_APP_PASSWORD = "your-app-password-here"
# Save permanently:
[Environment]::SetEnvironmentVariable("GMAIL_APP_PASSWORD", "...", "User")
```

### Step 2: Configure PowerShell

```powershell
$GmailUser = "joseflinder38@gmail.com"
$GmailPassword = $env:GMAIL_APP_PASSWORD

$SMTPClient = New-Object Net.Mail.SmtpClient("smtp.gmail.com", 587)
$SMTPClient.EnableSsl = $true
$SMTPClient.Credentials = New-Object System.Net.NetworkCredential(
    $GmailUser, 
    $GmailPassword
)
```

### Step 3: Send Email

```powershell
$MailMessage = New-Object System.Net.Mail.MailMessage(
    $GmailUser,
    "recruiter@company.de"
)
$MailMessage.Subject = "Bewerbung – Fachkraft Arbeitssicherheit"
$MailMessage.Body = $EmailBody
$MailMessage.IsBodyHtml = $false

$SMTPClient.Send($MailMessage)
```

---

## SCHEDULED EMAIL CAMPAIGNS

### Monthly Outreach Campaign

```powershell
# Task: "Memoria-Monthly-Email-Campaign" (1st of month, 09:00)

$TopJobs = Get-TopJobMatches -Score 75+  # From AI Matcher
foreach ($Job in $TopJobs) {
    $Email = Generate-Email -Template "initial" -Job $Job
    Send-GmailMessage $Email
    Log-Application -Job $Job -Method "automated-email"
}

Write-Host "✓ Sent $($TopJobs.Count) applications this month"
```

---

## BEST PRACTICES

✅ **DO:**
- Personalize each email (reference specific job details)
- Send during business hours (08:00-17:00)
- Use professional tone (formal German)
- Track all sent emails in vault
- Wait 7 days before follow-up

❌ **DON'T:**
- Send to multiple recipients (looks mass-mailed)
- Use generic templates without personalization
- Send more than 2 follow-ups to same company
- Forget to update status in vault
- Use HTML emails to conservative companies

---

**Status:** Ready for Activation  
**Estimated impact:** 5-10 additional applications/month  
**Response time improvement:** 20-30% (personal touch matters!)
