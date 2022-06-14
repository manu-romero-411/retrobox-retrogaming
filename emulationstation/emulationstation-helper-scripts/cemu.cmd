@echo off
cls
set realpath=%~dp0
set retroboxroot=%realpath%\..\..
set EMUDIR=%retroboxroot%\emuladores
set antimicroExec=start /b cmd /c  "C:\Program Files\AntimicroX\bin\antimicrox.exe"
rem start /b cmd /c %antimicroExec% --hidden --profile %retroboxroot%\gamepad-profiles\redream.gamecontroller.amgp
sudo %antimicroExec% --hidden --profile %retroboxroot%\gamepad-profiles\redream.gamecontroller.amgp

cd %1
set GAMENAME=
call %1\cemu.bat
start /WAIT %EMUDIR%/cemu/Cemu.exe -f -g %1\code\%GAMENAME%

sudo taskkill /IM antimicrox.exe /F