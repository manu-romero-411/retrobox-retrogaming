@echo off
set realpath=%~dp0
set retroboxroot=%realpath%\..\..

cd "C:\Program Files (x86)\Steam"
start steam://open/bigpicture

:PRERUN
	echo prerun
	powershell -command "Get-Process | where {$_.mainWindowTitle} | format-table mainWindowTitle" | findstr Steam 
	if errorlevel 0 (
		%retroboxroot%\misc\nircmd.exe win activate title "Steam"
		goto :RUN
	) else (
		timeout /t 5 & GOTO :PRERUN
	)
:RUN
	echo run
	wmic process where "name like '%%Steam%%'" get processid,commandline | findstr bigpicture && (
		timeout /t 5 & goto :RUN
	) || (
		timeout /t 3 & GOTO :POSTRUN
	)

:POSTRUN
	echo postrun
    	taskkill /IM Steam.exe  /F
	taskkill /IM steamservice.exe  /F
	taskkill /IM steamwebhelper.exe  /F
	exit
    	goto :EOF