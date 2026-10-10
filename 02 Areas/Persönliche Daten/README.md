---
tags: [profil, dokumentation]
---

# Persönliche Daten – System-Übersicht

Dies ist dein **Zentrale Datenquelle** zu deiner Person. Alle zukünftigen Arbeiten von Claude Code nutzen diese Informationen automatisch.

---

## 📁 Struktur

```
02 Areas/Persönliche Daten/
├── README.md (diese Datei)
├── Profil.md ⭐ HAUPTDATEI
├── Schulungen & Zertifikate.md
└── Zeugnisse & Referenzen.md
```

---

## 📄 Dateien Erklärung

### **Profil.md** ⭐ HAUPTDATEI
Die **vollständige Zusammenfassung deiner Person**:
- Persönliche Daten (Name, Geburt, Adresse, Kontakt)
- Berufsausbildung & Qualifikationen
- Berufliche Erfahrung (Positionen, Firmen)
- Sprachen, IT-Kompetenzen
- Kernkompetenzen
- Referenzen & Kontakte

**→ Diese Datei wird von Claude Code automatisch ausgelesen für:**
- Bewerbungen (Anschreiben, Lebenslauf)
- Freelance-Angebote
- Vorstellungsgespräch-Vorbereitung
- Verträge & Dokumentation

### **Schulungen & Zertifikate.md**
Detaillierte Liste aller:
- Berufsausbildungen
- Gefahrstoff-Zertifikate (mit Gültigkeitsdaten!)
- Fortbildungen & Schulungen
- IT-Schulungen
- Qualifikationen & Auszeichnungen

### **Zeugnisse & Referenzen.md**
Detaillierte Dokumentation:
- Alle Arbeitszeugnisse mit Links zu PDFs
- Arbeitgeber & Positionen (chronologisch)
- Berufliche Referenzen (Namen, Kontakt, Zeiträume)
- Leistungsbeurteilungen

---

## 🔄 Wie Claude Code diese nutzt

### Automatische Nutzung
```
🤖 Wenn du eine Bewerbung schreibst:
   → Claude Code liest [[02 Areas/Persönliche Daten/Profil]]
   → Nutzt deine Qualifikationen, Arbeitserfahrung, Kernkompetenzen
   → Generiert Lebenslauf & Anschreiben automatisch
```

```
🤖 Wenn du ein Freelance-Angebot verfasst:
   → Claude Code nutzt deine Gefahrstoff-Expertise aus [[Schulungen & Zertifikate]]
   → Deine Referenzen aus [[Zeugnisse & Referenzen]]
   → Erstellt ein professionelles Angebot
```

### Manuelle Nutzung
```
📝 Wenn du eine Datei brauchst:
   /generate-lebenslauf
   /generate-angebot
   /vorbereitung-vorstellungsgespräch
   etc.
```

---

## ✏️ Wie du diese Dateien pflegst

1. **Öffne [[Profil]]**
2. **Fülle alle [EINTRAGEN] Platzhalter aus** mit deinen echten Daten
3. **Nutze diese Struktur:**
   - 🟦 **[EINTRAGEN]** = Deine Input erforderlich
   - ✅ **Häkchen** = Optionale Felder
   - 🔗 **Links** `[[...]]` = Verknüpfung zu Dokumenten

4. **Halte es aktuell:**
   - Neue Schulungen? → `Schulungen & Zertifikate.md`
   - Neuer Job? → `Zeugnisse & Referenzen.md`
   - Adressänderung? → `Profil.md`

---

## 📁 Dokumente hochladen

**Alle deine Urkunden, Zeugnisse, Zertifikate speicherst du hier:**

→ `03 Resources/Persönliche Dokumente/`

**Struktur:**
```
03 Resources/Persönliche Dokumente/
├── Zeugnisse/
│   ├── Ausbildungszeugnis.pdf
│   ├── Arbeitszeugnis_Firma1.pdf
│   └── Arbeitszeugnis_Firma2.pdf
├── Zertifikate/
│   ├── REACH_Zertifikat.pdf
│   ├── GHS-CLP_Schulung.pdf
│   └── ...
├── Schulungen/
│   ├── Fortbildung_Gefahrstoffe.pdf
│   └── ...
├── Ausweise/
│   ├── Personalausweis_Kopie.pdf (optional)
│   └── ...
└── Verträge/
    ├── Arbeitsvertrag_Firma1.pdf
    └── ...
```

---

## 🔐 Datenschutz & Sicherheit

⚠️ **WICHTIG:**
- Diese Dateien enthalten persönliche Daten (Adressen, Nummern, Kontakte)
- **Nicht öffentlich hochladen** (z.B. nicht auf GitHub)
- **Nicht in öffentliche Vaults verschieben**
- **PDF-Kopien sollten gesichert werden**

✅ **Sicherheit:**
- Nutze dein lokales Obsidian-Vault (offline)
- Backups regelmäßig machen
- Sensible Nummern (Personalausweis, Steuer-ID) nur wenn nötig speichern

---

## 📝 Checkliste: Erste Einrichtung

- [ ] `Profil.md` vollständig ausgefüllt
- [ ] `Schulungen & Zertifikate.md` mit deinen Zertifikaten gefüllt
- [ ] `Zeugnisse & Referenzen.md` mit Arbeitgebern & Referenzen gefüllt
- [ ] Alle Urkunden/PDFs in `03 Resources/Persönliche Dokumente/` hochgeladen
- [ ] Links in den Markdown-Dateien zu den PDFs erstellt (z.B. `[[03 Resources/...]]`)

---

## 🎯 Nächste Schritte

1. **Gib deinen Daten ein** in die 3 Dateien
2. **Lade deine Dokumente hoch** in `03 Resources/Persönliche Dokumente/`
3. **Verknüpfe die Dokumente** mit Wiki-Links in den Markdown-Dateien
4. **Starte dein erstes Projekt** (z.B. `/generate-lebenslauf`)

---

**Willkommen zu deiner persönlichen Datenquelle!** 🚀
