@echo off

rem ## VARIABLES DE ENTORNO
set realpath=%~dp0
set rbpath=%realpath%\..\..
set retroboxroot=
pushd %rbpath%
set retroboxroot=%CD%
popd

set EMUDIR=%retroboxroot%\emuladores

set dirname=D:\Juegos/retrogaming/roms/psp

rem ## AJUSTAR DIRECTORIOS DE BIOS, MEMORY CARDS E ISOS DEL EMULADOR
%retroboxroot%\misc\tools\sed.exe -i s#directorio#%dirname%#g %EMUDIR%\ppsspp\memstick\PSP\SYSTEM\ppsspp.ini

REM ## INICIAR EMULADOR
%EMUDIR%\ppsspp\PPSSPPWindows64.exe %1 --escape-exit

REM ## PARA ASEGURAR QUE TODA LA CONFIGURACIÓN ES PORTABLE, VOLVER A COLOCAR EL VALOR CENTINELA EN LA CONFIG DE PPSSPP
set "dirname=%dirname:~0,-1%"
%retroboxroot%\misc\tools\sed.exe -i s#%dirname%#directorio#g %EMUDIR%\ppsspp\memstick\PSP\SYSTEM\ppsspp.ini

rem ## DESENGANCHAR TECLA ALT, QUE SE QUEDA COMO "BLOQUEADA"
start /b "" %retroboxroot%\misc\ahks\alt_key_unhang.exe

REM ## DEVOLVER EL CONTROL A EMULATIONSTATION
goto :FIN
	
rem ## CAZAERRORES
:ERROR
echo ERROR
exit 1

rem ## SALIDA SEGURA DEL SCRIPT
:FIN
exit 0