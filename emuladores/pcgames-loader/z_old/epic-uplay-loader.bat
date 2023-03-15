@echo off

set realpath=%~dp0
set exefile=%2
set exepath=%1

rem sudo pnputil /enable-device "PCI\VEN_10DE&DEV_1299&SUBSYS_18D01043&REV_A1\4&31955350&0&00E0"
set antimicroExec="%retroboxroot%\misc\tools\antimicro\bin\antimicrox.exe"

REM HERE MODIFY YOUR EXE PATH TO UPLAY GAME:
cd "%exepath%"
cmd /c start "" /high "%exepath:"=%%exefile:"=%"
rem goto :ENDLOOP

start /b "" "%retroboxroot%\misc\tools\antimicro\bin\antimicrox.exe" --profile %retroboxroot%\misc\gamepad-profiles\apps-tv.gamecontroller.amgp

:PRERUN
	echo hola
	tasklist | findstr %exefile% > nul
	if %errorlevel%==1 (
		timeout /t 4
		GOTO :PRERUN
	) else (
		goto :RUNNING
	)
:RUNNING
	taskkill /IM antimicrox.exe /F
	tasklist | findstr %exefile% > nul
	if %errorlevel%==1 (
		timeout /t 2
		GOTO :ENDLOOP
	)
	timeout /t 3
	GOTO :RUNNING

:ENDLOOP
	rem taskkill /IM UbisoftGameLauncher.exe /F
	rem taskkill /IM upc.exe /F
	rem taskkill /IM UplayWebCore.exe /F

	rem sudo pnputil /disable-device "PCI\VEN_10DE&DEV_1299&SUBSYS_18D01043&REV_A1\4&31955350&0&00E0"

	goto :EOF