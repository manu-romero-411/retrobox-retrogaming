@echo on
cls
set realpath=%~dp0
set retroboxroot=%realpath%\..\..
set EMUDIR=%retroboxroot%\emuladores
set antimicroExec=start /b cmd /c  "C:\Program Files\AntimicroX\bin\antimicrox.exe"
start /b cmd /c %antimicroExec% --hidden --profile D:\Juegos\retrogaming\gamepad-profiles\redream.gamecontroller.amgp

start /wait %EMUDIR%\redream\redream.exe %1

taskkill /IM antimicrox.exe /F