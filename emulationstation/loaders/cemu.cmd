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

rem ## CARGAR ANTIMICRO Y UN SCRIPT DE AUTOHOTKEY ESPECIALMENTE DISEÑADO PARA SALIR DEL EMULADOR
start /b "" %antimicroExec% --hidden --profile %retroboxroot%\misc\gamepad-profiles\cemu.gamecontroller.amgp
start /b "" %retroboxroot%\misc\ahks\cemu_close.exe

rem ## ASÍ CARGA CEMU LOS JUEGOS:
rem ### 1. VA AL DIRECTORIO DE ALGÚN JUEGO EN %retroboxroot%\roms
rem ### 2. SE CARGA UN SCRIPT QUE ALLÍ HABRÁ, CON UNA VARIABLE.
rem ### 3. LA VARIABLE ES UN ARCHIVO CON EXTENSIÓN .rpx.
rem ### 4. CEMU NECESITARÁ CARGAR ESE ARCHIVO, ASÍ QUE LO HACE. CON ESE ARCHIVO INICIARÁ EL JUEGO.
cd %1
set GAMENAME=
call %1\cemu.bat
start /WAIT %EMUDIR%/cemu/Cemu.exe -f -g %1\code\%GAMENAME%

rem ## TRAS CERRAR EL JUEGO, CERRAR TAMBIÉN ANTIMICRO Y EL SCRIPT DE AUTOHOTKEY
taskkill /IM antimicrox.exe /F
taskkill /IM cemu_close.exe /F

rem ## DESENGANCHAR TECLA ALT, QUE SE QUEDA COMO "BLOQUEADA"
start /b "" %retroboxroot%\misc\ahks\alt_key_unhang.exe

rem ## DEVOLVER EL CONTROL A EMULATIONSTATION
goto :FIN

rem ## CAZAERRORES
:ERROR
echo ERROR
exit 1

rem ## SALIDA SEGURA DEL SCRIPT
:FIN
exit 0
