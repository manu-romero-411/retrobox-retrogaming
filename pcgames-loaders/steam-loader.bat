@echo OFF

set exefile=%2

REM HERE MODIFY YOUR STEAM APPID:
START %1

:PRERUN
	start /b cmd /c "C:\Program Files\AntimicroX\bin\antimicrox.exe" --profile D:\Juegos\retrogaming\gamepad-profiles\preload-steam-epic.gamecontroller.amgp
	tasklist|findstr %exefile% && (
	    taskkill /IM antimicrox.exe /F
        goto :RUNNING
    ) || (
        timeout /t 4 & GOTO :PRERUN
    )
    pause

:RUNNING
    tasklist|findstr %exefile%  || (
        timeout /t 2 & GOTO :ENDLOOP
    )
    timeout /t 3
    GOTO :RUNNING

:ENDLOOP
    rem taskkill /IM Steam.exe  /F
    goto :EOF
