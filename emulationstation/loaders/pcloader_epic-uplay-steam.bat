@echo off

rem ## VARIABLES DE ENTORNO
set realpath=%~dp0
set retroboxroot=%realpath%\..\..
set antimicroExec=start /b cmd /c  "C:\Program Files\AntimicroX\bin\antimicrox.exe"

if [%1]==[] goto :ERROR
call %1

rem if [%2]==[] goto :ERROR
set profiledir=%2

rem ## ENCENDER GRÁFICA NVIDIA
sudo pnputil /enable-device "PCI\VEN_10DE&DEV_1299&SUBSYS_18D01043&REV_A1\4&31955350&0&00E0"

rem ## SI EL JUEGO ES DE EPIC, CARGARLO CON EPIC
if NOT [%epicurl%]==[] (
	start %epicurl%
	goto :PRERUN
) 

rem ## SI EL JUEGO ES DE STEAM, CARGARLO CON STEAM
if NOT [%steamid%]==[] (
	start %steamid%
	goto :PRERUN
) 

rem ## SI EL JUEGO ES DE UPLAY U OTRA TIENDA, CARGARLO DESDE SU DIRECTORIO DE INSTALACIÓN
cd "%exedir%"
cmd /c start "" /high "%exedir:"=%%exefile:"=%"


rem ## BUCLE PREVIO A LA EJECUCIÓN DEL JUEGO (PANTALLAS DE CARGA DE LA TIENDA, ETC.) 
:PRERUN
	tasklist | findstr %exefile% && (
		rem ### CUANDO SE ROMPA EL BUCLE (EL JUEGO HAYA INICIADO), CARGAR ANTIMICRO Y SCRIPT DE AUTOHOTKEY PARA DESVIAR PULSACIONES A -*/
	    sudo start /b cmd /c %retroboxroot%\misc\new_close.exe
		sudo start /b cmd /c %antimicroExec% --profile %profiledir%
		goto :RUNNING
	) || (
		timeout /t 4
		goto :PRERUN
	)

rem ## BUCLE INGAME - ESTARÁ PENDIENTE DE QUE CERREMOS EL JUEGO
:RUNNING
	tasklist | findstr %exefile% > nul
	if %errorlevel%==1 (
		timeout /t 2
		GOTO :ENDLOOP
	)
	timeout /t 3
	GOTO :RUNNING

rem ## BUCLE POSTGAME - SE ENCARGA DE VOLVER A EMULATIONSTATION DE FORMA CORRECTA
:ENDLOOP
	rem ### CERRAR ANTIMICRO Y SCRIPT DE AUTOHOTKEY
	sudo taskkill /IM new_close.exe /F
	sudo taskkill /IM antimicrox.exe /F

	rem ### APAGAR GRÁFICA NVIDIA
	sudo pnputil /disable-device "PCI\VEN_10DE&DEV_1299&SUBSYS_18D01043&REV_A1\4&31955350&0&00E0"
	
	rem ### DEVOLVER EL CONTROL A EMULATIONSTATION
	goto :FIN
	
rem ## CAZAERRORES
:ERROR
echo ERROR
exit 1

rem ## SALIDA SEGURA DEL SCRIPT
:FIN
exit 0