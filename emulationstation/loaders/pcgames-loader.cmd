@echo off

rem ## VARIABLES DE ENTORNO
set gamedir=%1
set realpath=%~dp0
set retroboxroot=%realpath%\..\..
set antimicroExec="C:\Program Files\AntimicroX\bin\antimicrox.exe"

rem ## emustation-load-game.bat windows C:\Users\Manuel\retrogaming\extra-menus\pcgames\emustation\steam_bayonetta.cmd

rem ## BUSCAR O CREAR PERFIL DE ANTIMICRO PARA EL MANDO
set basename=""
for %%i in (%gamedir%) do set basename=%%~ni
for %%F in (%gamedir%) do set dirname=%%~dpF
cd %dirname%
if NOT EXIST %dirname:"=%..\xdgAntimicro\%basename:"=%.gamecontroller.amgp (
	copy %dirname:"=%..\xdgAntimicro\base.gamecontroller.amgp %dirname:"=%..\xdgAntimicro\%basename:"=%.gamecontroller.amgp
)
set profiledir=%dirname:"=%..\xdgAntimicro\%basename:"=%.gamecontroller.amgp

if NOT exist %profiledir% (
	copy %dirname:"=%..\xdgAntimicro\base.gamecontroller.amgp %profiledir%
)

rem ## SI EL JUEGO ES DE ALGUNA TIENDA DE JUEGOS, UTILIZAR EL SCRIPT ESPECIAL
((echo %gamedir% | findstr epic) || (echo %gamedir% | findstr steam) || (echo %gamedir% | findstr uplay)) && (
	%realpath%\pcloader_epic-uplay-steam.bat %gamedir% %profiledir%
	goto :FIN
)

rem ## SI EL JUEGO ES PIRATA, FANGAME O NO ES DE TIENDAS, SEGUIR POR AQUÍ
rem ## CARGAR PERFIL DE ANTIMICRO PARA EL MANDO, Y SCRIPT DE AUTOHOTKEY PARA DESVIAR PULSACIONES A LAS TECLAS -*/
start /b cmd /c %retroboxroot%\misc\new_close.exe
start /b cmd /c %antimicroexec% --profile %profiledir%			

rem ## EJECUTAR JUEGO
%gamedir%

rem ## CERRAR ANTIMICRO Y SCRIPT DE AUTOHOTKEY
tasklist /nh /fi "imagename eq antimicrox.exe" | find /i "antimicrox.exe" && taskkill /IM antimicrox.exe /F
tasklist /nh /fi "imagename eq new_close.exe" | find /i "new_close.exe" && taskkill /IM new_close.exe /F
goto :FIN

rem ## CAZAERRORES
:ERROR
echo ERROR
exit 1

rem ## SALIDA SEGURA DEL SCRIPT
:FIN
exit 0