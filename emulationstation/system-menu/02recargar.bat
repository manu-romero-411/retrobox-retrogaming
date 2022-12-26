@echo off

echo " " > D:\.no-reboot
taskkill /IM emulationstation.exe /F
timeout /t 2
start /b "" D:\Juegos\retrogaming\misc\silentcmd-windows\SilentCMD.exe D:\Juegos\retrogaming\retrobox.cmd -b