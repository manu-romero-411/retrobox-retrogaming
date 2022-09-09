@echo off

echo " " > D:\.noreboot
taskkill /IM emulationstation.exe /F
cd "C:\Program Files\Electronic Arts\EA Desktop\EA Desktop\"
start /b cmd /c "C:\Program Files\Electronic Arts\EA Desktop\EA Desktop\EALauncher.exe"
