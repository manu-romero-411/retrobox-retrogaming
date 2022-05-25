@echo on
cls
set realpath=%~dp0
set retroboxroot=%realpath%\..\..
set EMUDIR=%retroboxroot%\emuladores
rem set antimicroExec=start /b cmd /c  "C:\Program Files\AntimicroX\bin\antimicrox.exe"
rem start /b cmd /c %antimicroExec% --hidden --profile D:\Juegos\retrogaming\gamepad-profiles\redream.gamecontroller.amgp

start /wait %EMUDIR%\dolphin\Dolphin.exe -b -e %1

remtaskkill /IM antimicrox.exe /F