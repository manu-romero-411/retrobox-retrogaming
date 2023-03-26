@echo off &SETLOCAL ENABLEDELAYEDEXPANSION
setlocal ENABLEDELAYEDEXPANSION
rem ## sleep arbitrario para que a la pantalla le dé tiempo a que los emuladores carguen
timeout /t 4

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

cd %realpath%

rem ## BUSCAR EMULADOR POR DEFECTO: FORMA NUEVA (EMULATIONSTATION)
if NOT [%3]==[] (
	set emu=%3
) else (
	exit 1
)

rem ## CARGAR EMULADOR O PROGRAMA QUE HA PEDIDO EL JUEGO/APLICACIÓN
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
call %retroboxroot%\emulationstation\loaders\%emu%.cmd %rom%
goto :FIN

rem ## CAZAERRORES
:ERROR
echo ERROR
exit 1

rem ## SALIDA SEGURA DEL SCRIPT
:FIN
echo Control devuelto a emustation 
@exit 0