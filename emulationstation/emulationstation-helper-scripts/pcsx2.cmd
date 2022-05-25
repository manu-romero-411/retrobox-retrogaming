@echo on
cls
set realpath=%~dp0
set retroboxroot=%realpath%\..\..
set EMUDIR=%retroboxroot%\emuladores
set antimicroExec=start /b cmd /c  "C:\Program Files\AntimicroX\bin\antimicrox.exe"
start /b cmd /c %antimicroExec% --hidden --profile D:\Juegos\retrogaming\gamepad-profiles\pcsx2.gamecontroller.amgp
start /b cmd /c %retroboxroot%\misc\pcsx2-close.exe

start /wait %EMUDIR%\pcsx2\pcsx2x64-avx2.exe --nogui --fullscreen --fullboot %1

taskkill /IM antimicrox.exe /F
taskkill /IM pcsx2-close.exe /F