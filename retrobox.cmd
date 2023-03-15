@echo off

rem ## DECLARACIÓN DE VARIABLES
set realpath=%~dp0
set rbpath=%realpath%
set retroboxroot=
pushd %rbpath%
set retroboxroot=%CD%
popd

rem ## SI FALTA ALGUNA DEPENDENCIA, NO PODREMOS CONTINUAR
call %retroboxroot%\misc\scripts\dep-check.cmd

for /f "tokens=3* delims= " %%a in ('reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "Desktop"') do (set escritorio=%%a %%b)
set "escritorio=%escritorio:~0,-1%"
if exist %escritorio%\retrobox-deps.txt (
    exit 1
)

rem ## EL ARCHIVO .noreboot ES GENERADO SI USAMOS LA OPCIÓN "Modo Windows" DEL MENÚ "Opciones del sistema".
REM ## IMPIDE QUE SE VUELVA A LINUX AL SELECCIONAR TAL OPCIÓN.
del D:\.noreboot

rem ## ÚNICA INSTANCIA: SI SE INTENTA EJECUTAR UNA SEGUNDA INSTANCIA DEL SCRIPT, NO PASARÁ NADA.
tasklist /nh /fi "imagename eq emulationstation.exe" | find /i "emulationstation.exe" && exit 1

rem ## PARA AHORRAR ENERGÍA Y QUE EL PC NO SE CALIENTE MÁS DE LA CUENTA, APAGAR GRÁFICA NVIDIA (SE ENCENDERÁ SI ES NECESARIO EN ALGÚN JUEGO/EMULADOR).
rem pnputil /disable-device "PCI\VEN_10DE&DEV_1299&SUBSYS_18D01043&REV_A1\4&31955350&0&00E0"

rem ## OCULTAR BARRA DE TAREAS E ICONOS DEL ESCRITORIO DE WINDOWS COMPLETAMENTE
if NOT "%1" == "-b" (
	powershell -command "(New-Object -comObject Shell.Application).Windows() | foreach-object {$_.quit()}; Get-Process | Where-Object {$_.MainWindowTitle -ne \"\"} | stop-process"
)

rem reg import %retroboxroot%\misc\regs\iconos-escritorio-ocultar.reg
rem taskkill /IM explorer.exe /F
rem start explorer.exe
rem timeout /t 3
taskkill /IM RetroBar.exe /F
timeout /t 2
%retroboxroot%\misc\tools\nircmd.exe win hide class Shell_TrayWnd

rem ## BUCLE DE EJECUCIÓN
:RUN
	if NOT EXIST %retroboxroot%\roms (
		mkdir %retroboxroot%\roms
	)

	if NOT EXIST %retroboxroot%\saves (
		mkdir %retroboxroot%\saves
	)
	
	rem ## INICIAR EMULATIONSTATION
	start /w %retroboxroot%\emulationstation\emulationstation.exe
	
	rem ## RUTINA DE FINALIZACIÓN DE EMULATIONSTATION
	goto :FIN

rem ## BUCLE DE CIERRE
:FIN
	if "%1" == "-b" (
		rem ### SI HEMOS CERRADO EMULATIONSTATION DESDE LA OPCIÓN "Modo Windows", SE CREARÁ EL ARCHIVO .noreboot.
		rem ### DE LO CONTRARIO, AL LLEGAR AQUÍ, VOLVEREMOS A LINUX (BIEEEEEN).
		if not exist D:\.noreboot (
			%retroboxroot%\misc\tools\SilentCMD.exe %retroboxroot%\misc\scripts\reboot-linux.cmd
		) else (
			del D:\.noreboot
			del D:\.wingaming
		)
	)
	
	%retroboxroot%\misc\tools\nircmd.exe win show class Shell_TrayWnd
	timeout /t 1
	rem reg import %retroboxroot%\misc\regs\iconos-escritorio-mostrar.reg
	rem taskkill /IM explorer.exe /F
	rem start explorer.exe
	start %retroboxroot%\misc\tools\RetroBar.exe