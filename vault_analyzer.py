#!/usr/bin/env python3
"""
Obsidian Vault Analyzer for Memoria
=====================================
Analysiert die Vault-Struktur, generiert Statistiken und Reports.

REGELN:
- KEINE sensiblen Daten aus 02 Areas/Persönliche Daten exportieren
- Nur strukturelle Informationen (Dateianzahl, Tags, Status)
- Inhalte von Dateien nur bei expliziter Freigabe lesen
"""

import os
import json
import re
from pathlib import Path
from datetime import datetime
from collections import defaultdict
import sys

# Windows UTF-8 Fix
if sys.platform == 'win32':
    import io
    sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')

class VaultAnalyzer:
    def __init__(self, vault_root: str):
        self.vault_root = Path(vault_root)
        self.stats = {
            'total_files': 0,
            'total_folders': 0,
            'files_by_folder': defaultdict(int),
            'markdown_files': [],
            'tags': defaultdict(int),
            'status_values': defaultdict(int),
            'wikilinks': [],
            'dead_links': [],
            'frontmatter_count': 0,
        }

    def scan(self):
        """Vollständiger Scan der Vault-Struktur"""
        print("🔍 Scanning vault...\n")

        for item in self.vault_root.rglob("*"):
            # Ignoriere .obsidian, .git und andere Systemordner
            if any(part.startswith('.') for part in item.parts):
                continue

            if item.is_file():
                self.stats['total_files'] += 1

                # Kategorisiere nach Ordner
                rel_path = item.relative_to(self.vault_root)
                folder = str(rel_path.parent)
                self.stats['files_by_folder'][folder] += 1

                # Lese nur Markdown-Dateien
                if item.suffix == '.md':
                    self.stats['markdown_files'].append(str(rel_path))
                    self._analyze_markdown(item)

            elif item.is_dir():
                self.stats['total_folders'] += 1

    def _analyze_markdown(self, file_path: Path):
        """Extrahiere Frontmatter und Wikilinks (OHNE Inhalte)"""
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()

            # Extrahiere Frontmatter (YAML)
            fm_match = re.match(r'^---\n(.*?)\n---', content, re.DOTALL)
            if fm_match:
                self.stats['frontmatter_count'] += 1
                fm_text = fm_match.group(1)

                # Extrahiere Status
                status_match = re.search(r'status:\s*(.+?)$', fm_text, re.MULTILINE)
                if status_match:
                    status = status_match.group(1).strip()
                    self.stats['status_values'][status] += 1

                # Extrahiere Tags
                tags_match = re.search(r'tags:\s*\[(.*?)\]', fm_text)
                if tags_match:
                    tags_str = tags_match.group(1)
                    tags = [t.strip().strip("'\"") for t in tags_str.split(',')]
                    for tag in tags:
                        if tag:
                            self.stats['tags'][tag] += 1

            # Finde Wikilinks: [[...]]
            wikilinks = re.findall(r'\[\[([^\]]+)\]\]', content)
            for link in wikilinks:
                self.stats['wikilinks'].append({
                    'from': str(file_path.relative_to(self.vault_root)),
                    'to': link
                })

        except Exception as e:
            print(f"⚠️  Fehler beim Lesen {file_path}: {e}", file=sys.stderr)

    def check_dead_links(self):
        """Finde Wikilinks zu nicht-existierenden Dateien"""
        print("🔗 Checking for dead links...\n")

        # Erstelle Set aller existierenden Files (ohne Extension)
        existing = set()
        for md_file in self.stats['markdown_files']:
            # Titel (ohne .md)
            name = Path(md_file).stem
            existing.add(name)
            # Voller Pfad (mit und ohne .md)
            existing.add(md_file)
            existing.add(md_file.replace('.md', ''))

        dead_count = 0
        for link_info in self.stats['wikilinks']:
            target = link_info['to'].strip()
            # Entferne Ankörper (#section)
            target_base = target.split('#')[0]

            # Checke ob Ziel existiert
            if target_base and not self._exists_in_vault(target_base):
                self.stats['dead_links'].append(link_info)
                dead_count += 1

        print(f"⚠️  {dead_count} Dead Links gefunden\n")
        return dead_count

    def _exists_in_vault(self, link_target: str) -> bool:
        """Prüfe ob ein Wikilink zu einer existierenden Datei zeigt"""
        # Versuche verschiedene Varianten
        variants = [
            link_target + '.md',
            link_target.replace('/', '\\') + '.md',
            link_target.replace('\\', '/') + '.md',
        ]

        for variant in variants:
            if (self.vault_root / variant).exists():
                return True

        return False

    def generate_report(self, output_file: str = None):
        """Generiere einen strukturierten Report"""
        report = []
        report.append("# 📊 Vault Analyse Report\n")
        report.append(f"**Generiert:** {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
        report.append("---\n\n")

        # Zusammenfassung
        report.append("## 📈 Zusammenfassung\n\n")
        report.append(f"- **Dateien insgesamt:** {self.stats['total_files']}\n")
        report.append(f"- **Markdown-Dateien:** {len(self.stats['markdown_files'])}\n")
        report.append(f"- **Ordner:** {self.stats['total_folders']}\n")
        report.append(f"- **Mit Frontmatter:** {self.stats['frontmatter_count']}\n")
        report.append(f"- **Wikilinks:** {len(self.stats['wikilinks'])}\n")
        report.append(f"- **Dead Links:** {len(self.stats['dead_links'])}\n\n")

        # Dateien pro Ordner
        report.append("## 📁 Dateien nach Ordner\n\n")
        for folder in sorted(self.stats['files_by_folder'].keys()):
            count = self.stats['files_by_folder'][folder]
            report.append(f"- `{folder}`: {count} Dateien\n")
        report.append("\n")

        # Status-Verteilung
        if self.stats['status_values']:
            report.append("## 🎯 Status-Verteilung\n\n")
            for status, count in sorted(self.stats['status_values'].items(), key=lambda x: -x[1]):
                report.append(f"- **{status}**: {count}\n")
            report.append("\n")

        # Tags
        if self.stats['tags']:
            report.append("## 🏷️ Tags (Top 15)\n\n")
            top_tags = sorted(self.stats['tags'].items(), key=lambda x: -x[1])[:15]
            for tag, count in top_tags:
                report.append(f"- `{tag}`: {count}\n")
            report.append("\n")

        # Dead Links (falls vorhanden)
        if self.stats['dead_links']:
            report.append("## ⚠️ Dead Links\n\n")
            report.append("| Von | Zu |\n")
            report.append("|-----|----|\n")
            for link in self.stats['dead_links'][:20]:  # Top 20
                report.append(f"| `{link['from']}` | `[[{link['to']}]]` |\n")
            report.append("\n")

        # Zusammensetzung
        report.append("## 🗂️ Vault-Zusammensetzung\n\n")
        report.append("```\n")
        for line in self._tree_structure():
            report.append(line + "\n")
        report.append("```\n")

        report_text = "".join(report)

        # Speichere oder gebe aus
        if output_file:
            with open(output_file, 'w', encoding='utf-8') as f:
                f.write(report_text)
            print(f"✅ Report gespeichert: {output_file}\n")

        return report_text

    def _tree_structure(self, path=None, prefix="", max_depth=3, current_depth=0):
        """Generiere eine Tree-View der Struktur"""
        if path is None:
            path = self.vault_root

        lines = []

        if current_depth >= max_depth:
            return lines

        try:
            items = sorted(path.iterdir(), key=lambda x: (not x.is_dir(), x.name))
        except PermissionError:
            return lines

        dirs = [i for i in items if i.is_dir() and not i.name.startswith('.')]
        files = [i for i in items if i.is_file() and not i.name.startswith('.')]

        # Zeige Ordner
        for i, dir_item in enumerate(dirs):
            is_last = (i == len(dirs) - 1) and len(files) == 0
            lines.append(f"{prefix}{'└── ' if is_last else '├── '}{dir_item.name}/")

            new_prefix = prefix + ("    " if is_last else "│   ")
            lines.extend(self._tree_structure(dir_item, new_prefix, max_depth, current_depth + 1))

        # Zeige Dateien (begrenzt)
        for i, file_item in enumerate(files[:5]):  # Max 5 Dateien pro Ordner
            is_last = i == len(files) - 1
            lines.append(f"{prefix}{'└── ' if is_last else '├── '}{file_item.name}")

        if len(files) > 5:
            lines.append(f"{prefix}    ... und {len(files) - 5} weitere Dateien")

        return lines

    def export_json(self, output_file: str):
        """Exportiere Statistiken als JSON (OHNE sensible Daten)"""
        export_data = {
            'timestamp': datetime.now().isoformat(),
            'vault_stats': {
                'total_files': self.stats['total_files'],
                'total_folders': self.stats['total_folders'],
                'markdown_files': len(self.stats['markdown_files']),
                'files_with_frontmatter': self.stats['frontmatter_count'],
            },
            'files_by_folder': dict(self.stats['files_by_folder']),
            'status_distribution': dict(self.stats['status_values']),
            'top_tags': dict(sorted(self.stats['tags'].items(), key=lambda x: -x[1])[:10]),
            'dead_links_count': len(self.stats['dead_links']),
        }

        with open(output_file, 'w', encoding='utf-8') as f:
            json.dump(export_data, f, indent=2, ensure_ascii=False)

        print(f"✅ JSON exportiert: {output_file}\n")


def main():
    vault_root = "C:\\Users\\Admin\\iCloudDrive\\iCloud~md~obsidian\\Memoria"

    print("=" * 60)
    print("🧠 MEMORIA VAULT ANALYZER")
    print("=" * 60)
    print()

    analyzer = VaultAnalyzer(vault_root)

    # Führe Analysen durch
    analyzer.scan()
    analyzer.check_dead_links()

    # Generiere Report
    report = analyzer.generate_report()
    print(report)

    # Speichere Report in Vault
    report_file = Path(vault_root) / "00 Inbox" / "VAULT-ANALYZER-REPORT.md"
    report_file.parent.mkdir(parents=True, exist_ok=True)
    with open(report_file, 'w', encoding='utf-8') as f:
        f.write(report)

    # Exportiere JSON
    json_file = Path(vault_root) / "00 Inbox" / "vault-stats.json"
    analyzer.export_json(str(json_file))

    print("=" * 60)
    print("✅ ANALYSE ABGESCHLOSSEN")
    print("=" * 60)


if __name__ == "__main__":
    main()
