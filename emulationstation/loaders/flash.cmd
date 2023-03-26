@echo off &SETLOCAL ENABLEDELAYEDEXPANSION

rem ## VARIABLES DE ENTORNO
set gamedir=%1
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
set basename=""
for %%i in (%gamedir%) do set basename=%%~ni
for %%F in (%gamedir%) do set dirname=%%~dpF

set profiledir="%retroboxroot:"=%\emuladores\flashplayer\profiles\%basename:"=%.gamecontroller.amgp"
rem set profiledir=%retroboxroot%\emuladores\flashplayer\profiles\aaaaa.gamecontroller.amgp
if NOT exist %profiledir% (
	copy %retroboxroot%\emuladores\flashplayer\profiles\base.gamecontroller.amgp "%profiledir:"=%"
)

start /b "" %retroboxroot%\misc\ahks\new_close.exe
start /b "" "%antimicroExec:"=%"  --hidden --profile %profiledir%

rem ## ASÍ CARGA FLASH LOS JUEGOS:
rem ### 1. VA AL DIRECTORIO DE ALGÚN JUEGO EN %retroboxroot%\roms
rem ### 2. SE CARGA UN SCRIPT QUE ALLÍ HABRÁ, CON UNA VARIABLE.
rem ### 3. LA VARIABLE ES UN ARCHIVO CON EXTENSIÓN .swf.
rem ### 4. FLASH NECESITARÁ CARGAR ESE ARCHIVO, ASÍ QUE LO HACE. CON ESE ARCHIVO INICIARÁ EL JUEGO.
cd %1
set GAMENAME=
call %1\flash.bat

start /b %EMUDIR%/flashplayer/flash.exe "%rom:"=%\%GAMENAME:"=%"

rem ## BUCLE PREVIO A LA EJECUCIÓN DEL JUEGO. WORKAROUND PARA PANTALLA COMPLETA
:PRERUN
	tasklist /nh /fi "imagename eq %exefile%" | findstr flash.exe && (
		sleep 2
		start /b "" %retroboxroot%\misc\ahks\ctrl-f.exe
		goto :RUNNING
	) || (
		timeout /t 2
		goto :PRERUN
	)

rem ## BUCLE INGAME - ESTARÁ PENDIENTE DE QUE CERREMOS EL JUEGO
:RUNNING
	tasklist /nh /fi "imagename eq %exefile%" | findstr flash.exe > nul
	if %errorlevel%==1 (
		timeout /t 1
		GOTO :ENDLOOP
	)
	timeout /t 4
	GOTO :RUNNING

:ENDLOOP
rem ## TRAS CERRAR EL JUEGO, CERRAR TAMBIÉN ANTIMICRO Y EL SCRIPT DE AUTOHOTKEY
taskkill /IM antimicrox.exe /F
taskkill /IM new_close.exe /F

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
