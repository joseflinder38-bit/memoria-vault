---
type: projekt
status: konzept
created: 2026-07-10
deadline: 2026-08-31
ziel: MVP des Betriebsanweisungs-Generators für KMUs
nächster-schritt: Business Canvas + Prototype
letztes-update: 2026-07-10
---

# 📋 BETRIEBSANWEISUNGS-GENERATOR – PROJEKT-PLAN

**Status:** 🟡 Konzept-Phase  
**Erstellt:** 2026-07-10  
**Ziel:** SaaS-Lösung für Handwerksbetriebe zur automatischen Betriebsanweisungs-Generierung

---

## 🎯 EXECUTIVE SUMMARY

**Problem:** KMUs (10-100 Mitarbeiter) haben KEINE digitale Lösung für Betriebsanweisungen  
**Lösung:** AI-gestützter Generator basierend auf TRGS-Vorlagen  
**Zielmarkt:** 500.000+ KMUs in Deutschland  
**Monetisierung:** €49-299/Monat (Subscription)  
**MVP-Aufwand:** 4-6 Wochen  
**Geschätzter Revenue (Year 1):** €54k+ (nach Kosten)

---

## 💡 FEATURES (MVP)

### **User Journey:**

```
1. Nutzer loggt sich ein
   ↓
2. Beantwortet Fragen:
   - "Welche Branche?" (Dropdown: Metallverarbeitung, Lackierung, Chemie, etc.)
   - "Welche Tätigkeit?" (Schweißen, Schleifen, Lackieren, etc.)
   - "Welche Gefahrstoffe?" (Multi-Select: Lösungsmittel, Säuren, etc.)
   - "Mitarbeiterzahl?" (Für PSA-Empfehlungen)
   ↓
3. AI generiert automatisch:
   - Betriebsanweisung (basierend auf Josef's 12 Vorlagen)
   - Sicherheitsdatenblatt-Auszug
   - PSA-Empfehlungen
   - Erste-Hilfe-Maßnahmen
   - Notfallkontakte
   ↓
4. Nutzer editiert (optional):
   - Text anpassen
   - Logos/Branding einfügen
   - Unterschrift-Felder
   ↓
5. Export & Speichern:
   - PDF (druckbar, TRGS-konform)
   - Word-Doc (editierbar)
   - Cloud-Archiv (Versionierung)
```

---

## 🏗️ MVP-ROADMAP (4-6 Wochen)

