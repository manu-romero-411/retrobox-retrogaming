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
for %%F in (%rom%) do set dirname=%%~dpF
set "dirname=%dirname:\=/%"

REM ## CARGAR PERFIL DE ANTIMICRO 
start /b cmd /c %antimicroExec% --hidden --profile %retroboxroot%\misc\gamepad-profiles\redream.gamecontroller.amgp

rem ## AJUSTAR DIRECTORIOS DE BIOS, MEMORY CARDS E ISOS DEL EMULADOR
cscript %retroboxroot%\misc\tools\replace.vbs %EMUDIR%\ppsspp\memstick\PSP\SYSTEM\ppsspp.ini directorio %dirname%

REM ## INICIAR EMULADOR
%EMUDIR%\ppsspp\PPSSPPWindows64.exe %1 --escape-exit

REM ## PARA ASEGURAR QUE TODA LA CONFIGURACIÓN ES PORTABLE, VOLVER A COLOCAR EL VALOR CENTINELA EN LA CONFIG DE PPSSPP
set "dirname=%dirname:~0,-1%"
cscript %retroboxroot%\misc\tools\replace.vbs %EMUDIR%\ppsspp\memstick\PSP\SYSTEM\ppsspp.ini %dirname% directorio

REM ## CERRAR ANTIMICRO TRAS SALIR DEL JUEGO
taskkill /IM antimicrox.exe /F

rem ## DESENGANCHAR TECLA ALT, QUE SE QUEDA COMO "BLOQUEADA"
start /b cmd /c %retroboxroot%\misc\ahks\alt_key_unhang.exe

REM ## DEVOLVER EL CONTROL A EMULATIONSTATION
goto :FIN
	
rem ## CAZAERRORES
:ERROR
echo ERROR
exit 1

rem ## SALIDA SEGURA DEL SCRIPT
:FIN
exit 0