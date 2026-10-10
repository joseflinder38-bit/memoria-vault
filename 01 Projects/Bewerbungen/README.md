---
ordner: Bewerbungen
version: 2.0
created: 2026-07-10
status: aktiv
letztes-update: 2026-07-10
---

# 📋 Bewerbungs-System — README

Dieses System organisiert **Lebensläufe, Bewerbungsanschreiben und Tracking** für deine Jobsuche im öffentlichen Dienst.

---

## 📂 **ORDNER-STRUKTUR**

```
01 Projects/Bewerbungen/
├── README.md (diese Datei)
├── Lebenslauf_v2.0.html (AKTUELLER LEBENSLAUF — HTML)
├── Lebenslauf_v2.0.pdf (print-ready PDF) — ⏳ TODO
├── Lebenslauf_v2.0.docx (Word für Bewerbungsportale) — ⏳ TODO
├── Lebenslauf_v1.1.html (vorherige Version — archiv)
│
└── Anschreiben/
    ├── Beispiel-Anschreiben_Stadtverwaltung-Montabaur.md
    ├── Anschreiben_[Firma]_[Position]_v1.md (neu für jede Bewerbung)
    └── ...

└── Tracking/
    ├── Bewerbungen-Übersicht.md (Dataview-Query: alle Bewerbungen)
    └── [später]
```

---

## 📄 **DATEIEN & IHRE ZWECKE**

### **A) LEBENSLÄUFE (aktuelle Version: 2.0)**

| Datei | Format | Verwendung | Status |
|-------|--------|-----------|--------|
| **Lebenslauf_v2.0.html** | HTML | Screen + Druck (beste Qualität) | ✅ AKTUELL |
| **Lebenslauf_v2.0.pdf** | PDF | E-Mail & Online-Portale | ⏳ TODO |
| **Lebenslauf_v2.0.docx** | Word | Portale ohne PDF-Upload | ⏳ TODO |
| **Lebenslauf_v1.1.html** | HTML | Archiv (alte Version) | 📦 |

**Wann welches Format verwenden:**
- 📧 **E-Mail-Bewerbung?** → HTML oder PDF
- 🌐 **Online-Portal mit PDF-Upload?** → PDF
- 🌐 **Online-Portal mit Word-Upload?** → DOCX

---

### **B) BEWERBUNGSANSCHREIBEN**

| Datei | Zweck | Verwendung |
|-------|-------|-----------|
| **[[05 Templates/Bewerbung-Anschreiben-Template.md]]** | Universelle Vorlage mit Platzhaltern | Basis für ALLE neuen Anschreiben |
| **Beispiel-Anschreiben_Stadtverwaltung-Montabaur.md** | Konkrete ausgefüllte Bewerbung | Lernbeispiel — Copy-Paste-ready |
| **Anschreiben_[Firma]_[Position]_v1.md** | Pro Bewerbung neue Datei | Personalisierte Anschreiben |

**Workflow für neue Bewerbung:**
1. Kopiere Template → `Anschreiben_[FIRMA]_[POSITION]_v1.md`
2. Ich fülle Platzhalter basierend auf Jobausschreibung
3. Du gibst Feedback/Anpassungen
4. Export PDF → versenden

---

## 🎯 **DEIN BEWERBUNGS-PROFIL (HINTERLEGT)**

Diese Informationen werden in JEDEM Anschreiben verwendet:

**Stärken:**
- ✅ Zuverlässigkeit (5+ Jahre durchgehend)
- ✅ Sicherheits- & Compliance-Fokus (8 aktuelle Zertifikate)
- ✅ Projektmanagement & Eigenverantwortung
- ✅ Detailorientierung & Genauigkeit
- ✅ Team- & Kommunikationsfähigkeit

**Arbeitsstil:**
- Flexibel — sowohl selbstständig als auch teamorientiert

**Motivationen (öffentlicher Dienst):**
- Sicherheit & Stabilität (tarifliche Bezahlung, Jobsicherheit)
- Sinnhafte Tätigkeit (für Gesellschaft & öffentliches Wohl)
- Geregelte Arbeitszeiten (Work-Life-Balance)

**Motivationen (Büro-Management):**
- Verwaltungs-Prozesse optimieren
- Koordination & Teamunterstützung
- Dokumente & Compliance sicherstellen

**Langzeitziel:**
- Aufstieg in Führungsrolle (Abteilungsleitung, Koordination)

**USP (Unique Selling Point):**
- Bewiesene Zuverlässigkeit (5+ Jahre, kontinuierliche Zertifizierungen)
- Seltene Expertise-Kombination: Büro-Management + Gefahrstoffe-Spezialist

---

## 🚀 **WORKFLOW: NEUE BEWERBUNG SCHREIBEN**

### **Schritt 1: Jobausschreibung finden (Nina Scout)**
Täglich 08:00 Uhr → Nina Scout sucht Jobs  
📁 Speicherort: `02 Areas/Jobsuche-Archiv/Jobs_[Datum].md`  
Dort siehst du: TOP MATCHES mit Match-Score & Gehalt

### **Schritt 2: Anschreiben generieren**
**Du sagst:** "Schreib Anschreiben für [Firma] und [Position]"

