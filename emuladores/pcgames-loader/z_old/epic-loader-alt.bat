@echo off

set realpath=%~dp0
set exefile1=%2
set exefile2=%3
set exepath=%1

sudo pnputil /enable-device "PCI\VEN_10DE&DEV_1299&SUBSYS_18D01043&REV_A1\4&31955350&0&00E0"

REM HERE MODIFY YOUR EXE PATH TO UPLAY GAME:
cd "%exepath%"
cmd /c start "" /high "%exepath:"=%%exefile1:"=%"
rem goto :ENDLOOP

start /b "" "C:\Program Files\AntimicroX\bin\antimicrox.exe" --profile %retroboxroot%\misc\gamepad-profiles\apps-tv.gamecontroller.amgp

:PRERUN1
	tasklist | findstr %exefile1% > nul
	if %errorlevel%==1 (
		timeout /t 3
		GOTO :PRERUN
	) else (
		goto :PRERUN2
	)

:PRERUN2
	tasklist | findstr %exefile2% > nul
	if %errorlevel%==1 (
		timeout /t 3
		GOTO :PRERUN2
	) else (
		taskkill /IM antimicrox.exe /F
		goto :RUNNING
	)

:RUNNING
	tasklist | findstr %exefile2% > nul
	if %errorlevel%==1 (
		timeout /t 2
		GOTO :ENDLOOP
	)
	timeout /t 5
	GOTO :RUNNING

:ENDLOOP
	rem taskkill /IM UbisoftGameLauncher.exe /F
	rem taskkill /IM upc.exe /F
	rem taskkill /IM UplayWebCore.exe /F
	sudo pnputil /disable-device "PCI\VEN_10DE&DEV_1299&SUBSYS_18D01043&REV_A1\4&31955350&0&00E0"

	goto :EOF