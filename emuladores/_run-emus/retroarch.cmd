@echo off &SETLOCAL ENABLEDELAYEDEXPANSION

rem ## DECLARACIÓN DE VARIABLES
set realpath=%~dp0
set rbpath=%realpath%\..\..
set retroboxroot=
pushd %rbpath%
set retroboxroot=%CD%
popd
set EMUDIR=%retroboxroot%\emuladores

rem # variable especial para el funcionamiento de sed
set rbroot=%retroboxroot:\=\\%

rem ## ESTABLECER DIRECTORIOS DE GUARDADO DE PARTIDAS Y BIOS. LOS DIRECTORIOS DE PARTIDAS IRÁN SEPARADOS SEGÚN PLATAFORMA
del %EMUDIR%\retroarch\retroarch-config.cfg
copy %EMUDIR%\retroarch\retroarch-original.cfg %EMUDIR%\retroarch\retroarch-config.cfg
%retroboxroot%\misc\tools\sed.exe -i s#directorio#%rbroot%\\saves#g %EMUDIR%\retroarch\retroarch-config.cfg 
%retroboxroot%\misc\tools\sed.exe -i s#biosdir#%rbroot%\\bios#g %EMUDIR%\retroarch\retroarch-config.cfg 

rem ## INICIAR RETROARCH
%EMUDIR%\retroarch\retroarch.exe -c %EMUDIR%\retroarch\retroarch-config.cfg

rem ## DESHACER CONFIGURACIÓN DE DIRECTORIOS Y BIOS PARA QUE EN LA SIGUIENTE EJECUCIÓN DE RETROARCH NO HAYA CONFLICTOS
del %EMUDIR%\retroarch\retroarch-original.cfg
copy %EMUDIR%\retroarch\retroarch-config.cfg %EMUDIR%\retroarch\retroarch-original.cfg
%retroboxroot%\misc\tools\sed.exe -i s#%rbroot%\\saves#directorio#g %EMUDIR%\retroarch\retroarch-original.cfg 
%retroboxroot%\misc\tools\sed.exe -i s#%rbroot%\\bios#biosdir#g %EMUDIR%\retroarch\retroarch-original.cfg 

rem ## SI SE HA NECESITADO ENCENDER, APAGAR GRÁFICA NVIDIA
rem echo %emu% | findstr "parallel" >NUL && (
rem 	sudo pnputil /disable-device "PCI\VEN_10DE&DEV_1299&SUBSYS_18D01043&REV_A1\4&31955350&0&00E0"
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
