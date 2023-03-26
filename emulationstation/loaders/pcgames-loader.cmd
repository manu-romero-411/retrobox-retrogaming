@echo off &SETLOCAL ENABLEDELAYEDEXPANSION

rem ## VARIABLES DE ENTORNO
set gamedir=%1
set realpath=%~dp0
set rbpath=%realpath%\..\..
set retroboxroot=
pushd %rbpath%
set retroboxroot=%CD%
popd

set antimicroExec="%retroboxroot%\misc\tools\antimicro\bin\antimicrox.exe"

rem ## BUSCAR O CREAR PERFIL DE ANTIMICRO PARA EL MANDO
set basename=""
for %%i in (%gamedir%) do set basename=%%~ni
for %%F in (%gamedir%) do set dirname=%%~dpF
cd %dirname%

set profiledir=%retroboxroot%\emuladores\pcgames-loader\antimicro\%basename:"=%.gamecontroller.amgp

if NOT exist %profiledir% (
	copy %retroboxroot%\emuladores\pcgames-loader\antimicro\base.gamecontroller.amgp %profiledir%
)

rem ## SI EL JUEGO ES DE ALGUNA TIENDA DE JUEGOS, UTILIZAR EL SCRIPT ESPECIAL
((echo %gamedir% | findstr epic) || (echo %gamedir% | findstr steam) || (echo %gamedir% | findstr uplay)) && (
	call %realpath%\pcloader_epic-uplay-steam.cmd %gamedir% %profiledir%
	goto :FIN
)

rem ## SI EL JUEGO ES PIRATA, FANGAME O NO ES DE TIENDAS, SEGUIR POR AQUÍ
rem ## CARGAR PERFIL DE ANTIMICRO PARA EL MANDO, Y SCRIPT DE AUTOHOTKEY PARA DESVIAR PULSACIONES A LAS TECLAS -*/
start /b "" %retroboxroot%\misc\ahks\new_close.exe
start /b "" %antimicroexec% --profile %profiledir%			

rem ## EJECUTAR JUEGO
%gamedir%

rem ## CERRAR ANTIMICRO Y SCRIPT DE AUTOHOTKEY
tasklist /nh /fi "imagename eq antimicrox.exe" | find /i "antimicrox.exe" && taskkill /IM antimicrox.exe /F
tasklist /nh /fi "imagename eq new_close.exe" | find /i "new_close.exe" && taskkill /IM new_close.exe /F

rem ## DESENGANCHAR TECLA ALT, QUE SE QUEDA COMO "BLOQUEADA"
start /b "" %retroboxroot%\misc\ahks\alt_key_unhang.exe
timeout /t 1

rem ## DEVOLVER EL CONTROL A EMULATIONSTATION
goto :FIN

rem ## CAZAERRORES
:ERROR
echo ERROR
exit 1

rem ## SALIDA SEGURA DEL SCRIPT
:FIN
@exit 0