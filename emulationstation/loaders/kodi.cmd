@echo off

rem ## VARIABLES DE ENTORNO
set realpath=%~dp0
set retroboxroot=%realpath%\..\..
set antimicroExec="C:\Program Files\AntimicroX\bin\antimicrox.exe"
set kodipath="C:\Program Files\Kodi\kodi.exe"
set acestreampath="%appdata%\ACEStream\engine\ace_engine.exe"

rem ## CARGAR PERFIL DE ANTIMICRO PARA PODER CERRAR KODI CON EL MANDO
start /b cmd /c %antimicroexec% --profile %retroboxroot%\gamepad-profiles\redream.gamecontroller.amgp

rem ## INICIAR ACESTREAM (PARA CRISTAL AZUL, WINNER SPORTS Y BALANDRO)
start /b cmd /c %acestreampath%

rem ## INICIAR KODI
%kodipath%

rem ## TRAS CERRAR KODI, CERRAR PROCESOS DE ACESTREAM
taskkill /IM ace_engine.exe /F
taskkill /IM ace_update.exe /F

rem ## CERRAR ANTIMICRO
taskkill /IM antimicrox.exe /F

rem ### DEVOLVER EL CONTROL A EMULATIONSTATION
goto :FIN
	
rem ## CAZAERRORES
:ERROR
echo ERROR
exit 1

rem ## SALIDA SEGURA DEL SCRIPT
:FIN
exit 0
