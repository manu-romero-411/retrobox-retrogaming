@echo on
set realpath=%~dp0
set retroboxroot=%realpath%\..\..

cd "%localappdata%\Discord\"
%localappdata%\Discord\Update.exe --processStart Discord.exe
start /b cmd /c  "C:\Program Files\AntimicroX\bin\antimicrox.exe" --profile %retroboxroot%\gamepad-profiles\apps-tv.gamecontroller.amgp

:PRERUN
	set contador=10
	powershell -command "Get-Process | where {$_.mainWindowTitle} | format-table mainWindowTitle" | findstr Discord && (
		echo run
		%retroboxroot%\misc\nircmd.exe win activate title "Discord"
		goto :RUN
	) || (
		echo noprerun
		timeout /t 2
		set /A contador=contador-1
		if %contador%==0 (
			GOTO :EOF
		) else (
			GOTO :PRERUN
		)
	)
:RUN
	powershell -command "Get-Process | where {$_.mainWindowTitle} | format-table mainWindowTitle" | findstr Discord  && (
		timeout /t 8 & goto :RUN
	) || (
		goto :POSTRUN 
	)

:POSTRUN
	%retroboxroot%\misc\nircmd.exe win activate title "EmulationStation"
	taskkill /IM antimicrox.exe /F