**Ich:**
1. Lese dein Profil
2. Kopiere Bewerbung-Anschreiben-Template
3. Fülle Platzhalter mit:
   - Firma, Position, Abteilung, Kontaktperson
   - Deine Stärken & Qualifikationen
   - Match-Punkte zu Jobausschreibung
   - Spezifische Motivationen
4. Erstelle neue Datei: `Anschreiben_[Firma]_[Position]_v1.md`

### **Schritt 3: Feedback & Optimierung**
Du sagst: "Ändere [Punkt] oder Füge [Text] hinzu"  
Ich überarbeite die Datei

### **Schritt 4: Export & Versand**
- Konvertiere zu PDF (schöne Formatierung)
- Speichere PDF im Anschreiben-Ordner
- Versende mit Lebenslauf v2.0 per E-Mail oder Portal

### **Schritt 5: Tracking**
- Markiere in Tracking-Datei: "Beworben [Datum]"
- Notiere: Firma, Position, Link zur Ausschreibung, Deadline
- Erinnerung: Nach 14 Tagen nachfragen (Follow-up)

---

## 📊 **BEWERBUNGS-TRACKING (Dataview)**

**Geplant (wird noch erstellt):**
```dataview
table firma, position, datum_bewerbung, status
from "01 Projects/Bewerbungen"
where status != "archived"
sort datum_bewerbung desc
```

**Zeigt:** Alle aktiven Bewerbungen mit Status

---

## ✅ **CHECKLISTE VOR VERSAND**

Für JEDE Bewerbung:

- [ ] **Lebenslauf:**
  - [ ] Aktuellste Version (v2.0)?
  - [ ] Richtiges Format (HTML, PDF oder DOCX)?
  - [ ] Keine Formatierungsfehler beim Druck?

- [ ] **Anschreiben:**
  - [ ] Firma & Position korrekt geschrieben?
  - [ ] Kontaktperson richtig benannt (oder "Sehr geehrte Damen und Herren")?
  - [ ] Alle `[PLATZHALTER]` gefüllt?
  - [ ] Qualifikationen tatsächlich in Jobbeschreibung erwähnt?
  - [ ] Rechtschreibung & Grammatik korrekt?
  - [ ] Ton: professionell aber warm (nicht robotisch)?
  - [ ] Unterschrift (digital oder handschriftlich gescannt)?

- [ ] **Versand-Vorbereitung:**
  - [ ] E-Mail-Adresse des Empfängers korrekt?
  - [ ] Betreffzeile aussagekräftig?
  - [ ] PDFs klein genug (<5MB gesamt)?
  - [ ] Lebenslauf + Anschreiben beide angehängt?

---

## 📝 **BEISPIEL-ANSCHREIBEN STUDIEREN**

Falls du unsicher bist, wie es aussieht:

→ **[[01 Projects/Bewerbungen/Beispiel-Anschreiben_Stadtverwaltung-Montabaur.md]]**

Dieses Beispiel zeigt:
- ✅ Wie der Aufbau aussieht (4 Absätze)
- ✅ Wie Qualifikationen abgegleicht werden
- ✅ Welche Besonderheiten hervorgehoben werden
- ✅ Wie die Schlusssatz formuliert ist

**Du kannst Teile davon direkt kopieren & anpassen!**

---

## 🔄 **VERSIONEN & CHANGELOG**

### Lebenslauf v2.0 (AKTUELL — 2026-07-10)
```
✅ Bessere Lesbarkeit & Struktur
✅ Stärken-Box hervorgehoben
✅ Zertifikate prominenter
✅ Duale Kompetenzen gleich gewichtet
✅ Verbesserte Typographie
```

### Lebenslauf v1.1 (Archiv — 2026-07-05)
```
✅ Erste optimierte Version
~ Firmenname korrigiert (AsEG-ALLODEMONT → AsEG-ALLDEMONT)
~ Konstruktionsmechaniker-Status klargestellt
```

### Lebenslauf v1.0_FINAL (Archiv — 2026-07-05)
```
✅ Erste finale Version
~ 2-Spalten-Design (Sidebar + Main)
```

---

## 📅 **NÄCHSTE SCHRITTE**

- [ ] **PDF-Version** von Lebenslauf v2.0 konvertieren
- [ ] **DOCX-Version** von Lebenslauf v2.0 konvertieren
- [ ] **Tracking-Datei** erstellen (Dataview-Query für alle Bewerbungen)
- [ ] **Follow-up-Reminder** (14 Tage nach Bewerbung)

---

## 🔗 **VERKNÜPFUNGEN**

- **Jobsuche-Ergebnisse:** [[02 Areas/Jobsuche-Archiv/]]
- **Bewerbungs-Template:** [[05 Templates/Bewerbung-Anschreiben-Template]]
- **Dein Profil (Stärken/Zertifikate):** [[02 Areas/Persönliche Daten/Qualifikationen/]]
- **Arbeitsstand:** [[02 Areas/Persönliche Daten/ARBEITSSTAND]]

---

**Version:** 2.0  
**Zuletzt aktualisiert:** 2026-07-10  
**Status:** ✅ PRODUKTIV & BEREIT
