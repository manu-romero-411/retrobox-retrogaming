@echo on

set realpath=%~dp0
set exefile=%2
set exepath=%1

REM HERE MODIFY YOUR EXE PATH TO UPLAY GAME:
cd "%exepath%"
cmd /c "%exepath:"=%%exefile:"=%"
rem goto :ENDLOOP

start /b cmd /c "C:\Program Files\AntimicroX\bin\antimicrox.exe" --profile %retroboxroot%\gamepad-profiles\apps-tv.gamecontroller.amgp

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
	goto :EOF