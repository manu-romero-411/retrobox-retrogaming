@echo on

rem ## DECLARACIÓN DE VARIABLES
set realpath=%~dp0
set retroboxroot=%realpath%\..\..

if [%1]==[] goto :ERROR
set rom=%1
for %%f in ("%rom%") do set rom=%%~nf

set ABS_PATH=
pushd %retroboxroot%
set ABS_PATH=%CD%
popd

set EMUDIR=%ABS_PATH%\emuladores
CD %EMUDIR%\model2emu\

set antimicroExec="C:\Program Files\AntimicroX\bin\antimicrox.exe"

rem ## CREAR DIRECTORIOS DE GUARDADO DE PARTIDAS
if exist "%ABS_PATH%\saves\model2" ( 
	cd .
) else (
	mkdir "%ABS_PATH%\saves\model2"
)

rem ## ENCENDER GRÁFICA NVIDIA
rem sudo pnputil /enable-device "PCI\VEN_10DE&DEV_1299&SUBSYS_18D01043&REV_A1\4&31955350&0&00E0"

rem ## PONER EN MARCHA ANTIMICRO, PARA TENER ATAJOS DE TECLADO DE WINDOWS EN EL MANDO
start /b cmd /c %ABS_PATH%\misc\model2_close.exe
start /b cmd /c %antimicroExec% --hidden --profile %retroboxroot%\gamepad-profiles\model2.gamecontroller.amgp

rem ## AJUSTAR DIRECTORIOS DE BIOS, MEMORY CARDS E ISOS DEL EMULADOR
%ABS_PATH%\misc\inifile.exe %EMUDIR%\model2emu\EMULATOR.ini [RomDirs] Dir1=%ABS_PATH%\roms\segamodel2 

rem ## INICIAR MODEL2EMU
%EMUDIR%\model2emu\emulator_multicpu.exe %rom%

rem ## AL HABER ABANDONADO REDREAM, CERRAR ANTIMICRO
taskkill /IM model2_close.exe /F
taskkill /IM antimicrox.exe /F

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
