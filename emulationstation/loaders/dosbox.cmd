@echo off &SETLOCAL ENABLEDELAYEDEXPANSION

rem ## DECLARACIÓN DE VARIABLES
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

rem # variable especial para el funcionamiento de sed
set rom0="%rom:"=%"
set rom1=%rom0:\=\\%

rem ## ENCENDER GRÁFICA NVIDIA
rem sudo pnputil /enable-device "PCI\VEN_10DE&DEV_1299&SUBSYS_18D01043&REV_A1\4&31955350&0&00E0"

rem ## PONER EN MARCHA ANTIMICRO, PARA TENER ATAJOS DE TECLADO DE WINDOWS EN EL MANDO
rem start /b "" %antimicroExec% --hidden --profile %retroboxroot%\misc\gamepad-profiles\redream.gamecontroller.amgp

rem ## INICIAR DOSBOX
echo %rom1%
%retroboxroot%\misc\tools\sed.exe -i s#directorio1#\"%rom1%\"#g %EMUDIR%\dosbox\doscfg.conf
start /wait %EMUDIR%\dosbox\dosbox.exe -noconsole -userconf -conf %EMUDIR%\dosbox\doscfg.conf
%retroboxroot%\misc\tools\sed.exe -i s#\"%rom1%\"#directorio1#g %EMUDIR%\dosbox\doscfg.conf

rem ## AL HABER ABANDONADO DOSBOX, CERRAR ANTIMICRO
rem taskkill /IM antimicrox.exe /F

rem ## APAGAR GRÁFICA NVIDIA
rem sudo pnputil /disable-device "PCI\VEN_10DE&DEV_1299&SUBSYS_18D01043&REV_A1\4&31955350&0&00E0"

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
