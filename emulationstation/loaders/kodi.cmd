@echo off

rem ## VARIABLES DE ENTORNO
set realpath=%~dp0
set rbpath=%realpath%\..\..
set retroboxroot=
pushd %rbpath%
set retroboxroot=%CD%
popd

set antimicroExec="%retroboxroot%\misc\tools\antimicro\bin\antimicrox.exe"
set kodipath="C:\Program Files\Kodi\kodi.exe"
set acestreampath="%appdata%\ACEStream\engine\ace_engine.exe"

rem ## CARGAR PERFIL DE ANTIMICRO PARA PODER CERRAR KODI CON EL MANDO
start /b "" %antimicroexec% --profile %retroboxroot%\misc\gamepad-profiles\redream.gamecontroller.amgp

rem ## INICIAR ACESTREAM (PARA CRISTAL AZUL, WINNER SPORTS Y BALANDRO)
start /b "" %acestreampath%

rem ## INICIAR KODI
%kodipath%

rem ## TRAS CERRAR KODI, CERRAR PROCESOS DE ACESTREAM
taskkill /IM ace_engine.exe /F
taskkill /IM ace_update.exe /F

rem ## CERRAR ANTIMICRO
taskkill /IM antimicrox.exe /F

rem ## DESENGANCHAR TECLA ALT, QUE SE QUEDA COMO "BLOQUEADA"
start /b "" %retroboxroot%\misc\ahks\alt_key_unhang.exe

rem ### DEVOLVER EL CONTROL A EMULATIONSTATION
goto :FIN
	
rem ## CAZAERRORES
:ERROR
echo ERROR
exit 1

rem ## SALIDA SEGURA DEL SCRIPT
:FIN
exit 0
