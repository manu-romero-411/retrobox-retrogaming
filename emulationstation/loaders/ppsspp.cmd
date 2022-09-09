@echo off

rem ## VARIABLES DE ENTORNO
set realpath=%~dp0
set rbpath=%realpath%\..\..
set retroboxroot=
pushd %rbpath%
set retroboxroot=%CD%
popd

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

rem ## DESENGANCHAR TECLA ALT, QUE SE QUEDA COMO "BLOQUEADA"
start /b cmd /c %retroboxroot%\misc\ahks\alt_key_unhang.exe
timeout /t 1

REM ## DEVOLVER EL CONTROL A EMULATIONSTATION
goto :FIN
	
rem ## CAZAERRORES
:ERROR
echo ERROR
exit 1

rem ## SALIDA SEGURA DEL SCRIPT
:FIN
exit 0

