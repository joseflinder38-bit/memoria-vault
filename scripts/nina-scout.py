import json
from datetime import datetime
from jobspy import scrape_jobs
import os

vault_path = r'C:\Users\Admin\iCloudDrive\iCloud~md~obsidian\Memoria'
output_file = os.path.join(vault_path, '02 Areas', 'Jobsuche', f'Jobs_{datetime.now().strftime("%Y-%m-%d")}.md')

print("Starting Nina Scout job search...")

try:
    jobs = scrape_jobs(
        site_name=['indeed', 'linkedin', 'glassdoor'],
        search_term='Kaufmann BÃ¼ro OR Arbeitssicherheit OR Gefahrstoff',
        location='Heistenbach, Rheinland-Pfalz',
        radius=30,
        hours_old=24,
        results_wanted=30
    )

    print(f"Found {len(jobs)} jobs")

    if len(jobs) > 0:
        markdown = f"# Jobs Report - {datetime.now().strftime('%Y-%m-%d %H:%M')}\n\n"
        markdown += "| Match | Firma | Position | Ort | Gehalt |\n"
        markdown += "|-------|-------|----------|-----|--------|\n"

        for job in jobs[:15]:
            match = 70
            if 'Gefahrstoff' in str(job.get('description', '')).upper():
                match = 90
            if 'Montabaur' in str(job.get('location', '')).upper():
                match = min(100, match + 5)

            icon = 'ðŸ”¥' if match >= 80 else 'ðŸ‘' if match >= 70 else 'ðŸ¤”'
            firma = str(job.get('company', 'N/A'))[:30]
            position = str(job.get('title', 'N/A'))[:30]
            ort = str(job.get('location', 'N/A'))[:20]
            gehalt = str(job.get('salary_source', ''))[:15]

            markdown += f"| {icon} {match}% | {firma} | {position} | {ort} | {gehalt} |\n"

        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(markdown)

        print(f"Saved to: {output_file}")
    else:
        print("No jobs found")

except Exception as e:
    print(f"Error: {e}")
