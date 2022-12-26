@echo off

rem ## VARIABLES DE ENTORNO
set realpath=%~dp0
set rbpath=%realpath%\..\..
set retroboxroot=
pushd %rbpath%
set retroboxroot=%CD%
popd

set EMUDIR=%retroboxroot%\emuladores
set antimicroExec="C:\Program Files\AntimicroX\bin\antimicrox.exe"

rem ## AJUSTAR DIRECTORIOS DE BIOS, MEMORY CARDS E ISOS DEL EMULADOR
%retroboxroot%\misc\tools\inifile.exe %EMUDIR%\pcsx2\inis\PCSX2_ui.ini [Folders] Bios=..\\..\\bios
%retroboxroot%\misc\tools\inifile.exe %EMUDIR%\pcsx2\inis\PCSX2_ui.ini [Folders] MemoryCards=..\\..\\saves\\ps2
%retroboxroot%\misc\tools\inifile.exe %EMUDIR%\pcsx2\inis\PCSX2_ui.ini [Folders] RunIso=..\\..\\roms\\ps2

rem ## CARGAR EMULADOR
start /wait %EMUDIR%\pcsx2\pcsx2x64-avx2.exe

rem ## DESENGANCHAR TECLA ALT, QUE SE QUEDA COMO "BLOQUEADA"
start /b "" %retroboxroot%\misc\ahks\alt_key_unhang.exe

rem ### DEVOLVER EL CONTROL A EMULATIONSTATION
goto :FIN
	
rem ## CAZAERRORES
:ERROR
echo ERROR
exit 1

rem ## SALIDA SEGURA DEL SCRIPT
:FIN
exit 0