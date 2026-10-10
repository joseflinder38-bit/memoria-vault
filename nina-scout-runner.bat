@echo off
cd /d "%USERPROFILE%\iCloudDrive\iCloud~md~obsidian\Memoria"
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "02 Areas\Pers?nliche Daten\Privat\nina-scout-daily-jobsearch.ps1"
exit /b %ERRORLEVEL%
