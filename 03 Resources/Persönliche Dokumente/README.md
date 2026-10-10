---
tags: [resources, dokumente, persönlich]
letztes-update: 2026-07-10
---

# Persönliche Dokumente – Upload-Ordner

**Dies ist dein Archiv für alle Urkunden, Zeugnisse, Zertifikate und persönlichen Dokumente.**

---

## 📁 Ordnerstruktur

```
03 Resources/Persönliche Dokumente/
├── Zeugnisse/              ← Arbeitszeugnisse
├── Zertifikate/            ← Schulungs- & Fachzertifikate
├── Schulungen/             ← Teilnahmebescheinigungen, Kurse
├── Ausweise/               ← Personalausweis, Führerschein, etc. (optional)
├── Verträge/               ← Arbeitsverträge
├── Beglaubigungen/         ← Beglaubigte Kopien, Anerkennungen
└── Archive/                ← Alte/abgelaufene Dokumente
```

---

## 📋 Wie du Dateien hochlädst

### 1. **Zeugnisse/** 
Speichere hier alle Arbeitszeugnisse:
```
Zeugnisse/
├── Ausbildungszeugnis.pdf
├── Arbeitszeugnis_MusterGmbH_2020-2024.pdf
├── Arbeitszeugnis_AnotherCo_2018-2020.pdf
└── Arbeitszeugnis_Alt.pdf
```

**Naming-Konvention:**
- `Ausbildungszeugnis.pdf` (oder `Berufsschulzeugnis.pdf`)
- `Arbeitszeugnis_[FIRMA]_[VON-BIS].pdf`

### 2. **Zertifikate/**
Alle Fach- & Schulungszertifikate:
```
Zertifikate/
├── REACH_Zertifikat_2024.pdf
├── GHS-CLP_Schulung_2023.pdf
├── Gefahrstoffe_Seminar_2022.pdf
└── [ANDERES_ZERTIFIKAT].pdf
```

### 3. **Schulungen/**
Teilnahmebescheinigungen, die kein Zertifikat sind:
```
Schulungen/
├── Fortbildung_Büromanagement_2023.pdf
├── IT_Excel_Kurs_2024.pdf
└── Sicherheitsschulung_2024.pdf
```

### 4. **Ausweise/** (Optional)
Beglaubigte Kopien von Ausweisen:
```
Ausweise/
├── Personalausweis_Vorderseite.pdf
├── Personalausweis_Rückseite.pdf
├── Führerschein_Vorderseite.pdf
└── Führerschein_Rückseite.pdf
```
⚠️ **Achtung:** Sensible Daten! Nur wenn absolut nötig!

### 5. **Verträge/**
Arbeitsverträge, Freelance-Verträge:
```
Verträge/
├── Arbeitsvertrag_MusterGmbH_2020.pdf
├── Arbeitsvertrag_AnotherCo_2018.pdf
└── Freelance_Beratungsvertrag_Template.pdf
```

### 6. **Beglaubigungen/**
Amtlich beglaubigte Kopien, Anerkennungen:
```
Beglaubigungen/
├── Zeugnis_beglaubigt_2024.pdf
├── Abschluss_anerkannt_2020.pdf
└── [ANDERE_BEGLAUBIGUNG].pdf
```

### 7. **Archive/**
Alte/abgelaufene/nicht-aktive Dokumente:
```
Archive/
├── Altes_Zeugnis_2010.pdf
├── Abgelaufenes_Zertifikat_2015.pdf
└── Veraltete_Schulungsunterlagen/
```

---

## 🔗 Verknüpfung mit Profil

Nach dem Hochladen der Dateien, **verlinke sie in deinen Profil-Dateien**:

### In `[[02 Areas/Persönliche Daten/Profil]]` eintragen:
```markdown
- **Ausbildungszeugnis:** [[03 Resources/Persönliche Dokumente/Zeugnisse/Ausbildungszeugnis]]
```

### In `[[02 Areas/Persönliche Daten/Schulungen & Zertifikate]]` eintragen:
```markdown
| REACH-Zertifikat | [ANBIETER] | [DATUM] | [DATUM] | Aktiv | [[03 Resources/Persönliche Dokumente/Zertifikate/REACH_Zertifikat_2024]] |
```

### In `[[02 Areas/Persönliche Daten/Zeugnisse & Referenzen]]` eintragen:
```markdown
| MusterGmbH | Sachbearbeiter | 2020-2024 | 2024 | ✅ | [[03 Resources/Persönliche Dokumente/Zeugnisse/Arbeitszeugnis_MusterGmbH_2020-2024]] |
```

---

## 📝 Dateibenennungs-Konvention

**Wichtig:** Nutze klare, konsistente Namen!

**Format:**
```
[DOKUMENTTYP]_[BESCHREIBUNG]_[DATUM/JAHR].pdf
```

**Beispiele:**
- ✅ `Arbeitszeugnis_MusterGmbH_2024.pdf`
- ✅ `Zertifikat_REACH_2023-2025.pdf`
- ✅ `Schulung_Gefahrstoffe_2024.pdf`
- ❌ `Zeugnis1.pdf` (zu kurz)
- ❌ `zeugnis_von_der_firma.pdf` (unklar)

---

## 🔐 Sicherheit & Datenschutz

### Was darf rein:
- ✅ Zeugnisse (können beim Umzug in neuen Job notwendig sein)
- ✅ Zertifikate & Schulungen
- ✅ Beglaubigte Kopien
- ✅ Arbeitsverträge

### Was sollte vermieden werden:
- ⚠️ Personalausweisnummern-Seiten (nur wenn absolut nötig!)
- ⚠️ Steuer-IDs in Dokumenten (falls sichtbar)
- ⚠️ Bankdaten
- ⚠️ Krankenakten, private Briefe

### Backup & Sicherung:
- 📁 Speichere Backups außerhalb des Vaults
- 🔒 Nutze Verschlüsselung für sensible Dateien
- 📋 Führe eine Übersicht in `Profil.md` (ohne PDF-Inhalte)

---

## 📊 Checkliste: Hochladen

- [ ] **Alle Arbeitszeugnisse** in `Zeugnisse/` hochgeladen
- [ ] **Alle Zertifikate** in `Zertifikate/` hochgeladen
- [ ] **Schulungsbescheinigungen** in `Schulungen/` hochgeladen
- [ ] **Arbeitsverträge** in `Verträge/` hochgeladen
- [ ] **Beglaubigte Kopien** in `Beglaubigungen/` hochgeladen
- [ ] **Alle Dateien verlinkt** in `Profil.md`, `Schulungen & Zertifikate.md`, `Zeugnisse & Referenzen.md`
- [ ] **Alte Dokumente** in `Archive/` verschoben

---

## 🎯 Nächste Schritte

1. **Sammle all deine Dokumente** (Zeugnisse, Zertifikate, Urkunden)
2. **Lade sie in die entsprechenden Ordner** hoch
3. **Erstelle Wiki-Links** in den Profil-Dateien zu den PDFs
4. **Update dein Profil** mit allen Informationen

---

**Dein persönliches Dokumenten-Archiv ist bereit!** 📚
