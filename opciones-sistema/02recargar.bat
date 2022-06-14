@echo off

echo " " > D:\.no-reboot
taskkill /IM emulationstation.exe /F
timeout /t 2
start /b cmd /c D:\Juegos\retrogaming\misc\silentcmd-windows\SilentCMD.exe D:\Juegos\retrogaming\retrobox.bat -fromwin