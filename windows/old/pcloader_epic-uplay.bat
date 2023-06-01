@echo on

set realpath=%~dp0
set retroboxroot=%realpath%\..\..
set antimicroExec=start /b cmd /c  "C:\Program Files\AntimicroX\bin\antimicrox.exe"

if [%1]==[] goto :ERROR
call %1

rem if [%2]==[] goto :ERROR
set profiledir=%2

rem sudo pnputil /enable-device "PCI\VEN_10DE&DEV_1299&SUBSYS_18D01043&REV_A1\4&31955350&0&00E0"

if NOT [%epicurl%]==[] (
	start %epicurl%
	goto :PRERUN
) 

if NOT [%steamid%]==[] (
	start %steamid%
	goto :PRERUN
) 

cd "%exedir%"
cmd /c start "" /high "%exedir:"=%%exefile:"=%"


:PRERUN
	tasklist | findstr %exefile% && (
	    start /b cmd /c %retroboxroot%\misc\new_close.exe
		start /b cmd /c %antimicroExec% --profile %profiledir%
		goto :RUNNING
	) || (
		timeout /t 4
		goto :PRERUN
	)
	goto :EOF

:RUNNING
	tasklist | findstr %exefile% > nul
	if %errorlevel%==1 (
		timeout /t 2
		GOTO :ENDLOOP
	)
	timeout /t 3
	GOTO :RUNNING

:ENDLOOP
	taskkill /IM new_close.exe /F
	taskkill /IM antimicrox.exe /F

	sudo pnputil /disable-device "PCI\VEN_10DE&DEV_1299&SUBSYS_18D01043&REV_A1\4&31955350&0&00E0"
	
	goto :FIN
	
rem ## CAZAERRORES
:ERROR
echo ERROR
goto :EOF

rem ## SALIDA SEGURA DEL SCRIPT
:FIN
goto :EOF