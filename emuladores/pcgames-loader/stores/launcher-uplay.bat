@echo off

echo " " > D:\.noreboot
cd /d "C:\Program Files (x86)\Ubisoft\Ubisoft Game Launcher\"
start /b "" "C:\Program Files (x86)\Ubisoft\Ubisoft Game Launcher\UbisoftConnect.exe"
taskkill /IM emulationstation.exe  /F