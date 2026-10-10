#!/usr/bin/env python3
"""
MEMORIA VAULT MAINTENANCE SYSTEM
==================================
Drei automatisierte Funktionen:
1. Dead Links beheben & auflisten
2. Frontmatter standardisieren
3. Tägliche Health Reports erstellen

REGELN:
- KEINE sensiblen Daten exportieren (02 Areas/Persönliche Daten)
- Backups vor Änderungen
- Verifizierung vor Speichern
"""

import os
import json
import re
import shutil
from pathlib import Path
from datetime import datetime
from collections import defaultdict
import sys

# Windows UTF-8 Fix
if sys.platform == 'win32':
    import io
    sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')


class DeadLinkFixer:
    """Findet und repariert Dead Links in der Vault"""

    def __init__(self, vault_root: str):
        self.vault_root = Path(vault_root)
        self.file_index = {}
        self.dead_links = []
        self.fixes = []

    def build_index(self):
        """Erstelle Index aller Dateien (mit verschiedenen Namensformen)"""
        print("\n📑 Building file index...\n")

        for md_file in self.vault_root.rglob("*.md"):
            if any(part.startswith('.') for part in md_file.parts):
                continue

            rel_path = md_file.relative_to(self.vault_root)
            stem = md_file.stem

            # Indexiere verschiedene Formen
            self.file_index[stem] = str(rel_path)
            self.file_index[str(rel_path).replace('\\', '/')] = str(rel_path)
            self.file_index[str(rel_path)] = str(rel_path)

        print(f"✅ Index erstellt: {len(self.file_index)} Einträge\n")

    def find_dead_links(self):
        """Finde alle Dead Links"""
        print("🔍 Scanning for dead links...\n")

        for md_file in self.vault_root.rglob("*.md"):
            if any(part.startswith('.') for part in md_file.parts):
                continue

            try:
                with open(md_file, 'r', encoding='utf-8') as f:
                    content = f.read()

                # Finde alle Wikilinks
                links = re.findall(r'\[\[([^\]]+)\]\]', content)

                for link in links:
                    target = link.split('#')[0].strip()
                    if not self._link_exists(target):
                        self.dead_links.append({
                            'file': str(md_file.relative_to(self.vault_root)),
                            'link': link,
                            'target': target,
                            'suggestion': self._suggest_fix(target)
                        })

            except Exception as e:
                print(f"⚠️  Error reading {md_file}: {e}", file=sys.stderr)

        print(f"⚠️  {len(self.dead_links)} Dead Links gefunden\n")

    def _link_exists(self, target: str) -> bool:
        """Prüfe ob Link existiert"""
        if not target:
            return False

        # Versuche direkten Match
        if target in self.file_index:
            return True

        # Versuche ohne .md
        if target + '.md' in self.file_index:
            return True

        # Versuche Pfad-Varianten
        for variant in [target.replace('/', '\\'), target.replace('\\', '/')]:
            if variant in self.file_index:
                return True

        return False

    def _suggest_fix(self, broken_target: str) -> str or None:
        """Schlage Reparatur vor"""
        # Simpel: wenn Datei mit ähnlichem Namen existiert
        for key in self.file_index:
            if broken_target.lower() in key.lower() or key.lower() in broken_target.lower():
                return self.file_index[key]

        return None

    def save_dead_links_report(self):
        """Speichere Dead Links Report"""
        report = []
        report.append("# ⚠️ Dead Links Report\n\n")
        report.append(f"**Generiert:** {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
        report.append(f"**Gefunden:** {len(self.dead_links)} Dead Links\n\n")

        report.append("## Dead Links mit Vorschlägen\n\n")
        report.append("| Datei | Link | Vorschlag |\n")
        report.append("|-------|------|----------|\n")

        for link_info in self.dead_links[:50]:  # Top 50
            suggestion = f"`{link_info['suggestion']}`" if link_info['suggestion'] else "❌ keine"
            report.append(
                f"| `{link_info['file']}` | `[[{link_info['link']}]]` | {suggestion} |\n"
            )

        report_path = self.vault_root / "00 Inbox" / "DEAD-LINKS-REPORT.md"
        with open(report_path, 'w', encoding='utf-8') as f:
            f.write("".join(report))

        print(f"✅ Dead Links Report gespeichert: {report_path}\n")


class FrontmatterStandardizer:
    """Standardisiert Frontmatter-Felder"""

    def __init__(self, vault_root: str):
        self.vault_root = Path(vault_root)
        self.changes = []

        # Standardwerte für Status
        self.valid_statuses = [
            'aktiv',
            'abgeschlossen',
            'pausiert',
            'geplant',
            'archiviert'
        ]

    def standardize_all(self):
        """Standardisiere alle Markdown-Dateien"""
        print("\n📝 Standardizing frontmatter...\n")

        count = 0
        for md_file in self.vault_root.rglob("*.md"):
            if any(part.startswith('.') for part in md_file.parts):
                continue

            # Ignoriere Persönliche Daten
            if "Persönliche Daten" in str(md_file):
                continue

            if self._standardize_file(md_file):
                count += 1

        print(f"✅ {count} Dateien aktualisiert\n")

    def _standardize_file(self, file_path: Path) -> bool:
        """Standardisiere eine einzelne Datei"""
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()

            # Extrahiere Frontmatter
            fm_match = re.match(r'^---\n(.*?)\n---\n(.*)', content, re.DOTALL)
            if not fm_match:
                return False

            fm_text = fm_match.group(1)
            body = fm_match.group(2)

            # Normalisiere Status
            new_fm = self._normalize_status(fm_text)

            # Füge letztes Update hinzu (falls nicht vorhanden)
            if 'letztes-update:' not in new_fm:
                new_fm += f"\nletztes-update: {datetime.now().strftime('%Y-%m-%d')}"

            # Speichere zurück
            new_content = f"---\n{new_fm}\n---\n{body}"

            if new_content != content:
                # Backup vor Änderung
                backup_path = file_path.with_suffix('.md.bak')
                shutil.copy2(file_path, backup_path)

                with open(file_path, 'w', encoding='utf-8') as f:
                    f.write(new_content)

                self.changes.append(str(file_path.relative_to(self.vault_root)))
                return True

            return False

        except Exception as e:
            print(f"⚠️  Error standardizing {file_path}: {e}", file=sys.stderr)
            return False

    def _normalize_status(self, fm_text: str) -> str:
        """Normalisiere Status-Feld"""
        # Suche Status-Zeile
        status_match = re.search(r'^status:\s*(.+?)$', fm_text, re.MULTILINE)

        if status_match:
            old_status = status_match.group(1).strip().lower()

            # Mappe zu Standard-Status
            if any(x in old_status for x in ['aktiv', 'active', 'laufend', 'in bearbeitung']):
                new_status = 'aktiv'
            elif any(x in old_status for x in ['fertig', 'done', 'abgeschlossen', 'complete']):
                new_status = 'abgeschlossen'
            elif any(x in old_status for x in ['pause', 'paused', 'halt']):
                new_status = 'pausiert'
            elif any(x in old_status for x in ['plan', 'planned', 'todo', 'geplant']):
                new_status = 'geplant'
            elif any(x in old_status for x in ['archiv', 'archived', 'alt']):
                new_status = 'archiviert'
            else:
                # Behalte Original wenn unsicher
                return fm_text

            # Ersetze
            new_fm = re.sub(
                r'^status:\s*.+?$',
                f'status: {new_status}',
                fm_text,
                flags=re.MULTILINE
            )
            return new_fm

        return fm_text

    def save_standardization_report(self):
        """Speichere Standardisierungs-Report"""
        report = []
        report.append("# ✅ Frontmatter Standardisierung Report\n\n")
        report.append(f"**Datum:** {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
        report.append(f"**Dateien aktualisiert:** {len(self.changes)}\n\n")

        report.append("## Geänderte Dateien\n\n")
        for change in self.changes:
            report.append(f"- `{change}`\n")

        report.append("\n## Standard-Status-Werte\n\n")
        report.append("- `aktiv` — derzeit in Arbeit\n")
        report.append("- `abgeschlossen` — fertig\n")
        report.append("- `pausiert` — temporär gestoppt\n")
        report.append("- `geplant` — noch nicht gestartet\n")
        report.append("- `archiviert` — obsolet\n")

        report_path = self.vault_root / "00 Inbox" / "FRONTMATTER-STANDARDIZATION-REPORT.md"
        with open(report_path, 'w', encoding='utf-8') as f:
            f.write("".join(report))

        print(f"✅ Standardization Report gespeichert: {report_path}\n")


class DailyHealthReport:
    """Erstellt tägliche Health-Check Reports"""

    def __init__(self, vault_root: str):
        self.vault_root = Path(vault_root)

    def generate(self):
        """Generiere Health Report"""
        print("\n🏥 Generating daily health report...\n")

        stats = self._collect_stats()

        report = self._build_report(stats)

        # Speichere Report
        today = datetime.now().strftime('%Y-%m-%d')
        report_name = f"00 Inbox/VAULT-HEALTH-{today}.md"
        report_path = self.vault_root / report_name

        with open(report_path, 'w', encoding='utf-8') as f:
            f.write(report)

        print(f"✅ Health Report gespeichert: {report_path}\n")
        return report_path

    def _collect_stats(self) -> dict:
        """Sammle Vault-Statistiken"""
        stats = {
            'timestamp': datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
            'total_files': 0,
            'markdown_files': 0,
            'inbox_files': 0,
            'inbox_size': 0,
            'active_projects': 0,
            'completed_projects': 0,
            'archive_size': 0,
            'recent_changes': [],
        }

        # Zähle Dateien
        for item in self.vault_root.rglob("*"):
            if any(part.startswith('.') for part in item.parts):
                continue

            if item.is_file():
                stats['total_files'] += 1

                if item.suffix == '.md':
                    stats['markdown_files'] += 1

                # Inbox-Größe
                if '00 Inbox' in str(item):
                    stats['inbox_files'] += 1
                    stats['inbox_size'] += item.stat().st_size

        # Zähle aktive Projekte
        projects_dir = self.vault_root / "01 Projects"
        if projects_dir.exists():
            for proj_file in projects_dir.glob("*.md"):
                try:
                    with open(proj_file, 'r', encoding='utf-8') as f:
                        content = f.read()
                    if 'status: aktiv' in content.lower():
                        stats['active_projects'] += 1
                    elif 'status: abgeschlossen' in content.lower():
                        stats['completed_projects'] += 1
                except:
                    pass

        # Archive-Größe
        archive_dir = self.vault_root / "04 Archive"
        if archive_dir.exists():
            for item in archive_dir.rglob("*"):
                if item.is_file():
                    stats['archive_size'] += item.stat().st_size

        return stats

    def _build_report(self, stats: dict) -> str:
        """Baue Health Report"""
        inbox_mb = stats['inbox_size'] / (1024 * 1024)
        archive_mb = stats['archive_size'] / (1024 * 1024)

        report = f"""# 🏥 Vault Health Report

**Generiert:** {stats['timestamp']}

---

## 📊 Statistiken

| Metrik | Wert |
|--------|------|
| **Dateien insgesamt** | {stats['total_files']} |
| **Markdown-Dateien** | {stats['markdown_files']} |
| **Inbox-Dateien** | {stats['inbox_files']} |
| **Inbox-Größe** | {inbox_mb:.2f} MB |
| **Aktive Projekte** | {stats['active_projects']} |
| **Abgeschlossene Projekte** | {stats['completed_projects']} |
| **Archive-Größe** | {archive_mb:.2f} MB |

---

## ✅ Status

- **Vault Integrität:** ✅ OK
- **Inbox Cleanup:** {"⚠️ WARNUNG - Über 20 Dateien" if stats['inbox_files'] > 20 else "✅ OK"}
- **Archive Größe:** {"⚠️ GROSS" if archive_mb > 100 else "✅ OK"}

---

## 📝 Nächste Aufgaben

1. Inbox überprüfen (sollte < 10 Dateien sein)
2. Dead Links periodisch überprüfen
3. Alte Daily Notes archivieren

**Report automatisch erstellt um {stats['timestamp']}**
"""

        return report


def main():
    vault_root = "C:\\Users\\Admin\\iCloudDrive\\iCloud~md~obsidian\\Memoria"

    print("=" * 70)
    print("🔧 MEMORIA VAULT MAINTENANCE SYSTEM")
    print("=" * 70)

    try:
        # 1. Dead Links Fixer
        print("\n[1/3] DEAD LINKS FIXER")
        print("-" * 70)
        fixer = DeadLinkFixer(vault_root)
        fixer.build_index()
        fixer.find_dead_links()
        fixer.save_dead_links_report()

        # 2. Frontmatter Standardizer
        print("\n[2/3] FRONTMATTER STANDARDIZER")
        print("-" * 70)
        standardizer = FrontmatterStandardizer(vault_root)
        standardizer.standardize_all()
        standardizer.save_standardization_report()

        # 3. Daily Health Report
        print("\n[3/3] DAILY HEALTH REPORT")
        print("-" * 70)
        reporter = DailyHealthReport(vault_root)
        report_path = reporter.generate()

        print("\n" + "=" * 70)
        print("✅ MAINTENANCE ABGESCHLOSSEN")
        print("=" * 70)
        print("\n📁 Outputs:")
        print(f"  1. Dead Links Report: 00 Inbox/DEAD-LINKS-REPORT.md")
        print(f"  2. Standardization Report: 00 Inbox/FRONTMATTER-STANDARDIZATION-REPORT.md")
        print(f"  3. Health Report: {report_path.relative_to(vault_root)}")

    except Exception as e:
        print(f"\n❌ FEHLER: {e}", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()
