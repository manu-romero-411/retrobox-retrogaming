@echo off

echo " " > D:\.noreboot
cd /d "C:\Program Files (x86)\Steam\"
start /b "" "C:\Program Files (x86)\Steam\Steam.exe"
taskkill /IM emulationstation.exe  /F