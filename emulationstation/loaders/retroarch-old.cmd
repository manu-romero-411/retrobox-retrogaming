@echo off

rem ## DECLARACIÓN DE VARIABLES
set realpath=%~dp0
set rbpath=%realpath%\..\..
set retroboxroot=
pushd %rbpath%
set retroboxroot=%CD%
popd
set EMUDIR=D:\Juegos\retrogaming\emuladores

if [%1]==[] goto :ERROR
set plataforma=%1

if [%2]==[] goto :ERROR
set rom=%2

if [%3]==[] goto :ERROR
set emu=%3

rem ## CREAR DIRECTORIOS DE GUARDADO DE PARTIDAS
if exist "%retroboxroot%\saves\%plataforma%" ( 
	cd .
) else (
	mkdir "%retroboxroot%\saves\%plataforma%"
)

rem ## DIRECTORIOS ALTERNATIVOS DE GUARDADO
rem if exist "E:\Juegos\saves\%plataforma%" ( 
rem 	cd .
rem ) else (
rem 	mkdir "E:\Juegos\saves\%plataforma%"
rem )

rem ## ENCENDER GRÁFICA NVIDIA SI VAMOS A JUGAR N64 CON CORE parallel_n64_libretro
rem echo %emu% | findstr "parallel" >NUL && (
	rem sudo pnputil /enable-device "PCI\VEN_10DE&DEV_1299&SUBSYS_18D01043&REV_A1\4&31955350&0&00E0"
rem )

rem ## ESTABLECER DIRECTORIOS DE GUARDADO DE PARTIDAS Y BIOS. LOS DIRECTORIOS DE PARTIDAS IRÁN SEPARADOS SEGÚN PLATAFORMA
del %EMUDIR%\retroarch-old\retroarch-config.cfg
copy %EMUDIR%\retroarch-old\retroarch-original.cfg %EMUDIR%\retroarch-old\retroarch-config.cfg
%retroboxroot%\misc\tools\sed.exe -i s#directorio#%rbroot%\\saves\\%plataforma%#g %EMUDIR%\retroarch-old\retroarch-config.cfg 
%retroboxroot%\misc\tools\sed.exe -i s#biosdir#%rbroot%\\bios#g %EMUDIR%\retroarch-old\retroarch-config.cfg 


rem ## INICIAR RETROARCH
echo %emu% | findstr "parallel" >NUL && (
	%EMUDIR%\retroarch-old\retroarch-nvidia.exe -c %EMUDIR%\retroarch-old\retroarch-config.cfg -L %EMUDIR%\retroarch-old\cores\%emu%.dll %rom%
) || (
	%EMUDIR%\retroarch-old\retroarch.exe -c %EMUDIR%\retroarch-old\retroarch-config.cfg -L %EMUDIR%\retroarch-old\cores\%emu%.dll %rom%
)

rem ## DESHACER CONFIGURACIÓN DE DIRECTORIOS Y BIOS PARA QUE EN LA SIGUIENTE EJECUCIÓN DE RETROARCH NO HAYA CONFLICTOS
del %EMUDIR%\retroarch-old\retroarch-original.cfg
copy %EMUDIR%\retroarch-old\retroarch-config.cfg %EMUDIR%\retroarch-old\retroarch-original.cfg
%retroboxroot%\misc\tools\sed.exe -i s#%rbroot%\\saves\\%plataforma%#directorio#g %EMUDIR%\retroarch-old\retroarch-original.cfg 
%retroboxroot%\misc\tools\sed.exe -i s#%rbroot%\\bios#biosdir#g %EMUDIR%\retroarch-old\retroarch-original.cfg 

rem ## SI SE HA NECESITADO ENCENDER, APAGAR GRÁFICA NVIDIA
rem echo %emu% | findstr "parallel" >NUL && (
rem	sudo pnputil /disable-device "PCI\VEN_10DE&DEV_1299&SUBSYS_18D01043&REV_A1\4&31955350&0&00E0"
rem )

rem ## DEVOLVER EL CONTROL A EMULATIONSTATION
goto :FIN

rem ## CAZAERRORES
:ERROR
echo ERROR
exit 1

rem ## SALIDA SEGURA DEL SCRIPT
:FIN
exit 0