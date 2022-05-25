@echo on
cls
set realpath=%~dp0
set retroboxroot=%realpath%\..\..
set EMUDIR=%retroboxroot%\emuladores
set antimicroExec=start /b cmd /c  "C:\Program Files\AntimicroX\bin\antimicrox.exe"
start /b cmd /c %antimicroExec% --hidden --profile %retroboxroot%\gamepad-profiles\redream.gamecontroller.amgp

start /wait %EMUDIR%\ppsspp\PPSSPPWindows64.exe %1 --escape-exit

taskkill /IM antimicrox.exe /F