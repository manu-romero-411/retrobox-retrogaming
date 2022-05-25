@echo off
if not exist C:\.winboot (
	if "%1" == "-b" (
		goto :EOF
	)
)

del D:\.noreboot
tasklist /nh /fi "imagename eq emulationstation.exe" | find /i "emulationstation.exe" && exit
tasklist /nh /fi "imagename eq retrobat.exe" | find /i "retrobat.exe" && exit
tasklist /nh /fi "imagename eq retroarch.exe" | find /i "retroarch.exe" && exit

set realpath=%~dp0
set retroboxroot=%realpath%
rem goto :DISPLAYRES

rem :DISPLAYRES
	for /f "delims=" %%# in  ('"wmic path Win32_VideoController  get CurrentHorizontalResolution,CurrentVerticalResolution /format:value"') do (
 		set "%%#">nul
	)

	set borde=2
	set /a horiz=%CurrentHorizontalResolution%-%borde%
	set /a verti=%CurrentVerticalResolution%-%borde%

	%retroboxroot%\misc\inifile.exe %retroboxroot%\retrobat.ini [EmulationStation] WindowXSize=%horiz%
	%retroboxroot%\misc\inifile.exe %retroboxroot%\retrobat.ini [EmulationStation] WindowYSize=%verti%

	rem echo %horiz% %verti%

	goto :PREPRERUN
:LOAD
	if exist C:\.winboot (
		goto :PREPRERUN
	) else (
		if "%1" == "-fromwin" (
			goto :PREPRERUN
		) else (
			goto :EOF
		)
	)

:PREPRERUN
	if NOT "%1" == "-fromwin" (
		rem %retroboxroot%\misc\silentcmd-windows\SilentCMD.exe %retroboxroot%\misc\hide-title-bar.bat
		rem powershell -command "(New-Object -comObject Shell.Application).Windows() | foreach-object {$_.quit()}; Get-Process | Where-Object {$_.MainWindowTitle -ne \"\"} | stop-process"
		rem %retroboxroot%\misc\HideDesktopIcons.exe
		
	)
	taskkill /IM firefox.exe /F
	taskkill /IM explorer.exe /F
	taskkill /IM code.exe /F
	start explorer.exe
	timeout /t 2
	%retroboxroot%\misc\nircmd.exe win hide class Shell_TrayWnd
	%retroboxroot%\misc\HideDesktopIcons.exe
	REM start /w %retroboxroot%\retrobat.exe
	taskkill /IM antimicrox.exe /F
	start /w %retroboxroot%\emulationstation\emulationstation.exe --windowed --resolution %horiz% %verti%
	rem start /w %retroboxroot%\emulationstation\emulationstation.exe
	goto :FIN

:PRERUN
	powershell -command "Get-Process | where {$_.mainWindowTitle} | format-table mainWindowTitle" | findstr EmulationStation 
	if errorlevel 0 (
		%retroboxroot%\misc\nircmd.exe win activate title "EmulationStation"
		goto :RUNNING
	) else (
		timeout /t 3 & GOTO :PRERUN
	)

:RUNNING
	tasklist | findstr emulationstation.exe  || (
		GOTO :FIN
	)
	timeout /t 3
	GOTO :RUNNING

:FIN
	if NOT "%1" == "-fromwin" (
		if exist C:\.winboot (
			if not exist D:\.noreboot (
				%retroboxroot%\misc\silentcmd-windows\SilentCMD.exe %retroboxroot%\misc\reboot-linux.bat
			)
		)
		rem %retroboxroot%\misc\HideDesktopIcons.exe
		
	)
	%retroboxroot%\misc\nircmd.exe win show class Shell_TrayWnd
	%retroboxroot%\misc\HideDesktopIcons.exe

	rem if not exist %retroboxroot%\.no-reboot (
		rem shutdown /r /t 0
	rem )
	rem start /b cmd /c start /b cmd /c  "C:\Program Files\AntimicroX\bin\antimicrox.exe" --hidden --profile %retroboxroot%\gamepad-profiles\winUWP.gamecontroller.amgp
	goto :EOF
exit
