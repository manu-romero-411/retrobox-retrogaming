@echo off

rem ## VARIABLES DE ENTORNO
set realpath=%~dp0
set retroboxroot=%realpath%\..\..
set EMUDIR=%retroboxroot%\emuladores

if [%1]==[] goto :ERROR
set rom=%1

rem ## CARGAR EMULADOR
start /wait %EMUDIR%\dolphin\Dolphin.exe -b -e %1

rem ## DEVOLVER CONTROL A EMULATIONSTATION
goto :FIN

rem ## CAZAERRORES
:ERROR
echo ERROR
exit 1

rem ## SALIDA SEGURA DEL SCRIPT
:FIN
exit 0