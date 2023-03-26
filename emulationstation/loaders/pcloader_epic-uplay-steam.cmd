@echo on

rem ## VARIABLES DE ENTORNO
set realpath=%~dp0
set rbpath=%realpath%\..\..
set retroboxroot=
pushd %rbpath%
set retroboxroot=%CD%
popd
set antimicroExec="%retroboxroot%\misc\tools\antimicro\bin\antimicrox.exe"

if [%1]==[] goto :ERROR
call %1

rem if [%2]==[] goto :ERROR
set profiledir=%2

rem ## EJECUTAR JOYXOFF MIENTRAS CARGA EL JUEGO (PANTALLAS UAC DE UPLAY, INICIOS DE SESIÓN, ETC.)
rem start /b "" "C:\Program Files (x86)\Joyxoff\Joyxoff.exe"

rem ## ENCENDER GRÁFICA NVIDIA
rem pnputil /enable-device "PCI\VEN_10DE&DEV_1299&SUBSYS_18D01043&REV_A1\4&31955350&0&00E0"

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

echo %1 | findstr uplay
if NOT errorlevel 1 (
	set count=1
	goto :UBIRUN
) else (
	goto :PRERUN
)

rem ## BUCLE PREVIO A LA EJECUCIÓN DEL JUEGO (PANTALLAS DE CARGA DE LA TIENDA, ETC.) 
:UBIRUN	
	@echo on
	echo %count%
	timeout /t 4
	tasklist | findstr %exefile%
	if NOT errorlevel 1 (
		if NOT %count% == 0 (
			set count=0
		) else (
			start /b "" %retroboxroot%\misc\ahks\new_close.exe
			start /b "" %antimicroExec% --profile %profiledir%
			goto :RUNNING
		)
	)
	
	goto :UBIRUN

:PRERUN
	tasklist | findstr %exefile%
	if NOT errorlevel 1 (
		rem ### CUANDO SE ROMPA EL BUCLE (EL JUEGO HAYA INICIADO), CARGAR ANTIMICRO Y SCRIPT DE AUTOHOTKEY PARA DESVIAR PULSACIONES A -*/
	    	rem taskkill /IM Joyxoff.exe /F
		start /b "" %retroboxroot%\misc\ahks\new_close.exe
		start /b "" %antimicroExec% --profile %profiledir%
		goto :RUNNING
	) else (
		timeout /t 4
		goto :PRERUN
	)

rem ## BUCLE INGAME - ESTARÁ PENDIENTE DE QUE CERREMOS EL JUEGO
:RUNNING
	tasklist | findstr %exefile% > nul
	if NOT errorlevel 1 (
		timeout /t 3
		GOTO :RUNNING
	)
	timeout /t 3
	GOTO :ENDLOOP

rem ## BUCLE POSTGAME - SE ENCARGA DE VOLVER A EMULATIONSTATION DE FORMA CORRECTA
:ENDLOOP
	rem ### CERRAR ANTIMICRO Y SCRIPT DE AUTOHOTKEY
	taskkill /IM new_close.exe /F
	taskkill /IM antimicrox.exe /F

	rem ### APAGAR GRÁFICA NVIDIA
	rem pnputil /disable-device "PCI\VEN_10DE&DEV_1299&SUBSYS_18D01043&REV_A1\4&31955350&0&00E0"
	
	rem ### DESENGANCHAR TECLA ALT, QUE SE QUEDA COMO "BLOQUEADA"
	start /b "" %retroboxroot%\misc\ahks\alt_key_unhang.exe

	rem ### DEVOLVER EL CONTROL A EMULATIONSTATION
	goto :FIN
	
rem ## CAZAERRORES
:ERROR
echo ERROR
exit /b 1

rem ## SALIDA SEGURA DEL SCRIPT
:FIN
exit /b 0