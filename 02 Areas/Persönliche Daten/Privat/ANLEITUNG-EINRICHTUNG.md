---
tags: [profil, anleitung]
---

# Anleitung: Einrichtung deiner Persönlichen Datenquelle

**Schritt-für-Schritt Anleitung zur vollständigen Einrichtung deines Profil-Systems.**

---

## 🎯 Übersicht

Du hast jetzt 3 neue Dateien + 1 Upload-Ordner:

| Komponente                      | Ort                           | Funktion                                          |
| ------------------------------- | ----------------------------- | ------------------------------------------------- |
| **Profil.md**                   | `02 Areas/Persönliche Daten/` | Hauptdatenquelle (Name, Kontakt, Qualifikationen) |
| **Schulungen & Zertifikate.md** | `02 Areas/Persönliche Daten/` | Detail-Liste aller Zertifikate                    |
| **Zeugnisse & Referenzen.md**   | `02 Areas/Persönliche Daten/` | Arbeitserfahrung & Referenzen                     |
| **Persönliche Dokumente/**      | `03 Resources/`               | Upload-Ordner für PDFs (Zeugnisse, Urkunden)      |

---

## 📝 SCHRITT 1: Profil ausfüllen (ca. 30 Min)

### Öffne: `[[02 Areas/Persönliche Daten/Profil]]`

Gehe alle `[EINTRAGEN]` Platzhalter durch und fülle sie mit deinen Daten:

#### 👤 **Persönliche Daten** (10 Min)
- [ ] Vollständiger Name
- [ ] Geburtsdatum & Geburtsort
- [ ] Adresse & Postleitzahl
- [ ] Telefon-Nummer

- [ ] Steuer-ID, Umsatzsteuer-ID (für Freelance)
- [ ] Bankverbindung (IBAN für Rechnungen)

#### 🎓 **Berufsausbildung** (5 Min)
- [ ] "Kaufmann für Büromanagement" – Abschlussdatum
- [ ] Ausbildungsort
- [ ] Gefahrstoff-Zertifikate/Schulungen auflisten

#### 💼 **Berufliche Erfahrung** (10 Min)
- [ ] Letzte/Aktuelle Position
- [ ] 2-3 bisherige Arbeitgeber mit Zeiträumen
- [ ] Branche & Hauptaufgaben

#### 🗣️ **Sprachen & IT** (5 Min)
- [ ] Deutsch (Muttersprache) ✅
- [ ] Englisch Niveau
- [ ] Microsoft Office Kenntnisse
- [ ] Spezial-Software (z.B. SAP, Datenbanken)

#### 👥 **Referenzen** (5 Min)
- [ ] 2-3 Referenzen (Name, Position, Kontakt, Zeitraum)

---

## 📊 SCHRITT 2: Schulungen & Zertifikate ausfüllen (ca. 20 Min)

### Öffne: `[[02 Areas/Persönliche Daten/Schulungen & Zertifikate]]`

Trage alle deine Qualifikationen ein:

#### 🎓 **Berufsausbildung**
- [ ] Kaufmann für Büromanagement (Schule/Betrieb, Datum)
- [ ] Andere Ausbildungen (falls vorhanden)

#### 🧪 **Gefahrstoff-Zertifikate**
Beispiele (falls vorhanden):
- [ ] REACH-Zertifikat (Datum, Gültig bis)
- [ ] GHS/CLP-Schulung (Datum)
- [ ] Gefahrstoffverordnung (GefStoffV) (Datum)
- [ ] Betriebsanweisungen-Schulung (Datum)
- [ ] Andere: [EINTRAGEN]

#### 📚 **Weitere Schulungen**
- [ ] Excel-Kurse, PowerPoint, Word
- [ ] Branchenschulungen (Metallverarbeitung, Chemie, etc.)
- [ ] Sicherheitsschulungen
- [ ] Andere: [EINTRAGEN]

---

## 📋 SCHRITT 3: Zeugnisse & Referenzen ausfüllen (ca. 20 Min)

### Öffne: `[[02 Areas/Persönliche Daten/Zeugnisse & Referenzen]]`

#### 📄 **Arbeitszeugnisse**
- [ ] Letzte Position: Firma, Titel, Zeitraum, Zeugnisnote
- [ ] 2-3 frühere Positionen: Firma, Titel, Zeitraum

#### 👥 **Referenzen**
Für jede Referenz:
- [ ] Name (vollständig)
- [ ] Position (z.B. "Geschäftsführer")
- [ ] Firma & Branche
- [ ] E-Mail & Telefon
- [ ] Zeitraum Zusammenarbeit
- [ ] Schwerpunkte (3 Punkte)

---

## 📁 SCHRITT 4: Dokumente hochladen (variabel)

### Ordner: `03 Resources/Persönliche Dokumente/`

Lade deine physischen/digitalen Dokumente hoch:

#### 📂 **Zeugnisse/**
- [ ] Ausbildungszeugnis.pdf
- [ ] Arbeitszeugnis_[FIRMA]_[DATUM].pdf
- [ ] Weitere Zeugnisse

#### 📂 **Zertifikate/**
- [ ] REACH_Zertifikat_[DATUM].pdf
- [ ] GHS-CLP_Schulung_[DATUM].pdf
- [ ] Andere Zertifikate

#### 📂 **Schulungen/**
- [ ] Fortbildung_[NAME]_[DATUM].pdf
- [ ] IT-Schulung_[NAME]_[DATUM].pdf

#### 📂 **Verträge/** (optional)
- [ ] Arbeitsvertrag_[FIRMA]_[DATUM].pdf

#### 📂 **Ausweise/** (optional, sensibel!)
- [ ] Personalausweis_Vorderseite.pdf
- [ ] Personalausweis_Rückseite.pdf

---

## 🔗 SCHRITT 5: Verknüpfungen erstellen (ca. 15 Min)

Nach dem Hochladen der Dateien, **erstelle Links** in deinen Profil-Dateien.

### Beispiel in `Profil.md`:
```markdown
- **Ausbildungszeugnis:** [[03 Resources/Persönliche Dokumente/Zeugnisse/Ausbildungszeugnis]]
```

### Beispiel in `Schulungen & Zertifikate.md`:
```markdown
| REACH-Zertifikat | [ANBIETER] | 2023 | 2025 | Aktiv | [[03 Resources/Persönliche Dokumente/Zertifikate/REACH_Zertifikat_2023]] |
```

### Beispiel in `Zeugnisse & Referenzen.md`:
```markdown
| MusterGmbH | Sachbearbeiter | 2020-2024 | 2024 | ✅ | [[03 Resources/Persönliche Dokumente/Zeugnisse/Arbeitszeugnis_MusterGmbH_2024]] |
```

---

## ✅ SCHRITT 6: Final-Check (5 Min)

- [ ] **Profil.md** – Alle persönlichen Daten eingetragen
- [ ] **Schulungen & Zertifikate.md** – Alle Qualifikationen aufgelistet
- [ ] **Zeugnisse & Referenzen.md** – Alle Arbeitgeber & Referenzen eingetragen
- [ ] **PDFs hochgeladen** in `03 Resources/Persönliche Dokumente/`
- [ ] **Wiki-Links erstellt** in den Markdown-Dateien
- [ ] **Alle [EINTRAGEN] Platzhalter gefüllt oder gelöscht**

---

## 🚀 SCHRITT 7: Erste Anwendung

Nach der Einrichtung kannst du diese Befehle nutzen:

```
/generate-lebenslauf
/generate-bewerbung
/generate-freelance-angebot
/vorbereitung-vorstellungsgespräch
```

Diese Befehle werden automatisch dein Profil auslesen und verwenden!

---

## 💡 Tipps

### Naming-Konvention beibehalten
Nutze immer diese Format für Dateien:
```
[DOKUMENTTYP]_[BESCHREIBUNG]_[DATUM].pdf
```
Beispiele:
- `Arbeitszeugnis_MusterGmbH_2024.pdf`
- `Zertifikat_REACH_2023-2025.pdf`

### Regelmäßig aktualisieren
- Neue Schulung gemacht? → Update `Schulungen & Zertifikate.md`
- Job gewechselt? → Update `Zeugnisse & Referenzen.md`
- Adresse geändert? → Update `Profil.md`

### Sicherheit
- ⚠️ Keine Bankdaten oder Steuer-IDs in den PDFs sichtbar!
- 🔒 Backups außerhalb des Vaults regelmäßig machen
- 🔐 Nicht öffentlich hochladen (z.B. nicht auf GitHub)

---

## 📞 Support

Falls du Fragen hast:
- Lies `README.md` in `02 Areas/Persönliche Daten/` nochmal
- Oder die Übersicht in `03 Resources/Persönliche Dokumente/README.md`

---

**Viel Erfolg bei der Einrichtung! 🎯**
