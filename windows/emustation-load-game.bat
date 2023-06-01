@echo off &SETLOCAL ENABLEDELAYEDEXPANSION
setlocal ENABLEDELAYEDEXPANSION
rem ## sleep arbitrario para que a la pantalla le dé tiempo a que los emuladores carguen
timeout /t 1

rem ## DECLARACIÓN DE VARIABLES
set realpath=%~dp0
set rbpath=%realpath%\..\..
set retroboxroot=
pushd %rbpath%
set retroboxroot=%CD%
popd

set EMUDIR=%retroboxroot%\emuladores

if [%1]==[] goto :ERROR
set plataforma=%1

if [%2]==[] goto :ERROR
set rom=%2

if [%3]==[] goto :ERROR
set emu=%3

cd %realpath%

rem ## CARGAR EMULADOR O PROGRAMA QUE HA PEDIDO EL JUEGO/APLICACIÓN

call %retroboxroot%\misc\mandoHelp\mandoHelp_load.cmd %plataforma% %rom%
echo %help% | findstr none >NUL && GOTO :LOADEMU

start /b "" %retroboxroot%\misc\ahks\pressA.exe
python %retroboxroot%\misc\mandoHelp\mandoHelp2.py "%retroboxroot%\misc\mandoHelp\%help:"=%.png"
tasklist | findstr "pressA.exe"
if NOT errorlevel 1 (
	taskkill /IM pressA.exe /F
)

:LOADEMU
echo %emu% | findstr libretro >NUL && (
	rem ### RETROARCH
	echo %emu% | findstr old >NUL && (
		%retroboxroot%\emulationstation\loaders\retroarch-old.cmd %plataforma% %rom% %emu%
	) || (
		%retroboxroot%\emulationstation\loaders\retroarch.cmd %plataforma% %rom% %emu%
	)
	goto :FIN
) || (
	goto :NORETROARCH
)

rem ### EMULADOR/PROGRAMA EXTERNO A RETROARCH
:NORETROARCH
rem echo %plataforma% | findstr apps-tv >NUL && (
rem	echo %rom% | findstr kodi && set emu=
rem	echo %rom% | findstr discord && set emu=

rem	call %retroboxroot%\emulationstation\loaders\retrobox-app-loader.cmd %rom% %emu% 
rem ) || (
	call %retroboxroot%\emulationstation\loaders\%emu%.cmd %rom%
rem)
goto :FIN

rem ## CAZAERRORES
:ERROR
echo ERROR

exit 1

rem ## SALIDA SEGURA DEL SCRIPT
:FIN
echo Control devuelto a emustation 
exit 0