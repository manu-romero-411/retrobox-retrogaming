@echo on
set realpath=%~dp0
set retroboxroot=%realpath%\..\..

cd "%appdata%\Telegram Desktop\"
"%appdata%\Telegram Desktop\Telegram.exe"
start /b cmd /c  "C:\Program Files\AntimicroX\bin\antimicrox.exe" --profile %retroboxroot%\gamepad-profiles\apps-tv.gamecontroller.amgp

:PRERUN
	set contador=10
	powershell -command "Get-Process | where {$_.mainWindowTitle} | format-table mainWindowTitle" | findstr Telegram && (
		%retroboxroot%\misc\nircmd.exe win activate title "Telegram"
		goto :RUN
	) || (
		GOTO :PRERUN
	)
:RUN
	powershell -command "Get-Process | where {$_.mainWindowTitle} | format-table mainWindowTitle" | findstr Telegram  && (
		timeout /t 5 & goto :RUN
	) || (
		goto :POSTRUN 
	)

:POSTRUN
	%retroboxroot%\misc\nircmd.exe win activate title "EmulationStation"
	taskkill /IM antimicrox.exe /F