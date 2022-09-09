@echo off

set realpath=%~dp0
call %1

sudo pnputil /enable-device "PCI\VEN_10DE&DEV_1299&SUBSYS_18D01043&REV_A1\4&31955350&0&00E0"


REM HERE MODIFY YOUR EXE PATH TO UPLAY GAME:
cd "%exepath%"

:PRERUN
	tasklist | findstr %exefile% > nul
	if %errorlevel%==1 (
		timeout /t 4
		GOTO :PRERUN
	) else (
		goto :RUNNING
	)
:RUNNING
	tasklist | findstr %exefile% > nul
	if %errorlevel%==1 (
		timeout /t 2
		GOTO :ENDLOOP
	)
	timeout /t 3
	GOTO :RUNNING

:ENDLOOP
	sudo pnputil /disable-device "PCI\VEN_10DE&DEV_1299&SUBSYS_18D01043&REV_A1\4&31955350&0&00E0"
	goto :EOF