### **Woche 1-2: Setup & AI-Integration**
- [ ] Tech-Stack aufsetzen (React + Node.js + PostgreSQL)
- [ ] OpenAI GPT-4 API integrieren
- [ ] Basis-Prompts schreiben (Josef's Vorlagen als System-Prompts)
- [ ] User-Auth (Firebase) einrichten
- **Deliverable:** AI kann auf Anfrage Betriebsanweisungen generieren

### **Woche 3: Backend & Datenbank**
- [ ] User-Management (Registrierung, Login, Profile)
- [ ] Datenbankschema (Users, Betriebsanweisungen, Vorlagen)
- [ ] API-Endpoints (Generate, Save, List, Delete)
- [ ] Speicher-Logik (Cloud + Versionierung)
- **Deliverable:** API funktioniert end-to-end

### **Woche 4: Frontend (UI/UX)**
- [ ] Questions-Form (Branche, Tätigkeit, Gefahrstoffe, etc.)
- [ ] Live-Preview (Generierte Anweisung in Echtzeit)
- [ ] Editor (Text editierbar vor Export)
- [ ] Mobile-optimiert (iPad-ready)
- **Deliverable:** Nutzer kann Generator komplett bedienen

### **Woche 5: PDF-Export & Speichern**
- [ ] PDF-Export (TRGS-konform formatiert)
- [ ] Word-Export (.docx)
- [ ] Cloud-Storage (Archiv, Versionierung)
- [ ] Download-Funktion
- **Deliverable:** Volle Funktionalität arbeitet

### **Woche 6: Testing & Refinement**
- [ ] Beta-Testing mit Josef's Freelance-Kunden
- [ ] UI/UX Polish
- [ ] Bug-Fixes
- [ ] Dokumentation
- **Deliverable:** Beta-Ready für Soft Launch

---

## 💻 TECHNOLOGIE-STACK

```
FRONTEND:
  - React (UI)
  - Tailwind CSS (Styling)
  - React Query (Data Fetching)
  - Next.js (SSR + API Routes optional)
  → Ziel: Responsive, iPad-optimiert

BACKEND:
  - Node.js + Express
  - PostgreSQL (Datenspeicher)
  - Redis (Caching für Performance)
  - OpenAI API (GPT-4)
  → Ziel: Skalierbar, stabil

AUTHENTICATION:
  - Firebase Auth oder Auth0
  → Ziel: Einfach & sicher

PDF-EXPORT:
  - pdfkit (Node.js PDF Generator)
  oder
  - Puppeteer (Chrome-basiert, besser für komplexe Layouts)
  → Ziel: TRGS-konforme PDFs

HOSTING:
  - Frontend: Vercel oder Netlify (kostenlos tier)
  - Backend: AWS EC2 oder Heroku
  - Database: AWS RDS oder Vercel Postgres
  → Ziel: Kostengünstig, zuverlässig

MONITORING:
  - Sentry (Error Tracking)
  - LogRocket (Session Replay)
  → Ziel: Bugs schnell finden
```

### **Geschätzte Kosten (monatlich, beim MVP):**
- Hosting: ~$50
- OpenAI API: ~$200 (skaliert mit Nutzung)
- Database: ~$50
- Sentry/Monitoring: ~$0 (kostenlos tier)
- **Total: ~$300/Monat**

---

## 💰 BUSINESS MODEL

### **Pricing-Option A: Pay-per-Use** ⚠️ Nicht ideal
- €5 pro generierte Betriebsanweisung
- Problematisch: Users generieren, kaufen nicht
- Empfehlung: **Nicht nehmen**

### **Pricing-Option B: Subscription** ✅ EMPFOHLEN

```
TIER 1: STARTER
  - €49/Monat
  - Bis zu 10 Betriebsanweisungen/Monat
  - Cloud-Speicher (1 GB)
  - Standard-Support
  → Ideal für: Solo-Handwerker, kleine Betriebe

TIER 2: PRO
  - €99/Monat
  - Unlimited Betriebsanweisungen
  - Cloud-Speicher (50 GB)
  - Team-Funktionen (bis 5 Benutzer)
  - Priority Support
  → Ideal für: Mittlere KMUs (20-100 Mitarbeiter)

TIER 3: ENTERPRISE
  - €299/Monat
  - Alles aus Pro, plus:
  - Unbegrenzte Benutzer
  - Custom Branding/Logo
  - API-Zugang
  - Dedicated Support
  → Ideal für: Große Betriebe, Beratungen
```

### **Finanzielle Projektion (Year 1)**

```
ANNAHMEN:
- 5 Kunden Monat 1 (Beta)
- +20 Kunden/Monat (organisches Wachstum)
- 60% Starter, 30% Pro, 10% Enterprise
- 90% Churn nach 3 Monaten (normal), dann stabil

MONAT 1-3 (Ramp-up):
- Customers: 5 → 50
- MRR: €200 → €3.000
- Kosten: €300/Monat
- Profit: -€100 → €2.700

MONAT 4-6 (Growth):
- Customers: 50 → 150
- MRR: €3.000 → €9.000
- Kosten: €500/Monat (mehr Server-load)
- Profit: €2.500 → €8.500

MONAT 7-12 (Skalierung):
- Customers: 150 → 400
- MRR: €9.000 → €25.000
- Kosten: €1.000/Monat
- Profit: €8.000 → €24.000

YEAR 1 TOTAL:
- Cumulative Customers: 400
- Annual Recurring Revenue (ARR): €300k+
- Profit (nach Kosten): €54k+
```

**Realistisch:** Jahr 1 eher €20-30k Profit, dann exponentiel

---

## 📊 GO-TO-MARKET STRATEGIE

### **PHASE 1: SOFT LAUNCH (Woche 7-12)**

**Beta-Testers:**
- Josef's Freelance-Kunden (5-10 Betriebe)
- Kolleg:innen im Handwerk
- Berufsgenossenschaft-Kontakte

**Ziele:**
- ✅ Feedback sammeln
- ✅ 5-10 Case Studies machen
- ✅ Video-Testimonials
- ✅ Bugs fixen

**Channels:**
- Direkte Emails an Kontakte
- WhatsApp/Telefon
- LinkedIn Posts (Beta-Ankündigung)

**Erwartete Metriken:**
- 5-10 Beta-Kunden
- 10+ Betriebsanweisungen generiert
- 90%+ Zufriedenheit

---

### **PHASE 2: REGIONAL LAUNCH (Monat 3-4)**

**Zielgruppe:**
- Handwerksbetriebe 20-100 Mitarbeiter
- Region: Westerwald, Rheinland-Pfalz, später Bundesweit

**Marketing-Channels:**
1. **LinkedIn/XING** (B2B targeting)
   - Ads an "Handwerksmeister", "Geschäftsführer", etc.
   - Organische Posts (Case Studies, Tipps)
   
2. **Handwerkskammern & IHK**
   - Kontakt zu Geschäftsführung
   - In Mitgliedernewsletter erwähnen
   - Eventuelle Partnerschaft
   
3. **Google Ads (SEM)**
   - Keywords: "Betriebsanweisung Generator", "TRGS Generator", "Arbeitsanweisung erstellen"
   - Budget: €500/Monat
   
4. **Content Marketing**
   - Blog-Artikel: "Warum Betriebsanweisungen wichtig sind"
   - SEO-optimiert für Keywords
   - Free Guide zum Download (Lead-Magnet)

5. **Email-Marketing**
   - Newsletter zu TRGS-Updates
   - Best Practices für Betriebsanweisungen
   - Kundenstories

**Pricing-Strategie:**
- Kostenlosen Trial: 14 Tage, unlimited
- Erste 3 Monate: -20% Discount (Early-Adopter)

**Erwartete Metriken:**
- 50-100 signups
- 10-20 zahlende Kunden
- €2k-3k MRR

---

### **PHASE 3: SCALE (Monat 5+)**

**Expansion:**
- Bundesweit skalieren (von Westerwald ausgehend)
- Neue Branchen-Module (z.B. Gastronomie, Pflege)
- API für Integration (ERP-Systeme, HR-Tools)
- White-Label-Lösung für Beratungen

**Partnerschaften:**
- Berufsgenossenschaften (Co-Marketing)
- Verbände (Handwerk, Industrie, Handel)
- Softwarehersteller (Integration)
- Versicherungen (Empfehlung)

**Erweiterungen:**
- Schulungs-Tracking (Wer hat Anweisung gelesen?)
- Checklisten-Generator
- Gefährdungsbeurteilung-Tool
- Behörden-Reports (automatisiert)

---

## 👥 KONKURRENZANALYSE

| Anbieter | Preis | Features | Schwäche |
|----------|-------|----------|----------|
| **Unser Tool** | €49-299 | AI-generiert, einfach, lokal optimiert | Noch nicht live |
| **word-Vorlagen** | Kostenlos | Vorlagen nur, keine AI | Unpersönlich, alt |
| **Berufsgenossenschaft-Tools** | Kostenlos | Offiziell, aber komplex | Slow, nicht user-friendly |
| **Spezialisierte Betriebe** | €500+ | Consulting-heavy | Teuer, langsam |

**Unser Vorteil:** AI-gestützt, schnell, günstig, user-friendly, Josef's Expertise ✅

---

## 🎯 UNIQUE SELLING POINTS (USPs)

1. ✅ **TRGS-konform** — Josef ist zertifiziert (TRGS 519/521)
2. ✅ **Lokal optimiert** — Für deutsche Betriebe, nicht generic
3. ✅ **Super schnell** — 5 Minuten statt Stunden
4. ✅ **Günstig** — €49 vs. €500+
5. ✅ **AI-powered** — GPT-4 macht die Heavy Lifting
6. ✅ **Datenschutz** — Deutsche Server, DSGVO-konform

---

## 🚀 NÄCHSTE SCHRITTE (PRIORITÄT)

### **Immediately (nächste Session):**
- [ ] **Business Canvas** ausarbeiten (1-2 Stunden)
- [ ] **Prototype** mit GPT-API testen (Feasibility-Check)
- [ ] **Markt-Interviews** planen (5-10 KMUs anschreiben)

### **Woche 1:**
- [ ] Tech-Stack final entscheiden
- [ ] Domain registrieren (z.B. betriebsanweisung.app)
- [ ] GitHub-Repo aufsetzen
- [ ] Dev-Umgebung konfigurieren

### **Woche 2-3:**
- [ ] MVP-Kickoff: Backend-Entwicklung starten
- [ ] Frontend-Setup
- [ ] AI-Prompts verfeinern

---

## 📁 RESSOURCEN (VORLAGEN & DOKUMENTE)

**Josef's Betriebsanweisungs-Vorlagen:**
- ✅ `03 Resources/Gefahrstoffe/Betriebsanweisungen/Vorlagen/` (12 Dateien)
- Nutzen als: System-Prompts für GPT

**Existierende Vault-Struktur:**
- ✅ `02 Areas/Persönliche Daten/` (Josef's Profil & Zertifikate)
- Nutzen als: Authentizität & Marketing-Content

**Freelance-Kunden:**
- ✅ `01 Projects/Freelance Gefahrstoffe Aufbau/Kunden/` (Potenzielle Beta-Testers)
- Nutzen als: Early Adopters & Case Studies

---

## 📊 SUCCESS METRICS (NORTH STAR)

| Metrik | Monat 1 | Monat 3 | Monat 6 | Monat 12 |
|--------|---------|---------|---------|----------|
| **Signups** | 5 | 50 | 150 | 400 |
| **Zahlende Kunden** | 2 | 20 | 60 | 150 |
| **MRR** | €100 | €2.000 | €6.000 | €15.000 |
| **Churn Rate** | N/A | <10% | <8% | <5% |
| **NPS Score** | 40+ | 50+ | 60+ | 70+ |
| **Betriebsanweisungen generiert** | 10 | 500 | 2.000 | 10.000+ |

---

## 🎓 LERNRESSOURCEN

**Für MVP-Entwicklung:**
- React Tutorial: https://react.dev
- Node.js + Express: https://expressjs.com
- OpenAI API: https://platform.openai.com/docs
- PostgreSQL: https://www.postgresql.org/docs
- Nextjs (optional): https://nextjs.org

**Für Business:**
- Lean Startup Methodologie
- Jobs to be Done Framework
- SaaS Metrics & Unit Economics

---

## 📞 KONTAKT & FOLLOW-UP

**Projekt-Lead:** Josef Linder  
**Nächste Überprüfung:** 2026-07-17  
**Status Updates:** Wöchentlich

**Offene Fragen zu klären:**
- [ ] Exakte Tech-Stack-Auswahl
- [ ] Priorität: Speed vs. Features
- [ ] Team: Solo vs. Co-Founder?
- [ ] Finanzierung: Bootstrapped vs. Investors?

---

**Zuletzt aktualisiert:** 2026-07-10  
**Status:** 🟡 Bereit für Business Canvas Phase
