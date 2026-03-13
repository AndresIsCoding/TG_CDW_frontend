@echo off
cd /d "%~dp0.."
serve -s build/web -l 3000
pause
