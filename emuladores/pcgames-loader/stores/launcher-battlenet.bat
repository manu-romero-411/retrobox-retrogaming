@echo off &SETLOCAL ENABLEDELAYEDEXPANSION

echo " " > D:\.noreboot
cd /d "C:\Program Files (x86)\Battle.net\"
start /b "" "C:\Program Files (x86)\Battle.net\Battle.net Launcher.exe"
taskkill /IM emulationstation.exe  /F