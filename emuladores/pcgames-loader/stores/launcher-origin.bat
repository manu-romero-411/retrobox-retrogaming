@echo off &SETLOCAL ENABLEDELAYEDEXPANSION

echo " " > D:\.noreboot
taskkill /IM emulationstation.exe /F
cd "C:\Program Files\Electronic Arts\EA Desktop\EA Desktop\"
start /b "" "C:\Program Files\Electronic Arts\EA Desktop\EA Desktop\EALauncher.exe"
