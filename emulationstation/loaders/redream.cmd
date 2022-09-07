@echo on

rem ## DECLARACIÓN DE VARIABLES
set realpath=%~dp0
set retroboxroot=%realpath%\..\..
set EMUDIR=%retroboxroot%\emuladores
set antimicroExec="C:\Program Files\AntimicroX\bin\antimicrox.exe"

if [%1]==[] goto :ERROR
set rom=%1

rem ## CREAR DIRECTORIOS DE GUARDADO DE PARTIDAS
if exist "%retroboxroot%\saves\dreamcast" ( 
	cd .
) else (
	mkdir "%retroboxroot%\saves\dreamcast"
)

rem ## ENCENDER GRÁFICA NVIDIA
rem sudo pnputil /enable-device "PCI\VEN_10DE&DEV_1299&SUBSYS_18D01043&REV_A1\4&31955350&0&00E0"

rem ## PONER EN MARCHA ANTIMICRO, PARA TENER ATAJOS DE TECLADO DE WINDOWS EN EL MANDO
start /b cmd /c %antimicroExec% --hidden --profile %retroboxroot%\gamepad-profiles\redream.gamecontroller.amgp

rem ## INICIAR REDREAM
start /wait %EMUDIR%\redream\redream.exe %rom%

rem ## AL HABER ABANDONADO REDREAM, CERRAR ANTIMICRO
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
