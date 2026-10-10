---
type: agent-registry
version: "1.0"
letztes-update: 2026-07-25
---

# 🤖 AGENTEN-REGISTER

**Zentrale Übersicht: Alle 12 Agenten + ihre Oberaufgaben**

---

## Agenten auf einen Blick

| # | Agent | Typ | Oberaufgabe | Ordner | Status |
|---|-------|-----|-------------|--------|--------|
| 1 | **Henry** | Ausführungs-Agent | Zentrale Datenquelle (Qualifikationen, Expertise, Ziele) | `07 Agents/` | ✅ Aktiv |
| 2 | **Tim** | Ausführungs-Agent | Koordinator & Request-Manager (verteilt Aufgaben an Brian) | `07 Agents/` | ✅ Aktiv |
| 3 | **Brian** | Ausführungs-Agent | Output-Generator (Bewerbungen, Angebote, E-Mails) | `07 Agents/` | ✅ Aktiv |
| 4 | **Rainer** | Ausführungs-Agent | Vault-Maintenance (Aufräumen, Checks, Reparaturen) | `07 Agents/` | 🔄 Geplant |
| 5 | **Karl Market Watch** | Automation | Finanz-Tracking (Aktien, Edelmetalle, Kryptowährungen) | `02 Areas/Finanzen/` | ✅ Aktiv |
| 6 | **Nina Scout** | Automation | Job-Markt-Recherche (Stellenanzeigen, Chancen) | `02 Areas/Jobsuche/` | 🔄 Setup |
| 7 | **Vera Research** | Automation | Wissensammlung (Tutorials, Ressourcen, Regulierungen) | `03 Resources/` | 🔄 Geplant |
| 8 | **Freelance Monitor** | Automation | Geschäfts-Tracking (Kunden, Projekte, Pipeline) | `01 Projects/Freelance Gefahrstoffe/` | 🔄 Geplant |
| 9 | **Finanzen** | Bereichs-Agent | Budgets, Sparziele, Ausgaben-Tracking | `02 Areas/Finanzen/` | ✅ Aktiv |
| 10 | **Jobsuche** | Bereichs-Agent | Bewerbungen, Interviews, Stellensuche | `02 Areas/Jobsuche/` | ✅ Aktiv |
| 11 | **Freelance Gefahrstoffe** | Bereichs-Agent | Kundenaufbau, Leistungsportfolio, Business-Planung | `02 Areas/Freelance Gefahrstoffe/` | ✅ Aktiv |
| 12 | **Gefahrstoffe Wissen** | Bereichs-Agent | Fachkompetenz, Verordnungen, Best Practices | `02 Areas/Gefahrstoffe Wissen/` | ✅ Aktiv |

---

## Agent-Typen erklärt

### 🔧 Ausführungs-Agenten (4)
Spezialisierte Claude-Agenten, die **gezielt aktiviert** werden:

- **Henry**: Liest Qualifikationen, Zertifikate, Erfahrung aus der Vault
- **Tim**: Empfängt Befehle (`/tim [command]`), orchestriert andere Agenten
- **Brian**: Schreibt Bewerbungen, Angebote, Mails auf Basis von Henrys Daten
- **Rainer**: Räumt Vault auf, führt Integritäts-Checks durch, repariert Fehler

→ **Aktivierung**: Manuell via `/tim [command]` oder automatisch via Scheduler

---

### 🤖 Automation-Agenten (4)
Cloud-basierte Agenten mit **regelmäßiger Ausführung** (via schtasks):

- **Karl Market Watch**: Tägl. 10:00 Finanz-Daten sammeln & analysieren
- **Nina Scout**: Tägl. 08:00 Jobbörsen durchsuchen (Umkreis 50km Heistenbach)
- **Vera Research**: Wöchentl. Do 09:00 Lernressourcen & Tutorials finden
- **Freelance Monitor**: Tägl. 14:00 Geschäfts-Metriken aktualisieren

→ **Aktivierung**: Automatisch via Windows Task Scheduler (schtasks)

---

### 📍 Bereichs-Agenten (4)
Deine **Lebens-/Arbeitsbereiche**, regelmäßig aktualisiert:

- **Finanzen**: Einnahmen, Ausgaben, Sparziele
- **Jobsuche**: Bewerbungen, Rückmeldungen, Chancen
- **Freelance Gefahrstoffe**: Kundenakquise, Projekte, Pipeline
- **Gefahrstoffe Wissen**: Fachkompetenz, Zertifikate, Trainings

→ **Aktivierung**: Wöchentlich sonntags via `/update-agenten` oder manuell

---

## Wichtige Links

- [[02 Areas/Agent-Config/GLOBAL-RULES.md]] – Datenschutz, Automation, Messungen
- [[02 Areas/Agent-Config/SKILLS-ÜBERSICHT.md]] – Alle Skills dokumentiert
- [[02 Areas/Agenten-Übersicht.md]] – Wöchentliche Updates (Details)
- [[07 Agents/Zeus_Knowledge.md]] – Zentrale Datenquelle für Ausführungs-Agenten
- [[07 Agents/README.md]] – Agent-System-Dokumentation
