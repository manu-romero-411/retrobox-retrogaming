@echo off

rem ## VARIABLES DE ENTORNO
set realpath=%~dp0
set retroboxroot=%realpath%\..\..
set EMUDIR=%retroboxroot%\emuladores
set antimicroExec="C:\Program Files\AntimicroX\bin\antimicrox.exe"

if [%1]==[] goto :ERROR
set rom=%1

REM ## CARGAR PERFIL DE ANTIMICRO 
start /b cmd /c %antimicroExec% --hidden --profile %retroboxroot%\gamepad-profiles\redream.gamecontroller.amgp

REM ## INICIAR EMULADOR
%EMUDIR%\ppsspp\PPSSPPWindows64.exe %1 --escape-exit

REM ## CERRAR ANTIMICRO TRAS SALIR DEL JUEGO
taskkill /IM antimicrox.exe /F

REM ## DEVOLVER EL CONTROL A EMULATIONSTATION
goto :FIN
	
rem ## CAZAERRORES
:ERROR
echo ERROR
exit 1

rem ## SALIDA SEGURA DEL SCRIPT
:FIN
exit 0

