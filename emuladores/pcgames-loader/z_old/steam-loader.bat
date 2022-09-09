@echo OFF

set realpath=%~dp0
set retroboxroot=%realpath%\..\..
set antimicroExec=start /b cmd /c  "C:\Program Files\AntimicroX\bin\antimicrox.exe"

if [%1]==[] goto :ERROR
call %1

sudo pnputil /enable-device "PCI\VEN_10DE&DEV_1299&SUBSYS_18D01043&REV_A1\4&31955350&0&00E0"

start %steamid%

:PRERUN
	start /b cmd /c "C:\Program Files\AntimicroX\bin\antimicrox.exe" --profile D:\Juegos\retrogaming\misc\gamepad-profiles\preload-steam-epic.gamecontroller.amgp
	tasklist|findstr %exefile% && (
	    taskkill /IM antimicrox.exe /F
		goto :RUNNING
	) || (
        	timeout /t 4 & GOTO :PRERUN
	)
	goto :EOF

:RUNNING
    tasklist|findstr %exefile%  || (
        timeout /t 2 & GOTO :ENDLOOP
    )
    timeout /t 3
    GOTO :RUNNING

:ENDLOOP
	sudo pnputil /disable-device "PCI\VEN_10DE&DEV_1299&SUBSYS_18D01043&REV_A1\4&31955350&0&00E0"
    goto :EOF

rem ## CAZAERRORES
:ERROR
echo ERROR
goto :EOF

rem ## SALIDA SEGURA DEL SCRIPT
:FIN
goto :EOF