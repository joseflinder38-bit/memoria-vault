---
type: standards
version: "1.0"
erstellt: 2026-07-28
---

# 🏷️ TAG-KONVENTION FÜR OBSIDIAN

**Standardisierte Tags für bessere Kategorisierung, Queries und Automation**

---

## DOMAIN-TAGS (Wozu gehört dieser Note?)

Verwende im Frontmatter:
```yaml
tags:
  - domain/jobsuche
  - domain/freelance
  - domain/finanzen
  - domain/persönlich
```

| Tag | Bedeutung | Beispiele |
|-----|-----------|----------|
| `#domain/jobsuche` | Bewerbungen, Jobs, Interviews | Bewerbungs-Notes, Interview-Vorbereitung |
| `#domain/freelance` | Freelance-Business, Kunden, Projekte | Kunden-Notes, Proposals, Abrechnung |
| `#domain/finanzen` | Geld, Budget, Ausgaben, Einnahmen | Finanz-Tracking, Prognosen |
| `#domain/persönlich` | Private Angelegenheiten | Gesundheit, Familie, Hobbys |

---

## STATUS-TAGS (Was ist der aktuelle Status?)

```yaml
tags:
  - status/active        # Aktuell in Arbeit
  - status/completed     # Fertig / Abgeschlossen
  - status/waiting       # Wartet auf Rückmeldung
  - status/blocked       # Blockiert, braucht Help
  - status/on-hold       # Bewusst pausiert
```

| Tag | Wann verwenden? |
|-----|-----------------|
| `#status/active` | Bewerbung gerade eingereicht, Projekt läuft |
| `#status/completed` | Zusage erhalten, Projekt abgeschlossen, Bezahlt |
| `#status/waiting` | Ich warte auf Rückmeldung vom Arbeitgeber/Kunden |
| `#status/blocked` | Ich kann nicht weitermachen (brauche Info/Material) |
| `#status/on-hold` | Ich habe das bewusst pausiert (z.B. später revisit) |

---

## PRIORITÄTS-TAGS (Wie wichtig ist das?)

```yaml
tags:
  - priority/high       # Sofort bearbeiten (diese Woche)
  - priority/medium     # Wichtig, aber Zeit für nächste Woche
  - priority/low        # Wenn Kapazität vorhanden (irgendwann)
```

**Regel:**
- `#priority/high` = Deadline < 1 Woche ODER großes Potenzial
- `#priority/medium` = Deadline 1-4 Wochen ODER regelmäßig
- `#priority/low` = Deadline > 1 Monat ODER nice-to-have

---

## AKTION-TAGS (Was soll der Agent/ich tun?)

```yaml
tags:
  - action/follow-up    # Nachverfolgung erforderlich
  - action/review       # Review/QA erforderlich vor Versand
  - action/send-email   # Email schreiben + versenden
  - action/update-status # Status aktualisieren
```

| Tag | Beispiel |
|-----|----------|
| `#action/follow-up` | Kunde nicht geantwortet → nachbohren |
| `#action/review` | Proposal vor Versand prüfen |
| `#action/send-email` | Email-Entwurf ist bereit → Versand |
| `#action/update-status` | Note ist alt, Status muss aktualisiert werden |

---

## KOMBINIERTE BEISPIELE

### Beispiel 1: Aktive Bewerbung bei Siemens

```yaml
---
firma: "Siemens AG"
position: "Office Manager"
status: "active"
tags:
  - domain/jobsuche
  - status/active
  - priority/high
  - action/follow-up
---
```

**Interpretation:** 
- Ist eine Jobsuche-Aktivität
- Aktuell in Arbeit
- Wichtig (diese Woche)
- Braucht Follow-up (ev. Interview-Vorbereitung nötig)

---

### Beispiel 2: Freelance-Proposal in Verhandlung

```yaml
---
kunde: "MusterGmbH"
leistung: "Gefahrstoffkataster"
status: "proposal-gesendet"
tags:
  - domain/freelance
  - status/waiting
  - priority/high
  - action/review
---
```

**Interpretation:**
- Ist Freelance-Projekt
- Wartet auf Kunden-Rückmeldung
- Hohe Priorität (Umsatz!)
- Braucht Überprüfung der Proposal

---

### Beispiel 3: Abgeschlossenes Projekt

```yaml
---
kunde: "ABC GmbH"
leistung: "Betriebsanweisung Update"
status: "completed"
tags:
  - domain/freelance
  - status/completed
  - priority/low
---
```

**Interpretation:**
- Freelance-Projekt
- Fertig (nicht mehr relevant für Aktionen)
- Low Priority (historisches Archiv)

---

## DATAVIEW QUERIES MIT TAGS

### Query 1: Alle HOHEN Prioritäten diese Woche

```dataview
TABLE firma, position, deadline
FROM "01 Projects/Bewerbungen"
WHERE contains(tags, "#priority/high") AND deadline < date(today) + dur(7 days)
SORT deadline ASC
```

### Query 2: Alle Kunden-Follow-ups erforderlich

```dataview
TABLE kunde, leistung, nächster_kontakt
FROM "01 Projects/Freelance/Kunden"
WHERE contains(tags, "#action/follow-up") AND contains(tags, "#priority/high")
SORT nächster_kontakt ASC
```

### Query 3: Aktive Projektе ohne Review

```dataview
TABLE kunde, leistung
FROM "01 Projects/Freelance/Kunden"
WHERE contains(tags, "#status/active") AND contains(tags, "#action/review")
```

---

## 📋 CHECKLISTE: TAGS ZUR VORHANDENEN STRUKTUR HINZUFÜGEN

**Für alle Bewerbungs-Notes:**
- [ ] Öffne `01 Projects/Bewerbungen/Firmen/[Firma].md`
- [ ] Füge Frontmatter hinzu:
  ```yaml
  tags:
    - domain/jobsuche
    - status/[active|waiting|completed|rejected]
    - priority/[high|medium|low]
  ```

**Für alle Kunden-Notes:**
- [ ] Öffne `01 Projects/Freelance/Kunden/[Kunde].md`
- [ ] Füge Frontmatter hinzu:
  ```yaml
  tags:
    - domain/freelance
    - status/[kontakt|proposal-gesendet|aktiv|completed]
    - priority/[high|medium|low]
  ```

---

## 🎯 WICHTIGE REGELN

1. **Immer `domain/*` Tag** — damit weiß man, wozu das gehört
2. **Immer `status/*` Tag** — damit weiß man, wo das steht
3. **Priorität nur bei hochrelevanten Notes** — nicht alles is `#priority/high`
4. **Action-Tags nur bei echten Aufgaben** — nicht bei abgeschlossenen Projekten
5. **Keine Custom-Tags erfinden** — nur die oben definierten verwenden

---

## 📍 STATUS

- ✅ TAG-KONVENTION definiert
- ✅ Beispiele dokumentiert
- ✅ Dataview-Queries vorbereitet
- ⏳ Tags zu bestehenden Notes hinzufügen (manuell oder via Script)

**Nächster Schritt:** Tags zu deinen Notes hinzufügen!
