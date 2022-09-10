@echo off

echo " " > D:\.noreboot
cd /d "C:\Program Files (x86)\Battle.net\"
start /b cmd /c "C:\Program Files (x86)\Battle.net\Battle.net Launcher.exe"
taskkill /IM emulationstation.exe  /F