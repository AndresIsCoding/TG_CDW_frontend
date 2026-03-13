@echo off
cd /d "%~dp0.."
serve -s build/web -l 5000
pause
