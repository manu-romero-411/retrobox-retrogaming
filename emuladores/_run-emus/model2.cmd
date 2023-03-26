@echo off &SETLOCAL ENABLEDELAYEDEXPANSION

rem ## DECLARACIÓN DE VARIABLES
set realpath=%~dp0
set rbpath=%realpath%\..\..
set retroboxroot=
pushd %rbpath%
set retroboxroot=%CD%
popd

set EMUDIR=%retroboxroot%\emuladores
CD %EMUDIR%\model2emu\

rem ## AJUSTAR DIRECTORIOS DE BIOS, MEMORY CARDS E ISOS DEL EMULADOR
%retroboxroot%\misc\tools\inifile.exe %EMUDIR%\model2emu\EMULATOR.ini [RomDirs] Dir1=%retroboxroot%\roms\segamodel2 

rem ## INICIAR MODEL2EMU
%EMUDIR%\model2emu\emulator_multicpu.exe %rom%

rem ## DESENGANCHAR TECLA ALT, QUE SE QUEDA COMO "BLOQUEADA"
start /b "" %retroboxroot%\misc\ahks\alt_key_unhang.exe

rem ## APAGAR GRÁFICA NVIDIA
rem sudo pnputil /disable-device "PCI\VEN_10DE&DEV_1299&SUBSYS_18D01043&REV_A1\4&31955350&0&00E0"

rem ## DEVOLVER EL CONTROL A EMULATIONSTATION
goto :FIN

rem ## CAZAERRORES
:ERROR
echo ERROR
exit 1

rem ## SALIDA SEGURA DEL SCRIPT
:FIN
exit 0
