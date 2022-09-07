@echo off

rem ## VARIABLES DE ENTORNO
set realpath=%~dp0
set retroboxroot=%realpath%\..\..
set EMUDIR=%retroboxroot%\emuladores
set antimicroExec="C:\Program Files\AntimicroX\bin\antimicrox.exe"

if [%1]==[] goto :ERROR
set rom=%1

rem ## CARGAR PERFIL DE ANTIMICRO ESPECIAL PARA CEMU
start /b cmd /c %antimicroExec% --hidden --profile %retroboxroot%\gamepad-profiles\redream.gamecontroller.amgp

rem ## ASÍ CARGA CEMU LOS JUEGOS:
rem ### 1. VA AL DIRECTORIO DE ALGÚN JUEGO EN %retroboxroot%\roms
rem ### 2. SE CARGA UN SCRIPT QUE ALLÍ HABRÁ, CON UNA VARIABLE.
rem ### 3. LA VARIABLE ES UN ARCHIVO CON EXTENSIÓN .rpx.
rem ### 4. CEMU NECESITARÁ CARGAR ESE ARCHIVO, ASÍ QUE LO HACE. CON ESE ARCHIVO INICIARÁ EL JUEGO.
cd %1
set GAMENAME=
call %1\cemu.bat
start /WAIT %EMUDIR%/cemu/Cemu.exe -f -g %1\code\%GAMENAME%

rem ## AL TERMINAR DE JUGAR, CERRAR ANTIMICRO
taskkill /IM antimicrox.exe /F

rem ## DEVOLVER EL CONTROL A EMULATIONSTATION
goto :FIN

rem ## CAZAERRORES
:ERROR
echo ERROR
exit 1

rem ## SALIDA SEGURA DEL SCRIPT
:FIN
exit 0
