@echo off &SETLOCAL ENABLEDELAYEDEXPANSION

set realpath=%~dp0
set retroboxroot=%realpath%\..

:PRERUN
	echo lllf
	tasklist /nh /fi "imagename eq emulationstation.exe" | find /i "emulationstation.exe"
	if errorlevel 0 (
		%retroboxroot%\misc\nircmd.exe win activate title "EmulationStation"
		%retroboxroot%\misc\hide-title-bar.exe
		goto :EOF
	) else (
		timeout /t 3 & GOTO :PRERUN
	)
