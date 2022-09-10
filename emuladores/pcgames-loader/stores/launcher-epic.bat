@echo off

echo " " > D:\.noreboot
cd "C:\Program Files (x86)\Epic Games\Launcher\Portal\Binaries\Win32\"
start /b cmd /c "C:\Program Files (x86)\Epic Games\Launcher\Portal\Binaries\Win32\EpicGamesLauncher.exe"
taskkill /IM emulationstation.exe /F