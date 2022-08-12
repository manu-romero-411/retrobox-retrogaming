@echo off

rem ## DECLARACIÓN DE VARIABLES
set realpath=%~dp0
set retroboxroot=%realpath%\..\..
set CONFIGFILE=%retroboxroot%\defaults.conf
set EMUDIR=%retroboxroot%\emuladores
set ROMCONFIGDIR=%retroboxroot%\config\%1-config.conf

if [%1]==[] goto :ERROR
set plataforma=%1


if [%2]==[] goto :ERROR
set rom=%2

cd %realpath%

rem ## BUSCAR EMULADOR POR DEFECTO: FORMA NUEVA (EMULATIONSTATION)
if NOT [%3]==[] (
	set emu=%3
	goto :CONTINUE2
)

rem ## BUSCAR EMULADOR POR DEFECTO: FORMA ANTIGUA (defaults.conf)
set "emu=findstr default-%1 %CONFIGFILE%"

for /f "delims=" %%a in ('%emu%') do (
	set tempvar=%%a
	goto :CONTINUE
)

:CONTINUE
set emu=%tempvar%
echo %emu%
setlocal disabledelayedexpansion
for /f "tokens=1,2 delims==" %%a in ("%emu%") do set emu=%%b

rem ## CARGAR EMULADOR O PROGRAMA QUE HA PEDIDO EL JUEGO/APLICACIÓN
:CONTINUE2
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
%retroboxroot%\emulationstation\loaders\%emu%.cmd %rom%
goto :FIN

rem ## CAZAERRORES
:ERROR
echo ERROR
exit 1

rem ## SALIDA SEGURA DEL SCRIPT
:FIN
exit 0