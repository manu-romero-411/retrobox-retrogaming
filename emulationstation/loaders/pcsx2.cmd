@echo off

rem ## VARIABLES DE ENTORNO
set realpath=%~dp0
set retroboxroot=%realpath%\..\..
set EMUDIR=%retroboxroot%\emuladores
set antimicroExec="C:\Program Files\AntimicroX\bin\antimicrox.exe"

if [%1]==[] goto :ERROR
set rom=%1

rem ## CARGAR ANTIMICRO Y UN SCRIPT DE AUTOHOTKEY ESPECIALMENTE DISEÑADO PARA SALIR DEL EMULADOR
start /b cmd /c %antimicroExec% --hidden --profile %retroboxroot%\gamepad-profiles\pcsx2.gamecontroller.amgp
start /b cmd /c %retroboxroot%\misc\pcsx2-close.exe

rem ## AJUSTAR DIRECTORIOS DE BIOS, MEMORY CARDS E ISOS DEL EMULADOR
%retroboxroot%\misc\inifile.exe %EMUDIR%\pcsx2\inis\PCSX2_ui.ini [Folders] Bios=..\\..\\bios
%retroboxroot%\misc\inifile.exe %EMUDIR%\pcsx2\inis\PCSX2_ui.ini [Folders] MemoryCards=..\\..\\saves\\ps2
%retroboxroot%\misc\inifile.exe %EMUDIR%\pcsx2\inis\PCSX2_ui.ini [Folders] RunIso=..\\..\\roms\\ps2

rem ## CARGAR EMULADOR
start /wait %EMUDIR%\pcsx2\pcsx2x64-avx2.exe --nogui --fullscreen --fullboot %1

rem ## TRAS CERRAR EL JUEGO, CERRAR TAMBIÉN ANTIMICRO Y EL SCRIPT DE AUTOHOTKEY
taskkill /IM antimicrox.exe /F
taskkill /IM pcsx2-close.exe /F

rem ### DEVOLVER EL CONTROL A EMULATIONSTATION
goto :FIN
	
rem ## CAZAERRORES
:ERROR
echo ERROR
exit 1

rem ## SALIDA SEGURA DEL SCRIPT
:FIN
exit 0