@echo off
set gamedir=%1
set realpath=%~dp0
set retroboxroot=%realpath%\..\..
for %%i in (lnk,bat) do (
	echo %gamedir% | findstr %i && (
		goto :LNKFILES
	) || (
		goto :CARPETASPIR
	)
)

:LNKFILES
	rem ## CARGAR PERFILES DE MANDOS SI SE NECESITAN
	set basename=""
	for %%i in (%gamedir%) do set basename=%%~ni
	for %%F in (%gamedir%) do set dirname=%%~dpF
	cd %dirname%
	set profiledir=%dirname:"=%..\xdgAntimicro\%basename:"=%.gamecontroller.amgp
	rem echo %profiledir% > D:\hola.txt
	if exist %profiledir% (
		start /b cmd /c "C:\Program Files\AntimicroX\bin\antimicrox.exe" --profile %profiledir%
	)
	%gamedir%
	tasklist /nh /fi "imagename eq antimicrox.exe" | find /i "antimicrox.exe" &&taskkill /IM antimicrox.exe /F
	exit /B

:CARPETASPIR
	rem ## SI retrobox-run NO EXISTE, SACAMOS AL USUARIO AL MENÚ DE EMULATIONSTATION
	if not exist %gamedir%\retrobox-run.lnk (
		rem exit 1
	)
	rem ## CARGAR PERFILES DE MANDOS SI SE NECESITAN
	if exist %gamedir%\game.gamecontroller.amgp (
		set profiledir=%gamedir:"=%\game.gamecontroller.amgp
	)

	start /b cmd /c %realpath%\antimicro.cmd "%profiledir%"
	cd %gamedir%
	%gamedir%\retrobox-run.lnk
	tasklist /nh /fi "imagename eq antimicrox.exe" | find /i "antimicrox.exe" &&taskkill /IM antimicrox.exe /F
	exit /B