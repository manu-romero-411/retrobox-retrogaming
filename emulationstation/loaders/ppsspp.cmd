@echo off

rem ## VARIABLES DE ENTORNO
set realpath=%~dp0
set rbpath=%realpath%\..\..
set retroboxroot=
pushd %rbpath%
set retroboxroot=%CD%
popd

set EMUDIR=%retroboxroot%\emuladores
set antimicroExec="%retroboxroot%\misc\tools\antimicro\bin\antimicrox.exe"

if [%1]==[] goto :ERROR
set rom=%1
for %%F in (%rom%) do set dirname=%%~dpF
set "dirname=%dirname:\=/%"

REM ## CARGAR ANTIMICRO Y UN SCRIPT DE AUTOHOTKEY ESPECIALMENTE DISEÑADO PARA SALIR DEL EMULADOR
start /b "" %antimicroExec% --hidden --profile %retroboxroot%\misc\gamepad-profiles\ppsspp.gamecontroller.amgp
start /b "" %retroboxroot%\misc\ahks\ppsspp_close.exe

rem ## AJUSTAR DIRECTORIOS DE BIOS, MEMORY CARDS E ISOS DEL EMULADOR
%retroboxroot%\misc\tools\sed.exe -i s#directorio#%dirname%#g %EMUDIR%\ppsspp\memstick\PSP\SYSTEM\ppsspp.ini

REM ## INICIAR EMULADOR
%EMUDIR%\ppsspp\PPSSPPWindows64.exe %1 --escape-exit

REM ## PARA ASEGURAR QUE TODA LA CONFIGURACIÓN ES PORTABLE, VOLVER A COLOCAR EL VALOR CENTINELA EN LA CONFIG DE PPSSPP
set "dirname=%dirname:~0,-1%"
%retroboxroot%\misc\tools\sed.exe -i s#%dirname%#directorio#g %EMUDIR%\ppsspp\memstick\PSP\SYSTEM\ppsspp.ini

REM ## TRAS CERRAR EL JUEGO, CERRAR TAMBIÉN ANTIMICRO Y EL SCRIPT DE AUTOHOTKEY
taskkill /IM antimicrox.exe /F
taskkill /IM ppsspp_close.exe /F

rem ## DESENGANCHAR TECLA ALT, QUE SE QUEDA COMO "BLOQUEADA"
start /b "" %retroboxroot%\misc\ahks\alt_key_unhang.exe

REM ## DEVOLVER EL CONTROL A EMULATIONSTATION
goto :FIN
	
rem ## CAZAERRORES
:ERROR
echo ERROR
exit 1

rem ## SALIDA SEGURA DEL SCRIPT
:FIN
exit 0