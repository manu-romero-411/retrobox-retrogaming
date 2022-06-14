@echo on
cls
set realpath=%~dp0
set retroboxroot=%realpath%\..\..
set EMUDIR=E:\Juegos\emuladores
set antimicroExec=start /b cmd /c  "C:\Program Files\AntimicroX\bin\antimicrox.exe"
start /b cmd /c %antimicroExec% --hidden --profile %retroboxroot%\gamepad-profiles\redream.gamecontroller.amgp

start /wait %EMUDIR%\redream\redream.exe %1

taskkill /IM antimicrox.exe /F